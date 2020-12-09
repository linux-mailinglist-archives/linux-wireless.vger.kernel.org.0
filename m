Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1852D4CF2
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 22:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388221AbgLIVfU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 16:35:20 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35882 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733021AbgLIVfN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 16:35:13 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn6pw-003Drx-Is; Wed, 09 Dec 2020 23:17:25 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 23:16:45 +0200
Message-Id: <iwlwifi.20201209231352.101ac3058c04.Idd28706b122cdc8103956f8e72bb062fe4adb54e@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209211651.968276-1-luca@coelho.fi>
References: <20201209211651.968276-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 41/47] iwlwifi: Add a new card for MA family
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Matti Gottlieb <matti.gottlieb@intel.com>

Add a PCI ID for snj with mr in AX family.

Signed-off-by: Matti Gottlieb <matti.gottlieb@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  | 11 +++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  2 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   |  6 ++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index d24dcacd1434..7220fc8fd9b0 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -44,6 +44,7 @@
 #define IWL_SNJ_A_HR_B_FW_PRE		"iwlwifi-SoSnj-a0-hr-b0-"
 #define IWL_MA_A_GF_A_FW_PRE		"iwlwifi-ma-a0-gf-a0-"
 #define IWL_MA_A_MR_A_FW_PRE		"iwlwifi-ma-a0-mr-a0-"
+#define IWL_SNJ_A_MR_A_FW_PRE		"iwlwifi-SoSnj-a0-mr-a0-"
 
 #define IWL_QU_B_HR_B_MODULE_FIRMWARE(api) \
 	IWL_QU_B_HR_B_FW_PRE __stringify(api) ".ucode"
@@ -79,6 +80,8 @@
 	IWL_MA_A_GF_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(api) \
 	IWL_MA_A_MR_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_SNJ_A_MR_A_MODULE_FIRMWARE(api) \
+	IWL_SNJ_A_MR_A_FW_PRE __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_22000_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
@@ -600,6 +603,13 @@ const struct iwl_cfg iwl_cfg_ma_a0_mr_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_snj_a0_mr_a0 = {
+	.fw_name_pre = IWL_SNJ_A_MR_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QNJ_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
@@ -617,3 +627,4 @@ MODULE_FIRMWARE(IWL_SNJ_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SNJ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_A_GF_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_MA_A_MR_A_FW_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SNJ_A_MR_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 0217ab058d83..516890727b25 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -418,6 +418,7 @@ struct iwl_cfg {
 #define IWL_CFG_MAC_TYPE_QU		0x33
 #define IWL_CFG_MAC_TYPE_QUZ		0x35
 #define IWL_CFG_MAC_TYPE_QNJ		0x36
+#define IWL_CFG_MAC_TYPE_SNJ		0x42
 #define IWL_CFG_MAC_TYPE_MA		0x44
 
 #define IWL_CFG_RF_TYPE_TH		0x105
@@ -599,6 +600,7 @@ extern const struct iwl_cfg iwlax211_cfg_snj_gf_a0;
 extern const struct iwl_cfg iwlax201_cfg_snj_hr_b0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_mr_a0;
+extern const struct iwl_cfg iwl_cfg_snj_a0_mr_a0;
 #endif /* CONFIG_IWLMVM */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 31ab00bc7dc4..236bea9663d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -930,6 +930,12 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY,
 		      IWL_CFG_ANY, IWL_CFG_ANY,
 		      iwl_cfg_ma_a0_mr_a0, iwl_ma_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY,
+		      iwl_cfg_snj_a0_mr_a0, iwl_ma_name),
+
 
 #endif /* CONFIG_IWLMVM */
 };
-- 
2.29.2

