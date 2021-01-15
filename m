Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4B22F7731
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jan 2021 12:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbhAOLG4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jan 2021 06:06:56 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40322 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726278AbhAOLGz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jan 2021 06:06:55 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l0Mvg-003hBK-IX; Fri, 15 Jan 2021 13:06:08 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 15 Jan 2021 13:05:53 +0200
Message-Id: <iwlwifi.20210115130252.173359fc236d.I75c7c2397d20df8d7fbc24cb16a5232d5c551889@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115110558.1248847-1-luca@coelho.fi>
References: <20210115110558.1248847-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH for v5.11 07/12] iwlwifi: queue: don't crash if txq->entries is NULL
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The code was really awkward, we would first dereference
txq->entries when calling iwl_txq_genX_tfd_unmap and then
we would check that txq->entries is non-NULL.
Fix that by exiting if txq->entries is NULL.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 49 +++++++++----------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 27eea909e32d..62c0c4cbe481 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -142,26 +142,25 @@ void iwl_txq_gen2_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq)
 	 * idx is bounded by n_window
 	 */
 	int idx = iwl_txq_get_cmd_index(txq, txq->read_ptr);
+	struct sk_buff *skb;
 
 	lockdep_assert_held(&txq->lock);
 
+	if (!txq->entries)
+		return;
+
 	iwl_txq_gen2_tfd_unmap(trans, &txq->entries[idx].meta,
 			       iwl_txq_get_tfd(trans, txq, idx));
 
-	/* free SKB */
-	if (txq->entries) {
-		struct sk_buff *skb;
-
-		skb = txq->entries[idx].skb;
+	skb = txq->entries[idx].skb;
 
-		/* Can be called from irqs-disabled context
-		 * If skb is not NULL, it means that the whole queue is being
-		 * freed and that the queue is not empty - free the skb
-		 */
-		if (skb) {
-			iwl_op_mode_free_skb(trans->op_mode, skb);
-			txq->entries[idx].skb = NULL;
-		}
+	/* Can be called from irqs-disabled context
+	 * If skb is not NULL, it means that the whole queue is being
+	 * freed and that the queue is not empty - free the skb
+	 */
+	if (skb) {
+		iwl_op_mode_free_skb(trans->op_mode, skb);
+		txq->entries[idx].skb = NULL;
 	}
 }
 
@@ -1494,28 +1493,28 @@ void iwl_txq_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq)
 	 */
 	int rd_ptr = txq->read_ptr;
 	int idx = iwl_txq_get_cmd_index(txq, rd_ptr);
+	struct sk_buff *skb;
 
 	lockdep_assert_held(&txq->lock);
 
+	if (!txq->entries)
+		return;
+
 	/* We have only q->n_window txq->entries, but we use
 	 * TFD_QUEUE_SIZE_MAX tfds
 	 */
 	iwl_txq_gen1_tfd_unmap(trans, &txq->entries[idx].meta, txq, rd_ptr);
 
 	/* free SKB */
-	if (txq->entries) {
-		struct sk_buff *skb;
-
-		skb = txq->entries[idx].skb;
+	skb = txq->entries[idx].skb;
 
-		/* Can be called from irqs-disabled context
-		 * If skb is not NULL, it means that the whole queue is being
-		 * freed and that the queue is not empty - free the skb
-		 */
-		if (skb) {
-			iwl_op_mode_free_skb(trans->op_mode, skb);
-			txq->entries[idx].skb = NULL;
-		}
+	/* Can be called from irqs-disabled context
+	 * If skb is not NULL, it means that the whole queue is being
+	 * freed and that the queue is not empty - free the skb
+	 */
+	if (skb) {
+		iwl_op_mode_free_skb(trans->op_mode, skb);
+		txq->entries[idx].skb = NULL;
 	}
 }
 
-- 
2.29.2

