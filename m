Return-Path: <linux-wireless+bounces-16557-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7389F70BD
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 00:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 693B27A3826
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 23:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366E91FCFFC;
	Wed, 18 Dec 2024 23:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="q+ALCjZt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183F01991B8
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 23:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734564336; cv=none; b=V3e1eM4ngnSIreNkHds+6GfRw9KUgMDS9AV1E6j/9BTx/Qu377/AQj7OlP19kQHF4gmfQQ0ft02moJ3RISKq1gjOft2725DJF4tyboxwJjVHas45ALFlta1wiBaMGq3qXUUoQDITMB5LnI8ooH0BZfbZYXZg2MxBWg3wNtCZ1lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734564336; c=relaxed/simple;
	bh=68JsRVUFcCE6A7IEnSvr1Ic79/1RnHRKB4vIHDuFer4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGve4NPzl1Qgnqii6tZo5/RuocIo9KEO5vwdH1g1TxTAbMRPmpdq6tTWuoi5zG5P6nsl1J2I7BTG+GYLCLA8jKmIxtmPP05cd/XY68b0t+BZcy0QMf3KuCIxQJYKTeOgMB+wK+rFGrXKMDLtkfjgf7faXDEudnhGdi5Q67zQr40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=q+ALCjZt; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 8CA40C0067
	for <linux-wireless@vger.kernel.org>; Wed, 18 Dec 2024 23:25:26 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 22AD813C2B0;
	Wed, 18 Dec 2024 15:25:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 22AD813C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1734564326;
	bh=68JsRVUFcCE6A7IEnSvr1Ic79/1RnHRKB4vIHDuFer4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q+ALCjZtyCMm1uqmfpu+jSix1KrsQD0yal2sgC74myonHRQ3vfeAp8ofV2d5qlCkY
	 yfkevX1PKhtRexdrBy8Kq1xQgU1U0xeUhmEYNwnPeCd1L6XFZ26Jm+o8Y1+YE3lPBN
	 yz0kiGdXI+rB34eVB9iYEMY76CLGDVUhztA7AEfc=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH v5 3/3] wifi: mac80211: Clarify per-link tx stats.
Date: Wed, 18 Dec 2024 15:25:19 -0800
Message-ID: <20241218232519.3156080-3-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241218232519.3156080-1-greearb@candelatech.com>
References: <20241218232519.3156080-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1734564327-ooKVwP8kUtwv
X-MDID-O:
 us5;ut7;1734564327;ooKVwP8kUtwv;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Ben Greear <greearb@candelatech.com>

In the tx path, deflink tx stats are increased for the packets
requested to be transmitted.  At that point, we cannot know the
actual link that will be used to transmit.  Rename those stats with
req_ prefix to show they are requested.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/sta_info.c |  6 +++---
 net/mac80211/sta_info.h |  8 +++++---
 net/mac80211/tx.c       | 20 ++++++++++----------
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index aa22f09e6d14..c8c64271eb26 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2522,7 +2522,7 @@ static void sta_set_tidstats(struct sta_info *sta,
 
 	if (!(tidstats->filled & BIT(NL80211_TID_STATS_TX_MSDU))) {
 		tidstats->filled |= BIT(NL80211_TID_STATS_TX_MSDU);
-		tidstats->tx_msdu = sta->deflink.tx_stats.msdu[tid];
+		tidstats->tx_msdu = sta->deflink.tx_stats.req_msdu[tid];
 	}
 
 	if (!(tidstats->filled & BIT(NL80211_TID_STATS_TX_MSDU_RETRIES)) &&
@@ -2606,14 +2606,14 @@ void sta_set_sinfo(struct sta_info *sta, struct station_info *sinfo,
 			       BIT_ULL(NL80211_STA_INFO_TX_BYTES)))) {
 		sinfo->tx_bytes = 0;
 		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
-			sinfo->tx_bytes += sta->deflink.tx_stats.bytes[ac];
+			sinfo->tx_bytes += sta->deflink.tx_stats.req_bytes[ac];
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES64);
 	}
 
 	if (!(sinfo->filled & BIT_ULL(NL80211_STA_INFO_TX_PACKETS))) {
 		sinfo->tx_packets = 0;
 		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
-			sinfo->tx_packets += sta->deflink.tx_stats.packets[ac];
+			sinfo->tx_packets += sta->deflink.tx_stats.req_packets[ac];
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
 	}
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index fc59e6410082..40179a9ec0bc 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -553,14 +553,16 @@ struct link_sta_info {
 
 	/* Updated from TX path only, no locking requirements */
 	struct {
-		u64 packets[IEEE80211_NUM_ACS];
-		u64 bytes[IEEE80211_NUM_ACS];
+		/* Packets and bytes requested to be transmitted, deflink only */
+		u64 req_packets[IEEE80211_NUM_ACS];
+		u64 req_bytes[IEEE80211_NUM_ACS];
 		/* Packets and bytes reported transmitted (per link) */
 		u64 rep_packets;
 		u64 rep_bytes;
 		struct ieee80211_tx_rate last_rate;
 		struct rate_info last_rate_info;
-		u64 msdu[IEEE80211_NUM_TIDS + 1];
+		/* Requested to be transmitted */
+		u64 req_msdu[IEEE80211_NUM_TIDS + 1];
 	} tx_stats;
 
 	enum ieee80211_sta_rx_bandwidth cur_max_bandwidth;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a24636bda679..ab89dac99cf5 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -866,7 +866,7 @@ ieee80211_tx_h_sequence(struct ieee80211_tx_data *tx)
 		hdr->seq_ctrl = cpu_to_le16(tx->sdata->sequence_number);
 		tx->sdata->sequence_number += 0x10;
 		if (tx->sta)
-			tx->sta->deflink.tx_stats.msdu[IEEE80211_NUM_TIDS]++;
+			tx->sta->deflink.tx_stats.req_msdu[IEEE80211_NUM_TIDS]++;
 		return TX_CONTINUE;
 	}
 
@@ -880,7 +880,7 @@ ieee80211_tx_h_sequence(struct ieee80211_tx_data *tx)
 
 	/* include per-STA, per-TID sequence counter */
 	tid = ieee80211_get_tid(hdr);
-	tx->sta->deflink.tx_stats.msdu[tid]++;
+	tx->sta->deflink.tx_stats.req_msdu[tid]++;
 
 	hdr->seq_ctrl = ieee80211_tx_next_seq(tx->sta, tid);
 
@@ -1033,10 +1033,10 @@ ieee80211_tx_h_stats(struct ieee80211_tx_data *tx)
 
 	skb_queue_walk(&tx->skbs, skb) {
 		ac = skb_get_queue_mapping(skb);
-		tx->sta->deflink.tx_stats.bytes[ac] += skb->len;
+		tx->sta->deflink.tx_stats.req_bytes[ac] += skb->len;
 	}
 	if (ac >= 0)
-		tx->sta->deflink.tx_stats.packets[ac]++;
+		tx->sta->deflink.tx_stats.req_packets[ac]++;
 
 	return TX_CONTINUE;
 }
@@ -3575,18 +3575,18 @@ ieee80211_xmit_fast_finish(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (skb_shinfo(skb)->gso_size)
-		sta->deflink.tx_stats.msdu[tid] +=
+		sta->deflink.tx_stats.req_msdu[tid] +=
 			DIV_ROUND_UP(skb->len, skb_shinfo(skb)->gso_size);
 	else
-		sta->deflink.tx_stats.msdu[tid]++;
+		sta->deflink.tx_stats.req_msdu[tid]++;
 
 	info->hw_queue = sdata->vif.hw_queue[skb_get_queue_mapping(skb)];
 
 	/* statistics normally done by ieee80211_tx_h_stats (but that
 	 * has to consider fragmentation, so is more complex)
 	 */
-	sta->deflink.tx_stats.bytes[skb_get_queue_mapping(skb)] += skb->len;
-	sta->deflink.tx_stats.packets[skb_get_queue_mapping(skb)]++;
+	sta->deflink.tx_stats.req_bytes[skb_get_queue_mapping(skb)] += skb->len;
+	sta->deflink.tx_stats.req_packets[skb_get_queue_mapping(skb)]++;
 
 	if (pn_offs) {
 		u64 pn;
@@ -4672,8 +4672,8 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	}
 
 	dev_sw_netstats_tx_add(dev, skbs, len);
-	sta->deflink.tx_stats.packets[queue] += skbs;
-	sta->deflink.tx_stats.bytes[queue] += len;
+	sta->deflink.tx_stats.req_packets[queue] += skbs;
+	sta->deflink.tx_stats.req_bytes[queue] += len;
 
 	ieee80211_tpt_led_trig_tx(local, len);
 
-- 
2.42.0


