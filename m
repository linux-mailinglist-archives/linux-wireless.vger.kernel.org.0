Return-Path: <linux-wireless+bounces-1398-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B15EA82221C
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 20:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E602842A7
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 19:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6650F15E94;
	Tue,  2 Jan 2024 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MRQPCrzs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB3415E9F
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 19:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704224174; x=1735760174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dUziu6Tq7OqWRP+RnvAVitzFIZkaloQFf3NFs8AVi7A=;
  b=MRQPCrzs/gVLh0dDKP2LXuc+dSrLs0GLsWY4vwrk9ZzW3eCr+2eALRCQ
   i6GghQKeCI8g9xUqFBU77b8KH2rHUpwgsmDY0SPd5u65K9Hg94tBxwYl2
   5XB3bsleX1vdhO9FuudCcguqAv7XCSQ/ZNEPH2/7uHvIuWQRv2drVwv6k
   hxAUN0ydoSPxMOAL+YRYIkPt0wNuNAt1TKmQr3E5DeRBZTqJrhK0xNGle
   t/B5/bH14FaxtlfA5OXamuA0kPN20ujkntRHCXXehs/uEVYZCu2eYyN5j
   zY7xP0mQA6xMzB2G/XM96snMI0Mw4CZpDQqqfS20YrdES0oNucxDRm4be
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463314297"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="463314297"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="898624472"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="898624472"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:12 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/15] wifi: cfg80211: add RNR with reporting AP information
Date: Tue,  2 Jan 2024 21:35:32 +0200
Message-Id: <20240102213313.4cb3dbb1d84f.I7c74edec83c5d7598cdd578929fd0876d67aef7f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
References: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

If the reporting AP is part of the same MLD, then an entry in the RNR is
required in order to discover it again from the BSS generated from the
per-STA profile in the Multi-Link Probe Response.

We need this because we do not have a direct concept of an MLD AP and
just do the lookup from one to the other on the fly if needed. As such,
we need to ensure that this lookup will work both ways.

Fixes: 2481b5da9c6b ("wifi: cfg80211: handle BSS data contained in ML probe responses")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/scan.c | 134 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 5 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 42555753b947..dbb5885d40e7 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2614,6 +2614,103 @@ cfg80211_tbtt_info_for_mld_ap(const u8 *ie, size_t ielen, u8 mld_id, u8 link_id,
 	return 0;
 }
 
+static struct element *
+cfg80211_gen_reporter_rnr(struct cfg80211_bss *source_bss, bool is_mbssid,
+			  bool same_mld, u8 link_id, u8 bss_change_count,
+			  gfp_t gfp)
+{
+	const struct cfg80211_bss_ies *ies;
+	struct ieee80211_neighbor_ap_info ap_info;
+	struct ieee80211_tbtt_info_ge_11 tbtt_info;
+	u32 short_ssid;
+	const struct element *elem;
+	struct element *res;
+
+	/*
+	 * We only generate the RNR to permit ML lookups. For that we do not
+	 * need an entry for the corresponding transmitting BSS, lets just skip
+	 * it even though it would be easy to add.
+	 */
+	if (!same_mld)
+		return NULL;
+
+	/* We could use tx_data->ies if we change cfg80211_calc_short_ssid */
+	rcu_read_lock();
+	ies = rcu_dereference(source_bss->ies);
+
+	ap_info.tbtt_info_len = offsetofend(typeof(tbtt_info), mld_params);
+	ap_info.tbtt_info_hdr =
+			u8_encode_bits(IEEE80211_TBTT_INFO_TYPE_TBTT,
+				       IEEE80211_AP_INFO_TBTT_HDR_TYPE) |
+			u8_encode_bits(0, IEEE80211_AP_INFO_TBTT_HDR_COUNT);
+
+	ap_info.channel = ieee80211_frequency_to_channel(source_bss->channel->center_freq);
+
+	/* operating class */
+	elem = cfg80211_find_elem(WLAN_EID_SUPPORTED_REGULATORY_CLASSES,
+				  ies->data, ies->len);
+	if (elem && elem->datalen >= 1) {
+		ap_info.op_class = elem->data[0];
+	} else {
+		struct cfg80211_chan_def chandef;
+
+		/* The AP is not providing us with anything to work with. So
+		 * make up a somewhat reasonable operating class, but don't
+		 * bother with it too much as no one will ever use the
+		 * information.
+		 */
+		cfg80211_chandef_create(&chandef, source_bss->channel,
+					NL80211_CHAN_NO_HT);
+
+		if (!ieee80211_chandef_to_operating_class(&chandef,
+							  &ap_info.op_class))
+			goto out_unlock;
+	}
+
+	/* Just set TBTT offset and PSD 20 to invalid/unknown */
+	tbtt_info.tbtt_offset = 255;
+	tbtt_info.psd_20 = IEEE80211_RNR_TBTT_PARAMS_PSD_RESERVED;
+
+	memcpy(tbtt_info.bssid, source_bss->bssid, ETH_ALEN);
+	if (cfg80211_calc_short_ssid(ies, &elem, &short_ssid))
+		goto out_unlock;
+
+	rcu_read_unlock();
+
+	tbtt_info.short_ssid = cpu_to_le32(short_ssid);
+
+	tbtt_info.bss_params = IEEE80211_RNR_TBTT_PARAMS_SAME_SSID;
+
+	if (is_mbssid) {
+		tbtt_info.bss_params |= IEEE80211_RNR_TBTT_PARAMS_MULTI_BSSID;
+		tbtt_info.bss_params |= IEEE80211_RNR_TBTT_PARAMS_TRANSMITTED_BSSID;
+	}
+
+	tbtt_info.mld_params.mld_id = 0;
+	tbtt_info.mld_params.params =
+		le16_encode_bits(link_id, IEEE80211_RNR_MLD_PARAMS_LINK_ID) |
+		le16_encode_bits(bss_change_count,
+				 IEEE80211_RNR_MLD_PARAMS_BSS_CHANGE_COUNT);
+
+	res = kzalloc(struct_size(res, data,
+				  sizeof(ap_info) + ap_info.tbtt_info_len),
+		      gfp);
+	if (!res)
+		return NULL;
+
+	/* Copy the data */
+	res->id = WLAN_EID_REDUCED_NEIGHBOR_REPORT;
+	res->datalen = sizeof(ap_info) + ap_info.tbtt_info_len;
+	memcpy(res->data, &ap_info, sizeof(ap_info));
+	memcpy(res->data + sizeof(ap_info), &tbtt_info, ap_info.tbtt_info_len);
+
+	return res;
+
+out_unlock:
+	rcu_read_unlock();
+	return NULL;
+}
+
 static void
 cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 				struct cfg80211_inform_single_bss_data *tx_data,
@@ -2627,13 +2724,14 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 		.source_bss = source_bss,
 		.bss_source = BSS_SOURCE_STA_PROFILE,
 	};
+	struct element *reporter_rnr = NULL;
 	struct ieee80211_multi_link_elem *ml_elem;
 	struct cfg80211_mle *mle;
 	u16 control;
 	u8 ml_common_len;
-	u8 *new_ie;
+	u8 *new_ie = NULL;
 	struct cfg80211_bss *bss;
-	int mld_id;
+	u8 mld_id, reporter_link_id, bss_change_count;
 	u16 seen_links = 0;
 	const u8 *pos;
 	u8 i;
@@ -2655,8 +2753,14 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 
 	ml_common_len = ml_elem->variable[0];
 
-	/* length + MLD MAC address + link ID info + BSS Params Change Count */
-	pos = ml_elem->variable + 1 + 6 + 1 + 1;
+	/* length + MLD MAC address */
+	pos = ml_elem->variable + 1 + 6;
+
+	reporter_link_id = pos[0];
+	pos += 1;
+
+	bss_change_count = pos[0];
+	pos += 1;
 
 	if (u16_get_bits(control, IEEE80211_MLC_BASIC_PRES_MED_SYNC_DELAY))
 		pos += 2;
@@ -2687,10 +2791,21 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 	if (!mle)
 		return;
 
+	/* No point in doing anything if there is no per-STA profile */
+	if (!mle->sta_prof[0])
+		goto out;
+
 	new_ie = kmalloc(IEEE80211_MAX_DATA_LEN, gfp);
 	if (!new_ie)
 		goto out;
 
+	reporter_rnr = cfg80211_gen_reporter_rnr(source_bss,
+						 u16_get_bits(control,
+							      IEEE80211_MLC_BASIC_PRES_MLD_ID),
+						 mld_id == 0, reporter_link_id,
+						 bss_change_count,
+						 gfp);
+
 	for (i = 0; i < ARRAY_SIZE(mle->sta_prof) && mle->sta_prof[i]; i++) {
 		const struct ieee80211_neighbor_ap_info *ap_info;
 		enum nl80211_band band;
@@ -2800,7 +2915,15 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 
 		data.ielen += sizeof(*ml_elem) + ml_common_len;
 
-		/* TODO: Add an RNR containing only the reporting AP */
+		if (reporter_rnr && (use_for & NL80211_BSS_USE_FOR_NORMAL)) {
+			if (data.ielen + 1 + reporter_rnr->datalen >
+			    IEEE80211_MAX_DATA_LEN)
+				continue;
+
+			memcpy(new_ie + data.ielen, reporter_rnr,
+			       1 + reporter_rnr->datalen);
+			data.ielen += 1 + reporter_rnr->datalen;
+		}
 
 		bss = cfg80211_inform_single_bss_data(wiphy, &data, gfp);
 		if (!bss)
@@ -2809,6 +2932,7 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 	}
 
 out:
+	kfree(reporter_rnr);
 	kfree(new_ie);
 	kfree(mle);
 }
-- 
2.34.1


