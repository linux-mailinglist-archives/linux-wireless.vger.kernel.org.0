Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FEF723F852
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Aug 2020 19:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgHHRZr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Aug 2020 13:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHRZr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Aug 2020 13:25:47 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2415BC061756
        for <linux-wireless@vger.kernel.org>; Sat,  8 Aug 2020 10:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=OalnPqJXvUuCPazxtPkqT4L7SXTnx7BkZI7+3jRwAzM=; b=MWMUBgZZYUG/tMo/bIZe4rphcg
        ujipWy0dQ5B0NKI68OOfSx5mpjtJvWsCt9tdWRL0+jCQE4IqDlrtOTSLEQmlG30ZLmh8nj/KAZ6Od
        cCwK530Hmy+DHqogGo40MSLz9kZ5KyZnBmLE81X+bYl5ZBidIN7Xc3PEzJU4ulBGBRtU=;
Received: from p54ae996c.dip0.t-ipconnect.de ([84.174.153.108] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k4SbH-0006Dk-ET; Sat, 08 Aug 2020 19:25:43 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH] mac80211: reduce packet loss event false positives
Date:   Sat,  8 Aug 2020 19:25:42 +0200
Message-Id: <20200808172542.41628-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When running a large number of packets per second with a high data rate
and long A-MPDUs, the packet loss threshold can be reached very quickly
when the link conditions change. This frequently shows up as spurious
disconnects.
Mitigate false positives by using a similar logic for regular stations
as the one being used for TDLS, though with a more aggressive timeout.
Packet loss events are only reported if no ACK was received for a second.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/sta_info.h |  4 ++--
 net/mac80211/status.c   | 31 +++++++++++++++----------------
 2 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 49728047dfad..f66fcce8e6a4 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -522,7 +522,7 @@ struct ieee80211_sta_rx_stats {
  * @status_stats.retry_failed: # of frames that failed after retry
  * @status_stats.retry_count: # of retries attempted
  * @status_stats.lost_packets: # of lost packets
- * @status_stats.last_tdls_pkt_time: timestamp of last TDLS packet
+ * @status_stats.last_pkt_time: timestamp of last ACKed packet
  * @status_stats.msdu_retries: # of MSDU retries
  * @status_stats.msdu_failed: # of failed MSDUs
  * @status_stats.last_ack: last ack timestamp (jiffies)
@@ -595,7 +595,7 @@ struct sta_info {
 		unsigned long filtered;
 		unsigned long retry_failed, retry_count;
 		unsigned int lost_packets;
-		unsigned long last_tdls_pkt_time;
+		unsigned long last_pkt_time;
 		u64 msdu_retries[IEEE80211_NUM_TIDS + 1];
 		u64 msdu_failed[IEEE80211_NUM_TIDS + 1];
 		unsigned long last_ack;
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index cbc40b358ba2..819c4221c284 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -755,12 +755,16 @@ static void ieee80211_report_used_skb(struct ieee80211_local *local,
  *  - current throughput (higher value for higher tpt)?
  */
 #define STA_LOST_PKT_THRESHOLD	50
+#define STA_LOST_PKT_TIME	HZ		/* 1 sec since last ACK */
 #define STA_LOST_TDLS_PKT_THRESHOLD	10
 #define STA_LOST_TDLS_PKT_TIME		(10*HZ) /* 10secs since last ACK */
 
 static void ieee80211_lost_packet(struct sta_info *sta,
 				  struct ieee80211_tx_info *info)
 {
+	unsigned long pkt_time = STA_LOST_PKT_TIME;
+	unsigned int pkt_thr = STA_LOST_PKT_THRESHOLD;
+
 	/* If driver relies on its own algorithm for station kickout, skip
 	 * mac80211 packet loss mechanism.
 	 */
@@ -773,21 +777,20 @@ static void ieee80211_lost_packet(struct sta_info *sta,
 		return;
 
 	sta->status_stats.lost_packets++;
-	if (!sta->sta.tdls &&
-	    sta->status_stats.lost_packets < STA_LOST_PKT_THRESHOLD)
-		return;
+	if (sta->sta.tdls) {
+		pkt_time = STA_LOST_TDLS_PKT_TIME;
+		pkt_thr = STA_LOST_PKT_THRESHOLD;
+	}
 
 	/*
 	 * If we're in TDLS mode, make sure that all STA_LOST_TDLS_PKT_THRESHOLD
 	 * of the last packets were lost, and that no ACK was received in the
 	 * last STA_LOST_TDLS_PKT_TIME ms, before triggering the CQM packet-loss
 	 * mechanism.
+	 * For non-TDLS, use STA_LOST_PKT_THRESHOLD and STA_LOST_PKT_TIME
 	 */
-	if (sta->sta.tdls &&
-	    (sta->status_stats.lost_packets < STA_LOST_TDLS_PKT_THRESHOLD ||
-	     time_before(jiffies,
-			 sta->status_stats.last_tdls_pkt_time +
-			 STA_LOST_TDLS_PKT_TIME)))
+	if (sta->status_stats.lost_packets < pkt_thr ||
+	    !time_after(jiffies, sta->status_stats.last_pkt_time + pkt_time))
 		return;
 
 	cfg80211_cqm_pktloss_notify(sta->sdata->dev, sta->sta.addr,
@@ -1035,9 +1038,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 					sta->status_stats.lost_packets = 0;
 
 				/* Track when last TDLS packet was ACKed */
-				if (test_sta_flag(sta, WLAN_STA_TDLS_PEER_AUTH))
-					sta->status_stats.last_tdls_pkt_time =
-						jiffies;
+				sta->status_stats.last_pkt_time = jiffies;
 			} else if (noack_success) {
 				/* nothing to do here, do not account as lost */
 			} else {
@@ -1170,9 +1171,8 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 			if (sta->status_stats.lost_packets)
 				sta->status_stats.lost_packets = 0;
 
-			/* Track when last TDLS packet was ACKed */
-			if (test_sta_flag(sta, WLAN_STA_TDLS_PEER_AUTH))
-				sta->status_stats.last_tdls_pkt_time = jiffies;
+			/* Track when last packet was ACKed */
+			sta->status_stats.last_pkt_time = jiffies;
 		} else if (test_sta_flag(sta, WLAN_STA_PS_STA)) {
 			return;
 		} else if (noack_success) {
@@ -1261,8 +1261,7 @@ void ieee80211_tx_status_8023(struct ieee80211_hw *hw,
 			if (sta->status_stats.lost_packets)
 				sta->status_stats.lost_packets = 0;
 
-			if (test_sta_flag(sta, WLAN_STA_TDLS_PEER_AUTH))
-				sta->status_stats.last_tdls_pkt_time = jiffies;
+			sta->status_stats.last_pkt_time = jiffies;
 		} else {
 			ieee80211_lost_packet(sta, info);
 		}
-- 
2.28.0

