Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2252E26D825
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Sep 2020 11:53:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgIQJwc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Sep 2020 05:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgIQJwa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Sep 2020 05:52:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D325C06174A
        for <linux-wireless@vger.kernel.org>; Thu, 17 Sep 2020 02:52:30 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kIqaZ-005VOF-Me; Thu, 17 Sep 2020 11:52:27 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Amar <asinghal@codeaurora.org>
Subject: [PATCH] cfg80211: fix 6 GHz channel conversion
Date:   Thu, 17 Sep 2020 11:52:23 +0200
Message-Id: <20200917115222.312ba6f1d461.I3a8c8fbcc3cc019814fd9cd0aced7eb591626136@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We shouldn't accept any channels bigger than 233, fix that.

Reported-by: Amar <asinghal@codeaurora.org>
Fixes: d1a1646c0de7 ("cfg80211: adapt to new channelization of the 6GHz band")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 4a9ff9ef513f..6fa99df52f86 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -95,7 +95,7 @@ u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band)
 		/* see 802.11ax D6.1 27.3.23.2 */
 		if (chan == 2)
 			return MHZ_TO_KHZ(5935);
-		if (chan <= 253)
+		if (chan <= 233)
 			return MHZ_TO_KHZ(5950 + chan * 5);
 		break;
 	case NL80211_BAND_60GHZ:
-- 
2.26.2

