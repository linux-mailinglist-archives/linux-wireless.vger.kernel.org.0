Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3874573A43
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbiGMPe4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236956AbiGMPeo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:44 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCBE4C629
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=jVVwoo5aETTzk3HglV68XdYAH54lURre97D4ulQln0E=;
        t=1657726482; x=1658936082; b=rq8MJfKjEziUxNYeInueC8Gw+bSPcXqdVu3FzGtQs9mZuoa
        CszBUonGzqVn8A9tJIzstHtFVzpsw2SqVD+Ozc2ZLpv3+M9Ti54mp0PmHwaVf1kpMtjPIJpps2Y7F
        pW3bKAsIJslori/6qDiRERgLeLRcYoX6O+WHiv007N4tYDkKKHaeKq6Z8I8zTlmn8mSfESxPmYXiN
        sDBQPFEl1QhK3W8nkAQEjenal6zezpSb8mcFPPl699F6BesXVraPXCCFHUCbQenPT2H79XrYn3kB+
        x8+Sbr6bLcnfV1J6etRCl/Tli9WivBns9cNvvJE3i4HosZ1/+qqq4Dg7LwXb9JpQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNr-00EnaA-Vs;
        Wed, 13 Jul 2022 17:34:40 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 11/21] wifi: mac80211: mlme: shift some code around
Date:   Wed, 13 Jul 2022 17:34:23 +0200
Message-Id: <20220713173301.844f9be241c0.I26f763e5fe6fb7cb38ad38915642086a9c4a21a7@changeid>
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

We'll need ieee80211_prep_channel() in other code for MLO
later, so move the code up - unchanged for now - to avoid
forward declarations in the future.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 1002 ++++++++++++++++++++++---------------------
 1 file changed, 509 insertions(+), 493 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 78b8fcd5fdb2..3b4d0bc35b5d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3545,6 +3545,515 @@ static int ieee80211_mgd_setup_link_sta(struct ieee80211_link_data *link,
 	return 0;
 }
 
+static u8 ieee80211_max_rx_chains(struct ieee80211_link_data *link,
+				  struct cfg80211_bss *cbss)
+{
+	struct ieee80211_he_mcs_nss_supp *he_mcs_nss_supp;
+	const struct element *ht_cap_elem, *vht_cap_elem;
+	const struct cfg80211_bss_ies *ies;
+	const struct ieee80211_ht_cap *ht_cap;
+	const struct ieee80211_vht_cap *vht_cap;
+	const struct ieee80211_he_cap_elem *he_cap;
+	const struct element *he_cap_elem;
+	u16 mcs_80_map, mcs_160_map;
+	int i, mcs_nss_size;
+	bool support_160;
+	u8 chains = 1;
+
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)
+		return chains;
+
+	ht_cap_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_HT_CAPABILITY);
+	if (ht_cap_elem && ht_cap_elem->datalen >= sizeof(*ht_cap)) {
+		ht_cap = (void *)ht_cap_elem->data;
+		chains = ieee80211_mcs_to_chains(&ht_cap->mcs);
+		/*
+		 * TODO: use "Tx Maximum Number Spatial Streams Supported" and
+		 *	 "Tx Unequal Modulation Supported" fields.
+		 */
+	}
+
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)
+		return chains;
+
+	vht_cap_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_VHT_CAPABILITY);
+	if (vht_cap_elem && vht_cap_elem->datalen >= sizeof(*vht_cap)) {
+		u8 nss;
+		u16 tx_mcs_map;
+
+		vht_cap = (void *)vht_cap_elem->data;
+		tx_mcs_map = le16_to_cpu(vht_cap->supp_mcs.tx_mcs_map);
+		for (nss = 8; nss > 0; nss--) {
+			if (((tx_mcs_map >> (2 * (nss - 1))) & 3) !=
+					IEEE80211_VHT_MCS_NOT_SUPPORTED)
+				break;
+		}
+		/* TODO: use "Tx Highest Supported Long GI Data Rate" field? */
+		chains = max(chains, nss);
+	}
+
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE)
+		return chains;
+
+	ies = rcu_dereference(cbss->ies);
+	he_cap_elem = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY,
+					     ies->data, ies->len);
+
+	if (!he_cap_elem || he_cap_elem->datalen < sizeof(*he_cap))
+		return chains;
+
+	/* skip one byte ext_tag_id */
+	he_cap = (void *)(he_cap_elem->data + 1);
+	mcs_nss_size = ieee80211_he_mcs_nss_size(he_cap);
+
+	/* invalid HE IE */
+	if (he_cap_elem->datalen < 1 + mcs_nss_size + sizeof(*he_cap))
+		return chains;
+
+	/* mcs_nss is right after he_cap info */
+	he_mcs_nss_supp = (void *)(he_cap + 1);
+
+	mcs_80_map = le16_to_cpu(he_mcs_nss_supp->tx_mcs_80);
+
+	for (i = 7; i >= 0; i--) {
+		u8 mcs_80 = mcs_80_map >> (2 * i) & 3;
+
+		if (mcs_80 != IEEE80211_VHT_MCS_NOT_SUPPORTED) {
+			chains = max_t(u8, chains, i + 1);
+			break;
+		}
+	}
+
+	support_160 = he_cap->phy_cap_info[0] &
+		      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
+
+	if (!support_160)
+		return chains;
+
+	mcs_160_map = le16_to_cpu(he_mcs_nss_supp->tx_mcs_160);
+	for (i = 7; i >= 0; i--) {
+		u8 mcs_160 = mcs_160_map >> (2 * i) & 3;
+
+		if (mcs_160 != IEEE80211_VHT_MCS_NOT_SUPPORTED) {
+			chains = max_t(u8, chains, i + 1);
+			break;
+		}
+	}
+
+	return chains;
+}
+
+static bool
+ieee80211_verify_peer_he_mcs_support(struct ieee80211_sub_if_data *sdata,
+				     const struct cfg80211_bss_ies *ies,
+				     const struct ieee80211_he_operation *he_op)
+{
+	const struct element *he_cap_elem;
+	const struct ieee80211_he_cap_elem *he_cap;
+	struct ieee80211_he_mcs_nss_supp *he_mcs_nss_supp;
+	u16 mcs_80_map_tx, mcs_80_map_rx;
+	u16 ap_min_req_set;
+	int mcs_nss_size;
+	int nss;
+
+	he_cap_elem = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY,
+					     ies->data, ies->len);
+
+	/* invalid HE IE */
+	if (!he_cap_elem || he_cap_elem->datalen < 1 + sizeof(*he_cap)) {
+		sdata_info(sdata,
+			   "Invalid HE elem, Disable HE\n");
+		return false;
+	}
+
+	/* skip one byte ext_tag_id */
+	he_cap = (void *)(he_cap_elem->data + 1);
+	mcs_nss_size = ieee80211_he_mcs_nss_size(he_cap);
+
+	/* invalid HE IE */
+	if (he_cap_elem->datalen < 1 + sizeof(*he_cap) + mcs_nss_size) {
+		sdata_info(sdata,
+			   "Invalid HE elem with nss size, Disable HE\n");
+		return false;
+	}
+
+	/* mcs_nss is right after he_cap info */
+	he_mcs_nss_supp = (void *)(he_cap + 1);
+
+	mcs_80_map_tx = le16_to_cpu(he_mcs_nss_supp->tx_mcs_80);
+	mcs_80_map_rx = le16_to_cpu(he_mcs_nss_supp->rx_mcs_80);
+
+	/* P802.11-REVme/D0.3
+	 * 27.1.1 Introduction to the HE PHY
+	 * ...
+	 * An HE STA shall support the following features:
+	 * ...
+	 * Single spatial stream HE-MCSs 0 to 7 (transmit and receive) in all
+	 * supported channel widths for HE SU PPDUs
+	 */
+	if ((mcs_80_map_tx & 0x3) == IEEE80211_HE_MCS_NOT_SUPPORTED ||
+	    (mcs_80_map_rx & 0x3) == IEEE80211_HE_MCS_NOT_SUPPORTED) {
+		sdata_info(sdata,
+			   "Missing mandatory rates for 1 Nss, rx 0x%x, tx 0x%x, disable HE\n",
+			   mcs_80_map_tx, mcs_80_map_rx);
+		return false;
+	}
+
+	if (!he_op)
+		return true;
+
+	ap_min_req_set = le16_to_cpu(he_op->he_mcs_nss_set);
+
+	/*
+	 * Apparently iPhone 13 (at least iOS version 15.3.1) sets this to all
+	 * zeroes, which is nonsense, and completely inconsistent with itself
+	 * (it doesn't have 8 streams). Accept the settings in this case anyway.
+	 */
+	if (!ap_min_req_set)
+		return true;
+
+	/* make sure the AP is consistent with itself
+	 *
+	 * P802.11-REVme/D0.3
+	 * 26.17.1 Basic HE BSS operation
+	 *
+	 * A STA that is operating in an HE BSS shall be able to receive and
+	 * transmit at each of the <HE-MCS, NSS> tuple values indicated by the
+	 * Basic HE-MCS And NSS Set field of the HE Operation parameter of the
+	 * MLME-START.request primitive and shall be able to receive at each of
+	 * the <HE-MCS, NSS> tuple values indicated by the Supported HE-MCS and
+	 * NSS Set field in the HE Capabilities parameter of the MLMESTART.request
+	 * primitive
+	 */
+	for (nss = 8; nss > 0; nss--) {
+		u8 ap_op_val = (ap_min_req_set >> (2 * (nss - 1))) & 3;
+		u8 ap_rx_val;
+		u8 ap_tx_val;
+
+		if (ap_op_val == IEEE80211_HE_MCS_NOT_SUPPORTED)
+			continue;
+
+		ap_rx_val = (mcs_80_map_rx >> (2 * (nss - 1))) & 3;
+		ap_tx_val = (mcs_80_map_tx >> (2 * (nss - 1))) & 3;
+
+		if (ap_rx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
+		    ap_tx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
+		    ap_rx_val < ap_op_val || ap_tx_val < ap_op_val) {
+			sdata_info(sdata,
+				   "Invalid rates for %d Nss, rx %d, tx %d oper %d, disable HE\n",
+				   nss, ap_rx_val, ap_rx_val, ap_op_val);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static bool
+ieee80211_verify_sta_he_mcs_support(struct ieee80211_sub_if_data *sdata,
+				    struct ieee80211_supported_band *sband,
+				    const struct ieee80211_he_operation *he_op)
+{
+	const struct ieee80211_sta_he_cap *sta_he_cap =
+		ieee80211_get_he_iftype_cap(sband,
+					    ieee80211_vif_type_p2p(&sdata->vif));
+	u16 ap_min_req_set;
+	int i;
+
+	if (!sta_he_cap || !he_op)
+		return false;
+
+	ap_min_req_set = le16_to_cpu(he_op->he_mcs_nss_set);
+
+	/*
+	 * Apparently iPhone 13 (at least iOS version 15.3.1) sets this to all
+	 * zeroes, which is nonsense, and completely inconsistent with itself
+	 * (it doesn't have 8 streams). Accept the settings in this case anyway.
+	 */
+	if (!ap_min_req_set)
+		return true;
+
+	/* Need to go over for 80MHz, 160MHz and for 80+80 */
+	for (i = 0; i < 3; i++) {
+		const struct ieee80211_he_mcs_nss_supp *sta_mcs_nss_supp =
+			&sta_he_cap->he_mcs_nss_supp;
+		u16 sta_mcs_map_rx =
+			le16_to_cpu(((__le16 *)sta_mcs_nss_supp)[2 * i]);
+		u16 sta_mcs_map_tx =
+			le16_to_cpu(((__le16 *)sta_mcs_nss_supp)[2 * i + 1]);
+		u8 nss;
+		bool verified = true;
+
+		/*
+		 * For each band there is a maximum of 8 spatial streams
+		 * possible. Each of the sta_mcs_map_* is a 16-bit struct built
+		 * of 2 bits per NSS (1-8), with the values defined in enum
+		 * ieee80211_he_mcs_support. Need to make sure STA TX and RX
+		 * capabilities aren't less than the AP's minimum requirements
+		 * for this HE BSS per SS.
+		 * It is enough to find one such band that meets the reqs.
+		 */
+		for (nss = 8; nss > 0; nss--) {
+			u8 sta_rx_val = (sta_mcs_map_rx >> (2 * (nss - 1))) & 3;
+			u8 sta_tx_val = (sta_mcs_map_tx >> (2 * (nss - 1))) & 3;
+			u8 ap_val = (ap_min_req_set >> (2 * (nss - 1))) & 3;
+
+			if (ap_val == IEEE80211_HE_MCS_NOT_SUPPORTED)
+				continue;
+
+			/*
+			 * Make sure the HE AP doesn't require MCSs that aren't
+			 * supported by the client as required by spec
+			 *
+			 * P802.11-REVme/D0.3
+			 * 26.17.1 Basic HE BSS operation
+			 *
+			 * An HE STA shall not attempt to join * (MLME-JOIN.request primitive)
+			 * a BSS, unless it supports (i.e., is able to both transmit and
+			 * receive using) all of the <HE-MCS, NSS> tuples in the basic
+			 * HE-MCS and NSS set.
+			 */
+			if (sta_rx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
+			    sta_tx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
+			    (ap_val > sta_rx_val) || (ap_val > sta_tx_val)) {
+				verified = false;
+				break;
+			}
+		}
+
+		if (verified)
+			return true;
+	}
+
+	/* If here, STA doesn't meet AP's HE min requirements */
+	return false;
+}
+
+static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
+				  struct ieee80211_link_data *link,
+				  struct cfg80211_bss *cbss)
+{
+	struct ieee80211_local *local = sdata->local;
+	const struct ieee80211_ht_cap *ht_cap = NULL;
+	const struct ieee80211_ht_operation *ht_oper = NULL;
+	const struct ieee80211_vht_operation *vht_oper = NULL;
+	const struct ieee80211_he_operation *he_oper = NULL;
+	const struct ieee80211_eht_operation *eht_oper = NULL;
+	const struct ieee80211_s1g_oper_ie *s1g_oper = NULL;
+	struct ieee80211_supported_band *sband;
+	struct cfg80211_chan_def chandef;
+	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
+	bool is_5ghz = cbss->channel->band == NL80211_BAND_5GHZ;
+	struct ieee80211_bss *bss = (void *)cbss->priv;
+	struct ieee802_11_elems *elems;
+	const struct cfg80211_bss_ies *ies;
+	int ret;
+	u32 i;
+	bool have_80mhz;
+
+	rcu_read_lock();
+
+	ies = rcu_dereference(cbss->ies);
+	elems = ieee802_11_parse_elems(ies->data, ies->len, false, cbss);
+	if (!elems) {
+		rcu_read_unlock();
+		return -ENOMEM;
+	}
+
+	sband = local->hw.wiphy->bands[cbss->channel->band];
+
+	link->u.mgd.conn_flags &= ~(IEEE80211_CONN_DISABLE_40MHZ |
+					     IEEE80211_CONN_DISABLE_80P80MHZ |
+					     IEEE80211_CONN_DISABLE_160MHZ);
+
+	/* disable HT/VHT/HE if we don't support them */
+	if (!sband->ht_cap.ht_supported && !is_6ghz) {
+		mlme_dbg(sdata, "HT not supported, disabling HT/VHT/HE/EHT\n");
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+	}
+
+	if (!sband->vht_cap.vht_supported && is_5ghz) {
+		mlme_dbg(sdata, "VHT not supported, disabling VHT/HE/EHT\n");
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+	}
+
+	if (!ieee80211_get_he_iftype_cap(sband,
+					 ieee80211_vif_type_p2p(&sdata->vif))) {
+		mlme_dbg(sdata, "HE not supported, disabling HE and EHT\n");
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+	}
+
+	if (!ieee80211_get_eht_iftype_cap(sband,
+					  ieee80211_vif_type_p2p(&sdata->vif))) {
+		mlme_dbg(sdata, "EHT not supported, disabling EHT\n");
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+	}
+
+	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) && !is_6ghz) {
+		ht_oper = elems->ht_operation;
+		ht_cap = elems->ht_cap_elem;
+
+		if (!ht_cap) {
+			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
+			ht_oper = NULL;
+		}
+	}
+
+	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) && !is_6ghz) {
+		vht_oper = elems->vht_operation;
+		if (vht_oper && !ht_oper) {
+			vht_oper = NULL;
+			sdata_info(sdata,
+				   "AP advertised VHT without HT, disabling HT/VHT/HE\n");
+			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
+			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
+			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
+		}
+
+		if (!elems->vht_cap_elem) {
+			sdata_info(sdata,
+				   "bad VHT capabilities, disabling VHT\n");
+			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+			vht_oper = NULL;
+		}
+	}
+
+	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE)) {
+		he_oper = elems->he_operation;
+
+		if (is_6ghz) {
+			struct ieee80211_bss_conf *bss_conf;
+			u8 j = 0;
+
+			bss_conf = link->conf;
+
+			if (elems->pwr_constr_elem)
+				bss_conf->pwr_reduction = *elems->pwr_constr_elem;
+
+			BUILD_BUG_ON(ARRAY_SIZE(bss_conf->tx_pwr_env) !=
+				     ARRAY_SIZE(elems->tx_pwr_env));
+
+			for (i = 0; i < elems->tx_pwr_env_num; i++) {
+				if (elems->tx_pwr_env_len[i] >
+				    sizeof(bss_conf->tx_pwr_env[j]))
+					continue;
+
+				bss_conf->tx_pwr_env_num++;
+				memcpy(&bss_conf->tx_pwr_env[j], elems->tx_pwr_env[i],
+				       elems->tx_pwr_env_len[i]);
+				j++;
+			}
+		}
+
+		if (!ieee80211_verify_peer_he_mcs_support(sdata, ies, he_oper) ||
+		    !ieee80211_verify_sta_he_mcs_support(sdata, sband, he_oper))
+			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE |
+						  IEEE80211_CONN_DISABLE_EHT;
+	}
+
+	/*
+	 * EHT requires HE to be supported as well. Specifically for 6 GHz
+	 * channels, the operation channel information can only be deduced from
+	 * both the 6 GHz operation information (from the HE operation IE) and
+	 * EHT operation.
+	 */
+	if (!(link->u.mgd.conn_flags &
+			(IEEE80211_CONN_DISABLE_HE |
+			 IEEE80211_CONN_DISABLE_EHT)) &&
+	    he_oper) {
+		const struct cfg80211_bss_ies *cbss_ies;
+		const u8 *eht_oper_ie;
+
+		cbss_ies = rcu_dereference(cbss->ies);
+		eht_oper_ie = cfg80211_find_ext_ie(WLAN_EID_EXT_EHT_OPERATION,
+						   cbss_ies->data, cbss_ies->len);
+		if (eht_oper_ie && eht_oper_ie[1] >=
+		    1 + sizeof(struct ieee80211_eht_operation))
+			eht_oper = (void *)(eht_oper_ie + 3);
+		else
+			eht_oper = NULL;
+	}
+
+	/* Allow VHT if at least one channel on the sband supports 80 MHz */
+	have_80mhz = false;
+	for (i = 0; i < sband->n_channels; i++) {
+		if (sband->channels[i].flags & (IEEE80211_CHAN_DISABLED |
+						IEEE80211_CHAN_NO_80MHZ))
+			continue;
+
+		have_80mhz = true;
+		break;
+	}
+
+	if (!have_80mhz) {
+		sdata_info(sdata, "80 MHz not supported, disabling VHT\n");
+		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
+	}
+
+	if (sband->band == NL80211_BAND_S1GHZ) {
+		s1g_oper = elems->s1g_oper;
+		if (!s1g_oper)
+			sdata_info(sdata,
+				   "AP missing S1G operation element?\n");
+	}
+
+	link->u.mgd.conn_flags |=
+		ieee80211_determine_chantype(link, sband,
+					     cbss->channel,
+					     bss->vht_cap_info,
+					     ht_oper, vht_oper,
+					     he_oper, eht_oper,
+					     s1g_oper,
+					     &chandef, false);
+
+	link->needed_rx_chains =
+		min(ieee80211_max_rx_chains(link, cbss), local->rx_chains);
+
+	rcu_read_unlock();
+	/* the element data was RCU protected so no longer valid anyway */
+	kfree(elems);
+	elems = NULL;
+
+	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE && is_6ghz) {
+		sdata_info(sdata, "Rejecting non-HE 6/7 GHz connection");
+		return -EINVAL;
+	}
+
+	/* will change later if needed */
+	link->smps_mode = IEEE80211_SMPS_OFF;
+
+	mutex_lock(&local->mtx);
+	/*
+	 * If this fails (possibly due to channel context sharing
+	 * on incompatible channels, e.g. 80+80 and 160 sharing the
+	 * same control channel) try to use a smaller bandwidth.
+	 */
+	ret = ieee80211_link_use_channel(link, &chandef,
+					 IEEE80211_CHANCTX_SHARED);
+
+	/* don't downgrade for 5 and 10 MHz channels, though. */
+	if (chandef.width == NL80211_CHAN_WIDTH_5 ||
+	    chandef.width == NL80211_CHAN_WIDTH_10)
+		goto out;
+
+	while (ret && chandef.width != NL80211_CHAN_WIDTH_20_NOHT) {
+		link->u.mgd.conn_flags |=
+			ieee80211_chandef_downgrade(&chandef);
+		ret = ieee80211_link_use_channel(link, &chandef,
+						 IEEE80211_CHANCTX_SHARED);
+	}
+ out:
+	mutex_unlock(&local->mtx);
+	return ret;
+}
+
 static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 				    struct cfg80211_bss *cbss,
 				    struct ieee80211_mgmt *mgmt, size_t len,
@@ -5243,499 +5752,6 @@ void ieee80211_mlme_notify_scan_completed(struct ieee80211_local *local)
 	rcu_read_unlock();
 }
 
-static u8 ieee80211_max_rx_chains(struct ieee80211_link_data *link,
-				  struct cfg80211_bss *cbss)
-{
-	struct ieee80211_he_mcs_nss_supp *he_mcs_nss_supp;
-	const struct element *ht_cap_elem, *vht_cap_elem;
-	const struct cfg80211_bss_ies *ies;
-	const struct ieee80211_ht_cap *ht_cap;
-	const struct ieee80211_vht_cap *vht_cap;
-	const struct ieee80211_he_cap_elem *he_cap;
-	const struct element *he_cap_elem;
-	u16 mcs_80_map, mcs_160_map;
-	int i, mcs_nss_size;
-	bool support_160;
-	u8 chains = 1;
-
-	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)
-		return chains;
-
-	ht_cap_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_HT_CAPABILITY);
-	if (ht_cap_elem && ht_cap_elem->datalen >= sizeof(*ht_cap)) {
-		ht_cap = (void *)ht_cap_elem->data;
-		chains = ieee80211_mcs_to_chains(&ht_cap->mcs);
-		/*
-		 * TODO: use "Tx Maximum Number Spatial Streams Supported" and
-		 *	 "Tx Unequal Modulation Supported" fields.
-		 */
-	}
-
-	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)
-		return chains;
-
-	vht_cap_elem = ieee80211_bss_get_elem(cbss, WLAN_EID_VHT_CAPABILITY);
-	if (vht_cap_elem && vht_cap_elem->datalen >= sizeof(*vht_cap)) {
-		u8 nss;
-		u16 tx_mcs_map;
-
-		vht_cap = (void *)vht_cap_elem->data;
-		tx_mcs_map = le16_to_cpu(vht_cap->supp_mcs.tx_mcs_map);
-		for (nss = 8; nss > 0; nss--) {
-			if (((tx_mcs_map >> (2 * (nss - 1))) & 3) !=
-					IEEE80211_VHT_MCS_NOT_SUPPORTED)
-				break;
-		}
-		/* TODO: use "Tx Highest Supported Long GI Data Rate" field? */
-		chains = max(chains, nss);
-	}
-
-	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE)
-		return chains;
-
-	ies = rcu_dereference(cbss->ies);
-	he_cap_elem = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY,
-					     ies->data, ies->len);
-
-	if (!he_cap_elem || he_cap_elem->datalen < sizeof(*he_cap))
-		return chains;
-
-	/* skip one byte ext_tag_id */
-	he_cap = (void *)(he_cap_elem->data + 1);
-	mcs_nss_size = ieee80211_he_mcs_nss_size(he_cap);
-
-	/* invalid HE IE */
-	if (he_cap_elem->datalen < 1 + mcs_nss_size + sizeof(*he_cap))
-		return chains;
-
-	/* mcs_nss is right after he_cap info */
-	he_mcs_nss_supp = (void *)(he_cap + 1);
-
-	mcs_80_map = le16_to_cpu(he_mcs_nss_supp->tx_mcs_80);
-
-	for (i = 7; i >= 0; i--) {
-		u8 mcs_80 = mcs_80_map >> (2 * i) & 3;
-
-		if (mcs_80 != IEEE80211_VHT_MCS_NOT_SUPPORTED) {
-			chains = max_t(u8, chains, i + 1);
-			break;
-		}
-	}
-
-	support_160 = he_cap->phy_cap_info[0] &
-		      IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G;
-
-	if (!support_160)
-		return chains;
-
-	mcs_160_map = le16_to_cpu(he_mcs_nss_supp->tx_mcs_160);
-	for (i = 7; i >= 0; i--) {
-		u8 mcs_160 = mcs_160_map >> (2 * i) & 3;
-
-		if (mcs_160 != IEEE80211_VHT_MCS_NOT_SUPPORTED) {
-			chains = max_t(u8, chains, i + 1);
-			break;
-		}
-	}
-
-	return chains;
-}
-
-static bool
-ieee80211_verify_peer_he_mcs_support(struct ieee80211_sub_if_data *sdata,
-				     const struct cfg80211_bss_ies *ies,
-				     const struct ieee80211_he_operation *he_op)
-{
-	const struct element *he_cap_elem;
-	const struct ieee80211_he_cap_elem *he_cap;
-	struct ieee80211_he_mcs_nss_supp *he_mcs_nss_supp;
-	u16 mcs_80_map_tx, mcs_80_map_rx;
-	u16 ap_min_req_set;
-	int mcs_nss_size;
-	int nss;
-
-	he_cap_elem = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY,
-					     ies->data, ies->len);
-
-	/* invalid HE IE */
-	if (!he_cap_elem || he_cap_elem->datalen < 1 + sizeof(*he_cap)) {
-		sdata_info(sdata,
-			   "Invalid HE elem, Disable HE\n");
-		return false;
-	}
-
-	/* skip one byte ext_tag_id */
-	he_cap = (void *)(he_cap_elem->data + 1);
-	mcs_nss_size = ieee80211_he_mcs_nss_size(he_cap);
-
-	/* invalid HE IE */
-	if (he_cap_elem->datalen < 1 + sizeof(*he_cap) + mcs_nss_size) {
-		sdata_info(sdata,
-			   "Invalid HE elem with nss size, Disable HE\n");
-		return false;
-	}
-
-	/* mcs_nss is right after he_cap info */
-	he_mcs_nss_supp = (void *)(he_cap + 1);
-
-	mcs_80_map_tx = le16_to_cpu(he_mcs_nss_supp->tx_mcs_80);
-	mcs_80_map_rx = le16_to_cpu(he_mcs_nss_supp->rx_mcs_80);
-
-	/* P802.11-REVme/D0.3
-	 * 27.1.1 Introduction to the HE PHY
-	 * ...
-	 * An HE STA shall support the following features:
-	 * ...
-	 * Single spatial stream HE-MCSs 0 to 7 (transmit and receive) in all
-	 * supported channel widths for HE SU PPDUs
-	 */
-	if ((mcs_80_map_tx & 0x3) == IEEE80211_HE_MCS_NOT_SUPPORTED ||
-	    (mcs_80_map_rx & 0x3) == IEEE80211_HE_MCS_NOT_SUPPORTED) {
-		sdata_info(sdata,
-			   "Missing mandatory rates for 1 Nss, rx 0x%x, tx 0x%x, disable HE\n",
-			   mcs_80_map_tx, mcs_80_map_rx);
-		return false;
-	}
-
-	if (!he_op)
-		return true;
-
-	ap_min_req_set = le16_to_cpu(he_op->he_mcs_nss_set);
-
-	/* make sure the AP is consistent with itself
-	 *
-	 * P802.11-REVme/D0.3
-	 * 26.17.1 Basic HE BSS operation
-	 *
-	 * A STA that is operating in an HE BSS shall be able to receive and
-	 * transmit at each of the <HE-MCS, NSS> tuple values indicated by the
-	 * Basic HE-MCS And NSS Set field of the HE Operation parameter of the
-	 * MLME-START.request primitive and shall be able to receive at each of
-	 * the <HE-MCS, NSS> tuple values indicated by the Supported HE-MCS and
-	 * NSS Set field in the HE Capabilities parameter of the MLMESTART.request
-	 * primitive
-	 */
-	for (nss = 8; nss > 0; nss--) {
-		u8 ap_op_val = (ap_min_req_set >> (2 * (nss - 1))) & 3;
-		u8 ap_rx_val;
-		u8 ap_tx_val;
-
-		if (ap_op_val == IEEE80211_HE_MCS_NOT_SUPPORTED)
-			continue;
-
-		ap_rx_val = (mcs_80_map_rx >> (2 * (nss - 1))) & 3;
-		ap_tx_val = (mcs_80_map_tx >> (2 * (nss - 1))) & 3;
-
-		if (ap_rx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
-		    ap_tx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
-		    ap_rx_val < ap_op_val || ap_tx_val < ap_op_val) {
-			sdata_info(sdata,
-				   "Invalid rates for %d Nss, rx %d, tx %d oper %d, disable HE\n",
-				   nss, ap_rx_val, ap_rx_val, ap_op_val);
-			return false;
-		}
-	}
-
-	return true;
-}
-
-static bool
-ieee80211_verify_sta_he_mcs_support(struct ieee80211_sub_if_data *sdata,
-				    struct ieee80211_supported_band *sband,
-				    const struct ieee80211_he_operation *he_op)
-{
-	const struct ieee80211_sta_he_cap *sta_he_cap =
-		ieee80211_get_he_iftype_cap(sband,
-					    ieee80211_vif_type_p2p(&sdata->vif));
-	u16 ap_min_req_set;
-	int i;
-
-	if (!sta_he_cap || !he_op)
-		return false;
-
-	ap_min_req_set = le16_to_cpu(he_op->he_mcs_nss_set);
-
-	/* Need to go over for 80MHz, 160MHz and for 80+80 */
-	for (i = 0; i < 3; i++) {
-		const struct ieee80211_he_mcs_nss_supp *sta_mcs_nss_supp =
-			&sta_he_cap->he_mcs_nss_supp;
-		u16 sta_mcs_map_rx =
-			le16_to_cpu(((__le16 *)sta_mcs_nss_supp)[2 * i]);
-		u16 sta_mcs_map_tx =
-			le16_to_cpu(((__le16 *)sta_mcs_nss_supp)[2 * i + 1]);
-		u8 nss;
-		bool verified = true;
-
-		/*
-		 * For each band there is a maximum of 8 spatial streams
-		 * possible. Each of the sta_mcs_map_* is a 16-bit struct built
-		 * of 2 bits per NSS (1-8), with the values defined in enum
-		 * ieee80211_he_mcs_support. Need to make sure STA TX and RX
-		 * capabilities aren't less than the AP's minimum requirements
-		 * for this HE BSS per SS.
-		 * It is enough to find one such band that meets the reqs.
-		 */
-		for (nss = 8; nss > 0; nss--) {
-			u8 sta_rx_val = (sta_mcs_map_rx >> (2 * (nss - 1))) & 3;
-			u8 sta_tx_val = (sta_mcs_map_tx >> (2 * (nss - 1))) & 3;
-			u8 ap_val = (ap_min_req_set >> (2 * (nss - 1))) & 3;
-
-			if (ap_val == IEEE80211_HE_MCS_NOT_SUPPORTED)
-				continue;
-
-			/*
-			 * Make sure the HE AP doesn't require MCSs that aren't
-			 * supported by the client as required by spec
-			 *
-			 * P802.11-REVme/D0.3
-			 * 26.17.1 Basic HE BSS operation
-			 *
-			 * An HE STA shall not attempt to join * (MLME-JOIN.request primitive)
-			 * a BSS, unless it supports (i.e., is able to both transmit and
-			 * receive using) all of the <HE-MCS, NSS> tuples in the basic
-			 * HE-MCS and NSS set.
-			 */
-			if (sta_rx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
-			    sta_tx_val == IEEE80211_HE_MCS_NOT_SUPPORTED ||
-			    (ap_val > sta_rx_val) || (ap_val > sta_tx_val)) {
-				verified = false;
-				break;
-			}
-		}
-
-		if (verified)
-			return true;
-	}
-
-	/* If here, STA doesn't meet AP's HE min requirements */
-	return false;
-}
-
-static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
-				  struct ieee80211_link_data *link,
-				  struct cfg80211_bss *cbss)
-{
-	struct ieee80211_local *local = sdata->local;
-	const struct ieee80211_ht_cap *ht_cap = NULL;
-	const struct ieee80211_ht_operation *ht_oper = NULL;
-	const struct ieee80211_vht_operation *vht_oper = NULL;
-	const struct ieee80211_he_operation *he_oper = NULL;
-	const struct ieee80211_eht_operation *eht_oper = NULL;
-	const struct ieee80211_s1g_oper_ie *s1g_oper = NULL;
-	struct ieee80211_supported_band *sband;
-	struct cfg80211_chan_def chandef;
-	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
-	bool is_5ghz = cbss->channel->band == NL80211_BAND_5GHZ;
-	struct ieee80211_bss *bss = (void *)cbss->priv;
-	struct ieee802_11_elems *elems;
-	const struct cfg80211_bss_ies *ies;
-	int ret;
-	u32 i;
-	bool have_80mhz;
-
-	rcu_read_lock();
-
-	ies = rcu_dereference(cbss->ies);
-	elems = ieee802_11_parse_elems(ies->data, ies->len, false, cbss);
-	if (!elems) {
-		rcu_read_unlock();
-		return -ENOMEM;
-	}
-
-	sband = local->hw.wiphy->bands[cbss->channel->band];
-
-	link->u.mgd.conn_flags &= ~(IEEE80211_CONN_DISABLE_40MHZ |
-				    IEEE80211_CONN_DISABLE_80P80MHZ |
-				    IEEE80211_CONN_DISABLE_160MHZ);
-
-	/* disable HT/VHT/HE if we don't support them */
-	if (!sband->ht_cap.ht_supported && !is_6ghz) {
-		mlme_dbg(sdata, "HT not supported, disabling HT/VHT/HE/EHT\n");
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
-	}
-
-	if (!sband->vht_cap.vht_supported && is_5ghz) {
-		mlme_dbg(sdata, "VHT not supported, disabling VHT/HE/EHT\n");
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
-	}
-
-	if (!ieee80211_get_he_iftype_cap(sband,
-					 ieee80211_vif_type_p2p(&sdata->vif))) {
-		mlme_dbg(sdata, "HE not supported, disabling HE and EHT\n");
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
-	}
-
-	if (!ieee80211_get_eht_iftype_cap(sband,
-					  ieee80211_vif_type_p2p(&sdata->vif))) {
-		mlme_dbg(sdata, "EHT not supported, disabling EHT\n");
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
-	}
-
-	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) && !is_6ghz) {
-		ht_oper = elems->ht_operation;
-		ht_cap = elems->ht_cap_elem;
-
-		if (!ht_cap) {
-			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
-			ht_oper = NULL;
-		}
-	}
-
-	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) && !is_6ghz) {
-		vht_oper = elems->vht_operation;
-		if (vht_oper && !ht_oper) {
-			vht_oper = NULL;
-			sdata_info(sdata,
-				   "AP advertised VHT without HT, disabling HT/VHT/HE\n");
-			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HT;
-			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE;
-			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_EHT;
-		}
-
-		if (!elems->vht_cap_elem) {
-			sdata_info(sdata,
-				   "bad VHT capabilities, disabling VHT\n");
-			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-			vht_oper = NULL;
-		}
-	}
-
-	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE)) {
-		he_oper = elems->he_operation;
-
-		if (is_6ghz) {
-			struct ieee80211_bss_conf *bss_conf;
-			u8 i, j = 0;
-
-			bss_conf = link->conf;
-
-			if (elems->pwr_constr_elem)
-				bss_conf->pwr_reduction = *elems->pwr_constr_elem;
-
-			BUILD_BUG_ON(ARRAY_SIZE(bss_conf->tx_pwr_env) !=
-				     ARRAY_SIZE(elems->tx_pwr_env));
-
-			for (i = 0; i < elems->tx_pwr_env_num; i++) {
-				if (elems->tx_pwr_env_len[i] >
-				    sizeof(bss_conf->tx_pwr_env[j]))
-					continue;
-
-				bss_conf->tx_pwr_env_num++;
-				memcpy(&bss_conf->tx_pwr_env[j], elems->tx_pwr_env[i],
-				       elems->tx_pwr_env_len[i]);
-				j++;
-			}
-		}
-
-		if (!ieee80211_verify_peer_he_mcs_support(sdata, ies, he_oper) ||
-		    !ieee80211_verify_sta_he_mcs_support(sdata, sband, he_oper))
-			link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_HE |
-						  IEEE80211_CONN_DISABLE_EHT;
-	}
-
-	/*
-	 * EHT requires HE to be supported as well. Specifically for 6 GHz
-	 * channels, the operation channel information can only be deduced from
-	 * both the 6 GHz operation information (from the HE operation IE) and
-	 * EHT operation.
-	 */
-	if (!(link->u.mgd.conn_flags &
-			(IEEE80211_CONN_DISABLE_HE |
-			 IEEE80211_CONN_DISABLE_EHT)) &&
-	    he_oper) {
-		const struct cfg80211_bss_ies *ies;
-		const u8 *eht_oper_ie;
-
-		ies = rcu_dereference(cbss->ies);
-		eht_oper_ie = cfg80211_find_ext_ie(WLAN_EID_EXT_EHT_OPERATION,
-						   ies->data, ies->len);
-		if (eht_oper_ie && eht_oper_ie[1] >=
-		    1 + sizeof(struct ieee80211_eht_operation))
-			eht_oper = (void *)(eht_oper_ie + 3);
-		else
-			eht_oper = NULL;
-	}
-
-	/* Allow VHT if at least one channel on the sband supports 80 MHz */
-	have_80mhz = false;
-	for (i = 0; i < sband->n_channels; i++) {
-		if (sband->channels[i].flags & (IEEE80211_CHAN_DISABLED |
-						IEEE80211_CHAN_NO_80MHZ))
-			continue;
-
-		have_80mhz = true;
-		break;
-	}
-
-	if (!have_80mhz) {
-		sdata_info(sdata, "80 MHz not supported, disabling VHT\n");
-		link->u.mgd.conn_flags |= IEEE80211_CONN_DISABLE_VHT;
-	}
-
-	if (sband->band == NL80211_BAND_S1GHZ) {
-		s1g_oper = elems->s1g_oper;
-		if (!s1g_oper)
-			sdata_info(sdata,
-				   "AP missing S1G operation element?\n");
-	}
-
-	link->u.mgd.conn_flags |=
-		ieee80211_determine_chantype(link, sband,
-					     cbss->channel,
-					     bss->vht_cap_info,
-					     ht_oper, vht_oper,
-					     he_oper, eht_oper,
-					     s1g_oper,
-					     &chandef, false);
-
-	link->needed_rx_chains =
-		min(ieee80211_max_rx_chains(link, cbss), local->rx_chains);
-
-	rcu_read_unlock();
-	/* the element data was RCU protected so no longer valid anyway */
-	kfree(elems);
-	elems = NULL;
-
-	if (link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE && is_6ghz) {
-		sdata_info(sdata, "Rejecting non-HE 6/7 GHz connection");
-		return -EINVAL;
-	}
-
-	/* will change later if needed */
-	link->smps_mode = IEEE80211_SMPS_OFF;
-
-	mutex_lock(&local->mtx);
-	/*
-	 * If this fails (possibly due to channel context sharing
-	 * on incompatible channels, e.g. 80+80 and 160 sharing the
-	 * same control channel) try to use a smaller bandwidth.
-	 */
-	ret = ieee80211_link_use_channel(link, &chandef,
-					 IEEE80211_CHANCTX_SHARED);
-
-	/* don't downgrade for 5 and 10 MHz channels, though. */
-	if (chandef.width == NL80211_CHAN_WIDTH_5 ||
-	    chandef.width == NL80211_CHAN_WIDTH_10)
-		goto out;
-
-	while (ret && chandef.width != NL80211_CHAN_WIDTH_20_NOHT) {
-		link->u.mgd.conn_flags |=
-			ieee80211_chandef_downgrade(&chandef);
-		ret = ieee80211_link_use_channel(link, &chandef,
-						 IEEE80211_CHANCTX_SHARED);
-	}
- out:
-	mutex_unlock(&local->mtx);
-	return ret;
-}
-
 static bool ieee80211_get_dtim(const struct cfg80211_bss_ies *ies,
 			       u8 *dtim_count, u8 *dtim_period)
 {
-- 
2.36.1

