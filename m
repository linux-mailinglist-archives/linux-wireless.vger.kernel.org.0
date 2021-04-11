Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E343235B2EA
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 11:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235331AbhDKJwM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 05:52:12 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44486 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229804AbhDKJwM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 05:52:12 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVWfv-000Jkq-DN; Sun, 11 Apr 2021 12:46:41 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 11 Apr 2021 12:46:28 +0300
Message-Id: <iwlwifi.20210411124418.7e68856c8a95.I83acdbe39b63c363cabc04ad42d1d0b9ce98901c@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210411094630.431873-1-luca@coelho.fi>
References: <20210411094630.431873-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 10/12] iwlwifi: mvm: add support for version 3 of LARI_CONFIG_CHANGE command.
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Add support for version 3 of the LARI_CONFIG_CHANGE command.
This is needed to support FW API change which is needed
to support 11ax enablement in Russia.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c   | 10 +---------
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h    | 17 ++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c    | 18 ++++++++++++------
 3 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index eecc76a6e408..e31bba836c6f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2019-2020 Intel Corporation
+ * Copyright (C) 2019-2021 Intel Corporation
  */
 #include <linux/uuid.h>
 #include "iwl-drv.h"
@@ -759,14 +759,6 @@ __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 		config_bitmap |=
 			cpu_to_le32(LARI_CONFIG_CHANGE_ETSI_TO_DISABLED_MSK);
 
-	/*
-	 ** Evaluate func 'DSM_FUNC_11AX_ENABLEMENT'
-	 */
-	ret = iwl_acpi_eval_dsm_func(fwrt->dev, DSM_FUNC_11AX_ENABLEMENT);
-
-	config_bitmap |=
-		cpu_to_le32((ret &= IWL_11AX_UKRAINE_MASK) << IWL_11AX_UKRAINE_SHIFT);
-
 	return config_bitmap;
 }
 IWL_EXPORT_SYMBOL(iwl_acpi_get_lari_config_bitmap);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 3a358bbdde8e..dc8f2777e944 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -437,6 +437,21 @@ struct iwl_lari_config_change_cmd_v2 {
 	__le32 oem_uhb_allow_bitmap;
 } __packed; /* LARI_CHANGE_CONF_CMD_S_VER_2 */
 
+/**
+ * struct iwl_lari_config_change_cmd_v3 - change LARI configuration
+ * @config_bitmap: bit map of the config commands. each bit will trigger a
+ * different predefined FW config operation
+ * @oem_uhb_allow_bitmap: bitmap of UHB enabled MCC sets
+ * @oem_11ax_allow_bitmap: bitmap of 11ax allowed MCCs.
+ * For each supported country, a pair of regulatory override bit and 11ax mode exist
+ * in the bit field.
+ */
+struct iwl_lari_config_change_cmd_v3 {
+	__le32 config_bitmap;
+	__le32 oem_uhb_allow_bitmap;
+	__le32 oem_11ax_allow_bitmap;
+} __packed; /* LARI_CHANGE_CONF_CMD_S_VER_3 */
+
 /**
  * struct iwl_pnvm_init_complete_ntfy - PNVM initialization complete
  * @status: PNVM image loading status
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 9a3981f43050..8aa5f1a2c58c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1140,18 +1140,24 @@ static u8 iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
 static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 {
 	int cmd_ret;
-	struct iwl_lari_config_change_cmd_v2 cmd = {};
+	struct iwl_lari_config_change_cmd_v3 cmd = {};
 
 	cmd.config_bitmap = iwl_acpi_get_lari_config_bitmap(&mvm->fwrt);
 
 	/* apply more config masks here */
 
 	if (cmd.config_bitmap) {
-		size_t cmd_size = iwl_fw_lookup_cmd_ver(mvm->fw,
-							REGULATORY_AND_NVM_GROUP,
-							LARI_CONFIG_CHANGE, 1) == 2 ?
-			sizeof(struct iwl_lari_config_change_cmd_v2) :
-			sizeof(struct iwl_lari_config_change_cmd_v1);
+		size_t cmd_size;
+		u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
+						   REGULATORY_AND_NVM_GROUP,
+						   LARI_CONFIG_CHANGE, 1);
+		if (cmd_ver == 3)
+			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v3);
+		else if (cmd_ver == 2)
+			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v2);
+		else
+			cmd_size = sizeof(struct iwl_lari_config_change_cmd_v1);
+
 		IWL_DEBUG_RADIO(mvm,
 				"sending LARI_CONFIG_CHANGE, config_bitmap=0x%x\n",
 				le32_to_cpu(cmd.config_bitmap));
-- 
2.31.0

