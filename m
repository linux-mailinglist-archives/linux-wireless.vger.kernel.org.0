Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE2974A2E17
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jan 2022 12:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236902AbiA2LQ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jan 2022 06:16:28 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37870 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236441AbiA2LQ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jan 2022 06:16:27 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDliS-0002ji-Fr;
        Sat, 29 Jan 2022 13:16:26 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 29 Jan 2022 13:16:11 +0200
Message-Id: <iwlwifi.20220129105618.25c90fb14968.Ic8f05581a745d08011ca29b3f42767402643e8c5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129111622.678447-1-luca@coelho.fi>
References: <20220129111622.678447-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 01/12] iwlwifi: dbg: add infra for tracking free buffer size
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Until now function just got a pointer to some buffer and used it as if
it's good to use with no boundaries about size left in the buffer.

This infra helps for internal functions ops to make sure buffer usage
is in bound of allocation.

We also add external checks with warnings to verify every internal
function didn't exceed usage of the free buffer size.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 90 ++++++++++++++-------
 1 file changed, 60 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index cef3f54908fa..5c0d094887fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1027,7 +1027,7 @@ struct iwl_dump_ini_region_data {
 static int
 iwl_dump_ini_prph_mac_iter(struct iwl_fw_runtime *fwrt,
 			   struct iwl_dump_ini_region_data *reg_data,
-			   void *range_ptr, int idx)
+			   void *range_ptr, u32 range_len, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -1052,7 +1052,7 @@ iwl_dump_ini_prph_mac_iter(struct iwl_fw_runtime *fwrt,
 static int
 iwl_dump_ini_prph_phy_iter(struct iwl_fw_runtime *fwrt,
 			   struct iwl_dump_ini_region_data *reg_data,
-			   void *range_ptr, int idx)
+			   void *range_ptr, u32 range_len, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -1102,7 +1102,7 @@ iwl_dump_ini_prph_phy_iter(struct iwl_fw_runtime *fwrt,
 
 static int iwl_dump_ini_csr_iter(struct iwl_fw_runtime *fwrt,
 				 struct iwl_dump_ini_region_data *reg_data,
-				 void *range_ptr, int idx)
+				 void *range_ptr, u32 range_len, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -1121,7 +1121,7 @@ static int iwl_dump_ini_csr_iter(struct iwl_fw_runtime *fwrt,
 
 static int iwl_dump_ini_config_iter(struct iwl_fw_runtime *fwrt,
 				    struct iwl_dump_ini_region_data *reg_data,
-				    void *range_ptr, int idx)
+				    void *range_ptr, u32 range_len, int idx)
 {
 	struct iwl_trans *trans = fwrt->trans;
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
@@ -1153,7 +1153,7 @@ static int iwl_dump_ini_config_iter(struct iwl_fw_runtime *fwrt,
 
 static int iwl_dump_ini_dev_mem_iter(struct iwl_fw_runtime *fwrt,
 				     struct iwl_dump_ini_region_data *reg_data,
-				     void *range_ptr, int idx)
+				     void *range_ptr, u32 range_len, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -1175,7 +1175,7 @@ static int iwl_dump_ini_dev_mem_iter(struct iwl_fw_runtime *fwrt,
 }
 
 static int _iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
-				     void *range_ptr, int idx)
+				     void *range_ptr, u32 range_len, int idx)
 {
 	struct page *page = fwrt->fw_paging_db[idx].fw_paging_block;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -1195,7 +1195,7 @@ static int _iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
 
 static int iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
 				    struct iwl_dump_ini_region_data *reg_data,
-				    void *range_ptr, int idx)
+				    void *range_ptr, u32 range_len, int idx)
 {
 	struct iwl_fw_ini_error_dump_range *range;
 	u32 page_size;
@@ -1204,7 +1204,7 @@ static int iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
 	idx++;
 
 	if (!fwrt->trans->trans_cfg->gen2)
-		return _iwl_dump_ini_paging_iter(fwrt, range_ptr, idx);
+		return _iwl_dump_ini_paging_iter(fwrt, range_ptr, range_len, idx);
 
 	range = range_ptr;
 	page_size = fwrt->trans->init_dram.paging[idx].size;
@@ -1220,7 +1220,7 @@ static int iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
 static int
 iwl_dump_ini_mon_dram_iter(struct iwl_fw_runtime *fwrt,
 			   struct iwl_dump_ini_region_data *reg_data,
-			   void *range_ptr, int idx)
+			   void *range_ptr, u32 range_len, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -1239,7 +1239,7 @@ iwl_dump_ini_mon_dram_iter(struct iwl_fw_runtime *fwrt,
 
 static int iwl_dump_ini_mon_smem_iter(struct iwl_fw_runtime *fwrt,
 				      struct iwl_dump_ini_region_data *reg_data,
-				      void *range_ptr, int idx)
+				      void *range_ptr, u32 range_len, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -1307,7 +1307,7 @@ static bool iwl_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 
 static int iwl_dump_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 				 struct iwl_dump_ini_region_data *reg_data,
-				 void *range_ptr, int idx)
+				 void *range_ptr, u32 range_len, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -1442,7 +1442,7 @@ static void iwl_ini_get_rxf_data(struct iwl_fw_runtime *fwrt,
 
 static int iwl_dump_ini_rxf_iter(struct iwl_fw_runtime *fwrt,
 				 struct iwl_dump_ini_region_data *reg_data,
-				 void *range_ptr, int idx)
+				 void *range_ptr, u32 range_len, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -1509,7 +1509,7 @@ static int iwl_dump_ini_rxf_iter(struct iwl_fw_runtime *fwrt,
 static int
 iwl_dump_ini_err_table_iter(struct iwl_fw_runtime *fwrt,
 			    struct iwl_dump_ini_region_data *reg_data,
-			    void *range_ptr, int idx)
+			    void *range_ptr, u32 range_len, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_region_err_table *err_table = &reg->err_table;
@@ -1528,7 +1528,7 @@ iwl_dump_ini_err_table_iter(struct iwl_fw_runtime *fwrt,
 static int
 iwl_dump_ini_special_mem_iter(struct iwl_fw_runtime *fwrt,
 			      struct iwl_dump_ini_region_data *reg_data,
-			      void *range_ptr, int idx)
+			      void *range_ptr, u32 range_len, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_region_special_device_memory *special_mem =
@@ -1549,7 +1549,7 @@ iwl_dump_ini_special_mem_iter(struct iwl_fw_runtime *fwrt,
 static int
 iwl_dump_ini_dbgi_sram_iter(struct iwl_fw_runtime *fwrt,
 			    struct iwl_dump_ini_region_data *reg_data,
-			    void *range_ptr, int idx)
+			    void *range_ptr, u32 range_len, int idx)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
@@ -1579,7 +1579,7 @@ iwl_dump_ini_dbgi_sram_iter(struct iwl_fw_runtime *fwrt,
 
 static int iwl_dump_ini_fw_pkt_iter(struct iwl_fw_runtime *fwrt,
 				    struct iwl_dump_ini_region_data *reg_data,
-				    void *range_ptr, int idx)
+				    void *range_ptr, u32 range_len, int idx)
 {
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
 	struct iwl_rx_packet *pkt = reg_data->dump_data->fw_pkt;
@@ -1601,7 +1601,7 @@ static int iwl_dump_ini_fw_pkt_iter(struct iwl_fw_runtime *fwrt,
 static void *
 iwl_dump_ini_mem_fill_header(struct iwl_fw_runtime *fwrt,
 			     struct iwl_dump_ini_region_data *reg_data,
-			     void *data)
+			     void *data, u32 data_len)
 {
 	struct iwl_fw_ini_error_dump *dump = data;
 
@@ -1677,7 +1677,7 @@ iwl_dump_ini_mon_fill_header(struct iwl_fw_runtime *fwrt,
 static void *
 iwl_dump_ini_mon_dram_fill_header(struct iwl_fw_runtime *fwrt,
 				  struct iwl_dump_ini_region_data *reg_data,
-				  void *data)
+				  void *data, u32 data_len)
 {
 	struct iwl_fw_ini_monitor_dump *mon_dump = (void *)data;
 
@@ -1688,7 +1688,7 @@ iwl_dump_ini_mon_dram_fill_header(struct iwl_fw_runtime *fwrt,
 static void *
 iwl_dump_ini_mon_smem_fill_header(struct iwl_fw_runtime *fwrt,
 				  struct iwl_dump_ini_region_data *reg_data,
-				  void *data)
+				  void *data, u32 data_len)
 {
 	struct iwl_fw_ini_monitor_dump *mon_dump = (void *)data;
 
@@ -1699,7 +1699,7 @@ iwl_dump_ini_mon_smem_fill_header(struct iwl_fw_runtime *fwrt,
 static void *
 iwl_dump_ini_err_table_fill_header(struct iwl_fw_runtime *fwrt,
 				   struct iwl_dump_ini_region_data *reg_data,
-				   void *data)
+				   void *data, u32 data_len)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_err_table_dump *dump = data;
@@ -1713,7 +1713,7 @@ iwl_dump_ini_err_table_fill_header(struct iwl_fw_runtime *fwrt,
 static void *
 iwl_dump_ini_special_mem_fill_header(struct iwl_fw_runtime *fwrt,
 				     struct iwl_dump_ini_region_data *reg_data,
-				     void *data)
+				     void *data, u32 data_len)
 {
 	struct iwl_fw_ini_region_tlv *reg = (void *)reg_data->reg_tlv->data;
 	struct iwl_fw_ini_special_device_memory *dump = data;
@@ -1964,10 +1964,10 @@ struct iwl_dump_ini_mem_ops {
 			struct iwl_dump_ini_region_data *reg_data);
 	void *(*fill_mem_hdr)(struct iwl_fw_runtime *fwrt,
 			      struct iwl_dump_ini_region_data *reg_data,
-			      void *data);
+			      void *data, u32 data_len);
 	int (*fill_range)(struct iwl_fw_runtime *fwrt,
 			  struct iwl_dump_ini_region_data *reg_data,
-			  void *range, int idx);
+			  void *range, u32 range_len, int idx);
 };
 
 /**
@@ -1993,6 +1993,8 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 	u32 id = le32_to_cpu(reg->id);
 	u32 num_of_ranges, i, size;
 	u8 *range;
+	u32 free_size;
+	u64 header_size;
 
 	/*
 	 * The higher part of the ID from 2 is irrelevant for
@@ -2001,13 +2003,21 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 	if (le32_to_cpu(reg->hdr.version) >= 2)
 		id &= IWL_FW_INI_REGION_V2_MASK;
 
+	IWL_DEBUG_FW(fwrt, "WRT: Collecting region: id=%d, type=%d\n", id,
+		     type);
+
 	if (!ops->get_num_of_ranges || !ops->get_size || !ops->fill_mem_hdr ||
-	    !ops->fill_range)
+	    !ops->fill_range) {
+		IWL_DEBUG_FW(fwrt, "WRT: no ops for collecting data\n");
 		return 0;
+	}
 
 	size = ops->get_size(fwrt, reg_data);
-	if (!size)
+
+	if (size < sizeof(*header)) {
+		IWL_DEBUG_FW(fwrt, "WRT: size didn't include space for haeder\n");
 		return 0;
+	}
 
 	entry = vzalloc(sizeof(*entry) + sizeof(*tlv) + size);
 	if (!entry)
@@ -2022,9 +2032,6 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 	tlv->reserved = reg->reserved;
 	tlv->len = cpu_to_le32(size);
 
-	IWL_DEBUG_FW(fwrt, "WRT: Collecting region: id=%d, type=%d\n", id,
-		     type);
-
 	num_of_ranges = ops->get_num_of_ranges(fwrt, reg_data);
 
 	header = (void *)tlv->data;
@@ -2033,7 +2040,8 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 	header->name_len = cpu_to_le32(IWL_FW_INI_MAX_NAME);
 	memcpy(header->name, reg->name, IWL_FW_INI_MAX_NAME);
 
-	range = ops->fill_mem_hdr(fwrt, reg_data, header);
+	free_size = size;
+	range = ops->fill_mem_hdr(fwrt, reg_data, header, free_size);
 	if (!range) {
 		IWL_ERR(fwrt,
 			"WRT: Failed to fill region header: id=%d, type=%d\n",
@@ -2041,8 +2049,21 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 		goto out_err;
 	}
 
+	header_size = range - (u8 *)header;
+
+	if (WARN(header_size > free_size,
+		 "header size %llu > free_size %d",
+		 header_size, free_size)) {
+		IWL_ERR(fwrt,
+			"WRT: fill_mem_hdr used more than given free_size\n");
+		goto out_err;
+	}
+
+	free_size -= header_size;
+
 	for (i = 0; i < num_of_ranges; i++) {
-		int range_size = ops->fill_range(fwrt, reg_data, range, i);
+		int range_size = ops->fill_range(fwrt, reg_data, range,
+						 free_size, i);
 
 		if (range_size < 0) {
 			IWL_ERR(fwrt,
@@ -2050,6 +2071,15 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 				id, type);
 			goto out_err;
 		}
+
+		if (WARN(range_size > free_size, "range_size %d > free_size %d",
+			 range_size, free_size)) {
+			IWL_ERR(fwrt,
+				"WRT: fill_raged used more than given free_size\n");
+			goto out_err;
+		}
+
+		free_size -= range_size;
 		range = range + range_size;
 	}
 
-- 
2.34.1

