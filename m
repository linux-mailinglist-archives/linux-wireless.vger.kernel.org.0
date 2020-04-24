Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3361B7A80
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 17:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgDXPsf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 11:48:35 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57904 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728481AbgDXPsd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 11:48:33 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jS0Z5-000OY2-0b; Fri, 24 Apr 2020 18:48:31 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 18:48:11 +0300
Message-Id: <iwlwifi.20200424182644.54418c829390.I15d6b462a0e69a280b6c6cfbcb6bcb05bb5f79ee@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424154818.2657602-1-luca@coelho.fi>
References: <20200424154818.2657602-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 05/12] iwlwifi: yoyo: don't access TLV before verifying len
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

If we access the TLV memory with shorter len than the struct
we access garbage data that was not given by the user.

On the way rewrite the checker in a cleaner way.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Fixes: a9248de42464 ("iwlwifi: dbg_ini: add TLV allocation new API support")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  5 ++-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 44 +++++++++----------
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index b9d7ed93311c..74ac65bd545a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -5,7 +5,7 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -25,7 +25,7 @@
  *
  * BSD LICENSE
  *
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -304,6 +304,7 @@ enum iwl_fw_ini_buffer_location {
 	IWL_FW_INI_LOCATION_SRAM_PATH,
 	IWL_FW_INI_LOCATION_DRAM_PATH,
 	IWL_FW_INI_LOCATION_NPK_PATH,
+	IWL_FW_INI_LOCATION_NUM,
 }; /* FW_DEBUG_TLV_BUFFER_LOCATION_E_VER_1 */
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index 9eb8fbfaa2a2..7987a288917b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -165,38 +165,36 @@ static int iwl_dbg_tlv_alloc_buf_alloc(struct iwl_trans *trans,
 				       struct iwl_ucode_tlv *tlv)
 {
 	struct iwl_fw_ini_allocation_tlv *alloc = (void *)tlv->data;
-	u32 buf_location = le32_to_cpu(alloc->buf_location);
-	u32 alloc_id = le32_to_cpu(alloc->alloc_id);
+	u32 buf_location;
+	u32 alloc_id;
 
-	if (le32_to_cpu(tlv->length) != sizeof(*alloc) ||
-	    (buf_location != IWL_FW_INI_LOCATION_SRAM_PATH &&
-	     buf_location != IWL_FW_INI_LOCATION_DRAM_PATH &&
-	     buf_location != IWL_FW_INI_LOCATION_NPK_PATH)) {
-		IWL_ERR(trans,
-			"WRT: Invalid allocation TLV\n");
+	if (le32_to_cpu(tlv->length) != sizeof(*alloc))
 		return -EINVAL;
-	}
 
-	if ((buf_location == IWL_FW_INI_LOCATION_SRAM_PATH ||
-	     buf_location == IWL_FW_INI_LOCATION_NPK_PATH) &&
-	     alloc_id != IWL_FW_INI_ALLOCATION_ID_DBGC1) {
-		IWL_ERR(trans,
-			"WRT: Allocation TLV for SMEM/NPK path must have id %u (current: %u)\n",
-			IWL_FW_INI_ALLOCATION_ID_DBGC1, alloc_id);
-		return -EINVAL;
-	}
+	buf_location = le32_to_cpu(alloc->buf_location);
+	alloc_id = le32_to_cpu(alloc->alloc_id);
+
+	if (buf_location == IWL_FW_INI_LOCATION_INVALID ||
+	    buf_location >= IWL_FW_INI_LOCATION_NUM)
+		goto err;
 
 	if (alloc_id == IWL_FW_INI_ALLOCATION_INVALID ||
-	    alloc_id >= IWL_FW_INI_ALLOCATION_NUM) {
-		IWL_ERR(trans,
-			"WRT: Invalid allocation id %u for allocation TLV\n",
-			alloc_id);
-		return -EINVAL;
-	}
+	    alloc_id >= IWL_FW_INI_ALLOCATION_NUM)
+		goto err;
+
+	if ((buf_location == IWL_FW_INI_LOCATION_SRAM_PATH ||
+	     buf_location == IWL_FW_INI_LOCATION_NPK_PATH) &&
+	     alloc_id != IWL_FW_INI_ALLOCATION_ID_DBGC1)
+		goto err;
 
 	trans->dbg.fw_mon_cfg[alloc_id] = *alloc;
 
 	return 0;
+err:
+	IWL_ERR(trans,
+		"WRT: Invalid allocation id %u and/or location id %u for allocation TLV\n",
+		alloc_id, buf_location);
+	return -EINVAL;
 }
 
 static int iwl_dbg_tlv_alloc_hcmd(struct iwl_trans *trans,
-- 
2.26.2

