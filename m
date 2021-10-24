Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E244389C9
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 17:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbhJXPXR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 11:23:17 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58650 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231372AbhJXPXR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 11:23:17 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mefIs-000czj-8T; Sun, 24 Oct 2021 18:20:55 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 18:20:32 +0300
Message-Id: <iwlwifi.20211024181719.672fa727ef75.I6572df5d1e3441a0214993a59985da9a9431f3e5@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211024152037.332948-1-luca@coelho.fi>
References: <20211024152037.332948-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 07/12] iwlwifi: rename GEO_TX_POWER_LIMIT to PER_CHAIN_LIMIT_OFFSET_CMD
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

When this code was implemented, there was no official FW API
description yet, so a placeholder name was used (GEO_TX_POWER_LIMIT).
But then the command became actually called
PER_CHAIN_LIMIT_OFFSET_CMD.  Rename the command (and change related
comments) to PER_CHAIN_LIMIT_OFFSET_CMD to avoid confusion.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  8 +++---
 .../net/wireless/intel/iwlwifi/fw/api/phy.h   |  6 ++--
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 28 +++++++++----------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  9 +++---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  2 +-
 5 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 4602e74d176d..bf431fa4fe81 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -862,10 +862,10 @@ IWL_EXPORT_SYMBOL(iwl_sar_get_wgds_table);
 bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
 {
 	/*
-	 * The GEO_TX_POWER_LIMIT command is not supported on earlier
-	 * firmware versions.  Unfortunately, we don't have a TLV API
-	 * flag to rely on, so rely on the major version which is in
-	 * the first byte of ucode_ver.  This was implemented
+	 * The PER_CHAIN_LIMIT_OFFSET_CMD command is not supported on
+	 * earlier firmware versions.  Unfortunately, we don't have a
+	 * TLV API flag to rely on, so rely on the major version which
+	 * is in the first byte of ucode_ver.  This was implemented
 	 * initially on version 38 and then backported to 17.  It was
 	 * also backported to 29, but only for 7265D devices.  The
 	 * intention was to have it in 36 as well, but not all 8000
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
index d07a632f1af7..c04f2521fcb3 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2019-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2019-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -29,9 +29,9 @@ enum iwl_phy_ops_subcmd_ids {
 	TEMP_REPORTING_THRESHOLDS_CMD = 0x04,
 
 	/**
-	 * @GEO_TX_POWER_LIMIT: &struct iwl_geo_tx_power_profiles_cmd
+	 * @PER_CHAIN_LIMIT_OFFSET_CMD: &struct iwl_geo_tx_power_profiles_cmd
 	 */
-	GEO_TX_POWER_LIMIT = 0x05,
+	PER_CHAIN_LIMIT_OFFSET_CMD = 0x05,
 
 	/**
 	 * @PER_PLATFORM_ANT_GAIN_CMD: &struct iwl_ppag_table_cmd
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 44dd64e78a2c..4d671c878bb7 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -391,10 +391,10 @@ struct iwl_dev_tx_power_cmd {
 enum iwl_geo_per_chain_offset_operation {
 	IWL_PER_CHAIN_OFFSET_SET_TABLES,
 	IWL_PER_CHAIN_OFFSET_GET_CURRENT_TABLE,
-};  /* GEO_TX_POWER_LIMIT FLAGS TYPE */
+};  /* PER_CHAIN_OFFSET_OPERATION_E */
 
 /**
- * struct iwl_per_chain_offset - embedded struct for GEO_TX_POWER_LIMIT.
+ * struct iwl_per_chain_offset - embedded struct for PER_CHAIN_LIMIT_OFFSET_CMD.
  * @max_tx_power: maximum allowed tx power.
  * @chain_a: tx power offset for chain a.
  * @chain_b: tx power offset for chain b.
@@ -406,17 +406,17 @@ struct iwl_per_chain_offset {
 } __packed; /* PER_CHAIN_LIMIT_OFFSET_PER_CHAIN_S_VER_1 */
 
 /**
- * struct iwl_geo_tx_power_profile_cmd_v1 - struct for GEO_TX_POWER_LIMIT cmd.
+ * struct iwl_geo_tx_power_profile_cmd_v1 - struct for PER_CHAIN_LIMIT_OFFSET_CMD cmd.
  * @ops: operations, value from &enum iwl_geo_per_chain_offset_operation
  * @table: offset profile per band.
  */
 struct iwl_geo_tx_power_profiles_cmd_v1 {
 	__le32 ops;
 	struct iwl_per_chain_offset table[IWL_NUM_GEO_PROFILES][IWL_NUM_BANDS_PER_CHAIN_V1];
-} __packed; /* GEO_TX_POWER_LIMIT_VER_1 */
+} __packed; /* PER_CHAIN_LIMIT_OFFSET_CMD_VER_1 */
 
 /**
- * struct iwl_geo_tx_power_profile_cmd_v2 - struct for GEO_TX_POWER_LIMIT cmd.
+ * struct iwl_geo_tx_power_profile_cmd_v2 - struct for PER_CHAIN_LIMIT_OFFSET_CMD cmd.
  * @ops: operations, value from &enum iwl_geo_per_chain_offset_operation
  * @table: offset profile per band.
  * @table_revision: BIOS table revision.
@@ -425,10 +425,10 @@ struct iwl_geo_tx_power_profiles_cmd_v2 {
 	__le32 ops;
 	struct iwl_per_chain_offset table[IWL_NUM_GEO_PROFILES][IWL_NUM_BANDS_PER_CHAIN_V1];
 	__le32 table_revision;
-} __packed; /* GEO_TX_POWER_LIMIT_VER_2 */
+} __packed; /* PER_CHAIN_LIMIT_OFFSET_CMD_VER_2 */
 
 /**
- * struct iwl_geo_tx_power_profile_cmd_v3 - struct for GEO_TX_POWER_LIMIT cmd.
+ * struct iwl_geo_tx_power_profile_cmd_v3 - struct for PER_CHAIN_LIMIT_OFFSET_CMD cmd.
  * @ops: operations, value from &enum iwl_geo_per_chain_offset_operation
  * @table: offset profile per band.
  * @table_revision: BIOS table revision.
@@ -437,10 +437,10 @@ struct iwl_geo_tx_power_profiles_cmd_v3 {
 	__le32 ops;
 	struct iwl_per_chain_offset table[IWL_NUM_GEO_PROFILES][IWL_NUM_BANDS_PER_CHAIN_V2];
 	__le32 table_revision;
-} __packed; /* GEO_TX_POWER_LIMIT_VER_3 */
+} __packed; /* PER_CHAIN_LIMIT_OFFSET_CMD_VER_3 */
 
 /**
- * struct iwl_geo_tx_power_profile_cmd_v4 - struct for GEO_TX_POWER_LIMIT cmd.
+ * struct iwl_geo_tx_power_profile_cmd_v4 - struct for PER_CHAIN_LIMIT_OFFSET_CMD cmd.
  * @ops: operations, value from &enum iwl_geo_per_chain_offset_operation
  * @table: offset profile per band.
  * @table_revision: BIOS table revision.
@@ -449,10 +449,10 @@ struct iwl_geo_tx_power_profiles_cmd_v4 {
 	__le32 ops;
 	struct iwl_per_chain_offset table[IWL_NUM_GEO_PROFILES_V3][IWL_NUM_BANDS_PER_CHAIN_V1];
 	__le32 table_revision;
-} __packed; /* GEO_TX_POWER_LIMIT_VER_4 */
+} __packed; /* PER_CHAIN_LIMIT_OFFSET_CMD_VER_4 */
 
 /**
- * struct iwl_geo_tx_power_profile_cmd_v5 - struct for GEO_TX_POWER_LIMIT cmd.
+ * struct iwl_geo_tx_power_profile_cmd_v5 - struct for PER_CHAIN_LIMIT_OFFSET_CMD cmd.
  * @ops: operations, value from &enum iwl_geo_per_chain_offset_operation
  * @table: offset profile per band.
  * @table_revision: BIOS table revision.
@@ -461,7 +461,7 @@ struct iwl_geo_tx_power_profiles_cmd_v5 {
 	__le32 ops;
 	struct iwl_per_chain_offset table[IWL_NUM_GEO_PROFILES_V3][IWL_NUM_BANDS_PER_CHAIN_V2];
 	__le32 table_revision;
-} __packed; /* GEO_TX_POWER_LIMIT_VER_5 */
+} __packed; /* PER_CHAIN_LIMIT_OFFSET_CMD_VER_5 */
 
 union iwl_geo_tx_power_profiles_cmd {
 	struct iwl_geo_tx_power_profiles_cmd_v1 v1;
@@ -472,12 +472,12 @@ union iwl_geo_tx_power_profiles_cmd {
 };
 
 /**
- * struct iwl_geo_tx_power_profiles_resp -  response to GEO_TX_POWER_LIMIT cmd
+ * struct iwl_geo_tx_power_profiles_resp -  response to PER_CHAIN_LIMIT_OFFSET_CMD cmd
  * @profile_idx: current geo profile in use
  */
 struct iwl_geo_tx_power_profiles_resp {
 	__le32 profile_idx;
-} __packed; /* GEO_TX_POWER_LIMIT_RESP */
+} __packed; /* PER_CHAIN_LIMIT_OFFSET_RSP */
 
 /**
  * union iwl_ppag_table_cmd - union for all versions of PPAG command
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 8b96b885658f..863fec150e53 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -769,7 +769,7 @@ int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 	int ret;
 	struct iwl_host_cmd cmd;
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_OPS_GROUP,
-					   GEO_TX_POWER_LIMIT,
+					   PER_CHAIN_LIMIT_OFFSET_CMD,
 					   IWL_FW_CMD_VER_UNKNOWN);
 
 	/* the ops field is at the same spot for all versions, so set in v1 */
@@ -792,7 +792,7 @@ int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 		return -EOPNOTSUPP;
 
 	cmd = (struct iwl_host_cmd){
-		.id =  WIDE_ID(PHY_OPS_GROUP, GEO_TX_POWER_LIMIT),
+		.id =  WIDE_ID(PHY_OPS_GROUP, PER_CHAIN_LIMIT_OFFSET_CMD),
 		.len = { len, },
 		.flags = CMD_WANT_SKB,
 		.data = { &geo_tx_cmd },
@@ -822,7 +822,7 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	u32 n_profiles;
 	int ret;
 	u8 cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_OPS_GROUP,
-					   GEO_TX_POWER_LIMIT,
+					   PER_CHAIN_LIMIT_OFFSET_CMD,
 					   IWL_FW_CMD_VER_UNKNOWN);
 
 	BUILD_BUG_ON(offsetof(struct iwl_geo_tx_power_profiles_cmd_v1, ops) !=
@@ -894,7 +894,8 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 		cmd.v2.table_revision = cpu_to_le32(mvm->fwrt.geo_rev);
 
 	return iwl_mvm_send_cmd_pdu(mvm,
-				    WIDE_ID(PHY_OPS_GROUP, GEO_TX_POWER_LIMIT),
+				    WIDE_ID(PHY_OPS_GROUP,
+					    PER_CHAIN_LIMIT_OFFSET_CMD),
 				    0, len, &cmd);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index e331e18b9ab1..0ad45d11c9e0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -521,7 +521,7 @@ static const struct iwl_hcmd_names iwl_mvm_phy_names[] = {
 	HCMD_NAME(CMD_DTS_MEASUREMENT_TRIGGER_WIDE),
 	HCMD_NAME(CTDP_CONFIG_CMD),
 	HCMD_NAME(TEMP_REPORTING_THRESHOLDS_CMD),
-	HCMD_NAME(GEO_TX_POWER_LIMIT),
+	HCMD_NAME(PER_CHAIN_LIMIT_OFFSET_CMD),
 	HCMD_NAME(CT_KILL_NOTIFICATION),
 	HCMD_NAME(DTS_MEASUREMENT_NOTIF_WIDE),
 };
-- 
2.33.0

