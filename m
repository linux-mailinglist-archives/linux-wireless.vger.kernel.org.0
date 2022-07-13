Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542BA573A3C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 17:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236989AbiGMPe7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 11:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236961AbiGMPep (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 11:34:45 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3845B4D144
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 08:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=rO1Bgjw2mlkdERj+oDRv7dUs7I15gVJle2H4170vmrA=;
        t=1657726483; x=1658936083; b=yUf+QSNcW5wZ+IKhhVdcz75WEPnrejv5SSeuAyQnU3shJWl
        sgG/00pzdPZ+jKXiFVOraQ7ZVLZ8IVKe4WsbJH86gzkVede02+2h4OWv+VROoMxtDtTmogDoBzrEB
        c18zq/DmHlN2HM2jYkPl3h8ofqtmi71bVsSVHgImKawC09GaaJINVFbaxfAI6fpAkho79Q3rbF+eo
        +HgWILvcg7SicVkzkf9UvxezvFMmjpft8CUveEBsPvghvbsspASUVQ9gBW0LWux37MAYW2PieMd4r
        +2HD0d2zTpLSlX0IfWFAjazzvzl6ZvSppk+YNDLWqaOZqk9o4PDjlkw/ZbHWHsnw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBeNt-00EnaA-An;
        Wed, 13 Jul 2022 17:34:41 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 16/21] wifi: mac80211: mlme: refactor assoc success handling
Date:   Wed, 13 Jul 2022 17:34:28 +0200
Message-Id: <20220713173301.5bf795ac3166.Ica375e701ab260cf57ca562d8563789f29a76668@changeid>
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

Refactor the per-link setup out of ieee80211_assoc_success()
into a new function ieee80211_assoc_config_link().

It looks useless for now to parse the elements again inside
ieee80211_assoc_config_link(), but that will be done with
the link ID in the future.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 737 ++++++++++++++++++++++----------------------
 1 file changed, 376 insertions(+), 361 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 308b4ede10b9..873f7f6e03ce 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3540,6 +3540,326 @@ static bool ieee80211_twt_bcast_support(struct ieee80211_sub_if_data *sdata,
 			IEEE80211_HE_MAC_CAP2_BCAST_TWT);
 }
 
+static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
+					struct link_sta_info *link_sta,
+					struct cfg80211_bss *cbss,
+					struct ieee80211_mgmt *mgmt,
+					const u8 *elem_start,
+					unsigned int elem_len,
+					u64 *changed)
+{
+	struct ieee80211_sub_if_data *sdata = link->sdata;
+	struct ieee80211_mgd_assoc_data *assoc_data = sdata->u.mgd.assoc_data;
+	struct ieee80211_bss_conf *bss_conf = link->conf;
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_elems_parse_params parse_params = {
+		.start = elem_start,
+		.len = elem_len,
+		.bss = cbss,
+	};
+	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
+	bool is_s1g = cbss->channel->band == NL80211_BAND_S1GHZ;
+	const struct cfg80211_bss_ies *bss_ies = NULL;
+	struct ieee80211_supported_band *sband;
+	struct ieee802_11_elems *elems;
+	u16 capab_info;
+	bool ret;
+
+	elems = ieee802_11_parse_elems_full(&parse_params);
+	if (!elems)
+		return false;
+
+	capab_info = le16_to_cpu(mgmt->u.assoc_resp.capab_info);
+
+	if (!is_s1g && !elems->supp_rates) {
+		sdata_info(sdata, "no SuppRates element in AssocResp\n");
+		ret = false;
+		goto out;
+	}
+
+	link->u.mgd.tdls_chan_switch_prohibited =
+		elems->ext_capab && elems->ext_capab_len >= 5 &&
+		(elems->ext_capab[4] & WLAN_EXT_CAPA5_TDLS_CH_SW_PROHIBITED);
+
+	/*
+	 * Some APs are erroneously not including some information in their
+	 * (re)association response frames. Try to recover by using the data
+	 * from the beacon or probe response. This seems to afflict mobile
+	 * 2G/3G/4G wifi routers, reported models include the "Onda PN51T",
+	 * "Vodafone PocketWiFi 2", "ZTE MF60" and a similar T-Mobile device.
+	 */
+	if (!is_6ghz &&
+	    ((assoc_data->wmm && !elems->wmm_param) ||
+	     (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) &&
+	      (!elems->ht_cap_elem || !elems->ht_operation)) ||
+	     (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) &&
+	      (!elems->vht_cap_elem || !elems->vht_operation)))) {
+		const struct cfg80211_bss_ies *ies;
+		struct ieee802_11_elems *bss_elems;
+
+		rcu_read_lock();
+		ies = rcu_dereference(cbss->ies);
+		if (ies)
+			bss_ies = kmemdup(ies, sizeof(*ies) + ies->len,
+					  GFP_ATOMIC);
+		rcu_read_unlock();
+		if (!bss_ies) {
+			ret = false;
+			goto out;
+		}
+
+		parse_params.start = bss_ies->data;
+		parse_params.len = bss_ies->len;
+		bss_elems = ieee802_11_parse_elems_full(&parse_params);
+		if (!bss_elems) {
+			ret = false;
+			goto out;
+		}
+
+		if (assoc_data->wmm &&
+		    !elems->wmm_param && bss_elems->wmm_param) {
+			elems->wmm_param = bss_elems->wmm_param;
+			sdata_info(sdata,
+				   "AP bug: WMM param missing from AssocResp\n");
+		}
+
+		/*
+		 * Also check if we requested HT/VHT, otherwise the AP doesn't
+		 * have to include the IEs in the (re)association response.
+		 */
+		if (!elems->ht_cap_elem && bss_elems->ht_cap_elem &&
+		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)) {
+			elems->ht_cap_elem = bss_elems->ht_cap_elem;
+			sdata_info(sdata,
+				   "AP bug: HT capability missing from AssocResp\n");
+		}
+		if (!elems->ht_operation && bss_elems->ht_operation &&
+		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)) {
+			elems->ht_operation = bss_elems->ht_operation;
+			sdata_info(sdata,
+				   "AP bug: HT operation missing from AssocResp\n");
+		}
+		if (!elems->vht_cap_elem && bss_elems->vht_cap_elem &&
+		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)) {
+			elems->vht_cap_elem = bss_elems->vht_cap_elem;
+			sdata_info(sdata,
+				   "AP bug: VHT capa missing from AssocResp\n");
+		}
+		if (!elems->vht_operation && bss_elems->vht_operation &&
+		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)) {
+			elems->vht_operation = bss_elems->vht_operation;
+			sdata_info(sdata,
+				   "AP bug: VHT operation missing from AssocResp\n");
+		}
+
+		kfree(bss_elems);
+	}
+
+	/*
+	 * We previously checked these in the beacon/probe response, so
+	 * they should be present here. This is just a safety net.
+	 */
+	if (!is_6ghz && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) &&
+	    (!elems->wmm_param || !elems->ht_cap_elem || !elems->ht_operation)) {
+		sdata_info(sdata,
+			   "HT AP is missing WMM params or HT capability/operation\n");
+		ret = false;
+		goto out;
+	}
+
+	if (!is_6ghz && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) &&
+	    (!elems->vht_cap_elem || !elems->vht_operation)) {
+		sdata_info(sdata,
+			   "VHT AP is missing VHT capability/operation\n");
+		ret = false;
+		goto out;
+	}
+
+	if (is_6ghz && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
+	    !elems->he_6ghz_capa) {
+		sdata_info(sdata,
+			   "HE 6 GHz AP is missing HE 6 GHz band capability\n");
+		ret = false;
+		goto out;
+	}
+
+	sband = ieee80211_get_link_sband(link);
+	if (!sband) {
+		ret = false;
+		goto out;
+	}
+
+	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
+	    (!elems->he_cap || !elems->he_operation)) {
+		mutex_unlock(&sdata->local->sta_mtx);
+		sdata_info(sdata,
+			   "HE AP is missing HE capability/operation\n");
+		ret = false;
+		goto out;
+	}
+
+	/* Set up internal HT/VHT capabilities */
+	if (elems->ht_cap_elem && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT))
+		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
+						  elems->ht_cap_elem,
+						  link_sta);
+
+	if (elems->vht_cap_elem && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
+		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
+						    elems->vht_cap_elem,
+						    link_sta);
+
+	if (elems->he_operation && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
+	    elems->he_cap) {
+		ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband,
+						  elems->he_cap,
+						  elems->he_cap_len,
+						  elems->he_6ghz_capa,
+						  link_sta);
+
+		bss_conf->he_support = link_sta->pub->he_cap.has_he;
+		if (elems->rsnx && elems->rsnx_len &&
+		    (elems->rsnx[0] & WLAN_RSNX_CAPA_PROTECTED_TWT) &&
+		    wiphy_ext_feature_isset(local->hw.wiphy,
+					    NL80211_EXT_FEATURE_PROTECTED_TWT))
+			bss_conf->twt_protected = true;
+		else
+			bss_conf->twt_protected = false;
+
+		*changed |= ieee80211_recalc_twt_req(link, link_sta, elems);
+
+		if (elems->eht_operation && elems->eht_cap &&
+		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT)) {
+			ieee80211_eht_cap_ie_to_sta_eht_cap(sdata, sband,
+							    elems->he_cap,
+							    elems->he_cap_len,
+							    elems->eht_cap,
+							    elems->eht_cap_len,
+							    link_sta);
+
+			bss_conf->eht_support = link_sta->pub->eht_cap.has_eht;
+		} else {
+			bss_conf->eht_support = false;
+		}
+	} else {
+		bss_conf->he_support = false;
+		bss_conf->twt_requester = false;
+		bss_conf->twt_protected = false;
+		bss_conf->eht_support = false;
+	}
+
+	bss_conf->twt_broadcast =
+		ieee80211_twt_bcast_support(sdata, bss_conf, sband, link_sta);
+
+	if (bss_conf->he_support) {
+		bss_conf->he_bss_color.color =
+			le32_get_bits(elems->he_operation->he_oper_params,
+				      IEEE80211_HE_OPERATION_BSS_COLOR_MASK);
+		bss_conf->he_bss_color.partial =
+			le32_get_bits(elems->he_operation->he_oper_params,
+				      IEEE80211_HE_OPERATION_PARTIAL_BSS_COLOR);
+		bss_conf->he_bss_color.enabled =
+			!le32_get_bits(elems->he_operation->he_oper_params,
+				       IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED);
+
+		if (bss_conf->he_bss_color.enabled)
+			*changed |= BSS_CHANGED_HE_BSS_COLOR;
+
+		bss_conf->htc_trig_based_pkt_ext =
+			le32_get_bits(elems->he_operation->he_oper_params,
+				      IEEE80211_HE_OPERATION_DFLT_PE_DURATION_MASK);
+		bss_conf->frame_time_rts_th =
+			le32_get_bits(elems->he_operation->he_oper_params,
+				      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
+
+		bss_conf->uora_exists = !!elems->uora_element;
+		if (elems->uora_element)
+			bss_conf->uora_ocw_range = elems->uora_element[0];
+
+		ieee80211_he_op_ie_to_bss_conf(&sdata->vif, elems->he_operation);
+		ieee80211_he_spr_ie_to_bss_conf(&sdata->vif, elems->he_spr);
+		/* TODO: OPEN: what happens if BSS color disable is set? */
+	}
+
+	if (cbss->transmitted_bss) {
+		bss_conf->nontransmitted = true;
+		ether_addr_copy(bss_conf->transmitter_bssid,
+				cbss->transmitted_bss->bssid);
+		bss_conf->bssid_indicator = cbss->max_bssid_indicator;
+		bss_conf->bssid_index = cbss->bssid_index;
+	}
+
+	/*
+	 * Some APs, e.g. Netgear WNDR3700, report invalid HT operation data
+	 * in their association response, so ignore that data for our own
+	 * configuration. If it changed since the last beacon, we'll get the
+	 * next beacon and update then.
+	 */
+
+	/*
+	 * If an operating mode notification IE is present, override the
+	 * NSS calculation (that would be done in rate_control_rate_init())
+	 * and use the # of streams from that element.
+	 */
+	if (elems->opmode_notif &&
+	    !(*elems->opmode_notif & IEEE80211_OPMODE_NOTIF_RX_NSS_TYPE_BF)) {
+		u8 nss;
+
+		nss = *elems->opmode_notif & IEEE80211_OPMODE_NOTIF_RX_NSS_MASK;
+		nss >>= IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
+		nss += 1;
+		link_sta->pub->rx_nss = nss;
+	}
+
+	/*
+	 * Always handle WMM once after association regardless
+	 * of the first value the AP uses. Setting -1 here has
+	 * that effect because the AP values is an unsigned
+	 * 4-bit value.
+	 */
+	link->u.mgd.wmm_last_param_set = -1;
+	link->u.mgd.mu_edca_last_param_set = -1;
+
+	if (link->u.mgd.disable_wmm_tracking) {
+		ieee80211_set_wmm_default(link, false, false);
+	} else if (!ieee80211_sta_wmm_params(local, link, elems->wmm_param,
+					     elems->wmm_param_len,
+					     elems->mu_edca_param_set)) {
+		/* still enable QoS since we might have HT/VHT */
+		ieee80211_set_wmm_default(link, false, true);
+		/* disable WMM tracking in this case to disable
+		 * tracking WMM parameter changes in the beacon if
+		 * the parameters weren't actually valid. Doing so
+		 * avoids changing parameters very strangely when
+		 * the AP is going back and forth between valid and
+		 * invalid parameters.
+		 */
+		link->u.mgd.disable_wmm_tracking = true;
+	}
+
+	if (elems->max_idle_period_ie) {
+		bss_conf->max_idle_period =
+			le16_to_cpu(elems->max_idle_period_ie->max_idle_period);
+		bss_conf->protected_keep_alive =
+			!!(elems->max_idle_period_ie->idle_options &
+			   WLAN_IDLE_OPTIONS_PROTECTED_KEEP_ALIVE);
+		*changed |= BSS_CHANGED_KEEP_ALIVE;
+	} else {
+		bss_conf->max_idle_period = 0;
+		bss_conf->protected_keep_alive = false;
+	}
+
+	/* set assoc capability (AID was already set earlier),
+	 * ieee80211_set_associated() will tell the driver */
+	bss_conf->assoc_capability = capab_info;
+
+	ret = true;
+out:
+	kfree(elems);
+	kfree(bss_ies);
+	return ret;
+}
+
 static int ieee80211_mgd_setup_link_sta(struct ieee80211_link_data *link,
 					struct sta_info *sta,
 					struct ieee80211_link_sta *link_sta,
@@ -4119,160 +4439,15 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 				    struct cfg80211_bss *cbss,
-				    struct ieee80211_mgmt *mgmt, size_t len,
-				    struct ieee802_11_elems *elems)
+				    struct ieee80211_mgmt *mgmt,
+				    struct ieee802_11_elems *elems,
+				    const u8 *elem_start, unsigned int elem_len)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_local *local = sdata->local;
-	struct ieee80211_supported_band *sband;
-	struct link_sta_info *link_sta;
 	struct sta_info *sta;
-	u16 capab_info, aid;
-	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
-	const struct cfg80211_bss_ies *bss_ies = NULL;
-	struct ieee80211_mgd_assoc_data *assoc_data = ifmgd->assoc_data;
-	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
-	bool is_s1g = cbss->channel->band == NL80211_BAND_S1GHZ;
-	struct ieee80211_link_data *link = &sdata->deflink;
-	u32 changed = 0;
+	u64 changed = 0;
 	int err;
-	bool ret;
-
-	capab_info = le16_to_cpu(mgmt->u.assoc_resp.capab_info);
-
-	if (elems->aid_resp)
-		aid = le16_to_cpu(elems->aid_resp->aid);
-	else if (is_s1g)
-		aid = 0; /* TODO */
-	else
-		aid = le16_to_cpu(mgmt->u.assoc_resp.aid);
-
-	/*
-	 * The 5 MSB of the AID field are reserved
-	 * (802.11-2016 9.4.1.8 AID field)
-	 */
-	aid &= 0x7ff;
-
-	ifmgd->broken_ap = false;
-
-	if (aid == 0 || aid > IEEE80211_MAX_AID) {
-		sdata_info(sdata, "invalid AID value %d (out of range), turn off PS\n",
-			   aid);
-		aid = 0;
-		ifmgd->broken_ap = true;
-	}
-
-	if (!is_s1g && !elems->supp_rates) {
-		sdata_info(sdata, "no SuppRates element in AssocResp\n");
-		ret = false;
-		goto out;
-	}
-
-	sdata->vif.cfg.aid = aid;
-	sdata->deflink.u.mgd.tdls_chan_switch_prohibited =
-		elems->ext_capab && elems->ext_capab_len >= 5 &&
-		(elems->ext_capab[4] & WLAN_EXT_CAPA5_TDLS_CH_SW_PROHIBITED);
-
-	/*
-	 * Some APs are erroneously not including some information in their
-	 * (re)association response frames. Try to recover by using the data
-	 * from the beacon or probe response. This seems to afflict mobile
-	 * 2G/3G/4G wifi routers, reported models include the "Onda PN51T",
-	 * "Vodafone PocketWiFi 2", "ZTE MF60" and a similar T-Mobile device.
-	 */
-	if (!is_6ghz &&
-	    ((assoc_data->wmm && !elems->wmm_param) ||
-	     (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) &&
-	      (!elems->ht_cap_elem || !elems->ht_operation)) ||
-	     (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) &&
-	      (!elems->vht_cap_elem || !elems->vht_operation)))) {
-		const struct cfg80211_bss_ies *ies;
-		struct ieee802_11_elems *bss_elems;
-
-		rcu_read_lock();
-		ies = rcu_dereference(cbss->ies);
-		if (ies)
-			bss_ies = kmemdup(ies, sizeof(*ies) + ies->len,
-					  GFP_ATOMIC);
-		rcu_read_unlock();
-		if (!bss_ies) {
-			ret = false;
-			goto out;
-		}
-
-		bss_elems = ieee802_11_parse_elems(bss_ies->data, bss_ies->len,
-						   false, assoc_data->bss);
-		if (!bss_elems) {
-			ret = false;
-			goto out;
-		}
-
-		if (assoc_data->wmm &&
-		    !elems->wmm_param && bss_elems->wmm_param) {
-			elems->wmm_param = bss_elems->wmm_param;
-			sdata_info(sdata,
-				   "AP bug: WMM param missing from AssocResp\n");
-		}
-
-		/*
-		 * Also check if we requested HT/VHT, otherwise the AP doesn't
-		 * have to include the IEs in the (re)association response.
-		 */
-		if (!elems->ht_cap_elem && bss_elems->ht_cap_elem &&
-		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)) {
-			elems->ht_cap_elem = bss_elems->ht_cap_elem;
-			sdata_info(sdata,
-				   "AP bug: HT capability missing from AssocResp\n");
-		}
-		if (!elems->ht_operation && bss_elems->ht_operation &&
-		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT)) {
-			elems->ht_operation = bss_elems->ht_operation;
-			sdata_info(sdata,
-				   "AP bug: HT operation missing from AssocResp\n");
-		}
-		if (!elems->vht_cap_elem && bss_elems->vht_cap_elem &&
-		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)) {
-			elems->vht_cap_elem = bss_elems->vht_cap_elem;
-			sdata_info(sdata,
-				   "AP bug: VHT capa missing from AssocResp\n");
-		}
-		if (!elems->vht_operation && bss_elems->vht_operation &&
-		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT)) {
-			elems->vht_operation = bss_elems->vht_operation;
-			sdata_info(sdata,
-				   "AP bug: VHT operation missing from AssocResp\n");
-		}
-
-		kfree(bss_elems);
-	}
-
-	/*
-	 * We previously checked these in the beacon/probe response, so
-	 * they should be present here. This is just a safety net.
-	 */
-	if (!is_6ghz && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT) &&
-	    (!elems->wmm_param || !elems->ht_cap_elem || !elems->ht_operation)) {
-		sdata_info(sdata,
-			   "HT AP is missing WMM params or HT capability/operation\n");
-		ret = false;
-		goto out;
-	}
-
-	if (!is_6ghz && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT) &&
-	    (!elems->vht_cap_elem || !elems->vht_operation)) {
-		sdata_info(sdata,
-			   "VHT AP is missing VHT capability/operation\n");
-		ret = false;
-		goto out;
-	}
-
-	if (is_6ghz && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
-	    !elems->he_6ghz_capa) {
-		sdata_info(sdata,
-			   "HE 6 GHz AP is missing HE 6 GHz band capability\n");
-		ret = false;
-		goto out;
-	}
 
 	mutex_lock(&sdata->local->sta_mtx);
 	/*
@@ -4280,154 +4455,13 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	 * the association and should be available to us
 	 */
 	sta = sta_info_get(sdata, cbss->bssid);
-	if (WARN_ON(!sta)) {
-		mutex_unlock(&sdata->local->sta_mtx);
-		ret = false;
-		goto out;
-	}
+	if (WARN_ON(!sta))
+		goto out_err;
 
-	link_sta = rcu_dereference_protected(sta->link[link->link_id],
-					     lockdep_is_held(&local->sta_mtx));
-	if (WARN_ON(!link_sta)) {
-		mutex_unlock(&sdata->local->sta_mtx);
-		ret = false;
-		goto out;
-	}
-
-	sband = ieee80211_get_link_sband(link);
-	if (!sband) {
-		mutex_unlock(&sdata->local->sta_mtx);
-		ret = false;
-		goto out;
-	}
-
-	if (!(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
-	    (!elems->he_cap || !elems->he_operation)) {
-		mutex_unlock(&sdata->local->sta_mtx);
-		sdata_info(sdata,
-			   "HE AP is missing HE capability/operation\n");
-		ret = false;
-		goto out;
-	}
-
-	/* Set up internal HT/VHT capabilities */
-	if (elems->ht_cap_elem && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HT))
-		ieee80211_ht_cap_ie_to_sta_ht_cap(sdata, sband,
-						  elems->ht_cap_elem,
-						  link_sta);
-
-	if (elems->vht_cap_elem && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_VHT))
-		ieee80211_vht_cap_ie_to_sta_vht_cap(sdata, sband,
-						    elems->vht_cap_elem,
-						    link_sta);
-
-	if (elems->he_operation && !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_HE) &&
-	    elems->he_cap) {
-		ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband,
-						  elems->he_cap,
-						  elems->he_cap_len,
-						  elems->he_6ghz_capa,
-						  link_sta);
-
-		bss_conf->he_support = link_sta->pub->he_cap.has_he;
-		if (elems->rsnx && elems->rsnx_len &&
-		    (elems->rsnx[0] & WLAN_RSNX_CAPA_PROTECTED_TWT) &&
-		    wiphy_ext_feature_isset(local->hw.wiphy,
-					    NL80211_EXT_FEATURE_PROTECTED_TWT))
-			bss_conf->twt_protected = true;
-		else
-			bss_conf->twt_protected = false;
-
-		changed |= ieee80211_recalc_twt_req(link, link_sta, elems);
-
-		if (elems->eht_operation && elems->eht_cap &&
-		    !(link->u.mgd.conn_flags & IEEE80211_CONN_DISABLE_EHT)) {
-			ieee80211_eht_cap_ie_to_sta_eht_cap(sdata, sband,
-							    elems->he_cap,
-							    elems->he_cap_len,
-							    elems->eht_cap,
-							    elems->eht_cap_len,
-							    link_sta);
-
-			bss_conf->eht_support = link_sta->pub->eht_cap.has_eht;
-		} else {
-			bss_conf->eht_support = false;
-		}
-	} else {
-		bss_conf->he_support = false;
-		bss_conf->twt_requester = false;
-		bss_conf->twt_protected = false;
-		bss_conf->eht_support = false;
-	}
-
-	bss_conf->twt_broadcast =
-		ieee80211_twt_bcast_support(sdata, bss_conf, sband, link_sta);
-
-	if (bss_conf->he_support) {
-		bss_conf->he_bss_color.color =
-			le32_get_bits(elems->he_operation->he_oper_params,
-				      IEEE80211_HE_OPERATION_BSS_COLOR_MASK);
-		bss_conf->he_bss_color.partial =
-			le32_get_bits(elems->he_operation->he_oper_params,
-				      IEEE80211_HE_OPERATION_PARTIAL_BSS_COLOR);
-		bss_conf->he_bss_color.enabled =
-			!le32_get_bits(elems->he_operation->he_oper_params,
-				       IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED);
-
-		if (bss_conf->he_bss_color.enabled)
-			changed |= BSS_CHANGED_HE_BSS_COLOR;
-
-		bss_conf->htc_trig_based_pkt_ext =
-			le32_get_bits(elems->he_operation->he_oper_params,
-			      IEEE80211_HE_OPERATION_DFLT_PE_DURATION_MASK);
-		bss_conf->frame_time_rts_th =
-			le32_get_bits(elems->he_operation->he_oper_params,
-			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
-
-		bss_conf->uora_exists = !!elems->uora_element;
-		if (elems->uora_element)
-			bss_conf->uora_ocw_range = elems->uora_element[0];
-
-		ieee80211_he_op_ie_to_bss_conf(&sdata->vif, elems->he_operation);
-		ieee80211_he_spr_ie_to_bss_conf(&sdata->vif, elems->he_spr);
-		/* TODO: OPEN: what happens if BSS color disable is set? */
-	}
-
-	if (cbss->transmitted_bss) {
-		bss_conf->nontransmitted = true;
-		ether_addr_copy(bss_conf->transmitter_bssid,
-				cbss->transmitted_bss->bssid);
-		bss_conf->bssid_indicator = cbss->max_bssid_indicator;
-		bss_conf->bssid_index = cbss->bssid_index;
-	} else {
-		bss_conf->nontransmitted = false;
-		memset(bss_conf->transmitter_bssid, 0,
-		       sizeof(bss_conf->transmitter_bssid));
-		bss_conf->bssid_indicator = 0;
-		bss_conf->bssid_index = 0;
-	}
-
-	/*
-	 * Some APs, e.g. Netgear WNDR3700, report invalid HT operation data
-	 * in their association response, so ignore that data for our own
-	 * configuration. If it changed since the last beacon, we'll get the
-	 * next beacon and update then.
-	 */
-
-	/*
-	 * If an operating mode notification IE is present, override the
-	 * NSS calculation (that would be done in rate_control_rate_init())
-	 * and use the # of streams from that element.
-	 */
-	if (elems->opmode_notif &&
-	    !(*elems->opmode_notif & IEEE80211_OPMODE_NOTIF_RX_NSS_TYPE_BF)) {
-		u8 nss;
-
-		nss = *elems->opmode_notif & IEEE80211_OPMODE_NOTIF_RX_NSS_MASK;
-		nss >>= IEEE80211_OPMODE_NOTIF_RX_NSS_SHIFT;
-		nss += 1;
-		link_sta->pub->rx_nss = nss;
-	}
+	if (!ieee80211_assoc_config_link(&sdata->deflink, &sta->deflink,
+					 cbss, mgmt, elem_start, elem_len,
+					 &changed))
+		goto out_err;
 
 	rate_control_rate_init(sta);
 
@@ -4449,9 +4483,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 			   "failed to move station %pM to desired state\n",
 			   sta->sta.addr);
 		WARN_ON(__sta_info_destroy(sta));
-		mutex_unlock(&sdata->local->sta_mtx);
-		ret = false;
-		goto out;
+		goto out_err;
 	}
 
 	if (sdata->wdev.use_4addr)
@@ -4459,48 +4491,6 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 
 	mutex_unlock(&sdata->local->sta_mtx);
 
-	/*
-	 * Always handle WMM once after association regardless
-	 * of the first value the AP uses. Setting -1 here has
-	 * that effect because the AP values is an unsigned
-	 * 4-bit value.
-	 */
-	link->u.mgd.wmm_last_param_set = -1;
-	link->u.mgd.mu_edca_last_param_set = -1;
-
-	if (link->u.mgd.disable_wmm_tracking) {
-		ieee80211_set_wmm_default(link, false, false);
-	} else if (!ieee80211_sta_wmm_params(local, link, elems->wmm_param,
-					     elems->wmm_param_len,
-					     elems->mu_edca_param_set)) {
-		/* still enable QoS since we might have HT/VHT */
-		ieee80211_set_wmm_default(link, false, true);
-		/* disable WMM tracking in this case to disable
-		 * tracking WMM parameter changes in the beacon if
-		 * the parameters weren't actually valid. Doing so
-		 * avoids changing parameters very strangely when
-		 * the AP is going back and forth between valid and
-		 * invalid parameters.
-		 */
-		link->u.mgd.disable_wmm_tracking = true;
-	}
-	changed |= BSS_CHANGED_QOS;
-
-	if (elems->max_idle_period_ie) {
-		bss_conf->max_idle_period =
-			le16_to_cpu(elems->max_idle_period_ie->max_idle_period);
-		bss_conf->protected_keep_alive =
-			!!(elems->max_idle_period_ie->idle_options &
-			   WLAN_IDLE_OPTIONS_PROTECTED_KEEP_ALIVE);
-		changed |= BSS_CHANGED_KEEP_ALIVE;
-	} else {
-		bss_conf->max_idle_period = 0;
-		bss_conf->protected_keep_alive = false;
-	}
-
-	/* set assoc capability (AID was already set earlier),
-	 * ieee80211_set_associated() will tell the driver */
-	bss_conf->assoc_capability = capab_info;
 	ieee80211_set_associated(sdata, cbss, changed);
 
 	/*
@@ -4517,10 +4507,10 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	ieee80211_sta_reset_beacon_monitor(sdata);
 	ieee80211_sta_reset_conn_monitor(sdata);
 
-	ret = true;
- out:
-	kfree(bss_ies);
-	return ret;
+	return true;
+out_err:
+	mutex_unlock(&sdata->local->sta_mtx);
+	return false;
 }
 
 static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
@@ -4532,7 +4522,8 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	u16 capab_info, status_code, aid;
 	struct ieee802_11_elems *elems;
 	int ac;
-	u8 *pos;
+	const u8 *elem_start;
+	unsigned int elem_len;
 	bool reassoc;
 	struct cfg80211_bss *cbss;
 	struct ieee80211_event event = {
@@ -4565,12 +4556,10 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	reassoc = ieee80211_is_reassoc_resp(mgmt->frame_control);
 	capab_info = le16_to_cpu(mgmt->u.assoc_resp.capab_info);
 	status_code = le16_to_cpu(mgmt->u.assoc_resp.status_code);
-	pos = mgmt->u.assoc_resp.variable;
-	aid = le16_to_cpu(mgmt->u.assoc_resp.aid);
-	if (cbss->channel->band == NL80211_BAND_S1GHZ) {
-		pos = (u8 *) mgmt->u.s1g_assoc_resp.variable;
-		aid = 0; /* TODO */
-	}
+	if (cbss->channel->band == NL80211_BAND_S1GHZ)
+		elem_start = mgmt->u.s1g_assoc_resp.variable;
+	else
+		elem_start = mgmt->u.assoc_resp.variable;
 
 	/*
 	 * Note: this may not be perfect, AP might misbehave - if
@@ -4581,19 +4570,34 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 	info.subtype = reassoc ? IEEE80211_STYPE_REASSOC_REQ :
 				 IEEE80211_STYPE_ASSOC_REQ;
 
+	if (assoc_data->fils_kek_len &&
+	    fils_decrypt_assoc_resp(sdata, (u8 *)mgmt, &len, assoc_data) < 0)
+		return;
+
+	elem_len = len - (elem_start - (u8 *)mgmt);
+	elems = ieee802_11_parse_elems(elem_start, elem_len, false, NULL);
+	if (!elems)
+		goto notify_driver;
+
+	if (elems->aid_resp)
+		aid = le16_to_cpu(elems->aid_resp->aid);
+	else if (cbss->channel->band == NL80211_BAND_S1GHZ)
+		aid = 0; /* TODO */
+	else
+		aid = le16_to_cpu(mgmt->u.assoc_resp.aid);
+
+	/*
+	 * The 5 MSB of the AID field are reserved
+	 * (802.11-2016 9.4.1.8 AID field)
+	 */
+	aid &= 0x7ff;
+
 	sdata_info(sdata,
 		   "RX %sssocResp from %pM (capab=0x%x status=%d aid=%d)\n",
 		   reassoc ? "Rea" : "A", mgmt->sa,
 		   capab_info, status_code, (u16)(aid & ~(BIT(15) | BIT(14))));
 
-	if (assoc_data->fils_kek_len &&
-	    fils_decrypt_assoc_resp(sdata, (u8 *)mgmt, &len, assoc_data) < 0)
-		return;
-
-	elems = ieee802_11_parse_elems(pos, len - (pos - (u8 *)mgmt), false,
-				       assoc_data->bss);
-	if (!elems)
-		goto notify_driver;
+	ifmgd->broken_ap = false;
 
 	if (status_code == WLAN_STATUS_ASSOC_REJECTED_TEMPORARILY &&
 	    elems->timeout_int &&
@@ -4623,7 +4627,18 @@ static void ieee80211_rx_mgmt_assoc_resp(struct ieee80211_sub_if_data *sdata,
 		event.u.mlme.reason = status_code;
 		drv_event_callback(sdata->local, sdata, &event);
 	} else {
-		if (!ieee80211_assoc_success(sdata, cbss, mgmt, len, elems)) {
+		if (aid == 0 || aid > IEEE80211_MAX_AID) {
+			sdata_info(sdata,
+				   "invalid AID value %d (out of range), turn off PS\n",
+				   aid);
+			aid = 0;
+			ifmgd->broken_ap = true;
+		}
+
+		sdata->vif.cfg.aid = aid;
+
+		if (!ieee80211_assoc_success(sdata, cbss, mgmt, elems,
+					     elem_start, elem_len)) {
 			/* oops -- internal error -- send timeout for now */
 			ieee80211_destroy_assoc_data(sdata, ASSOC_TIMEOUT);
 			goto notify_driver;
-- 
2.36.1

