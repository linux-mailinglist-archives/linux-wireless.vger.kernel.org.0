Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04FB6F0DD
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 09:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfD3HDu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 03:03:50 -0400
Received: from nbd.name ([46.4.11.11]:60894 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfD3HDt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 03:03:49 -0400
Received: from p548c87b5.dip0.t-ipconnect.de ([84.140.135.181] helo=bertha.fritz.box)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hLMnq-0008Ac-19; Tue, 30 Apr 2019 09:03:46 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, John Crispin <john@phrozen.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>
Subject: [PATCH V2 3/3] ath11k: add TWT support
Date:   Tue, 30 Apr 2019 09:03:38 +0200
Message-Id: <20190430070338.4006-4-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190430070338.4006-1-john@phrozen.org>
References: <20190430070338.4006-1-john@phrozen.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add target wait time wmi calls to the driver. En/disable the support
from when the bss_config changes. We ignore the cmd completion events.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/mac.c |  7 +++
 drivers/net/wireless/ath/ath11k/wmi.c | 91 +++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h | 71 +++++++++++++++++++++++++++
 3 files changed, 169 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 2c7afbc7b9a6..e3f9d288c357 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1938,6 +1938,13 @@ static void ath11k_bss_info_changed(struct ieee80211_hw *hw,
 		ath11k_mac_txpower_recalc(ar);
 	}
 
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
index 7edaed5c97df..52d6fb200d07 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1797,6 +1797,10 @@ ath11k_wmi_copy_peer_flags(struct wmi_peer_assoc_complete_cmd *cmd,
 			cmd->peer_flags |= WMI_PEER_VHT;
 		if (param->he_flag)
 			cmd->peer_flags |= WMI_PEER_HE;
+		if (param->twt_requester)
+			cmd->peer_flags |= WMI_PEER_TWT_REQ;
+		if (param->twt_responder)
+			cmd->peer_flags |= WMI_PEER_TWT_RESP;
 	}
 
 	/* Suppress authorization for all AUTH modes that need 4-way handshake
@@ -2787,6 +2791,86 @@ int ath11k_wmi_pdev_pktlog_disable(struct ath11k *ar)
 	return ret;
 }
 
+int
+ath11k_wmi_send_twt_enable_cmd(struct ath11k *ar, u32 pdev_id)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct ath11k_base *ab = wmi->wmi_sc->sc;
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
+	struct ath11k_base *ab = wmi->wmi_sc->sc;
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
 static inline void ath11k_fill_band_to_mac_param(struct ath11k_base  *soc,
 				struct wmi_host_pdev_band_to_mac *band_to_mac)
 {
@@ -2877,6 +2961,9 @@ ath11k_wmi_copy_resource_config(struct wmi_resource_config *wmi_cfg,
 	wmi_cfg->use_pdev_id = tg_cfg->use_pdev_id;
 	wmi_cfg->flag1 = tg_cfg->atf_config;
 	wmi_cfg->peer_map_unmap_v2_support = tg_cfg->peer_map_unmap_v2_support;
+	wmi_cfg->sched_params = tg_cfg->sched_params;
+	wmi_cfg->twt_ap_pdev_count = tg_cfg->twt_ap_pdev_count;
+	wmi_cfg->twt_ap_sta_count = tg_cfg->twt_ap_sta_count;
 }
 
 static int ath11k_init_cmd_send(struct ath11k_pdev_wmi *wmi,
@@ -3068,6 +3155,8 @@ int ath11k_wmi_cmd_init(struct ath11k_base *sc)
 	config.beacon_tx_offload_max_vdev = sc->num_radios * TARGET_MAX_BCN_OFFLD;
 	config.rx_batchmode = TARGET_RX_BATCHMODE;
 	config.peer_map_unmap_v2_support = 1;
+	config.twt_ap_pdev_count = 2;
+	config.twt_ap_sta_count = 1000;
 
 	memcpy(&wmi_sc->wlan_resource_config, &config, sizeof(config));
 
@@ -5859,6 +5948,8 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	/* add Unsupported events here */
 	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
 	case WMI_VDEV_DELETE_RESP_EVENTID:
+	case WMI_TWT_ENABLE_EVENTID:
+	case WMI_TWT_DISABLE_EVENTID:
 		ath11k_dbg(ab, ATH11K_DBG_WMI,
 			   "ignoring unsupported event 0x%x\n", id);
 		break;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 071537850c68..99f69fc3cf53 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -169,6 +169,10 @@ enum wmi_cmd_group {
 	WMI_GRP_MONITOR,        /* 0x39 */
 	WMI_GRP_REGULATORY,     /* 0x3a */
 	WMI_GRP_HW_DATA_FILTER, /* 0x3b */
+	WMI_GRP_WLM,            /* 0x3c */
+	WMI_GRP_11K_OFFLOAD,    /* 0x3d */
+	WMI_GRP_TWT,            /* 0x3e */
+
 };
 
 #define WMI_CMD_GRP(grp_id) (((grp_id) << 12) | 0x1)
@@ -531,6 +535,12 @@ enum wmi_tlv_cmd_id {
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
@@ -713,6 +723,13 @@ enum wmi_tlv_event_id {
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
@@ -2736,6 +2753,9 @@ struct wmi_resource_config {
 	u32 max_num_dbs_scan_duty_cycle;
 	u32 max_num_group_keys;
 	u32 peer_map_unmap_v2_support;
+	u32 sched_params;
+	u32 twt_ap_pdev_count;
+	u32 twt_ap_sta_count;
 } __packed;
 
 struct wmi_service_ready_event {
@@ -3907,6 +3927,8 @@ struct peer_assoc_params {
 	u32 peer_he_mcs_count;
 	u32 peer_he_rx_mcs_set[WMI_HOST_MAX_HE_RATE_SET];
 	u32 peer_he_tx_mcs_set[WMI_HOST_MAX_HE_RATE_SET];
+	bool twt_responder;
+	bool twt_requester;
 	struct ath11k_ppe_threshold peer_ppet;
 };
 
@@ -4130,6 +4152,8 @@ struct wmi_pktlog_disable_cmd {
 #define WMI_PEER_DYN_MIMOPS	0x00020000
 #define WMI_PEER_STATIC_MIMOPS	0x00040000
 #define WMI_PEER_SPATIAL_MUX	0x00200000
+#define WMI_PEER_TWT_REQ	0x00400000
+#define WMI_PEER_TWT_RESP	0x00800000
 #define WMI_PEER_VHT		0x02000000
 #define WMI_PEER_80MHZ		0x04000000
 #define WMI_PEER_PMF		0x08000000
@@ -5005,6 +5029,48 @@ struct wmi_wmm_params_all_arg {
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
@@ -5065,6 +5131,9 @@ struct target_resource_config {
 	u32 max_bssid_rx_filters;
 	u32 use_pdev_id;
 	u32 peer_map_unmap_v2_support;
+	u32 sched_params;
+	u32 twt_ap_pdev_count;
+	u32 twt_ap_sta_count;
 };
 
 #define WMI_MAX_MEM_REQS 32
@@ -5190,4 +5259,6 @@ size_t ath11k_wmi_fw_stats_num_vdevs(struct list_head *head);
 void ath11k_wmi_fw_stats_fill(struct ath11k *ar,
 			      struct ath11k_fw_stats *fw_stats, u32 stats_id,
 			      char *buf);
+int ath11k_wmi_send_twt_enable_cmd(struct ath11k *ar, u32 pdev_id);
+int ath11k_wmi_send_twt_disable_cmd(struct ath11k *ar, u32 pdev_id);
 #endif
-- 
2.11.0

