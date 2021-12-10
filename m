Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2CFE46FB13
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 08:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbhLJHKG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 02:10:06 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50834 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234781AbhLJHKG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 02:10:06 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mvZzC-001F9v-8f; Fri, 10 Dec 2021 09:06:30 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 10 Dec 2021 09:06:17 +0200
Message-Id: <iwlwifi.20211210090244.e94c1f921245.I8cba209b1366dc0636a04711fc6a85539ca878d0@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210070621.236783-1-luca@coelho.fi>
References: <20211210070621.236783-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 07/11] iwlwifi: add support for BNJ HW
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mike Golant <michael.golant@intel.com>

Add support for BNJ HW with GF, GF4, HR1, FM and FM4 RF modules

Signed-off-by: Mike Golant <michael.golant@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 54 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  5 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 29 +++++++++-
 3 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index b1ad0e1c472a..23e2a28b3aa8 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -56,6 +56,11 @@
 #define IWL_BZ_A_FM_A_FW_PRE		"iwlwifi-bz-a0-fm-a0-"
 #define IWL_GL_A_FM_A_FW_PRE		"iwlwifi-gl-a0-fm-a0-"
 #define IWL_BZ_Z_GF_A_FW_PRE		"iwlwifi-bz-z0-gf-a0-"
+#define IWL_BNJ_A_FM_A_FW_PRE		"iwlwifi-BzBnj-a0-fm-a0-"
+#define IWL_BNJ_A_FM4_A_FW_PRE		"iwlwifi-BzBnj-a0-fm4-a0-"
+#define IWL_BNJ_A_GF_A_FW_PRE		"iwlwifi-BzBnj-a0-gf-a0-"
+#define IWL_BNJ_A_GF4_A_FW_PRE		"iwlwifi-BzBnj-a0-gf4-a0-"
+#define IWL_BNJ_A_HR_B_FW_PRE		"iwlwifi-BzBnj-a0-hr-b0-"
 
 
 #define IWL_QU_B_HR_B_MODULE_FIRMWARE(api) \
@@ -116,6 +121,16 @@
 		IWL_GL_A_FM_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BZ_Z_GF_A_MODULE_FIRMWARE(api) \
 	IWL_BZ_Z_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_A_FM_A_MODULE_FIRMWARE(api) \
+	IWL_BNJ_A_FM_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_A_FM4_A_MODULE_FIRMWARE(api) \
+	IWL_BNJ_A_FM4_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_A_GF_A_MODULE_FIRMWARE(api) \
+	IWL_BNJ_A_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_A_GF4_A_MODULE_FIRMWARE(api) \
+	IWL_BNJ_A_GF4_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BNJ_A_HR_B_MODULE_FIRMWARE(api) \
+	IWL_BNJ_A_HR_B_FW_PRE __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_22000_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
@@ -882,6 +897,40 @@ const struct iwl_cfg iwl_cfg_bz_z0_gf_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_bnj_a0_fm_a0 = {
+	.fw_name_pre = IWL_BNJ_A_FM_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bnj_a0_fm4_a0 = {
+	.fw_name_pre = IWL_BNJ_A_FM4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bnj_a0_gf_a0 = {
+	.fw_name_pre = IWL_BNJ_A_GF_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bnj_a0_gf4_a0 = {
+	.fw_name_pre = IWL_BNJ_A_GF4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_bnj_a0_hr_b0 = {
+	.fw_name_pre = IWL_BNJ_A_HR_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
 MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QNJ_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
@@ -910,3 +959,8 @@ MODULE_FIRMWARE(IWL_BZ_A_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_MR_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_FM_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_GL_A_FM_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_A_FM_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_A_FM4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_A_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BNJ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index ff739fec53ab..17a172556a92 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -638,6 +638,11 @@ extern const struct iwl_cfg iwl_cfg_bz_a0_mr_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_fm_a0;
 extern const struct iwl_cfg iwl_cfg_gl_a0_fm_a0;
 extern const struct iwl_cfg iwl_cfg_bz_z0_gf_a0;
+extern const struct iwl_cfg iwl_cfg_bnj_a0_fm_a0;
+extern const struct iwl_cfg iwl_cfg_bnj_a0_fm4_a0;
+extern const struct iwl_cfg iwl_cfg_bnj_a0_gf_a0;
+extern const struct iwl_cfg iwl_cfg_bnj_a0_gf4_a0;
+extern const struct iwl_cfg iwl_cfg_bnj_a0_hr_b0;
 #endif /* CONFIG_IWLMVM */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 3902f2fcb731..57892eb985bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1138,7 +1138,7 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_NO_JACKET,
 		      iwl_cfg_gl_a0_fm_a0, iwl_bz_name),
 
 /* BZ Z step */
@@ -1148,6 +1148,33 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
 		      iwl_cfg_bz_z0_gf_a0, iwl_bz_name),
 
+/* BNJ */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
+		      iwl_cfg_bnj_a0_fm_a0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_IS_JACKET,
+		      iwl_cfg_bnj_a0_fm4_a0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
+		      iwl_cfg_bnj_a0_gf_a0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_CDB, IWL_CFG_IS_JACKET,
+		      iwl_cfg_bnj_a0_gf4_a0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_IS_JACKET,
+		      iwl_cfg_bnj_a0_hr_b0, iwl_bz_name),
+
 /* SoF with JF2 */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-- 
2.34.1

