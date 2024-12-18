Return-Path: <linux-wireless+bounces-16556-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 954509F70BC
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 00:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89A916DD9E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 23:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7978B1FCF53;
	Wed, 18 Dec 2024 23:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="b8LXrD/I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4431FCCF7
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 23:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734564335; cv=none; b=PiTX50e0/PVuruk5uhT3xYzgdQO3lVsjcz0tqnQwlJ1cv7feYHKozVtZ1aNmb9OLRhv+CYK89s4Qw+nrzOD+MwnVJ1Ipi8CB/k3Ba41AtQyssLfDE+yRkRne+zaz5T5HA8VfqRRGWPsrUC8BfXBUajqzwqjl6oISGY5XFls25Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734564335; c=relaxed/simple;
	bh=pZ0jg0R92W9XKygxCZtaDTn61pWQli9rrgAw/YbGiFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BM2MC5vvZKexMn9v2V+cYh/SaWA38RsjsFWCGARUqokZgU3kSG35GIvMLUUtNW+DkO6cZovRu3k0RiCjNOAZIQrJL/DaqRy6xZoWi6nYH+5kib2lS4Yv2qaKPPohg196xjTGF+YmGY5CZ05CRsSNzuWS4hohvoVUuEghcYLRTSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=b8LXrD/I; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 96C0BC4005D
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 23:25:24 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 169F413C2B0;
	Wed, 18 Dec 2024 15:25:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 169F413C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1734564324;
	bh=pZ0jg0R92W9XKygxCZtaDTn61pWQli9rrgAw/YbGiFg=;
	h=From:To:Cc:Subject:Date:From;
	b=b8LXrD/ILQb+c5hpFI6ihSUjvN0RyV9DlepXtU25XZX0DfEo+7YDqi2hPU8I+HtgO
	 OkmjZleznmO5X3Noj15hYsH3DdBRmfrCskC2ZCi3OnkqCFFqqDCyy/cDrvMywmwMWp
	 6g3bZ+1Z0ZeXBf4Oj+p9CQN2ELN+Ggqeee0pdiA8=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH v5 1/3] wifi: mac80211: Assign tx-stats to the proper link.
Date: Wed, 18 Dec 2024 15:25:17 -0800
Message-ID: <20241218232519.3156080-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1734564325-Q7ZrrUqpyDmw
X-MDID-O:
 us5;ut7;1734564325;Q7ZrrUqpyDmw;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Ben Greear <greearb@candelatech.com>

For drivers that can report the tx link-id, account tx
stats against that link.  If we cannot determine tx link,
then use deflink.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

v5:  Properly increment tx pkt and bytes counters per-link, add
     optional 3/3 patch to make it more clear requested vs actual
     tx packet counters.
v4:  Reorder patches, use new tx_link_id status field 4 bits wide.

 include/net/mac80211.h  |  4 ++-
 net/mac80211/sta_info.h |  3 ++
 net/mac80211/status.c   | 79 ++++++++++++++++++++++++++++++-----------
 3 files changed, 64 insertions(+), 22 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ab8dce1f2c27..19d3b0517dcd 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1276,7 +1276,9 @@ struct ieee80211_tx_info {
 			u8 ampdu_ack_len;
 			u8 ampdu_len;
 			u8 antenna;
-			u8 pad;
+			/* link ID which transmitted + 1 (0 means default or unknown) */
+			u8 tx_link_id:4;
+			u8 pad:4;
 			u16 tx_time;
 			u8 flags;
 			u8 pad2;
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 9f89fb5bee37..fc59e6410082 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -555,6 +555,9 @@ struct link_sta_info {
 	struct {
 		u64 packets[IEEE80211_NUM_ACS];
 		u64 bytes[IEEE80211_NUM_ACS];
+		/* Packets and bytes reported transmitted (per link) */
+		u64 rep_packets;
+		u64 rep_bytes;
 		struct ieee80211_tx_rate last_rate;
 		struct rate_info last_rate_info;
 		u64 msdu[IEEE80211_NUM_TIDS + 1];
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index 5f28f3633fa0..c46fd6ea2873 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -41,6 +41,26 @@ void ieee80211_tx_status_irqsafe(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_tx_status_irqsafe);
 
+static struct link_sta_info*
+ieee80211_get_tx_link_sta(struct sta_info *sta, struct ieee80211_tx_info *info)
+{
+	int link_id = 0;
+	struct link_sta_info *link_sta;
+
+	if (!sta)
+		return NULL;
+
+	if (info)
+		link_id = info->status.tx_link_id;
+
+	if (link_id) {
+		link_sta = rcu_access_pointer(sta->link[link_id - 1]);
+		if (link_sta)
+			return link_sta;
+	}
+	return &sta->deflink;
+}
+
 static void ieee80211_handle_filtered_frame(struct ieee80211_local *local,
 					    struct sta_info *sta,
 					    struct sk_buff *skb)
@@ -48,6 +68,7 @@ static void ieee80211_handle_filtered_frame(struct ieee80211_local *local,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	int ac;
+	struct link_sta_info *link_sta = ieee80211_get_tx_link_sta(sta, info);
 
 	if (info->flags & (IEEE80211_TX_CTL_NO_PS_BUFFER |
 			   IEEE80211_TX_CTL_AMPDU |
@@ -72,7 +93,7 @@ static void ieee80211_handle_filtered_frame(struct ieee80211_local *local,
 	info->flags |= IEEE80211_TX_INTFL_RETRANSMISSION;
 	info->flags &= ~IEEE80211_TX_TEMPORARY_FLAGS;
 
-	sta->deflink.status_stats.filtered++;
+	link_sta->status_stats.filtered++;
 
 	/*
 	 * Clear more-data bit on filtered frames, it might be set
@@ -826,6 +847,7 @@ static void ieee80211_lost_packet(struct sta_info *sta,
 {
 	unsigned long pkt_time = STA_LOST_PKT_TIME;
 	unsigned int pkt_thr = STA_LOST_PKT_THRESHOLD;
+	struct link_sta_info *link_sta;
 
 	/* If driver relies on its own algorithm for station kickout, skip
 	 * mac80211 packet loss mechanism.
@@ -838,7 +860,8 @@ static void ieee80211_lost_packet(struct sta_info *sta,
 	    !(info->flags & IEEE80211_TX_STAT_AMPDU))
 		return;
 
-	sta->deflink.status_stats.lost_packets++;
+	link_sta = ieee80211_get_tx_link_sta(sta, info);
+	link_sta->status_stats.lost_packets++;
 	if (sta->sta.tdls) {
 		pkt_time = STA_LOST_TDLS_PKT_TIME;
 		pkt_thr = STA_LOST_PKT_THRESHOLD;
@@ -851,14 +874,14 @@ static void ieee80211_lost_packet(struct sta_info *sta,
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
@@ -973,8 +996,12 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 	fc = hdr->frame_control;
 
 	if (status->sta) {
+		struct link_sta_info *link_sta;
+
 		sta = container_of(status->sta, struct sta_info, sta);
 
+		link_sta = ieee80211_get_tx_link_sta(sta, info);
+
 		if (info->flags & IEEE80211_TX_STATUS_EOSP)
 			clear_sta_flag(sta, WLAN_STA_SP);
 
@@ -991,7 +1018,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 		if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL) &&
 		    (ieee80211_is_data(hdr->frame_control)) &&
 		    (rates_idx != -1))
-			sta->deflink.tx_stats.last_rate =
+			link_sta->tx_stats.last_rate =
 				info->status.rates[rates_idx];
 
 		if ((info->flags & IEEE80211_TX_STAT_AMPDU_NO_BACK) &&
@@ -1037,12 +1064,17 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 			return;
 		} else if (ieee80211_is_data_present(fc)) {
 			if (!acked && !noack_success)
-				sta->deflink.status_stats.msdu_failed[tid]++;
+				link_sta->status_stats.msdu_failed[tid]++;
 
-			sta->deflink.status_stats.msdu_retries[tid] +=
+			link_sta->status_stats.msdu_retries[tid] +=
 				retry_count;
 		}
 
+		if (acked || noack_success) {
+			link_sta->tx_stats.rep_packets++;
+			link_sta->tx_stats.rep_bytes += skb->len;
+		}
+
 		if (!(info->flags & IEEE80211_TX_CTL_INJECTED) && acked)
 			ieee80211_frame_acked(sta, skb);
 
@@ -1147,12 +1179,15 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
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
 
@@ -1182,8 +1217,8 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 		struct ieee80211_sub_if_data *sdata = sta->sdata;
 
 		if (!acked && !noack_success)
-			sta->deflink.status_stats.retry_failed++;
-		sta->deflink.status_stats.retry_count += retry_count;
+			link_sta->status_stats.retry_failed++;
+		link_sta->status_stats.retry_count += retry_count;
 
 		if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
 			if (sdata->vif.type == NL80211_IFTYPE_STATION &&
@@ -1192,13 +1227,12 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 							acked, info->status.tx_time);
 
 			if (acked) {
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
@@ -1206,10 +1240,10 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
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
@@ -1273,8 +1307,11 @@ void ieee80211_tx_rate_update(struct ieee80211_hw *hw,
 
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


