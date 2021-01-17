Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01D792F91E3
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 12:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbhAQLMg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 06:12:36 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40656 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728350AbhAQLLf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 06:11:35 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l15xI-003sZv-2P; Sun, 17 Jan 2021 13:10:48 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Jan 2021 13:10:36 +0200
Message-Id: <iwlwifi.20210117130510.ad2df68fccbc.I381f931c6e7606c21935ec6667619b209224e408@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117111038.1402870-1-luca@coelho.fi>
References: <20210117111038.1402870-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 09/11] iwlwifi: dbg: dump paged memory from index 1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

We skip index 0 that holds CSS section which isn't relevant for paged
memory.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 34 +++++++++++----------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 0f0a6727701b..1fdf80f154da 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2015-2017 Intel Deutschland GmbH
  */
@@ -1157,10 +1157,7 @@ static int iwl_dump_ini_dev_mem_iter(struct iwl_fw_runtime *fwrt,
 static int _iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
 				     void *range_ptr, int idx)
 {
-	/* increase idx by 1 since the pages are from 1 to
-	 * fwrt->num_of_paging_blk + 1
-	 */
-	struct page *page = fwrt->fw_paging_db[++idx].fw_paging_block;
+	struct page *page = fwrt->fw_paging_db[idx].fw_paging_block;
 	struct iwl_fw_ini_error_dump_range *range = range_ptr;
 	dma_addr_t addr = fwrt->fw_paging_db[idx].fw_paging_phys;
 	u32 page_size = fwrt->fw_paging_db[idx].fw_paging_size;
@@ -1183,6 +1180,9 @@ static int iwl_dump_ini_paging_iter(struct iwl_fw_runtime *fwrt,
 	struct iwl_fw_ini_error_dump_range *range;
 	u32 page_size;
 
+	/* all paged index start from 1 to skip CSS section */
+	idx++;
+
 	if (!fwrt->trans->trans_cfg->gen2)
 		return _iwl_dump_ini_paging_iter(fwrt, range_ptr, idx);
 
@@ -1684,8 +1684,12 @@ static u32 iwl_dump_ini_mem_ranges(struct iwl_fw_runtime *fwrt,
 static u32 iwl_dump_ini_paging_ranges(struct iwl_fw_runtime *fwrt,
 				      struct iwl_dump_ini_region_data *reg_data)
 {
-	if (fwrt->trans->trans_cfg->gen2)
-		return fwrt->trans->init_dram.paging_cnt;
+	if (fwrt->trans->trans_cfg->gen2) {
+		if (fwrt->trans->init_dram.paging_cnt)
+			return fwrt->trans->init_dram.paging_cnt - 1;
+		else
+			return 0;
+	}
 
 	return fwrt->num_of_paging_blk;
 }
@@ -1750,15 +1754,13 @@ iwl_dump_ini_paging_get_size(struct iwl_fw_runtime *fwrt,
 	u32 range_header_len = sizeof(struct iwl_fw_ini_error_dump_range);
 	u32 size = sizeof(struct iwl_fw_ini_error_dump);
 
-	if (fwrt->trans->trans_cfg->gen2) {
-		for (i = 0; i < iwl_dump_ini_paging_ranges(fwrt, reg_data); i++)
-			size += range_header_len +
-				fwrt->trans->init_dram.paging[i].size;
-	} else {
-		for (i = 1; i <= iwl_dump_ini_paging_ranges(fwrt, reg_data);
-		     i++)
-			size += range_header_len +
-				fwrt->fw_paging_db[i].fw_paging_size;
+	/* start from 1 to skip CSS section */
+	for (i = 1; i <= iwl_dump_ini_paging_ranges(fwrt, reg_data); i++) {
+		size += range_header_len;
+		if (fwrt->trans->trans_cfg->gen2)
+			size += fwrt->trans->init_dram.paging[i].size;
+		else
+			size += fwrt->fw_paging_db[i].fw_paging_size;
 	}
 
 	return size;
-- 
2.29.2

