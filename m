Return-Path: <linux-wireless+bounces-2875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C3C8438ED
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 09:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84A51F23BD7
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jan 2024 08:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE5569E0D;
	Wed, 31 Jan 2024 08:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oGtWHMhY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D4667E98
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jan 2024 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706689522; cv=none; b=dvZCJ5Boxmkya+Qi4kxZls0yxe2RDLUljJhZ3268pcB1+dfJS9uY8wKMF+YEWXvIDVuf+zfRnnkK+F1fPfn4+HA0WDgb659VKIRBTtUogeKqfDvauBv3jLYGnUHn1wn2ayM8Jbe4yWUmntVNB0NbSfD9fqRELeJyJ7RcDeYWE0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706689522; c=relaxed/simple;
	bh=ZDkkj/ScVuGymKEkYNSYq3xWv+dH6D9v3/XObwytUdE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pZD5pS6yWnSQ+Ixt6s/ZY9Yogov0v8vHsC5MoFfpEWA177xFjk2gSxzs69qYGEOz0fdocHINOWpjpACw+rRBI5J3a+uIyW/51MM4YCtpugGJO6mvWpGa1KnC3CPENNq18V+0K7nz+E/6Lp58FnjuO5g/mTe2iZruuXj9sBWaPpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oGtWHMhY; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706689520; x=1738225520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZDkkj/ScVuGymKEkYNSYq3xWv+dH6D9v3/XObwytUdE=;
  b=oGtWHMhY6tMFbKzU9ayiDxsMgDtc6lYUkwfW1XwHjzf/JG6iEfH82ML0
   Ov6fGfx/uVWoMP3uDskZ023ktlvMVppACdg9A6wr7D0Wg2iWaMsN8zeeZ
   7xVmqh/XYDuk3oVpZUf/tklDGkZC4dz+s6C8YaCoRGr5KS/zI7yS9Jx0F
   g1VW+nLFKzPOpteHrL6sJneI682UmH8iipepXPgVU5Ex//oCFm7+xqwuZ
   YQzQ2cfPrkJf5SUDGCH964R8Ok1QRsGOQ3E/xcrI2IDQuEv/zxNrK+j8Y
   ylHninfTJM2AqmM0AW9LJSSPXlak9dAhwOXUyKXvnaZGvxm6s2OD/yOpv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="407249952"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="407249952"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="3968920"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 00:25:17 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/14] wifi: iwlwifi: prepare for reading PPAG table from UEFI
Date: Wed, 31 Jan 2024 10:24:41 +0200
Message-Id: <20240131091413.25623670b422.I8132af7517e4faf0ea8cbeb2efe9651edd319b98@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131082447.1372353-1-miriam.rachel.korenblit@intel.com>
References: <20240131082447.1372353-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

As PPAG table is going to be read from UEFI, there are some
cleanups required:
Move functions/definitions that are common to both UEFI and ACPI to
regulatory.h/c.
In addition, rename the functions/macros names so it will be clear which
one is ACPI specific, and which is common for ACPI and UEFI.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 172 +-----------------
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  35 ----
 .../wireless/intel/iwlwifi/fw/regulatory.c    | 161 ++++++++++++++++
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  20 ++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   2 +-
 5 files changed, 187 insertions(+), 203 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index d2689d93da0c..9b0ecfc087ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2019-2023 Intel Corporation
  */
 #include <linux/uuid.h>
-#include <linux/dmi.h>
 #include "iwl-drv.h"
 #include "iwl-debug.h"
 #include "acpi.h"
@@ -20,63 +19,6 @@ const guid_t iwl_rfi_guid = GUID_INIT(0x7266172C, 0x220B, 0x4B29,
 				      0xDD, 0x26, 0xB5, 0xFD);
 IWL_EXPORT_SYMBOL(iwl_rfi_guid);
 
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
-			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-		},
-	},
-	{ .ident = "GOOGLE-HP",
-	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
-			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
-		},
-	},
-	{ .ident = "GOOGLE-ASUS",
-	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
-			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTek COMPUTER INC."),
-		},
-	},
-	{ .ident = "GOOGLE-SAMSUNG",
-	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
-			DMI_MATCH(DMI_BOARD_VENDOR, "SAMSUNG ELECTRONICS CO., LTD"),
-		},
-	},
-	{ .ident = "DELL",
-	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
-		},
-	},
-	{ .ident = "DELL",
-	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
-		},
-	},
-	{ .ident = "RAZER",
-	  .matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "Razer"),
-		},
-	},
-	{}
-};
-
 static int iwl_acpi_get_handle(struct device *dev, acpi_string method,
 			       acpi_handle *ret_handle)
 {
@@ -1002,7 +944,7 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 		goto out_free;
 	}
 
-	fwrt->ppag_flags = flags->integer.value & ACPI_PPAG_MASK;
+	fwrt->ppag_flags = flags->integer.value & IWL_PPAG_ETSI_CHINA_MASK;
 	cmd_ver = iwl_fw_lookup_cmd_ver(fwrt->fw,
 					WIDE_ID(PHY_OPS_GROUP,
 						PER_PLATFORM_ANT_GAIN_CMD),
@@ -1036,11 +978,11 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 			if (cmd_ver >= 4)
 				continue;
 			if ((j == 0 &&
-				(fwrt->ppag_chains[i].subbands[j] > ACPI_PPAG_MAX_LB ||
-				 fwrt->ppag_chains[i].subbands[j] < ACPI_PPAG_MIN_LB)) ||
+				(fwrt->ppag_chains[i].subbands[j] > IWL_PPAG_MAX_LB ||
+				 fwrt->ppag_chains[i].subbands[j] < IWL_PPAG_MIN_LB)) ||
 				(j != 0 &&
-				(fwrt->ppag_chains[i].subbands[j] > ACPI_PPAG_MAX_HB ||
-				fwrt->ppag_chains[i].subbands[j] < ACPI_PPAG_MIN_HB))) {
+				(fwrt->ppag_chains[i].subbands[j] > IWL_PPAG_MAX_HB ||
+				fwrt->ppag_chains[i].subbands[j] < IWL_PPAG_MIN_HB))) {
 					ret = -EINVAL;
 					goto out_free;
 				}
@@ -1056,110 +998,6 @@ int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 }
 IWL_EXPORT_SYMBOL(iwl_acpi_get_ppag_table);
 
-int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
-			union iwl_ppag_table_cmd *cmd,
-			int *cmd_size)
-{
-        u8 cmd_ver;
-        int i, j, num_sub_bands;
-        s8 *gain;
-
-	/* many firmware images for JF lie about this */
-	if (CSR_HW_RFID_TYPE(fwrt->trans->hw_rf_id) ==
-	    CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_JF))
-		return -EOPNOTSUPP;
-
-        if (!fw_has_capa(&fwrt->fw->ucode_capa, IWL_UCODE_TLV_CAPA_SET_PPAG)) {
-                IWL_DEBUG_RADIO(fwrt,
-                                "PPAG capability not supported by FW, command not sent.\n");
-                return -EINVAL;
-	}
-
-	cmd_ver = iwl_fw_lookup_cmd_ver(fwrt->fw,
-					WIDE_ID(PHY_OPS_GROUP,
-						PER_PLATFORM_ANT_GAIN_CMD),
-					IWL_FW_CMD_VER_UNKNOWN);
-	if (!fwrt->ppag_table_valid || (cmd_ver <= 3 && !fwrt->ppag_flags)) {
-		IWL_DEBUG_RADIO(fwrt, "PPAG not enabled, command not sent.\n");
-		return -EINVAL;
-	}
-
-        /* The 'flags' field is the same in v1 and in v2 so we can just
-         * use v1 to access it.
-         */
-        cmd->v1.flags = cpu_to_le32(fwrt->ppag_flags);
-
-	IWL_DEBUG_RADIO(fwrt, "PPAG cmd ver is %d\n", cmd_ver);
-	if (cmd_ver == 1) {
-                num_sub_bands = IWL_NUM_SUB_BANDS_V1;
-                gain = cmd->v1.gain[0];
-                *cmd_size = sizeof(cmd->v1);
-                if (fwrt->ppag_ver == 1 || fwrt->ppag_ver == 2) {
-			/* in this case FW supports revision 0 */
-                        IWL_DEBUG_RADIO(fwrt,
-					"PPAG table rev is %d, send truncated table\n",
-                                        fwrt->ppag_ver);
-		}
-	} else if (cmd_ver >= 2 && cmd_ver <= 4) {
-                num_sub_bands = IWL_NUM_SUB_BANDS_V2;
-                gain = cmd->v2.gain[0];
-                *cmd_size = sizeof(cmd->v2);
-                if (fwrt->ppag_ver == 0) {
-			/* in this case FW supports revisions 1 or 2 */
-                        IWL_DEBUG_RADIO(fwrt,
-					"PPAG table rev is 0, send padded table\n");
-                }
-        } else {
-                IWL_DEBUG_RADIO(fwrt, "Unsupported PPAG command version\n");
-                return -EINVAL;
-        }
-
-	/* ppag mode */
-	IWL_DEBUG_RADIO(fwrt,
-			"PPAG MODE bits were read from bios: %d\n",
-			cmd->v1.flags);
-	if ((cmd_ver == 1 && !fw_has_capa(&fwrt->fw->ucode_capa,
-					  IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT)) ||
-	    (cmd_ver == 2 && fwrt->ppag_ver == 2)) {
-		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_ETSI_MASK);
-		IWL_DEBUG_RADIO(fwrt, "masking ppag China bit\n");
-	} else {
-		IWL_DEBUG_RADIO(fwrt, "isn't masking ppag China bit\n");
-	}
-
-	IWL_DEBUG_RADIO(fwrt,
-			"PPAG MODE bits going to be sent: %d\n",
-			cmd->v1.flags);
-
-	for (i = 0; i < IWL_NUM_CHAIN_LIMITS; i++) {
-                for (j = 0; j < num_sub_bands; j++) {
-                        gain[i * num_sub_bands + j] =
-                                fwrt->ppag_chains[i].subbands[j];
-                        IWL_DEBUG_RADIO(fwrt,
-                                        "PPAG table: chain[%d] band[%d]: gain = %d\n",
-                                        i, j, gain[i * num_sub_bands + j]);
-                }
-        }
-
-	return 0;
-}
-IWL_EXPORT_SYMBOL(iwl_fill_ppag_table);
-
-bool iwl_acpi_is_ppag_approved(struct iwl_fw_runtime *fwrt)
-{
-
-	if (!dmi_check_system(dmi_ppag_approved_list)) {
-		IWL_DEBUG_RADIO(fwrt,
-			"System vendor '%s' is not in the approved list, disabling PPAG.\n",
-			dmi_get_system_info(DMI_SYS_VENDOR));
-			fwrt->ppag_flags = 0;
-			return false;
-	}
-
-	return true;
-}
-IWL_EXPORT_SYMBOL(iwl_acpi_is_ppag_approved);
-
 void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
 			      struct iwl_phy_specific_cfg *filters)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index ef927d74bc7c..ca3587e9f856 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -94,29 +94,12 @@
 #define ACPI_PPAG_WIFI_DATA_SIZE_V2	((IWL_NUM_CHAIN_LIMITS * \
 					  IWL_NUM_SUB_BANDS_V2) + 2)
 
-/* PPAG gain value bounds in 1/8 dBm */
-#define ACPI_PPAG_MIN_LB -16
-#define ACPI_PPAG_MAX_LB 24
-#define ACPI_PPAG_MIN_HB -16
-#define ACPI_PPAG_MAX_HB 40
-#define ACPI_PPAG_MASK 3
-#define IWL_PPAG_ETSI_MASK BIT(0)
-
 #define IWL_SAR_ENABLE_MSK		BIT(0)
 #define IWL_REDUCE_POWER_FLAGS_POS	1
 
 /* The Inidcator whether UEFI WIFI GUID tables are locked is read from ACPI */
 #define UEFI_WIFI_GUID_UNLOCKED		0
 
-/*
- * The profile for revision 2 is a superset of revision 1, which is in
- * turn a superset of revision 0.  So we can store all revisions
- * inside revision 2, which is what we represent here.
- */
-struct iwl_ppag_chain {
-	s8 subbands[ACPI_SAR_NUM_SUB_BANDS_REV2];
-};
-
 enum iwl_dsm_funcs_rev_0 {
 	DSM_FUNC_QUERY = 0,
 	DSM_FUNC_DISABLE_SRD = 1,
@@ -207,12 +190,6 @@ __le32 iwl_acpi_get_lari_config_bitmap(struct iwl_fw_runtime *fwrt);
 
 int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt);
 
-int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
-			union iwl_ppag_table_cmd *cmd,
-			int *cmd_size);
-
-bool iwl_acpi_is_ppag_approved(struct iwl_fw_runtime *fwrt);
-
 void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
 			      struct iwl_phy_specific_cfg *filters);
 
@@ -284,18 +261,6 @@ static inline int iwl_acpi_get_ppag_table(struct iwl_fw_runtime *fwrt)
 	return -ENOENT;
 }
 
-static inline int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
-				      union iwl_ppag_table_cmd *cmd,
-				      int *cmd_size)
-{
-	return -ENOENT;
-}
-
-static inline bool iwl_acpi_is_ppag_approved(struct iwl_fw_runtime *fwrt)
-{
-	return false;
-}
-
 static inline void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
 					    struct iwl_phy_specific_cfg *filters)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
index 862d8b8b0fc9..2393c8a8e288 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2023 Intel Corporation
  */
+#include <linux/dmi.h>
 #include "iwl-drv.h"
 #include "iwl-debug.h"
 #include "regulatory.h"
@@ -24,6 +25,63 @@ IWL_BIOS_TABLE_LOADER(wrds);
 IWL_BIOS_TABLE_LOADER(ewrd);
 IWL_BIOS_TABLE_LOADER(wgds);
 
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
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+		},
+	},
+	{ .ident = "GOOGLE-HP",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+		},
+	},
+	{ .ident = "GOOGLE-ASUS",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTek COMPUTER INC."),
+		},
+	},
+	{ .ident = "GOOGLE-SAMSUNG",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+			DMI_MATCH(DMI_BOARD_VENDOR, "SAMSUNG ELECTRONICS CO., LTD"),
+		},
+	},
+	{ .ident = "DELL",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		},
+	},
+	{ .ident = "DELL",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+		},
+	},
+	{ .ident = "RAZER",
+	  .matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Razer"),
+		},
+	},
+	{}
+};
+
 bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
 {
 	/*
@@ -147,3 +205,106 @@ int iwl_sar_fill_profile(struct iwl_fw_runtime *fwrt,
 	return ret;
 }
 IWL_EXPORT_SYMBOL(iwl_sar_fill_profile);
+
+int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
+			union iwl_ppag_table_cmd *cmd, int *cmd_size)
+{
+	u8 cmd_ver;
+	int i, j, num_sub_bands;
+	s8 *gain;
+
+	/* many firmware images for JF lie about this */
+	if (CSR_HW_RFID_TYPE(fwrt->trans->hw_rf_id) ==
+	    CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_JF))
+		return -EOPNOTSUPP;
+
+	if (!fw_has_capa(&fwrt->fw->ucode_capa, IWL_UCODE_TLV_CAPA_SET_PPAG)) {
+		IWL_DEBUG_RADIO(fwrt,
+				"PPAG capability not supported by FW, command not sent.\n");
+		return -EINVAL;
+	}
+
+	cmd_ver = iwl_fw_lookup_cmd_ver(fwrt->fw,
+					WIDE_ID(PHY_OPS_GROUP,
+						PER_PLATFORM_ANT_GAIN_CMD),
+					IWL_FW_CMD_VER_UNKNOWN);
+	if (!fwrt->ppag_table_valid || (cmd_ver <= 3 && !fwrt->ppag_flags)) {
+		IWL_DEBUG_RADIO(fwrt, "PPAG not enabled, command not sent.\n");
+		return -EINVAL;
+	}
+
+	/* The 'flags' field is the same in v1 and in v2 so we can just
+	 * use v1 to access it.
+	 */
+	cmd->v1.flags = cpu_to_le32(fwrt->ppag_flags);
+
+	IWL_DEBUG_RADIO(fwrt, "PPAG cmd ver is %d\n", cmd_ver);
+	if (cmd_ver == 1) {
+		num_sub_bands = IWL_NUM_SUB_BANDS_V1;
+		gain = cmd->v1.gain[0];
+		*cmd_size = sizeof(cmd->v1);
+		if (fwrt->ppag_ver == 1 || fwrt->ppag_ver == 2) {
+			/* in this case FW supports revision 0 */
+			IWL_DEBUG_RADIO(fwrt,
+					"PPAG table rev is %d, send truncated table\n",
+					fwrt->ppag_ver);
+		}
+	} else if (cmd_ver >= 2 && cmd_ver <= 4) {
+		num_sub_bands = IWL_NUM_SUB_BANDS_V2;
+		gain = cmd->v2.gain[0];
+		*cmd_size = sizeof(cmd->v2);
+		if (fwrt->ppag_ver == 0) {
+			/* in this case FW supports revisions 1 or 2 */
+			IWL_DEBUG_RADIO(fwrt,
+					"PPAG table rev is 0, send padded table\n");
+		}
+	} else {
+		IWL_DEBUG_RADIO(fwrt, "Unsupported PPAG command version\n");
+		return -EINVAL;
+	}
+
+	/* ppag mode */
+	IWL_DEBUG_RADIO(fwrt,
+			"PPAG MODE bits were read from bios: %d\n",
+			cmd->v1.flags);
+	if ((cmd_ver == 1 &&
+	     !fw_has_capa(&fwrt->fw->ucode_capa,
+			  IWL_UCODE_TLV_CAPA_PPAG_CHINA_BIOS_SUPPORT)) ||
+	    (cmd_ver == 2 && fwrt->ppag_ver == 2)) {
+		cmd->v1.flags &= cpu_to_le32(IWL_PPAG_ETSI_MASK);
+		IWL_DEBUG_RADIO(fwrt, "masking ppag China bit\n");
+	} else {
+		IWL_DEBUG_RADIO(fwrt, "isn't masking ppag China bit\n");
+	}
+
+	IWL_DEBUG_RADIO(fwrt,
+			"PPAG MODE bits going to be sent: %d\n",
+			cmd->v1.flags);
+
+	for (i = 0; i < IWL_NUM_CHAIN_LIMITS; i++) {
+		for (j = 0; j < num_sub_bands; j++) {
+			gain[i * num_sub_bands + j] =
+				fwrt->ppag_chains[i].subbands[j];
+			IWL_DEBUG_RADIO(fwrt,
+					"PPAG table: chain[%d] band[%d]: gain = %d\n",
+					i, j, gain[i * num_sub_bands + j]);
+		}
+	}
+
+	return 0;
+}
+IWL_EXPORT_SYMBOL(iwl_fill_ppag_table);
+
+bool iwl_is_ppag_approved(struct iwl_fw_runtime *fwrt)
+{
+	if (!dmi_check_system(dmi_ppag_approved_list)) {
+		IWL_DEBUG_RADIO(fwrt,
+				"System vendor '%s' is not in the approved list, disabling PPAG.\n",
+				dmi_get_system_info(DMI_SYS_VENDOR));
+				fwrt->ppag_flags = 0;
+				return false;
+	}
+
+	return true;
+}
+IWL_EXPORT_SYMBOL(iwl_is_ppag_approved);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
index 73c6122e7626..63f650cb6517 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/regulatory.h
@@ -31,6 +31,15 @@
 
 #define IWL_SAR_ENABLE_MSK		BIT(0)
 
+/* PPAG gain value bounds in 1/8 dBm */
+#define IWL_PPAG_MIN_LB	-16
+#define IWL_PPAG_MAX_LB 24
+#define IWL_PPAG_MIN_HB -16
+#define IWL_PPAG_MAX_HB 40
+
+#define IWL_PPAG_ETSI_CHINA_MASK	3
+#define IWL_PPAG_ETSI_MASK		BIT(0)
+
 /*
  * The profile for revision 2 is a superset of revision 1, which is in
  * turn a superset of revision 0.  So we can store all revisions
@@ -75,6 +84,11 @@ struct iwl_geo_profile {
 	struct iwl_geo_profile_band bands[BIOS_GEO_MAX_NUM_BANDS];
 };
 
+/* Same thing as with SAR, all revisions fit in revision 2 */
+struct iwl_ppag_chain {
+	s8 subbands[BIOS_SAR_MAX_SUB_BANDS_NUM];
+};
+
 struct iwl_fw_runtime;
 
 bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt);
@@ -87,6 +101,12 @@ int iwl_sar_fill_profile(struct iwl_fw_runtime *fwrt,
 			 __le16 *per_chain, u32 n_tables, u32 n_subbands,
 			 int prof_a, int prof_b);
 
+int iwl_fill_ppag_table(struct iwl_fw_runtime *fwrt,
+			union iwl_ppag_table_cmd *cmd,
+			int *cmd_size);
+
+bool iwl_is_ppag_approved(struct iwl_fw_runtime *fwrt);
+
 int iwl_bios_get_wrds_table(struct iwl_fw_runtime *fwrt);
 
 int iwl_bios_get_ewrd_table(struct iwl_fw_runtime *fwrt);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index d52fc3119972..1d759fe7d12d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1104,7 +1104,7 @@ int iwl_mvm_ppag_send_cmd(struct iwl_mvm *mvm)
 static int iwl_mvm_ppag_init(struct iwl_mvm *mvm)
 {
 	/* no need to read the table, done in INIT stage */
-	if (!(iwl_acpi_is_ppag_approved(&mvm->fwrt)))
+	if (!(iwl_is_ppag_approved(&mvm->fwrt)))
 		return 0;
 
 	return iwl_mvm_ppag_send_cmd(mvm);
-- 
2.34.1


