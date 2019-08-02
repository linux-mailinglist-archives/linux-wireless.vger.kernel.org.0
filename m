Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4A0B7F606
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2019 13:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392383AbfHBLbc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Aug 2019 07:31:32 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:49798 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732758AbfHBLbX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Aug 2019 07:31:23 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 137E530C035;
        Fri,  2 Aug 2019 04:31:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 137E530C035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1564745482;
        bh=KA7nqVnkPaj2UuP6Z2fpVnC6cG3+/uEleQ2FIkfNnGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SbyWNSsEOgdl8/FTVhw3iddrh6ZdlLPxiC31wHuDg7CGz4zMznsv3UJkuPwhJMn3E
         d3U+wzsvVQRcwyeYhW52+X6gRbPP1RH9H6Bqp14QBZ4B+KpXRwhmDWwMso7SGIeqJM
         KSgF2aZKWJYEuc4u0zMzkxfMul2BFXV2PFQx66wo=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id D13FF60DA7;
        Fri,  2 Aug 2019 04:31:21 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id 4D1BDB02B3D; Fri,  2 Aug 2019 13:31:19 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH V3 1/8] nl80211: add 6GHz band definition to enum nl80211_band
Date:   Fri,  2 Aug 2019 13:30:58 +0200
Message-Id: <1564745465-21234-2-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564745465-21234-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1564745465-21234-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In the 802.11ax specification a new band is introduced, which
is also proposed by FCC for unlicensed use. This band is referred
to as 6GHz spanning frequency range from 5925 to 7125 MHz.

Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Leon Zegers <leon.zegers@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
changes:
  - V2
	fix ABI breakage by appending the new band definition.
  - V3
	fix warning (-Wswitch) in mac80211.
---
 include/uapi/linux/nl80211.h | 2 ++
 net/mac80211/tx.c            | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 822851d..4d5988f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4543,6 +4543,7 @@ enum nl80211_txrate_gi {
  * @NL80211_BAND_2GHZ: 2.4 GHz ISM band
  * @NL80211_BAND_5GHZ: around 5 GHz band (4.9 - 5.7 GHz)
  * @NL80211_BAND_60GHZ: around 60 GHz band (58.32 - 69.12 GHz)
+ * @NL80211_BAND_6GHZ: around 6 GHz band (5.9 - 7.2 GHz)
  * @NUM_NL80211_BANDS: number of bands, avoid using this in userspace
  *	since newer kernel versions may support more bands
  */
@@ -4550,6 +4551,7 @@ enum nl80211_band {
 	NL80211_BAND_2GHZ,
 	NL80211_BAND_5GHZ,
 	NL80211_BAND_60GHZ,
+	NL80211_BAND_6GHZ,
 
 	NUM_NL80211_BANDS,
 };
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 235c637..1fa4227 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -162,6 +162,7 @@ static __le16 ieee80211_duration(struct ieee80211_tx_data *tx,
 			break;
 		}
 		case NL80211_BAND_5GHZ:
+		case NL80211_BAND_6GHZ:
 			if (r->flags & IEEE80211_RATE_MANDATORY_A)
 				mrate = r->bitrate;
 			break;
-- 
1.9.1

