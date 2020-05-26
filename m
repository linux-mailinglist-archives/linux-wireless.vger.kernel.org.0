Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 521CC19B9C8
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 03:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbgDBBSW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 21:18:22 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:46474 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733237AbgDBBSV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 21:18:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 50D0D4F7AF1;
        Thu,  2 Apr 2020 01:18:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NK_D_GMwpo2v; Thu,  2 Apr 2020 01:18:14 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id F06F04F7AEB;
        Thu,  2 Apr 2020 01:18:11 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 2/9] cfg80211: express channels with a KHz component
Date:   Wed,  1 Apr 2020 18:18:03 -0700
Message-Id: <20200402011810.22947-3-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200402011810.22947-1-thomas@adapt-ip.com>
References: <20200402011810.22947-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some bands (S1G) define channels centered on a non-integer
MHz. Give ieee80211_channel and cfg80211_chan_def a
freq_offset component where the final frequency can be
expressed as:

MHZ_TO_KHZ(chan->center_freq) + chan->freq_offset;

Also provide some helper functions to do the frequency
conversion and test for equality.

Retain the existing interface to frequency and channel
conversion helpers, and expose new ones which handle
frequencies in units of KHz.

Some internal functions (net/wireless/chan.c) pass around
a frequency value. Convert these to units of KHz.

mesh, ibss, wext, etc. are currently ignored.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 include/net/cfg80211.h | 92 +++++++++++++++++++++++++++++++++++++++---
 net/wireless/chan.c    | 68 +++++++++++++++++--------------
 net/wireless/reg.c     | 40 +++++++++---------
 net/wireless/scan.c    |  4 +-
 net/wireless/trace.h   | 21 +++++++---
 net/wireless/util.c    | 32 +++++++++------
 6 files changed, 182 insertions(+), 75 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index c78bd4ff9e33..9da99a7bdfbf 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -128,6 +128,7 @@ enum ieee80211_channel_flags {
  * with cfg80211.
  *
  * @center_freq: center frequency in MHz
+ * @freq_offset: offset from @center_freq, in KHz
  * @hw_value: hardware-specific value for the channel
  * @flags: channel flags from &enum ieee80211_channel_flags.
  * @orig_flags: channel flags at registration time, used by regulatory
@@ -149,6 +150,7 @@ enum ieee80211_channel_flags {
 struct ieee80211_channel {
 	enum nl80211_band band;
 	u32 center_freq;
+	u16 freq_offset;
 	u16 hw_value;
 	u32 flags;
 	int max_antenna_gain;
@@ -617,6 +619,7 @@ struct key_params {
  *	If edmg is requested (i.e. the .channels member is non-zero),
  *	chan will define the primary channel and all other
  *	parameters are ignored.
+ * @freq1_offset: offset from @center_freq1, in KHz
  */
 struct cfg80211_chan_def {
 	struct ieee80211_channel *chan;
@@ -624,6 +627,7 @@ struct cfg80211_chan_def {
 	u32 center_freq1;
 	u32 center_freq2;
 	struct ieee80211_edmg edmg;
+	u16 freq1_offset;
 };
 
 /**
@@ -713,6 +717,7 @@ cfg80211_chandef_identical(const struct cfg80211_chan_def *chandef1,
 	return (chandef1->chan == chandef2->chan &&
 		chandef1->width == chandef2->width &&
 		chandef1->center_freq1 == chandef2->center_freq1 &&
+		chandef1->freq1_offset == chandef2->freq1_offset &&
 		chandef1->center_freq2 == chandef2->center_freq2);
 }
 
@@ -5145,30 +5150,92 @@ static inline void *wdev_priv(struct wireless_dev *wdev)
  * cfg80211 offers a number of utility functions that can be useful.
  */
 
+/**
+ * ieee80211_channel_equal - compare two struct ieee80211_channel
+ *
+ * @a: 1st struct ieee80211_channel
+ * @b: 2nd struct ieee80211_channel
+ * Return: true if center frequency of @a == @b
+ */
+static inline bool
+ieee80211_channel_equal(struct ieee80211_channel *a,
+			struct ieee80211_channel *b)
+{
+	return (a->center_freq == b->center_freq &&
+		a->freq_offset == b->freq_offset);
+}
+
+/**
+ * ieee80211_channel_to_khz - convert ieee80211_channel to frequency in KHz
+ * @chan: struct ieee80211_channel to convert
+ * Return: The corresponding frequency (in KHz)
+ */
+static inline u32
+ieee80211_channel_to_khz(const struct ieee80211_channel *chan)
+{
+	return MHZ_TO_KHZ(chan->center_freq) + chan->freq_offset;
+}
+
+/**
+ * ieee80211_channel_to_freq_khz - convert channel number to frequency
+ * @chan: channel number
+ * @band: band, necessary due to channel number overlap
+ * Return: The corresponding frequency (in KHz), or 0 if the conversion failed.
+ */
+u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band);
+
 /**
  * ieee80211_channel_to_frequency - convert channel number to frequency
  * @chan: channel number
  * @band: band, necessary due to channel number overlap
  * Return: The corresponding frequency (in MHz), or 0 if the conversion failed.
  */
-int ieee80211_channel_to_frequency(int chan, enum nl80211_band band);
+static inline int
+ieee80211_channel_to_frequency(int chan, enum nl80211_band band)
+{
+	return KHZ_TO_MHZ(ieee80211_channel_to_freq_khz(chan, band));
+}
+
+/**
+ * ieee80211_freq_khz_to_channel - convert frequency to channel number
+ * @freq: center frequency in KHz
+ * Return: The corresponding channel, or 0 if the conversion failed.
+ */
+int ieee80211_freq_khz_to_channel(u32 freq);
 
 /**
  * ieee80211_frequency_to_channel - convert frequency to channel number
- * @freq: center frequency
+ * @freq: center frequency in MHz
  * Return: The corresponding channel, or 0 if the conversion failed.
  */
-int ieee80211_frequency_to_channel(int freq);
+static inline int
+ieee80211_frequency_to_channel(int freq)
+{
+	return ieee80211_freq_khz_to_channel(MHZ_TO_KHZ(freq));
+}
+
+/**
+ * ieee80211_get_channel_khz - get channel struct from wiphy for specified
+ * frequency
+ * @wiphy: the struct wiphy to get the channel for
+ * @freq: the center frequency (in KHz) of the channel
+ * Return: The channel struct from @wiphy at @freq.
+ */
+struct ieee80211_channel *
+ieee80211_get_channel_khz(struct wiphy *wiphy, u32 freq);
 
 /**
  * ieee80211_get_channel - get channel struct from wiphy for specified frequency
  *
  * @wiphy: the struct wiphy to get the channel for
- * @freq: the center frequency of the channel
- *
+ * @freq: the center frequency (in MHz) of the channel
  * Return: The channel struct from @wiphy at @freq.
  */
-struct ieee80211_channel *ieee80211_get_channel(struct wiphy *wiphy, int freq);
+static inline struct ieee80211_channel *
+ieee80211_get_channel(struct wiphy *wiphy, int freq)
+{
+	return ieee80211_get_channel_khz(wiphy, MHZ_TO_KHZ(freq));
+}
 
 /**
  * ieee80211_get_response_rate - get basic rate for a given rate
@@ -7192,6 +7259,19 @@ bool ieee80211_operating_class_to_band(u8 operating_class,
 bool ieee80211_chandef_to_operating_class(struct cfg80211_chan_def *chandef,
 					  u8 *op_class);
 
+/**
+ * ieee80211_chandef_to_khz - convert chandef to frequency in KHz
+ *
+ * @chandef: the chandef to convert
+ *
+ * Returns the center frequency of chandef (1st segment) in KHz.
+ */
+static inline u32
+ieee80211_chandef_to_khz(const struct cfg80211_chan_def *chandef)
+{
+	return MHZ_TO_KHZ(chandef->center_freq1) + chandef->freq1_offset;
+}
+
 /*
  * cfg80211_tdls_oper_request - request userspace to perform TDLS operation
  * @dev: the device on which the operation is requested
diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index fcac5c6366e1..d60e50a3b910 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -27,6 +27,7 @@ void cfg80211_chandef_create(struct cfg80211_chan_def *chandef,
 		return;
 
 	chandef->chan = chan;
+	chandef->freq1_offset = chan->freq_offset;
 	chandef->center_freq2 = 0;
 	chandef->edmg.bw_config = 0;
 	chandef->edmg.channels = 0;
@@ -153,7 +154,8 @@ bool cfg80211_chandef_valid(const struct cfg80211_chan_def *chandef)
 	case NL80211_CHAN_WIDTH_10:
 	case NL80211_CHAN_WIDTH_20:
 	case NL80211_CHAN_WIDTH_20_NOHT:
-		if (chandef->center_freq1 != control_freq)
+		if (ieee80211_chandef_to_khz(chandef) !=
+		    ieee80211_channel_to_khz(chandef->chan))
 			return false;
 		if (chandef->center_freq2)
 			return false;
@@ -386,10 +388,11 @@ static u32 cfg80211_get_start_freq(u32 center_freq,
 {
 	u32 start_freq;
 
-	if (bandwidth <= 20)
+	bandwidth = MHZ_TO_KHZ(bandwidth);
+	if (bandwidth <= MHZ_TO_KHZ(20))
 		start_freq = center_freq;
 	else
-		start_freq = center_freq - bandwidth/2 + 10;
+		start_freq = center_freq - bandwidth / 2 + MHZ_TO_KHZ(10);
 
 	return start_freq;
 }
@@ -399,10 +402,11 @@ static u32 cfg80211_get_end_freq(u32 center_freq,
 {
 	u32 end_freq;
 
-	if (bandwidth <= 20)
+	bandwidth = MHZ_TO_KHZ(bandwidth);
+	if (bandwidth <= MHZ_TO_KHZ(20))
 		end_freq = center_freq;
 	else
-		end_freq = center_freq + bandwidth/2 - 10;
+		end_freq = center_freq + bandwidth / 2 - MHZ_TO_KHZ(10);
 
 	return end_freq;
 }
@@ -417,8 +421,8 @@ static int cfg80211_get_chans_dfs_required(struct wiphy *wiphy,
 	start_freq = cfg80211_get_start_freq(center_freq, bandwidth);
 	end_freq = cfg80211_get_end_freq(center_freq, bandwidth);
 
-	for (freq = start_freq; freq <= end_freq; freq += 20) {
-		c = ieee80211_get_channel(wiphy, freq);
+	for (freq = start_freq; freq <= end_freq; freq += MHZ_TO_KHZ(20)) {
+		c = ieee80211_get_channel_khz(wiphy, freq);
 		if (!c)
 			return -EINVAL;
 
@@ -449,8 +453,8 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 			return -EINVAL;
 
 		ret = cfg80211_get_chans_dfs_required(wiphy,
-						      chandef->center_freq1,
-						      width);
+					ieee80211_chandef_to_khz(chandef),
+					width);
 		if (ret < 0)
 			return ret;
 		else if (ret > 0)
@@ -460,8 +464,8 @@ int cfg80211_chandef_dfs_required(struct wiphy *wiphy,
 			return 0;
 
 		ret = cfg80211_get_chans_dfs_required(wiphy,
-						      chandef->center_freq2,
-						      width);
+					MHZ_TO_KHZ(chandef->center_freq2),
+					width);
 		if (ret < 0)
 			return ret;
 		else if (ret > 0)
@@ -503,8 +507,8 @@ static int cfg80211_get_chans_dfs_usable(struct wiphy *wiphy,
 	 * DFS_AVAILABLE). Return number of usable channels
 	 * (require CAC). Allow DFS and non-DFS channel mix.
 	 */
-	for (freq = start_freq; freq <= end_freq; freq += 20) {
-		c = ieee80211_get_channel(wiphy, freq);
+	for (freq = start_freq; freq <= end_freq; freq += MHZ_TO_KHZ(20)) {
+		c = ieee80211_get_channel_khz(wiphy, freq);
 		if (!c)
 			return -EINVAL;
 
@@ -536,8 +540,9 @@ bool cfg80211_chandef_dfs_usable(struct wiphy *wiphy,
 	if (width < 0)
 		return false;
 
-	r1 = cfg80211_get_chans_dfs_usable(wiphy, chandef->center_freq1,
-					  width);
+	r1 = cfg80211_get_chans_dfs_usable(wiphy,
+					   MHZ_TO_KHZ(chandef->center_freq1),
+					   width);
 
 	if (r1 < 0)
 		return false;
@@ -546,8 +551,8 @@ bool cfg80211_chandef_dfs_usable(struct wiphy *wiphy,
 	case NL80211_CHAN_WIDTH_80P80:
 		WARN_ON(!chandef->center_freq2);
 		r2 = cfg80211_get_chans_dfs_usable(wiphy,
-						   chandef->center_freq2,
-						   width);
+					MHZ_TO_KHZ(chandef->center_freq2),
+					width);
 		if (r2 < 0)
 			return false;
 		break;
@@ -694,8 +699,8 @@ static bool cfg80211_get_chans_dfs_available(struct wiphy *wiphy,
 	 * If any channel in between is disabled or has not
 	 * had gone through CAC return false
 	 */
-	for (freq = start_freq; freq <= end_freq; freq += 20) {
-		c = ieee80211_get_channel(wiphy, freq);
+	for (freq = start_freq; freq <= end_freq; freq += MHZ_TO_KHZ(20)) {
+		c = ieee80211_get_channel_khz(wiphy, freq);
 		if (!c)
 			return false;
 
@@ -724,7 +729,8 @@ static bool cfg80211_chandef_dfs_available(struct wiphy *wiphy,
 	if (width < 0)
 		return false;
 
-	r = cfg80211_get_chans_dfs_available(wiphy, chandef->center_freq1,
+	r = cfg80211_get_chans_dfs_available(wiphy,
+					     MHZ_TO_KHZ(chandef->center_freq1),
 					     width);
 
 	/* If any of channels unavailable for cf1 just return */
@@ -735,8 +741,8 @@ static bool cfg80211_chandef_dfs_available(struct wiphy *wiphy,
 	case NL80211_CHAN_WIDTH_80P80:
 		WARN_ON(!chandef->center_freq2);
 		r = cfg80211_get_chans_dfs_available(wiphy,
-						     chandef->center_freq2,
-						     width);
+					MHZ_TO_KHZ(chandef->center_freq2),
+					width);
 		break;
 	default:
 		WARN_ON(chandef->center_freq2);
@@ -757,8 +763,8 @@ static unsigned int cfg80211_get_chans_dfs_cac_time(struct wiphy *wiphy,
 	start_freq = cfg80211_get_start_freq(center_freq, bandwidth);
 	end_freq = cfg80211_get_end_freq(center_freq, bandwidth);
 
-	for (freq = start_freq; freq <= end_freq; freq += 20) {
-		c = ieee80211_get_channel(wiphy, freq);
+	for (freq = start_freq; freq <= end_freq; freq += MHZ_TO_KHZ(20)) {
+		c = ieee80211_get_channel_khz(wiphy, freq);
 		if (!c)
 			return 0;
 
@@ -790,14 +796,14 @@ cfg80211_chandef_dfs_cac_time(struct wiphy *wiphy,
 		return 0;
 
 	t1 = cfg80211_get_chans_dfs_cac_time(wiphy,
-					     chandef->center_freq1,
+					     MHZ_TO_KHZ(chandef->center_freq1),
 					     width);
 
 	if (!chandef->center_freq2)
 		return t1;
 
 	t2 = cfg80211_get_chans_dfs_cac_time(wiphy,
-					     chandef->center_freq2,
+					     MHZ_TO_KHZ(chandef->center_freq2),
 					     width);
 
 	return max(t1, t2);
@@ -813,8 +819,8 @@ static bool cfg80211_secondary_chans_ok(struct wiphy *wiphy,
 	start_freq = cfg80211_get_start_freq(center_freq, bandwidth);
 	end_freq = cfg80211_get_end_freq(center_freq, bandwidth);
 
-	for (freq = start_freq; freq <= end_freq; freq += 20) {
-		c = ieee80211_get_channel(wiphy, freq);
+	for (freq = start_freq; freq <= end_freq; freq += MHZ_TO_KHZ(20)) {
+		c = ieee80211_get_channel_khz(wiphy, freq);
 		if (!c || c->flags & prohibited_flags)
 			return false;
 	}
@@ -976,13 +982,15 @@ bool cfg80211_chandef_usable(struct wiphy *wiphy,
 		prohibited_flags |= IEEE80211_CHAN_NO_OFDM;
 
 
-	if (!cfg80211_secondary_chans_ok(wiphy, chandef->center_freq1,
+	if (!cfg80211_secondary_chans_ok(wiphy,
+					 ieee80211_chandef_to_khz(chandef),
 					 width, prohibited_flags))
 		return false;
 
 	if (!chandef->center_freq2)
 		return true;
-	return cfg80211_secondary_chans_ok(wiphy, chandef->center_freq2,
+	return cfg80211_secondary_chans_ok(wiphy,
+					   MHZ_TO_KHZ(chandef->center_freq2),
 					   width, prohibited_flags);
 }
 EXPORT_SYMBOL(cfg80211_chandef_usable);
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index d476d4da0d09..0d74a31ef0ab 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1658,22 +1658,23 @@ static uint32_t reg_rule_to_chan_bw_flags(const struct ieee80211_regdomain *regd
 					  const struct ieee80211_channel *chan)
 {
 	const struct ieee80211_freq_range *freq_range = NULL;
-	u32 max_bandwidth_khz, bw_flags = 0;
+	u32 max_bandwidth_khz, center_freq_khz, bw_flags = 0;
 
 	freq_range = &reg_rule->freq_range;
 
 	max_bandwidth_khz = freq_range->max_bandwidth_khz;
+	center_freq_khz = ieee80211_channel_to_khz(chan);
 	/* Check if auto calculation requested */
 	if (reg_rule->flags & NL80211_RRF_AUTO_BW)
 		max_bandwidth_khz = reg_get_max_bandwidth(regd, reg_rule);
 
 	/* If we get a reg_rule we can assume that at least 5Mhz fit */
 	if (!cfg80211_does_bw_fit_range(freq_range,
-					MHZ_TO_KHZ(chan->center_freq),
+					center_freq_khz,
 					MHZ_TO_KHZ(10)))
 		bw_flags |= IEEE80211_CHAN_NO_10MHZ;
 	if (!cfg80211_does_bw_fit_range(freq_range,
-					MHZ_TO_KHZ(chan->center_freq),
+					center_freq_khz,
 					MHZ_TO_KHZ(20)))
 		bw_flags |= IEEE80211_CHAN_NO_20MHZ;
 
@@ -1710,7 +1711,7 @@ static void handle_channel(struct wiphy *wiphy,
 
 	flags = chan->orig_flags;
 
-	reg_rule = freq_reg_info(wiphy, MHZ_TO_KHZ(chan->center_freq));
+	reg_rule = freq_reg_info(wiphy, ieee80211_channel_to_khz(chan));
 	if (IS_ERR(reg_rule)) {
 		/*
 		 * We will disable all channels that do not match our
@@ -1729,13 +1730,13 @@ static void handle_channel(struct wiphy *wiphy,
 		if (lr->initiator == NL80211_REGDOM_SET_BY_DRIVER &&
 		    request_wiphy && request_wiphy == wiphy &&
 		    request_wiphy->regulatory_flags & REGULATORY_STRICT_REG) {
-			pr_debug("Disabling freq %d MHz for good\n",
-				 chan->center_freq);
+			pr_debug("Disabling freq %d.%03d MHz for good\n",
+				 chan->center_freq, chan->freq_offset);
 			chan->orig_flags |= IEEE80211_CHAN_DISABLED;
 			chan->flags = chan->orig_flags;
 		} else {
-			pr_debug("Disabling freq %d MHz\n",
-				 chan->center_freq);
+			pr_debug("Disabling freq %d.%03d MHz\n",
+				 chan->center_freq, chan->freq_offset);
 			chan->flags |= IEEE80211_CHAN_DISABLED;
 		}
 		return;
@@ -1936,7 +1937,7 @@ static void handle_reg_beacon(struct wiphy *wiphy, unsigned int chan_idx,
 	sband = wiphy->bands[reg_beacon->chan.band];
 	chan = &sband->channels[chan_idx];
 
-	if (likely(chan->center_freq != reg_beacon->chan.center_freq))
+	if (likely(!ieee80211_channel_equal(chan, &reg_beacon->chan)))
 		return;
 
 	if (chan->beacon_found)
@@ -2269,18 +2270,18 @@ static void handle_channel_custom(struct wiphy *wiphy,
 	u32 bw_flags = 0;
 	const struct ieee80211_reg_rule *reg_rule = NULL;
 	const struct ieee80211_power_rule *power_rule = NULL;
-	u32 bw;
+	u32 bw, center_freq_khz;
 
+	center_freq_khz = ieee80211_channel_to_khz(chan);
 	for (bw = MHZ_TO_KHZ(20); bw >= min_bw; bw = bw / 2) {
-		reg_rule = freq_reg_info_regd(MHZ_TO_KHZ(chan->center_freq),
-					      regd, bw);
+		reg_rule = freq_reg_info_regd(center_freq_khz, regd, bw);
 		if (!IS_ERR(reg_rule))
 			break;
 	}
 
 	if (IS_ERR_OR_NULL(reg_rule)) {
-		pr_debug("Disabling freq %d MHz as custom regd has no rule that fits it\n",
-			 chan->center_freq);
+		pr_debug("Disabling freq %d.%03d MHz as custom regd has no rule that fits it\n",
+			 chan->center_freq, chan->freq_offset);
 		if (wiphy->regulatory_flags & REGULATORY_WIPHY_SELF_MANAGED) {
 			chan->flags |= IEEE80211_CHAN_DISABLED;
 		} else {
@@ -3337,8 +3338,8 @@ static bool pending_reg_beacon(struct ieee80211_channel *beacon_chan)
 	struct reg_beacon *pending_beacon;
 
 	list_for_each_entry(pending_beacon, &reg_pending_beacons, list)
-		if (beacon_chan->center_freq ==
-		    pending_beacon->chan.center_freq)
+		if (ieee80211_channel_equal(beacon_chan,
+					    &pending_beacon->chan))
 			return true;
 	return false;
 }
@@ -3367,9 +3368,10 @@ int regulatory_hint_found_beacon(struct wiphy *wiphy,
 	if (!reg_beacon)
 		return -ENOMEM;
 
-	pr_debug("Found new beacon on frequency: %d MHz (Ch %d) on %s\n",
-		 beacon_chan->center_freq,
-		 ieee80211_frequency_to_channel(beacon_chan->center_freq),
+	pr_debug("Found new beacon on frequency: %d.%03d MHz (Ch %d) on %s\n",
+		 beacon_chan->center_freq, beacon_chan->freq_offset,
+		 ieee80211_freq_khz_to_channel(
+			 ieee80211_channel_to_khz(beacon_chan)),
 		 wiphy_name(wiphy));
 
 	memcpy(&reg_beacon->chan, beacon_chan,
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 4000382aef48..74ea4cfb39fb 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1322,8 +1322,8 @@ cfg80211_get_bss_channel(struct wiphy *wiphy, const u8 *ie, size_t ielen,
 		return channel;
 	}
 
-	freq = ieee80211_channel_to_frequency(channel_number, channel->band);
-	alt_channel = ieee80211_get_channel(wiphy, freq);
+	freq = ieee80211_channel_to_freq_khz(channel_number, channel->band);
+	alt_channel = ieee80211_get_channel_khz(wiphy, freq);
 	if (!alt_channel) {
 		if (channel->band == NL80211_BAND_2GHZ) {
 			/*
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 839df54cee21..74647f239581 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -112,24 +112,29 @@
 	} while (0)
 
 #define CHAN_ENTRY __field(enum nl80211_band, band) \
-		   __field(u32, center_freq)
+		   __field(u32, center_freq)		\
+		   __field(u16, freq_offset)
 #define CHAN_ASSIGN(chan)					  \
 	do {							  \
 		if (chan) {					  \
 			__entry->band = chan->band;		  \
 			__entry->center_freq = chan->center_freq; \
+			__entry->freq_offset = chan->freq_offset; \
 		} else {					  \
 			__entry->band = 0;			  \
 			__entry->center_freq = 0;		  \
+			__entry->freq_offset = 0;		  \
 		}						  \
 	} while (0)
-#define CHAN_PR_FMT "band: %d, freq: %u"
-#define CHAN_PR_ARG __entry->band, __entry->center_freq
+#define CHAN_PR_FMT "band: %d, freq: %u.%03u"
+#define CHAN_PR_ARG __entry->band, __entry->center_freq, __entry->freq_offset
 
 #define CHAN_DEF_ENTRY __field(enum nl80211_band, band)		\
 		       __field(u32, control_freq)			\
+		       __field(u32, freq_offset)			\
 		       __field(u32, width)				\
 		       __field(u32, center_freq1)			\
+		       __field(u32, freq1_offset)			\
 		       __field(u32, center_freq2)
 #define CHAN_DEF_ASSIGN(chandef)					\
 	do {								\
@@ -137,21 +142,27 @@
 			__entry->band = (chandef)->chan->band;		\
 			__entry->control_freq =				\
 				(chandef)->chan->center_freq;		\
+			__entry->freq_offset =				\
+				(chandef)->chan->freq_offset;		\
 			__entry->width = (chandef)->width;		\
 			__entry->center_freq1 = (chandef)->center_freq1;\
+			__entry->freq1_offset = (chandef)->freq1_offset;\
 			__entry->center_freq2 = (chandef)->center_freq2;\
 		} else {						\
 			__entry->band = 0;				\
 			__entry->control_freq = 0;			\
+			__entry->freq_offset = 0;			\
 			__entry->width = 0;				\
 			__entry->center_freq1 = 0;			\
+			__entry->freq1_offset = 0;			\
 			__entry->center_freq2 = 0;			\
 		}							\
 	} while (0)
 #define CHAN_DEF_PR_FMT							\
-	"band: %d, control freq: %u, width: %d, cf1: %u, cf2: %u"
+	"band: %d, control freq: %u.%03u, width: %d, cf1: %u.%03u, cf2: %u"
 #define CHAN_DEF_PR_ARG __entry->band, __entry->control_freq,		\
-			__entry->width, __entry->center_freq1,		\
+			__entry->freq_offset, __entry->width,		\
+			__entry->center_freq1, __entry->freq1_offset,	\
 			__entry->center_freq2
 
 #define SINFO_ENTRY __field(int, generation)	    \
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 6590efbbcbb9..7418ca613177 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -72,7 +72,7 @@ u32 ieee80211_mandatory_rates(struct ieee80211_supported_band *sband,
 }
 EXPORT_SYMBOL(ieee80211_mandatory_rates);
 
-int ieee80211_channel_to_frequency(int chan, enum nl80211_band band)
+u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band)
 {
 	/* see 802.11 17.3.8.3.2 and Annex J
 	 * there are overlapping channel numbers in 5GHz and 2GHz bands */
@@ -81,15 +81,15 @@ int ieee80211_channel_to_frequency(int chan, enum nl80211_band band)
 	switch (band) {
 	case NL80211_BAND_2GHZ:
 		if (chan == 14)
-			return 2484;
+			return MHZ_TO_KHZ(2484);
 		else if (chan < 14)
-			return 2407 + chan * 5;
+			return MHZ_TO_KHZ(2407 + chan * 5);
 		break;
 	case NL80211_BAND_5GHZ:
 		if (chan >= 182 && chan <= 196)
-			return 4000 + chan * 5;
+			return MHZ_TO_KHZ(4000 + chan * 5);
 		else
-			return 5000 + chan * 5;
+			return MHZ_TO_KHZ(5000 + chan * 5);
 		break;
 	case NL80211_BAND_6GHZ:
 		/* see 802.11ax D4.1 27.3.22.2 */
@@ -98,17 +98,20 @@ int ieee80211_channel_to_frequency(int chan, enum nl80211_band band)
 		break;
 	case NL80211_BAND_60GHZ:
 		if (chan < 7)
-			return 56160 + chan * 2160;
+			return MHZ_TO_KHZ(56160 + chan * 2160);
 		break;
 	default:
 		;
 	}
 	return 0; /* not supported */
 }
-EXPORT_SYMBOL(ieee80211_channel_to_frequency);
+EXPORT_SYMBOL(ieee80211_channel_to_freq_khz);
 
-int ieee80211_frequency_to_channel(int freq)
+int ieee80211_freq_khz_to_channel(u32 freq)
 {
+	/* TODO: just handle MHz for now */
+	freq = KHZ_TO_MHZ(freq);
+
 	/* see 802.11 17.3.8.3.2 and Annex J */
 	if (freq == 2484)
 		return 14;
@@ -126,9 +129,10 @@ int ieee80211_frequency_to_channel(int freq)
 	else
 		return 0;
 }
-EXPORT_SYMBOL(ieee80211_frequency_to_channel);
+EXPORT_SYMBOL(ieee80211_freq_khz_to_channel);
 
-struct ieee80211_channel *ieee80211_get_channel(struct wiphy *wiphy, int freq)
+struct ieee80211_channel *ieee80211_get_channel_khz(struct wiphy *wiphy,
+						    u32 freq)
 {
 	enum nl80211_band band;
 	struct ieee80211_supported_band *sband;
@@ -141,14 +145,16 @@ struct ieee80211_channel *ieee80211_get_channel(struct wiphy *wiphy, int freq)
 			continue;
 
 		for (i = 0; i < sband->n_channels; i++) {
-			if (sband->channels[i].center_freq == freq)
-				return &sband->channels[i];
+			struct ieee80211_channel *chan = &sband->channels[i];
+
+			if (ieee80211_channel_to_khz(chan) == freq)
+				return chan;
 		}
 	}
 
 	return NULL;
 }
-EXPORT_SYMBOL(ieee80211_get_channel);
+EXPORT_SYMBOL(ieee80211_get_channel_khz);
 
 static void set_mandatory_flags_band(struct ieee80211_supported_band *sband)
 {
-- 
2.20.1

