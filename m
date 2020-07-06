Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE3EF215C9D
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jul 2020 19:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgGFRGc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jul 2020 13:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgGFRGc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jul 2020 13:06:32 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B58C061755
        for <linux-wireless@vger.kernel.org>; Mon,  6 Jul 2020 10:06:32 -0700 (PDT)
Received: from [134.101.131.141] (helo=bertha9.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1jsUZY-0000u0-1s; Mon, 06 Jul 2020 19:06:28 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 3/3] ath11k: add support for BSS coloring
Date:   Mon,  6 Jul 2020 19:06:16 +0200
Message-Id: <20200706170616.1764626-3-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706170616.1764626-1-john@phrozen.org>
References: <20200706170616.1764626-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Whenever the MAC detects a color collision or any of its associated station
detects one the FW will send out an event. Add the code to parse and handle
this event. and pass the data up to mac80211.

The FW does not provide an offload feature such as the one used for CSA. The
CCA process is hence triggered via the beacon offload tx completion events
sent out by the FW.

Signed-off-by: John Crispin <john@phrozen.org>
---
Changes in V2
* properly set the BSS color to avoid duplicate events
* turn the collision warning into a dbg message

 drivers/net/wireless/ath/ath11k/mac.c | 36 +++++++++++++++++
 drivers/net/wireless/ath/ath11k/mac.h |  1 +
 drivers/net/wireless/ath/ath11k/wmi.c | 57 +++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h | 14 +++++++
 4 files changed, 108 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 2836a0f197ab..9fc20ba15818 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -720,6 +720,22 @@ static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
 	return ret;
 }
 
+void ath11k_mac_bcn_tx_event(struct ath11k_vif *arvif)
+{
+	struct ieee80211_vif *vif = arvif->vif;
+
+	if (!vif->cca_active)
+		return;
+
+	if (ieee80211_cca_is_complete(vif)) {
+		ieee80211_cca_finish(vif);
+		return;
+	}
+
+	ieee80211_cca_update_counter(vif);
+	ath11k_mac_setup_bcn_tmpl(arvif);
+}
+
 static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 				     struct ieee80211_bss_conf *info)
 {
@@ -1974,6 +1990,24 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 			if (ret)
 				ath11k_warn(ar->ab, "failed to set bss color collision on vdev %i: %d\n",
 					    arvif->vdev_id,  ret);
+
+			param_id = WMI_VDEV_PARAM_BSS_COLOR;
+			if (info->he_bss_color.disabled)
+				param_value = IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED;
+			else
+				param_value = info->he_bss_color.color <<
+						IEEE80211_HE_OPERATION_BSS_COLOR_OFFSET;
+
+			ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+							    param_id,
+							    param_value);
+			if (ret)
+				ath11k_warn(ar->ab,
+					    "failed to set bss color param on vdev %i: %d\n",
+					    arvif->vdev_id,  ret);
+
+			ath11k_info(ar->ab, "bss color param 0x%x set on vdev %i\n",
+				    param_value, arvif->vdev_id);
 		} else if (vif->type == NL80211_IFTYPE_STATION) {
 			ret = ath11k_wmi_send_bss_color_change_enable_cmd(ar,
 									  arvif->vdev_id,
@@ -5883,6 +5917,8 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	ar->hw->wiphy->features |= NL80211_FEATURE_AP_MODE_CHAN_WIDTH_CHANGE |
 				   NL80211_FEATURE_AP_SCAN;
 
+	ar->hw->wiphy->flags |= WIPHY_FLAG_SUPPORTS_BSS_COLOR;
+
 	ar->max_num_stations = TARGET_NUM_STATIONS;
 	ar->max_num_peers = TARGET_NUM_PEERS_PDEV;
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index 0607479774a9..55978744e170 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -146,4 +146,5 @@ int ath11k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx);
 u8 ath11k_mac_bw_to_mac80211_bw(u8 bw);
 enum ath11k_supported_bw ath11k_mac_mac80211_bw_to_ath11k_bw(enum rate_info_bw bw);
 enum hal_encrypt_type ath11k_dp_tx_get_encrypt_type(u32 cipher);
+void ath11k_mac_bcn_tx_event(struct ath11k_vif *arvif);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index c2a972377687..210d230bc146 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -97,6 +97,8 @@ static const struct wmi_tlv_policy wmi_tlv_policies[] = {
 		= { .min_len = sizeof(struct wmi_stats_event) },
 	[WMI_TAG_PDEV_CTL_FAILSAFE_CHECK_EVENT]
 		= { .min_len = sizeof(struct wmi_pdev_ctl_failsafe_chk_event) },
+	[WMI_TAG_OBSS_COLOR_COLLISION_EVT]
+		= { .min_len = sizeof(struct wmi_obss_color_collision_event) },
 };
 
 #define PRIMAP(_hw_mode_) \
@@ -2925,6 +2927,49 @@ int ath11k_wmi_send_bss_color_change_enable_cmd(struct ath11k *ar, u32 vdev_id,
 	return ret;
 }
 
+static void
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
+	switch (ev->evt_type) {
+	case WMI_BSS_COLOR_COLLISION_DETECTION:
+		break;
+	case WMI_BSS_COLOR_COLLISION_DISABLE:
+	case WMI_BSS_COLOR_FREE_SLOT_TIMER_EXPIRY:
+	case WMI_BSS_COLOR_FREE_SLOT_AVAILABLE:
+		goto exit;
+	default:
+		ath11k_warn(ab, "received unknown obss color collision detetction event\n");
+		goto exit;
+	}
+
+	ieeee80211_obss_color_collision_notify(arvif->vif, ev->obss_color_bitmap);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "OBSS color collision detected vdev:%d, event:%d, bitmap:%08llx\n",
+		   ev->vdev_id, ev->evt_type, ev->obss_color_bitmap);
+exit:
+	kfree(tb);
+}
+
 static void
 ath11k_fill_band_to_mac_param(struct ath11k_base  *soc,
 			      struct wmi_host_pdev_band_to_mac *band_to_mac)
@@ -5118,6 +5163,7 @@ static void ath11k_vdev_start_resp_event(struct ath11k_base *ab, struct sk_buff
 
 static void ath11k_bcn_tx_status_event(struct ath11k_base *ab, struct sk_buff *skb)
 {
+	struct ath11k_vif *arvif;
 	u32 vdev_id, tx_status;
 
 	if (ath11k_pull_bcn_tx_status_ev(ab, skb->data, skb->len,
@@ -5125,6 +5171,14 @@ static void ath11k_bcn_tx_status_event(struct ath11k_base *ab, struct sk_buff *s
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
@@ -5994,6 +6048,9 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
 	case WMI_PDEV_TEMPERATURE_EVENTID:
 		ath11k_wmi_pdev_temperature_event(ab, skb);
 		break;
+	case WMI_OBSS_COLOR_COLLISION_DETECTION_EVENTID:
+		ath11k_wmi_obss_color_collision_event(ab, skb);
+		break;
 	/* add Unsupported events here */
 	case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
 	case WMI_VDEV_DELETE_RESP_EVENTID:
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index b9f3e559ced7..5676ae3d5454 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -723,6 +723,7 @@ enum wmi_tlv_event_id {
 	WMI_MDNS_STATS_EVENTID = WMI_TLV_CMD(WMI_GRP_MDNS_OFL),
 	WMI_SAP_OFL_ADD_STA_EVENTID = WMI_TLV_CMD(WMI_GRP_SAP_OFL),
 	WMI_SAP_OFL_DEL_STA_EVENTID,
+	WMI_OBSS_COLOR_COLLISION_DETECTION_EVENTID = WMI_EVT_GRP_START_ID(WMI_GRP_OBSS_OFL),
 	WMI_OCB_SET_CONFIG_RESP_EVENTID = WMI_TLV_CMD(WMI_GRP_OCB),
 	WMI_OCB_GET_TSF_TIMER_RESP_EVENTID,
 	WMI_DCC_GET_STATS_RESP_EVENTID,
@@ -4705,6 +4706,13 @@ struct wmi_obss_spatial_reuse_params_cmd {
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
@@ -4722,6 +4730,12 @@ struct wmi_bss_color_change_enable_params_cmd {
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
2.25.1

