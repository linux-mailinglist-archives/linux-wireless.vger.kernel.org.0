Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE611348029
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 19:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237324AbhCXSPC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 14:15:02 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:41034 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237297AbhCXSOr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 14:14:47 -0400
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 0D2BD13C2B3;
        Wed, 24 Mar 2021 11:14:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0D2BD13C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1616609687;
        bh=7xYNXoy1X5a0IYrGYAkYDEcWlSesYUujs0cRAS2jiyI=;
        h=From:To:Cc:Subject:Date:From;
        b=oAIBmnxOBFFmf1n4zAaRdCinnU+4NOVpfCzAmvIN6hYqnHHw3cKjmBzYB1HZ6xdne
         eLYki8Ya4/SJEjBTXZ9CJTze748sqJmC30s8FOemVJ3i+jVAKacA7T3fs6lgkCtJGR
         RlAi1NfCFX9uTjlVw+psw9duchZ2UEml8QgTWhMI=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH-v2 1/6] mac80211:  Fix station rx-packets counters.
Date:   Wed, 24 Mar 2021 11:14:36 -0700
Message-Id: <20210324181441.13755-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

I noticed 'iw dev wlan6 station dump' showed almost no rx-packets
one one of my radios.  The rx-amsdu path did not appear to gather
any stats, and after code inspection, neither did the rx-data
handler.

Add common method to deal with these stats.  Verified in AX
and /a mode, stats look at least generally correct now.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/rx.c | 54 ++++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index eb8225209005..4a64c2183a27 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1713,6 +1713,27 @@ ieee80211_rx_h_uapsd_and_pspoll(struct ieee80211_rx_data *rx)
 	return RX_CONTINUE;
 }
 
+static void ieee80211_update_data_rx_stats(struct ieee80211_rx_data *rx,
+					   struct ieee80211_sta_rx_stats *stats,
+					   struct ieee80211_rx_status *status,
+					   int skb_len)
+{
+	stats->fragments++;
+	stats->packets++;
+	stats->last_rx = jiffies;
+	stats->last_rate = sta_stats_encode_rate(status);
+
+	/* The seqno index has the same property as needed
+	 * for the rx_msdu field, i.e. it is IEEE80211_NUM_TIDS
+	 * for non-QoS-data frames. Here we know it's a data
+	 * frame, so count MSDUs.
+	 */
+	u64_stats_update_begin(&stats->syncp);
+	stats->msdu[rx->seqno_idx]++;
+	stats->bytes += skb_len;
+	u64_stats_update_end(&stats->syncp);
+}
+
 static ieee80211_rx_result debug_noinline
 ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 {
@@ -2706,6 +2727,8 @@ ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx)
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	__le16 fc = hdr->frame_control;
+	ieee80211_rx_result rv;
+	int orig_len = skb->len;
 
 	if (!(status->rx_flags & IEEE80211_RX_AMSDU))
 		return RX_CONTINUE;
@@ -2734,7 +2757,12 @@ ieee80211_rx_h_amsdu(struct ieee80211_rx_data *rx)
 	if (is_multicast_ether_addr(hdr->addr1))
 		return RX_DROP_UNUSABLE;
 
-	return __ieee80211_rx_h_amsdu(rx, 0);
+	rv = __ieee80211_rx_h_amsdu(rx, 0);
+	if ((rv == RX_QUEUED) && (rx->sta)) {
+		struct ieee80211_sta_rx_stats *stats = &rx->sta->rx_stats;
+		ieee80211_update_data_rx_stats(rx, stats, status, orig_len);
+	}
+	return rv;
 }
 
 #ifdef CONFIG_MAC80211_MESH
@@ -2958,6 +2986,13 @@ ieee80211_rx_h_data(struct ieee80211_rx_data *rx)
 		mod_timer(&local->dynamic_ps_timer, jiffies +
 			  msecs_to_jiffies(local->hw.conf.dynamic_ps_timeout));
 
+	
+	if (rx->sta) {
+		struct ieee80211_sta_rx_stats *stats = &rx->sta->rx_stats;
+		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(rx->skb);
+		ieee80211_update_data_rx_stats(rx, stats, status, rx->skb->len);
+	}
+
 	ieee80211_deliver_skb(rx);
 
 	return RX_QUEUED;
@@ -4400,12 +4435,6 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 		return true;
 	}
 
-	stats->last_rx = jiffies;
-	stats->last_rate = sta_stats_encode_rate(status);
-
-	stats->fragments++;
-	stats->packets++;
-
 	/* do the header conversion - first grab the addresses */
 	ether_addr_copy(addrs.da, skb->data + fast_rx->da_offs);
 	ether_addr_copy(addrs.sa, skb->data + fast_rx->sa_offs);
@@ -4416,18 +4445,9 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 
 	skb->dev = fast_rx->dev;
 
+	ieee80211_update_data_rx_stats(rx, stats, status, orig_len);
 	dev_sw_netstats_rx_add(fast_rx->dev, skb->len);
 
-	/* The seqno index has the same property as needed
-	 * for the rx_msdu field, i.e. it is IEEE80211_NUM_TIDS
-	 * for non-QoS-data frames. Here we know it's a data
-	 * frame, so count MSDUs.
-	 */
-	u64_stats_update_begin(&stats->syncp);
-	stats->msdu[rx->seqno_idx]++;
-	stats->bytes += orig_len;
-	u64_stats_update_end(&stats->syncp);
-
 	if (fast_rx->internal_forward) {
 		struct sk_buff *xmit_skb = NULL;
 		if (is_multicast_ether_addr(addrs.da)) {
-- 
2.20.1

