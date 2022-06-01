Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A545539E93
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jun 2022 09:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243392AbiFAHkd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jun 2022 03:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350080AbiFAHkJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jun 2022 03:40:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AC6996A3
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jun 2022 00:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=f8Ex8iitjYeVdYaNjwUB2r8BBeN6UiXtzoJvverhjP4=;
        t=1654069206; x=1655278806; b=K4ZMgSCYuN2tmF3M1ZJuwiJHFgusbMzF8VIRzdgkYR6jxZb
        OQzW08rdgt9mSQpqefmglJ78kcpanRanHXRWC0P7xzvm3LOiqhxNXgX7xD24lNdSPpxRXIVw+lShE
        qjMsjjFOKWpNvoLSYc5GdN868+FdxffxUGg+G4kaVbYGsaBbUDv8WikAmdTpAjv1pmXP2sRpNVVDk
        ojNiw2rdTMpFTp91eIQzh33xQHIVqA2QPmFLGizHEAZup/ZxbeJJyN4KNs9kOuidFHCjLDyCM4LuX
        2SEAewWhIMdjnsz1yb7JMX/iAjei/XGMtnz5IkH7fOzXCE0ULih3dYHkilL56ZXw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nwIxX-00AJPK-VS;
        Wed, 01 Jun 2022 09:40:04 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 10/15] mac80211: add link_id to vht.c code for MLO
Date:   Wed,  1 Jun 2022 09:39:53 +0200
Message-Id: <20220601093922.e9c894f624bd.Iff0e52fc8d7616a39120951eb39e117cd0f9f711@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220601073958.8345-1-johannes@sipsolutions.net>
References: <20220601073958.8345-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Update the code in vht.c and add the link_id parameter where
necessary.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 +-
 include/net/mac80211.h                        |   3 +-
 net/mac80211/cfg.c                            |   5 +-
 net/mac80211/ibss.c                           |   2 +-
 net/mac80211/ieee80211_i.h                    |  18 +--
 net/mac80211/iface.c                          |   6 +-
 net/mac80211/mesh_plink.c                     |   2 +-
 net/mac80211/mlme.c                           |   6 +-
 net/mac80211/rate.c                           |   2 +-
 net/mac80211/rx.c                             |   2 +-
 net/mac80211/tdls.c                           |   2 +-
 net/mac80211/vht.c                            | 122 +++++++++---------
 12 files changed, 92 insertions(+), 80 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5d3cedc146be..2539dc5aaa3f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1776,7 +1776,7 @@ static void iwl_mvm_mu_mimo_iface_iterator(void *_data, u8 *mac,
 		 * the data received from firmware as if it came from the
 		 * action frame, so no conversion is needed.
 		 */
-		ieee80211_update_mu_groups(vif,
+		ieee80211_update_mu_groups(vif, 0,
 					   (u8 *)&notif->membership_status,
 					   (u8 *)&notif->user_position);
 	}
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 66a18dc4462f..a3621900fbe4 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6548,6 +6548,7 @@ ieee80211_vif_type_p2p(struct ieee80211_vif *vif)
  * ieee80211_update_mu_groups - set the VHT MU-MIMO groud data
  *
  * @vif: the specified virtual interface
+ * @link_id: the link ID for MLO, otherwise 0
  * @membership: 64 bits array - a bit is set if station is member of the group
  * @position: 2 bits per group id indicating the position in the group
  *
@@ -6556,7 +6557,7 @@ ieee80211_vif_type_p2p(struct ieee80211_vif *vif)
  * matching GroupId management frame.
  * Calls to this function need to be serialized with RX path.
  */
-void ieee80211_update_mu_groups(struct ieee80211_vif *vif,
+void ieee80211_update_mu_groups(struct ieee80211_vif *vif, unsigned int link_id,
 				const u8 *membership, const u8 *position);
 
 void ieee80211_enable_rssi_reports(struct ieee80211_vif *vif,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e76565cb6292..27eb281f53b6 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1767,7 +1767,7 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	/* VHT can override some HT caps such as the A-MSDU max length */
 	if (params->vht_capa)
 		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
-						    params->vht_capa, sta);
+						    params->vht_capa, sta, 0);
 
 	if (params->he_capa)
 		ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband,
@@ -1788,7 +1788,8 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 		/* returned value is only needed for rc update, but the
 		 * rc isn't initialized here yet, so ignore it
 		 */
-		__ieee80211_vht_handle_opmode(sdata, sta, params->opmode_notif,
+		__ieee80211_vht_handle_opmode(sdata, sta, 0,
+					      params->opmode_notif,
 					      sband->band);
 	}
 
diff --git a/net/mac80211/ibss.c b/net/mac80211/ibss.c
index 2ca75f2d3023..87815a3624f3 100644
--- a/net/mac80211/ibss.c
+++ b/net/mac80211/ibss.c
@@ -1068,7 +1068,7 @@ static void ieee80211_update_sta_info(struct ieee80211_sub_if_data *sdata,
 						   &chandef);
 			memcpy(&cap_ie, elems->vht_cap_elem, sizeof(cap_ie));
 			ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
-							    &cap_ie, sta);
+							    &cap_ie, sta, 0);
 			if (memcmp(&cap, &sta->sta.deflink.vht_cap, sizeof(cap)))
 				rates_updated |= true;
 		}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 92ed1e3c2980..5be96b0bbd96 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2121,29 +2121,31 @@ void
 ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_supported_band *sband,
 				    const struct ieee80211_vht_cap *vht_cap_ie,
-				    struct sta_info *sta);
+				    struct sta_info *sta, unsigned int link_id);
 enum ieee80211_sta_rx_bandwidth ieee80211_sta_cap_rx_bw(struct sta_info *sta,
 							unsigned int link_id);
 enum ieee80211_sta_rx_bandwidth ieee80211_sta_cur_vht_bw(struct sta_info *sta,
 							 unsigned int link_id);
-void ieee80211_sta_set_rx_nss(struct sta_info *sta);
+void ieee80211_sta_set_rx_nss(struct sta_info *sta, unsigned int link_id);
 enum ieee80211_sta_rx_bandwidth
 ieee80211_chan_width_to_rx_bw(enum nl80211_chan_width width);
-enum nl80211_chan_width ieee80211_sta_cap_chan_bw(struct sta_info *sta);
+enum nl80211_chan_width ieee80211_sta_cap_chan_bw(struct sta_info *sta,
+						  unsigned int link_id);
 void ieee80211_process_mu_groups(struct ieee80211_sub_if_data *sdata,
+				 unsigned int link_id,
 				 struct ieee80211_mgmt *mgmt);
 u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
-                                  struct sta_info *sta, u8 opmode,
-				  enum nl80211_band band);
+				  struct sta_info *sta, unsigned int link_id,
+				  u8 opmode, enum nl80211_band band);
 void ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
-				 struct sta_info *sta, u8 opmode,
-				 enum nl80211_band band);
+				 struct sta_info *sta, unsigned int link_id,
+				 u8 opmode, enum nl80211_band band);
 void ieee80211_apply_vhtcap_overrides(struct ieee80211_sub_if_data *sdata,
 				      struct ieee80211_sta_vht_cap *vht_cap);
 void ieee80211_get_vht_mask_from_cap(__le16 vht_cap,
 				     u16 vht_mask[NL80211_VHT_NSS_MAX]);
 enum nl80211_chan_width
-ieee80211_sta_rx_bw_to_chan_width(struct sta_info *sta);
+ieee80211_sta_rx_bw_to_chan_width(struct sta_info *sta, unsigned int link_id);
 
 /* HE */
 void
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index fa684d76a169..c5be60ee12d8 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1496,14 +1496,14 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
 			sta = sta_info_get_bss(sdata, mgmt->sa);
 
 			if (sta)
-				ieee80211_vht_handle_opmode(sdata, sta, opmode,
-							    band);
+				ieee80211_vht_handle_opmode(sdata, sta, 0,
+							    opmode, band);
 
 			mutex_unlock(&local->sta_mtx);
 			break;
 		}
 		case WLAN_VHT_ACTION_GROUPID_MGMT:
-			ieee80211_process_mu_groups(sdata, mgmt);
+			ieee80211_process_mu_groups(sdata, 0, mgmt);
 			break;
 		default:
 			WARN_ON(1);
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index a6cb1db50f1d..fb7e8a9600ca 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -442,7 +442,7 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 		changed |= IEEE80211_RC_BW_CHANGED;
 
 	ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
-					    elems->vht_cap_elem, sta);
+					    elems->vht_cap_elem, sta, 0);
 
 	ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband, elems->he_cap,
 					  elems->he_cap_len,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index ca9e0d83e2a4..643ef0ae786e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3570,7 +3570,8 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 
 	if (elems->vht_cap_elem && !(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
 		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
-						    elems->vht_cap_elem, sta);
+						    elems->vht_cap_elem,
+						    sta, 0);
 
 	if (elems->he_operation && !(ifmgd->flags & IEEE80211_STA_DISABLE_HE) &&
 	    elems->he_cap) {
@@ -4377,7 +4378,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (sta && elems->opmode_notif)
-		ieee80211_vht_handle_opmode(sdata, sta, *elems->opmode_notif,
+		ieee80211_vht_handle_opmode(sdata, sta, 0,
+					    *elems->opmode_notif,
 					    rx_status->band);
 	mutex_unlock(&local->sta_mtx);
 
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index b268088585eb..402e898b75c3 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -37,7 +37,7 @@ void rate_control_rate_init(struct sta_info *sta)
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 
-	ieee80211_sta_set_rx_nss(sta);
+	ieee80211_sta_set_rx_nss(sta, 0);
 
 	if (!ref)
 		return;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 1774d0f9feaa..e6b16ebbdb48 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3403,7 +3403,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			rx->sta->sta.deflink.bandwidth = new_bw;
 			sband = rx->local->hw.wiphy->bands[status->band];
 			sta_opmode.bw =
-				ieee80211_sta_rx_bw_to_chan_width(rx->sta);
+				ieee80211_sta_rx_bw_to_chan_width(rx->sta, 0);
 			sta_opmode.changed = STA_OPMODE_MAX_BW_CHANGED;
 
 			rate_control_rate_update(local, sband, rx->sta, 0,
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 86a13ef31ef1..4fc120c64022 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -308,7 +308,7 @@ ieee80211_tdls_chandef_vht_upgrade(struct ieee80211_sub_if_data *sdata,
 	/* IEEE802.11ac-2013 Table E-4 */
 	u16 centers_80mhz[] = { 5210, 5290, 5530, 5610, 5690, 5775 };
 	struct cfg80211_chan_def uc = sta->tdls_chandef;
-	enum nl80211_chan_width max_width = ieee80211_sta_cap_chan_bw(sta);
+	enum nl80211_chan_width max_width = ieee80211_sta_cap_chan_bw(sta, 0);
 	int i;
 
 	/* only support upgrading non-narrow channels up to 80Mhz */
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index 27d260be9123..acfe1459535f 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -116,16 +116,16 @@ void
 ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 				    struct ieee80211_supported_band *sband,
 				    const struct ieee80211_vht_cap *vht_cap_ie,
-				    struct sta_info *sta)
+				    struct sta_info *sta, unsigned int link_id)
 {
-	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.deflink.vht_cap;
+	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.link[link_id]->vht_cap;
 	struct ieee80211_sta_vht_cap own_cap;
 	u32 cap_info, i;
 	bool have_80mhz;
 
 	memset(vht_cap, 0, sizeof(*vht_cap));
 
-	if (!sta->sta.deflink.ht_cap.ht_supported)
+	if (!sta->sta.link[link_id]->ht_cap.ht_supported)
 		return;
 
 	if (!vht_cap_ie || !sband->vht_cap.vht_supported)
@@ -295,10 +295,10 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 	switch (vht_cap->cap & IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_MASK) {
 	case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ:
 	case IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160_80PLUS80MHZ:
-		sta->deflink.cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
+		sta->link[link_id]->cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
 		break;
 	default:
-		sta->deflink.cur_max_bandwidth = IEEE80211_STA_RX_BW_80;
+		sta->link[link_id]->cur_max_bandwidth = IEEE80211_STA_RX_BW_80;
 
 		if (!(vht_cap->vht_mcs.tx_highest &
 				cpu_to_le16(IEEE80211_VHT_EXT_NSS_BW_CAPABLE)))
@@ -310,10 +310,11 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 		 * above) between 160 and 80+80 yet.
 		 */
 		if (cap_info & IEEE80211_VHT_CAP_EXT_NSS_BW_MASK)
-			sta->deflink.cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
+			sta->link[link_id]->cur_max_bandwidth =
+				IEEE80211_STA_RX_BW_160;
 	}
 
-	sta->sta.deflink.bandwidth = ieee80211_sta_cur_vht_bw(sta, 0);
+	sta->sta.link[link_id]->bandwidth = ieee80211_sta_cur_vht_bw(sta, link_id);
 
 	switch (vht_cap->cap & IEEE80211_VHT_CAP_MAX_MPDU_MASK) {
 	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
@@ -391,16 +392,17 @@ enum ieee80211_sta_rx_bandwidth ieee80211_sta_cap_rx_bw(struct sta_info *sta,
 	return IEEE80211_STA_RX_BW_80;
 }
 
-enum nl80211_chan_width ieee80211_sta_cap_chan_bw(struct sta_info *sta)
+enum nl80211_chan_width ieee80211_sta_cap_chan_bw(struct sta_info *sta,
+						  unsigned int link_id)
 {
-	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.deflink.vht_cap;
+	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.link[link_id]->vht_cap;
 	u32 cap_width;
 
 	if (!vht_cap->vht_supported) {
-		if (!sta->sta.deflink.ht_cap.ht_supported)
+		if (!sta->sta.link[link_id]->ht_cap.ht_supported)
 			return NL80211_CHAN_WIDTH_20_NOHT;
 
-		return sta->sta.deflink.ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
+		return sta->sta.link[link_id]->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 ?
 				NL80211_CHAN_WIDTH_40 : NL80211_CHAN_WIDTH_20;
 	}
 
@@ -415,15 +417,17 @@ enum nl80211_chan_width ieee80211_sta_cap_chan_bw(struct sta_info *sta)
 }
 
 enum nl80211_chan_width
-ieee80211_sta_rx_bw_to_chan_width(struct sta_info *sta)
+ieee80211_sta_rx_bw_to_chan_width(struct sta_info *sta, unsigned int link_id)
 {
-	enum ieee80211_sta_rx_bandwidth cur_bw = sta->sta.deflink.bandwidth;
-	struct ieee80211_sta_vht_cap *vht_cap = &sta->sta.deflink.vht_cap;
+	enum ieee80211_sta_rx_bandwidth cur_bw =
+		sta->sta.link[link_id]->bandwidth;
+	struct ieee80211_sta_vht_cap *vht_cap =
+		&sta->sta.link[link_id]->vht_cap;
 	u32 cap_width;
 
 	switch (cur_bw) {
 	case IEEE80211_STA_RX_BW_20:
-		if (!sta->sta.deflink.ht_cap.ht_supported)
+		if (!sta->sta.link[link_id]->ht_cap.ht_supported)
 			return NL80211_CHAN_WIDTH_20_NOHT;
 		else
 			return NL80211_CHAN_WIDTH_20;
@@ -497,18 +501,18 @@ enum ieee80211_sta_rx_bandwidth ieee80211_sta_cur_vht_bw(struct sta_info *sta,
 	return bw;
 }
 
-void ieee80211_sta_set_rx_nss(struct sta_info *sta)
+void ieee80211_sta_set_rx_nss(struct sta_info *sta, unsigned int link_id)
 {
 	u8 ht_rx_nss = 0, vht_rx_nss = 0, he_rx_nss = 0, eht_rx_nss = 0, rx_nss;
 	bool support_160;
 
 	/* if we received a notification already don't overwrite it */
-	if (sta->sta.deflink.rx_nss)
+	if (sta->sta.link[link_id]->rx_nss)
 		return;
 
-	if (sta->sta.deflink.eht_cap.has_eht) {
+	if (sta->sta.link[link_id]->eht_cap.has_eht) {
 		int i;
-		const u8 *rx_nss_mcs = (void *)&sta->sta.deflink.eht_cap.eht_mcs_nss_supp;
+		const u8 *rx_nss_mcs = (void *)&sta->sta.link[link_id]->eht_cap.eht_mcs_nss_supp;
 
 		/* get the max nss for EHT over all possible bandwidths and mcs */
 		for (i = 0; i < sizeof(struct ieee80211_eht_mcs_nss_supp); i++)
@@ -517,10 +521,10 @@ void ieee80211_sta_set_rx_nss(struct sta_info *sta)
 						       IEEE80211_EHT_MCS_NSS_RX));
 	}
 
-	if (sta->sta.deflink.he_cap.has_he) {
+	if (sta->sta.link[link_id]->he_cap.has_he) {
 		int i;
 		u8 rx_mcs_80 = 0, rx_mcs_160 = 0;
-		const struct ieee80211_sta_he_cap *he_cap = &sta->sta.deflink.he_cap;
+		const struct ieee80211_sta_he_cap *he_cap = &sta->sta.link[link_id]->he_cap;
 		u16 mcs_160_map =
 			le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_160);
 		u16 mcs_80_map = le16_to_cpu(he_cap->he_mcs_nss_supp.rx_mcs_80);
@@ -551,23 +555,23 @@ void ieee80211_sta_set_rx_nss(struct sta_info *sta)
 			he_rx_nss = rx_mcs_80;
 	}
 
-	if (sta->sta.deflink.ht_cap.ht_supported) {
-		if (sta->sta.deflink.ht_cap.mcs.rx_mask[0])
+	if (sta->sta.link[link_id]->ht_cap.ht_supported) {
+		if (sta->sta.link[link_id]->ht_cap.mcs.rx_mask[0])
 			ht_rx_nss++;
-		if (sta->sta.deflink.ht_cap.mcs.rx_mask[1])
+		if (sta->sta.link[link_id]->ht_cap.mcs.rx_mask[1])
 			ht_rx_nss++;
-		if (sta->sta.deflink.ht_cap.mcs.rx_mask[2])
+		if (sta->sta.link[link_id]->ht_cap.mcs.rx_mask[2])
 			ht_rx_nss++;
-		if (sta->sta.deflink.ht_cap.mcs.rx_mask[3])
+		if (sta->sta.link[link_id]->ht_cap.mcs.rx_mask[3])
 			ht_rx_nss++;
 		/* FIXME: consider rx_highest? */
 	}
 
-	if (sta->sta.deflink.vht_cap.vht_supported) {
+	if (sta->sta.link[link_id]->vht_cap.vht_supported) {
 		int i;
 		u16 rx_mcs_map;
 
-		rx_mcs_map = le16_to_cpu(sta->sta.deflink.vht_cap.vht_mcs.rx_mcs_map);
+		rx_mcs_map = le16_to_cpu(sta->sta.link[link_id]->vht_cap.vht_mcs.rx_mcs_map);
 
 		for (i = 7; i >= 0; i--) {
 			u8 mcs = (rx_mcs_map >> (2 * i)) & 3;
@@ -583,12 +587,12 @@ void ieee80211_sta_set_rx_nss(struct sta_info *sta)
 	rx_nss = max(vht_rx_nss, ht_rx_nss);
 	rx_nss = max(he_rx_nss, rx_nss);
 	rx_nss = max(eht_rx_nss, rx_nss);
-	sta->sta.deflink.rx_nss = max_t(u8, 1, rx_nss);
+	sta->sta.link[link_id]->rx_nss = max_t(u8, 1, rx_nss);
 }
 
 u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
-				  struct sta_info *sta, u8 opmode,
-				  enum nl80211_band band)
+				  struct sta_info *sta, unsigned int link_id,
+				  u8 opmode, enum nl80211_band band)
 {
 	enum ieee80211_sta_rx_bandwidth new_bw;
 	struct sta_opmode_info sta_opmode = {};
@@ -603,8 +607,8 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 	nss >>= IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
 	nss += 1;
 
-	if (sta->sta.deflink.rx_nss != nss) {
-		sta->sta.deflink.rx_nss = nss;
+	if (sta->sta.link[link_id]->rx_nss != nss) {
+		sta->sta.link[link_id]->rx_nss = nss;
 		sta_opmode.rx_nss = nss;
 		changed |= IEEE80211_RC_NSS_CHANGED;
 		sta_opmode.changed |= STA_OPMODE_N_SS_CHANGED;
@@ -613,28 +617,28 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 	switch (opmode & IEEE80211_OPMODE_NOTIF_CHANWIDTH_MASK) {
 	case IEEE80211_OPMODE_NOTIF_CHANWIDTH_20MHZ:
 		/* ignore IEEE80211_OPMODE_NOTIF_BW_160_80P80 must not be set */
-		sta->deflink.cur_max_bandwidth = IEEE80211_STA_RX_BW_20;
+		sta->link[link_id]->cur_max_bandwidth = IEEE80211_STA_RX_BW_20;
 		break;
 	case IEEE80211_OPMODE_NOTIF_CHANWIDTH_40MHZ:
 		/* ignore IEEE80211_OPMODE_NOTIF_BW_160_80P80 must not be set */
-		sta->deflink.cur_max_bandwidth = IEEE80211_STA_RX_BW_40;
+		sta->link[link_id]->cur_max_bandwidth = IEEE80211_STA_RX_BW_40;
 		break;
 	case IEEE80211_OPMODE_NOTIF_CHANWIDTH_80MHZ:
 		if (opmode & IEEE80211_OPMODE_NOTIF_BW_160_80P80)
-			sta->deflink.cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
+			sta->link[link_id]->cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
 		else
-			sta->deflink.cur_max_bandwidth = IEEE80211_STA_RX_BW_80;
+			sta->link[link_id]->cur_max_bandwidth = IEEE80211_STA_RX_BW_80;
 		break;
 	case IEEE80211_OPMODE_NOTIF_CHANWIDTH_160MHZ:
 		/* legacy only, no longer used by newer spec */
-		sta->deflink.cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
+		sta->link[link_id]->cur_max_bandwidth = IEEE80211_STA_RX_BW_160;
 		break;
 	}
 
-	new_bw = ieee80211_sta_cur_vht_bw(sta, 0);
-	if (new_bw != sta->sta.deflink.bandwidth) {
-		sta->sta.deflink.bandwidth = new_bw;
-		sta_opmode.bw = ieee80211_sta_rx_bw_to_chan_width(sta);
+	new_bw = ieee80211_sta_cur_vht_bw(sta, link_id);
+	if (new_bw != sta->sta.link[link_id]->bandwidth) {
+		sta->sta.link[link_id]->bandwidth = new_bw;
+		sta_opmode.bw = ieee80211_sta_rx_bw_to_chan_width(sta, link_id);
 		changed |= IEEE80211_RC_BW_CHANGED;
 		sta_opmode.changed |= STA_OPMODE_MAX_BW_CHANGED;
 	}
@@ -647,54 +651,56 @@ u32 __ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
 }
 
 void ieee80211_process_mu_groups(struct ieee80211_sub_if_data *sdata,
+				 unsigned int link_id,
 				 struct ieee80211_mgmt *mgmt)
 {
-	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
+	struct ieee80211_bss_conf *link_conf = sdata->vif.link_conf[link_id];
 
-	if (!sdata->vif.bss_conf.mu_mimo_owner)
+	if (!link_conf->mu_mimo_owner)
 		return;
 
 	if (!memcmp(mgmt->u.action.u.vht_group_notif.position,
-		    bss_conf->mu_group.position, WLAN_USER_POSITION_LEN) &&
+		    link_conf->mu_group.position, WLAN_USER_POSITION_LEN) &&
 	    !memcmp(mgmt->u.action.u.vht_group_notif.membership,
-		    bss_conf->mu_group.membership, WLAN_MEMBERSHIP_LEN))
+		    link_conf->mu_group.membership, WLAN_MEMBERSHIP_LEN))
 		return;
 
-	memcpy(bss_conf->mu_group.membership,
+	memcpy(link_conf->mu_group.membership,
 	       mgmt->u.action.u.vht_group_notif.membership,
 	       WLAN_MEMBERSHIP_LEN);
-	memcpy(bss_conf->mu_group.position,
+	memcpy(link_conf->mu_group.position,
 	       mgmt->u.action.u.vht_group_notif.position,
 	       WLAN_USER_POSITION_LEN);
 
-	ieee80211_link_info_change_notify(sdata, 0, BSS_CHANGED_MU_GROUPS);
+	ieee80211_link_info_change_notify(sdata, link_id, BSS_CHANGED_MU_GROUPS);
 }
 
-void ieee80211_update_mu_groups(struct ieee80211_vif *vif,
+void ieee80211_update_mu_groups(struct ieee80211_vif *vif, unsigned int link_id,
 				const u8 *membership, const u8 *position)
 {
-	struct ieee80211_bss_conf *bss_conf = &vif->bss_conf;
+	struct ieee80211_bss_conf *link_conf = vif->link_conf[link_id];
 
-	if (WARN_ON_ONCE(!vif->bss_conf.mu_mimo_owner))
+	if (WARN_ON_ONCE(!link_conf->mu_mimo_owner))
 		return;
 
-	memcpy(bss_conf->mu_group.membership, membership, WLAN_MEMBERSHIP_LEN);
-	memcpy(bss_conf->mu_group.position, position, WLAN_USER_POSITION_LEN);
+	memcpy(link_conf->mu_group.membership, membership, WLAN_MEMBERSHIP_LEN);
+	memcpy(link_conf->mu_group.position, position, WLAN_USER_POSITION_LEN);
 }
 EXPORT_SYMBOL_GPL(ieee80211_update_mu_groups);
 
 void ieee80211_vht_handle_opmode(struct ieee80211_sub_if_data *sdata,
-				 struct sta_info *sta, u8 opmode,
-				 enum nl80211_band band)
+				 struct sta_info *sta, unsigned int link_id,
+				 u8 opmode, enum nl80211_band band)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_supported_band *sband = local->hw.wiphy->bands[band];
 
-	u32 changed = __ieee80211_vht_handle_opmode(sdata, sta, opmode, band);
+	u32 changed = __ieee80211_vht_handle_opmode(sdata, sta, link_id,
+						    opmode, band);
 
 	if (changed > 0) {
 		ieee80211_recalc_min_chandef(sdata);
-		rate_control_rate_update(local, sband, sta, 0, changed);
+		rate_control_rate_update(local, sband, sta, link_id, changed);
 	}
 }
 
-- 
2.36.1

