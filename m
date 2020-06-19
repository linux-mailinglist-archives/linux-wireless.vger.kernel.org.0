Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A41201CC2
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2020 22:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391103AbgFSUwT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Jun 2020 16:52:19 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:1483 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388929AbgFSUwT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Jun 2020 16:52:19 -0400
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Jun 2020 13:52:18 -0700
Received: from asinghal-linux.qualcomm.com ([10.234.220.60])
  by ironmsg01-sd.qualcomm.com with ESMTP; 19 Jun 2020 13:52:18 -0700
Received: by asinghal-linux.qualcomm.com (Postfix, from userid 73644)
        id 0F3A73EBA; Fri, 19 Jun 2020 13:52:17 -0700 (PDT)
From:   Amar Singhal <asinghal@codeaurora.org>
To:     linux-wireless@vger.kernel.org, johannes@sipsolutions.net,
        jouni@codeaaurora.org
Cc:     asinghal@codeaurora.org
Subject: [PATCH] cfg80211: Adjust 6ghz frequencies per channelization
Date:   Fri, 19 Jun 2020 13:52:01 -0700
Message-Id: <1592599921-10607-1-git-send-email-asinghal@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Per 11ax draft 6.1, 6ghz frequencies need adjustment. Also orphan
channel of frequency 5935 MHz has been added. Modify utilities
accordingly.

Signed-off-by: Amar Singhal <asinghal@codeaurora.org>
---
 net/wireless/util.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index df75e58..3fb4f4b 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -92,9 +92,11 @@ u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band)
 			return MHZ_TO_KHZ(5000 + chan * 5);
 		break;
 	case NL80211_BAND_6GHZ:
-		/* see 802.11ax D4.1 27.3.22.2 */
-		if (chan <= 253)
-			return 5940 + chan * 5;
+		/* see 802.11ax D6.1 27.3.22.2 */
+		if (chan == 2)
+			return 5925 + chan * 5;
+		if (chan <= 233)
+			return 5950 + chan * 5;
 		break;
 	case NL80211_BAND_60GHZ:
 		if (chan < 7)
@@ -119,11 +121,13 @@ int ieee80211_freq_khz_to_channel(u32 freq)
 		return (freq - 2407) / 5;
 	else if (freq >= 4910 && freq <= 4980)
 		return (freq - 4000) / 5;
-	else if (freq < 5945)
+	else if (freq < 5925)
 		return (freq - 5000) / 5;
+	else if (freq == 5935)
+		return (freq - 5925) / 5;
 	else if (freq <= 45000) /* DMG band lower limit */
-		/* see 802.11ax D4.1 27.3.22.2 */
-		return (freq - 5940) / 5;
+		/* see 802.11ax D6.1 27.3.22.2 */
+		return (freq - 5950) / 5;
 	else if (freq >= 58320 && freq <= 70200)
 		return (freq - 56160) / 2160;
 	else
-- 
1.9.1

