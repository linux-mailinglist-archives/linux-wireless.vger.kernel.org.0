Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF84246FB16
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 08:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbhLJHKJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 02:10:09 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50852 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234860AbhLJHKJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 02:10:09 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mvZzE-001F9v-S4; Fri, 10 Dec 2021 09:06:33 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 10 Dec 2021 09:06:20 +0200
Message-Id: <iwlwifi.20211210090244.1d8725b7518a.I0c36617a7282bd445cda484d97ac4a83022706ee@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210070621.236783-1-luca@coelho.fi>
References: <20211210070621.236783-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 10/11] iwlwifi: recognize missing PNVM data and then log filename
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We can detect that a FW SYSASSERT is due to missing PNVM data by
checking the assertion code.  When this happens, it's is useful for
the user if we print the filename where the driver is looking for the
data.

Add the PNVM missing assertion code to the dump list and print out the
name of the file we're looking for when this happens.

Reported-by: Sam Edwards <CFSworks@gmail.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c | 9 +++++++++
 drivers/net/wireless/intel/iwlwifi/fw/img.c  | 6 +++---
 drivers/net/wireless/intel/iwlwifi/fw/img.h  | 4 ++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index 6c59506ea00d..81acb7df73d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -12,6 +12,7 @@
 #include "iwl-io.h"
 #include "iwl-prph.h"
 #include "iwl-csr.h"
+#include "pnvm.h"
 
 /*
  * Note: This structure is read from the device with IO accesses,
@@ -100,6 +101,7 @@ static void iwl_fwrt_dump_umac_error_log(struct iwl_fw_runtime *fwrt)
 	struct iwl_trans *trans = fwrt->trans;
 	struct iwl_umac_error_event_table table = {};
 	u32 base = fwrt->trans->dbg.umac_error_event_table;
+	char pnvm_name[MAX_PNVM_NAME];
 
 	if (!base &&
 	    !(fwrt->trans->dbg.error_event_table_tlv_status &
@@ -117,6 +119,13 @@ static void iwl_fwrt_dump_umac_error_log(struct iwl_fw_runtime *fwrt)
 			fwrt->trans->status, table.valid);
 	}
 
+	if ((table.error_id & ~FW_SYSASSERT_CPU_MASK) ==
+	    FW_SYSASSERT_PNVM_MISSING) {
+		iwl_pnvm_get_fs_name(trans, pnvm_name, sizeof(pnvm_name));
+		IWL_ERR(fwrt, "PNVM data is missing, please install %s\n",
+			pnvm_name);
+	}
+
 	IWL_ERR(fwrt, "0x%08X | %s\n", table.error_id,
 		iwl_fw_lookup_assert_desc(table.error_id));
 	IWL_ERR(fwrt, "0x%08X | umac branchlink1\n", table.blink1);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.c b/drivers/net/wireless/intel/iwlwifi/fw/img.c
index 24a966673691..530674a35eeb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright(c) 2019 - 2020 Intel Corporation
+ * Copyright(c) 2019 - 2021 Intel Corporation
  */
 
 #include "img.h"
@@ -49,10 +49,9 @@ u8 iwl_fw_lookup_notif_ver(const struct iwl_fw *fw, u8 grp, u8 cmd, u8 def)
 }
 EXPORT_SYMBOL_GPL(iwl_fw_lookup_notif_ver);
 
-#define FW_SYSASSERT_CPU_MASK 0xf0000000
 static const struct {
 	const char *name;
-	u8 num;
+	u32 num;
 } advanced_lookup[] = {
 	{ "NMI_INTERRUPT_WDG", 0x34 },
 	{ "SYSASSERT", 0x35 },
@@ -73,6 +72,7 @@ static const struct {
 	{ "NMI_INTERRUPT_ACTION_PT", 0x7C },
 	{ "NMI_INTERRUPT_UNKNOWN", 0x84 },
 	{ "NMI_INTERRUPT_INST_ACTION_PT", 0x86 },
+	{ "PNVM_MISSING", FW_SYSASSERT_PNVM_MISSING },
 	{ "ADVANCED_SYSASSERT", 0 },
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index 993bda17fa30..fa7b1780064c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -279,4 +279,8 @@ u8 iwl_fw_lookup_cmd_ver(const struct iwl_fw *fw, u8 grp, u8 cmd, u8 def);
 
 u8 iwl_fw_lookup_notif_ver(const struct iwl_fw *fw, u8 grp, u8 cmd, u8 def);
 const char *iwl_fw_lookup_assert_desc(u32 num);
+
+#define FW_SYSASSERT_CPU_MASK		0xf0000000
+#define FW_SYSASSERT_PNVM_MISSING	0x0010070d
+
 #endif  /* __iwl_fw_img_h__ */
-- 
2.34.1

