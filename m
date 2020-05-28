Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B681E64D2
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 16:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391293AbgE1Oyz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 10:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391243AbgE1Oyy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 10:54:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922C7C08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 07:54:54 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeJrb-004vYI-Iw; Thu, 28 May 2020 16:50:31 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 20/24] cfg80211: Update 6GHz starting frequency
Date:   Thu, 28 May 2020 16:50:16 +0200
Message-Id: <20200528165011.d9233bd62260.If474d2bc528aa07610fef429ff83e8312079e242@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528165011.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
References: <20200528165011.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

The starting frequency of the 6GHz band changed from
5940 MHz to 5950 MHz. Update the code accordingly.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/util.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 92585334b723..553bf1c8ee75 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -94,7 +94,7 @@ u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band)
 	case NL80211_BAND_6GHZ:
 		/* see 802.11ax D4.1 27.3.22.2 */
 		if (chan <= 253)
-			return 5940 + chan * 5;
+			return 5950 + chan * 5;
 		break;
 	case NL80211_BAND_60GHZ:
 		if (chan < 7)
@@ -119,11 +119,11 @@ int ieee80211_freq_khz_to_channel(u32 freq)
 		return (freq - 2407) / 5;
 	else if (freq >= 4910 && freq <= 4980)
 		return (freq - 4000) / 5;
-	else if (freq < 5945)
+	else if (freq < 5955)
 		return (freq - 5000) / 5;
 	else if (freq <= 45000) /* DMG band lower limit */
 		/* see 802.11ax D4.1 27.3.22.2 */
-		return (freq - 5940) / 5;
+		return (freq - 5950) / 5;
 	else if (freq >= 58320 && freq <= 70200)
 		return (freq - 56160) / 2160;
 	else
-- 
2.26.2

