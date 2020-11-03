Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC0B2A3FEF
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Nov 2020 10:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgKCJZC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Nov 2020 04:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgKCJZB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Nov 2020 04:25:01 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510DEC0613D1
        for <linux-wireless@vger.kernel.org>; Tue,  3 Nov 2020 01:25:00 -0800 (PST)
Received: from [149.224.151.57] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1kZsYh-0006aB-Lq; Tue, 03 Nov 2020 10:24:55 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V5] ath11k: add multiple bssid support
Date:   Tue,  3 Nov 2020 10:24:54 +0100
Message-Id: <20201103092454.1925317-1-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add the required wmi support and make use of it in the beacon template
code. We need to split the beacon code up into 2 code paths so that
we can also send EMA templates.

Signed-off-by: John Crispin <john@phrozen.org>
---
The patch depends on the multiple bssid and bss color series.

Changes in V5
* rebase on latest next tree

 drivers/net/wireless/ath/ath11k/hw.c  |   2 +
 drivers/net/wireless/ath/ath11k/mac.c | 184 ++++++++++++++++++++++----
 drivers/net/wireless/ath/ath11k/wmi.c |  30 ++++-
 drivers/net/wireless/ath/ath11k/wmi.h |  88 +++++++++++-
 4 files changed, 269 insertions(+), 35 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 11a411b76fe4..5976b086741d 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -129,6 +129,8 @@ static void ath11k_init_wmi_config_ipq8074(struct ath11k_base *ab,
 	config->peer_map_unmap_v2_support = 1;
 	config->twt_ap_pdev_count = 2;
 	config->twt_ap_sta_count = 1000;
+	config->ema_max_vap_cnt = 16;
+	config->ema_max_profile_period = 8;
 }
 
 static int ath11k_hw_mac_id_to_pdev_id_ipq8074(struct ath11k_hw_params *hw,
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 825470dafbb0..62778b34fdb6 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -742,9 +742,13 @@ void ath11k_mac_peer_cleanup_all(struct ath11k *ar)
 
 static int ath11k_monitor_vdev_up(struct ath11k *ar, int vdev_id)
 {
+	struct vdev_up_params params = {
+		.vdev_id = vdev_id,
+		.bssid = ar->mac_addr,
+	};
 	int ret = 0;
 
-	ret = ath11k_wmi_vdev_up(ar, vdev_id, 0, ar->mac_addr);
+	ret = ath11k_wmi_vdev_up(ar, &params);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to put up monitor vdev %i: %d\n",
 			    vdev_id, ret);
@@ -766,27 +770,17 @@ static int ath11k_mac_op_config(struct ieee80211_hw *hw, u32 changed)
 	return 0;
 }
 
-static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
+static int __ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif, struct sk_buff *bcn,
+				       struct ieee80211_mutable_offsets offs,
+				       int ema_idx, int ema_cnt)
 {
 	struct ath11k *ar = arvif->ar;
 	struct ath11k_base *ab = ar->ab;
-	struct ieee80211_hw *hw = ar->hw;
-	struct ieee80211_vif *vif = arvif->vif;
-	struct ieee80211_mutable_offsets offs = {};
-	struct sk_buff *bcn;
 	struct ieee80211_mgmt *mgmt;
+	u32 ema_param = 0;
 	u8 *ies;
 	int ret;
 
-	if (arvif->vdev_type != WMI_VDEV_TYPE_AP)
-		return 0;
-
-	bcn = ieee80211_beacon_get_template(hw, vif, &offs);
-	if (!bcn) {
-		ath11k_warn(ab, "failed to get beacon template from mac80211\n");
-		return -EPERM;
-	}
-
 	ies = bcn->data + ieee80211_get_hdrlen_from_skb(bcn);
 	ies += sizeof(mgmt->u.beacon);
 
@@ -798,9 +792,16 @@ static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
 				    ies, (skb_tail_pointer(bcn) - ies)))
 		arvif->wpaie_present = true;
 
-	ret = ath11k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn);
+	if (ema_cnt) {
+		ema_param = ema_cnt << WMI_BEACON_EMA_PARAM_PERIODICITY_SHIFT;
+		ema_param |= ema_idx << WMI_BEACON_EMA_PARAM_TMPL_IDX_SHIFT;
+		ema_param |= (!ema_idx ? 1 : 0) <<
+			     WMI_BEACON_EMA_PARAM_FIRST_TMPL_SHIFT;
+		ema_param |= (ema_idx + 1 == ema_cnt ? 1 : 0) <<
+			     WMI_BEACON_EMA_PARAM_LAST_TMPL_SHIFT;
+	}
 
-	kfree_skb(bcn);
+	ret = ath11k_wmi_bcn_tmpl(ar, arvif->vdev_id, &offs, bcn, ema_param);
 
 	if (ret)
 		ath11k_warn(ab, "failed to submit beacon template command: %d\n",
@@ -809,6 +810,69 @@ static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
 	return ret;
 }
 
+static int ath11k_mac_setup_bcn_tmpl_ema(struct ath11k_vif *arvif)
+{
+	struct ath11k *ar = arvif->ar;
+	struct ieee80211_vif *vif = arvif->vif;
+	struct ieee80211_ema_bcn_list *bcn;
+	struct ieee80211_hw *hw = ar->hw;
+	struct list_head bcns;
+	int cnt, idx = 0, ret = 0;
+
+	INIT_LIST_HEAD(&bcns);
+	cnt = ieee80211_beacon_get_template_ema_list(hw, vif, &bcns);
+	if (!cnt){
+		ath11k_warn(ar->ab, "failed to get ema beacon template from mac80211\n");
+		return -EPERM;
+	}
+
+	list_for_each_entry(bcn, &bcns, list) {
+		ret = __ath11k_mac_setup_bcn_tmpl(arvif, bcn->skb, bcn->offs, idx++, cnt);
+		if (ret)
+			break;
+	}
+
+	ieee80211_beacon_free_ema_list(&bcns);
+
+	return ret;
+}
+
+static int ath11k_mac_setup_bcn_tmpl_legacy(struct ath11k_vif *arvif)
+{
+	struct ath11k *ar = arvif->ar;
+	struct ieee80211_mutable_offsets offs = {};
+	struct ieee80211_vif *vif = arvif->vif;
+	struct ieee80211_hw *hw = ar->hw;
+	struct sk_buff *bcn;
+	int ret;
+
+	bcn = ieee80211_beacon_get_template(hw, vif, &offs);
+	if (!bcn) {
+		ath11k_warn(ar->ab, "failed to get beacon template from mac80211\n");
+		return -EPERM;
+	}
+
+	ret = __ath11k_mac_setup_bcn_tmpl(arvif, bcn, offs, 0, 0);
+
+	kfree_skb(bcn);
+
+	return ret;
+}
+
+static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
+{
+	if (arvif->vdev_type != WMI_VDEV_TYPE_AP)
+		return 0;
+
+	if (arvif->vif->multiple_bssid.flags & IEEE80211_VIF_MBSS_NON_TRANSMITTING)
+		return 0;
+
+	if (arvif->vif->multiple_bssid.flags & IEEE80211_VIF_MBSS_EMA_BEACON)
+		return ath11k_mac_setup_bcn_tmpl_ema(arvif);
+
+	return ath11k_mac_setup_bcn_tmpl_legacy(arvif);
+}
+
 void ath11k_mac_bcn_tx_event(struct ath11k_vif *arvif)
 {
 	struct ieee80211_vif *vif = arvif->vif;
@@ -829,6 +893,12 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 				     struct ieee80211_bss_conf *info)
 {
 	struct ath11k *ar = arvif->ar;
+	struct vdev_up_params params = {
+		.vdev_id = arvif->vdev_id,
+		.bssid = arvif->bssid,
+		.profile_num = info->multiple_bssid.count,
+		.profile_idx = info->multiple_bssid.index,
+	};
 	int ret = 0;
 
 	lockdep_assert_held(&arvif->ar->conf_mutex);
@@ -856,9 +926,15 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 	arvif->aid = 0;
 
 	ether_addr_copy(arvif->bssid, info->bssid);
+	if (arvif->vif->multiple_bssid.flags & IEEE80211_VIF_MBSS_NON_TRANSMITTING) {
+		struct ath11k_vif *pvif;
+
+		pvif = (struct ath11k_vif *)arvif->vif->multiple_bssid.parent->drv_priv;
 
-	ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
-				 arvif->bssid);
+		params.trans_bssid = pvif->bssid;
+	}
+
+	ret = ath11k_wmi_vdev_up(arvif->ar, &params);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to bring up vdev %d: %i\n",
 			    arvif->vdev_id, ret);
@@ -1706,6 +1782,11 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 	struct ath11k *ar = hw->priv;
 	struct ath11k_vif *arvif = (void *)vif->drv_priv;
 	struct peer_assoc_params peer_arg;
+	struct vdev_up_params params = {
+		.vdev_id = arvif->vdev_id,
+		.bssid = bss_conf->bssid,
+		.aid = bss_conf->aid,
+	};
 	struct ieee80211_sta *ap_sta;
 	int ret;
 
@@ -1754,7 +1835,7 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 	arvif->aid = bss_conf->aid;
 	ether_addr_copy(arvif->bssid, bss_conf->bssid);
 
-	ret = ath11k_wmi_vdev_up(ar, arvif->vdev_id, arvif->aid, arvif->bssid);
+	ret = ath11k_wmi_vdev_up(ar, &params);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to set vdev %d up: %d\n",
 			    arvif->vdev_id, ret);
@@ -2107,7 +2188,8 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 			ret = ath11k_wmi_send_obss_color_collision_cfg_cmd(
 				ar, arvif->vdev_id, info->he_bss_color.color,
 				ATH11K_BSS_COLOR_COLLISION_DETECTION_AP_PERIOD_MS,
-				info->he_bss_color.enabled);
+				(arvif->vif->multiple_bssid.flags & IEEE80211_VIF_MBSS_NON_TRANSMITTING) ?
+					0 : info->he_bss_color.enabled);
 			if (ret)
 				ath11k_warn(ar->ab, "failed to set bss color collision on vdev %i: %d\n",
 					    arvif->vdev_id,  ret);
@@ -4295,17 +4377,35 @@ static void ath11k_mac_op_stop(struct ieee80211_hw *hw)
 	atomic_set(&ar->num_pending_mgmt_tx, 0);
 }
 
-static void
+static int
 ath11k_mac_setup_vdev_create_params(struct ath11k_vif *arvif,
 				    struct vdev_create_params *params)
 {
 	struct ath11k *ar = arvif->ar;
+	struct ieee80211_vif *parent;
 	struct ath11k_pdev *pdev = ar->pdev;
 
 	params->if_id = arvif->vdev_id;
 	params->type = arvif->vdev_type;
 	params->subtype = arvif->vdev_subtype;
 	params->pdev_id = pdev->pdev_id;
+	params->vdevid_trans = 0;
+	if (arvif->vif->multiple_bssid.flags & IEEE80211_VIF_MBSS_NON_TRANSMITTING) {
+		params->flags = WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP;
+		parent = arvif->vif->multiple_bssid.parent;
+		if (!parent)
+			return -ENOENT;
+		if (ar->hw->wiphy != ieee80211_vif_to_wdev(parent)->wiphy)
+			return -EINVAL;
+		params->vdevid_trans = ath11k_vif_to_arvif(parent)->vdev_id;
+	} else if (arvif->vif->multiple_bssid.flags & IEEE80211_VIF_MBSS_TRANSMITTING) {
+		params->flags = WMI_HOST_VDEV_FLAGS_TRANSMIT_AP;
+	} else {
+		params->flags = WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP;
+	}
+
+	if (arvif->vif->multiple_bssid.flags & IEEE80211_VIF_MBSS_EMA_BEACON)
+		params->flags |= WMI_HOST_VDEV_FLAGS_EMA_MODE;
 
 	if (pdev->cap.supported_bands & WMI_HOST_WLAN_2G_CAP) {
 		params->chains[NL80211_BAND_2GHZ].tx = ar->num_tx_chains;
@@ -4320,6 +4420,7 @@ ath11k_mac_setup_vdev_create_params(struct ath11k_vif *arvif,
 		params->chains[NL80211_BAND_6GHZ].tx = ar->num_tx_chains;
 		params->chains[NL80211_BAND_6GHZ].rx = ar->num_rx_chains;
 	}
+	return 0;
 }
 
 static u32
@@ -4499,7 +4600,11 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 	for (i = 0; i < ARRAY_SIZE(vif->hw_queue); i++)
 		vif->hw_queue[i] = i % (ATH11K_HW_MAX_QUEUES - 1);
 
-	ath11k_mac_setup_vdev_create_params(arvif, &vdev_param);
+	ret = ath11k_mac_setup_vdev_create_params(arvif, &vdev_param);
+	if (ret) {
+		ath11k_warn(ab, "failed to prepare vdev %d\n", ret);
+		goto err;
+	}
 
 	ret = ath11k_wmi_vdev_create(ar, vif->addr, &vdev_param);
 	if (ret) {
@@ -4929,6 +5034,25 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
 		   arg.vdev_id, arg.channel.freq,
 		   ath11k_wmi_phymode_str(arg.channel.mode));
 
+	if (arvif->vif->multiple_bssid.flags & IEEE80211_VIF_MBSS_NON_TRANSMITTING) {
+		struct ieee80211_vif *parent;
+
+		arg.mbss_capability_flags = WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP;
+		parent = arvif->vif->multiple_bssid.parent;
+		if (!parent)
+			return -ENOENT;
+		if (ar->hw->wiphy != ieee80211_vif_to_wdev(parent)->wiphy)
+			return -EINVAL;
+		arg.vdevid_trans = ath11k_vif_to_arvif(parent)->vdev_id;
+	} else if (arvif->vif->multiple_bssid.flags & IEEE80211_VIF_MBSS_TRANSMITTING) {
+		arg.mbss_capability_flags = WMI_HOST_VDEV_FLAGS_TRANSMIT_AP;
+	} else {
+		arg.mbss_capability_flags = WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP;
+	}
+
+	if (arvif->vif->multiple_bssid.flags & IEEE80211_VIF_MBSS_EMA_BEACON)
+		arg.mbss_capability_flags |= WMI_HOST_VDEV_FLAGS_EMA_MODE;
+
 	ret = ath11k_wmi_vdev_start(ar, &arg, restart);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to %s WMI vdev %i\n",
@@ -5117,6 +5241,8 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 	/* TODO: Update ar->rx_channel */
 
 	for (i = 0; i < n_vifs; i++) {
+		struct vdev_up_params params;
+
 		arvif = (void *)vifs[i].vif->drv_priv;
 
 		if (WARN_ON(!arvif->is_started))
@@ -5137,8 +5263,10 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 			continue;
 		}
 
-		ret = ath11k_wmi_vdev_up(arvif->ar, arvif->vdev_id, arvif->aid,
-					 arvif->bssid);
+		params.vdev_id = arvif->vdev_id,
+		params.bssid = arvif->bssid,
+		params.aid = arvif->aid,
+		ret = ath11k_wmi_vdev_up(arvif->ar, &params);
 		if (ret) {
 			ath11k_warn(ab, "failed to bring vdev up %d: %d\n",
 				    arvif->vdev_id, ret);
@@ -6109,19 +6237,23 @@ static int ath11k_mac_setup_iface_combinations(struct ath11k *ar)
 
 static const u8 ath11k_if_types_ext_capa[] = {
 	[0] = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
+	[2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT,
 	[7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
 };
 
 static const u8 ath11k_if_types_ext_capa_sta[] = {
 	[0] = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
+	[2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT,
 	[7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
 	[9] = WLAN_EXT_CAPA10_TWT_REQUESTER_SUPPORT,
 };
 
 static const u8 ath11k_if_types_ext_capa_ap[] = {
 	[0] = WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING,
+	[2] = WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT,
 	[7] = WLAN_EXT_CAPA8_OPMODE_NOTIF,
 	[9] = WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT,
+	[10] = WLAN_EXT_CAPA11_EMA_SUPPORT,
 };
 
 static const struct wiphy_iftype_ext_capab ath11k_iftypes_ext_capa[] = {
@@ -6238,6 +6370,8 @@ static int __ath11k_mac_register(struct ath11k *ar)
 	ieee80211_hw_set(ar->hw, SUPPORTS_TX_FRAG);
 	ieee80211_hw_set(ar->hw, REPORTS_LOW_ACK);
 	ieee80211_hw_set(ar->hw, SUPPORTS_TX_ENCAP_OFFLOAD);
+	ieee80211_hw_set(ar->hw, SUPPORTS_MULTI_BSSID);
+	ieee80211_hw_set(ar->hw, SUPPORTS_MULTI_BSSID_AP);
 	if (ht_cap & WMI_HT_CAP_ENABLED) {
 		ieee80211_hw_set(ar->hw, AMPDU_AGGREGATION);
 		ieee80211_hw_set(ar->hw, TX_AMPDU_SETUP_IN_HW);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index b9932b018b7d..22025af6d287 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -647,6 +647,7 @@ int ath11k_wmi_vdev_create(struct ath11k *ar, u8 *macaddr,
 	cmd->vdev_subtype = param->subtype;
 	cmd->num_cfg_txrx_streams = WMI_NUM_SUPPORTED_BAND_MAX;
 	cmd->pdev_id = param->pdev_id;
+
 	ether_addr_copy(cmd->vdev_macaddr.addr, macaddr);
 
 	ptr = skb->data + sizeof(*cmd);
@@ -861,6 +862,12 @@ int ath11k_wmi_vdev_start(struct ath11k *ar, struct wmi_vdev_start_req_arg *arg,
 			cmd->flags |= WMI_VDEV_START_HIDDEN_SSID;
 		if (arg->pmf_enabled)
 			cmd->flags |= WMI_VDEV_START_PMF_ENABLED;
+
+		if (test_bit(WMI_TLV_SERVICE_MBSS_PARAM_IN_VDEV_START_SUPPORT,
+			     ar->ab->wmi_ab.svc_map)) {
+			cmd->mbss_capability_flags = arg->mbss_capability_flags;
+			cmd->vdevid_trans = arg->vdevid_trans;
+		}
 	}
 
 	cmd->flags |= WMI_VDEV_START_LDPC_RX_ENABLED;
@@ -904,7 +911,7 @@ int ath11k_wmi_vdev_start(struct ath11k *ar, struct wmi_vdev_start_req_arg *arg,
 	return ret;
 }
 
-int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
+int ath11k_wmi_vdev_up(struct ath11k *ar, struct vdev_up_params *params)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
 	struct wmi_vdev_up_cmd *cmd;
@@ -919,10 +926,14 @@ int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
 
 	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_VDEV_UP_CMD) |
 			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
-	cmd->vdev_id = vdev_id;
-	cmd->vdev_assoc_id = aid;
+	cmd->vdev_id = params->vdev_id;
+	cmd->vdev_assoc_id = params->aid;
+	cmd->profile_idx = params->profile_idx;
+	cmd->profile_num = params->profile_num;
 
-	ether_addr_copy(cmd->vdev_bssid.addr, bssid);
+	if (params->trans_bssid)
+		ether_addr_copy(cmd->trans_bssid.addr, params->trans_bssid);
+	ether_addr_copy(cmd->vdev_bssid.addr, params->bssid);
 
 	ret = ath11k_wmi_cmd_send(wmi, skb, WMI_VDEV_UP_CMDID);
 	if (ret) {
@@ -931,8 +942,9 @@ int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid, const u8 *bssid)
 	}
 
 	ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
-		   "WMI mgmt vdev up id 0x%x assoc id %d bssid %pM\n",
-		   vdev_id, aid, bssid);
+		   "WMI mgmt vdev up id 0x%x assoc id %d idx %d num %d bssid %pM trans_bssid %pM\n",
+		   params->vdev_id, params->aid, params->profile_idx, params->profile_num,
+		   params->bssid, params->trans_bssid);
 
 	return ret;
 }
@@ -1579,7 +1591,7 @@ int ath11k_wmi_send_bcn_offload_control_cmd(struct ath11k *ar,
 
 int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 			struct ieee80211_mutable_offsets *offs,
-			struct sk_buff *bcn)
+			struct sk_buff *bcn, u32 ema_params)
 {
 	struct ath11k_pdev_wmi *wmi = ar->wmi;
 	struct wmi_bcn_tmpl_cmd *cmd;
@@ -1604,6 +1616,8 @@ int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 	cmd->csa_switch_count_offset = offs->cntdwn_counter_offs[0];
 	cmd->ext_csa_switch_count_offset = offs->cntdwn_counter_offs[1];
 	cmd->buf_len = bcn->len;
+	cmd->mbssid_ie_offset = offs->multiple_bssid_offset;
+	cmd->ema_params = ema_params;
 
 	ptr = skb->data + sizeof(*cmd);
 
@@ -3203,6 +3217,8 @@ ath11k_wmi_copy_resource_config(struct wmi_resource_config *wmi_cfg,
 	wmi_cfg->sched_params = tg_cfg->sched_params;
 	wmi_cfg->twt_ap_pdev_count = tg_cfg->twt_ap_pdev_count;
 	wmi_cfg->twt_ap_sta_count = tg_cfg->twt_ap_sta_count;
+	wmi_cfg->ema_max_vap_cnt = tg_cfg->ema_max_vap_cnt;
+	wmi_cfg->ema_max_profile_period = tg_cfg->ema_max_profile_period;
 }
 
 static int ath11k_init_cmd_send(struct ath11k_pdev_wmi *wmi,
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 4f7078369b3c..27a46e4b9b9e 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -119,6 +119,14 @@ enum {
 	WMI_HOST_WLAN_2G_5G_CAP	= 0x3,
 };
 
+enum {
+	WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP	= 0x00000001,
+	WMI_HOST_VDEV_FLAGS_TRANSMIT_AP		= 0x00000002,
+	WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP	= 0x00000004,
+	WMI_HOST_VDEV_FLAGS_EMA_MODE            = 0x00000008,
+	WMI_HOST_VDEV_FLAGS_SCAN_MODE_VAP       = 0x00000010,
+};
+
 /*
  * wmi command groups.
  */
@@ -2034,6 +2042,40 @@ enum wmi_tlv_service {
 	WMI_TLV_SERVICE_PER_PEER_HTT_STATS_RESET = 213,
 	WMI_TLV_SERVICE_FREQINFO_IN_METADATA = 219,
 	WMI_TLV_SERVICE_EXT2_MSG = 220,
+	WMI_TLV_SERVICE_WPA3_SAE_ROAM_SUPPORT = 221,
+	WMI_TLV_SERVICE_WPA3_OWE_ROAM_SUPPORT = 222,
+	WMI_TLV_SERVICE_AUDIO_AGGR = 223,
+	WMI_TLV_SERVICE_6GHZ_SUPPORT = 224,
+	WMI_TLV_SERVICE_QMI_STATS_SUPPORT = 225,
+	WMI_TLV_SERVICE_CFR_CAPTURE_FILTER_SUPPORT = 226,
+	WMI_TLV_SERVICE_STA_BSS_MAX_IDLE_TIME = 227,
+	WMI_TLV_SERVICE_BIP_CIPHER_SUPPORT = 228,
+	WMI_TLV_SERVICE_BW_165MHZ_SUPPORT = 229,
+	WMI_TLV_SERVICE_BW_RESTRICTED_80P80_SUPPORT = WMI_TLV_SERVICE_BW_165MHZ_SUPPORT,
+	WMI_TLV_SERVICE_NAN_NDI_SAP_SAP_SCC_SUPPORT = 230,
+	WMI_TLV_SERVICE_NAN_VDEV_SUPPORT = 231,
+	WMI_TLV_SERVICE_AUDIO_SYNC_SUPPORT = 232,
+	WMI_TLV_SERVICE_DUAL_STA_ROAM_SUPPORT = 233,
+	WMI_TLV_SERVICE_PEER_CREATE_CONF = 234,
+	WMI_TLV_SERVICE_MULTIPLE_VDEV_RESTART_RESPONSE_SUPPORT = 235,
+	WMI_TLV_SERVICE_ROAM_SCAN_CHANNEL_LIST_TO_HOST_SUPPORT = 236,
+	WMI_TLV_SERVICE_PEER_DELETE_NO_PEER_FLUSH_TIDS_CMD = 237,
+	WMI_TLV_SERVICE_NSS_RATIO_TO_HOST_SUPPORT = 238,
+	WMI_TLV_SERVICE_WPA3_SUITEB_ROAM_SUPPORT = 239,
+	WMI_TLV_SERVICE_PERIODIC_FRAME_INJECT_SUPPORT = 240,
+	WMI_TLV_SERVICE_NDI_NDI_STA_SUPPORT = 241,
+	WMI_TLV_SERVICE_BW_TRUE_160_SUPPORT = 242,
+	WMI_TLV_SERVICE_HOST_SCAN_STOP_VDEV_ALL_SUPPORT = 243,
+	WMI_TLV_SERVICE_BEACON_PROTECTION_SUPPORT = 244,
+	WMI_TLV_SERVICE_EMA_AP_SUPPORT = 245,
+	WMI_TLV_SERVICE_PEER_POWER_SAVE_DURATION_SUPPORT = 246,
+	WMI_TLV_SERVICE_5_DOT_9GHZ_SUPPORT = 247,
+	WMI_TLV_SERVICE_MU_PREAMBLE_PUNCTURE_SUPPORT = 248,
+	WMI_TLV_SERVICE_SRG_SRP_SPATIAL_REUSE_SUPPORT = 249,
+	WMI_TLV_REQUEST_CTRL_PATH_STATS_REQUEST = 250,
+	WMI_TLV_SERVICE_TPC_STATS_EVENT = 251,
+	WMI_TLV_SERVICE_NO_INTERBAND_MCC_SUPPORT = 252,
+	WMI_TLV_SERVICE_MBSS_PARAM_IN_VDEV_START_SUPPORT = 253,
 
 	WMI_MAX_EXT_SERVICE
 };
@@ -2279,6 +2321,18 @@ struct wmi_resource_config {
 	u32 sched_params;
 	u32 twt_ap_pdev_count;
 	u32 twt_ap_sta_count;
+	u32 max_nlo_ssids;
+	u32 num_pkt_filters;
+	u32 num_max_sta_vdevs;
+	u32 max_bssid_indicator;
+	u32 ul_resp_config;
+	u32 msdu_flow_override_config0;
+	u32 msdu_flow_override_config1;
+	u32 flags2;
+	u32 host_service_flags;
+	u32 max_rnr_neighbours;
+	u32 ema_max_vap_cnt;
+	u32 ema_max_profile_period;
 } __packed;
 
 struct wmi_service_ready_event {
@@ -2456,6 +2510,8 @@ struct vdev_create_params {
 		u8 rx;
 	} chains[NUM_NL80211_BANDS];
 	u32 pdev_id;
+	u32 flags;
+	u32 vdevid_trans;
 };
 
 struct wmi_vdev_create_cmd {
@@ -2480,6 +2536,15 @@ struct wmi_vdev_delete_cmd {
 	u32 vdev_id;
 } __packed;
 
+struct vdev_up_params {
+	u32 vdev_id;
+	u16 aid;
+	u32 profile_idx;
+	u32 profile_num;
+	const u8 *bssid;
+	u8 *trans_bssid;
+};
+
 struct wmi_vdev_up_cmd {
 	u32 tlv_header;
 	u32 vdev_id;
@@ -2528,6 +2593,9 @@ struct wmi_vdev_start_request_cmd {
 	u32 he_ops;
 	u32 cac_duration_ms;
 	u32 regdomain;
+	u32 min_data_rate;
+	u32 mbss_capability_flags;
+	u32 vdevid_trans;
 } __packed;
 
 #define MGMT_TX_DL_FRM_LEN		     64
@@ -2697,6 +2765,9 @@ struct wmi_vdev_start_req_arg {
 	u32 pref_rx_streams;
 	u32 pref_tx_streams;
 	u32 num_noa_descriptors;
+	u32 min_data_rate;
+	u32 mbss_capability_flags;
+	u32 vdevid_trans;
 };
 
 struct peer_create_params {
@@ -3414,6 +3485,11 @@ struct wmi_get_pdev_temperature_cmd {
 
 #define WMI_BEACON_TX_BUFFER_SIZE	512
 
+#define WMI_BEACON_EMA_PARAM_PERIODICITY_SHIFT		0
+#define WMI_BEACON_EMA_PARAM_TMPL_IDX_SHIFT		8
+#define WMI_BEACON_EMA_PARAM_FIRST_TMPL_SHIFT		16
+#define WMI_BEACON_EMA_PARAM_LAST_TMPL_SHIFT		24
+
 struct wmi_bcn_tmpl_cmd {
 	u32 tlv_header;
 	u32 vdev_id;
@@ -3424,6 +3500,11 @@ struct wmi_bcn_tmpl_cmd {
 	u32 csa_event_bitmap;
 	u32 mbssid_ie_offset;
 	u32 esp_ie_offset;
+	u32 csc_switch_count_offset;
+	u32 csc_event_bitmap;
+	u32 mu_edca_ie_offset;
+	u32 feature_enable_bitmap;
+	u32 ema_params;
 } __packed;
 
 struct wmi_key_seq_counter {
@@ -4984,6 +5065,8 @@ struct target_resource_config {
 	u32 sched_params;
 	u32 twt_ap_pdev_count;
 	u32 twt_ap_sta_count;
+	u32 ema_max_vap_cnt;
+	u32 ema_max_profile_period;
 };
 
 #define WMI_MAX_MEM_REQS 32
@@ -5021,10 +5104,9 @@ int ath11k_wmi_mgmt_send(struct ath11k *ar, u32 vdev_id, u32 buf_id,
 			 struct sk_buff *frame);
 int ath11k_wmi_bcn_tmpl(struct ath11k *ar, u32 vdev_id,
 			struct ieee80211_mutable_offsets *offs,
-			struct sk_buff *bcn);
+			struct sk_buff *bcn, u32 ema_param);
 int ath11k_wmi_vdev_down(struct ath11k *ar, u8 vdev_id);
-int ath11k_wmi_vdev_up(struct ath11k *ar, u32 vdev_id, u32 aid,
-		       const u8 *bssid);
+int ath11k_wmi_vdev_up(struct ath11k *ar, struct vdev_up_params *params);
 int ath11k_wmi_vdev_stop(struct ath11k *ar, u8 vdev_id);
 int ath11k_wmi_vdev_start(struct ath11k *ar, struct wmi_vdev_start_req_arg *arg,
 			  bool restart);
-- 
2.25.1

