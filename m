Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97BF624D0C4
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 10:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgHUIth (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 04:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgHUItd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 04:49:33 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A49C061387
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 01:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cBa8HBE/xeev3ZcQtBrtrAB4HqtL28yYOdl7tNsfqmM=; b=hpJuccCfnNQWtVT5MPadYKj5rk
        pqNL2KeDqVyOilTUfX5qLWnZnTx/Pqs+0J+W8kYS0LMG9iWmhIRWUUtcU4ZxW+sNNd+AXv/88Jd5S
        LYMu8WUinZ5IuDWaUD9ILVb+YYHjf98qjN5lvxX7O2N0Fi5vuUR8b8hveOL5WH2eDfAM=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k92jp-0005lO-9I; Fri, 21 Aug 2020 10:49:29 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v3 02/13] mac80211: reduce duplication in tx status functions
Date:   Fri, 21 Aug 2020 10:49:15 +0200
Message-Id: <20200821084926.10650-3-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200821084926.10650-1-nbd@nbd.name>
References: <20200821084926.10650-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move redundant functionality from __ieee80211_tx_status into
ieee80211_tx_status_ext. Preparation for unifying with the 802.3 tx status
codepath.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/status.c | 101 +++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 66 deletions(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 0f286fb4304e..b3c356b3fc78 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -184,18 +184,6 @@ static void ieee80211_frame_acked(struct sta_info *sta, struct sk_buff *skb)
 	struct ieee80211_mgmt *mgmt = (void *) skb->data;
 	struct ieee80211_local *local = sta->local;
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
-	struct ieee80211_tx_info *txinfo = IEEE80211_SKB_CB(skb);
-
-	if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
-		sta->status_stats.last_ack = jiffies;
-		if (txinfo->status.is_valid_ack_signal) {
-			sta->status_stats.last_ack_signal =
-					 (s8)txinfo->status.ack_signal;
-			sta->status_stats.ack_signal_filled = true;
-			ewma_avg_signal_add(&sta->status_stats.avg_ack_signal,
-					    -txinfo->status.ack_signal);
-		}
-	}
 
 	if (ieee80211_is_data_qos(mgmt->frame_control)) {
 		struct ieee80211_hdr *hdr = (void *) skb->data;
@@ -890,7 +878,8 @@ void ieee80211_tx_monitor(struct ieee80211_local *local, struct sk_buff *skb,
 }
 
 static void __ieee80211_tx_status(struct ieee80211_hw *hw,
-				  struct ieee80211_tx_status *status)
+				  struct ieee80211_tx_status *status,
+				  int rates_idx, int retry_count)
 {
 	struct sk_buff *skb = status->skb;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
@@ -899,8 +888,6 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 	struct sta_info *sta;
 	__le16 fc;
 	struct ieee80211_supported_band *sband;
-	int retry_count;
-	int rates_idx;
 	bool send_to_cooked;
 	bool acked;
 	bool noack_success;
@@ -909,8 +896,6 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 	int tid = IEEE80211_NUM_TIDS;
 	u16 tx_time_est;
 
-	rates_idx = ieee80211_tx_get_rates(hw, info, &retry_count);
-
 	sband = local->hw.wiphy->bands[info->band];
 	fc = hdr->frame_control;
 
@@ -987,24 +972,14 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 		if (info->flags & IEEE80211_TX_STAT_TX_FILTERED) {
 			ieee80211_handle_filtered_frame(local, sta, skb);
 			return;
-		} else {
+		} else if (ieee80211_is_data_present(fc)) {
 			if (!acked && !noack_success)
-				sta->status_stats.retry_failed++;
-			sta->status_stats.retry_count += retry_count;
+				sta->status_stats.msdu_failed[tid]++;
 
-			if (ieee80211_is_data_present(fc)) {
-				if (!acked && !noack_success)
-					sta->status_stats.msdu_failed[tid]++;
-
-				sta->status_stats.msdu_retries[tid] +=
-					retry_count;
-			}
+			sta->status_stats.msdu_retries[tid] +=
+				retry_count;
 		}
 
-		rate_control_tx_status(local, sband, status);
-		if (ieee80211_vif_is_mesh(&sta->sdata->vif))
-			ieee80211s_update_metric(local, sta, status);
-
 		if (!(info->flags & IEEE80211_TX_CTL_INJECTED) && acked)
 			ieee80211_frame_acked(sta, skb);
 
@@ -1029,20 +1004,6 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 							     true);
 			ieee80211_info_set_tx_time_est(info, 0);
 		}
-
-		if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
-			if (acked) {
-				if (sta->status_stats.lost_packets)
-					sta->status_stats.lost_packets = 0;
-
-				/* Track when last TDLS packet was ACKed */
-				sta->status_stats.last_pkt_time = jiffies;
-			} else if (noack_success) {
-				/* nothing to do here, do not account as lost */
-			} else {
-				ieee80211_lost_packet(sta, info);
-			}
-		}
 	}
 
 	/* SNMP counters
@@ -1126,7 +1087,7 @@ void ieee80211_tx_status(struct ieee80211_hw *hw, struct sk_buff *skb)
 	if (sta)
 		status.sta = &sta->sta;
 
-	__ieee80211_tx_status(hw, &status);
+	ieee80211_tx_status_ext(hw, &status);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL(ieee80211_tx_status);
@@ -1138,16 +1099,10 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 	struct ieee80211_tx_info *info = status->info;
 	struct ieee80211_sta *pubsta = status->sta;
 	struct ieee80211_supported_band *sband;
-	int retry_count;
+	int rates_idx, retry_count;
 	bool acked, noack_success;
 
-	if (status->skb)
-		return __ieee80211_tx_status(hw, status);
-
-	if (!status->sta)
-		return;
-
-	ieee80211_tx_get_rates(hw, info, &retry_count);
+	rates_idx = ieee80211_tx_get_rates(hw, info, &retry_count);
 
 	sband = hw->wiphy->bands[info->band];
 
@@ -1163,20 +1118,30 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 			sta->status_stats.retry_failed++;
 		sta->status_stats.retry_count += retry_count;
 
-		if (acked) {
-			sta->status_stats.last_ack = jiffies;
+		if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
+			if (acked) {
+				sta->status_stats.last_ack = jiffies;
 
-			if (sta->status_stats.lost_packets)
-				sta->status_stats.lost_packets = 0;
+				if (sta->status_stats.lost_packets)
+					sta->status_stats.lost_packets = 0;
 
-			/* Track when last packet was ACKed */
-			sta->status_stats.last_pkt_time = jiffies;
-		} else if (test_sta_flag(sta, WLAN_STA_PS_STA)) {
-			return;
-		} else if (noack_success) {
-			/* nothing to do here, do not account as lost */
-		} else {
-			ieee80211_lost_packet(sta, info);
+				/* Track when last packet was ACKed */
+				sta->status_stats.last_pkt_time = jiffies;
+
+				if (info->status.is_valid_ack_signal) {
+					sta->status_stats.last_ack_signal =
+							 (s8)info->status.ack_signal;
+					sta->status_stats.ack_signal_filled = true;
+					ewma_avg_signal_add(&sta->status_stats.avg_ack_signal,
+							    -info->status.ack_signal);
+				}
+			} else if (test_sta_flag(sta, WLAN_STA_PS_STA)) {
+				return;
+			} else if (noack_success) {
+				/* nothing to do here, do not account as lost */
+			} else {
+				ieee80211_lost_packet(sta, info);
+			}
 		}
 
 		rate_control_tx_status(local, sband, status);
@@ -1184,6 +1149,10 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 			ieee80211s_update_metric(local, sta, status);
 	}
 
+	if (status->skb)
+		return __ieee80211_tx_status(hw, status, rates_idx,
+					     retry_count);
+
 	if (acked || noack_success) {
 		I802_DEBUG_INC(local->dot11TransmittedFrameCount);
 		if (!pubsta)
-- 
2.28.0

