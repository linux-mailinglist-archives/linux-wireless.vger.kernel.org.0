Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C63BA43CF
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 11:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfHaJxA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 05:53:00 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39754 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726968AbfHaJxA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 05:53:00 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i400U-0002OQ-68; Sat, 31 Aug 2019 12:49:18 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 31 Aug 2019 12:48:57 +0300
Message-Id: <20190831094859.6391-18-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190831094859.6391-1-luca@coelho.fi>
References: <20190831094859.6391-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 17/19] iwlwifi: dbg_ini: move tx fifo data into fw runtime
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Needed for future changes.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 53 +++++--------------
 .../net/wireless/intel/iwlwifi/fw/runtime.h   | 17 +++++-
 2 files changed, 28 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 73af6e6a54c3..77eeca3eb3bf 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1166,35 +1166,23 @@ iwl_dump_ini_mon_dram_iter(struct iwl_fw_runtime *fwrt,
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
-struct iwl_ini_txf_iter_data {
-	int fifo;
-	int lmac;
-	u32 fifo_size;
-	bool internal_txf;
-	bool init;
-};
-
 static bool iwl_ini_txf_iter(struct iwl_fw_runtime *fwrt,
-			     struct iwl_fw_ini_region_cfg *reg)
+			     struct iwl_fw_ini_region_cfg *reg, int idx)
 {
-	struct iwl_ini_txf_iter_data *iter = fwrt->dump.fifo_iter;
+	struct iwl_txf_iter_data *iter = &fwrt->dump.txf_iter_data;
 	struct iwl_fwrt_shared_mem_cfg *cfg = &fwrt->smem_cfg;
 	int txf_num = cfg->num_txfifo_entries;
 	int int_txf_num = ARRAY_SIZE(cfg->internal_txfifo_size);
 	u32 lmac_bitmap = le32_to_cpu(reg->fifos.fid1);
 
-	if (!iter)
-		return false;
-
-	if (iter->init) {
+	if (!idx) {
 		if (le32_to_cpu(reg->offset) &&
 		    WARN_ONCE(cfg->num_lmacs == 1,
 			      "Invalid lmac offset: 0x%x\n",
 			      le32_to_cpu(reg->offset)))
 			return false;
 
-		iter->init = false;
-		iter->internal_txf = false;
+		iter->internal_txf = 0;
 		iter->fifo_size = 0;
 		iter->fifo = -1;
 		if (le32_to_cpu(reg->offset))
@@ -1211,7 +1199,7 @@ static bool iwl_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 				return true;
 		}
 
-	iter->internal_txf = true;
+	iter->internal_txf = 1;
 
 	if (!fw_has_capa(&fwrt->fw->ucode_capa,
 			 IWL_UCODE_TLV_CAPA_EXTEND_SHARED_MEM_CFG))
@@ -1232,7 +1220,7 @@ static int iwl_dump_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 				 void *range_ptr, int idx)
 {
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
-	struct iwl_ini_txf_iter_data *iter;
+	struct iwl_txf_iter_data *iter = &fwrt->dump.txf_iter_data;
 	struct iwl_fw_ini_error_dump_register *reg_dump = (void *)range->data;
 	u32 offs = le32_to_cpu(reg->offset), addr;
 	u32 registers_size =
@@ -1241,14 +1229,12 @@ static int iwl_dump_ini_txf_iter(struct iwl_fw_runtime *fwrt,
 	unsigned long flags;
 	int i;
 
-	if (!iwl_ini_txf_iter(fwrt, reg))
+	if (!iwl_ini_txf_iter(fwrt, reg, idx))
 		return -EIO;
 
 	if (!iwl_trans_grab_nic_access(fwrt->trans, &flags))
 		return -EBUSY;
 
-	iter = fwrt->dump.fifo_iter;
-
 	range->fifo_hdr.fifo_num = cpu_to_le32(iter->fifo);
 	range->fifo_hdr.num_of_registers = reg->fifos.num_of_registers;
 	range->range_data_size = cpu_to_le32(iter->fifo_size + registers_size);
@@ -1520,16 +1506,11 @@ static u32 iwl_dump_ini_mon_dram_ranges(struct iwl_fw_runtime *fwrt,
 static u32 iwl_dump_ini_txf_ranges(struct iwl_fw_runtime *fwrt,
 				   struct iwl_fw_ini_region_cfg *reg)
 {
-	struct iwl_ini_txf_iter_data iter = { .init = true };
-	void *fifo_iter = fwrt->dump.fifo_iter;
 	u32 num_of_fifos = 0;
 
-	fwrt->dump.fifo_iter = &iter;
-	while (iwl_ini_txf_iter(fwrt, reg))
+	while (iwl_ini_txf_iter(fwrt, reg, num_of_fifos))
 		num_of_fifos++;
 
-	fwrt->dump.fifo_iter = fifo_iter;
-
 	return num_of_fifos;
 }
 
@@ -1602,25 +1583,21 @@ static u32 iwl_dump_ini_mon_smem_get_size(struct iwl_fw_runtime *fwrt,
 static u32 iwl_dump_ini_txf_get_size(struct iwl_fw_runtime *fwrt,
 				     struct iwl_fw_ini_region_cfg *reg)
 {
-	struct iwl_ini_txf_iter_data iter = { .init = true };
-	void *fifo_iter = fwrt->dump.fifo_iter;
+	struct iwl_txf_iter_data *iter = &fwrt->dump.txf_iter_data;
 	u32 size = 0;
 	u32 fifo_hdr = sizeof(struct iwl_fw_ini_error_dump_range) +
 		le32_to_cpu(reg->fifos.num_of_registers) *
 		sizeof(struct iwl_fw_ini_error_dump_register);
 
-	fwrt->dump.fifo_iter = &iter;
-	while (iwl_ini_txf_iter(fwrt, reg)) {
+	while (iwl_ini_txf_iter(fwrt, reg, size)) {
 		size += fifo_hdr;
 		if (!reg->fifos.header_only)
-			size += iter.fifo_size;
+			size += iter->fifo_size;
 	}
 
 	if (size)
 		size += sizeof(struct iwl_fw_ini_error_dump);
 
-	fwrt->dump.fifo_iter = fifo_iter;
-
 	return size;
 }
 
@@ -1891,19 +1868,13 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 			}
 			size += iwl_dump_ini_mem(fwrt, list, reg, &ops);
 			break;
-		case IWL_FW_INI_REGION_TXF: {
-			struct iwl_ini_txf_iter_data iter = { .init = true };
-			void *fifo_iter = fwrt->dump.fifo_iter;
-
-			fwrt->dump.fifo_iter = &iter;
+		case IWL_FW_INI_REGION_TXF:
 			ops.get_num_of_ranges = iwl_dump_ini_txf_ranges;
 			ops.get_size = iwl_dump_ini_txf_get_size;
 			ops.fill_mem_hdr = iwl_dump_ini_mem_fill_header;
 			ops.fill_range = iwl_dump_ini_txf_iter;
 			size += iwl_dump_ini_mem(fwrt, list, reg, &ops);
-			fwrt->dump.fifo_iter = fifo_iter;
 			break;
-		}
 		case IWL_FW_INI_REGION_RXF:
 			ops.get_num_of_ranges = iwl_dump_ini_rxf_ranges;
 			ops.get_size = iwl_dump_ini_rxf_get_size;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 0a4e13e4cc2c..40b92509085d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -90,6 +90,20 @@ struct iwl_fwrt_shared_mem_cfg {
 
 #define IWL_FW_RUNTIME_DUMP_WK_NUM 5
 
+/**
+ * struct iwl_txf_iter_data - Tx fifo iterator data struct
+ * @fifo: fifo number
+ * @lmac: lmac number
+ * @fifo_size: fifo size
+ * @internal_txf: non zero if fifo is  internal Tx fifo
+ */
+struct iwl_txf_iter_data {
+	int fifo;
+	int lmac;
+	u32 fifo_size;
+	u8 internal_txf;
+};
+
 /**
  * struct iwl_fw_runtime - runtime data for firmware
  * @fw: firmware image
@@ -143,7 +157,8 @@ struct iwl_fw_runtime {
 		struct iwl_fw_ini_active_triggers active_trigs[IWL_FW_TRIGGER_ID_NUM];
 		u32 lmac_err_id[MAX_NUM_LMAC];
 		u32 umac_err_id;
-		void *fifo_iter;
+
+		struct iwl_txf_iter_data txf_iter_data;
 		struct timer_list periodic_trig;
 
 		u8 img_name[IWL_FW_INI_MAX_IMG_NAME_LEN];
-- 
2.23.0.rc1

