Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9A21E760D
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2020 08:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgE2Gjq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 May 2020 02:39:46 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:35006 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725562AbgE2Gjp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 May 2020 02:39:45 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jeYgB-000jvb-2Z; Fri, 29 May 2020 09:39:43 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 29 May 2020 09:39:25 +0300
Message-Id: <iwlwifi.20200529092401.f549b75bfdac.Iac74a6ffe45aff887cea13ee1d31b100ca11e249@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529063931.80551-1-luca@coelho.fi>
References: <20200529063931.80551-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 05/11] iwlwifi: acpi: evaluate dsm to enable 5.2 bands in Indonesia
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gil Adam <gil.adam@intel.com>

Evaluate the appropriate DSM from ACPI to enable 5.15,5.35 GHz
bands in Indonesia. If enabled send LARI_CONFIG_CHANGE cmd to fw.

Signed-off-by: Gil Adam <gil.adam@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   | 34 ++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 43 +++++++++++++++++++
 2 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 2d230a7893c2..fd719c37428c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -8,7 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(C) 2018 - 2019 Intel Corporation
+ * Copyright(C) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(C) 2018 - 2019 Intel Corporation
+ * Copyright(C) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -74,6 +74,11 @@ enum iwl_regulatory_and_nvm_subcmd_ids {
 	 */
 	NVM_ACCESS_COMPLETE = 0x0,
 
+	/**
+	 * @LARI_CONFIG_CHANGE: &struct iwl_lari_config_change_cmd
+	 */
+	LARI_CONFIG_CHANGE = 0x1,
+
 	/**
 	 * @NVM_GET_INFO:
 	 * Command is &struct iwl_nvm_get_info,
@@ -446,4 +451,29 @@ struct iwl_tas_config_cmd {
 	__le32 black_list_size;
 	__le32 black_list_array[IWL_TAS_BLACK_LIST_MAX];
 } __packed; /* TAS_CONFIG_CMD_API_S_VER_2 */
+
+/**
+ * enum iwl_lari_configs - bit masks for the various LARI config operations
+ * @LARI_CONFIG_DISABLE_11AC_UKRAINE_MSK: disable 11ac in ukraine
+ * @LARI_CONFIG_CHANGE_ETSI_TO_PASSIVE_MSK: ETSI 5.8GHz SRD passive scan
+ * @LARI_CONFIG_CHANGE_ETSI_TO_DISABLED_MSK: ETSI 5.8GHz SRD disabled
+ * @LARI_CONFIG_ENABLE_5G2_IN_INDONESIA_MSK: enable 5.15/5.35GHz bands in
+ * 	Indonesia
+ */
+enum iwl_lari_config_masks {
+	LARI_CONFIG_DISABLE_11AC_UKRAINE_MSK		= BIT(0),
+	LARI_CONFIG_CHANGE_ETSI_TO_PASSIVE_MSK		= BIT(1),
+	LARI_CONFIG_CHANGE_ETSI_TO_DISABLED_MSK		= BIT(2),
+	LARI_CONFIG_ENABLE_5G2_IN_INDONESIA_MSK		= BIT(3),
+};
+
+/**
+ * struct iwl_lari_config_change_cmd - change LARI configuration
+ * @config_bitmap: bit map of the config commands. each bit will trigger a
+ * different predefined FW config operation
+ */
+struct iwl_lari_config_change_cmd {
+	__le32 config_bitmap;
+} __packed; /* LARI_CHANGE_CONF_CMD_S_VER_1 */
+
 #endif /* __iwl_fw_api_nvm_reg_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 5e8d3f8c3d86..95a613537047 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -988,6 +988,44 @@ static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 	if (ret < 0)
 		IWL_DEBUG_RADIO(mvm, "failed to send TAS_CONFIG (%d)\n", ret);
 }
+
+static bool iwl_mvm_eval_dsm_indonesia_5g2(struct iwl_mvm *mvm)
+{
+	int ret = iwl_acpi_get_dsm_u8((&mvm->fwrt)->dev, 0,
+				      DSM_FUNC_ENABLE_INDONESIA_5G2);
+
+	IWL_DEBUG_RADIO(mvm,
+			"Evaluated DSM function ENABLE_INDONESIA_5G2, ret=%d\n",
+			ret);
+
+	return ret == 1;
+}
+
+static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
+{
+	int ret;
+	struct iwl_lari_config_change_cmd cmd = {};
+
+	if (iwl_mvm_eval_dsm_indonesia_5g2(mvm))
+		cmd.config_bitmap |=
+			cpu_to_le32(LARI_CONFIG_ENABLE_5G2_IN_INDONESIA_MSK);
+
+	/* apply more config masks here */
+
+	if (cmd.config_bitmap) {
+		IWL_DEBUG_RADIO(mvm,
+				"sending LARI_CONFIG_CHANGE, config_bitmap=0x%x\n",
+				le32_to_cpu(cmd.config_bitmap));
+		ret = iwl_mvm_send_cmd_pdu(mvm,
+					   WIDE_ID(REGULATORY_AND_NVM_GROUP,
+						   LARI_CONFIG_CHANGE),
+					   0, sizeof(cmd), &cmd);
+		if (ret < 0)
+			IWL_DEBUG_RADIO(mvm,
+					"Failed to send LARI_CONFIG_CHANGE (%d)\n",
+					ret);
+	}
+}
 #else /* CONFIG_ACPI */
 
 inline int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm,
@@ -1019,6 +1057,10 @@ static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
 static void iwl_mvm_tas_init(struct iwl_mvm *mvm)
 {
 }
+
+static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
+{
+}
 #endif /* CONFIG_ACPI */
 
 void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
@@ -1293,6 +1335,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	if (ret)
 		goto error;
 
+	iwl_mvm_lari_cfg(mvm);
 	/*
 	 * RTNL is not taken during Ct-kill, but we don't need to scan/Tx
 	 * anyway, so don't init MCC.
-- 
2.26.2

