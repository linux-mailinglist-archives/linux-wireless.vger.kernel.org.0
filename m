Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1913F2A89
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 13:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239410AbhHTLEZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 07:04:25 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57582 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239649AbhHTLEQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 07:04:16 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mH2J9-002IL4-63; Fri, 20 Aug 2021 14:03:32 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 20 Aug 2021 14:03:17 +0300
Message-Id: <iwlwifi.20210820140104.7cc54e0d4a58.I4f2a547dc04c3d14cacdbc739da0b056fc04923d@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210820110318.260751-1-luca@coelho.fi>
References: <20210820110318.260751-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 11/12] iwlwifi: Add support for more BZ HWs
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Matti Gottlieb <matti.gottlieb@intel.com>

Add support for GA and for BZ with FM rf.

Signed-off-by: Matti Gottlieb <matti.gottlieb@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 23 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  3 +++
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  1 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 14 +++++++++++
 4 files changed, 41 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 52d1d391f4c6..1950482b3829 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -53,6 +53,9 @@
 #define IWL_BZ_A_GF_A_FW_PRE		"iwlwifi-bz-a0-gf-a0-"
 #define IWL_BZ_A_GF4_A_FW_PRE		"iwlwifi-bz-a0-gf4-a0-"
 #define IWL_BZ_A_MR_A_FW_PRE		"iwlwifi-bz-a0-mr-a0-"
+#define IWL_BZ_A_FM_A_FW_PRE		"iwlwifi-bz-a0-fm-a0-"
+#define IWL_GL_A_FM_A_FW_PRE		"iwlwifi-gl-a0-fm7-a0-"
+
 
 #define IWL_QU_B_HR_B_MODULE_FIRMWARE(api) \
 	IWL_QU_B_HR_B_FW_PRE __stringify(api) ".ucode"
@@ -106,6 +109,10 @@
 	IWL_BZ_A_GF4_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BZ_A_MR_A_MODULE_FIRMWARE(api) \
 	IWL_BZ_A_MR_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_BZ_A_FM_A_MODULE_FIRMWARE(api) \
+		IWL_BZ_A_FM_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_GL_A_FM_A_MODULE_FIRMWARE(api) \
+		IWL_GL_A_FM_A_FW_PRE __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_22000_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
@@ -850,6 +857,20 @@ const struct iwl_cfg iwl_cfg_bz_a0_mr_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_bz_a0_fm_a0 = {
+	.fw_name_pre = IWL_BZ_A_FM_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_gl_a0_fm_a0 = {
+	.fw_name_pre = IWL_GL_A_FM_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_BZ,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QNJ_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
@@ -876,3 +897,5 @@ MODULE_FIRMWARE(IWL_BZ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_BZ_A_MR_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_BZ_A_FM_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_GL_A_FM_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 7eb534df5331..f55f08d4d511 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -420,6 +420,7 @@ struct iwl_cfg {
 #define IWL_CFG_MAC_TYPE_SOF		0x43
 #define IWL_CFG_MAC_TYPE_MA		0x44
 #define IWL_CFG_MAC_TYPE_BZ		0x46
+#define IWL_CFG_MAC_TYPE_GL		0x47
 
 #define IWL_CFG_RF_TYPE_TH		0x105
 #define IWL_CFG_RF_TYPE_TH1		0x108
@@ -628,6 +629,8 @@ extern const struct iwl_cfg iwl_cfg_bz_a0_hr_b0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_gf4_a0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_mr_a0;
+extern const struct iwl_cfg iwl_cfg_bz_a0_fm_a0;
+extern const struct iwl_cfg iwl_cfg_gl_a0_fm_a0;
 #endif /* CONFIG_IWLMVM */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 972f8ba7a95f..2ab5315dd803 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -440,6 +440,7 @@ struct iwl_crf_chip_id_reg {
 #define REG_CRF_ID_TYPE_GF			0x410
 #define REG_CRF_ID_TYPE_GF_TC			0xF08
 #define REG_CRF_ID_TYPE_MR			0x810
+#define REG_CRF_ID_TYPE_FM			0x910
 
 #define HPM_DEBUG			0xA03440
 #define PERSISTENCE_BIT			BIT(12)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 01011aa01bbf..3942924b8d1f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1109,6 +1109,17 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_bz_a0_mr_a0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_BZ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      iwl_cfg_bz_a0_fm_a0, iwl_bz_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_GL, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_FM, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
+		      iwl_cfg_gl_a0_fm_a0, iwl_bz_name),
+
 
 /* So with GF */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
@@ -1179,6 +1190,9 @@ static int get_crf_id(struct iwl_trans *iwl_trans)
 		case REG_CRF_ID_TYPE_MR:
 			iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_MR << 12);
 			break;
+		case REG_CRF_ID_TYPE_FM:
+			iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_FM << 12);
+			break;
 		default:
 			ret = -EIO;
 			IWL_ERR(iwl_trans,
-- 
2.33.0

