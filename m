Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56852CFAE6
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Dec 2020 10:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgLEJvc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 5 Dec 2020 04:51:32 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:43615 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728781AbgLEJgO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 5 Dec 2020 04:36:14 -0500
X-Greylist: delayed 521 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Dec 2020 04:36:14 EST
Received: from isengard.fritz.box (unknown [87.147.53.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id E8C4C58007E;
        Sat,  5 Dec 2020 10:26:29 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>,
        Marc Rantanen <marc@eciceron.se>
Subject: [PATCH] iw: use correct type in policy check for mesh
Date:   Sat,  5 Dec 2020 10:26:15 +0100
Message-Id: <20201205092615.131561-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

NL80211_STA_INFO_CONNECTED_TO_AS and NL80211_STA_INFO_CONNECTED_TO_GATE
are defined as u8 in kernel, but were checked against NLA_FLAG.

This fixes:

root@openwrt:~# iw dev wlan0-mesh station
failed to parse nested attributes!
failed to parse nested attributes!
failed to parse nested attributes!

Reported-by: Marc Rantanen <marc@eciceron.se>
Tested-by: Marc Rantanen <marc@eciceron.se>
Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 station.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/station.c b/station.c
index b2c5b9c..bddea51 100644
--- a/station.c
+++ b/station.c
@@ -329,8 +329,8 @@ static int print_sta_handler(struct nl_msg *msg, void *arg)
 		[NL80211_STA_INFO_ACK_SIGNAL] = {.type = NLA_U8 },
 		[NL80211_STA_INFO_ACK_SIGNAL_AVG] = { .type = NLA_U8 },
 		[NL80211_STA_INFO_AIRTIME_LINK_METRIC] = { .type = NLA_U32 },
-		[NL80211_STA_INFO_CONNECTED_TO_AS] = { .type = NLA_FLAG },
-		[NL80211_STA_INFO_CONNECTED_TO_GATE] = { .type = NLA_FLAG },
+		[NL80211_STA_INFO_CONNECTED_TO_AS] = { .type = NLA_U8 },
+		[NL80211_STA_INFO_CONNECTED_TO_GATE] = { .type = NLA_U8 },
 	};
 	char *chain;
 	struct timeval now;
-- 
2.29.2

