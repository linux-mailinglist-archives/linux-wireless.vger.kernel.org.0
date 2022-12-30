Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD57659BD3
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Dec 2022 21:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbiL3UHy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Dec 2022 15:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbiL3UHw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Dec 2022 15:07:52 -0500
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707221AA28
        for <linux-wireless@vger.kernel.org>; Fri, 30 Dec 2022 12:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=MOP4M3OXBZgoVcJxv12HuWgWeoMLWtZ3mq7m62SOrj4=; b=k+bmtiQBNr/hR5sCGE7kC5RcPL
        ptayezVWrrOG/IBA0D/tqkzbhxvjITwkdb+0fqetFdbQysXGlLBYxfOTzUdxpb4LYHkyHRNB3T+QY
        rfiz8bRKfg7g0wxx/mv+g8uBkNcc0BFVIfvQfLizYv/NEYlArjKB/KTJwKiAdpH0lVyo=;
Received: from p200300daa720fc04e414d7f16dff6555.dip0.t-ipconnect.de ([2003:da:a720:fc04:e414:d7f1:6dff:6555] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pBLfP-00CoaL-Q1; Fri, 30 Dec 2022 21:07:47 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, quic_srirrama@quicinc.com
Subject: [PATCH v5] wifi: mac80211: fix initialization of rx->link and rx->link_sta
Date:   Fri, 30 Dec 2022 21:07:47 +0100
Message-Id: <20221230200747.19040-1-nbd@nbd.name>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are some codepaths that do not initialize rx->link_sta properly. This
causes a crash in places which assume that rx->link_sta is valid if rx->sta
is valid.
One known instance is triggered by __ieee80211_rx_h_amsdu being called from
fast-rx. It results in a crash like this one:

 BUG: kernel NULL pointer dereference, address: 00000000000000a8
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page PGD 0 P4D 0
 Oops: 0002 [#1] PREEMPT SMP PTI
 CPU: 1 PID: 506 Comm: mt76-usb-rx phy Tainted: G            E      6.1.0-debian64x+1.7 #3
 Hardware name: ZOTAC ZBOX-ID92/ZBOX-IQ01/ZBOX-ID92/ZBOX-IQ01, BIOS B220P007 05/21/2014
 RIP: 0010:ieee80211_deliver_skb+0x62/0x1f0 [mac80211]
 Code: 00 48 89 04 24 e8 9e a7 c3 df 89 c0 48 03 1c c5 a0 ea 39 a1 4c 01 6b 08 48 ff 03 48
       83 7d 28 00 74 11 48 8b 45 30 48 63 55 44 <48> 83 84 d0 a8 00 00 00 01 41 8b 86 c0
       11 00 00 8d 50 fd 83 fa 01
 RSP: 0018:ffff999040803b10 EFLAGS: 00010286
 RAX: 0000000000000000 RBX: ffffb9903f496480 RCX: 0000000000000000
 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
 RBP: ffff999040803ce0 R08: 0000000000000000 R09: 0000000000000000
 R10: 0000000000000000 R11: 0000000000000000 R12: ffff8d21828ac900
 R13: 000000000000004a R14: ffff8d2198ed89c0 R15: ffff8d2198ed8000
 FS:  0000000000000000(0000) GS:ffff8d24afe80000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00000000000000a8 CR3: 0000000429810002 CR4: 00000000001706e0
 Call Trace:
  <TASK>
  __ieee80211_rx_h_amsdu+0x1b5/0x240 [mac80211]
  ? ieee80211_prepare_and_rx_handle+0xcdd/0x1320 [mac80211]
  ? __local_bh_enable_ip+0x3b/0xa0
  ieee80211_prepare_and_rx_handle+0xcdd/0x1320 [mac80211]
  ? prepare_transfer+0x109/0x1a0 [xhci_hcd]
  ieee80211_rx_list+0xa80/0xda0 [mac80211]
  mt76_rx_complete+0x207/0x2e0 [mt76]
  mt76_rx_poll_complete+0x357/0x5a0 [mt76]
  mt76u_rx_worker+0x4f5/0x600 [mt76_usb]
  ? mt76_get_min_avg_rssi+0x140/0x140 [mt76]
  __mt76_worker_fn+0x50/0x80 [mt76]
  kthread+0xed/0x120
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x22/0x30

Since the initialization of rx->link and rx->link_sta is rather convoluted
and duplicated in many places, clean it up by using a helper function to
set it.

Fixes: ccdde7c74ffd ("wifi: mac80211: properly implement MLO key handling")
Fixes: b320d6c456ff ("wifi: mac80211: use correct rx link_sta instead of default")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v5: fix sdata link assignment, fix sdata when receiving on multiple interfaces
v4: fix regression in handling mgmt frames with AP_VLAN
v3: include crash log
v2: fix uninitialized variable
 net/mac80211/rx.c | 222 +++++++++++++++++++++-------------------------
 1 file changed, 99 insertions(+), 123 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 7e3ab6e1b28f..6ccc487bad7f 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4049,6 +4049,58 @@ static void ieee80211_invoke_rx_handlers(struct ieee80211_rx_data *rx)
 #undef CALL_RXH
 }
 
+static bool
+ieee80211_rx_is_valid_sta_link_id(struct ieee80211_sta *sta, u8 link_id)
+{
+	if (!sta->mlo)
+		return false;
+
+	return !!(sta->valid_links & BIT(link_id));
+}
+
+static bool ieee80211_rx_data_set_link(struct ieee80211_rx_data *rx,
+				       u8 link_id)
+{
+	rx->link_id = link_id;
+	rx->link = rcu_dereference(rx->sdata->link[link_id]);
+
+	if (!rx->sta || !rx->sta->sta.mlo)
+		return rx->link;
+
+	if (!ieee80211_rx_is_valid_sta_link_id(&rx->sta->sta, link_id))
+		return false;
+
+	rx->link_sta = rcu_dereference(rx->sta->link[link_id]);
+
+	return rx->link && rx->link_sta;
+}
+
+static bool ieee80211_rx_data_set_sta(struct ieee80211_rx_data *rx,
+				      struct ieee80211_sta *pubsta,
+				      int link_id)
+{
+	struct sta_info *sta;
+
+	sta = container_of(pubsta, struct sta_info, sta);
+
+	rx->link_id = link_id;
+	rx->sta = sta;
+
+	if (sta) {
+		rx->local = sta->sdata->local;
+		if (!rx->sdata)
+			rx->sdata = sta->sdata;
+		rx->link_sta = &sta->deflink;
+	}
+
+	if (link_id < 0)
+		rx->link = &rx->sdata->deflink;
+	else if (!ieee80211_rx_data_set_link(rx, link_id))
+		return false;
+
+	return true;
+}
+
 /*
  * This function makes calls into the RX path, therefore
  * it has to be invoked under RCU read lock.
@@ -4057,16 +4109,19 @@ void ieee80211_release_reorder_timeout(struct sta_info *sta, int tid)
 {
 	struct sk_buff_head frames;
 	struct ieee80211_rx_data rx = {
-		.sta = sta,
-		.sdata = sta->sdata,
-		.local = sta->local,
 		/* This is OK -- must be QoS data frame */
 		.security_idx = tid,
 		.seqno_idx = tid,
-		.link_id = -1,
 	};
 	struct tid_ampdu_rx *tid_agg_rx;
-	u8 link_id;
+	int link_id = -1;
+
+	/* FIXME: statistics won't be right with this */
+	if (sta->sta.valid_links)
+		link_id = ffs(sta->sta.valid_links) - 1;
+
+	if (!ieee80211_rx_data_set_sta(&rx, &sta->sta, link_id))
+		return;
 
 	tid_agg_rx = rcu_dereference(sta->ampdu_mlme.tid_rx[tid]);
 	if (!tid_agg_rx)
@@ -4086,10 +4141,6 @@ void ieee80211_release_reorder_timeout(struct sta_info *sta, int tid)
 		};
 		drv_event_callback(rx.local, rx.sdata, &event);
 	}
-	/* FIXME: statistics won't be right with this */
-	link_id = sta->sta.valid_links ? ffs(sta->sta.valid_links) - 1 : 0;
-	rx.link = rcu_dereference(sta->sdata->link[link_id]);
-	rx.link_sta = rcu_dereference(sta->link[link_id]);
 
 	ieee80211_rx_handlers(&rx, &frames);
 }
@@ -4105,7 +4156,6 @@ void ieee80211_mark_rx_ba_filtered_frames(struct ieee80211_sta *pubsta, u8 tid,
 		/* This is OK -- must be QoS data frame */
 		.security_idx = tid,
 		.seqno_idx = tid,
-		.link_id = -1,
 	};
 	int i, diff;
 
@@ -4116,10 +4166,8 @@ void ieee80211_mark_rx_ba_filtered_frames(struct ieee80211_sta *pubsta, u8 tid,
 
 	sta = container_of(pubsta, struct sta_info, sta);
 
-	rx.sta = sta;
-	rx.sdata = sta->sdata;
-	rx.link = &rx.sdata->deflink;
-	rx.local = sta->local;
+	if (!ieee80211_rx_data_set_sta(&rx, pubsta, -1))
+		return;
 
 	rcu_read_lock();
 	tid_agg_rx = rcu_dereference(sta->ampdu_mlme.tid_rx[tid]);
@@ -4506,15 +4554,6 @@ void ieee80211_check_fast_rx_iface(struct ieee80211_sub_if_data *sdata)
 	mutex_unlock(&local->sta_mtx);
 }
 
-static bool
-ieee80211_rx_is_valid_sta_link_id(struct ieee80211_sta *sta, u8 link_id)
-{
-	if (!sta->mlo)
-		return false;
-
-	return !!(sta->valid_links & BIT(link_id));
-}
-
 static void ieee80211_rx_8023(struct ieee80211_rx_data *rx,
 			      struct ieee80211_fast_rx *fast_rx,
 			      int orig_len)
@@ -4625,7 +4664,6 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 	struct sk_buff *skb = rx->skb;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
-	struct sta_info *sta = rx->sta;
 	int orig_len = skb->len;
 	int hdrlen = ieee80211_hdrlen(hdr->frame_control);
 	int snap_offs = hdrlen;
@@ -4637,7 +4675,6 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 		u8 da[ETH_ALEN];
 		u8 sa[ETH_ALEN];
 	} addrs __aligned(2);
-	struct link_sta_info *link_sta;
 	struct ieee80211_sta_rx_stats *stats;
 
 	/* for parallel-rx, we need to have DUP_VALIDATED, otherwise we write
@@ -4740,18 +4777,10 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
  drop:
 	dev_kfree_skb(skb);
 
-	if (rx->link_id >= 0) {
-		link_sta = rcu_dereference(sta->link[rx->link_id]);
-		if (!link_sta)
-			return true;
-	} else {
-		link_sta = &sta->deflink;
-	}
-
 	if (fast_rx->uses_rss)
-		stats = this_cpu_ptr(link_sta->pcpu_rx_stats);
+		stats = this_cpu_ptr(rx->link_sta->pcpu_rx_stats);
 	else
-		stats = &link_sta->rx_stats;
+		stats = &rx->link_sta->rx_stats;
 
 	stats->dropped++;
 	return true;
@@ -4769,8 +4798,8 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 	struct ieee80211_local *local = rx->local;
 	struct ieee80211_sub_if_data *sdata = rx->sdata;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
-	struct link_sta_info *link_sta = NULL;
-	struct ieee80211_link_data *link;
+	struct link_sta_info *link_sta = rx->link_sta;
+	struct ieee80211_link_data *link = rx->link;
 
 	rx->skb = skb;
 
@@ -4792,35 +4821,6 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 	if (!ieee80211_accept_frame(rx))
 		return false;
 
-	if (rx->link_id >= 0) {
-		link = rcu_dereference(rx->sdata->link[rx->link_id]);
-
-		/* we might race link removal */
-		if (!link)
-			return true;
-		rx->link = link;
-
-		if (rx->sta) {
-			rx->link_sta =
-				rcu_dereference(rx->sta->link[rx->link_id]);
-			if (!rx->link_sta)
-				return true;
-		}
-	} else {
-		if (rx->sta)
-			rx->link_sta = &rx->sta->deflink;
-
-		rx->link = &sdata->deflink;
-	}
-
-	if (unlikely(!is_multicast_ether_addr(hdr->addr1) &&
-		     rx->link_id >= 0 && rx->sta && rx->sta->sta.mlo)) {
-		link_sta = rcu_dereference(rx->sta->link[rx->link_id]);
-
-		if (WARN_ON_ONCE(!link_sta))
-			return true;
-	}
-
 	if (!consume) {
 		struct skb_shared_hwtstamps *shwt;
 
@@ -4840,7 +4840,7 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 		shwt->hwtstamp = skb_hwtstamps(skb)->hwtstamp;
 	}
 
-	if (unlikely(link_sta)) {
+	if (unlikely(rx->sta && rx->sta->sta.mlo)) {
 		/* translate to MLD addresses */
 		if (ether_addr_equal(link->conf->addr, hdr->addr1))
 			ether_addr_copy(hdr->addr1, rx->sdata->vif.addr);
@@ -4870,6 +4870,7 @@ static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct ieee80211_fast_rx *fast_rx;
 	struct ieee80211_rx_data rx;
+	int link_id = -1;
 
 	memset(&rx, 0, sizeof(rx));
 	rx.skb = skb;
@@ -4886,12 +4887,8 @@ static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
 	if (!pubsta)
 		goto drop;
 
-	rx.sta = container_of(pubsta, struct sta_info, sta);
-	rx.sdata = rx.sta->sdata;
-
-	if (status->link_valid &&
-	    !ieee80211_rx_is_valid_sta_link_id(pubsta, status->link_id))
-		goto drop;
+	if (status->link_valid)
+		link_id = status->link_id;
 
 	/*
 	 * TODO: Should the frame be dropped if the right link_id is not
@@ -4900,19 +4897,8 @@ static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
 	 * link_id is used only for stats purpose and updating the stats on
 	 * the deflink is fine?
 	 */
-	if (status->link_valid)
-		rx.link_id = status->link_id;
-
-	if (rx.link_id >= 0) {
-		struct ieee80211_link_data *link;
-
-		link =  rcu_dereference(rx.sdata->link[rx.link_id]);
-		if (!link)
-			goto drop;
-		rx.link = link;
-	} else {
-		rx.link = &rx.sdata->deflink;
-	}
+	if (!ieee80211_rx_data_set_sta(&rx, pubsta, link_id))
+		goto drop;
 
 	fast_rx = rcu_dereference(rx.sta->fast_rx);
 	if (!fast_rx)
@@ -4930,6 +4916,8 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 {
 	struct link_sta_info *link_sta;
 	struct ieee80211_hdr *hdr = (void *)skb->data;
+	struct sta_info *sta;
+	int link_id = -1;
 
 	/*
 	 * Look up link station first, in case there's a
@@ -4939,24 +4927,19 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 	 */
 	link_sta = link_sta_info_get_bss(rx->sdata, hdr->addr2);
 	if (link_sta) {
-		rx->sta = link_sta->sta;
-		rx->link_id = link_sta->link_id;
+		sta = link_sta->sta;
+		link_id = link_sta->link_id;
 	} else {
 		struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 
-		rx->sta = sta_info_get_bss(rx->sdata, hdr->addr2);
-		if (rx->sta) {
-			if (status->link_valid &&
-			    !ieee80211_rx_is_valid_sta_link_id(&rx->sta->sta,
-							       status->link_id))
-				return false;
-
-			rx->link_id = status->link_valid ? status->link_id : -1;
-		} else {
-			rx->link_id = -1;
-		}
+		sta = sta_info_get_bss(rx->sdata, hdr->addr2);
+		if (status->link_valid)
+			link_id = status->link_id;
 	}
 
+	if (!ieee80211_rx_data_set_sta(rx, &sta->sta, link_id))
+		return false;
+
 	return ieee80211_prepare_and_rx_handle(rx, skb, consume);
 }
 
@@ -5015,19 +4998,15 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 
 	if (ieee80211_is_data(fc)) {
 		struct sta_info *sta, *prev_sta;
-		u8 link_id = status->link_id;
+		int link_id = -1;
 
-		if (pubsta) {
-			rx.sta = container_of(pubsta, struct sta_info, sta);
-			rx.sdata = rx.sta->sdata;
+		if (status->link_valid)
+			link_id = status->link_id;
 
-			if (status->link_valid &&
-			    !ieee80211_rx_is_valid_sta_link_id(pubsta, link_id))
+		if (pubsta) {
+			if (!ieee80211_rx_data_set_sta(&rx, pubsta, link_id))
 				goto out;
 
-			if (status->link_valid)
-				rx.link_id = status->link_id;
-
 			/*
 			 * In MLO connection, fetch the link_id using addr2
 			 * when the driver does not pass link_id in status.
@@ -5045,7 +5024,7 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 				if (!link_sta)
 					goto out;
 
-				rx.link_id = link_sta->link_id;
+				ieee80211_rx_data_set_link(&rx, link_sta->link_id);
 			}
 
 			if (ieee80211_prepare_and_rx_handle(&rx, skb, true))
@@ -5061,30 +5040,27 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 				continue;
 			}
 
-			if ((status->link_valid &&
-			     !ieee80211_rx_is_valid_sta_link_id(&prev_sta->sta,
-								link_id)) ||
-			    (!status->link_valid && prev_sta->sta.mlo))
+			rx.sdata = prev_sta->sdata;
+			if (!ieee80211_rx_data_set_sta(&rx, &prev_sta->sta,
+						       link_id))
+				goto out;
+
+			if (!status->link_valid && prev_sta->sta.mlo)
 				continue;
 
-			rx.link_id = status->link_valid ? link_id : -1;
-			rx.sta = prev_sta;
-			rx.sdata = prev_sta->sdata;
 			ieee80211_prepare_and_rx_handle(&rx, skb, false);
 
 			prev_sta = sta;
 		}
 
 		if (prev_sta) {
-			if ((status->link_valid &&
-			     !ieee80211_rx_is_valid_sta_link_id(&prev_sta->sta,
-								link_id)) ||
-			    (!status->link_valid && prev_sta->sta.mlo))
+			rx.sdata = prev_sta->sdata;
+			if (!ieee80211_rx_data_set_sta(&rx, &prev_sta->sta,
+						       link_id))
 				goto out;
 
-			rx.link_id = status->link_valid ? link_id : -1;
-			rx.sta = prev_sta;
-			rx.sdata = prev_sta->sdata;
+			if (!status->link_valid && prev_sta->sta.mlo)
+				goto out;
 
 			if (ieee80211_prepare_and_rx_handle(&rx, skb, true))
 				return;
-- 
2.38.1

