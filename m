Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65B026150E
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 18:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732127AbgIHQmq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 12:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732019AbgIHQmS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 12:42:18 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5016C06137E
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 05:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZVeIXbED33B0oRI14KObhFDllCing8Gcc/5VA62luPM=; b=YnMXpOyHhFG5Rh3diGw5RK7l9Z
        flJagcBJTybVX05wJJYWlwBT808jTZdwoLJ7W6O5D+Z31ziihIZEFXrMtXs9JZcEx7B5qa7b3aJVW
        wMCzmRc8URInoS+BJeoMC/a3d9nBeDdaU5X1DasoUJ6eYFsNgJUUUKDobQ3atpFbq1ts=;
Received: from p4ff13fcb.dip0.t-ipconnect.de ([79.241.63.203] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kFcry-00050i-EX; Tue, 08 Sep 2020 14:37:06 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v4 10/14] mac80211: unify 802.3 (offload) and 802.11 tx status codepath
Date:   Tue,  8 Sep 2020 14:36:58 +0200
Message-Id: <20200908123702.88454-11-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908123702.88454-1-nbd@nbd.name>
References: <20200908123702.88454-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Make ieee80211_tx_status_8023 call ieee80211_tx_status_ext, similar to
ieee80211_tx_status.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/status.c | 93 +++++++++++++------------------------------
 1 file changed, 28 insertions(+), 65 deletions(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index c873910d95e0..ac4d988556b0 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -894,7 +894,6 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 	struct ieee80211_bar *bar;
 	int shift = 0;
 	int tid = IEEE80211_NUM_TIDS;
-	u16 tx_time_est;
 
 	sband = local->hw.wiphy->bands[info->band];
 	fc = hdr->frame_control;
@@ -987,17 +986,6 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 		    ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS))
 			ieee80211_sta_tx_notify(sta->sdata, (void *) skb->data,
 						acked, info->status.tx_time);
-
-		if ((tx_time_est = ieee80211_info_get_tx_time_est(info)) > 0) {
-			/* Do this here to avoid the expensive lookup of the sta
-			 * in ieee80211_report_used_skb().
-			 */
-			ieee80211_sta_update_pending_airtime(local, sta,
-							     skb_get_queue_mapping(skb),
-							     tx_time_est,
-							     true);
-			ieee80211_info_set_tx_time_est(info, 0);
-		}
 	}
 
 	/* SNMP counters
@@ -1092,9 +1080,12 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct ieee80211_tx_info *info = status->info;
 	struct ieee80211_sta *pubsta = status->sta;
+	struct sk_buff *skb = status->skb;
+	struct sta_info *sta = NULL;
 	struct ieee80211_supported_band *sband;
 	int rates_idx, retry_count;
 	bool acked, noack_success;
+	u16 tx_time_est;
 
 	rates_idx = ieee80211_tx_get_rates(hw, info, &retry_count);
 
@@ -1104,8 +1095,6 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 	noack_success = !!(info->flags & IEEE80211_TX_STAT_NOACK_TRANSMITTED);
 
 	if (pubsta) {
-		struct sta_info *sta;
-
 		sta = container_of(pubsta, struct sta_info, sta);
 
 		if (!acked && !noack_success)
@@ -1143,7 +1132,18 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 			ieee80211s_update_metric(local, sta, status);
 	}
 
-	if (status->skb)
+	if (skb && (tx_time_est = ieee80211_info_get_tx_time_est(info)) > 0) {
+		/* Do this here to avoid the expensive lookup of the sta
+		 * in ieee80211_report_used_skb().
+		 */
+		ieee80211_sta_update_pending_airtime(local, sta,
+						     skb_get_queue_mapping(skb),
+						     tx_time_est,
+						     true);
+		ieee80211_info_set_tx_time_est(info, 0);
+	}
+
+	if (skb && !(info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP))
 		return __ieee80211_tx_status(hw, status, rates_idx,
 					     retry_count);
 
@@ -1158,6 +1158,12 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 	} else {
 		I802_DEBUG_INC(local->dot11FailedCount);
 	}
+
+	if (!skb)
+		return;
+
+	ieee80211_report_used_skb(local, skb, false);
+	dev_kfree_skb(skb);
 }
 EXPORT_SYMBOL(ieee80211_tx_status_ext);
 
@@ -1184,66 +1190,23 @@ void ieee80211_tx_status_8023(struct ieee80211_hw *hw,
 			      struct ieee80211_vif *vif,
 			      struct sk_buff *skb)
 {
-	struct ieee80211_local *local = hw_to_local(hw);
 	struct ieee80211_sub_if_data *sdata;
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_tx_status status = {
+		.skb = skb,
+		.info = IEEE80211_SKB_CB(skb),
+	};
 	struct sta_info *sta;
-	int retry_count;
-	int rates_idx;
-	bool acked;
 
 	sdata = vif_to_sdata(vif);
 
-	acked = info->flags & IEEE80211_TX_STAT_ACK;
-	rates_idx = ieee80211_tx_get_rates(hw, info, &retry_count);
-
 	rcu_read_lock();
 
-	if (ieee80211_lookup_ra_sta(sdata, skb, &sta))
-		goto counters_update;
-
-	if (IS_ERR(sta))
-		goto counters_update;
-
-	if (!acked)
-		sta->status_stats.retry_failed++;
-
-	if (rates_idx != -1)
-		sta->tx_stats.last_rate = info->status.rates[rates_idx];
-
-	sta->status_stats.retry_count += retry_count;
-
-	if (ieee80211_hw_check(hw, REPORTS_TX_ACK_STATUS)) {
-		sta->status_stats.last_ack = jiffies;
-		if (info->flags & IEEE80211_TX_STAT_ACK) {
-			if (sta->status_stats.lost_packets)
-				sta->status_stats.lost_packets = 0;
+	if (!ieee80211_lookup_ra_sta(sdata, skb, &sta) && !IS_ERR(sta))
+		status.sta = &sta->sta;
 
-			sta->status_stats.last_pkt_time = jiffies;
-		} else {
-			ieee80211_lost_packet(sta, info);
-		}
-	}
+	ieee80211_tx_status_ext(hw, &status);
 
-counters_update:
 	rcu_read_unlock();
-	ieee80211_led_tx(local);
-
-	if (!(info->flags & IEEE80211_TX_STAT_ACK) &&
-	    !(info->flags & IEEE80211_TX_STAT_NOACK_TRANSMITTED))
-		goto skip_stats_update;
-
-	I802_DEBUG_INC(local->dot11TransmittedFrameCount);
-	if (is_multicast_ether_addr(skb->data))
-		I802_DEBUG_INC(local->dot11MulticastTransmittedFrameCount);
-	if (retry_count > 0)
-		I802_DEBUG_INC(local->dot11RetryCount);
-	if (retry_count > 1)
-		I802_DEBUG_INC(local->dot11MultipleRetryCount);
-
-skip_stats_update:
-	ieee80211_report_used_skb(local, skb, false);
-	dev_kfree_skb(skb);
 }
 EXPORT_SYMBOL(ieee80211_tx_status_8023);
 
-- 
2.28.0

