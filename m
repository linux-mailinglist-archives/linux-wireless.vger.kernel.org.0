Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1E0A43C0
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 11:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfHaJtN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 05:49:13 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39646 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726626AbfHaJtK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 05:49:10 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i400J-0002OQ-Kz; Sat, 31 Aug 2019 12:49:08 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 31 Aug 2019 12:48:44 +0300
Message-Id: <20190831094859.6391-5-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190831094859.6391-1-luca@coelho.fi>
References: <20190831094859.6391-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 04/19] iwlwifi: support per-platform antenna gain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gil Adam <gil.adam@intel.com>

TX power limits as defined in the OTP assume the worst case scenario
in terms of the platform's atenna gain, but most platforms are below
that value so they can use more TX power without passing the regulatory
limit. If the platform indicates in the BIOS that it indeed has lower
gain, and the geographic location allows it, higher TX power can be
used. The driver reads the PPAG (Per-Platform Antenna Gain) data from
BIOS (if it exists), validates it and sends the appropriate command to
the FW. This flow happens once at FW init, in case of suspend/resume
there is no need to read again from BIOS as we save those values during
init, so just send the PPAG command again to FW.

Signed-off-by: Gil Adam <gil.adam@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  12 ++
 .../net/wireless/intel/iwlwifi/fw/api/phy.h   |   7 +
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  12 ++
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   1 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 121 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   3 +
 7 files changed, 159 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 991a23450999..6cb2d1f5efea 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -68,6 +68,7 @@
 #define ACPI_WRDD_METHOD	"WRDD"
 #define ACPI_SPLC_METHOD	"SPLC"
 #define ACPI_ECKV_METHOD	"ECKV"
+#define ACPI_PPAG_METHOD	"PPAG"
 
 #define ACPI_WIFI_DOMAIN	(0x07)
 
@@ -92,6 +93,17 @@
 #define ACPI_WGDS_NUM_BANDS		2
 #define ACPI_WGDS_TABLE_SIZE		3
 
+#define ACPI_PPAG_NUM_CHAINS		2
+#define ACPI_PPAG_NUM_SUB_BANDS		5
+#define ACPI_PPAG_WIFI_DATA_SIZE	((ACPI_PPAG_NUM_CHAINS * \
+					ACPI_PPAG_NUM_SUB_BANDS) + 3)
+
+/* PPAG gain value bounds in 1/8 dBm */
+#define ACPI_PPAG_MIN_LB -16
+#define ACPI_PPAG_MAX_LB 24
+#define ACPI_PPAG_MIN_HB -16
+#define ACPI_PPAG_MAX_HB 40
+
 #ifdef CONFIG_ACPI
 
 void *iwl_acpi_get_object(struct device *dev, acpi_string method);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h b/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
index 9cc59e00bd95..8991ddffbf5e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/phy.h
@@ -8,6 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
+ * Copyright(c) 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -30,6 +31,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
+ * Copyright(c) 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -89,6 +91,11 @@ enum iwl_phy_ops_subcmd_ids {
 	 */
 	GEO_TX_POWER_LIMIT = 0x05,
 
+	/**
+	 * @PER_PLATFORM_ANT_GAIN_CMD: &struct iwl_ppag_table_cmd
+	 */
+	PER_PLATFORM_ANT_GAIN_CMD = 0x07,
+
 	/**
 	 * @CT_KILL_NOTIFICATION: &struct ct_kill_notif
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index f195db398bed..6e1b9b21904e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -449,6 +449,18 @@ struct iwl_geo_tx_power_profiles_resp {
 	__le32 profile_idx;
 } __packed; /* GEO_TX_POWER_LIMIT_RESP */
 
+/**
+ * struct iwl_ppag_table_cmd - struct for PER_PLATFORM_ANT_GAIN_CMD cmd.
+ * @enabled: 1 if PPAG is enabled, 0 otherwise
+ * @gain: table of antenna gain values per chain and sub-band
+ * @reserved: reserved
+ */
+struct iwl_ppag_table_cmd {
+	__le32 enabled;
+	s8 gain[IWL_NUM_CHAIN_LIMITS][IWL_NUM_SUB_BANDS];
+	s8 reserved[2];
+} __packed; /* PER_PLATFORM_ANT_GAIN_CMD */
+
 /**
  * struct iwl_beacon_filter_cmd
  * REPLY_BEACON_FILTERING_CMD = 0xd2 (command)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 3d567240ef11..73cd41480c2f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -446,6 +446,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_ULTRA_HB_CHANNELS		= (__force iwl_ucode_tlv_capa_t)48,
 	IWL_UCODE_TLV_CAPA_CS_MODIFY			= (__force iwl_ucode_tlv_capa_t)49,
 	IWL_UCODE_TLV_CAPA_SET_LTR_GEN2			= (__force iwl_ucode_tlv_capa_t)50,
+	IWL_UCODE_TLV_CAPA_SET_PPAG			= (__force iwl_ucode_tlv_capa_t)52,
 
 	/* set 2 */
 	IWL_UCODE_TLV_CAPA_EXTENDED_DTS_MEASURE		= (__force iwl_ucode_tlv_capa_t)64,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 6f7345b121a6..2bf5b83e116c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1965,6 +1965,9 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 	 */
 	iwl_mvm_update_changed_regdom(mvm);
 
+	/* Re-configure PPAG settings */
+	iwl_mvm_ppag_send_cmd(mvm);
+
 	if (!unified_image)
 		/*  Re-configure default SAR profile */
 		iwl_mvm_sar_select_profile(mvm, 1, 1);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 0f6925a51435..af46723f790f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1002,6 +1002,113 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	return iwl_mvm_send_cmd_pdu(mvm, cmd_wide_id, 0, sizeof(cmd), &cmd);
 }
 
+static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
+{
+	union acpi_object *wifi_pkg, *data, *enabled;
+	int i, j, ret, tbl_rev;
+	int idx = 2;
+
+	mvm->ppag_table.enabled = cpu_to_le32(0);
+	data = iwl_acpi_get_object(mvm->dev, ACPI_PPAG_METHOD);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	wifi_pkg = iwl_acpi_get_wifi_pkg(mvm->dev, data,
+					 ACPI_PPAG_WIFI_DATA_SIZE, &tbl_rev);
+
+	if (IS_ERR(wifi_pkg) || tbl_rev != 0) {
+		ret = PTR_ERR(wifi_pkg);
+		goto out_free;
+	}
+
+	enabled = &wifi_pkg->package.elements[1];
+	if (enabled->type != ACPI_TYPE_INTEGER ||
+	    (enabled->integer.value != 0 && enabled->integer.value != 1)) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	mvm->ppag_table.enabled = cpu_to_le32(enabled->integer.value);
+	if (!mvm->ppag_table.enabled) {
+		ret = 0;
+		goto out_free;
+	}
+
+	/*
+	 * read, verify gain values and save them into the PPAG table.
+	 * first sub-band (j=0) corresponds to Low-Band (2.4GHz), and the
+	 * following sub-bands to High-Band (5GHz).
+	 */
+	for (i = 0; i < ACPI_PPAG_NUM_CHAINS; i++) {
+		for (j = 0; j < ACPI_PPAG_NUM_SUB_BANDS; j++) {
+			union acpi_object *ent;
+
+			ent = &wifi_pkg->package.elements[idx++];
+			if (ent->type != ACPI_TYPE_INTEGER ||
+			    (j == 0 && ent->integer.value > ACPI_PPAG_MAX_LB) ||
+			    (j == 0 && ent->integer.value < ACPI_PPAG_MIN_LB) ||
+			    (j != 0 && ent->integer.value > ACPI_PPAG_MAX_HB) ||
+			    (j != 0 && ent->integer.value < ACPI_PPAG_MIN_HB)) {
+				mvm->ppag_table.enabled = cpu_to_le32(0);
+				ret = -EINVAL;
+				goto out_free;
+			}
+			mvm->ppag_table.gain[i][j] = ent->integer.value;
+		}
+	}
+	ret = 0;
+out_free:
+	kfree(data);
+	return ret;
+}
+
+int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
+{
+	int i, j, ret;
+
+	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_SET_PPAG)) {
+		IWL_DEBUG_RADIO(mvm,
+				"PPAG capability not supported by FW, command not sent.\n");
+		return 0;
+	}
+
+	IWL_DEBUG_RADIO(mvm, "Sending PER_PLATFORM_ANT_GAIN_CMD\n");
+	IWL_DEBUG_RADIO(mvm, "PPAG is %s\n",
+			mvm->ppag_table.enabled ? "enabled" : "disabled");
+
+	for (i = 0; i < ACPI_PPAG_NUM_CHAINS; i++) {
+		for (j = 0; j < ACPI_PPAG_NUM_SUB_BANDS; j++) {
+			IWL_DEBUG_RADIO(mvm,
+					"PPAG table: chain[%d] band[%d]: gain = %d\n",
+					i, j, mvm->ppag_table.gain[i][j]);
+		}
+	}
+
+	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(PHY_OPS_GROUP,
+						PER_PLATFORM_ANT_GAIN_CMD),
+				   0, sizeof(mvm->ppag_table),
+				   &mvm->ppag_table);
+	if (ret < 0)
+		IWL_ERR(mvm, "failed to send PER_PLATFORM_ANT_GAIN_CMD (%d)\n",
+			ret);
+
+	return ret;
+}
+
+static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
+{
+	int ret;
+
+	ret = iwl_mvm_get_ppag_table(mvm);
+	if (ret < 0) {
+		IWL_DEBUG_RADIO(mvm,
+				"PPAG BIOS table invalid or unavailable. (%d)\n",
+				ret);
+		return 0;
+	}
+	return iwl_mvm_ppag_send_cmd(mvm);
+}
+
 #else /* CONFIG_ACPI */
 static int iwl_mvm_sar_get_wrds_table(struct iwl_mvm *mvm)
 {
@@ -1033,6 +1140,16 @@ int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 {
 	return -ENOENT;
 }
+
+int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
+{
+	return -ENOENT;
+}
+
+static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
+{
+	return -ENOENT;
+}
 #endif /* CONFIG_ACPI */
 
 void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
@@ -1325,6 +1442,10 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	if (iwl_acpi_get_eckv(mvm->dev, &mvm->ext_clock_valid))
 		IWL_DEBUG_INFO(mvm, "ECKV table doesn't exist in BIOS\n");
 
+	ret = iwl_mvm_ppag_init(mvm);
+	if (ret)
+		goto error;
+
 	ret = iwl_mvm_sar_init(mvm);
 	if (ret == 0) {
 		ret = iwl_mvm_sar_geo_init(mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 79bbdf8121cc..0ea0f72880af 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1136,6 +1136,8 @@ struct iwl_mvm {
 	struct iwl_mvm_sar_profile sar_profiles[ACPI_SAR_PROFILE_NUM];
 	struct iwl_mvm_geo_profile geo_profiles[ACPI_NUM_GEO_PROFILES];
 	u32 geo_rev;
+	struct iwl_ppag_table_cmd ppag_table;
+	u32 ppag_rev;
 #endif
 };
 
@@ -2050,6 +2052,7 @@ void iwl_mvm_event_frame_timeout_callback(struct iwl_mvm *mvm,
 
 int iwl_mvm_sar_select_profile(struct iwl_mvm *mvm, int prof_a, int prof_b);
 int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm);
+int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm);
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 void iwl_mvm_sta_add_debugfs(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif,
-- 
2.23.0.rc1

