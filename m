Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669DC723A63
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 09:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbjFFHsR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 03:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbjFFHqQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 03:46:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1AC26B8
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 00:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686037432; x=1717573432;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JN8MDTvQMyCOUiLrD+/sNVyQ8GHSEs1UDWlYoYOWXZM=;
  b=JNIoQSXZ7rYLOo2FBa77RrPTlak+O0ni7Ukj6JKZKPaTubVcxFtVChSK
   4340u072HUW8EL03fHRWuqDZmU4zQZOe9ArUlfoYxdwgclcWKWbdx0ZTE
   B41rgfkctLpmD1JuxiYaz9EQKwqQEkIf1W8dlIapUNQBROrb8gZ8mShiN
   RxmjA55UpDzf80RdI6ZpMyv5icuygeOR4STD0N8cBSoTDiqpfZN112UWn
   h0E4CTehqeZYZO5xXeN6yFdo3DfNLTHEcI5bdjshBp/563GPdx8a2p/Yk
   ms99v6AZEYowDmb6DLRLNdrqer22WN1kPe68PRIUP305A78W993pD3HFP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422419046"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="422419046"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821516233"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="821516233"
Received: from oniamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.217.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:23 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/13] wifi: iwlwifi: Generalize the parsing of the pnvm image
Date:   Tue,  6 Jun 2023 10:42:58 +0300
Message-Id: <20230606103519.06c02f380b6f.I03a3030fca194aa0c4bc2ecd18531f8914e98cfd@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230606074310.889520-1-gregory.greenman@intel.com>
References: <20230606074310.889520-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Alon Giladi <alon.giladi@intel.com>

Generalize iwl_pnvm_parse(). This saves us from copying each payload
twice (first in the parsing and later when copying it to the dram).
Moreover, its  more compatible for handling larger pnvm tables in
the future (in which payloads won't be concatenated).

The main changes are:

1. Take out the concatenating of the payloads from the parsing level
2. Start using iwl_pnvm_image structure that will hold pointers to
payloads that should be delivered to fw, their sizes and number.

Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  | 43 +++++++------------
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  4 +-
 .../wireless/intel/iwlwifi/iwl-context-info.h |  5 ++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 23 ++++++++--
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 34 +++++++++++----
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |  8 ++--
 6 files changed, 72 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index c6f2672fdc73..bec3c7ec3f4c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -36,10 +36,8 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
 	const struct iwl_ucode_tlv *tlv;
 	u32 sha1 = 0;
 	u16 mac_type = 0, rf_id = 0;
-	u8 *pnvm_data = NULL, *tmp;
+	struct iwl_pnvm_image pnvm_data = {};
 	bool hw_match = false;
-	u32 size = 0;
-	int ret;
 
 	IWL_DEBUG_FW(trans, "Handling PNVM section\n");
 
@@ -55,8 +53,7 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
 		if (len < tlv_len) {
 			IWL_ERR(trans, "invalid TLV len: %zd/%u\n",
 				len, tlv_len);
-			ret = -EINVAL;
-			goto out;
+			return -EINVAL;
 		}
 
 		data += sizeof(*tlv);
@@ -112,23 +109,18 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
 				break;
 			}
 
-			IWL_DEBUG_FW(trans, "Adding data (size %d)\n",
-				     data_len);
-
-			tmp = krealloc(pnvm_data, size + data_len, GFP_KERNEL);
-			if (!tmp) {
+			if (pnvm_data.n_chunks == IPC_DRAM_MAP_ENTRY_NUM_MAX) {
 				IWL_DEBUG_FW(trans,
-					     "Couldn't allocate (more) pnvm_data\n");
-
-				ret = -ENOMEM;
-				goto out;
+					     "too many payloads to allocate in DRAM.\n");
+				return -EINVAL;
 			}
 
-			pnvm_data = tmp;
-
-			memcpy(pnvm_data + size, section->data, data_len);
+			IWL_DEBUG_FW(trans, "Adding data (size %d)\n",
+				     data_len);
 
-			size += data_len;
+			pnvm_data.chunks[pnvm_data.n_chunks].data = section->data;
+			pnvm_data.chunks[pnvm_data.n_chunks].len = data_len;
+			pnvm_data.n_chunks++;
 
 			break;
 		}
@@ -152,22 +144,17 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
 			     "HW mismatch, skipping PNVM section (need mac_type 0x%x rf_id 0x%x)\n",
 			     CSR_HW_REV_TYPE(trans->hw_rev),
 			     CSR_HW_RFID_TYPE(trans->hw_rf_id));
-		ret = -ENOENT;
-		goto out;
+		return -ENOENT;
 	}
 
-	if (!size) {
+	if (!pnvm_data.n_chunks) {
 		IWL_DEBUG_FW(trans, "Empty PNVM, skipping.\n");
-		ret = -ENOENT;
-		goto out;
+		return -ENOENT;
 	}
 
 	IWL_INFO(trans, "loaded PNVM version %08x\n", sha1);
 
-	ret = iwl_trans_set_pnvm(trans, pnvm_data, size);
-out:
-	kfree(pnvm_data);
-	return ret;
+	return iwl_trans_set_pnvm(trans, &pnvm_data);
 }
 
 static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
@@ -275,7 +262,7 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 	 * need to set it again.
 	 */
 	if (trans->pnvm_loaded) {
-		ret = iwl_trans_set_pnvm(trans, NULL, 0);
+		ret = iwl_trans_set_pnvm(trans, NULL);
 		if (ret)
 			return ret;
 		goto skip_parse;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index 3f7278014009..9d2dcb64523c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -13,6 +13,8 @@
 #define CSR_IML_SIZE_ADDR               0x128
 #define CSR_IML_RESP_ADDR               0x12c
 
+#define UNFRAGMENTED_PNVM_PAYLOADS_NUMBER 2
+
 /* Set bit for enabling automatic function boot */
 #define CSR_AUTO_FUNC_BOOT_ENA          BIT(1)
 /* Set bit for initiating function boot */
@@ -278,7 +280,7 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans, bool alive);
 
 int iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
-					  const void *data, u32 len);
+					  const struct iwl_pnvm_image *pnvm_payloads);
 int iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans,
 						  const void *data, u32 len);
 int iwl_trans_pcie_ctx_info_gen3_set_step(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
index 4354d5acac9f..1a1321db137c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2020, 2022 Intel Corporation
  */
 #ifndef __iwl_context_info_file_h__
 #define __iwl_context_info_file_h__
@@ -177,6 +177,9 @@ void iwl_pcie_ctxt_info_free_paging(struct iwl_trans *trans);
 int iwl_pcie_init_fw_sec(struct iwl_trans *trans,
 			 const struct fw_img *fw,
 			 struct iwl_context_info_dram *ctxt_dram);
+void *iwl_pcie_ctxt_info_dma_alloc_coherent(struct iwl_trans *trans,
+					    size_t size,
+					    dma_addr_t *phys);
 int iwl_pcie_ctxt_info_alloc_dma(struct iwl_trans *trans,
 				 const void *data, u32 len,
 				 struct iwl_dram_data *dram);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 9f1228b5a384..35ddb4cfa356 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -459,6 +459,22 @@ struct iwl_trans_rxq_dma_data {
 	u64 ur_bd_cb;
 };
 
+/* maximal number of DRAM MAP entries supported by FW */
+#define IPC_DRAM_MAP_ENTRY_NUM_MAX 64
+
+/**
+ * struct iwl_pnvm_image - contains info about the parsed pnvm image
+ * @chunks: array of pointers to pnvm payloads and their sizes
+ * @n_chunks: the number of the pnvm payloads.
+ */
+struct iwl_pnvm_image {
+	struct {
+		const void *data;
+		u32 len;
+	} chunks[IPC_DRAM_MAP_ENTRY_NUM_MAX];
+	u32 n_chunks;
+};
+
 /**
  * struct iwl_trans_ops - transport specific operations
  *
@@ -614,7 +630,8 @@ struct iwl_trans_ops {
 						 void *sanitize_ctx);
 	void (*debugfs_cleanup)(struct iwl_trans *trans);
 	void (*sync_nmi)(struct iwl_trans *trans);
-	int (*set_pnvm)(struct iwl_trans *trans, const void *data, u32 len);
+	int (*set_pnvm)(struct iwl_trans *trans,
+			const struct iwl_pnvm_image *pnvm_data);
 	int (*set_reduce_power)(struct iwl_trans *trans,
 				const void *data, u32 len);
 	void (*interrupts)(struct iwl_trans *trans, bool enable);
@@ -1516,10 +1533,10 @@ void iwl_trans_sync_nmi_with_addr(struct iwl_trans *trans, u32 inta_addr,
 				  u32 sw_err_bit);
 
 static inline int iwl_trans_set_pnvm(struct iwl_trans *trans,
-				     const void *data, u32 len)
+				     const struct iwl_pnvm_image *pnvm_data)
 {
 	if (trans->ops->set_pnvm) {
-		int ret = trans->ops->set_pnvm(trans, data, len);
+		int ret = trans->ops->set_pnvm(trans, pnvm_data);
 
 		if (ret)
 			return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index cb60ba40fe97..800857e61d65 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -282,28 +282,46 @@ void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans, bool alive)
 }
 
 int iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
-					  const void *data, u32 len)
+					  const struct iwl_pnvm_image *pnvm_payloads)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
 		&trans_pcie->prph_scratch->ctrl_cfg;
-	int ret;
+	struct iwl_dram_data *dram = &trans_pcie->pnvm_dram;
 
 	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		return 0;
 
 	/* only allocate the DRAM if not allocated yet */
 	if (!trans->pnvm_loaded) {
+		u32 len, len0, len1;
+
 		if (WARN_ON(prph_sc_ctrl->pnvm_cfg.pnvm_size))
 			return -EBUSY;
 
-		ret = iwl_pcie_ctxt_info_alloc_dma(trans, data, len,
-						   &trans_pcie->pnvm_dram);
-		if (ret < 0) {
-			IWL_DEBUG_FW(trans, "Failed to allocate PNVM DMA %d.\n",
-				     ret);
-			return ret;
+		if (pnvm_payloads->n_chunks !=
+			UNFRAGMENTED_PNVM_PAYLOADS_NUMBER) {
+			IWL_DEBUG_FW(trans, "expected 2 payloads, got %d.\n",
+				     pnvm_payloads->n_chunks);
+			return -EINVAL;
+		}
+		len0 = pnvm_payloads->chunks[0].len;
+		len1 = pnvm_payloads->chunks[1].len;
+		if (len1 > 0xFFFFFFFF - len0) {
+			IWL_DEBUG_FW(trans, "sizes of payloads overflow.\n");
+			return -EINVAL;
+		}
+		len = len0 + len1;
+
+		dram->block = iwl_pcie_ctxt_info_dma_alloc_coherent(trans, len, &dram->physical);
+		if (!dram->block) {
+			IWL_DEBUG_FW(trans, "Failed to allocate PNVM DMA.\n");
+			return -ENOMEM;
 		}
+		dram->size = len;
+		memcpy(dram->block, pnvm_payloads->chunks[0].data, len0);
+		memcpy((u8 *)dram->block + len0, pnvm_payloads->chunks[1].data,
+		       len1);
 	}
 
 	prph_sc_ctrl->pnvm_cfg.pnvm_base_addr =
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
index 74ce31fdf45e..5f55efe64bf5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2021 Intel Corporation
+ * Copyright (C) 2018-2022 Intel Corporation
  */
 #include "iwl-trans.h"
 #include "iwl-fh.h"
@@ -38,9 +38,9 @@ static void *_iwl_pcie_ctxt_info_dma_alloc_coherent(struct iwl_trans *trans,
 	return result;
 }
 
-static void *iwl_pcie_ctxt_info_dma_alloc_coherent(struct iwl_trans *trans,
-						   size_t size,
-						   dma_addr_t *phys)
+void *iwl_pcie_ctxt_info_dma_alloc_coherent(struct iwl_trans *trans,
+					    size_t size,
+					    dma_addr_t *phys)
 {
 	return _iwl_pcie_ctxt_info_dma_alloc_coherent(trans, size, phys, 0);
 }
-- 
2.38.1

