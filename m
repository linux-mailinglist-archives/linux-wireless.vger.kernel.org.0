Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C293573A41
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbiGMPe5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236959AbiGMPep (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3DF64D149
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=OPHKYXWXbYif1zEAyJJUZqBrwqAi3zBycKnCGL1CPtA=;
        t=1657726483; x=1658936083; b=l8inS3ivunYIEoAPGDbNuAINlr4PlEY0IsoF21YHR14Y/6Q
        mzOxmQNxXgA3a8/a/u8jzA9ZFV8Ois23NthnwQhl2Hyxxls9fX8hbDVtz/zLwKK14FFJM7G0q+YLA
        edhXODnnC0W3ubIRRp8YAXF9TfbgqD46odmcD8+FWRguf+qj8FBDikaEEa8eO/3rR8rBS7V+h2UQ+
        I8KHOBi75wVmoqI9ciuZwkUFpQ0gP0jLv6h3OjJ14k5lWk+PGenykqOYxY/tU+Zd9l3f8vsYrUFjc
        vgFCTV8MzlqkMIQ1lq36q4CWwUGSEp+O75CiA1I69B/e4/Am2SibE76hj3FL0gzA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNt-00EnaA-Rd;
        Wed, 13 Jul 2022 17:34:41 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 18/21] wifi: mac80211: mlme: refactor assoc link setup
Date:   Wed, 13 Jul 2022 17:34:30 +0200
Message-Id: <20220713173301.8aa30902c9cc.I4202bf90f873ed62ebf879cac380800a4e32b6b9@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713153433.279227-1-johannes@sipsolutions.net>
References: <20220713153433.279227-1-johannes@sipsolutions.net>
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

Factor out the code to set up the assoc link into a
new function ieee80211_setup_assoc_link().

While at it, also modify the 'override' handling to
just take into account whether or not the conn_flags
were changed, which is what we need to setup again
the channel later.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 286 ++++++++++++++++++++++++--------------------
 1 file changed, 156 insertions(+), 130 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 62bb5fec01c9..09b79fb42bb8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6144,22 +6144,138 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	return err;
 }
 
+static ieee80211_conn_flags_t
+ieee80211_setup_assoc_link(struct ieee80211_sub_if_data *sdata,
+			   struct ieee80211_mgd_assoc_data *assoc_data,
+			   struct cfg80211_assoc_request *req,
+			   ieee80211_conn_flags_t conn_flags)
+{
+	struct ieee80211_local *local = sdata->local;
+	const struct cfg80211_bss_ies *beacon_ies;
+	struct ieee80211_supported_band *sband;
+	const struct element *ht_elem, *vht_elem;
+	struct ieee80211_link_data *link = &sdata->deflink;
+	struct cfg80211_bss *cbss = req->bss;
+	struct ieee80211_bss *bss = (void *)cbss->priv;
+	bool is_5ghz, is_6ghz;
+
+	sband = local->hw.wiphy->bands[cbss->channel->band];
+	if (WARN_ON(!sband))
+		return false;
+
+	is_5ghz = cbss->channel->band == NL80211_BAND_5GHZ;
+	is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
+
+	assoc_data->supp_rates = bss->supp_rates;
+	assoc_data->supp_rates_len = bss->supp_rates_len;
+
+	rcu_read_lock();
+	ht_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_HT_OPERATION);
+	if (ht_elem && ht_elem->datalen >= sizeof(struct ieee80211_ht_operation))
+		assoc_data->ap_ht_param =
+			((struct ieee80211_ht_operation *)(ht_elem->data))->ht_param;
+	else if (!is_6ghz)
+		conn_flags |= IEEE80211_CONN_DISABLE_HT;
+	vht_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_VHT_CAPABILITY);
+	if (vht_elem && vht_elem->datalen >= sizeof(struct ieee80211_vht_cap)) {
+		memcpy(&assoc_data->ap_vht_cap, vht_elem->data,
+		       sizeof(struct ieee80211_vht_cap));
+	} else if (is_5ghz) {
+		link_info(link,
+			  "VHT capa missing/short, disabling VHT/HE/EHT\n");
+		conn_flags |= IEEE80211_CONN_DISABLE_VHT |
+			      IEEE80211_CONN_DISABLE_HE |
+			      IEEE80211_CONN_DISABLE_EHT;
+	}
+	rcu_read_unlock();
+
+	link->u.mgd.beacon_crc_valid = false;
+	link->u.mgd.dtim_period = 0;
+	link->u.mgd.have_beacon = false;
+
+	/* override HT/VHT configuration only if the AP and we support it */
+	if (!(conn_flags & IEEE80211_CONN_DISABLE_HT)) {
+		struct ieee80211_sta_ht_cap sta_ht_cap;
+
+		memcpy(&sta_ht_cap, &sband->ht_cap, sizeof(sta_ht_cap));
+		ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
+	}
+
+	rcu_read_lock();
+	beacon_ies = rcu_dereference(cbss->beacon_ies);
+	if (beacon_ies) {
+		const struct element *elem;
+		u8 dtim_count = 0;
+
+		ieee80211_get_dtim(beacon_ies, &dtim_count,
+				   &link->u.mgd.dtim_period);
+
+		sdata->deflink.u.mgd.have_beacon = true;
+
+		if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY)) {
+			link->conf->sync_tsf = beacon_ies->tsf;
+			link->conf->sync_device_ts = bss->device_ts_beacon;
+			link->conf->sync_dtim_count = dtim_count;
+		}
+
+		elem = cfg80211_find_ext_elem(WLAN_EID_EXT_MULTIPLE_BSSID_CONFIGURATION,
+					      beacon_ies->data, beacon_ies->len);
+		if (elem && elem->datalen >= 3)
+			link->conf->profile_periodicity = elem->data[2];
+		else
+			link->conf->profile_periodicity = 0;
+
+		elem = cfg80211_find_elem(WLAN_EID_EXT_CAPABILITY,
+					  beacon_ies->data, beacon_ies->len);
+		if (elem && elem->datalen >= 11 &&
+		    (elem->data[10] & WLAN_EXT_CAPA11_EMA_SUPPORT))
+			link->conf->ema_ap = true;
+		else
+			link->conf->ema_ap = false;
+	}
+	rcu_read_unlock();
+
+	if (bss->corrupt_data) {
+		char *corrupt_type = "data";
+
+		if (bss->corrupt_data & IEEE80211_BSS_CORRUPT_BEACON) {
+			if (bss->corrupt_data & IEEE80211_BSS_CORRUPT_PROBE_RESP)
+				corrupt_type = "beacon and probe response";
+			else
+				corrupt_type = "beacon";
+		} else if (bss->corrupt_data & IEEE80211_BSS_CORRUPT_PROBE_RESP) {
+			corrupt_type = "probe response";
+		}
+		sdata_info(sdata, "associating to AP %pM with corrupt %s\n",
+			   cbss->bssid, corrupt_type);
+	}
+
+	if (link->u.mgd.req_smps == IEEE80211_SMPS_AUTOMATIC) {
+		if (sdata->u.mgd.powersave)
+			link->smps_mode = IEEE80211_SMPS_DYNAMIC;
+		else
+			link->smps_mode = IEEE80211_SMPS_OFF;
+	} else {
+		link->smps_mode = link->u.mgd.req_smps;
+	}
+
+	return conn_flags;
+}
+
 int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 			struct cfg80211_assoc_request *req)
 {
-	bool is_6ghz = req->bss->channel->band == NL80211_BAND_6GHZ;
-	bool is_5ghz = req->bss->channel->band == NL80211_BAND_5GHZ;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_bss *bss = (void *)req->bss->priv;
 	struct ieee80211_mgd_assoc_data *assoc_data;
 	const struct cfg80211_bss_ies *beacon_ies;
-	struct ieee80211_supported_band *sband;
 	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
-	const struct element *ssid_elem, *ht_elem, *vht_elem;
+	const struct element *ssid_elem;
 	struct ieee80211_link_data *link = &sdata->deflink;
+	ieee80211_conn_flags_t conn_flags = 0;
 	int i, err;
-	bool override = false;
+	bool override;
 
 	assoc_data = kzalloc(sizeof(*assoc_data) + req->ie_len, GFP_KERNEL);
 	if (!assoc_data)
@@ -6215,8 +6331,6 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
 	/* prepare assoc data */
 
-	link->u.mgd.beacon_crc_valid = false;
-
 	assoc_data->wmm = bss->wmm_used &&
 			  (local->hw.queues >= IEEE80211_NUM_ACS);
 
@@ -6231,27 +6345,44 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		if (req->crypto.ciphers_pairwise[i] == WLAN_CIPHER_SUITE_WEP40 ||
 		    req->crypto.ciphers_pairwise[i] == WLAN_CIPHER_SUITE_TKIP ||
 		    req->crypto.ciphers_pairwise[i] == WLAN_CIPHER_SUITE_WEP104) {
-			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
-			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
-			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+			conn_flags |= IEEE80211_CONN_DISABLE_HT;
+			conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+			conn_flags |= IEEE80211_CONN_DISABLE_HE;
+			conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 			netdev_info(sdata->dev,
 				    "disabling HT/VHT/HE due to WEP/TKIP use\n");
 		}
 	}
 
-	sband = local->hw.wiphy->bands[req->bss->channel->band];
-
 	/* also disable HT/VHT/HE/EHT if the AP doesn't use WMM */
 	if (!bss->wmm_used) {
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+		conn_flags |= IEEE80211_CONN_DISABLE_HT;
+		conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+		conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		conn_flags |= IEEE80211_CONN_DISABLE_EHT;
 		netdev_info(sdata->dev,
 			    "disabling HT/VHT/HE as WMM/QoS is not supported by the AP\n");
 	}
 
+	if (req->flags & ASSOC_REQ_DISABLE_HT) {
+		mlme_dbg(sdata, "HT disabled by flag, disabling HT/VHT/HE\n");
+		conn_flags |= IEEE80211_CONN_DISABLE_HT;
+		conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+		conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+	}
+
+	if (req->flags & ASSOC_REQ_DISABLE_VHT) {
+		mlme_dbg(sdata, "VHT disabled by flag, disabling VHT\n");
+		conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+	}
+
+	if (req->flags & ASSOC_REQ_DISABLE_HE) {
+		mlme_dbg(sdata, "HE disabled by flag, disabling HE/EHT\n");
+		conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+	}
+
 	memcpy(&ifmgd->ht_capa, &req->ht_capa, sizeof(ifmgd->ht_capa));
 	memcpy(&ifmgd->ht_capa_mask, &req->ht_capa_mask,
 	       sizeof(ifmgd->ht_capa_mask));
@@ -6286,28 +6417,15 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 
 	assoc_data->bss = req->bss;
 	assoc_data->capability = req->bss->capability;
-	assoc_data->supp_rates = bss->supp_rates;
-	assoc_data->supp_rates_len = bss->supp_rates_len;
 
-	rcu_read_lock();
-	ht_elem = ieee80211_bss_get_elem(req->bss, WLAN_EID_HT_OPERATION);
-	if (ht_elem && ht_elem->datalen >= sizeof(struct ieee80211_ht_operation))
-		assoc_data->ap_ht_param =
-			((struct ieee80211_ht_operation *)(ht_elem->data))->ht_param;
-	else if (!is_6ghz)
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
-	vht_elem = ieee80211_bss_get_elem(req->bss, WLAN_EID_VHT_CAPABILITY);
-	if (vht_elem && vht_elem->datalen >= sizeof(struct ieee80211_vht_cap)) {
-		memcpy(&assoc_data->ap_vht_cap, vht_elem->data,
-		       sizeof(struct ieee80211_vht_cap));
-	} else if (is_5ghz) {
-		sdata_info(sdata,
-			   "VHT capa missing/short, disabling VHT/HE/EHT\n");
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT |
-				IEEE80211_CONN_DISABLE_HE |
-				IEEE80211_CONN_DISABLE_EHT;
-	}
-	rcu_read_unlock();
+	/* default timeout */
+	assoc_data->timeout = jiffies;
+	assoc_data->timeout_started = true;
+
+	conn_flags |= ieee80211_setup_assoc_link(sdata, assoc_data, req,
+						 conn_flags);
+	override = link->u.mgd.conn_flags != conn_flags;
+	link->u.mgd.conn_flags |= conn_flags;
 
 	if (WARN((sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_UAPSD) &&
 		 ieee80211_hw_check(&local->hw, PS_NULLFUNC_STACK),
@@ -6351,50 +6469,7 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	sdata->control_port_no_preauth = req->crypto.control_port_no_preauth;
 
 	/* kick off associate process */
-
 	ifmgd->assoc_data = assoc_data;
-	link->u.mgd.dtim_period = 0;
-	link->u.mgd.have_beacon = false;
-
-	/* override HT/VHT configuration only if the AP and we support it */
-	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)) {
-		struct ieee80211_sta_ht_cap sta_ht_cap;
-
-		if (req->flags & ASSOC_REQ_DISABLE_HT)
-			override = true;
-
-		memcpy(&sta_ht_cap, &sband->ht_cap, sizeof(sta_ht_cap));
-		ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
-
-		/* check for 40 MHz disable override */
-		if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_40MHZ) &&
-		    sband->ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40 &&
-		    !(sta_ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40))
-			override = true;
-
-		if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) &&
-		    req->flags & ASSOC_REQ_DISABLE_VHT)
-			override = true;
-	}
-
-	if (req->flags & ASSOC_REQ_DISABLE_HT) {
-		mlme_dbg(sdata, "HT disabled by flag, disabling HT/VHT/HE\n");
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
-	}
-
-	if (req->flags & ASSOC_REQ_DISABLE_VHT) {
-		mlme_dbg(sdata, "VHT disabled by flag, disabling VHT\n");
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-	}
-
-	if (req->flags & ASSOC_REQ_DISABLE_HE) {
-		mlme_dbg(sdata, "HE disabled by flag, disabling HE/EHT\n");
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
-	}
 
 	if (req->flags & ASSOC_REQ_DISABLE_EHT)
 		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
@@ -6426,60 +6501,11 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		assoc_data->timeout = TU_TO_EXP_TIME(req->bss->beacon_interval);
 		assoc_data->timeout_started = true;
 		assoc_data->need_beacon = true;
-	} else if (beacon_ies) {
-		const struct element *elem;
-		u8 dtim_count = 0;
-
-		ieee80211_get_dtim(beacon_ies, &dtim_count,
-				   &link->u.mgd.dtim_period);
-
-		link->u.mgd.have_beacon = true;
-		assoc_data->timeout = jiffies;
-		assoc_data->timeout_started = true;
-
-		if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY)) {
-			link->conf->sync_tsf = beacon_ies->tsf;
-			link->conf->sync_device_ts =
-				bss->device_ts_beacon;
-			link->conf->sync_dtim_count = dtim_count;
-		}
-
-		elem = cfg80211_find_ext_elem(WLAN_EID_EXT_MULTIPLE_BSSID_CONFIGURATION,
-					      beacon_ies->data, beacon_ies->len);
-		if (elem && elem->datalen >= 3)
-			link->conf->profile_periodicity = elem->data[2];
-		else
-			link->conf->profile_periodicity = 0;
-
-		elem = cfg80211_find_elem(WLAN_EID_EXT_CAPABILITY,
-					  beacon_ies->data, beacon_ies->len);
-		if (elem && elem->datalen >= 11 &&
-		    (elem->data[10] & WLAN_EXT_CAPA11_EMA_SUPPORT))
-			link->conf->ema_ap = true;
-		else
-			link->conf->ema_ap = false;
-	} else {
-		assoc_data->timeout = jiffies;
-		assoc_data->timeout_started = true;
 	}
 	rcu_read_unlock();
 
 	run_again(sdata, assoc_data->timeout);
 
-	if (bss->corrupt_data) {
-		char *corrupt_type = "data";
-		if (bss->corrupt_data & IEEE80211_BSS_CORRUPT_BEACON) {
-			if (bss->corrupt_data &
-					IEEE80211_BSS_CORRUPT_PROBE_RESP)
-				corrupt_type = "beacon and probe response";
-			else
-				corrupt_type = "beacon";
-		} else if (bss->corrupt_data & IEEE80211_BSS_CORRUPT_PROBE_RESP)
-			corrupt_type = "probe response";
-		sdata_info(sdata, "associating with AP with corrupt %s\n",
-			   corrupt_type);
-	}
-
 	return 0;
  err_clear:
 	eth_zero_addr(sdata->deflink.u.mgd.bssid);
-- 
2.36.1

