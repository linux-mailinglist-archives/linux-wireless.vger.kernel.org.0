Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FD6277281
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Sep 2020 15:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgIXNhM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Sep 2020 09:37:12 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:52076 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727846AbgIXNhM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Sep 2020 09:37:12 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kLRDv-002IGj-Qm; Thu, 24 Sep 2020 16:23:48 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 24 Sep 2020 16:23:39 +0300
Message-Id: <iwlwifi.20200924162106.fb29c33d2cb9.I942bfe645e9d47cd1fcf6435506061f8b2cea21a@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924132339.337310-1-luca@coelho.fi>
References: <20200924132339.337310-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 7/7] iwlwifi: acpi: support ppag table command v2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gil Adam <gil.adam@intel.com>

Version 2 of the PPAG table command supports more sub-bands than
previous. Change relevant command structs and the reading of the ACPI
tables.

Signed-off-by: Gil Adam <gil.adam@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |   8 +-
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  27 +++--
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 103 +++++++++++++-----
 4 files changed, 100 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index bff0260012ec..c01b79736d7c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -107,10 +107,10 @@
 #define ACPI_WGDS_NUM_BANDS		2
 #define ACPI_WGDS_TABLE_SIZE		3
 
-#define ACPI_PPAG_NUM_CHAINS		2
-#define ACPI_PPAG_NUM_SUB_BANDS		5
-#define ACPI_PPAG_WIFI_DATA_SIZE	((ACPI_PPAG_NUM_CHAINS * \
-					ACPI_PPAG_NUM_SUB_BANDS) + 3)
+#define ACPI_PPAG_WIFI_DATA_SIZE	((IWL_NUM_CHAIN_LIMITS * \
+					IWL_NUM_SUB_BANDS) + 3)
+#define ACPI_PPAG_WIFI_DATA_SIZE_V2	((IWL_NUM_CHAIN_LIMITS * \
+					IWL_NUM_SUB_BANDS_V2) + 3)
 
 /* PPAG gain value bounds in 1/8 dBm */
 #define ACPI_PPAG_MIN_LB -16
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 6e1b9b21904e..45503e78d705 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -8,7 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -331,6 +331,7 @@ enum iwl_dev_tx_power_cmd_mode {
 
 #define IWL_NUM_CHAIN_LIMITS	2
 #define IWL_NUM_SUB_BANDS	5
+#define IWL_NUM_SUB_BANDS_V2	11
 
 /**
  * struct iwl_dev_tx_power_cmd - TX power reduction command
@@ -450,16 +451,26 @@ struct iwl_geo_tx_power_profiles_resp {
 } __packed; /* GEO_TX_POWER_LIMIT_RESP */
 
 /**
- * struct iwl_ppag_table_cmd - struct for PER_PLATFORM_ANT_GAIN_CMD cmd.
+ * union iwl_ppag_table_cmd - union for all versions of PPAG command
+ * @v1: version 1, table revision = 0
+ * @v2: version 2, table revision = 1
+ *
  * @enabled: 1 if PPAG is enabled, 0 otherwise
  * @gain: table of antenna gain values per chain and sub-band
  * @reserved: reserved
  */
-struct iwl_ppag_table_cmd {
-	__le32 enabled;
-	s8 gain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS];
-	s8 reserved[2];
-} __packed; /* PER_PLATFORM_ANT_GAIN_CMD */
+union iwl_ppag_table_cmd {
+	struct {
+		__le32 enabled;
+		s8 gain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS];
+		s8 reserved[2];
+	} v1;
+	struct {
+		__le32 enabled;
+		s8 gain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS_V2];
+		s8 reserved[2];
+	} v2;
+} __packed;
 
 /**
  * struct iwl_beacon_filter_cmd
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index b5e5e32b6152..cddcb4d9a264 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -207,7 +207,8 @@ struct iwl_fw_runtime {
 	u8 sar_chain_b_profile;
 	struct iwl_geo_profile geo_profiles[ACPI_NUM_GEO_PROFILES];
 	u32 geo_rev;
-	struct iwl_ppag_table_cmd ppag_table;
+	union iwl_ppag_table_cmd ppag_table;
+	u32 ppag_ver;
 #endif
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 4467359aaa20..ba7d57b40c79 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -841,27 +841,53 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 {
 	union acpi_object *wifi_pkg, *data, *enabled;
-	int i, j, ret, tbl_rev;
+	union iwl_ppag_table_cmd ppag_table;
+	int i, j, ret, tbl_rev, num_sub_bands;
 	int idx = 2;
+	s8 *gain;
 
-	mvm->fwrt.ppag_table.enabled = cpu_to_le32(0);
+	/*
+	 * The 'enabled' field is the same in v1 and v2 so we can just
+	 * use v1 to access it.
+	 */
+	mvm->fwrt.ppag_table.v1.enabled = cpu_to_le32(0);
 	data = iwl_acpi_get_object(mvm->dev, ACPI_PPAG_METHOD);
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 
+	/* try to read ppag table revision 1 */
 	wifi_pkg = iwl_acpi_get_wifi_pkg(mvm->dev, data,
-					 ACPI_PPAG_WIFI_DATA_SIZE, &tbl_rev);
-
-	if (IS_ERR(wifi_pkg)) {
-		ret = PTR_ERR(wifi_pkg);
-		goto out_free;
+					 ACPI_PPAG_WIFI_DATA_SIZE_V2, &tbl_rev);
+	if (!IS_ERR(wifi_pkg)) {
+		if (tbl_rev != 1) {
+			ret = -EINVAL;
+			goto out_free;
+		}
+		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
+		gain = mvm->fwrt.ppag_table.v2.gain[0];
+		mvm->fwrt.ppag_ver = 2;
+		IWL_DEBUG_RADIO(mvm, "Reading PPAG table v2 (tbl_rev=1)\n");
+		goto read_table;
 	}
 
-	if (tbl_rev != 0) {
-		ret = -EINVAL;
-		goto out_free;
+	/* try to read ppag table revision 0 */
+	wifi_pkg = iwl_acpi_get_wifi_pkg(mvm->dev, data,
+					 ACPI_PPAG_WIFI_DATA_SIZE, &tbl_rev);
+	if (!IS_ERR(wifi_pkg)) {
+		if (tbl_rev != 0) {
+			ret = -EINVAL;
+			goto out_free;
+		}
+		num_sub_bands = IWL_NUM_SUB_BANDS;
+		gain = mvm->fwrt.ppag_table.v1.gain[0];
+		mvm->fwrt.ppag_ver = 1;
+		IWL_DEBUG_RADIO(mvm, "Reading PPAG table v1 (tbl_rev=0)\n");
+		goto read_table;
 	}
+	ret = PTR_ERR(wifi_pkg);
+	goto out_free;
 
+read_table:
 	enabled = &wifi_pkg->package.elements[1];
 	if (enabled->type != ACPI_TYPE_INTEGER ||
 	    (enabled->integer.value != 0 && enabled->integer.value != 1)) {
@@ -869,8 +895,8 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 		goto out_free;
 	}
 
-	mvm->fwrt.ppag_table.enabled = cpu_to_le32(enabled->integer.value);
-	if (!mvm->fwrt.ppag_table.enabled) {
+	ppag_table.v1.enabled = cpu_to_le32(enabled->integer.value);
+	if (!ppag_table.v1.enabled) {
 		ret = 0;
 		goto out_free;
 	}
@@ -880,8 +906,8 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 	 * first sub-band (j=0) corresponds to Low-Band (2.4GHz), and the
 	 * following sub-bands to High-Band (5GHz).
 	 */
-	for (i = 0; i < ACPI_PPAG_NUM_CHAINS; i++) {
-		for (j = 0; j < ACPI_PPAG_NUM_SUB_BANDS; j++) {
+	for (i = 0; i < IWL_NUM_CHAIN_LIMITS; i++) {
+		for (j = 0; j < num_sub_bands; j++) {
 			union acpi_object *ent;
 
 			ent = &wifi_pkg->package.elements[idx++];
@@ -890,11 +916,11 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 			    (j == 0 && ent->integer.value < ACPI_PPAG_MIN_LB) ||
 			    (j != 0 && ent->integer.value > ACPI_PPAG_MAX_HB) ||
 			    (j != 0 && ent->integer.value < ACPI_PPAG_MIN_HB)) {
-				mvm->fwrt.ppag_table.enabled = cpu_to_le32(0);
+				ppag_table.v1.enabled = cpu_to_le32(0);
 				ret = -EINVAL;
 				goto out_free;
 			}
-			mvm->fwrt.ppag_table.gain[i][j] = ent->integer.value;
+			gain[i * num_sub_bands + j] = ent->integer.value;
 		}
 	}
 	ret = 0;
@@ -905,34 +931,55 @@ static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
 
 int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 {
-	int i, j, ret;
+	u8 cmd_ver;
+	int i, j, ret, num_sub_bands, cmd_size;
+	union iwl_ppag_table_cmd ppag_table;
+	s8 *gain;
 
 	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_SET_PPAG)) {
 		IWL_DEBUG_RADIO(mvm,
 				"PPAG capability not supported by FW, command not sent.\n");
 		return 0;
 	}
-
-	if (!mvm->fwrt.ppag_table.enabled) {
-		IWL_DEBUG_RADIO(mvm,
-				"PPAG not enabled, command not sent.\n");
+	if (!mvm->fwrt.ppag_table.v1.enabled) {
+		IWL_DEBUG_RADIO(mvm, "PPAG not enabled, command not sent.\n");
 		return 0;
 	}
 
-	IWL_DEBUG_RADIO(mvm, "Sending PER_PLATFORM_ANT_GAIN_CMD\n");
+	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, PHY_OPS_GROUP,
+					PER_PLATFORM_ANT_GAIN_CMD);
+	if (cmd_ver == 1) {
+		num_sub_bands = IWL_NUM_SUB_BANDS;
+		gain = mvm->fwrt.ppag_table.v1.gain[0];
+		cmd_size = sizeof(ppag_table.v1);
+		if (mvm->fwrt.ppag_ver == 2) {
+			IWL_DEBUG_RADIO(mvm,
+					"PPAG table is v2 but FW supports v1, sending truncated table\n");
+		}
+	} else if (cmd_ver == 2) {
+		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
+		gain = mvm->fwrt.ppag_table.v2.gain[0];
+		cmd_size = sizeof(ppag_table.v2);
+		if (mvm->fwrt.ppag_ver == 1) {
+			IWL_DEBUG_RADIO(mvm,
+					"PPAG table is v1 but FW supports v2, sending padded table\n");
+		}
+	} else {
+		IWL_DEBUG_RADIO(mvm, "Unsupported PPAG command version\n");
+		return 0;
+	}
 
-	for (i = 0; i < ACPI_PPAG_NUM_CHAINS; i++) {
-		for (j = 0; j < ACPI_PPAG_NUM_SUB_BANDS; j++) {
+	for (i = 0; i < IWL_NUM_CHAIN_LIMITS; i++) {
+		for (j = 0; j < num_sub_bands; j++) {
 			IWL_DEBUG_RADIO(mvm,
 					"PPAG table: chain[%d] band[%d]: gain = %d\n",
-					i, j, mvm->fwrt.ppag_table.gain[i][j]);
+					i, j, gain[i * num_sub_bands + j]);
 		}
 	}
-
+	IWL_DEBUG_RADIO(mvm, "Sending PER_PLATFORM_ANT_GAIN_CMD\n");
 	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(PHY_OPS_GROUP,
 						PER_PLATFORM_ANT_GAIN_CMD),
-				   0, sizeof(mvm->fwrt.ppag_table),
-				   &mvm->fwrt.ppag_table);
+				   0, cmd_size, &ppag_table);
 	if (ret < 0)
 		IWL_ERR(mvm, "failed to send PER_PLATFORM_ANT_GAIN_CMD (%d)\n",
 			ret);
-- 
2.28.0

