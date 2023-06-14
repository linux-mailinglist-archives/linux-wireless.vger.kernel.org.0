Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7A872F9A8
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 11:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244233AbjFNJpo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 05:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbjFNJov (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 05:44:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D591B270E
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 02:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686735837; x=1718271837;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GirVw8fsJFon6sEe+PEeE9t8n4kzUm9k/FMTvBrfuTs=;
  b=OAJlU+y6Yj9dsnEAr/mvy/8oAk8DWxU36g3zelFN8Nt1oRZSRxQbUHad
   v6pZ5im9624Xy8bk8xtDEkPw6w8GfZPa/tE/fVEGpUrocnyeZBdKn7HgJ
   qb6pATk69xlbB/oBVReRJIiGOC5KdMOvju15IcWD1uJPXaGNhgBgCWgxp
   G/U0qGLOOFunoznd7Q4vPIzM+HKHL2R9WiWyx8MczZIe6yEEmarXBcJsc
   hHNh2vFvj+55oCOEU5BYidaCTPGKTpoX+si407AnS0BYWAKnR2dSYxlqZ
   Pvduw2LpZxoCNpZyrTLLLuTO1pT7RcOwNPQpHnKGC5IxwTuOMLHSfiYrv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361049904"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361049904"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711989898"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="711989898"
Received: from basharil-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.203.45])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:29 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 16/20] wifi: iwlwifi: implement WPFC ACPI table loading
Date:   Wed, 14 Jun 2023 12:41:33 +0300
Message-Id: <20230614123447.035026ea3169.I3a1fc1fe644fefa0d818ee1926c5fc331d68e8a3@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230614094137.379897-1-gregory.greenman@intel.com>
References: <20230614094137.379897-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We skipped this in the past, but now we will need it for some
platforms. Implement loading the PHY filter configuration IDs
from the WPFC ACPI table. Note that the firmware must also be
aware of the right filter configuration IDs (they're just the
IDs of a filter configuration, not the actual configuration).

Remove the useless hardcoded zeroes while at it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  | 37 ++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  | 11 +++++
 .../wireless/intel/iwlwifi/fw/api/config.h    | 15 +++----
 .../wireless/intel/iwlwifi/mvm/constants.h    |  6 +--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   | 43 +++----------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 ++
 6 files changed, 65 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 6345ac454e80..dfe8357036eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1248,3 +1248,40 @@ bool iwl_acpi_is_ppag_approved(struct iwl_fw_runtime *fwrt)
 	return true;
 }
 IWL_EXPORT_SYMBOL(iwl_acpi_is_ppag_approved);
+
+void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
+			      struct iwl_phy_specific_cfg *filters)
+{
+	struct iwl_phy_specific_cfg tmp = {};
+	union acpi_object *wifi_pkg, *data;
+	int tbl_rev, i;
+
+	data = iwl_acpi_get_object(fwrt->dev, ACPI_WPFC_METHOD);
+	if (IS_ERR(data))
+		return;
+
+	/* try to read wtas table revision 1 or revision 0*/
+	wifi_pkg = iwl_acpi_get_wifi_pkg(fwrt->dev, data,
+					 ACPI_WPFC_WIFI_DATA_SIZE,
+					 &tbl_rev);
+	if (IS_ERR(wifi_pkg))
+		goto out_free;
+
+	if (tbl_rev != 0)
+		goto out_free;
+
+	BUILD_BUG_ON(ARRAY_SIZE(filters->filter_cfg_chains) != ACPI_WPFC_WIFI_DATA_SIZE);
+
+	for (i = 0; i < ARRAY_SIZE(filters->filter_cfg_chains); i++) {
+		if (wifi_pkg->package.elements[i].type != ACPI_TYPE_INTEGER)
+			return;
+		tmp.filter_cfg_chains[i] =
+			cpu_to_le32(wifi_pkg->package.elements[i].integer.value);
+	}
+
+	IWL_DEBUG_RADIO(fwrt, "Loaded WPFC filter config from ACPI\n");
+	*filters = tmp;
+out_free:
+	kfree(data);
+}
+IWL_EXPORT_SYMBOL(iwl_acpi_get_phy_filters);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
index e9c533cf7f93..c36c62d6414d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.h
@@ -11,6 +11,7 @@
 #include "fw/api/power.h"
 #include "fw/api/phy.h"
 #include "fw/api/nvm-reg.h"
+#include "fw/api/config.h"
 #include "fw/img.h"
 #include "iwl-trans.h"
 
@@ -23,6 +24,7 @@
 #define ACPI_ECKV_METHOD	"ECKV"
 #define ACPI_PPAG_METHOD	"PPAG"
 #define ACPI_WTAS_METHOD	"WTAS"
+#define ACPI_WPFC_METHOD	"WPFC"
 
 #define ACPI_WIFI_DOMAIN	(0x07)
 
@@ -54,6 +56,7 @@
 #define ACPI_EWRD_WIFI_DATA_SIZE_REV2	((ACPI_SAR_PROFILE_NUM - 1) * \
 					 ACPI_SAR_NUM_CHAINS_REV2 * \
 					 ACPI_SAR_NUM_SUB_BANDS_REV2 + 3)
+#define ACPI_WPFC_WIFI_DATA_SIZE	4 /* 4 filter config words */
 
 /* revision 0 and 1 are identical, except for the semantics in the FW */
 #define ACPI_GEO_NUM_BANDS_REV0		2
@@ -225,6 +228,9 @@ int iwl_read_ppag_table(struct iwl_fw_runtime *fwrt, union iwl_ppag_table_cmd *c
 
 bool iwl_acpi_is_ppag_approved(struct iwl_fw_runtime *fwrt);
 
+void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
+			      struct iwl_phy_specific_cfg *filters);
+
 #else /* CONFIG_ACPI */
 
 static inline void *iwl_acpi_get_dsm_object(struct device *dev, int rev,
@@ -314,6 +320,11 @@ static inline bool iwl_acpi_is_ppag_approved(struct iwl_fw_runtime *fwrt)
 	return false;
 }
 
+static inline void iwl_acpi_get_phy_filters(struct iwl_fw_runtime *fwrt,
+					    struct iwl_phy_specific_cfg *filters)
+{
+}
+
 #endif /* CONFIG_ACPI */
 
 #endif /* __iwl_fw_acpi__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/config.h b/drivers/net/wireless/intel/iwlwifi/fw/api/config.h
index 087354b3c308..4419631604b4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/config.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/config.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2019 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2019, 2023 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -67,17 +67,12 @@ enum iwl_calib_cfg {
  * Sent as part of the phy configuration command (v3) to configure specific FW
  * defined PHY filters that can be applied to each antenna.
  *
- * @filter_cfg_chain_a: filter config id for LMAC1 chain A
- * @filter_cfg_chain_b: filter config id for LMAC1 chain B
- * @filter_cfg_chain_c: filter config id for LMAC2 chain A
- * @filter_cfg_chain_d: filter config id for LMAC2 chain B
- * values: 0 - no filter; 0xffffffff - reserved; otherwise - filter id
+ * @filter_cfg_chains: filter config id for LMAC1 chain A, LMAC1 chain B,
+ *	LMAC2 chain A, LMAC2 chain B (in that order)
+ *	values: 0: no filter; 0xffffffff: reserved; otherwise: filter id
  */
 struct iwl_phy_specific_cfg {
-	__le32 filter_cfg_chain_a;
-	__le32 filter_cfg_chain_b;
-	__le32 filter_cfg_chain_c;
-	__le32 filter_cfg_chain_d;
+	__le32 filter_cfg_chains[4];
 } __packed; /* PHY_SPECIFIC_CONFIGURATION_API_VER_1*/
 
 /**
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
index c604f9f39b24..243eccc68cb0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/constants.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
- * Copyright (C) 2013-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2013-2014, 2018-2023 Intel Corporation
  * Copyright (C) 2015 Intel Deutschland GmbH
  */
 #ifndef __MVM_CONSTANTS_H
@@ -109,10 +109,6 @@
 #define IWL_MVM_USE_TWT				true
 #define IWL_MVM_AMPDU_CONSEC_DROPS_DELBA	20
 #define IWL_MVM_USE_NSSN_SYNC			0
-#define IWL_MVM_PHY_FILTER_CHAIN_A		0
-#define IWL_MVM_PHY_FILTER_CHAIN_B		0
-#define IWL_MVM_PHY_FILTER_CHAIN_C		0
-#define IWL_MVM_PHY_FILTER_CHAIN_D		0
 #define IWL_MVM_FTM_INITIATOR_ENABLE_SMOOTH     false
 #define IWL_MVM_FTM_INITIATOR_SMOOTH_ALPHA      40
 /*  20016 pSec is 6 meter RTT, meaning 3 meter range */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 8d8277d94f56..77cdfb4a5ba3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -478,40 +478,13 @@ static int iwl_mvm_load_ucode_wait_alive(struct iwl_mvm *mvm,
 	return 0;
 }
 
-#ifdef CONFIG_ACPI
 static void iwl_mvm_phy_filter_init(struct iwl_mvm *mvm,
 				    struct iwl_phy_specific_cfg *phy_filters)
 {
-	/*
-	 * TODO: read specific phy config from BIOS
-	 * ACPI table for this feature has not been defined yet,
-	 * so for now we use hardcoded values.
-	 */
-
-	if (IWL_MVM_PHY_FILTER_CHAIN_A) {
-		phy_filters->filter_cfg_chain_a =
-			cpu_to_le32(IWL_MVM_PHY_FILTER_CHAIN_A);
-	}
-	if (IWL_MVM_PHY_FILTER_CHAIN_B) {
-		phy_filters->filter_cfg_chain_b =
-			cpu_to_le32(IWL_MVM_PHY_FILTER_CHAIN_B);
-	}
-	if (IWL_MVM_PHY_FILTER_CHAIN_C) {
-		phy_filters->filter_cfg_chain_c =
-			cpu_to_le32(IWL_MVM_PHY_FILTER_CHAIN_C);
-	}
-	if (IWL_MVM_PHY_FILTER_CHAIN_D) {
-		phy_filters->filter_cfg_chain_d =
-			cpu_to_le32(IWL_MVM_PHY_FILTER_CHAIN_D);
-	}
-}
-#else /* CONFIG_ACPI */
-
-static void iwl_mvm_phy_filter_init(struct iwl_mvm *mvm,
-				    struct iwl_phy_specific_cfg *phy_filters)
-{
-}
+#ifdef CONFIG_ACPI
+	*phy_filters = mvm->phy_filters;
 #endif /* CONFIG_ACPI */
+}
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_EFI)
 static int iwl_mvm_sgom_init(struct iwl_mvm *mvm)
@@ -560,7 +533,6 @@ static int iwl_send_phy_cfg_cmd(struct iwl_mvm *mvm)
 	u32 cmd_id = PHY_CONFIGURATION_CMD;
 	struct iwl_phy_cfg_cmd_v3 phy_cfg_cmd;
 	enum iwl_ucode_type ucode_type = mvm->fwrt.cur_fw_img;
-	struct iwl_phy_specific_cfg phy_filters = {};
 	u8 cmd_ver;
 	size_t cmd_size;
 
@@ -591,11 +563,8 @@ static int iwl_send_phy_cfg_cmd(struct iwl_mvm *mvm)
 
 	cmd_ver = iwl_fw_lookup_cmd_ver(mvm->fw, cmd_id,
 					IWL_FW_CMD_VER_UNKNOWN);
-	if (cmd_ver == 3) {
-		iwl_mvm_phy_filter_init(mvm, &phy_filters);
-		memcpy(&phy_cfg_cmd.phy_specific_cfg, &phy_filters,
-		       sizeof(struct iwl_phy_specific_cfg));
-	}
+	if (cmd_ver >= 3)
+		iwl_mvm_phy_filter_init(mvm, &phy_cfg_cmd.phy_specific_cfg);
 
 	IWL_DEBUG_INFO(mvm, "Sending Phy CFG command: 0x%x\n",
 		       phy_cfg_cmd.phy_cfg);
@@ -1380,6 +1349,8 @@ void iwl_mvm_get_acpi_tables(struct iwl_mvm *mvm)
 				/* we don't fail if the table is not available */
 		}
 	}
+
+	iwl_acpi_get_phy_filters(&mvm->fwrt, &mvm->phy_filters);
 }
 #else /* CONFIG_ACPI */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 97ec100103b4..3be67ec5cd4b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1182,6 +1182,10 @@ struct iwl_mvm {
 	__le16 cur_aid;
 	u8 cur_bssid[ETH_ALEN];
 
+#ifdef CONFIG_ACPI
+	struct iwl_phy_specific_cfg phy_filters;
+#endif
+
 	unsigned long last_6ghz_passive_scan_jiffies;
 	unsigned long last_reset_or_resume_time_jiffies;
 
-- 
2.38.1

