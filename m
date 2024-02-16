Return-Path: <linux-wireless+bounces-3669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BBD857C23
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 12:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2B9B1F220A8
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 11:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDE578680;
	Fri, 16 Feb 2024 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kxLZ7t5H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E529577F39
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084492; cv=none; b=mUdiHOacvlQ9fwJe/WPpe5m0TlnA1TxYwRhkjlgbUmUMbp9QfNOtcIyve1t2bdxIzsBQqVHm3P4Sxefu3kYWc1NbiaENyb2/gegzB0CZGPpqjCbOOR+yLwIW7+S5S6blJ1t3i0giGQFgwTI4rzTB1XoAOu5DsZCy8D4NPPLQAJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084492; c=relaxed/simple;
	bh=qXzMb+/A626zW2fG362UVo02rLxO6Gbsb0rr8AYE1ro=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fGV/6rxNIg3GZSHnz1+sYpCQ8VZNdskyPVKEv4Zf2Cr8J4A3Gu60eww1N48ycA1m071t8rrYpdwGwF+wrJnmqRtuHGbtqjGQYMT8mUIkLK68NvetjbAIExfJ/MBVeXyr+R8Qxjo8qhkKHIQlrxZ9lw1wDqKAC+QQ1HfDB4zPaRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kxLZ7t5H; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708084490; x=1739620490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qXzMb+/A626zW2fG362UVo02rLxO6Gbsb0rr8AYE1ro=;
  b=kxLZ7t5HDp2bpflnSqDuXfqUK7wlxI6yBp+gx2AE9nL/OKc0vG9jsATz
   yixVF/G984w4izYRP5RcG+NU4xz1rgkZgcyQQdr+BDXxfyt0CVbJCTGEy
   Y3sndV1Dg6sb6zgxHXRZZ/EoqcX0XzZYAZbuLZkUnlFBFRZU4PiNlEc8t
   aLgOje9x/RuEUYSKmiHk2xQ8lxTbLvwZBOIX0YqNud88rwEP9cQr7kGhr
   r6kzUQqZpk4H8QcneZUHGxNsjx/dGZeqrnPo95lGMgg4JOpEL+f46Ciky
   XjEG6tutgdoI9ZKeRmqJPlhkdo0Mmgj2prrkYGi1g4EBsHmcLs/4XyVQo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2321911"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2321911"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:54:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="3795592"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:54:48 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/7] wifi: cfg80211: remove cfg80211_inform_single_bss_frame_data()
Date: Fri, 16 Feb 2024 13:54:28 +0200
Message-Id: <20240216135047.f3f864f94c78.I2192adb32ab10713e71f395a9d203386264f6ed5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240216115433.1044027-1-miriam.rachel.korenblit@intel.com>
References: <20240216115433.1044027-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

This function pretty much does what cfg80211_inform_single_bss_data()
already does, except on a frame data. But we can call the other one,
after populating the inform_data more completely, so we don't need to
do everything twice.

This also uncovered a few bugs:
 * the 6 GHz power type checks were only done in this function, move
   (and rename from 'uhb') those;
 * the chains/chain_signal information wasn't used in the latter,
   add that

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/wireless/scan.c | 245 +++++++++++++++-----------------------------
 1 file changed, 80 insertions(+), 165 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 0907a72231ee..754138168646 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2087,6 +2087,35 @@ struct cfg80211_inform_single_bss_data {
 	u64 cannot_use_reasons;
 };
 
+static bool cfg80211_6ghz_power_type_valid(const u8 *ie, size_t ielen,
+					   const u32 flags)
+{
+	const struct element *tmp;
+	struct ieee80211_he_operation *he_oper;
+
+	tmp = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ie, ielen);
+	if (tmp && tmp->datalen >= sizeof(*he_oper) + 1) {
+		const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
+
+		he_oper = (void *)&tmp->data[1];
+		he_6ghz_oper = ieee80211_he_6ghz_oper(he_oper);
+
+		if (!he_6ghz_oper)
+			return false;
+
+		switch (u8_get_bits(he_6ghz_oper->control,
+				    IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
+		case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
+			return true;
+		case IEEE80211_6GHZ_CTRL_REG_SP_AP:
+			return !(flags & IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT);
+		case IEEE80211_6GHZ_CTRL_REG_VLP_AP:
+			return !(flags & IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT);
+		}
+	}
+	return false;
+}
+
 /* Returned bss is reference counted and must be cleaned up appropriately. */
 static struct cfg80211_bss *
 cfg80211_inform_single_bss_data(struct wiphy *wiphy,
@@ -2119,6 +2148,14 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	if (!channel)
 		return NULL;
 
+	if (channel->band == NL80211_BAND_6GHZ &&
+	    !cfg80211_6ghz_power_type_valid(data->ie, data->ielen,
+					    channel->flags)) {
+		data->use_for = 0;
+		data->cannot_use_reasons =
+			NL80211_BSS_CANNOT_USE_6GHZ_PWR_MISMATCH;
+	}
+
 	memcpy(tmp.pub.bssid, data->bssid, ETH_ALEN);
 	tmp.pub.channel = channel;
 	if (data->bss_source != BSS_SOURCE_STA_PROFILE)
@@ -2130,6 +2167,9 @@ cfg80211_inform_single_bss_data(struct wiphy *wiphy,
 	tmp.ts_boottime = drv_data->boottime_ns;
 	tmp.parent_tsf = drv_data->parent_tsf;
 	ether_addr_copy(tmp.parent_bssid, drv_data->parent_bssid);
+	tmp.pub.chains = drv_data->chains;
+	memcpy(tmp.pub.chain_signal, drv_data->chain_signal,
+	       IEEE80211_MAX_CHAINS);
 	tmp.pub.use_for = data->use_for;
 	tmp.pub.cannot_use_reasons = data->cannot_use_reasons;
 
@@ -3025,59 +3065,23 @@ cfg80211_inform_bss_data(struct wiphy *wiphy,
 }
 EXPORT_SYMBOL(cfg80211_inform_bss_data);
 
-static bool cfg80211_uhb_power_type_valid(const u8 *ie,
-					  size_t ielen,
-					  const u32 flags)
-{
-	const struct element *tmp;
-	struct ieee80211_he_operation *he_oper;
-
-	tmp = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ie, ielen);
-	if (tmp && tmp->datalen >= sizeof(*he_oper) + 1) {
-		const struct ieee80211_he_6ghz_oper *he_6ghz_oper;
-
-		he_oper = (void *)&tmp->data[1];
-		he_6ghz_oper = ieee80211_he_6ghz_oper(he_oper);
-
-		if (!he_6ghz_oper)
-			return false;
-
-		switch (u8_get_bits(he_6ghz_oper->control,
-				    IEEE80211_HE_6GHZ_OPER_CTRL_REG_INFO)) {
-		case IEEE80211_6GHZ_CTRL_REG_LPI_AP:
-			return true;
-		case IEEE80211_6GHZ_CTRL_REG_SP_AP:
-			return !(flags & IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT);
-		case IEEE80211_6GHZ_CTRL_REG_VLP_AP:
-			return !(flags & IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT);
-		}
-	}
-	return false;
-}
-
-/* cfg80211_inform_bss_width_frame helper */
-static struct cfg80211_bss *
-cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
-				      struct cfg80211_inform_bss *data,
-				      struct ieee80211_mgmt *mgmt, size_t len,
-				      gfp_t gfp)
+struct cfg80211_bss *
+cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
+			       struct cfg80211_inform_bss *data,
+			       struct ieee80211_mgmt *mgmt, size_t len,
+			       gfp_t gfp)
 {
-	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
-	struct cfg80211_internal_bss tmp = {}, *res;
-	struct cfg80211_bss_ies *ies;
-	struct ieee80211_channel *channel;
-	bool signal_valid;
+	struct cfg80211_inform_single_bss_data inform_data = {
+		.drv_data = data,
+		.use_for = data->restrict_use ?
+				data->use_for :
+				NL80211_BSS_USE_FOR_ALL,
+		.cannot_use_reasons = data->cannot_use_reasons,
+	};
+	size_t min_hdr_len = offsetof(struct ieee80211_mgmt,
+				      u.probe_resp.variable);
 	struct ieee80211_ext *ext = NULL;
-	u8 *bssid, *variable;
-	u16 capability, beacon_int;
-	size_t ielen, min_hdr_len = offsetof(struct ieee80211_mgmt,
-					     u.probe_resp.variable);
-	int bss_type;
-
-	BUILD_BUG_ON(offsetof(struct ieee80211_mgmt, u.probe_resp.variable) !=
-			offsetof(struct ieee80211_mgmt, u.beacon.variable));
-
-	trace_cfg80211_inform_bss_frame(wiphy, data, mgmt, len);
+	struct cfg80211_bss *res;
 
 	if (WARN_ON(!mgmt))
 		return NULL;
@@ -3085,9 +3089,10 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 	if (WARN_ON(!wiphy))
 		return NULL;
 
-	if (WARN_ON(wiphy->signal_type == CFG80211_SIGNAL_TYPE_UNSPEC &&
-		    (data->signal < 0 || data->signal > 100)))
-		return NULL;
+	BUILD_BUG_ON(offsetof(struct ieee80211_mgmt, u.probe_resp.variable) !=
+		     offsetof(struct ieee80211_mgmt, u.beacon.variable));
+
+	trace_cfg80211_inform_bss_frame(wiphy, data, mgmt, len);
 
 	if (ieee80211_is_s1g_beacon(mgmt->frame_control)) {
 		ext = (void *) mgmt;
@@ -3100,140 +3105,50 @@ cfg80211_inform_single_bss_frame_data(struct wiphy *wiphy,
 	if (WARN_ON(len < min_hdr_len))
 		return NULL;
 
-	ielen = len - min_hdr_len;
-	variable = mgmt->u.probe_resp.variable;
-	if (ext) {
-		if (ieee80211_is_s1g_short_beacon(mgmt->frame_control))
-			variable = ext->u.s1g_short_beacon.variable;
-		else
-			variable = ext->u.s1g_beacon.variable;
-	}
-
-	channel = cfg80211_get_bss_channel(wiphy, variable, ielen, data->chan);
-	if (!channel)
-		return NULL;
-
-	if (channel->band == NL80211_BAND_6GHZ &&
-	    !cfg80211_uhb_power_type_valid(variable, ielen, channel->flags)) {
-		data->restrict_use = 1;
-		data->use_for = 0;
-		data->cannot_use_reasons =
-			NL80211_BSS_CANNOT_USE_6GHZ_PWR_MISMATCH;
-	}
-
+	inform_data.ielen = len - min_hdr_len;
+	inform_data.ie = mgmt->u.probe_resp.variable;
 	if (ext) {
 		const struct ieee80211_s1g_bcn_compat_ie *compat;
 		const struct element *elem;
 
+		if (ieee80211_is_s1g_short_beacon(mgmt->frame_control))
+			inform_data.ie = ext->u.s1g_short_beacon.variable;
+		else
+			inform_data.ie = ext->u.s1g_beacon.variable;
+
 		elem = cfg80211_find_elem(WLAN_EID_S1G_BCN_COMPAT,
-					  variable, ielen);
+					  inform_data.ie, inform_data.ielen);
 		if (!elem)
 			return NULL;
 		if (elem->datalen < sizeof(*compat))
 			return NULL;
 		compat = (void *)elem->data;
-		bssid = ext->u.s1g_beacon.sa;
-		capability = le16_to_cpu(compat->compat_info);
-		beacon_int = le16_to_cpu(compat->beacon_int);
+		memcpy(inform_data.bssid, ext->u.s1g_beacon.sa, ETH_ALEN);
+		inform_data.capability = le16_to_cpu(compat->compat_info);
+		inform_data.beacon_interval = le16_to_cpu(compat->beacon_int);
 	} else {
-		bssid = mgmt->bssid;
-		beacon_int = le16_to_cpu(mgmt->u.probe_resp.beacon_int);
-		capability = le16_to_cpu(mgmt->u.probe_resp.capab_info);
+		memcpy(inform_data.bssid, mgmt->bssid, ETH_ALEN);
+		inform_data.beacon_interval =
+			le16_to_cpu(mgmt->u.probe_resp.beacon_int);
+		inform_data.capability =
+			le16_to_cpu(mgmt->u.probe_resp.capab_info);
 	}
 
-	if (channel->band == NL80211_BAND_60GHZ) {
-		bss_type = capability & WLAN_CAPABILITY_DMG_TYPE_MASK;
-		if (bss_type == WLAN_CAPABILITY_DMG_TYPE_AP ||
-		    bss_type == WLAN_CAPABILITY_DMG_TYPE_PBSS)
-			regulatory_hint_found_beacon(wiphy, channel, gfp);
-	} else {
-		if (capability & WLAN_CAPABILITY_ESS)
-			regulatory_hint_found_beacon(wiphy, channel, gfp);
-	}
-
-	ies = kzalloc(sizeof(*ies) + ielen, gfp);
-	if (!ies)
-		return NULL;
-	ies->len = ielen;
-	ies->tsf = le64_to_cpu(mgmt->u.probe_resp.timestamp);
-	ies->from_beacon = ieee80211_is_beacon(mgmt->frame_control) ||
-			   ieee80211_is_s1g_beacon(mgmt->frame_control);
-	memcpy(ies->data, variable, ielen);
+	inform_data.tsf = le64_to_cpu(mgmt->u.probe_resp.timestamp);
 
 	if (ieee80211_is_probe_resp(mgmt->frame_control))
-		rcu_assign_pointer(tmp.pub.proberesp_ies, ies);
+		inform_data.ftype = CFG80211_BSS_FTYPE_PRESP;
 	else
-		rcu_assign_pointer(tmp.pub.beacon_ies, ies);
-	rcu_assign_pointer(tmp.pub.ies, ies);
+		inform_data.ftype = CFG80211_BSS_FTYPE_BEACON;
 
-	memcpy(tmp.pub.bssid, bssid, ETH_ALEN);
-	tmp.pub.beacon_interval = beacon_int;
-	tmp.pub.capability = capability;
-	tmp.pub.channel = channel;
-	tmp.pub.signal = data->signal;
-	tmp.ts_boottime = data->boottime_ns;
-	tmp.parent_tsf = data->parent_tsf;
-	tmp.pub.chains = data->chains;
-	memcpy(tmp.pub.chain_signal, data->chain_signal, IEEE80211_MAX_CHAINS);
-	ether_addr_copy(tmp.parent_bssid, data->parent_bssid);
-	tmp.pub.use_for = data->restrict_use ?
-				data->use_for :
-				NL80211_BSS_USE_FOR_ALL;
-	tmp.pub.cannot_use_reasons = data->cannot_use_reasons;
-
-	signal_valid = data->chan == channel;
-	spin_lock_bh(&rdev->bss_lock);
-	res = __cfg80211_bss_update(rdev, &tmp, signal_valid, jiffies);
-	if (!res)
-		goto drop;
-
-	rdev_inform_bss(rdev, &res->pub, ies, data->drv_data);
-
-	spin_unlock_bh(&rdev->bss_lock);
-
-	trace_cfg80211_return_bss(&res->pub);
-	/* __cfg80211_bss_update gives us a referenced result */
-	return &res->pub;
-
-drop:
-	spin_unlock_bh(&rdev->bss_lock);
-	return NULL;
-}
-
-struct cfg80211_bss *
-cfg80211_inform_bss_frame_data(struct wiphy *wiphy,
-			       struct cfg80211_inform_bss *data,
-			       struct ieee80211_mgmt *mgmt, size_t len,
-			       gfp_t gfp)
-{
-	struct cfg80211_inform_single_bss_data inform_data = {
-		.drv_data = data,
-		.ie = mgmt->u.probe_resp.variable,
-		.ielen = len - offsetof(struct ieee80211_mgmt,
-					u.probe_resp.variable),
-		.use_for = data->restrict_use ?
-				data->use_for :
-				NL80211_BSS_USE_FOR_ALL,
-		.cannot_use_reasons = data->cannot_use_reasons,
-	};
-	struct cfg80211_bss *res;
-
-	res = cfg80211_inform_single_bss_frame_data(wiphy, data, mgmt,
-						    len, gfp);
+	res = cfg80211_inform_single_bss_data(wiphy, &inform_data, gfp);
 	if (!res)
 		return NULL;
 
 	/* don't do any further MBSSID/ML handling for S1G */
-	if (ieee80211_is_s1g_beacon(mgmt->frame_control))
+	if (ext)
 		return res;
 
-	inform_data.ftype = ieee80211_is_beacon(mgmt->frame_control) ?
-		CFG80211_BSS_FTYPE_BEACON : CFG80211_BSS_FTYPE_PRESP;
-	memcpy(inform_data.bssid, mgmt->bssid, ETH_ALEN);
-	inform_data.tsf = le64_to_cpu(mgmt->u.probe_resp.timestamp);
-	inform_data.beacon_interval =
-		le16_to_cpu(mgmt->u.probe_resp.beacon_int);
-
 	/* process each non-transmitting bss */
 	cfg80211_parse_mbssid_data(wiphy, &inform_data, res, gfp);
 
-- 
2.34.1


