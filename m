Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A61425830C
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Aug 2020 22:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbgHaU4M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Aug 2020 16:56:12 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:52190 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729485AbgHaU4L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Aug 2020 16:56:11 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 4A52B4F8E7D;
        Mon, 31 Aug 2020 20:56:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id CVlsCOcr7xlK; Mon, 31 Aug 2020 20:56:08 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id A81F84F8AD5;
        Mon, 31 Aug 2020 20:56:05 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v2 03/22] cfg80211: regulatory: handle S1G channels
Date:   Mon, 31 Aug 2020 13:55:41 -0700
Message-Id: <20200831205600.21058-4-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200831205600.21058-1-thomas@adapt-ip.com>
References: <20200831205600.21058-1-thomas@adapt-ip.com>
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

v2:
 - drop the freq_reg_info() interface changes and move the
   check for S1G band inside. Fixes a driver compile
   error.
 - fix iterating past bws[] in __freq_reg_info() by
   setting initial element to 0.
   Reported-by: kernel test robot <lkp@intel.com>
---
 net/wireless/reg.c | 70 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index 0ab7808fcec8..be6f54b70ad3 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1617,9 +1617,11 @@ __freq_reg_info(struct wiphy *wiphy, u32 center_freq, u32 min_bw)
 {
 	const struct ieee80211_regdomain *regd = reg_get_regdomain(wiphy);
 	const struct ieee80211_reg_rule *reg_rule = NULL;
+	const u32 bws[] = {0, 1, 2, 4, 5, 8, 10, 16, 20};
+	int i = sizeof(bws) / sizeof(u32) - 1;
 	u32 bw;
 
-	for (bw = MHZ_TO_KHZ(20); bw >= min_bw; bw = bw / 2) {
+	for (bw = MHZ_TO_KHZ(bws[i]); bw >= min_bw; bw = MHZ_TO_KHZ(bws[i--])) {
 		reg_rule = freq_reg_info_regd(center_freq, regd, bw);
 		if (!IS_ERR(reg_rule))
 			return reg_rule;
@@ -1631,7 +1633,9 @@ __freq_reg_info(struct wiphy *wiphy, u32 center_freq, u32 min_bw)
 const struct ieee80211_reg_rule *freq_reg_info(struct wiphy *wiphy,
 					       u32 center_freq)
 {
-	return __freq_reg_info(wiphy, center_freq, MHZ_TO_KHZ(20));
+	u32 min_bw = center_freq < MHZ_TO_KHZ(1000) ? 1 : 20;
+
+	return __freq_reg_info(wiphy, center_freq, MHZ_TO_KHZ(min_bw));
 }
 EXPORT_SYMBOL(freq_reg_info);
 
@@ -1659,6 +1663,7 @@ static uint32_t reg_rule_to_chan_bw_flags(const struct ieee80211_regdomain *regd
 {
 	const struct ieee80211_freq_range *freq_range = NULL;
 	u32 max_bandwidth_khz, center_freq_khz, bw_flags = 0;
+	bool is_s1g = chan->band == NL80211_BAND_S1GHZ;
 
 	freq_range = &reg_rule->freq_range;
 
@@ -1678,16 +1683,57 @@ static uint32_t reg_rule_to_chan_bw_flags(const struct ieee80211_regdomain *regd
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
 
-- 
2.20.1

