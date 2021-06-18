Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367773AC5AF
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 10:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbhFRIFq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 04:05:46 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48096 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233027AbhFRIEE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 04:04:04 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lu9RR-001YIf-Er; Fri, 18 Jun 2021 11:01:31 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 11:01:19 +0300
Message-Id: <iwlwifi.20210618105614.8230d91a46c1.Ia7db71e5e6265ca87363f1481eac1bc3bbebb15c@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618080121.588233-1-luca@coelho.fi>
References: <20210618080121.588233-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 08/10] iwlwifi: pcie: free some DMA memory earlier
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In gen3, after firmware is alive, we no longer need the
firmware and image loader images, only the context info
itself and PRPH info/scratch need to remain.

Call iwl_pcie_ctxt_info_gen3_free() appropriately in the
alive callback (iwl_trans_pcie_gen2_fw_alive()) with a new
argument indicating whether it can free everything or only
partially.

The context info and PRPH scratch are also not needed after
PNVM load, but we don't have a good hook for freeing after
that, so keep them for now.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  4 ++--
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 23 ++++++++++++-------
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  6 +++--
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index 2be605cc6fbf..518a1bc79584 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2018, 2020 Intel Corporation
+ * Copyright (C) 2018, 2020-2021 Intel Corporation
  */
 #ifndef __iwl_context_info_file_gen3_h__
 #define __iwl_context_info_file_gen3_h__
@@ -245,7 +245,7 @@ struct iwl_context_info_gen3 {
 
 int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 				 const struct fw_img *fw);
-void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans);
+void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans, bool alive);
 
 int iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
 					  const void *data, u32 len);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index c7b9ca264429..c69a1541e678 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -231,32 +231,39 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 
 }
 
-void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans)
+void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans, bool alive)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
+	if (trans_pcie->iml) {
+		dma_free_coherent(trans->dev, trans->iml_len, trans_pcie->iml,
+				  trans_pcie->iml_dma_addr);
+		trans_pcie->iml_dma_addr = 0;
+		trans_pcie->iml = NULL;
+	}
+
+	iwl_pcie_ctxt_info_free_fw_img(trans);
+
+	if (alive)
+		return;
+
 	if (!trans_pcie->ctxt_info_gen3)
 		return;
 
+	/* ctxt_info_gen3 and prph_scratch are still needed for PNVM load */
 	dma_free_coherent(trans->dev, sizeof(*trans_pcie->ctxt_info_gen3),
 			  trans_pcie->ctxt_info_gen3,
 			  trans_pcie->ctxt_info_dma_addr);
 	trans_pcie->ctxt_info_dma_addr = 0;
 	trans_pcie->ctxt_info_gen3 = NULL;
 
-	dma_free_coherent(trans->dev, trans->iml_len, trans_pcie->iml,
-			  trans_pcie->iml_dma_addr);
-	trans_pcie->iml_dma_addr = 0;
-	trans_pcie->iml = NULL;
-
-	iwl_pcie_ctxt_info_free_fw_img(trans);
-
 	dma_free_coherent(trans->dev, sizeof(*trans_pcie->prph_scratch),
 			  trans_pcie->prph_scratch,
 			  trans_pcie->prph_scratch_dma_addr);
 	trans_pcie->prph_scratch_dma_addr = 0;
 	trans_pcie->prph_scratch = NULL;
 
+	/* this is needed for the entire lifetime */
 	dma_free_coherent(trans->dev, PAGE_SIZE, trans_pcie->prph_info,
 			  trans_pcie->prph_info_dma_addr);
 	trans_pcie->prph_info_dma_addr = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 93b957866beb..a34009357227 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -149,7 +149,7 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 
 	iwl_pcie_ctxt_info_free_paging(trans);
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
-		iwl_pcie_ctxt_info_gen3_free(trans);
+		iwl_pcie_ctxt_info_gen3_free(trans, false);
 	else
 		iwl_pcie_ctxt_info_free(trans);
 
@@ -323,7 +323,9 @@ void iwl_trans_pcie_gen2_fw_alive(struct iwl_trans *trans, u32 scd_addr)
 	/* now that we got alive we can free the fw image & the context info.
 	 * paging memory cannot be freed included since FW will still use it
 	 */
-	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+		iwl_pcie_ctxt_info_gen3_free(trans, true);
+	else
 		iwl_pcie_ctxt_info_free(trans);
 
 	/*
-- 
2.32.0

