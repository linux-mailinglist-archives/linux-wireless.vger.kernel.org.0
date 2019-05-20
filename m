Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633CF23327
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 14:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732425AbfETMA5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 08:00:57 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:35388 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732290AbfETMAz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 08:00:55 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id CFE9630C0A1;
        Mon, 20 May 2019 05:00:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com CFE9630C0A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1558353653;
        bh=+zfkG1l3OrC8wcXOVwJk+kbcHvGZVXhVLoCaq6HA4ZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QWEwD6gFTMeenGsYPl/AA8QTstTSr3zI6SWAt/6e/fZGMEb6upIVj4AhS7v5g0Hmo
         axcJyYDAviIdmnVPej+Nb4hXN5UWEUJFRaQ2QkTh9l0ETXE58uB+gmdSsedFqgp1Il
         aeIzrtugTUAP+4BMuKDJ7pJegzP/Xp31av1i6px0=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id D44AE60D77;
        Mon, 20 May 2019 05:00:53 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id F11D1B02AC0; Mon, 20 May 2019 14:00:50 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFC 3/8] cfg80211: util: add 6GHz channel to freq conversion and vice versa
Date:   Mon, 20 May 2019 14:00:40 +0200
Message-Id: <1558353645-18119-4-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Extend the functions ieee80211_channel_to_frequency() and
ieee80211_frequency_to_channel() to support 6GHz band according
specification in 802.11ax D4.1 27.3.22.2.

Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Leon Zegers <leon.zegers@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 net/wireless/util.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index cf63b63..081637e 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -91,6 +91,11 @@ int ieee80211_channel_to_frequency(int chan, enum nl80211_band band)
 		else
 			return 5000 + chan * 5;
 		break;
+	case NL80211_BAND_6GHZ:
+		/* see 802.11ax D4.1 27.3.22.2 */
+		if (chan <= 253)
+			return 5940 + chan * 5;
+		break;
 	case NL80211_BAND_60GHZ:
 		if (chan < 7)
 			return 56160 + chan * 2160;
@@ -111,8 +116,11 @@ int ieee80211_frequency_to_channel(int freq)
 		return (freq - 2407) / 5;
 	else if (freq >= 4910 && freq <= 4980)
 		return (freq - 4000) / 5;
-	else if (freq <= 45000) /* DMG band lower limit */
+	else if (freq < 5940)
 		return (freq - 5000) / 5;
+	else if (freq <= 45000) /* DMG band lower limit */
+		/* see 802.11ax D4.1 27.3.22.2 */
+		return (freq - 5940) / 5;
 	else if (freq >= 58320 && freq <= 70200)
 		return (freq - 56160) / 2160;
 	else
-- 
1.9.1

