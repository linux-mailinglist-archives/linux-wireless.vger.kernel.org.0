Return-Path: <linux-wireless+bounces-12707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 272F997240C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 23:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9B0284CE3
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 21:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEA36AB8;
	Mon,  9 Sep 2024 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="sRb8WtUF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E22582
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725915634; cv=none; b=API9pw9PbxpIqaNrwUuX8s4TDyNn9tlIuB5JNch+jJ+H1E+tLXTpiKZ29ysOxcoZVvC4IIDt97wP8e37p4CR6fxeWUUMr9z8uzxt4o817GRus/+y6FuOzs8IRJEoKKhJa9w5vz/tsYMLUm8BOQpxFZF8JDvUfINqW6riFXll94g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725915634; c=relaxed/simple;
	bh=DMexNx2oo/sg9N07jSTqgnFIqkISz9fqh8a7cQcikD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b54SLNOU1vQX0K+aLpSr7PZTRn/vS2+0nkG5XPlgJhQo86uoFROl69eiAb4cvN7OoZT7NJeb4VvFiDOXkzcCFSd6C+kGM7iLHLNXxVbXhLYKYypm708zxJdvgRm70BcrNCqrWIIjM7KvMYs0qL0TBPKG/lCDrY+owanZ6Vx048c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=sRb8WtUF; arc=none smtp.client-ip=67.231.154.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E2CB4303DA1
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 21:00:30 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id AEC373C0085
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 21:00:22 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id DC60013C2B0;
	Mon,  9 Sep 2024 14:00:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com DC60013C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1725915622;
	bh=DMexNx2oo/sg9N07jSTqgnFIqkISz9fqh8a7cQcikD8=;
	h=From:To:Cc:Subject:Date:From;
	b=sRb8WtUFl5cNYNhuM5bq7CMtW2ZG0EVTDOT3P3Uw/++q4vJG7ysH6pWahpZl7oJxp
	 xsCZoyQ/wNKYbAdZmyT6yAcdyG5SoRd4fksufpOWAWtJSAliH0khLeeijzBPmCFrG3
	 TxIW83kofWMoP+W+nD9LV+YrP1MQ2m/OxoD1uJkI=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH 1/2] wifi: mac80211: Assign tx-stats to the proper link.
Date: Mon,  9 Sep 2024 14:00:16 -0700
Message-ID: <20240909210017.3228400-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1725915623-tDk3Uyptq0Ms
X-MDID-O:
 us5;at1;1725915623;tDk3Uyptq0Ms;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

For drivers that can report the tx link-id, account tx
stats against that link.  If we cannot determine tx link,
then use deflink.

If mac80211 sets the link-id, and driver does not change that
value, then the tx-stats will be applied against the link-id
set by mac80211.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 include/net/mac80211.h |  2 ++
 net/mac80211/status.c  | 82 ++++++++++++++++++++++++++++--------------
 2 files changed, 58 insertions(+), 26 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 0a04eaf5343c..49d4f3c4faa3 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1320,6 +1320,7 @@ struct ieee80211_rate_status {
  * @info: Basic tx status information
  * @skb: Packet skb (can be NULL if not provided by the driver)
  * @rates: Mrr stages that were used when sending the packet
+ * @link_sta: link that attempted to transmit the skb
  * @n_rates: Number of mrr stages (count of instances for @rates)
  * @free_list: list where processed skbs are stored to be free'd by the driver
  * @ack_hwtstamp: Hardware timestamp of the received ack in nanoseconds
@@ -1331,6 +1332,7 @@ struct ieee80211_tx_status {
 	struct ieee80211_tx_info *info;
 	struct sk_buff *skb;
 	struct ieee80211_rate_status *rates;
+	struct link_sta_info *link_sta;
 	ktime_t ack_hwtstamp;
 	u8 n_rates;
 
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index dd8f857a1fbc..a01900bf73bd 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -41,13 +41,35 @@ void ieee80211_tx_status_irqsafe(struct ieee80211_hw *hw,
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
-					    struct sk_buff *skb)
+					    struct sk_buff *skb,
+					    struct ieee80211_tx_status *status)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	int ac;
+	struct link_sta_info *link_sta = status->link_sta;
 
 	if (info->flags & (IEEE80211_TX_CTL_NO_PS_BUFFER |
 			   IEEE80211_TX_CTL_AMPDU |
@@ -72,7 +94,7 @@ static void ieee80211_handle_filtered_frame(struct ieee80211_local *local,
 	info->flags |= IEEE80211_TX_INTFL_RETRANSMISSION;
 	info->flags &= ~IEEE80211_TX_TEMPORARY_FLAGS;
 
-	sta->deflink.status_stats.filtered++;
+	link_sta->status_stats.filtered++;
 
 	/*
 	 * Clear more-data bit on filtered frames, it might be set
@@ -822,10 +844,12 @@ static void ieee80211_report_used_skb(struct ieee80211_local *local,
 #define STA_LOST_TDLS_PKT_TIME		(10*HZ) /* 10secs since last ACK */
 
 static void ieee80211_lost_packet(struct sta_info *sta,
-				  struct ieee80211_tx_info *info)
+				  struct ieee80211_tx_info *info,
+				  struct ieee80211_tx_status *status)
 {
 	unsigned long pkt_time = STA_LOST_PKT_TIME;
 	unsigned int pkt_thr = STA_LOST_PKT_THRESHOLD;
+	struct link_sta_info *link_sta = status->link_sta;
 
 	/* If driver relies on its own algorithm for station kickout, skip
 	 * mac80211 packet loss mechanism.
@@ -838,7 +862,7 @@ static void ieee80211_lost_packet(struct sta_info *sta,
 	    !(info->flags & IEEE80211_TX_STAT_AMPDU))
 		return;
 
-	sta->deflink.status_stats.lost_packets++;
+	link_sta->status_stats.lost_packets++;
 	if (sta->sta.tdls) {
 		pkt_time = STA_LOST_TDLS_PKT_TIME;
 		pkt_thr = STA_LOST_PKT_THRESHOLD;
@@ -851,14 +875,14 @@ static void ieee80211_lost_packet(struct sta_info *sta,
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
@@ -970,6 +994,8 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 	fc = hdr->frame_control;
 
 	if (status->sta) {
+		struct link_sta_info *link_sta = status->link_sta;
+
 		sta = container_of(status->sta, struct sta_info, sta);
 
 		if (info->flags & IEEE80211_TX_STATUS_EOSP)
@@ -988,7 +1014,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 		if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL) &&
 		    (ieee80211_is_data(hdr->frame_control)) &&
 		    (rates_idx != -1))
-			sta->deflink.tx_stats.last_rate =
+			link_sta->tx_stats.last_rate =
 				info->status.rates[rates_idx];
 
 		if ((info->flags & IEEE80211_TX_STAT_AMPDU_NO_BACK) &&
@@ -1030,13 +1056,13 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 		}
 
 		if (info->flags & IEEE80211_TX_STAT_TX_FILTERED) {
-			ieee80211_handle_filtered_frame(local, sta, skb);
+			ieee80211_handle_filtered_frame(local, sta, skb, status);
 			return;
 		} else if (ieee80211_is_data_present(fc)) {
 			if (!acked && !noack_success)
-				sta->deflink.status_stats.msdu_failed[tid]++;
+				link_sta->status_stats.msdu_failed[tid]++;
 
-			sta->deflink.status_stats.msdu_retries[tid] +=
+			link_sta->status_stats.msdu_retries[tid] +=
 				retry_count;
 		}
 
@@ -1144,12 +1170,17 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 	int rates_idx, retry_count;
 	bool acked, noack_success, ack_signal_valid;
 	u16 tx_time_est;
+	struct link_sta_info *link_sta = status->link_sta;
 
 	if (pubsta) {
 		sta = container_of(pubsta, struct sta_info, sta);
+		if (!link_sta) {
+			link_sta = ieee80211_get_tx_link_sta(sta, info);
+			status->link_sta = link_sta;
+		}
 
 		if (status->n_rates)
-			sta->deflink.tx_stats.last_rate_info =
+			link_sta->tx_stats.last_rate_info =
 				status->rates[status->n_rates - 1].rate_idx;
 	}
 
@@ -1179,8 +1210,8 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 		struct ieee80211_sub_if_data *sdata = sta->sdata;
 
 		if (!acked && !noack_success)
-			sta->deflink.status_stats.retry_failed++;
-		sta->deflink.status_stats.retry_count += retry_count;
+			link_sta->status_stats.retry_failed++;
+		link_sta->status_stats.retry_count += retry_count;
 
 		if (ieee80211_hw_check(&local->hw, REPORTS_TX_ACK_STATUS)) {
 			if (sdata->vif.type == NL80211_IFTYPE_STATION &&
@@ -1189,13 +1220,11 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 							acked, info->status.tx_time);
 
 			if (acked) {
-				sta->deflink.status_stats.last_ack = jiffies;
-
-				if (sta->deflink.status_stats.lost_packets)
-					sta->deflink.status_stats.lost_packets = 0;
+				link_sta->status_stats.last_ack = jiffies;
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
@@ -1215,12 +1244,12 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 				 * that this TX packet failed because of that.
 				 */
 				if (skb)
-					ieee80211_handle_filtered_frame(local, sta, skb);
+					ieee80211_handle_filtered_frame(local, sta, skb, status);
 				return;
 			} else if (noack_success) {
 				/* nothing to do here, do not account as lost */
 			} else {
-				ieee80211_lost_packet(sta, info);
+				ieee80211_lost_packet(sta, info, status);
 			}
 		}
 
@@ -1266,12 +1295,13 @@ void ieee80211_tx_rate_update(struct ieee80211_hw *hw,
 	struct ieee80211_tx_status status = {
 		.info = info,
 		.sta = pubsta,
+		.link_sta = ieee80211_get_tx_link_sta(sta, info),
 	};
 
 	rate_control_tx_status(local, &status);
 
 	if (ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL))
-		sta->deflink.tx_stats.last_rate = info->status.rates[0];
+		status.link_sta->tx_stats.last_rate = info->status.rates[0];
 }
 EXPORT_SYMBOL(ieee80211_tx_rate_update);
 
-- 
2.42.0


