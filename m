Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E9B5AEB9A
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 16:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240859AbiIFOIH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 10:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240842AbiIFOGx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 10:06:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6954F857DA
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 06:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662471928; x=1694007928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vHFIX1L8XM12D+ambrd2H4ssx8FrLeFZ/hcHLEnNtZM=;
  b=NslKcJW5JHlwWeIHgleLwAZ//XHHgpSZFfVPx77NTNhuK6lnpUL+aJpF
   7+7YbdjEStbb5CyJxn0zxzg1kBlkdYMKkw0an+CWLLApMm2sZGCHZsgqg
   HS7deoi3DUDpFKB+/Fi6xiU6UweFmp94mIwFUbLq/xLsfKpmArYzAqmYL
   ypt8tyf5XadpXlqWMWTRvOUc/uC37wfnjwAgf1JDM0IWY8DSNvPlEEmAM
   xJsSr97hnIGRRnL5VztlsGbQWHyPlQixAGEXGa29bZ57WY4zOZeVuwWXA
   m4RZtnMcSg2bhvvF44Azcdz8xG9ForzIQeMWcmu/yGmVenTdgjpD9TqSv
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="297906960"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="297906960"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:43:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942459562"
Received: from ygueta-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.82.178])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 06:43:10 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Yaara Baruch <yaara.baruch@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/15] wifi: iwlwifi: pcie: add support for BZ devices
Date:   Tue,  6 Sep 2022 16:42:05 +0300
Message-Id: <20220906161827.0b7fc8487039.I984dcb58272e2f38c835e7aaa7e1ac646bc2f65e@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220906134219.365090-1-gregory.greenman@intel.com>
References: <20220906134219.365090-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yaara Baruch <yaara.baruch@intel.com>

Add support in BZ-FM and BZ-GL devices. Adjust current structs
steps to differ between the new devices.

Signed-off-by: Yaara Baruch <yaara.baruch@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 33 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  3 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 19 +++++++++--
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 8ff967edc8f0..c949675ca2ed 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -56,13 +56,16 @@
 #define IWL_BZ_A_GF4_A_FW_PRE		"iwlwifi-bz-a0-gf4-a0-"
 #define IWL_BZ_A_MR_A_FW_PRE		"iwlwifi-bz-a0-mr-a0-"
 #define IWL_BZ_A_FM_A_FW_PRE		"iwlwifi-bz-a0-fm-a0-"
+#define IWL_BZ_A_FM4_A_FW_PRE		"iwlwifi-bz-a0-fm4-a0-"
 #define IWL_GL_A_FM_A_FW_PRE		"iwlwifi-gl-a0-fm-a0-"
+#define IWL_GL_B_FM_B_FW_PRE		"iwlwifi-gl-b0-fm-b0-"
 #define IWL_BZ_Z_GF_A_FW_PRE		"iwlwifi-bz-z0-gf-a0-"
 #define IWL_BNJ_A_FM_A_FW_PRE		"iwlwifi-BzBnj-a0-fm-a0-"
 #define IWL_BNJ_A_FM4_A_FW_PRE		"iwlwifi-BzBnj-a0-fm4-a0-"
 #define IWL_BNJ_A_GF_A_FW_PRE		"iwlwifi-BzBnj-a0-gf-a0-"
 #define IWL_BNJ_A_GF4_A_FW_PRE		"iwlwifi-BzBnj-a0-gf4-a0-"
 #define IWL_BNJ_A_HR_B_FW_PRE		"iwlwifi-BzBnj-a0-hr-b0-"
+#define IWL_BNJ_B_FM_B_FW_PRE		"iwlwifi-BzBnj-b0-fm-b0-"
 
 
 #define IWL_QU_B_HR_B_MODULE_FIRMWARE(api) \
@@ -119,8 +122,12 @@
 	IWL_BZ_A_MR_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BZ_A_FM_A_MODULE_FIRMWARE(api) \
 		IWL_BZ_A_FM_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_A_FM4_A_MODULE_FIRMWARE(api) \
+		IWL_BZ_A_FM4_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_GL_A_FM_A_MODULE_FIRMWARE(api) \
 		IWL_GL_A_FM_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_GL_B_FM_B_MODULE_FIRMWARE(api) \
+		IWL_GL_B_FM_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_A_FM_A_MODULE_FIRMWARE(api) \
 	IWL_BNJ_A_FM_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_A_FM4_A_MODULE_FIRMWARE(api) \
@@ -131,6 +138,8 @@
 	IWL_BNJ_A_GF4_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_A_HR_B_MODULE_FIRMWARE(api) \
 	IWL_BNJ_A_HR_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_B_FM_B_MODULE_FIRMWARE(api) \
+	IWL_BNJ_B_FM_B_FW_PRE __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_22000_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
@@ -926,6 +935,13 @@ const struct iwl_cfg iwl_cfg_bz_a0_fm_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_bz_a0_fm4_a0 = {
+	.fw_name_pre = IWL_BZ_A_FM4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 const struct iwl_cfg iwl_cfg_gl_a0_fm_a0 = {
 	.fw_name_pre = IWL_GL_A_FM_A_FW_PRE,
 	.uhb_supported = true,
@@ -933,6 +949,13 @@ const struct iwl_cfg iwl_cfg_gl_a0_fm_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_gl_b0_fm_b0 = {
+	.fw_name_pre = IWL_GL_B_FM_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 const struct iwl_cfg iwl_cfg_bz_z0_gf_a0 = {
 	.fw_name_pre = IWL_BZ_Z_GF_A_FW_PRE,
 	.uhb_supported = true,
@@ -974,6 +997,13 @@ const struct iwl_cfg iwl_cfg_bnj_a0_hr_b0 = {
 	IWL_DEVICE_BZ,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
+
+const struct iwl_cfg iwl_cfg_bnj_b0_fm_b0 = {
+	.fw_name_pre = IWL_BNJ_B_FM_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
 MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QNJ_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
@@ -1007,3 +1037,6 @@ MODULE_FIRMWARE(IWL_BNJ_A_FM4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_A_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BNJ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BZ_A_FM4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_GL_B_FM_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_B_FM_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index f5b556a103e8..cfa5e1b3c3f6 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -649,13 +649,16 @@ extern const struct iwl_cfg iwl_cfg_bz_a0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_gf4_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_mr_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_fm_a0;
+extern const struct iwl_cfg iwl_cfg_bz_a0_fm4_a0;
 extern const struct iwl_cfg iwl_cfg_gl_a0_fm_a0;
+extern const struct iwl_cfg iwl_cfg_gl_b0_fm_b0;
 extern const struct iwl_cfg iwl_cfg_bz_z0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_a0_fm_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_a0_fm4_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_a0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_a0_gf4_a0;
 extern const struct iwl_cfg iwl_cfg_bnj_a0_hr_b0;
+extern const struct iwl_cfg iwl_cfg_bnj_b0_fm_b0;
 #endif /* CONFIG_IWLMVM */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index b16d4ae182d1..4f699862e7f7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1155,10 +1155,20 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_bz_a0_fm_a0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_NO_JACKET,
+		      iwl_cfg_bz_a0_fm4_a0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_NO_JACKET,
 		      iwl_cfg_gl_a0_fm_a0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_NO_JACKET,
+		      iwl_cfg_gl_b0_fm_b0, iwl_bz_name),
 
 /* BZ Z step */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
@@ -1169,10 +1179,15 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 
 /* BNJ */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, SILICON_A_STEP,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
 		      iwl_cfg_bnj_a0_fm_a0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, SILICON_B_STEP,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
+		      iwl_cfg_bnj_b0_fm_b0, iwl_bz_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
-- 
2.35.3

