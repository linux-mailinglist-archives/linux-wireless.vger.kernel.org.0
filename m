Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76AC1E6B29
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 21:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406645AbgE1Tgu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 15:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406608AbgE1Tgq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 15:36:46 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16660C08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 12:36:46 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeOIq-0054OL-DL; Thu, 28 May 2020 21:34:56 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 13/24] mac80211: determine chandef from HE 6 GHz operation
Date:   Thu, 28 May 2020 21:34:36 +0200
Message-Id: <20200528213443.25687d2695bc.I3f9747c1147480f65445f13eda5c4a5ed4e86757@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528213443.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
References: <20200528213443.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Support connecting to HE 6 GHz APs and mesh networks on 6 GHz,
where the HT/VHT information is missing but instead the HE 6 GHz
band capability is present, and the 6 GHz Operation information
field is used to encode the channel configuration instead of the
HT/VHT operation elements.

Also add some other bits needed to connect to 6 GHz networks.

Link: https://lore.kernel.org/r/1589399105-25472-10-git-send-email-rmanohar@codeaurora.org
Co-developed-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |   3 ++
 net/mac80211/mesh.c        |   1 +
 net/mac80211/mlme.c        |  69 +++++++++++++++++-------
 net/mac80211/util.c        | 106 +++++++++++++++++++++++++++++++++++++
 4 files changed, 160 insertions(+), 19 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 0cc584574976..6cac5bf7cba3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2202,6 +2202,9 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw, u32 vht_cap_info,
 				const struct ieee80211_vht_operation *oper,
 				const struct ieee80211_ht_operation *htop,
 				struct cfg80211_chan_def *chandef);
+bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
+				    const struct ieee80211_he_operation *he_oper,
+				    struct cfg80211_chan_def *chandef);
 u32 ieee80211_chandef_downgrade(struct cfg80211_chan_def *c);
 
 int __must_check
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 696d6fb322e6..5f1ca25b6c97 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -104,6 +104,7 @@ bool mesh_matches_local(struct ieee80211_sub_if_data *sdata,
 	ieee80211_chandef_vht_oper(&sdata->local->hw, vht_cap_info,
 				   ie->vht_operation, ie->ht_operation,
 				   &sta_chan_def);
+	ieee80211_chandef_he_6ghz_oper(sdata, ie->he_operation, &sta_chan_def);
 
 	if (!cfg80211_chandef_compatible(&sdata->vif.bss_conf.chandef,
 					 &sta_chan_def))
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 1f9c48414c85..bc558d1d20fc 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -156,15 +156,24 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_sta_ht_cap sta_ht_cap;
 	u32 ht_cfreq, ret;
 
-	memcpy(&sta_ht_cap, &sband->ht_cap, sizeof(sta_ht_cap));
-	ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
-
 	memset(chandef, 0, sizeof(struct cfg80211_chan_def));
 	chandef->chan = channel;
 	chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
 	chandef->center_freq1 = channel->center_freq;
 	chandef->freq1_offset = channel->freq_offset;
 
+	if (channel->band == NL80211_BAND_6GHZ) {
+		if (!ieee80211_chandef_he_6ghz_oper(sdata, he_oper, chandef))
+			ret = IEEE80211_STA_DISABLE_HT |
+			      IEEE80211_STA_DISABLE_VHT |
+			      IEEE80211_STA_DISABLE_HE;
+		vht_chandef = *chandef;
+		goto out;
+	}
+
+	memcpy(&sta_ht_cap, &sband->ht_cap, sizeof(sta_ht_cap));
+	ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
+
 	if (!ht_oper || !sta_ht_cap.ht_supported) {
 		ret = IEEE80211_STA_DISABLE_HT |
 		      IEEE80211_STA_DISABLE_VHT |
@@ -914,7 +923,8 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 			 !(ifmgd->flags & IEEE80211_STA_DISABLE_VHT)))
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
 
-	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT))
+	if (sband->band != NL80211_BAND_6GHZ &&
+	    !(ifmgd->flags & IEEE80211_STA_DISABLE_HT))
 		ieee80211_add_ht_ie(sdata, skb, assoc_data->ap_ht_param,
 				    sband, chan, sdata->smps_mode);
 
@@ -968,7 +978,8 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		offset = noffset;
 	}
 
-	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
+	if (sband->band != NL80211_BAND_6GHZ &&
+	    !(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
 		ieee80211_add_vht_ie(sdata, skb, sband,
 				     &assoc_data->ap_vht_cap);
 
@@ -3248,6 +3259,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
 	const struct cfg80211_bss_ies *bss_ies = NULL;
 	struct ieee80211_mgd_assoc_data *assoc_data = ifmgd->assoc_data;
+	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
 	u32 changed = 0;
 	int err;
 	bool ret;
@@ -3289,11 +3301,12 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	 * 2G/3G/4G wifi routers, reported models include the "Onda PN51T",
 	 * "Vodafone PocketWiFi 2", "ZTE MF60" and a similar T-Mobile device.
 	 */
-	if ((assoc_data->wmm && !elems->wmm_param) ||
-	    (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT) &&
-	     (!elems->ht_cap_elem || !elems->ht_operation)) ||
-	    (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT) &&
-	     (!elems->vht_cap_elem || !elems->vht_operation))) {
+	if (!is_6ghz &&
+	    ((assoc_data->wmm && !elems->wmm_param) ||
+	     (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT) &&
+	      (!elems->ht_cap_elem || !elems->ht_operation)) ||
+	     (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT) &&
+	      (!elems->vht_cap_elem || !elems->vht_operation)))) {
 		const struct cfg80211_bss_ies *ies;
 		struct ieee802_11_elems bss_elems;
 
@@ -3351,7 +3364,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	 * We previously checked these in the beacon/probe response, so
 	 * they should be present here. This is just a safety net.
 	 */
-	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT) &&
+	if (!is_6ghz && !(ifmgd->flags & IEEE80211_STA_DISABLE_HT) &&
 	    (!elems->wmm_param || !elems->ht_cap_elem || !elems->ht_operation)) {
 		sdata_info(sdata,
 			   "HT AP is missing WMM params or HT capability/operation\n");
@@ -3359,7 +3372,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
-	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT) &&
+	if (!is_6ghz && !(ifmgd->flags & IEEE80211_STA_DISABLE_VHT) &&
 	    (!elems->vht_cap_elem || !elems->vht_operation)) {
 		sdata_info(sdata,
 			   "VHT AP is missing VHT capability/operation\n");
@@ -3367,6 +3380,14 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		goto out;
 	}
 
+	if (is_6ghz && !(ifmgd->flags & IEEE80211_STA_DISABLE_HE) &&
+	    !elems->he_6ghz_capa) {
+		sdata_info(sdata,
+			   "HE 6 GHz AP is missing HE 6 GHz band capability\n");
+		ret = false;
+		goto out;
+	}
+
 	mutex_lock(&sdata->local->sta_mtx);
 	/*
 	 * station info was already allocated and inserted before
@@ -4826,6 +4847,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 	const struct ieee80211_he_operation *he_oper = NULL;
 	struct ieee80211_supported_band *sband;
 	struct cfg80211_chan_def chandef;
+	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
 	struct ieee80211_bss *bss = (void *)cbss->priv;
 	int ret;
 	u32 i;
@@ -4838,21 +4860,23 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 			  IEEE80211_STA_DISABLE_160MHZ);
 
 	/* disable HT/VHT/HE if we don't support them */
-	if (!sband->ht_cap.ht_supported) {
+	if (!sband->ht_cap.ht_supported && !is_6ghz) {
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 	}
 
-	if (!sband->vht_cap.vht_supported)
+	if (!sband->vht_cap.vht_supported && !is_6ghz) {
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
+		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
+	}
 
 	if (!ieee80211_get_he_sta_cap(sband))
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 
 	rcu_read_lock();
 
-	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT)) {
+	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT) && !is_6ghz) {
 		const u8 *ht_oper_ie, *ht_cap_ie;
 
 		ht_oper_ie = ieee80211_bss_get_ie(cbss, WLAN_EID_HT_OPERATION);
@@ -4869,7 +4893,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT)) {
+	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT) && !is_6ghz) {
 		const u8 *vht_oper_ie, *vht_cap;
 
 		vht_oper_ie = ieee80211_bss_get_ie(cbss,
@@ -4934,6 +4958,11 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 	rcu_read_unlock();
 
+	if (ifmgd->flags & IEEE80211_STA_DISABLE_HE && is_6ghz) {
+		sdata_info(sdata, "Rejecting non-HE 6/7 GHz connection");
+		return -EINVAL;
+	}
+
 	/* will change later if needed */
 	sdata->smps_mode = IEEE80211_SMPS_OFF;
 
@@ -5315,6 +5344,7 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 			struct cfg80211_assoc_request *req)
 {
+	bool is_6ghz = req->bss->channel->band == NL80211_BAND_6GHZ;
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_bss *bss = (void *)req->bss->priv;
@@ -5457,14 +5487,15 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	if (ht_ie && ht_ie[1] >= sizeof(struct ieee80211_ht_operation))
 		assoc_data->ap_ht_param =
 			((struct ieee80211_ht_operation *)(ht_ie + 2))->ht_param;
-	else
+	else if (!is_6ghz)
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
 	vht_ie = ieee80211_bss_get_ie(req->bss, WLAN_EID_VHT_CAPABILITY);
 	if (vht_ie && vht_ie[1] >= sizeof(struct ieee80211_vht_cap))
 		memcpy(&assoc_data->ap_vht_cap, vht_ie + 2,
 		       sizeof(struct ieee80211_vht_cap));
-	else
-		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
+	else if (!is_6ghz)
+		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT |
+				IEEE80211_STA_DISABLE_HE;
 	rcu_read_unlock();
 
 	if (WARN((sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_UAPSD) &&
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index e6104829fa1c..cbe24d303f0d 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3244,6 +3244,112 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw, u32 vht_cap_info,
 	return true;
 }
 
+bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
+				    const struct ieee80211_he_operation *he_oper,
+				    struct cfg80211_chan_def *chandef)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_supported_band *sband;
+	enum nl80211_iftype iftype = ieee80211_vif_type_p2p(&sdata->vif);
+	const struct ieee80211_sta_he_cap *he_cap;
+	struct cfg80211_chan_def he_chandef = *chandef;
+	const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
+	bool support_80_80, support_160;
+	u8 he_phy_cap;
+	u32 freq;
+
+	if (chandef->chan->band != NL80211_BAND_6GHZ)
+		return true;
+
+	sband = local->hw.wiphy->bands[NL80211_BAND_6GHZ];
+
+	he_cap = ieee80211_get_he_iftype_cap(sband, iftype);
+	if (!he_cap) {
+		sdata_info(sdata, "Missing iftype sband data/HE cap");
+		return false;
+	}
+
+	he_phy_cap = he_cap->he_cap_elem.phy_cap_info[0];
+	support_160 =
+		he_phy_cap &
+		IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+	support_80_80 =
+		he_phy_cap &
+		IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G;
+
+	if (!he_oper) {
+		sdata_info(sdata,
+			   "HE is not advertised on (on %d MHz), expect issues\n",
+			   chandef->chan->center_freq);
+		return false;
+	}
+
+	he_6ghz_oper = ieee80211_he_6ghz_oper(he_oper);
+
+	if (!he_6ghz_oper) {
+		sdata_info(sdata,
+			   "HE 6GHz operation missing (on %d MHz), expect issues\n",
+			   chandef->chan->center_freq);
+		return false;
+	}
+
+	freq = ieee80211_channel_to_frequency(he_6ghz_oper->primary,
+					      NL80211_BAND_6GHZ);
+	he_chandef.chan = ieee80211_get_channel(sdata->local->hw.wiphy, freq);
+
+	switch (u8_get_bits(he_6ghz_oper->control,
+			    IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH)) {
+	case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_20MHZ:
+		he_chandef.width = NL80211_CHAN_WIDTH_20;
+		break;
+	case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_40MHZ:
+		he_chandef.width = NL80211_CHAN_WIDTH_40;
+		break;
+	case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_80MHZ:
+		he_chandef.width = NL80211_CHAN_WIDTH_80;
+		break;
+	case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_160MHZ:
+		he_chandef.width = NL80211_CHAN_WIDTH_80;
+		if (!he_6ghz_oper->ccfs1)
+			break;
+		if (abs(he_6ghz_oper->ccfs1 - he_6ghz_oper->ccfs0) == 8) {
+			if (support_160)
+				he_chandef.width = NL80211_CHAN_WIDTH_160;
+		} else {
+			if (support_80_80)
+				he_chandef.width = NL80211_CHAN_WIDTH_80P80;
+		}
+		break;
+	}
+
+	if (he_chandef.width == NL80211_CHAN_WIDTH_160) {
+		he_chandef.center_freq1 =
+			ieee80211_channel_to_frequency(he_6ghz_oper->ccfs1,
+						       NL80211_BAND_6GHZ);
+	} else {
+		he_chandef.center_freq1 =
+			ieee80211_channel_to_frequency(he_6ghz_oper->ccfs0,
+						       NL80211_BAND_6GHZ);
+		he_chandef.center_freq2 =
+			ieee80211_channel_to_frequency(he_6ghz_oper->ccfs1,
+						       NL80211_BAND_6GHZ);
+	}
+
+	if (!cfg80211_chandef_valid(&he_chandef)) {
+		sdata_info(sdata,
+			   "HE 6GHz operation resulted in invalid chandef: %d MHz/%d/%d MHz/%d MHz\n",
+			   he_chandef.chan ? he_chandef.chan->center_freq : 0,
+			   he_chandef.width,
+			   he_chandef.center_freq1,
+			   he_chandef.center_freq2);
+		return false;
+	}
+
+	*chandef = he_chandef;
+
+	return true;
+}
+
 int ieee80211_parse_bitrates(struct cfg80211_chan_def *chandef,
 			     const struct ieee80211_supported_band *sband,
 			     const u8 *srates, int srates_len, u32 *rates)
-- 
2.26.2

