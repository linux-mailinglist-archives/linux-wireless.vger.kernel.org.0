Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41112DE93B
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Dec 2020 19:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgLRSsT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Dec 2020 13:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726481AbgLRSsS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Dec 2020 13:48:18 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DF2C061248
        for <linux-wireless@vger.kernel.org>; Fri, 18 Dec 2020 10:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ea6rzL9+lb3xnOmiV3G7hS1IFw2c/v43HUwukWGBats=; b=W66idE+puT+ODE98ASPSQqCthz
        NNWdj9UUgpoea3B0BgZHajvtA9HeIYZDXQIe57suVW9M8fnREohkXX3aLwbCQHlrx+wHNe3RbtLEH
        nGprb1ZVJ3T1Lzq2cBTDP1lLTzQ99lUkaIj2sOv3XZdI/N0+PON+NQHAmXwtyLOKNipw=;
Received: from p4ff13815.dip0.t-ipconnect.de ([79.241.56.21] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kqKmf-0000Fr-FP; Fri, 18 Dec 2020 19:47:21 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     toke@redhat.com
Subject: [PATCH v2 6/6] mac80211: add rx decapsulation offload support
Date:   Fri, 18 Dec 2020 19:47:18 +0100
Message-Id: <20201218184718.93650-6-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201218184718.93650-1-nbd@nbd.name>
References: <20201218184718.93650-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This allows drivers to pass 802.3 frames to mac80211, with some restrictions:

- the skb must be passed with a valid sta
- fast-rx needs to be active for the sta
- monitor mode needs to be disabled

mac80211 will tell the driver when it is safe to enable rx decap offload for
a particular station.

In order to implement support, a driver must:

- call ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD)
- implement ops->sta_set_decap_offload
- mark 802.3 frames with RX_FLAG_8023

If it doesn't want to enable offload for some vif types, it can mask out
IEEE80211_OFFLOAD_DECAP_ENABLED in vif->offload_flags from within the
.add_interface or .update_vif_offload driver ops

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2: rename ieee80211_iftype_supports_encap_offload to
	ieee80211_iftype_supports_hdr_offload

 include/net/mac80211.h     |  16 +++
 net/mac80211/debugfs.c     |   1 +
 net/mac80211/debugfs_sta.c |   1 +
 net/mac80211/driver-ops.h  |  16 +++
 net/mac80211/iface.c       |  17 ++-
 net/mac80211/rx.c          | 243 ++++++++++++++++++++++++-------------
 net/mac80211/sta_info.h    |   2 +
 net/mac80211/trace.h       |  18 ++-
 8 files changed, 225 insertions(+), 89 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d315740581f1..296d39e93a13 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1296,6 +1296,8 @@ ieee80211_tx_info_clear_status(struct ieee80211_tx_info *info)
  *	the "0-length PSDU" field included there.  The value for it is
  *	in &struct ieee80211_rx_status.  Note that if this value isn't
  *	known the frame shouldn't be reported.
+ * @RX_FLAG_8023: the frame has an 802.3 header (decap offload performed by
+ *	hardware or driver)
  */
 enum mac80211_rx_flags {
 	RX_FLAG_MMIC_ERROR		= BIT(0),
@@ -1328,6 +1330,7 @@ enum mac80211_rx_flags {
 	RX_FLAG_RADIOTAP_HE_MU		= BIT(27),
 	RX_FLAG_RADIOTAP_LSIG		= BIT(28),
 	RX_FLAG_NO_PSDU			= BIT(29),
+	RX_FLAG_8023			= BIT(30),
 };
 
 /**
@@ -1649,11 +1652,15 @@ enum ieee80211_vif_flags {
  *	The driver supports sending frames passed as 802.3 frames by mac80211.
  *	It must also support sending 802.11 packets for the same interface.
  * @IEEE80211_OFFLOAD_ENCAP_4ADDR: support 4-address mode encapsulation offload
+ * @IEEE80211_OFFLOAD_DECAP_ENABLED: rx encapsulation offload is enabled
+ *	The driver supports passing received 802.11 frames as 802.3 frames to
+ *	mac80211.
  */
 
 enum ieee80211_offload_flags {
 	IEEE80211_OFFLOAD_ENCAP_ENABLED		= BIT(0),
 	IEEE80211_OFFLOAD_ENCAP_4ADDR		= BIT(1),
+	IEEE80211_OFFLOAD_DECAP_ENABLED		= BIT(2),
 };
 
 /**
@@ -2389,6 +2396,9 @@ struct ieee80211_txq {
  * @IEEE80211_HW_SUPPORTS_TX_ENCAP_OFFLOAD: Hardware supports tx encapsulation
  *	offload
  *
+ * @IEEE80211_HW_SUPPORTS_RX_DECAP_OFFLOAD: Hardware supports rx decapsulation
+ *	offload
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2442,6 +2452,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_SUPPORTS_ONLY_HE_MULTI_BSSID,
 	IEEE80211_HW_AMPDU_KEYBORDER_SUPPORT,
 	IEEE80211_HW_SUPPORTS_TX_ENCAP_OFFLOAD,
+	IEEE80211_HW_SUPPORTS_RX_DECAP_OFFLOAD,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
@@ -3880,6 +3891,8 @@ enum ieee80211_reconfig_type {
  *	This callback may sleep.
  * @sta_set_4addr: Called to notify the driver when a station starts/stops using
  *	4-address mode
+ * @sta_set_decap_offload: Called to notify the driver when a station is allowed
+ *	to use rx decapsulation offload
  */
 struct ieee80211_ops {
 	void (*tx)(struct ieee80211_hw *hw,
@@ -4197,6 +4210,9 @@ struct ieee80211_ops {
 			      struct ieee80211_sta *sta, bool enabled);
 	int (*set_sar_specs)(struct ieee80211_hw *hw,
 			     const struct cfg80211_sar_specs *sar);
+	void (*sta_set_decap_offload)(struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif,
+				      struct ieee80211_sta *sta, bool enabled);
 };
 
 /**
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 48f144f107d5..60e5994e3ea3 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -409,6 +409,7 @@ static const char *hw_flag_names[] = {
 	FLAG(SUPPORTS_ONLY_HE_MULTI_BSSID),
 	FLAG(AMPDU_KEYBORDER_SUPPORT),
 	FLAG(SUPPORTS_TX_ENCAP_OFFLOAD),
+	FLAG(SUPPORTS_RX_DECAP_OFFLOAD),
 #undef FLAG
 };
 
diff --git a/net/mac80211/debugfs_sta.c b/net/mac80211/debugfs_sta.c
index eb4bb79d936a..5a27c61a7b38 100644
--- a/net/mac80211/debugfs_sta.c
+++ b/net/mac80211/debugfs_sta.c
@@ -79,6 +79,7 @@ static const char * const sta_flag_names[] = {
 	FLAG(MPSP_RECIPIENT),
 	FLAG(PS_DELIVER),
 	FLAG(USES_ENCRYPTION),
+	FLAG(DECAP_OFFLOAD),
 #undef FLAG
 };
 
diff --git a/net/mac80211/driver-ops.h b/net/mac80211/driver-ops.h
index bcdfd19a596b..604ca59937f0 100644
--- a/net/mac80211/driver-ops.h
+++ b/net/mac80211/driver-ops.h
@@ -1413,4 +1413,20 @@ static inline void drv_sta_set_4addr(struct ieee80211_local *local,
 	trace_drv_return_void(local);
 }
 
+static inline void drv_sta_set_decap_offload(struct ieee80211_local *local,
+					     struct ieee80211_sub_if_data *sdata,
+					     struct ieee80211_sta *sta,
+					     bool enabled)
+{
+	sdata = get_bss_sdata(sdata);
+	if (!check_sdata_in_driver(sdata))
+		return;
+
+	trace_drv_sta_set_decap_offload(local, sdata, sta, enabled);
+	if (local->ops->sta_set_decap_offload)
+		local->ops->sta_set_decap_offload(&local->hw, &sdata->vif, sta,
+						  enabled);
+	trace_drv_return_void(local);
+}
+
 #endif /* __MAC80211_DRIVER_OPS */
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 3b9ec4ef81c3..1b44690823aa 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -765,7 +765,7 @@ static const struct net_device_ops ieee80211_dataif_8023_ops = {
 	.ndo_get_stats64	= ieee80211_get_stats64,
 };
 
-static bool ieee80211_iftype_supports_encap_offload(enum nl80211_iftype iftype)
+static bool ieee80211_iftype_supports_hdr_offload(enum nl80211_iftype iftype)
 {
 	switch (iftype) {
 	/* P2P GO and client are mapped to AP/STATION types */
@@ -785,7 +785,7 @@ static bool ieee80211_set_sdata_offload_flags(struct ieee80211_sub_if_data *sdat
 	flags = sdata->vif.offload_flags;
 
 	if (ieee80211_hw_check(&local->hw, SUPPORTS_TX_ENCAP_OFFLOAD) &&
-	    ieee80211_iftype_supports_encap_offload(sdata->vif.type)) {
+	    ieee80211_iftype_supports_hdr_offload(sdata->vif.type)) {
 		flags |= IEEE80211_OFFLOAD_ENCAP_ENABLED;
 
 		if (!ieee80211_hw_check(&local->hw, SUPPORTS_TX_FRAG) &&
@@ -798,10 +798,21 @@ static bool ieee80211_set_sdata_offload_flags(struct ieee80211_sub_if_data *sdat
 		flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
 	}
 
+	if (ieee80211_hw_check(&local->hw, SUPPORTS_RX_DECAP_OFFLOAD) &&
+	    ieee80211_iftype_supports_hdr_offload(sdata->vif.type)) {
+		flags |= IEEE80211_OFFLOAD_DECAP_ENABLED;
+
+		if (local->monitors)
+			flags &= ~IEEE80211_OFFLOAD_DECAP_ENABLED;
+	} else {
+		flags &= ~IEEE80211_OFFLOAD_DECAP_ENABLED;
+	}
+
 	if (sdata->vif.offload_flags == flags)
 		return false;
 
 	sdata->vif.offload_flags = flags;
+	ieee80211_check_fast_rx_iface(sdata);
 	return true;
 }
 
@@ -819,7 +830,7 @@ static void ieee80211_set_vif_encap_ops(struct ieee80211_sub_if_data *sdata)
 	}
 
 	if (!ieee80211_hw_check(&local->hw, SUPPORTS_TX_ENCAP_OFFLOAD) ||
-	    !ieee80211_iftype_supports_encap_offload(bss->vif.type))
+	    !ieee80211_iftype_supports_hdr_offload(bss->vif.type))
 		return;
 
 	enabled = bss->vif.offload_flags & IEEE80211_OFFLOAD_ENCAP_ENABLED;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 972895e9f22d..c1343c028b76 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4095,7 +4095,9 @@ void ieee80211_check_fast_rx(struct sta_info *sta)
 		.vif_type = sdata->vif.type,
 		.control_port_protocol = sdata->control_port_protocol,
 	}, *old, *new = NULL;
+	bool set_offload = false;
 	bool assign = false;
+	bool offload;
 
 	/* use sparse to check that we don't return without updating */
 	__acquire(check_fast_rx);
@@ -4208,6 +4210,17 @@ void ieee80211_check_fast_rx(struct sta_info *sta)
 	if (assign)
 		new = kmemdup(&fastrx, sizeof(fastrx), GFP_KERNEL);
 
+	offload = assign &&
+		  (sdata->vif.offload_flags & IEEE80211_OFFLOAD_DECAP_ENABLED);
+
+	if (offload)
+		set_offload = !test_and_set_sta_flag(sta, WLAN_STA_DECAP_OFFLOAD);
+	else
+		set_offload = test_and_clear_sta_flag(sta, WLAN_STA_DECAP_OFFLOAD);
+
+	if (set_offload)
+		drv_sta_set_decap_offload(local, sdata, &sta->sta, assign);
+
 	spin_lock_bh(&sta->lock);
 	old = rcu_dereference_protected(sta->fast_rx, true);
 	rcu_assign_pointer(sta->fast_rx, new);
@@ -4254,6 +4267,104 @@ void ieee80211_check_fast_rx_iface(struct ieee80211_sub_if_data *sdata)
 	mutex_unlock(&local->sta_mtx);
 }
 
+static void ieee80211_rx_8023(struct ieee80211_rx_data *rx,
+			      struct ieee80211_fast_rx *fast_rx,
+			      int orig_len)
+{
+	struct ieee80211_sta_rx_stats *stats;
+	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(rx->skb);
+	struct sta_info *sta = rx->sta;
+	struct sk_buff *skb = rx->skb;
+	void *sa = skb->data + ETH_ALEN;
+	void *da = skb->data;
+
+	stats = &sta->rx_stats;
+	if (fast_rx->uses_rss)
+		stats = this_cpu_ptr(sta->pcpu_rx_stats);
+
+	/* statistics part of ieee80211_rx_h_sta_process() */
+	if (!(status->flag & RX_FLAG_NO_SIGNAL_VAL)) {
+		stats->last_signal = status->signal;
+		if (!fast_rx->uses_rss)
+			ewma_signal_add(&sta->rx_stats_avg.signal,
+					-status->signal);
+	}
+
+	if (status->chains) {
+		int i;
+
+		stats->chains = status->chains;
+		for (i = 0; i < ARRAY_SIZE(status->chain_signal); i++) {
+			int signal = status->chain_signal[i];
+
+			if (!(status->chains & BIT(i)))
+				continue;
+
+			stats->chain_signal_last[i] = signal;
+			if (!fast_rx->uses_rss)
+				ewma_signal_add(&sta->rx_stats_avg.chain_signal[i],
+						-signal);
+		}
+	}
+	/* end of statistics */
+
+	stats->last_rx = jiffies;
+	stats->last_rate = sta_stats_encode_rate(status);
+
+	stats->fragments++;
+	stats->packets++;
+
+	skb->dev = fast_rx->dev;
+
+	dev_sw_netstats_rx_add(fast_rx->dev, skb->len);
+
+	/* The seqno index has the same property as needed
+	 * for the rx_msdu field, i.e. it is IEEE80211_NUM_TIDS
+	 * for non-QoS-data frames. Here we know it's a data
+	 * frame, so count MSDUs.
+	 */
+	u64_stats_update_begin(&stats->syncp);
+	stats->msdu[rx->seqno_idx]++;
+	stats->bytes += orig_len;
+	u64_stats_update_end(&stats->syncp);
+
+	if (fast_rx->internal_forward) {
+		struct sk_buff *xmit_skb = NULL;
+		if (is_multicast_ether_addr(da)) {
+			xmit_skb = skb_copy(skb, GFP_ATOMIC);
+		} else if (!ether_addr_equal(da, sa) &&
+			   sta_info_get(rx->sdata, da)) {
+			xmit_skb = skb;
+			skb = NULL;
+		}
+
+		if (xmit_skb) {
+			/*
+			 * Send to wireless media and increase priority by 256
+			 * to keep the received priority instead of
+			 * reclassifying the frame (see cfg80211_classify8021d).
+			 */
+			xmit_skb->priority += 256;
+			xmit_skb->protocol = htons(ETH_P_802_3);
+			skb_reset_network_header(xmit_skb);
+			skb_reset_mac_header(xmit_skb);
+			dev_queue_xmit(xmit_skb);
+		}
+
+		if (!skb)
+			return;
+	}
+
+	/* deliver to local stack */
+	skb->protocol = eth_type_trans(skb, fast_rx->dev);
+	memset(skb->cb, 0, sizeof(skb->cb));
+	if (rx->list)
+		list_add_tail(&skb->list, rx->list);
+	else
+		netif_receive_skb(skb);
+
+}
+
 static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 				     struct ieee80211_fast_rx *fast_rx)
 {
@@ -4274,9 +4385,6 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 	} addrs __aligned(2);
 	struct ieee80211_sta_rx_stats *stats = &sta->rx_stats;
 
-	if (fast_rx->uses_rss)
-		stats = this_cpu_ptr(sta->pcpu_rx_stats);
-
 	/* for parallel-rx, we need to have DUP_VALIDATED, otherwise we write
 	 * to a common data structure; drivers can implement that per queue
 	 * but we don't have that information in mac80211
@@ -4350,32 +4458,6 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 	    pskb_trim(skb, skb->len - fast_rx->icv_len))
 		goto drop;
 
-	/* statistics part of ieee80211_rx_h_sta_process() */
-	if (!(status->flag & RX_FLAG_NO_SIGNAL_VAL)) {
-		stats->last_signal = status->signal;
-		if (!fast_rx->uses_rss)
-			ewma_signal_add(&sta->rx_stats_avg.signal,
-					-status->signal);
-	}
-
-	if (status->chains) {
-		int i;
-
-		stats->chains = status->chains;
-		for (i = 0; i < ARRAY_SIZE(status->chain_signal); i++) {
-			int signal = status->chain_signal[i];
-
-			if (!(status->chains & BIT(i)))
-				continue;
-
-			stats->chain_signal_last[i] = signal;
-			if (!fast_rx->uses_rss)
-				ewma_signal_add(&sta->rx_stats_avg.chain_signal[i],
-						-signal);
-		}
-	}
-	/* end of statistics */
-
 	if (rx->key && !ieee80211_has_protected(hdr->frame_control))
 		goto drop;
 
@@ -4387,12 +4469,6 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 		return true;
 	}
 
-	stats->last_rx = jiffies;
-	stats->last_rate = sta_stats_encode_rate(status);
-
-	stats->fragments++;
-	stats->packets++;
-
 	/* do the header conversion - first grab the addresses */
 	ether_addr_copy(addrs.da, skb->data + fast_rx->da_offs);
 	ether_addr_copy(addrs.sa, skb->data + fast_rx->sa_offs);
@@ -4401,58 +4477,14 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
 	/* push the addresses in front */
 	memcpy(skb_push(skb, sizeof(addrs)), &addrs, sizeof(addrs));
 
-	skb->dev = fast_rx->dev;
-
-	dev_sw_netstats_rx_add(fast_rx->dev, skb->len);
-
-	/* The seqno index has the same property as needed
-	 * for the rx_msdu field, i.e. it is IEEE80211_NUM_TIDS
-	 * for non-QoS-data frames. Here we know it's a data
-	 * frame, so count MSDUs.
-	 */
-	u64_stats_update_begin(&stats->syncp);
-	stats->msdu[rx->seqno_idx]++;
-	stats->bytes += orig_len;
-	u64_stats_update_end(&stats->syncp);
-
-	if (fast_rx->internal_forward) {
-		struct sk_buff *xmit_skb = NULL;
-		if (is_multicast_ether_addr(addrs.da)) {
-			xmit_skb = skb_copy(skb, GFP_ATOMIC);
-		} else if (!ether_addr_equal(addrs.da, addrs.sa) &&
-			   sta_info_get(rx->sdata, addrs.da)) {
-			xmit_skb = skb;
-			skb = NULL;
-		}
-
-		if (xmit_skb) {
-			/*
-			 * Send to wireless media and increase priority by 256
-			 * to keep the received priority instead of
-			 * reclassifying the frame (see cfg80211_classify8021d).
-			 */
-			xmit_skb->priority += 256;
-			xmit_skb->protocol = htons(ETH_P_802_3);
-			skb_reset_network_header(xmit_skb);
-			skb_reset_mac_header(xmit_skb);
-			dev_queue_xmit(xmit_skb);
-		}
-
-		if (!skb)
-			return true;
-	}
-
-	/* deliver to local stack */
-	skb->protocol = eth_type_trans(skb, fast_rx->dev);
-	memset(skb->cb, 0, sizeof(skb->cb));
-	if (rx->list)
-		list_add_tail(&skb->list, rx->list);
-	else
-		netif_receive_skb(skb);
+	ieee80211_rx_8023(rx, fast_rx, orig_len);
 
 	return true;
  drop:
 	dev_kfree_skb(skb);
+	if (fast_rx->uses_rss)
+		stats = this_cpu_ptr(sta->pcpu_rx_stats);
+
 	stats->dropped++;
 	return true;
 }
@@ -4506,6 +4538,43 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 	return true;
 }
 
+static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
+				       struct ieee80211_sta *pubsta,
+				       struct sk_buff *skb,
+				       struct list_head *list)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct ieee80211_fast_rx *fast_rx;
+	struct ieee80211_rx_data rx;
+
+	memset(&rx, 0, sizeof(rx));
+	rx.skb = skb;
+	rx.local = local;
+	rx.list = list;
+
+	I802_DEBUG_INC(local->dot11ReceivedFragmentCount);
+
+	/* drop frame if too short for header */
+	if (skb->len < sizeof(struct ethhdr))
+		goto drop;
+
+	if (!pubsta)
+		goto drop;
+
+	rx.sta = container_of(pubsta, struct sta_info, sta);
+	rx.sdata = rx.sta->sdata;
+
+	fast_rx = rcu_dereference(rx.sta->fast_rx);
+	if (!fast_rx)
+		goto drop;
+
+	ieee80211_rx_8023(&rx, fast_rx, skb->len);
+	return;
+
+drop:
+	dev_kfree_skb(skb);
+}
+
 /*
  * This is the actual Rx frames handler. as it belongs to Rx path it must
  * be called with rcu_read_lock protection.
@@ -4737,13 +4806,17 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 	 * if it was previously present.
 	 * Also, frames with less than 16 bytes are dropped.
 	 */
-	skb = ieee80211_rx_monitor(local, skb, rate);
+	if (!(status->flag & RX_FLAG_8023))
+		skb = ieee80211_rx_monitor(local, skb, rate);
 	if (skb) {
 		ieee80211_tpt_led_trig_rx(local,
 					  ((struct ieee80211_hdr *)skb->data)->frame_control,
 					  skb->len);
 
-		__ieee80211_rx_handle_packet(hw, pubsta, skb, list);
+		if (status->flag & RX_FLAG_8023)
+			__ieee80211_rx_handle_8023(hw, pubsta, skb, list);
+		else
+			__ieee80211_rx_handle_packet(hw, pubsta, skb, list);
 	}
 
 	kcov_remote_stop();
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 7afd07636b81..78b9d0c7cc58 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -71,6 +71,7 @@
  *	until pending frames are delivered
  * @WLAN_STA_USES_ENCRYPTION: This station was configured for encryption,
  *	so drop all packets without a key later.
+ * @WLAN_STA_DECAP_OFFLOAD: This station uses rx decap offload
  *
  * @NUM_WLAN_STA_FLAGS: number of defined flags
  */
@@ -102,6 +103,7 @@ enum ieee80211_sta_info_flags {
 	WLAN_STA_MPSP_RECIPIENT,
 	WLAN_STA_PS_DELIVER,
 	WLAN_STA_USES_ENCRYPTION,
+	WLAN_STA_DECAP_OFFLOAD,
 
 	NUM_WLAN_STA_FLAGS,
 };
diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
index 601322e16957..8fcc39056402 100644
--- a/net/mac80211/trace.h
+++ b/net/mac80211/trace.h
@@ -2761,7 +2761,7 @@ DEFINE_EVENT(local_sdata_addr_evt, drv_update_vif_offload,
 	TP_ARGS(local, sdata)
 );
 
-TRACE_EVENT(drv_sta_set_4addr,
+DECLARE_EVENT_CLASS(sta_flag_evt,
 	TP_PROTO(struct ieee80211_local *local,
 		 struct ieee80211_sub_if_data *sdata,
 		 struct ieee80211_sta *sta, bool enabled),
@@ -2788,6 +2788,22 @@ TRACE_EVENT(drv_sta_set_4addr,
 	)
 );
 
+DEFINE_EVENT(sta_flag_evt, drv_sta_set_4addr,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 struct ieee80211_sta *sta, bool enabled),
+
+	TP_ARGS(local, sdata, sta, enabled)
+);
+
+DEFINE_EVENT(sta_flag_evt, drv_sta_set_decap_offload,
+	TP_PROTO(struct ieee80211_local *local,
+		 struct ieee80211_sub_if_data *sdata,
+		 struct ieee80211_sta *sta, bool enabled),
+
+	TP_ARGS(local, sdata, sta, enabled)
+);
+
 #endif /* !__MAC80211_DRIVER_TRACE || TRACE_HEADER_MULTI_READ */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.28.0

