Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86418127A5C
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 12:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfLTL5F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 06:57:05 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:54024 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727177AbfLTL5F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 06:57:05 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iiGtp-0007ip-Hi; Fri, 20 Dec 2019 13:56:54 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 20 Dec 2019 13:56:38 +0200
Message-Id: <20191220115638.1299888-11-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191220115638.1299888-1-luca@coelho.fi>
References: <20191220115638.1299888-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.5 10/10] iwlwifi: pcie: extend hardware workaround to context-info
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

After more investigation on the hardware side, it appears that the
hardware bug regarding 2^32 boundary reaching/crossing also affects
other uses of the DMA engine, in particular the ones triggered by
the context-info (image loader) mechanism.

It also turns out that the bug only affects devices with gen2 TX
hardware engine, so we don't need to change context info for gen3.
The TX path workarounds are simpler to still keep for both though.

Add the workaround to that code as well; this is a lot simpler as
we have just a single way to allocate DMA memory there.

I made the algorithm recursive (with a small limit) since it's
actually (almost) impossible to hit this today - dma_alloc_coherent
is currently documented to always return 32-bit addressable memory
regardless of the DMA mask for it, and so we could only get REALLY
unlucky to get the very last page in that area.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   | 45 +++++++++++++++++--
 .../wireless/intel/iwlwifi/pcie/internal.h    | 10 +++++
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 14 +-----
 3 files changed, 54 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index d38cefbb779e..e249e3fd14c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -57,6 +57,42 @@
 #include "internal.h"
 #include "iwl-prph.h"
 
+static void *_iwl_pcie_ctxt_info_dma_alloc_coherent(struct iwl_trans *trans,
+						    size_t size,
+						    dma_addr_t *phys,
+						    int depth)
+{
+	void *result;
+
+	if (WARN(depth > 2,
+		 "failed to allocate DMA memory not crossing 2^32 boundary"))
+		return NULL;
+
+	result = dma_alloc_coherent(trans->dev, size, phys, GFP_KERNEL);
+
+	if (!result)
+		return NULL;
+
+	if (unlikely(iwl_pcie_crosses_4g_boundary(*phys, size))) {
+		void *old = result;
+		dma_addr_t oldphys = *phys;
+
+		result = _iwl_pcie_ctxt_info_dma_alloc_coherent(trans, size,
+								phys,
+								depth + 1);
+		dma_free_coherent(trans->dev, size, old, oldphys);
+	}
+
+	return result;
+}
+
+static void *iwl_pcie_ctxt_info_dma_alloc_coherent(struct iwl_trans *trans,
+						   size_t size,
+						   dma_addr_t *phys)
+{
+	return _iwl_pcie_ctxt_info_dma_alloc_coherent(trans, size, phys, 0);
+}
+
 void iwl_pcie_ctxt_info_free_paging(struct iwl_trans *trans)
 {
 	struct iwl_self_init_dram *dram = &trans->init_dram;
@@ -161,14 +197,17 @@ int iwl_pcie_ctxt_info_init(struct iwl_trans *trans,
 	struct iwl_context_info *ctxt_info;
 	struct iwl_context_info_rbd_cfg *rx_cfg;
 	u32 control_flags = 0, rb_size;
+	dma_addr_t phys;
 	int ret;
 
-	ctxt_info = dma_alloc_coherent(trans->dev, sizeof(*ctxt_info),
-				       &trans_pcie->ctxt_info_dma_addr,
-				       GFP_KERNEL);
+	ctxt_info = iwl_pcie_ctxt_info_dma_alloc_coherent(trans,
+							  sizeof(*ctxt_info),
+							  &phys);
 	if (!ctxt_info)
 		return -ENOMEM;
 
+	trans_pcie->ctxt_info_dma_addr = phys;
+
 	ctxt_info->version.version = 0;
 	ctxt_info->version.mac_id =
 		cpu_to_le16((u16)iwl_read32(trans, CSR_HW_REV));
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 04361ecf31bd..f14bcef3495e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -672,6 +672,16 @@ void iwl_pcie_disable_ict(struct iwl_trans *trans);
 /*****************************************************
 * TX / HCMD
 ******************************************************/
+/*
+ * We need this inline in case dma_addr_t is only 32-bits - since the
+ * hardware is always 64-bit, the issue can still occur in that case,
+ * so use u64 for 'phys' here to force the addition in 64-bit.
+ */
+static inline bool iwl_pcie_crosses_4g_boundary(u64 phys, u16 len)
+{
+	return upper_32_bits(phys) != upper_32_bits(phys + len);
+}
+
 int iwl_pcie_tx_init(struct iwl_trans *trans);
 int iwl_pcie_gen2_tx_init(struct iwl_trans *trans, int txq_id,
 			  int queue_size);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 4adda83d5f02..5ad02e816e21 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -213,16 +213,6 @@ static void iwl_pcie_gen2_free_tfd(struct iwl_trans *trans, struct iwl_txq *txq)
 	}
 }
 
-/*
- * We need this inline in case dma_addr_t is only 32-bits - since the
- * hardware is always 64-bit, the issue can still occur in that case,
- * so use u64 for 'phys' here to force the addition in 64-bit.
- */
-static inline bool crosses_4g_boundary(u64 phys, u16 len)
-{
-	return upper_32_bits(phys) != upper_32_bits(phys + len);
-}
-
 static int iwl_pcie_gen2_set_tb(struct iwl_trans *trans,
 				struct iwl_tfh_tfd *tfd, dma_addr_t addr,
 				u16 len)
@@ -238,7 +228,7 @@ static int iwl_pcie_gen2_set_tb(struct iwl_trans *trans,
 	 * there's no more space, and so when we know there is enough we
 	 * don't always check ...
 	 */
-	WARN(crosses_4g_boundary(addr, len),
+	WARN(iwl_pcie_crosses_4g_boundary(addr, len),
 	     "possible DMA problem with iova:0x%llx, len:%d\n",
 	     (unsigned long long)addr, len);
 
@@ -300,7 +290,7 @@ static int iwl_pcie_gen2_set_tb_with_wa(struct iwl_trans *trans,
 	if (unlikely(dma_mapping_error(trans->dev, phys)))
 		return -ENOMEM;
 
-	if (likely(!crosses_4g_boundary(phys, len))) {
+	if (likely(!iwl_pcie_crosses_4g_boundary(phys, len))) {
 		ret = iwl_pcie_gen2_set_tb(trans, tfd, phys, len);
 
 		if (ret < 0)
-- 
2.24.0

