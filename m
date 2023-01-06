Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540F6660987
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jan 2023 23:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbjAFWcR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Jan 2023 17:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbjAFWcM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Jan 2023 17:32:12 -0500
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8BF587287
        for <linux-wireless@vger.kernel.org>; Fri,  6 Jan 2023 14:32:10 -0800 (PST)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1673044327;
        bh=Vh8/RucAhAQoXaLG7PV1kd42fG2TR2qkXFjn/cENGGg=;
        h=From:To:Cc:Subject:Date;
        b=ZhY8x6ufkRF2QNzBH18EXV4lHorDFJGOIHOENqSyK8huHtcrSBmB0ZMFf5nfs75MD
         jbaUilP5mot/ZOtS32sY1AE8/KdU5ZiJ4x1+nvEJaoFsDKLZboni5ofYMKHberTavx
         0ImS5QzCS1xpcNFKjMFYLBj0SpIFrFPVJwahitZQ=
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net,
        Alexander Wetzel <alexander@wetzel-home.de>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] wifi: mac80211: Fix iTXQ AMPDU fragmentation handling
Date:   Fri,  6 Jan 2023 23:31:41 +0100
Message-Id: <20230106223141.98696-1-alexander@wetzel-home.de>
X-Mailer: git-send-email 2.39.0
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

mac80211 must not enable aggregation wile transmitting a fragmented
MPDU. Enforce that for mac80211 internal TX queues (iTXQs).

Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/oe-lkp/202301021738.7cd3e6ae-oliver.sang@intel.com
Signed-off-by: Alexander Wetzel <alexander@wetzel-home.de>

---
This bug was exposed by lkp-tests after switching hwsim to iTXQ.
I had some problems reproducing the issue first and had to use the
kernel config from lkp-tests to reproduce the race.

This patch assumes that
https://patchwork.kernel.org/project/linux-wireless/patch/20221230121850.218810-1-alexander@wetzel-home.de/
has been applied, too.

It's fixing a similar race and the logic overlaps.

Alexander
---
 net/mac80211/agg-tx.c |  2 --
 net/mac80211/ht.c     | 31 +++++++++++++++++++++++++++++++
 net/mac80211/tx.c     | 18 ++++++------------
 3 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 9c40f8d3bce8..3426d770bef8 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -511,8 +511,6 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 	 */
 	clear_bit(HT_AGG_STATE_WANT_START, &tid_tx->state);
 
-	ieee80211_agg_stop_txq(sta, tid);
-
 	/*
 	 * Make sure no packets are being processed. This ensures that
 	 * we have a valid starting sequence number and that in-flight
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 83bc41346ae7..5315ab750280 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -391,6 +391,37 @@ void ieee80211_ba_session_work(struct work_struct *work)
 
 		tid_tx = sta->ampdu_mlme.tid_start_tx[tid];
 		if (!blocked && tid_tx) {
+			struct txq_info *txqi = to_txq_info(sta->sta.txq[tid]);
+			struct ieee80211_sub_if_data *sdata =
+				vif_to_sdata(txqi->txq.vif);
+			struct fq *fq = &sdata->local->fq;
+
+			spin_lock_bh(&fq->lock);
+
+			/* Allow only frags to be dequeued */
+			set_bit(IEEE80211_TXQ_STOP, &txqi->flags);
+
+			if (!skb_queue_empty(&txqi->frags)) {
+				/* Fragmented Tx is ongoing, wait for it to
+				 * finish. Reschedule worker to retry later.
+				 */
+
+				spin_unlock_bh(&fq->lock);
+				spin_unlock_bh(&sta->lock);
+
+				/* Give the task working on the txq a chance
+				 * to send out the queued frags
+				 */
+				synchronize_net();
+
+				mutex_unlock(&sta->ampdu_mlme.mtx);
+
+				ieee80211_queue_work(&sdata->local->hw, work);
+				return;
+			}
+
+			spin_unlock_bh(&fq->lock);
+
 			/*
 			 * Assign it over to the normal tid_tx array
 			 * where it "goes live".
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 178043f84489..defe97a31724 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1129,7 +1129,6 @@ static bool ieee80211_tx_prep_agg(struct ieee80211_tx_data *tx,
 	struct sk_buff *purge_skb = NULL;
 
 	if (test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state)) {
-		info->flags |= IEEE80211_TX_CTL_AMPDU;
 		reset_agg_timer = true;
 	} else if (test_bit(HT_AGG_STATE_WANT_START, &tid_tx->state)) {
 		/*
@@ -1161,7 +1160,6 @@ static bool ieee80211_tx_prep_agg(struct ieee80211_tx_data *tx,
 		if (!tid_tx) {
 			/* do nothing, let packet pass through */
 		} else if (test_bit(HT_AGG_STATE_OPERATIONAL, &tid_tx->state)) {
-			info->flags |= IEEE80211_TX_CTL_AMPDU;
 			reset_agg_timer = true;
 		} else {
 			queued = true;
@@ -3677,8 +3675,7 @@ static void __ieee80211_xmit_fast(struct ieee80211_sub_if_data *sdata,
 	info->band = fast_tx->band;
 	info->control.vif = &sdata->vif;
 	info->flags = IEEE80211_TX_CTL_FIRST_FRAGMENT |
-		      IEEE80211_TX_CTL_DONTFRAG |
-		      (ampdu ? IEEE80211_TX_CTL_AMPDU : 0);
+		      IEEE80211_TX_CTL_DONTFRAG;
 	info->control.flags = IEEE80211_TX_CTRL_FAST_XMIT |
 			      u32_encode_bits(IEEE80211_LINK_UNSPECIFIED,
 					      IEEE80211_TX_CTRL_MLO_LINK);
@@ -3804,9 +3801,6 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 
 	spin_lock_bh(&fq->lock);
 
-	if (unlikely(test_bit(IEEE80211_TXQ_STOP, &txqi->flags)))
-		goto out;
-
 	/* Make sure fragments stay together. */
 	skb = __skb_dequeue(&txqi->frags);
 	if (unlikely(skb)) {
@@ -3816,6 +3810,9 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 		IEEE80211_SKB_CB(skb)->control.flags &=
 			~IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
 	} else {
+		if (unlikely(test_bit(IEEE80211_TXQ_STOP, &txqi->flags)))
+			goto out;
+
 		skb = fq_tin_dequeue(fq, tin, fq_tin_dequeue_func);
 	}
 
@@ -3866,9 +3863,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	}
 
 	if (test_bit(IEEE80211_TXQ_AMPDU, &txqi->flags))
-		info->flags |= IEEE80211_TX_CTL_AMPDU;
-	else
-		info->flags &= ~IEEE80211_TX_CTL_AMPDU;
+		info->flags |= (IEEE80211_TX_CTL_AMPDU |
+				IEEE80211_TX_CTL_DONTFRAG);
 
 	if (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) {
 		if (!ieee80211_hw_check(&local->hw, HAS_RATE_CONTROL)) {
@@ -4602,8 +4598,6 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 
 	info = IEEE80211_SKB_CB(skb);
 	memset(info, 0, sizeof(*info));
-	if (tid_tx)
-		info->flags |= IEEE80211_TX_CTL_AMPDU;
 
 	info->hw_queue = sdata->vif.hw_queue[queue];
 
-- 
2.39.0

