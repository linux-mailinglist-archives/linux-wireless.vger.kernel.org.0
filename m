Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6B53166CD
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 13:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhBJMd3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 07:33:29 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45108 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231939AbhBJMat (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 07:30:49 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9och-0049Yg-5J; Wed, 10 Feb 2021 14:29:35 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 14:29:24 +0200
Message-Id: <iwlwifi.20210210142629.f8e3080ce633.I7377b421b031796730daf809c4024a3c3ef95fa8@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210122927.315774-1-luca@coelho.fi>
References: <20210210122927.315774-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 09/12] iwlwifi: pcie: add AX201 and AX211 radio modules for Ma devices
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Matti Gottlieb <matti.gottlieb@intel.com>

Add support for AX201 and AX211 radio modules, which we call HR2 and
GF, respectively.  These modules can be used with the Ma family of
devices and above.

Signed-off-by: Matti Gottlieb <matti.gottlieb@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 22 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  2 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 10 +++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index d1e9fcba9645..f27fb46f82d8 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -43,7 +43,9 @@
 #define IWL_SNJ_A_GF_A_FW_PRE		"iwlwifi-SoSnj-a0-gf-a0-"
 #define IWL_SNJ_A_HR_B_FW_PRE		"iwlwifi-SoSnj-a0-hr-b0-"
 #define IWL_SNJ_A_JF_B_FW_PRE		"iwlwifi-SoSnj-a0-jf-b0-"
+#define IWL_MA_A_HR_B_FW_PRE		"iwlwifi-ma-a0-hr-b0-"
 #define IWL_MA_A_GF_A_FW_PRE		"iwlwifi-ma-a0-gf-a0-"
+#define IWL_MA_A_GF4_A_FW_PRE		"iwlwifi-ma-a0-gf4-a0-"
 #define IWL_MA_A_MR_A_FW_PRE		"iwlwifi-ma-a0-mr-a0-"
 #define IWL_SNJ_A_MR_A_FW_PRE		"iwlwifi-SoSnj-a0-mr-a0-"
 
@@ -79,8 +81,12 @@
 	IWL_SNJ_A_HR_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_SNJ_A_JF_B_MODULE_FIRMWARE(api) \
 	IWL_SNJ_A_JF_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(api)		\
+	IWL_MA_A_HR_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_MA_A_GF_A_FW_MODULE_FIRMWARE(api)		\
 	IWL_MA_A_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_MA_A_GF4_A_FW_MODULE_FIRMWARE(api)		\
+	IWL_MA_A_GF4_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(api) \
 	IWL_MA_A_MR_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_SNJ_A_MR_A_MODULE_FIRMWARE(api) \
@@ -661,6 +667,13 @@ const struct iwl_cfg iwl_cfg_snj_a0_jf_b0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_ma_a0_hr_b0 = {
+	.fw_name_pre = IWL_MA_A_HR_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 const struct iwl_cfg iwl_cfg_ma_a0_gf_a0 = {
 	.fw_name_pre = IWL_MA_A_GF_A_FW_PRE,
 	.uhb_supported = true,
@@ -668,6 +681,13 @@ const struct iwl_cfg iwl_cfg_ma_a0_gf_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_ma_a0_gf4_a0 = {
+	.fw_name_pre = IWL_MA_A_GF4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 const struct iwl_cfg iwl_cfg_ma_a0_mr_a0 = {
 	.fw_name_pre = IWL_MA_A_MR_A_FW_PRE,
 	.uhb_supported = true,
@@ -716,6 +736,8 @@ MODULE_FIRMWARE(IWL_SNJ_A_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SNJ_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SNJ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SNJ_A_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_A_HR_B_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_A_GF_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_MA_A_GF4_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SNJ_A_MR_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 4a8f7489fc4d..605628a67c6a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -610,7 +610,9 @@ extern const struct iwl_cfg iwlax411_2ax_cfg_sosnj_gf4_a0;
 extern const struct iwl_cfg iwlax211_cfg_snj_gf_a0;
 extern const struct iwl_cfg iwl_cfg_snj_hr_b0;
 extern const struct iwl_cfg iwl_cfg_snj_a0_jf_b0;
+extern const struct iwl_cfg iwl_cfg_ma_a0_hr_b0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_gf_a0;
+extern const struct iwl_cfg iwl_cfg_ma_a0_gf4_a0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_mr_a0;
 extern const struct iwl_cfg iwl_cfg_snj_a0_mr_a0;
 extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 80d17f0ca3fe..314fec4a89ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -994,11 +994,21 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      iwl_cfg_snj_hr_b0, iwl_ax201_name),
 
 /* Ma */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      iwl_cfg_ma_a0_hr_b0, iwl_ax201_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_ma_a0_gf_a0, iwl_ax211_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB,
+		      iwl_cfg_ma_a0_gf4_a0, iwl_ax211_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY,
-- 
2.30.0

