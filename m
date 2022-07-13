Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0A3573340
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbiGMJp7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbiGMJpT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:19 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C9CF32E5
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=qzNytJmWPrUXHM/hm/8e2Stxa0vZhtOTNr3wo1oGcxs=;
        t=1657705518; x=1658915118; b=Z8/TIz3nWBTTseG6nEpdjuXvO4fvIfk4ymmS57BK1YMG0Zm
        8av+NNkVE6EawQR+cTVMI/KGneW5pLQIUQToVrASALhrmmYAgRtX44GyBIxn7d2nY9zzhso9GIC43
        Z+8SHzMgLXr47O11HYvbX/PFs88W/6/+t9GshVqmbBFt7in4iEz9GZWVi7HWL9mzpC1R030KTQvBU
        XekDtz16quvYqLCcOMGvqWEWjAOMSR1axtxOIhQ45Qh4skQB4xd2tIPeMIE6EE+21Uoxkhvqjjaw7
        95QLO3aJztdBOoLEChKFd4Z6/YO5lDt8ACpWvjiRG87Lf886HPxLwFt/nD0aTjaQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvk-00EgvB-1G;
        Wed, 13 Jul 2022 11:45:16 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 37/76] wifi: mac80211: mlme: use correct link_sta
Date:   Wed, 13 Jul 2022 11:44:23 +0200
Message-Id: <20220713114425.55b3149a7261.I3ed0c7572e1daf2f1bbc42d490a61f2928fda267@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
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

For station capabilities, e.g. TWT, we need to use the correct
link station instead of deflink. Switch the code to do that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 46 ++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index fcd964e634d5..7870e3e23e26 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3395,7 +3395,7 @@ static void ieee80211_get_rates(struct ieee80211_supported_band *sband,
 	}
 }
 
-static bool ieee80211_twt_req_supported(const struct sta_info *sta,
+static bool ieee80211_twt_req_supported(const struct link_sta_info *link_sta,
 					const struct ieee802_11_elems *elems)
 {
 	if (elems->ext_capab_len < 10)
@@ -3404,15 +3404,15 @@ static bool ieee80211_twt_req_supported(const struct sta_info *sta,
 	if (!(elems->ext_capab[9] & WLAN_EXT_CAPA10_TWT_RESPONDER_SUPPORT))
 		return false;
 
-	return sta->sta.deflink.he_cap.he_cap_elem.mac_cap_info[0] &
+	return link_sta->pub->he_cap.he_cap_elem.mac_cap_info[0] &
 		IEEE80211_HE_MAC_CAP0_TWT_RES;
 }
 
 static int ieee80211_recalc_twt_req(struct ieee80211_link_data *link,
-				    struct sta_info *sta,
+				    struct link_sta_info *link_sta,
 				    struct ieee802_11_elems *elems)
 {
-	bool twt = ieee80211_twt_req_supported(sta, elems);
+	bool twt = ieee80211_twt_req_supported(link_sta, elems);
 
 	if (link->conf->twt_requester != twt) {
 		link->conf->twt_requester = twt;
@@ -3424,14 +3424,14 @@ static int ieee80211_recalc_twt_req(struct ieee80211_link_data *link,
 static bool ieee80211_twt_bcast_support(struct ieee80211_sub_if_data *sdata,
 					struct ieee80211_bss_conf *bss_conf,
 					struct ieee80211_supported_band *sband,
-					struct sta_info *sta)
+					struct link_sta_info *link_sta)
 {
 	const struct ieee80211_sta_he_cap *own_he_cap =
 		ieee80211_get_he_iftype_cap(sband,
 					    ieee80211_vif_type_p2p(&sdata->vif));
 
 	return bss_conf->he_support &&
-		(sta->sta.deflink.he_cap.he_cap_elem.mac_cap_info[2] &
+		(link_sta->pub->he_cap.he_cap_elem.mac_cap_info[2] &
 			IEEE80211_HE_MAC_CAP2_BCAST_TWT) &&
 		own_he_cap &&
 		(own_he_cap->he_cap_elem.mac_cap_info[2] &
@@ -3446,6 +3446,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_supported_band *sband;
+	struct link_sta_info *link_sta;
 	struct sta_info *sta;
 	u16 capab_info, aid;
 	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
@@ -3617,6 +3618,14 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
+	link_sta = rcu_dereference_protected(sta->link[link->link_id],
+					     lockdep_is_held(&local->sta_mtx));
+	if (WARN_ON(!link_sta)) {
+		mutex_unlock(&sdata->local->sta_mtx);
+		ret = false;
+		goto out;
+	}
+
 	sband = ieee80211_get_link_sband(link);
 	if (!sband) {
 		mutex_unlock(&sdata->local->sta_mtx);
@@ -3637,12 +3646,12 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	if (elems->ht_cap_elem && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT))
 		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
 						  elems->ht_cap_elem,
-						  &sta->deflink);
+						  link_sta);
 
 	if (elems->vht_cap_elem && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
 		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
 						    elems->vht_cap_elem,
-						    &sta->deflink);
+						    link_sta);
 
 	if (elems->he_operation && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
 	    elems->he_cap) {
@@ -3650,9 +3659,9 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 						  elems->he_cap,
 						  elems->he_cap_len,
 						  elems->he_6ghz_capa,
-						  &sta->deflink);
+						  link_sta);
 
-		bss_conf->he_support = sta->sta.deflink.he_cap.has_he;
+		bss_conf->he_support = link_sta->pub->he_cap.has_he;
 		if (elems->rsnx && elems->rsnx_len &&
 		    (elems->rsnx[0] & WLAN_RSNX_CAPA_PROTECTED_TWT) &&
 		    wiphy_ext_feature_isset(local->hw.wiphy,
@@ -3661,7 +3670,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		else
 			bss_conf->twt_protected = false;
 
-		changed |= ieee80211_recalc_twt_req(link, sta, elems);
+		changed |= ieee80211_recalc_twt_req(link, link_sta, elems);
 
 		if (elems->eht_operation && elems->eht_cap &&
 		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT)) {
@@ -3684,7 +3693,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	}
 
 	bss_conf->twt_broadcast =
-		ieee80211_twt_bcast_support(sdata, bss_conf, sband, sta);
+		ieee80211_twt_bcast_support(sdata, bss_conf, sband, link_sta);
 
 	if (bss_conf->he_support) {
 		bss_conf->he_bss_color.color =
@@ -3749,7 +3758,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		nss = *elems->opmode_notif & IEEE80211_OPMODE_NOTIF_RX_NSS_MASK;
 		nss >>= IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
 		nss += 1;
-		sta->sta.deflink.rx_nss = nss;
+		link_sta->pub->rx_nss = nss;
 	}
 
 	rate_control_rate_init(sta);
@@ -4190,6 +4199,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_channel *chan;
+	struct link_sta_info *link_sta;
 	struct sta_info *sta;
 	u32 changed = 0;
 	bool erp_valid;
@@ -4431,8 +4441,14 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 
 	mutex_lock(&local->sta_mtx);
 	sta = sta_info_get(sdata, sdata->vif.cfg.ap_addr);
+	if (WARN_ON(!sta))
+		goto free;
+	link_sta = rcu_dereference_protected(sta->link[link->link_id],
+					     lockdep_is_held(&local->sta_mtx));
+	if (WARN_ON(!link_sta))
+		goto free;
 
-	changed |= ieee80211_recalc_twt_req(link, sta, elems);
+	changed |= ieee80211_recalc_twt_req(link, link_sta, elems);
 
 	if (ieee80211_config_bw(link, elems->ht_cap_elem,
 				elems->vht_cap_elem, elems->ht_operation,
@@ -4454,7 +4470,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	}
 
 	if (sta && elems->opmode_notif)
-		ieee80211_vht_handle_opmode(sdata, &sta->deflink,
+		ieee80211_vht_handle_opmode(sdata, link_sta,
 					    *elems->opmode_notif,
 					    rx_status->band);
 	mutex_unlock(&local->sta_mtx);
-- 
2.36.1

