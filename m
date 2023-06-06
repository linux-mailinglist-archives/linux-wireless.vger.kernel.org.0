Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A13B723A66
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 09:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbjFFHtM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 03:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbjFFHsc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 03:48:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B941991
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 00:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686037460; x=1717573460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V5tOJVHO1SMYEKWtdOfL36MQRKq53uphZiU0wSAUwog=;
  b=DGOpBjpikYaI0yxhMAxpaEO2mFObB8zseT5sfGO8udDcgbz88Xw/gAM4
   2tEsLJyuq688ZNaVLN8UVrgzfyOCn+QAquuu7dwR+nUScfuEVr0xU638a
   pfRgu2lbQxWUNd2cZplXEPSv9EFtLAfvcGt/zYdy3NM7iC0yXCcjtxRtm
   M1gIkpuSFxa0KVvpvdHUsqFFCBnWay1TVM0kLb2UpOjqCmPkYOfLKTP1O
   WIgENAXF6IDAFOn8oetHX4JNplX9St+BdmNzf18m96wKU1+V8hFCrjzDj
   kPmxB0jII/eP2CAAj+AXibodHGmdunFblPlPq/QeEpDa14nTvpgSAJJAf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422419072"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="422419072"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821516298"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="821516298"
Received: from oniamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.217.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:32 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 05/13] wifi: iwlwifi: Add support for fragmented pnvm images
Date:   Tue,  6 Jun 2023 10:43:02 +0300
Message-Id: <20230606103519.c49bfaf435a9.I0278312e7c3355b224cd870d4f8cf6578d12f03e@changeid>
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

Add support for fragmented pnvm images, depending on the FW capability.

Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  2 +
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |  7 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h  |  5 +-
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  6 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 16 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  3 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 95 ++++++++++++-------
 7 files changed, 88 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index cddf09d6be1c..96e15f2631ed 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -323,6 +323,7 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  *	is supported.
  * @IWL_UCODE_TLV_CAPA_BT_COEX_RRC: supports BT Coex RRC
  * @IWL_UCODE_TLV_CAPA_GSCAN_SUPPORT: supports gscan (no longer used)
+ * @IWL_UCODE_TLV_CAPA_FRAGMENTED_PNVM_IMG: supports fragmented PNVM image
  * @IWL_UCODE_TLV_CAPA_SOC_LATENCY_SUPPORT: the firmware supports setting
  *	stabilization latency for SoCs.
  * @IWL_UCODE_TLV_CAPA_STA_PM_NOTIF: firmware will send STA PM notification
@@ -398,6 +399,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_GSCAN_SUPPORT		= (__force iwl_ucode_tlv_capa_t)31,
 
 	/* set 1 */
+	IWL_UCODE_TLV_CAPA_FRAGMENTED_PNVM_IMG		= (__force iwl_ucode_tlv_capa_t)32,
 	IWL_UCODE_TLV_CAPA_SOC_LATENCY_SUPPORT		= (__force iwl_ucode_tlv_capa_t)37,
 	IWL_UCODE_TLV_CAPA_STA_PM_NOTIF			= (__force iwl_ucode_tlv_capa_t)38,
 	IWL_UCODE_TLV_CAPA_BINDING_CDB_SUPPORT		= (__force iwl_ucode_tlv_capa_t)39,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index cb6a9191cf95..91e1faef76f6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -271,7 +271,8 @@ static u8 *iwl_get_pnvm_image(struct iwl_trans *trans_p, size_t *len)
 }
 
 int iwl_pnvm_load(struct iwl_trans *trans,
-		  struct iwl_notif_wait_data *notif_wait)
+		  struct iwl_notif_wait_data *notif_wait,
+		  const struct iwl_ucode_capabilities *capa)
 {
 	u8 *data;
 	size_t length;
@@ -303,7 +304,7 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 			goto reduce_tables;
 		}
 
-		ret = iwl_trans_load_pnvm(trans, &pnvm_data);
+		ret = iwl_trans_load_pnvm(trans, &pnvm_data, capa);
 		/* can only free data after pvnm_data use, but
 		 * pnvm_data.version used below is not a pointer
 		 */
@@ -314,7 +315,7 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 			 pnvm_data.version);
 	}
 
-	iwl_trans_set_pnvm(trans);
+	iwl_trans_set_pnvm(trans, capa);
 
 reduce_tables:
 	/* now try to get the reduce power table, if not loaded yet */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
index 203c367dd4de..4e10baa01738 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /******************************************************************************
  *
- * Copyright(c) 2020-2021 Intel Corporation
+ * Copyright(c) 2020-2022 Intel Corporation
  *
  *****************************************************************************/
 
@@ -15,7 +15,8 @@
 #define MAX_PNVM_NAME  64
 
 int iwl_pnvm_load(struct iwl_trans *trans,
-		  struct iwl_notif_wait_data *notif_wait);
+		  struct iwl_notif_wait_data *notif_wait,
+		  const struct iwl_ucode_capabilities *capa);
 
 static inline
 void iwl_pnvm_get_fs_name(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index 9f718e43dd81..23208be831f3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -280,8 +280,10 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans, bool alive);
 
 int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
-					   const struct iwl_pnvm_image *pnvm_payloads);
-void iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans);
+					   const struct iwl_pnvm_image *pnvm_payloads,
+					   const struct iwl_ucode_capabilities *capa);
+void iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
+					   const struct iwl_ucode_capabilities *capa);
 int iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans,
 						  const void *data, u32 len);
 int iwl_trans_pcie_ctx_info_gen3_set_step(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 684b57df9b48..541841bc8f21 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -634,8 +634,10 @@ struct iwl_trans_ops {
 	void (*debugfs_cleanup)(struct iwl_trans *trans);
 	void (*sync_nmi)(struct iwl_trans *trans);
 	int (*load_pnvm)(struct iwl_trans *trans,
-			 const struct iwl_pnvm_image *pnvm_payloads);
-	void (*set_pnvm)(struct iwl_trans *trans);
+			 const struct iwl_pnvm_image *pnvm_payloads,
+			 const struct iwl_ucode_capabilities *capa);
+	void (*set_pnvm)(struct iwl_trans *trans,
+			 const struct iwl_ucode_capabilities *capa);
 	int (*set_reduce_power)(struct iwl_trans *trans,
 				const void *data, u32 len);
 	void (*interrupts)(struct iwl_trans *trans, bool enable);
@@ -1539,15 +1541,17 @@ void iwl_trans_sync_nmi_with_addr(struct iwl_trans *trans, u32 inta_addr,
 				  u32 sw_err_bit);
 
 static inline int iwl_trans_load_pnvm(struct iwl_trans *trans,
-				      const struct iwl_pnvm_image *pnvm_data)
+				      const struct iwl_pnvm_image *pnvm_data,
+				      const struct iwl_ucode_capabilities *capa)
 {
-	return trans->ops->load_pnvm(trans, pnvm_data);
+	return trans->ops->load_pnvm(trans, pnvm_data, capa);
 }
 
-static inline void iwl_trans_set_pnvm(struct iwl_trans *trans)
+static inline void iwl_trans_set_pnvm(struct iwl_trans *trans,
+				      const struct iwl_ucode_capabilities *capa)
 {
 	if (trans->ops->set_pnvm)
-		trans->ops->set_pnvm(trans);
+		trans->ops->set_pnvm(trans, capa);
 }
 
 static inline int iwl_trans_set_reduce_power(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index b35c96cf7ad2..1b5a80279e3c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -433,7 +433,8 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 	/* if reached this point, Alive notification was received */
 	iwl_mei_alive_notif(true);
 
-	ret = iwl_pnvm_load(mvm->trans, &mvm->notif_wait);
+	ret = iwl_pnvm_load(mvm->trans, &mvm->notif_wait,
+			    &mvm->fw->ucode_capa);
 	if (ret) {
 		IWL_ERR(mvm, "Timeout waiting for PNVM load!\n");
 		iwl_fw_set_current_image(&mvm->fwrt, old_type);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index f43246b45a85..fc450c0d1145 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -281,33 +281,20 @@ void iwl_pcie_ctxt_info_gen3_free(struct iwl_trans *trans, bool alive)
 	trans_pcie->prph_info = NULL;
 }
 
-int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
-					   const struct iwl_pnvm_image *pnvm_payloads)
+static int iwl_pcie_load_payloads_continuously(struct iwl_trans *trans,
+					       const struct iwl_pnvm_image *pnvm_data,
+					       struct iwl_dram_data *dram)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
-		&trans_pcie->prph_scratch->ctrl_cfg;
-	struct iwl_dram_data *dram = &trans_pcie->pnvm_dram[0];
 	u32 len, len0, len1;
 
-	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
-		return 0;
-
-	/* only allocate the DRAM if not allocated yet */
-	if (trans->pnvm_loaded)
-		return 0;
-
-	if (WARN_ON(prph_sc_ctrl->pnvm_cfg.pnvm_size))
-		return -EBUSY;
-
-	if (pnvm_payloads->n_chunks != UNFRAGMENTED_PNVM_PAYLOADS_NUMBER) {
+	if (pnvm_data->n_chunks != UNFRAGMENTED_PNVM_PAYLOADS_NUMBER) {
 		IWL_DEBUG_FW(trans, "expected 2 payloads, got %d.\n",
-			     pnvm_payloads->n_chunks);
-			return -EINVAL;
+			     pnvm_data->n_chunks);
+		return -EINVAL;
 	}
 
-	len0 = pnvm_payloads->chunks[0].len;
-	len1 = pnvm_payloads->chunks[1].len;
+	len0 = pnvm_data->chunks[0].len;
+	len1 = pnvm_data->chunks[1].len;
 	if (len1 > 0xFFFFFFFF - len0) {
 		IWL_DEBUG_FW(trans, "sizes of payloads overflow.\n");
 		return -EINVAL;
@@ -322,32 +309,76 @@ int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
 	}
 
 	dram->size = len;
-	memcpy(dram->block, pnvm_payloads->chunks[0].data, len0);
-	memcpy((u8 *)dram->block + len0, pnvm_payloads->chunks[1].data, len1);
-	trans_pcie->n_pnvm_regions = 1;
+	memcpy(dram->block, pnvm_data->chunks[0].data, len0);
+	memcpy((u8 *)dram->block + len0, pnvm_data->chunks[1].data, len1);
 
-	trans->pnvm_loaded = true;
 	return 0;
 }
 
-void iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans)
+/* FIXME: An implementation will be added with the next several commits. */
+static int iwl_pcie_load_payloads_segments(struct iwl_trans *trans,
+					   const struct iwl_pnvm_image *pnvm_payloads)
+{
+	return -ENOMEM;
+}
+
+int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
+					   const struct iwl_pnvm_image *pnvm_payloads,
+					   const struct iwl_ucode_capabilities *capa)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
 		&trans_pcie->prph_scratch->ctrl_cfg;
+	struct iwl_dram_data *dram = &trans_pcie->pnvm_dram[0];
+	int ret = 0;
+
+	/* only allocate the DRAM if not allocated yet */
+	if (trans->pnvm_loaded)
+		return 0;
+
+	if (WARN_ON(prph_sc_ctrl->pnvm_cfg.pnvm_size))
+		return -EBUSY;
 
 	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
-		return;
-	/* FIXME: currently we concatenate payloads and save them only in
-	 * pnvm_dram[0] - therefor only pnvm_dram[0] is delivered to the
-	 * prph_sc. Need to add a UCODE sensitivity and another case in which
-	 * we deliver to the prph_sc an array with all the DRAM addresses.
-	 */
+		return 0;
+
+	if (fw_has_capa(capa, IWL_UCODE_TLV_CAPA_FRAGMENTED_PNVM_IMG))
+		return iwl_pcie_load_payloads_segments(trans, pnvm_payloads);
+
+	ret = iwl_pcie_load_payloads_continuously(trans, pnvm_payloads, dram);
+	if (!ret) {
+		trans_pcie->n_pnvm_regions = 1;
+		trans->pnvm_loaded = true;
+	}
+
+	return ret;
+}
+
+/* FIXME: An implementation will be added with the next several commits. */
+static void iwl_pcie_set_pnvm_segments(struct iwl_trans *trans) {}
+
+static void iwl_pcie_set_continuous_pnvm(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
+		&trans_pcie->prph_scratch->ctrl_cfg;
+
 	prph_sc_ctrl->pnvm_cfg.pnvm_base_addr =
 		cpu_to_le64(trans_pcie->pnvm_dram[0].physical);
 	prph_sc_ctrl->pnvm_cfg.pnvm_size =
 		cpu_to_le32(trans_pcie->pnvm_dram[0].size);
+}
+
+void iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
+					   const struct iwl_ucode_capabilities *capa)
+{
+	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+		return;
 
+	if (fw_has_capa(capa, IWL_UCODE_TLV_CAPA_FRAGMENTED_PNVM_IMG))
+		iwl_pcie_set_pnvm_segments(trans);
+	else
+		iwl_pcie_set_continuous_pnvm(trans);
 }
 
 int iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans,
-- 
2.38.1

