Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CBD2B0076
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 08:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgKLHnS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 02:43:18 -0500
Received: from z5.mailgun.us ([104.130.96.5]:46279 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgKLHnR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Nov 2020 02:43:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605166996; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=/2LDKyJlFiXhwIjeZXLU7sXVN1Ah2Bo1jTI9Ud7ENKg=; b=AxSrEMlVzx6cpYbzkNEyvs++cayWWFjRRswrr5GbogbcfDTiPhN+8d00t2OdaHE491AnELNL
 wdggRgmpghw4BEJ4/V5ueDXUnjN793Aqq0KQi0Y9cwWlqEK03C4Fl2RaKQu8heRCk0lYscwW
 xqwoRBFoRqePSNDPbkc8gswP7b4=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5face7949a53d19da9793142 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 12 Nov 2020 07:43:16
 GMT
Sender: mkenna=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EC5D2C433C8; Thu, 12 Nov 2020 07:43:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from ssreeela-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A8C33C433C6;
        Thu, 12 Nov 2020 07:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A8C33C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Ritesh Singh <ritesi@codeaurora.org>,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH 1/3] ath11k: vdev delete synchronization with firmware
Date:   Thu, 12 Nov 2020 13:12:58 +0530
Message-Id: <1605166980-29115-2-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605166980-29115-1-git-send-email-mkenna@codeaurora.org>
References: <1605166980-29115-1-git-send-email-mkenna@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ritesh Singh <ritesi@codeaurora.org>

When the interface is added immediately after removing the
interface, vdev deletion in firmware might not have been
completed.

Hence, add vdev_delete_resp_event and wait_event_timeout
to synchronize with firmware.

Signed-off-by: Ritesh Singh <ritesi@codeaurora.org>
Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
---

    V2: Rebased on latest ath.git TOT(Addressed Kalle's comment).

 drivers/net/wireless/ath/ath11k/core.c |  1 +
 drivers/net/wireless/ath/ath11k/core.h |  2 ++
 drivers/net/wireless/ath/ath11k/mac.c  | 29 ++++++++++++----
 drivers/net/wireless/ath/ath11k/wmi.c  | 62 +++++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h  |  4 +++
 5 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index c23a59a..f792825 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -810,6 +810,7 @@ static void ath11k_core_restart(struct work_struct *work)
 		complete(&ar->peer_assoc_done);
 		complete(&ar->install_key_done);
 		complete(&ar->vdev_setup_done);
+		complete(&ar->vdev_delete_done);
 		complete(&ar->bss_survey_done);
 		complete(&ar->thermal.wmi_sync);
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 79224ed..714dcb4 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -430,6 +430,7 @@ struct ath11k_per_peer_tx_stats {
 };
 
 #define ATH11K_FLUSH_TIMEOUT (5 * HZ)
+#define ATH11K_VDEV_DELETE_TIMEOUT_HZ (5 * HZ)
 
 struct ath11k_vdev_stop_status {
 	bool stop_in_progress;
@@ -512,6 +513,7 @@ struct ath11k {
 	int last_wmi_vdev_start_status;
 	struct ath11k_vdev_stop_status vdev_stop_status;
 	struct completion vdev_setup_done;
+	struct completion vdev_delete_done;
 
 	int num_peers;
 	int max_num_peers;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f4aedd5..f0ab88c 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4664,6 +4664,7 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	struct ath11k *ar = hw->priv;
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ath11k_base *ab = ar->ab;
+	unsigned long time_left;
 	int ret;
 	int i;
 
@@ -4672,10 +4673,6 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 	ath11k_dbg(ab, ATH11K_DBG_MAC, "mac remove interface (vdev %d)\n",
 		   arvif->vdev_id);
 
-	spin_lock_bh(&ar->data_lock);
-	list_del(&arvif->list);
-	spin_unlock_bh(&ar->data_lock);
-
 	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
 		ret = ath11k_peer_delete(ar, arvif->vdev_id, vif->addr);
 		if (ret)
@@ -4683,16 +4680,33 @@ static void ath11k_mac_op_remove_interface(struct ieee80211_hw *hw,
 				    arvif->vdev_id, ret);
 	}
 
+	reinit_completion(&ar->vdev_delete_done);
+
 	ret = ath11k_wmi_vdev_delete(ar, arvif->vdev_id);
-	if (ret)
+	if (ret) {
 		ath11k_warn(ab, "failed to delete WMI vdev %d: %d\n",
 			    arvif->vdev_id, ret);
+		goto err_vdev_del;
+	}
+
+	time_left = wait_for_completion_timeout(&ar->vdev_delete_done,
+						ATH11K_VDEV_DELETE_TIMEOUT_HZ);
+	if (time_left == 0) {
+		ath11k_warn(ab, "Timeout in receiving vdev delete response\n");
+		goto err_vdev_del;
+	}
 
+	ab->free_vdev_map |= 1LL << (arvif->vdev_id);
+	ar->allocated_vdev_map &= ~(1LL << arvif->vdev_id);
 	ar->num_created_vdevs--;
+
 	ath11k_dbg(ab, ATH11K_DBG_MAC, "vdev %pM deleted, vdev_id %d\n",
 		   vif->addr, arvif->vdev_id);
-	ar->allocated_vdev_map &= ~(1LL << arvif->vdev_id);
-	ab->free_vdev_map |= 1LL << (arvif->vdev_id);
+
+err_vdev_del:
+	spin_lock_bh(&ar->data_lock);
+	list_del(&arvif->list);
+	spin_unlock_bh(&ar->data_lock);
 
 	ath11k_peer_cleanup(ar, arvif->vdev_id);
 
@@ -6458,6 +6472,7 @@ int ath11k_mac_allocate(struct ath11k_base *ab)
 		INIT_LIST_HEAD(&ar->ppdu_stats_info);
 		mutex_init(&ar->conf_mutex);
 		init_completion(&ar->vdev_setup_done);
+		init_completion(&ar->vdev_delete_done);
 		init_completion(&ar->peer_assoc_done);
 		init_completion(&ar->install_key_done);
 		init_completion(&ar->bss_survey_done);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index bca66c1..d1175a1 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -126,6 +126,8 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_fils_discovery_event) },
 	[WMI_TAG_OFFLOAD_PRB_RSP_TX_STATUS_EVENT] = {
 		.min_len = sizeof(struct wmi_probe_resp_tx_status_event) },
+	[WMI_TAG_VDEV_DELETE_RESP_EVENT] = {
+		.min_len = sizeof(struct wmi_vdev_delete_resp_event) },
 };
 
 #define PRIMAP(_hw_mode_) \
@@ -4379,6 +4381,34 @@ static int ath11k_pull_peer_del_resp_ev(struct ath11k_base *ab, struct sk_buff *
 	return 0;
 }
 
+static int ath11k_pull_vdev_del_resp_ev(struct ath11k_base *ab,
+					struct sk_buff *skb,
+					u32 *vdev_id)
+{
+	const void **tb;
+	const struct wmi_vdev_delete_resp_event *ev;
+	int ret;
+
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
+		return ret;
+	}
+
+	ev = tb[WMI_TAG_VDEV_DELETE_RESP_EVENT];
+	if (!ev) {
+		ath11k_warn(ab, "failed to fetch vdev delete resp ev");
+		kfree(tb);
+		return -EPROTO;
+	}
+
+	*vdev_id = ev->vdev_id;
+
+	kfree(tb);
+	return 0;
+}
+
 static int ath11k_pull_bcn_tx_status_ev(struct ath11k_base *ab, void *evt_buf,
 					u32 len, u32 *vdev_id,
 					u32 *tx_status)
@@ -5711,6 +5741,34 @@ static void ath11k_peer_delete_resp_event(struct ath11k_base *ab, struct sk_buff
 	 */
 }
 
+static void ath11k_vdev_delete_resp_event(struct ath11k_base *ab,
+					  struct sk_buff *skb)
+{
+	struct ath11k *ar;
+	u32 vdev_id = 0;
+
+	if (ath11k_pull_vdev_del_resp_ev(ab, skb, &vdev_id) != 0) {
+		ath11k_warn(ab, "failed to extract vdev delete resp");
+		return;
+	}
+
+	rcu_read_lock();
+	ar = ath11k_mac_get_ar_by_vdev_id(ab, vdev_id);
+	if (!ar) {
+		ath11k_warn(ab, "invalid vdev id in vdev delete resp ev %d",
+			    vdev_id);
+		rcu_read_unlock();
+		return;
+	}
+
+	complete(&ar->vdev_delete_done);
+
+	rcu_read_unlock();
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "vdev delete resp for vdev id %d\n",
+		   vdev_id);
+}
+
 static inline const char *ath11k_wmi_vdev_resp_print(u32 vdev_resp_status)
 {
 	switch (vdev_resp_status) {
@@ -6722,7 +6780,6 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 		break;
 	/* add Unsupported events here */
 	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
-	case WMI_VDEV_DELETE_RESP_EVENTID:
 	case WMI_PEER_OPER_MODE_CHANGE_EVENTID:
 	case WMI_TWT_ENABLE_EVENTID:
 	case WMI_TWT_DISABLE_EVENTID:
@@ -6733,6 +6790,9 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_PDEV_DFS_RADAR_DETECTION_EVENTID:
 		ath11k_wmi_pdev_dfs_radar_detected_event(ab, skb);
 		break;
+	case WMI_VDEV_DELETE_RESP_EVENTID:
+		ath11k_vdev_delete_resp_event(ab, skb);
+		break;
 	/* TODO: Add remaining events */
 	default:
 		ath11k_dbg(ab, ATH11K_DBG_WMI, "Unknown eventid: 0x%x\n", id);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index e4cc159..4c802c5 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4018,6 +4018,10 @@ struct wmi_regulatory_rule_struct {
 	u32  flag_info;
 };
 
+struct wmi_vdev_delete_resp_event {
+	u32 vdev_id;
+} __packed;
+
 struct wmi_peer_delete_resp_event {
 	u32 vdev_id;
 	struct wmi_mac_addr peer_macaddr;
-- 
2.7.4

