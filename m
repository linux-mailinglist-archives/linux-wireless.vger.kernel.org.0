Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC2B7380B1
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jun 2023 13:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbjFUKOU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Jun 2023 06:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjFUKN7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Jun 2023 06:13:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0205B107
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jun 2023 03:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687342428; x=1718878428;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hn5pPISsAr7gDpXIZsDfQUt+TLY6VG0R4o++TKav/k4=;
  b=levaeVOe3ZTrOTb/6kzmwbCsSOfFkbTVNlRD0PUnBNN966KDzKCyQg5w
   k5Q+zf8J31VUmJwHudUdSYcNFqPZwdZ+CPh4LAOhJ6yjnl+YdiNYju9kz
   1mqNYQLkHtQlCmEELTmZUzkSM4aakoGsVXkIN6rBIFNY7dBAkBGwhDtzn
   vR1R3W9v/57GYuv60yW4/8tO97JxptVcwrjfYIHskPJFvS1gbVSWnYPgF
   tkBNx83p+EwJHNDNCaK8cRFynnuenmcp6mIw7KD+MD+XRW2DlHaWGs2zT
   NJk15DCLj9Lo3RNSoSWcwjrp4+2raVimaQml6KsposOhXfqYmGqdY4BIM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446506329"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="446506329"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:12:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="664599066"
X-IronPort-AV: E=Sophos;i="6.00,260,1681196400"; 
   d="scan'208";a="664599066"
Received: from ggreenma-mobl2.jer.intel.com ([10.13.17.65])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2023 03:12:40 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/18] wifi: iwlwifi: Add support for new CNVi (SC)
Date:   Wed, 21 Jun 2023 13:12:06 +0300
Message-Id: <20230621130443.716fd707e847.I34f6ffd61e3210c926868a3e961b16d1742bba29@changeid>
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

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Add support for the new Integrated Connectivity (CNVi)
and Companion RF (CRF) versions and their combinations
to handle new devices.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 89 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   | 11 +++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 38 +++++++-
 3 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index fbd73fa24230..a6fa57517188 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -89,6 +89,13 @@
 #define IWL_BNJ_B_HR_B_FW_PRE		"iwlwifi-BzBnj-b0-hr-b0-"
 #define IWL_BNJ_B_FM_B_FW_PRE		"iwlwifi-BzBnj-b0-fm-b0-"
 
+#define IWL_SC_A_FM_B_FW_PRE		"iwlwifi-sc-a0-fm-b0-"
+#define IWL_SC_A_FM_C_FW_PRE		"iwlwifi-sc-a0-fm-c0-"
+#define IWL_SC_A_HR_A_FW_PRE		"iwlwifi-sc-a0-hr-b0-"
+#define IWL_SC_A_HR_B_FW_PRE		"iwlwifi-sc-a0-hr-b0-"
+#define IWL_SC_A_GF_A_FW_PRE		"iwlwifi-sc-a0-gf-a0-"
+#define IWL_SC_A_GF4_A_FW_PRE		"iwlwifi-sc-a0-gf4-a0-"
+#define IWL_SC_A_WH_A_FW_PRE		"iwlwifi-sc-a0-wh-a0-"
 
 #define IWL_QU_B_HR_B_MODULE_FIRMWARE(api) \
 	IWL_QU_B_HR_B_FW_PRE __stringify(api) ".ucode"
@@ -203,6 +210,20 @@
 	IWL_BNJ_B_HR_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_B_FM_B_MODULE_FIRMWARE(api) \
 	IWL_BNJ_B_FM_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_SC_A_FM_B_FW_MODULE_FIRMWARE(api) \
+	IWL_SC_A_FM_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_SC_A_FM_C_FW_MODULE_FIRMWARE(api) \
+	IWL_SC_A_FM_C_FW_PRE __stringify(api) ".ucode"
+#define IWL_SC_A_HR_A_FW_MODULE_FIRMWARE(api) \
+	IWL_SC_A_HR_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_SC_A_HR_B_FW_MODULE_FIRMWARE(api) \
+	IWL_SC_A_HR_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_SC_A_GF_A_FW_MODULE_FIRMWARE(api) \
+	IWL_SC_A_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_SC_A_GF4_A_FW_MODULE_FIRMWARE(api) \
+	IWL_SC_A_GF4_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_SC_A_WH_A_FW_MODULE_FIRMWARE(api) \
+	IWL_SC_A_WH_A_FW_PRE __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_22000_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
@@ -390,6 +411,10 @@ static const struct iwl_ht_params iwl_gl_a_ht_params = {
 	IWL_DEVICE_BZ_COMMON,						\
 	.ht_params = &iwl_gl_a_ht_params
 
+#define IWL_DEVICE_SC							\
+	IWL_DEVICE_BZ_COMMON,						\
+	.ht_params = &iwl_22000_ht_params
+
 const struct iwl_cfg_trans_params iwl_qnj_trans_cfg = {
 	.mq_rx_supported = true,
 	.use_tfh = true,
@@ -586,6 +611,7 @@ const char iwl_ax221_name[] = "Intel(R) Wi-Fi 6E AX221 160MHz";
 const char iwl_ax231_name[] = "Intel(R) Wi-Fi 6E AX231 160MHz";
 const char iwl_ax411_name[] = "Intel(R) Wi-Fi 6E AX411 160MHz";
 const char iwl_bz_name[] = "Intel(R) TBD Bz device";
+const char iwl_sc_name[] = "Intel(R) TBD Sc device";
 
 const char iwl_ax200_killer_1650w_name[] =
 	"Killer(R) Wi-Fi 6 AX1650w 160MHz Wireless Network Adapter (200D2W)";
@@ -1249,6 +1275,62 @@ const struct iwl_cfg iwl_cfg_bnj_b0_fm_b0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_sc_a0_fm_b0 = {
+	.fw_name_pre = IWL_SC_A_FM_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_SC,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_sc_a0_fm_c0 = {
+	.fw_name_pre = IWL_SC_A_FM_C_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_SC,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_sc_a0_hr_a0 = {
+	.fw_name_pre = IWL_SC_A_HR_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_SC,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_sc_a0_hr_b0 = {
+	.fw_name_pre = IWL_SC_A_HR_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_SC,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_sc_a0_gf_a0 = {
+	.fw_name_pre = IWL_SC_A_GF_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_SC,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_sc_a0_gf4_a0 = {
+	.fw_name_pre = IWL_SC_A_GF4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_SC,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_sc_a0_wh_a0 = {
+	.fw_name_pre = IWL_SC_A_WH_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_SC,
+	.features = IWL_TX_CSUM_NETIF_FLAGS_BZ | NETIF_F_RXCSUM,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QNJ_B_HR_B_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22500_UCODE_API_MAX));
@@ -1300,3 +1382,10 @@ MODULE_FIRMWARE(IWL_BZ_A_FM4_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_B_FM_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_C_FM_C_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_B_FM_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC_A_FM_B_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC_A_FM_C_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC_A_HR_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC_A_HR_B_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC_A_GF_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC_A_GF4_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SC_A_WH_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 6d7f15f277bb..37ae57adf950 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 #ifndef __IWL_CONFIG_H__
 #define __IWL_CONFIG_H__
@@ -426,6 +427,7 @@ struct iwl_cfg {
 #define IWL_CFG_MAC_TYPE_MA		0x44
 #define IWL_CFG_MAC_TYPE_BZ		0x46
 #define IWL_CFG_MAC_TYPE_GL		0x47
+#define IWL_CFG_MAC_TYPE_SC		0x48
 
 #define IWL_CFG_RF_TYPE_TH		0x105
 #define IWL_CFG_RF_TYPE_TH1		0x108
@@ -437,6 +439,7 @@ struct iwl_cfg {
 #define IWL_CFG_RF_TYPE_MR		0x110
 #define IWL_CFG_RF_TYPE_MS		0x111
 #define IWL_CFG_RF_TYPE_FM		0x112
+#define IWL_CFG_RF_TYPE_WH		0x113
 
 #define IWL_CFG_RF_ID_TH		0x1
 #define IWL_CFG_RF_ID_TH1		0x1
@@ -534,6 +537,7 @@ extern const char iwl_ax221_name[];
 extern const char iwl_ax231_name[];
 extern const char iwl_ax411_name[];
 extern const char iwl_bz_name[];
+extern const char iwl_sc_name[];
 #if IS_ENABLED(CONFIG_IWLDVM)
 extern const struct iwl_cfg iwl5300_agn_cfg;
 extern const struct iwl_cfg iwl5100_agn_cfg;
@@ -679,6 +683,13 @@ extern const struct iwl_cfg iwl_cfg_bnj_b0_hr_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_b0_hr_b0;
 extern const struct iwl_cfg iwl_cfg_bnj_b0_fm_b0;
 extern const struct iwl_cfg iwl_cfg_bnj_b0_fm4_b0;
+extern const struct iwl_cfg iwl_cfg_sc_a0_fm_b0;
+extern const struct iwl_cfg iwl_cfg_sc_a0_fm_c0;
+extern const struct iwl_cfg iwl_cfg_sc_a0_hr_a0;
+extern const struct iwl_cfg iwl_cfg_sc_a0_hr_b0;
+extern const struct iwl_cfg iwl_cfg_sc_a0_gf_a0;
+extern const struct iwl_cfg iwl_cfg_sc_a0_gf4_a0;
+extern const struct iwl_cfg iwl_cfg_sc_a0_wh_a0;
 #endif /* CONFIG_IWLMVM */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 6c691121ad4c..3f303ca13412 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1419,8 +1419,44 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_MS, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwl_cfg_snj_a0_ms_a0, iwl_ax204_name)
+		      iwl_cfg_snj_a0_ms_a0, iwl_ax204_name),
 
+/* Sc */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SC, SILICON_A_STEP,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_B_STEP,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      iwl_cfg_sc_a0_fm_b0, iwl_sc_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SC, SILICON_A_STEP,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, SILICON_C_STEP,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      iwl_cfg_sc_a0_fm_c0, iwl_sc_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SC, SILICON_A_STEP,
+		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      iwl_cfg_sc_a0_hr_a0, iwl_sc_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SC, SILICON_A_STEP,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      iwl_cfg_sc_a0_hr_b0, iwl_sc_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SC, SILICON_A_STEP,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      iwl_cfg_sc_a0_gf_a0, iwl_sc_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SC, SILICON_A_STEP,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_ANY,
+		      iwl_cfg_sc_a0_gf4_a0, iwl_sc_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SC, SILICON_A_STEP,
+		      IWL_CFG_RF_TYPE_WH, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      iwl_cfg_sc_a0_wh_a0, iwl_sc_name),
 #endif /* CONFIG_IWLMVM */
 };
 
-- 
2.38.1

