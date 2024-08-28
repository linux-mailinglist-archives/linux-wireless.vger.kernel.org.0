Return-Path: <linux-wireless+bounces-12179-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D9A962D0D
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 17:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9669E282B78
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 15:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F5E1A2C02;
	Wed, 28 Aug 2024 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="B86xvkiN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA82C1A0718
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 15:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724860514; cv=none; b=tMRTweeP+qgnFv2m57e2tfnAW108/+yuVIE7OOWXEr9CNYJ6XLr9s/DmWv6jgIXJrf2QlH/P7x6iVB+5Mx8YhZbVqcTTPzBK24rlIeQGMIy8LwFAdpgwNCGJVav2qhEEL1Z8sE/SNymyI0XhYAsRVvCyZlPiH33N+KmjAmQ5AmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724860514; c=relaxed/simple;
	bh=wXKcKGYsjX99JuCAJGRTlWp9N4PsOOawC2zwGIkWZxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n/qY2FUiV1oOgXtM/m3xKd0xkrVuv486/Ojjx3mG+K0ArMtB9CnjFyjTNlqqzLehXn5TNhcEvzo7ojs+H4aTCvZW3aLO4uB783/Q8q+BGSuSsly5NW8uGMaG42hfhiWgLugCnfAeq+6oXGlOQdas6utkhS3ytPC5MciyLPnwnII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=B86xvkiN; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 264CB2C0066
	for <linux-wireless@vger.kernel.org>; Wed, 28 Aug 2024 15:55:04 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 61AA913C2B1;
	Wed, 28 Aug 2024 08:55:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 61AA913C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1724860503;
	bh=wXKcKGYsjX99JuCAJGRTlWp9N4PsOOawC2zwGIkWZxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B86xvkiNd0UYCAMyAaXAIC3AeOHrRuAzgl4zoNqWYQTHPdruN4BVJCN2ckez1xjc1
	 KCAX/WlAqCZTLO2poSiEiCkualwVVIVAcrFwExqJHuY115+HnjTyBEPxnWMZe9Dfaa
	 D/9oDm+O9+4xZgYckBrMHGQh0OQToSowVZ1B3X2g=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [RFC PATCH 2/2] wifi: mac80211:  Assign tx-stats to the proper link.
Date: Wed, 28 Aug 2024 08:54:58 -0700
Message-ID: <20240828155458.1990497-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240828155458.1990497-1-greearb@candelatech.com>
References: <20240828155458.1990497-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1724860504-XNa3fuznqhqD
X-MDID-O:
 us5;at1;1724860504;XNa3fuznqhqD;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

For drivers that can report the tx link-id, account tx
stats against that link.  If we cannot determine tx link,
then use deflink.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

Patch is against my internal tree, won't apply to upstream.  Will port
to upstream once details are ironed out.

 net/mac80211/status.c | 105 +++++++++++++++++++++++++++---------------
 1 file changed, 67 insertions(+), 38 deletions(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 71ef0b7bd9a1..b844d2f207aa 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -41,6 +41,23 @@ void ieee80211_tx_status_irqsafe(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_tx_status_irqsafe);
 
+static struct link_sta_info*
+ieee80211_get_tx_link_sta(struct sta_info *sta, struct ieee80211_tx_info *info)
+{
+	u8 link_id = u32_get_bits(info->control.flags, IEEE80211_TX_CTRL_MLO_LINK);
+	struct link_sta_info *l_sta_info;
+
+	if (!sta)
+		return NULL;
+
+	if (link_id != IEEE80211_LINK_UNSPECIFIED) {
+		l_sta_info = rcu_access_pointer(sta->link[link_id]);
+		if (l_sta_info)
+			return l_sta_info;
+	}
+	return &sta->deflink;
+}
+
 static void ieee80211_handle_filtered_frame(struct ieee80211_local *local,
 					    struct sta_info *sta,
 					    struct sk_buff *skb)
@@ -48,6 +65,7 @@ static void ieee80211_handle_filtered_frame(struct ieee80211_local *local,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	int ac;
+	struct link_sta_info *link_sta = ieee80211_get_tx_link_sta(sta, info);
 
 	if (info->flags & (IEEE80211_TX_CTL_NO_PS_BUFFER |
 			   IEEE80211_TX_CTL_AMPDU |
@@ -72,7 +90,7 @@ static void ieee80211_handle_filtered_frame(struct ieee80211_local *local,
 	info->flags |= IEEE80211_TX_INTFL_RETRANSMISSION;
 	info->flags &= ~IEEE80211_TX_TEMPORARY_FLAGS;
 
-	sta->deflink.status_stats.filtered++;
+	link_sta->status_stats.filtered++;
 
 	/*
 	 * Clear more-data bit on filtered frames, it might be set
@@ -826,6 +844,7 @@ static void ieee80211_lost_packet(struct sta_info *sta,
 {
 	unsigned long pkt_time = STA_LOST_PKT_TIME;
 	unsigned int pkt_thr = STA_LOST_PKT_THRESHOLD;
+	struct link_sta_info *link_sta;
 
 	/* If driver relies on its own algorithm for station kickout, skip
 	 * mac80211 packet loss mechanism.
@@ -838,7 +857,8 @@ static void ieee80211_lost_packet(struct sta_info *sta,
 	    !(info->flags & IEEE80211_TX_STAT_AMPDU))
 		return;
 
-	sta->deflink.status_stats.lost_packets++;
+	link_sta = ieee80211_get_tx_link_sta(sta, info);
+	link_sta->status_stats.lost_packets++;
 	if (sta->sta.tdls) {
 		pkt_time = STA_LOST_TDLS_PKT_TIME;
 		pkt_thr = STA_LOST_PKT_THRESHOLD;
@@ -851,14 +871,14 @@ static void ieee80211_lost_packet(struct sta_info *sta,
 	 * mechanism.
 	 * For non-TDLS, use STA_LOST_PKT_THRESHOLD and STA_LOST_PKT_TIME
 	 */
-	if (sta->deflink.status_stats.lost_packets < pkt_thr ||
-	    !time_after(jiffies, sta->deflink.status_stats.last_pkt_time + pkt_time))
+	if (link_sta->status_stats.lost_packets < pkt_thr ||
+	    !time_after(jiffies, link_sta->status_stats.last_pkt_time + pkt_time))
 		return;
 
 	cfg80211_cqm_pktloss_notify(sta->sdata->dev, sta->sta.addr,
-				    sta->deflink.status_stats.lost_packets,
+				    link_sta->status_stats.lost_packets,
 				    GFP_ATOMIC);
-	sta->deflink.status_stats.lost_packets = 0;
+	link_sta->status_stats.lost_packets = 0;
 }
 
 static int ieee80211_tx_get_rates(struct ieee80211_hw *hw,
@@ -970,8 +990,12 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 	fc = hdr->frame_control;
 
 	if (status->sta) {
+		struct link_sta_info *link_sta;
+
 		sta = container_of(status->sta, struct sta_info, sta);
 
+		link_sta = ieee80211_get_tx_link_sta(sta, info);
+
 		if (info->flags & IEEE80211_TX_STATUS_EOSP)
 			clear_sta_flag(sta, WLAN_STA_SP);
 
@@ -988,7 +1012,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 		if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL) &&
 		    (ieee80211_is_data(hdr->frame_control)) &&
 		    (rates_idx != -1))
-			sta->deflink.tx_stats.last_rate =
+			link_sta->tx_stats.last_rate =
 				info->status.rates[rates_idx];
 
 		if ((info->flags & IEEE80211_TX_STAT_AMPDU_NO_BACK) &&
@@ -1034,9 +1058,9 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 			return;
 		} else if (ieee80211_is_data_present(fc)) {
 			if (!acked && !noack_success)
-				sta->deflink.status_stats.msdu_failed[tid]++;
+				link_sta->status_stats.msdu_failed[tid]++;
 
-			sta->deflink.status_stats.msdu_retries[tid] +=
+			link_sta->status_stats.msdu_retries[tid] +=
 				retry_count;
 		}
 
@@ -1147,12 +1171,15 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 	int rates_idx, retry_count;
 	bool acked, noack_success, ack_signal_valid;
 	u16 tx_time_est;
+	struct link_sta_info *link_sta;
 
 	if (pubsta) {
 		sta = container_of(pubsta, struct sta_info, sta);
 
+		link_sta = ieee80211_get_tx_link_sta(sta, info);
+
 		if (status->n_rates)
-			sta->deflink.tx_stats.last_rate_info =
+			link_sta->tx_stats.last_rate_info =
 				status->rates[status->n_rates - 1].rate_idx;
 	}
 
@@ -1185,8 +1212,8 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 #endif
 
 		if (!acked && !noack_success)
-			sta->deflink.status_stats.retry_failed++;
-		sta->deflink.status_stats.retry_count += retry_count;
+			link_sta->status_stats.retry_failed++;
+		link_sta->status_stats.retry_count += retry_count;
 
 		if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
 			if (sdata->vif.type == NL80211_IFTYPE_STATION &&
@@ -1198,13 +1225,12 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 #ifdef CONFIG_MAC80211_DEBUG_STA_COUNTERS
 				do_stats = true;
 #endif
-				sta->deflink.status_stats.last_ack = jiffies;
+				link_sta->status_stats.last_ack = jiffies;
 
-				if (sta->deflink.status_stats.lost_packets)
-					sta->deflink.status_stats.lost_packets = 0;
+				link_sta->status_stats.lost_packets = 0;
 
 				/* Track when last packet was ACKed */
-				sta->deflink.status_stats.last_pkt_time = jiffies;
+				link_sta->status_stats.last_pkt_time = jiffies;
 
 				/* Reset connection monitor */
 				if (sdata->vif.type == NL80211_IFTYPE_STATION &&
@@ -1212,10 +1238,10 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 					sdata->u.mgd.probe_send_count = 0;
 
 				if (ack_signal_valid) {
-					sta->deflink.status_stats.last_ack_signal =
+					link_sta->status_stats.last_ack_signal =
 							 (s8)info->status.ack_signal;
-					sta->deflink.status_stats.ack_signal_filled = true;
-					ewma_avg_signal_add(&sta->deflink.status_stats.avg_ack_signal,
+					link_sta->status_stats.ack_signal_filled = true;
+					ewma_avg_signal_add(&link_sta->status_stats.avg_ack_signal,
 							    -info->status.ack_signal);
 				}
 			} else if (test_sta_flag(sta, WLAN_STA_PS_STA)) {
@@ -1242,40 +1268,40 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 			u8 mcs = 0;
 			struct ieee80211_tx_rate *txrt = &(info->status.rates[rates_idx]);
 			if (txrt->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
-				sta->deflink.tx_stats.msdu_40++;
+				link_sta->tx_stats.msdu_40++;
 			else if (txrt->flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
-				sta->deflink.tx_stats.msdu_80++;
+				link_sta->tx_stats.msdu_80++;
 			else if (txrt->flags & IEEE80211_TX_RC_160_MHZ_WIDTH)
-				sta->deflink.tx_stats.msdu_160++;
+				link_sta->tx_stats.msdu_160++;
 			else
-				sta->deflink.tx_stats.msdu_20++;
+				link_sta->tx_stats.msdu_20++;
 
 			if (txrt->flags & IEEE80211_TX_RC_MCS) {
 				nss = (txrt->idx / 8);
 				mcs = txrt->idx - (nss * 8);
-				sta->deflink.tx_stats.msdu_ht++;
+				link_sta->tx_stats.msdu_ht++;
 			} else if (txrt->flags & IEEE80211_TX_RC_VHT_MCS) {
 				mcs = ieee80211_rate_get_vht_mcs(txrt);
 				nss = ieee80211_rate_get_vht_nss(txrt);
 				nss -= 1;
-				sta->deflink.tx_stats.msdu_vht++;
+				link_sta->tx_stats.msdu_vht++;
 			} else if (pubsta && status->rates &&
-				 (sta->deflink.tx_stats.last_rate_info.flags & RATE_INFO_FLAGS_HE_MCS)) {
+				 (link_sta->tx_stats.last_rate_info.flags & RATE_INFO_FLAGS_HE_MCS)) {
 				/* get info from status->rate */
-				mcs = sta->deflink.tx_stats.last_rate_info.mcs;
-				nss = sta->deflink.tx_stats.last_rate_info.nss - 1;
-				sta->deflink.tx_stats.msdu_he++;
+				mcs = link_sta->tx_stats.last_rate_info.mcs;
+				nss = link_sta->tx_stats.last_rate_info.nss - 1;
+				link_sta->tx_stats.msdu_he++;
 			} else {
 				mcs = txrt->idx;
-				sta->deflink.tx_stats.msdu_legacy++;
+				link_sta->tx_stats.msdu_legacy++;
 			}
 
-			if (nss > (ARRAY_SIZE(sta->deflink.tx_stats.msdu_nss) - 1))
-				nss = ARRAY_SIZE(sta->deflink.tx_stats.msdu_nss) - 1;
-			if (mcs > (ARRAY_SIZE(sta->deflink.tx_stats.msdu_rate_idx) - 1))
-				mcs = ARRAY_SIZE(sta->deflink.tx_stats.msdu_rate_idx) - 1;
-			sta->deflink.tx_stats.msdu_nss[nss]++;
-			sta->deflink.tx_stats.msdu_rate_idx[mcs]++;
+			if (nss > (ARRAY_SIZE(link_sta->tx_stats.msdu_nss) - 1))
+				nss = ARRAY_SIZE(link_sta->tx_stats.msdu_nss) - 1;
+			if (mcs > (ARRAY_SIZE(link_sta->tx_stats.msdu_rate_idx) - 1))
+				mcs = ARRAY_SIZE(link_sta->tx_stats.msdu_rate_idx) - 1;
+			link_sta->tx_stats.msdu_nss[nss]++;
+			link_sta->tx_stats.msdu_rate_idx[mcs]++;
 		}
 #endif
 
@@ -1326,8 +1352,11 @@ void ieee80211_tx_rate_update(struct ieee80211_hw *hw,
 
 	rate_control_tx_status(local, &status);
 
-	if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL))
-		sta->deflink.tx_stats.last_rate = info->status.rates[0];
+	if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL)) {
+		struct link_sta_info *link_sta = ieee80211_get_tx_link_sta(sta, info);
+
+		link_sta->tx_stats.last_rate = info->status.rates[0];
+	}
 }
 EXPORT_SYMBOL(ieee80211_tx_rate_update);
 
-- 
2.42.0


