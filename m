Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B377B7C46
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 11:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242044AbjJDJhK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 05:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242027AbjJDJhF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 05:37:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7C1E4
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 02:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696412220; x=1727948220;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gQVXyYH+x9vQSPhrOO3sJGdLauBaOJKeUSblX3iGoHI=;
  b=f1l7TMpg+x0Z8Da6JPk+Qt5bjDnx2Hfs+gTM0cCcNNRaJvhyHfLLg/4V
   bhIlj2qhMsVQULr1mBXeUqwvPLO3OWEedZ+8MWazpiDOksLSt9p4rJysS
   scWhAWgQh717JFv1iCqwAmNjTJWhp91oGEOaigvX1JnBQQVbysm+K97hF
   5pb8klfT1H0PcB2QDBQtrG9TWNGu0t/JPGCtYUzOKHB9LGAj17p9dVkY2
   Z/yV6NYJ8Ov3fLzEKEh736mw/rb7sXxFYea9bUP1MKVXCb9gLhQcjTLZP
   NWTsQUQ9NxvhP4jjVkvvyn3gKCLJCAxZmQ0Hvfe+jC0YW6ye4v696o2L3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="449611706"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="449611706"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:36:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="1082415151"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="1082415151"
Received: from oferweis-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.222.21])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 02:36:48 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/15] wifi: iwlwifi: add support for new ini region types
Date:   Wed,  4 Oct 2023 12:36:21 +0300
Message-Id: <20231004123422.0a10320f4259.I680ef6e16267d95329ee239f05d0999f5a1719ac@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231004093634.131303-1-gregory.greenman@intel.com>
References: <20231004093634.131303-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

YoYo introduces 2 new region types: prph mac and phy blocks.
The data in this regions consists of a list of
(base address, size) pairs.
This way we can set a block of consecutive registers by the
base address and the size, instead of a list of registers.
Add support for parsing and dumping these new region types

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   | 34 ++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 72 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  2 +
 3 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 39bee9c00e07..fb421500f261 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #ifndef __iwl_fw_dbg_tlv_h__
 #define __iwl_fw_dbg_tlv_h__
@@ -42,6 +42,30 @@ struct iwl_fw_ini_header {
 	/* followed by the data */
 } __packed; /* FW_TLV_DEBUG_HEADER_S_VER_1 */
 
+/**
+ * struct iwl_fw_ini_addr_size - Base address and size that defines
+ * a chunk of memory
+ *
+ * @addr: the base address (fixed size - 4 bytes)
+ * @size: the size to read
+ */
+struct iwl_fw_ini_addr_size {
+	__le32 addr;
+	__le32 size;
+} __packed; /* FW_TLV_DEBUG_ADDR_SIZE_VER_1 */
+
+/**
+ * struct iwl_fw_ini_region_dev_addr_range - Configuration to read
+ * device address range
+ *
+ * @offset: offset to add to the base address of each chunk
+ * The addrs[] array will be treated as an array of &iwl_fw_ini_addr_size -
+ * an array of (addr, size) pairs.
+ */
+struct iwl_fw_ini_region_dev_addr_range {
+	__le32 offset;
+} __packed; /* FW_TLV_DEBUG_DEVICE_ADDR_RANGE_API_S_VER_1 */
+
 /**
  * struct iwl_fw_ini_region_dev_addr - Configuration to read device addresses
  *
@@ -135,6 +159,9 @@ struct iwl_fw_ini_region_internal_buffer {
  *	&IWL_FW_INI_REGION_PAGING, &IWL_FW_INI_REGION_CSR,
  *	&IWL_FW_INI_REGION_DRAM_IMR and &IWL_FW_INI_REGION_PCI_IOSF_CONFIG
  *	&IWL_FW_INI_REGION_DBGI_SRAM, &FW_TLV_DEBUG_REGION_TYPE_DBGI_SRAM,
+ * @dev_addr_range: device address range configuration. Used by
+ *	&IWL_FW_INI_REGION_PERIPHERY_MAC_RANGE and
+ *	&IWL_FW_INI_REGION_PERIPHERY_PHY_RANGE
  * @fifos: fifos configuration. Used by &IWL_FW_INI_REGION_TXF and
  *	&IWL_FW_INI_REGION_RXF
  * @err_table: error table configuration. Used by
@@ -157,6 +184,7 @@ struct iwl_fw_ini_region_tlv {
 	u8 name[IWL_FW_INI_MAX_NAME];
 	union {
 		struct iwl_fw_ini_region_dev_addr dev_addr;
+		struct iwl_fw_ini_region_dev_addr_range dev_addr_range;
 		struct iwl_fw_ini_region_fifos fifos;
 		struct iwl_fw_ini_region_err_table err_table;
 		struct iwl_fw_ini_region_internal_buffer internal_buffer;
@@ -362,6 +390,8 @@ enum iwl_fw_ini_buffer_location {
  * @IWL_FW_INI_REGION_PCI_IOSF_CONFIG: PCI/IOSF config
  * @IWL_FW_INI_REGION_SPECIAL_DEVICE_MEMORY: special device memory
  * @IWL_FW_INI_REGION_DBGI_SRAM: periphery registers of DBGI SRAM
+ * @IWL_FW_INI_REGION_PERIPHERY_MAC_RANGE: a range of periphery registers of MAC
+ * @IWL_FW_INI_REGION_PERIPHERY_PHY_RANGE: a range of periphery registers of PHY
  * @IWL_FW_INI_REGION_NUM: number of region types
  */
 enum iwl_fw_ini_region_type {
@@ -384,6 +414,8 @@ enum iwl_fw_ini_region_type {
 	IWL_FW_INI_REGION_PCI_IOSF_CONFIG,
 	IWL_FW_INI_REGION_SPECIAL_DEVICE_MEMORY,
 	IWL_FW_INI_REGION_DBGI_SRAM,
+	IWL_FW_INI_REGION_PERIPHERY_MAC_RANGE,
+	IWL_FW_INI_REGION_PERIPHERY_PHY_RANGE,
 	IWL_FW_INI_REGION_NUM
 }; /* FW_TLV_DEBUG_REGION_TYPE_API_E */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 6c03ffdcd3f4..a20be3642848 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1055,6 +1055,20 @@ iwl_dump_ini_prph_mac_iter(struct iwl_fw_runtime *fwrt,
 						 reg->dev_addr.size);
 }
 
+static int
+iwl_dump_ini_prph_mac_block_iter(struct iwl_fw_runtime *fwrt,
+				 struct iwl_dump_ini_region_data *reg_data,
+				 void *range_ptr, u32 range_len, int idx)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	struct iwl_fw_ini_addr_size *pairs = (void *)reg->addrs;
+	u32 addr = le32_to_cpu(reg->dev_addr_range.offset) +
+		   le32_to_cpu(pairs[idx].addr);
+
+	return iwl_dump_ini_prph_mac_iter_common(fwrt, range_ptr, addr,
+						 pairs[idx].size);
+}
+
 static int iwl_dump_ini_prph_phy_iter_common(struct iwl_fw_runtime *fwrt,
 					     void *range_ptr, u32 addr,
 					     __le32 size, __le32 offset)
@@ -1115,6 +1129,20 @@ iwl_dump_ini_prph_phy_iter(struct iwl_fw_runtime *fwrt,
 						 reg->dev_addr.offset);
 }
 
+static int
+iwl_dump_ini_prph_phy_block_iter(struct iwl_fw_runtime *fwrt,
+				 struct iwl_dump_ini_region_data *reg_data,
+				 void *range_ptr, u32 range_len, int idx)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	struct iwl_fw_ini_addr_size *pairs = (void *)reg->addrs;
+	u32 addr = le32_to_cpu(pairs[idx].addr);
+
+	return iwl_dump_ini_prph_phy_iter_common(fwrt, range_ptr, addr,
+						 pairs[idx].size,
+						 reg->dev_addr_range.offset);
+}
+
 static int iwl_dump_ini_csr_iter(struct iwl_fw_runtime *fwrt,
 				 struct iwl_dump_ini_region_data *reg_data,
 				 void *range_ptr, u32 range_len, int idx)
@@ -1799,6 +1827,16 @@ static u32 iwl_dump_ini_mem_ranges(struct iwl_fw_runtime *fwrt,
 	return iwl_tlv_array_len(reg_data->reg_tlv, reg, addrs);
 }
 
+static u32
+iwl_dump_ini_mem_block_ranges(struct iwl_fw_runtime *fwrt,
+			      struct iwl_dump_ini_region_data *reg_data)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	size_t size = sizeof(struct iwl_fw_ini_addr_size);
+
+	return iwl_tlv_array_len_with_size(reg_data->reg_tlv, reg, size);
+}
+
 static u32 iwl_dump_ini_paging_ranges(struct iwl_fw_runtime *fwrt,
 				      struct iwl_dump_ini_region_data *reg_data)
 {
@@ -1884,6 +1922,25 @@ static u32 iwl_dump_ini_mem_get_size(struct iwl_fw_runtime *fwrt,
 		(size + sizeof(struct iwl_fw_ini_error_dump_range));
 }
 
+static u32
+iwl_dump_ini_mem_block_get_size(struct iwl_fw_runtime *fwrt,
+				struct iwl_dump_ini_region_data *reg_data)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	struct iwl_fw_ini_addr_size *pairs = (void *)reg->addrs;
+	u32 ranges = iwl_dump_ini_mem_block_ranges(fwrt, reg_data);
+	u32 size = sizeof(struct iwl_fw_ini_error_dump);
+	int range;
+
+	if (!ranges)
+		return 0;
+
+	for (range = 0; range < ranges; range++)
+		size += le32_to_cpu(pairs[range].size);
+
+	return size + ranges * sizeof(struct iwl_fw_ini_error_dump_range);
+}
+
 static u32
 iwl_dump_ini_paging_get_size(struct iwl_fw_runtime *fwrt,
 			     struct iwl_dump_ini_region_data *reg_data)
@@ -2431,6 +2488,18 @@ static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
 		.fill_range = iwl_dump_ini_prph_phy_iter,
 	},
+	[IWL_FW_INI_REGION_PERIPHERY_MAC_RANGE] = {
+		.get_num_of_ranges = iwl_dump_ini_mem_block_ranges,
+		.get_size = iwl_dump_ini_mem_block_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
+		.fill_range = iwl_dump_ini_prph_mac_block_iter,
+	},
+	[IWL_FW_INI_REGION_PERIPHERY_PHY_RANGE] = {
+		.get_num_of_ranges = iwl_dump_ini_mem_block_ranges,
+		.get_size = iwl_dump_ini_mem_block_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
+		.fill_range = iwl_dump_ini_prph_phy_block_iter,
+	},
 	[IWL_FW_INI_REGION_PERIPHERY_AUX] = {},
 	[IWL_FW_INI_REGION_PAGING] = {
 		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
@@ -2510,7 +2579,8 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 		if (reg_type >= ARRAY_SIZE(iwl_dump_ini_region_ops))
 			continue;
 
-		if (reg_type == IWL_FW_INI_REGION_PERIPHERY_PHY &&
+		if ((reg_type == IWL_FW_INI_REGION_PERIPHERY_PHY ||
+		     reg_type == IWL_FW_INI_REGION_PERIPHERY_PHY_RANGE) &&
 		    tp_id != IWL_FW_INI_TIME_POINT_FW_ASSERT) {
 			IWL_WARN(fwrt,
 				 "WRT: trying to collect phy prph at time point: %d, skipping\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 7e0894ea1005..03f6e520145f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -975,4 +975,6 @@ static inline size_t _iwl_tlv_array_len(const struct iwl_ucode_tlv *tlv,
 	_iwl_tlv_array_len((_tlv_ptr), sizeof(*(_struct_ptr)),		\
 			   sizeof(_struct_ptr->_memb[0]))
 
+#define iwl_tlv_array_len_with_size(_tlv_ptr, _struct_ptr, _size)	\
+	_iwl_tlv_array_len((_tlv_ptr), sizeof(*(_struct_ptr)), _size)
 #endif  /* __iwl_fw_file_h__ */
-- 
2.38.1

