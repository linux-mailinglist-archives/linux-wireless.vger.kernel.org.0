Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2178A17D9B0
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2020 08:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgCIHQy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Mar 2020 03:16:54 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33124 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726428AbgCIHQx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Mar 2020 03:16:53 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1jBCeW-0007CP-J3; Mon, 09 Mar 2020 09:16:41 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  9 Mar 2020 09:16:19 +0200
Message-Id: <iwlwifi.20200309091348.fdfa5f31b8b1.Idfd28829d9f3820de06d3bba8fa66048b8d0d0b0@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200309071619.670108-1-luca@coelho.fi>
References: <20200309071619.670108-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 13/13] iwlwifi: move AX200 devices to the new table
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Move the AX200 devices to the new table and add the appropriate cfg
struct and strings.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    | 47 +++++++------------
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  4 ++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 19 ++++----
 3 files changed, 30 insertions(+), 40 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index a22a830019c0..53568bbcf214 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -246,6 +246,23 @@ static const struct iwl_ht_params iwl_22000_ht_params = {
 #define IWL_NUM_RBDS_22000_HE		2048
 #define IWL_NUM_RBDS_AX210_HE		4096
 
+const struct iwl_cfg_trans_params iwl_ax200_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_22000,
+	.base_params = &iwl_22000_base_params,
+	.mq_rx_supported = true,
+	.use_tfh = true,
+	.rf_id = true,
+	.gen2 = true,
+	.bisr_workaround = 1,
+};
+
+const char iwl_ax200_name[] = "Intel(R) Wi-Fi 6 AX200 160MHz";
+
+const char iwl_ax200_killer_1650w_name[] =
+	"Killer(R) Wi-Fi 6 AX1650w 160MHz Wireless Network Adapter (200D2W)";
+const char iwl_ax200_killer_1650x_name[] =
+	"Killer(R) Wi-Fi 6 AX1650x 160MHz Wireless Network Adapter (200NGW)";
+
 const struct iwl_cfg iwl_ax101_cfg_qu_hr = {
 	.name = "Intel(R) Wi-Fi 6 AX101",
 	.fw_name_pre = IWL_22000_QU_B_HR_B_FW_PRE,
@@ -352,35 +369,6 @@ const struct iwl_cfg iwl_ax1650i_cfg_quz_hr = {
 };
 
 const struct iwl_cfg iwl_ax200_cfg_cc = {
-	.name = "Intel(R) Wi-Fi 6 AX200 160MHz",
-	.fw_name_pre = IWL_CC_A_FW_PRE,
-	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.trans.bisr_workaround = 1,
-	.num_rbds = IWL_NUM_RBDS_22000_HE,
-};
-
-const struct iwl_cfg killer1650x_2ax_cfg = {
-	.name = "Killer(R) Wi-Fi 6 AX1650x 160MHz Wireless Network Adapter (200NGW)",
-	.fw_name_pre = IWL_CC_A_FW_PRE,
-	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.trans.bisr_workaround = 1,
-	.num_rbds = IWL_NUM_RBDS_22000_HE,
-};
-
-const struct iwl_cfg killer1650w_2ax_cfg = {
-	.name = "Killer(R) Wi-Fi 6 AX1650w 160MHz Wireless Network Adapter (200D2W)",
 	.fw_name_pre = IWL_CC_A_FW_PRE,
 	IWL_DEVICE_22500,
 	/*
@@ -389,7 +377,6 @@ const struct iwl_cfg killer1650w_2ax_cfg = {
 	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
 	 */
 	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.trans.bisr_workaround = 1,
 	.num_rbds = IWL_NUM_RBDS_22000_HE,
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index d406155b311e..dc32ccf95be5 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -496,6 +496,7 @@ struct iwl_dev_info {
  * This list declares the config structures for all devices.
  */
 extern const struct iwl_cfg_trans_params iwl9000_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl_ax200_trans_cfg;
 extern const char iwl9162_name[];
 extern const char iwl9260_name[];
 extern const char iwl9260_1_name[];
@@ -512,6 +513,9 @@ extern const char iwl9560_160_name[];
 extern const char iwl9260_killer_1550_name[];
 extern const char iwl9560_killer_1550i_name[];
 extern const char iwl9560_killer_1550s_name[];
+extern const char iwl_ax200_name[];
+extern const char iwl_ax200_killer_1650w_name[];
+extern const char iwl_ax200_killer_1650x_name[];
 
 #if IS_ENABLED(CONFIG_IWLDVM)
 extern const struct iwl_cfg iwl5300_agn_cfg;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 95b2096b8030..5413e80f86bb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -710,6 +710,8 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2720, 0x0030, iwl9560_2ac_cfg_qnj_jf_b0)},
 
 /* 22000 Series */
+	{IWL_PCI_DEVICE(0x2723, PCI_ANY_ID, iwl_ax200_trans_cfg)},
+
 	{IWL_PCI_DEVICE(0x02F0, 0x0070, iwl_ax201_cfg_quz_hr)},
 	{IWL_PCI_DEVICE(0x02F0, 0x0074, iwl_ax201_cfg_quz_hr)},
 	{IWL_PCI_DEVICE(0x02F0, 0x0078, iwl_ax201_cfg_quz_hr)},
@@ -784,16 +786,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0xA0F0, 0x4070, iwl_ax201_cfg_qu_hr)},
 	{IWL_PCI_DEVICE(0xA0F0, 0x4244, iwl_ax101_cfg_qu_hr)},
 
-	{IWL_PCI_DEVICE(0x2723, 0x0080, iwl_ax200_cfg_cc)},
-	{IWL_PCI_DEVICE(0x2723, 0x0084, iwl_ax200_cfg_cc)},
-	{IWL_PCI_DEVICE(0x2723, 0x0088, iwl_ax200_cfg_cc)},
-	{IWL_PCI_DEVICE(0x2723, 0x008C, iwl_ax200_cfg_cc)},
-	{IWL_PCI_DEVICE(0x2723, 0x1653, killer1650w_2ax_cfg)},
-	{IWL_PCI_DEVICE(0x2723, 0x1654, killer1650x_2ax_cfg)},
-	{IWL_PCI_DEVICE(0x2723, 0x2080, iwl_ax200_cfg_cc)},
-	{IWL_PCI_DEVICE(0x2723, 0x4080, iwl_ax200_cfg_cc)},
-	{IWL_PCI_DEVICE(0x2723, 0x4088, iwl_ax200_cfg_cc)},
-
 	{IWL_PCI_DEVICE(0x2725, 0x0090, iwlax211_2ax_cfg_so_gf_a0)},
 	{IWL_PCI_DEVICE(0x2725, 0x0020, iwlax210_2ax_cfg_ty_gf_a0)},
 	{IWL_PCI_DEVICE(0x2725, 0x0310, iwlax210_2ax_cfg_ty_gf_a0)},
@@ -827,6 +819,7 @@ MODULE_DEVICE_TABLE(pci, iwl_hw_card_ids);
 
 static const struct iwl_dev_info iwl_dev_info_table[] = {
 #if IS_ENABLED(CONFIG_IWLMVM)
+/* 9000 */
 	IWL_DEV_INFO(0x2526, 0x1550, iwl9260_2ac_cfg, iwl9260_killer_1550_name),
 	IWL_DEV_INFO(0x2526, 0x1551, iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_name),
 	IWL_DEV_INFO(0x2526, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name),
@@ -941,6 +934,12 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
 		      iwl9260_2ac_cfg, iwl9260_name),
+
+/* AX200 */
+	IWL_DEV_INFO(0x2723, 0x1653, iwl_ax200_cfg_cc, iwl_ax200_killer_1650w_name),
+	IWL_DEV_INFO(0x2723, 0x1654, iwl_ax200_cfg_cc, iwl_ax200_killer_1650x_name),
+	IWL_DEV_INFO(0x2723, IWL_CFG_ANY, iwl_ax200_cfg_cc, iwl_ax200_name),
+
 #endif /* CONFIG_IWLMVM */
 };
 
-- 
2.25.1

