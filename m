Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC893A4E60
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jun 2021 13:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhFLLez (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Jun 2021 07:34:55 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47602 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231252AbhFLLey (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Jun 2021 07:34:54 -0400
Received: from [192.130.48.226] (helo=kveik.superpark.guest)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1ls1sh-001V8i-PV; Sat, 12 Jun 2021 14:32:53 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 12 Jun 2021 14:32:41 +0300
Message-Id: <iwlwifi.20210612142637.c1fdd153d686.I7ee0485c52fb429de1fe171cb6dc0ae593a26788@changeid>
X-Mailer: git-send-email 2.32.0.rc2
In-Reply-To: <20210612113245.691117-1-luca@coelho.fi>
References: <20210612113245.691117-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 08/12] iwlwifi: pcie: Add support for AX231 radio module with Ma devices
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Matti Gottlieb <matti.gottlieb@intel.com>

Add support for AX231 radio modules, which we call Fm.
These modules can be used with the Ma family of devices
and above.

Signed-off-by: Matti Gottlieb <matti.gottlieb@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  | 12 ++++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  3 +++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index c2315dea9a23..0256d0042f71 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -47,6 +47,7 @@
 #define IWL_MA_A_GF_A_FW_PRE		"iwlwifi-ma-a0-gf-a0-"
 #define IWL_MA_A_GF4_A_FW_PRE		"iwlwifi-ma-a0-gf4-a0-"
 #define IWL_MA_A_MR_A_FW_PRE		"iwlwifi-ma-a0-mr-a0-"
+#define IWL_MA_A_FM_A_FW_PRE		"iwlwifi-ma-a0-fm-a0-"
 #define IWL_SNJ_A_MR_A_FW_PRE		"iwlwifi-SoSnj-a0-mr-a0-"
 #define IWL_BZ_A_HR_B_FW_PRE		"iwlwifi-bz-a0-hr-b0-"
 #define IWL_BZ_A_GF_A_FW_PRE		"iwlwifi-bz-a0-gf-a0-"
@@ -93,6 +94,8 @@
 	IWL_MA_A_GF4_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(api) \
 	IWL_MA_A_MR_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_A_FM_A_FW_MODULE_FIRMWARE(api)		\
+	IWL_MA_A_FM_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_SNJ_A_MR_A_MODULE_FIRMWARE(api) \
 	IWL_SNJ_A_MR_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BZ_A_HR_B_MODULE_FIRMWARE(api) \
@@ -389,6 +392,7 @@ const char iwl_ax201_name[] = "Intel(R) Wi-Fi 6 AX201 160MHz";
 const char iwl_ax203_name[] = "Intel(R) Wi-Fi 6 AX203";
 const char iwl_ax211_name[] = "Intel(R) Wi-Fi 6E AX211 160MHz";
 const char iwl_ax221_name[] = "Intel(R) Wi-Fi 6E AX221 160MHz";
+const char iwl_ax231_name[] = "Intel(R) Wi-Fi 6E AX231 160MHz";
 const char iwl_ax411_name[] = "Intel(R) Wi-Fi 6E AX411 160MHz";
 
 const char iwl_ax200_killer_1650w_name[] =
@@ -724,6 +728,13 @@ const struct iwl_cfg iwl_cfg_ma_a0_mr_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_ma_a0_fm_a0 = {
+	.fw_name_pre = IWL_MA_A_FM_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 const struct iwl_cfg iwl_cfg_snj_a0_mr_a0 = {
 	.fw_name_pre = IWL_SNJ_A_MR_A_FW_PRE,
 	.uhb_supported = true,
@@ -797,6 +808,7 @@ MODULE_FIRMWARE(IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_A_GF_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_A_GF4_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_A_FM_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SNJ_A_MR_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index b35ffdfdf14b..fc2ba1ce4370 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -426,6 +426,7 @@ struct iwl_cfg {
 #define IWL_CFG_RF_TYPE_HR1		0x10C
 #define IWL_CFG_RF_TYPE_GF		0x10D
 #define IWL_CFG_RF_TYPE_MR		0x110
+#define IWL_CFG_RF_TYPE_FM		0x112
 
 #define IWL_CFG_RF_ID_TH		0x1
 #define IWL_CFG_RF_ID_TH1		0x1
@@ -507,6 +508,7 @@ extern const char iwl_ax210_killer_1675w_name[];
 extern const char iwl_ax210_killer_1675x_name[];
 extern const char iwl_ax211_name[];
 extern const char iwl_ax221_name[];
+extern const char iwl_ax231_name[];
 extern const char iwl_ax411_name[];
 #if IS_ENABLED(CONFIG_IWLDVM)
 extern const struct iwl_cfg iwl5300_agn_cfg;
@@ -613,6 +615,7 @@ extern const struct iwl_cfg iwl_cfg_ma_a0_hr_b0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_gf4_a0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_mr_a0;
+extern const struct iwl_cfg iwl_cfg_ma_a0_fm_a0;
 extern const struct iwl_cfg iwl_cfg_snj_a0_mr_a0;
 extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0;
 extern const struct iwl_cfg iwl_cfg_quz_a0_hr_b0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 8da0d03bcff5..821dc6894155 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1029,6 +1029,11 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_ma_a0_mr_a0, iwl_ax221_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      iwl_cfg_ma_a0_fm_a0, iwl_ax231_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY,
-- 
2.32.0.rc2

