Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62A25F2BEA
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Oct 2022 10:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiJCIgR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Oct 2022 04:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiJCIfy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Oct 2022 04:35:54 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009C211821
        for <linux-wireless@vger.kernel.org>; Mon,  3 Oct 2022 01:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4D0qqhN5gNNbYJVvJ+sd8nUAe2/LMR4aioyQpGPCtIM=; b=i9vJ6aPX6y7Upneb52kbOdsQxh
        mLK7cOeBUNU22ExlNGQcWBNDlM7BQVCHt0qM7xdyYz9e1xZzqRWq1wqjnm3S31Bs7DSDdMfk50eCc
        kuJp9T7F4WPkzOmLgU1aTtMjrbXMJyZp7qmvhnKb9HCBd5903Oluwg5N+E70S8Kzxm0I=;
Received: from p200300daa7301d00d4086823c46c59c0.dip0.t-ipconnect.de ([2003:da:a730:1d00:d408:6823:c46c:59c0] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1ofG6H-009pC2-TE; Mon, 03 Oct 2022 09:42:54 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [RFC] wifi: mac80211: add support for declaring netdev GSO support
Date:   Mon,  3 Oct 2022 09:42:40 +0200
Message-Id: <20221003074240.84877-1-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
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

Improve performance by deferring GSO segmentation until after the sta lookup,
flow hash calculation and aggregation check. Pass the segmented packets to fq
in one batch.
GSO packets can't be passed to the driver, because they have metadata stored
in skb->cb, which gets overwritten by mac80211. Because of that, segmentation
needs to be done unconditionally in mac80211.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/fq_impl.h | 16 ++++---
 net/mac80211/tx.c     | 98 ++++++++++++++++++++++++++++++++-----------
 2 files changed, 83 insertions(+), 31 deletions(-)

diff --git a/include/net/fq_impl.h b/include/net/fq_impl.h
index 524b510f1c68..9467e33dfb36 100644
--- a/include/net/fq_impl.h
+++ b/include/net/fq_impl.h
@@ -200,6 +200,7 @@ static void fq_tin_enqueue(struct fq *fq,
 			   fq_skb_free_t free_func)
 {
 	struct fq_flow *flow;
+	struct sk_buff *next;
 	bool oom;
 
 	lockdep_assert_held(&fq->lock);
@@ -214,11 +215,15 @@ static void fq_tin_enqueue(struct fq *fq,
 	}
 
 	flow->tin = tin;
-	flow->backlog += skb->len;
-	tin->backlog_bytes += skb->len;
-	tin->backlog_packets++;
-	fq->memory_usage += skb->truesize;
-	fq->backlog++;
+	skb_list_walk_safe(skb, skb, next) {
+		skb_mark_not_on_list(skb);
+		flow->backlog += skb->len;
+		tin->backlog_bytes += skb->len;
+		tin->backlog_packets++;
+		fq->memory_usage += skb->truesize;
+		fq->backlog++;
+		__skb_queue_tail(&flow->queue, skb);
+	}
 
 	if (list_empty(&flow->flowchain)) {
 		flow->deficit = fq->quantum;
@@ -226,7 +231,6 @@ static void fq_tin_enqueue(struct fq *fq,
 			      &tin->new_flows);
 	}
 
-	__skb_queue_tail(&flow->queue, skb);
 	oom = (fq->memory_usage > fq->memory_limit);
 	while (fq->backlog > fq->limit || oom) {
 		flow = fq_find_fattest_flow(fq);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 27c964be102e..f0f591cb3c14 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1355,7 +1355,12 @@ static struct txq_info *ieee80211_get_txq(struct ieee80211_local *local,
 
 static void ieee80211_set_skb_enqueue_time(struct sk_buff *skb)
 {
-	IEEE80211_SKB_CB(skb)->control.enqueue_time = codel_get_time();
+	struct sk_buff *next;
+	codel_time_t now = codel_get_time();
+
+	skb_list_walk_safe(skb, skb, next) {
+		IEEE80211_SKB_CB(skb)->control.enqueue_time = now;
+	}
 }
 
 static u32 codel_skb_len_func(const struct sk_buff *skb)
@@ -4439,9 +4444,11 @@ netdev_tx_t ieee80211_subif_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
-static bool ieee80211_tx_8023(struct ieee80211_sub_if_data *sdata,
-			      struct sk_buff *skb, struct sta_info *sta,
-			      bool txpending)
+
+
+static bool __ieee80211_tx_8023(struct ieee80211_sub_if_data *sdata,
+				struct sk_buff *skb, struct sta_info *sta,
+				bool txpending)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_tx_control control = {};
@@ -4450,14 +4457,6 @@ static bool ieee80211_tx_8023(struct ieee80211_sub_if_data *sdata,
 	unsigned long flags;
 	int q = info->hw_queue;
 
-	if (sta)
-		sk_pacing_shift_update(skb->sk, local->hw.tx_sk_pacing_shift);
-
-	ieee80211_tpt_led_trig_tx(local, skb->len);
-
-	if (ieee80211_queue_skb(local, sdata, sta, skb))
-		return true;
-
 	spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
 
 	if (local->queue_stop_reasons[q] ||
@@ -4484,6 +4483,26 @@ static bool ieee80211_tx_8023(struct ieee80211_sub_if_data *sdata,
 	return true;
 }
 
+static bool ieee80211_tx_8023(struct ieee80211_sub_if_data *sdata,
+			      struct sk_buff *skb, struct sta_info *sta,
+			      bool txpending)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct sk_buff *next;
+	bool ret = true;
+
+	if (ieee80211_queue_skb(local, sdata, sta, skb))
+		return true;
+
+	skb_list_walk_safe(skb, skb, next) {
+		skb_mark_not_on_list(skb);
+		if (!__ieee80211_tx_8023(sdata, skb, sta, txpending))
+			ret = false;
+	}
+
+	return ret;
+}
+
 static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 				struct net_device *dev, struct sta_info *sta,
 				struct ieee80211_key *key, struct sk_buff *skb)
@@ -4491,12 +4510,17 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_tx_info *info;
 	struct ieee80211_local *local = sdata->local;
 	struct tid_ampdu_tx *tid_tx;
+	struct sk_buff *seg, *next;
+	unsigned int skbs = 0, len = 0;
+	u16 queue;
 	u8 tid;
 
 	if (local->ops->wake_tx_queue) {
-		u16 queue = __ieee80211_select_queue(sdata, sta, skb);
+		queue = __ieee80211_select_queue(sdata, sta, skb);
 		skb_set_queue_mapping(skb, queue);
 		skb_get_hash(skb);
+	} else {
+		queue = skb_get_queue_mapping(skb);
 	}
 
 	if (unlikely(test_bit(SCAN_SW_SCANNING, &local->scanning)) &&
@@ -4507,9 +4531,6 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	if (unlikely(!skb))
 		return;
 
-	info = IEEE80211_SKB_CB(skb);
-	memset(info, 0, sizeof(*info));
-
 	ieee80211_aggr_check(sdata, sta, skb);
 
 	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
@@ -4523,22 +4544,30 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 			return;
 		}
 
-		info->flags |= IEEE80211_TX_CTL_AMPDU;
 		if (tid_tx->timeout)
 			tid_tx->last_tx = jiffies;
 	}
 
-	if (unlikely(skb->sk &&
-		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS))
-		info->ack_frame_id = ieee80211_store_ack_skb(local, skb,
-							     &info->flags, NULL);
+	if (skb_is_gso(skb)) {
+		struct sk_buff *segs;
 
-	info->hw_queue = sdata->vif.hw_queue[skb_get_queue_mapping(skb)];
+		segs = skb_gso_segment(skb, local->hw.netdev_features &
+					    ~NETIF_F_GSO_SOFTWARE);
+		if (IS_ERR(segs))
+			goto out_free;
+
+		if (segs) {
+			consume_skb(skb);
+			skb = segs;
+		}
+	}
 
-	dev_sw_netstats_tx_add(dev, 1, skb->len);
+	info = IEEE80211_SKB_CB(skb);
+	memset(info, 0, sizeof(*info));
+	if (tid_tx)
+		info->flags |= IEEE80211_TX_CTL_AMPDU;
 
-	sta->deflink.tx_stats.bytes[skb_get_queue_mapping(skb)] += skb->len;
-	sta->deflink.tx_stats.packets[skb_get_queue_mapping(skb)]++;
+	info->hw_queue = sdata->vif.hw_queue[queue];
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		sdata = container_of(sdata->bss,
@@ -4550,6 +4579,24 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	if (key)
 		info->control.hw_key = &key->conf;
 
+	skb_list_walk_safe(skb, seg, next) {
+		skbs++;
+		len += seg->len;
+		if (seg != skb)
+			memcpy(IEEE80211_SKB_CB(seg), info, sizeof(*info));
+	}
+
+	if (unlikely(skb->sk &&
+		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS))
+		info->ack_frame_id = ieee80211_store_ack_skb(local, skb,
+							     &info->flags, NULL);
+
+	dev_sw_netstats_tx_add(dev, skbs, len);
+	sta->deflink.tx_stats.packets[queue] += skbs;
+	sta->deflink.tx_stats.bytes[queue] += len;
+
+	ieee80211_tpt_led_trig_tx(local, len);
+
 	ieee80211_tx_8023(sdata, skb, sta, false);
 
 	return;
@@ -4591,6 +4638,7 @@ netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
 		    key->conf.cipher == WLAN_CIPHER_SUITE_TKIP))
 		goto skip_offload;
 
+	sk_pacing_shift_update(skb->sk, sdata->local->hw.tx_sk_pacing_shift);
 	ieee80211_8023_xmit(sdata, dev, sta, key, skb);
 	goto out;
 
-- 
2.36.1

