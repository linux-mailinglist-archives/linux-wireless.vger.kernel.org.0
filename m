Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D95C25512B
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Aug 2020 00:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgH0Wdm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 18:33:42 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:50366 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727913AbgH0WdP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 18:33:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 5CC424F8276;
        Thu, 27 Aug 2020 22:33:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CfzbVuurSFPB; Thu, 27 Aug 2020 22:33:10 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 1D8364F809F;
        Thu, 27 Aug 2020 22:33:07 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 03/22] cfg80211: regulatory: handle S1G channels
Date:   Thu, 27 Aug 2020 15:32:45 -0700
Message-Id: <20200827223304.16155-4-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200827223304.16155-1-thomas@adapt-ip.com>
References: <20200827223304.16155-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

S1G channels have a minimum bandwidth of 1Mhz, and there
is a 1:1 mapping of allowed bandwidth to channel number.

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 net/mac80211/util.c    |  6 ++--
 net/wireless/nl80211.c |  3 +-
 net/wireless/reg.c     | 69 ++++++++++++++++++++++++++++++++++--------
 3 files changed, 63 insertions(+), 15 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 9ba1afe4ba1f..35798997e521 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1437,7 +1437,7 @@ void ieee80211_regulatory_limit_wmm_params(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	const struct ieee80211_reg_rule *rrule;
 	const struct ieee80211_wmm_ac *wmm_ac;
-	u16 center_freq = 0;
+	u16 min_bw, center_freq = 0;
 
 	if (sdata->vif.type != NL80211_IFTYPE_AP &&
 	    sdata->vif.type != NL80211_IFTYPE_STATION)
@@ -1453,7 +1453,9 @@ void ieee80211_regulatory_limit_wmm_params(struct ieee80211_sub_if_data *sdata,
 		return;
 	}
 
-	rrule = freq_reg_info(sdata->wdev.wiphy, MHZ_TO_KHZ(center_freq), 20);
+	min_bw = chanctx_conf->def.chan->band == NL80211_BAND_S1GHZ ? 1 : 20;
+	rrule = freq_reg_info(sdata->wdev.wiphy, MHZ_TO_KHZ(center_freq),
+			      min_bw);
 
 	if (IS_ERR_OR_NULL(rrule) || !rrule->has_wmm) {
 		rcu_read_unlock();
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index dd0f62e942ed..a57872708108 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -1012,9 +1012,10 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 		goto nla_put_failure;
 
 	if (large) {
+		u32 min_bw = chan->band == NL80211_BAND_S1GHZ ? 1 : 20;
 		const struct ieee80211_reg_rule *rule =
 			freq_reg_info(wiphy, MHZ_TO_KHZ(chan->center_freq),
-				      20);
+				      min_bw);
 
 		if (!IS_ERR_OR_NULL(rule) && rule->has_wmm) {
 			if (nl80211_msg_put_wmm_rules(msg, rule))
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 6c130cec22c3..f23ca3103558 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1617,9 +1617,11 @@ __freq_reg_info(struct wiphy *wiphy, u32 center_freq, u32 min_bw)
 {
 	const struct ieee80211_regdomain *regd = reg_get_regdomain(wiphy);
 	const struct ieee80211_reg_rule *reg_rule = NULL;
+	const u32 bws[] = {1, 2, 4, 5, 8, 10, 16, 20};
+	int i = sizeof(bws) / sizeof(u32) - 1;
 	u32 bw;
 
-	for (bw = MHZ_TO_KHZ(20); bw >= min_bw; bw = bw / 2) {
+	for (bw = MHZ_TO_KHZ(bws[i]); bw >= min_bw; bw = MHZ_TO_KHZ(bws[i--])) {
 		reg_rule = freq_reg_info_regd(center_freq, regd, bw);
 		if (!IS_ERR(reg_rule))
 			return reg_rule;
@@ -1660,6 +1662,7 @@ static uint32_t reg_rule_to_chan_bw_flags(const struct ieee80211_regdomain *regd
 {
 	const struct ieee80211_freq_range *freq_range = NULL;
 	u32 max_bandwidth_khz, center_freq_khz, bw_flags = 0;
+	bool is_s1g = chan->band == NL80211_BAND_S1GHZ;
 
 	freq_range = &reg_rule->freq_range;
 
@@ -1679,16 +1682,57 @@ static uint32_t reg_rule_to_chan_bw_flags(const struct ieee80211_regdomain *regd
 					MHZ_TO_KHZ(20)))
 		bw_flags |= IEEE80211_CHAN_NO_20MHZ;
 
-	if (max_bandwidth_khz < MHZ_TO_KHZ(10))
-		bw_flags |= IEEE80211_CHAN_NO_10MHZ;
-	if (max_bandwidth_khz < MHZ_TO_KHZ(20))
-		bw_flags |= IEEE80211_CHAN_NO_20MHZ;
-	if (max_bandwidth_khz < MHZ_TO_KHZ(40))
-		bw_flags |= IEEE80211_CHAN_NO_HT40;
-	if (max_bandwidth_khz < MHZ_TO_KHZ(80))
-		bw_flags |= IEEE80211_CHAN_NO_80MHZ;
-	if (max_bandwidth_khz < MHZ_TO_KHZ(160))
-		bw_flags |= IEEE80211_CHAN_NO_160MHZ;
+	if (is_s1g) {
+		/* S1G is strict about non overlapping channels. We can
+		 * calculate which bandwidth is allowed per channel by finding
+		 * the largest bandwidth which cleanly divides the freq_range.
+		 */
+		int edge_offset;
+		int ch_bw = max_bandwidth_khz;
+
+		while (ch_bw) {
+			edge_offset = (center_freq_khz - ch_bw / 2) -
+				      freq_range->start_freq_khz;
+			if (edge_offset % ch_bw == 0) {
+				switch (KHZ_TO_MHZ(ch_bw)) {
+				case 1:
+					bw_flags |= IEEE80211_CHAN_1MHZ;
+					break;
+				case 2:
+					bw_flags |= IEEE80211_CHAN_2MHZ;
+					break;
+				case 4:
+					bw_flags |= IEEE80211_CHAN_4MHZ;
+					break;
+				case 8:
+					bw_flags |= IEEE80211_CHAN_8MHZ;
+					break;
+				case 16:
+					bw_flags |= IEEE80211_CHAN_16MHZ;
+					break;
+				default:
+					/* If we got here, no bandwidths fit on
+					 * this frequency, ie. band edge.
+					 */
+					bw_flags |= IEEE80211_CHAN_DISABLED;
+					break;
+				}
+				break;
+			}
+			ch_bw /= 2;
+		}
+	} else {
+		if (max_bandwidth_khz < MHZ_TO_KHZ(10))
+			bw_flags |= IEEE80211_CHAN_NO_10MHZ;
+		if (max_bandwidth_khz < MHZ_TO_KHZ(20))
+			bw_flags |= IEEE80211_CHAN_NO_20MHZ;
+		if (max_bandwidth_khz < MHZ_TO_KHZ(40))
+			bw_flags |= IEEE80211_CHAN_NO_HT40;
+		if (max_bandwidth_khz < MHZ_TO_KHZ(80))
+			bw_flags |= IEEE80211_CHAN_NO_80MHZ;
+		if (max_bandwidth_khz < MHZ_TO_KHZ(160))
+			bw_flags |= IEEE80211_CHAN_NO_160MHZ;
+	}
 	return bw_flags;
 }
 
@@ -1707,12 +1751,13 @@ static void handle_channel(struct wiphy *wiphy,
 	struct wiphy *request_wiphy = NULL;
 	struct regulatory_request *lr = get_last_request();
 	const struct ieee80211_regdomain *regd;
+	u32 min_bw = chan->band == NL80211_BAND_S1GHZ ? 1 : 20;
 
 	request_wiphy = wiphy_idx_to_wiphy(lr->wiphy_idx);
 
 	flags = chan->orig_flags;
 
-	reg_rule = freq_reg_info(wiphy, ieee80211_channel_to_khz(chan), 20);
+	reg_rule = freq_reg_info(wiphy, ieee80211_channel_to_khz(chan), min_bw);
 	if (IS_ERR(reg_rule)) {
 		/*
 		 * We will disable all channels that do not match our
-- 
2.20.1

