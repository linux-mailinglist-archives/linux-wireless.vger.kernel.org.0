Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B34723A62
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 09:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbjFFHsP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 03:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235861AbjFFHqQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 03:46:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833FD2133
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 00:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686037431; x=1717573431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q40Ce5dVR+9ECIiLvPMIzFvuN0sTQ/em+QWIw9Jt6g8=;
  b=iBB5ix7PQ/HKXrz+/qS/HYQgGiXjdwQJ0SvtcS4FzWnrQo9MsiLhFWrF
   j54km5JB/nTQtjKMZAZ66oAecqI1/6gczxxozhVee+Oi7UzqZ6R34lcrA
   IslBtyrmI7nSRGmAVNA9FrwtGAHxnuzj8LDWQD7hJjTo6YiQLm2Qqi97I
   0IKjQQ/502gJaMKioVILm7snsfnGrtEPSCsEsKaw58w3y5RrP3b64Tq1n
   jrqhoMQMzM86VlIzlqd2nwpGEtoVhzddGH4DWEojgLXe2j7N++CnNUY22
   A7Uz5bqIlNA7W81pbxUS6nb1zsxgN+s+4Ow/YNzVIzlW8COinT7m5CT3g
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422419053"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="422419053"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821516250"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="821516250"
Received: from oniamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.217.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:26 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/13] wifi: iwlwifi: Separate loading and setting of pnvm image into two functions
Date:   Tue,  6 Jun 2023 10:42:59 +0300
Message-Id: <20230606103519.4c0728239fd6.Ibc30a9fbdb6123dadbe2dbb89318dbd5ec01080a@changeid>
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

Take the part that is copying the pnvm image into DRAM, out of the
the method that sets the prph_scratch. Makes the code cleaner since
those 2 operations don't always happen together (loading should happen
only once while setting can happen more than once).
In addition, each operation will get more complex in the future when
it will support also larger pnvm images.

Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  | 12 ++--
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  5 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 25 ++++---
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 69 +++++++++++--------
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  1 +
 5 files changed, 65 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index bec3c7ec3f4c..f99328cc6b01 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -38,6 +38,7 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
 	u16 mac_type = 0, rf_id = 0;
 	struct iwl_pnvm_image pnvm_data = {};
 	bool hw_match = false;
+	int ret;
 
 	IWL_DEBUG_FW(trans, "Handling PNVM section\n");
 
@@ -152,9 +153,14 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
 		return -ENOENT;
 	}
 
+	ret = iwl_trans_load_pnvm(trans, &pnvm_data);
+	if (ret)
+		return ret;
+
 	IWL_INFO(trans, "loaded PNVM version %08x\n", sha1);
 
-	return iwl_trans_set_pnvm(trans, &pnvm_data);
+	iwl_trans_set_pnvm(trans);
+	return 0;
 }
 
 static int iwl_pnvm_parse(struct iwl_trans *trans, const u8 *data,
@@ -262,9 +268,7 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 	 * need to set it again.
 	 */
 	if (trans->pnvm_loaded) {
-		ret = iwl_trans_set_pnvm(trans, NULL);
-		if (ret)
-			return ret;
+		iwl_trans_set_pnvm(trans);
 		goto skip_parse;
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index 9d2dcb64523c..9f718e43dd81 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -279,8 +279,9 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 				 const struct fw_img *fw);
 void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans, bool alive);
 
-int iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
-					  const struct iwl_pnvm_image *pnvm_payloads);
+int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
+					   const struct iwl_pnvm_image *pnvm_payloads);
+void iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans);
 int iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans,
 						  const void *data, u32 len);
 int iwl_trans_pcie_ctx_info_gen3_set_step(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 35ddb4cfa356..a7e8d45c874c 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -557,6 +557,7 @@ struct iwl_pnvm_image {
  *	Note that the transport must fill in the proper file headers.
  * @debugfs_cleanup: used in the driver unload flow to make a proper cleanup
  *	of the trans debugfs
+ * @load_pnvm: save the pnvm data in DRAM
  * @set_pnvm: set the pnvm data in the prph scratch buffer, inside the
  *	context info.
  * @interrupts: disable/enable interrupts to transport
@@ -630,8 +631,9 @@ struct iwl_trans_ops {
 						 void *sanitize_ctx);
 	void (*debugfs_cleanup)(struct iwl_trans *trans);
 	void (*sync_nmi)(struct iwl_trans *trans);
-	int (*set_pnvm)(struct iwl_trans *trans,
-			const struct iwl_pnvm_image *pnvm_data);
+	int (*load_pnvm)(struct iwl_trans *trans,
+			 const struct iwl_pnvm_image *pnvm_payloads);
+	void (*set_pnvm)(struct iwl_trans *trans);
 	int (*set_reduce_power)(struct iwl_trans *trans,
 				const void *data, u32 len);
 	void (*interrupts)(struct iwl_trans *trans, bool enable);
@@ -1532,19 +1534,16 @@ static inline void iwl_trans_sync_nmi(struct iwl_trans *trans)
 void iwl_trans_sync_nmi_with_addr(struct iwl_trans *trans, u32 inta_addr,
 				  u32 sw_err_bit);
 
-static inline int iwl_trans_set_pnvm(struct iwl_trans *trans,
-				     const struct iwl_pnvm_image *pnvm_data)
+static inline int iwl_trans_load_pnvm(struct iwl_trans *trans,
+				      const struct iwl_pnvm_image *pnvm_data)
 {
-	if (trans->ops->set_pnvm) {
-		int ret = trans->ops->set_pnvm(trans, pnvm_data);
-
-		if (ret)
-			return ret;
-	}
-
-	trans->pnvm_loaded = true;
+	return trans->ops->load_pnvm(trans, pnvm_data);
+}
 
-	return 0;
+static inline void iwl_trans_set_pnvm(struct iwl_trans *trans)
+{
+	if (trans->ops->set_pnvm)
+		trans->ops->set_pnvm(trans);
 }
 
 static inline int iwl_trans_set_reduce_power(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 800857e61d65..e9f3799d4593 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -281,55 +281,68 @@ void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans, bool alive)
 	trans_pcie->prph_info = NULL;
 }
 
-int iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
-					  const struct iwl_pnvm_image *pnvm_payloads)
+int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
+					   const struct iwl_pnvm_image *pnvm_payloads)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
 		&trans_pcie->prph_scratch->ctrl_cfg;
 	struct iwl_dram_data *dram = &trans_pcie->pnvm_dram;
+	u32 len, len0, len1;
 
 	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		return 0;
 
 	/* only allocate the DRAM if not allocated yet */
-	if (!trans->pnvm_loaded) {
-		u32 len, len0, len1;
+	if (trans->pnvm_loaded)
+		return 0;
 
-		if (WARN_ON(prph_sc_ctrl->pnvm_cfg.pnvm_size))
-			return -EBUSY;
+	if (WARN_ON(prph_sc_ctrl->pnvm_cfg.pnvm_size))
+		return -EBUSY;
 
-		if (pnvm_payloads->n_chunks !=
-			UNFRAGMENTED_PNVM_PAYLOADS_NUMBER) {
-			IWL_DEBUG_FW(trans, "expected 2 payloads, got %d.\n",
-				     pnvm_payloads->n_chunks);
-			return -EINVAL;
-		}
-		len0 = pnvm_payloads->chunks[0].len;
-		len1 = pnvm_payloads->chunks[1].len;
-		if (len1 > 0xFFFFFFFF - len0) {
-			IWL_DEBUG_FW(trans, "sizes of payloads overflow.\n");
+	if (pnvm_payloads->n_chunks != UNFRAGMENTED_PNVM_PAYLOADS_NUMBER) {
+		IWL_DEBUG_FW(trans, "expected 2 payloads, got %d.\n",
+			     pnvm_payloads->n_chunks);
 			return -EINVAL;
-		}
-		len = len0 + len1;
+	}
 
-		dram->block = iwl_pcie_ctxt_info_dma_alloc_coherent(trans, len, &dram->physical);
-		if (!dram->block) {
-			IWL_DEBUG_FW(trans, "Failed to allocate PNVM DMA.\n");
-			return -ENOMEM;
-		}
-		dram->size = len;
-		memcpy(dram->block, pnvm_payloads->chunks[0].data, len0);
-		memcpy((u8 *)dram->block + len0, pnvm_payloads->chunks[1].data,
-		       len1);
+	len0 = pnvm_payloads->chunks[0].len;
+	len1 = pnvm_payloads->chunks[1].len;
+	if (len1 > 0xFFFFFFFF - len0) {
+		IWL_DEBUG_FW(trans, "sizes of payloads overflow.\n");
+		return -EINVAL;
+	}
+	len = len0 + len1;
+
+	dram->block = iwl_pcie_ctxt_info_dma_alloc_coherent(trans, len,
+							    &dram->physical);
+	if (!dram->block) {
+		IWL_DEBUG_FW(trans, "Failed to allocate PNVM DMA.\n");
+		return -ENOMEM;
 	}
 
+	dram->size = len;
+	memcpy(dram->block, pnvm_payloads->chunks[0].data, len0);
+	memcpy((u8 *)dram->block + len0, pnvm_payloads->chunks[1].data, len1);
+
+	trans->pnvm_loaded = true;
+	return 0;
+}
+
+void iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
+		&trans_pcie->prph_scratch->ctrl_cfg;
+
+	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+		return;
+
 	prph_sc_ctrl->pnvm_cfg.pnvm_base_addr =
 		cpu_to_le64(trans_pcie->pnvm_dram.physical);
 	prph_sc_ctrl->pnvm_cfg.pnvm_size =
 		cpu_to_le32(trans_pcie->pnvm_dram.size);
 
-	return 0;
 }
 
 int iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index b281850fbf7a..6691d89d7226 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3534,6 +3534,7 @@ static const struct iwl_trans_ops trans_ops_pcie_gen2 = {
 	.txq_free = iwl_txq_dyn_free,
 	.wait_txq_empty = iwl_trans_pcie_wait_txq_empty,
 	.rxq_dma_data = iwl_trans_pcie_rxq_dma_data,
+	.load_pnvm = iwl_trans_pcie_ctx_info_gen3_load_pnvm,
 	.set_pnvm = iwl_trans_pcie_ctx_info_gen3_set_pnvm,
 	.set_reduce_power = iwl_trans_pcie_ctx_info_gen3_set_reduce_power,
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-- 
2.38.1

