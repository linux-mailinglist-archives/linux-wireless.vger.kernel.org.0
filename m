Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCEA41AEAB4
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Apr 2020 10:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgDRIJZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Apr 2020 04:09:25 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:56770 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725887AbgDRIJV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Apr 2020 04:09:21 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jPiXO-000L3r-19; Sat, 18 Apr 2020 11:09:18 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 18 Apr 2020 11:08:51 +0300
Message-Id: <iwlwifi.20200418110539.5eae2261b70c.I0369619a562c4e4008e2f0a3afb9ed5d4c9b49d4@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200418080857.2232093-1-luca@coelho.fi>
References: <20200418080857.2232093-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 06/12] iwlwifi: add new cards for AX family
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ihab Zhaika <ihab.zhaika@intel.com>

add few PCI ID'S for AX family.

Signed-off-by: Ihab Zhaika <ihab.zhaika@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 21 ++++++++++++++++---
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  1 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  7 ++++++-
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index bc49cdd819df..1af4ba2d30cb 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -90,7 +90,8 @@
 #define IWL_22000_SO_A_GF_A_FW_PRE      "iwlwifi-so-a0-gf-a0-"
 #define IWL_22000_TY_A_GF_A_FW_PRE      "iwlwifi-ty-a0-gf-a0-"
 #define IWL_22000_SO_A_GF4_A_FW_PRE     "iwlwifi-so-a0-gf4-a0-"
-#define IWL_22000_SOSNJ_A_GF4_A_FW_PRE  "iwlwifi-SoSnj-a0-gf4-a0-"
+#define IWL_SNJ_A_GF4_A_FW_PRE		"iwlwifi-SoSnj-a0-gf4-a0-"
+#define IWL_SNJ_A_GF_A_FW_PRE		"iwlwifi-SoSnj-a0-gf-a0-"
 
 #define IWL_22000_HR_MODULE_FIRMWARE(api) \
 	IWL_22000_HR_FW_PRE __stringify(api) ".ucode"
@@ -120,6 +121,10 @@
 	IWL_22000_SO_A_GF_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_22000_TY_A_GF_A_MODULE_FIRMWARE(api) \
 	IWL_22000_TY_A_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_SNJ_A_GF4_A_MODULE_FIRMWARE(api) \
+	IWL_SNJ_A_GF4_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_SNJ_A_GF_A_MODULE_FIRMWARE(api) \
+	IWL_SNJ_A_GF_A_FW_PRE __stringify(api) ".ucode"
 
 static const struct iwl_base_params iwl_22000_base_params = {
 	.eeprom_size = OTP_LOW_IMAGE_SIZE_32K,
@@ -553,8 +558,16 @@ const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0 = {
 };
 
 const struct iwl_cfg iwlax411_2ax_cfg_sosnj_gf4_a0 = {
-	.name = "Intel(R) Wi-Fi 7 AX411 160MHz",
-	.fw_name_pre = IWL_22000_SOSNJ_A_GF4_A_FW_PRE,
+	.name = "Intel(R) Wi-Fi 6 AX411 160MHz",
+	.fw_name_pre = IWL_SNJ_A_GF4_A_FW_PRE,
+	.uhb_supported = true,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwlax211_cfg_snj_gf_a0 = {
+	.name = "Intel(R) Wi-Fi 6 AX211 160MHz",
+	.fw_name_pre = IWL_SNJ_A_GF_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
@@ -573,3 +586,5 @@ MODULE_FIRMWARE(IWL_22000_SO_A_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_22000_SO_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_22000_SO_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_22000_TY_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SNJ_A_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SNJ_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index d5d984d7ce83..3ed8ead8a9bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -625,6 +625,7 @@ extern const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0;
 extern const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0;
 extern const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0;
 extern const struct iwl_cfg iwlax411_2ax_cfg_sosnj_gf4_a0;
+extern const struct iwl_cfg iwlax211_cfg_snj_gf_a0;
 #endif /* CPTCFG_IWLMVM || CPTCFG_IWLFMAC */
 
 #endif /* __IWL_CONFIG_H__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 6744c0281ffb..ab849aa4434e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -539,12 +539,17 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2725, 0x0310, iwlax210_2ax_cfg_ty_gf_a0)},
 	{IWL_PCI_DEVICE(0x2725, 0x0510, iwlax210_2ax_cfg_ty_gf_a0)},
 	{IWL_PCI_DEVICE(0x2725, 0x0A10, iwlax210_2ax_cfg_ty_gf_a0)},
-	{IWL_PCI_DEVICE(0x2725, 0x00B0, iwlax411_2ax_cfg_so_gf4_a0)},
+	{IWL_PCI_DEVICE(0x2725, 0x00B0, iwlax411_2ax_cfg_sosnj_gf4_a0)},
+	{IWL_PCI_DEVICE(0x2726, 0x0090, iwlax211_cfg_snj_gf_a0)},
+	{IWL_PCI_DEVICE(0x2726, 0x00B0, iwlax411_2ax_cfg_sosnj_gf4_a0)},
+	{IWL_PCI_DEVICE(0x2726, 0x0510, iwlax211_cfg_snj_gf_a0)},
 	{IWL_PCI_DEVICE(0x7A70, 0x0090, iwlax211_2ax_cfg_so_gf_a0)},
+	{IWL_PCI_DEVICE(0x7A70, 0x00B0, iwlax411_2ax_cfg_so_gf4_a0)},
 	{IWL_PCI_DEVICE(0x7A70, 0x0310, iwlax211_2ax_cfg_so_gf_a0)},
 	{IWL_PCI_DEVICE(0x7A70, 0x0510, iwlax211_2ax_cfg_so_gf_a0)},
 	{IWL_PCI_DEVICE(0x7A70, 0x0A10, iwlax211_2ax_cfg_so_gf_a0)},
 	{IWL_PCI_DEVICE(0x7AF0, 0x0090, iwlax211_2ax_cfg_so_gf_a0)},
+	{IWL_PCI_DEVICE(0x7AF0, 0x00B0, iwlax411_2ax_cfg_so_gf4_a0)},
 	{IWL_PCI_DEVICE(0x7AF0, 0x0310, iwlax211_2ax_cfg_so_gf_a0)},
 	{IWL_PCI_DEVICE(0x7AF0, 0x0510, iwlax211_2ax_cfg_so_gf_a0)},
 	{IWL_PCI_DEVICE(0x7AF0, 0x0A10, iwlax211_2ax_cfg_so_gf_a0)},
-- 
2.25.1

