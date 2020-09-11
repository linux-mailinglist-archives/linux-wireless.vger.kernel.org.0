Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B570C2667DE
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Sep 2020 19:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgIKRyj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Sep 2020 13:54:39 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50250 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725955AbgIKRyV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Sep 2020 13:54:21 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kGn6P-0028eU-DQ; Fri, 11 Sep 2020 20:44:49 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 11 Sep 2020 20:44:38 +0300
Message-Id: <iwlwifi.20200911204056.21397978115f.Id2d95275a36a6bb6b226d12cb6c5a629334587db@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911174439.163225-1-luca@coelho.fi>
References: <20200911174439.163225-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 10/11] iwlwifi: add new cards for AX201 family
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ihab Zhaika <ihab.zhaika@intel.com>

add few PCI ID'S for AX201 family including killer cards.

Signed-off-by: Ihab Zhaika <ihab.zhaika@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  | 17 +++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  4 +++-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 15 +++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index efe427049a6e..df7346eed14f 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -89,6 +89,7 @@
 #define IWL_SO_A_GF4_A_FW_PRE		"iwlwifi-so-a0-gf4-a0-"
 #define IWL_SNJ_A_GF4_A_FW_PRE		"iwlwifi-SoSnj-a0-gf4-a0-"
 #define IWL_SNJ_A_GF_A_FW_PRE		"iwlwifi-SoSnj-a0-gf-a0-"
+#define IWL_SNJ_A_HR_B_FW_PRE		"iwlwifi-SoSnj-a0-hr-b0-"
 
 #define IWL_QU_B_HR_B_MODULE_FIRMWARE(api) \
 	IWL_QU_B_HR_B_FW_PRE __stringify(api) ".ucode"
@@ -118,6 +119,8 @@
 	IWL_SNJ_A_GF4_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_SNJ_A_GF_A_MODULE_FIRMWARE(api) \
 	IWL_SNJ_A_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_SNJ_A_HR_B_MODULE_FIRMWARE(api) \
+	IWL_SNJ_A_HR_B_FW_PRE __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_22000_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
@@ -343,6 +346,10 @@ const char iwl_ax200_killer_1650w_name[] =
 	"Killer(R) Wi-Fi 6 AX1650w 160MHz Wireless Network Adapter (200D2W)";
 const char iwl_ax200_killer_1650x_name[] =
 	"Killer(R) Wi-Fi 6 AX1650x 160MHz Wireless Network Adapter (200NGW)";
+const char iwl_ax201_killer_1650s_name[] =
+	"Killer(R) Wi-Fi 6 AX1650s 160MHz Wireless Network Adapter (201D2W)";
+const char iwl_ax201_killer_1650i_name[] =
+	"Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201NGW)";
 
 const struct iwl_cfg iwl_qu_b0_hr1_b0 = {
 	.fw_name_pre = IWL_QU_B_HR_B_FW_PRE,
@@ -598,6 +605,14 @@ const struct iwl_cfg iwlax211_cfg_snj_gf_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwlax201_cfg_snj_hr_b0 = {
+	.name = iwl_ax201_name,
+	.fw_name_pre = IWL_QU_B_HR_B_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QNJ_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
@@ -612,3 +627,5 @@ MODULE_FIRMWARE(IWL_SO_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_TY_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SNJ_A_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SNJ_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SNJ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index e27c13263a23..64e4ba4d96fc 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -543,7 +543,8 @@ extern const char iwl_ax201_name[];
 extern const char iwl_ax101_name[];
 extern const char iwl_ax200_killer_1650w_name[];
 extern const char iwl_ax200_killer_1650x_name[];
-
+extern const char iwl_ax201_killer_1650s_name[];
+extern const char iwl_ax201_killer_1650i_name[];
 #if IS_ENABLED(CONFIG_IWLDVM)
 extern const struct iwl_cfg iwl5300_agn_cfg;
 extern const struct iwl_cfg iwl5100_agn_cfg;
@@ -641,6 +642,7 @@ extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0;
 extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long;
 extern const struct iwl_cfg iwlax411_2ax_cfg_sosnj_gf4_a0;
 extern const struct iwl_cfg iwlax211_cfg_snj_gf_a0;
+extern const struct iwl_cfg iwlax201_cfg_snj_hr_b0;
 #endif /* CONFIG_IWLMVM */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index e02bafb8921f..72bb2b38e5b6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -540,15 +540,24 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2725, 0x0510, iwlax210_2ax_cfg_ty_gf_a0)},
 	{IWL_PCI_DEVICE(0x2725, 0x0A10, iwlax210_2ax_cfg_ty_gf_a0)},
 	{IWL_PCI_DEVICE(0x2725, 0x00B0, iwlax411_2ax_cfg_sosnj_gf4_a0)},
+	{IWL_PCI_DEVICE(0x2726, 0x0070, iwlax201_cfg_snj_hr_b0)},
+	{IWL_PCI_DEVICE(0x2726, 0x0074, iwlax201_cfg_snj_hr_b0)},
+	{IWL_PCI_DEVICE(0x2726, 0x0078, iwlax201_cfg_snj_hr_b0)},
+	{IWL_PCI_DEVICE(0x2726, 0x007C, iwlax201_cfg_snj_hr_b0)},
 	{IWL_PCI_DEVICE(0x2726, 0x0090, iwlax211_cfg_snj_gf_a0)},
+	{IWL_PCI_DEVICE(0x2726, 0x0098, iwlax211_cfg_snj_gf_a0)},
 	{IWL_PCI_DEVICE(0x2726, 0x00B0, iwlax411_2ax_cfg_sosnj_gf4_a0)},
 	{IWL_PCI_DEVICE(0x2726, 0x0510, iwlax211_cfg_snj_gf_a0)},
+	{IWL_PCI_DEVICE(0x2726, 0x2074, iwlax201_cfg_snj_hr_b0)},
+	{IWL_PCI_DEVICE(0x2726, 0x4070, iwlax201_cfg_snj_hr_b0)},
 	{IWL_PCI_DEVICE(0x7A70, 0x0090, iwlax211_2ax_cfg_so_gf_a0_long)},
+	{IWL_PCI_DEVICE(0x7A70, 0x0098, iwlax211_2ax_cfg_so_gf_a0_long)},
 	{IWL_PCI_DEVICE(0x7A70, 0x00B0, iwlax411_2ax_cfg_so_gf4_a0_long)},
 	{IWL_PCI_DEVICE(0x7A70, 0x0310, iwlax211_2ax_cfg_so_gf_a0_long)},
 	{IWL_PCI_DEVICE(0x7A70, 0x0510, iwlax211_2ax_cfg_so_gf_a0_long)},
 	{IWL_PCI_DEVICE(0x7A70, 0x0A10, iwlax211_2ax_cfg_so_gf_a0_long)},
 	{IWL_PCI_DEVICE(0x7AF0, 0x0090, iwlax211_2ax_cfg_so_gf_a0)},
+	{IWL_PCI_DEVICE(0x7AF0, 0x0098, iwlax211_2ax_cfg_so_gf_a0)},
 	{IWL_PCI_DEVICE(0x7AF0, 0x00B0, iwlax411_2ax_cfg_so_gf4_a0)},
 	{IWL_PCI_DEVICE(0x7AF0, 0x0310, iwlax211_2ax_cfg_so_gf_a0)},
 	{IWL_PCI_DEVICE(0x7AF0, 0x0510, iwlax211_2ax_cfg_so_gf_a0)},
@@ -595,6 +604,12 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	/* QnJ with Hr */
 	IWL_DEV_INFO(0x2720, IWL_CFG_ANY, iwl_qnj_b0_hr_b0_cfg, iwl_ax201_name),
 
+	/* SnJ with HR*/
+	IWL_DEV_INFO(0x2726, 0x0244, iwlax201_cfg_snj_hr_b0, iwl_ax101_name),
+	IWL_DEV_INFO(0x2726, 0x1651, iwlax201_cfg_snj_hr_b0, iwl_ax201_killer_1650s_name),
+	IWL_DEV_INFO(0x2726, 0x1652, iwlax201_cfg_snj_hr_b0, iwl_ax201_killer_1650i_name),
+	IWL_DEV_INFO(0x2726, 0x4244, iwlax201_cfg_snj_hr_b0, iwl_ax101_name),
+
 	/* Qu with Hr */
 	IWL_DEV_INFO(0x43F0, 0x0070, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x43F0, 0x0074, iwl_ax201_cfg_qu_hr, NULL),
-- 
2.28.0

