Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA111AEAB1
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2020 10:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbgDRIJU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Apr 2020 04:09:20 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56746 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725969AbgDRIJT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Apr 2020 04:09:19 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPiXK-000L3r-Tm; Sat, 18 Apr 2020 11:09:15 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 18 Apr 2020 11:08:47 +0300
Message-Id: <iwlwifi.20200418110539.242a8f979592.I13c77a8a8dbf1a169b5052c7af1f8401ff3991ad@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200418080857.2232093-1-luca@coelho.fi>
References: <20200418080857.2232093-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 02/12] iwlwifi: mvm: add framework for specific phy configuration
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gil Adam <gil.adam@intel.com>

Add framework for supporting specific PHY filter configuration,
which allows for application of various FW defined PHY filters
(one per antenna). Change phy_cfg_cmd to the new API (ver3).
Reading of configuration from platform's ACPI tables to be added
later when tables are defined.

Signed-off-by: Gil Adam <gil.adam@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/config.h    | 39 ++++++++++++--
 .../wireless/intel/iwlwifi/mvm/constants.h    |  4 ++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 54 +++++++++++++++++--
 3 files changed, 91 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/config.h b/drivers/net/wireless/intel/iwlwifi/fw/api/config.h
index 5e88fa2e6fb7..546fa60ed9fd 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/config.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/config.h
@@ -8,7 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 Intel Corporation
+ * Copyright (C) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -119,16 +119,49 @@ enum iwl_calib_cfg {
 	IWL_CALIB_CFG_AGC_IDX			= BIT(18),
 };
 
+/**
+ * struct iwl_phy_specific_cfg - specific PHY filter configuration
+ *
+ * Sent as part of the phy configuration command (v3) to configure specific FW
+ * defined PHY filters that can be applied to each antenna.
+ *
+ * @filter_cfg_chain_a: filter config id for LMAC1 chain A
+ * @filter_cfg_chain_b: filter config id for LMAC1 chain B
+ * @filter_cfg_chain_c: filter config id for LMAC2 chain A
+ * @filter_cfg_chain_d: filter config id for LMAC2 chain B
+ * values: 0 - no filter; 0xffffffff - reserved; otherwise - filter id
+ */
+struct iwl_phy_specific_cfg {
+	__le32 filter_cfg_chain_a;
+	__le32 filter_cfg_chain_b;
+	__le32 filter_cfg_chain_c;
+	__le32 filter_cfg_chain_d;
+} __packed; /* PHY_SPECIFIC_CONFIGURATION_API_VER_1*/
+
 /**
  * struct iwl_phy_cfg_cmd - Phy configuration command
+ *
  * @phy_cfg: PHY configuration value, uses &enum iwl_fw_phy_cfg
  * @calib_control: calibration control data
  */
-struct iwl_phy_cfg_cmd {
+struct iwl_phy_cfg_cmd_v1 {
 	__le32	phy_cfg;
 	struct iwl_calib_ctrl calib_control;
 } __packed;
 
+/**
+ * struct iwl_phy_cfg_cmd_v3 - Phy configuration command (v3)
+ *
+ * @phy_cfg: PHY configuration value, uses &enum iwl_fw_phy_cfg
+ * @calib_control: calibration control data
+ * @phy_specific_cfg: configure predefined PHY filters
+ */
+struct iwl_phy_cfg_cmd_v3 {
+	__le32	phy_cfg;
+	struct iwl_calib_ctrl calib_control;
+	struct iwl_phy_specific_cfg phy_specific_cfg;
+} __packed; /* PHY_CONFIGURATION_CMD_API_S_VER_3 */
+
 /*
  * enum iwl_dc2dc_config_id - flag ids
  *
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index 58df25e2fb32..b0268f44b2ea 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -155,5 +155,9 @@
 #define IWL_MVM_USE_TWT				false
 #define IWL_MVM_AMPDU_CONSEC_DROPS_DELBA	10
 #define IWL_MVM_USE_NSSN_SYNC			0
+#define IWL_MVM_PHY_FILTER_CHAIN_A		0
+#define IWL_MVM_PHY_FILTER_CHAIN_B		0
+#define IWL_MVM_PHY_FILTER_CHAIN_C		0
+#define IWL_MVM_PHY_FILTER_CHAIN_D		0
 
 #endif /* __MVM_CONSTANTS_H */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 8fe78ce37771..2bc15ef13bb5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -550,10 +550,49 @@ static int iwl_run_unified_mvm_ucode(struct iwl_mvm *mvm, bool read_nvm)
 	return ret;
 }
 
+#ifdef CONFIG_ACPI
+static void iwl_mvm_phy_filter_init(struct iwl_mvm *mvm,
+				    struct iwl_phy_specific_cfg *phy_filters)
+{
+	/*
+	 * TODO: read specific phy config from BIOS
+	 * ACPI table for this feature has not been defined yet,
+	 * so for now we use hardcoded values.
+	 */
+
+	if (IWL_MVM_PHY_FILTER_CHAIN_A) {
+		phy_filters->filter_cfg_chain_a =
+			cpu_to_le32(IWL_MVM_PHY_FILTER_CHAIN_A);
+	}
+	if (IWL_MVM_PHY_FILTER_CHAIN_B) {
+		phy_filters->filter_cfg_chain_b =
+			cpu_to_le32(IWL_MVM_PHY_FILTER_CHAIN_B);
+	}
+	if (IWL_MVM_PHY_FILTER_CHAIN_C) {
+		phy_filters->filter_cfg_chain_c =
+			cpu_to_le32(IWL_MVM_PHY_FILTER_CHAIN_C);
+	}
+	if (IWL_MVM_PHY_FILTER_CHAIN_D) {
+		phy_filters->filter_cfg_chain_d =
+			cpu_to_le32(IWL_MVM_PHY_FILTER_CHAIN_D);
+	}
+}
+
+#else /* CONFIG_ACPI */
+
+static void iwl_mvm_phy_filter_init(struct iwl_mvm *mvm,
+				    struct iwl_phy_specific_cfg *phy_filters)
+{
+}
+#endif /* CONFIG_ACPI */
+
 static int iwl_send_phy_cfg_cmd(struct iwl_mvm *mvm)
 {
-	struct iwl_phy_cfg_cmd phy_cfg_cmd;
+	struct iwl_phy_cfg_cmd_v3 phy_cfg_cmd;
 	enum iwl_ucode_type ucode_type = mvm->fwrt.cur_fw_img;
+	struct iwl_phy_specific_cfg phy_filters = {};
+	u8 cmd_ver;
+	size_t cmd_size;
 
 	if (iwl_mvm_has_unified_ucode(mvm) &&
 	    !mvm->trans->cfg->tx_with_siso_diversity)
@@ -580,11 +619,20 @@ static int iwl_send_phy_cfg_cmd(struct iwl_mvm *mvm)
 	phy_cfg_cmd.calib_control.flow_trigger =
 		mvm->fw->default_calib[ucode_type].flow_trigger;
 
+	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, IWL_ALWAYS_LONG_GROUP,
+					PHY_CONFIGURATION_CMD);
+	if (cmd_ver == 3) {
+		iwl_mvm_phy_filter_init(mvm, &phy_filters);
+		memcpy(&phy_cfg_cmd.phy_specific_cfg, &phy_filters,
+		       sizeof(struct iwl_phy_specific_cfg));
+	}
+
 	IWL_DEBUG_INFO(mvm, "Sending Phy CFG command: 0x%x\n",
 		       phy_cfg_cmd.phy_cfg);
-
+	cmd_size = (cmd_ver == 3) ? sizeof(struct iwl_phy_cfg_cmd_v3) :
+				    sizeof(struct iwl_phy_cfg_cmd_v1);
 	return iwl_mvm_send_cmd_pdu(mvm, PHY_CONFIGURATION_CMD, 0,
-				    sizeof(phy_cfg_cmd), &phy_cfg_cmd);
+				    cmd_size, &phy_cfg_cmd);
 }
 
 int iwl_run_init_mvm_ucode(struct iwl_mvm *mvm, bool read_nvm)
-- 
2.25.1

