Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6160454D71
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 13:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730661AbfFYLUh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 07:20:37 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:48920 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730629AbfFYLUg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 07:20:36 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id E0BD530C01F;
        Tue, 25 Jun 2019 04:10:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com E0BD530C01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1561461031;
        bh=WBqQktAQOz0qMatA1u1Asw7J6wW4knpPcYjUx/ejdw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g2DCvzjqTMDr0nyLmHMIOTeM9UZba7AJPxGI7TrcDdxK0a/ewNGcjjavv2MFgobVY
         LNK2Y4YCLX7QRMF+mcXjSVYQT4y50Hp2m9g4IkPQdSWqbrehuPz5tmUm3rCT4k+4Y0
         EPjBw93MGgWUl3l2wTeeoTn+wH/RFNss9aZVFPmM=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 3BD3E60D7B;
        Tue, 25 Jun 2019 04:10:32 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id CDD93B02D05; Tue, 25 Jun 2019 13:10:29 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFC V2 1/8] nl80211: add 6GHz band definition to enum nl80211_band
Date:   Tue, 25 Jun 2019 13:10:20 +0200
Message-Id: <1561461027-10793-2-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561461027-10793-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1561461027-10793-1-git-send-email-arend.vanspriel@broadcom.com>
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
---
 include/uapi/linux/nl80211.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 8fc3a43..45b9117 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4536,6 +4536,7 @@ enum nl80211_txrate_gi {
  * @NL80211_BAND_2GHZ: 2.4 GHz ISM band
  * @NL80211_BAND_5GHZ: around 5 GHz band (4.9 - 5.7 GHz)
  * @NL80211_BAND_60GHZ: around 60 GHz band (58.32 - 69.12 GHz)
+ * @NL80211_BAND_6GHZ: around 6 GHz band (5.9 - 7.2 GHz)
  * @NUM_NL80211_BANDS: number of bands, avoid using this in userspace
  *	since newer kernel versions may support more bands
  */
@@ -4543,6 +4544,7 @@ enum nl80211_band {
 	NL80211_BAND_2GHZ,
 	NL80211_BAND_5GHZ,
 	NL80211_BAND_60GHZ,
+	NL80211_BAND_6GHZ,
 
 	NUM_NL80211_BANDS,
 };
-- 
1.9.1

