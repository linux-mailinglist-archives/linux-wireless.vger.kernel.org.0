Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2401AEABD
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2020 10:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDRIJu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Apr 2020 04:09:50 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56828 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725887AbgDRIJu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Apr 2020 04:09:50 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPiXS-000L3r-Fx; Sat, 18 Apr 2020 11:09:23 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 18 Apr 2020 11:08:57 +0300
Message-Id: <iwlwifi.20200418110539.3c9f0fa6033f.Id1d6c191f85efe0d6cf35434bfb186ffd46ff64c@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200418080857.2232093-1-luca@coelho.fi>
References: <20200418080857.2232093-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 12/12] iwlwifi: debug: set NPK buffer in context info
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gil Adam <gil.adam@intel.com>

When buffer destination for ini debug is configured
to NPK (TB22DTF) set the appropriate bit in the context
info struct.

Signed-off-by: Gil Adam <gil.adam@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 26 ++++++----
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       | 47 ++++++++++---------
 2 files changed, 43 insertions(+), 30 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index bf2f00b89214..9eb8fbfaa2a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -5,7 +5,7 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -28,7 +28,7 @@
  *
  * BSD LICENSE
  *
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -170,14 +170,24 @@ static int iwl_dbg_tlv_alloc_buf_alloc(struct iwl_trans *trans,
 
 	if (le32_to_cpu(tlv->length) != sizeof(*alloc) ||
 	    (buf_location != IWL_FW_INI_LOCATION_SRAM_PATH &&
-	     buf_location != IWL_FW_INI_LOCATION_DRAM_PATH))
+	     buf_location != IWL_FW_INI_LOCATION_DRAM_PATH &&
+	     buf_location != IWL_FW_INI_LOCATION_NPK_PATH)) {
+		IWL_ERR(trans,
+			"WRT: Invalid allocation TLV\n");
+		return -EINVAL;
+	}
+
+	if ((buf_location == IWL_FW_INI_LOCATION_SRAM_PATH ||
+	     buf_location == IWL_FW_INI_LOCATION_NPK_PATH) &&
+	     alloc_id != IWL_FW_INI_ALLOCATION_ID_DBGC1) {
+		IWL_ERR(trans,
+			"WRT: Allocation TLV for SMEM/NPK path must have id %u (current: %u)\n",
+			IWL_FW_INI_ALLOCATION_ID_DBGC1, alloc_id);
 		return -EINVAL;
+	}
 
-	if ((buf_location == IWL_FW_INI_LOCATION_SRAM_PATH &&
-	     alloc_id != IWL_FW_INI_ALLOCATION_ID_DBGC1) ||
-	    (buf_location == IWL_FW_INI_LOCATION_DRAM_PATH &&
-	     (alloc_id == IWL_FW_INI_ALLOCATION_INVALID ||
-	      alloc_id >= IWL_FW_INI_ALLOCATION_NUM))) {
+	if (alloc_id == IWL_FW_INI_ALLOCATION_INVALID ||
+	    alloc_id >= IWL_FW_INI_ALLOCATION_NUM) {
 		IWL_ERR(trans,
 			"WRT: Invalid allocation id %u for allocation TLV\n",
 			alloc_id);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 01f248ba8fec..27e94e6140b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -5,7 +5,7 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -18,7 +18,7 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -84,32 +84,35 @@ iwl_pcie_ctxt_info_dbg_enable(struct iwl_trans *trans,
 
 	fw_mon_cfg = &trans->dbg.fw_mon_cfg[alloc_id];
 
-	if (le32_to_cpu(fw_mon_cfg->buf_location) ==
-	    IWL_FW_INI_LOCATION_SRAM_PATH) {
+	switch (le32_to_cpu(fw_mon_cfg->buf_location)) {
+	case IWL_FW_INI_LOCATION_SRAM_PATH:
 		dbg_flags |= IWL_PRPH_SCRATCH_EDBG_DEST_INTERNAL;
-
 		IWL_DEBUG_FW(trans,
-			     "WRT: Applying SMEM buffer destination\n");
-
-		goto out;
-	}
-
-	if (le32_to_cpu(fw_mon_cfg->buf_location) ==
-	    IWL_FW_INI_LOCATION_DRAM_PATH &&
-	    trans->dbg.fw_mon_ini[alloc_id].num_frags) {
-		struct iwl_dram_data *frag =
-			&trans->dbg.fw_mon_ini[alloc_id].frags[0];
-
-		dbg_flags |= IWL_PRPH_SCRATCH_EDBG_DEST_DRAM;
+				"WRT: Applying SMEM buffer destination\n");
+		break;
 
+	case IWL_FW_INI_LOCATION_NPK_PATH:
+		dbg_flags |= IWL_PRPH_SCRATCH_EDBG_DEST_TB22DTF;
 		IWL_DEBUG_FW(trans,
-			     "WRT: Applying DRAM destination (alloc_id=%u)\n",
-			     alloc_id);
+			     "WRT: Applying NPK buffer destination\n");
+		break;
 
-		dbg_cfg->hwm_base_addr = cpu_to_le64(frag->physical);
-		dbg_cfg->hwm_size = cpu_to_le32(frag->size);
+	case IWL_FW_INI_LOCATION_DRAM_PATH:
+		if (trans->dbg.fw_mon_ini[alloc_id].num_frags) {
+			struct iwl_dram_data *frag =
+				&trans->dbg.fw_mon_ini[alloc_id].frags[0];
+			dbg_flags |= IWL_PRPH_SCRATCH_EDBG_DEST_DRAM;
+			dbg_cfg->hwm_base_addr = cpu_to_le64(frag->physical);
+			dbg_cfg->hwm_size = cpu_to_le32(frag->size);
+			IWL_DEBUG_FW(trans,
+				     "WRT: Applying DRAM destination (alloc_id=%u, num_frags=%u)\n",
+				     alloc_id,
+				     trans->dbg.fw_mon_ini[alloc_id].num_frags);
+		}
+		break;
+	default:
+		IWL_ERR(trans, "WRT: Invalid buffer destination\n");
 	}
-
 out:
 	if (dbg_flags)
 		*control_flags |= IWL_PRPH_SCRATCH_EARLY_DEBUG_EN | dbg_flags;
-- 
2.25.1

