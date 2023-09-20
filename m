Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33F07A8BA6
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Sep 2023 20:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjITS00 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Sep 2023 14:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjITS0Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Sep 2023 14:26:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008C0DD
        for <linux-wireless@vger.kernel.org>; Wed, 20 Sep 2023 11:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695234375; x=1726770375;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WopwXsPnkq4XMKFk+nQchi1Eh758KJdpLt5PxrzLPI0=;
  b=Q/E9GK1t4kklkFsS2LVn3yUHPZ9acZd3ML0TnEcg83oPRn+4Blcceb0M
   TB+JzSaLAW4DmUcgSU7c83j/fo15Gv3NMtlMeWNF5wCpJlpvrC5gf4gg1
   Sg4Nb9bTG4zTRvCBsy5SbTFkGUoafBbY3LRhNtMrdvOKfGgma4rDMTw7S
   D0pli4LRe7RrQHQkIPr06DudBWzu21OCm7zZbTR5doTNYHRukzBp0Zv+2
   Bfhr2HpAP51lkf/LuvYITmAtneTKnssinFwLMa7ov22agjWtQzU0WcoV7
   M2ZG/BFajpH4F+bdq0so5YaUEtDbEzCKdXfbq2LEAFSwXNtuBBCC5zXR3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="360556300"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="360556300"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="723424201"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="723424201"
Received: from dmani-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.217.100])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:26:13 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 01/18] wifi: mac80211: use bandwidth indication element for CSA
Date:   Wed, 20 Sep 2023 21:25:12 +0300
Message-Id: <20230920211508.43ef01920556.If4f24a61cd634ab1e50eba43899b9e992bf25602@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230920182529.659973-1-gregory.greenman@intel.com>
References: <20230920182529.659973-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In CSA, parse the (EHT) bandwidth indication element and
use it (in fact prefer it if present).

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/linux/ieee80211.h  | 23 +++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  3 ++-
 net/mac80211/mlme.c        |  5 +++--
 net/mac80211/spectmgmt.c   | 13 ++++++++++--
 net/mac80211/util.c        | 42 ++++++++++++++++++++++++++------------
 5 files changed, 68 insertions(+), 18 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 340d7e0f6bf7..f11b7022d9eb 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -3139,6 +3139,28 @@ ieee80211_eht_oper_size_ok(const u8 *data, u8 len)
 	return len >= needed;
 }
 
+#define IEEE80211_BW_IND_DIS_SUBCH_PRESENT	BIT(1)
+
+struct ieee80211_bandwidth_indication {
+	u8 params;
+	struct ieee80211_eht_operation_info info;
+} __packed;
+
+static inline bool
+ieee80211_bandwidth_indication_size_ok(const u8 *data, u8 len)
+{
+	const struct ieee80211_bandwidth_indication *bwi = (const void *)data;
+
+	if (len < sizeof(*bwi))
+		return false;
+
+	if (bwi->params & IEEE80211_BW_IND_DIS_SUBCH_PRESENT &&
+	    len < sizeof(*bwi) + 2)
+		return false;
+
+	return true;
+}
+
 #define LISTEN_INT_USF	GENMASK(15, 14)
 #define LISTEN_INT_UI	GENMASK(13, 0)
 
@@ -3596,6 +3618,7 @@ enum ieee80211_eid_ext {
 	WLAN_EID_EXT_EHT_OPERATION = 106,
 	WLAN_EID_EXT_EHT_MULTI_LINK = 107,
 	WLAN_EID_EXT_EHT_CAPABILITY = 108,
+	WLAN_EID_EXT_BANDWIDTH_INDICATION = 135,
 };
 
 /* Action category code */
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index d5c5f865323c..e7856336b5c6 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1677,6 +1677,7 @@ struct ieee802_11_elems {
 	const struct ieee80211_eht_operation *eht_operation;
 	const struct ieee80211_multi_link_elem *ml_basic;
 	const struct ieee80211_multi_link_elem *ml_reconf;
+	const struct ieee80211_bandwidth_indication *bandwidth_indication;
 
 	/* length of them, respectively */
 	u8 ext_capab_len;
@@ -2463,7 +2464,7 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw, u32 vht_cap_info,
 				const struct ieee80211_vht_operation *oper,
 				const struct ieee80211_ht_operation *htop,
 				struct cfg80211_chan_def *chandef);
-void ieee80211_chandef_eht_oper(const struct ieee80211_eht_operation *eht_oper,
+void ieee80211_chandef_eht_oper(const struct ieee80211_eht_operation_info *info,
 				bool support_160, bool support_320,
 				struct cfg80211_chan_def *chandef);
 bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index e8f16ed235c3..a211f594f25a 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -109,7 +109,8 @@ ieee80211_extract_dis_subch_bmap(const struct ieee80211_eht_operation *eht_oper,
 		return 0;
 
 	/* set 160/320 supported to get the full AP definition */
-	ieee80211_chandef_eht_oper(eht_oper, true, true, &ap_chandef);
+	ieee80211_chandef_eht_oper((const void *)eht_oper->optional,
+				   true, true, &ap_chandef);
 	ap_center_freq = ap_chandef.center_freq1;
 	ap_bw = 20 * BIT(u8_get_bits(info->control,
 				     IEEE80211_EHT_OPER_CHAN_WIDTH));
@@ -387,7 +388,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	if (eht_oper && (eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT)) {
 		struct cfg80211_chan_def eht_chandef = *chandef;
 
-		ieee80211_chandef_eht_oper(eht_oper,
+		ieee80211_chandef_eht_oper((const void *)eht_oper->optional,
 					   eht_chandef.width ==
 					   NL80211_CHAN_WIDTH_160,
 					   false, &eht_chandef);
diff --git a/net/mac80211/spectmgmt.c b/net/mac80211/spectmgmt.c
index 871cdac2d0f4..55959b0b24c5 100644
--- a/net/mac80211/spectmgmt.c
+++ b/net/mac80211/spectmgmt.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2008, Intel Corporation
  * Copyright 2008, Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2018, 2020, 2022 Intel Corporation
+ * Copyright (C) 2018, 2020, 2022-2023 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -33,12 +33,14 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 	struct cfg80211_chan_def new_vht_chandef = {};
 	const struct ieee80211_sec_chan_offs_ie *sec_chan_offs;
 	const struct ieee80211_wide_bw_chansw_ie *wide_bw_chansw_ie;
+	const struct ieee80211_bandwidth_indication *bwi;
 	int secondary_channel_offset = -1;
 
 	memset(csa_ie, 0, sizeof(*csa_ie));
 
 	sec_chan_offs = elems->sec_chan_offs;
 	wide_bw_chansw_ie = elems->wide_bw_chansw_ie;
+	bwi = elems->bandwidth_indication;
 
 	if (conn_flags & (IEEE80211_CONN_DISABLE_HT |
 			  IEEE80211_CONN_DISABLE_40MHZ)) {
@@ -132,7 +134,14 @@ int ieee80211_parse_ch_switch_ie(struct ieee80211_sub_if_data *sdata,
 		break;
 	}
 
-	if (wide_bw_chansw_ie) {
+	if (bwi) {
+		/* start with the CSA one */
+		new_vht_chandef = csa_ie->chandef;
+		/* and update the width accordingly */
+		/* FIXME: support 160/320 */
+		ieee80211_chandef_eht_oper(&bwi->info, true, true,
+					   &new_vht_chandef);
+	} else if (wide_bw_chansw_ie) {
 		u8 new_seg1 = wide_bw_chansw_ie->new_center_freq_seg1;
 		struct ieee80211_vht_operation vht_oper = {
 			.chan_width =
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 88f714a75862..a1e18938ce52 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -990,6 +990,11 @@ ieee80211_parse_extension_element(u32 *crc,
 			}
 		}
 		break;
+	case WLAN_EID_EXT_BANDWIDTH_INDICATION:
+		if (ieee80211_bandwidth_indication_size_ok(data, len))
+			elems->bandwidth_indication = data;
+		calc_crc = true;
+		break;
 	}
 
 	if (crc && calc_crc)
@@ -1005,11 +1010,11 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 	bool calc_crc = params->filter != 0;
 	DECLARE_BITMAP(seen_elems, 256);
 	u32 crc = params->crc;
-	const u8 *ie;
 
 	bitmap_zero(seen_elems, 256);
 
 	for_each_element(elem, params->start, params->len) {
+		const struct element *subelem;
 		bool elem_parse_failed;
 		u8 id = elem->id;
 		u8 elen = elem->datalen;
@@ -1267,15 +1272,27 @@ _ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params,
 			}
 			/*
 			 * This is a bit tricky, but as we only care about
-			 * the wide bandwidth channel switch element, so
-			 * just parse it out manually.
+			 * a few elements, parse them out manually.
 			 */
-			ie = cfg80211_find_ie(WLAN_EID_WIDE_BW_CHANNEL_SWITCH,
-					      pos, elen);
-			if (ie) {
-				if (ie[1] >= sizeof(*elems->wide_bw_chansw_ie))
+			subelem = cfg80211_find_elem(WLAN_EID_WIDE_BW_CHANNEL_SWITCH,
+						     pos, elen);
+			if (subelem) {
+				if (subelem->datalen >= sizeof(*elems->wide_bw_chansw_ie))
 					elems->wide_bw_chansw_ie =
-						(void *)(ie + 2);
+						(void *)subelem->data;
+				else
+					elem_parse_failed = true;
+			}
+
+			subelem = cfg80211_find_ext_elem(WLAN_EID_EXT_BANDWIDTH_INDICATION,
+							 pos, elen);
+			if (subelem) {
+				const void *edata = subelem->data + 1;
+				u8 edatalen = subelem->datalen - 1;
+
+				if (ieee80211_bandwidth_indication_size_ok(edata,
+									   edatalen))
+					elems->bandwidth_indication = edata;
 				else
 					elem_parse_failed = true;
 			}
@@ -3746,12 +3763,10 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw, u32 vht_cap_info,
 	return true;
 }
 
-void ieee80211_chandef_eht_oper(const struct ieee80211_eht_operation *eht_oper,
+void ieee80211_chandef_eht_oper(const struct ieee80211_eht_operation_info *info,
 				bool support_160, bool support_320,
 				struct cfg80211_chan_def *chandef)
 {
-	struct ieee80211_eht_operation_info *info = (void *)eht_oper->optional;
-
 	chandef->center_freq1 =
 		ieee80211_channel_to_frequency(info->ccfs0,
 					       chandef->chan->band);
@@ -3920,8 +3935,9 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 		support_320 =
 			eht_phy_cap & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
 
-		ieee80211_chandef_eht_oper(eht_oper, support_160,
-					   support_320, &he_chandef);
+		ieee80211_chandef_eht_oper((const void *)eht_oper->optional,
+					   support_160, support_320,
+					   &he_chandef);
 	}
 
 	if (!cfg80211_chandef_valid(&he_chandef)) {
-- 
2.38.1

