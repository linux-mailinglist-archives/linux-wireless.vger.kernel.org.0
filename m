Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9627F601
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2019 13:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392375AbfHBLbZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Aug 2019 07:31:25 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:49822 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392094AbfHBLbY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Aug 2019 07:31:24 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 8439D30C039;
        Fri,  2 Aug 2019 04:31:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 8439D30C039
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1564745482;
        bh=wQW1g9afgWHv3wlMgELh7kRgNcwwtNlfiR3bhHlhj34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JY7vVTX2b6dzPQGHJTIGeVLuVvEKkY4UeOZ99tL+WCYw4ELwZDDBqkApLLAUe9Lnv
         ISOOVZfVZXTxkflLIeRvzXpqV6tYJtlHAERa0A0aQPUjNK7vUTyIxkboyJ5vh5bnk6
         qtnbUTQbKdF64/E0DMYpOXmpywSTe6Ix3shDa+TA=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id AAFC660DA7;
        Fri,  2 Aug 2019 04:31:22 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id 4EB5FB02EF6; Fri,  2 Aug 2019 13:31:19 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH V3 4/8] cfg80211: extend ieee80211_operating_class_to_band() for 6GHz
Date:   Fri,  2 Aug 2019 13:31:01 +0200
Message-Id: <1564745465-21234-5-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564745465-21234-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1564745465-21234-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add 6GHz operating class range as defined in 802.11ax D4.1 Annex E.

Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Leon Zegers <leon.zegers@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 net/wireless/util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 4e633d4..4462837 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1474,6 +1474,9 @@ bool ieee80211_operating_class_to_band(u8 operating_class,
 	case 128 ... 130:
 		*band = NL80211_BAND_5GHZ;
 		return true;
+	case 131 ... 135:
+		*band = NL80211_BAND_6GHZ;
+		return true;
 	case 81:
 	case 82:
 	case 83:
-- 
1.9.1

