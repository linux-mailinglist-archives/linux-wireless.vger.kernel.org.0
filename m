Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C11F281A2C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Oct 2020 19:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388139AbgJBRxM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Oct 2020 13:53:12 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:53212 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726224AbgJBRxM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Oct 2020 13:53:12 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id 2181B4FA0DF;
        Fri,  2 Oct 2020 17:53:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5jBO51pU-6h7; Fri,  2 Oct 2020 17:53:09 +0000 (UTC)
Received: from atlas.ibsgaard.io (c-73-223-60-234.hsd1.ca.comcast.net [73.223.60.234])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 2F1774FA00B;
        Fri,  2 Oct 2020 17:53:09 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [PATCH 1/2] mac80211: handle lack of sband->bitrates in rates
Date:   Fri,  2 Oct 2020 10:53:07 -0700
Message-Id: <20201002175308.16374-1-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Even though a driver or mac80211 shouldn't produce a
legacy bitrate if sband->bitrates doesn't exist, don't
crash if that is the case either.

This fixes a kernel panic if station dump is run before
last_rate can be updated with a data frame when
sband->bitrates is missing (eg. in S1G bands).

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 net/mac80211/cfg.c      | 3 ++-
 net/mac80211/sta_info.c | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index da70f174d629..e40160114824 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -709,7 +709,8 @@ void sta_set_rate_info_tx(struct sta_info *sta,
 		u16 brate;
 
 		sband = ieee80211_get_sband(sta->sdata);
-		if (sband) {
+		WARN_ON(sband && !sband->bitrates);
+		if (sband && sband->bitrates) {
 			brate = sband->bitrates[rate->idx].bitrate;
 			rinfo->legacy = DIV_ROUND_UP(brate, 1 << shift);
 		}
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index f2840d1d95cf..0efb66b8f185 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2122,6 +2122,10 @@ static void sta_stats_decode_rate(struct ieee80211_local *local, u32 rate,
 		int rate_idx = STA_STATS_GET(LEGACY_IDX, rate);
 
 		sband = local->hw.wiphy->bands[band];
+
+		if (WARN_ON(!sband->bitrates))
+			break;
+
 		brate = sband->bitrates[rate_idx].bitrate;
 		if (rinfo->bw == RATE_INFO_BW_5)
 			shift = 2;
-- 
2.20.1

