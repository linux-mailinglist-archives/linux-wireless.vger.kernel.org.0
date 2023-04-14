Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101906E2065
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 12:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjDNKMb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 06:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjDNKM0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 06:12:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AAE6E9F
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 03:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681467141; x=1713003141;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hSnF+m2CKGdplJYDCE2z8GhCw491mt4dPtfYG0lWcCc=;
  b=AZcbB6znUw8DGduqWd92x1pGEMoarV5Gah4r3244AIBlvefyMQM0CwKq
   kvExh+PeJcLfJi3LvJaOOUsb4vOmAAUkZe0Y5jCEaPUMdWbUHq9qQut/L
   u7uQYJpKg5mQdL3P6sZdGc19ZUTOjIBiBxlL1s9KfMKxXapxdHPXDx5R3
   KWIIYZfpkDSjfC1zlQz6KzglU+1jlgVcVXQ4nGkUJZg2UH/m7+AfO24AD
   Pwvhb72B3eOpqtpcaCaIBJNQwr0ikgCD1eDZj8N9yx4dfI1P+5pu4H7p0
   0Ltz99l2bxrHQwi3D/MTDjjj941P55gzqwUGWs/UBt4KP3NCnbd+L6QM8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="346263538"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="346263538"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="692351551"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="692351551"
Received: from yalankry-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.233.156])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:19 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/15] wifi: iwlwifi: Add RF Step Type for BZ device
Date:   Fri, 14 Apr 2023 13:11:52 +0300
Message-Id: <20230414130637.8f2e2fff7bbc.Iee5554178bc5f134dcc28591db0968e619afbdca@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230414101206.1170180-1-gregory.greenman@intel.com>
References: <20230414101206.1170180-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Add RF step id handling and handle for BZ device.
Read CNV Aux register and uses for no OTP case.
Add missing rf support for Bz/Bnj device and correct/add
the mapping for rf-type if OTP not present.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  47 ++-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   4 +
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |   2 +
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |   7 +
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   5 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 375 +++++++++---------
 6 files changed, 255 insertions(+), 185 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 0b10b34a77a8..032928631ddc 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -51,6 +51,7 @@
 #define IWL_MA_A_MR_A_FW_PRE		"iwlwifi-ma-a0-mr-a0-"
 #define IWL_MA_A_FM_A_FW_PRE		"iwlwifi-ma-a0-fm-a0-"
 #define IWL_SNJ_A_MR_A_FW_PRE		"iwlwifi-SoSnj-a0-mr-a0-"
+#define IWL_BZ_A_HR_A_FW_PRE		"iwlwifi-bz-a0-hr-b0-"
 #define IWL_BZ_A_HR_B_FW_PRE		"iwlwifi-bz-a0-hr-b0-"
 #define IWL_BZ_A_GF_A_FW_PRE		"iwlwifi-bz-a0-gf-a0-"
 #define IWL_BZ_A_GF4_A_FW_PRE		"iwlwifi-bz-a0-gf4-a0-"
@@ -69,7 +70,9 @@
 #define IWL_BNJ_B_GF_A_FW_PRE		"iwlwifi-BzBnj-b0-gf-a0-"
 #define IWL_BNJ_A_GF4_A_FW_PRE		"iwlwifi-BzBnj-a0-gf4-a0-"
 #define IWL_BNJ_B_GF4_A_FW_PRE		"iwlwifi-BzBnj-b0-gf4-a0-"
+#define IWL_BNJ_A_HR_A_FW_PRE		"iwlwifi-BzBnj-a0-hr-b0-"
 #define IWL_BNJ_A_HR_B_FW_PRE		"iwlwifi-BzBnj-a0-hr-b0-"
+#define IWL_BNJ_B_HR_A_FW_PRE		"iwlwifi-BzBnj-b0-hr-b0-"
 #define IWL_BNJ_B_HR_B_FW_PRE		"iwlwifi-BzBnj-b0-hr-b0-"
 #define IWL_BNJ_B_FM_B_FW_PRE		"iwlwifi-BzBnj-b0-fm-b0-"
 
@@ -118,6 +121,8 @@
 	IWL_MA_A_FM_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_SNJ_A_MR_A_MODULE_FIRMWARE(api) \
 	IWL_SNJ_A_MR_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_A_HR_A_MODULE_FIRMWARE(api) \
+	IWL_BZ_A_HR_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BZ_A_HR_B_MODULE_FIRMWARE(api) \
 	IWL_BZ_A_HR_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_BZ_A_GF_A_MODULE_FIRMWARE(api) \
@@ -127,17 +132,17 @@
 #define IWL_BZ_A_MR_A_MODULE_FIRMWARE(api) \
 	IWL_BZ_A_MR_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BZ_A_FM_A_MODULE_FIRMWARE(api) \
-		IWL_BZ_A_FM_A_FW_PRE __stringify(api) ".ucode"
+	IWL_BZ_A_FM_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BZ_A_FM4_A_MODULE_FIRMWARE(api) \
-		IWL_BZ_A_FM4_A_FW_PRE __stringify(api) ".ucode"
+	IWL_BZ_A_FM4_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BZ_A_FM_B_MODULE_FIRMWARE(api) \
-		IWL_BZ_A_FM_B_FW_PRE __stringify(api) ".ucode"
+	IWL_BZ_A_FM_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_BZ_A_FM4_B_MODULE_FIRMWARE(api) \
-		IWL_BZ_A_FM4_B_FW_PRE __stringify(api) ".ucode"
+	IWL_BZ_A_FM4_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_GL_A_FM_A_MODULE_FIRMWARE(api) \
-		IWL_GL_A_FM_A_FW_PRE __stringify(api) ".ucode"
+	IWL_GL_A_FM_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_GL_B_FM_B_MODULE_FIRMWARE(api) \
-		IWL_GL_B_FM_B_FW_PRE __stringify(api) ".ucode"
+	IWL_GL_B_FM_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_A_FM_A_MODULE_FIRMWARE(api) \
 	IWL_BNJ_A_FM_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_A_FM4_A_MODULE_FIRMWARE(api) \
@@ -152,8 +157,12 @@
 	IWL_BNJ_A_GF4_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_B_GF4_A_MODULE_FIRMWARE(api) \
 	IWL_BNJ_B_GF4_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_A_HR_A_MODULE_FIRMWARE(api) \
+	IWL_BNJ_A_HR_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_A_HR_B_MODULE_FIRMWARE(api) \
 	IWL_BNJ_A_HR_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_B_HR_A_MODULE_FIRMWARE(api) \
+	IWL_BNJ_B_HR_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_B_HR_B_MODULE_FIRMWARE(api) \
 	IWL_BNJ_B_HR_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_B_FM_B_MODULE_FIRMWARE(api) \
@@ -928,6 +937,14 @@ const struct iwl_cfg iwl_cfg_quz_a0_hr_b0 = {
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
+const struct iwl_cfg iwl_cfg_bz_a0_hr_a0 = {
+	.fw_name_pre = IWL_BZ_A_HR_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 const struct iwl_cfg iwl_cfg_bz_a0_hr_b0 = {
 	.fw_name_pre = IWL_BZ_A_HR_B_FW_PRE,
 	.uhb_supported = true,
@@ -1072,6 +1089,14 @@ const struct iwl_cfg iwl_cfg_bnj_b0_gf4_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_bnj_a0_hr_a0 = {
+	.fw_name_pre = IWL_BNJ_A_HR_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 const struct iwl_cfg iwl_cfg_bnj_a0_hr_b0 = {
 	.fw_name_pre = IWL_BNJ_A_HR_B_FW_PRE,
 	.uhb_supported = true,
@@ -1080,6 +1105,14 @@ const struct iwl_cfg iwl_cfg_bnj_a0_hr_b0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_bnj_b0_hr_a0 = {
+	.fw_name_pre = IWL_BNJ_B_HR_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.features = IWL_TX_CSUM_NETIF_FLAGS | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 const struct iwl_cfg iwl_cfg_bnj_b0_hr_b0 = {
 	.fw_name_pre = IWL_BNJ_B_HR_B_FW_PRE,
 	.uhb_supported = true,
@@ -1117,6 +1150,7 @@ MODULE_FIRMWARE(IWL_MA_A_GF4_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_A_FM_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SNJ_A_MR_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BZ_A_HR_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
@@ -1132,6 +1166,7 @@ MODULE_FIRMWARE(IWL_BNJ_B_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_A_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_B_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_B_HR_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM4_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 9b7b6fca2b1b..c4ac951de19f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -469,6 +469,7 @@ struct iwl_dev_info {
 	u16 mac_type;
 	u16 rf_type;
 	u8 mac_step;
+	u8 rf_step;
 	u8 rf_id;
 	u8 no_160;
 	u8 cores;
@@ -644,6 +645,7 @@ extern const struct iwl_cfg iwl_cfg_snj_a0_ms_a0;
 extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0;
 extern const struct iwl_cfg iwl_cfg_so_a0_ms_a0;
 extern const struct iwl_cfg iwl_cfg_quz_a0_hr_b0;
+extern const struct iwl_cfg iwl_cfg_bz_a0_hr_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_hr_b0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_gf4_a0;
@@ -661,7 +663,9 @@ extern const struct iwl_cfg iwl_cfg_bnj_a0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_b0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_a0_gf4_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_b0_gf4_a0;
+extern const struct iwl_cfg iwl_cfg_bnj_a0_hr_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_a0_hr_b0;
+extern const struct iwl_cfg iwl_cfg_bnj_b0_hr_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_b0_hr_b0;
 extern const struct iwl_cfg iwl_cfg_bnj_b0_fm_b0;
 extern const struct iwl_cfg iwl_cfg_bnj_b0_fm4_b0;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index 52479516c76b..587368a0ad4a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -311,6 +311,8 @@ enum {
 	SILICON_A_STEP = 0,
 	SILICON_B_STEP,
 	SILICON_C_STEP,
+	SILICON_D_STEP,
+	SILICON_E_STEP,
 	SILICON_Z_STEP = 0xf,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 62ce116d3783..0dfe00eae05d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -350,6 +350,11 @@
 #define WFPM_OTP_CFG1_ADDR		0x00a03098
 #define WFPM_OTP_CFG1_IS_JACKET_BIT	BIT(4)
 #define WFPM_OTP_CFG1_IS_CDB_BIT	BIT(5)
+#define WFPM_OTP_BZ_BNJ_JACKET_BIT	5
+#define WFPM_OTP_BZ_BNJ_CDB_BIT		4
+#define WFPM_OTP_CFG1_IS_JACKET(_val)   (((_val) & 0x00000020) >> WFPM_OTP_BZ_BNJ_JACKET_BIT)
+#define WFPM_OTP_CFG1_IS_CDB(_val)      (((_val) & 0x00000010) >> WFPM_OTP_BZ_BNJ_CDB_BIT)
+
 
 #define WFPM_GP2			0xA030B4
 
@@ -445,6 +450,8 @@ enum {
 #define REG_CRF_ID_TYPE_GF_TC			0xF08
 #define REG_CRF_ID_TYPE_MR			0x810
 #define REG_CRF_ID_TYPE_FM			0x910
+#define REG_CRF_ID_TYPE_FMI			0x930
+#define REG_CRF_ID_TYPE_FMR			0x900
 
 #define HPM_DEBUG			0xA03440
 #define PERSISTENCE_BIT			BIT(12)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 74ff4788dc83..9f1228b5a384 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -997,7 +997,7 @@ struct iwl_trans_txqs {
  *	0 indicates that frag SKBs (NETIF_F_SG) aren't supported.
  * @hw_rf_id a u32 with the device RF ID
  * @hw_crf_id a u32 with the device CRF ID
- * @hw_cdb_id a u32 with the device CDB ID
+ * @hw_wfpm_id a u32 with the device wfpm ID
  * @hw_id: a u32 with the ID of the device / sub-device.
  *	Set during transport allocation.
  * @hw_id_str: a string with info about HW ID. Set during transport allocation.
@@ -1040,7 +1040,8 @@ struct iwl_trans {
 	u32 hw_rev_step;
 	u32 hw_rf_id;
 	u32 hw_crf_id;
-	u32 hw_cdb_id;
+	u32 hw_cnv_id;
+	u32 hw_wfpm_id;
 	u32 hw_id;
 	char hw_id_str[52];
 	u32 sku_id[3];
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index a60329079167..fb0c2c0f236f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -513,16 +513,17 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 MODULE_DEVICE_TABLE(pci, iwl_hw_card_ids);
 
 #define _IWL_DEV_INFO(_device, _subdevice, _mac_type, _mac_step, _rf_type, \
-		      _rf_id, _no_160, _cores, _cdb, _jacket, _cfg, _name) \
-	{ .device = (_device), .subdevice = (_subdevice), .cfg = &(_cfg),  \
-	  .name = _name, .mac_type = _mac_type, .rf_type = _rf_type,	   \
-	  .no_160 = _no_160, .cores = _cores, .rf_id = _rf_id,		   \
+		      _rf_id, _rf_step, _no_160, _cores, _cdb, _jacket, _cfg, \
+		      _name) \
+	{ .device = (_device), .subdevice = (_subdevice), .cfg = &(_cfg), \
+	  .name = _name, .mac_type = _mac_type, .rf_type = _rf_type, .rf_step = _rf_step, \
+	  .no_160 = _no_160, .cores = _cores, .rf_id = _rf_id, \
 	  .mac_step = _mac_step, .cdb = _cdb, .jacket = _jacket }
 
 #define IWL_DEV_INFO(_device, _subdevice, _cfg, _name) \
-	_IWL_DEV_INFO(_device, _subdevice, IWL_CFG_ANY, IWL_CFG_ANY,	   \
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,  \
-		      IWL_CFG_ANY, IWL_CFG_ANY, _cfg, _name)
+	_IWL_DEV_INFO(_device, _subdevice, IWL_CFG_ANY, IWL_CFG_ANY, \
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY, \
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY, _cfg, _name)
 
 static const struct iwl_dev_info iwl_dev_info_table[] = {
 #if IS_ENABLED(CONFIG_IWLMVM)
@@ -693,87 +694,87 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_2ac_cfg_soc, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_2ac_cfg_soc, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_2ac_cfg_soc, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_2ac_cfg_soc, iwl9462_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_2ac_cfg_soc, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_2ac_cfg_soc, iwl9560_name),
 
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9260_2ac_cfg, iwl9461_160_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9260_2ac_cfg, iwl9461_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9260_2ac_cfg, iwl9462_160_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9260_2ac_cfg, iwl9462_name),
 
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT_GNSS, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9260_2ac_cfg, iwl9270_160_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT_GNSS, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9260_2ac_cfg, iwl9270_name),
 
 	_IWL_DEV_INFO(0x271B, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_TH1, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_TH1, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9260_2ac_cfg, iwl9162_160_name),
 	_IWL_DEV_INFO(0x271B, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_TH1, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_TH1, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9260_2ac_cfg, iwl9162_name),
 
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9260_2ac_cfg, iwl9260_160_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9260_2ac_cfg, iwl9260_name),
 
@@ -781,176 +782,176 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	/* Qu B step */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9462_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9560_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1551,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9560_killer_1550s_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1552,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9560_killer_1550i_name),
 
 	/* Qu C step */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9462_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9560_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1551,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9560_killer_1550s_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1552,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9560_killer_1550i_name),
 
 	/* QuZ */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9462_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1551,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_killer_1550s_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1552,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_killer_1550i_name),
 
 	/* QnJ */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qnj_b0_jf_b0_cfg, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qnj_b0_jf_b0_cfg, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qnj_b0_jf_b0_cfg, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qnj_b0_jf_b0_cfg, iwl9462_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qnj_b0_jf_b0_cfg, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qnj_b0_jf_b0_cfg, iwl9560_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1551,
 		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qnj_b0_jf_b0_cfg, iwl9560_killer_1550s_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1552,
 		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl9560_qnj_b0_jf_b0_cfg, iwl9560_killer_1550i_name),
 
@@ -958,402 +959,383 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	/* Qu B step */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_qu_b0_hr1_b0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_qu_b0_hr_b0, iwl_ax203_name),
 
 	/* Qu C step */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
-		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_qu_c0_hr1_b0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_qu_c0_hr_b0, iwl_ax203_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_qu_c0_hr_b0, iwl_ax201_name),
 
 	/* QuZ */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_quz_a0_hr1_b0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_quz_a0_hr_b0, iwl_ax203_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_quz_a0_hr_b0, iwl_ax201_name),
 
 /* QnJ with Hr */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_qnj_b0_hr_b0_cfg, iwl_ax201_name),
 
 /* SnJ with Jf */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_snj_a0_jf_b0, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_snj_a0_jf_b0, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_snj_a0_jf_b0, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_snj_a0_jf_b0, iwl9462_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_snj_a0_jf_b0, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_snj_a0_jf_b0, iwl9560_name),
 
 /* SnJ with Hr */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_snj_hr_b0, iwl_ax101_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_snj_hr_b0, iwl_ax201_name),
 
 /* Ma */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_ma_a0_hr_b0, iwl_ax201_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_ma_a0_gf_a0, iwl_ax211_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_ANY,
 		      iwl_cfg_ma_a0_gf4_a0, iwl_ax211_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_ma_a0_mr_a0, iwl_ax221_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_ma_a0_fm_a0, iwl_ax231_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_snj_a0_mr_a0, iwl_ax221_name),
 
 /* So with Hr */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax203_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax201_name),
 
 /* So-F with Hr */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax203_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax201_name),
 
 /* So-F with Gf */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_ANY,
 		      iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_name),
 
 /* Bz */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      iwl_cfg_bz_a0_hr_a0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_bz_a0_hr_b0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_bz_a0_gf_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_ANY,
 		      iwl_cfg_bz_a0_gf4_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_bz_a0_mr_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, SILICON_A_STEP,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_A_STEP,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_bz_a0_fm_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_A_STEP,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_NO_JACKET,
 		      iwl_cfg_bz_a0_fm4_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
 		      iwl_cfg_bz_a0_fm_b0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_IS_JACKET,
 		      iwl_cfg_bz_a0_fm4_b0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_A_STEP,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_NO_JACKET,
 		      iwl_cfg_gl_a0_fm_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_NO_JACKET,
 		      iwl_cfg_gl_b0_fm_b0, iwl_bz_name),
 
 /* BZ Z step */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_BZ, SILICON_Z_STEP,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_bz_z0_gf_a0, iwl_bz_name),
 
 /* BNJ */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_A_STEP,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
 		      iwl_cfg_bnj_a0_fm_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
 		      iwl_cfg_bnj_b0_fm_b0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_A_STEP,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_IS_JACKET,
 		      iwl_cfg_bnj_a0_fm4_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_IS_JACKET,
 		      iwl_cfg_bnj_b0_fm4_b0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
 		      iwl_cfg_bnj_a0_gf_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
 		      iwl_cfg_bnj_b0_gf_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_IS_JACKET,
 		      iwl_cfg_bnj_a0_gf4_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_IS_JACKET,
 		      iwl_cfg_bnj_b0_gf4_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
-		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_NO_JACKET,
+		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      iwl_cfg_bnj_a0_hr_a0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_bnj_a0_hr_b0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
-		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_NO_JACKET,
-		      iwl_cfg_bnj_b0_hr_b0, iwl_bz_name),
-
-/* SoF with JF2 */
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwlax210_2ax_cfg_so_jf_b0, iwl9560_160_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwlax210_2ax_cfg_so_jf_b0, iwl9560_name),
-
-/* SoF with JF */
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwlax210_2ax_cfg_so_jf_b0, iwl9461_160_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
-		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_160_name),
-	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwlax210_2ax_cfg_so_jf_b0, iwl9461_name),
+		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      iwl_cfg_bnj_b0_hr_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_name),
+		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      iwl_cfg_bnj_b0_hr_b0, iwl_bz_name),
 
 /* SoF with JF2 */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9560_name),
 
 /* SoF with JF */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_name),
 
 /* So with GF */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwlax211_2ax_cfg_so_gf_a0, iwl_ax211_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_ANY,
 		      iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_name),
 
 /* So with JF2 */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9560_name),
 
 /* So with JF */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_name),
 
@@ -1361,22 +1343,22 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 /* For now we use the same FW as MR, but this will change in the future. */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_MS, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_MS, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_so_a0_ms_a0, iwl_ax204_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_MS, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_MS, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_so_a0_ms_a0, iwl_ax204_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_MS, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_MS, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_ma_a0_ms_a0, iwl_ax204_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
-		      IWL_CFG_RF_TYPE_MS, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_MS, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_snj_a0_ms_a0, iwl_ax204_name)
 
@@ -1411,8 +1393,16 @@ static int get_crf_id(struct iwl_trans *iwl_trans)
 	/* Read crf info */
 	iwl_trans->hw_crf_id = iwl_read_prph_no_grab(iwl_trans, sd_reg_ver_addr);
 
+	/* Read cnv info */
+	iwl_trans->hw_cnv_id =
+		iwl_read_prph_no_grab(iwl_trans, CNVI_AUX_MISC_CHIP);
+
 	/* Read cdb info (also contains the jacket info if needed in the future */
-	iwl_trans->hw_cdb_id = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_OTP_CFG1_ADDR);
+	iwl_trans->hw_wfpm_id =
+		iwl_read_umac_prph_no_grab(iwl_trans, WFPM_OTP_CFG1_ADDR);
+	IWL_INFO(iwl_trans, "Detected crf-id 0x%x, cnv-id 0x%x wfpm id 0x%x\n",
+		 iwl_trans->hw_crf_id, iwl_trans->hw_cnv_id,
+		 iwl_trans->hw_wfpm_id);
 
 	iwl_trans_release_nic_access(iwl_trans);
 
@@ -1428,7 +1418,11 @@ static int map_crf_id(struct iwl_trans *iwl_trans)
 {
 	int ret = 0;
 	u32 val = iwl_trans->hw_crf_id;
-	u32 cdb = iwl_trans->hw_cdb_id;
+	u32 step_id = REG_CRF_ID_STEP(val);
+	u32 slave_id = REG_CRF_ID_SLAVE(val);
+	u32 jacket_id_cnv  = REG_CRF_ID_SLAVE(iwl_trans->hw_cnv_id);
+	u32 jacket_id_wfpm  = WFPM_OTP_CFG1_IS_JACKET(iwl_trans->hw_wfpm_id);
+	u32 cdb_id_wfpm  = WFPM_OTP_CFG1_IS_CDB(iwl_trans->hw_wfpm_id);
 
 	/* Map between crf id to rf id */
 	switch (REG_CRF_ID_TYPE(val)) {
@@ -1438,9 +1432,12 @@ static int map_crf_id(struct iwl_trans *iwl_trans)
 	case REG_CRF_ID_TYPE_JF_2:
 		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_JF2 << 12);
 		break;
-	case REG_CRF_ID_TYPE_HR_NONE_CDB:
+	case REG_CRF_ID_TYPE_HR_NONE_CDB_1X1:
 		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_HR1 << 12);
 		break;
+	case REG_CRF_ID_TYPE_HR_NONE_CDB:
+		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_HR2 << 12);
+		break;
 	case REG_CRF_ID_TYPE_HR_CDB:
 		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_HR2 << 12);
 		break;
@@ -1450,27 +1447,43 @@ static int map_crf_id(struct iwl_trans *iwl_trans)
 	case REG_CRF_ID_TYPE_MR:
 		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_MR << 12);
 		break;
-		case REG_CRF_ID_TYPE_FM:
-			iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_FM << 12);
-			break;
+	case REG_CRF_ID_TYPE_FM:
+	case REG_CRF_ID_TYPE_FMI:
+	case REG_CRF_ID_TYPE_FMR:
+		iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_FM << 12);
+		break;
 	default:
 		ret = -EIO;
 		IWL_ERR(iwl_trans,
-			"Can find a correct rfid for crf id 0x%x\n",
+			"Can't find a correct rfid for crf id 0x%x\n",
 			REG_CRF_ID_TYPE(val));
 		goto out;
 
 	}
 
+	/* Set Step-id */
+	iwl_trans->hw_rf_id |= (step_id << 8);
+
 	/* Set CDB capabilities */
-	if (cdb & BIT(4)) {
+	if (cdb_id_wfpm || slave_id) {
 		iwl_trans->hw_rf_id += BIT(28);
 		IWL_INFO(iwl_trans, "Adding cdb to rf id\n");
 	}
 
-	IWL_INFO(iwl_trans, "Detected RF 0x%x from crf id 0x%x\n",
-		 iwl_trans->hw_rf_id, REG_CRF_ID_TYPE(val));
+	/* Set Jacket capabilities */
+	if (jacket_id_wfpm || jacket_id_cnv) {
+		iwl_trans->hw_rf_id += BIT(29);
+		IWL_INFO(iwl_trans, "Adding jacket to rf id\n");
+	}
 
+	IWL_INFO(iwl_trans,
+		 "Detected rf-type 0x%x step-id 0x%x slave-id 0x%x from crf id 0x%x\n",
+		 REG_CRF_ID_TYPE(val), step_id, slave_id, iwl_trans->hw_rf_id);
+	IWL_INFO(iwl_trans,
+		 "Detected cdb-id 0x%x jacket-id 0x%x from wfpm id 0x%x\n",
+		 cdb_id_wfpm, jacket_id_wfpm, iwl_trans->hw_wfpm_id);
+	IWL_INFO(iwl_trans, "Detected jacket-id 0x%x from cnvi id 0x%x\n",
+		 jacket_id_cnv, iwl_trans->hw_cnv_id);
 
 out:
 	return ret;
@@ -1481,8 +1494,8 @@ static int map_crf_id(struct iwl_trans *iwl_trans)
 
 static const struct iwl_dev_info *
 iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
-		      u16 mac_type, u8 mac_step,
-		      u16 rf_type, u8 cdb, u8 jacket, u8 rf_id, u8 no_160, u8 cores)
+		      u16 mac_type, u8 mac_step, u16 rf_type, u8 cdb,
+		      u8 jacket, u8 rf_id, u8 no_160, u8 cores, u8 rf_step)
 {
 	int num_devices = ARRAY_SIZE(iwl_dev_info_table);
 	int i;
@@ -1533,6 +1546,10 @@ iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
 		    dev_info->cores != cores)
 			continue;
 
+		if (dev_info->rf_step != (u8)IWL_CFG_ANY &&
+		    dev_info->rf_step != rf_step)
+			continue;
+
 		return dev_info;
 	}
 
@@ -1604,6 +1621,10 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto out_free_trans;
 	}
 
+	IWL_INFO(iwl_trans, "PCI dev %04x/%04x, rev=0x%x, rfid=0x%x\n",
+		 pdev->device, pdev->subsystem_device,
+		 iwl_trans->hw_rev, iwl_trans->hw_rf_id);
+
 	dev_info = iwl_pci_find_dev_info(pdev->device, pdev->subsystem_device,
 					 CSR_HW_REV_TYPE(iwl_trans->hw_rev),
 					 iwl_trans->hw_rev_step,
@@ -1612,8 +1633,8 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 					 CSR_HW_RFID_IS_JACKET(iwl_trans->hw_rf_id),
 					 IWL_SUBDEVICE_RF_ID(pdev->subsystem_device),
 					 IWL_SUBDEVICE_NO_160(pdev->subsystem_device),
-					 IWL_SUBDEVICE_CORES(pdev->subsystem_device));
-
+					 IWL_SUBDEVICE_CORES(pdev->subsystem_device),
+					 CSR_HW_RFID_STEP(iwl_trans->hw_rf_id));
 	if (dev_info) {
 		iwl_trans->cfg = dev_info->cfg;
 		iwl_trans->name = dev_info->name;
-- 
2.38.1

