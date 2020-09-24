Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C509277285
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Sep 2020 15:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgIXNhW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Sep 2020 09:37:22 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52092 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728022AbgIXNhW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Sep 2020 09:37:22 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLRDs-002IGj-At; Thu, 24 Sep 2020 16:23:45 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 24 Sep 2020 16:23:35 +0300
Message-Id: <iwlwifi.20200924162105.f6469c62665d.Id920f1ae8f70886b66a98956a6412726d29a9481@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924132339.337310-1-luca@coelho.fi>
References: <20200924132339.337310-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 3/7] iwlwifi: move bc_pool to a common trans header
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

The bc_pool code is not directly related to the PCIe transport,
so move the structures it uses to the common iwl-trans.h header.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.c | 17 +++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h |  2 ++
 .../net/wireless/intel/iwlwifi/pcie/internal.h |  1 -
 .../net/wireless/intel/iwlwifi/pcie/trans.c    | 18 ------------------
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c  | 16 ++++++----------
 5 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 4a61ab56d728..105776b39792 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -66,6 +66,7 @@
 #include "iwl-trans.h"
 #include "iwl-drv.h"
 #include "iwl-fh.h"
+#include <linux/dmapool.h>
 
 struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 				  struct device *dev,
@@ -110,6 +111,22 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 	trans->ops = ops;
 	trans->num_rx_queues = 1;
 
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		trans->txqs.bc_tbl_size = sizeof(struct iwl_gen3_bc_tbl);
+	else
+		trans->txqs.bc_tbl_size = sizeof(struct iwlagn_scd_bc_tbl);
+	/*
+	 * For gen2 devices, we use a single allocation for each byte-count
+	 * table, but they're pretty small (1k) so use a DMA pool that we
+	 * allocate here.
+	 */
+	if (trans->trans_cfg->gen2) {
+		trans->txqs.bc_pool = dmam_pool_create("iwlwifi:bc", dev,
+						       trans->txqs.bc_tbl_size,
+						       256, 0);
+		if (!trans->txqs.bc_pool)
+			return NULL;
+	}
 	snprintf(trans->dev_cmd_pool_name, sizeof(trans->dev_cmd_pool_name),
 		 "iwl_cmd_pool:%s", dev_name(trans->dev));
 	trans->dev_cmd_pool =
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index d17eafe31e41..dbcd89e9546b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -914,6 +914,8 @@ struct iwl_trans_txqs {
 	unsigned long queue_used[BITS_TO_LONGS(IWL_MAX_TVQM_QUEUES)];
 	unsigned long queue_stopped[BITS_TO_LONGS(IWL_MAX_TVQM_QUEUES)];
 	struct iwl_txq *txq[IWL_MAX_TVQM_QUEUES];
+	struct dma_pool *bc_pool;
+	size_t bc_tbl_size;
 	struct {
 		u8 fifo;
 		u8 q_id;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 55808ba10d27..032e858ce7a3 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -451,7 +451,6 @@ struct iwl_trans_pcie {
 	u32 scd_base_addr;
 	struct iwl_dma_ptr scd_bc_tbls;
 	struct iwl_dma_ptr kw;
-	struct dma_pool *bc_pool;
 
 	struct iwl_txq *txq_memory;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 43adb6646366..354ec140f448 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3649,24 +3649,6 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	init_waitqueue_head(&trans_pcie->sx_waitq);
 
-	/*
-	 * For gen2 devices, we use a single allocation for each byte-count
-	 * table, but they're pretty small (1k) so use a DMA pool that we
-	 * allocate here.
-	 */
-	if (cfg_trans->gen2) {
-		size_t bc_tbl_size;
-
-		if (cfg_trans->device_family >= IWL_DEVICE_FAMILY_AX210)
-			bc_tbl_size = sizeof(struct iwl_gen3_bc_tbl);
-		else
-			bc_tbl_size = sizeof(struct iwlagn_scd_bc_tbl);
-
-		trans_pcie->bc_pool = dmam_pool_create("iwlwifi:bc", &pdev->dev,
-						       bc_tbl_size, 256, 0);
-		if (!trans_pcie->bc_pool)
-			goto out_no_pci;
-	}
 
 	if (trans_pcie->msix_enabled) {
 		ret = iwl_pcie_init_msix_handler(pdev, trans_pcie);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 606bef2ecc7b..8b2275bf301c 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -1225,7 +1225,7 @@ void iwl_pcie_gen2_txq_free_memory(struct iwl_trans *trans,
 
 	kfree(txq->entries);
 	if (txq->bc_tbl.addr)
-		dma_pool_free(trans_pcie->bc_pool, txq->bc_tbl.addr,
+		dma_pool_free(trans->txqs.bc_pool, txq->bc_tbl.addr,
 			      txq->bc_tbl.dma);
 	kfree(txq);
 }
@@ -1273,18 +1273,14 @@ int iwl_trans_pcie_dyn_txq_alloc_dma(struct iwl_trans *trans,
 				     struct iwl_txq **intxq, int size,
 				     unsigned int timeout)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	size_t bc_tbl_size, bc_tbl_entries;
 	struct iwl_txq *txq;
 	int ret;
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
-		bc_tbl_size = sizeof(struct iwl_gen3_bc_tbl);
-		bc_tbl_entries = bc_tbl_size / sizeof(u16);
-	} else {
-		bc_tbl_size = sizeof(struct iwlagn_scd_bc_tbl);
-		bc_tbl_entries = bc_tbl_size / sizeof(u16);
-	}
+	WARN_ON(!trans->txqs.bc_tbl_size);
+
+	bc_tbl_size = trans->txqs.bc_tbl_size;
+	bc_tbl_entries = bc_tbl_size / sizeof(u16);
 
 	if (WARN_ON(size > bc_tbl_entries))
 		return -EINVAL;
@@ -1293,7 +1289,7 @@ int iwl_trans_pcie_dyn_txq_alloc_dma(struct iwl_trans *trans,
 	if (!txq)
 		return -ENOMEM;
 
-	txq->bc_tbl.addr = dma_pool_alloc(trans_pcie->bc_pool, GFP_KERNEL,
+	txq->bc_tbl.addr = dma_pool_alloc(trans->txqs.bc_pool, GFP_KERNEL,
 					  &txq->bc_tbl.dma);
 	if (!txq->bc_tbl.addr) {
 		IWL_ERR(trans, "Scheduler BC Table allocation failed\n");
-- 
2.28.0

