Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6D9261B93
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 21:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbgIHTEl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 15:04:41 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:52680 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731365AbgIHTDc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 15:03:32 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 145A44F9AD6;
        Tue,  8 Sep 2020 19:03:28 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SVgKjfAK4VGB; Tue,  8 Sep 2020 19:03:24 +0000 (UTC)
Received: from atlas.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 05A2D4F9AE0;
        Tue,  8 Sep 2020 19:03:20 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH v3 03/22] cfg80211: regulatory: handle S1G channels
Date:   Tue,  8 Sep 2020 12:03:04 -0700
Message-Id: <20200908190323.15814-4-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200908190323.15814-1-thomas@adapt-ip.com>
References: <20200908190323.15814-1-thomas@adapt-ip.com>
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

v3:
  - use ARRAY_SIZE()
---
 net/wireless/reg.c | 70 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 12 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index dcd3d39a5372..2864ca2c3cfd 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -1617,9 +1617,11 @@ __freq_reg_info(struct wiphy *wiphy, u32 center_freq, u32 min_bw)
 {
 	const struct ieee80211_regdomain *regd = reg_get_regdomain(wiphy);
 	const struct ieee80211_reg_rule *reg_rule = NULL;
+	const u32 bws[] = {0, 1, 2, 4, 5, 8, 10, 16, 20};
+	int i = ARRAY_SIZE(bws) - 1;
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

