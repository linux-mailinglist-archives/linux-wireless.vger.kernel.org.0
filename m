Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFCA135B2DC
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 11:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbhDKJr1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 05:47:27 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44438 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235306AbhDKJqy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 05:46:54 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVWfq-000Jkq-Ex; Sun, 11 Apr 2021 12:46:36 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 11 Apr 2021 12:46:22 +0300
Message-Id: <iwlwifi.20210411124417.c72d2f0355c4.Ia3baff633b9b9109f88ab379ef0303aa152c16bf@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210411094630.431873-1-luca@coelho.fi>
References: <20210411094630.431873-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 04/12] iwlwifi: queue: avoid memory leak in reset flow
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

In case the device is stopped any usage of hw queues needs to be
reallocated in fw due to fw reset after device stop, so all driver
internal queue should also be freed, and if we don't free the next usage
would leak the old memory and get in recover flows
"iwlwifi 0000:00:03.0: dma_pool_destroy iwlwifi:bc" warning.

Also warn about trying to reuse an internal allocated queue.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  4 +--
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 30 ++++---------------
 drivers/net/wireless/intel/iwlwifi/queue/tx.h |  3 +-
 3 files changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 73894793ed4f..a86300350df8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  */
 #include "iwl-trans.h"
 #include "iwl-prph.h"
@@ -143,7 +143,7 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 	if (test_and_clear_bit(STATUS_DEVICE_ENABLED, &trans->status)) {
 		IWL_DEBUG_INFO(trans,
 			       "DEVICE_ENABLED bit was set and is now cleared\n");
-		iwl_txq_gen2_tx_stop(trans);
+		iwl_txq_gen2_tx_free(trans);
 		iwl_pcie_rx_stop(trans);
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 494f9dbf92d6..451b06069350 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -13,30 +13,6 @@
 #include "iwl-scd.h"
 #include <linux/dmapool.h>
 
-/*
- * iwl_txq_gen2_tx_stop - Stop all Tx DMA channels
- */
-void iwl_txq_gen2_tx_stop(struct iwl_trans *trans)
-{
-	int txq_id;
-
-	/*
-	 * This function can be called before the op_mode disabled the
-	 * queues. This happens when we have an rfkill interrupt.
-	 * Since we stop Tx altogether - mark the queues as stopped.
-	 */
-	memset(trans->txqs.queue_stopped, 0,
-	       sizeof(trans->txqs.queue_stopped));
-	memset(trans->txqs.queue_used, 0, sizeof(trans->txqs.queue_used));
-
-	/* Unmap DMA from host system and free skb's */
-	for (txq_id = 0; txq_id < ARRAY_SIZE(trans->txqs.txq); txq_id++) {
-		if (!trans->txqs.txq[txq_id])
-			continue;
-		iwl_txq_gen2_unmap(trans, txq_id);
-	}
-}
-
 /*
  * iwl_txq_update_byte_tbl - Set up entry in Tx byte-count array
  */
@@ -1184,6 +1160,12 @@ static int iwl_txq_alloc_response(struct iwl_trans *trans, struct iwl_txq *txq,
 		goto error_free_resp;
 	}
 
+	if (WARN_ONCE(trans->txqs.txq[qid],
+		      "queue %d already allocated\n", qid)) {
+		ret = -EIO;
+		goto error_free_resp;
+	}
+
 	txq->id = qid;
 	trans->txqs.txq[qid] = txq;
 	wr_ptr &= (trans->trans_cfg->base_params->max_tfd_queue_size - 1);
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.h b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
index af1dbdf5617a..20efc62acf13 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2020 Intel Corporation
+ * Copyright (C) 2020-2021 Intel Corporation
  */
 #ifndef __iwl_trans_queue_tx_h__
 #define __iwl_trans_queue_tx_h__
@@ -123,7 +123,6 @@ int iwl_txq_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
 void iwl_txq_dyn_free(struct iwl_trans *trans, int queue);
 void iwl_txq_gen2_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq);
 void iwl_txq_inc_wr_ptr(struct iwl_trans *trans, struct iwl_txq *txq);
-void iwl_txq_gen2_tx_stop(struct iwl_trans *trans);
 void iwl_txq_gen2_tx_free(struct iwl_trans *trans);
 int iwl_txq_init(struct iwl_trans *trans, struct iwl_txq *txq, int slots_num,
 		 bool cmd_queue);
-- 
2.31.0

