Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE65439B3A
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 18:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhJYQNc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 12:13:32 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:57003 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhJYQNb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 12:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635178269; x=1666714269;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=93wGs71QuZyGhcT2287FxfRRlrIaDUSqnCHnv73i664=;
  b=YmnZwPo4zQLLPSrFGT6mGP191i0QM66S+ZVcE4GiMMNa8+uMT6guCEt4
   oh7yiw0k4AVo1LhjIkZXRCHPgflRnXMBOUqI1HIVcETXc+nAU2mlRpdon
   d2B/g06F6Ni089XmUZoRHEarsCvM2y6ONjYqFTiDToagqkWvuudNv+Bi9
   w=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 25 Oct 2021 09:11:09 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 09:11:09 -0700
Received: from ramess-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 25 Oct 2021 09:11:06 -0700
From:   Rameshkumar Sundaram <quic_ramess@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <lavaks@codeaurora.org>
Subject: [PATCH] ath11k: add support for BSS color change
Date:   Mon, 25 Oct 2021 21:40:54 +0530
Message-ID: <1635178254-17732-1-git-send-email-quic_ramess@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: John Crispin <john@phrozen.org>

Whenever the MAC detects a color collision, or any of
its associated stations detects one, the firmware will
send out an event. Add the code to parse and handle
this event and pass the data up to mac80211.

The firmware does not provide an offload feature such
as the one used for CSA. The color change process is
hence triggered via the beacon offload tx completion
events sent out by firmware.

BSS color feature is enabled depending on service flag
advertised by firmware, based on which color change
functionality is invoked.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00680-QCAHKSWPL_SILICONZ-1

Signed-off-by: John Crispin <john@phrozen.org>
Co-developed-by: Lavanya Suresh <lavaks@codeaurora.org>
Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
Signed-off-by: Rameshkumar Sundaram <quic_ramess@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h |  2 +
 drivers/net/wireless/ath/ath11k/mac.c  | 57 +++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/mac.h  |  1 +
 drivers/net/wireless/ath/ath11k/wmi.c  | 78 +++++++++++++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/wmi.h  | 15 +++++++
 5 files changed, 147 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 31d234a..fd77a5d 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -249,6 +249,8 @@ struct ath11k_vif {
 	int txpower;
 	bool rsnie_present;
 	bool wpaie_present;
+	bool bcca_zero_sent;
+	bool do_not_send_tmpl;
 	struct ieee80211_chanctx_conf chanctx;
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 3ae5193..ec01026 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1154,6 +1154,26 @@ static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
 	return ret;
 }
 
+void ath11k_mac_bcn_tx_event(struct ath11k_vif *arvif)
+{
+	struct ieee80211_vif *vif = arvif->vif;
+
+	if (!vif->color_change_active && !arvif->bcca_zero_sent)
+		return;
+
+	if (vif->color_change_active && ieee80211_beacon_cntdwn_is_complete(vif)) {
+		arvif->bcca_zero_sent = true;
+		ieee80211_color_change_finish(vif);
+		return;
+	}
+
+	arvif->bcca_zero_sent = false;
+
+	if (vif->color_change_active)
+		ieee80211_beacon_update_cntdwn(vif);
+	ath11k_mac_setup_bcn_tmpl(arvif);
+}
+
 static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 				     struct ieee80211_bss_conf *info)
 {
@@ -2806,10 +2826,17 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 				   "Set staggered beacon mode for VDEV: %d\n",
 				   arvif->vdev_id);
 
-		ret = ath11k_mac_setup_bcn_tmpl(arvif);
-		if (ret)
-			ath11k_warn(ar->ab, "failed to update bcn template: %d\n",
-				    ret);
+		if (!arvif->do_not_send_tmpl || !arvif->bcca_zero_sent) {
+			ret = ath11k_mac_setup_bcn_tmpl(arvif);
+			if (ret)
+				ath11k_warn(ar->ab, "failed to update bcn template: %d\n",
+					    ret);
+		}
+
+		if (arvif->bcca_zero_sent)
+			arvif->do_not_send_tmpl = true;
+		else
+			arvif->do_not_send_tmpl = false;
 	}
 
 	if (changed & (BSS_CHANGED_BEACON_INFO | BSS_CHANGED_BEACON)) {
@@ -3010,6 +3037,25 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 			if (ret)
 				ath11k_warn(ar->ab, "failed to set bss color collision on vdev %i: %d\n",
 					    arvif->vdev_id,  ret);
+
+			param_id = WMI_VDEV_PARAM_BSS_COLOR;
+			if (info->he_bss_color.enabled)
+				param_value = info->he_bss_color.color <<
+						IEEE80211_HE_OPERATION_BSS_COLOR_OFFSET;
+			else
+				param_value = IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED;
+
+			ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+							    param_id,
+							    param_value);
+			if (ret)
+				ath11k_warn(ar->ab,
+					    "failed to set bss color param on vdev %i: %d\n",
+					    arvif->vdev_id,  ret);
+
+			ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+				   "bss color param 0x%x set on vdev %i\n",
+				   param_value, arvif->vdev_id);
 		} else if (vif->type == NL80211_IFTYPE_STATION) {
 			ret = ath11k_wmi_send_bss_color_change_enable_cmd(ar,
 									  arvif->vdev_id,
@@ -7706,6 +7752,9 @@ static int __ath11k_mac_register(struct ath11k *ar)
 
 	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
 	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);
+	if (test_bit(WMI_TLV_SERVICE_BSS_COLOR_OFFLOAD, ar->ab->wmi_ab.svc_map))
+		wiphy_ext_feature_set(ar->hw->wiphy,
+				      NL80211_EXT_FEATURE_BSS_COLOR);
 
 	ar->hw->wiphy->cipher_suites = cipher_suites;
 	ar->hw->wiphy->n_cipher_suites = ARRAY_SIZE(cipher_suites);
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index 254ca4a..f6f37e8c 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -155,4 +155,5 @@ enum ath11k_supported_bw ath11k_mac_mac80211_bw_to_ath11k_bw(enum rate_info_bw b
 enum hal_encrypt_type ath11k_dp_tx_get_encrypt_type(u32 cipher);
 void ath11k_mac_handle_beacon(struct ath11k *ar, struct sk_buff *skb);
 void ath11k_mac_handle_beacon_miss(struct ath11k *ar, u32 vdev_id);
+void ath11k_mac_bcn_tx_event(struct ath11k_vif *arvif);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 2c940ed..3aa67f6 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -128,6 +128,8 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		.min_len = sizeof(struct wmi_probe_resp_tx_status_event) },
 	[WMI_TAG_VDEV_DELETE_RESP_EVENT] = {
 		.min_len = sizeof(struct wmi_vdev_delete_resp_event) },
+	[WMI_TAG_OBSS_COLOR_COLLISION_EVT] = {
+		.min_len = sizeof(struct wmi_obss_color_collision_event) },
 };
 
 #define PRIMAP(_hw_mode_) \
@@ -1612,6 +1614,15 @@ int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 	void *ptr;
 	int ret, len;
 	size_t aligned_len = roundup(bcn->len, 4);
+	struct ieee80211_vif *vif;
+	struct ath11k_vif *arvif = ath11k_mac_get_arvif(ar, vdev_id);
+
+	if (!arvif) {
+		ath11k_warn(ar->ab, "failed to find arvif with vdev id %d\n", vdev_id);
+		return -EINVAL;
+	}
+
+	vif = arvif->vif;
 
 	len = sizeof(*cmd) + sizeof(*bcn_prb_info) + TLV_HDR_SIZE + aligned_len;
 
@@ -1624,8 +1635,12 @@ int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
 	cmd->vdev_id = vdev_id;
 	cmd->tim_ie_offset = offs->tim_offset;
-	cmd->csa_switch_count_offset = offs->cntdwn_counter_offs[0];
-	cmd->ext_csa_switch_count_offset = offs->cntdwn_counter_offs[1];
+
+	if (vif->csa_active) {
+		cmd->csa_switch_count_offset = offs->cntdwn_counter_offs[0];
+		cmd->ext_csa_switch_count_offset = offs->cntdwn_counter_offs[1];
+	}
+
 	cmd->buf_len = bcn->len;
 
 	ptr = skb->data + sizeof(*cmd);
@@ -3428,6 +3443,53 @@ int ath11k_wmi_fils_discovery(struct ath11k *ar, u32 vdev_id, u32 interval,
 }
 
 static void
+ath11k_wmi_obss_color_collision_event(struct ath11k_base *ab, struct sk_buff *skb)
+{
+	const void **tb;
+	const struct wmi_obss_color_collision_event *ev;
+	struct ath11k_vif *arvif;
+	int ret;
+
+	tb = ath11k_wmi_tlv_parse_alloc(ab, skb->data, skb->len, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ret = PTR_ERR(tb);
+		ath11k_warn(ab, "failed to parse tlv: %d\n", ret);
+		return;
+	}
+
+	ev = tb[WMI_TAG_OBSS_COLOR_COLLISION_EVT];
+	if (!ev) {
+		ath11k_warn(ab, "failed to fetch obss color collision ev");
+		goto exit;
+	}
+
+	arvif = ath11k_mac_get_arvif_by_vdev_id(ab, ev->vdev_id);
+	if (!arvif) {
+		ath11k_warn(ab, "failed to find arvif with vedv id %d in obss_color_collision_event\n",
+			    ev->vdev_id);
+		goto exit;
+	}
+
+	switch (ev->evt_type) {
+	case WMI_BSS_COLOR_COLLISION_DETECTION:
+		ieeee80211_obss_color_collision_notify(arvif->vif, ev->obss_color_bitmap);
+		ath11k_dbg(ab, ATH11K_DBG_WMI,
+			   "OBSS color collision detected vdev:%d, event:%d, bitmap:%08llx\n",
+			   ev->vdev_id, ev->evt_type, ev->obss_color_bitmap);
+		break;
+	case WMI_BSS_COLOR_COLLISION_DISABLE:
+	case WMI_BSS_COLOR_FREE_SLOT_TIMER_EXPIRY:
+	case WMI_BSS_COLOR_FREE_SLOT_AVAILABLE:
+		break;
+	default:
+		ath11k_warn(ab, "received unknown obss color collision detetction event\n");
+	}
+
+exit:
+	kfree(tb);
+}
+
+static void
 ath11k_fill_band_to_mac_param(struct ath11k_base  *soc,
 			      struct wmi_host_pdev_band_to_mac *band_to_mac)
 {
@@ -6111,6 +6173,7 @@ static void ath11k_vdev_start_resp_event(struct ath11k_base *ab, struct sk_buff
 
 static void ath11k_bcn_tx_status_event(struct ath11k_base *ab, struct sk_buff *skb)
 {
+	struct ath11k_vif *arvif;
 	u32 vdev_id, tx_status;
 
 	if (ath11k_pull_bcn_tx_status_ev(ab, skb->data, skb->len,
@@ -6118,6 +6181,14 @@ static void ath11k_bcn_tx_status_event(struct ath11k_base *ab, struct sk_buff *s
 		ath11k_warn(ab, "failed to extract bcn tx status");
 		return;
 	}
+
+	arvif = ath11k_mac_get_arvif_by_vdev_id(ab, vdev_id);
+	if (!arvif) {
+		ath11k_warn(ab, "invalid vdev id %d in bcn_tx_status",
+			    vdev_id);
+		return;
+	}
+	ath11k_mac_bcn_tx_event(arvif);
 }
 
 static void ath11k_vdev_stopped_event(struct ath11k_base *ab, struct sk_buff *skb)
@@ -7138,6 +7209,9 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_OFFLOAD_PROB_RESP_TX_STATUS_EVENTID:
 		ath11k_probe_resp_tx_status_event(ab, skb);
 		break;
+	case WMI_OBSS_COLOR_COLLISION_DETECTION_EVENTID:
+		ath11k_wmi_obss_color_collision_event(ab, skb);
+		break;
 	/* add Unsupported events here */
 	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
 	case WMI_PEER_OPER_MODE_CHANGE_EVENTID:
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index f395937..f43a280 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -774,6 +774,8 @@ enum wmi_tlv_event_id {
 	WMI_MDNS_STATS_EVENTID = WMI_TLV_CMD(WMI_GRP_MDNS_OFL),
 	WMI_SAP_OFL_ADD_STA_EVENTID = WMI_TLV_CMD(WMI_GRP_SAP_OFL),
 	WMI_SAP_OFL_DEL_STA_EVENTID,
+	WMI_OBSS_COLOR_COLLISION_DETECTION_EVENTID =
+		WMI_EVT_GRP_START_ID(WMI_GRP_OBSS_OFL),
 	WMI_OCB_SET_CONFIG_RESP_EVENTID = WMI_TLV_CMD(WMI_GRP_OCB),
 	WMI_OCB_GET_TSF_TIMER_RESP_EVENTID,
 	WMI_DCC_GET_STATS_RESP_EVENTID,
@@ -4915,6 +4917,13 @@ struct wmi_pdev_obss_pd_bitmap_cmd {
 #define ATH11K_BSS_COLOR_COLLISION_DETECTION_STA_PERIOD_MS	10000
 #define ATH11K_BSS_COLOR_COLLISION_DETECTION_AP_PERIOD_MS	5000
 
+enum wmi_bss_color_collision {
+	WMI_BSS_COLOR_COLLISION_DISABLE = 0,
+	WMI_BSS_COLOR_COLLISION_DETECTION,
+	WMI_BSS_COLOR_FREE_SLOT_TIMER_EXPIRY,
+	WMI_BSS_COLOR_FREE_SLOT_AVAILABLE,
+};
+
 struct wmi_obss_color_collision_cfg_params_cmd {
 	u32 tlv_header;
 	u32 vdev_id;
@@ -4932,6 +4941,12 @@ struct wmi_bss_color_change_enable_params_cmd {
 	u32 enable;
 } __packed;
 
+struct wmi_obss_color_collision_event {
+	u32 vdev_id;
+	u32 evt_type;
+	u64 obss_color_bitmap;
+} __packed;
+
 #define ATH11K_IPV4_TH_SEED_SIZE 5
 #define ATH11K_IPV6_TH_SEED_SIZE 11
 
-- 
2.7.4

