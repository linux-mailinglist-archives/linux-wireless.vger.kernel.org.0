Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 387C6124991
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 15:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfLRO1z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 09:27:55 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:50969 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfLRO1z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 09:27:55 -0500
Received: from isengard.tu-ilmenau.de (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id CD3B4580074;
        Wed, 18 Dec 2019 15:27:53 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] mac80211: fix tx status for no ack cases
Date:   Wed, 18 Dec 2019 15:27:36 +0100
Message-Id: <20191218142736.15843-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Before this patch, frames which where successfully transmitted without
requiring acks where accounted as lost frames.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 net/mac80211/status.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index b720feaf9a74..f0bc314cd6ec 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -888,6 +888,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 	int rates_idx;
 	bool send_to_cooked;
 	bool acked;
+	bool noack_success;
 	struct ieee80211_bar *bar;
 	int shift = 0;
 	int tid = IEEE80211_NUM_TIDS;
@@ -906,6 +907,8 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 			clear_sta_flag(sta, WLAN_STA_SP);
 
 		acked = !!(info->flags & IEEE80211_TX_STAT_ACK);
+		noack_success = !!(info->flags &
+				   IEEE80211_TX_STAT_NOACK_TRANSMITTED);
 
 		/* mesh Peer Service Period support */
 		if (ieee80211_vif_is_mesh(&sta->sdata->vif) &&
@@ -970,12 +973,12 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 			ieee80211_handle_filtered_frame(local, sta, skb);
 			return;
 		} else {
-			if (!acked)
+			if (!acked && !noack_success)
 				sta->status_stats.retry_failed++;
 			sta->status_stats.retry_count += retry_count;
 
 			if (ieee80211_is_data_present(fc)) {
-				if (!acked)
+				if (!acked && !noack_success)
 					sta->status_stats.msdu_failed[tid]++;
 
 				sta->status_stats.msdu_retries[tid] +=
@@ -1013,7 +1016,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 		}
 
 		if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
-			if (info->flags & IEEE80211_TX_STAT_ACK) {
+			if (acked) {
 				if (sta->status_stats.lost_packets)
 					sta->status_stats.lost_packets = 0;
 
@@ -1021,6 +1024,8 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 				if (test_sta_flag(sta, WLAN_STA_TDLS_PEER_AUTH))
 					sta->status_stats.last_tdls_pkt_time =
 						jiffies;
+			} else if (noack_success) {
+				/* nothing to do here, do not account as lost */
 			} else {
 				ieee80211_lost_packet(sta, info);
 			}
@@ -1141,7 +1146,7 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 
 		sta = container_of(pubsta, struct sta_info, sta);
 
-		if (!acked)
+		if (!acked && !noack_success)
 			sta->status_stats.retry_failed++;
 		sta->status_stats.retry_count += retry_count;
 
@@ -1156,6 +1161,8 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 				sta->status_stats.last_tdls_pkt_time = jiffies;
 		} else if (test_sta_flag(sta, WLAN_STA_PS_STA)) {
 			return;
+		} else if (noack_success) {
+			/* nothing to do here, do not account as lost */
 		} else {
 			ieee80211_lost_packet(sta, info);
 		}
-- 
2.24.1

