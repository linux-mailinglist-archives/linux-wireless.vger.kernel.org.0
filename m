Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BF2723A70
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 09:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbjFFHvc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 03:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236809AbjFFHtE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 03:49:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E51410E0
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 00:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686037490; x=1717573490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0UzfJX4z3ebHPYqJJ9TU+XXGQ4YJBaIkbdDE5xypBVI=;
  b=Alg86TR3NWjrkz5KHp8szD+R/DjY8bilozxfi+z6lmNKS9E0nD7pYJ3t
   5asakMw1amxPq+jGRpv1ewtYuksjv579/MsnIqmrvxx80eWCH6Xxwk7pJ
   rZMiJu678vXqbZsEaTHG9tNR1QyiE6B9xD7145izcOqB2JB5WWg8p855P
   9qpGv7Cwq73syxXBeSRfC8a2RP+8MZSESOo62SCKPHLXhMTU1xZ5Wka4l
   N5Ht74J/nLN1/W7hnPTtWO+mFnEfI2epon99Bhzh92fHopiLuKb896sTH
   kBZNrmTJV50GIxrgg127mEf1uiGOwRGvs32YqPSfVjMSoOAK6gPFKBYNS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422419093"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="422419093"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821516347"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="821516347"
Received: from oniamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.217.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:38 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Alon Giladi <alon.giladi@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/13] wifi: iwlwifi: Use iwl_pnvm_image in reduce power tables flow
Date:   Tue,  6 Jun 2023 10:43:05 +0300
Message-Id: <20230606103519.564f1eead99b.Iaba653b21dc09aafc72b9bbb3928abddce0db50a@changeid>
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

Generalize the parsing, loading, and setting of the power-reduce
tables, in order to support allocation of several DRAM payloads
in the future.

Signed-off-by: Alon Giladi <alon.giladi@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |  7 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 90 ++++++++-----------
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  8 +-
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  5 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 11 ++-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 25 ++----
 6 files changed, 63 insertions(+), 83 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index bb6300469f4a..42d994240b31 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -320,8 +320,9 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 reduce_tables:
 	/* now try to get the reduce power table, if not loaded yet */
 	if (!trans->reduce_power_loaded) {
-		data = iwl_uefi_get_reduced_power(trans, &length);
-		if (IS_ERR_OR_NULL(data)) {
+		memset(&pnvm_data, 0, sizeof(pnvm_data));
+		ret = iwl_uefi_get_reduced_power(trans, &pnvm_data);
+		if (ret) {
 			/*
 			 * Pretend we've loaded it - at least we've tried and
 			 * couldn't load it at all, so there's no point in
@@ -329,7 +330,7 @@ int iwl_pnvm_load(struct iwl_trans *trans,
 			 */
 			trans->reduce_power_loaded = true;
 		} else {
-			ret = iwl_trans_load_reduce_power(trans, data, length);
+			ret = iwl_trans_load_reduce_power(trans, &pnvm_data);
 			if (ret) {
 				IWL_DEBUG_FW(trans,
 					     "Failed to load reduce power table %d\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 01afea33c38c..64b45a5b767e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -55,14 +55,14 @@ void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 	return data;
 }
 
-static void *iwl_uefi_reduce_power_section(struct iwl_trans *trans,
-					   const u8 *data, size_t len)
+static int iwl_uefi_reduce_power_section(struct iwl_trans *trans,
+					 const u8 *data, size_t len,
+					 struct iwl_pnvm_image *pnvm_data)
 {
 	const struct iwl_ucode_tlv *tlv;
-	u8 *reduce_power_data = NULL, *tmp;
-	u32 size = 0;
 
 	IWL_DEBUG_FW(trans, "Handling REDUCE_POWER section\n");
+	memset(pnvm_data, 0, sizeof(*pnvm_data));
 
 	while (len >= sizeof(*tlv)) {
 		u32 tlv_len, tlv_type;
@@ -76,9 +76,7 @@ static void *iwl_uefi_reduce_power_section(struct iwl_trans *trans,
 		if (len < tlv_len) {
 			IWL_ERR(trans, "invalid TLV len: %zd/%u\n",
 				len, tlv_len);
-			kfree(reduce_power_data);
-			reduce_power_data = ERR_PTR(-EINVAL);
-			goto out;
+			return -EINVAL;
 		}
 
 		data += sizeof(*tlv);
@@ -89,23 +87,17 @@ static void *iwl_uefi_reduce_power_section(struct iwl_trans *trans,
 				     "Got IWL_UCODE_TLV_MEM_DESC len %d\n",
 				     tlv_len);
 
-			IWL_DEBUG_FW(trans, "Adding data (size %d)\n", tlv_len);
-
-			tmp = krealloc(reduce_power_data, size + tlv_len, GFP_KERNEL);
-			if (!tmp) {
+			if (pnvm_data->n_chunks == IPC_DRAM_MAP_ENTRY_NUM_MAX) {
 				IWL_DEBUG_FW(trans,
-					     "Couldn't allocate (more) reduce_power_data\n");
-
-				kfree(reduce_power_data);
-				reduce_power_data = ERR_PTR(-ENOMEM);
-				goto out;
+				"too many payloads to allocate in DRAM.\n");
+				return -EINVAL;
 			}
 
-			reduce_power_data = tmp;
-
-			memcpy(reduce_power_data + size, data, tlv_len);
+			IWL_DEBUG_FW(trans, "Adding data (size %d)\n", tlv_len);
 
-			size += tlv_len;
+			pnvm_data->chunks[pnvm_data->n_chunks].data = data;
+			pnvm_data->chunks[pnvm_data->n_chunks].len = tlv_len;
+			pnvm_data->n_chunks++;
 
 			break;
 		}
@@ -124,27 +116,18 @@ static void *iwl_uefi_reduce_power_section(struct iwl_trans *trans,
 	}
 
 done:
-	if (!size) {
+	if (!pnvm_data->n_chunks) {
 		IWL_DEBUG_FW(trans, "Empty REDUCE_POWER, skipping.\n");
-		/* Better safe than sorry, but 'reduce_power_data' should
-		 * always be NULL if !size.
-		 */
-		kfree(reduce_power_data);
-		reduce_power_data = ERR_PTR(-ENOENT);
-		goto out;
+		return -ENOENT;
 	}
-
-	IWL_INFO(trans, "loaded REDUCE_POWER\n");
-
-out:
-	return reduce_power_data;
+	return 0;
 }
 
-static void *iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
-					 const u8 *data, size_t len)
+static int iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
+				       const u8 *data, size_t len,
+				       struct iwl_pnvm_image *pnvm_data)
 {
 	const struct iwl_ucode_tlv *tlv;
-	void *sec_data;
 
 	IWL_DEBUG_FW(trans, "Parsing REDUCE_POWER data\n");
 
@@ -160,7 +143,7 @@ static void *iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
 		if (len < tlv_len) {
 			IWL_ERR(trans, "invalid TLV len: %zd/%u\n",
 				len, tlv_len);
-			return ERR_PTR(-EINVAL);
+			return -EINVAL;
 		}
 
 		if (tlv_type == IWL_UCODE_TLV_PNVM_SKU) {
@@ -181,11 +164,11 @@ static void *iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
 			if (trans->sku_id[0] == le32_to_cpu(sku_id->data[0]) &&
 			    trans->sku_id[1] == le32_to_cpu(sku_id->data[1]) &&
 			    trans->sku_id[2] == le32_to_cpu(sku_id->data[2])) {
-				sec_data = iwl_uefi_reduce_power_section(trans,
-									 data,
-									 len);
-				if (!IS_ERR(sec_data))
-					return sec_data;
+				int ret = iwl_uefi_reduce_power_section(trans,
+								    data, len,
+								    pnvm_data);
+				if (!ret)
+					return 0;
 			} else {
 				IWL_DEBUG_FW(trans, "SKU ID didn't match!\n");
 			}
@@ -195,20 +178,20 @@ static void *iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
 		}
 	}
 
-	return ERR_PTR(-ENOENT);
+	return -ENOENT;
 }
 
-void *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
+int iwl_uefi_get_reduced_power(struct iwl_trans *trans,
+			       struct iwl_pnvm_image *pnvm_data)
 {
 	struct pnvm_sku_package *package;
-	void *data = NULL;
 	unsigned long package_size;
 	efi_status_t status;
-
-	*len = 0;
+	int ret;
+	size_t len = 0;
 
 	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 
 	/*
 	 * TODO: we hardcode a maximum length here, because reading
@@ -219,7 +202,7 @@ void *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
 
 	package = kmalloc(package_size, GFP_KERNEL);
 	if (!package)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	status = efi.get_variable(IWL_UEFI_REDUCED_POWER_NAME, &IWL_EFI_VAR_GUID,
 				  NULL, &package_size, package);
@@ -228,22 +211,23 @@ void *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
 			     "Reduced Power UEFI variable not found 0x%lx (len %lu)\n",
 			     status, package_size);
 		kfree(package);
-		return ERR_PTR(-ENOENT);
+		return -ENOENT;
 	}
 
 	IWL_DEBUG_FW(trans, "Read reduced power from UEFI with size %lu\n",
 		     package_size);
-	*len = package_size;
+	len = package_size;
 
 	IWL_DEBUG_FW(trans, "rev %d, total_size %d, n_skus %d\n",
 		     package->rev, package->total_size, package->n_skus);
 
-	data = iwl_uefi_reduce_power_parse(trans, package->data,
-					   *len - sizeof(*package));
+	ret = iwl_uefi_reduce_power_parse(trans, package->data,
+					  len - sizeof(*package),
+					  pnvm_data);
 
 	kfree(package);
 
-	return data;
+	return ret;
 }
 
 static int iwl_uefi_step_parse(struct uefi_cnv_common_step_data *common_step_data,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index 17089bc74cf9..03176f73151a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -50,7 +50,8 @@ struct uefi_cnv_common_step_data {
  */
 #ifdef CONFIG_EFI
 void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len);
-void *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len);
+int iwl_uefi_get_reduced_power(struct iwl_trans *trans,
+			       struct iwl_pnvm_image *pnvm_data);
 void iwl_uefi_get_step_table(struct iwl_trans *trans);
 #else /* CONFIG_EFI */
 static inline
@@ -60,9 +61,10 @@ void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 }
 
 static inline
-void *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
+int iwl_uefi_get_reduced_power(struct iwl_trans *trans,
+			       struct iwl_pnvm_image *pnvm_data)
 {
-	return ERR_PTR(-EOPNOTSUPP);
+	return -EOPNOTSUPP;
 }
 
 static inline
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
index e019aec027d6..7e7d135e85b1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-context-info-gen3.h
@@ -292,8 +292,9 @@ int iwl_trans_pcie_ctx_info_gen3_load_pnvm(struct iwl_trans *trans,
 					   const struct iwl_ucode_capabilities *capa);
 void iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
 					   const struct iwl_ucode_capabilities *capa);
-int iwl_trans_pcie_ctx_info_gen3_load_reduce_power(struct iwl_trans *trans,
-						   const void *data, u32 len);
+int iwl_trans_pcie_ctx_info_gen3_load_reduce_power
+				(struct iwl_trans *trans,
+				 const struct iwl_pnvm_image *payloads);
 void iwl_trans_pcie_ctx_info_gen3_set_reduce_power(struct iwl_trans *trans);
 int iwl_trans_pcie_ctx_info_gen3_set_step(struct iwl_trans *trans,
 					  u32 mbx_addr_0_step, u32 mbx_addr_1_step);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 888869d9c94a..8e9585d3a0ee 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -641,8 +641,7 @@ struct iwl_trans_ops {
 	void (*set_pnvm)(struct iwl_trans *trans,
 			 const struct iwl_ucode_capabilities *capa);
 	int (*load_reduce_power)(struct iwl_trans *trans,
-				 const void *data,
-				 u32 len);
+				 const struct iwl_pnvm_image *payloads);
 	void (*set_reduce_power)(struct iwl_trans *trans);
 
 	void (*interrupts)(struct iwl_trans *trans, bool enable);
@@ -1559,11 +1558,11 @@ static inline void iwl_trans_set_pnvm(struct iwl_trans *trans,
 		trans->ops->set_pnvm(trans, capa);
 }
 
-static inline int iwl_trans_load_reduce_power(struct iwl_trans *trans,
-					      const void *data,
-					      u32 len)
+static inline int iwl_trans_load_reduce_power
+				(struct iwl_trans *trans,
+				 const struct iwl_pnvm_image *payloads)
 {
-	return trans->ops->load_reduce_power(trans, data, len);
+	return trans->ops->load_reduce_power(trans, payloads);
 }
 
 static inline void iwl_trans_set_reduce_power(struct iwl_trans *trans)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 2619c868b51f..26d5ba777d24 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -443,31 +443,24 @@ void iwl_trans_pcie_ctx_info_gen3_set_pnvm(struct iwl_trans *trans,
 }
 
 int iwl_trans_pcie_ctx_info_gen3_load_reduce_power(struct iwl_trans *trans,
-						   const void *data,
-						   u32 len)
+						   const struct iwl_pnvm_image *payloads)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	struct iwl_prph_scratch_ctrl_cfg *prph_sc_ctrl =
 		&trans_pcie->prph_scratch->ctrl_cfg;
-	int ret;
+	struct iwl_dram_data *dram = &trans_pcie->reduce_power_dram;
 
 	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		return 0;
 
-	/* only allocate the DRAM if not allocated yet */
-	if (!trans->reduce_power_loaded) {
-		if (WARN_ON(prph_sc_ctrl->reduce_power_cfg.size))
-			return -EBUSY;
+	if (WARN_ON(prph_sc_ctrl->reduce_power_cfg.size))
+		return -EBUSY;
 
-		ret = iwl_pcie_ctxt_info_alloc_dma(trans, data, len,
-					   &trans_pcie->reduce_power_dram);
-		if (ret < 0) {
-			IWL_DEBUG_FW(trans,
-				     "Failed to allocate reduce power DMA %d.\n",
-				     ret);
-			return ret;
-		}
-	}
+	/* only allocate the DRAM if not allocated yet */
+	if (!trans->reduce_power_loaded)
+		return iwl_pcie_load_payloads_continuously(trans,
+							   payloads,
+							   dram);
 	return 0;
 }
 
-- 
2.38.1

