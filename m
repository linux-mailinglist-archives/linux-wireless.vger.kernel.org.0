Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76C7D7F602
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2019 13:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392377AbfHBLb1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Aug 2019 07:31:27 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:49826 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392119AbfHBLbY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Aug 2019 07:31:24 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id C06D630C03E;
        Fri,  2 Aug 2019 04:31:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com C06D630C03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1564745482;
        bh=qLgeRUgG74OOJPHvet1nvjlzYIxEnqIoFdGG1pCujsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kmWCzs1ZZUT7v9fb2rRx9vvkcK7nUSULuMj4w0wescWp3TF8r1eiA+5PKijzxAqYY
         Cr3O/2ArB2Psl3AHdy5fTunDVcLLnYN+2kITV4e1CpK/hYvSvrH28WDa5hqdT5RF+h
         LtQKOprCCyFcnxQdQovGL2XhhiHBA4U4Jl+SpVTY=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 8B36D60C88;
        Fri,  2 Aug 2019 04:31:22 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id 4E0FAB0315D; Fri,  2 Aug 2019 13:31:19 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH V3 6/8] cfg80211: use same IR permissive rules for 6GHz band
Date:   Fri,  2 Aug 2019 13:31:03 +0200
Message-Id: <1564745465-21234-7-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1564745465-21234-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1564745465-21234-1-git-send-email-arend.vanspriel@broadcom.com>
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

