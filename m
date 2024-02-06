Return-Path: <linux-wireless+bounces-3227-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E60D484B890
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 15:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7362897AC
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 14:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDD01339A5;
	Tue,  6 Feb 2024 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SG6ESC3s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FC91339A1
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707231278; cv=none; b=VLXiBPYlWAFAnZU1hmqq9dbHfs4wc39A+0/cutxYQwqF8FcF1E5nT/Xygt8mdLDQDON52GxoRdOhTmb+7TUIVyRK4mqWPDl6OHEy/Fb6SEuzIo1HWz6gYDljkd1Q82HQlRZBsE0KXwGMjJfFX7mIU+Q5WKYHLIEStbGCZHkZWtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707231278; c=relaxed/simple;
	bh=a+uU5nMmXeYr2uno2PcybugAcB3ZlMj3ftTW3hpzoGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=poZUKyhzlR0VComVAT8g8L+MEu0vJQBPHmxV2YV4Yvx/61E0O4GV5v/pQsHs/dOmj9Ca/hmkQw5PJq1wAy+ToxmXodM3zrAJdgzacJfFRbh30AenEczGWUGtNMw9xu8FrLvAffUT9rveeo3rw/huDvGgUdfzQenFLatgd7P4+UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SG6ESC3s; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707231277; x=1738767277;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a+uU5nMmXeYr2uno2PcybugAcB3ZlMj3ftTW3hpzoGs=;
  b=SG6ESC3sgx7HxGizV1Hiw7vFO/LPIilIRp5dafKcGdUTChyc8BtQYJuD
   gSADzgvXuM4b+ON9H8RiQYpSAfu8O060OW+fNSt3douUoLzoWi6oUMw75
   zFH6G0UjDHo2eYZ7E6WwOFgan3+IOXJQrwPkEY0//d19xpX/HZ98zoJVJ
   bg0aps5beX/77uLbupNbkUkNEgKupR43mim7o9nXxgWJwbiPDabKTqe75
   M9sisVwuYb68J1IH0lQyBtH6LGaZlR81mAOaeLtnVpSL3omJw/qbobHSU
   VrvloUMjtW1miovJDvpDminodTa7YV6a4qfKsio0G16rn/XHok7zWqkeK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="917820"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="917820"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 06:54:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="824197944"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="824197944"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 06:54:35 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5/8] wifi: cfg80211: optionally support monitor on disabled channels
Date: Tue,  6 Feb 2024 16:54:08 +0200
Message-Id: <20240206164849.87fad3a21a09.I9116b2fdc2e2c9fd59a9273a64db7fcb41fc0328@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240206145411.3217588-1-miriam.rachel.korenblit@intel.com>
References: <20240206145411.3217588-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If the hardware supports a disabled channel, it may in
some cases be possible to use monitor mode (without any
transmit) on it when it's otherwise disabled. Add a new
channel flag IEEE80211_CHAN_CAN_MONITOR that makes it
possible for a driver to indicate such a thing.

Make it per channel so drivers could have a choice with
it, perhaps it's only possible on some channels, perhaps
some channels are not supported at all, but still there
and marked disabled.

In _nl80211_parse_chandef() simplify the code and check
only for an unknown channel, _cfg80211_chandef_usable()
will later check for IEEE80211_CHAN_DISABLED anyway.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/cfg80211.h       |  4 ++++
 include/uapi/linux/nl80211.h |  4 ++++
 net/wireless/chan.c          | 26 +++++++++++++++++++-------
 net/wireless/core.h          |  5 ++++-
 net/wireless/nl80211.c       | 27 ++++++++++++++++++---------
 5 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index bac3d75ccded..69e50bc2aa43 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -122,6 +122,9 @@ struct wiphy;
  *	not permitted using this channel
  * @IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT: Client connection with AFC AP
  *	not permitted using this channel
+ * @IEEE80211_CHAN_CAN_MONITOR: This channel can be used for monitor
+ *	mode even in the presence of other (regulatory) restrictions,
+ *	even if it is otherwise disabled.
  */
 enum ieee80211_channel_flags {
 	IEEE80211_CHAN_DISABLED		= 1<<0,
@@ -148,6 +151,7 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_DFS_CONCURRENT	= 1<<21,
 	IEEE80211_CHAN_NO_6GHZ_VLP_CLIENT = 1<<22,
 	IEEE80211_CHAN_NO_6GHZ_AFC_CLIENT = 1<<23,
+	IEEE80211_CHAN_CAN_MONITOR	= 1<<24,
 };
 
 #define IEEE80211_CHAN_NO_HT40 \
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 2af018dfef39..0cac86d090c8 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4272,6 +4272,9 @@ enum nl80211_wmm_rule {
  *	not allowed using this channel
  * @NL80211_FREQUENCY_ATTR_NO_6GHZ_AFC_CLIENT: Client connection to AFC AP
  *	not allowed using this channel
+ * @NL80211_FREQUENCY_ATTR_CAN_MONITOR: This channel can be used in monitor
+ *	mode despite other (regulatory) restrictions, even if the channel is
+ *	otherwise completely disabled.
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -4314,6 +4317,7 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_DFS_CONCURRENT,
 	NL80211_FREQUENCY_ATTR_NO_6GHZ_VLP_CLIENT,
 	NL80211_FREQUENCY_ATTR_NO_6GHZ_AFC_CLIENT,
+	NL80211_FREQUENCY_ATTR_CAN_MONITOR,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index ceb9174c5c3d..1839a4827fce 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -1047,7 +1047,7 @@ EXPORT_SYMBOL(cfg80211_chandef_dfs_cac_time);
 
 static bool cfg80211_secondary_chans_ok(struct wiphy *wiphy,
 					u32 center_freq, u32 bandwidth,
-					u32 prohibited_flags)
+					u32 prohibited_flags, bool monitor)
 {
 	struct ieee80211_channel *c;
 	u32 freq, start_freq, end_freq;
@@ -1057,7 +1057,11 @@ static bool cfg80211_secondary_chans_ok(struct wiphy *wiphy,
 
 	for (freq = start_freq; freq <= end_freq; freq += MHZ_TO_KHZ(20)) {
 		c = ieee80211_get_channel_khz(wiphy, freq);
-		if (!c || c->flags & prohibited_flags)
+		if (!c)
+			return false;
+		if (monitor && c->flags & IEEE80211_CHAN_CAN_MONITOR)
+			continue;
+		if (c->flags & prohibited_flags)
 			return false;
 	}
 
@@ -1117,9 +1121,9 @@ static bool cfg80211_edmg_usable(struct wiphy *wiphy, u8 edmg_channels,
 	return true;
 }
 
-bool cfg80211_chandef_usable(struct wiphy *wiphy,
-			     const struct cfg80211_chan_def *chandef,
-			     u32 prohibited_flags)
+bool _cfg80211_chandef_usable(struct wiphy *wiphy,
+			      const struct cfg80211_chan_def *chandef,
+			      u32 prohibited_flags, bool monitor)
 {
 	struct ieee80211_sta_ht_cap *ht_cap;
 	struct ieee80211_sta_vht_cap *vht_cap;
@@ -1281,14 +1285,22 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 
 	if (!cfg80211_secondary_chans_ok(wiphy,
 					 ieee80211_chandef_to_khz(chandef),
-					 width, prohibited_flags))
+					 width, prohibited_flags, monitor))
 		return false;
 
 	if (!chandef->center_freq2)
 		return true;
 	return cfg80211_secondary_chans_ok(wiphy,
 					   MHZ_TO_KHZ(chandef->center_freq2),
-					   width, prohibited_flags);
+					   width, prohibited_flags, monitor);
+}
+
+bool cfg80211_chandef_usable(struct wiphy *wiphy,
+			     const struct cfg80211_chan_def *chandef,
+			     u32 prohibited_flags)
+{
+	return _cfg80211_chandef_usable(wiphy, chandef, prohibited_flags,
+					false);
 }
 EXPORT_SYMBOL(cfg80211_chandef_usable);
 
diff --git a/net/wireless/core.h b/net/wireless/core.h
index debf63e6c61f..118f2f619828 100644
--- a/net/wireless/core.h
+++ b/net/wireless/core.h
@@ -3,7 +3,7 @@
  * Wireless configuration interface internals.
  *
  * Copyright 2006-2010	Johannes Berg <johannes@sipsolutions.net>
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 #ifndef __NET_WIRELESS_CORE_H
 #define __NET_WIRELESS_CORE_H
@@ -492,6 +492,9 @@ bool cfg80211_is_sub_chan(struct cfg80211_chan_def *chandef,
 bool cfg80211_wdev_on_sub_chan(struct wireless_dev *wdev,
 			       struct ieee80211_channel *chan,
 			       bool primary_only);
+bool _cfg80211_chandef_usable(struct wiphy *wiphy,
+			      const struct cfg80211_chan_def *chandef,
+			      u32 prohibited_flags, bool monitor);
 
 static inline unsigned int elapsed_jiffies_msecs(unsigned long start)
 {
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 24d3b01cd000..40b4405d15bd 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3233,9 +3233,9 @@ static int nl80211_parse_punct_bitmap(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
-int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
-			  struct genl_info *info,
-			  struct cfg80211_chan_def *chandef)
+static int _nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
+				  struct genl_info *info, bool monitor,
+				  struct cfg80211_chan_def *chandef)
 {
 	struct netlink_ext_ack *extack = info->extack;
 	struct nlattr **attrs = info->attrs;
@@ -3260,10 +3260,9 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 	chandef->freq1_offset = control_freq % 1000;
 	chandef->center_freq2 = 0;
 
-	/* Primary channel not allowed */
-	if (!chandef->chan || chandef->chan->flags & IEEE80211_CHAN_DISABLED) {
+	if (!chandef->chan) {
 		NL_SET_ERR_MSG_ATTR(extack, attrs[NL80211_ATTR_WIPHY_FREQ],
-				    "Channel is disabled");
+				    "Unknown channel");
 		return -EINVAL;
 	}
 
@@ -3345,8 +3344,9 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
-	if (!cfg80211_chandef_usable(&rdev->wiphy, chandef,
-				     IEEE80211_CHAN_DISABLED)) {
+	if (!_cfg80211_chandef_usable(&rdev->wiphy, chandef,
+				      IEEE80211_CHAN_DISABLED,
+				      monitor)) {
 		NL_SET_ERR_MSG(extack, "(extension) channel is disabled");
 		return -EINVAL;
 	}
@@ -3361,6 +3361,13 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 	return 0;
 }
 
+int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
+			  struct genl_info *info,
+			  struct cfg80211_chan_def *chandef)
+{
+	return _nl80211_parse_chandef(rdev, info, false, chandef);
+}
+
 static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
 				 struct net_device *dev,
 				 struct genl_info *info,
@@ -3385,7 +3392,9 @@ static int __nl80211_set_channel(struct cfg80211_registered_device *rdev,
 		link_id = 0;
 	}
 
-	result = nl80211_parse_chandef(rdev, info, &chandef);
+	result = _nl80211_parse_chandef(rdev, info,
+					iftype == NL80211_IFTYPE_MONITOR,
+					&chandef);
 	if (result)
 		return result;
 
-- 
2.34.1


