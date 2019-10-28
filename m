Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49452E70CC
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Oct 2019 12:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388702AbfJ1Lwz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Oct 2019 07:52:55 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:40212 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727585AbfJ1Lwz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Oct 2019 07:52:55 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iP3Zq-0002na-JD; Mon, 28 Oct 2019 12:52:50 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] mac80211: don't re-parse elems in ieee80211_assoc_success()
Date:   Mon, 28 Oct 2019 12:52:42 +0100
Message-Id: <20191028125240.cb7661671bd2.I757c8752bf4f2f35e54f5e0a2c0a9cd9216c3d8b@changeid>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We've already parsed the same data in the caller, so we can
pass it. The only thing is that we might fill in more details
in ieee80211_assoc_success(), but that doesn't bother the
caller, so it's fine to do even when we share the parsed data.

This reduces the stack space usage of the call stack here,
Arnd reported it had grown above the 1024 byte warning limit.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 103 +++++++++++++++++++++-----------------------
 1 file changed, 49 insertions(+), 54 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 54dd8849d1cc..5fa13176036f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3186,15 +3186,14 @@ static int ieee80211_recalc_twt_req(struct ieee80211_sub_if_data *sdata,
 
 static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 				    struct cfg80211_bss *cbss,
-				    struct ieee80211_mgmt *mgmt, size_t len)
+				    struct ieee80211_mgmt *mgmt, size_t len,
+				    struct ieee802_11_elems *elems)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_supported_band *sband;
 	struct sta_info *sta;
-	u8 *pos;
 	u16 capab_info, aid;
-	struct ieee802_11_elems elems;
 	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
 	const struct cfg80211_bss_ies *bss_ies = NULL;
 	struct ieee80211_mgd_assoc_data *assoc_data = ifmgd->assoc_data;
@@ -3222,19 +3221,15 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		ifmgd->broken_ap = true;
 	}
 
-	pos = mgmt->u.assoc_resp.variable;
-	ieee802_11_parse_elems(pos, len - (pos - (u8 *)mgmt), false, &elems,
-			       mgmt->bssid, assoc_data->bss->bssid);
-
-	if (!elems.supp_rates) {
+	if (!elems->supp_rates) {
 		sdata_info(sdata, "no SuppRates element in AssocResp\n");
 		return false;
 	}
 
 	ifmgd->aid = aid;
 	ifmgd->tdls_chan_switch_prohibited =
-		elems.ext_capab && elems.ext_capab_len >= 5 &&
-		(elems.ext_capab[4] & WLAN_EXT_CAPA5_TDLS_CH_SW_PROHIBITED);
+		elems->ext_capab && elems->ext_capab_len >= 5 &&
+		(elems->ext_capab[4] & WLAN_EXT_CAPA5_TDLS_CH_SW_PROHIBITED);
 
 	/*
 	 * Some APs are erroneously not including some information in their
@@ -3243,11 +3238,11 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	 * 2G/3G/4G wifi routers, reported models include the "Onda PN51T",
 	 * "Vodafone PocketWiFi 2", "ZTE MF60" and a similar T-Mobile device.
 	 */
-	if ((assoc_data->wmm && !elems.wmm_param) ||
+	if ((assoc_data->wmm && !elems->wmm_param) ||
 	    (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT) &&
-	     (!elems.ht_cap_elem || !elems.ht_operation)) ||
+	     (!elems->ht_cap_elem || !elems->ht_operation)) ||
 	    (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT) &&
-	     (!elems.vht_cap_elem || !elems.vht_operation))) {
+	     (!elems->vht_cap_elem || !elems->vht_operation))) {
 		const struct cfg80211_bss_ies *ies;
 		struct ieee802_11_elems bss_elems;
 
@@ -3265,8 +3260,8 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 				       mgmt->bssid,
 				       assoc_data->bss->bssid);
 		if (assoc_data->wmm &&
-		    !elems.wmm_param && bss_elems.wmm_param) {
-			elems.wmm_param = bss_elems.wmm_param;
+		    !elems->wmm_param && bss_elems.wmm_param) {
+			elems->wmm_param = bss_elems.wmm_param;
 			sdata_info(sdata,
 				   "AP bug: WMM param missing from AssocResp\n");
 		}
@@ -3275,27 +3270,27 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		 * Also check if we requested HT/VHT, otherwise the AP doesn't
 		 * have to include the IEs in the (re)association response.
 		 */
-		if (!elems.ht_cap_elem && bss_elems.ht_cap_elem &&
+		if (!elems->ht_cap_elem && bss_elems.ht_cap_elem &&
 		    !(ifmgd->flags & IEEE80211_STA_DISABLE_HT)) {
-			elems.ht_cap_elem = bss_elems.ht_cap_elem;
+			elems->ht_cap_elem = bss_elems.ht_cap_elem;
 			sdata_info(sdata,
 				   "AP bug: HT capability missing from AssocResp\n");
 		}
-		if (!elems.ht_operation && bss_elems.ht_operation &&
+		if (!elems->ht_operation && bss_elems.ht_operation &&
 		    !(ifmgd->flags & IEEE80211_STA_DISABLE_HT)) {
-			elems.ht_operation = bss_elems.ht_operation;
+			elems->ht_operation = bss_elems.ht_operation;
 			sdata_info(sdata,
 				   "AP bug: HT operation missing from AssocResp\n");
 		}
-		if (!elems.vht_cap_elem && bss_elems.vht_cap_elem &&
+		if (!elems->vht_cap_elem && bss_elems.vht_cap_elem &&
 		    !(ifmgd->flags & IEEE80211_STA_DISABLE_VHT)) {
-			elems.vht_cap_elem = bss_elems.vht_cap_elem;
+			elems->vht_cap_elem = bss_elems.vht_cap_elem;
 			sdata_info(sdata,
 				   "AP bug: VHT capa missing from AssocResp\n");
 		}
-		if (!elems.vht_operation && bss_elems.vht_operation &&
+		if (!elems->vht_operation && bss_elems.vht_operation &&
 		    !(ifmgd->flags & IEEE80211_STA_DISABLE_VHT)) {
-			elems.vht_operation = bss_elems.vht_operation;
+			elems->vht_operation = bss_elems.vht_operation;
 			sdata_info(sdata,
 				   "AP bug: VHT operation missing from AssocResp\n");
 		}
@@ -3306,7 +3301,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	 * they should be present here. This is just a safety net.
 	 */
 	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT) &&
-	    (!elems.wmm_param || !elems.ht_cap_elem || !elems.ht_operation)) {
+	    (!elems->wmm_param || !elems->ht_cap_elem || !elems->ht_operation)) {
 		sdata_info(sdata,
 			   "HT AP is missing WMM params or HT capability/operation\n");
 		ret = false;
@@ -3314,7 +3309,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT) &&
-	    (!elems.vht_cap_elem || !elems.vht_operation)) {
+	    (!elems->vht_cap_elem || !elems->vht_operation)) {
 		sdata_info(sdata,
 			   "VHT AP is missing VHT capability/operation\n");
 		ret = false;
@@ -3341,7 +3336,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE) &&
-	    (!elems.he_cap || !elems.he_operation)) {
+	    (!elems->he_cap || !elems->he_operation)) {
 		mutex_unlock(&sdata->local->sta_mtx);
 		sdata_info(sdata,
 			   "HE AP is missing HE capability/operation\n");
@@ -3350,23 +3345,23 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	}
 
 	/* Set up internal HT/VHT capabilities */
-	if (elems.ht_cap_elem && !(ifmgd->flags & IEEE80211_STA_DISABLE_HT))
+	if (elems->ht_cap_elem && !(ifmgd->flags & IEEE80211_STA_DISABLE_HT))
 		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
-						  elems.ht_cap_elem, sta);
+						  elems->ht_cap_elem, sta);
 
-	if (elems.vht_cap_elem && !(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
+	if (elems->vht_cap_elem && !(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
 		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
-						    elems.vht_cap_elem, sta);
+						    elems->vht_cap_elem, sta);
 
-	if (elems.he_operation && !(ifmgd->flags & IEEE80211_STA_DISABLE_HE) &&
-	    elems.he_cap) {
+	if (elems->he_operation && !(ifmgd->flags & IEEE80211_STA_DISABLE_HE) &&
+	    elems->he_cap) {
 		ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband,
-						  elems.he_cap,
-						  elems.he_cap_len,
+						  elems->he_cap,
+						  elems->he_cap_len,
 						  sta);
 
 		bss_conf->he_support = sta->sta.he_cap.has_he;
-		changed |= ieee80211_recalc_twt_req(sdata, sta, &elems);
+		changed |= ieee80211_recalc_twt_req(sdata, sta, elems);
 	} else {
 		bss_conf->he_support = false;
 		bss_conf->twt_requester = false;
@@ -3374,14 +3369,14 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 
 	if (bss_conf->he_support) {
 		bss_conf->bss_color =
-			le32_get_bits(elems.he_operation->he_oper_params,
+			le32_get_bits(elems->he_operation->he_oper_params,
 				      IEEE80211_HE_OPERATION_BSS_COLOR_MASK);
 
 		bss_conf->htc_trig_based_pkt_ext =
-			le32_get_bits(elems.he_operation->he_oper_params,
+			le32_get_bits(elems->he_operation->he_oper_params,
 			      IEEE80211_HE_OPERATION_DFLT_PE_DURATION_MASK);
 		bss_conf->frame_time_rts_th =
-			le32_get_bits(elems.he_operation->he_oper_params,
+			le32_get_bits(elems->he_operation->he_oper_params,
 			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
 
 		bss_conf->multi_sta_back_32bit =
@@ -3392,12 +3387,12 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 			sta->sta.he_cap.he_cap_elem.mac_cap_info[2] &
 			IEEE80211_HE_MAC_CAP2_ACK_EN;
 
-		bss_conf->uora_exists = !!elems.uora_element;
-		if (elems.uora_element)
-			bss_conf->uora_ocw_range = elems.uora_element[0];
+		bss_conf->uora_exists = !!elems->uora_element;
+		if (elems->uora_element)
+			bss_conf->uora_ocw_range = elems->uora_element[0];
 
-		ieee80211_he_op_ie_to_bss_conf(&sdata->vif, elems.he_operation);
-		ieee80211_he_spr_ie_to_bss_conf(&sdata->vif, elems.he_spr);
+		ieee80211_he_op_ie_to_bss_conf(&sdata->vif, elems->he_operation);
+		ieee80211_he_spr_ie_to_bss_conf(&sdata->vif, elems->he_spr);
 		/* TODO: OPEN: what happens if BSS color disable is set? */
 	}
 
@@ -3421,11 +3416,11 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	 * NSS calculation (that would be done in rate_control_rate_init())
 	 * and use the # of streams from that element.
 	 */
-	if (elems.opmode_notif &&
-	    !(*elems.opmode_notif & IEEE80211_OPMODE_NOTIF_RX_NSS_TYPE_BF)) {
+	if (elems->opmode_notif &&
+	    !(*elems->opmode_notif & IEEE80211_OPMODE_NOTIF_RX_NSS_TYPE_BF)) {
 		u8 nss;
 
-		nss = *elems.opmode_notif & IEEE80211_OPMODE_NOTIF_RX_NSS_MASK;
+		nss = *elems->opmode_notif & IEEE80211_OPMODE_NOTIF_RX_NSS_MASK;
 		nss >>= IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
 		nss += 1;
 		sta->sta.rx_nss = nss;
@@ -3440,7 +3435,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		sta->sta.mfp = false;
 	}
 
-	sta->sta.wme = elems.wmm_param && local->hw.queues >= IEEE80211_NUM_ACS;
+	sta->sta.wme = elems->wmm_param && local->hw.queues >= IEEE80211_NUM_ACS;
 
 	err = sta_info_move_state(sta, IEEE80211_STA_ASSOC);
 	if (!err && !(ifmgd->flags & IEEE80211_STA_CONTROL_PORT))
@@ -3468,9 +3463,9 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 
 	if (ifmgd->flags & IEEE80211_STA_DISABLE_WMM) {
 		ieee80211_set_wmm_default(sdata, false, false);
-	} else if (!ieee80211_sta_wmm_params(local, sdata, elems.wmm_param,
-					     elems.wmm_param_len,
-					     elems.mu_edca_param_set)) {
+	} else if (!ieee80211_sta_wmm_params(local, sdata, elems->wmm_param,
+					     elems->wmm_param_len,
+					     elems->mu_edca_param_set)) {
 		/* still enable QoS since we might have HT/VHT */
 		ieee80211_set_wmm_default(sdata, false, true);
 		/* set the disable-WMM flag in this case to disable
@@ -3484,11 +3479,11 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	}
 	changed |= BSS_CHANGED_QOS;
 
-	if (elems.max_idle_period_ie) {
+	if (elems->max_idle_period_ie) {
 		bss_conf->max_idle_period =
-			le16_to_cpu(elems.max_idle_period_ie->max_idle_period);
+			le16_to_cpu(elems->max_idle_period_ie->max_idle_period);
 		bss_conf->protected_keep_alive =
-			!!(elems.max_idle_period_ie->idle_options &
+			!!(elems->max_idle_period_ie->idle_options &
 			   WLAN_IDLE_OPTIONS_PROTECTED_KEEP_ALIVE);
 		changed |= BSS_CHANGED_KEEP_ALIVE;
 	} else {
@@ -3598,7 +3593,7 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		event.u.mlme.reason = status_code;
 		drv_event_callback(sdata->local, sdata, &event);
 	} else {
-		if (!ieee80211_assoc_success(sdata, bss, mgmt, len)) {
+		if (!ieee80211_assoc_success(sdata, bss, mgmt, len, &elems)) {
 			/* oops -- internal error -- send timeout for now */
 			ieee80211_destroy_assoc_data(sdata, false, false);
 			cfg80211_assoc_timeout(sdata->dev, bss);
-- 
2.20.1

