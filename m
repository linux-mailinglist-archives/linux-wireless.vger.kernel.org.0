Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7BB634802B
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 19:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbhCXSPD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 14:15:03 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:41048 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237467AbhCXSOs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 14:14:48 -0400
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id E4FC813C2BC;
        Wed, 24 Mar 2021 11:14:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E4FC813C2BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1616609688;
        bh=nE0m9VcXVsL9Cclx7TFdqnMG4tpBiCRuGKWQ4xg2Gis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M5qoEfkv9NJB5H9WUoPczUrhAkTndPkuvlrzwo61E2Yac3CL67+NUmfy+Hn6r1Xhy
         9gg+aE5EiLzUMsRvpMG3xQZXdN8hr13qLfTR00a5pUbXuuQV7ejYbkB6MHagoKq4w8
         WEumIt/yzsN78vrdSjPZFYGFFLmzUc20Q6+rJsjo=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH-v2 6/6] mac80211:  last_rate is 32-bit number.
Date:   Wed, 24 Mar 2021 11:14:41 -0700
Message-Id: <20210324181441.13755-6-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210324181441.13755-1-greearb@candelatech.com>
References: <20210324181441.13755-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Assign it to 32-bit holding variable instead of 16 when processing
the rx rate.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/sta_info.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 6dd62ba40133..a28a562a8fb4 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2246,7 +2246,7 @@ static void sta_stats_decode_rate(struct ieee80211_local *local, u32 rate,
 
 static int sta_set_rate_info_rx(struct sta_info *sta, struct rate_info *rinfo)
 {
-	u16 rate = READ_ONCE(sta_get_last_rx_stats(sta)->last_rate);
+	u32 rate = READ_ONCE(sta_get_last_rx_stats(sta)->last_rate);
 
 	if (rate == STA_STATS_RATE_INVALID)
 		return -EINVAL;
-- 
2.20.1

