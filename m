Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDE0A54D70
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 13:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbfFYLUg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 07:20:36 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:48876 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729096AbfFYLUf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 07:20:35 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 02E2930C024;
        Tue, 25 Jun 2019 04:10:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 02E2930C024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1561461032;
        bh=5goibmUdKmSQmYE3OGu2YspPrIWECvLFDb8dFRV7RrE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lL+tX+y90aWYvY0nNfwEhzwMawpN5acrJ93rBoLW39ND9FRXaStE3dCaY1hr/xVFm
         ZFE77NLKmFfLN10ffr9DPPiImWAMTbGSQFlRlZODBtIF7tB0Vs/I2FfR/HGaQx1F5F
         gkD7P8cPPB07UbADNcc/hnQrV77HpYZAa2Cm4ozQ=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 857D460D85;
        Tue, 25 Jun 2019 04:10:32 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id CEF73B02AFA; Tue, 25 Jun 2019 13:10:29 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFC V2 5/8] cfg80211: add 6GHz in code handling array with NUM_NL80211_BANDS entries
Date:   Tue, 25 Jun 2019 13:10:24 +0200
Message-Id: <1561461027-10793-6-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561461027-10793-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1561461027-10793-1-git-send-email-arend.vanspriel@broadcom.com>
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
index fc83dd1..57bc35a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -667,6 +667,7 @@ static int validate_ie_attr(const struct nlattr *attr,
 nl80211_match_band_rssi_policy[NUM_NL80211_BANDS] = {
 	[NL80211_BAND_2GHZ] = { .type = NLA_S32 },
 	[NL80211_BAND_5GHZ] = { .type = NLA_S32 },
+	[NL80211_BAND_6GHZ] = { .type = NLA_S32 },
 	[NL80211_BAND_60GHZ] = { .type = NLA_S32 },
 };
 
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 4fbb91a..d98ad2b 100644
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

