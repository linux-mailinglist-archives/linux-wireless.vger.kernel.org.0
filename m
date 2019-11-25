Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA5511091F8
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 17:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbfKYQga (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 11:36:30 -0500
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:56896
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728927AbfKYQga (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 11:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574699788;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=VFq+RPPdYp2ZSAFTKHJkA1DfrhKX21fmpQLPVRkKF+o=;
        b=Z9zqdOjnJtE14Epd0aO+ow3Vr4ndlEeBzLVQoyHuaCVbumfdr1eShfUHayglJeH2
        6k/6PnpnHuyvv89BX1GyHFfmJLkB6O2BPlCvnWn1pFt5t6Oa4V9vXhShXsCOEJEXUS6
        +6gXeuhzKnBmQyhR5kNLG7iIVzoQD8jChpIslodA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574699788;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=VFq+RPPdYp2ZSAFTKHJkA1DfrhKX21fmpQLPVRkKF+o=;
        b=Ofl2vjiV977w1EMlRu+xqUG1EXFDpR9eFXBd2z8Q1KZfLvuCU5ZG1HHupSQHwai3
        R+3HMr8hqeFbr4Ywh092KFW6ejxQluGNZeMonhGk/mIDAm5DQzfR4cpWQtHvlZNJCxB
        xJV06T7Berjvo2xbY46l/IvO3Cs4C0gbDOf1zK6A=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77C8DC76F4A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 7/8] ath11k: add TWT support
Date:   Mon, 25 Nov 2019 16:36:28 +0000
Message-ID: <0101016ea36be968-3ec47eaa-a258-47e1-99a2-0599f2726bd7-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574699772-17938-1-git-send-email-kvalo@codeaurora.org>
References: <1574699772-17938-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.25-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

Add target wait time wmi calls to the driver. En/disable the support
from when the bss_config changes. We ignore the cmd completion events.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 12 +++++
 drivers/net/wireless/ath/ath11k/wmi.c | 91 +++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h | 70 +++++++++++++++++++++++++++
 3 files changed, 173 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 79c22d86e0fe..70945d121fba 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1189,6 +1189,11 @@ static void ath11k_peer_assoc_h_he(struct ath11k *ar,
 		}
 	}
 
+	if (he_cap->he_cap_elem.mac_cap_info[0] & IEEE80211_HE_MAC_CAP0_TWT_RES)
+		arg->twt_responder = true;
+	if (he_cap->he_cap_elem.mac_cap_info[0] & IEEE80211_HE_MAC_CAP0_TWT_REQ)
+		arg->twt_requester = true;
+
 	switch (sta->bandwidth) {
 	case IEEE80211_STA_RX_BW_160:
 		if (he_cap->he_cap_elem.phy_cap_info[0] &
@@ -1904,6 +1909,13 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 	    !ath11k_mac_vif_chan(arvif->vif, &def))
 		ath11k_recalculate_mgmt_rate(ar, vif, &def);
 
+	if (changed & BSS_CHANGED_TWT) {
+		if (info->twt_requester || info->twt_responder)
+			ath11k_wmi_send_twt_enable_cmd(ar, ar->pdev_idx);
+		else
+			ath11k_wmi_send_twt_disable_cmd(ar, ar->pdev_idx);
+	}
+
 	mutex_unlock(&ar->conf_mutex);
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index d077ea30f3c1..7aa66e8eecb6 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1622,6 +1622,10 @@ ath11k_wmi_copy_peer_flags(struct wmi_peer_assoc_complete_cmd *cmd,
 			cmd->peer_flags |= WMI_PEER_VHT;
 		if (param->he_flag)
 			cmd->peer_flags |= WMI_PEER_HE;
+		if (param->twt_requester)
+			cmd->peer_flags |= WMI_PEER_TWT_REQ;
+		if (param->twt_responder)
+			cmd->peer_flags |= WMI_PEER_TWT_RESP;
 	}
 
 	/* Suppress authorization for all AUTH modes that need 4-way handshake
@@ -2457,6 +2461,86 @@ int ath11k_wmi_pdev_pktlog_disable(struct ath11k *ar)
 	return ret;
 }
 
+int
+ath11k_wmi_send_twt_enable_cmd(struct ath11k *ar, u32 pdev_id)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct ath11k_base *ab = wmi->wmi_sc->ab;
+	struct wmi_twt_enable_params_cmd *cmd;
+	struct sk_buff *skb;
+	int ret, len;
+
+	len = sizeof(*cmd);
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (void *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_TWT_ENABLE_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
+	cmd->pdev_id = pdev_id;
+	cmd->sta_cong_timer_ms = ATH11K_TWT_DEF_STA_CONG_TIMER_MS;
+	cmd->default_slot_size = ATH11K_TWT_DEF_DEFAULT_SLOT_SIZE;
+	cmd->congestion_thresh_setup = ATH11K_TWT_DEF_CONGESTION_THRESH_SETUP;
+	cmd->congestion_thresh_teardown =
+		ATH11K_TWT_DEF_CONGESTION_THRESH_TEARDOWN;
+	cmd->congestion_thresh_critical =
+		ATH11K_TWT_DEF_CONGESTION_THRESH_CRITICAL;
+	cmd->interference_thresh_teardown =
+		ATH11K_TWT_DEF_INTERFERENCE_THRESH_TEARDOWN;
+	cmd->interference_thresh_setup =
+		ATH11K_TWT_DEF_INTERFERENCE_THRESH_SETUP;
+	cmd->min_no_sta_setup = ATH11K_TWT_DEF_MIN_NO_STA_SETUP;
+	cmd->min_no_sta_teardown = ATH11K_TWT_DEF_MIN_NO_STA_TEARDOWN;
+	cmd->no_of_bcast_mcast_slots = ATH11K_TWT_DEF_NO_OF_BCAST_MCAST_SLOTS;
+	cmd->min_no_twt_slots = ATH11K_TWT_DEF_MIN_NO_TWT_SLOTS;
+	cmd->max_no_sta_twt = ATH11K_TWT_DEF_MAX_NO_STA_TWT;
+	cmd->mode_check_interval = ATH11K_TWT_DEF_MODE_CHECK_INTERVAL;
+	cmd->add_sta_slot_interval = ATH11K_TWT_DEF_ADD_STA_SLOT_INTERVAL;
+	cmd->remove_sta_slot_interval =
+		ATH11K_TWT_DEF_REMOVE_STA_SLOT_INTERVAL;
+	/* TODO add MBSSID support */
+	cmd->mbss_support = 0;
+
+	ret = ath11k_wmi_cmd_send(wmi, skb,
+				  WMI_TWT_ENABLE_CMDID);
+	if (ret) {
+		ath11k_warn(ab, "Failed to send WMI_TWT_ENABLE_CMDID");
+		dev_kfree_skb(skb);
+	}
+	return ret;
+}
+
+int
+ath11k_wmi_send_twt_disable_cmd(struct ath11k *ar, u32 pdev_id)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct ath11k_base *ab = wmi->wmi_sc->ab;
+	struct wmi_twt_disable_params_cmd *cmd;
+	struct sk_buff *skb;
+	int ret, len;
+
+	len = sizeof(*cmd);
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_sc, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (void *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_TWT_DISABLE_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
+	cmd->pdev_id = pdev_id;
+
+	ret = ath11k_wmi_cmd_send(wmi, skb,
+				  WMI_TWT_DISABLE_CMDID);
+	if (ret) {
+		ath11k_warn(ab, "Failed to send WMI_TWT_DIeABLE_CMDID");
+		dev_kfree_skb(skb);
+	}
+	return ret;
+}
+
 static void
 ath11k_fill_band_to_mac_param(struct ath11k_base  *soc,
 			      struct wmi_host_pdev_band_to_mac *band_to_mac)
@@ -2548,6 +2632,9 @@ ath11k_wmi_copy_resource_config(struct wmi_resource_config *wmi_cfg,
 	wmi_cfg->use_pdev_id = tg_cfg->use_pdev_id;
 	wmi_cfg->flag1 = tg_cfg->atf_config;
 	wmi_cfg->peer_map_unmap_v2_support = tg_cfg->peer_map_unmap_v2_support;
+	wmi_cfg->sched_params = tg_cfg->sched_params;
+	wmi_cfg->twt_ap_pdev_count = tg_cfg->twt_ap_pdev_count;
+	wmi_cfg->twt_ap_sta_count = tg_cfg->twt_ap_sta_count;
 }
 
 static int ath11k_init_cmd_send(struct ath11k_pdev_wmi *wmi,
@@ -2739,6 +2826,8 @@ int ath11k_wmi_cmd_init(struct ath11k_base *ab)
 	config.beacon_tx_offload_max_vdev = ab->num_radios * TARGET_MAX_BCN_OFFLD;
 	config.rx_batchmode = TARGET_RX_BATCHMODE;
 	config.peer_map_unmap_v2_support = 1;
+	config.twt_ap_pdev_count = 2;
+	config.twt_ap_sta_count = 1000;
 
 	memcpy(&wmi_sc->wlan_resource_config, &config, sizeof(config));
 
@@ -5421,6 +5510,8 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
 	case WMI_VDEV_DELETE_RESP_EVENTID:
 	case WMI_PEER_OPER_MODE_CHANGE_EVENTID:
+	case WMI_TWT_ENABLE_EVENTID:
+	case WMI_TWT_DISABLE_EVENTID:
 		ath11k_dbg(ab, ATH11K_DBG_WMI,
 			   "ignoring unsupported event 0x%x\n", id);
 		break;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index fd1ffa593a41..b5c53f2ac5cc 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -169,6 +169,9 @@ enum wmi_cmd_group {
 	WMI_GRP_MONITOR        = 0x39,
 	WMI_GRP_REGULATORY     = 0x3a,
 	WMI_GRP_HW_DATA_FILTER = 0x3b,
+	WMI_GRP_WLM            = 0x3c,
+	WMI_GRP_11K_OFFLOAD    = 0x3d,
+	WMI_GRP_TWT            = 0x3e,
 };
 
 #define WMI_CMD_GRP(grp_id) (((grp_id) << 12) | 0x1)
@@ -530,6 +533,12 @@ enum wmi_tlv_cmd_id {
 	WMI_NDP_RESPONDER_REQ_CMDID,
 	WMI_NDP_END_REQ_CMDID,
 	WMI_HW_DATA_FILTER_CMDID = WMI_TLV_CMD(WMI_GRP_HW_DATA_FILTER),
+	WMI_TWT_ENABLE_CMDID = WMI_TLV_CMD(WMI_GRP_TWT),
+	WMI_TWT_DISABLE_CMDID,
+	WMI_TWT_ADD_DIALOG_CMDID,
+	WMI_TWT_DEL_DIALOG_CMDID,
+	WMI_TWT_PAUSE_DIALOG_CMDID,
+	WMI_TWT_RESUME_DIALOG_CMDID,
 };
 
 enum wmi_tlv_event_id {
@@ -724,6 +733,13 @@ enum wmi_tlv_event_id {
 	WMI_NDP_INDICATION_EVENTID,
 	WMI_NDP_CONFIRM_EVENTID,
 	WMI_NDP_END_INDICATION_EVENTID,
+
+	WMI_TWT_ENABLE_EVENTID = WMI_TLV_CMD(WMI_GRP_TWT),
+	WMI_TWT_DISABLE_EVENTID,
+	WMI_TWT_ADD_DIALOG_EVENTID,
+	WMI_TWT_DEL_DIALOG_EVENTID,
+	WMI_TWT_PAUSE_DIALOG_EVENTID,
+	WMI_TWT_RESUME_DIALOG_EVENTID,
 };
 
 enum wmi_tlv_pdev_param {
@@ -2183,6 +2199,9 @@ struct wmi_resource_config {
 	u32 max_num_dbs_scan_duty_cycle;
 	u32 max_num_group_keys;
 	u32 peer_map_unmap_v2_support;
+	u32 sched_params;
+	u32 twt_ap_pdev_count;
+	u32 twt_ap_sta_count;
 } __packed;
 
 struct wmi_service_ready_event {
@@ -3401,6 +3420,8 @@ struct peer_assoc_params {
 	u32 peer_he_mcs_count;
 	u32 peer_he_rx_mcs_set[WMI_HOST_MAX_HE_RATE_SET];
 	u32 peer_he_tx_mcs_set[WMI_HOST_MAX_HE_RATE_SET];
+	bool twt_responder;
+	bool twt_requester;
 	struct ath11k_ppe_threshold peer_ppet;
 };
 
@@ -3652,6 +3673,8 @@ struct wmi_unit_test_cmd {
 #define WMI_PEER_DYN_MIMOPS	0x00020000
 #define WMI_PEER_STATIC_MIMOPS	0x00040000
 #define WMI_PEER_SPATIAL_MUX	0x00200000
+#define WMI_PEER_TWT_REQ	0x00400000
+#define WMI_PEER_TWT_RESP	0x00800000
 #define WMI_PEER_VHT		0x02000000
 #define WMI_PEER_80MHZ		0x04000000
 #define WMI_PEER_PMF		0x08000000
@@ -4494,6 +4517,48 @@ struct wmi_wmm_params_all_arg {
 	struct wmi_wmm_params_arg ac_vo;
 };
 
+#define ATH11K_TWT_DEF_STA_CONG_TIMER_MS		5000
+#define ATH11K_TWT_DEF_DEFAULT_SLOT_SIZE		10
+#define ATH11K_TWT_DEF_CONGESTION_THRESH_SETUP		50
+#define ATH11K_TWT_DEF_CONGESTION_THRESH_TEARDOWN	20
+#define ATH11K_TWT_DEF_CONGESTION_THRESH_CRITICAL	100
+#define ATH11K_TWT_DEF_INTERFERENCE_THRESH_TEARDOWN	80
+#define ATH11K_TWT_DEF_INTERFERENCE_THRESH_SETUP	50
+#define ATH11K_TWT_DEF_MIN_NO_STA_SETUP			10
+#define ATH11K_TWT_DEF_MIN_NO_STA_TEARDOWN		2
+#define ATH11K_TWT_DEF_NO_OF_BCAST_MCAST_SLOTS		2
+#define ATH11K_TWT_DEF_MIN_NO_TWT_SLOTS			2
+#define ATH11K_TWT_DEF_MAX_NO_STA_TWT			500
+#define ATH11K_TWT_DEF_MODE_CHECK_INTERVAL		10000
+#define ATH11K_TWT_DEF_ADD_STA_SLOT_INTERVAL		1000
+#define ATH11K_TWT_DEF_REMOVE_STA_SLOT_INTERVAL		5000
+
+struct wmi_twt_enable_params_cmd {
+	u32 tlv_header;
+	u32 pdev_id;
+	u32 sta_cong_timer_ms;
+	u32 mbss_support;
+	u32 default_slot_size;
+	u32 congestion_thresh_setup;
+	u32 congestion_thresh_teardown;
+	u32 congestion_thresh_critical;
+	u32 interference_thresh_teardown;
+	u32 interference_thresh_setup;
+	u32 min_no_sta_setup;
+	u32 min_no_sta_teardown;
+	u32 no_of_bcast_mcast_slots;
+	u32 min_no_twt_slots;
+	u32 max_no_sta_twt;
+	u32 mode_check_interval;
+	u32 add_sta_slot_interval;
+	u32 remove_sta_slot_interval;
+};
+
+struct wmi_twt_disable_params_cmd {
+	u32 tlv_header;
+	u32 pdev_id;
+};
+
 struct target_resource_config {
 	u32 num_vdevs;
 	u32 num_peers;
@@ -4553,6 +4618,9 @@ struct target_resource_config {
 	u32 max_bssid_rx_filters;
 	u32 use_pdev_id;
 	u32 peer_map_unmap_v2_support;
+	u32 sched_params;
+	u32 twt_ap_pdev_count;
+	u32 twt_ap_sta_count;
 };
 
 #define WMI_MAX_MEM_REQS 32
@@ -4676,4 +4744,6 @@ void ath11k_wmi_fw_stats_fill(struct ath11k *ar,
 			      struct ath11k_fw_stats *fw_stats, u32 stats_id,
 			      char *buf);
 int ath11k_wmi_simulate_radar(struct ath11k *ar);
+int ath11k_wmi_send_twt_enable_cmd(struct ath11k *ar, u32 pdev_id);
+int ath11k_wmi_send_twt_disable_cmd(struct ath11k *ar, u32 pdev_id);
 #endif
-- 
2.7.4

