Return-Path: <linux-wireless+bounces-31137-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH9dHmXdc2nMzAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31137-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 21:43:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E498E7AB30
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 21:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E4E6302795E
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jan 2026 20:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4052F361A;
	Fri, 23 Jan 2026 20:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T0G+fqC5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498AB2F690F
	for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 20:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769200744; cv=none; b=MkqtgCFSbcnelr4W5d7Z3s4sqHcAIaehkihaFSRVlEVORksM72q8cX/kD8vosqe/AwIuirRKQbDxnW/1IlrNVxffHOP8NlGoEUHjxwcg7zgYWJKJNmAYKs11Pn6RuZOsWq7avUrI+bu9pgKZVthDgQxTrEQZTfFa6crSdSBWWG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769200744; c=relaxed/simple;
	bh=KgGdeSzgMIOPZZ7L41W1PW/HdF8nfGQLQXo6G0TUv4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DE2LWZERUg+u6aSnZ/nh8FGvboArnYlAcf8NBE3Zqo4fRHik8c1iROesq35EUuK4SDx4juZXt37q074NWqD8d5WjyEaYvngeuX/SZdEB6uZ5anEKPLJ8sEU85CcmIj+pfNKc/2NiE7XUql6PZbwkBQD5SmC0xPFg7XDIOluEVSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T0G+fqC5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-352c414bbbeso2533169a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jan 2026 12:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769200742; x=1769805542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UjIu3YoQL2Ii+Wh6+3qxOEv2+5UI6zI1XQ1vy+K6uTw=;
        b=T0G+fqC5eUAEA3mzTzd3ErCNUcluMG2yJ7YSf/MYInViNEQP1V+dTzLN5pEa1IrEUi
         imbGWNfvNYaa1PtSWlQXrdBROpRi7VPWE2F2PiMB3Kz0JGlqTCLfl86Msy6LuPSoDY6j
         4jEzd/iiqS8v2XIehWZwdfAiLtDZGoo75Af27z7Vl7ly/fDLNVpXcecAw74WiUhjn8Q9
         FxmLk8bTbII1X9CFTprGKnim8U2DreaIfwhG6gZ06R1RaMdz7NSRN/gE+QhTTZ1e/Anq
         wArvfaQjhh//JlZy4GmGGSYGPA7l/4hPh+s6MyBsUYlHyEq4/klGElmZoJ1LFHf7lcr6
         CFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769200742; x=1769805542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjIu3YoQL2Ii+Wh6+3qxOEv2+5UI6zI1XQ1vy+K6uTw=;
        b=o7Swzxt7D5PBrSPC8tHWDs04Dgq1HLxj4KSpwboNiMs24wH6kwZr2pJDZu4y+5P2cr
         Unim+ObYOx58kFolhiAjX3/nkNrIz8oYiuSurVxpzYXprhg6RVLdOxb7GFMMAjF8Yox5
         ffrzzGR9nKQ+b2IKF3MaeH1YrZvoDm7B6P/o2JR/bK6j8kA0c2+mEVxaRAlDgjcWxq4B
         mj/jbbFhZ0GY1AF8rUISgaxR1E6f82kKi9u9dMwQz4cJd4SZG4Fe9xPpovuNIQ2gWN87
         UsCGJEE18eUdYVEwzX74upHqhnHNADzY2VQbFBttCH+Wm8hN+9YNNYc7d+RIvsEZkgU3
         5jBg==
X-Gm-Message-State: AOJu0YyX2EJGiWst91ZJ+q6hZjbelzwLuC/9L22yRkHpNWPDMLYffdZH
	xVAIhHJvRHSKAJ9uQt6eUWr1y6UdL5khr0FDHYMmvgEKVkVVVdj8rQcaqkrJow==
X-Gm-Gg: AZuq6aKiBcbDez8vcrjl2Z4527y4c2Oepp4oSWZKaxnXQ2gq0+yIcSVIv6K3WlGkx+T
	b0QlcAfpTPQ4N0ua6/kAnOzuCNZ+cTUCjWkgNYN/vfP60fKk7PXFLMX7UlqrKZIqS08wvDk4KTa
	9A0yfmQ5eEiArmTPMZSdc2Wp49nqM7Axf0wuxRoCE0ZIOnvgrYaxkPw30wKW3kYVyRlwUE4Pgkr
	xntJbrL+plNNz2C5s2vf1Pc5PsgoaEDt3GZGLz+Ns0ycfpfM9y+qeTw5c9L9c7wyxKCripL1Tsp
	Kyzwcb+Oya36cwxyXvr84NU4weS3jaskuVsnYnYIVMQLrcg0iiduY/vyxhQ5Dg4dVygWPZD1ijt
	p8zYUF76nsi4VnXgK1Xvd7OAfJs+Pg/LuNgNUIMCsw9/31LAtqwIkb1uh4YaBJo2weWT72qHzwH
	CfHFAF7BJLKVEXmN/pSkeQDh1aoYDr+nbyTtS6k4j16Yaa7WLxrYvgKw==
X-Received: by 2002:a17:90a:d647:b0:34c:ab9b:76c4 with SMTP id 98e67ed59e1d1-3536a984e8bmr2903920a91.0.1769200742319;
        Fri, 23 Jan 2026 12:39:02 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536f25c4c5sm1300810a91.6.2026.01.23.12.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 12:39:01 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next] wifi: mac80211: use u64_stats_t with u64_stats_sync properly
Date: Sat, 24 Jan 2026 04:38:40 +0800
Message-ID: <20260123203845.2915525-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,sipsolutions.net,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-31137-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: E498E7AB30
X-Rspamd-Action: no action

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. Convert to u64_stats_t to ensure atomic
operations.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 net/mac80211/rx.c       |  8 ++++----
 net/mac80211/sta_info.c | 22 +++++++++++++++++-----
 net/mac80211/sta_info.h |  4 ++--
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index e0ccd9749853..577c505a5d10 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1880,7 +1880,7 @@ ieee80211_rx_h_sta_process(struct ieee80211_rx_data *rx)
 	link_sta->rx_stats.fragments++;
 
 	u64_stats_update_begin(&link_sta->rx_stats.syncp);
-	link_sta->rx_stats.bytes += rx->skb->len;
+	u64_stats_add(&link_sta->rx_stats.bytes, rx->skb->len);
 	u64_stats_update_end(&link_sta->rx_stats.syncp);
 
 	if (!(status->flag & RX_FLAG_NO_SIGNAL_VAL)) {
@@ -2777,7 +2777,7 @@ ieee80211_deliver_skb(struct ieee80211_rx_data *rx)
 		 * frame, so count MSDUs.
 		 */
 		u64_stats_update_begin(&rx->link_sta->rx_stats.syncp);
-		rx->link_sta->rx_stats.msdu[rx->seqno_idx]++;
+		u64_stats_inc(&rx->link_sta->rx_stats.msdu[rx->seqno_idx]);
 		u64_stats_update_end(&rx->link_sta->rx_stats.syncp);
 	}
 
@@ -4868,8 +4868,8 @@ static void ieee80211_rx_8023(struct ieee80211_rx_data *rx,
 	 * frame, so count MSDUs.
 	 */
 	u64_stats_update_begin(&stats->syncp);
-	stats->msdu[rx->seqno_idx]++;
-	stats->bytes += orig_len;
+	u64_stats_inc(&stats->msdu[rx->seqno_idx]);
+	u64_stats_add(&stats->bytes, orig_len);
 	u64_stats_update_end(&stats->syncp);
 
 	if (fast_rx->internal_forward) {
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 1a995bc301b1..22e8561ad6fc 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -360,7 +360,9 @@ static void sta_accumulate_removed_link_stats(struct sta_info *sta, int link_id)
 	struct link_sta_info *link_sta = wiphy_dereference(sta->local->hw.wiphy,
 							   sta->link[link_id]);
 	struct ieee80211_link_data *link;
+	unsigned int start;
 	int ac, tid;
+	u64 value;
 	u32 thr;
 
 	for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
@@ -369,8 +371,13 @@ static void sta_accumulate_removed_link_stats(struct sta_info *sta, int link_id)
 		sta->rem_link_stats.tx_bytes += link_sta->tx_stats.bytes[ac];
 	}
 
+	do {
+		start = u64_stats_fetch_begin(&link_sta->rx_stats.syncp);
+		value = u64_stats_read(&link_sta->rx_stats.bytes);
+	} while (u64_stats_fetch_retry(&link_sta->rx_stats.syncp, start));
+
 	sta->rem_link_stats.rx_packets += link_sta->rx_stats.packets;
-	sta->rem_link_stats.rx_bytes += link_sta->rx_stats.bytes;
+	sta->rem_link_stats.rx_bytes += value;
 	sta->rem_link_stats.tx_retries += link_sta->status_stats.retry_count;
 	sta->rem_link_stats.tx_failed += link_sta->status_stats.retry_failed;
 	sta->rem_link_stats.rx_dropped_misc += link_sta->rx_stats.dropped;
@@ -380,8 +387,13 @@ static void sta_accumulate_removed_link_stats(struct sta_info *sta, int link_id)
 		sta->rem_link_stats.expected_throughput += thr;
 
 	for (tid = 0; tid < IEEE80211_NUM_TIDS; tid++) {
-		sta->rem_link_stats.pertid_stats.rx_msdu +=
-			link_sta->rx_stats.msdu[tid];
+		do {
+			start = u64_stats_fetch_begin(&link_sta->rx_stats.syncp);
+			value = u64_stats_read(&link_sta->rx_stats.msdu[tid]);
+		} while (u64_stats_fetch_retry(&link_sta->rx_stats.syncp,
+					       start));
+
+		sta->rem_link_stats.pertid_stats.rx_msdu += value;
 		sta->rem_link_stats.pertid_stats.tx_msdu +=
 			link_sta->tx_stats.msdu[tid];
 		sta->rem_link_stats.pertid_stats.tx_msdu_retries +=
@@ -2578,7 +2590,7 @@ static inline u64 sta_get_tidstats_msdu(struct ieee80211_sta_rx_stats *rxstats,
 
 	do {
 		start = u64_stats_fetch_begin(&rxstats->syncp);
-		value = rxstats->msdu[tid];
+		value = u64_stats_read(&rxstats->msdu[tid]);
 	} while (u64_stats_fetch_retry(&rxstats->syncp, start));
 
 	return value;
@@ -2654,7 +2666,7 @@ static inline u64 sta_get_stats_bytes(struct ieee80211_sta_rx_stats *rxstats)
 
 	do {
 		start = u64_stats_fetch_begin(&rxstats->syncp);
-		value = rxstats->bytes;
+		value = u64_stats_read(&rxstats->bytes);
 	} while (u64_stats_fetch_retry(&rxstats->syncp, start));
 
 	return value;
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 5288d5286651..b1edf8ed102f 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -434,8 +434,8 @@ struct ieee80211_sta_rx_stats {
 	s8 chain_signal_last[IEEE80211_MAX_CHAINS];
 	u32 last_rate;
 	struct u64_stats_sync syncp;
-	u64 bytes;
-	u64 msdu[IEEE80211_NUM_TIDS + 1];
+	u64_stats_t bytes;
+	u64_stats_t msdu[IEEE80211_NUM_TIDS + 1];
 };
 
 /*
-- 
2.51.0


