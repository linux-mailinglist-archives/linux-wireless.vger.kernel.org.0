Return-Path: <linux-wireless+bounces-13819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0A0997244
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 18:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7518D1C22701
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 16:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05F1149DFD;
	Wed,  9 Oct 2024 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="C7FfJ/p6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CC4143C6C
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728492586; cv=none; b=ufENAoi/jLKKiTChkm85ojE4fO25LohcGUWNQvMvNH26piO5yMo+EJaIyg55g+o6VoEPPwb7WGyLqdxUm190BTH9Mlv1zrHQtTFUXDo9mU2MbcyLa7JgzqsEK8nDJR07kZcsImN9EmLbaIP4k+qJbq9wAUFaYapxYRIRgG9FGbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728492586; c=relaxed/simple;
	bh=3er8MqM8DkzxsfXLN0Q3W6+rE+yUUuQoMMphPG0uJ3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJfX37tPxELB1W4xX4zXD9gCrTnCOI94iYy3AWo/7OQBmBrrWFiwz7DTA1xAn9fIvQMfJynoyP38fRvk8A1NfZ6z91dDH8g3QRvYamPqcC5Z43pvUJoA9WsO3acp2p2UETdb8Gk97KYfI9OCtJ2nvcxXnttCUaZaJU2x0JUtOWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=C7FfJ/p6; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E36BA940079
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 16:49:10 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id 411CE13C2B0;
	Wed,  9 Oct 2024 09:49:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 411CE13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1728492550;
	bh=3er8MqM8DkzxsfXLN0Q3W6+rE+yUUuQoMMphPG0uJ3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C7FfJ/p6x8t7cG7DIPtinmNv6YjiKtU4+kUkGeQ7QBTi79j5uYKUE2tdC+1ySxPtK
	 3CDpDyoSot3N7uDLaqcMWGYP/u+dWpXwWEBcP2291ruw7x1dj+Y8kt3uJCT8rNo5z2
	 uQV7rZDdnmur+pxhZFrAofcAEzEUJLeJaQF193RU=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH v3 2/2] wifi: mac80211: Assign tx-stats to the proper link.
Date: Wed,  9 Oct 2024 09:49:04 -0700
Message-ID: <20241009164904.3906438-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20241009164904.3906438-1-greearb@candelatech.com>
References: <20241009164904.3906438-1-greearb@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1728492583-OVQjzhW_BbLh
X-MDID-O:
 us5;at1;1728492583;OVQjzhW_BbLh;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Ben Greear <greearb@candelatech.com>

For drivers that can report the tx link-id, account tx
stats against that link.  If we cannot determine tx link,
then use deflink.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---

v3:  Rename link_sta_info variable to link_sta to match other code.

 net/mac80211/status.c | 74 +++++++++++++++++++++++++++++++------------
 1 file changed, 53 insertions(+), 21 deletions(-)

diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index b41b867f43b2..28bf3f8a2fb4 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -41,6 +41,26 @@ void ieee80211_tx_status_irqsafe(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_tx_status_irqsafe);
 
+static struct link_sta_info*
+ieee80211_get_tx_link_sta(struct sta_info *sta, struct ieee80211_tx_info *info)
+{
+	u8 link_id = IEEE80211_LINK_UNSPECIFIED;
+	struct link_sta_info *link_sta;
+
+	if (!sta)
+		return NULL;
+
+	if (info)
+		link_id = u32_get_bits(info->control.flags, IEEE80211_TX_CTRL_MLO_LINK);
+
+	if (link_id != IEEE80211_LINK_UNSPECIFIED) {
+		link_sta = rcu_access_pointer(sta->link[link_id]);
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
@@ -970,8 +993,12 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 	fc = hdr->frame_control;
 
 	if (status->sta) {
+		struct link_sta_info *link_sta;
+
 		sta = container_of(status->sta, struct sta_info, sta);
 
+		link_sta = ieee80211_get_tx_link_sta(sta, info);
+
 		if (info->flags & IEEE80211_TX_STATUS_EOSP)
 			clear_sta_flag(sta, WLAN_STA_SP);
 
@@ -988,7 +1015,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 		if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL) &&
 		    (ieee80211_is_data(hdr->frame_control)) &&
 		    (rates_idx != -1))
-			sta->deflink.tx_stats.last_rate =
+			link_sta->tx_stats.last_rate =
 				info->status.rates[rates_idx];
 
 		if ((info->flags & IEEE80211_TX_STAT_AMPDU_NO_BACK) &&
@@ -1034,9 +1061,9 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 			return;
 		} else if (ieee80211_is_data_present(fc)) {
 			if (!acked && !noack_success)
-				sta->deflink.status_stats.msdu_failed[tid]++;
+				link_sta->status_stats.msdu_failed[tid]++;
 
-			sta->deflink.status_stats.msdu_retries[tid] +=
+			link_sta->status_stats.msdu_retries[tid] +=
 				retry_count;
 		}
 
@@ -1144,12 +1171,15 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
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
 
@@ -1179,8 +1209,8 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 		struct ieee80211_sub_if_data *sdata = sta->sdata;
 
 		if (!acked && !noack_success)
-			sta->deflink.status_stats.retry_failed++;
-		sta->deflink.status_stats.retry_count += retry_count;
+			link_sta->status_stats.retry_failed++;
+		link_sta->status_stats.retry_count += retry_count;
 
 		if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
 			if (sdata->vif.type == NL80211_IFTYPE_STATION &&
@@ -1189,13 +1219,12 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
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
@@ -1203,10 +1232,10 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
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
@@ -1270,8 +1299,11 @@ void ieee80211_tx_rate_update(struct ieee80211_hw *hw,
 
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


