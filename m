Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD591E7C8E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 14:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgE2MEi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 08:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgE2MEi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 08:04:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A3FC03E969
        for <linux-wireless@vger.kernel.org>; Fri, 29 May 2020 05:04:38 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jedkZ-005UbF-PY; Fri, 29 May 2020 14:04:35 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] cfg80211: fix 6 GHz frequencies to kHz
Date:   Fri, 29 May 2020 14:04:27 +0200
Message-Id: <20200529140425.1bf824f6911b.I4a1174916b8f5965af4366999eb9ffc7a0347470@changeid>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The updates to change to kHz frequencies and the 6 GHz
additions evidently overlapped (or rather, I didn't see
it when applying the latter), so the 6 GHz is broken.
Fix this.

Fixes: 934f4c7dd3a5 ("cfg80211: express channels with a KHz component")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/wireless/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index df75e58eca5d..5b3b0d1222a2 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -94,7 +94,7 @@ u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band)
 	case NL80211_BAND_6GHZ:
 		/* see 802.11ax D4.1 27.3.22.2 */
 		if (chan <= 253)
-			return 5940 + chan * 5;
+			return MHZ_TO_KHZ(5940 + chan * 5);
 		break;
 	case NL80211_BAND_60GHZ:
 		if (chan < 7)
-- 
2.26.2

