Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5E246860B
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 16:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348126AbhLDPxV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 10:53:21 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50478 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1347440AbhLDPxU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 10:53:20 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtXIO-0017qB-Jg; Sat, 04 Dec 2021 17:49:53 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 17:49:37 +0200
Message-Id: <iwlwifi.20211204174546.e6dfd8b5dd40.Ibc9a8fe2bfde345f49df5d57ec56663da6a53dc4@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204154944.914175-1-luca@coelho.fi>
References: <20211204154944.914175-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 05/12] iwlwifi: support SAR GEO Offset Mapping override via BIOS
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ayala Barazani <ayala.barazani@intel.com>

Support reading the SAR Geographic Offset Mapping (SGOM) table from UEFI
to allow OEMs to override the values according to geographical regions.

Signed-off-by: Ayala Barazani <ayala.barazani@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  2 +
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  5 ++
 .../net/wireless/intel/iwlwifi/fw/api/power.h | 14 +++
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |  4 +
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 88 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  | 20 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 49 ++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  2 +
 8 files changed, 183 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 2e4590876bc3..0495316d1fc1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -852,6 +852,8 @@ int iwl_sar_get_wgds_table(struct iwl_fw_runtime *fwrt)
 		}
 	}
 
+	fwrt->geo_num_profiles = num_profiles;
+	fwrt->geo_enabled = true;
 	ret = 0;
 out_free:
 	kfree(data);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
index 3551a3f1c1aa..186199100929 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/nvm-reg.h
@@ -33,6 +33,11 @@ enum iwl_regulatory_and_nvm_subcmd_ids {
 	 */
 	TAS_CONFIG = 0x3,
 
+	/**
+	 * @SAR_OFFSET_MAPPING_TABLE_CMD: &iwl_sar_offset_mapping_cmd
+	 */
+	SAR_OFFSET_MAPPING_TABLE_CMD = 0x4,
+
 	/**
 	 * @PNVM_INIT_COMPLETE_NTFY: &struct iwl_pnvm_init_complete_ntfy
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
index 4d671c878bb7..631b96cc8ee9 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/power.h
@@ -503,6 +503,20 @@ union iwl_ppag_table_cmd {
 	} v2;
 } __packed;
 
+#define MCC_TO_SAR_OFFSET_TABLE_ROW_SIZE	26
+#define MCC_TO_SAR_OFFSET_TABLE_COL_SIZE	13
+
+/**
+ * struct iwl_sar_offset_mapping_cmd - struct for SAR_OFFSET_MAPPING_TABLE_CMD
+ * @offset_map: mapping a mcc to a geo sar group
+ * @reserved: reserved
+ */
+struct iwl_sar_offset_mapping_cmd {
+	u8 offset_map[MCC_TO_SAR_OFFSET_TABLE_ROW_SIZE]
+		[MCC_TO_SAR_OFFSET_TABLE_COL_SIZE];
+	u16 reserved;
+} __packed; /*SAR_OFFSET_MAPPING_TABLE_CMD_API_S*/
+
 /**
  * struct iwl_beacon_filter_cmd
  * REPLY_BEACON_FILTERING_CMD = 0xd2 (command)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
index 69799f1ed2c4..cd895b614ddb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/runtime.h
@@ -156,8 +156,12 @@ struct iwl_fw_runtime {
 	u8 sar_chain_b_profile;
 	struct iwl_geo_profile geo_profiles[ACPI_NUM_GEO_PROFILES_REV3];
 	u32 geo_rev;
+	u32 geo_num_profiles;
+	bool geo_enabled;
 	union iwl_ppag_table_cmd ppag_table;
 	u32 ppag_ver;
+	struct iwl_sar_offset_mapping_cmd sgom_table;
+	bool sgom_enabled;
 #endif
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
index c875bf35533c..c4dfc1aa60d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.c
@@ -11,6 +11,7 @@
 #include "fw/uefi.h"
 #include "fw/api/alive.h"
 #include <linux/efi.h>
+#include "fw/runtime.h"
 
 #define IWL_EFI_VAR_GUID EFI_GUID(0x92daaf2f, 0xc02b, 0x455b,	\
 				  0xb2, 0xec, 0xf5, 0xa3,	\
@@ -260,3 +261,90 @@ void *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
 
 	return data;
 }
+
+#ifdef CONFIG_ACPI
+static int iwl_uefi_sgom_parse(struct uefi_cnv_wlan_sgom_data *sgom_data,
+			       struct iwl_fw_runtime *fwrt)
+{
+	int i, j;
+
+	if (sgom_data->revision != 1)
+		return -EINVAL;
+
+	memcpy(fwrt->sgom_table.offset_map, sgom_data->offset_map,
+	       sizeof(fwrt->sgom_table.offset_map));
+
+	for (i = 0; i < MCC_TO_SAR_OFFSET_TABLE_ROW_SIZE; i++) {
+		for (j = 0; j < MCC_TO_SAR_OFFSET_TABLE_COL_SIZE; j++) {
+			/* since each byte is composed of to values, */
+			/* one for each letter, */
+			/* extract and check each of them separately */
+			u8 value = fwrt->sgom_table.offset_map[i][j];
+			u8 low = value & 0xF;
+			u8 high = (value & 0xF0) >> 4;
+
+			if (high > fwrt->geo_num_profiles)
+				high = 0;
+			if (low > fwrt->geo_num_profiles)
+				low = 0;
+			fwrt->sgom_table.offset_map[i][j] = (high << 4) | low;
+		}
+	}
+
+	fwrt->sgom_enabled = true;
+	return 0;
+}
+
+void iwl_uefi_get_sgom_table(struct iwl_trans *trans,
+			     struct iwl_fw_runtime *fwrt)
+{
+	struct efivar_entry *sgom_efivar;
+	struct uefi_cnv_wlan_sgom_data *data;
+	unsigned long package_size;
+	int err, ret;
+
+	if (!fwrt->geo_enabled)
+		return;
+
+	sgom_efivar = kzalloc(sizeof(*sgom_efivar), GFP_KERNEL);
+	if (!sgom_efivar)
+		return;
+
+	memcpy(&sgom_efivar->var.VariableName, IWL_UEFI_SGOM_NAME,
+	       sizeof(IWL_UEFI_SGOM_NAME));
+	sgom_efivar->var.VendorGuid = IWL_EFI_VAR_GUID;
+
+	/* TODO: we hardcode a maximum length here, because reading
+	 * from the UEFI is not working.  To implement this properly,
+	 * we have to call efivar_entry_size().
+	 */
+	package_size = IWL_HARDCODED_SGOM_SIZE;
+
+	data = kmalloc(package_size, GFP_KERNEL);
+	if (!data) {
+		data = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	err = efivar_entry_get(sgom_efivar, NULL, &package_size, data);
+	if (err) {
+		IWL_DEBUG_FW(trans,
+			     "SGOM UEFI variable not found %d\n", err);
+		goto out_free;
+	}
+
+	IWL_DEBUG_FW(trans, "Read SGOM from UEFI with size %lu\n",
+		     package_size);
+
+	ret = iwl_uefi_sgom_parse(data, fwrt);
+	if (ret < 0)
+		IWL_DEBUG_FW(trans, "Cannot read SGOM tables. rev is invalid\n");
+
+out_free:
+	kfree(data);
+
+out:
+	kfree(sgom_efivar);
+}
+IWL_EXPORT_SYMBOL(iwl_uefi_get_sgom_table);
+#endif /* CONFIG_ACPI */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
index d552c656ac9f..09d2a971b3a0 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/uefi.h
@@ -7,6 +7,7 @@
 
 #define IWL_UEFI_OEM_PNVM_NAME		L"UefiCnvWlanOemSignedPnvm"
 #define IWL_UEFI_REDUCED_POWER_NAME	L"UefiCnvWlanReducedPower"
+#define IWL_UEFI_SGOM_NAME		L"UefiCnvWlanSarGeoOffsetMapping"
 
 /*
  * TODO: we have these hardcoded values that the caller must pass,
@@ -16,6 +17,7 @@
  */
 #define IWL_HARDCODED_PNVM_SIZE		4096
 #define IWL_HARDCODED_REDUCE_POWER_SIZE	32768
+#define IWL_HARDCODED_SGOM_SIZE		339
 
 struct pnvm_sku_package {
 	u8 rev;
@@ -25,6 +27,16 @@ struct pnvm_sku_package {
 	u8 data[];
 } __packed;
 
+struct uefi_cnv_wlan_sgom_data {
+	u8 revision;
+	u8 offset_map[IWL_HARDCODED_SGOM_SIZE - 1];
+} __packed;
+
+/*
+ * This is known to be broken on v4.19 and to work on v5.4.  Until we
+ * figure out why this is the case and how to make it work, simply
+ * disable the feature in old kernels.
+ */
 #ifdef CONFIG_EFI
 void *iwl_uefi_get_pnvm(struct iwl_trans *trans, size_t *len);
 void *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len);
@@ -42,4 +54,12 @@ void *iwl_uefi_get_reduced_power(struct iwl_trans *trans, size_t *len)
 }
 #endif /* CONFIG_EFI */
 
+#if defined(CONFIG_EFI) && defined(CONFIG_ACPI)
+void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt);
+#else
+static inline
+void iwl_uefi_get_sgom_table(struct iwl_trans *trans, struct iwl_fw_runtime *fwrt)
+{
+}
+#endif
 #endif /* __iwl_fw_uefi__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 7608b1e486c4..187637c81d1a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -518,7 +518,6 @@ static void iwl_mvm_phy_filter_init(struct iwl_mvm *mvm,
 			cpu_to_le32(IWL_MVM_PHY_FILTER_CHAIN_D);
 	}
 }
-
 #else /* CONFIG_ACPI */
 
 static void iwl_mvm_phy_filter_init(struct iwl_mvm *mvm,
@@ -527,6 +526,49 @@ static void iwl_mvm_phy_filter_init(struct iwl_mvm *mvm,
 }
 #endif /* CONFIG_ACPI */
 
+#if defined(CONFIG_ACPI) && defined(CONFIG_EFI)
+static int iwl_mvm_sgom_init(struct iwl_mvm *mvm)
+{
+	u8 cmd_ver;
+	int ret;
+	struct iwl_host_cmd cmd = {
+		.id = WIDE_ID(REGULATORY_AND_NVM_GROUP,
+			      SAR_OFFSET_MAPPING_TABLE_CMD),
+		.flags = 0,
+		.data[0] = &mvm->fwrt.sgom_table,
+		.len[0] =  sizeof(mvm->fwrt.sgom_table),
+		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
+	};
+
+	if (!mvm->fwrt.sgom_enabled) {
+		IWL_DEBUG_RADIO(mvm, "SGOM table is disabled\n");
+		return 0;
+	}
+
+	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, REGULATORY_AND_NVM_GROUP,
+					SAR_OFFSET_MAPPING_TABLE_CMD,
+					IWL_FW_CMD_VER_UNKNOWN);
+
+	if (cmd_ver != 2) {
+		IWL_DEBUG_RADIO(mvm, "command version is unsupported. version = %d\n",
+				cmd_ver);
+		return 0;
+	}
+
+	ret = iwl_mvm_send_cmd(mvm, &cmd);
+	if (ret < 0)
+		IWL_ERR(mvm, "failed to send SAR_OFFSET_MAPPING_CMD (%d)\n", ret);
+
+	return ret;
+}
+#else
+
+static int iwl_mvm_sgom_init(struct iwl_mvm *mvm)
+{
+	return 0;
+}
+#endif
+
 static int iwl_send_phy_cfg_cmd(struct iwl_mvm *mvm)
 {
 	struct iwl_phy_cfg_cmd_v3 phy_cfg_cmd;
@@ -1340,6 +1382,7 @@ static u8 iwl_mvm_eval_dsm_rfi(struct iwl_mvm *mvm)
 void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
 {
 }
+
 #endif /* CONFIG_ACPI */
 
 void iwl_mvm_send_recovery_cmd(struct iwl_mvm *mvm, u32 flags)
@@ -1634,6 +1677,10 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	else if (ret < 0)
 		goto error;
 
+	ret = iwl_mvm_sgom_init(mvm);
+	if (ret)
+		goto error;
+
 	iwl_mvm_tas_init(mvm);
 	iwl_mvm_leds_sync(mvm);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 9c0872b106b6..cc1879e10c65 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -26,6 +26,7 @@
 #include "time-event.h"
 #include "fw-api.h"
 #include "fw/acpi.h"
+#include "fw/uefi.h"
 
 #define DRV_DESCRIPTION	"The new Intel(R) wireless AGN driver for Linux"
 MODULE_DESCRIPTION(DRV_DESCRIPTION);
@@ -1094,6 +1095,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 			    &iwl_mvm_sanitize_ops, mvm, dbgfs_dir);
 
 	iwl_mvm_get_acpi_tables(mvm);
+	iwl_uefi_get_sgom_table(trans, &mvm->fwrt);
 
 	mvm->init_status = 0;
 
-- 
2.33.1

