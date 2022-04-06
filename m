Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8664F63D6
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 17:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236309AbiDFPjO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 11:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbiDFPiP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 11:38:15 -0400
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3592F2301
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 05:52:30 -0700 (PDT)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nc4Tg-000pov-PR;
        Wed, 06 Apr 2022 15:09:38 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net, kvalo@kernel.org
Cc:     luca@coelho.fi, gregory.greenman@intel.com,
        linux-wireless@vger.kernel.org
Date:   Wed,  6 Apr 2022 15:09:23 +0300
Message-Id: <iwlwifi.20220406145756.8c67d9d16b62.Ib11def78ef30a308f73602338b8c17d4a781a433@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220406120924.979792-1-luca@coelho.fi>
References: <20220406120924.979792-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 6/7] mac80211: add hardware timestamps for RX and TX
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

When the low level driver reports hardware timestamps for frame
TX status or frame RX, pass the timestamps to cfg80211.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/mac80211.h | 30 +++++++++++++++++++++++++++++-
 net/mac80211/rx.c      | 32 ++++++++++++++++++++++++--------
 net/mac80211/status.c  | 40 ++++++++++++++++++++++++++++++----------
 3 files changed, 83 insertions(+), 19 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 382ebb862ea8..1d18c005a4e9 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -125,6 +125,22 @@
  * via the usual ieee80211_tx_dequeue).
  */
 
+/**
+ * DOC: HW timestamping
+ *
+ * Timing Measurement and Fine Timing Measurement require accurate timestamps
+ * of the action frames TX/RX and their respective acks.
+ *
+ * To report hardware timestamps for Timing Measurement or Fine Timing
+ * Measurement frame RX, the low level driver should set the SKB's hwtstamp
+ * field to the frame RX timestamp and report the ack TX timestamp in the
+ * ieee80211_rx_status struct.
+ *
+ * Similarly, To report hardware timestamps for Timing Measurement or Fine
+ * Timing Measurement frame TX, the driver should set the SKB's hwtstamp field
+ * to the frame TX timestamp and report the ack RX timestamp in the
+ * ieee80211_tx_status struct.
+ */
 struct device;
 
 /**
@@ -1151,6 +1167,10 @@ ieee80211_info_get_tx_time_est(struct ieee80211_tx_info *info)
  * @info: Basic tx status information
  * @skb: Packet skb (can be NULL if not provided by the driver)
  * @rate: The TX rate that was used when sending the packet
+ * @ack_hwtstamp: Hardware timestamp of the received ack in nanoseconds
+ *	Only needed for Timing measurement and Fine timing measurement action
+ *	frames. Only reported by devices that have the
+ *	%NL80211_EXT_FEATURE_HW_TIMESTAMP capability.
  * @free_list: list where processed skbs are stored to be free'd by the driver
  */
 struct ieee80211_tx_status {
@@ -1158,6 +1178,7 @@ struct ieee80211_tx_status {
 	struct ieee80211_tx_info *info;
 	struct sk_buff *skb;
 	struct rate_info *rate;
+	ktime_t ack_hwtstamp;
 	struct list_head *free_list;
 };
 
@@ -1393,6 +1414,10 @@ enum mac80211_rx_encoding {
  * 	(TSF) timer when the first data symbol (MPDU) arrived at the hardware.
  * @boottime_ns: CLOCK_BOOTTIME timestamp the frame was received at, this is
  *	needed only for beacons and probe responses that update the scan cache.
+ * @ack_tx_hwtstamp: Hardware timestamp for the ack TX in nanoseconds. Only
+ *	needed for Timing measurement and Fine timing measurement action frames.
+ *	Only reported by devices that have the %NL80211_EXT_FEATURE_HW_TIMESTAMP
+ *	capability.
  * @device_timestamp: arbitrary timestamp for the device, mac80211 doesn't use
  *	it but can store it and pass it back to the driver for synchronisation
  * @band: the active band when this frame was received
@@ -1426,7 +1451,10 @@ enum mac80211_rx_encoding {
  */
 struct ieee80211_rx_status {
 	u64 mactime;
-	u64 boottime_ns;
+	union {
+		u64 boottime_ns;
+		ktime_t ack_tx_hwtstamp;
+	};
 	u32 device_timestamp;
 	u32 ampdu_reference;
 	u32 flag;
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index beb6b92eb780..2d9c2a3370b2 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3586,7 +3586,11 @@ static ieee80211_rx_result debug_noinline
 ieee80211_rx_h_userspace_mgmt(struct ieee80211_rx_data *rx)
 {
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(rx->skb);
-	int sig = 0;
+	struct cfg80211_rx_info info = {
+		.freq = ieee80211_rx_status_to_khz(status),
+		.buf = rx->skb->data,
+		.len = rx->skb->len
+	};
 
 	/* skip known-bad action frames and return them in the next handler */
 	if (status->rx_flags & IEEE80211_RX_MALFORMED_ACTION_FRM)
@@ -3601,11 +3605,17 @@ ieee80211_rx_h_userspace_mgmt(struct ieee80211_rx_data *rx)
 
 	if (ieee80211_hw_check(&rx->local->hw, SIGNAL_DBM) &&
 	    !(status->flag & RX_FLAG_NO_SIGNAL_VAL))
-		sig = status->signal;
+		info.sig_dbm = status->signal;
+
+	if (wiphy_ext_feature_isset(rx->local->hw.wiphy,
+				    NL80211_EXT_FEATURE_HW_TIMESTAMP) &&
+	    (ieee80211_is_timing_measurement(rx->skb) ||
+	     ieee80211_is_ftm(rx->skb))) {
+		info.rx_tstamp = ktime_to_ns(skb_hwtstamps(rx->skb)->hwtstamp);
+		info.ack_tstamp = ktime_to_ns(status->ack_tx_hwtstamp);
+	}
 
-	if (cfg80211_rx_mgmt_khz(&rx->sdata->wdev,
-				 ieee80211_rx_status_to_khz(status), sig,
-				 rx->skb->data, rx->skb->len, 0)) {
+	if (cfg80211_rx_mgmt_ext(&rx->sdata->wdev, &info)) {
 		if (rx->sta)
 			rx->sta->rx_stats.packets++;
 		dev_kfree_skb(rx->skb);
@@ -4677,8 +4687,10 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 		return false;
 
 	if (!consume) {
-		skb = skb_copy(skb, GFP_ATOMIC);
-		if (!skb) {
+		struct skb_shared_hwtstamps *shwt;
+
+		rx->skb = skb_copy(skb, GFP_ATOMIC);
+		if (!rx->skb) {
 			if (net_ratelimit())
 				wiphy_debug(local->hw.wiphy,
 					"failed to copy skb for %s\n",
@@ -4686,7 +4698,11 @@ static bool ieee80211_prepare_and_rx_handle(struct ieee80211_rx_data *rx,
 			return true;
 		}
 
-		rx->skb = skb;
+		/* skb_copy() does not copy the hw timestamps, so copy it
+		 * explicitly
+		 */
+		shwt = skb_hwtstamps(rx->skb);
+		shwt->hwtstamp = skb_hwtstamps(skb)->hwtstamp;
 	}
 
 	ieee80211_invoke_rx_handlers(rx);
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index e81e8a5bb774..eb3c75a435f7 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -612,9 +612,11 @@ ieee80211_sdata_from_skb(struct ieee80211_local *local, struct sk_buff *skb)
 }
 
 static void ieee80211_report_ack_skb(struct ieee80211_local *local,
-				     struct ieee80211_tx_info *info,
-				     bool acked, bool dropped)
+				     struct sk_buff *orig_skb,
+				     bool acked, bool dropped,
+				     ktime_t ack_hwtstamp)
 {
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(orig_skb);
 	struct sk_buff *skb;
 	unsigned long flags;
 
@@ -631,6 +633,21 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 		struct ieee80211_hdr *hdr = (void *)skb->data;
 		bool is_valid_ack_signal =
 			!!(info->status.flags & IEEE80211_TX_STATUS_ACK_SIGNAL_VALID);
+		struct cfg80211_tx_status status = {
+			.cookie = cookie,
+			.buf = skb->data,
+			.len = skb->len,
+			.ack = acked,
+		};
+
+		if (wiphy_ext_feature_isset(local->hw.wiphy,
+					    NL80211_EXT_FEATURE_HW_TIMESTAMP) &&
+		    (ieee80211_is_timing_measurement(orig_skb) ||
+		     ieee80211_is_ftm(orig_skb))) {
+			status.tx_tstamp =
+				ktime_to_ns(skb_hwtstamps(orig_skb)->hwtstamp);
+			status.ack_tstamp = ktime_to_ns(ack_hwtstamp);
+		}
 
 		rcu_read_lock();
 		sdata = ieee80211_sdata_from_skb(local, skb);
@@ -650,9 +667,9 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 						      is_valid_ack_signal,
 						      GFP_ATOMIC);
 			else if (ieee80211_is_mgmt(hdr->frame_control))
-				cfg80211_mgmt_tx_status(&sdata->wdev, cookie,
-							skb->data, skb->len,
-							acked, GFP_ATOMIC);
+				cfg80211_mgmt_tx_status_ext(&sdata->wdev,
+							    &status,
+							    GFP_ATOMIC);
 			else
 				pr_warn("Unknown status report in ack skb\n");
 
@@ -669,7 +686,8 @@ static void ieee80211_report_ack_skb(struct ieee80211_local *local,
 }
 
 static void ieee80211_report_used_skb(struct ieee80211_local *local,
-				      struct sk_buff *skb, bool dropped)
+				      struct sk_buff *skb, bool dropped,
+				      ktime_t ack_hwtstamp)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	u16 tx_time_est = ieee80211_info_get_tx_time_est(info);
@@ -732,7 +750,8 @@ static void ieee80211_report_used_skb(struct ieee80211_local *local,
 
 		rcu_read_unlock();
 	} else if (info->ack_frame_id) {
-		ieee80211_report_ack_skb(local, info, acked, dropped);
+		ieee80211_report_ack_skb(local, skb, acked, dropped,
+					 ack_hwtstamp);
 	}
 
 	if (!dropped && skb->destructor) {
@@ -1047,7 +1066,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 			  jiffies + msecs_to_jiffies(10));
 	}
 
-	ieee80211_report_used_skb(local, skb, false);
+	ieee80211_report_used_skb(local, skb, false, status->ack_hwtstamp);
 
 	/* this was a transmitted frame, but now we want to reuse it */
 	skb_orphan(skb);
@@ -1212,7 +1231,7 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 	if (!skb)
 		return;
 
-	ieee80211_report_used_skb(local, skb, false);
+	ieee80211_report_used_skb(local, skb, false, status->ack_hwtstamp);
 	if (status->free_list)
 		list_add_tail(&skb->list, status->free_list);
 	else
@@ -1274,8 +1293,9 @@ EXPORT_SYMBOL(ieee80211_report_low_ack);
 void ieee80211_free_txskb(struct ieee80211_hw *hw, struct sk_buff *skb)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
+	ktime_t kt = ktime_set(0, 0);
 
-	ieee80211_report_used_skb(local, skb, true);
+	ieee80211_report_used_skb(local, skb, true, kt);
 	dev_kfree_skb_any(skb);
 }
 EXPORT_SYMBOL(ieee80211_free_txskb);
-- 
2.35.1

