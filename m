Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7DA7BE743
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Oct 2023 19:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377337AbjJIRB2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Oct 2023 13:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377145AbjJIRB0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Oct 2023 13:01:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E6F9C
        for <linux-wireless@vger.kernel.org>; Mon,  9 Oct 2023 10:01:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA3DC433C7
        for <linux-wireless@vger.kernel.org>; Mon,  9 Oct 2023 17:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696870882;
        bh=RmgBPLRZMo70GGkJ0L6kuMfs3O4Z8KK7ZOJ50NYLXC8=;
        h=From:To:Subject:Date:From;
        b=DZBVjxFR2RB4nTZsQU9UUa58dE88yKMG6bCp3MknPorgx84Xcb1KjgASyzhvzmGNt
         q5mWZNV2tsnkiVMCKdMiR7CWa9mHZdZ7OhsM5i/E1xBkb5DZnXvMkV+7mbXSZNh+58
         Hwc+UuNhP98ij6XNzRPKI4e5aXtzhip3IcVobzGu8fYuO+QPMEMCyUmIPiF/fpUIat
         9o2P8Dzg518wT1PB5PhH6CHe0W+5bJARxKVt9saVQ1ShTvgDFX85aDFR5zRV12ezrD
         /Qv7+b+rcLF251QTm+VFBO+Y9UDBbJcklnGsWUfo7JHKwuCStqZkNCXRhLYfRdGeJl
         Hp879Y7Y4kE3g==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH RFC 1/2] wifi: mac80211: rename ieee80211_tx_status() to ieee80211_tx_status_skb()
Date:   Mon,  9 Oct 2023 20:01:19 +0300
Message-Id: <20231009170120.2522470-1-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Kalle Valo <quic_kvalo@quicinc.com>

make htmldocs warns:

Documentation/driver-api/80211/mac80211:109: ./include/net/mac80211.h:5170: WARNING: Duplicate C declaration, also defined at mac80211:1117.
Declaration is '.. c:function:: void ieee80211_tx_status (struct ieee80211_hw *hw, struct sk_buff *skb)'.

This is because there's a function named ieee80211_tx_status() and a struct named
ieee80211_tx_status. This has been discussed previously but no solution found:

https://lore.kernel.org/all/20220521114629.6ee9fc06@coco.lan/

There's also a bug open for three years with no solution in sight:

https://github.com/sphinx-doc/sphinx/pull/8313

So I guess we have no other solution than to a workaround this in the code,
for example to rename the function to ieee80211_tx_status_skb() to avoid the
name conflict. I got the idea for the name from ieee80211_tx_status_noskb() in
which the skb is not provided as an argument, instead with
ieee80211_tx_status_skb() the skb is provided.

Compile tested only.

Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 Documentation/driver-api/80211/mac80211.rst   |  2 +-
 drivers/net/wireless/ath/ath12k/dp_tx.c       |  4 +--
 drivers/net/wireless/ath/ath5k/base.c         |  2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c |  2 +-
 drivers/net/wireless/ath/ath9k/xmit.c         |  2 +-
 drivers/net/wireless/broadcom/b43/dma.c       |  4 +--
 drivers/net/wireless/broadcom/b43/pio.c       |  2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c   |  4 +--
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  4 +--
 drivers/net/wireless/mediatek/mt7601u/tx.c    |  2 +-
 .../net/wireless/ralink/rt2x00/rt2x00dev.c    |  2 +-
 drivers/net/wireless/st/cw1200/txrx.c         |  2 +-
 drivers/net/wireless/ti/wl1251/tx.c           |  6 ++--
 include/net/mac80211.h                        | 30 +++++++++----------
 net/mac80211/main.c                           |  2 +-
 net/mac80211/status.c                         |  4 +--
 16 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/Documentation/driver-api/80211/mac80211.rst b/Documentation/driver-api/80211/mac80211.rst
index 67d2e58b45e4..e38a220401f5 100644
--- a/Documentation/driver-api/80211/mac80211.rst
+++ b/Documentation/driver-api/80211/mac80211.rst
@@ -120,7 +120,7 @@ functions/definitions
 	ieee80211_rx
 	ieee80211_rx_ni
 	ieee80211_rx_irqsafe
-	ieee80211_tx_status
+	ieee80211_tx_status_skb
 	ieee80211_tx_status_ni
 	ieee80211_tx_status_irqsafe
 	ieee80211_rts_get
diff --git a/drivers/net/wireless/ath/ath12k/dp_tx.c b/drivers/net/wireless/ath/ath12k/dp_tx.c
index f5e0f5426226..492ca6ce6714 100644
--- a/drivers/net/wireless/ath/ath12k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_tx.c
@@ -401,7 +401,7 @@ ath12k_dp_tx_htt_tx_complete_buf(struct ath12k_base *ab,
 		}
 	}
 
-	ieee80211_tx_status(ar->hw, msdu);
+	ieee80211_tx_status_skb(ar->hw, msdu);
 }
 
 static void
@@ -498,7 +498,7 @@ static void ath12k_dp_tx_complete_msdu(struct ath12k *ar,
 	 * Might end up reporting it out-of-band from HTT stats.
 	 */
 
-	ieee80211_tx_status(ar->hw, msdu);
+	ieee80211_tx_status_skb(ar->hw, msdu);
 
 exit:
 	rcu_read_unlock();
diff --git a/drivers/net/wireless/ath/ath5k/base.c b/drivers/net/wireless/ath/ath5k/base.c
index 597d1f916dfd..9f534ed2fbb3 100644
--- a/drivers/net/wireless/ath/ath5k/base.c
+++ b/drivers/net/wireless/ath/ath5k/base.c
@@ -1770,7 +1770,7 @@ ath5k_tx_frame_completed(struct ath5k_hw *ah, struct sk_buff *skb,
 		ah->stats.antenna_tx[0]++; /* invalid */
 
 	trace_ath5k_tx_complete(ah, skb, txq, ts);
-	ieee80211_tx_status(ah->hw, skb);
+	ieee80211_tx_status_skb(ah->hw, skb);
 }
 
 static void
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
index 672789e3c55d..800177021baf 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
@@ -523,7 +523,7 @@ static void ath9k_htc_tx_process(struct ath9k_htc_priv *priv,
 	}
 
 	/* Send status to mac80211 */
-	ieee80211_tx_status(priv->hw, skb);
+	ieee80211_tx_status_skb(priv->hw, skb);
 }
 
 static inline void ath9k_htc_tx_drainq(struct ath9k_htc_priv *priv,
diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 4e939dcac1c9..f15684379b03 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -94,7 +94,7 @@ static void ath_tx_status(struct ieee80211_hw *hw, struct sk_buff *skb)
 
 	if (info->flags & (IEEE80211_TX_CTL_REQ_TX_STATUS |
 			   IEEE80211_TX_STATUS_EOSP)) {
-		ieee80211_tx_status(hw, skb);
+		ieee80211_tx_status_skb(hw, skb);
 		return;
 	}
 
diff --git a/drivers/net/wireless/broadcom/b43/dma.c b/drivers/net/wireless/broadcom/b43/dma.c
index 9a7c62bd5e43..760d1a28edc6 100644
--- a/drivers/net/wireless/broadcom/b43/dma.c
+++ b/drivers/net/wireless/broadcom/b43/dma.c
@@ -1531,9 +1531,9 @@ void b43_dma_handle_txstatus(struct b43_wldev *dev,
 				ring->nr_failed_tx_packets++;
 			ring->nr_total_packet_tries += status->frame_count;
 #endif /* DEBUG */
-			ieee80211_tx_status(dev->wl->hw, meta->skb);
+			ieee80211_tx_status_skb(dev->wl->hw, meta->skb);
 
-			/* skb will be freed by ieee80211_tx_status().
+			/* skb will be freed by ieee80211_tx_status_skb().
 			 * Poison our pointer. */
 			meta->skb = B43_DMA_PTR_POISON;
 		} else {
diff --git a/drivers/net/wireless/broadcom/b43/pio.c b/drivers/net/wireless/broadcom/b43/pio.c
index 8c28a9250cd1..0cf70fdb60a6 100644
--- a/drivers/net/wireless/broadcom/b43/pio.c
+++ b/drivers/net/wireless/broadcom/b43/pio.c
@@ -582,7 +582,7 @@ void b43_pio_handle_txstatus(struct b43_wldev *dev,
 	q->buffer_used -= total_len;
 	q->free_packet_slots += 1;
 
-	ieee80211_tx_status(dev->wl->hw, pack->skb);
+	ieee80211_tx_status_skb(dev->wl->hw, pack->skb);
 	pack->skb = NULL;
 	list_add(&pack->list, &q->packets_list);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
index 60a7b61d59aa..b0322af8e081 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
@@ -1247,7 +1247,7 @@ void iwlagn_rx_reply_tx(struct iwl_priv *priv, struct iwl_rx_cmd_buffer *rxb)
 
 	while (!skb_queue_empty(&skbs)) {
 		skb = __skb_dequeue(&skbs);
-		ieee80211_tx_status(priv->hw, skb);
+		ieee80211_tx_status_skb(priv->hw, skb);
 	}
 }
 
@@ -1384,6 +1384,6 @@ void iwlagn_rx_reply_compressed_ba(struct iwl_priv *priv,
 
 	while (!skb_queue_empty(&reclaimed_skbs)) {
 		skb = __skb_dequeue(&reclaimed_skbs);
-		ieee80211_tx_status(priv->hw, skb);
+		ieee80211_tx_status_skb(priv->hw, skb);
 	}
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 674ddf951b79..f151c48496d9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1724,7 +1724,7 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 			RS_DRV_DATA_PACK(lq_color, tx_resp->reduced_tpc);
 
 		if (likely(!iwl_mvm_time_sync_frame(mvm, skb, hdr->addr1)))
-			ieee80211_tx_status(mvm->hw, skb);
+			ieee80211_tx_status_skb(mvm->hw, skb);
 	}
 
 	/* This is an aggregation queue or might become one, so we use
@@ -2080,7 +2080,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 
 	while (!skb_queue_empty(&reclaimed_skbs)) {
 		skb = __skb_dequeue(&reclaimed_skbs);
-		ieee80211_tx_status(mvm->hw, skb);
+		ieee80211_tx_status_skb(mvm->hw, skb);
 	}
 }
 
diff --git a/drivers/net/wireless/mediatek/mt7601u/tx.c b/drivers/net/wireless/mediatek/mt7601u/tx.c
index 51d977ffc52f..5aeeac0dd9fe 100644
--- a/drivers/net/wireless/mediatek/mt7601u/tx.c
+++ b/drivers/net/wireless/mediatek/mt7601u/tx.c
@@ -110,7 +110,7 @@ void mt7601u_tx_status(struct mt7601u_dev *dev, struct sk_buff *skb)
 	info->flags |= IEEE80211_TX_STAT_ACK;
 
 	spin_lock_bh(&dev->mac_lock);
-	ieee80211_tx_status(dev->hw, skb);
+	ieee80211_tx_status_skb(dev->hw, skb);
 	spin_unlock_bh(&dev->mac_lock);
 }
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
index 9a9cfd0ce402..c88ce446e117 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00dev.c
@@ -533,7 +533,7 @@ void rt2x00lib_txdone(struct queue_entry *entry,
 	 */
 	if (!(skbdesc_flags & SKBDESC_NOT_MAC80211)) {
 		if (rt2x00_has_cap_flag(rt2x00dev, REQUIRE_TASKLET_CONTEXT))
-			ieee80211_tx_status(rt2x00dev->hw, entry->skb);
+			ieee80211_tx_status_skb(rt2x00dev->hw, entry->skb);
 		else
 			ieee80211_tx_status_ni(rt2x00dev->hw, entry->skb);
 	} else {
diff --git a/drivers/net/wireless/st/cw1200/txrx.c b/drivers/net/wireless/st/cw1200/txrx.c
index e16e9ae90d20..084d52b11f5b 100644
--- a/drivers/net/wireless/st/cw1200/txrx.c
+++ b/drivers/net/wireless/st/cw1200/txrx.c
@@ -994,7 +994,7 @@ void cw1200_skb_dtor(struct cw1200_common *priv,
 					  txpriv->raw_link_id, txpriv->tid);
 		tx_policy_put(priv, txpriv->rate_id);
 	}
-	ieee80211_tx_status(priv->hw, skb);
+	ieee80211_tx_status_skb(priv->hw, skb);
 }
 
 void cw1200_rx_cb(struct cw1200_common *priv,
diff --git a/drivers/net/wireless/ti/wl1251/tx.c b/drivers/net/wireless/ti/wl1251/tx.c
index e9dc3c72bb11..474b603c121c 100644
--- a/drivers/net/wireless/ti/wl1251/tx.c
+++ b/drivers/net/wireless/ti/wl1251/tx.c
@@ -434,7 +434,7 @@ static void wl1251_tx_packet_cb(struct wl1251 *wl,
 		     result->status, wl1251_tx_parse_status(result->status));
 
 
-	ieee80211_tx_status(wl->hw, skb);
+	ieee80211_tx_status_skb(wl->hw, skb);
 
 	wl->tx_frames[result->id] = NULL;
 }
@@ -566,7 +566,7 @@ void wl1251_tx_flush(struct wl1251 *wl)
 		if (!(info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS))
 				continue;
 
-		ieee80211_tx_status(wl->hw, skb);
+		ieee80211_tx_status_skb(wl->hw, skb);
 	}
 
 	for (i = 0; i < FW_TX_CMPLT_BLOCK_SIZE; i++)
@@ -577,7 +577,7 @@ void wl1251_tx_flush(struct wl1251 *wl)
 			if (!(info->flags & IEEE80211_TX_CTL_REQ_TX_STATUS))
 				continue;
 
-			ieee80211_tx_status(wl->hw, skb);
+			ieee80211_tx_status_skb(wl->hw, skb);
 			wl->tx_frames[i] = NULL;
 		}
 }
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 72375eceb786..965085dadc32 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -4901,7 +4901,7 @@ void ieee80211_restart_hw(struct ieee80211_hw *hw);
  * for a single hardware must be synchronized against each other. Calls to
  * this function, ieee80211_rx_ni() and ieee80211_rx_irqsafe() may not be
  * mixed for a single hardware. Must not run concurrently with
- * ieee80211_tx_status() or ieee80211_tx_status_ni().
+ * ieee80211_tx_status_skb() or ieee80211_tx_status_ni().
  *
  * This function must be called with BHs disabled and RCU read lock
  *
@@ -4926,7 +4926,7 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
  * for a single hardware must be synchronized against each other. Calls to
  * this function, ieee80211_rx_ni() and ieee80211_rx_irqsafe() may not be
  * mixed for a single hardware. Must not run concurrently with
- * ieee80211_tx_status() or ieee80211_tx_status_ni().
+ * ieee80211_tx_status_skb() or ieee80211_tx_status_ni().
  *
  * This function must be called with BHs disabled.
  *
@@ -4951,7 +4951,7 @@ void ieee80211_rx_napi(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
  * for a single hardware must be synchronized against each other. Calls to
  * this function, ieee80211_rx_ni() and ieee80211_rx_irqsafe() may not be
  * mixed for a single hardware. Must not run concurrently with
- * ieee80211_tx_status() or ieee80211_tx_status_ni().
+ * ieee80211_tx_status_skb() or ieee80211_tx_status_ni().
  *
  * In process context use instead ieee80211_rx_ni().
  *
@@ -4971,7 +4971,7 @@ static inline void ieee80211_rx(struct ieee80211_hw *hw, struct sk_buff *skb)
  *
  * Calls to this function, ieee80211_rx() or ieee80211_rx_ni() may not
  * be mixed for a single hardware.Must not run concurrently with
- * ieee80211_tx_status() or ieee80211_tx_status_ni().
+ * ieee80211_tx_status_skb() or ieee80211_tx_status_ni().
  *
  * @hw: the hardware this frame came in on
  * @skb: the buffer to receive, owned by mac80211 after this call
@@ -4986,7 +4986,7 @@ void ieee80211_rx_irqsafe(struct ieee80211_hw *hw, struct sk_buff *skb);
  *
  * Calls to this function, ieee80211_rx() and ieee80211_rx_irqsafe() may
  * not be mixed for a single hardware. Must not run concurrently with
- * ieee80211_tx_status() or ieee80211_tx_status_ni().
+ * ieee80211_tx_status_skb() or ieee80211_tx_status_ni().
  *
  * @hw: the hardware this frame came in on
  * @skb: the buffer to receive, owned by mac80211 after this call
@@ -5162,7 +5162,7 @@ void ieee80211_tx_rate_update(struct ieee80211_hw *hw,
 			      struct ieee80211_tx_info *info);
 
 /**
- * ieee80211_tx_status - transmit status callback
+ * ieee80211_tx_status_skb - transmit status callback
  *
  * Call this function for all transmitted frames after they have been
  * transmitted. It is permissible to not call this function for
@@ -5177,13 +5177,13 @@ void ieee80211_tx_rate_update(struct ieee80211_hw *hw,
  * @hw: the hardware the frame was transmitted by
  * @skb: the frame that was transmitted, owned by mac80211 after this call
  */
-void ieee80211_tx_status(struct ieee80211_hw *hw,
-			 struct sk_buff *skb);
+void ieee80211_tx_status_skb(struct ieee80211_hw *hw,
+			     struct sk_buff *skb);
 
 /**
  * ieee80211_tx_status_ext - extended transmit status callback
  *
- * This function can be used as a replacement for ieee80211_tx_status
+ * This function can be used as a replacement for ieee80211_tx_status_skb()
  * in drivers that may want to provide extra information that does not
  * fit into &struct ieee80211_tx_info.
  *
@@ -5200,7 +5200,7 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 /**
  * ieee80211_tx_status_noskb - transmit status callback without skb
  *
- * This function can be used as a replacement for ieee80211_tx_status
+ * This function can be used as a replacement for ieee80211_tx_status_skb()
  * in drivers that cannot reliably map tx status information back to
  * specific skbs.
  *
@@ -5228,9 +5228,9 @@ static inline void ieee80211_tx_status_noskb(struct ieee80211_hw *hw,
 /**
  * ieee80211_tx_status_ni - transmit status callback (in process context)
  *
- * Like ieee80211_tx_status() but can be called in process context.
+ * Like ieee80211_tx_status_skb() but can be called in process context.
  *
- * Calls to this function, ieee80211_tx_status() and
+ * Calls to this function, ieee80211_tx_status_skb() and
  * ieee80211_tx_status_irqsafe() may not be mixed
  * for a single hardware.
  *
@@ -5241,17 +5241,17 @@ static inline void ieee80211_tx_status_ni(struct ieee80211_hw *hw,
 					  struct sk_buff *skb)
 {
 	local_bh_disable();
-	ieee80211_tx_status(hw, skb);
+	ieee80211_tx_status_skb(hw, skb);
 	local_bh_enable();
 }
 
 /**
  * ieee80211_tx_status_irqsafe - IRQ-safe transmit status callback
  *
- * Like ieee80211_tx_status() but can be called in IRQ context
+ * Like ieee80211_tx_status_skb() but can be called in IRQ context
  * (internally defers to a tasklet.)
  *
- * Calls to this function, ieee80211_tx_status() and
+ * Calls to this function, ieee80211_tx_status_skb() and
  * ieee80211_tx_status_ni() may not be mixed for a single hardware.
  *
  * @hw: the hardware the frame was transmitted by
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index b46f4d733c5d..033a5261ac3a 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -319,7 +319,7 @@ static void ieee80211_tasklet_handler(struct tasklet_struct *t)
 			break;
 		case IEEE80211_TX_STATUS_MSG:
 			skb->pkt_type = 0;
-			ieee80211_tx_status(&local->hw, skb);
+			ieee80211_tx_status_skb(&local->hw, skb);
 			break;
 		default:
 			WARN(1, "mac80211: Packet is of unknown type %d\n",
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index f67eafada741..bf146fc9571c 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -1095,7 +1095,7 @@ static void __ieee80211_tx_status(struct ieee80211_hw *hw,
 			     send_to_cooked, status);
 }
 
-void ieee80211_tx_status(struct ieee80211_hw *hw, struct sk_buff *skb)
+void ieee80211_tx_status_skb(struct ieee80211_hw *hw, struct sk_buff *skb)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
 	struct ieee80211_local *local = hw_to_local(hw);
@@ -1114,7 +1114,7 @@ void ieee80211_tx_status(struct ieee80211_hw *hw, struct sk_buff *skb)
 	ieee80211_tx_status_ext(hw, &status);
 	rcu_read_unlock();
 }
-EXPORT_SYMBOL(ieee80211_tx_status);
+EXPORT_SYMBOL(ieee80211_tx_status_skb);
 
 void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 			     struct ieee80211_tx_status *status)

base-commit: 71ffa1bcd7a0b8331c32a81ce90290daaf17fce2
-- 
2.39.2

