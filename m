Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7178434802D
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 19:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237459AbhCXSPF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 14:15:05 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:41040 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237463AbhCXSOs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 14:14:48 -0400
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 904A213C2B7;
        Wed, 24 Mar 2021 11:14:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 904A213C2B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1616609687;
        bh=wBpzey1nSaELX9/LNvqoPsN7qoUHhiNw2JfinCso+jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJabmqi0AKsTlNu2nheUambtsw7//GGfJGXJUH9DSarNmCDTVOPj6UfRxRuZ+XCY8
         4kbonRjy1atI0DAA/OWIVqHpZE1LQYxEzx4wVeHyZUJlvT8GXDhZ1bmEHPm9Tu8QHC
         3WBPM2kllZ6RzIBEIhBlATc+Dbj1bRGtNSjRjveM=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH-v2 4/6] mac80211:  Add counters for specific HE encoding types.
Date:   Wed, 24 Mar 2021 11:14:39 -0700
Message-Id: <20210324181441.13755-4-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210324181441.13755-1-greearb@candelatech.com>
References: <20210324181441.13755-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

So we can get counters of SU, SU-EXT, MU, Trigger
frame types.  Drivers use a convoluted way to pass this
up the stack, encoding the info in radiotap headers prepended
on the skb.  So, do a bit of hopefully-correct math to find
the radiotap_he header again in mac80211 and store it for
stats gathering.  This only applies if you have enabled
verbose mac80211 station stats.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/debugfs_sta.c |  4 ++++
 net/mac80211/ieee80211_i.h |  5 +++++
 net/mac80211/rx.c          | 39 +++++++++++++++++++++++++++++++++-----
 net/mac80211/sta_info.c    |  4 ++++
 net/mac80211/sta_info.h    |  4 ++++
 5 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index f29e937aec5c..9dd29fe94bde 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -188,6 +188,10 @@ static ssize_t sta_stats_read(struct file *file, char __user *userbuf,
 	PRINT_MY_STATS("rx-bw-160", rx_stats.msdu_160);
 
 	PRINT_MY_STATS("rx-he-total", rx_stats.msdu_he_tot);
+	PRINT_MY_STATS("rx-he-su", rx_stats.msdu_he_su);
+	PRINT_MY_STATS("rx-he-ext-su", rx_stats.msdu_he_ext_su);
+	PRINT_MY_STATS("rx-he-mu", rx_stats.msdu_he_mu);
+	PRINT_MY_STATS("rx-he-trigger", rx_stats.msdu_he_trigger);
 	PRINT_MY_STATS("rx-vht", rx_stats.msdu_vht);
 	PRINT_MY_STATS("rx-ht", rx_stats.msdu_ht);
 	PRINT_MY_STATS("rx-legacy", rx_stats.msdu_legacy);
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 7951c6377fc8..b75a2ae5f2e9 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -244,6 +244,11 @@ struct ieee80211_rx_data {
 
 	u32 tkip_iv32;
 	u16 tkip_iv16;
+
+#ifdef CONFIG_MAC80211_DEBUG_STA_COUNTERS
+	/* for stats gathering */
+	struct ieee80211_radiotap_he radiotap_he;
+#endif
 };
 
 struct ieee80211_csa_settings {
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 01117e2d1f27..c83428b5bb5a 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -735,8 +735,8 @@ ieee80211_make_monitor_skb(struct ieee80211_local *local,
  * radiotap header the driver might have added.
  */
 static struct sk_buff *
-ieee80211_rx_monitor(struct ieee80211_local *local, struct sk_buff *origskb,
-		     struct ieee80211_rate *rate)
+ieee80211_rx_monitor(struct ieee80211_radiotap_he *radiotap_he, struct ieee80211_local *local,
+		     struct sk_buff *origskb, struct ieee80211_rate *rate)
 {
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(origskb);
 	struct ieee80211_sub_if_data *sdata;
@@ -796,6 +796,19 @@ ieee80211_rx_monitor(struct ieee80211_local *local, struct sk_buff *origskb,
 		return NULL;
 	}
 
+#ifdef CONFIG_MAC80211_DEBUG_STA_COUNTERS
+	if (status->flag & RX_FLAG_RADIOTAP_HE) {
+		/* Store this for later so we can gather stats.
+		 * This depends on drivers putting the radiotap_he header
+		 * on the skb first.  Seems all drivers do at this point.
+		 */
+		struct ieee80211_radiotap_he *he;
+		he = (struct ieee80211_radiotap_he *)(origskb->data + (rtap_space - sizeof(*he)));
+		*radiotap_he = *he;
+	}
+#endif
+
+
 	only_monitor = should_drop_frame(origskb, present_fcs_len, rtap_space);
 
 	if (!local->monitors || (status->flag & RX_FLAG_SKIP_MONITOR)) {
@@ -1763,6 +1776,17 @@ static void ieee80211_update_data_rx_stats(struct ieee80211_rx_data *rx,
 
 	if (status->encoding == RX_ENC_HE) {
 		stats->msdu_he_tot++;
+		if (status->flag & RX_FLAG_RADIOTAP_HE) {
+			u8 he_type = rx->radiotap_he.data1 & 0x3;
+			if (he_type == 0x0)
+				stats->msdu_he_su++;
+			if (he_type == 0x1)
+				stats->msdu_he_ext_su++;
+			if (he_type == 0x2)
+				stats->msdu_he_mu++;
+			if (he_type == 0x3)
+				stats->msdu_he_trigger++;
+		}
 	}
 	else if (status->encoding == RX_ENC_VHT) {
 		stats->msdu_vht++;
@@ -4601,7 +4625,8 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 					 struct ieee80211_sta *pubsta,
 					 struct sk_buff *skb,
-					 struct list_head *list)
+					 struct list_head *list,
+					 struct ieee80211_radiotap_he *radiotap_he)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct ieee80211_sub_if_data *sdata;
@@ -4617,6 +4642,9 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 	rx.skb = skb;
 	rx.local = local;
 	rx.list = list;
+#ifdef CONFIG_MAC80211_DEBUG_STA_COUNTERS
+	rx.radiotap_he = *radiotap_he;
+#endif
 
 	if (ieee80211_is_data(fc) || ieee80211_is_mgmt(fc))
 		I802_DEBUG_INC(local->dot11ReceivedFragmentCount);
@@ -4748,6 +4776,7 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 	struct ieee80211_rate *rate = NULL;
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
+	struct ieee80211_radiotap_he radiotap_he;
 
 	WARN_ON_ONCE(softirq_count() == 0);
 
@@ -4841,13 +4870,13 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 	 * if it was previously present.
 	 * Also, frames with less than 16 bytes are dropped.
 	 */
-	skb = ieee80211_rx_monitor(local, skb, rate);
+	skb = ieee80211_rx_monitor(&radiotap_he, local, skb, rate);
 	if (skb) {
 		ieee80211_tpt_led_trig_rx(local,
 					  ((struct ieee80211_hdr *)skb->data)->frame_control,
 					  skb->len);
 
-		__ieee80211_rx_handle_packet(hw, pubsta, skb, list);
+		__ieee80211_rx_handle_packet(hw, pubsta, skb, list, &radiotap_he);
 	}
 
 	kcov_remote_stop();
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 765993802fec..6dd62ba40133 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2688,6 +2688,10 @@ void sta_accum_rx_stats(struct sta_info *sta,
 		for (i = 0; i<NL80211_RATE_INFO_HE_RU_ALLOC_LAST; i++)
 			rx_stats->msdu_he_ru_alloc[i] += cpurxs->msdu_he_ru_alloc[i];
 		rx_stats->msdu_he_tot += cpurxs->msdu_he_tot;
+		rx_stats->msdu_he_su += cpurxs->msdu_he_su;
+		rx_stats->msdu_he_ext_su += cpurxs->msdu_he_ext_su;
+		rx_stats->msdu_he_mu += cpurxs->msdu_he_mu;
+		rx_stats->msdu_he_trigger += cpurxs->msdu_he_trigger;
 		rx_stats->msdu_vht += cpurxs->msdu_vht;
 		rx_stats->msdu_ht += cpurxs->msdu_ht;
 		rx_stats->msdu_legacy += cpurxs->msdu_legacy;
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index e205a8a06ae7..90fcebf199ad 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -447,6 +447,10 @@ struct ieee80211_sta_rx_stats {
 	u32 msdu_160;
 	u32 msdu_he_ru_alloc[NL80211_RATE_INFO_HE_RU_ALLOC_LAST];
 	u32 msdu_he_tot;
+	u32 msdu_he_su;
+	u32 msdu_he_ext_su;
+	u32 msdu_he_mu;
+	u32 msdu_he_trigger;
 	u32 msdu_vht;
 	u32 msdu_ht;
 	u32 msdu_legacy;
-- 
2.20.1

