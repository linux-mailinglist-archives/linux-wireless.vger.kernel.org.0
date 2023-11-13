Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08447E990F
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 10:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbjKMJgD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 04:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjKMJgB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 04:36:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB4C10E7
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 01:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699868156; x=1731404156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5nIYyrubcAia4zaDtKJ4jGYC6TIdGliVkmutlPFNChs=;
  b=bl5eO2TyyeWduc14UqIyyKOI82VYsJeIbDVRWM13zlHjrvtO17P39c1v
   oePfj27PeQ6JEearCWeQroVoFXnpTKZ/IA/yHw63xeljnnDDu3XLw5I/F
   zTsAlOJOWDAeriBU98TH3tuAxjW6fazonQbc8/IOn6OkYynK+z/JX0jNG
   NSO1aoDInIjgYC6+MXUYDno7v1h6TZVn3kyc32g6K8y1EYWVH5yUAk6Wb
   11Nx8tKd4zXEozXI8FkH2tBFqMoP8dRcPbbf91m+R/BnRW3pl39hWAqrP
   9qmHUtSy5974BV+LLeiUr+2E2uf1VqBSJPzzBUxvchbsvayc7M5+6QEGm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="369735720"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="369735720"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 01:35:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="937695255"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="937695255"
Received: from tdistelf-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.220.47])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 01:35:54 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 3/6] wifi: cfg80211: reg: Support P2P operation on DFS channels
Date:   Mon, 13 Nov 2023 11:35:02 +0200
Message-Id: <20231113112844.8684c245e2a0.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231113093505.456824-1-gregory.greenman@intel.com>
References: <20231113093505.456824-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>

FCC-594280 D01 Section B.3 allows peer-to-peer and ad hoc devices to
operate on DFS channels while they operate under the control of a
concurrent DFS master. For example, it is possible to have a P2P GO on a
DFS channel as long as BSS connection is active on the same channel.
Allow such operation by adding additional regulatory flags to indicate
DFS concurrent channels and capable devices. Add the required
relaxations in DFS regulatory checks.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 include/net/cfg80211.h       |  2 +
 include/uapi/linux/nl80211.h | 17 +++++++
 net/wireless/chan.c          | 94 +++++++++++++++++++++++++++++++++---
 net/wireless/nl80211.c       |  3 ++
 net/wireless/reg.c           |  3 ++
 5 files changed, 112 insertions(+), 7 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d36ad4cedf3b..c467d11283f7 100644
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
index 03e44823355e..8724d7f72af3 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4226,6 +4226,10 @@ enum nl80211_wmm_rule {
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
@@ -4265,6 +4269,7 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_NO_320MHZ,
 	NL80211_FREQUENCY_ATTR_NO_EHT,
 	NL80211_FREQUENCY_ATTR_PSD,
+	NL80211_FREQUENCY_ATTR_DFS_CONCURRENT,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
@@ -4470,6 +4475,10 @@ enum nl80211_sched_scan_match_attr {
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
@@ -4491,6 +4500,7 @@ enum nl80211_reg_rule_flags {
 	NL80211_RRF_NO_320MHZ		= 1<<18,
 	NL80211_RRF_NO_EHT		= 1<<19,
 	NL80211_RRF_PSD			= 1<<20,
+	NL80211_RRF_DFS_CONCURRENT	= 1<<21,
 };
 
 #define NL80211_RRF_PASSIVE_SCAN	NL80211_RRF_NO_IR
@@ -6428,6 +6438,12 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_OWE_OFFLOAD_AP: Driver/Device wants to do OWE DH IE
  *	handling in AP mode.
  *
+ * @NL80211_EXT_FEATURE_DFS_CONCURRENT: The device supports peer-to-peer or
+ *	ad hoc operation on DFS channels under the control of a concurrent
+ *	DFS master on the same channel as described in FCC-594280 D01
+ *	(Section B.3). This, for example, allows P2P GO and P2P clients to
+ *	operate on DFS channels as long as there's a concurrent BSS connection.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -6501,6 +6517,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_AUTH_AND_DEAUTH_RANDOM_TA,
 	NL80211_EXT_FEATURE_OWE_OFFLOAD,
 	NL80211_EXT_FEATURE_OWE_OFFLOAD_AP,
+	NL80211_EXT_FEATURE_DFS_CONCURRENT,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 2d21e423abdb..7d63d95b2178 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -514,9 +514,83 @@ static u32 cfg80211_get_end_freq(u32 center_freq,
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
@@ -529,9 +603,11 @@ static int cfg80211_get_chans_dfs_required(struct wiphy *wiphy,
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
 
@@ -557,7 +633,7 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 
 		ret = cfg80211_get_chans_dfs_required(wiphy,
 					ieee80211_chandef_to_khz(chandef),
-					width);
+					width, iftype);
 		if (ret < 0)
 			return ret;
 		else if (ret > 0)
@@ -568,7 +644,7 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 
 		ret = cfg80211_get_chans_dfs_required(wiphy,
 					MHZ_TO_KHZ(chandef->center_freq2),
-					width);
+					width, iftype);
 		if (ret < 0)
 			return ret;
 		else if (ret > 0)
@@ -1336,15 +1412,19 @@ static bool _cfg80211_reg_can_beacon(struct wiphy *wiphy,
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
index 12b7bd92bb86..c693ebddd053 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1198,6 +1198,9 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		if ((chan->flags & IEEE80211_CHAN_NO_EHT) &&
 		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_NO_EHT))
 			goto nla_put_failure;
+		if ((chan->flags & IEEE80211_CHAN_DFS_CONCURRENT) &&
+		    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_DFS_CONCURRENT))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_MAX_TX_POWER,
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 2ef4f6cc7a32..552c05bbad47 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1595,6 +1595,9 @@ static u32 map_regdom_flags(u32 rd_flags)
 		channel_flags |= IEEE80211_CHAN_NO_EHT;
 	if (rd_flags & NL80211_RRF_PSD)
 		channel_flags |= IEEE80211_CHAN_PSD;
+	if (rd_flags & NL80211_RRF_DFS_CONCURRENT)
+		channel_flags |= IEEE80211_CHAN_DFS_CONCURRENT;
+
 	return channel_flags;
 }
 
-- 
2.38.1

