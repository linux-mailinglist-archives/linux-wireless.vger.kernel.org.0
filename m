Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832542EC725
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Jan 2021 00:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbhAFX7D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Jan 2021 18:59:03 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:64451 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727363AbhAFX7D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Jan 2021 18:59:03 -0500
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Wed, 06 Jan 2021 18:59:02 EST
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 06 Jan 2021 15:50:58 -0800
X-QCInternal: smtphost
Received: from mxchen-linux.qualcomm.com (HELO mxchen-linux.localdomain) ([10.234.28.165])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 06 Jan 2021 15:50:57 -0800
Received: by mxchen-linux.localdomain (Postfix, from userid 451784)
        id 444FB2070; Wed,  6 Jan 2021 15:50:56 -0800 (PST)
From:   Max Chen <mxchen@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Max Chen <mxchen@codeaurora.org>, linux-wireless@vger.kernel.org,
        wil6210@qti.qualcomm.com
Subject: [PATCH 1/2] cfg80211: Add phyrate conversion support for extended MCS in 60GHz band
Date:   Wed,  6 Jan 2021 15:50:49 -0800
Message-Id: <1609977050-7089-2-git-send-email-mxchen@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609977050-7089-1-git-send-email-mxchen@codeaurora.org>
References: <1609977050-7089-1-git-send-email-mxchen@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The current phyrate conversion does not include extended MCS and provides
incorrect rates. Add a flag for extended MCS in DMG and add corresponding
phyrate table for the correct conversions using base MCS in DMG specs.

Signed-off-by: Max Chen <mxchen@codeaurora.org>
---
 include/net/cfg80211.h |  2 ++
 net/wireless/util.c    | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index ab249ca..19c9c51 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1471,6 +1471,7 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
  * @RATE_INFO_FLAGS_DMG: 60GHz MCS
  * @RATE_INFO_FLAGS_HE_MCS: HE MCS information
  * @RATE_INFO_FLAGS_EDMG: 60GHz MCS in EDMG mode
+ * @RATE_INFO_FLAGS_EXTENDED_SC_DMG: 60GHz extended SC MCS
  */
 enum rate_info_flags {
 	RATE_INFO_FLAGS_MCS			= BIT(0),
@@ -1479,6 +1480,7 @@ enum rate_info_flags {
 	RATE_INFO_FLAGS_DMG			= BIT(3),
 	RATE_INFO_FLAGS_HE_MCS			= BIT(4),
 	RATE_INFO_FLAGS_EDMG			= BIT(5),
+	RATE_INFO_FLAGS_EXTENDED_SC_DMG		= BIT(6),
 };
 
 /**
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 5af8803..6143f6a 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1152,6 +1152,25 @@ static u32 cfg80211_calculate_bitrate_dmg(struct rate_info *rate)
 	return __mcs2bitrate[rate->mcs];
 }
 
+static u32 cfg80211_calculate_bitrate_extended_sc_dmg(struct rate_info *rate)
+{
+	static const u32 __mcs2bitrate[] = {
+		[6] = 26950, /* MCS 9.1 : 2695.0 mbps */
+		[7] = 50050, /* MCS 12.1 */
+		[8] = 53900,
+		[9] = 57750,
+		[10] = 63900,
+		[11] = 75075,
+		[12] = 80850,
+	};
+
+	/* Extended SC MCS not defined for base MCS below 6 or above 12 */
+	if (WARN_ON_ONCE(rate->mcs < 6) || WARN_ON_ONCE(rate->mcs > 12))
+		return 0;
+
+	return __mcs2bitrate[rate->mcs];
+}
+
 static u32 cfg80211_calculate_bitrate_edmg(struct rate_info *rate)
 {
 	static const u32 __mcs2bitrate[] = {
@@ -1362,6 +1381,8 @@ u32 cfg80211_calculate_bitrate(struct rate_info *rate)
 		return cfg80211_calculate_bitrate_ht(rate);
 	if (rate->flags & RATE_INFO_FLAGS_DMG)
 		return cfg80211_calculate_bitrate_dmg(rate);
+	if (rate->flags & RATE_INFO_FLAGS_EXTENDED_SC_DMG)
+		return cfg80211_calculate_bitrate_extended_sc_dmg(rate);
 	if (rate->flags & RATE_INFO_FLAGS_EDMG)
 		return cfg80211_calculate_bitrate_edmg(rate);
 	if (rate->flags & RATE_INFO_FLAGS_VHT_MCS)
-- 
2.7.4

