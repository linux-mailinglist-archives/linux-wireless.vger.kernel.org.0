Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB8E223322
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 14:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732354AbfETMAz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 08:00:55 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:35398 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732283AbfETMAz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 08:00:55 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 9D4BD30C0A0;
        Mon, 20 May 2019 05:00:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 9D4BD30C0A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1558353653;
        bh=L7bmPvrXrRT78nANaAUXJEd/KZDQp60omDsRj55LMXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KJkgBK45XhWXfWueOgypJyzg5kV795xWwL3lCCCn7ASKp8NbbHsYkcaLeGICP/Uhj
         EC2ncG6x8jl/XF0ELbVr5aoEOGVM/yTiJfQx0gl9tmI0CUdgtAZdjYUN2ShOSVWneT
         atp54FjsA5Tcy0KQDNmVFe9KT8eIXASGY30JCA0w=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id E30BB60D69;
        Mon, 20 May 2019 05:00:53 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id F1AE6B02CD6; Mon, 20 May 2019 14:00:50 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFC 8/8] cfg80211: apply same mandatory rate flags for 5GHz and 6GHz
Date:   Mon, 20 May 2019 14:00:45 +0200
Message-Id: <1558353645-18119-9-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For the new 6GHz band the same rules apply for mandatory rates so
add it to set_mandatory_flags_band() function.

Reviewed-by: Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Reviewed-by: Leon Zegers <leon.zegers@broadcom.com>
Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
---
 net/wireless/util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 03e7176..fd90c86 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -156,6 +156,7 @@ static void set_mandatory_flags_band(struct ieee80211_supported_band *sband)
 
 	switch (sband->band) {
 	case NL80211_BAND_5GHZ:
+	case NL80211_BAND_6GHZ:
 		want = 3;
 		for (i = 0; i < sband->n_bitrates; i++) {
 			if (sband->bitrates[i].bitrate == 60 ||
-- 
1.9.1

