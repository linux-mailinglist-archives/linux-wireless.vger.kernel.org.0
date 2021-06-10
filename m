Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05ED3A3494
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jun 2021 22:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhFJUKX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Jun 2021 16:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhFJUKW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Jun 2021 16:10:22 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1875FC061574
        for <linux-wireless@vger.kernel.org>; Thu, 10 Jun 2021 13:08:25 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lrQyS-0050J8-AR; Thu, 10 Jun 2021 22:08:20 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Thiraviyam Mariyappan <tmariyap@codeaurora.org>
Subject: [PATCH] mac80211: consider per-CPU statistics if present
Date:   Thu, 10 Jun 2021 22:08:16 +0200
Message-Id: <20210610220814.13b35f5797c5.I511e9b33c5694e0d6cef4b6ae755c873d7c22124@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If we have been keeping per-CPU statistics, consider them
regardless of USES_RSS, because we may not actually fill
those, for example in non-fast-RX cases when the connection
is not compatible with fast-RX. If we didn't fill them, the
additional data will be zero and not affect anything, and
if we did fill them then it's more correct to consider them.

This fixes an issue in mesh mode where some statistics are
not updated due to USES_RSS being set, but fast-RX isn't
used.

Reported-by: Thiraviyam Mariyappan <tmariyap@codeaurora.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/sta_info.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index f2fb69da9b6e..f0909021da2e 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2096,7 +2096,7 @@ sta_get_last_rx_stats(struct sta_info *sta)
 	struct ieee80211_local *local = sta->local;
 	int cpu;
 
-	if (!ieee80211_hw_check(&local->hw, USES_RSS))
+	if (!sta->pcpu_rx_stats)
 		return stats;
 
 	for_each_possible_cpu(cpu) {
@@ -2196,9 +2196,7 @@ static void sta_set_tidstats(struct sta_info *sta,
 	int cpu;
 
 	if (!(tidstats->filled & BIT(NL80211_TID_STATS_RX_MSDU))) {
-		if (!ieee80211_hw_check(&local->hw, USES_RSS))
-			tidstats->rx_msdu +=
-				sta_get_tidstats_msdu(&sta->rx_stats, tid);
+		tidstats->rx_msdu += sta_get_tidstats_msdu(&sta->rx_stats, tid);
 
 		if (sta->pcpu_rx_stats) {
 			for_each_possible_cpu(cpu) {
@@ -2277,7 +2275,6 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 		sinfo->rx_beacon = sdata->u.mgd.count_beacon_signal;
 
 	drv_sta_statistics(local, sdata, &sta->sta, sinfo);
-
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_INACTIVE_TIME) |
 			 BIT_ULL(NL80211_STA_INFO_STA_FLAGS) |
 			 BIT_ULL(NL80211_STA_INFO_BSS_PARAM) |
@@ -2312,8 +2309,7 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 
 	if (!(sinfo->filled & (BIT_ULL(NL80211_STA_INFO_RX_BYTES64) |
 			       BIT_ULL(NL80211_STA_INFO_RX_BYTES)))) {
-		if (!ieee80211_hw_check(&local->hw, USES_RSS))
-			sinfo->rx_bytes += sta_get_stats_bytes(&sta->rx_stats);
+		sinfo->rx_bytes += sta_get_stats_bytes(&sta->rx_stats);
 
 		if (sta->pcpu_rx_stats) {
 			for_each_possible_cpu(cpu) {
-- 
2.31.1

