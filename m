Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4674682F5
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 07:36:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240659AbhLDGjc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 01:39:32 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50290 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238276AbhLDGjb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 01:39:31 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtOeS-0017AH-Rb; Sat, 04 Dec 2021 08:36:05 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 08:35:47 +0200
Message-Id: <iwlwifi.20211204083238.fc8626515758.Ibfeffc8bb071f9773ea189992ebef056f51be1be@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204063555.769822-1-luca@coelho.fi>
References: <20211204063555.769822-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 04/12] iwlwifi: add support for Bz-Z HW
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mike Golant <michael.golant@intel.com>

Add support for Bz Z step HW with GF RF.

Signed-off-by: Mike Golant <michael.golant@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  | 10 ++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  1 +
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h    |  1 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   |  7 +++++++
 4 files changed, 19 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 1572097bccf1..7a06bbae178b 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -55,6 +55,7 @@
 #define IWL_BZ_A_MR_A_FW_PRE		"iwlwifi-bz-a0-mr-a0-"
 #define IWL_BZ_A_FM_A_FW_PRE		"iwlwifi-bz-a0-fm-a0-"
 #define IWL_GL_A_FM_A_FW_PRE		"iwlwifi-gl-a0-fm7-a0-"
+#define IWL_BZ_Z_GF_A_FW_PRE		"iwlwifi-bz-z0-gf-a0-"
 
 
 #define IWL_QU_B_HR_B_MODULE_FIRMWARE(api) \
@@ -113,6 +114,8 @@
 		IWL_BZ_A_FM_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_GL_A_FM_A_MODULE_FIRMWARE(api) \
 		IWL_GL_A_FM_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_Z_GF_A_MODULE_FIRMWARE(api) \
+	IWL_BZ_Z_GF_A_FW_PRE __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_22000_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
@@ -879,6 +882,13 @@ const struct iwl_cfg iwl_cfg_gl_a0_fm_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_bz_z0_gf_a0 = {
+	.fw_name_pre = IWL_BZ_Z_GF_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QNJ_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 665167a223f6..d704e278b577 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -634,6 +634,7 @@ extern const struct iwl_cfg iwl_cfg_bz_a0_gf4_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_mr_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_fm_a0;
 extern const struct iwl_cfg iwl_cfg_gl_a0_fm_a0;
+extern const struct iwl_cfg iwl_cfg_bz_z0_gf_a0;
 #endif /* CONFIG_IWLMVM */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index cfea20e507b3..046a01f5988b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -304,6 +304,7 @@ enum {
 	SILICON_A_STEP = 0,
 	SILICON_B_STEP,
 	SILICON_C_STEP,
+	SILICON_Z_STEP = 0xf,
 };
 
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index db8b62e432eb..93d789670f89 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1130,6 +1130,13 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_gl_a0_fm_a0, iwl_bz_name),
 
+/* BZ Z step */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, SILICON_Z_STEP,
+		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      iwl_cfg_bz_z0_gf_a0, iwl_bz_name),
+
 /* SoF with JF2 */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
-- 
2.33.1

