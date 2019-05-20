Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA82B23326
	for <lists+linux-wireless@lfdr.de>; Mon, 20 May 2019 14:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732440AbfETMA5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 May 2019 08:00:57 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:35402 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732316AbfETMAz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 May 2019 08:00:55 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.224.233])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id E802C30C0A2;
        Mon, 20 May 2019 05:00:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com E802C30C0A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1558353653;
        bh=s6gh0Ko5DkoD8CU8bX1oBQPSktFgwWM4twdQ5wCT57E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EgIsuzC5e8h1NBQkK7MwNWIGAn0zdj34xjIFDZwuvDrfnSZMIjuRrm3zz/OZLkiL1
         UQRJz75sb7vVFF4PqGJc6d81y+gG6eAdNwMEbba0kJxPms7nmSNJOX0N8wBh64lB/F
         6BxPBnTUeMDzKX7GV7aWmaL66i4vmYX015uDIsn4=
Received: from bld-bun-01.bun.broadcom.com (bld-bun-01.bun.broadcom.com [10.176.128.83])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id 5822E60D71;
        Mon, 20 May 2019 05:00:54 -0700 (PDT)
Received: by bld-bun-01.bun.broadcom.com (Postfix, from userid 25152)
        id F2BFFB02ED9; Mon, 20 May 2019 14:00:50 +0200 (CEST)
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [RFC 4/8] cfg80211: extend ieee80211_operating_class_to_band() for 6GHz
Date:   Mon, 20 May 2019 14:00:41 +0200
Message-Id: <1558353645-18119-5-git-send-email-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
References: <1558353645-18119-1-git-send-email-arend.vanspriel@broadcom.com>
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
index 081637e..03e7176 100644
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

