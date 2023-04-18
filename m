Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFEF6E5D55
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjDRJ2b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbjDRJ2a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:28:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFD34216
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681810108; x=1713346108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bt6NHvctyaBdl37EKw5rvhrY7ihfgiebtY3QOu2etlc=;
  b=hCVBF6gdmy/T1lAo+qpWnLHeerdYuHIypgRehGZK+nTdvmQ4uQ2C7rnM
   CWRDwAXzv2mwZ4eN3G/qrsSjFo4aveuSxAyHTQkCjMeJxbGIskVR4V27n
   tQ3EYEs5DTm3EbgB7cfH4TdZEEriGXuFSnMIgJ0V2bI+AKa5dczcjd/gH
   sw3LuTDQgyNB12so+CfeOXGnudn1ihXWqCMUW8dhpepeRapNvkOJM3jq6
   MbERB9qRfsN1KfDA64vrcDLSjRszTCd1e0qyjDmp9gyZ8wRpc/dXsRCKz
   zHV3jB4HZF9O5byanqLaw/rcbUDzLs7qTWSUFyJ0BKBFmOrkyxD2v8INE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="410341146"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="410341146"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="684511199"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="684511199"
Received: from kadanh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.234.12])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 02:28:26 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mukesh Sisodiya <mukesh.sisodiya@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/11] wifi: iwlwifi: Update support for b0 version
Date:   Tue, 18 Apr 2023 12:28:04 +0300
Message-Id: <20230418122405.5dca1ea7a0cf.I87932e1e216a1940eeae8824071ecb777f4c034f@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230418092814.1438734-1-gregory.greenman@intel.com>
References: <20230418092814.1438734-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Add support for B0 version of MAC of MR device

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 55 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  5 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 35 ++++++++++--
 3 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 532d14f61253..b6f82510e980 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -50,6 +50,11 @@
 #define IWL_MA_A_GF4_A_FW_PRE		"iwlwifi-ma-a0-gf4-a0-"
 #define IWL_MA_A_MR_A_FW_PRE		"iwlwifi-ma-a0-mr-a0-"
 #define IWL_MA_A_FM_A_FW_PRE		"iwlwifi-ma-a0-fm-a0-"
+#define IWL_MA_B_HR_B_FW_PRE		"iwlwifi-ma-b0-hr-b0-"
+#define IWL_MA_B_GF_A_FW_PRE		"iwlwifi-ma-b0-gf-a0-"
+#define IWL_MA_B_GF4_A_FW_PRE		"iwlwifi-ma-b0-gf4-a0-"
+#define IWL_MA_B_MR_A_FW_PRE		"iwlwifi-ma-b0-mr-a0-"
+#define IWL_MA_B_FM_A_FW_PRE		"iwlwifi-ma-b0-fm-a0-"
 #define IWL_SNJ_A_MR_A_FW_PRE		"iwlwifi-SoSnj-a0-mr-a0-"
 #define IWL_BZ_A_HR_A_FW_PRE		"iwlwifi-bz-a0-hr-b0-"
 #define IWL_BZ_A_HR_B_FW_PRE		"iwlwifi-bz-a0-hr-b0-"
@@ -119,6 +124,16 @@
 	IWL_MA_A_MR_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_MA_A_FM_A_FW_MODULE_FIRMWARE(api)		\
 	IWL_MA_A_FM_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(api)		\
+	IWL_MA_B_HR_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_B_GF_A_FW_MODULE_FIRMWARE(api)		\
+	IWL_MA_B_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_B_GF4_A_FW_MODULE_FIRMWARE(api)		\
+	IWL_MA_B_GF4_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_B_MR_A_FW_MODULE_FIRMWARE(api) \
+	IWL_MA_B_MR_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_B_FM_A_FW_MODULE_FIRMWARE(api)		\
+	IWL_MA_B_FM_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_SNJ_A_MR_A_MODULE_FIRMWARE(api) \
 	IWL_SNJ_A_MR_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BZ_A_HR_A_MODULE_FIRMWARE(api) \
@@ -891,6 +906,41 @@ const struct iwl_cfg iwl_cfg_ma_a0_ms_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_ma_b0_fm_a0 = {
+	.fw_name_pre = IWL_MA_B_FM_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_ma_b0_hr_b0 = {
+	.fw_name_pre = IWL_MA_B_HR_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_ma_b0_gf_a0 = {
+	.fw_name_pre = IWL_MA_B_GF_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_ma_b0_gf4_a0 = {
+	.fw_name_pre = IWL_MA_B_GF4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_ma_b0_mr_a0 = {
+	.fw_name_pre = IWL_MA_B_MR_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 const struct iwl_cfg iwl_cfg_so_a0_ms_a0 = {
 	.fw_name_pre = IWL_SO_A_MR_A_FW_PRE,
 	.uhb_supported = false,
@@ -1149,6 +1199,11 @@ MODULE_FIRMWARE(IWL_MA_A_GF_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_A_GF4_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_A_FM_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_B_HR_B_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_B_GF_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_B_GF4_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_B_MR_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_B_FM_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SNJ_A_MR_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_HR_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index c4ac951de19f..411b7d4fcc9a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -640,6 +640,11 @@ extern const struct iwl_cfg iwl_cfg_ma_a0_gf4_a0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_mr_a0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_ms_a0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_fm_a0;
+extern const struct iwl_cfg iwl_cfg_ma_b0_hr_b0;
+extern const struct iwl_cfg iwl_cfg_ma_b0_gf_a0;
+extern const struct iwl_cfg iwl_cfg_ma_b0_gf4_a0;
+extern const struct iwl_cfg iwl_cfg_ma_b0_mr_a0;
+extern const struct iwl_cfg iwl_cfg_ma_b0_fm_a0;
 extern const struct iwl_cfg iwl_cfg_snj_a0_mr_a0;
 extern const struct iwl_cfg iwl_cfg_snj_a0_ms_a0;
 extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 31b575f35410..dba112394838 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1058,27 +1058,27 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* Ma */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_MA, SILICON_A_STEP,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_ma_a0_hr_b0, iwl_ax201_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_MA, SILICON_A_STEP,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_ma_a0_gf_a0, iwl_ax211_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_MA, SILICON_A_STEP,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_ANY,
 		      iwl_cfg_ma_a0_gf4_a0, iwl_ax211_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_MA, SILICON_A_STEP,
 		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_ma_a0_mr_a0, iwl_ax221_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_MA, SILICON_A_STEP,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_ma_a0_fm_a0, iwl_ax231_name),
@@ -1087,6 +1087,31 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_snj_a0_mr_a0, iwl_ax221_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_MA, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      iwl_cfg_ma_b0_hr_b0, iwl_ax201_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_MA, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      iwl_cfg_ma_b0_gf_a0, iwl_ax211_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_MA, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_ANY,
+		      iwl_cfg_ma_b0_gf4_a0, iwl_ax211_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_MA, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      iwl_cfg_ma_b0_mr_a0, iwl_ax221_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_MA, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      iwl_cfg_ma_b0_fm_a0, iwl_ax231_name),
 
 /* So with Hr */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-- 
2.38.1

