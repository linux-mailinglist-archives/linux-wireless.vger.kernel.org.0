Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBB673805C
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjFUKOg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 06:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjFUKOB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 06:14:01 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9EF1FCF
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 03:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687342431; x=1718878431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ciwSOQkB46jdVyzfOw/ir9boO0UlQBZMCMsUg7P6nJg=;
  b=Zdgj/ZISpHh5j6i1qzVVU32E0PXcQFXwLd+vLDKGc8c6A1UXA0kBEnPo
   B/xogm8Q9YTWmYi7Xr1GZdRDA5SV5N/CRXFlnsfe5/9Nf6NPWJSmGMxVl
   BeCo5iWyQLHouNUB07DBGDvqWaA4s8bvd4ow6WjGS1iMh5VQ0tFhSVtgU
   rj4MZ2isd7b1KUD5GWuKjxn2lZegYnDjfnpnrACZyK1fdWF3r3W82Z9+H
   qdqGn5WGsELHiTJqoJ77ROsGju4EN7DzIwoxS1u0UXGBvj01KOu2aTZIy
   wPIyTGGlYbtMvJIjNM9IdBLtbmZWx2XagwMalRGd8Me3mWSdl0MCLLrpF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446506459"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="446506459"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:13:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="664599242"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="664599242"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.65])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:13:10 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/18] wifi: iwlwifi: unify Bz/Gl device configurations
Date:   Wed, 21 Jun 2023 13:12:15 +0300
Message-Id: <20230621130443.1dc121ba338f.I07d651516eb82cbaded4724ef30558a50f2fa866@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230621101222.218083-1-gregory.greenman@intel.com>
References: <20230621101222.218083-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

All the configurations for the various Bz/Gl devices
are basically identical, except for Gl A-step and the
firmware filename prefixes.

Add some infrastructure to auto-generate the firmware
filename prefix based on the detected MAC step and
RF name/step, and remove all the unneeded configs.

This reduces the size of the iwlwifi module by ~9k:
 517582	  27111	    560	 545253	  851e5	drivers/net/wireless/intel/iwlwifi/iwlwifi.ko
 526885	  27083	    560	 554528	  87620	drivers/net/wireless/intel/iwlwifi/iwlwifi.ko

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   | 128 +-----------------
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h  |  18 +--
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  24 +---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  69 +++++++++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h  |   6 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  92 ++-----------
 7 files changed, 102 insertions(+), 239 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
index eb737e906df2..fe6166d364cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/bz.c
@@ -191,112 +191,8 @@ const struct iwl_cfg_trans_params iwl_bz_trans_cfg = {
 
 const char iwl_bz_name[] = "Intel(R) TBD Bz device";
 
-const struct iwl_cfg iwl_cfg_bz_a0_hr_a0 = {
-	.fw_name_pre = IWL_BZ_A_HR_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_a0_hr_b0 = {
-	.fw_name_pre = IWL_BZ_A_HR_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_a0_gf_a0 = {
-	.fw_name_pre = IWL_BZ_A_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_a0_gf4_a0 = {
-	.fw_name_pre = IWL_BZ_A_GF4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_b0_gf_a0 = {
-	.fw_name_pre = IWL_BZ_B_GF_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_b0_gf4_a0 = {
-	.fw_name_pre = IWL_BZ_B_GF4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_a0_mr_a0 = {
-	.fw_name_pre = IWL_BZ_A_MR_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_a0_fm_a0 = {
-	.fw_name_pre = IWL_BZ_A_FM_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_a0_fm4_a0 = {
-	.fw_name_pre = IWL_BZ_A_FM4_A_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_a0_fm_b0 = {
-	.fw_name_pre = IWL_BZ_A_FM_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_a0_fm_c0 = {
-	.fw_name_pre = IWL_BZ_A_FM_C_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_a0_fm4_b0 = {
-	.fw_name_pre = IWL_BZ_A_FM4_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_b0_fm_b0 = {
-	.fw_name_pre = IWL_BZ_B_FM_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_b0_fm4_b0 = {
-	.fw_name_pre = IWL_BZ_B_FM4_B_FW_PRE,
+const struct iwl_cfg iwl_cfg_bz = {
+	.fw_name_mac = "bz",
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
 	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
@@ -311,24 +207,8 @@ const struct iwl_cfg iwl_cfg_gl_a0_fm_a0 = {
 	.num_rbds = IWL_NUM_RBDS_BZ_HE,
 };
 
-const struct iwl_cfg iwl_cfg_gl_b0_fm_b0 = {
-	.fw_name_pre = IWL_GL_B_FM_B_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_gl_c0_fm_c0 = {
-	.fw_name_pre = IWL_GL_C_FM_C_FW_PRE,
-	.uhb_supported = true,
-	IWL_DEVICE_BZ,
-	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
-	.num_rbds = IWL_NUM_RBDS_BZ_HE,
-};
-
-const struct iwl_cfg iwl_cfg_bz_z0_gf_a0 = {
-	.fw_name_pre = IWL_BZ_Z_GF_A_FW_PRE,
+const struct iwl_cfg iwl_cfg_gl = {
+	.fw_name_mac = "gl",
 	.uhb_supported = true,
 	IWL_DEVICE_BZ,
 	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
index 4e10baa01738..32fba08b7db1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/pnvm.h
@@ -1,13 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
-/******************************************************************************
- *
- * Copyright(c) 2020-2022 Intel Corporation
- *
- *****************************************************************************/
-
+/*
+ * Copyright(c) 2020-2023 Intel Corporation
+ */
 #ifndef __IWL_PNVM_H__
 #define __IWL_PNVM_H__
 
+#include "iwl-drv.h"
 #include "fw/notif-wait.h"
 
 #define MVM_UCODE_PNVM_TIMEOUT	(HZ / 4)
@@ -22,16 +20,20 @@ static inline
 void iwl_pnvm_get_fs_name(struct iwl_trans *trans,
 			  u8 *pnvm_name, size_t max_len)
 {
+	char _fw_name_pre[FW_NAME_PRE_BUFSIZE];
+	const char *fw_name_pre;
 	int pre_len;
 
+	fw_name_pre = iwl_drv_get_fwname_pre(trans, _fw_name_pre);
+
 	/*
 	 * The prefix unfortunately includes a hyphen at the end, so
 	 * don't add the dot here...
 	 */
-	snprintf(pnvm_name, max_len, "%spnvm", trans->cfg->fw_name_pre);
+	snprintf(pnvm_name, max_len, "%spnvm", fw_name_pre);
 
 	/* ...but replace the hyphen with the dot here. */
-	pre_len = strlen(trans->cfg->fw_name_pre);
+	pre_len = strlen(fw_name_pre);
 	if (pre_len < max_len && pre_len > 0)
 		pnvm_name[pre_len - 1] = '.';
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index a18cbe75646f..47e164beda29 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -310,6 +310,8 @@ struct iwl_fw_mon_regs {
  * @fw_name_pre: Firmware filename prefix. The api version and extension
  *	(.ucode) will be added to filename before loading from disk. The
  *	filename is constructed as fw_name_pre<api>.ucode.
+ * @fw_name_mac: MAC name for this config, the remaining pieces of the
+ *	name will be generated dynamically
  * @ucode_api_max: Highest version of uCode API supported by driver.
  * @ucode_api_min: Lowest version of uCode API supported by driver.
  * @max_inst_size: The maximal length of the fw inst section (only DVM)
@@ -363,6 +365,7 @@ struct iwl_cfg {
 	/* params specific to an individual device within a device family */
 	const char *name;
 	const char *fw_name_pre;
+	const char *fw_name_mac;
 	/* params likely to change within a device family */
 	const struct iwl_ht_params *ht_params;
 	const struct iwl_eeprom_params *eeprom_params;
@@ -643,24 +646,11 @@ extern const struct iwl_cfg iwl_cfg_ma_b0_fm_a0;
 extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0;
 extern const struct iwl_cfg iwl_cfg_so_a0_ms_a0;
 extern const struct iwl_cfg iwl_cfg_quz_a0_hr_b0;
-extern const struct iwl_cfg iwl_cfg_bz_a0_hr_a0;
-extern const struct iwl_cfg iwl_cfg_bz_a0_hr_b0;
-extern const struct iwl_cfg iwl_cfg_bz_a0_gf_a0;
-extern const struct iwl_cfg iwl_cfg_bz_a0_gf4_a0;
-extern const struct iwl_cfg iwl_cfg_bz_b0_gf_a0;
-extern const struct iwl_cfg iwl_cfg_bz_b0_gf4_a0;
-extern const struct iwl_cfg iwl_cfg_bz_a0_mr_a0;
-extern const struct iwl_cfg iwl_cfg_bz_a0_fm_a0;
-extern const struct iwl_cfg iwl_cfg_bz_a0_fm4_a0;
-extern const struct iwl_cfg iwl_cfg_bz_a0_fm_b0;
-extern const struct iwl_cfg iwl_cfg_bz_a0_fm_c0;
-extern const struct iwl_cfg iwl_cfg_bz_a0_fm4_b0;
-extern const struct iwl_cfg iwl_cfg_bz_b0_fm_b0;
-extern const struct iwl_cfg iwl_cfg_bz_b0_fm4_b0;
+
+extern const struct iwl_cfg iwl_cfg_bz;
 extern const struct iwl_cfg iwl_cfg_gl_a0_fm_a0;
-extern const struct iwl_cfg iwl_cfg_gl_b0_fm_b0;
-extern const struct iwl_cfg iwl_cfg_gl_c0_fm_c0;
-extern const struct iwl_cfg iwl_cfg_bz_z0_gf_a0;
+extern const struct iwl_cfg iwl_cfg_gl;
+
 extern const struct iwl_cfg iwl_cfg_sc_a0_fm_b0;
 extern const struct iwl_cfg iwl_cfg_sc_a0_fm_c0;
 extern const struct iwl_cfg iwl_cfg_sc_a0_hr_a0;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 34feb4d29adc..a7cf73d67371 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -158,12 +158,71 @@ static int iwl_alloc_fw_desc(struct iwl_drv *drv, struct fw_desc *desc,
 	return 0;
 }
 
+static inline char iwl_drv_get_step(int step)
+{
+	if (step == SILICON_Z_STEP)
+		return 'z';
+	return 'a' + step;
+}
+
+const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf)
+{
+	char mac_step, rf_step;
+	const char *rf, *cdb;
+
+	if (trans->cfg->fw_name_pre)
+		return trans->cfg->fw_name_pre;
+
+	if (WARN_ON(!trans->cfg->fw_name_mac))
+		return "unconfigured-";
+
+	mac_step = iwl_drv_get_step(trans->hw_rev_step);
+
+	switch (CSR_HW_RFID_TYPE(trans->hw_rf_id)) {
+	case IWL_CFG_RF_TYPE_HR1:
+	case IWL_CFG_RF_TYPE_HR2:
+		rf = "hr";
+		break;
+	case IWL_CFG_RF_TYPE_GF:
+		rf = "gf";
+		break;
+	case IWL_CFG_RF_TYPE_MR:
+		rf = "mr";
+		break;
+	case IWL_CFG_RF_TYPE_MS:
+		rf = "ms";
+		break;
+	case IWL_CFG_RF_TYPE_FM:
+		rf = "fm";
+		break;
+	case IWL_CFG_RF_TYPE_WH:
+		rf = "wh";
+		break;
+	default:
+		return "unknown-rf-";
+	}
+
+	cdb = CSR_HW_RFID_IS_CDB(trans->hw_rf_id) ? "4" : "";
+
+	rf_step = iwl_drv_get_step(CSR_HW_RFID_STEP(trans->hw_rf_id));
+
+	scnprintf(buf, FW_NAME_PRE_BUFSIZE,
+		  "iwlwifi-%s-%c0-%s%s-%c0",
+		  trans->cfg->fw_name_mac, mac_step,
+		  rf, cdb, rf_step);
+
+	return buf;
+}
+IWL_EXPORT_SYMBOL(iwl_drv_get_fwname_pre);
+
 static void iwl_req_fw_callback(const struct firmware *ucode_raw,
 				void *context);
 
 static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 {
 	const struct iwl_cfg *cfg = drv->trans->cfg;
+	char _fw_name_pre[FW_NAME_PRE_BUFSIZE];
+	const char *fw_name_pre;
 
 	if (drv->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_9000 &&
 	    (drv->trans->hw_rev_step != SILICON_B_STEP &&
@@ -174,6 +233,8 @@ static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 		return -EINVAL;
 	}
 
+	fw_name_pre = iwl_drv_get_fwname_pre(drv->trans, _fw_name_pre);
+
 	if (first)
 		drv->fw_index = cfg->ucode_api_max;
 	else
@@ -183,13 +244,13 @@ static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 		IWL_ERR(drv, "no suitable firmware found!\n");
 
 		if (cfg->ucode_api_min == cfg->ucode_api_max) {
-			IWL_ERR(drv, "%s%d is required\n", cfg->fw_name_pre,
+			IWL_ERR(drv, "%s%d is required\n", fw_name_pre,
 				cfg->ucode_api_max);
 		} else {
 			IWL_ERR(drv, "minimum version required: %s%d\n",
-				cfg->fw_name_pre, cfg->ucode_api_min);
+				fw_name_pre, cfg->ucode_api_min);
 			IWL_ERR(drv, "maximum version supported: %s%d\n",
-				cfg->fw_name_pre, cfg->ucode_api_max);
+				fw_name_pre, cfg->ucode_api_max);
 		}
 
 		IWL_ERR(drv,
@@ -198,7 +259,7 @@ static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 	}
 
 	snprintf(drv->firmware_name, sizeof(drv->firmware_name), "%s%d.ucode",
-		 cfg->fw_name_pre, drv->fw_index);
+		 fw_name_pre, drv->fw_index);
 
 	IWL_DEBUG_FW_INFO(drv, "attempting to load firmware '%s'\n",
 			  drv->firmware_name);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
index 80073f973334..6c19989e4ab7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2020-2021 Intel Corporation
+ * Copyright (C) 2005-2014, 2020-2021, 2023 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  */
 #ifndef __iwl_drv_h__
@@ -92,4 +92,8 @@ void iwl_drv_stop(struct iwl_drv *drv);
 /* max retry for init flow */
 #define IWL_MAX_INIT_RETRY 2
 
+#define FW_NAME_PRE_BUFSIZE	64
+struct iwl_trans;
+const char *iwl_drv_get_fwname_pre(struct iwl_trans *trans, char *buf);
+
 #endif /* __iwl_drv_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index c037b2ad5fa1..cf27f106d4d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -15,6 +15,7 @@
 #include "iwl-io.h"
 #include "debugfs.h"
 #include "iwl-modparams.h"
+#include "iwl-drv.h"
 #include "fw/error-dump.h"
 #include "fw/api/phy-ctxt.h"
 
@@ -715,6 +716,7 @@ static ssize_t iwl_dbgfs_fw_ver_read(struct file *file, char __user *user_buf,
 	struct iwl_mvm *mvm = file->private_data;
 	char *buff, *pos, *endpos;
 	static const size_t bufsz = 1024;
+	char _fw_name_pre[FW_NAME_PRE_BUFSIZE];
 	int ret;
 
 	buff = kmalloc(bufsz, GFP_KERNEL);
@@ -725,7 +727,7 @@ static ssize_t iwl_dbgfs_fw_ver_read(struct file *file, char __user *user_buf,
 	endpos = pos + bufsz;
 
 	pos += scnprintf(pos, endpos - pos, "FW prefix: %s\n",
-			 mvm->trans->cfg->fw_name_pre);
+			 iwl_drv_get_fwname_pre(mvm->trans, _fw_name_pre));
 	pos += scnprintf(pos, endpos - pos, "FW: %s\n",
 			 mvm->fwrt.fw->human_readable);
 	pos += scnprintf(pos, endpos - pos, "Device: %s\n",
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 7f914bc1000c..33827441803b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1026,97 +1026,21 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 /* Bz */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_bz_a0_hr_a0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_bz_a0_hr_b0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_bz_a0_gf_a0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB,
-		      iwl_cfg_bz_a0_gf4_a0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_bz_b0_gf_a0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB,
-		      iwl_cfg_bz_b0_gf4_a0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_bz_a0_mr_a0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_A_STEP,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_bz_a0_fm_a0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_A_STEP,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB,
-		      iwl_cfg_bz_a0_fm4_a0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_bz_a0_fm_b0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_C_STEP,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_bz_a0_fm_c0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB,
-		      iwl_cfg_bz_a0_fm4_b0, iwl_bz_name),
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_bz, iwl_bz_name),
+
+/* Ga (Gl) */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
+		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_bz_b0_fm_b0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB,
-		      iwl_cfg_bz_b0_fm4_b0, iwl_bz_name),
-/* Ga (Gl) */
+		      iwl_cfg_gl, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_A_STEP,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_gl_a0_fm_a0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_gl_b0_fm_b0, iwl_bz_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, SILICON_C_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_C_STEP,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_gl_c0_fm_c0, iwl_bz_name),
-
-/* BZ Z step */
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, SILICON_Z_STEP,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
-		      iwl_cfg_bz_z0_gf_a0, iwl_bz_name),
 
 /* SoF with JF2 */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-- 
2.38.1

