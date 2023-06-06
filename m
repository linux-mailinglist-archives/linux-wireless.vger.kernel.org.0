Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C819B723A78
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jun 2023 09:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbjFFHvi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 03:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237071AbjFFHuA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 03:50:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFE31BF8
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 00:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686037529; x=1717573529;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E0vVIprFZFV4HTvZZYkUvhFxZrg/Ng0i3k5AfN760ec=;
  b=dUnhxPYpr+WzNj0gkR3sgAih7pQY+QPJQP3Jbe7eO1FgrQ3c1Y82/ynT
   slYTtGbYxOtjiE2RpX5M7g6u9pppV3EquaXGDYhDA7kQI8pdbp8pRf4TX
   F43pPw6OK5g4fgcLrBVGg8zCgW2Gg9rY2YZ6VoDNJZmaRXm9NAcA1BUsJ
   48S8LnVLKDP51laaEkPvCEf6rP+6IbS8uzbOwqoynhyQkl/rn9K2mKPCc
   Qsj34Bn7DE5SCsauNdaMGrHGluLqS7I6dRVzk2dXUAavGPtwshIWIEN9b
   3m8DTOk/kMKf7o/BGvOqW5ixsCWVmD2WtoTxWR8WCHqQ+hamSyuexKYCJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="422419131"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="422419131"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821516458"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; 
   d="scan'208";a="821516458"
Received: from oniamir-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.217.62])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 00:43:49 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/13] wifi: iwlwifi: pnvm: handle memory descriptor tlv
Date:   Tue,  6 Jun 2023 10:43:10 +0300
Message-Id: <20230606103519.8c5f5ee8e30b.Id1893c9dec140b5ba4abe8a121c2e1a1d121d2d7@changeid>
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

From: Gregory Greenman <gregory.greenman@intel.com>

When PNVM is obtained from UEFI, there's an additional memory
descriptor TLV that has to be handled. It is the same TLV that
holds data in the reduced power tables. Also, in this TLV, the
actual data is located after address and size, so add the
corresponding offset.

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c |  5 ++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c | 62 ++++++++++++++------
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h |  9 +++
 3 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
index 82eb32e67a2c..650e4bde9c17 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.c
@@ -127,6 +127,11 @@ static int iwl_pnvm_handle_section(struct iwl_trans *trans, const u8 *data,
 
 			break;
 		}
+		case IWL_UCODE_TLV_MEM_DESC:
+			if (iwl_uefi_handle_tlv_mem_desc(trans, data, tlv_len,
+							 pnvm_data))
+				return -EINVAL;
+			break;
 		case IWL_UCODE_TLV_PNVM_SKU:
 			IWL_DEBUG_FW(trans,
 				     "New PNVM section started, stop parsing.\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index 488b9fb79743..9877988db0d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -17,6 +17,12 @@
 				  0xb2, 0xec, 0xf5, 0xa3,	\
 				  0x59, 0x4f, 0x4a, 0xea)
 
+struct iwl_uefi_pnvm_mem_desc {
+	__le32 addr;
+	__le32 size;
+	const u8 data[];
+} __packed;
+
 static void *iwl_uefi_get_variable(efi_char16_t *name, efi_guid_t *guid,
 				   unsigned long *data_size)
 {
@@ -70,6 +76,42 @@ void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 	return data;
 }
 
+int iwl_uefi_handle_tlv_mem_desc(struct iwl_trans *trans, const u8 *data,
+				 u32 tlv_len, struct iwl_pnvm_image *pnvm_data)
+{
+	const struct iwl_uefi_pnvm_mem_desc *desc = (const void *)data;
+	u32 data_len;
+
+	if (tlv_len < sizeof(*desc)) {
+		IWL_DEBUG_FW(trans, "TLV len (%d) is too small\n", tlv_len);
+		return -EINVAL;
+	}
+
+	data_len = tlv_len - sizeof(*desc);
+
+	IWL_DEBUG_FW(trans,
+		     "Handle IWL_UCODE_TLV_MEM_DESC, len %d data_len %d\n",
+		     tlv_len, data_len);
+
+	if (le32_to_cpu(desc->size) != data_len) {
+		IWL_DEBUG_FW(trans, "invalid mem desc size %d\n", desc->size);
+		return -EINVAL;
+	}
+
+	if (pnvm_data->n_chunks == IPC_DRAM_MAP_ENTRY_NUM_MAX) {
+		IWL_DEBUG_FW(trans, "too many payloads to allocate in DRAM.\n");
+		return -EINVAL;
+	}
+
+	IWL_DEBUG_FW(trans, "Adding data (size %d)\n", data_len);
+
+	pnvm_data->chunks[pnvm_data->n_chunks].data = desc->data;
+	pnvm_data->chunks[pnvm_data->n_chunks].len = data_len;
+	pnvm_data->n_chunks++;
+
+	return 0;
+}
+
 static int iwl_uefi_reduce_power_section(struct iwl_trans *trans,
 					 const u8 *data, size_t len,
 					 struct iwl_pnvm_image *pnvm_data)
@@ -97,25 +139,11 @@ static int iwl_uefi_reduce_power_section(struct iwl_trans *trans,
 		data += sizeof(*tlv);
 
 		switch (tlv_type) {
-		case IWL_UCODE_TLV_MEM_DESC: {
-			IWL_DEBUG_FW(trans,
-				     "Got IWL_UCODE_TLV_MEM_DESC len %d\n",
-				     tlv_len);
-
-			if (pnvm_data->n_chunks == IPC_DRAM_MAP_ENTRY_NUM_MAX) {
-				IWL_DEBUG_FW(trans,
-				"too many payloads to allocate in DRAM.\n");
+		case IWL_UCODE_TLV_MEM_DESC:
+			if (iwl_uefi_handle_tlv_mem_desc(trans, data, tlv_len,
+							 pnvm_data))
 				return -EINVAL;
-			}
-
-			IWL_DEBUG_FW(trans, "Adding data (size %d)\n", tlv_len);
-
-			pnvm_data->chunks[pnvm_data->n_chunks].data = data;
-			pnvm_data->chunks[pnvm_data->n_chunks].len = tlv_len;
-			pnvm_data->n_chunks++;
-
 			break;
-		}
 		case IWL_UCODE_TLV_PNVM_SKU:
 			IWL_DEBUG_FW(trans,
 				     "New REDUCE_POWER section started, stop parsing.\n");
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index dc7ccf49d92d..1369cc4855c3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -46,6 +46,8 @@ int iwl_uefi_reduce_power_parse(struct iwl_trans *trans,
 				const u8 *data, size_t len,
 				struct iwl_pnvm_image *pnvm_data);
 void iwl_uefi_get_step_table(struct iwl_trans *trans);
+int iwl_uefi_handle_tlv_mem_desc(struct iwl_trans *trans, const u8 *data,
+				 u32 tlv_len, struct iwl_pnvm_image *pnvm_data);
 #else /* CONFIG_EFI */
 static inline void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len)
 {
@@ -69,6 +71,13 @@ iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
 static inline void iwl_uefi_get_step_table(struct iwl_trans *trans)
 {
 }
+
+static inline int
+iwl_uefi_handle_tlv_mem_desc(struct iwl_trans *trans, const u8 *data,
+			     u32 tlv_len, struct iwl_pnvm_image *pnvm_data)
+{
+	return 0;
+}
 #endif /* CONFIG_EFI */
 
 #if defined(CONFIG_EFI) && defined(CONFIG_ACPI)
-- 
2.38.1

