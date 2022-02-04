Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCD44AA2BD
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 23:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344785AbiBDWDL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 17:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343564AbiBDWDH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 17:03:07 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0617C061714
        for <linux-wireless@vger.kernel.org>; Fri,  4 Feb 2022 14:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=FZDQwcmkGiA649ctpqvw3WhQ9DyyFCsnyFLB5WPQWcc=;
        t=1644012186; x=1645221786; b=TZBzlm+Q5Xpg1BIr1KxepGPpL/U3hd7bcehY6jS0hDOg8Bj
        x3Mt8LV8A1wTvCEvS6uIvGtSCCOSpINmuASCGuoNhBvftSTjAhxKxvbHQJrhFk+qHlQxQQ5ytCKLU
        ZNY9bkX0sofrpQMWjo5AapwIu5TWAT7cEmvewqMeCBPDhsAjqFIOry2j7qtJKZUV5Y+FiWqi6J4iX
        7RFTmkAr64VoxM/rkGu0N1viGAIr4y9CBn5rWTlosxLd9bEqYzWjIQZH2d5bpM0ox5OWADwPWI3pF
        7EsVmfWl+h1yO4SIPpD1AbC2aRo8CG/cwBHkTOI5N0k4JHBGE5O5S49sx5xyl52A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nG6fY-00EeJL-SX;
        Fri, 04 Feb 2022 23:03:04 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>,
        Ilan Peer <ilan.peer@intel.com>,
        Jia Ding <quic_jiad@quicinc.com>,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Sriram R <quic_srirrama@quicinc.com>
Subject: [PATCH 14/19] mac80211: Add EHT capabilities to association/probe request
Date:   Fri,  4 Feb 2022 23:02:50 +0100
Message-Id: <20220204230119.eead869a197f.I40d2ef06099cb091e9c2c01f8ef521b993a3d559@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204220255.448224-1-johannes@sipsolutions.net>
References: <20220204220255.448224-1-johannes@sipsolutions.net>
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

From: Ilan Peer <ilan.peer@intel.com>

Add the EHT capabilities element to both probe request and
association request frames, if advertised by the driver.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |   5 ++
 net/mac80211/main.c        |  14 ++++-
 net/mac80211/mlme.c        |  48 ++++++++++++++++-
 net/mac80211/util.c        | 104 +++++++++++++++++++++++++++++++++++++
 4 files changed, 169 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 6a93dfcaad21..39844267f09e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2520,4 +2520,9 @@ u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 void ieee80211_init_frag_cache(struct ieee80211_fragment_cache *cache);
 void ieee80211_destroy_frag_cache(struct ieee80211_fragment_cache *cache);
 
+u8 ieee80211_ie_len_eht_cap(struct ieee80211_sub_if_data *sdata, u8 iftype);
+u8 *ieee80211_ie_build_eht_cap(u8 *pos,
+			       const struct ieee80211_sta_he_cap *he_cap,
+			       const struct ieee80211_sta_eht_cap *eht_cap,
+			       u8 *end);
 #endif /* IEEE80211_I_H */
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 5311c3cd3050..a48a32f87897 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -909,7 +909,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	int result, i;
 	enum nl80211_band band;
 	int channels, max_bitrates;
-	bool supp_ht, supp_vht, supp_he;
+	bool supp_ht, supp_vht, supp_he, supp_eht;
 	struct cfg80211_chan_def dflt_chandef = {};
 
 	if (ieee80211_hw_check(hw, QUEUE_CONTROL) &&
@@ -978,6 +978,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 	supp_ht = false;
 	supp_vht = false;
 	supp_he = false;
+	supp_eht = false;
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
 		struct ieee80211_supported_band *sband;
 
@@ -1021,6 +1022,7 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 			iftd = &sband->iftype_data[i];
 
 			supp_he = supp_he || iftd->he_cap.has_he;
+			supp_eht = supp_eht || iftd->eht_cap.has_eht;
 		}
 
 		/* HT, VHT, HE require QoS, thus >= 4 queues */
@@ -1028,6 +1030,10 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 			    (supp_ht || supp_vht || supp_he)))
 			return -EINVAL;
 
+		/* EHT requires HE support */
+		if (WARN_ON(supp_eht && !supp_he))
+			return -EINVAL;
+
 		if (!sband->ht_cap.ht_supported)
 			continue;
 
@@ -1138,6 +1144,12 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 			3 + sizeof(struct ieee80211_he_cap_elem) +
 			sizeof(struct ieee80211_he_mcs_nss_supp) +
 			IEEE80211_HE_PPE_THRES_MAX_LEN;
+
+		if (supp_eht)
+			local->scan_ies_len +=
+				3 + sizeof(struct ieee80211_eht_cap_elem) +
+				sizeof(struct ieee80211_eht_mcs_nss_supp) +
+				IEEE80211_EHT_PPE_THRES_MAX_LEN;
 	}
 
 	if (!local->ops->hw_scan) {
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index dac0b495ae76..752aa8734af6 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -692,6 +692,48 @@ static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 	ieee80211_ie_build_he_6ghz_cap(sdata, skb);
 }
 
+static void ieee80211_add_eht_ie(struct ieee80211_sub_if_data *sdata,
+				 struct sk_buff *skb,
+				 struct ieee80211_supported_band *sband)
+{
+	u8 *pos;
+	const struct ieee80211_sta_he_cap *he_cap;
+	const struct ieee80211_sta_eht_cap *eht_cap;
+	struct ieee80211_chanctx_conf *chanctx_conf;
+	u8 eht_cap_size;
+	bool reg_cap = false;
+
+	rcu_read_lock();
+	chanctx_conf = rcu_dereference(sdata->vif.chanctx_conf);
+	if (!WARN_ON_ONCE(!chanctx_conf))
+		reg_cap = cfg80211_chandef_usable(sdata->wdev.wiphy,
+						  &chanctx_conf->def,
+						  IEEE80211_CHAN_NO_HE |
+						  IEEE80211_CHAN_NO_EHT);
+	rcu_read_unlock();
+
+	he_cap = ieee80211_get_he_iftype_cap(sband,
+					     ieee80211_vif_type_p2p(&sdata->vif));
+	eht_cap = ieee80211_get_eht_iftype_cap(sband,
+					       ieee80211_vif_type_p2p(&sdata->vif));
+
+	/*
+	 * EHT capabilities element is only added if the HE capabilities element
+	 * was added so assume that 'he_cap' is valid and don't check it.
+	 */
+	if (WARN_ON(!he_cap || !eht_cap || !reg_cap))
+		return;
+
+	eht_cap_size =
+		2 + 1 + sizeof(eht_cap->eht_cap_elem) +
+		ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
+					   &eht_cap->eht_cap_elem) +
+		ieee80211_eht_ppe_size(eht_cap->eht_ppe_thres[0],
+				       eht_cap->eht_cap_elem.phy_cap_info);
+	pos = skb_put(skb, eht_cap_size);
+	ieee80211_ie_build_eht_cap(pos, he_cap, eht_cap, pos + eht_cap_size);
+}
+
 static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
@@ -1020,9 +1062,13 @@ static void ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HE |
 			        IEEE80211_STA_DISABLE_EHT;
 
-	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE))
+	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE)) {
 		ieee80211_add_he_ie(sdata, skb, sband);
 
+		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_EHT))
+			ieee80211_add_eht_ie(sdata, skb, sband);
+	}
+
 	/* if present, add any custom non-vendor IEs that go after HE */
 	if (assoc_data->ie_len) {
 		noffset = ieee80211_ie_split_vendor(assoc_data->ie,
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 7f780551dfa7..812b70845fb8 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1809,6 +1809,7 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_supported_band *sband;
 	const struct ieee80211_sta_he_cap *he_cap;
+	const struct ieee80211_sta_eht_cap *eht_cap;
 	u8 *pos = buffer, *end = buffer + buffer_len;
 	size_t noffset;
 	int supp_rates_len, i;
@@ -1989,6 +1990,18 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 			goto out_err;
 	}
 
+	eht_cap = ieee80211_get_eht_iftype_cap(sband,
+					       ieee80211_vif_type_p2p(&sdata->vif));
+
+	if (eht_cap &&
+	    cfg80211_any_usable_channels(local->hw.wiphy, BIT(sband->band),
+					 IEEE80211_CHAN_NO_HE |
+					 IEEE80211_CHAN_NO_EHT)) {
+		pos = ieee80211_ie_build_eht_cap(pos, he_cap, eht_cap, end);
+		if (!pos)
+			goto out_err;
+	}
+
 	if (cfg80211_any_usable_channels(local->hw.wiphy,
 					 BIT(NL80211_BAND_6GHZ),
 					 IEEE80211_CHAN_NO_HE)) {
@@ -4737,3 +4750,94 @@ u16 ieee80211_encode_usf(int listen_interval)
 
 	return (u16) listen_interval;
 }
+
+u8 ieee80211_ie_len_eht_cap(struct ieee80211_sub_if_data *sdata, u8 iftype)
+{
+	const struct ieee80211_sta_he_cap *he_cap;
+	const struct ieee80211_sta_eht_cap *eht_cap;
+	struct ieee80211_supported_band *sband;
+	u8 n;
+
+	sband = ieee80211_get_sband(sdata);
+	if (!sband)
+		return 0;
+
+	he_cap = ieee80211_get_he_iftype_cap(sband, iftype);
+	eht_cap = ieee80211_get_eht_iftype_cap(sband, iftype);
+	if (!he_cap || !eht_cap)
+		return 0;
+
+	n = ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
+				       &eht_cap->eht_cap_elem);
+	return 2 + 1 +
+	       sizeof(he_cap->he_cap_elem) + n +
+	       ieee80211_eht_ppe_size(eht_cap->eht_ppe_thres[0],
+				      eht_cap->eht_cap_elem.phy_cap_info);
+	return 0;
+}
+
+u8 *ieee80211_ie_build_eht_cap(u8 *pos,
+			       const struct ieee80211_sta_he_cap *he_cap,
+			       const struct ieee80211_sta_eht_cap *eht_cap,
+			       u8 *end)
+{
+	u8 mcs_nss_len, ppet_len;
+	u8 ie_len;
+	u8 *orig_pos = pos;
+
+	/* Make sure we have place for the IE */
+	if (!he_cap || !eht_cap)
+		return orig_pos;
+
+	mcs_nss_len = ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
+						 &eht_cap->eht_cap_elem);
+	ppet_len = ieee80211_eht_ppe_size(eht_cap->eht_ppe_thres[0],
+					  eht_cap->eht_cap_elem.phy_cap_info);
+
+	ie_len = 2 + 1 + sizeof(eht_cap->eht_cap_elem) + mcs_nss_len + ppet_len;
+	if ((end - pos) < ie_len)
+		return orig_pos;
+
+	*pos++ = WLAN_EID_EXTENSION;
+	*pos++ = ie_len - 2;
+	*pos++ = WLAN_EID_EXT_EHT_CAPABILITY;
+
+	/* Fixed data */
+	memcpy(pos, &eht_cap->eht_cap_elem, sizeof(eht_cap->eht_cap_elem));
+	pos += sizeof(eht_cap->eht_cap_elem);
+
+	if (!(he_cap->he_cap_elem.phy_cap_info[0] &
+	      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_MASK_ALL)) {
+		memcpy(pos, &eht_cap->eht_mcs_nss_supp.only_20mhz,
+		       sizeof(eht_cap->eht_mcs_nss_supp.only_20mhz));
+		pos += sizeof(eht_cap->eht_mcs_nss_supp.only_20mhz);
+	} else {
+		if (he_cap->he_cap_elem.phy_cap_info[0] &
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G) {
+			memcpy(pos, &eht_cap->eht_mcs_nss_supp.bw_80,
+			       sizeof(eht_cap->eht_mcs_nss_supp.bw_80));
+			pos += sizeof(eht_cap->eht_mcs_nss_supp.bw_80);
+		}
+
+		if (he_cap->he_cap_elem.phy_cap_info[0] &
+		    IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G) {
+			memcpy(pos, &eht_cap->eht_mcs_nss_supp.bw_160,
+			       sizeof(eht_cap->eht_mcs_nss_supp.bw_160));
+			pos += sizeof(eht_cap->eht_mcs_nss_supp.bw_160);
+		}
+
+		if (eht_cap->eht_cap_elem.phy_cap_info[0] &
+		    IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ) {
+			memcpy(pos, &eht_cap->eht_mcs_nss_supp.bw_320,
+			       sizeof(eht_cap->eht_mcs_nss_supp.bw_320));
+			pos += sizeof(eht_cap->eht_mcs_nss_supp.bw_320);
+		}
+	}
+
+	if (ppet_len) {
+		memcpy(pos, &eht_cap->eht_ppe_thres, ppet_len);
+		pos += ppet_len;
+	}
+
+	return pos;
+}
-- 
2.34.1

