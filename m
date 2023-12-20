Return-Path: <linux-wireless+bounces-1002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E674818E61
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 18:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 714F91C24931
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6518137D29;
	Tue, 19 Dec 2023 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iW1swFlG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BD4347BA
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703007659; x=1734543659;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AfoV8V7/jQ+CWiokS4xfpUvm3Mj0WGbsIt0snZvPceY=;
  b=iW1swFlGI30IKC/R+uAo9pgdZw/att33+9v2TneCF/jNuHfne/HVAQYF
   7i96Wm1Lwik8v27fGmWlZaEBr+SxK4SgXmL7GCrdY/HDcMZs7UTx69spa
   BwDr8qsluUX+7UZ7GlQeiAVpz3htm+pwEBSJ0/xuzOi7pxT84J0p1lFwe
   oBS4uFclUwCtwjHSodka0uPpsQuMi1W3pjM1EZWFpGUxPRKp9YTdEVeaz
   AJ32pf+EBEaTL/YArkQt1X7F6QKU3Z4hisCKh+p+aJ/tc126f/84iR6jD
   6mWzJX4DxZHIW/6QOv5HRzPQF+oTWDQCO2nEzowJX3XVdJT+B7OaP55HA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2790347"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="2790347"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 09:40:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="894369881"
X-IronPort-AV: E=Sophos;i="6.04,289,1695711600"; 
   d="scan'208";a="894369881"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 09:40:56 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH v2 01/13] wifi: cfg80211: reg: Support P2P operation on DFS channels
Date: Wed, 20 Dec 2023 13:41:34 +0200
Message-Id: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

FCC-594280 D01 Section B.3 allows peer-to-peer and ad hoc devices to
operate on DFS channels while they operate under the control of a
concurrent DFS master. For example, it is possible to have a P2P GO on a
DFS channel as long as BSS connection is active on the same channel.
Allow such operation by adding additional regulatory flags to indicate
DFS concurrent channels and capable devices. Add the required
relaxations in DFS regulatory checks.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: fix the wrong email addresses
---
 include/net/cfg80211.h       |  2 +
 include/uapi/linux/nl80211.h | 16 ++++++
 net/wireless/chan.c          | 94 +++++++++++++++++++++++++++++++++---
 net/wireless/nl80211.c       |  3 ++
 net/wireless/reg.c           |  2 +
 5 files changed, 110 insertions(+), 7 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 602960dafe0f..868c50b516b8 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -117,6 +117,7 @@ struct wiphy;
  *	This may be due to the driver or due to regulatory bandwidth
  *	restrictions.
  * @IEEE80211_CHAN_NO_EHT: EHT operation is not permitted on this channel.
+ * @IEEE80211_CHAN_DFS_CONCURRENT: See %NL80211_RRF_DFS_CONCURRENT
  */
 enum ieee80211_channel_flags {
 	IEEE80211_CHAN_DISABLED		= 1<<0,
@@ -140,6 +141,7 @@ enum ieee80211_channel_flags {
 	IEEE80211_CHAN_16MHZ		= 1<<18,
 	IEEE80211_CHAN_NO_320MHZ	= 1<<19,
 	IEEE80211_CHAN_NO_EHT		= 1<<20,
+	IEEE80211_CHAN_DFS_CONCURRENT	= 1<<21,
 };
 
 #define IEEE80211_CHAN_NO_HT40 \
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index a682b54bd3ba..466da830e65f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4256,6 +4256,10 @@ enum nl80211_wmm_rule {
  *	in current regulatory domain.
  * @NL80211_FREQUENCY_ATTR_PSD: Power spectral density (in dBm) that
  *	is allowed on this channel in current regulatory domain.
+ * @NL80211_FREQUENCY_ATTR_DFS_CONCURRENT: Operation on this channel is
+ *	allowed for peer-to-peer or adhoc communication under the control
+ *	of a DFS master which operates on the same channel (FCC-594280 D01
+ *	Section B.3). Should be used together with %NL80211_RRF_DFS only.
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -4295,6 +4299,7 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_NO_320MHZ,
 	NL80211_FREQUENCY_ATTR_NO_EHT,
 	NL80211_FREQUENCY_ATTR_PSD,
+	NL80211_FREQUENCY_ATTR_DFS_CONCURRENT,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
@@ -4500,6 +4505,10 @@ enum nl80211_sched_scan_match_attr {
  * @NL80211_RRF_NO_320MHZ: 320MHz operation not allowed
  * @NL80211_RRF_NO_EHT: EHT operation not allowed
  * @NL80211_RRF_PSD: Ruleset has power spectral density value
+ * @NL80211_RRF_DFS_CONCURRENT: Operation on this channel is allowed for
+	peer-to-peer or adhoc communication under the control of a DFS master
+	which operates on the same channel (FCC-594280 D01 Section B.3).
+	Should be used together with %NL80211_RRF_DFS only.
  */
 enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_OFDM		= 1<<0,
@@ -4521,6 +4530,7 @@ enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_320MHZ		= 1<<18,
 	NL80211_RRF_NO_EHT		= 1<<19,
 	NL80211_RRF_PSD			= 1<<20,
+	NL80211_RRF_DFS_CONCURRENT	= 1<<21,
 };
 
 #define NL80211_RRF_PASSIVE_SCAN	NL80211_RRF_NO_IR
@@ -6492,6 +6502,11 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_OWE_OFFLOAD_AP: Driver/Device wants to do OWE DH IE
  *	handling in AP mode.
  *
+ * @NL80211_EXT_FEATURE_DFS_CONCURRENT: The device supports peer-to-peer or
+ *	ad hoc operation on DFS channels under the control of a concurrent
+ *	DFS master on the same channel as described in FCC-594280 D01
+ *	(Section B.3). This, for example, allows P2P GO and P2P clients to
+ *	operate on DFS channels as long as there's a concurrent BSS connection.
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6565,6 +6580,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA,
 	NL80211_EXT_FEATURE_OWE_OFFLOAD,
 	NL80211_EXT_FEATURE_OWE_OFFLOAD_AP,
+	NL80211_EXT_FEATURE_DFS_CONCURRENT,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index dfb4893421d7..ceb9174c5c3d 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -515,9 +515,83 @@ static u32 cfg80211_get_end_freq(u32 center_freq,
 	return end_freq;
 }
 
+static bool
+cfg80211_dfs_permissive_check_wdev(struct cfg80211_registered_device *rdev,
+				   enum nl80211_iftype iftype,
+				   struct wireless_dev *wdev,
+				   struct ieee80211_channel *chan)
+{
+	unsigned int link_id;
+
+	for_each_valid_link(wdev, link_id) {
+		struct ieee80211_channel *other_chan = NULL;
+		struct cfg80211_chan_def chandef = {};
+		int ret;
+
+		/* In order to avoid daisy chaining only allow BSS STA */
+		if (wdev->iftype != NL80211_IFTYPE_STATION ||
+		    !wdev->links[link_id].client.current_bss)
+			continue;
+
+		other_chan =
+			wdev->links[link_id].client.current_bss->pub.channel;
+
+		if (!other_chan)
+			continue;
+
+		if (chan == other_chan)
+			return true;
+
+		/* continue if we can't get the channel */
+		ret = rdev_get_channel(rdev, wdev, link_id, &chandef);
+		if (ret)
+			continue;
+
+		if (cfg80211_is_sub_chan(&chandef, chan, false))
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * Check if P2P GO is allowed to operate on a DFS channel
+ */
+static bool cfg80211_dfs_permissive_chan(struct wiphy *wiphy,
+					 enum nl80211_iftype iftype,
+					 struct ieee80211_channel *chan)
+{
+	struct wireless_dev *wdev;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+
+	lockdep_assert_held(&rdev->wiphy.mtx);
+
+	if (!wiphy_ext_feature_isset(&rdev->wiphy,
+				     NL80211_EXT_FEATURE_DFS_CONCURRENT) ||
+	    !(chan->flags & IEEE80211_CHAN_DFS_CONCURRENT))
+		return false;
+
+	/* only valid for P2P GO */
+	if (iftype != NL80211_IFTYPE_P2P_GO)
+		return false;
+
+	/*
+	 * Allow only if there's a concurrent BSS
+	 */
+	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
+		bool ret = cfg80211_dfs_permissive_check_wdev(rdev, iftype,
+							      wdev, chan);
+		if (ret)
+			return ret;
+	}
+
+	return false;
+}
+
 static int cfg80211_get_chans_dfs_required(struct wiphy *wiphy,
 					    u32 center_freq,
-					    u32 bandwidth)
+					    u32 bandwidth,
+					    enum nl80211_iftype iftype)
 {
 	struct ieee80211_channel *c;
 	u32 freq, start_freq, end_freq;
@@ -530,9 +604,11 @@ static int cfg80211_get_chans_dfs_required(struct wiphy *wiphy,
 		if (!c)
 			return -EINVAL;
 
-		if (c->flags & IEEE80211_CHAN_RADAR)
+		if (c->flags & IEEE80211_CHAN_RADAR &&
+		    !cfg80211_dfs_permissive_chan(wiphy, iftype, c))
 			return 1;
 	}
+
 	return 0;
 }
 
@@ -558,7 +634,7 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 
 		ret = cfg80211_get_chans_dfs_required(wiphy,
 					ieee80211_chandef_to_khz(chandef),
-					width);
+					width, iftype);
 		if (ret < 0)
 			return ret;
 		else if (ret > 0)
@@ -569,7 +645,7 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 
 		ret = cfg80211_get_chans_dfs_required(wiphy,
 					MHZ_TO_KHZ(chandef->center_freq2),
-					width);
+					width, iftype);
 		if (ret < 0)
 			return ret;
 		else if (ret > 0)
@@ -1337,15 +1413,19 @@ static bool _cfg80211_reg_can_beacon(struct wiphy *wiphy,
 				     bool check_no_ir)
 {
 	bool res;
-	u32 prohibited_flags = IEEE80211_CHAN_DISABLED |
-			       IEEE80211_CHAN_RADAR;
+	u32 prohibited_flags = IEEE80211_CHAN_DISABLED;
+	int dfs_required;
 
 	trace_cfg80211_reg_can_beacon(wiphy, chandef, iftype, check_no_ir);
 
 	if (check_no_ir)
 		prohibited_flags |= IEEE80211_CHAN_NO_IR;
 
-	if (cfg80211_chandef_dfs_required(wiphy, chandef, iftype) > 0 &&
+	dfs_required = cfg80211_chandef_dfs_required(wiphy, chandef, iftype);
+	if (dfs_required != 0)
+		prohibited_flags |= IEEE80211_CHAN_RADAR;
+
+	if (dfs_required > 0 &&
 	    cfg80211_chandef_dfs_available(wiphy, chandef)) {
 		/* We can skip IEEE80211_CHAN_NO_IR if chandef dfs available */
 		prohibited_flags = IEEE80211_CHAN_DISABLED;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 7ea1cb632952..ff2c63d59bb5 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1201,6 +1201,9 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_NO_EHT) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_EHT))
 			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_DFS_CONCURRENT) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_DFS_CONCURRENT))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_MAX_TX_POWER,
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 2ef4f6cc7a32..9a61b3322fd2 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1593,6 +1593,8 @@ static u32 map_regdom_flags(u32 rd_flags)
 		channel_flags |= IEEE80211_CHAN_NO_320MHZ;
 	if (rd_flags & NL80211_RRF_NO_EHT)
 		channel_flags |= IEEE80211_CHAN_NO_EHT;
+	if (rd_flags & NL80211_RRF_DFS_CONCURRENT)
+		channel_flags |= IEEE80211_CHAN_DFS_CONCURRENT;
 	if (rd_flags & NL80211_RRF_PSD)
 		channel_flags |= IEEE80211_CHAN_PSD;
 	return channel_flags;
-- 
2.34.1


