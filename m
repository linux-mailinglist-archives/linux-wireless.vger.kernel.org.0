Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584D55F8D2D
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Oct 2022 20:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbiJISdo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Oct 2022 14:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJISdl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Oct 2022 14:33:41 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B93192A5
        for <linux-wireless@vger.kernel.org>; Sun,  9 Oct 2022 11:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=38J9MxGT04mKWPImuceVTYzR3hBfwVNFHs8xf/79YTQ=; b=rAtIaT5NCiHnmejO8/RKqXfHb0
        yRmgd1WsaOr1DyJHlwJdhUBmD1lmat5cLqDPcJpNrTBr0tzpfd1Ey5mbM0VhjLkXPpxqnLO5p64t2
        lj4Wy1rR/h/jzf/9Sei/2H3C0r7sbj848Sjmv8xh7ENzab+lQ314o8M3uaF5c4uoBVfU=;
Received: from p200300daa7301d0040b5a08eac3e582e.dip0.t-ipconnect.de ([2003:da:a730:1d00:40b5:a08e:ac3e:582e] helo=localhost.localdomain)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1ohb7I-00BSKa-FK; Sun, 09 Oct 2022 20:33:36 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH] mac80211: add support for restricting netdev features per vif
Date:   Sun,  9 Oct 2022 20:33:34 +0200
Message-Id: <20221009183334.35841-1-nbd@nbd.name>
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

This can be used to selectively disable feature flags for checksum offload,
scatter/gather or GSO by changing vif->netdev_features.
Removing features from vif->netdev_features does not affect the netdev
features themselves, but instead fixes up skbs in the tx path so that the
offloads are not needed in the driver.

Aside from making it easier to deal with vif type based hardware limitations,
this also makes it possible to optimize performance on hardware without native
GSO support by declaring GSO support in hw->netdev_features and removing it
from vif->netdev_features. This allows mac80211 to handle GSO segmentation
after the sta lookup, but before itxq enqueue, thus reducing the number of
unnecessary sta lookups, as well as some other per-packet processing.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/fq_impl.h  |  16 ++-
 include/net/mac80211.h |   5 +
 net/mac80211/iface.c   |   1 +
 net/mac80211/tx.c      | 283 +++++++++++++++++++++++++++--------------
 4 files changed, 203 insertions(+), 102 deletions(-)

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
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index cda4584dfd51..5b9202c68876 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1806,6 +1806,10 @@ struct ieee80211_vif_cfg {
  * @addr: address of this interface
  * @p2p: indicates whether this AP or STA interface is a p2p
  *	interface, i.e. a GO or p2p-sta respectively
+ * @netdev_features: tx netdev features supported by the hardware for this
+ *	vif. mac80211 initializes this to hw->netdev_features, and the driver
+ *	can mask out specific tx features. mac80211 will handle software fixup
+ *	for masked offloads (GSO, CSUM)
  * @driver_flags: flags/capabilities the driver has for this interface,
  *	these need to be set (or cleared) when the interface is added
  *	or, if supported by the driver, the interface type is changed
@@ -1847,6 +1851,7 @@ struct ieee80211_vif {
 
 	struct ieee80211_txq *txq;
 
+	netdev_features_t netdev_features;
 	u32 driver_flags;
 	u32 offload_flags;
 
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 572254366a0f..811bb3406c9e 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -2242,6 +2242,7 @@ int ieee80211_if_add(struct ieee80211_local *local, const char *name,
 		ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 		ndev->hw_features |= ndev->features &
 					MAC80211_SUPPORTED_FEATURES_TX;
+		sdata->vif.netdev_features = local->hw.netdev_features;
 
 		netdev_set_default_ethtool_ops(ndev, &ieee80211_ethtool_ops);
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d9e7a2ed5d2c..876af60049a8 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1355,7 +1355,11 @@ static struct txq_info *ieee80211_get_txq(struct ieee80211_local *local,
 
 static void ieee80211_set_skb_enqueue_time(struct sk_buff *skb)
 {
-	IEEE80211_SKB_CB(skb)->control.enqueue_time = codel_get_time();
+	struct sk_buff *next;
+	codel_time_t now = codel_get_time();
+
+	skb_list_walk_safe(skb, skb, next)
+		IEEE80211_SKB_CB(skb)->control.enqueue_time = now;
 }
 
 static u32 codel_skb_len_func(const struct sk_buff *skb)
@@ -3583,55 +3587,81 @@ ieee80211_xmit_fast_finish(struct ieee80211_sub_if_data *sdata,
 	return TX_CONTINUE;
 }
 
-static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
-				struct sta_info *sta,
-				struct ieee80211_fast_tx *fast_tx,
-				struct sk_buff *skb)
+static netdev_features_t
+ieee80211_sdata_netdev_features(struct ieee80211_sub_if_data *sdata)
 {
-	struct ieee80211_local *local = sdata->local;
-	u16 ethertype = (skb->data[12] << 8) | skb->data[13];
-	int extra_head = fast_tx->hdr_len - (ETH_HLEN - 2);
-	int hw_headroom = sdata->local->hw.extra_tx_headroom;
-	struct ethhdr eth;
-	struct ieee80211_tx_info *info;
-	struct ieee80211_hdr *hdr = (void *)fast_tx->hdr;
-	struct ieee80211_tx_data tx;
-	ieee80211_tx_result r;
-	struct tid_ampdu_tx *tid_tx = NULL;
-	u8 tid = IEEE80211_NUM_TIDS;
+	if (sdata->vif.type != NL80211_IFTYPE_AP_VLAN)
+		return sdata->vif.netdev_features;
 
-	/* control port protocol needs a lot of special handling */
-	if (cpu_to_be16(ethertype) == sdata->control_port_protocol)
-		return false;
+	if (!sdata->bss)
+		return 0;
 
-	/* only RFC 1042 SNAP */
-	if (ethertype < ETH_P_802_3_MIN)
-		return false;
+	sdata = container_of(sdata->bss, struct ieee80211_sub_if_data, u.ap);
+	return sdata->vif.netdev_features;
+}
 
-	/* don't handle TX status request here either */
-	if (skb->sk && skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)
-		return false;
+static struct sk_buff *
+ieee80211_tx_skb_fixup(struct sk_buff *skb, netdev_features_t features)
+{
+	if (skb_is_gso(skb)) {
+		struct sk_buff *segs;
 
-	if (hdr->frame_control & cpu_to_le16(IEEE80211_STYPE_QOS_DATA)) {
-		tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
-		tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
-		if (tid_tx) {
-			if (!test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state))
-				return false;
-			if (tid_tx->timeout)
-				tid_tx->last_tx = jiffies;
-		}
+		segs = skb_gso_segment(skb, features);
+		if (!segs)
+			return skb;
+		if (IS_ERR(segs))
+			goto free;
+
+		consume_skb(skb);
+		return segs;
 	}
 
+	if (skb_needs_linearize(skb, features) && __skb_linearize(skb))
+		goto free;
+
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		int ofs = skb_checksum_start_offset(skb);
+
+		if (skb->encapsulation)
+			skb_set_inner_transport_header(skb, ofs);
+		else
+			skb_set_transport_header(skb, ofs);
+
+		if (skb_csum_hwoffload_help(skb, features))
+			goto free;
+	}
+
+	skb_mark_not_on_list(skb);
+	return skb;
+
+free:
+	kfree_skb(skb);
+	return NULL;
+}
+
+static void __ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
+				  struct sta_info *sta,
+				  struct ieee80211_fast_tx *fast_tx,
+				  struct sk_buff *skb, u8 tid, bool ampdu)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_hdr *hdr = (void *)fast_tx->hdr;
+	struct ieee80211_tx_info *info;
+	struct ieee80211_tx_data tx;
+	ieee80211_tx_result r;
+	int hw_headroom = sdata->local->hw.extra_tx_headroom;
+	int extra_head = fast_tx->hdr_len - (ETH_HLEN - 2);
+	struct ethhdr eth;
+
 	/* after this point (skb is modified) we cannot return false */
 
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (unlikely(!skb))
-		return true;
+		return;
 
 	if ((hdr->frame_control & cpu_to_le16(IEEE80211_STYPE_QOS_DATA)) &&
 	    ieee80211_amsdu_aggregate(sdata, sta, fast_tx, skb))
-		return true;
+		return;
 
 	/* will not be crypto-handled beyond what we do here, so use false
 	 * as the may-encrypt argument for the resize to not account for
@@ -3640,10 +3670,8 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	if (unlikely(ieee80211_skb_resize(sdata, skb,
 					  max_t(int, extra_head + hw_headroom -
 						     skb_headroom(skb), 0),
-					  ENCRYPT_NO))) {
-		kfree_skb(skb);
-		return true;
-	}
+					  ENCRYPT_NO)))
+		goto free;
 
 	memcpy(&eth, skb->data, ETH_HLEN - 2);
 	hdr = skb_push(skb, extra_head);
@@ -3657,7 +3685,7 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	info->control.vif = &sdata->vif;
 	info->flags = IEEE80211_TX_CTL_FIRST_FRAGMENT |
 		      IEEE80211_TX_CTL_DONTFRAG |
-		      (tid_tx ? IEEE80211_TX_CTL_AMPDU : 0);
+		      (ampdu ? IEEE80211_TX_CTL_AMPDU : 0);
 	info->control.flags = IEEE80211_TX_CTRL_FAST_XMIT |
 			      u32_encode_bits(IEEE80211_LINK_UNSPECIFIED,
 					      IEEE80211_TX_CTRL_MLO_LINK);
@@ -3681,16 +3709,14 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	tx.key = fast_tx->key;
 
 	if (ieee80211_queue_skb(local, sdata, sta, skb))
-		return true;
+		return;
 
 	tx.skb = skb;
 	r = ieee80211_xmit_fast_finish(sdata, sta, fast_tx->pn_offs,
 				       fast_tx->key, &tx);
 	tx.skb = NULL;
-	if (r == TX_DROP) {
-		kfree_skb(skb);
-		return true;
-	}
+	if (r == TX_DROP)
+		goto free;
 
 	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
 		sdata = container_of(sdata->bss,
@@ -3698,6 +3724,55 @@ static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 
 	__skb_queue_tail(&tx.skbs, skb);
 	ieee80211_tx_frags(local, &sdata->vif, sta, &tx.skbs, false);
+	return;
+
+free:
+	kfree_skb(skb);
+}
+
+static bool ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
+				struct sta_info *sta,
+				struct ieee80211_fast_tx *fast_tx,
+				struct sk_buff *skb)
+{
+	u16 ethertype = (skb->data[12] << 8) | skb->data[13];
+	struct ieee80211_hdr *hdr = (void *)fast_tx->hdr;
+	struct tid_ampdu_tx *tid_tx = NULL;
+	struct sk_buff *next;
+	u8 tid = IEEE80211_NUM_TIDS;
+
+	/* control port protocol needs a lot of special handling */
+	if (cpu_to_be16(ethertype) == sdata->control_port_protocol)
+		return false;
+
+	/* only RFC 1042 SNAP */
+	if (ethertype < ETH_P_802_3_MIN)
+		return false;
+
+	/* don't handle TX status request here either */
+	if (skb->sk && skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS)
+		return false;
+
+	if (hdr->frame_control & cpu_to_le16(IEEE80211_STYPE_QOS_DATA)) {
+		tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
+		tid_tx = rcu_dereference(sta->ampdu_mlme.tid_tx[tid]);
+		if (tid_tx) {
+			if (!test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state))
+				return false;
+			if (tid_tx->timeout)
+				tid_tx->last_tx = jiffies;
+		}
+	}
+
+	skb = ieee80211_tx_skb_fixup(skb, ieee80211_sdata_netdev_features(sdata));
+	if (!skb)
+		return true;
+
+	skb_list_walk_safe(skb, skb, next) {
+		skb_mark_not_on_list(skb);
+		__ieee80211_xmit_fast(sdata, sta, fast_tx, skb, tid, tid_tx);
+	}
+
 	return true;
 }
 
@@ -4202,31 +4277,14 @@ void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 			goto out;
 	}
 
-	if (skb_is_gso(skb)) {
-		struct sk_buff *segs;
-
-		segs = skb_gso_segment(skb, 0);
-		if (IS_ERR(segs)) {
-			goto out_free;
-		} else if (segs) {
-			consume_skb(skb);
-			skb = segs;
-		}
-	} else {
-		/* we cannot process non-linear frames on this path */
-		if (skb_linearize(skb))
-			goto out_free;
-
-		/* the frame could be fragmented, software-encrypted, and other
-		 * things so we cannot really handle checksum offload with it -
-		 * fix it up in software before we handle anything else.
-		 */
-		if (skb->ip_summed == CHECKSUM_PARTIAL) {
-			skb_set_transport_header(skb,
-						 skb_checksum_start_offset(skb));
-			if (skb_checksum_help(skb))
-				goto out_free;
-		}
+	/* the frame could be fragmented, software-encrypted, and other
+	 * things so we cannot really handle checksum or GSO offload.
+	 * fix it up in software before we handle anything else.
+	 */
+	skb = ieee80211_tx_skb_fixup(skb, 0);
+	if (!skb) {
+		len = 0;
+		goto out;
 	}
 
 	skb_list_walk_safe(skb, skb, next) {
@@ -4439,9 +4497,11 @@ netdev_tx_t ieee80211_subif_start_xmit(struct sk_buff *skb,
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
@@ -4450,14 +4510,6 @@ static bool ieee80211_tx_8023(struct ieee80211_sub_if_data *sdata,
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
@@ -4484,6 +4536,26 @@ static bool ieee80211_tx_8023(struct ieee80211_sub_if_data *sdata,
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
@@ -4491,12 +4563,17 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
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
@@ -4507,9 +4584,6 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	if (unlikely(!skb))
 		return;
 
-	info = IEEE80211_SKB_CB(skb);
-	memset(info, 0, sizeof(*info));
-
 	ieee80211_aggr_check(sdata, sta, skb);
 
 	tid = skb->priority & IEEE80211_QOS_CTL_TAG1D_MASK;
@@ -4523,22 +4597,20 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
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
-
-	info->hw_queue = sdata->vif.hw_queue[skb_get_queue_mapping(skb)];
+	skb = ieee80211_tx_skb_fixup(skb, ieee80211_sdata_netdev_features(sdata));
+	if (!skb)
+		return;
 
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
@@ -4550,6 +4622,24 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
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
@@ -4591,6 +4681,7 @@ netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
 		    key->conf.cipher == WLAN_CIPHER_SUITE_TKIP))
 		goto skip_offload;
 
+	sk_pacing_shift_update(skb->sk, sdata->local->hw.tx_sk_pacing_shift);
 	ieee80211_8023_xmit(sdata, dev, sta, key, skb);
 	goto out;
 
-- 
2.36.1

