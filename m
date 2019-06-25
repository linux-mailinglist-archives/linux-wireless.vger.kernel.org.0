Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F85C54D6F
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 13:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730656AbfFYLUg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 07:20:36 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:48890 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730628AbfFYLUf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 07:20:35 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id DE4F930C01D;
        Tue, 25 Jun 2019 04:10:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com DE4F930C01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1561461031;
        bh=rTdnG2aRFOO0KC/KI61mstGyLoXkrAjLGr26vfgYNcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TkvWqqmzkElxgH9E4gXbuwpvWQGU82Ed3ZrbolOu2GOJ+Rm4T9Ii/3ZYYGzZjxc1o
         urmjyb6ejUcon7n1hbmPJyaHNkZ3kzIbIR+7Z53U3IBVIU7W4rQkPpljLzx1zZrB1z
         V87O1Sn4722XR5EkdA4UCikctA2V08j15O/7Pt9w=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 3BA5560D34;
        Tue, 25 Jun 2019 04:10:32 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id CE7A2B02BBB; Tue, 25 Jun 2019 13:10:29 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFC V2 7/8] cfg80211: ibss: use 11a mandatory rates for 6GHz band operation
Date:   Tue, 25 Jun 2019 13:10:26 +0200
Message-Id: <1561461027-10793-8-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561461027-10793-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1561461027-10793-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The default mandatory rates, ie. when not specified by user-space, is
determined by the band. Select 11a rateset for 6GHz band.

Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Leon Zegers <leon.zegers@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 net/wireless/ibss.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/net/wireless/ibss.c b/net/wireless/ibss.c
index d1743e6..ae8fe66 100644
--- a/net/wireless/ibss.c
+++ b/net/wireless/ibss.c
@@ -104,13 +104,19 @@ int __cfg80211_join_ibss(struct cfg80211_registered_device *rdev,
 		* use the mandatory rate set for 11b or
 		* 11a for maximum compatibility.
 		*/
-		struct ieee80211_supported_band *sband =
-			rdev->wiphy.bands[params->chandef.chan->band];
+		struct ieee80211_supported_band *sband;
+		enum nl80211_band band;
+		u32 flag;
 		int j;
-		u32 flag = params->chandef.chan->band == NL80211_BAND_5GHZ ?
-			IEEE80211_RATE_MANDATORY_A :
-			IEEE80211_RATE_MANDATORY_B;
 
+		band = params->chandef.chan->band;
+		if (band == NL80211_BAND_5GHZ ||
+		    band == NL80211_BAND_6GHZ)
+			flag = IEEE80211_RATE_MANDATORY_A;
+		else
+			flag = IEEE80211_RATE_MANDATORY_B;
+
+		sband = rdev->wiphy.bands[band];
 		for (j = 0; j < sband->n_bitrates; j++) {
 			if (sband->bitrates[j].flags & flag)
 				params->basic_rates |= BIT(j);
-- 
1.9.1

