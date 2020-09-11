Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D4B2667E7
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 19:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgIKRzE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 13:55:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50280 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726073AbgIKRzA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 13:55:00 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kGn6O-0028eU-JG; Fri, 11 Sep 2020 20:44:49 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 11 Sep 2020 20:44:37 +0300
Message-Id: <iwlwifi.20200911204056.45b270b0bf2f.I4561138cd5be9f44fa42cfce10258de0607be40f@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911174439.163225-1-luca@coelho.fi>
References: <20200911174439.163225-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 09/11] iwlwifi: fw: move assert descriptor parser to common code
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Move this parser to a common place, instead of having it in code that
is specific to mvm.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/img.c   | 44 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |  6 +--
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 44 ++-----------------
 3 files changed, 48 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.c b/drivers/net/wireless/intel/iwlwifi/fw/img.c
index de8cff463dbe..a4cbfc8f030f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.c
@@ -5,7 +5,7 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2019 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -25,7 +25,7 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2019 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -97,3 +97,43 @@ u8 iwl_fw_lookup_notif_ver(const struct iwl_fw *fw, u8 grp, u8 cmd, u8 def)
 	return def;
 }
 EXPORT_SYMBOL_GPL(iwl_fw_lookup_notif_ver);
+
+#define FW_SYSASSERT_CPU_MASK 0xf0000000
+static const struct {
+	const char *name;
+	u8 num;
+} advanced_lookup[] = {
+	{ "NMI_INTERRUPT_WDG", 0x34 },
+	{ "SYSASSERT", 0x35 },
+	{ "UCODE_VERSION_MISMATCH", 0x37 },
+	{ "BAD_COMMAND", 0x38 },
+	{ "BAD_COMMAND", 0x39 },
+	{ "NMI_INTERRUPT_DATA_ACTION_PT", 0x3C },
+	{ "FATAL_ERROR", 0x3D },
+	{ "NMI_TRM_HW_ERR", 0x46 },
+	{ "NMI_INTERRUPT_TRM", 0x4C },
+	{ "NMI_INTERRUPT_BREAK_POINT", 0x54 },
+	{ "NMI_INTERRUPT_WDG_RXF_FULL", 0x5C },
+	{ "NMI_INTERRUPT_WDG_NO_RBD_RXF_FULL", 0x64 },
+	{ "NMI_INTERRUPT_HOST", 0x66 },
+	{ "NMI_INTERRUPT_LMAC_FATAL", 0x70 },
+	{ "NMI_INTERRUPT_UMAC_FATAL", 0x71 },
+	{ "NMI_INTERRUPT_OTHER_LMAC_FATAL", 0x73 },
+	{ "NMI_INTERRUPT_ACTION_PT", 0x7C },
+	{ "NMI_INTERRUPT_UNKNOWN", 0x84 },
+	{ "NMI_INTERRUPT_INST_ACTION_PT", 0x86 },
+	{ "ADVANCED_SYSASSERT", 0 },
+};
+
+const char *iwl_fw_lookup_assert_desc(u32 num)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(advanced_lookup) - 1; i++)
+		if (advanced_lookup[i].num == (num & ~FW_SYSASSERT_CPU_MASK))
+			return advanced_lookup[i].name;
+
+	/* No entry matches 'num', so it is the last: ADVANCED_SYSASSERT */
+	return advanced_lookup[i].name;
+}
+EXPORT_SYMBOL_GPL(iwl_fw_lookup_assert_desc);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index a8630bf90b63..50672414356a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -5,10 +5,9 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2008 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016        Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2008 - 2014, 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +30,7 @@
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016        Intel Deutschland GmbH
- * Copyright(c) 2018 - 2019 Intel Corporation
+ * Copyright(c) 2008 - 2014, 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -316,4 +315,5 @@ iwl_get_ucode_image(const struct iwl_fw *fw, enum iwl_ucode_type ucode_type)
 u8 iwl_fw_lookup_cmd_ver(const struct iwl_fw *fw, u8 grp, u8 cmd);
 
 u8 iwl_fw_lookup_notif_ver(const struct iwl_fw *fw, u8 grp, u8 cmd, u8 def);
+const char *iwl_fw_lookup_assert_desc(u32 num);
 #endif  /* __iwl_fw_img_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index be57b8391850..52a052e92b94 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -67,6 +67,7 @@
 #include "iwl-csr.h"
 #include "mvm.h"
 #include "fw/api/rs.h"
+#include "fw/img.h"
 
 /*
  * Will return 0 even if the cmd failed when RFKILL is asserted unless
@@ -289,45 +290,6 @@ u8 iwl_mvm_next_antenna(struct iwl_mvm *mvm, u8 valid, u8 last_idx)
 	return last_idx;
 }
 
-#define FW_SYSASSERT_CPU_MASK 0xf0000000
-static const struct {
-	const char *name;
-	u8 num;
-} advanced_lookup[] = {
-	{ "NMI_INTERRUPT_WDG", 0x34 },
-	{ "SYSASSERT", 0x35 },
-	{ "UCODE_VERSION_MISMATCH", 0x37 },
-	{ "BAD_COMMAND", 0x38 },
-	{ "BAD_COMMAND", 0x39 },
-	{ "NMI_INTERRUPT_DATA_ACTION_PT", 0x3C },
-	{ "FATAL_ERROR", 0x3D },
-	{ "NMI_TRM_HW_ERR", 0x46 },
-	{ "NMI_INTERRUPT_TRM", 0x4C },
-	{ "NMI_INTERRUPT_BREAK_POINT", 0x54 },
-	{ "NMI_INTERRUPT_WDG_RXF_FULL", 0x5C },
-	{ "NMI_INTERRUPT_WDG_NO_RBD_RXF_FULL", 0x64 },
-	{ "NMI_INTERRUPT_HOST", 0x66 },
-	{ "NMI_INTERRUPT_LMAC_FATAL", 0x70 },
-	{ "NMI_INTERRUPT_UMAC_FATAL", 0x71 },
-	{ "NMI_INTERRUPT_OTHER_LMAC_FATAL", 0x73 },
-	{ "NMI_INTERRUPT_ACTION_PT", 0x7C },
-	{ "NMI_INTERRUPT_UNKNOWN", 0x84 },
-	{ "NMI_INTERRUPT_INST_ACTION_PT", 0x86 },
-	{ "ADVANCED_SYSASSERT", 0 },
-};
-
-static const char *desc_lookup(u32 num)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(advanced_lookup) - 1; i++)
-		if (advanced_lookup[i].num == (num & ~FW_SYSASSERT_CPU_MASK))
-			return advanced_lookup[i].name;
-
-	/* No entry matches 'num', so it is the last: ADVANCED_SYSASSERT */
-	return advanced_lookup[i].name;
-}
-
 /*
  * Note: This structure is read from the device with IO accesses,
  * and the reading already does the endian conversion. As it is
@@ -480,7 +442,7 @@ static void iwl_mvm_dump_umac_error_log(struct iwl_mvm *mvm)
 	}
 
 	IWL_ERR(mvm, "0x%08X | %s\n", table.error_id,
-		desc_lookup(table.error_id));
+		iwl_fw_lookup_assert_desc(table.error_id));
 	IWL_ERR(mvm, "0x%08X | umac branchlink1\n", table.blink1);
 	IWL_ERR(mvm, "0x%08X | umac branchlink2\n", table.blink2);
 	IWL_ERR(mvm, "0x%08X | umac interruptlink1\n", table.ilink1);
@@ -550,7 +512,7 @@ static void iwl_mvm_dump_lmac_error_log(struct iwl_mvm *mvm, u8 lmac_num)
 	IWL_ERR(mvm, "Loaded firmware version: %s\n", mvm->fw->fw_version);
 
 	IWL_ERR(mvm, "0x%08X | %-28s\n", table.error_id,
-		desc_lookup(table.error_id));
+		iwl_fw_lookup_assert_desc(table.error_id));
 	IWL_ERR(mvm, "0x%08X | trm_hw_status0\n", table.trm_hw_status0);
 	IWL_ERR(mvm, "0x%08X | trm_hw_status1\n", table.trm_hw_status1);
 	IWL_ERR(mvm, "0x%08X | branchlink2\n", table.blink2);
-- 
2.28.0

