Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867271B8581
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 12:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgDYKFQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 06:05:16 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58236 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726307AbgDYKFP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 06:05:15 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jSHgO-000P3t-PZ; Sat, 25 Apr 2020 13:05:13 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 25 Apr 2020 13:04:53 +0300
Message-Id: <iwlwifi.20200425130140.6e84c79aea30.Ie9a417132812d110ec1cc87852f101477c01cfcb@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200425100459.2778317-1-luca@coelho.fi>
References: <20200425100459.2778317-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 05/11] iwlwifi: pcie: gen2: use DMA pool for byte-count tables
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Since the recent patch in this area, we no longer allocate 64k
for a single queue, but only 1k, which still means a full page.
Use a DMA pool to reduce this further, since we will have a lot
of queues in a typical system that can share pages.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/pcie/internal.h    |  1 +
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 19 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 11 ++++++++---
 3 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index abe649af689c..43f81204c152 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -556,6 +556,7 @@ struct iwl_trans_pcie {
 	u32 scd_base_addr;
 	struct iwl_dma_ptr scd_bc_tbls;
 	struct iwl_dma_ptr kw;
+	struct dma_pool *bc_pool;
 
 	struct iwl_txq *txq_memory;
 	struct iwl_txq *txq[IWL_MAX_TVQM_QUEUES];
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index a0daae058c1c..8ccfc7cc7348 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3672,6 +3672,25 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	init_waitqueue_head(&trans_pcie->sx_waitq);
 
+	/*
+	 * For gen2 devices, we use a single allocation for each byte-count
+	 * table, but they're pretty small (1k) so use a DMA pool that we
+	 * allocate here.
+	 */
+	if (cfg_trans->gen2) {
+		size_t bc_tbl_size;
+
+		if (cfg_trans->device_family >= IWL_DEVICE_FAMILY_AX210)
+			bc_tbl_size = sizeof(struct iwl_gen3_bc_tbl);
+		else
+			bc_tbl_size = sizeof(struct iwlagn_scd_bc_tbl);
+
+		trans_pcie->bc_pool = dmam_pool_create("iwlwifi:bc", &pdev->dev,
+						       bc_tbl_size, 256, 0);
+		if (!trans_pcie->bc_pool)
+			goto out_no_pci;
+	}
+
 	if (trans_pcie->msix_enabled) {
 		ret = iwl_pcie_init_msix_handler(pdev, trans_pcie);
 		if (ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 36f4e81eb70a..766f9bec7586 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -1224,7 +1224,9 @@ void iwl_pcie_gen2_txq_free_memory(struct iwl_trans *trans,
 	}
 
 	kfree(txq->entries);
-	iwl_pcie_free_dma_ptr(trans, &txq->bc_tbl);
+	if (txq->bc_tbl.addr)
+		dma_pool_free(trans_pcie->bc_pool, txq->bc_tbl.addr,
+			      txq->bc_tbl.dma);
 	kfree(txq);
 }
 
@@ -1272,6 +1274,7 @@ int iwl_trans_pcie_dyn_txq_alloc_dma(struct iwl_trans *trans,
 				     struct iwl_txq **intxq, int size,
 				     unsigned int timeout)
 {
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	size_t bc_tbl_size, bc_tbl_entries;
 	struct iwl_txq *txq;
 	int ret;
@@ -1290,8 +1293,10 @@ int iwl_trans_pcie_dyn_txq_alloc_dma(struct iwl_trans *trans,
 	txq = kzalloc(sizeof(*txq), GFP_KERNEL);
 	if (!txq)
 		return -ENOMEM;
-	ret = iwl_pcie_alloc_dma_ptr(trans, &txq->bc_tbl, bc_tbl_size);
-	if (ret) {
+
+	txq->bc_tbl.addr = dma_pool_alloc(trans_pcie->bc_pool, GFP_KERNEL,
+					  &txq->bc_tbl.dma);
+	if (!txq->bc_tbl.addr) {
 		IWL_ERR(trans, "Scheduler BC Table allocation failed\n");
 		kfree(txq);
 		return -ENOMEM;
-- 
2.26.2

