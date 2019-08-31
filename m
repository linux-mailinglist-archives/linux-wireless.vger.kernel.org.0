Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBB0A43CA
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 11:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfHaJwu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 05:52:50 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39724 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726659AbfHaJwu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 05:52:50 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i400W-0002OQ-2w; Sat, 31 Aug 2019 12:49:20 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 31 Aug 2019 12:48:59 +0300
Message-Id: <20190831094859.6391-20-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190831094859.6391-1-luca@coelho.fi>
References: <20190831094859.6391-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 19/19] iwlwifi: dbg_ini: use regions ops array instead of switch case in dump flow
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Make a static regions ops array and use it instead of switch case when
determining what op to use to collect a region.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 150 +++++++++++---------
 1 file changed, 79 insertions(+), 71 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 0c7035033f27..04afaec2d80e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1648,7 +1648,7 @@ struct iwl_dump_ini_mem_ops {
  */
 static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 			    struct iwl_fw_ini_region_cfg *reg,
-			    struct iwl_dump_ini_mem_ops *ops)
+			    const struct iwl_dump_ini_mem_ops *ops)
 {
 	struct iwl_fw_ini_dump_entry *entry;
 	struct iwl_fw_error_dump_data *tlv;
@@ -1656,8 +1656,8 @@ static u32 iwl_dump_ini_mem(struct iwl_fw_runtime *fwrt, struct list_head *list,
 	u32 num_of_ranges, i, type = le32_to_cpu(reg->region_type), size;
 	void *range;
 
-	if (WARN_ON(!ops || !ops->get_num_of_ranges || !ops->get_size ||
-		    !ops->fill_mem_hdr || !ops->fill_range))
+	if (!ops->get_num_of_ranges || !ops->get_size || !ops->fill_mem_hdr ||
+	    !ops->fill_range)
 		return 0;
 
 	size = ops->get_size(fwrt, reg);
@@ -1789,6 +1789,75 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 	return entry->size;
 }
 
+static const struct iwl_dump_ini_mem_ops iwl_dump_ini_region_ops[] = {
+	[IWL_FW_INI_REGION_INVALID] = {},
+	[IWL_FW_INI_REGION_DEVICE_MEMORY] = {
+		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
+		.get_size = iwl_dump_ini_mem_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
+		.fill_range = iwl_dump_ini_dev_mem_iter,
+	},
+	[IWL_FW_INI_REGION_PERIPHERY_MAC] = {
+		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
+		.get_size = iwl_dump_ini_mem_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
+		.fill_range = iwl_dump_ini_prph_iter,
+	},
+	[IWL_FW_INI_REGION_PERIPHERY_PHY] = {},
+	[IWL_FW_INI_REGION_PERIPHERY_AUX] = {},
+	[IWL_FW_INI_REGION_DRAM_BUFFER] = {
+		.get_num_of_ranges = iwl_dump_ini_mon_dram_ranges,
+		.get_size = iwl_dump_ini_mon_dram_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mon_dram_fill_header,
+		.fill_range = iwl_dump_ini_mon_dram_iter,
+	},
+	[IWL_FW_INI_REGION_DRAM_IMR] = {},
+	[IWL_FW_INI_REGION_INTERNAL_BUFFER] = {
+		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
+		.get_size = iwl_dump_ini_mon_smem_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mon_smem_fill_header,
+		.fill_range = iwl_dump_ini_dev_mem_iter,
+	},
+	[IWL_FW_INI_REGION_TXF] = {
+		.get_num_of_ranges = iwl_dump_ini_txf_ranges,
+		.get_size = iwl_dump_ini_txf_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
+		.fill_range = iwl_dump_ini_txf_iter,
+	},
+	[IWL_FW_INI_REGION_RXF] = {
+		.get_num_of_ranges = iwl_dump_ini_rxf_ranges,
+		.get_size = iwl_dump_ini_rxf_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
+		.fill_range = iwl_dump_ini_rxf_iter,
+	},
+	[IWL_FW_INI_REGION_PAGING] = {
+		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
+		.get_num_of_ranges = iwl_dump_ini_paging_ranges,
+		.get_size = iwl_dump_ini_paging_get_size,
+		.fill_range = iwl_dump_ini_paging_iter,
+	},
+	[IWL_FW_INI_REGION_CSR] = {
+		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
+		.get_size = iwl_dump_ini_mem_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
+		.fill_range = iwl_dump_ini_csr_iter,
+	},
+	[IWL_FW_INI_REGION_NOTIFICATION] = {},
+	[IWL_FW_INI_REGION_DHC] = {},
+	[IWL_FW_INI_REGION_LMAC_ERROR_TABLE] = {
+		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
+		.get_size = iwl_dump_ini_mem_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
+		.fill_range = iwl_dump_ini_dev_mem_iter,
+	},
+	[IWL_FW_INI_REGION_UMAC_ERROR_TABLE] = {
+		.get_num_of_ranges = iwl_dump_ini_mem_ranges,
+		.get_size = iwl_dump_ini_mem_get_size,
+		.fill_mem_hdr = iwl_dump_ini_mem_fill_header,
+		.fill_range = iwl_dump_ini_dev_mem_iter,
+	},
+};
+
 static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 				struct iwl_fw_ini_trigger *trigger,
 				struct list_head *list)
@@ -1797,9 +1866,8 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 	u32 size = 0;
 
 	for (i = 0; i < le32_to_cpu(trigger->num_regions); i++) {
-		u32 reg_id = le32_to_cpu(trigger->data[i]);
+		u32 reg_id = le32_to_cpu(trigger->data[i]), reg_type;
 		struct iwl_fw_ini_region_cfg *reg;
-		struct iwl_dump_ini_mem_ops ops;
 
 		if (WARN_ON(reg_id >= ARRAY_SIZE(fwrt->dump.active_regs)))
 			continue;
@@ -1816,72 +1884,12 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 		if (le32_to_cpu(reg->domain) != IWL_FW_INI_DBG_DOMAIN_ALWAYS_ON)
 			continue;
 
-		switch (le32_to_cpu(reg->region_type)) {
-		case IWL_FW_INI_REGION_DEVICE_MEMORY:
-		case IWL_FW_INI_REGION_LMAC_ERROR_TABLE:
-		case IWL_FW_INI_REGION_UMAC_ERROR_TABLE:
-			ops.get_num_of_ranges = iwl_dump_ini_mem_ranges;
-			ops.get_size = iwl_dump_ini_mem_get_size;
-			ops.fill_mem_hdr = iwl_dump_ini_mem_fill_header;
-			ops.fill_range = iwl_dump_ini_dev_mem_iter;
-			size += iwl_dump_ini_mem(fwrt, list, reg, &ops);
-			break;
-		case IWL_FW_INI_REGION_PERIPHERY_MAC:
-			ops.get_num_of_ranges =	iwl_dump_ini_mem_ranges;
-			ops.get_size = iwl_dump_ini_mem_get_size;
-			ops.fill_mem_hdr = iwl_dump_ini_mem_fill_header;
-			ops.fill_range = iwl_dump_ini_prph_iter;
-			size += iwl_dump_ini_mem(fwrt, list, reg, &ops);
-			break;
-		case IWL_FW_INI_REGION_DRAM_BUFFER:
-			ops.get_num_of_ranges = iwl_dump_ini_mon_dram_ranges;
-			ops.get_size = iwl_dump_ini_mon_dram_get_size;
-			ops.fill_mem_hdr = iwl_dump_ini_mon_dram_fill_header;
-			ops.fill_range = iwl_dump_ini_mon_dram_iter;
-			size += iwl_dump_ini_mem(fwrt, list, reg, &ops);
-			break;
-		case IWL_FW_INI_REGION_INTERNAL_BUFFER:
-			ops.get_num_of_ranges = iwl_dump_ini_mem_ranges;
-			ops.get_size = iwl_dump_ini_mon_smem_get_size;
-			ops.fill_mem_hdr = iwl_dump_ini_mon_smem_fill_header;
-			ops.fill_range = iwl_dump_ini_dev_mem_iter;
-			size += iwl_dump_ini_mem(fwrt, list, reg, &ops);
-			break;
-		case IWL_FW_INI_REGION_PAGING:
-			ops.fill_mem_hdr = iwl_dump_ini_mem_fill_header;
-			ops.get_num_of_ranges = iwl_dump_ini_paging_ranges;
-			ops.get_size = iwl_dump_ini_paging_get_size;
-			ops.fill_range = iwl_dump_ini_paging_iter;
-			size += iwl_dump_ini_mem(fwrt, list, reg, &ops);
-			break;
-		case IWL_FW_INI_REGION_TXF:
-			ops.get_num_of_ranges = iwl_dump_ini_txf_ranges;
-			ops.get_size = iwl_dump_ini_txf_get_size;
-			ops.fill_mem_hdr = iwl_dump_ini_mem_fill_header;
-			ops.fill_range = iwl_dump_ini_txf_iter;
-			size += iwl_dump_ini_mem(fwrt, list, reg, &ops);
-			break;
-		case IWL_FW_INI_REGION_RXF:
-			ops.get_num_of_ranges = iwl_dump_ini_rxf_ranges;
-			ops.get_size = iwl_dump_ini_rxf_get_size;
-			ops.fill_mem_hdr = iwl_dump_ini_mem_fill_header;
-			ops.fill_range = iwl_dump_ini_rxf_iter;
-			size += iwl_dump_ini_mem(fwrt, list, reg, &ops);
-			break;
-		case IWL_FW_INI_REGION_CSR:
-			ops.get_num_of_ranges =	iwl_dump_ini_mem_ranges;
-			ops.get_size = iwl_dump_ini_mem_get_size;
-			ops.fill_mem_hdr = iwl_dump_ini_mem_fill_header;
-			ops.fill_range = iwl_dump_ini_csr_iter;
-			size += iwl_dump_ini_mem(fwrt, list, reg, &ops);
-			break;
-		case IWL_FW_INI_REGION_PERIPHERY_PHY:
-		case IWL_FW_INI_REGION_PERIPHERY_AUX:
-		case IWL_FW_INI_REGION_DRAM_IMR:
-			/* This is undefined yet */
-		default:
-			break;
-		}
+		reg_type = le32_to_cpu(reg->region_type);
+		if (reg_type >= ARRAY_SIZE(iwl_dump_ini_region_ops))
+			continue;
+
+		size += iwl_dump_ini_mem(fwrt, list, reg,
+					 &iwl_dump_ini_region_ops[reg_type]);
 	}
 
 	if (size)
-- 
2.23.0.rc1

