Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57355F8C52
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Oct 2022 18:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJIQa4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Oct 2022 12:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiJIQay (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Oct 2022 12:30:54 -0400
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F7BC2125E
        for <linux-wireless@vger.kernel.org>; Sun,  9 Oct 2022 09:30:52 -0700 (PDT)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1665333048;
        bh=TAR08Tq9xIYmuBm947RAYnZNbnTa9GMtL0HlbtzVvcM=;
        h=From:To:Cc:Subject:Date;
        b=ZSCaKvC+Bjb846G5acFLsImGVKR77yKtB9yQk1muSNMmmyhW+hpedgbjK00h+pv1q
         J228D49C2dxkiVealMEQfHNEgi0DLM060acNaR7xeILIs7fFxPfTTQSNV2H1utoguv
         gsY8hqDNcLzxb1WAsSDCTDlUQ+sc1iGCOnx/FIjI=
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: [PATCH v2 1/3] wifi: mac80211: add internal handler for wake_tx_queue
Date:   Sun,  9 Oct 2022 18:30:38 +0200
Message-Id: <20221009163040.25637-1-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Start to align the TX handling to only use internal TX queues (iTXQs):

Provide a handler for drivers not having a custom wake_tx_queue
callback and update the documentation.

Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>
---

This is the v2 for "wifi: mac80211: Use internal TX queues for all drivers"
https://patchwork.kernel.org/project/linux-wireless/patch/20220926161303.13035-1-alexander@wetzel-home.de/

Changes compared to V1:
 - broken out the new wake_tx_queue handler as exported function
 - update drivers to provide wake_tx_queue instead handling it internally
 - Minor docu updates
 - Some sentences of the edited docu were referring to wrong netif
   functions. Fixed that with the edit, too.
 - added a comment explaining why we call ieee80211_next_txq()
 - removed now pointless checks for sta.txq

I gave the full series a quick run with the hostapd hwsim test suite,
still looks good for me.

While there is obvious something wrong with ieee80211_build_preq_ies() for
hwsim, that's unrelated to what we are doing here. (Multiple tests
trigger the WARN_ON() in ieee80211_get_he_6ghz_capa().)
---
 include/net/mac80211.h | 51 ++++++++++++++++++++++++++----------------
 net/mac80211/util.c    | 46 +++++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 19 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index ac2bad57933f..fbc27600951b 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -89,15 +89,13 @@
 /**
  * DOC: mac80211 software tx queueing
  *
- * mac80211 provides an optional intermediate queueing implementation designed
- * to allow the driver to keep hardware queues short and provide some fairness
- * between different stations/interfaces.
- * In this model, the driver pulls data frames from the mac80211 queue instead
- * of letting mac80211 push them via drv_tx().
- * Other frames (e.g. control or management) are still pushed using drv_tx().
+ * mac80211 uses an intermediate queueing implementation, designed to allow the
+ * driver to keep hardware queues short and to provide some fairness between
+ * different stations/interfaces.
  *
- * Drivers indicate that they use this model by implementing the .wake_tx_queue
- * driver operation.
+ * Drivers must provide the .wake_tx_queue driver operation by either
+ * linking it to ieee80211_handle_wake_tx_queue() or implementing a custom
+ * handler.
  *
  * Intermediate queues (struct ieee80211_txq) are kept per-sta per-tid, with
  * another per-sta for non-data/non-mgmt and bufferable management frames, and
@@ -106,9 +104,12 @@
  * The driver is expected to initialize its private per-queue data for stations
  * and interfaces in the .add_interface and .sta_add ops.
  *
- * The driver can't access the queue directly. To dequeue a frame from a
- * txq, it calls ieee80211_tx_dequeue(). Whenever mac80211 adds a new frame to a
- * queue, it calls the .wake_tx_queue driver op.
+ * The driver can't access the internal TX queues (iTXQs) directly.
+ * Whenever mac80211 adds a new frame to a queue, it calls the .wake_tx_queue
+ * driver op.
+ * Drivers implementing a custom .wake_tx_queue op can get them by calling
+ * ieee80211_tx_dequeue(). Drivers using ieee80211_handle_wake_tx_queue() will
+ * simply get the individual frames pushed via the .tx driver operation.
  *
  * Drivers can optionally delegate responsibility for scheduling queues to
  * mac80211, to take advantage of airtime fairness accounting. In this case, to
@@ -1826,7 +1827,7 @@ struct ieee80211_vif_cfg {
  *	for this interface.
  * @drv_priv: data area for driver use, will always be aligned to
  *	sizeof(void \*).
- * @txq: the multicast data TX queue (if driver uses the TXQ abstraction)
+ * @txq: the multicast data TX queue
  * @txqs_stopped: per AC flag to indicate that intermediate TXQs are stopped,
  *	protected by fq->lock.
  * @offload_flags: 802.3 -> 802.11 enapsulation offload flags, see
@@ -2252,8 +2253,8 @@ struct ieee80211_link_sta {
  *	For non MLO STA it will point to the deflink data. For MLO STA
  *	ieee80211_sta_recalc_aggregates() must be called to update it.
  * @support_p2p_ps: indicates whether the STA supports P2P PS mechanism or not.
- * @txq: per-TID data TX queues (if driver uses the TXQ abstraction); note that
- *	the last entry (%IEEE80211_NUM_TIDS) is used for non-data frames
+ * @txq: per-TID data TX queues; note that the last entry (%IEEE80211_NUM_TIDS)
+ *	is used for non-data frames
  * @deflink: This holds the default link STA information, for non MLO STA all link
  *	specific STA information is accessed through @deflink or through
  *	link[0] which points to address of @deflink. For MLO Link STA
@@ -5691,7 +5692,7 @@ void ieee80211_key_replay(struct ieee80211_key_conf *keyconf);
  * @hw: pointer as obtained from ieee80211_alloc_hw().
  * @queue: queue number (counted from zero).
  *
- * Drivers should use this function instead of netif_wake_queue.
+ * Drivers must use this function instead of netif_wake_queue.
  */
 void ieee80211_wake_queue(struct ieee80211_hw *hw, int queue);
 
@@ -5700,7 +5701,7 @@ void ieee80211_wake_queue(struct ieee80211_hw *hw, int queue);
  * @hw: pointer as obtained from ieee80211_alloc_hw().
  * @queue: queue number (counted from zero).
  *
- * Drivers should use this function instead of netif_stop_queue.
+ * Drivers must use this function instead of netif_stop_queue.
  */
 void ieee80211_stop_queue(struct ieee80211_hw *hw, int queue);
 
@@ -5709,7 +5710,7 @@ void ieee80211_stop_queue(struct ieee80211_hw *hw, int queue);
  * @hw: pointer as obtained from ieee80211_alloc_hw().
  * @queue: queue number (counted from zero).
  *
- * Drivers should use this function instead of netif_stop_queue.
+ * Drivers must use this function instead of netif_queue_stopped.
  *
  * Return: %true if the queue is stopped. %false otherwise.
  */
@@ -5720,7 +5721,7 @@ int ieee80211_queue_stopped(struct ieee80211_hw *hw, int queue);
  * ieee80211_stop_queues - stop all queues
  * @hw: pointer as obtained from ieee80211_alloc_hw().
  *
- * Drivers should use this function instead of netif_stop_queue.
+ * Drivers must use this function instead of netif_tx_stop_all_queues.
  */
 void ieee80211_stop_queues(struct ieee80211_hw *hw);
 
@@ -5728,7 +5729,7 @@ void ieee80211_stop_queues(struct ieee80211_hw *hw);
  * ieee80211_wake_queues - wake all queues
  * @hw: pointer as obtained from ieee80211_alloc_hw().
  *
- * Drivers should use this function instead of netif_wake_queue.
+ * Drivers must use this function instead of netif_tx_wake_all_queues.
  */
 void ieee80211_wake_queues(struct ieee80211_hw *hw);
 
@@ -6949,6 +6950,18 @@ static inline struct sk_buff *ieee80211_tx_dequeue_ni(struct ieee80211_hw *hw,
 	return skb;
 }
 
+/**
+ * ieee80211_handle_wake_tx_queue - mac80211 handler for wake_tx_queue callback
+ *
+ * @hw: pointer as obtained from wake_tx_queue() callback().
+ * @txq: pointer as obtained from wake_tx_queue() callback().
+ *
+ * Drivers can use this function for the mandatory mac80211 wake_tx_queue
+ * callback in struct ieee80211_ops.
+ */
+void ieee80211_handle_wake_tx_queue(struct ieee80211_hw *hw,
+				    struct ieee80211_txq *txq);
+
 /**
  * ieee80211_next_txq - get next tx queue to pull packets from
  *
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index bf7461c41bef..a7f9a2b3e683 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -288,6 +288,52 @@ __le16 ieee80211_ctstoself_duration(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_ctstoself_duration);
 
+static void wake_tx_push_queue(struct ieee80211_local *local,
+			       struct ieee80211_sub_if_data *sdata,
+			       struct ieee80211_txq *queue)
+{
+	int q = sdata->vif.hw_queue[queue->ac];
+	struct ieee80211_tx_control control = {};
+	struct sk_buff *skb;
+	unsigned long flags;
+	bool q_stopped;
+
+	control.sta = queue->sta;
+
+	while (1) {
+		spin_lock_irqsave(&local->queue_stop_reason_lock, flags);
+		q_stopped = local->queue_stop_reasons[q];
+		spin_unlock_irqrestore(&local->queue_stop_reason_lock, flags);
+
+		if (q_stopped)
+			break;
+
+		skb = ieee80211_tx_dequeue(&local->hw, queue);
+		if (!skb)
+			break;
+
+		drv_tx(local, &control, skb);
+	}
+}
+
+/* wake_tx_queue handler for driver not implementing a custom one*/
+void ieee80211_handle_wake_tx_queue(struct ieee80211_hw *hw,
+				    struct ieee80211_txq *txq)
+{
+	struct ieee80211_local *local = hw_to_local(hw);
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(txq->vif);
+	struct ieee80211_txq *queue;
+
+	/* Use ieee80211_next_txq() for airtime fairness accounting */
+	ieee80211_txq_schedule_start(hw, txq->ac);
+	while ((queue = ieee80211_next_txq(hw, txq->ac))) {
+		wake_tx_push_queue(local, sdata, queue);
+		ieee80211_return_txq(hw, queue, false);
+	}
+	ieee80211_txq_schedule_end(hw, txq->ac);
+}
+EXPORT_SYMBOL(ieee80211_handle_wake_tx_queue);
+
 static void __ieee80211_wake_txqs(struct ieee80211_sub_if_data *sdata, int ac)
 {
 	struct ieee80211_local *local = sdata->local;
-- 
2.37.3

