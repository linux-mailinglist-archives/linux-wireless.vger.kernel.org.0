Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F95B11228F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2019 06:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfLDFh0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Dec 2019 00:37:26 -0500
Received: from nbd.name ([46.4.11.11]:56562 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfLDFhZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Dec 2019 00:37:25 -0500
Received: from p5dcfb666.dip0.t-ipconnect.de ([93.207.182.102] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1icNLn-00089G-Dy; Wed, 04 Dec 2019 06:37:23 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [RESEND 5/9] ath11k: add WMI calls to manually add/del/pause/resume TWT dialogs
Date:   Wed,  4 Dec 2019 06:37:09 +0100
Message-Id: <20191204053713.3064-6-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191204053713.3064-1-john@phrozen.org>
References: <20191204053713.3064-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These calls are used for debugging and will be required for WFA certification
tests.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 218 ++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/wmi.h | 114 ++++++++++++++
 2 files changed, 318 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index b16bfb50d73e..ba08a7d95764 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -97,6 +97,8 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		= { .min_len = sizeof(struct wmi_stats_event) },
 	[WMI_TAG_PDEV_CTL_FAILSAFE_CHECK_EVENT]
 		= { .min_len = sizeof(struct wmi_pdev_ctl_failsafe_chk_event) },
+	[WMI_TAG_TWT_ADD_DIALOG_COMPLETE_EVENT]
+		= { .min_len = sizeof(struct wmi_twt_add_dialog_event) },
 };
 
 #define PRIMAP(_hw_mode_) \
@@ -234,22 +236,22 @@ static int ath11k_wmi_cmd_send_nowait(struct ath11k_pdev_wmi *wmi, struct sk_buf
 int ath11k_wmi_cmd_send(struct ath11k_pdev_wmi *wmi, struct sk_buff *skb,
 			u32 cmd_id)
 {
-	struct ath11k_wmi_base *wmi_sc = wmi->wmi_ab;
+	struct ath11k_wmi_base *wmi_ab = wmi->wmi_ab;
 	int ret = -EOPNOTSUPP;
 
 	might_sleep();
 
-	wait_event_timeout(wmi_sc->tx_credits_wq, ({
+	wait_event_timeout(wmi_ab->tx_credits_wq, ({
 		ret = ath11k_wmi_cmd_send_nowait(wmi, skb, cmd_id);
 
-		if (ret && test_bit(ATH11K_FLAG_CRASH_FLUSH, &wmi_sc->ab->dev_flags))
+		if (ret && test_bit(ATH11K_FLAG_CRASH_FLUSH, &wmi_ab->ab->dev_flags))
 			ret = -ESHUTDOWN;
 
 		(ret != -EAGAIN);
 	}), WMI_SEND_TIMEOUT_HZ);
 
 	if (ret == -EAGAIN)
-		ath11k_warn(wmi_sc->ab, "wmi command %d timeout\n", cmd_id);
+		ath11k_warn(wmi_ab->ab, "wmi command %d timeout\n", cmd_id);
 
 	return ret;
 }
@@ -503,10 +505,10 @@ static int ath11k_service_ready_event(struct ath11k_base *ab, struct sk_buff *sk
 	return 0;
 }
 
-struct sk_buff *ath11k_wmi_alloc_skb(struct ath11k_wmi_base *wmi_sc, u32 len)
+struct sk_buff *ath11k_wmi_alloc_skb(struct ath11k_wmi_base *wmi_ab, u32 len)
 {
 	struct sk_buff *skb;
-	struct ath11k_base *ab = wmi_sc->ab;
+	struct ath11k_base *ab = wmi_ab->ab;
 	u32 round_len = roundup(len, 4);
 
 	skb = ath11k_htc_alloc_skb(ab, WMI_SKB_HEADROOM + round_len);
@@ -2580,6 +2582,157 @@ ath11k_wmi_send_twt_disable_cmd(struct ath11k *ar, u32 pdev_id)
 	return ret;
 }
 
+int
+ath11k_wmi_send_twt_add_dialog_cmd(struct ath11k *ar,
+				   struct wmi_twt_add_dialog_params *params)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct ath11k_base *ab = wmi->wmi_ab->ab;
+	struct wmi_twt_add_dialog_params_cmd *cmd;
+	struct sk_buff *skb;
+	int ret, len;
+
+	len = sizeof(*cmd);
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (void *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_TWT_ADD_DIALOG_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
+
+	cmd->vdev_id = params->vdev_id;
+	ether_addr_copy(cmd->peer_macaddr.addr, params->peer_macaddr);
+	cmd->dialog_id = params->dialog_id;
+	cmd->wake_intvl_us = params->wake_intvl_us;
+	cmd->wake_intvl_mantis = params->wake_intvl_mantis;
+	cmd->wake_dura_us = params->wake_dura_us;
+	cmd->sp_offset_us = params->sp_offset_us;
+	cmd->flags = params->twt_cmd;
+	if (params->flag_bcast)
+		cmd->flags |= WMI_TWT_ADD_DIALOG_FLAG_BCAST;
+	if (params->flag_trigger)
+		cmd->flags |= WMI_TWT_ADD_DIALOG_FLAG_TRIGGER;
+	if (params->flag_flow_type)
+		cmd->flags |= WMI_TWT_ADD_DIALOG_FLAG_FLOW_TYPE;
+	if (params->flag_protection)
+		cmd->flags |= WMI_TWT_ADD_DIALOG_FLAG_PROTECTION;
+
+	ret = ath11k_wmi_cmd_send(wmi, skb,
+				  WMI_TWT_ADD_DIALOG_CMDID);
+	if (ret) {
+		ath11k_warn(ab, "Failed to send WMI_TWT_ADD_DIALOG_CMDID");
+		dev_kfree_skb(skb);
+	}
+	return ret;
+}
+
+int
+ath11k_wmi_send_twt_del_dialog_cmd(struct ath11k *ar,
+				   struct wmi_twt_del_dialog_params *params)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct ath11k_base *ab = wmi->wmi_ab->ab;
+	struct wmi_twt_del_dialog_params_cmd *cmd;
+	struct sk_buff *skb;
+	int ret, len;
+
+	len = sizeof(*cmd);
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (void *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_TWT_DEL_DIALOG_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
+
+	cmd->vdev_id = params->vdev_id;
+	ether_addr_copy(cmd->peer_macaddr.addr, params->peer_macaddr);
+	cmd->dialog_id = params->dialog_id;
+
+	ret = ath11k_wmi_cmd_send(wmi, skb,
+				  WMI_TWT_DEL_DIALOG_CMDID);
+	if (ret) {
+		ath11k_warn(ab, "Failed to send WMI_TWT_DEL_DIALOG_CMDID");
+		dev_kfree_skb(skb);
+	}
+	return ret;
+}
+
+int
+ath11k_wmi_send_twt_pause_dialog_cmd(struct ath11k *ar,
+				     struct wmi_twt_pause_dialog_params *params)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct ath11k_base *ab = wmi->wmi_ab->ab;
+	struct wmi_twt_pause_dialog_params_cmd *cmd;
+	struct sk_buff *skb;
+	int ret, len;
+
+	len = sizeof(*cmd);
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (void *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_TWT_PAUSE_DIALOG_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
+
+	cmd->vdev_id = params->vdev_id;
+	ether_addr_copy(cmd->peer_macaddr.addr, params->peer_macaddr);
+	cmd->dialog_id = params->dialog_id;
+
+	ret = ath11k_wmi_cmd_send(wmi, skb,
+				  WMI_TWT_PAUSE_DIALOG_CMDID);
+	if (ret) {
+		ath11k_warn(ab, "Failed to send WMI_TWT_PAUSE_DIALOG_CMDID");
+		dev_kfree_skb(skb);
+	}
+	return ret;
+}
+
+int
+ath11k_wmi_send_twt_resume_dialog_cmd(struct ath11k *ar,
+				      struct wmi_twt_resume_dialog_params *params)
+{
+	struct ath11k_pdev_wmi *wmi = ar->wmi;
+	struct ath11k_base *ab = wmi->wmi_ab->ab;
+	struct wmi_twt_resume_dialog_params_cmd *cmd;
+	struct sk_buff *skb;
+	int ret, len;
+
+	len = sizeof(*cmd);
+
+	skb = ath11k_wmi_alloc_skb(wmi->wmi_ab, len);
+	if (!skb)
+		return -ENOMEM;
+
+	cmd = (void *)skb->data;
+	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG,
+				     WMI_TAG_TWT_RESUME_DIALOG_CMD) |
+			  FIELD_PREP(WMI_TLV_LEN, len - TLV_HDR_SIZE);
+
+	cmd->vdev_id = params->vdev_id;
+	ether_addr_copy(cmd->peer_macaddr.addr, params->peer_macaddr);
+	cmd->dialog_id = params->dialog_id;
+	cmd->sp_offset_us = params->sp_offset_us;
+	cmd->next_twt_size = params->next_twt_size;
+
+	ret = ath11k_wmi_cmd_send(wmi, skb,
+				  WMI_TWT_RESUME_DIALOG_CMDID);
+	if (ret) {
+		ath11k_warn(ab, "Failed to send WMI_TWT_RESUME_DIALOG_CMDID");
+		dev_kfree_skb(skb);
+	}
+	return ret;
+}
+
 int
 ath11k_wmi_send_obss_spr_cmd(struct ath11k *ar, u32 vdev_id,
 			     struct ieee80211_he_obss_pd *he_obss_pd)
@@ -2851,7 +3004,7 @@ int ath11k_wmi_wait_for_unified_ready(struct ath11k_base *ab)
 
 int ath11k_wmi_cmd_init(struct ath11k_base *ab)
 {
-	struct ath11k_wmi_base *wmi_sc = &ab->wmi_ab;
+	struct ath11k_wmi_base *wmi_ab = &ab->wmi_ab;
 	struct wmi_init_cmd_param init_param;
 	struct target_resource_config  config;
 
@@ -2903,21 +3056,21 @@ int ath11k_wmi_cmd_init(struct ath11k_base *ab)
 	config.twt_ap_pdev_count = 2;
 	config.twt_ap_sta_count = 1000;
 
-	memcpy(&wmi_sc->wlan_resource_config, &config, sizeof(config));
+	memcpy(&wmi_ab->wlan_resource_config, &config, sizeof(config));
 
-	init_param.res_cfg = &wmi_sc->wlan_resource_config;
-	init_param.num_mem_chunks = wmi_sc->num_mem_chunks;
-	init_param.hw_mode_id = wmi_sc->preferred_hw_mode;
-	init_param.mem_chunks = wmi_sc->mem_chunks;
+	init_param.res_cfg = &wmi_ab->wlan_resource_config;
+	init_param.num_mem_chunks = wmi_ab->num_mem_chunks;
+	init_param.hw_mode_id = wmi_ab->preferred_hw_mode;
+	init_param.mem_chunks = wmi_ab->mem_chunks;
 
-	if (wmi_sc->preferred_hw_mode == WMI_HOST_HW_MODE_SINGLE)
+	if (wmi_ab->preferred_hw_mode == WMI_HOST_HW_MODE_SINGLE)
 		init_param.hw_mode_id = WMI_HOST_HW_MODE_MAX;
 
 	init_param.num_band_to_mac = ab->num_radios;
 
 	ath11k_fill_band_to_mac_param(ab, init_param.band_to_mac);
 
-	return ath11k_init_cmd_send(&wmi_sc->wmi[0], &init_param);
+	return ath11k_init_cmd_send(&wmi_ab->wmi[0], &init_param);
 }
 
 static int ath11k_wmi_tlv_hw_mode_caps_parse(struct ath11k_base *soc,
@@ -5511,6 +5664,37 @@ ath11k_wmi_pdev_dfs_radar_detected_event(struct ath11k_base *ab, struct sk_buff
 	kfree(tb);
 }
 
+static void ath11k_wmi_twt_add_dialog_event(struct ath11k_base *ab, struct sk_buff *skb)
+{
+	const char *status[] = {
+		"OK", "TWT_NOT_ENABLED", "USED_DIALOG_ID", "INVALID_PARAM",
+		"NOT_READY", "NO_RESOURCE", "NO_ACK", "NO_RESPONSE",
+		"DENIED", "UNKNOWN_ERROR"
+	};
+	const void **tb;
+	const struct wmi_twt_add_dialog_event *ev;
+	int ret;
+
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
+		return;
+	}
+
+	ev = tb[WMI_TAG_TWT_ADD_DIALOG_COMPLETE_EVENT];
+	if (!ev) {
+		ath11k_warn(ab, "failed to fetch twt add dialog ev");
+		goto exit;
+	}
+
+	ath11k_info(ab, "TWT Add Dialog Event - Status: %s, DialogId: %d, VdevId: %d\n",
+		    status[ev->status], ev->vdev_id, ev->dialog_id);
+
+exit:
+	kfree(tb);
+}
+
 static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 {
 	struct wmi_cmd_hdr *cmd_hdr;
@@ -5588,12 +5772,18 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_PDEV_CSA_SWITCH_COUNT_STATUS_EVENTID:
 		ath11k_wmi_pdev_csa_switch_count_status_event(ab, skb);
 		break;
+	case WMI_TWT_ADD_DIALOG_EVENTID:
+		ath11k_wmi_twt_add_dialog_event(ab, skb);
+		break;
 	/* add Unsupported events here */
 	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
 	case WMI_VDEV_DELETE_RESP_EVENTID:
 	case WMI_PEER_OPER_MODE_CHANGE_EVENTID:
 	case WMI_TWT_ENABLE_EVENTID:
 	case WMI_TWT_DISABLE_EVENTID:
+	case WMI_TWT_DEL_DIALOG_EVENTID:
+	case WMI_TWT_PAUSE_DIALOG_EVENTID:
+	case WMI_TWT_RESUME_DIALOG_EVENTID:
 		ath11k_dbg(ab, ATH11K_DBG_WMI,
 			   "ignoring unsupported event 0x%x\n", id);
 		break;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index ab983aac604b..6e0be33bd37c 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4569,6 +4569,112 @@ struct wmi_twt_disable_params_cmd {
 	u32 pdev_id;
 };
 
+enum WMI_HOST_TWT_COMMAND {
+	WMI_HOST_TWT_COMMAND_REQUEST_TWT = 0,
+	WMI_HOST_TWT_COMMAND_SUGGEST_TWT,
+	WMI_HOST_TWT_COMMAND_DEMAND_TWT,
+	WMI_HOST_TWT_COMMAND_TWT_GROUPING,
+	WMI_HOST_TWT_COMMAND_ACCEPT_TWT,
+	WMI_HOST_TWT_COMMAND_ALTERNATE_TWT,
+	WMI_HOST_TWT_COMMAND_DICTATE_TWT,
+	WMI_HOST_TWT_COMMAND_REJECT_TWT,
+};
+
+#define WMI_TWT_ADD_DIALOG_FLAG_BCAST		BIT(8)
+#define WMI_TWT_ADD_DIALOG_FLAG_TRIGGER		BIT(9)
+#define WMI_TWT_ADD_DIALOG_FLAG_FLOW_TYPE	BIT(10)
+#define WMI_TWT_ADD_DIALOG_FLAG_PROTECTION	BIT(11)
+
+struct wmi_twt_add_dialog_params_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	struct wmi_mac_addr peer_macaddr;
+	u32 dialog_id;
+	u32 wake_intvl_us;
+	u32 wake_intvl_mantis;
+	u32 wake_dura_us;
+	u32 sp_offset_us;
+	u32 flags;
+};
+
+struct wmi_twt_add_dialog_params {
+	u32 vdev_id;
+	u8 peer_macaddr[ETH_ALEN];
+	u32 dialog_id;
+	u32 wake_intvl_us;
+	u32 wake_intvl_mantis;
+	u32 wake_dura_us;
+	u32 sp_offset_us;
+	u8 twt_cmd;
+	u8 flag_bcast;
+	u8 flag_trigger;
+	u8 flag_flow_type;
+	u8 flag_protection;
+};
+
+enum  wmi_twt_add_dialog_status {
+	WMI_ADD_TWT_STATUS_OK,
+	WMI_ADD_TWT_STATUS_TWT_NOT_ENABLED,
+	WMI_ADD_TWT_STATUS_USED_DIALOG_ID,
+	WMI_ADD_TWT_STATUS_INVALID_PARAM,
+	WMI_ADD_TWT_STATUS_NOT_READY,
+	WMI_ADD_TWT_STATUS_NO_RESOURCE,
+	WMI_ADD_TWT_STATUS_NO_ACK,
+	WMI_ADD_TWT_STATUS_NO_RESPONSE,
+	WMI_ADD_TWT_STATUS_DENIED,
+	WMI_ADD_TWT_STATUS_UNKNOWN_ERROR,
+};
+
+struct wmi_twt_add_dialog_event {
+	u32 vdev_id;
+	struct wmi_mac_addr peer_macaddr;
+	u32 dialog_id;
+	u32 status;
+};
+
+struct wmi_twt_del_dialog_params {
+	u32 vdev_id;
+	u8 peer_macaddr[ETH_ALEN];
+	u32 dialog_id;
+};
+
+struct wmi_twt_del_dialog_params_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	struct wmi_mac_addr peer_macaddr;
+	u32 dialog_id;
+};
+
+struct wmi_twt_pause_dialog_params {
+	u32 vdev_id;
+	u8 peer_macaddr[ETH_ALEN];
+	u32 dialog_id;
+};
+
+struct wmi_twt_pause_dialog_params_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	struct wmi_mac_addr peer_macaddr;
+	u32 dialog_id;
+};
+
+struct wmi_twt_resume_dialog_params {
+	u32 vdev_id;
+	u8 peer_macaddr[ETH_ALEN];
+	u32 dialog_id;
+	u32 sp_offset_us;
+	u32 next_twt_size;
+};
+
+struct wmi_twt_resume_dialog_params_cmd {
+	u32 tlv_header;
+	u32 vdev_id;
+	struct wmi_mac_addr peer_macaddr;
+	u32 dialog_id;
+	u32 sp_offset_us;
+	u32 next_twt_size;
+};
+
 struct wmi_obss_spatial_reuse_params_cmd {
 	u32 tlv_header;
 	u32 pdev_id;
@@ -4766,6 +4872,14 @@ void ath11k_wmi_fw_stats_fill(struct ath11k *ar,
 int ath11k_wmi_simulate_radar(struct ath11k *ar);
 int ath11k_wmi_send_twt_enable_cmd(struct ath11k *ar, u32 pdev_id);
 int ath11k_wmi_send_twt_disable_cmd(struct ath11k *ar, u32 pdev_id);
+int ath11k_wmi_send_twt_add_dialog_cmd(struct ath11k *ar,
+				       struct wmi_twt_add_dialog_params *params);
+int ath11k_wmi_send_twt_del_dialog_cmd(struct ath11k *ar,
+				       struct wmi_twt_del_dialog_params *params);
+int ath11k_wmi_send_twt_pause_dialog_cmd(struct ath11k *ar,
+					 struct wmi_twt_pause_dialog_params *params);
+int ath11k_wmi_send_twt_resume_dialog_cmd(struct ath11k *ar,
+					  struct wmi_twt_resume_dialog_params *params);
 int ath11k_wmi_send_obss_spr_cmd(struct ath11k *ar, u32 vdev_id,
 				 struct ieee80211_he_obss_pd *he_obss_pd);
 #endif
-- 
2.20.1

