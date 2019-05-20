Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E016723328
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 14:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732450AbfETMA6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 08:00:58 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:35394 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732284AbfETMAz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 08:00:55 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 9719030C09C;
        Mon, 20 May 2019 05:00:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 9719030C09C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1558353653;
        bh=mkJu/zZfZN0zQxn0odqdvcOs5IezpaVsorLvkTkOAr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DP7FgX6hIAKTI6CltdvSG0EuYNK9sy6dD9vKNMjcDWH7fxU0fVGL5twzp/b73W7HT
         pV5yMSpGfRnIXN93DPCJVOPkKwAs6ezagmsxvYHg/R3QgbMmX56H4yAzvj0uOERYiP
         DH9asygQNB83kaGoIBmkuLj1HE3TZU/flTN9PeZk=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 560AF60D6F;
        Mon, 20 May 2019 05:00:54 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id F233BB030A9; Mon, 20 May 2019 14:00:50 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFC 5/8] cfg80211: add 6GHz in code handling array with NUM_NL80211_BANDS entries
Date:   Mon, 20 May 2019 14:00:42 +0200
Message-Id: <1558353645-18119-6-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In nl80211.c there is a policy for all bands in NUM_NL80211_BANDS and
in trace.h there is a callback trace for multicast rates which is per
band in NUM_NL80211_BANDS. Both need to be extended for the new
NL80211_BAND_6GHZ.

Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Leon Zegers <leon.zegers@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 net/wireless/nl80211.c | 1 +
 net/wireless/trace.h   | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index fffe4b3..c0224fc 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -627,6 +627,7 @@ static int validate_ie_attr(const struct nlattr *attr,
 nl80211_match_band_rssi_policy[NUM_NL80211_BANDS] = {
 	[NL80211_BAND_2GHZ] = { .type = NLA_S32 },
 	[NL80211_BAND_5GHZ] = { .type = NLA_S32 },
+	[NL80211_BAND_6GHZ] = { .type = NLA_S32 },
 	[NL80211_BAND_60GHZ] = { .type = NLA_S32 },
 };
 
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 2abfff9..a7f39a8 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -2446,10 +2446,11 @@
 		       sizeof(int) * NUM_NL80211_BANDS);
 	),
 	TP_printk(WIPHY_PR_FMT ", " NETDEV_PR_FMT ", "
-		  "mcast_rates [2.4GHz=0x%x, 5.2GHz=0x%x, 60GHz=0x%x]",
+		  "mcast_rates [2.4GHz=0x%x, 5.2GHz=0x%x, 6GHz=0x%x, 60GHz=0x%x]",
 		  WIPHY_PR_ARG, NETDEV_PR_ARG,
 		  __entry->mcast_rate[NL80211_BAND_2GHZ],
 		  __entry->mcast_rate[NL80211_BAND_5GHZ],
+		  __entry->mcast_rate[NL80211_BAND_6GHZ],
 		  __entry->mcast_rate[NL80211_BAND_60GHZ])
 );
 
-- 
1.9.1

