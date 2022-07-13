Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D13D573A3E
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbiGMPey (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbiGMPeo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3D832060
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=b+c44Roxnzht342gdjNbU8KZbA09y+EyQAFVX3RYmPg=;
        t=1657726482; x=1658936082; b=dCGWwhSG7lYUne3s7hvEJEKo+ujYir55kiZ2Q+dzPbdPzKi
        oEhm6EhYu4Hzpwao2oPpXCn9wVUd1gLRtDHiehiNCVDHTEYYS05d6OyOo2lWmorikGfeRDuuGMmCw
        eejdwO3utU/Xqpz/t1J/cZSN+9RB3rEW42q0WjXOgltuE6MM2V5cPOfpsZkLxWI8u1BMPtaIfB4+O
        cHUhZKqKypZO8ODEsHNeHtrS2kqshvJMt1mxYiiNKDu+7HINVVRGKixK5Nua8IN9dP+lSbLj3Ch0f
        G2i6qRWsowNDnF0JoRqmnGTUHzqGGIKhiMYEk35o79ES0SSPiQothFRAOVd94rLg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNs-00EnaA-Ob;
        Wed, 13 Jul 2022 17:34:40 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 14/21] wifi: mac80211: mlme: refactor assoc req element building
Date:   Wed, 13 Jul 2022 17:34:26 +0200
Message-Id: <20220713173301.fdc756ca1a1c.Id2b09ee06bb8ebe3cd5125ba1db9963b4bda5aa0@changeid>
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

For MLO, we will need to build these elements per link, so
factor out the code that does this, returning the capability,
to simplify building the multi-link element in the future.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 278 ++++++++++++++++++++++++++------------------
 1 file changed, 162 insertions(+), 116 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 999eead2129e..26c354e1b042 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -936,17 +936,158 @@ static size_t ieee80211_add_before_he_elems(struct sk_buff *skb,
 	return noffset;
 }
 
+static size_t ieee80211_assoc_link_elems(struct ieee80211_sub_if_data *sdata,
+					 struct sk_buff *skb, u16 *capab,
+					 const struct element *ext_capa,
+					 const u8 *extra_elems,
+					 size_t extra_elems_len,
+					 struct ieee80211_link_data *link)
+{
+	enum nl80211_iftype iftype = ieee80211_vif_type_p2p(&sdata->vif);
+	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
+	struct ieee80211_mgd_assoc_data *assoc_data = ifmgd->assoc_data;
+	struct cfg80211_bss *cbss = assoc_data->bss;
+	struct ieee80211_channel *chan = cbss->channel;
+	const struct ieee80211_sband_iftype_data *iftd;
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_supported_band *sband;
+	enum nl80211_chan_width width = NL80211_CHAN_WIDTH_20;
+	struct ieee80211_chanctx_conf *chanctx_conf;
+	size_t offset = 0;
+	u8 *pos;
+	int i;
+
+	/*
+	 * 5/10 MHz scenarios are only viable without MLO, in which
+	 * case this pointer should be used ... All of this is a bit
+	 * unclear though, not sure this even works at all.
+	 */
+	rcu_read_lock();
+	chanctx_conf = rcu_dereference(link->conf->chanctx_conf);
+	if (chanctx_conf)
+		width = chanctx_conf->def.width;
+	rcu_read_unlock();
+
+	sband = local->hw.wiphy->bands[chan->band];
+	iftd = ieee80211_get_sband_iftype_data(sband, iftype);
+
+	if (sband->band == NL80211_BAND_2GHZ) {
+		*capab |= WLAN_CAPABILITY_SHORT_SLOT_TIME;
+		*capab |= WLAN_CAPABILITY_SHORT_PREAMBLE;
+	}
+
+	if ((cbss->capability & WLAN_CAPABILITY_SPECTRUM_MGMT) &&
+	    ieee80211_hw_check(&local->hw, SPECTRUM_MGMT))
+		*capab |= WLAN_CAPABILITY_SPECTRUM_MGMT;
+
+	if (sband->band != NL80211_BAND_S1GHZ)
+		ieee80211_assoc_add_rates(skb, width, sband, assoc_data);
+
+	if (*capab & WLAN_CAPABILITY_SPECTRUM_MGMT ||
+	    *capab & WLAN_CAPABILITY_RADIO_MEASURE) {
+		struct cfg80211_chan_def chandef = {
+			.width = width,
+			.chan = chan,
+		};
+
+		pos = skb_put(skb, 4);
+		*pos++ = WLAN_EID_PWR_CAPABILITY;
+		*pos++ = 2;
+		*pos++ = 0; /* min tx power */
+		 /* max tx power */
+		*pos++ = ieee80211_chandef_max_power(&chandef);
+	}
+
+	/*
+	 * Per spec, we shouldn't include the list of channels if we advertise
+	 * support for extended channel switching, but we've always done that;
+	 * (for now?) apply this restriction only on the (new) 6 GHz band.
+	 */
+	if (*capab & WLAN_CAPABILITY_SPECTRUM_MGMT &&
+	    (sband->band != NL80211_BAND_6GHZ ||
+	     !ext_capa || ext_capa->datalen < 1 ||
+	     !(ext_capa->data[0] & WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING))) {
+		/* TODO: get this in reg domain format */
+		pos = skb_put(skb, 2 * sband->n_channels + 2);
+		*pos++ = WLAN_EID_SUPPORTED_CHANNELS;
+		*pos++ = 2 * sband->n_channels;
+		for (i = 0; i < sband->n_channels; i++) {
+			int cf = sband->channels[i].center_freq;
+
+			*pos++ = ieee80211_frequency_to_channel(cf);
+			*pos++ = 1; /* one channel in the subband*/
+		}
+	}
+
+	/* if present, add any custom IEs that go before HT */
+	offset = ieee80211_add_before_ht_elems(skb, extra_elems,
+					       extra_elems_len,
+					       offset);
+
+	if (sband->band != NL80211_BAND_6GHZ &&
+	    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT))
+		ieee80211_add_ht_ie(sdata, skb,
+				    assoc_data->ap_ht_param,
+				    sband, chan, link->smps_mode,
+				    link->u.mgd.conn_flags);
+
+	/* if present, add any custom IEs that go before VHT */
+	offset = ieee80211_add_before_vht_elems(skb, extra_elems,
+						extra_elems_len,
+						offset);
+
+	if (sband->band != NL80211_BAND_6GHZ &&
+	    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
+		link->conf->mu_mimo_owner =
+			ieee80211_add_vht_ie(sdata, skb, sband,
+					     &assoc_data->ap_vht_cap,
+					     link->u.mgd.conn_flags);
+
+	/*
+	 * If AP doesn't support HT, mark HE and EHT as disabled.
+	 * If on the 5GHz band, make sure it supports VHT.
+	 */
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT ||
+	    (sband->band == NL80211_BAND_5GHZ &&
+	     link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
+		link->u.mgd.conn_flags |=
+			IEEE80211_CONN_DISABLE_HE |
+			IEEE80211_CONN_DISABLE_EHT;
+
+	/* if present, add any custom IEs that go before HE */
+	offset = ieee80211_add_before_he_elems(skb, extra_elems,
+					       extra_elems_len,
+					       offset);
+
+	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE))
+		ieee80211_add_he_ie(sdata, skb, sband,
+				    link->u.mgd.conn_flags);
+
+	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT))
+		ieee80211_add_eht_ie(sdata, skb, sband);
+
+	if (sband->band == NL80211_BAND_S1GHZ) {
+		ieee80211_add_aid_request_ie(sdata, skb);
+		ieee80211_add_s1g_capab_ie(sdata, &sband->s1g_cap, skb);
+	}
+
+	if (iftd && iftd->vendor_elems.data && iftd->vendor_elems.len)
+		skb_put_data(skb, iftd->vendor_elems.data, iftd->vendor_elems.len);
+
+	return offset;
+}
+
 static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_mgd_assoc_data *assoc_data = ifmgd->assoc_data;
+	struct ieee80211_link_data *link = &sdata->deflink;
 	struct sk_buff *skb;
 	struct ieee80211_mgmt *mgmt;
 	u8 *pos, qos_info, *ie_start;
-	size_t offset = 0, noffset;
-	int i;
-	u16 capab;
+	size_t offset, noffset;
+	u16 capab = WLAN_CAPABILITY_ESS;
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	struct ieee80211_channel *chan;
@@ -955,7 +1096,7 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	enum nl80211_iftype iftype = ieee80211_vif_type_p2p(&sdata->vif);
 	const struct ieee80211_sband_iftype_data *iftd;
 	struct ieee80211_prep_tx_info info = {};
-	struct ieee80211_link_data *link = &sdata->deflink;
+	void *capab_pos;
 	int ret;
 
 	/* we know it's writable, cast away the const */
@@ -1003,23 +1144,18 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 
 	skb_reserve(skb, local->hw.extra_tx_headroom);
 
-	capab = WLAN_CAPABILITY_ESS;
-
-	if (sband->band == NL80211_BAND_2GHZ) {
-		capab |= WLAN_CAPABILITY_SHORT_SLOT_TIME;
-		capab |= WLAN_CAPABILITY_SHORT_PREAMBLE;
-	}
-
 	if (assoc_data->capability & WLAN_CAPABILITY_PRIVACY)
 		capab |= WLAN_CAPABILITY_PRIVACY;
 
-	if ((assoc_data->capability & WLAN_CAPABILITY_SPECTRUM_MGMT) &&
-	    ieee80211_hw_check(&local->hw, SPECTRUM_MGMT))
-		capab |= WLAN_CAPABILITY_SPECTRUM_MGMT;
-
 	if (ifmgd->flags & IEEE80211_STA_ENABLE_RRM)
 		capab |= WLAN_CAPABILITY_RADIO_MEASURE;
 
+	/* Set MBSSID support for HE AP if needed */
+	if (ieee80211_hw_check(&local->hw, SUPPORTS_ONLY_HE_MULTI_BSSID) &&
+	    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
+	    ext_capa && ext_capa->datalen >= 3)
+		ext_capa->data[2] |= WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT;
+
 	mgmt = skb_put_zero(skb, 24);
 	memcpy(mgmt->da, assoc_data->bss->bssid, ETH_ALEN);
 	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
@@ -1032,7 +1168,7 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		skb_put(skb, 10);
 		mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 						  IEEE80211_STYPE_REASSOC_REQ);
-		mgmt->u.reassoc_req.capab_info = cpu_to_le16(capab);
+		capab_pos = &mgmt->u.reassoc_req.capab_info;
 		mgmt->u.reassoc_req.listen_interval = listen_int;
 		memcpy(mgmt->u.reassoc_req.current_ap, assoc_data->prev_bssid,
 		       ETH_ALEN);
@@ -1041,7 +1177,7 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		skb_put(skb, 4);
 		mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
 						  IEEE80211_STYPE_ASSOC_REQ);
-		mgmt->u.assoc_req.capab_info = cpu_to_le16(capab);
+		capab_pos = &mgmt->u.assoc_req.capab_info;
 		mgmt->u.assoc_req.listen_interval = listen_int;
 		info.subtype = IEEE80211_STYPE_ASSOC_REQ;
 	}
@@ -1053,97 +1189,15 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 	*pos++ = assoc_data->ssid_len;
 	memcpy(pos, assoc_data->ssid, assoc_data->ssid_len);
 
-	if (sband->band != NL80211_BAND_S1GHZ)
-		ieee80211_assoc_add_rates(skb, chanctx_conf->def.width,
-					  sband, assoc_data);
-
-	if (capab & WLAN_CAPABILITY_SPECTRUM_MGMT ||
-	    capab & WLAN_CAPABILITY_RADIO_MEASURE) {
-		pos = skb_put(skb, 4);
-		*pos++ = WLAN_EID_PWR_CAPABILITY;
-		*pos++ = 2;
-		*pos++ = 0; /* min tx power */
-		 /* max tx power */
-		*pos++ = ieee80211_chandef_max_power(&chanctx_conf->def);
-	}
-
-	/*
-	 * Per spec, we shouldn't include the list of channels if we advertise
-	 * support for extended channel switching, but we've always done that;
-	 * (for now?) apply this restriction only on the (new) 6 GHz band.
-	 */
-	if (capab & WLAN_CAPABILITY_SPECTRUM_MGMT &&
-	    (sband->band != NL80211_BAND_6GHZ ||
-	     !ext_capa || ext_capa->datalen < 1 ||
-	     !(ext_capa->data[0] & WLAN_EXT_CAPA1_EXT_CHANNEL_SWITCHING))) {
-		/* TODO: get this in reg domain format */
-		pos = skb_put(skb, 2 * sband->n_channels + 2);
-		*pos++ = WLAN_EID_SUPPORTED_CHANNELS;
-		*pos++ = 2 * sband->n_channels;
-		for (i = 0; i < sband->n_channels; i++) {
-			int cf = sband->channels[i].center_freq;
-
-			*pos++ = ieee80211_frequency_to_channel(cf);
-			*pos++ = 1; /* one channel in the subband*/
-		}
-	}
-
-	/* Set MBSSID support for HE AP if needed */
-	if (ieee80211_hw_check(&local->hw, SUPPORTS_ONLY_HE_MULTI_BSSID) &&
-	    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
-	    ext_capa && ext_capa->datalen >= 3)
-		ext_capa->data[2] |= WLAN_EXT_CAPA3_MULTI_BSSID_SUPPORT;
-
-	/* if present, add any custom IEs that go before HT */
-	offset = ieee80211_add_before_ht_elems(skb, assoc_data->ie,
-					       assoc_data->ie_len,
-					       offset);
-
-	if (WARN_ON_ONCE((link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) &&
-			 !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)))
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-
-	if (sband->band != NL80211_BAND_6GHZ &&
-	    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT))
-		ieee80211_add_ht_ie(sdata, skb, assoc_data->ap_ht_param,
-				    sband, chan, link->smps_mode,
-				    link->u.mgd.conn_flags);
-
-	/* if present, add any custom IEs that go before VHT */
-	offset = ieee80211_add_before_vht_elems(skb, assoc_data->ie,
-						assoc_data->ie_len,
-						offset);
-
-	if (sband->band != NL80211_BAND_6GHZ &&
-	    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
-		link->conf->mu_mimo_owner =
-			ieee80211_add_vht_ie(sdata, skb, sband,
-					     &assoc_data->ap_vht_cap,
-					     link->u.mgd.conn_flags);
-
-	/*
-	 * If AP doesn't support HT, mark HE and EHT as disabled.
-	 * If on the 5GHz band, make sure it supports VHT.
-	 */
-	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT ||
-	    (sband->band == NL80211_BAND_5GHZ &&
-	     link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE |
-						   IEEE80211_CONN_DISABLE_EHT;
-
-	/* if present, add any custom IEs that go before HE */
-	offset = ieee80211_add_before_he_elems(skb, assoc_data->ie,
-					       assoc_data->ie_len,
-					       offset);
-
-	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE)) {
-		ieee80211_add_he_ie(sdata, skb, sband, link->u.mgd.conn_flags);
-
-		if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT))
-			ieee80211_add_eht_ie(sdata, skb, sband);
-	}
-
-	/* if present, add any custom non-vendor IEs that go after HE */
+	/* add the elements for the assoc (main) link */
+	offset = ieee80211_assoc_link_elems(sdata, skb, &capab,
+					    ext_capa,
+					    assoc_data->ie,
+					    assoc_data->ie_len,
+					    link);
+	put_unaligned_le16(capab, capab_pos);
+
+	/* if present, add any custom non-vendor IEs */
 	if (assoc_data->ie_len) {
 		noffset = ieee80211_ie_split_vendor(assoc_data->ie,
 						    assoc_data->ie_len,
@@ -1164,14 +1218,6 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		pos = ieee80211_add_wmm_info_ie(skb_put(skb, 9), qos_info);
 	}
 
-	if (sband->band == NL80211_BAND_S1GHZ) {
-		ieee80211_add_aid_request_ie(sdata, skb);
-		ieee80211_add_s1g_capab_ie(sdata, &sband->s1g_cap, skb);
-	}
-
-	if (iftd && iftd->vendor_elems.data && iftd->vendor_elems.len)
-		skb_put_data(skb, iftd->vendor_elems.data, iftd->vendor_elems.len);
-
 	/* add any remaining custom (i.e. vendor specific here) IEs */
 	if (assoc_data->ie_len) {
 		noffset = assoc_data->ie_len;
-- 
2.36.1

