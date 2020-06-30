Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A2120FCD7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 21:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgF3Tj6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jun 2020 15:39:58 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:59393 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgF3Tj6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jun 2020 15:39:58 -0400
Received: from legolas.prakinf.tu-ilmenau.de (unknown [141.24.207.116])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id B6416580083;
        Tue, 30 Jun 2020 21:39:54 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 2/2] cfg80211: add helper fn for adjacent rule channels
Date:   Tue, 30 Jun 2020 21:39:31 +0200
Message-Id: <20200630193931.392519-2-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200630193931.392519-1-markus.theil@tu-ilmenau.de>
References: <20200630193931.392519-1-markus.theil@tu-ilmenau.de>
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
 net/wireless/reg.c | 119 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 10c76f27f6e1..4ca9f7fb6582 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1764,6 +1764,95 @@ static void handle_channel_single_rule(struct wiphy *wiphy,
 		chan->max_power = chan->max_reg_power;
 }
 
+static void handle_channel_adjacent_rules(struct wiphy *wiphy,
+					  enum nl80211_reg_initiator initiator,
+					  struct ieee80211_channel *chan,
+					  u32 flags,
+					  struct regulatory_request *lr,
+					  struct wiphy *request_wiphy,
+					  const struct ieee80211_reg_rule *reg_rule1,
+					  const struct ieee80211_reg_rule *reg_rule2)
+{
+	u32 bw_flags1 = 0;
+	u32 bw_flags2 = 0;
+	const struct ieee80211_power_rule *power_rule1 = NULL;
+	const struct ieee80211_power_rule *power_rule2 = NULL;
+	const struct ieee80211_regdomain *regd;
+
+	regd = reg_get_regdomain(wiphy);
+
+	power_rule1 = &reg_rule1->power_rule;
+	power_rule2 = &reg_rule2->power_rule;
+	bw_flags1 = reg_rule_to_chan_bw_flags(regd, reg_rule1, chan);
+	bw_flags2 = reg_rule_to_chan_bw_flags(regd, reg_rule2, chan);
+
+	if (lr->initiator == NL80211_REGDOM_SET_BY_DRIVER &&
+	    request_wiphy && request_wiphy == wiphy &&
+	    request_wiphy->regulatory_flags & REGULATORY_STRICT_REG) {
+		/*
+		 * This guarantees the driver's requested regulatory domain
+		 * will always be used as a base for further regulatory
+		 * settings
+		 */
+		chan->flags = chan->orig_flags =
+			map_regdom_flags(reg_rule1->flags) |
+			map_regdom_flags(reg_rule2->flags) |
+			bw_flags1 |
+			bw_flags2;
+		chan->max_antenna_gain = chan->orig_mag =
+			min_t(int, MBI_TO_DBI(power_rule1->max_antenna_gain),
+			      MBI_TO_DBI(power_rule2->max_antenna_gain));
+		chan->max_reg_power = chan->max_power = chan->orig_mpwr =
+			min_t(int, MBM_TO_DBM(power_rule1->max_eirp),
+			      MBM_TO_DBM(power_rule2->max_eirp));
+
+		if (chan->flags & IEEE80211_CHAN_RADAR) {
+			chan->dfs_cac_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
+			if (reg_rule1->dfs_cac_ms || reg_rule2->dfs_cac_ms)
+				chan->dfs_cac_ms = max_t(unsigned int, reg_rule1->dfs_cac_ms, reg_rule2->dfs_cac_ms);
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
+		      map_regdom_flags(reg_rule1->flags) |
+		      map_regdom_flags(reg_rule2->flags);
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
+		if (reg_rule1->dfs_cac_ms || reg_rule2->dfs_cac_ms)
+			chan->dfs_cac_ms = max_t(unsigned int, reg_rule1->dfs_cac_ms, reg_rule2->dfs_cac_ms);
+		else
+			chan->dfs_cac_ms = IEEE80211_DFS_MIN_CAC_TIME_MS;
+	}
+
+	if (chan->orig_mpwr) {
+		/*
+		 * Devices that use REGULATORY_COUNTRY_IE_FOLLOW_POWER
+		 * will always follow the passed country IE power settings.
+		 */
+		if (initiator == NL80211_REGDOM_SET_BY_COUNTRY_IE &&
+		    wiphy->regulatory_flags & REGULATORY_COUNTRY_IE_FOLLOW_POWER)
+			chan->max_power = chan->max_reg_power;
+		else
+			chan->max_power = min(chan->orig_mpwr,
+					      chan->max_reg_power);
+	} else
+		chan->max_power = chan->max_reg_power;
+}
+
 /*
  * Note that right now we assume the desired channel bandwidth
  * is always 20 MHz for each individual channel (HT40 uses 20 MHz
@@ -1775,6 +1864,8 @@ static void handle_channel(struct wiphy *wiphy,
 {
 	u32 flags = 0;
 	const struct ieee80211_reg_rule *reg_rule = NULL;
+	const struct ieee80211_reg_rule *reg_rule1 = NULL;
+	const struct ieee80211_reg_rule *reg_rule2 = NULL;
 	struct wiphy *request_wiphy = NULL;
 	struct regulatory_request *lr = get_last_request();
 
@@ -1784,6 +1875,34 @@ static void handle_channel(struct wiphy *wiphy,
 
 	reg_rule = freq_reg_info(wiphy, ieee80211_channel_to_khz(chan));
 	if (IS_ERR(reg_rule)) {
+		/*
+		 * check for adjacent match, therefore get rules for chan - 20 MHz
+		 * and chan + 20 MHz and test if reg rules are adjacent
+		 */
+		reg_rule1 = freq_reg_info(wiphy, ieee80211_channel_to_khz(chan) - MHZ_TO_KHZ(20));
+		reg_rule2 = freq_reg_info(wiphy, ieee80211_channel_to_khz(chan) + MHZ_TO_KHZ(20));
+		if (!IS_ERR(reg_rule1) && !IS_ERR(reg_rule2)) {
+			struct ieee80211_freq_range combined_range;
+
+			if (reg_rule1->freq_range.end_freq_khz !=
+			    reg_rule2->freq_range.start_freq_khz)
+				goto disable_chan;
+
+			combined_range.start_freq_khz = reg_rule1->freq_range.start_freq_khz;
+			combined_range.end_freq_khz = reg_rule2->freq_range.end_freq_khz;
+			combined_range.max_bandwidth_khz = min_t(u32,
+								 reg_rule1->freq_range.max_bandwidth_khz,
+								 reg_rule2->freq_range.max_bandwidth_khz);
+
+			if (!cfg80211_does_bw_fit_range(&combined_range, ieee80211_channel_to_khz(chan), MHZ_TO_KHZ(20)))
+				goto disable_chan;
+
+			handle_channel_adjacent_rules(wiphy, initiator, chan, flags, lr,
+						      request_wiphy, reg_rule1, reg_rule2);
+			return;
+		}
+
+disable_chan:
 		/*
 		 * We will disable all channels that do not match our
 		 * received regulatory rule unless the hint is coming
-- 
2.27.0

