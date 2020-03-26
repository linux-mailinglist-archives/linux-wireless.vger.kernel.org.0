Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9DB193B59
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 09:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgCZI4L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 04:56:11 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:35178 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbgCZI4L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 04:56:11 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585212969; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=c0JT6pakLfi1gdWTYvrUJhueCbW5XURdtrQo5R+NpEU=; b=qV99WtgOgqsr6SPiCm3DuDZ5aUaEN58PVare8CvW3cbO9CWE3XeRsehUZ7YO9Odch3+tu2L4
 /hyTEIAr2kU3nkInEOuD3EMDQ2X/EyEmubdE6E+6fk/wjprvrXWXawcyVcUWvDWg3jjQ69bW
 GcXFafBd4YcDUn9HCnIGv0e0cEY=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7c6e23.7f72ab1e3730-smtp-out-n01;
 Thu, 26 Mar 2020 08:56:03 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D9E66C433D2; Thu, 26 Mar 2020 08:56:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from che-swdbs-01.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 27166C433F2;
        Thu, 26 Mar 2020 08:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27166C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH v3] ath11k: Add sta debugfs support to configure ADDBA and DELBA
Date:   Thu, 26 Mar 2020 14:27:06 +0530
Message-Id: <1585213026-28406-1-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to test aggregation procedures (addba/addba_resp/delba)
manually by adding the required callbacks in sta debugfs files.

To enable automatic aggregation in target,

    echo 0 > /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/
	     stations/XX:XX:XX:XX:XX:XX/aggr_mode

For manual mode,

    echo 1 > /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/
	     stations/XX:XX:XX:XX:XX:XX/aggr_mode

To send addba response,
    echo 0 25 > /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/
		stations/XX:XX:XX:XX:XX:XX/addba_resp

To send addba,
    echo 1 32 > /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/
		stations/XX:XX:XX:XX:XX:XX/addba

To send delba,
    echo 0 1 37 > /sys/kernel/debug/ieee80211/phyX/netdev:wlanX/
		  stations/XX:XX:XX:XX:XX:XX/delba

Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
---

	V3: Rebased on top of latest ath.git tree and cc'ed linux-wireless.

	V2: Rebased on top of latest ath.git tree.


 drivers/net/wireless/ath/ath11k/core.h        |   5 +
 drivers/net/wireless/ath/ath11k/debug.h       |   6 +
 drivers/net/wireless/ath/ath11k/debugfs_sta.c | 221 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.c         | 140 ++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h         |  38 +++++
 5 files changed, 410 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 6e7b8ec..96ca114c 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -341,6 +341,11 @@ struct ath11k_sta {
 	u8 rssi_comb;
 	struct ath11k_htt_tx_stats *tx_stats;
 	struct ath11k_rx_peer_stats *rx_stats;
+
+#ifdef CONFIG_MAC80211_DEBUGFS
+	/* protected by conf_mutex */
+	bool aggr_mode;
+#endif
 };
 
 #define ATH11K_NUM_CHANS 41
diff --git a/drivers/net/wireless/ath/ath11k/debug.h b/drivers/net/wireless/ath/ath11k/debug.h
index 97e7306..4a3ff82 100644
--- a/drivers/net/wireless/ath/ath11k/debug.h
+++ b/drivers/net/wireless/ath/ath11k/debug.h
@@ -112,6 +112,12 @@ enum ath11k_pktlog_enum {
 	ATH11K_PKTLOG_TYPE_LITE_RX      = 24,
 };
 
+enum ath11k_dbg_aggr_mode {
+	ATH11K_DBG_AGGR_MODE_AUTO,
+	ATH11K_DBG_AGGR_MODE_MANUAL,
+	ATH11K_DBG_AGGR_MODE_MAX,
+};
+
 __printf(2, 3) void ath11k_info(struct ath11k_base *ab, const char *fmt, ...);
 __printf(2, 3) void ath11k_err(struct ath11k_base *ab, const char *fmt, ...);
 __printf(2, 3) void ath11k_warn(struct ath11k_base *ab, const char *fmt, ...);
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index 389dac2..68963cf 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -533,6 +533,222 @@ static ssize_t ath11k_dbg_sta_read_peer_pktlog(struct file *file,
 	.llseek = default_llseek,
 };
 
+static ssize_t ath11k_dbg_sta_write_delba(struct file *file,
+					  const char __user *user_buf,
+					  size_t count, loff_t *ppos)
+{
+	struct ieee80211_sta *sta = file->private_data;
+	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k *ar = arsta->arvif->ar;
+	u32 tid, initiator, reason;
+	int ret;
+	char buf[64] = {0};
+
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
+				     user_buf, count);
+	if (ret <= 0)
+		return ret;
+
+	ret = sscanf(buf, "%u %u %u", &tid, &initiator, &reason);
+	if (ret != 3)
+		return -EINVAL;
+
+	/* Valid TID values are 0 through 15 */
+	if (tid > HAL_DESC_REO_NON_QOS_TID - 1)
+		return -EINVAL;
+
+	mutex_lock(&ar->conf_mutex);
+	if (ar->state != ATH11K_STATE_ON ||
+	    arsta->aggr_mode != ATH11K_DBG_AGGR_MODE_MANUAL) {
+		ret = count;
+		goto out;
+	}
+
+	ret = ath11k_wmi_delba_send(ar, arsta->arvif->vdev_id, sta->addr,
+				    tid, initiator, reason);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send delba: vdev_id %u peer %pM tid %u initiator %u reason %u\n",
+			    arsta->arvif->vdev_id, sta->addr, tid, initiator,
+			    reason);
+	}
+	ret = count;
+out:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+static const struct file_operations fops_delba = {
+	.write = ath11k_dbg_sta_write_delba,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static ssize_t ath11k_dbg_sta_write_addba_resp(struct file *file,
+					       const char __user *user_buf,
+					       size_t count, loff_t *ppos)
+{
+	struct ieee80211_sta *sta = file->private_data;
+	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k *ar = arsta->arvif->ar;
+	u32 tid, status;
+	int ret;
+	char buf[64] = {0};
+
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
+				     user_buf, count);
+	if (ret <= 0)
+		return ret;
+
+	ret = sscanf(buf, "%u %u", &tid, &status);
+	if (ret != 2)
+		return -EINVAL;
+
+	/* Valid TID values are 0 through 15 */
+	if (tid > HAL_DESC_REO_NON_QOS_TID - 1)
+		return -EINVAL;
+
+	mutex_lock(&ar->conf_mutex);
+	if (ar->state != ATH11K_STATE_ON ||
+	    arsta->aggr_mode != ATH11K_DBG_AGGR_MODE_MANUAL) {
+		ret = count;
+		goto out;
+	}
+
+	ret = ath11k_wmi_addba_set_resp(ar, arsta->arvif->vdev_id, sta->addr,
+					tid, status);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send addba response: vdev_id %u peer %pM tid %u status%u\n",
+			    arsta->arvif->vdev_id, sta->addr, tid, status);
+	}
+	ret = count;
+out:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+static const struct file_operations fops_addba_resp = {
+	.write = ath11k_dbg_sta_write_addba_resp,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static ssize_t ath11k_dbg_sta_write_addba(struct file *file,
+					  const char __user *user_buf,
+					  size_t count, loff_t *ppos)
+{
+	struct ieee80211_sta *sta = file->private_data;
+	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k *ar = arsta->arvif->ar;
+	u32 tid, buf_size;
+	int ret;
+	char buf[64] = {0};
+
+	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos,
+				     user_buf, count);
+	if (ret <= 0)
+		return ret;
+
+	ret = sscanf(buf, "%u %u", &tid, &buf_size);
+	if (ret != 2)
+		return -EINVAL;
+
+	/* Valid TID values are 0 through 15 */
+	if (tid > HAL_DESC_REO_NON_QOS_TID - 1)
+		return -EINVAL;
+
+	mutex_lock(&ar->conf_mutex);
+	if (ar->state != ATH11K_STATE_ON ||
+	    arsta->aggr_mode != ATH11K_DBG_AGGR_MODE_MANUAL) {
+		ret = count;
+		goto out;
+	}
+
+	ret = ath11k_wmi_addba_send(ar, arsta->arvif->vdev_id, sta->addr,
+				    tid, buf_size);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to send addba request: vdev_id %u peer %pM tid %u buf_size %u\n",
+			    arsta->arvif->vdev_id, sta->addr, tid, buf_size);
+	}
+
+	ret = count;
+out:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+static const struct file_operations fops_addba = {
+	.write = ath11k_dbg_sta_write_addba,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
+static ssize_t ath11k_dbg_sta_read_aggr_mode(struct file *file,
+					     char __user *user_buf,
+					     size_t count, loff_t *ppos)
+{
+	struct ieee80211_sta *sta = file->private_data;
+	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k *ar = arsta->arvif->ar;
+	char buf[64];
+	int len = 0;
+
+	mutex_lock(&ar->conf_mutex);
+	len = scnprintf(buf, sizeof(buf) - len,
+			"aggregation mode: %s\n\n%s\n%s\n",
+			(arsta->aggr_mode == ATH11K_DBG_AGGR_MODE_AUTO) ?
+			"auto" : "manual", "auto = 0", "manual = 1");
+	mutex_unlock(&ar->conf_mutex);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buf, len);
+}
+
+static ssize_t ath11k_dbg_sta_write_aggr_mode(struct file *file,
+					      const char __user *user_buf,
+					      size_t count, loff_t *ppos)
+{
+	struct ieee80211_sta *sta = file->private_data;
+	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k *ar = arsta->arvif->ar;
+	u32 aggr_mode;
+	int ret;
+
+	if (kstrtouint_from_user(user_buf, count, 0, &aggr_mode))
+		return -EINVAL;
+
+	if (aggr_mode >= ATH11K_DBG_AGGR_MODE_MAX)
+		return -EINVAL;
+
+	mutex_lock(&ar->conf_mutex);
+	if (ar->state != ATH11K_STATE_ON ||
+	    aggr_mode == arsta->aggr_mode) {
+		ret = count;
+		goto out;
+	}
+
+	ret = ath11k_wmi_addba_clear_resp(ar, arsta->arvif->vdev_id, sta->addr);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to clear addba session ret: %d\n",
+			    ret);
+		goto out;
+	}
+
+	arsta->aggr_mode = aggr_mode;
+out:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
+static const struct file_operations fops_aggr_mode = {
+	.read = ath11k_dbg_sta_read_aggr_mode,
+	.write = ath11k_dbg_sta_write_aggr_mode,
+	.open = simple_open,
+	.owner = THIS_MODULE,
+	.llseek = default_llseek,
+};
+
 void ath11k_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta, struct dentry *dir)
 {
@@ -550,4 +766,9 @@ void ath11k_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	debugfs_create_file("peer_pktlog", 0644, dir, sta,
 			    &fops_peer_pktlog);
+
+	debugfs_create_file("aggr_mode", 0644, dir, sta, &fops_aggr_mode);
+	debugfs_create_file("addba", 0200, dir, sta, &fops_addba);
+	debugfs_create_file("addba_resp", 0200, dir, sta, &fops_addba_resp);
+	debugfs_create_file("delba", 0200, dir, sta, &fops_delba);
 }
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index e7ce369..49a17c8 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2368,6 +2368,146 @@ int ath11k_wmi_send_dfs_phyerr_offload_enable_cmd(struct ath11k *ar,
 	return ret;
 }
 
+int ath11k_wmi_delba_send(struct ath11k *ar, u32 vdev_id, const u8 *mac,
+			  u32 tid, u32 initiator, u32 reason)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct wmi_delba_send_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_delba_send_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_DELBA_SEND_CMD) |
+			FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+	cmd->vdev_id = vdev_id;
+	ether_addr_copy(cmd->peer_macaddr.addr, mac);
+	cmd->tid = tid;
+	cmd->initiator = initiator;
+	cmd->reasoncode = reason;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "wmi delba send vdev_id 0x%X mac_addr %pM tid %u initiator %u reason %u\n",
+		   vdev_id, mac, tid, initiator, reason);
+
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_DELBA_SEND_CMDID);
+
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "failed to send WMI_DELBA_SEND_CMDID cmd\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
+int ath11k_wmi_addba_set_resp(struct ath11k *ar, u32 vdev_id, const u8 *mac,
+			      u32 tid, u32 status)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct wmi_addba_setresponse_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_addba_setresponse_cmd *)skb->data;
+	cmd->tlv_header =
+		FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ADDBA_SETRESPONSE_CMD) |
+		FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+	cmd->vdev_id = vdev_id;
+	ether_addr_copy(cmd->peer_macaddr.addr, mac);
+	cmd->tid = tid;
+	cmd->statuscode = status;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "wmi addba set resp vdev_id 0x%X mac_addr %pM tid %u status %u\n",
+		   vdev_id, mac, tid, status);
+
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_ADDBA_SET_RESP_CMDID);
+
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "failed to send WMI_ADDBA_SET_RESP_CMDID cmd\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
+int ath11k_wmi_addba_send(struct ath11k *ar, u32 vdev_id, const u8 *mac,
+			  u32 tid, u32 buf_size)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct wmi_addba_send_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_addba_send_cmd *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ADDBA_SEND_CMD) |
+		FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+	cmd->vdev_id = vdev_id;
+	ether_addr_copy(cmd->peer_macaddr.addr, mac);
+	cmd->tid = tid;
+	cmd->buffersize = buf_size;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "wmi addba send vdev_id 0x%X mac_addr %pM tid %u bufsize %u\n",
+		   vdev_id, mac, tid, buf_size);
+
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_ADDBA_SEND_CMDID);
+
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "failed to send WMI_ADDBA_SEND_CMDID cmd\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
+int ath11k_wmi_addba_clear_resp(struct ath11k *ar, u32 vdev_id, const u8 *mac)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct wmi_addba_clear_resp_cmd *cmd;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, sizeof(*cmd));
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (struct wmi_addba_clear_resp_cmd *)skb->data;
+	cmd->tlv_header =
+		FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ADDBA_CLEAR_RESP_CMD) |
+		FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
+	cmd->vdev_id = vdev_id;
+	ether_addr_copy(cmd->peer_macaddr.addr, mac);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
+		   "wmi addba clear resp vdev_id 0x%X mac_addr %pM\n",
+		   vdev_id, mac);
+
+	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_ADDBA_CLEAR_RESP_CMDID);
+
+	if (ret) {
+		ath11k_warn(ar->ab,
+			    "failed to send WMI_ADDBA_CLEAR_RESP_CMDID cmd\n");
+		dev_kfree_skb(skb);
+	}
+
+	return ret;
+}
+
 int ath11k_wmi_pdev_peer_pktlog_filter(struct ath11k *ar, u8 *addr, u8 enable)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 510f9c6..780e662 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3649,6 +3649,37 @@ struct wmi_therm_throt_level_config_info {
 	u32 prio;
 } __packed;
 
+struct wmi_delba_send_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	struct wmi_mac_addr peer_macaddr;
+	u32 tid;
+	u32 initiator;
+	u32 reasoncode;
+} __packed;
+
+struct wmi_addba_setresponse_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	struct wmi_mac_addr peer_macaddr;
+	u32 tid;
+	u32 statuscode;
+} __packed;
+
+struct wmi_addba_send_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	struct wmi_mac_addr peer_macaddr;
+	u32 tid;
+	u32 buffersize;
+} __packed;
+
+struct wmi_addba_clear_resp_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	struct wmi_mac_addr peer_macaddr;
+} __packed;
+
 struct wmi_pdev_pktlog_filter_info {
 	u32 tlv_header;
 	struct wmi_mac_addr peer_macaddr;
@@ -4822,6 +4853,13 @@ int ath11k_wmi_send_scan_chan_list_cmd(struct ath11k *ar,
 				       struct scan_chan_list_params *chan_list);
 int ath11k_wmi_send_dfs_phyerr_offload_enable_cmd(struct ath11k *ar,
 						  u32 pdev_id);
+int ath11k_wmi_addba_clear_resp(struct ath11k *ar, u32 vdev_id, const u8 *mac);
+int ath11k_wmi_addba_send(struct ath11k *ar, u32 vdev_id, const u8 *mac,
+			  u32 tid, u32 buf_size);
+int ath11k_wmi_addba_set_resp(struct ath11k *ar, u32 vdev_id, const u8 *mac,
+			      u32 tid, u32 status);
+int ath11k_wmi_delba_send(struct ath11k *ar, u32 vdev_id, const u8 *mac,
+			  u32 tid, u32 initiator, u32 reason);
 int ath11k_wmi_send_bcn_offload_control_cmd(struct ath11k *ar,
 					    u32 vdev_id, u32 bcn_ctrl_op);
 int
-- 
1.9.1
