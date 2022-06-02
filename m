Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAB453B9C9
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jun 2022 15:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiFBNeP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jun 2022 09:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbiFBNeO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jun 2022 09:34:14 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C081625C4B
        for <linux-wireless@vger.kernel.org>; Thu,  2 Jun 2022 06:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654176850; x=1685712850;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=WdYmyrFQkrRWH31qG5aQX+bBFwQ/z/t2TAZ5DvvyYK0=;
  b=Sitivl17pMQpG8tYWC6vDyZumkhm4rV3gXRoUSKRB/OsdTLUPxeNuX0k
   diHp0p7Hdai9XlksIG8sqKfBDL6fEAj72XdbG2XV4Q4atS2Ua7gKsgWYM
   Pk98KB2lCW0q847ur1edSr7r/D3AJP76aQEcTrWbrBlpFMHik9c9ySP9y
   o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Jun 2022 06:34:10 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 06:34:10 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 06:34:10 -0700
Received: from tmariyap-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 2 Jun 2022 06:34:07 -0700
From:   Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
Subject: [PATCH] ath11k: add wmi ctrl path stats
Date:   Thu, 2 Jun 2022 19:03:20 +0530
Message-ID: <1654176800-29003-1-git-send-email-quic_tmariyap@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently, ath11k HTT debugfs uses the HTT interface to send stats request
to target and response from target. Here HTT interface already overloaded
with the data path stats. To reduce the load from HTT, using WMI interface
to print the control path stats. This patch come up with framework for
control path stats using wmi interface.
For now, this framework supports PDEV_STAT and further stats will be
added.

WMI control path stats command and results are below:
echo <stats_id> <action> >
        sys/kernel/debug/ieee80211/phy3/netdev\:wlan3/wmi_ctrl_stats
cat sys/kernel/debug/ieee80211/phy3/netdev\:wlan3/wmi_ctrl_stats
stats_id:
1 -> WMI_REQ_CTRL_PATH_PDEV_STATS
action:
1 -> stats get
2 -> stats reset

WMI_CTRL_PATH_PDEV_STATS:
req_id = 26
fw_tx_mgmt_subtype =  0:0, 1:0, 2:0, 3:0, 4:0, 5:109, 6:0, 7:0, 8:344, ...
fw_rx_mgmt_subtype =  0:0, 1:0, 2:0, 3:0, 4:0, 5:0, 6:0, 7:0, 8:0, 9:0, ...
scan_fail_dfs_violation_time_ms = 0
nol_chk_fail_last_chan_freq = 0
nol_chk_fail_time_stamp_ms = 0
tot_peer_create_cnt = 2
tot_peer_del_cnt = 1
tot_peer_del_resp_cnt = 1
vdev_pause_fail_rt_to_sched_algo_fifo_full_cnt = 0

Tested-on: WLAN.HK.2.5.0.1-00517-QCAHKSWPL_SILICONZ-1

Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h    |   8 +
 drivers/net/wireless/ath/ath11k/debugfs.c | 155 +++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.c     | 242 ++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h     |  90 +++++++++++
 4 files changed, 495 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index ea31016..4459d8c 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -692,6 +692,14 @@ struct ath11k {
 	struct list_head ppdu_stats_info;
 	u32 ppdu_stat_list_depth;
 
+	/* To protect wmi_ctrl_path_stats_list manipulation */
+	struct mutex wmi_ctrl_path_stats_lock;
+	struct list_head wmi_ctrl_path_stats_list;
+	struct completion wmi_ctrl_path_stats_rcvd;
+	u32 wmi_ctrl_path_stats_tagid;
+	u8 wmi_ctrl_path_stats_reqid;
+	bool wmi_ctrl_path_stats_more_enabled;
+
 	struct ath11k_per_peer_tx_stats cached_stats;
 	u32 last_ppdu_id;
 	u32 cached_ppdu_id;
diff --git a/drivers/net/wireless/ath/ath11k/debugfs.c b/drivers/net/wireless/ath/ath11k/debugfs.c
index 9648e00..c5820f3 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs.c
@@ -1638,6 +1638,157 @@ static const struct file_operations ath11k_fops_twt_resume_dialog = {
 	.open = simple_open
 };
 
+static ssize_t ath11k_write_wmi_ctrl_path_stats(struct file *file,
+						const char __user *ubuf,
+						size_t count, loff_t *ppos)
+{
+	struct ath11k_vif *arvif = file->private_data;
+	struct wmi_ctrl_path_stats_cmd_fixed_param param = {0};
+	u8 buf[128] = {0};
+	int ret;
+
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, ubuf, count);
+	if (ret < 0)
+		return ret;
+
+	buf[ret] = '\0';
+
+	ret = sscanf(buf, "%u %u", &param.stats_id, &param.action);
+	if (ret != 2)
+		return -EINVAL;
+
+	if (!param.action || param.action > WMI_REQ_CTRL_PATH_STAT_RESET)
+		return -EINVAL;
+
+	ret = ath11k_wmi_send_wmi_ctrl_stats_cmd(arvif->ar, &param);
+	return ret ? ret : count;
+}
+
+#define WMI_MAX_STRING_LEN		256
+#define WMI_CTRL_PATH_STATS_REQID	0x1A
+#define WMI_CTRL_PATH_STATS_REQID_MAX	0xFF
+
+static int ath11k_read_wmi_ctrl_path_pdev_stats(struct ath11k_vif *arvif, char __user *ubuf,
+						size_t count, loff_t *ppos)
+{
+	const int size = 2048;
+	char *buf;
+	u8 i, index_tx, index_rx;
+	int len = 0, ret_val;
+	char fw_tx_mgmt_subtype[WMI_MAX_STRING_LEN] = {0};
+	char fw_rx_mgmt_subtype[WMI_MAX_STRING_LEN] = {0};
+	struct wmi_ctrl_path_stats_list_fmt *stats;
+	struct wmi_ctrl_path_pdev_stats *pdev_stats;
+
+	buf = kzalloc(size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	mutex_lock(&arvif->ar->wmi_ctrl_path_stats_lock);
+	list_for_each_entry(stats, &arvif->ar->wmi_ctrl_path_stats_list, list) {
+		if (!stats)
+			break;
+
+		pdev_stats = stats->stats_ptr;
+		index_tx = 0;
+		index_rx = 0;
+
+		for (i = 0; i < WMI_MGMT_FRAME_SUBTYPE_MAX; i++) {
+			index_tx += scnprintf(&fw_tx_mgmt_subtype[index_tx],
+				WMI_MAX_STRING_LEN - index_tx,
+				" %u:%u,", i,
+				pdev_stats->tx_mgmt_subtype[i]);
+			index_rx += scnprintf(&fw_rx_mgmt_subtype[index_rx],
+				 WMI_MAX_STRING_LEN - index_rx,
+				 " %u:%u,", i,
+				 pdev_stats->rx_mgmt_subtype[i]);
+		}
+
+		len += scnprintf(buf + len, size - len,
+				 "WMI_CTRL_PATH_PDEV_STATS:\n");
+		len += scnprintf(buf + len, size - len,
+				 "req_id = %u\n", pdev_stats->req_id);
+		len += scnprintf(buf + len, size - len,
+				 "fw_tx_mgmt_subtype = %s\n",
+				 fw_tx_mgmt_subtype);
+		len += scnprintf(buf + len, size - len,
+				 "fw_rx_mgmt_subtype = %s\n",
+				 fw_rx_mgmt_subtype);
+		len += scnprintf(buf + len, size - len,
+				 "scan_fail_dfs_violation_time_ms = %u\n",
+				 pdev_stats->scan_fail_dfs_violation_time_ms);
+		len += scnprintf(buf + len, size - len,
+				 "nol_chk_fail_last_chan_freq = %u\n",
+				 pdev_stats->nol_chk_fail_last_chan_freq);
+		len += scnprintf(buf + len, size - len,
+				 "nol_chk_fail_time_stamp_ms = %u\n",
+				 pdev_stats->nol_chk_fail_time_stamp_ms);
+		len += scnprintf(buf + len, size - len,
+				 "tot_peer_create_cnt = %u\n",
+				 pdev_stats->tot_peer_create_cnt);
+		len += scnprintf(buf + len, size - len,
+				 "tot_peer_del_cnt = %u\n",
+				 pdev_stats->tot_peer_del_cnt);
+		len += scnprintf(buf + len, size - len,
+				 "tot_peer_del_resp_cnt = %u\n",
+				 pdev_stats->tot_peer_del_resp_cnt);
+		len += scnprintf(buf + len, size - len,
+				 "vdev_pause_fail_rt_to_sched_algo_fifo_full_cnt = %u\n",
+				 pdev_stats->vdev_pause_fail_rt_to_sched_algo_fifo_full_cnt);
+
+		if (pdev_stats->req_id == WMI_CTRL_PATH_STATS_REQID_MAX)
+			arvif->ar->wmi_ctrl_path_stats_reqid =
+						WMI_CTRL_PATH_STATS_REQID;
+	}
+
+	ath11k_wmi_ctrl_path_stats_list_free(arvif->ar);
+	mutex_unlock(&arvif->ar->wmi_ctrl_path_stats_lock);
+	ret_val =  simple_read_from_buffer(ubuf, count, ppos, buf, len);
+	kfree(buf);
+	return ret_val;
+}
+
+static ssize_t ath11k_read_wmi_ctrl_path_stats(struct file *file,
+					       char __user *ubuf,
+					       size_t count, loff_t *ppos)
+{
+	struct ath11k_vif *arvif = file->private_data;
+	int ret_val = 0;
+	u32 tagid;
+
+	tagid = arvif->ar->wmi_ctrl_path_stats_tagid;
+
+	switch (tagid) {
+	case WMI_TAG_CTRL_PATH_PDEV_STATS:
+		ret_val = ath11k_read_wmi_ctrl_path_pdev_stats(arvif, ubuf, count, ppos);
+		break;
+	/* Add case for newly wmi ctrl path added stats here */
+	default:
+		/* Unsupported tag */
+		break;
+	}
+
+	return ret_val;
+}
+
+static const struct file_operations ath11k_fops_wmi_ctrl_stats = {
+	.write = ath11k_write_wmi_ctrl_path_stats,
+	.open = simple_open,
+	.read = ath11k_read_wmi_ctrl_path_stats,
+};
+
+static void ath11k_wmi_ctrl_stats_init(struct ath11k_vif *arvif)
+{
+	debugfs_create_file("wmi_ctrl_stats", 0600,
+			    arvif->vif->debugfs_dir, arvif,
+			    &ath11k_fops_wmi_ctrl_stats);
+	INIT_LIST_HEAD(&arvif->ar->wmi_ctrl_path_stats_list);
+	mutex_init(&arvif->ar->wmi_ctrl_path_stats_lock);
+	init_completion(&arvif->ar->wmi_ctrl_path_stats_rcvd);
+	arvif->ar->wmi_ctrl_path_stats_more_enabled = false;
+	arvif->ar->wmi_ctrl_path_stats_reqid = WMI_CTRL_PATH_STATS_REQID;
+}
+
 int ath11k_debugfs_add_interface(struct ath11k_vif *arvif)
 {
 	if (arvif->vif->type == NL80211_IFTYPE_AP && !arvif->debugfs_twt) {
@@ -1663,6 +1814,10 @@ int ath11k_debugfs_add_interface(struct ath11k_vif *arvif)
 		debugfs_create_file("resume_dialog", 0200, arvif->debugfs_twt,
 				    arvif, &ath11k_fops_twt_resume_dialog);
 	}
+	if (test_bit(WMI_TLV_REQUEST_CTRL_PATH_STATS_REQUEST,
+		     arvif->ar->ab->wmi_ab.svc_map))
+		ath11k_wmi_ctrl_stats_init(arvif);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 84d1c70..f956837 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2635,6 +2635,83 @@ int ath11k_wmi_delba_send(struct ath11k *ar, u32 vdev_id, const u8 *mac,
 	return ret;
 }
 
+int
+ath11k_wmi_send_wmi_ctrl_stats_cmd(struct ath11k *ar,
+				   struct wmi_ctrl_path_stats_cmd_fixed_param *param)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct ath11k_base *ab = wmi->wmi_ab->ab;
+	u32 num_pdev_idx = 0, pdev_size = 0;
+	u32 pdev_id_array[MAX_RADIOS] = {0};
+	int len, ret;
+	struct wmi_tlv *tlv;
+	struct sk_buff *skb;
+	struct wmi_ctrl_path_stats_cmd_fixed_param *cmd;
+	u8 *ptr;
+	u32 stats_id = 0;
+	unsigned long time_left;
+
+	switch (param->stats_id) {
+	case WMI_REQ_CTRL_PATH_PDEV_STAT:
+		pdev_id_array[num_pdev_idx] = ar->pdev->pdev_id;
+		stats_id = (1 << param->stats_id);
+		param->req_id = ar->wmi_ctrl_path_stats_reqid;
+		ar->wmi_ctrl_path_stats_reqid++;
+		num_pdev_idx++;
+		break;
+	/* Add case for newly wmi ctrl path stats here */
+	default:
+		ath11k_warn(ab, "Unsupported stats id %d", param->stats_id);
+		return -EIO;
+	}
+
+	pdev_size = sizeof(u32) * num_pdev_idx;
+	len = sizeof(*cmd) + TLV_HDR_SIZE + pdev_size;
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (void *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_CTRL_PATH_STATS_CMD_FIXED_PARAM) |
+			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+	cmd->stats_id = stats_id;
+	cmd->req_id = param->req_id;
+	cmd->action = param->action;
+
+	ptr = skb->data + sizeof(*cmd);
+
+	tlv = (struct wmi_tlv *)ptr;
+	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_UINT32) |
+		      FIELD_PREP(WMI_TLV_LEN, pdev_size);
+	ptr += TLV_HDR_SIZE;
+	memcpy(ptr, &pdev_id_array[0], pdev_size);
+
+	if (param->action == WMI_REQ_CTRL_PATH_STAT_GET)
+		reinit_completion(&ar->wmi_ctrl_path_stats_rcvd);
+
+	ret = ath11k_wmi_cmd_send(wmi, skb,
+				  WMI_REQUEST_CTRL_PATH_STATS_CMDID);
+	if (ret) {
+		dev_kfree_skb(skb);
+		ath11k_warn(ab,
+			    "Failed to send WMI_REQUEST_CTRL_PATH_STATS_CMDID: %d", ret);
+	} else {
+		if (param->action == WMI_REQ_CTRL_PATH_STAT_GET) {
+			time_left = wait_for_completion_timeout(&ar->wmi_ctrl_path_stats_rcvd,
+								WMI_CTRL_STATS_READY_TIMEOUT_HZ *
+								HZ);
+			if (time_left == 0) {
+				ath11k_warn(ab, "timeout in receiving wmi ctrl path stats\n");
+				return -ETIMEDOUT;
+			}
+		}
+	}
+
+	return ret;
+}
+
 int ath11k_wmi_addba_set_resp(struct ath11k *ar, u32 vdev_id, const u8 *mac,
 			      u32 tid, u32 status)
 {
@@ -6941,6 +7018,168 @@ static void ath11k_mgmt_tx_compl_event(struct ath11k_base *ab, struct sk_buff *s
 	rcu_read_unlock();
 }
 
+void ath11k_wmi_ctrl_path_stats_list_free(struct ath11k *ar)
+{
+	struct wmi_ctrl_path_stats_list_fmt *stats, *tmp;
+
+	lockdep_assert_held(&ar->wmi_ctrl_path_stats_lock);
+	list_for_each_entry_safe(stats, tmp, &ar->wmi_ctrl_path_stats_list, list) {
+		kfree(stats->stats_ptr);
+		list_del(&stats->list);
+		kfree(stats);
+	}
+}
+
+static int wmi_ctrl_path_pdev_stats_tlv(struct ath11k_base *ab, u16 len,
+					const void *ptr, void *data)
+{
+	struct wmi_ctrl_path_stats_event_parse_param *stats_buff = data;
+	struct wmi_ctrl_path_pdev_stats *pdev_stats_skb = (struct wmi_ctrl_path_pdev_stats *)ptr;
+	struct wmi_ctrl_path_pdev_stats *pdev_stats;
+	struct wmi_ctrl_path_stats_list_fmt *stats = kzalloc(sizeof(*stats), GFP_ATOMIC);
+	struct ath11k *ar = NULL;
+
+	if (!stats)
+		return -ENOMEM;
+
+	pdev_stats = kzalloc(sizeof(*pdev_stats), GFP_ATOMIC);
+	if (!pdev_stats) {
+		kfree(stats);
+		return -ENOMEM;
+	}
+
+	memcpy(pdev_stats, pdev_stats_skb,
+	       offsetof(struct wmi_ctrl_path_pdev_stats, req_id));
+	pdev_stats->req_id = stats_buff->req_id;
+	stats->stats_ptr = pdev_stats;
+
+	ar = ath11k_mac_get_ar_by_pdev_id(ab, pdev_stats_skb->pdev_id + 1);
+	if (!ar) {
+		kfree(stats);
+		kfree(pdev_stats);
+		ath11k_warn(ab, "Failed to get ar for wmi ctrl stats\n");
+		return -EINVAL;
+	}
+
+	list_add_tail(&stats->list, &stats_buff->list);
+	ar->wmi_ctrl_path_stats_tagid = WMI_TAG_CTRL_PATH_PDEV_STATS;
+	stats_buff->ar = ar;
+	return 0;
+}
+
+static int ath11k_wmi_ctrl_stats_subtlv_parser(struct ath11k_base *ab,
+					       u16 tag, u16 len,
+					       const void *ptr, void *data)
+{
+	int ret = 0;
+
+	switch (tag) {
+	case WMI_TAG_CTRL_PATH_STATS_EV_FIXED_PARAM:
+		break;
+	case WMI_TAG_CTRL_PATH_PDEV_STATS:
+		ret = wmi_ctrl_path_pdev_stats_tlv(ab, len, ptr, data);
+		break;
+	/* Add case for newly wmi ctrl path added stats here */
+	default:
+		ath11k_warn(ab,
+			    "Received invalid tag %u for wmi ctrl path stats in subtlvs\n", tag);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int ath11k_wmi_ctrl_stats_event_parser(struct ath11k_base *ab,
+					      u16 tag, u16 len,
+					      const void *ptr, void *data)
+{
+	int ret = 0;
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "wmi ctrl path stats tag 0x%x of len %d rcvd\n",
+		   tag, len);
+
+	switch (tag) {
+	case WMI_TAG_CTRL_PATH_STATS_EV_FIXED_PARAM:
+		/* Fixed param is already processed*/
+		break;
+	case WMI_TAG_ARRAY_STRUCT:
+		/* len 0 is expected for array of struct when there
+		 * is no content of that type to pack inside that tlv
+		 */
+		if (len == 0)
+			return 0;
+		ret = ath11k_wmi_tlv_iter(ab, ptr, len,
+					  ath11k_wmi_ctrl_stats_subtlv_parser,
+					  data);
+		break;
+	default:
+		ath11k_warn(ab, "Received invalid tag %u for wmi ctrl path stats\n", tag);
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static void ath11k_wmi_ctrl_path_stats_event(struct ath11k_base *ab, struct sk_buff *skb)
+{
+	int ret;
+	const struct wmi_tlv *tlv;
+	struct wmi_ctrl_path_stats_event_fixed_param *fixed_param;
+	u16 tlv_tag;
+	u8 *ptr = skb->data;
+	struct ath11k *ar = NULL;
+	struct wmi_ctrl_path_stats_event_parse_param param;
+
+	INIT_LIST_HEAD(&param.list);
+
+	if (skb->len < (sizeof(*fixed_param) + TLV_HDR_SIZE)) {
+		ath11k_warn(ab, "wmi ctrl stats event size invalid\n");
+		return;
+	}
+
+	param.ar = NULL;
+	tlv = (struct wmi_tlv *)ptr;
+	tlv_tag = FIELD_GET(WMI_TLV_TAG, tlv->header);
+	ptr += sizeof(*tlv);
+
+	if (tlv_tag != WMI_TAG_CTRL_PATH_STATS_EV_FIXED_PARAM) {
+		ath11k_warn(ab, "wmi ctrl Stats received without fixed param tlv at start\n");
+		return;
+	}
+
+	fixed_param = (struct wmi_ctrl_path_stats_event_fixed_param *)ptr;
+	param.req_id = fixed_param->req_id;
+	ret = ath11k_wmi_tlv_iter(ab, skb->data, skb->len,
+				  ath11k_wmi_ctrl_stats_event_parser,
+				  &param);
+	if (ret)
+		ath11k_warn(ab, "failed to parse wmi_ctrl_path_stats tlv: %d\n", ret);
+
+	ar = param.ar;
+	if (!ar)
+		return;
+
+	mutex_lock(&ar->wmi_ctrl_path_stats_lock);
+	if (!fixed_param->more) {
+		if (!ar->wmi_ctrl_path_stats_more_enabled)
+			ath11k_wmi_ctrl_path_stats_list_free(ar);
+		else
+			ar->wmi_ctrl_path_stats_more_enabled = false;
+
+		list_splice_tail_init(&param.list, &ar->wmi_ctrl_path_stats_list);
+		complete(&ar->wmi_ctrl_path_stats_rcvd);
+		ath11k_dbg(ab, ATH11K_DBG_WMI, "wmi ctrl path stats completed");
+	} else {
+		if (!ar->wmi_ctrl_path_stats_more_enabled) {
+			ath11k_wmi_ctrl_path_stats_list_free(ar);
+			ar->wmi_ctrl_path_stats_more_enabled = true;
+		}
+		list_splice_tail_init(&param.list, &ar->wmi_ctrl_path_stats_list);
+	}
+	mutex_unlock(&ar->wmi_ctrl_path_stats_lock);
+}
+
 static struct ath11k *ath11k_get_ar_on_scan_state(struct ath11k_base *ab,
 						  u32 vdev_id,
 						  enum ath11k_scan_state state)
@@ -8003,6 +8242,9 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_GTK_OFFLOAD_STATUS_EVENTID:
 		ath11k_wmi_gtk_offload_status_event(ab, skb);
 		break;
+	case WMI_CTRL_PATH_STATS_EVENTID:
+		ath11k_wmi_ctrl_path_stats_event(ab, skb);
+		break;
 	/* TODO: Add remaining events */
 	default:
 		ath11k_dbg(ab, ATH11K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index b1fad47..7f3712e 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -448,6 +448,8 @@ enum wmi_tlv_cmd_id {
 	WMI_REQUEST_RCPI_CMDID,
 	WMI_REQUEST_PEER_STATS_INFO_CMDID,
 	WMI_REQUEST_RADIO_CHAN_STATS_CMDID,
+	WMI_REQUEST_WLM_STATS_CMDID,
+	WMI_REQUEST_CTRL_PATH_STATS_CMDID,
 	WMI_SET_ARP_NS_OFFLOAD_CMDID = WMI_TLV_CMD(WMI_GRP_ARP_NS_OFL),
 	WMI_ADD_PROACTIVE_ARP_RSP_PATTERN_CMDID,
 	WMI_DEL_PROACTIVE_ARP_RSP_PATTERN_CMDID,
@@ -713,6 +715,8 @@ enum wmi_tlv_event_id {
 	WMI_UPDATE_RCPI_EVENTID,
 	WMI_PEER_STATS_INFO_EVENTID,
 	WMI_RADIO_CHAN_STATS_EVENTID,
+	WMI_WLM_STATS_EVENTID,
+	WMI_CTRL_PATH_STATS_EVENTID,
 	WMI_NLO_MATCH_EVENTID = WMI_TLV_CMD(WMI_GRP_NLO_OFL),
 	WMI_NLO_SCAN_COMPLETE_EVENTID,
 	WMI_APFIND_EVENTID,
@@ -1864,6 +1868,9 @@ enum wmi_tlv_tag {
 	WMI_TAG_PDEV_SRG_OBSS_BSSID_ENABLE_BITMAP_CMD,
 	WMI_TAG_PDEV_NON_SRG_OBSS_COLOR_ENABLE_BITMAP_CMD,
 	WMI_TAG_PDEV_NON_SRG_OBSS_BSSID_ENABLE_BITMAP_CMD,
+	WMI_TAG_CTRL_PATH_STATS_CMD_FIXED_PARAM = 0x388,
+	WMI_TAG_CTRL_PATH_STATS_EV_FIXED_PARAM,
+	WMI_TAG_CTRL_PATH_PDEV_STATS,
 	WMI_TAG_PDEV_SET_BIOS_SAR_TABLE_CMD = 0x3D8,
 	WMI_TAG_PDEV_SET_BIOS_GEO_TABLE_CMD,
 	WMI_TAG_MAX
@@ -2091,6 +2098,7 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_FREQINFO_IN_METADATA = 219,
 	WMI_TLV_SERVICE_EXT2_MSG = 220,
 	WMI_TLV_SERVICE_SRG_SRP_SPATIAL_REUSE_SUPPORT = 249,
+	WMI_TLV_REQUEST_CTRL_PATH_STATS_REQUEST = 250,
 
 	/* The second 128 bits */
 	WMI_MAX_EXT_SERVICE = 256,
@@ -4959,6 +4967,84 @@ struct wmi_twt_disable_params_cmd {
 	u32 pdev_id;
 } __packed;
 
+/**
+ * WMI arrays of length WMI_MGMT_FRAME_SUBTYPE_MAX use the
+ * IEEE802.11 standard's enumeration of mgmt frame subtypes:
+ *  0 -> IEEE80211_STYPE_ASSOC_REQ
+ *  1 -> IEEE80211_STYPE_ASSOC_RESP
+ *  2 -> IEEE80211_STYPE_REASSOC_REQ
+ *  3 -> IEEE80211_STYPE_REASSOC_RESP
+ *  4 -> IEEE80211_STYPE_PROBE_REQ
+ *  5 -> IEEE80211_STYPE_PROBE_RESP
+ *  6 -> Reserved
+ *  7 -> Reserved
+ *  8 -> IEEE80211_STYPE_BEACON
+ *  9 -> IEEE80211_STYPE_ATIM
+ * 10 -> IEEE80211_STYPE_DISASSOC
+ * 11 -> IEEE80211_STYPE_AUTH
+ * 12 -> IEEE80211_STYPE_DEAUTH
+ * 13 -> IEEE80211_STYPE_ACTION
+ * 14 -> IEEE80211_STYPE_ACTION_NOACK
+ * 15 -> IEEE80211_STYPE_RESERVED
+ */
+#define WMI_MGMT_FRAME_SUBTYPE_MAX 16
+
+struct wmi_ctrl_path_pdev_stats {
+	u32 req_id;
+	u32 pdev_id;
+	u32 tx_mgmt_subtype[WMI_MGMT_FRAME_SUBTYPE_MAX];
+	u32 rx_mgmt_subtype[WMI_MGMT_FRAME_SUBTYPE_MAX];
+	u32 scan_fail_dfs_violation_time_ms;
+	u32 nol_chk_fail_last_chan_freq;
+	u32 nol_chk_fail_time_stamp_ms;
+	u32 tot_peer_create_cnt;
+	u32 tot_peer_del_cnt;
+	u32 tot_peer_del_resp_cnt;
+	u32 vdev_pause_fail_rt_to_sched_algo_fifo_full_cnt;
+} __packed;
+
+struct  wmi_ctrl_path_stats_cmd_fixed_param {
+	u32 tlv_header;
+	/* refer enum  wmi_ctrl_path_stats_id */
+	u32 stats_id;
+	u32 req_id;
+	/* refer enum wmi_ctrl_path_stats_action */
+	u32 action;
+} __packed;
+
+struct wmi_ctrl_path_stats_event_fixed_param {
+	u32 req_id;
+	/* more flag
+	 * 1 - More events sent after this event.
+	 * 0 - no more events after this event.
+	 */
+	u32 more;
+} __packed;
+
+struct wmi_ctrl_path_stats_list_fmt {
+	struct list_head list;
+	void *stats_ptr;
+};
+
+struct wmi_ctrl_path_stats_event_parse_param {
+	struct list_head list;
+	struct ath11k *ar;
+	u32 req_id;
+};
+
+enum  wmi_ctrl_path_stats_id {
+	WMI_REQ_CTRL_PATH_PDEV_STAT   = 1,
+	WMI_REQ_CTRL_PATH_VDEV_EXTD_STAT = 2,
+	WMI_REQ_CTRL_PATH_MEM_STAT       = 3,
+};
+
+enum wmi_ctrl_path_stats_action {
+	WMI_REQ_CTRL_PATH_STAT_GET   = 1,
+	WMI_REQ_CTRL_PATH_STAT_RESET = 2,
+	WMI_REQ_CTRL_PATH_STAT_START = 3,
+	WMI_REQ_CTRL_PATH_STAT_STOP  = 4,
+};
+
 enum WMI_HOST_TWT_COMMAND {
 	WMI_HOST_TWT_COMMAND_REQUEST_TWT = 0,
 	WMI_HOST_TWT_COMMAND_SUGGEST_TWT,
@@ -5374,6 +5460,7 @@ struct wmi_debug_log_config_cmd_fixed_param {
 
 #define WMI_SERVICE_READY_TIMEOUT_HZ (5 * HZ)
 #define WMI_SEND_TIMEOUT_HZ (3 * HZ)
+#define WMI_CTRL_STATS_READY_TIMEOUT_HZ (1 * HZ)
 
 struct ath11k_wmi_base {
 	struct ath11k_base *ab;
@@ -6133,5 +6220,8 @@ int ath11k_wmi_pdev_set_bios_sar_table_param(struct ath11k *ar, const u8 *sar_va
 int ath11k_wmi_pdev_set_bios_geo_table_param(struct ath11k *ar);
 int ath11k_wmi_sta_keepalive(struct ath11k *ar,
 			     const struct wmi_sta_keepalive_arg *arg);
+int ath11k_wmi_send_wmi_ctrl_stats_cmd(struct ath11k *ar,
+				       struct wmi_ctrl_path_stats_cmd_fixed_param *param);
+void ath11k_wmi_ctrl_path_stats_list_free(struct ath11k *ar);
 
 #endif
-- 
2.7.4

