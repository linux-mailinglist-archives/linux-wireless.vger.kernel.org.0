Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41331B7C17
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 18:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgDXQra (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 12:47:30 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58030 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728677AbgDXQr3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 12:47:29 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jS1U6-000OcH-Fu; Fri, 24 Apr 2020 19:47:27 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 19:47:05 +0300
Message-Id: <iwlwifi.20200424194456.93cc41bdbb4d.Ib7599901888a2d050f851bd878a875f593f2e8e5@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424164707.2715869-1-luca@coelho.fi>
References: <20200424164707.2715869-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 09/11] iwlwifi: pcie: remove occurrences of 22000 in the FW name defines
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We don't use the number 22000 for our devices anymore, so remove all
occurrences of it in the FW name macros.

While at it, add IWL_QU_B_HR_B to the list of firmwares used by the
driver, which was missing.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 72 +++++++++----------
 1 file changed, 32 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index c88394849c86..b9d13e38f12b 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -73,10 +73,7 @@
 #define IWL_22000_SMEM_OFFSET		0x400000
 #define IWL_22000_SMEM_LEN		0xD0000
 
-#define IWL_22000_JF_FW_PRE		"iwlwifi-Qu-a0-jf-b0-"
-#define IWL_22000_HR_FW_PRE		"iwlwifi-Qu-a0-hr-a0-"
-#define IWL_22000_HR_CDB_FW_PRE		"iwlwifi-QuIcp-z0-hrcdb-a0-"
-#define IWL_22000_QU_B_HR_B_FW_PRE	"iwlwifi-Qu-b0-hr-b0-"
+#define IWL_QU_B_HR_B_FW_PRE		"iwlwifi-Qu-b0-hr-b0-"
 #define IWL_QNJ_B_HR_B_FW_PRE		"iwlwifi-QuQnj-b0-hr-b0-"
 #define IWL_QU_C_HR_B_FW_PRE		"iwlwifi-Qu-c0-hr-b0-"
 #define IWL_QU_B_JF_B_FW_PRE		"iwlwifi-Qu-b0-jf-b0-"
@@ -85,20 +82,16 @@
 #define IWL_QUZ_A_JF_B_FW_PRE		"iwlwifi-QuZ-a0-jf-b0-"
 #define IWL_QNJ_B_JF_B_FW_PRE		"iwlwifi-QuQnj-b0-jf-b0-"
 #define IWL_CC_A_FW_PRE			"iwlwifi-cc-a0-"
-#define IWL_22000_SO_A_JF_B_FW_PRE	"iwlwifi-so-a0-jf-b0-"
-#define IWL_22000_SO_A_HR_B_FW_PRE      "iwlwifi-so-a0-hr-b0-"
-#define IWL_22000_SO_A_GF_A_FW_PRE      "iwlwifi-so-a0-gf-a0-"
-#define IWL_22000_TY_A_GF_A_FW_PRE      "iwlwifi-ty-a0-gf-a0-"
-#define IWL_22000_SO_A_GF4_A_FW_PRE     "iwlwifi-so-a0-gf4-a0-"
+#define IWL_SO_A_JF_B_FW_PRE		"iwlwifi-so-a0-jf-b0-"
+#define IWL_SO_A_HR_B_FW_PRE		"iwlwifi-so-a0-hr-b0-"
+#define IWL_SO_A_GF_A_FW_PRE		"iwlwifi-so-a0-gf-a0-"
+#define IWL_TY_A_GF_A_FW_PRE		"iwlwifi-ty-a0-gf-a0-"
+#define IWL_SO_A_GF4_A_FW_PRE		"iwlwifi-so-a0-gf4-a0-"
 #define IWL_SNJ_A_GF4_A_FW_PRE		"iwlwifi-SoSnj-a0-gf4-a0-"
 #define IWL_SNJ_A_GF_A_FW_PRE		"iwlwifi-SoSnj-a0-gf-a0-"
 
-#define IWL_22000_HR_MODULE_FIRMWARE(api) \
-	IWL_22000_HR_FW_PRE __stringify(api) ".ucode"
-#define IWL_22000_JF_MODULE_FIRMWARE(api) \
-	IWL_22000_JF_FW_PRE __stringify(api) ".ucode"
-#define IWL_22000_QU_B_HR_B_MODULE_FIRMWARE(api) \
-	IWL_22000_QU_B_HR_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_QU_B_HR_B_MODULE_FIRMWARE(api) \
+	IWL_QU_B_HR_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_QNJ_B_HR_B_MODULE_FIRMWARE(api)	\
 	IWL_QNJ_B_HR_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_QUZ_A_HR_B_MODULE_FIRMWARE(api) \
@@ -113,14 +106,14 @@
 	IWL_QNJ_B_JF_B_FW_PRE __stringify(api) ".ucode"
 #define IWL_CC_A_MODULE_FIRMWARE(api)			\
 	IWL_CC_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_22000_SO_A_JF_B_MODULE_FIRMWARE(api) \
-	IWL_22000_SO_A_JF_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_22000_SO_A_HR_B_MODULE_FIRMWARE(api) \
-	IWL_22000_SO_A_HR_B_FW_PRE __stringify(api) ".ucode"
-#define IWL_22000_SO_A_GF_A_MODULE_FIRMWARE(api) \
-	IWL_22000_SO_A_GF_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_22000_TY_A_GF_A_MODULE_FIRMWARE(api) \
-	IWL_22000_TY_A_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_SO_A_JF_B_MODULE_FIRMWARE(api) \
+	IWL_SO_A_JF_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_SO_A_HR_B_MODULE_FIRMWARE(api) \
+	IWL_SO_A_HR_B_FW_PRE __stringify(api) ".ucode"
+#define IWL_SO_A_GF_A_MODULE_FIRMWARE(api) \
+	IWL_SO_A_GF_A_FW_PRE __stringify(api) ".ucode"
+#define IWL_TY_A_GF_A_MODULE_FIRMWARE(api) \
+	IWL_TY_A_GF_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_SNJ_A_GF4_A_MODULE_FIRMWARE(api) \
 	IWL_SNJ_A_GF4_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_SNJ_A_GF_A_MODULE_FIRMWARE(api) \
@@ -352,7 +345,7 @@ const char iwl_ax200_killer_1650x_name[] =
 
 const struct iwl_cfg iwl_ax101_cfg_qu_hr = {
 	.name = "Intel(R) Wi-Fi 6 AX101",
-	.fw_name_pre = IWL_22000_QU_B_HR_B_FW_PRE,
+	.fw_name_pre = IWL_QU_B_HR_B_FW_PRE,
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
@@ -366,7 +359,7 @@ const struct iwl_cfg iwl_ax101_cfg_qu_hr = {
 
 const struct iwl_cfg iwl_ax201_cfg_qu_hr = {
 	.name = "Intel(R) Wi-Fi 6 AX201 160MHz",
-	.fw_name_pre = IWL_22000_QU_B_HR_B_FW_PRE,
+	.fw_name_pre = IWL_QU_B_HR_B_FW_PRE,
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
@@ -471,7 +464,7 @@ const struct iwl_cfg iwl_ax200_cfg_cc = {
 
 const struct iwl_cfg killer1650s_2ax_cfg_qu_b0_hr_b0 = {
 	.name = "Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201NGW)",
-	.fw_name_pre = IWL_22000_QU_B_HR_B_FW_PRE,
+	.fw_name_pre = IWL_QU_B_HR_B_FW_PRE,
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
@@ -484,7 +477,7 @@ const struct iwl_cfg killer1650s_2ax_cfg_qu_b0_hr_b0 = {
 
 const struct iwl_cfg killer1650i_2ax_cfg_qu_b0_hr_b0 = {
 	.name = "Killer(R) Wi-Fi 6 AX1650s 160MHz Wireless Network Adapter (201D2W)",
-	.fw_name_pre = IWL_22000_QU_B_HR_B_FW_PRE,
+	.fw_name_pre = IWL_QU_B_HR_B_FW_PRE,
 	IWL_DEVICE_22500,
 	/*
 	 * This device doesn't support receiving BlockAck with a large bitmap
@@ -535,21 +528,21 @@ const struct iwl_cfg iwl_qnj_b0_hr_b0_cfg = {
 
 const struct iwl_cfg iwlax210_2ax_cfg_so_jf_a0 = {
 	.name = "Intel(R) Wireless-AC 9560 160MHz",
-	.fw_name_pre = IWL_22000_SO_A_JF_B_FW_PRE,
+	.fw_name_pre = IWL_SO_A_JF_B_FW_PRE,
 	IWL_DEVICE_AX210,
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
 const struct iwl_cfg iwlax210_2ax_cfg_so_hr_a0 = {
 	.name = "Intel(R) Wi-Fi 6 AX210 160MHz",
-	.fw_name_pre = IWL_22000_SO_A_HR_B_FW_PRE,
+	.fw_name_pre = IWL_SO_A_HR_B_FW_PRE,
 	IWL_DEVICE_AX210,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
 const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0 = {
 	.name = "Intel(R) Wi-Fi 6 AX211 160MHz",
-	.fw_name_pre = IWL_22000_SO_A_GF_A_FW_PRE,
+	.fw_name_pre = IWL_SO_A_GF_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
@@ -557,7 +550,7 @@ const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0 = {
 
 const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0_long = {
 	.name = "Intel(R) Wi-Fi 6 AX211 160MHz",
-	.fw_name_pre = IWL_22000_SO_A_GF_A_FW_PRE,
+	.fw_name_pre = IWL_SO_A_GF_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
@@ -567,7 +560,7 @@ const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0_long = {
 
 const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0 = {
 	.name = "Intel(R) Wi-Fi 6 AX210 160MHz",
-	.fw_name_pre = IWL_22000_TY_A_GF_A_FW_PRE,
+	.fw_name_pre = IWL_TY_A_GF_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
@@ -575,7 +568,7 @@ const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0 = {
 
 const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0 = {
 	.name = "Intel(R) Wi-Fi 6 AX411 160MHz",
-	.fw_name_pre = IWL_22000_SO_A_GF4_A_FW_PRE,
+	.fw_name_pre = IWL_SO_A_GF4_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
@@ -583,7 +576,7 @@ const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0 = {
 
 const struct iwl_cfg iwlax411_2ax_cfg_so_gf4_a0_long = {
 	.name = "Intel(R) Wi-Fi 6 AX411 160MHz",
-	.fw_name_pre = IWL_22000_SO_A_GF4_A_FW_PRE,
+	.fw_name_pre = IWL_SO_A_GF4_A_FW_PRE,
 	.uhb_supported = true,
 	IWL_DEVICE_AX210,
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
@@ -607,8 +600,7 @@ const struct iwl_cfg iwlax211_cfg_snj_gf_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
-MODULE_FIRMWARE(IWL_22000_HR_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_22000_JF_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_QU_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QNJ_B_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_C_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QU_B_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
@@ -616,9 +608,9 @@ MODULE_FIRMWARE(IWL_QUZ_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QUZ_A_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_QNJ_B_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_CC_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_22000_SO_A_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_22000_SO_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_22000_SO_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-MODULE_FIRMWARE(IWL_22000_TY_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SO_A_JF_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SO_A_HR_B_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_SO_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
+MODULE_FIRMWARE(IWL_TY_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SNJ_A_GF4_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
 MODULE_FIRMWARE(IWL_SNJ_A_GF_A_MODULE_FIRMWARE(IWL_22000_UCODE_API_MAX));
-- 
2.26.2

