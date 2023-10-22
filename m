Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15397D236F
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Oct 2023 16:56:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjJVO4Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Oct 2023 10:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbjJVO4Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Oct 2023 10:56:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E90CF7
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 07:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697986581; x=1729522581;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+mz3ocdrSuyw/vXyigwPCkkhmCqY5GEXaUsDTLUnOjE=;
  b=S9I0blaMyLhJ2jwXtYibnqCXq6VOIDIXD/Bj2870O4ii0QXLIJ3M8pjx
   q1nEUYH4ZJHBZmOUzDHpPoeUZLheQyqm8ReehNMkzjGiL3VRRBYx/koSi
   TmfSYwdDwDl5T3eWlc0LmGHkLL13pviguLMWbxesBc8DbLC8ZFs5YA1My
   p5hBF/vg6qZ8X87tJ7Gwq5C3w8jSi0MHXxH9Pi8gfKoLG00csl/KTQ9ZE
   NzCMCOrPod/Ukb/OE5GXBVS3FPFzd9ozPMij6Uf1JrkeITXnetKg+Gu9S
   RJxosPuADwJdPizAWyoz/WQ3wB6MrmcOOAlEToZqkyobJxPqXhV5sS0g4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10870"; a="472925855"
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="472925855"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:56:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,242,1694761200"; 
   d="scan'208";a="5556203"
Received: from umark-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.231.87])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 07:55:04 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/10] wifi: iwlwifi: empty overflow queue during flush
Date:   Sun, 22 Oct 2023 17:55:51 +0300
Message-Id: <20231022173519.caf06c8709d9.Ibf664ccb3f952e836f8fa461ea58fc08e5c46e88@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231022145556.244202-1-gregory.greenman@intel.com>
References: <20231022145556.244202-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

If a TX queue has no space for new TX frames, the driver will keep
these frames in the overflow queue, and during reclaim flow it
will retry to send the frames from that queue.
But if the reclaim flow was invoked from TX queue flush, we will also
TX these frames, which is wrong as we don't want to TX anything
after flush.
This might also cause assert 0x125F when removing the queue,
saying that the driver removes a non-empty queue
Fix this by TXing the overflow queue's frames only if we are
not in flush queue flow.

Fixes: a44509805895 ("iwlwifi: move reclaim flows to the queue file")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c    | 5 +++--
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h | 7 ++++---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c    | 4 ++--
 drivers/net/wireless/intel/iwlwifi/queue/tx.c  | 9 +++++----
 drivers/net/wireless/intel/iwlwifi/queue/tx.h  | 2 +-
 5 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
index 60a7b61d59aa..ca1daec641c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/tx.c
@@ -3,6 +3,7 @@
  *
  * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
  * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2023 Intel Corporation
  *****************************************************************************/
 
 #include <linux/kernel.h>
@@ -1169,7 +1170,7 @@ void iwlagn_rx_reply_tx(struct iwl_priv *priv, struct iwl_rx_cmd_buffer *rxb)
 			iwlagn_check_ratid_empty(priv, sta_id, tid);
 		}
 
-		iwl_trans_reclaim(priv->trans, txq_id, ssn, &skbs);
+		iwl_trans_reclaim(priv->trans, txq_id, ssn, &skbs, false);
 
 		freed = 0;
 
@@ -1315,7 +1316,7 @@ void iwlagn_rx_reply_compressed_ba(struct iwl_priv *priv,
 	 * block-ack window (we assume that they've been successfully
 	 * transmitted ... if not, it's too late anyway). */
 	iwl_trans_reclaim(priv->trans, scd_flow, ba_resp_scd_ssn,
-			  &reclaimed_skbs);
+			  &reclaimed_skbs, false);
 
 	IWL_DEBUG_TX_REPLY(priv, "REPLY_COMPRESSED_BA [%d] Received from %pM, "
 			   "sta_id = %d\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index cab4d7351088..05e72a2125b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -589,7 +589,7 @@ struct iwl_trans_ops {
 	int (*tx)(struct iwl_trans *trans, struct sk_buff *skb,
 		  struct iwl_device_tx_cmd *dev_cmd, int queue);
 	void (*reclaim)(struct iwl_trans *trans, int queue, int ssn,
-			struct sk_buff_head *skbs);
+			struct sk_buff_head *skbs, bool is_flush);
 
 	void (*set_q_ptrs)(struct iwl_trans *trans, int queue, int ptr);
 
@@ -1274,14 +1274,15 @@ static inline int iwl_trans_tx(struct iwl_trans *trans, struct sk_buff *skb,
 }
 
 static inline void iwl_trans_reclaim(struct iwl_trans *trans, int queue,
-				     int ssn, struct sk_buff_head *skbs)
+				     int ssn, struct sk_buff_head *skbs,
+				     bool is_flush)
 {
 	if (WARN_ON_ONCE(trans->state != IWL_TRANS_FW_ALIVE)) {
 		IWL_ERR(trans, "%s bad state = %d\n", __func__, trans->state);
 		return;
 	}
 
-	trans->ops->reclaim(trans, queue, ssn, skbs);
+	trans->ops->reclaim(trans, queue, ssn, skbs, is_flush);
 }
 
 static inline void iwl_trans_set_q_ptrs(struct iwl_trans *trans, int queue,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index b0f3d51a7613..17188f641d0a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1623,7 +1623,7 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 	seq_ctl = le16_to_cpu(tx_resp->seq_ctl);
 
 	/* we can free until ssn % q.n_bd not inclusive */
-	iwl_trans_reclaim(mvm->trans, txq_id, ssn, &skbs);
+	iwl_trans_reclaim(mvm->trans, txq_id, ssn, &skbs, false);
 
 	while (!skb_queue_empty(&skbs)) {
 		struct sk_buff *skb = __skb_dequeue(&skbs);
@@ -1975,7 +1975,7 @@ static void iwl_mvm_tx_reclaim(struct iwl_mvm *mvm, int sta_id, int tid,
 	 * block-ack window (we assume that they've been successfully
 	 * transmitted ... if not, it's too late anyway).
 	 */
-	iwl_trans_reclaim(mvm->trans, txq, index, &reclaimed_skbs);
+	iwl_trans_reclaim(mvm->trans, txq, index, &reclaimed_skbs, is_flush);
 
 	skb_queue_walk(&reclaimed_skbs, skb) {
 		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 340240b8954f..ca74b1b63cac 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -1575,7 +1575,7 @@ void iwl_txq_progress(struct iwl_txq *txq)
 
 /* Frees buffers until index _not_ inclusive */
 void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
-		     struct sk_buff_head *skbs)
+		     struct sk_buff_head *skbs, bool is_flush)
 {
 	struct iwl_txq *txq = trans->txqs.txq[txq_id];
 	int tfd_num, read_ptr, last_to_free;
@@ -1650,9 +1650,11 @@ void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 	if (iwl_txq_space(trans, txq) > txq->low_mark &&
 	    test_bit(txq_id, trans->txqs.queue_stopped)) {
 		struct sk_buff_head overflow_skbs;
+		struct sk_buff *skb;
 
 		__skb_queue_head_init(&overflow_skbs);
-		skb_queue_splice_init(&txq->overflow_q, &overflow_skbs);
+		skb_queue_splice_init(&txq->overflow_q,
+				      is_flush ? skbs : &overflow_skbs);
 
 		/*
 		 * We are going to transmit from the overflow queue.
@@ -1672,8 +1674,7 @@ void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 		 */
 		spin_unlock_bh(&txq->lock);
 
-		while (!skb_queue_empty(&overflow_skbs)) {
-			struct sk_buff *skb = __skb_dequeue(&overflow_skbs);
+		while ((skb = __skb_dequeue(&overflow_skbs))) {
 			struct iwl_device_tx_cmd *dev_cmd_ptr;
 
 			dev_cmd_ptr = *(void **)((u8 *)skb->cb +
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.h b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
index 52aa885af49b..124b29aac4a1 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
@@ -181,7 +181,7 @@ void iwl_txq_gen1_update_byte_cnt_tbl(struct iwl_trans *trans,
 				      struct iwl_txq *txq, u16 byte_cnt,
 				      int num_tbs);
 void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
-		     struct sk_buff_head *skbs);
+		     struct sk_buff_head *skbs, bool is_flush);
 void iwl_txq_set_q_ptrs(struct iwl_trans *trans, int txq_id, int ptr);
 void iwl_trans_txq_freeze_timer(struct iwl_trans *trans, unsigned long txqs,
 				bool freeze);
-- 
2.38.1

