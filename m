Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6B73D50B4
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Oct 2019 17:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbfJLPsl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Oct 2019 11:48:41 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48636 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729274AbfJLPsl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Oct 2019 11:48:41 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iJJdH-0005yf-Et; Sat, 12 Oct 2019 18:48:39 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 12 Oct 2019 18:48:18 +0300
Message-Id: <20191012184707.144ef5f93643.I20693d5e3ff0007029a6e1cf17b7c174c29442c6@changeid>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191012154828.9249-1-luca@coelho.fi>
References: <20191012154828.9249-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 06/16] iwlwifi: dbg_ini: add error tables dumping support
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Allow to collect error table data.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 61 ++++++++++++++++++-
 .../wireless/intel/iwlwifi/fw/error-dump.h    | 11 ++++
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index dbaaac2486c7..ee555b8cf5bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1430,6 +1430,25 @@ static int iwl_dump_ini_rxf_iter(struct iwl_fw_runtime *fwrt,
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
+static int
+iwl_dump_ini_err_table_iter(struct iwl_fw_runtime *fwrt,
+			    struct iwl_dump_ini_region_data *reg_data,
+			    void *range_ptr, int idx)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	struct iwl_fw_ini_region_err_table *err_table = &reg->err_table;
+	struct iwl_fw_ini_error_dump_range *range = range_ptr;
+	u32 addr = le32_to_cpu(err_table->base_addr) +
+		   le32_to_cpu(err_table->offset);
+
+	range->internal_base_addr = cpu_to_le32(addr);
+	range->range_data_size = err_table->size;
+	iwl_trans_read_mem_bytes(fwrt->trans, addr, range->data,
+				 le32_to_cpu(err_table->size));
+
+	return sizeof(*range) + le32_to_cpu(range->range_data_size);
+}
+
 static void *
 iwl_dump_ini_mem_fill_header(struct iwl_fw_runtime *fwrt,
 			     struct iwl_dump_ini_region_data *reg_data,
@@ -1524,6 +1543,20 @@ iwl_dump_ini_mon_smem_fill_header(struct iwl_fw_runtime *fwrt,
 					    &fwrt->trans->cfg->mon_smem_regs);
 }
 
+static void *
+iwl_dump_ini_err_table_fill_header(struct iwl_fw_runtime *fwrt,
+				   struct iwl_dump_ini_region_data *reg_data,
+				   void *data)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	struct iwl_fw_ini_err_table_dump *dump = data;
+
+	dump->header.version = cpu_to_le32(IWL_INI_DUMP_VER);
+	dump->version = reg->err_table.version;
+
+	return dump->ranges;
+}
+
 static u32 iwl_dump_ini_mem_ranges(struct iwl_fw_runtime *fwrt,
 				   struct iwl_dump_ini_region_data *reg_data)
 {
@@ -1706,6 +1739,20 @@ static u32 iwl_dump_ini_rxf_get_size(struct iwl_fw_runtime *fwrt,
 	return size;
 }
 
+static u32
+iwl_dump_ini_err_table_get_size(struct iwl_fw_runtime *fwrt,
+				struct iwl_dump_ini_region_data *reg_data)
+{
+	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
+	u32 size = le32_to_cpu(reg->err_table.size);
+
+	if (size)
+		size += sizeof(struct iwl_fw_ini_err_table_dump) +
+			sizeof(struct iwl_fw_ini_error_dump_range);
+
+	return size;
+}
+
 /**
  * struct iwl_dump_ini_mem_ops - ini memory dump operations
  * @get_num_of_ranges: returns the number of memory ranges in the region.
@@ -1892,8 +1939,18 @@ static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
 		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
 		.fill_range = iwl_dump_ini_rxf_iter,
 	},
-	[IWL_FW_INI_REGION_LMAC_ERROR_TABLE] = {},
-	[IWL_FW_INI_REGION_UMAC_ERROR_TABLE] = {},
+	[IWL_FW_INI_REGION_LMAC_ERROR_TABLE] = {
+		.get_num_of_ranges = iwl_dump_ini_single_range,
+		.get_size = iwl_dump_ini_err_table_get_size,
+		.fill_mem_hdr = iwl_dump_ini_err_table_fill_header,
+		.fill_range = iwl_dump_ini_err_table_iter,
+	},
+	[IWL_FW_INI_REGION_UMAC_ERROR_TABLE] = {
+		.get_num_of_ranges = iwl_dump_ini_single_range,
+		.get_size = iwl_dump_ini_err_table_get_size,
+		.fill_mem_hdr = iwl_dump_ini_err_table_fill_header,
+		.fill_range = iwl_dump_ini_err_table_iter,
+	},
 	[IWL_FW_INI_REGION_RSP_OR_NOTIF] = {},
 	[IWL_FW_INI_REGION_DEVICE_MEMORY] = {
 		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 629af3f9c683..7be1c4b54503 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -434,7 +434,18 @@ struct iwl_fw_ini_dump_info {
 	u8 external_dbg_cfg_name[IWL_FW_INI_MAX_DBG_CFG_NAME_LEN];
 	__le32 regions_num;
 	__le32 region_ids[];
+} __packed;
 
+/**
+ * struct iwl_fw_ini_err_table_dump - ini error table dump
+ * @header: header of the region
+ * @version: error table version
+ * @ranges: the memory ranges of this this region
+ */
+struct iwl_fw_ini_err_table_dump {
+	struct iwl_fw_ini_error_dump_header header;
+	__le32 version;
+	struct iwl_fw_ini_error_dump_range ranges[];
 } __packed;
 
 /**
-- 
2.23.0

