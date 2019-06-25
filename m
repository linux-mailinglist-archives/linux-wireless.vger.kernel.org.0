Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B64754D6E
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 13:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbfFYLUf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 07:20:35 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:48888 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730629AbfFYLUf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 07:20:35 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id DE05130C004;
        Tue, 25 Jun 2019 04:10:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com DE05130C004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1561461031;
        bh=qLgeRUgG74OOJPHvet1nvjlzYIxEnqIoFdGG1pCujsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nbKj7pTWZC6aYZ5KvXTC+2ZTJUFKcTIK+SCpmyhWyI0Ch0cRyLH5hAi0F4q2bUs24
         7Y/LbwqtbwkPGZMDr8eWibYYDnEfuaxf6k6pKwqaWcJYthsKkozJjZ5d58717ICzDZ
         6AI1I8P5z65FYgasklrq58JjuvUOmnwqbva8bkQU=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 3C2BA60D81;
        Tue, 25 Jun 2019 04:10:32 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id CD68BB02E9B; Tue, 25 Jun 2019 13:10:29 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFC V2 6/8] cfg80211: use same IR permissive rules for 6GHz band
Date:   Tue, 25 Jun 2019 13:10:25 +0200
Message-Id: <1561461027-10793-7-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1561461027-10793-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1561461027-10793-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The function cfg80211_ir_permissive_chan() is applicable for
6GHz band as well so make sure it is handled.

Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Leon Zegers <leon.zegers@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 net/wireless/chan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/wireless/chan.c b/net/wireless/chan.c
index 7dc1bbd..7c9d204 100644
--- a/net/wireless/chan.c
+++ b/net/wireless/chan.c
@@ -894,7 +894,8 @@ static bool cfg80211_ir_permissive_chan(struct wiphy *wiphy,
 		if (chan == other_chan)
 			return true;
 
-		if (chan->band != NL80211_BAND_5GHZ)
+		if (chan->band != NL80211_BAND_5GHZ &&
+		    chan->band != NL80211_BAND_6GHZ)
 			continue;
 
 		r1 = cfg80211_get_unii(chan->center_freq);
-- 
1.9.1

