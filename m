Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5861A4CD34C
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Mar 2022 12:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239421AbiCDLWl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Mar 2022 06:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239372AbiCDLWh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Mar 2022 06:22:37 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4B51B0C63
        for <linux-wireless@vger.kernel.org>; Fri,  4 Mar 2022 03:21:47 -0800 (PST)
Received: from 91-156-4-241.elisa-laajakaista.fi ([91.156.4.241] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nQ60G-000QSW-F3;
        Fri, 04 Mar 2022 13:21:45 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri,  4 Mar 2022 13:21:28 +0200
Message-Id: <iwlwifi.20220304131517.7f250088b443.I61e64c2758ad178da729ce00428287cc94430eed@changeid>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220304112129.219513-1-luca@coelho.fi>
References: <20220304112129.219513-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 12/13] iwlwifi: acpi: move ppag code from mvm to fw/acpi
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Matt Chen <matt.chen@intel.com>

Move the ppag code to fw/acpi to keep consistency
with the other ACPI handling we do.

Signed-off-by: Matt Chen <matt.chen@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 203 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h |  25 +++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 190 +----------------
 3 files changed, 234 insertions(+), 184 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 4441f92c004f..dd220e1d7996 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2019-2021 Intel Corporation
  */
 #include <linux/uuid.h>
+#include <linux/dmi.h>
 #include "iwl-drv.h"
 #include "iwl-debug.h"
 #include "acpi.h"
@@ -19,6 +20,30 @@ const guid_t iwl_rfi_guid = GUID_INIT(0x7266172C, 0x220B, 0x4B29,
 				      0xDD, 0x26, 0xB5, 0xFD);
 IWL_EXPORT_SYMBOL(iwl_rfi_guid);
 
+static const struct dmi_system_id dmi_ppag_approved_list[] = {
+	{ .ident = "HP",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+		},
+	},
+	{ .ident = "SAMSUNG",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD"),
+		},
+	},
+	{ .ident = "MSFT",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+		},
+	},
+	{ .ident = "ASUS",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTek COMPUTER INC."),
+		},
+	},
+	{}
+};
+
 static int iwl_acpi_get_handle(struct device *dev, acpi_string method,
 			       acpi_handle *ret_handle)
 {
@@ -971,3 +996,181 @@ __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt)
 	return config_bitmap;
 }
 IWL_EXPORT_SYMBOL(iwl_acpi_get_lari_config_bitmap);
+
+int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
+{
+	union acpi_object *wifi_pkg, *data, *flags;
+	int i, j, ret, tbl_rev, num_sub_bands = 0;
+	int idx = 2;
+
+	fwrt->ppag_flags = 0;
+
+	data = iwl_acpi_get_object(fwrt->dev, ACPI_PPAG_METHOD);
+	if (IS_ERR(data))
+		return PTR_ERR(data);
+
+	/* try to read ppag table rev 2 or 1 (both have the same data size) */
+	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
+				ACPI_PPAG_WIFI_DATA_SIZE_V2, &tbl_rev);
+
+	if (!IS_ERR(wifi_pkg)) {
+		if (tbl_rev == 1 || tbl_rev == 2) {
+			num_sub_bands = IWL_NUM_SUB_BANDS_V2;
+			IWL_DEBUG_RADIO(fwrt,
+					"Reading PPAG table v2 (tbl_rev=%d)\n",
+					tbl_rev);
+			goto read_table;
+		} else {
+			ret = -EINVAL;
+			goto out_free;
+		}
+	}
+
+	/* try to read ppag table revision 0 */
+	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
+			ACPI_PPAG_WIFI_DATA_SIZE_V1, &tbl_rev);
+
+	if (!IS_ERR(wifi_pkg)) {
+		if (tbl_rev != 0) {
+			ret = -EINVAL;
+			goto out_free;
+		}
+		num_sub_bands = IWL_NUM_SUB_BANDS_V1;
+		IWL_DEBUG_RADIO(fwrt, "Reading PPAG table v1 (tbl_rev=0)\n");
+		goto read_table;
+	}
+
+read_table:
+	fwrt->ppag_ver = tbl_rev;
+	flags = &wifi_pkg->package.elements[1];
+
+	if (flags->type != ACPI_TYPE_INTEGER) {
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	fwrt->ppag_flags = flags->integer.value & ACPI_PPAG_MASK;
+
+	if (!fwrt->ppag_flags) {
+		ret = 0;
+		goto out_free;
+	}
+
+	/*
+	 * read, verify gain values and save them into the PPAG table.
+	 * first sub-band (j=0) corresponds to Low-Band (2.4GHz), and the
+	 * following sub-bands to High-Band (5GHz).
+	 */
+	for (i = 0; i < IWL_NUM_CHAIN_LIMITS; i++) {
+		for (j = 0; j < num_sub_bands; j++) {
+			union acpi_object *ent;
+
+			ent = &wifi_pkg->package.elements[idx++];
+			if (ent->type != ACPI_TYPE_INTEGER) {
+				ret = -EINVAL;
+				goto out_free;
+			}
+
+			fwrt->ppag_chains[i].subbands[j] = ent->integer.value;
+
+			if ((j == 0 &&
+				(fwrt->ppag_chains[i].subbands[j] > ACPI_PPAG_MAX_LB ||
+				 fwrt->ppag_chains[i].subbands[j] < ACPI_PPAG_MIN_LB)) ||
+				(j != 0 &&
+				(fwrt->ppag_chains[i].subbands[j] > ACPI_PPAG_MAX_HB ||
+				fwrt->ppag_chains[i].subbands[j] < ACPI_PPAG_MIN_HB))) {
+					fwrt->ppag_flags = 0;
+					ret = -EINVAL;
+					goto out_free;
+				}
+		}
+	}
+
+
+	ret = 0;
+
+out_free:
+	kfree(data);
+	return ret;
+}
+IWL_EXPORT_SYMBOL(iwl_acpi_get_ppag_table);
+
+int iwl_read_ppag_table(struct iwl_fw_runtime *fwrt, union iwl_ppag_table_cmd *cmd,
+			int *cmd_size)
+{
+        u8 cmd_ver;
+        int i, j, num_sub_bands;
+        s8 *gain;
+
+        if (!fw_has_capa(&fwrt->fw->ucode_capa, IWL_UCODE_TLV_CAPA_SET_PPAG)) {
+                IWL_DEBUG_RADIO(fwrt,
+                                "PPAG capability not supported by FW, command not sent.\n");
+                return -EINVAL;
+        }
+        if (!fwrt->ppag_flags) {
+                IWL_DEBUG_RADIO(fwrt, "PPAG not enabled, command not sent.\n");
+                return -EINVAL;
+        }
+
+        /* The 'flags' field is the same in v1 and in v2 so we can just
+         * use v1 to access it.
+         */
+        cmd->v1.flags = cpu_to_le32(fwrt->ppag_flags);
+        cmd_ver = iwl_fw_lookup_cmd_ver(fwrt->fw,
+                                        WIDE_ID(PHY_OPS_GROUP, PER_PLATFORM_ANT_GAIN_CMD),
+                                        IWL_FW_CMD_VER_UNKNOWN);
+	if (cmd_ver == 1) {
+                num_sub_bands = IWL_NUM_SUB_BANDS_V1;
+                gain = cmd->v1.gain[0];
+                *cmd_size = sizeof(cmd->v1);
+                if (fwrt->ppag_ver == 1 || fwrt->ppag_ver == 2) {
+                        IWL_DEBUG_RADIO(fwrt,
+                                        "PPAG table rev is %d but FW supports v1, sending truncated table\n",
+                                        fwrt->ppag_ver);
+                        cmd->v1.flags &= cpu_to_le32(IWL_PPAG_ETSI_MASK);
+		}
+	} else if (cmd_ver == 2 || cmd_ver == 3) {
+                num_sub_bands = IWL_NUM_SUB_BANDS_V2;
+                gain = cmd->v2.gain[0];
+                *cmd_size = sizeof(cmd->v2);
+                if (fwrt->ppag_ver == 0) {
+                        IWL_DEBUG_RADIO(fwrt,
+                                        "PPAG table is v1 but FW supports v2, sending padded table\n");
+                } else if (cmd_ver == 2 && fwrt->ppag_ver == 2) {
+                        IWL_DEBUG_RADIO(fwrt,
+                                        "PPAG table is v3 but FW supports v2, sending partial bitmap.\n");
+                        cmd->v1.flags &= cpu_to_le32(IWL_PPAG_ETSI_MASK);
+                }
+        } else {
+                IWL_DEBUG_RADIO(fwrt, "Unsupported PPAG command version\n");
+                return -EINVAL;
+        }
+
+	for (i = 0; i < IWL_NUM_CHAIN_LIMITS; i++) {
+                for (j = 0; j < num_sub_bands; j++) {
+                        gain[i * num_sub_bands + j] =
+                                fwrt->ppag_chains[i].subbands[j];
+                        IWL_DEBUG_RADIO(fwrt,
+                                        "PPAG table: chain[%d] band[%d]: gain = %d\n",
+                                        i, j, gain[i * num_sub_bands + j]);
+                }
+        }
+
+	return 0;
+}
+IWL_EXPORT_SYMBOL(iwl_read_ppag_table);
+
+bool iwl_acpi_is_ppag_approved(struct iwl_fw_runtime *fwrt)
+{
+
+	if (!dmi_check_system(dmi_ppag_approved_list)) {
+		IWL_DEBUG_RADIO(fwrt,
+			"System vendor '%s' is not in the approved list, disabling PPAG.\n",
+			dmi_get_system_info(DMI_SYS_VENDOR));
+			fwrt->ppag_flags = 0;
+			return false;
+	}
+
+	return true;
+}
+IWL_EXPORT_SYMBOL(iwl_acpi_is_ppag_approved);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index 089dd9002528..6f361c59106f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -91,6 +91,8 @@
 #define ACPI_PPAG_MAX_LB 24
 #define ACPI_PPAG_MIN_HB -16
 #define ACPI_PPAG_MAX_HB 40
+#define ACPI_PPAG_MASK 3
+#define IWL_PPAG_ETSI_MASK BIT(0)
 
 #define IWL_SAR_ENABLE_MSK		BIT(0)
 #define IWL_REDUCE_POWER_FLAGS_POS	1
@@ -223,6 +225,13 @@ int iwl_acpi_get_tas(struct iwl_fw_runtime *fwrt,
 
 __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt);
 
+int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt);
+
+int iwl_read_ppag_table(struct iwl_fw_runtime *fwrt, union iwl_ppag_table_cmd *cmd,
+			int *cmd_size);
+
+bool iwl_acpi_is_ppag_approved(struct iwl_fw_runtime *fwrt);
+
 #else /* CONFIG_ACPI */
 
 static inline void *iwl_acpi_get_object(struct device *dev, acpi_string method)
@@ -310,6 +319,22 @@ static inline __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt
 	return 0;
 }
 
+static inline int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
+{
+	return -ENOENT;
+}
+
+static inline int iwl_read_ppag_table(struct iwl_fw_runtime *fwrt,
+				    union iwl_ppag_table_cmd *cmd, int *cmd_size)
+{
+	return -ENOENT;
+}
+
+static inline bool iwl_acpi_is_ppag_approved(struct iwl_fw_runtime *fwrt)
+{
+	return false;
+}
+
 #endif /* CONFIG_ACPI */
 
 static inline union acpi_object *
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index f4de8250696f..94d291a56e4a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -25,9 +25,6 @@
 #define MVM_UCODE_ALIVE_TIMEOUT	(HZ)
 #define MVM_UCODE_CALIB_TIMEOUT	(2 * HZ)
 
-#define IWL_PPAG_MASK 3
-#define IWL_PPAG_ETSI_MASK BIT(0)
-
 #define IWL_TAS_US_MCC 0x5553
 #define IWL_TAS_CANADA_MCC 0x4341
 
@@ -1012,161 +1009,15 @@ static int iwl_mvm_sar_geo_init(struct iwl_mvm *mvm)
 	return iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0, len, &cmd);
 }
 
-static int iwl_mvm_get_ppag_table(struct iwl_mvm *mvm)
-{
-	union acpi_object *wifi_pkg, *data, *flags;
-	int i, j, ret, tbl_rev, num_sub_bands;
-	int idx = 2;
-
-	mvm->fwrt.ppag_flags = 0;
-
-	data = iwl_acpi_get_object(mvm->dev, ACPI_PPAG_METHOD);
-	if (IS_ERR(data))
-		return PTR_ERR(data);
-
-	/* try to read ppag table rev 2 or 1 (both have the same data size) */
-	wifi_pkg = iwl_acpi_get_wifi_pkg(mvm->dev, data,
-					 ACPI_PPAG_WIFI_DATA_SIZE_V2, &tbl_rev);
-	if (!IS_ERR(wifi_pkg)) {
-		if (tbl_rev == 1 || tbl_rev == 2) {
-			num_sub_bands = IWL_NUM_SUB_BANDS_V2;
-			IWL_DEBUG_RADIO(mvm,
-					"Reading PPAG table v2 (tbl_rev=%d)\n",
-					tbl_rev);
-			goto read_table;
-		} else {
-			ret = -EINVAL;
-			goto out_free;
-		}
-	}
-
-	/* try to read ppag table revision 0 */
-	wifi_pkg = iwl_acpi_get_wifi_pkg(mvm->dev, data,
-					 ACPI_PPAG_WIFI_DATA_SIZE_V1, &tbl_rev);
-	if (!IS_ERR(wifi_pkg)) {
-		if (tbl_rev != 0) {
-			ret = -EINVAL;
-			goto out_free;
-		}
-		num_sub_bands = IWL_NUM_SUB_BANDS_V1;
-		IWL_DEBUG_RADIO(mvm, "Reading PPAG table v1 (tbl_rev=0)\n");
-		goto read_table;
-	}
-	ret = PTR_ERR(wifi_pkg);
-	goto out_free;
-
-read_table:
-	mvm->fwrt.ppag_ver = tbl_rev;
-	flags = &wifi_pkg->package.elements[1];
-
-	if (flags->type != ACPI_TYPE_INTEGER) {
-		ret = -EINVAL;
-		goto out_free;
-	}
-
-	mvm->fwrt.ppag_flags = flags->integer.value & IWL_PPAG_MASK;
-
-	if (!mvm->fwrt.ppag_flags) {
-		ret = 0;
-		goto out_free;
-	}
-
-	/*
-	 * read, verify gain values and save them into the PPAG table.
-	 * first sub-band (j=0) corresponds to Low-Band (2.4GHz), and the
-	 * following sub-bands to High-Band (5GHz).
-	 */
-	for (i = 0; i < IWL_NUM_CHAIN_LIMITS; i++) {
-		for (j = 0; j < num_sub_bands; j++) {
-			union acpi_object *ent;
-
-			ent = &wifi_pkg->package.elements[idx++];
-			if (ent->type != ACPI_TYPE_INTEGER) {
-				ret = -EINVAL;
-				goto out_free;
-			}
-
-			mvm->fwrt.ppag_chains[i].subbands[j] = ent->integer.value;
-
-			if ((j == 0 &&
-			     (mvm->fwrt.ppag_chains[i].subbands[j] > ACPI_PPAG_MAX_LB ||
-			      mvm->fwrt.ppag_chains[i].subbands[j] < ACPI_PPAG_MIN_LB)) ||
-			    (j != 0 &&
-			     (mvm->fwrt.ppag_chains[i].subbands[j] > ACPI_PPAG_MAX_HB ||
-			      mvm->fwrt.ppag_chains[i].subbands[j] < ACPI_PPAG_MIN_HB))) {
-				mvm->fwrt.ppag_flags = 0;
-				ret = -EINVAL;
-				goto out_free;
-			}
-		}
-	}
-
-	ret = 0;
-out_free:
-	kfree(data);
-	return ret;
-}
-
 int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 {
 	union iwl_ppag_table_cmd cmd;
-	u8 cmd_ver;
-	int i, j, ret, num_sub_bands, cmd_size;
-	s8 *gain;
+	int ret, cmd_size;
 
-	if (!fw_has_capa(&mvm->fw->ucode_capa, IWL_UCODE_TLV_CAPA_SET_PPAG)) {
-		IWL_DEBUG_RADIO(mvm,
-				"PPAG capability not supported by FW, command not sent.\n");
-		return 0;
-	}
-	if (!mvm->fwrt.ppag_flags) {
-		IWL_DEBUG_RADIO(mvm, "PPAG not enabled, command not sent.\n");
-		return 0;
-	}
-
-	/* The 'flags' field is the same in v1 and in v2 so we can just
-	 * use v1 to access it.
-	 */
-	cmd.v1.flags = cpu_to_le32(mvm->fwrt.ppag_flags);
-	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw,
-					WIDE_ID(PHY_OPS_GROUP, PER_PLATFORM_ANT_GAIN_CMD),
-					IWL_FW_CMD_VER_UNKNOWN);
-	if (cmd_ver == 1) {
-		num_sub_bands = IWL_NUM_SUB_BANDS_V1;
-		gain = cmd.v1.gain[0];
-		cmd_size = sizeof(cmd.v1);
-		if (mvm->fwrt.ppag_ver == 1 || mvm->fwrt.ppag_ver == 2) {
-			IWL_DEBUG_RADIO(mvm,
-					"PPAG table rev is %d but FW supports v1, sending truncated table\n",
-					mvm->fwrt.ppag_ver);
-			cmd.v1.flags &= cpu_to_le32(IWL_PPAG_ETSI_MASK);
-		}
-	} else if (cmd_ver == 2 || cmd_ver == 3) {
-		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
-		gain = cmd.v2.gain[0];
-		cmd_size = sizeof(cmd.v2);
-		if (mvm->fwrt.ppag_ver == 0) {
-			IWL_DEBUG_RADIO(mvm,
-					"PPAG table is v1 but FW supports v2, sending padded table\n");
-		} else if (cmd_ver == 2 && mvm->fwrt.ppag_ver == 2) {
-			IWL_DEBUG_RADIO(mvm,
-					"PPAG table is v3 but FW supports v2, sending partial bitmap.\n");
-			cmd.v1.flags &= cpu_to_le32(IWL_PPAG_ETSI_MASK);
-		}
-	} else {
-		IWL_DEBUG_RADIO(mvm, "Unsupported PPAG command version\n");
-		return 0;
-	}
+	ret = iwl_read_ppag_table(&mvm->fwrt, &cmd, &cmd_size);
+	if(ret < 0)
+		return ret;
 
-	for (i = 0; i < IWL_NUM_CHAIN_LIMITS; i++) {
-		for (j = 0; j < num_sub_bands; j++) {
-			gain[i * num_sub_bands + j] =
-				mvm->fwrt.ppag_chains[i].subbands[j];
-			IWL_DEBUG_RADIO(mvm,
-					"PPAG table: chain[%d] band[%d]: gain = %d\n",
-					i, j, gain[i * num_sub_bands + j]);
-		}
-	}
 	IWL_DEBUG_RADIO(mvm, "Sending PER_PLATFORM_ANT_GAIN_CMD\n");
 	ret = iwl_mvm_send_cmd_pdu(mvm, WIDE_ID(PHY_OPS_GROUP,
 						PER_PLATFORM_ANT_GAIN_CMD),
@@ -1178,40 +1029,11 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 	return ret;
 }
 
-static const struct dmi_system_id dmi_ppag_approved_list[] = {
-	{ .ident = "HP",
-	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
-		},
-	},
-	{ .ident = "SAMSUNG",
-	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD"),
-		},
-	},
-	{ .ident = "MSFT",
-	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
-		},
-	},
-	{ .ident = "ASUS",
-	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTek COMPUTER INC."),
-		},
-	},
-	{}
-};
-
 static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
 {
 	/* no need to read the table, done in INIT stage */
-	if (!dmi_check_system(dmi_ppag_approved_list)) {
-		IWL_DEBUG_RADIO(mvm,
-				"System vendor '%s' is not in the approved list, disabling PPAG.\n",
-				dmi_get_system_info(DMI_SYS_VENDOR));
-		mvm->fwrt.ppag_flags = 0;
+	if (!(iwl_acpi_is_ppag_approved(&mvm->fwrt)))
 		return 0;
-	}
 
 	return iwl_mvm_ppag_send_cmd(mvm);
 }
@@ -1438,7 +1260,7 @@ void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
 	int ret;
 
 	/* read PPAG table */
-	ret = iwl_mvm_get_ppag_table(mvm);
+	ret = iwl_acpi_get_ppag_table(&mvm->fwrt);
 	if (ret < 0) {
 		IWL_DEBUG_RADIO(mvm,
 				"PPAG BIOS table invalid or unavailable. (%d)\n",
-- 
2.35.1

