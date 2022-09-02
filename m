Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62DA85AB427
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 16:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiIBOve (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 10:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236580AbiIBOvE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 10:51:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC1A82FB7
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 07:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=DJ01+NeHqJ+XouUvPRpEV5QJqsp1sG1Hy/t+PQvBcHM=;
        t=1662127989; x=1663337589; b=WRa86XUYTCey+KGOAfFNPAiuFFbC/3mknaJ6UIpaOthWmny
        6oKY6dHUEkBQvxL6MLV9SMbutwDL21s8VmJFJDg+bCXOFMs+qtCG+hzoDV5xOjiVJ+rsruGZjxo//
        ozB//W9SK0exvwRKk8FbUBUto+T2nK4jLIdgjllYtP+T3jJyfi9YDr2d8sjCnLktZZsQTZDFeNl6m
        F45ZxeJ8P2xXPXgSqFQbD9Kyo/w0tLXvP2TlOrTMS3nBPbpOut6F71IA9DRm+FRnyddOTgm/52ZyT
        96SmEOjemYm7nAyb+9ig7b2IJ9wrhXBcp+2kDcAFkAGu98KHCIaHKKcMEUW5SRHQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oU7Pv-006Ch3-0K;
        Fri, 02 Sep 2022 16:13:07 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 08/27] wifi: mac80211: use correct rx link_sta instead of default
Date:   Fri,  2 Sep 2022 16:12:40 +0200
Message-Id: <20220902161143.028e767b20a4.I4133fd56517e260f147fce5a65f5a0b8bfa70d69@changeid>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220902141259.377789-1-johannes@sipsolutions.net>
References: <20220902141259.377789-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Benjamin Berg <benjamin.berg@intel.com>

Use rx->link_sta everywhere instead of accessing the default link.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/rx.c | 69 ++++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 511c809e2c6b..38622446ea8a 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1452,7 +1452,7 @@ ieee80211_rx_h_check_dup(struct ieee80211_rx_data *rx)
 	if (unlikely(ieee80211_has_retry(hdr->frame_control) &&
 		     rx->sta->last_seq_ctrl[rx->seqno_idx] == hdr->seq_ctrl)) {
 		I802_DEBUG_INC(rx->local->dot11FrameDuplicateCount);
-		rx->sta->deflink.rx_stats.num_duplicates++;
+		rx->link_sta->rx_stats.num_duplicates++;
 		return RX_DROP_UNUSABLE;
 	} else if (!(status->flag & RX_FLAG_AMSDU_MORE)) {
 		rx->sta->last_seq_ctrl[rx->seqno_idx] = hdr->seq_ctrl;
@@ -1731,12 +1731,13 @@ static ieee80211_rx_result debug_noinline
 ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 {
 	struct sta_info *sta = rx->sta;
+	struct link_sta_info *link_sta = rx->link_sta;
 	struct sk_buff *skb = rx->skb;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	int i;
 
-	if (!sta)
+	if (!sta || !link_sta)
 		return RX_CONTINUE;
 
 	/*
@@ -1752,47 +1753,47 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 						NL80211_IFTYPE_ADHOC);
 		if (ether_addr_equal(bssid, rx->sdata->u.ibss.bssid) &&
 		    test_sta_flag(sta, WLAN_STA_AUTHORIZED)) {
-			sta->deflink.rx_stats.last_rx = jiffies;
+			link_sta->rx_stats.last_rx = jiffies;
 			if (ieee80211_is_data(hdr->frame_control) &&
 			    !is_multicast_ether_addr(hdr->addr1))
-				sta->deflink.rx_stats.last_rate =
+				link_sta->rx_stats.last_rate =
 					sta_stats_encode_rate(status);
 		}
 	} else if (rx->sdata->vif.type == NL80211_IFTYPE_OCB) {
-		sta->deflink.rx_stats.last_rx = jiffies;
+		link_sta->rx_stats.last_rx = jiffies;
 	} else if (!ieee80211_is_s1g_beacon(hdr->frame_control) &&
 		   !is_multicast_ether_addr(hdr->addr1)) {
 		/*
 		 * Mesh beacons will update last_rx when if they are found to
 		 * match the current local configuration when processed.
 		 */
-		sta->deflink.rx_stats.last_rx = jiffies;
+		link_sta->rx_stats.last_rx = jiffies;
 		if (ieee80211_is_data(hdr->frame_control))
-			sta->deflink.rx_stats.last_rate = sta_stats_encode_rate(status);
+			link_sta->rx_stats.last_rate = sta_stats_encode_rate(status);
 	}
 
-	sta->deflink.rx_stats.fragments++;
+	link_sta->rx_stats.fragments++;
 
-	u64_stats_update_begin(&rx->sta->deflink.rx_stats.syncp);
-	sta->deflink.rx_stats.bytes += rx->skb->len;
-	u64_stats_update_end(&rx->sta->deflink.rx_stats.syncp);
+	u64_stats_update_begin(&link_sta->rx_stats.syncp);
+	link_sta->rx_stats.bytes += rx->skb->len;
+	u64_stats_update_end(&link_sta->rx_stats.syncp);
 
 	if (!(status->flag & RX_FLAG_NO_SIGNAL_VAL)) {
-		sta->deflink.rx_stats.last_signal = status->signal;
-		ewma_signal_add(&sta->deflink.rx_stats_avg.signal,
+		link_sta->rx_stats.last_signal = status->signal;
+		ewma_signal_add(&link_sta->rx_stats_avg.signal,
 				-status->signal);
 	}
 
 	if (status->chains) {
-		sta->deflink.rx_stats.chains = status->chains;
+		link_sta->rx_stats.chains = status->chains;
 		for (i = 0; i < ARRAY_SIZE(status->chain_signal); i++) {
 			int signal = status->chain_signal[i];
 
 			if (!(status->chains & BIT(i)))
 				continue;
 
-			sta->deflink.rx_stats.chain_signal_last[i] = signal;
-			ewma_signal_add(&sta->deflink.rx_stats_avg.chain_signal[i],
+			link_sta->rx_stats.chain_signal_last[i] = signal;
+			ewma_signal_add(&link_sta->rx_stats_avg.chain_signal[i],
 					-signal);
 		}
 	}
@@ -1853,7 +1854,7 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 		 * Update counter and free packet here to avoid
 		 * counting this as a dropped packed.
 		 */
-		sta->deflink.rx_stats.packets++;
+		link_sta->rx_stats.packets++;
 		dev_kfree_skb(rx->skb);
 		return RX_QUEUED;
 	}
@@ -2389,7 +2390,7 @@ ieee80211_rx_h_defragment(struct ieee80211_rx_data *rx)
  out:
 	ieee80211_led_rx(rx->local);
 	if (rx->sta)
-		rx->sta->deflink.rx_stats.packets++;
+		rx->link_sta->rx_stats.packets++;
 	return RX_CONTINUE;
 }
 
@@ -2665,9 +2666,9 @@ ieee80211_deliver_skb(struct ieee80211_rx_data *rx)
 		 * for non-QoS-data frames. Here we know it's a data
 		 * frame, so count MSDUs.
 		 */
-		u64_stats_update_begin(&rx->sta->deflink.rx_stats.syncp);
-		rx->sta->deflink.rx_stats.msdu[rx->seqno_idx]++;
-		u64_stats_update_end(&rx->sta->deflink.rx_stats.syncp);
+		u64_stats_update_begin(&rx->link_sta->rx_stats.syncp);
+		rx->link_sta->rx_stats.msdu[rx->seqno_idx]++;
+		u64_stats_update_end(&rx->link_sta->rx_stats.syncp);
 	}
 
 	if ((sdata->vif.type == NL80211_IFTYPE_AP ||
@@ -3364,7 +3365,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 	switch (mgmt->u.action.category) {
 	case WLAN_CATEGORY_HT:
 		/* reject HT action frames from stations not supporting HT */
-		if (!rx->sta->sta.deflink.ht_cap.ht_supported)
+		if (!rx->link_sta->pub->ht_cap.ht_supported)
 			goto invalid;
 
 		if (sdata->vif.type != NL80211_IFTYPE_STATION &&
@@ -3428,26 +3429,26 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 			struct sta_opmode_info sta_opmode = {};
 
 			/* If it doesn't support 40 MHz it can't change ... */
-			if (!(rx->sta->sta.deflink.ht_cap.cap &
+			if (!(rx->link_sta->pub->ht_cap.cap &
 					IEEE80211_HT_CAP_SUP_WIDTH_20_40))
 				goto handled;
 
 			if (chanwidth == IEEE80211_HT_CHANWIDTH_20MHZ)
 				max_bw = IEEE80211_STA_RX_BW_20;
 			else
-				max_bw = ieee80211_sta_cap_rx_bw(&rx->sta->deflink);
+				max_bw = ieee80211_sta_cap_rx_bw(rx->link_sta);
 
 			/* set cur_max_bandwidth and recalc sta bw */
-			rx->sta->deflink.cur_max_bandwidth = max_bw;
-			new_bw = ieee80211_sta_cur_vht_bw(&rx->sta->deflink);
+			rx->link_sta->cur_max_bandwidth = max_bw;
+			new_bw = ieee80211_sta_cur_vht_bw(rx->link_sta);
 
-			if (rx->sta->sta.deflink.bandwidth == new_bw)
+			if (rx->link_sta->pub->bandwidth == new_bw)
 				goto handled;
 
-			rx->sta->sta.deflink.bandwidth = new_bw;
+			rx->link_sta->pub->bandwidth = new_bw;
 			sband = rx->local->hw.wiphy->bands[status->band];
 			sta_opmode.bw =
-				ieee80211_sta_rx_bw_to_chan_width(&rx->sta->deflink);
+				ieee80211_sta_rx_bw_to_chan_width(rx->link_sta);
 			sta_opmode.changed = STA_OPMODE_MAX_BW_CHANGED;
 
 			rate_control_rate_update(local, sband, rx->sta, 0,
@@ -3641,7 +3642,7 @@ ieee80211_rx_h_action(struct ieee80211_rx_data *rx)
 
  handled:
 	if (rx->sta)
-		rx->sta->deflink.rx_stats.packets++;
+		rx->link_sta->rx_stats.packets++;
 	dev_kfree_skb(rx->skb);
 	return RX_QUEUED;
 
@@ -3685,7 +3686,7 @@ ieee80211_rx_h_userspace_mgmt(struct ieee80211_rx_data *rx)
 
 	if (cfg80211_rx_mgmt_ext(&rx->sdata->wdev, &info)) {
 		if (rx->sta)
-			rx->sta->deflink.rx_stats.packets++;
+			rx->link_sta->rx_stats.packets++;
 		dev_kfree_skb(rx->skb);
 		return RX_QUEUED;
 	}
@@ -3723,7 +3724,7 @@ ieee80211_rx_h_action_post_userspace(struct ieee80211_rx_data *rx)
 
  handled:
 	if (rx->sta)
-		rx->sta->deflink.rx_stats.packets++;
+		rx->link_sta->rx_stats.packets++;
 	dev_kfree_skb(rx->skb);
 	return RX_QUEUED;
 }
@@ -3943,7 +3944,7 @@ static void ieee80211_rx_handlers_result(struct ieee80211_rx_data *rx,
 	case RX_DROP_MONITOR:
 		I802_DEBUG_INC(rx->sdata->local->rx_handlers_drop);
 		if (rx->sta)
-			rx->sta->deflink.rx_stats.dropped++;
+			rx->link_sta->rx_stats.dropped++;
 		fallthrough;
 	case RX_CONTINUE: {
 		struct ieee80211_rate *rate = NULL;
@@ -3962,7 +3963,7 @@ static void ieee80211_rx_handlers_result(struct ieee80211_rx_data *rx,
 	case RX_DROP_UNUSABLE:
 		I802_DEBUG_INC(rx->sdata->local->rx_handlers_drop);
 		if (rx->sta)
-			rx->sta->deflink.rx_stats.dropped++;
+			rx->link_sta->rx_stats.dropped++;
 		dev_kfree_skb(rx->skb);
 		break;
 	case RX_QUEUED:
-- 
2.37.2

