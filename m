Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D0B7347C6
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjFRSuw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjFRSuu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:50:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578CF1AE
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114244; x=1718650244;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EJu6xyPekBgKShgAGW3MwDVFze5AfV63i5nxI/Kzr+w=;
  b=GQlpUh2X2p9Qn+EHY2jbAzrwYjJ7sjM6KMnLuCurixUsCzmvL1DFnrBy
   sG+CHCvMR/3QbQ1S2w1m5+pg/VllYgM/3tnUazHE08OszX2NB8w251b9+
   I1hTrNvT0E38KtQgsLE5dr49v68Oe+sh/cUXJuDgw00vde6dO86H6/0K+
   Y5zevwb3nlURBAXG/hN9S3qZ0P155wO6dVBAAGVZaLcNpInc4tsiwjULu
   x6a8yffuFPPDT9C2pMLEsXuY/xOoGX2XKAkTj+sPJNyyhk+pYK4FOA6jx
   HJV3dqO0ad+iOK1EaHkcBaJtePHBkHUu1zElId67B7RsBJpQwFX2RdZaQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116655"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116655"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:42 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747234009"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747234009"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:40 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/20] wifi: cfg80211: handle BSS data contained in ML probe responses
Date:   Sun, 18 Jun 2023 21:49:53 +0300
Message-Id: <20230618214436.29593bd0ae1f.Ic9a67b8f022360aa202b870a932897a389171b14@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230618185002.817236-1-gregory.greenman@intel.com>
References: <20230618185002.817236-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

The basic multi-link element within an multi-link probe response will
contain full information about BSSes that are part of an MLD AP. This
BSS information may be used to associate with a link of an MLD AP
without having received a beacon from the BSS itself.

This patch adds parsing of the data and adding/updating the BSS using
the received elements. Doing this means that userspace can discover the
BSSes using an ML probe request and request association on these links.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/scan.c | 361 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 354 insertions(+), 7 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index f0b4d7671d17..46488650ecbc 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1979,6 +1979,7 @@ cfg80211_get_bss_channel(struct wiphy *wiphy, const u8 *ie, size_t ielen,
 struct cfg80211_inform_single_bss_data {
 	struct cfg80211_inform_bss *drv_data;
 	enum cfg80211_bss_frame_type ftype;
+	struct ieee80211_channel *channel;
 	u8 bssid[ETH_ALEN];
 	u64 tsf;
 	u16 capability;
@@ -1986,7 +1987,12 @@ struct cfg80211_inform_single_bss_data {
 	const u8 *ie;
 	size_t ielen;
 
-	/* Set for nontransmitted BSSIDs */
+	enum {
+		BSS_SOURCE_DIRECT = 0,
+		BSS_SOURCE_MBSSID,
+		BSS_SOURCE_STA_PROFILE,
+	} bss_source;
+	/* Set if reporting bss_source != BSS_SOURCE_DIRECT */
 	struct cfg80211_bss *source_bss;
 	u8 max_bssid_indicator;
 	u8 bssid_index;
@@ -2014,22 +2020,31 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 		    (drv_data->signal < 0 || drv_data->signal > 100)))
 		return NULL;
 
-	channel = cfg80211_get_bss_channel(wiphy, data->ie, data->ielen,
-					   drv_data->chan, drv_data->scan_width);
+	if (WARN_ON(data->bss_source != BSS_SOURCE_DIRECT && !data->source_bss))
+		return NULL;
+
+	channel = data->channel;
+	if (!channel)
+		channel = cfg80211_get_bss_channel(wiphy, data->ie, data->ielen,
+						   drv_data->chan,
+						   drv_data->scan_width);
 	if (!channel)
 		return NULL;
 
 	memcpy(tmp.pub.bssid, data->bssid, ETH_ALEN);
 	tmp.pub.channel = channel;
 	tmp.pub.scan_width = drv_data->scan_width;
-	tmp.pub.signal = drv_data->signal;
+	if (data->bss_source != BSS_SOURCE_STA_PROFILE)
+		tmp.pub.signal = drv_data->signal;
+	else
+		tmp.pub.signal = 0;
 	tmp.pub.beacon_interval = data->beacon_interval;
 	tmp.pub.capability = data->capability;
 	tmp.ts_boottime = drv_data->boottime_ns;
 	tmp.parent_tsf = drv_data->parent_tsf;
 	ether_addr_copy(tmp.parent_bssid, drv_data->parent_bssid);
 
-	if (data->source_bss) {
+	if (data->bss_source != BSS_SOURCE_DIRECT) {
 		tmp.pub.transmitted_bss = data->source_bss;
 		ts = bss_from_pub(data->source_bss)->ts;
 		tmp.pub.bssid_index = data->bssid_index;
@@ -2088,7 +2103,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 
 	rdev_inform_bss(rdev, &res->pub, ies, data->drv_data);
 
-	if (data->source_bss) {
+	if (data->bss_source == BSS_SOURCE_MBSSID) {
 		/* this is a nontransmitting bss, we need to add it to
 		 * transmitting bss' list if it is not there
 		 */
@@ -2197,6 +2212,7 @@ cfg80211_parse_mbssid_data(struct wiphy *wiphy,
 		.tsf = tx_data->tsf,
 		.beacon_interval = tx_data->beacon_interval,
 		.source_bss = source_bss,
+		.bss_source = BSS_SOURCE_MBSSID,
 	};
 	const u8 *mbssid_index_ie;
 	const struct element *elem, *sub;
@@ -2365,6 +2381,332 @@ ssize_t cfg80211_defragment_element(const struct element *elem, const u8 *ies,
 }
 EXPORT_SYMBOL(cfg80211_defragment_element);
 
+struct cfg80211_mle {
+	struct ieee80211_multi_link_elem *mle;
+	struct ieee80211_mle_per_sta_profile
+		*sta_prof[IEEE80211_MLD_MAX_NUM_LINKS];
+	ssize_t sta_prof_len[IEEE80211_MLD_MAX_NUM_LINKS];
+
+	u8 data[];
+};
+
+static struct cfg80211_mle *
+cfg80211_defrag_mle(const struct element *mle, const u8 *ie, size_t ielen,
+		    gfp_t gfp)
+{
+	const struct element *elem;
+	struct cfg80211_mle *res;
+	size_t buf_len;
+	ssize_t mle_len;
+	u8 common_size, idx;
+
+	if (!mle || !ieee80211_mle_size_ok(mle->data + 1, mle->datalen - 1))
+		return NULL;
+
+	/* Required length for first defragmentation */
+	buf_len = mle->datalen - 1;
+	for_each_element(elem, mle->data + mle->datalen,
+			 ielen - sizeof(*mle) + mle->datalen) {
+		if (elem->id != WLAN_EID_FRAGMENT)
+			break;
+
+		buf_len += elem->datalen;
+	}
+
+	res = kzalloc(struct_size(res, data, buf_len), gfp);
+	if (!res)
+		return NULL;
+
+	mle_len = cfg80211_defragment_element(mle, ie, ielen,
+					      res->data, buf_len,
+					      WLAN_EID_FRAGMENT);
+	if (mle_len < 0)
+		goto error;
+
+	res->mle = (void *)res->data;
+
+	/* Find the sub-element area in the buffer */
+	common_size = ieee80211_mle_common_size((u8 *)res->mle);
+	ie = res->data + common_size;
+	ielen = mle_len - common_size;
+
+	idx = 0;
+	for_each_element_id(elem, IEEE80211_MLE_SUBELEM_PER_STA_PROFILE,
+			    ie, ielen) {
+		res->sta_prof[idx] = (void *)elem->data;
+		res->sta_prof_len[idx] = elem->datalen;
+
+		idx++;
+		if (idx >= IEEE80211_MLD_MAX_NUM_LINKS)
+			break;
+	}
+	if (!for_each_element_completed(elem, ie, ielen))
+		goto error;
+
+	/* Defragment sta_info in-place */
+	for (idx = 0; res->sta_prof[idx] && idx < IEEE80211_MLD_MAX_NUM_LINKS;
+	     idx++) {
+		if (res->sta_prof_len[idx] < 255)
+			continue;
+
+		elem = (void *)res->sta_prof[idx] - 2;
+
+		if (idx + 1 < ARRAY_SIZE(res->sta_prof) &&
+		    res->sta_prof[idx + 1])
+			buf_len = (u8 *)res->sta_prof[idx + 1] -
+				  (u8 *)res->sta_prof[idx];
+		else
+			buf_len = ielen + ie - (u8 *)elem;
+
+		res->sta_prof_len[idx] =
+			cfg80211_defragment_element(elem,
+						    (u8 *)elem, buf_len,
+						    (u8 *)res->sta_prof[idx],
+						    buf_len,
+						    IEEE80211_MLE_SUBELEM_FRAGMENT);
+		if (res->sta_prof_len[idx] < 0)
+			goto error;
+	}
+
+	return res;
+
+error:
+	kfree(res);
+	return NULL;
+}
+
+static bool
+cfg80211_tbtt_info_for_mld_ap(const u8 *ie, size_t ielen, u8 mld_id, u8 link_id,
+			      const struct ieee80211_neighbor_ap_info **ap_info,
+			      const u8 **tbtt_info)
+{
+	const struct ieee80211_neighbor_ap_info *info;
+	const struct element *rnr;
+	const u8 *pos, *end;
+
+	for_each_element_id(rnr, WLAN_EID_REDUCED_NEIGHBOR_REPORT, ie, ielen) {
+		pos = rnr->data;
+		end = rnr->data + rnr->datalen;
+
+		/* RNR IE may contain more than one NEIGHBOR_AP_INFO */
+		while (sizeof(*info) <= end - pos) {
+			const struct ieee80211_rnr_mld_params *mld_params;
+			u16 params;
+			u8 length, i, count, mld_params_offset;
+			u8 type, lid;
+
+			info = (void *)pos;
+			count = u8_get_bits(info->tbtt_info_hdr,
+					    IEEE80211_AP_INFO_TBTT_HDR_COUNT) + 1;
+			length = info->tbtt_info_len;
+
+			pos += sizeof(*info);
+
+			if (count * length > end - pos)
+				return false;
+
+			type = u8_get_bits(info->tbtt_info_hdr,
+					   IEEE80211_AP_INFO_TBTT_HDR_TYPE);
+
+			/* Only accept full TBTT information. NSTR mobile APs
+			 * use the shortened version, but we ignore them here.
+			 */
+			if (type == IEEE80211_TBTT_INFO_TYPE_TBTT &&
+			    length >=
+			    offsetofend(struct ieee80211_tbtt_info_ge_11,
+					mld_params)) {
+				mld_params_offset =
+					offsetof(struct ieee80211_tbtt_info_ge_11, mld_params);
+			} else {
+				pos += count * length;
+				continue;
+			}
+
+			for (i = 0; i < count; i++) {
+				mld_params = (void *)pos + mld_params_offset;
+				params = le16_to_cpu(mld_params->params);
+
+				lid = u16_get_bits(params,
+						   IEEE80211_RNR_MLD_PARAMS_LINK_ID);
+
+				if (mld_id == mld_params->mld_id &&
+				    link_id == lid) {
+					*ap_info = info;
+					*tbtt_info = pos;
+
+					return true;
+				}
+
+				pos += length;
+			}
+		}
+	}
+
+	return false;
+}
+
+static void cfg80211_parse_ml_sta_data(struct wiphy *wiphy,
+				       struct cfg80211_inform_single_bss_data *tx_data,
+				       struct cfg80211_bss *source_bss,
+				       gfp_t gfp)
+{
+	struct cfg80211_inform_single_bss_data data = {
+		.drv_data = tx_data->drv_data,
+		.ftype = tx_data->ftype,
+		.source_bss = source_bss,
+		.bss_source = BSS_SOURCE_STA_PROFILE,
+	};
+	struct ieee80211_multi_link_elem *ml_elem;
+	const struct element *elem;
+	struct cfg80211_mle *mle;
+	u16 control;
+	u8 *new_ie;
+	struct cfg80211_bss *bss;
+	int mld_id;
+	u16 seen_links = 0;
+	const u8 *pos;
+	u8 i;
+
+	if (!source_bss)
+		return;
+
+	if (tx_data->ftype != CFG80211_BSS_FTYPE_PRESP)
+		return;
+
+	elem = cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_MULTI_LINK,
+				      tx_data->ie, tx_data->ielen);
+	if (!elem || !ieee80211_mle_size_ok(elem->data + 1, elem->datalen - 1))
+		return;
+
+	ml_elem = (void *)elem->data + 1;
+	control = le16_to_cpu(ml_elem->control);
+	if (u16_get_bits(control, IEEE80211_ML_CONTROL_TYPE) !=
+	    IEEE80211_ML_CONTROL_TYPE_BASIC)
+		return;
+
+	/* Must be present when transmitted by an AP (in a probe response) */
+	if (!(control & IEEE80211_MLC_BASIC_PRES_BSS_PARAM_CH_CNT) ||
+	    !(control & IEEE80211_MLC_BASIC_PRES_LINK_ID) ||
+	    !(control & IEEE80211_MLC_BASIC_PRES_MLD_CAPA_OP))
+		return;
+
+	/* length + MLD MAC address + link ID info + BSS Params Change Count */
+	pos = ml_elem->variable + 1 + 6 + 1 + 1;
+
+	if (u16_get_bits(control, IEEE80211_MLC_BASIC_PRES_MED_SYNC_DELAY))
+		pos += 2;
+	if (u16_get_bits(control, IEEE80211_MLC_BASIC_PRES_EML_CAPA))
+		pos += 2;
+
+	/* MLD capabilities and operations */
+	pos += 2;
+
+	/* Not included when the (nontransmitted) AP is responding itself,
+	 * but defined to zero then (Draft P802.11be_D3.0, 9.4.2.170.2)
+	 */
+	if (u16_get_bits(control, IEEE80211_MLC_BASIC_PRES_MLD_ID)) {
+		mld_id = *pos;
+		pos += 1;
+	} else {
+		mld_id = 0;
+	}
+
+	/* Extended MLD capabilities and operations */
+	pos += 2;
+
+	/* Fully defrag the ML element for sta information/profile iteration */
+	mle = cfg80211_defrag_mle(elem, tx_data->ie, tx_data->ielen, gfp);
+	if (!mle)
+		return;
+
+	new_ie = kmalloc(IEEE80211_MAX_DATA_LEN, gfp);
+	if (!new_ie)
+		goto out;
+
+	for (i = 0; i < ARRAY_SIZE(mle->sta_prof) && mle->sta_prof[i]; i++) {
+		const struct ieee80211_neighbor_ap_info *ap_info;
+		enum nl80211_band band;
+		u32 freq;
+		const u8 *profile;
+		const u8 *tbtt_info;
+		ssize_t profile_len;
+		u8 link_id;
+
+		if (!ieee80211_mle_basic_sta_prof_size_ok((u8 *)mle->sta_prof[i],
+							  mle->sta_prof_len[i]))
+			continue;
+
+		control = le16_to_cpu(mle->sta_prof[i]->control);
+
+		if (!(control & IEEE80211_MLE_STA_CONTROL_COMPLETE_PROFILE))
+			continue;
+
+		link_id = u16_get_bits(control,
+				       IEEE80211_MLE_STA_CONTROL_LINK_ID);
+		if (seen_links & BIT(link_id))
+			break;
+		seen_links |= BIT(link_id);
+
+		if (!(control & IEEE80211_MLE_STA_CONTROL_BEACON_INT_PRESENT) ||
+		    !(control & IEEE80211_MLE_STA_CONTROL_TSF_OFFS_PRESENT) ||
+		    !(control & IEEE80211_MLE_STA_CONTROL_STA_MAC_ADDR_PRESENT))
+			continue;
+
+		memcpy(data.bssid, mle->sta_prof[i]->variable, ETH_ALEN);
+		data.beacon_interval =
+			get_unaligned_le16(mle->sta_prof[i]->variable + 6);
+		data.tsf = tx_data->tsf +
+			   get_unaligned_le64(mle->sta_prof[i]->variable + 8);
+
+		/* sta_info_len counts itself */
+		profile = mle->sta_prof[i]->variable +
+			  mle->sta_prof[i]->sta_info_len - 1;
+		profile_len = (u8 *)mle->sta_prof[i] + mle->sta_prof_len[i] -
+			      profile;
+
+		if (profile_len < 2)
+			continue;
+
+		data.capability = get_unaligned_le16(profile);
+		profile += 2;
+		profile_len -= 2;
+
+		/* Find in RNR to look up channel information */
+		if (!cfg80211_tbtt_info_for_mld_ap(tx_data->ie, tx_data->ielen,
+						   mld_id, link_id,
+						   &ap_info, &tbtt_info))
+			continue;
+
+		/* We could sanity check the BSSID is included */
+
+		if (!ieee80211_operating_class_to_band(ap_info->op_class,
+						       &band))
+			continue;
+
+		freq = ieee80211_channel_to_freq_khz(ap_info->channel, band);
+		data.channel = ieee80211_get_channel_khz(wiphy, freq);
+
+		/* Generate new elements */
+		memset(new_ie, 0, IEEE80211_MAX_DATA_LEN);
+		data.ie = new_ie;
+		data.ielen = cfg80211_gen_new_ie(tx_data->ie, tx_data->ielen,
+						 profile, profile_len,
+						 new_ie,
+						 IEEE80211_MAX_DATA_LEN);
+		if (!data.ielen)
+			continue;
+
+		bss = cfg80211_inform_single_bss_data(wiphy, &data, gfp);
+		if (!bss)
+			break;
+		cfg80211_put_bss(wiphy, bss);
+	}
+
+out:
+	kfree(new_ie);
+	kfree(mle);
+}
+
 struct cfg80211_bss *
 cfg80211_inform_bss_data(struct wiphy *wiphy,
 			 struct cfg80211_inform_bss *data,
@@ -2391,6 +2733,9 @@ cfg80211_inform_bss_data(struct wiphy *wiphy,
 		return NULL;
 
 	cfg80211_parse_mbssid_data(wiphy, &inform_data, res, gfp);
+
+	cfg80211_parse_ml_sta_data(wiphy, &inform_data, res, gfp);
+
 	return res;
 }
 EXPORT_SYMBOL(cfg80211_inform_bss_data);
@@ -2549,7 +2894,7 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 	if (!res)
 		return NULL;
 
-	/* don't do any further MBSSID handling for S1G */
+	/* don't do any further MBSSID/ML handling for S1G */
 	if (ieee80211_is_s1g_beacon(mgmt->frame_control))
 		return res;
 
@@ -2563,6 +2908,8 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 	/* process each non-transmitting bss */
 	cfg80211_parse_mbssid_data(wiphy, &inform_data, res, gfp);
 
+	cfg80211_parse_ml_sta_data(wiphy, &inform_data, res, gfp);
+
 	return res;
 }
 EXPORT_SYMBOL(cfg80211_inform_bss_frame_data);
-- 
2.38.1

