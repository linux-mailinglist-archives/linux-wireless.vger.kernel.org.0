Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149067347C3
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jun 2023 20:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjFRSup (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Jun 2023 14:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjFRSuo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Jun 2023 14:50:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5F8E5C
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jun 2023 11:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687114235; x=1718650235;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rPUUjuNmGFYMUaZAOCPOdgedt1YPZR92tDkSggIHN7E=;
  b=mIeg/fcQbx70tYJriTiEU0zfywbRmLUloAES3WU/l5iKV5os6RcwT4up
   3qHsR2R61IS3p2e9fZNn8XKvHU/whDYt8RhO4XczzOXRuZracZZkLkV3Y
   xxxFZwS5RqG6mluN9eVXR7MrG+VXpMNFxpJBhA+cBePHwWNDWW8lYuiNV
   uB+mYwCx5m/ZKXOBtNrK8/dkue9eGv4W1SDIk6d1SDg63wtRzLjEP5+Fz
   vvGhZISJGSef2Y0CMuIfRn+GxrguMJl1XOLyf6FCT4MgcOZAmznNA5ATJ
   hDiLEXXjBFcx01dthiQebIQofiJ92WtwKmgVLYlw7SU4rVyDDkaLksqBP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="339116644"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="339116644"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:35 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="747233922"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="747233922"
Received: from aflumen-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.251.178.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 11:50:33 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Benjamin Berg <benjamin.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/20] wifi: cfg80211: use a struct for inform_single_bss data
Date:   Sun, 18 Jun 2023 21:49:50 +0300
Message-Id: <20230618214436.831ab8a87b6f.I3bcc83d90f41d6f8a47b39528575dad0a9ec3564@changeid>
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

The argument is getting quite large, so use a struct internally to pass
around the information.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 net/wireless/scan.c | 209 ++++++++++++++++++++++++--------------------
 1 file changed, 112 insertions(+), 97 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 095dc9db8750..974a6a8240dd 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1644,12 +1644,6 @@ static bool cfg80211_combine_bsses(struct cfg80211_registered_device *rdev,
 	return true;
 }
 
-struct cfg80211_non_tx_bss {
-	struct cfg80211_bss *tx_bss;
-	u8 max_bssid_indicator;
-	u8 bssid_index;
-};
-
 static void cfg80211_update_hidden_bsses(struct cfg80211_internal_bss *known,
 					 const struct cfg80211_bss_ies *new_ies,
 					 const struct cfg80211_bss_ies *old_ies)
@@ -1977,17 +1971,30 @@ cfg80211_get_bss_channel(struct wiphy *wiphy, const u8 *ie, size_t ielen,
 	return alt_channel;
 }
 
+struct cfg80211_inform_single_bss_data {
+	struct cfg80211_inform_bss *drv_data;
+	enum cfg80211_bss_frame_type ftype;
+	u8 bssid[ETH_ALEN];
+	u64 tsf;
+	u16 capability;
+	u16 beacon_interval;
+	const u8 *ie;
+	size_t ielen;
+
+	/* Set for nontransmitted BSSIDs */
+	struct cfg80211_bss *source_bss;
+	u8 max_bssid_indicator;
+	u8 bssid_index;
+};
+
 /* Returned bss is reference counted and must be cleaned up appropriately. */
 static struct cfg80211_bss *
 cfg80211_inform_single_bss_data(struct wiphy *wiphy,
-				struct cfg80211_inform_bss *data,
-				enum cfg80211_bss_frame_type ftype,
-				const u8 *bssid, u64 tsf, u16 capability,
-				u16 beacon_interval, const u8 *ie, size_t ielen,
-				struct cfg80211_non_tx_bss *non_tx_data,
+				struct cfg80211_inform_single_bss_data *data,
 				gfp_t gfp)
 {
 	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct cfg80211_inform_bss *drv_data = data->drv_data;
 	struct cfg80211_bss_ies *ies;
 	struct ieee80211_channel *channel;
 	struct cfg80211_internal_bss tmp = {}, *res;
@@ -1999,40 +2006,41 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 		return NULL;
 
 	if (WARN_ON(wiphy->signal_type == CFG80211_SIGNAL_TYPE_UNSPEC &&
-		    (data->signal < 0 || data->signal > 100)))
+		    (drv_data->signal < 0 || drv_data->signal > 100)))
 		return NULL;
 
-	channel = cfg80211_get_bss_channel(wiphy, ie, ielen, data->chan,
-					   data->scan_width);
+	channel = cfg80211_get_bss_channel(wiphy, data->ie, data->ielen,
+					   drv_data->chan, drv_data->scan_width);
 	if (!channel)
 		return NULL;
 
-	memcpy(tmp.pub.bssid, bssid, ETH_ALEN);
+	memcpy(tmp.pub.bssid, data->bssid, ETH_ALEN);
 	tmp.pub.channel = channel;
-	tmp.pub.scan_width = data->scan_width;
-	tmp.pub.signal = data->signal;
-	tmp.pub.beacon_interval = beacon_interval;
-	tmp.pub.capability = capability;
-	tmp.ts_boottime = data->boottime_ns;
-	tmp.parent_tsf = data->parent_tsf;
-	ether_addr_copy(tmp.parent_bssid, data->parent_bssid);
-
-	if (non_tx_data) {
-		tmp.pub.transmitted_bss = non_tx_data->tx_bss;
-		ts = bss_from_pub(non_tx_data->tx_bss)->ts;
-		tmp.pub.bssid_index = non_tx_data->bssid_index;
-		tmp.pub.max_bssid_indicator = non_tx_data->max_bssid_indicator;
+	tmp.pub.scan_width = drv_data->scan_width;
+	tmp.pub.signal = drv_data->signal;
+	tmp.pub.beacon_interval = data->beacon_interval;
+	tmp.pub.capability = data->capability;
+	tmp.ts_boottime = drv_data->boottime_ns;
+	tmp.parent_tsf = drv_data->parent_tsf;
+	ether_addr_copy(tmp.parent_bssid, drv_data->parent_bssid);
+
+	if (data->source_bss) {
+		tmp.pub.transmitted_bss = data->source_bss;
+		ts = bss_from_pub(data->source_bss)->ts;
+		tmp.pub.bssid_index = data->bssid_index;
+		tmp.pub.max_bssid_indicator = data->max_bssid_indicator;
 	} else {
 		ts = jiffies;
 
 		if (channel->band == NL80211_BAND_60GHZ) {
-			bss_type = capability & WLAN_CAPABILITY_DMG_TYPE_MASK;
+			bss_type = data->capability &
+				   WLAN_CAPABILITY_DMG_TYPE_MASK;
 			if (bss_type == WLAN_CAPABILITY_DMG_TYPE_AP ||
 			    bss_type == WLAN_CAPABILITY_DMG_TYPE_PBSS)
 				regulatory_hint_found_beacon(wiphy, channel,
 							     gfp);
 		} else {
-			if (capability & WLAN_CAPABILITY_ESS)
+			if (data->capability & WLAN_CAPABILITY_ESS)
 				regulatory_hint_found_beacon(wiphy, channel,
 							     gfp);
 		}
@@ -2046,15 +2054,15 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	 * override the IEs pointer should we have received an earlier
 	 * indication of Probe Response data.
 	 */
-	ies = kzalloc(sizeof(*ies) + ielen, gfp);
+	ies = kzalloc(sizeof(*ies) + data->ielen, gfp);
 	if (!ies)
 		return NULL;
-	ies->len = ielen;
-	ies->tsf = tsf;
+	ies->len = data->ielen;
+	ies->tsf = data->tsf;
 	ies->from_beacon = false;
-	memcpy(ies->data, ie, ielen);
+	memcpy(ies->data, data->ie, data->ielen);
 
-	switch (ftype) {
+	switch (data->ftype) {
 	case CFG80211_BSS_FTYPE_BEACON:
 		ies->from_beacon = true;
 		fallthrough;
@@ -2067,7 +2075,7 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	}
 	rcu_assign_pointer(tmp.pub.ies, ies);
 
-	signal_valid = data->chan == channel;
+	signal_valid = drv_data->chan == channel;
 	spin_lock_bh(&rdev->bss_lock);
 	res = __cfg80211_bss_update(rdev, &tmp, signal_valid, ts);
 	if (!res)
@@ -2075,12 +2083,11 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 
 	rdev_inform_bss(rdev, &res->pub, ies, data->drv_data);
 
-	if (non_tx_data) {
+	if (data->source_bss) {
 		/* this is a nontransmitting bss, we need to add it to
 		 * transmitting bss' list if it is not there
 		 */
-		if (cfg80211_add_nontrans_list(non_tx_data->tx_bss,
-					       &res->pub)) {
+		if (cfg80211_add_nontrans_list(data->source_bss, &res->pub)) {
 			if (__cfg80211_unlink_bss(rdev, res)) {
 				rdev->bss_generation++;
 				res = NULL;
@@ -2173,43 +2180,47 @@ size_t cfg80211_merge_profile(const u8 *ie, size_t ielen,
 }
 EXPORT_SYMBOL(cfg80211_merge_profile);
 
-static void cfg80211_parse_mbssid_data(struct wiphy *wiphy,
-				       struct cfg80211_inform_bss *data,
-				       enum cfg80211_bss_frame_type ftype,
-				       const u8 *bssid, u64 tsf,
-				       u16 beacon_interval, const u8 *ie,
-				       size_t ielen,
-				       struct cfg80211_non_tx_bss *non_tx_data,
-				       gfp_t gfp)
-{
+static void
+cfg80211_parse_mbssid_data(struct wiphy *wiphy,
+			   struct cfg80211_inform_single_bss_data *tx_data,
+			   struct cfg80211_bss *source_bss,
+			   gfp_t gfp)
+{
+	struct cfg80211_inform_single_bss_data data = {
+		.drv_data = tx_data->drv_data,
+		.ftype = tx_data->ftype,
+		.tsf = tx_data->tsf,
+		.beacon_interval = tx_data->beacon_interval,
+		.source_bss = source_bss,
+	};
 	const u8 *mbssid_index_ie;
 	const struct element *elem, *sub;
-	size_t new_ie_len;
-	u8 new_bssid[ETH_ALEN];
 	u8 *new_ie, *profile;
 	u64 seen_indices = 0;
-	u16 capability;
 	struct cfg80211_bss *bss;
 
-	if (!non_tx_data)
+	if (!source_bss)
 		return;
-	if (!cfg80211_find_elem(WLAN_EID_MULTIPLE_BSSID, ie, ielen))
+	if (!cfg80211_find_elem(WLAN_EID_MULTIPLE_BSSID,
+				tx_data->ie, tx_data->ielen))
 		return;
 	if (!wiphy->support_mbssid)
 		return;
 	if (wiphy->support_only_he_mbssid &&
-	    !cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY, ie, ielen))
+	    !cfg80211_find_ext_elem(WLAN_EID_EXT_HE_CAPABILITY,
+				    tx_data->ie, tx_data->ielen))
 		return;
 
 	new_ie = kmalloc(IEEE80211_MAX_DATA_LEN, gfp);
 	if (!new_ie)
 		return;
 
-	profile = kmalloc(ielen, gfp);
+	profile = kmalloc(tx_data->ielen, gfp);
 	if (!profile)
 		goto out;
 
-	for_each_element_id(elem, WLAN_EID_MULTIPLE_BSSID, ie, ielen) {
+	for_each_element_id(elem, WLAN_EID_MULTIPLE_BSSID,
+			    tx_data->ie, tx_data->ielen) {
 		if (elem->datalen < 4)
 			continue;
 		if (elem->data[0] < 1 || (int)elem->data[0] > 8)
@@ -2231,12 +2242,13 @@ static void cfg80211_parse_mbssid_data(struct wiphy *wiphy,
 				continue;
 			}
 
-			memset(profile, 0, ielen);
-			profile_len = cfg80211_merge_profile(ie, ielen,
+			memset(profile, 0, tx_data->ielen);
+			profile_len = cfg80211_merge_profile(tx_data->ie,
+							     tx_data->ielen,
 							     elem,
 							     sub,
 							     profile,
-							     ielen);
+							     tx_data->ielen);
 
 			/* found a Nontransmitted BSSID Profile */
 			mbssid_index_ie = cfg80211_find_ie
@@ -2256,31 +2268,27 @@ static void cfg80211_parse_mbssid_data(struct wiphy *wiphy,
 
 			seen_indices |= BIT_ULL(mbssid_index_ie[2]);
 
-			non_tx_data->bssid_index = mbssid_index_ie[2];
-			non_tx_data->max_bssid_indicator = elem->data[0];
+			data.bssid_index = mbssid_index_ie[2];
+			data.max_bssid_indicator = elem->data[0];
+
+			cfg80211_gen_new_bssid(tx_data->bssid,
+					       data.max_bssid_indicator,
+					       data.bssid_index,
+					       data.bssid);
 
-			cfg80211_gen_new_bssid(bssid,
-					       non_tx_data->max_bssid_indicator,
-					       non_tx_data->bssid_index,
-					       new_bssid);
 			memset(new_ie, 0, IEEE80211_MAX_DATA_LEN);
-			new_ie_len = cfg80211_gen_new_ie(ie, ielen,
+			data.ie = new_ie;
+			data.ielen = cfg80211_gen_new_ie(tx_data->ie,
+							 tx_data->ielen,
 							 profile,
-							 profile_len, new_ie,
+							 profile_len,
+							 new_ie,
 							 IEEE80211_MAX_DATA_LEN);
-			if (!new_ie_len)
+			if (!data.ielen)
 				continue;
 
-			capability = get_unaligned_le16(profile + 2);
-			bss = cfg80211_inform_single_bss_data(wiphy, data,
-							      ftype,
-							      new_bssid, tsf,
-							      capability,
-							      beacon_interval,
-							      new_ie,
-							      new_ie_len,
-							      non_tx_data,
-							      gfp);
+			data.capability = get_unaligned_le16(profile + 2);
+			bss = cfg80211_inform_single_bss_data(wiphy, &data, gfp);
 			if (!bss)
 				break;
 			cfg80211_put_bss(wiphy, bss);
@@ -2360,18 +2368,24 @@ cfg80211_inform_bss_data(struct wiphy *wiphy,
 			 u16 beacon_interval, const u8 *ie, size_t ielen,
 			 gfp_t gfp)
 {
+	struct cfg80211_inform_single_bss_data inform_data = {
+		.drv_data = data,
+		.ftype = ftype,
+		.tsf = tsf,
+		.capability = capability,
+		.beacon_interval = beacon_interval,
+		.ie = ie,
+		.ielen = ielen,
+	};
 	struct cfg80211_bss *res;
-	struct cfg80211_non_tx_bss non_tx_data;
 
-	res = cfg80211_inform_single_bss_data(wiphy, data, ftype, bssid, tsf,
-					      capability, beacon_interval, ie,
-					      ielen, NULL, gfp);
+	memcpy(inform_data.bssid, bssid, ETH_ALEN);
+
+	res = cfg80211_inform_single_bss_data(wiphy, &inform_data, gfp);
 	if (!res)
 		return NULL;
-	non_tx_data.tx_bss = res;
-	cfg80211_parse_mbssid_data(wiphy, data, ftype, bssid, tsf,
-				   beacon_interval, ie, ielen, &non_tx_data,
-				   gfp);
+
+	cfg80211_parse_mbssid_data(wiphy, &inform_data, res, gfp);
 	return res;
 }
 EXPORT_SYMBOL(cfg80211_inform_bss_data);
@@ -2517,12 +2531,13 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 			       struct ieee80211_mgmt *mgmt, size_t len,
 			       gfp_t gfp)
 {
+	struct cfg80211_inform_single_bss_data inform_data = {
+		.drv_data = data,
+		.ie = mgmt->u.probe_resp.variable,
+		.ielen = len - offsetof(struct ieee80211_mgmt,
+					u.probe_resp.variable),
+	};
 	struct cfg80211_bss *res;
-	const u8 *ie = mgmt->u.probe_resp.variable;
-	size_t ielen = len - offsetof(struct ieee80211_mgmt,
-				      u.probe_resp.variable);
-	enum cfg80211_bss_frame_type ftype;
-	struct cfg80211_non_tx_bss non_tx_data = {};
 
 	res = cfg80211_inform_single_bss_frame_data(wiphy, data, mgmt,
 						    len, gfp);
@@ -2533,15 +2548,15 @@ cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
 	if (ieee80211_is_s1g_beacon(mgmt->frame_control))
 		return res;
 
-	ftype = ieee80211_is_beacon(mgmt->frame_control) ?
+	inform_data.ftype = ieee80211_is_beacon(mgmt->frame_control) ?
 		CFG80211_BSS_FTYPE_BEACON : CFG80211_BSS_FTYPE_PRESP;
-	non_tx_data.tx_bss = res;
+	memcpy(inform_data.bssid, mgmt->bssid, ETH_ALEN);
+	inform_data.tsf = le64_to_cpu(mgmt->u.probe_resp.timestamp);
+	inform_data.beacon_interval =
+		le16_to_cpu(mgmt->u.probe_resp.beacon_int);
 
 	/* process each non-transmitting bss */
-	cfg80211_parse_mbssid_data(wiphy, data, ftype, mgmt->bssid,
-				   le64_to_cpu(mgmt->u.probe_resp.timestamp),
-				   le16_to_cpu(mgmt->u.probe_resp.beacon_int),
-				   ie, ielen, &non_tx_data, gfp);
+	cfg80211_parse_mbssid_data(wiphy, &inform_data, res, gfp);
 
 	return res;
 }
-- 
2.38.1

