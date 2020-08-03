Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BE723A8C0
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 16:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgHCOn7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Aug 2020 10:43:59 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:51356 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgHCOn6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Aug 2020 10:43:58 -0400
Received: from legolas.prakinf.tu-ilmenau.de (unknown [141.24.207.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 395C5580060;
        Mon,  3 Aug 2020 16:43:55 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v3 2/2] cfg80211: add helper fn for adjacent rule channels
Date:   Mon,  3 Aug 2020 16:43:53 +0200
Message-Id: <20200803144353.305538-2-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200803144353.305538-1-markus.theil@tu-ilmenau.de>
References: <20200803144353.305538-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some usable channels are located in the union of adjacent
regulatory rules, for example channel 144 in Germany.

Enable them, by also checking if a channel spans two adjacent
regulatory rules/frequency ranges.

All flags involved are disabling things, therefore we can build
the maximum by or-ing them together. Furthermore, take the maximum
of DFS CAC time values and the minimum of allowed power of both
adjacent channels in order to comply with both regulatory rules at
the same time.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
v3: style fixes

 net/wireless/reg.c | 175 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 160 insertions(+), 15 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 3dff817a9559..a6cda848c043 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1711,8 +1711,7 @@ static void handle_channel_single_rule(struct wiphy *wiphy,
 	if (lr->initiator == NL80211_REGDOM_SET_BY_DRIVER &&
 	    request_wiphy && request_wiphy == wiphy &&
 	    request_wiphy->regulatory_flags & REGULATORY_STRICT_REG) {
-		/*
-		 * This guarantees the driver's requested regulatory domain
+		/* This guarantees the driver's requested regulatory domain
 		 * will always be used as a base for further regulatory
 		 * settings
 		 */
@@ -1750,8 +1749,7 @@ static void handle_channel_single_rule(struct wiphy *wiphy,
 	}
 
 	if (chan->orig_mpwr) {
-		/*
-		 * Devices that use REGULATORY_COUNTRY_IE_FOLLOW_POWER
+		/* Devices that use REGULATORY_COUNTRY_IE_FOLLOW_POWER
 		 * will always follow the passed country IE power settings.
 		 */
 		if (initiator == NL80211_REGDOM_SET_BY_COUNTRY_IE &&
@@ -1764,6 +1762,116 @@ static void handle_channel_single_rule(struct wiphy *wiphy,
 		chan->max_power = chan->max_reg_power;
 }
 
+static void handle_channel_adjacent_rules(struct wiphy *wiphy,
+					  enum nl80211_reg_initiator initiator,
+					  struct ieee80211_channel *chan,
+					  u32 flags,
+					  struct regulatory_request *lr,
+					  struct wiphy *request_wiphy,
+					  const struct ieee80211_reg_rule *rrule1,
+					  const struct ieee80211_reg_rule *rrule2,
+					  struct ieee80211_freq_range *comb_range)
+{
+	u32 bw_flags1 = 0;
+	u32 bw_flags2 = 0;
+	const struct ieee80211_power_rule *power_rule1 = NULL;
+	const struct ieee80211_power_rule *power_rule2 = NULL;
+	const struct ieee80211_regdomain *regd;
+
+	regd = reg_get_regdomain(wiphy);
+
+	power_rule1 = &rrule1->power_rule;
+	power_rule2 = &rrule2->power_rule;
+	bw_flags1 = reg_rule_to_chan_bw_flags(regd, rrule1, chan);
+	bw_flags2 = reg_rule_to_chan_bw_flags(regd, rrule2, chan);
+
+	if (lr->initiator == NL80211_REGDOM_SET_BY_DRIVER &&
+	    request_wiphy && request_wiphy == wiphy &&
+	    request_wiphy->regulatory_flags & REGULATORY_STRICT_REG) {
+		/* This guarantees the driver's requested regulatory domain
+		 * will always be used as a base for further regulatory
+		 * settings
+		 */
+		chan->flags =
+			map_regdom_flags(rrule1->flags) |
+			map_regdom_flags(rrule2->flags) |
+			bw_flags1 |
+			bw_flags2;
+		chan->orig_flags = chan->flags;
+		chan->max_antenna_gain =
+			min_t(int, MBI_TO_DBI(power_rule1->max_antenna_gain),
+			      MBI_TO_DBI(power_rule2->max_antenna_gain));
+		chan->orig_mag = chan->max_antenna_gain;
+		chan->max_reg_power =
+			min_t(int, MBM_TO_DBM(power_rule1->max_eirp),
+			      MBM_TO_DBM(power_rule2->max_eirp));
+		chan->max_power = chan->max_reg_power;
+		chan->orig_mpwr = chan->max_reg_power;
+
+		if (chan->flags & IEEE80211_CHAN_RADAR) {
+			chan->dfs_cac_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
+			if (rrule1->dfs_cac_ms || rrule2->dfs_cac_ms)
+				chan->dfs_cac_ms = max_t(unsigned int,
+							 rrule1->dfs_cac_ms,
+							 rrule2->dfs_cac_ms);
+		}
+
+		return;
+	}
+
+	chan->dfs_state = NL80211_DFS_USABLE;
+	chan->dfs_state_entered = jiffies;
+
+	chan->beacon_found = false;
+	chan->flags = flags | bw_flags1 | bw_flags2 |
+		      map_regdom_flags(rrule1->flags) |
+		      map_regdom_flags(rrule2->flags);
+
+	/* reg_rule_to_chan_bw_flags may forbids 10 and forbids 20 MHz
+	 * (otherwise no adj. rule case), recheck therefore
+	 */
+	if (cfg80211_does_bw_fit_range(comb_range,
+				       ieee80211_channel_to_khz(chan),
+				       MHZ_TO_KHZ(10)))
+		chan->flags &= ~IEEE80211_CHAN_NO_10MHZ;
+	if (cfg80211_does_bw_fit_range(comb_range,
+				       ieee80211_channel_to_khz(chan),
+				       MHZ_TO_KHZ(20)))
+		chan->flags &= ~IEEE80211_CHAN_NO_20MHZ;
+
+	chan->max_antenna_gain =
+		min_t(int, chan->orig_mag,
+		      min_t(int,
+			    MBI_TO_DBI(power_rule1->max_antenna_gain),
+			    MBI_TO_DBI(power_rule2->max_antenna_gain)));
+	chan->max_reg_power = min_t(int,
+				    MBM_TO_DBM(power_rule1->max_eirp),
+				    MBM_TO_DBM(power_rule2->max_eirp));
+
+	if (chan->flags & IEEE80211_CHAN_RADAR) {
+		if (rrule1->dfs_cac_ms || rrule2->dfs_cac_ms)
+			chan->dfs_cac_ms = max_t(unsigned int,
+						 rrule1->dfs_cac_ms,
+						 rrule2->dfs_cac_ms);
+		else
+			chan->dfs_cac_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
+	}
+
+	if (chan->orig_mpwr) {
+		/* Devices that use REGULATORY_COUNTRY_IE_FOLLOW_POWER
+		 * will always follow the passed country IE power settings.
+		 */
+		if (initiator == NL80211_REGDOM_SET_BY_COUNTRY_IE &&
+		    wiphy->regulatory_flags & REGULATORY_COUNTRY_IE_FOLLOW_POWER)
+			chan->max_power = chan->max_reg_power;
+		else
+			chan->max_power = min(chan->orig_mpwr,
+					      chan->max_reg_power);
+	} else {
+		chan->max_power = chan->max_reg_power;
+	}
+}
+
 /* Note that right now we assume the desired channel bandwidth
  * is always 20 MHz for each individual channel (HT40 uses 20 MHz
  * per channel, the primary and the extension channel).
@@ -1772,17 +1880,54 @@ static void handle_channel(struct wiphy *wiphy,
 			   enum nl80211_reg_initiator initiator,
 			   struct ieee80211_channel *chan)
 {
-	u32 flags = 0;
-	const struct ieee80211_reg_rule *reg_rule = NULL;
-	struct wiphy *request_wiphy = NULL;
+	const u32 orig_chan_freq = ieee80211_channel_to_khz(chan);
 	struct regulatory_request *lr = get_last_request();
+	struct wiphy *request_wiphy = wiphy_idx_to_wiphy(lr->wiphy_idx);
+	const struct ieee80211_reg_rule *rrule = NULL;
+	const struct ieee80211_reg_rule *rrule1 = NULL;
+	const struct ieee80211_reg_rule *rrule2 = NULL;
+
+	u32 flags = chan->orig_flags;
+
+	rrule = freq_reg_info(wiphy, orig_chan_freq);
+	if (IS_ERR(rrule)) {
+		/* check for adjacent match, therefore get rules for
+		 * chan - 20 MHz and chan + 20 MHz and test
+		 * if reg rules are adjacent
+		 */
+		rrule1 = freq_reg_info(wiphy,
+				       orig_chan_freq - MHZ_TO_KHZ(20));
+		rrule2 = freq_reg_info(wiphy,
+				       orig_chan_freq + MHZ_TO_KHZ(20));
+		if (!IS_ERR(rrule1) && !IS_ERR(rrule2)) {
+			struct ieee80211_freq_range comb_range;
+
+			if (rrule1->freq_range.end_freq_khz !=
+			    rrule2->freq_range.start_freq_khz)
+				goto disable_chan;
+
+			comb_range.start_freq_khz =
+				rrule1->freq_range.start_freq_khz;
+			comb_range.end_freq_khz =
+				rrule2->freq_range.end_freq_khz;
+			comb_range.max_bandwidth_khz =
+				min_t(u32,
+				      rrule1->freq_range.max_bandwidth_khz,
+				      rrule2->freq_range.max_bandwidth_khz);
+
+			if (!cfg80211_does_bw_fit_range(&comb_range,
+							orig_chan_freq,
+							MHZ_TO_KHZ(20)))
+				goto disable_chan;
+
+			handle_channel_adjacent_rules(wiphy, initiator, chan,
+						      flags, lr, request_wiphy,
+						      rrule1, rrule2,
+						      &comb_range);
+			return;
+		}
 
-	request_wiphy = wiphy_idx_to_wiphy(lr->wiphy_idx);
-
-	flags = chan->orig_flags;
-
-	reg_rule = freq_reg_info(wiphy, ieee80211_channel_to_khz(chan));
-	if (IS_ERR(reg_rule)) {
+disable_chan:
 		/* We will disable all channels that do not match our
 		 * received regulatory rule unless the hint is coming
 		 * from a Country IE and the Country IE had no information
@@ -1793,7 +1938,7 @@ static void handle_channel(struct wiphy *wiphy,
 		 * while 5 GHz is still supported.
 		 */
 		if (initiator == NL80211_REGDOM_SET_BY_COUNTRY_IE &&
-		    PTR_ERR(reg_rule) == -ERANGE)
+		    PTR_ERR(rrule) == -ERANGE)
 			return;
 
 		if (lr->initiator == NL80211_REGDOM_SET_BY_DRIVER &&
@@ -1812,7 +1957,7 @@ static void handle_channel(struct wiphy *wiphy,
 	}
 
 	handle_channel_single_rule(wiphy, initiator, chan, flags, lr,
-				   request_wiphy, reg_rule);
+				   request_wiphy, rrule);
 }
 
 static void handle_band(struct wiphy *wiphy,
-- 
2.28.0

