Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D80B108B53
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2019 11:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfKYKEs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Nov 2019 05:04:48 -0500
Received: from nbd.name ([46.4.11.11]:38860 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727316AbfKYKEs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Nov 2019 05:04:48 -0500
Received: from p5dcfb8d8.dip0.t-ipconnect.de ([93.207.184.216] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1iZBEa-0001Rq-Ao; Mon, 25 Nov 2019 11:04:44 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        John Crispin <john@phrozen.org>,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
Subject: [PATCH V10 1/2] mac80211: add hw 80211 encapsulation offloading support
Date:   Mon, 25 Nov 2019 11:04:37 +0100
Message-Id: <20191125100438.16539-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds a new transmit path for hardware that supports 802.11
encapsulation offloading. In those cases 802.3 frames get passed
directly to the driver allowing the hardware to handle the encapsulation.
Some features such as monitor mode and TKIP would break when encapsulation
offloading is enabled. If any of these get enabled, the code will alwyas
fallback to the normal sw encapsulation data path.

The patch defines a secondary netdev_ops struct that the device gets
assigned if 802.11 encap support is available and enabled. The driver
needs to enable the support on a per vif basis if it finds that all
pre-reqs are meet.

Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
Signed-off-by: John Crispin <john@phrozen.org>
---
 include/net/mac80211.h     |  36 ++++++++
 net/mac80211/debugfs.c     |   1 +
 net/mac80211/ieee80211_i.h |   9 ++
 net/mac80211/iface.c       |  74 ++++++++++++++++
 net/mac80211/key.c         |  10 +++
 net/mac80211/status.c      |  74 ++++++++++++++++
 net/mac80211/tx.c          | 176 ++++++++++++++++++++++++++++++++++++-
 7 files changed, 376 insertions(+), 4 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index aa145808e57a..d4298d4f99c6 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -826,6 +826,7 @@ enum mac80211_tx_control_flags {
 	IEEE80211_TX_CTRL_AMSDU			= BIT(3),
 	IEEE80211_TX_CTRL_FAST_XMIT		= BIT(4),
 	IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP	= BIT(5),
+	IEEE80211_TX_CTRL_HW_80211_ENCAP	= BIT(6),
 };
 
 /*
@@ -2302,6 +2303,9 @@ struct ieee80211_txq {
  *	aggregating MPDUs with the same keyid, allowing mac80211 to keep Tx
  *	A-MPDU sessions active while rekeying with Extended Key ID.
  *
+ * @IEEE80211_HW_SUPPORTS_80211_ENCAP: Hardware/driver supports 802.11
+ *	encap for data frames.
+ *
  * @NUM_IEEE80211_HW_FLAGS: number of hardware flags, used for sizing arrays
  */
 enum ieee80211_hw_flags {
@@ -2354,6 +2358,7 @@ enum ieee80211_hw_flags {
 	IEEE80211_HW_SUPPORTS_MULTI_BSSID,
 	IEEE80211_HW_SUPPORTS_ONLY_HE_MULTI_BSSID,
 	IEEE80211_HW_AMPDU_KEYBORDER_SUPPORT,
+	IEEE80211_HW_SUPPORTS_80211_ENCAP,
 
 	/* keep last, obviously */
 	NUM_IEEE80211_HW_FLAGS
@@ -4660,6 +4665,26 @@ static inline void ieee80211_tx_status_ni(struct ieee80211_hw *hw,
 void ieee80211_tx_status_irqsafe(struct ieee80211_hw *hw,
 				 struct sk_buff *skb);
 
+/**
+ * ieee80211_tx_status_8023 - transmit status callback for 802.3 frame format
+ *
+ * Call this function for all transmitted data frames after their transmit
+ * completion. This callback should only be called for data frames which
+ * are are using driver's (or hardware's) offload capability of encap/decap
+ * 802.11 frames.
+ *
+ * This function may not be called in IRQ context. Calls to this function
+ * for a single hardware must be synchronized against each other and all
+ * calls in the same tx status family.
+ *
+ * @hw: the hardware the frame was transmitted by
+ * @vif: the interface for which the frame was transmitted
+ * @skb: the frame that was transmitted, owned by mac80211 after this call
+ */
+void ieee80211_tx_status_8023(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct sk_buff *skb);
+
 /**
  * ieee80211_report_low_ack - report non-responding station
  *
@@ -6480,5 +6505,16 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
 u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
 			      struct ieee80211_tx_info *info,
 			      int len);
+/**
+ * ieee80211_set_hw_80211_encap - enable hardware encapsulation offloading.
+ *
+ * This function is used to notify mac80211 that a vif can be passed raw 802.3.
+ * The driver needs to then handle the 802.11 encapsulation inside the hardware
+ * or firmware.
+ *
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @enable: indicate if the feature should be turned on or off
+ */
+bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable);
 
 #endif /* MAC80211_H */
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index ad41d74530c6..c963b70c6ab7 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -355,6 +355,7 @@ static const char *hw_flag_names[] = {
 	FLAG(SUPPORTS_MULTI_BSSID),
 	FLAG(SUPPORTS_ONLY_HE_MULTI_BSSID),
 	FLAG(AMPDU_KEYBORDER_SUPPORT),
+	FLAG(SUPPORTS_80211_ENCAP),
 #undef FLAG
 };
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index ad15b3be8bb3..e3cf24cb4615 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -984,6 +984,8 @@ struct ieee80211_sub_if_data {
 	} debugfs;
 #endif
 
+	bool hw_80211_encap;
+
 	/* must be last, dynamically sized area in this! */
 	struct ieee80211_vif vif;
 };
@@ -1762,6 +1764,8 @@ netdev_tx_t ieee80211_monitor_start_xmit(struct sk_buff *skb,
 					 struct net_device *dev);
 netdev_tx_t ieee80211_subif_start_xmit(struct sk_buff *skb,
 				       struct net_device *dev);
+netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
+					    struct net_device *dev);
 void __ieee80211_subif_start_xmit(struct sk_buff *skb,
 				  struct net_device *dev,
 				  u32 info_flags,
@@ -1948,6 +1952,11 @@ void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
 				 struct sk_buff *skb, int tid,
 				 enum nl80211_band band, u32 txdata_flags);
 
+/* sta_out needs to be checked for ERR_PTR() before using */
+int ieee80211_lookup_ra_sta(struct ieee80211_sub_if_data *sdata,
+			    struct sk_buff *skb,
+			    struct sta_info **sta_out);
+
 static inline void
 ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
 			  struct sk_buff *skb, int tid,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index af8b09214786..6cbbd8f8ae12 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1205,6 +1205,79 @@ static const struct net_device_ops ieee80211_monitorif_ops = {
 	.ndo_get_stats64	= ieee80211_get_stats64,
 };
 
+static const struct net_device_ops ieee80211_dataif_8023_ops = {
+	.ndo_open		= ieee80211_open,
+	.ndo_stop		= ieee80211_stop,
+	.ndo_uninit		= ieee80211_uninit,
+	.ndo_start_xmit		= ieee80211_subif_start_xmit_8023,
+	.ndo_set_rx_mode	= ieee80211_set_multicast_list,
+	.ndo_set_mac_address	= ieee80211_change_mac,
+	.ndo_select_queue	= ieee80211_netdev_select_queue,
+	.ndo_get_stats64	= ieee80211_get_stats64,
+};
+
+static void __ieee80211_set_hw_80211_encap(struct ieee80211_sub_if_data *sdata,
+					   bool enable)
+{
+	if (enable) {
+		sdata->dev->netdev_ops = &ieee80211_dataif_8023_ops;
+		sdata->hw_80211_encap = true;
+	} else {
+		sdata->dev->netdev_ops = &ieee80211_dataif_ops;
+		sdata->hw_80211_encap = false;
+	}
+}
+
+bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable)
+{
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_sub_if_data *iter;
+	struct ieee80211_key *key;
+
+	mutex_lock(&local->iflist_mtx);
+	list_for_each_entry(iter, &local->interfaces, list) {
+		struct ieee80211_sub_if_data *disable = NULL;
+
+		if (vif->type == NL80211_IFTYPE_MONITOR) {
+			disable = iter;
+			__ieee80211_set_hw_80211_encap(iter, false);
+		} else if (iter->vif.type == NL80211_IFTYPE_MONITOR) {
+			disable = sdata;
+			enable = false;
+		}
+		if (disable)
+			sdata_dbg(disable,
+				  "disable hw 80211 encap due to mon co-exist\n");
+	}
+	mutex_unlock(&local->iflist_mtx);
+
+	if (enable == sdata->hw_80211_encap)
+		return enable;
+
+	if (!sdata->dev)
+		return false;
+
+	if (!ieee80211_hw_check(&local->hw, SUPPORTS_80211_ENCAP))
+		enable = false;
+
+	if (!ieee80211_hw_check(&local->hw, SUPPORTS_TX_FRAG) &&
+	    (local->hw.wiphy->frag_threshold != (u32)-1))
+		enable = false;
+
+	mutex_lock(&sdata->local->key_mtx);
+	list_for_each_entry(key, &sdata->key_list, list) {
+		if (key->conf.cipher == WLAN_CIPHER_SUITE_TKIP)
+			enable = false;
+	}
+	mutex_unlock(&sdata->local->key_mtx);
+
+	__ieee80211_set_hw_80211_encap(sdata, enable);
+
+	return enable;
+}
+EXPORT_SYMBOL(ieee80211_set_hw_80211_encap);
+
 static void ieee80211_if_free(struct net_device *dev)
 {
 	free_percpu(dev->tstats);
@@ -1404,6 +1477,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
 	sdata->vif.bss_conf.idle = true;
 
 	sdata->noack_map = 0;
+	sdata->hw_80211_encap = false;
 
 	/* only monitor/p2p-device differ */
 	if (sdata->dev) {
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 0f889b919b06..64adfecdf583 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -177,6 +177,13 @@ static int ieee80211_key_enable_hw_accel(struct ieee80211_key *key)
 		}
 	}
 
+	/* TKIP countermeasures don't work in encap offload mode */
+	if (key->conf.cipher == WLAN_CIPHER_SUITE_TKIP &&
+	    sdata->hw_80211_encap) {
+		sdata_dbg(sdata, "TKIP is not allowed in hw 80211 encap mode\n");
+		return -EINVAL;
+	}
+
 	ret = drv_set_key(key->local, SET_KEY, sdata,
 			  sta ? &sta->sta : NULL, &key->conf);
 
@@ -203,6 +210,9 @@ static int ieee80211_key_enable_hw_accel(struct ieee80211_key *key)
 			  key->conf.keyidx,
 			  sta ? sta->sta.addr : bcast_addr, ret);
 
+	if (sdata->hw_80211_encap)
+		return -EINVAL;
+
  out_unsupported:
 	switch (key->conf.cipher) {
 	case WLAN_CIPHER_SUITE_WEP40:
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index b720feaf9a74..c7ee843ab554 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -1198,6 +1198,80 @@ void ieee80211_tx_rate_update(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_tx_rate_update);
 
+void ieee80211_tx_status_8023(struct ieee80211_hw *hw,
+			      struct ieee80211_vif *vif,
+			      struct sk_buff *skb)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct sta_info *sta;
+	int retry_count;
+	int rates_idx;
+	bool acked;
+
+	if (WARN_ON(!ieee80211_hw_check(hw, SUPPORTS_80211_ENCAP)))
+		goto skip_stats_update;
+
+	sdata = vif_to_sdata(vif);
+
+	acked = info->flags & IEEE80211_TX_STAT_ACK;
+	rates_idx = ieee80211_tx_get_rates(hw, info, &retry_count);
+
+	rcu_read_lock();
+
+	if (ieee80211_lookup_ra_sta(sdata, skb, &sta))
+		goto counters_update;
+
+	if (IS_ERR(sta))
+		goto counters_update;
+
+	if (!acked)
+		sta->status_stats.retry_failed++;
+
+	if (rates_idx != -1)
+		sta->tx_stats.last_rate = info->status.rates[rates_idx];
+
+	sta->status_stats.retry_count += retry_count;
+
+	if (ieee80211_hw_check(hw, REPORTS_TX_ACK_STATUS)) {
+		if (acked && vif->type == NL80211_IFTYPE_STATION)
+			ieee80211_sta_reset_conn_monitor(sdata);
+
+		sta->status_stats.last_ack = jiffies;
+		if (info->flags & IEEE80211_TX_STAT_ACK) {
+			if (sta->status_stats.lost_packets)
+				sta->status_stats.lost_packets = 0;
+
+			if (test_sta_flag(sta, WLAN_STA_TDLS_PEER_AUTH))
+				sta->status_stats.last_tdls_pkt_time = jiffies;
+		} else {
+			ieee80211_lost_packet(sta, info);
+		}
+	}
+
+counters_update:
+	rcu_read_unlock();
+	ieee80211_led_tx(local);
+
+	if (!(info->flags & IEEE80211_TX_STAT_ACK) &&
+	    !(info->flags & IEEE80211_TX_STAT_NOACK_TRANSMITTED))
+		goto skip_stats_update;
+
+	I802_DEBUG_INC(local->dot11TransmittedFrameCount);
+	if (is_multicast_ether_addr(skb->data))
+		I802_DEBUG_INC(local->dot11MulticastTransmittedFrameCount);
+	if (retry_count > 0)
+		I802_DEBUG_INC(local->dot11RetryCount);
+	if (retry_count > 1)
+		I802_DEBUG_INC(local->dot11MultipleRetryCount);
+
+skip_stats_update:
+	ieee80211_report_used_skb(local, skb, false);
+	dev_kfree_skb(skb);
+}
+EXPORT_SYMBOL(ieee80211_tx_status_8023);
+
 void ieee80211_report_low_ack(struct ieee80211_sta *pubsta, u32 num_packets)
 {
 	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index b696b9136f4c..af07418c8693 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1250,7 +1250,8 @@ static struct txq_info *ieee80211_get_txq(struct ieee80211_local *local,
 	    (info->control.flags & IEEE80211_TX_CTRL_PS_RESPONSE))
 		return NULL;
 
-	if (unlikely(!ieee80211_is_data_present(hdr->frame_control))) {
+	if (!(info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP) &&
+	    unlikely(!ieee80211_is_data_present(hdr->frame_control))) {
 		if ((!ieee80211_is_mgmt(hdr->frame_control) ||
 		     ieee80211_is_bufferable_mmpdu(hdr->frame_control) ||
 		     vif->type == NL80211_IFTYPE_STATION) &&
@@ -2351,9 +2352,9 @@ static inline bool ieee80211_is_tdls_setup(struct sk_buff *skb)
 	       skb->data[14] == WLAN_TDLS_SNAP_RFTYPE;
 }
 
-static int ieee80211_lookup_ra_sta(struct ieee80211_sub_if_data *sdata,
-				   struct sk_buff *skb,
-				   struct sta_info **sta_out)
+int ieee80211_lookup_ra_sta(struct ieee80211_sub_if_data *sdata,
+			    struct sk_buff *skb,
+			    struct sta_info **sta_out)
 {
 	struct sta_info *sta;
 
@@ -3607,6 +3608,9 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	else
 		info->flags &= ~IEEE80211_TX_CTL_AMPDU;
 
+	if (info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP)
+		goto encap_out;
+
 	if (info->control.flags & IEEE80211_TX_CTRL_FAST_XMIT) {
 		struct sta_info *sta = container_of(txq->sta, struct sta_info,
 						    sta);
@@ -3666,6 +3670,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 		break;
 	}
 
+encap_out:
 	IEEE80211_SKB_CB(skb)->control.vif = vif;
 
 	if (local->airtime_flags & AIRTIME_USE_AQL) {
@@ -4097,6 +4102,159 @@ netdev_tx_t ieee80211_subif_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+static bool ieee80211_tx_8023(struct ieee80211_sub_if_data *sdata,
+			      struct sk_buff *skb, int led_len,
+			      struct sta_info *sta,
+			      bool txpending)
+{
+	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_tx_control control = {};
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ieee80211_sta *pubsta = NULL;
+	unsigned long flags;
+	int q = info->hw_queue;
+
+	if (ieee80211_queue_skb(local, sdata, sta, skb))
+		return true;
+
+	spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
+
+	if (local->queue_stop_reasons[q] ||
+	    (!txpending && !skb_queue_empty(&local->pending[q]))) {
+		if (txpending)
+			skb_queue_head(&local->pending[q], skb);
+		else
+			skb_queue_tail(&local->pending[q], skb);
+
+		spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
+
+		return false;
+	}
+
+	spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
+
+	if (sta && sta->uploaded)
+		pubsta = &sta->sta;
+
+	control.sta = pubsta;
+
+	drv_tx(local, &control, skb);
+
+	return true;
+}
+
+static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
+				struct net_device *dev, struct sta_info *sta,
+				struct sk_buff *skb)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct ethhdr *ehdr = (struct ethhdr *)skb->data;
+	struct ieee80211_local *local = sdata->local;
+	bool authorized = false;
+	bool multicast;
+	bool tdls_peer;
+	unsigned char *ra = NULL;
+
+	if (IS_ERR(sta) || (sta && !sta->uploaded))
+		sta = NULL;
+
+	if (sdata->vif.type == NL80211_IFTYPE_STATION) {
+		tdls_peer = test_sta_flag(sta, WLAN_STA_TDLS_PEER);
+		if (tdls_peer)
+			ra = skb->data;
+		else
+			ra = sdata->u.mgd.bssid;
+	} else {
+		ra = ehdr->h_dest;
+	}
+
+	if (!ra)
+		goto out_free;
+	multicast = is_multicast_ether_addr(ra);
+
+	if (sta)
+		authorized = test_sta_flag(sta, WLAN_STA_AUTHORIZED);
+
+	if (!multicast && !authorized &&
+	    (ehdr->h_proto != sdata->control_port_protocol ||
+	     !ether_addr_equal(sdata->vif.addr, ehdr->h_source)))
+		goto out_free;
+
+	if (multicast && sdata->vif.type == NL80211_IFTYPE_AP &&
+	    !atomic_read(&sdata->u.ap.num_mcast_sta))
+		goto out_free;
+
+	if (unlikely(test_bit(SCAN_SW_SCANNING, &local->scanning)) &&
+	    test_bit(SDATA_STATE_OFFCHANNEL, &sdata->state))
+		goto out_free;
+
+	if (unlikely(!multicast && skb->sk &&
+		     skb_shinfo(skb)->tx_flags & SKBTX_WIFI_STATUS))
+		ieee80211_store_ack_skb(local, skb, &info->flags);
+
+	memset(info, 0, sizeof(*info));
+
+	if (unlikely(sdata->control_port_protocol == ehdr->h_proto)) {
+		if (sdata->control_port_no_encrypt)
+			info->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT;
+		info->control.flags |= IEEE80211_TX_CTRL_PORT_CTRL_PROTO;
+	}
+
+	if (multicast)
+		info->flags |= IEEE80211_TX_CTL_NO_ACK;
+
+	info->hw_queue = sdata->vif.hw_queue[skb_get_queue_mapping(skb)];
+
+	ieee80211_tx_stats(dev, skb->len);
+
+	if (sta) {
+		sta->tx_stats.bytes[skb_get_queue_mapping(skb)] += skb->len;
+		sta->tx_stats.packets[skb_get_queue_mapping(skb)]++;
+	}
+
+	if (sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+		sdata = container_of(sdata->bss,
+				     struct ieee80211_sub_if_data, u.ap);
+
+	info->control.flags |= IEEE80211_TX_CTRL_HW_80211_ENCAP;
+	info->control.vif = &sdata->vif;
+
+	ieee80211_tx_8023(sdata, skb, skb->len, sta, false);
+
+	return;
+
+out_free:
+	kfree_skb(skb);
+}
+
+netdev_tx_t ieee80211_subif_start_xmit_8023(struct sk_buff *skb,
+					    struct net_device *dev)
+{
+	struct ieee80211_sub_if_data *sdata = IEEE80211_DEV_TO_SUB_IF(dev);
+	struct sta_info *sta;
+
+	if (WARN_ON(!sdata->hw_80211_encap)) {
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
+	if (unlikely(skb->len < ETH_HLEN)) {
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
+	rcu_read_lock();
+
+	if (ieee80211_lookup_ra_sta(sdata, skb, &sta))
+		kfree_skb(skb);
+	else
+		ieee80211_8023_xmit(sdata, dev, sta, skb);
+
+	rcu_read_unlock();
+
+	return NETDEV_TX_OK;
+}
+
 struct sk_buff *
 ieee80211_build_data_template(struct ieee80211_sub_if_data *sdata,
 			      struct sk_buff *skb, u32 info_flags)
@@ -4175,6 +4333,16 @@ static bool ieee80211_tx_pending_skb(struct ieee80211_local *local,
 		}
 		info->band = chanctx_conf->def.chan->band;
 		result = ieee80211_tx(sdata, NULL, skb, true, 0);
+	} else if (info->control.flags & IEEE80211_TX_CTRL_HW_80211_ENCAP) {
+		if (ieee80211_lookup_ra_sta(sdata, skb, &sta)) {
+			dev_kfree_skb(skb);
+			return true;
+		}
+
+		if (IS_ERR(sta) || (sta && !sta->uploaded))
+			sta = NULL;
+
+		result = ieee80211_tx_8023(sdata, skb, skb->len, sta, true);
 	} else {
 		struct sk_buff_head skbs;
 
-- 
2.20.1

