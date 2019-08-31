Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6A00A43C9
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 11:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfHaJwr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 05:52:47 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39720 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726354AbfHaJwr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 05:52:47 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i400V-0002OQ-3b; Sat, 31 Aug 2019 12:49:19 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 31 Aug 2019 12:48:58 +0300
Message-Id: <20190831094859.6391-19-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190831094859.6391-1-luca@coelho.fi>
References: <20190831094859.6391-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 18/19] iwlwifi: dbg_ini: make a single ops struct for paging collect
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

Needed for future changes.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 92 +++++++++------------
 1 file changed, 39 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 77eeca3eb3bf..0c7035033f27 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1106,25 +1106,9 @@ static int iwl_dump_ini_dev_mem_iter(struct iwl_fw_runtime *fwrt,
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
-static int
-iwl_dump_ini_paging_gen2_iter(struct iwl_fw_runtime *fwrt,
-			      struct iwl_fw_ini_region_cfg *reg,
-			      void *range_ptr, int idx)
-{
-	struct iwl_fw_ini_error_dump_range *range = range_ptr;
-	u32 page_size = fwrt->trans->init_dram.paging[idx].size;
-
-	range->page_num = cpu_to_le32(idx);
-	range->range_data_size = cpu_to_le32(page_size);
-	memcpy(range->data, fwrt->trans->init_dram.paging[idx].block,
-	       page_size);
-
-	return sizeof(*range) + le32_to_cpu(range->range_data_size);
-}
-
-static int iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
-				    struct iwl_fw_ini_region_cfg *reg,
-				    void *range_ptr, int idx)
+static int _iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
+				     struct iwl_fw_ini_region_cfg *reg,
+				     void *range_ptr, int idx)
 {
 	/* increase idx by 1 since the pages are from 1 to
 	 * fwrt->num_of_paging_blk + 1
@@ -1145,6 +1129,27 @@ static int iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
 	return sizeof(*range) + le32_to_cpu(range->range_data_size);
 }
 
+static int iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
+				    struct iwl_fw_ini_region_cfg *reg,
+				    void *range_ptr, int idx)
+{
+	struct iwl_fw_ini_error_dump_range *range;
+	u32 page_size;
+
+	if (!fwrt->trans->cfg->gen2)
+		return _iwl_dump_ini_paging_iter(fwrt, reg, range_ptr, idx);
+
+	range = range_ptr;
+	page_size = fwrt->trans->init_dram.paging[idx].size;
+
+	range->page_num = cpu_to_le32(idx);
+	range->range_data_size = cpu_to_le32(page_size);
+	memcpy(range->data, fwrt->trans->init_dram.paging[idx].block,
+	       page_size);
+
+	return sizeof(*range) + le32_to_cpu(range->range_data_size);
+}
+
 static int
 iwl_dump_ini_mon_dram_iter(struct iwl_fw_runtime *fwrt,
 			   struct iwl_fw_ini_region_cfg *reg, void *range_ptr,
@@ -1485,15 +1490,12 @@ static u32 iwl_dump_ini_mem_ranges(struct iwl_fw_runtime *fwrt,
 	return le32_to_cpu(reg->internal.num_of_ranges);
 }
 
-static u32 iwl_dump_ini_paging_gen2_ranges(struct iwl_fw_runtime *fwrt,
-					   struct iwl_fw_ini_region_cfg *reg)
-{
-	return fwrt->trans->init_dram.paging_cnt;
-}
-
 static u32 iwl_dump_ini_paging_ranges(struct iwl_fw_runtime *fwrt,
 				      struct iwl_fw_ini_region_cfg *reg)
 {
+	if (fwrt->trans->cfg->gen2)
+		return fwrt->trans->init_dram.paging_cnt;
+
 	return fwrt->num_of_paging_blk;
 }
 
@@ -1532,20 +1534,6 @@ static u32 iwl_dump_ini_mem_get_size(struct iwl_fw_runtime *fwrt,
 		 le32_to_cpu(reg->internal.range_data_size));
 }
 
-static u32 iwl_dump_ini_paging_gen2_get_size(struct iwl_fw_runtime *fwrt,
-					     struct iwl_fw_ini_region_cfg *reg)
-{
-	int i;
-	u32 range_header_len = sizeof(struct iwl_fw_ini_error_dump_range);
-	u32 size = sizeof(struct iwl_fw_ini_error_dump);
-
-	for (i = 0; i < iwl_dump_ini_paging_gen2_ranges(fwrt, reg); i++)
-		size += range_header_len +
-			fwrt->trans->init_dram.paging[i].size;
-
-	return size;
-}
-
 static u32 iwl_dump_ini_paging_get_size(struct iwl_fw_runtime *fwrt,
 					struct iwl_fw_ini_region_cfg *reg)
 {
@@ -1553,8 +1541,15 @@ static u32 iwl_dump_ini_paging_get_size(struct iwl_fw_runtime *fwrt,
 	u32 range_header_len = sizeof(struct iwl_fw_ini_error_dump_range);
 	u32 size = sizeof(struct iwl_fw_ini_error_dump);
 
-	for (i = 1; i <= iwl_dump_ini_paging_ranges(fwrt, reg); i++)
-		size += range_header_len + fwrt->fw_paging_db[i].fw_paging_size;
+	if (fwrt->trans->cfg->gen2) {
+		for (i = 0; i < iwl_dump_ini_paging_ranges(fwrt, reg); i++)
+			size += range_header_len +
+				fwrt->trans->init_dram.paging[i].size;
+	} else {
+		for (i = 1; i <= iwl_dump_ini_paging_ranges(fwrt, reg); i++)
+			size += range_header_len +
+				fwrt->fw_paging_db[i].fw_paging_size;
+	}
 
 	return size;
 }
@@ -1854,18 +1849,9 @@ static u32 iwl_dump_ini_trigger(struct iwl_fw_runtime *fwrt,
 			break;
 		case IWL_FW_INI_REGION_PAGING:
 			ops.fill_mem_hdr = iwl_dump_ini_mem_fill_header;
-			if (iwl_fw_dbg_is_paging_enabled(fwrt)) {
-				ops.get_num_of_ranges =
-					iwl_dump_ini_paging_ranges;
-				ops.get_size = iwl_dump_ini_paging_get_size;
-				ops.fill_range = iwl_dump_ini_paging_iter;
-			} else {
-				ops.get_num_of_ranges =
-					iwl_dump_ini_paging_gen2_ranges;
-				ops.get_size =
-					iwl_dump_ini_paging_gen2_get_size;
-				ops.fill_range = iwl_dump_ini_paging_gen2_iter;
-			}
+			ops.get_num_of_ranges = iwl_dump_ini_paging_ranges;
+			ops.get_size = iwl_dump_ini_paging_get_size;
+			ops.fill_range = iwl_dump_ini_paging_iter;
 			size += iwl_dump_ini_mem(fwrt, list, reg, &ops);
 			break;
 		case IWL_FW_INI_REGION_TXF:
-- 
2.23.0.rc1

