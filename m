Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F5A1B7C16
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 18:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728713AbgDXQr3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 12:47:29 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58022 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728644AbgDXQr2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 12:47:28 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jS1U5-000OcH-Kh; Fri, 24 Apr 2020 19:47:26 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 19:47:04 +0300
Message-Id: <iwlwifi.20200424194456.21283ca79d82.I57a493c679a56fff11417afdaec76617711ff6a9@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424164707.2715869-1-luca@coelho.fi>
References: <20200424164707.2715869-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 08/11] iwlwifi: pcie: convert QnJ with Hr to the device table
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Convert all the occurrences of QnJ with Hr into a single entry in the
PCI device table.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 14 +++++------
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  4 ++--
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 24 ++++---------------
 3 files changed, 14 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 2fbe0aa3e548..c88394849c86 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -77,7 +77,7 @@
 #define IWL_22000_HR_FW_PRE		"iwlwifi-Qu-a0-hr-a0-"
 #define IWL_22000_HR_CDB_FW_PRE		"iwlwifi-QuIcp-z0-hrcdb-a0-"
 #define IWL_22000_QU_B_HR_B_FW_PRE	"iwlwifi-Qu-b0-hr-b0-"
-#define IWL_22000_HR_B_FW_PRE		"iwlwifi-QuQnj-b0-hr-b0-"
+#define IWL_QNJ_B_HR_B_FW_PRE		"iwlwifi-QuQnj-b0-hr-b0-"
 #define IWL_QU_C_HR_B_FW_PRE		"iwlwifi-Qu-c0-hr-b0-"
 #define IWL_QU_B_JF_B_FW_PRE		"iwlwifi-Qu-b0-jf-b0-"
 #define IWL_QU_C_JF_B_FW_PRE		"iwlwifi-Qu-c0-jf-b0-"
@@ -99,8 +99,8 @@
 	IWL_22000_JF_FW_PRE __stringify(api) ".ucode"
 #define IWL_22000_QU_B_HR_B_MODULE_FIRMWARE(api) \
 	IWL_22000_QU_B_HR_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_22000_HR_B_QNJ_MODULE_FIRMWARE(api)	\
-	IWL_22000_HR_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_QNJ_B_HR_B_MODULE_FIRMWARE(api)	\
+	IWL_QNJ_B_HR_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_QUZ_A_HR_B_MODULE_FIRMWARE(api) \
 	IWL_QUZ_A_HR_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_QUZ_A_JF_B_MODULE_FIRMWARE(api) \
@@ -343,6 +343,7 @@ const struct iwl_cfg_trans_params iwl_ax200_trans_cfg = {
 };
 
 const char iwl_ax200_name[] = "Intel(R) Wi-Fi 6 AX200 160MHz";
+const char iwl_ax201_name[] = "Intel(R) Wi-Fi 6 AX201 160MHz";
 
 const char iwl_ax200_killer_1650w_name[] =
 	"Killer(R) Wi-Fi 6 AX1650w 160MHz Wireless Network Adapter (200D2W)";
@@ -520,9 +521,8 @@ const struct iwl_cfg killer1650i_2ax_cfg_qu_c0_hr_b0 = {
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
-const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_b0 = {
-	.name = "Intel(R) Dual Band Wireless AX 22000",
-	.fw_name_pre = IWL_22000_HR_B_FW_PRE,
+const struct iwl_cfg iwl_qnj_b0_hr_b0_cfg = {
+	.fw_name_pre = IWL_QNJ_B_HR_B_FW_PRE,
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
@@ -609,7 +609,7 @@ const struct iwl_cfg iwlax211_cfg_snj_gf_a0 = {
 
 MODULE_FIRMWARE(IWL_22000_HR_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_22000_JF_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_22000_HR_B_QNJ_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QNJ_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_B_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QUZ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 3a9a33851793..91ec41e0d427 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -535,6 +535,7 @@ extern const char iwl9260_killer_1550_name[];
 extern const char iwl9560_killer_1550i_name[];
 extern const char iwl9560_killer_1550s_name[];
 extern const char iwl_ax200_name[];
+extern const char iwl_ax201_name[];
 extern const char iwl_ax200_killer_1650w_name[];
 extern const char iwl_ax200_killer_1650x_name[];
 
@@ -625,8 +626,7 @@ extern const struct iwl_cfg killer1650s_2ax_cfg_qu_c0_hr_b0;
 extern const struct iwl_cfg killer1650i_2ax_cfg_qu_c0_hr_b0;
 extern const struct iwl_cfg killer1650x_2ax_cfg;
 extern const struct iwl_cfg killer1650w_2ax_cfg;
-extern const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_b0_f0;
-extern const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_b0;
+extern const struct iwl_cfg iwl_qnj_b0_hr_b0_cfg;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_a0;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_hr_a0;
 extern const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 4146526b1278..d5f437ac3c43 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -590,7 +590,10 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x2723, 0x1654, iwl_ax200_cfg_cc, iwl_ax200_killer_1650x_name),
 	IWL_DEV_INFO(0x2723, IWL_CFG_ANY, iwl_ax200_cfg_cc, iwl_ax200_name),
 
-/* Qu with Hr */
+	/* QnJ with Hr */
+	IWL_DEV_INFO(0x2720, IWL_CFG_ANY, iwl_qnj_b0_hr_b0_cfg, iwl_ax201_name),
+
+	/* Qu with Hr */
 	IWL_DEV_INFO(0x43F0, 0x0044, iwl_ax101_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x43F0, 0x0070, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x43F0, 0x0074, iwl_ax201_cfg_qu_hr, NULL),
@@ -675,23 +678,6 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x4DF0, 0x4070, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x4DF0, 0x4244, iwl_ax101_cfg_qu_hr, NULL),
 
-	IWL_DEV_INFO(0x2720, 0x0000, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
-	IWL_DEV_INFO(0x2720, 0x0040, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
-	IWL_DEV_INFO(0x2720, 0x0044, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
-	IWL_DEV_INFO(0x2720, 0x0070, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
-	IWL_DEV_INFO(0x2720, 0x0074, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
-	IWL_DEV_INFO(0x2720, 0x0078, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
-	IWL_DEV_INFO(0x2720, 0x007C, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
-	IWL_DEV_INFO(0x2720, 0x0244, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
-	IWL_DEV_INFO(0x2720, 0x0310, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
-	IWL_DEV_INFO(0x2720, 0x0A10, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
-	IWL_DEV_INFO(0x2720, 0x1080, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
-	IWL_DEV_INFO(0x2720, 0x1651, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
-	IWL_DEV_INFO(0x2720, 0x1652, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
-	IWL_DEV_INFO(0x2720, 0x2074, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
-	IWL_DEV_INFO(0x2720, 0x4070, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
-	IWL_DEV_INFO(0x2720, 0x4244, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
-
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
@@ -789,7 +775,7 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
 		      iwl9260_2ac_cfg, iwl9260_name),
 
-	/* Qu with Jf */
+/* Qu with Jf */
 	/* Qu B step */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
-- 
2.26.2

