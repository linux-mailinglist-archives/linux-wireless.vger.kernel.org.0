Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793691B7C14
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 18:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbgDXQr2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 12:47:28 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57998 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728563AbgDXQrZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 12:47:25 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jS1U2-000OcH-Kp; Fri, 24 Apr 2020 19:47:23 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 19:47:00 +0300
Message-Id: <iwlwifi.20200424194456.7f30f977f9bf.I060b51d0d66d09b9d1ee512e7de8f2d695a52152@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424164707.2715869-1-luca@coelho.fi>
References: <20200424164707.2715869-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 04/11] iwlwifi: move iwl_set_soc_latency to iwl-drv to be used by other op_modes
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

All the op_mode need to send this command as well. Instead of
duplicating the code from mvm, put the code in a common place.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/init.c  | 55 ++++++++++++++++++-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 46 +---------------
 3 files changed, 55 insertions(+), 47 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/init.c b/drivers/net/wireless/intel/iwlwifi/fw/init.c
index ba00d162ce72..b373606e1241 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/init.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/init.c
@@ -6,7 +6,7 @@
  * GPL LICENSE SUMMARY
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2019 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -27,7 +27,7 @@
  * BSD LICENSE
  *
  * Copyright(c) 2017 Intel Deutschland GmbH
- * Copyright(c) 2019 Intel Corporation
+ * Copyright(c) 2019 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -62,6 +62,9 @@
 #include "dbg.h"
 #include "debugfs.h"
 
+#include "fw/api/soc.h"
+#include "fw/api/commands.h"
+
 void iwl_fw_runtime_init(struct iwl_fw_runtime *fwrt, struct iwl_trans *trans,
 			const struct iwl_fw *fw,
 			const struct iwl_fw_runtime_ops *ops, void *ops_ctx,
@@ -95,3 +98,51 @@ void iwl_fw_runtime_resume(struct iwl_fw_runtime *fwrt)
 	iwl_fw_resume_timestamp(fwrt);
 }
 IWL_EXPORT_SYMBOL(iwl_fw_runtime_resume);
+
+/* set device type and latency */
+int iwl_set_soc_latency(struct iwl_fw_runtime *fwrt)
+{
+	struct iwl_soc_configuration_cmd cmd = {};
+	struct iwl_host_cmd hcmd = {
+		.id = iwl_cmd_id(SOC_CONFIGURATION_CMD, SYSTEM_GROUP, 0),
+		.data[0] = &cmd,
+		.len[0] = sizeof(cmd),
+	};
+	int ret;
+
+	/*
+	 * In VER_1 of this command, the discrete value is considered
+	 * an integer; In VER_2, it's a bitmask.  Since we have only 2
+	 * values in VER_1, this is backwards-compatible with VER_2,
+	 * as long as we don't set any other bits.
+	 */
+	if (!fwrt->trans->trans_cfg->integrated)
+		cmd.flags = cpu_to_le32(SOC_CONFIG_CMD_FLAGS_DISCRETE);
+
+	BUILD_BUG_ON(IWL_CFG_TRANS_LTR_DELAY_NONE !=
+		     SOC_FLAGS_LTR_APPLY_DELAY_NONE);
+	BUILD_BUG_ON(IWL_CFG_TRANS_LTR_DELAY_200US !=
+		     SOC_FLAGS_LTR_APPLY_DELAY_200);
+	BUILD_BUG_ON(IWL_CFG_TRANS_LTR_DELAY_2500US !=
+		     SOC_FLAGS_LTR_APPLY_DELAY_2500);
+	BUILD_BUG_ON(IWL_CFG_TRANS_LTR_DELAY_1820US !=
+		     SOC_FLAGS_LTR_APPLY_DELAY_1820);
+
+	if (fwrt->trans->trans_cfg->ltr_delay != IWL_CFG_TRANS_LTR_DELAY_NONE &&
+	    !WARN_ON(!fwrt->trans->trans_cfg->integrated))
+		cmd.flags |= le32_encode_bits(fwrt->trans->trans_cfg->ltr_delay,
+					      SOC_FLAGS_LTR_APPLY_DELAY_MASK);
+
+	if (iwl_fw_lookup_cmd_ver(fwrt->fw, IWL_ALWAYS_LONG_GROUP,
+				  SCAN_REQ_UMAC) >= 2 &&
+	    fwrt->trans->trans_cfg->low_latency_xtal)
+		cmd.flags |= cpu_to_le32(SOC_CONFIG_CMD_FLAGS_LOW_LATENCY);
+
+	cmd.latency = cpu_to_le32(fwrt->trans->trans_cfg->xtal_latency);
+
+	ret = iwl_trans_send_cmd(fwrt->trans, &hcmd);
+	if (ret)
+		IWL_ERR(fwrt, "Failed to set soc latency: %d\n", ret);
+	return ret;
+}
+IWL_EXPORT_SYMBOL(iwl_set_soc_latency);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 9629ef94b214..b5e5e32b6152 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -242,5 +242,6 @@ int iwl_init_paging(struct iwl_fw_runtime *fwrt, enum iwl_ucode_type type);
 void iwl_free_fw_paging(struct iwl_fw_runtime *fwrt);
 
 void iwl_get_shared_mem_conf(struct iwl_fw_runtime *fwrt);
+int iwl_set_soc_latency(struct iwl_fw_runtime *fwrt);
 
 #endif /* __iwl_fw_runtime_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index c987d14597a6..4fd5d02b1f2d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -87,50 +87,6 @@ struct iwl_mvm_alive_data {
 	u32 scd_base_addr;
 };
 
-/* set device type and latency */
-static int iwl_set_soc_latency(struct iwl_mvm *mvm)
-{
-	struct iwl_soc_configuration_cmd cmd = {};
-	int ret;
-
-	/*
-	 * In VER_1 of this command, the discrete value is considered
-	 * an integer; In VER_2, it's a bitmask.  Since we have only 2
-	 * values in VER_1, this is backwards-compatible with VER_2,
-	 * as long as we don't set any other bits.
-	 */
-	if (!mvm->trans->trans_cfg->integrated)
-		cmd.flags = cpu_to_le32(SOC_CONFIG_CMD_FLAGS_DISCRETE);
-
-	BUILD_BUG_ON(IWL_CFG_TRANS_LTR_DELAY_NONE !=
-		     SOC_FLAGS_LTR_APPLY_DELAY_NONE);
-	BUILD_BUG_ON(IWL_CFG_TRANS_LTR_DELAY_200US !=
-		     SOC_FLAGS_LTR_APPLY_DELAY_200);
-	BUILD_BUG_ON(IWL_CFG_TRANS_LTR_DELAY_2500US !=
-		     SOC_FLAGS_LTR_APPLY_DELAY_2500);
-	BUILD_BUG_ON(IWL_CFG_TRANS_LTR_DELAY_1820US !=
-		     SOC_FLAGS_LTR_APPLY_DELAY_1820);
-
-	if (mvm->trans->trans_cfg->ltr_delay != IWL_CFG_TRANS_LTR_DELAY_NONE &&
-	    !WARN_ON(!mvm->trans->trans_cfg->integrated))
-		cmd.flags |= le32_encode_bits(mvm->trans->trans_cfg->ltr_delay,
-					      SOC_FLAGS_LTR_APPLY_DELAY_MASK);
-
-	if (iwl_fw_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
-				  SCAN_REQ_UMAC) >= 2 &&
-	    mvm->trans->trans_cfg->low_latency_xtal)
-		cmd.flags |= cpu_to_le32(SOC_CONFIG_CMD_FLAGS_LOW_LATENCY);
-
-	cmd.latency = cpu_to_le32(mvm->trans->trans_cfg->xtal_latency);
-
-	ret = iwl_mvm_send_cmd_pdu(mvm, iwl_cmd_id(SOC_CONFIGURATION_CMD,
-						   SYSTEM_GROUP, 0), 0,
-				   sizeof(cmd), &cmd);
-	if (ret)
-		IWL_ERR(mvm, "Failed to set soc latency: %d\n", ret);
-	return ret;
-}
-
 static int iwl_send_tx_ant_cfg(struct iwl_mvm *mvm, u8 valid_tx_ant)
 {
 	struct iwl_tx_ant_cfg_cmd tx_ant_cmd = {
@@ -1240,7 +1196,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 
 	if (fw_has_capa(&mvm->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_SOC_LATENCY_SUPPORT)) {
-		ret = iwl_set_soc_latency(mvm);
+		ret = iwl_set_soc_latency(&mvm->fwrt);
 		if (ret)
 			goto error;
 	}
-- 
2.26.2

