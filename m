Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6544A2E1D
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jan 2022 12:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237190AbiA2LQf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 Jan 2022 06:16:35 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37882 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237301AbiA2LQe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 Jan 2022 06:16:34 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDliZ-0002ji-3n;
        Sat, 29 Jan 2022 13:16:32 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 29 Jan 2022 13:16:17 +0200
Message-Id: <iwlwifi.20220129105618.a82ca9207ace.I38aa0acfb7846b179027b6f87f5f88f8e4177f63@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220129111622.678447-1-luca@coelho.fi>
References: <20220129111622.678447-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 07/12] iwlwifi: pcie: add support for MS devices
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yaara Baruch <yaara.baruch@intel.com>

Add MS devices to the driver. For now we are using the same FW image as MR
(since they differ only in rfid), but it should change in the future.

Signed-off-by: Yaara Baruch <yaara.baruch@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 23 +++++++++++++++++
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  5 ++++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 25 ++++++++++++++++++-
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 22f33c074ac9..c7bda7246f0d 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -40,6 +40,7 @@
 #define IWL_SO_A_GF_A_FW_PRE		"iwlwifi-so-a0-gf-a0-"
 #define IWL_TY_A_GF_A_FW_PRE		"iwlwifi-ty-a0-gf-a0-"
 #define IWL_SO_A_GF4_A_FW_PRE		"iwlwifi-so-a0-gf4-a0-"
+#define IWL_SO_A_MR_A_FW_PRE		"iwlwifi-so-a0-mr-a0-"
 #define IWL_SNJ_A_GF4_A_FW_PRE		"iwlwifi-SoSnj-a0-gf4-a0-"
 #define IWL_SNJ_A_GF_A_FW_PRE		"iwlwifi-SoSnj-a0-gf-a0-"
 #define IWL_SNJ_A_HR_B_FW_PRE		"iwlwifi-SoSnj-a0-hr-b0-"
@@ -483,6 +484,7 @@ const char iwl_ax101_name[] = "Intel(R) Wi-Fi 6 AX101";
 const char iwl_ax200_name[] = "Intel(R) Wi-Fi 6 AX200 160MHz";
 const char iwl_ax201_name[] = "Intel(R) Wi-Fi 6 AX201 160MHz";
 const char iwl_ax203_name[] = "Intel(R) Wi-Fi 6 AX203";
+const char iwl_ax204_name[] = "Intel(R) Wi-Fi 6 AX204 160MHz";
 const char iwl_ax211_name[] = "Intel(R) Wi-Fi 6E AX211 160MHz";
 const char iwl_ax221_name[] = "Intel(R) Wi-Fi 6E AX221 160MHz";
 const char iwl_ax231_name[] = "Intel(R) Wi-Fi 6E AX231 160MHz";
@@ -823,6 +825,20 @@ const struct iwl_cfg iwl_cfg_ma_a0_mr_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_ma_a0_ms_a0 = {
+	.fw_name_pre = IWL_MA_A_MR_A_FW_PRE,
+	.uhb_supported = false,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
+const struct iwl_cfg iwl_cfg_so_a0_ms_a0 = {
+	.fw_name_pre = IWL_SO_A_MR_A_FW_PRE,
+	.uhb_supported = false,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 const struct iwl_cfg iwl_cfg_ma_a0_fm_a0 = {
 	.fw_name_pre = IWL_MA_A_FM_A_FW_PRE,
 	.uhb_supported = true,
@@ -837,6 +853,13 @@ const struct iwl_cfg iwl_cfg_snj_a0_mr_a0 = {
 	.num_rbds = IWL_NUM_RBDS_AX210_HE,
 };
 
+const struct iwl_cfg iwl_cfg_snj_a0_ms_a0 = {
+	.fw_name_pre = IWL_SNJ_A_MR_A_FW_PRE,
+	.uhb_supported = false,
+	IWL_DEVICE_AX210,
+	.num_rbds = IWL_NUM_RBDS_AX210_HE,
+};
+
 const struct iwl_cfg iwl_cfg_so_a0_hr_a0 = {
 	.fw_name_pre = IWL_SO_A_HR_B_FW_PRE,
 	IWL_DEVICE_AX210,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 2eb7f87672b4..b7e430ad5e2a 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -434,6 +434,7 @@ struct iwl_cfg {
 #define IWL_CFG_RF_TYPE_HR1		0x10C
 #define IWL_CFG_RF_TYPE_GF		0x10D
 #define IWL_CFG_RF_TYPE_MR		0x110
+#define IWL_CFG_RF_TYPE_MS		0x111
 #define IWL_CFG_RF_TYPE_FM		0x112
 
 #define IWL_CFG_RF_ID_TH		0x1
@@ -510,6 +511,7 @@ extern const char iwl9560_killer_1550i_name[];
 extern const char iwl9560_killer_1550s_name[];
 extern const char iwl_ax200_name[];
 extern const char iwl_ax203_name[];
+extern const char iwl_ax204_name[];
 extern const char iwl_ax201_name[];
 extern const char iwl_ax101_name[];
 extern const char iwl_ax200_killer_1650w_name[];
@@ -632,9 +634,12 @@ extern const struct iwl_cfg iwl_cfg_ma_a0_hr_b0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_gf_a0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_gf4_a0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_mr_a0;
+extern const struct iwl_cfg iwl_cfg_ma_a0_ms_a0;
 extern const struct iwl_cfg iwl_cfg_ma_a0_fm_a0;
 extern const struct iwl_cfg iwl_cfg_snj_a0_mr_a0;
+extern const struct iwl_cfg iwl_cfg_snj_a0_ms_a0;
 extern const struct iwl_cfg iwl_cfg_so_a0_hr_a0;
+extern const struct iwl_cfg iwl_cfg_so_a0_ms_a0;
 extern const struct iwl_cfg iwl_cfg_quz_a0_hr_b0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_hr_b0;
 extern const struct iwl_cfg iwl_cfg_bz_a0_gf_a0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 5178e852c5d3..5730d10b3019 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1301,7 +1301,30 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB, IWL_CFG_ANY,
-		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_name)
+		      iwlax210_2ax_cfg_so_jf_b0, iwl9462_name),
+
+/* MsP */
+/* For now we use the same FW as MR, but this will change in the future. */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_MS, IWL_CFG_ANY,
+		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      iwl_cfg_so_a0_ms_a0, iwl_ax204_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SOF, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_MS, IWL_CFG_ANY,
+		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      iwl_cfg_so_a0_ms_a0, iwl_ax204_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_MS, IWL_CFG_ANY,
+		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      iwl_cfg_ma_a0_ms_a0, iwl_ax204_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_MS, IWL_CFG_ANY,
+		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB, IWL_CFG_ANY,
+		      iwl_cfg_snj_a0_ms_a0, iwl_ax204_name)
 
 #endif /* CONFIG_IWLMVM */
 };
-- 
2.34.1

