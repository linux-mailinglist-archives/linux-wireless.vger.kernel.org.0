Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1C5618F599
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 14:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgCWNUZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 09:20:25 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:43474 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728515AbgCWNUZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 09:20:25 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jGMzY-00023f-L5; Mon, 23 Mar 2020 15:19:45 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 23 Mar 2020 15:19:24 +0200
Message-Id: <iwlwifi.20200323151304.9c44dad10f3e.If236ef3d0da3e605a3379922818f5897e0affd7e@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323131925.208376-1-luca@coelho.fi>
References: <20200323131925.208376-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 13/14] iwlwifi: convert QnJ with Jf devices to new config table
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

All the QnJ devices have a similar matching to the other Qu devices,
but needs a different configuration.  Convert the QnJ devices to the
new table accordingly.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  78 ++++---------
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   8 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 107 ++++++++++--------
 3 files changed, 86 insertions(+), 107 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index d86752ad96b7..76f2ee06d8f6 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -246,6 +246,15 @@ const struct iwl_cfg_trans_params iwl_qu_trans_cfg = {
 	.xtal_latency = 5000,
 };
 
+const struct iwl_cfg_trans_params iwl_qnj_trans_cfg = {
+	.mq_rx_supported = true,
+	.use_tfh = true,
+	.rf_id = true,
+	.gen2 = true,
+	.device_family = IWL_DEVICE_FAMILY_22000,
+	.base_params = &iwl_22000_base_params,
+};
+
 /*
  * If the device doesn't support HE, no need to have that many buffers.
  * 22000 devices can split multiple frames into a single RB, so fewer are
@@ -281,6 +290,18 @@ const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg = {
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
+const struct iwl_cfg iwl9560_qnj_b0_jf_b0_cfg = {
+	.fw_name_pre = IWL_QNJ_B_JF_B_FW_PRE,
+	IWL_DEVICE_22500,
+	/*
+	 * This device doesn't support receiving BlockAck with a large bitmap
+	 * so we need to restrict the size of transmitted aggregation to the
+	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
+	 */
+	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
+	.num_rbds = IWL_NUM_RBDS_NON_HE,
+};
+
 const struct iwl_cfg_trans_params iwl_ax200_trans_cfg = {
 	.device_family = IWL_DEVICE_FAMILY_22000,
 	.base_params = &iwl_22000_base_params,
@@ -476,19 +497,6 @@ const struct iwl_cfg iwl9560_2ac_160_cfg_qu_c0_jf_b0 = {
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
-const struct iwl_cfg iwl9560_2ac_cfg_qnj_jf_b0 = {
-	.name = "Intel(R) Wireless-AC 9560 160MHz",
-	.fw_name_pre = IWL_QNJ_B_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
 const struct iwl_cfg iwl9560_2ac_cfg_quz_a0_jf_b0_soc = {
 	.name = "Intel(R) Wireless-AC 9560 160MHz",
 	.fw_name_pre = IWL_QUZ_A_JF_B_FW_PRE,
@@ -549,50 +557,6 @@ const struct iwl_cfg iwl9462_2ac_cfg_quz_a0_jf_b0_soc = {
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
-const struct iwl_cfg iwl9560_killer_s_2ac_cfg_quz_a0_jf_b0_soc = {
-	.name = "Killer (R) Wireless-AC 1550s Wireless Network Adapter (9560NGW)",
-	.fw_name_pre = IWL_QUZ_A_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.trans.integrated = true,
-	.trans.xtal_latency = 5000,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg iwl9560_killer_i_2ac_cfg_quz_a0_jf_b0_soc = {
-	.name = "Killer (R) Wireless-AC 1550i Wireless Network Adapter (9560NGW)",
-	.fw_name_pre = IWL_QUZ_A_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	/*
-	 * This device doesn't support receiving BlockAck with a large bitmap
-	 * so we need to restrict the size of transmitted aggregation to the
-	 * HT size; mac80211 would otherwise pick the HE max (256) by default.
-	 */
-	.max_tx_agg_size = IEEE80211_MAX_AMPDU_BUF_HT,
-	.trans.integrated = true,
-	.trans.xtal_latency = 5000,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg killer1550i_2ac_cfg_qu_b0_jf_b0 = {
-	.name = "Killer (R) Wireless-AC 1550i Wireless Network Adapter (9560NGW)",
-	.fw_name_pre = IWL_QU_B_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
-const struct iwl_cfg killer1550s_2ac_cfg_qu_b0_jf_b0 = {
-	.name = "Killer (R) Wireless-AC 1550s Wireless Network Adapter (9560NGW)",
-	.fw_name_pre = IWL_QU_B_JF_B_FW_PRE,
-	IWL_DEVICE_22500,
-	.num_rbds = IWL_NUM_RBDS_NON_HE,
-};
-
 const struct iwl_cfg killer1650s_2ax_cfg_qu_b0_hr_b0 = {
 	.name = "Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless Network Adapter (201NGW)",
 	.fw_name_pre = IWL_22000_QU_B_HR_B_FW_PRE,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index af7b6a67dfb1..2ecc94799e57 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -462,6 +462,7 @@ struct iwl_cfg {
 #define IWL_CFG_MAC_TYPE_TH		0x32
 #define IWL_CFG_MAC_TYPE_QU		0x33
 #define IWL_CFG_MAC_TYPE_QUZ		0x35
+#define IWL_CFG_MAC_TYPE_QNJ		0x36
 
 #define IWL_CFG_RF_TYPE_TH		0x105
 #define IWL_CFG_RF_TYPE_TH1		0x108
@@ -504,6 +505,7 @@ extern const struct iwl_cfg_trans_params iwl9000_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl9560_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl9560_shared_clk_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_qu_trans_cfg;
+extern const struct iwl_cfg_trans_params iwl_qnj_trans_cfg;
 extern const struct iwl_cfg_trans_params iwl_ax200_trans_cfg;
 extern const char iwl9162_name[];
 extern const char iwl9260_name[];
@@ -594,13 +596,12 @@ extern const struct iwl_cfg iwl9260_2ac_cfg;
 extern const struct iwl_cfg iwl9560_qu_b0_jf_b0_cfg;
 extern const struct iwl_cfg iwl9560_qu_c0_jf_b0_cfg;
 extern const struct iwl_cfg iwl9560_quz_a0_jf_b0_cfg;
+extern const struct iwl_cfg iwl9560_qnj_b0_jf_b0_cfg;
 extern const struct iwl_cfg iwl9560_2ac_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl9461_2ac_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl9462_2ac_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl9560_2ac_cfg_soc;
-extern const struct iwl_cfg iwl9560_killer_i_2ac_cfg_quz_a0_jf_b0_soc;
-extern const struct iwl_cfg iwl9560_killer_s_2ac_cfg_quz_a0_jf_b0_soc;
 extern const struct iwl_cfg iwl_ax101_cfg_qu_hr;
 extern const struct iwl_cfg iwl_ax101_cfg_qu_c0_hr_b0;
 extern const struct iwl_cfg iwl_ax101_cfg_quz_hr;
@@ -625,13 +626,10 @@ extern const struct iwl_cfg iwl9461_2ac_cfg_qu_c0_jf_b0;
 extern const struct iwl_cfg iwl9462_2ac_cfg_qu_c0_jf_b0;
 extern const struct iwl_cfg iwl9560_2ac_cfg_qu_c0_jf_b0;
 extern const struct iwl_cfg iwl9560_2ac_160_cfg_qu_c0_jf_b0;
-extern const struct iwl_cfg killer1550i_2ac_cfg_qu_b0_jf_b0;
-extern const struct iwl_cfg killer1550s_2ac_cfg_qu_b0_jf_b0;
 extern const struct iwl_cfg iwl22000_2ax_cfg_jf;
 extern const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_a0_f0;
 extern const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_b0_f0;
 extern const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_b0;
-extern const struct iwl_cfg iwl9560_2ac_cfg_qnj_jf_b0;
 extern const struct iwl_cfg iwl22000_2ax_cfg_qnj_hr_a0;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_a0;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_hr_a0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 609c4c5bd32c..7c228aa66a0f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -513,32 +513,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x24FD, 0x9074, iwl8265_2ac_cfg)},
 
 /* 9000 Series */
-	{IWL_PCI_DEVICE(0x2720, 0x0034, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x0038, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x003C, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x0060, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x0064, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x00A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x00A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x0230, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x0234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x0238, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x023C, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x0260, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x0264, iwl9461_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x02A0, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x02A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x1030, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x1551, killer1550s_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x1552, killer1550i_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x2030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x2034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x4030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x4034, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x40A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x4234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x42A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
-
 	{IWL_PCI_DEVICE(0x2526, PCI_ANY_ID, iwl9000_trans_cfg)},
 	{IWL_PCI_DEVICE(0x271B, PCI_ANY_ID, iwl9560_trans_cfg)},
 	{IWL_PCI_DEVICE(0x271C, PCI_ANY_ID, iwl9560_trans_cfg)},
@@ -555,28 +529,10 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x43F0, PCI_ANY_ID, iwl_qu_trans_cfg)},
 	{IWL_PCI_DEVICE(0xA0F0, PCI_ANY_ID, iwl_qu_trans_cfg)},
 
-	{IWL_PCI_DEVICE(0x2720, 0x0030, iwl9560_2ac_cfg_qnj_jf_b0)},
+	{IWL_PCI_DEVICE(0x2720, PCI_ANY_ID, iwl_qnj_trans_cfg)},
 
-/* 22000 Series */
 	{IWL_PCI_DEVICE(0x2723, PCI_ANY_ID, iwl_ax200_trans_cfg)},
 
-	{IWL_PCI_DEVICE(0x2720, 0x0000, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x2720, 0x0040, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x2720, 0x0044, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x2720, 0x0070, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x2720, 0x0074, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x2720, 0x0078, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x2720, 0x007C, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x2720, 0x0244, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x2720, 0x0310, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x2720, 0x0A10, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x2720, 0x1080, iwl_ax101_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x2720, 0x1651, killer1650s_2ax_cfg_qu_b0_hr_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x1652, killer1650i_2ax_cfg_qu_b0_hr_b0)},
-	{IWL_PCI_DEVICE(0x2720, 0x2074, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x2720, 0x4070, iwl_ax201_cfg_qu_hr)},
-	{IWL_PCI_DEVICE(0x2720, 0x4244, iwl_ax101_cfg_qu_hr)},
-
 	{IWL_PCI_DEVICE(0x2725, 0x0090, iwlax211_2ax_cfg_so_gf_a0)},
 	{IWL_PCI_DEVICE(0x2725, 0x0020, iwlax210_2ax_cfg_ty_gf_a0)},
 	{IWL_PCI_DEVICE(0x2725, 0x0310, iwlax210_2ax_cfg_ty_gf_a0)},
@@ -700,6 +656,23 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x3DF0, 0x4070, iwl_ax201_cfg_qu_hr, NULL),
 	IWL_DEV_INFO(0x3DF0, 0x4244, iwl_ax101_cfg_qu_hr, NULL),
 
+	IWL_DEV_INFO(0x2720, 0x0000, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2720, 0x0040, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2720, 0x0044, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2720, 0x0070, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2720, 0x0074, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2720, 0x0078, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2720, 0x007C, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2720, 0x0244, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2720, 0x0310, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2720, 0x0A10, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2720, 0x1080, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2720, 0x1651, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2720, 0x1652, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2720, 0x2074, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2720, 0x4070, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
+	IWL_DEV_INFO(0x2720, 0x4244, iwl22000_2ax_cfg_qnj_hr_b0, NULL),
+
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
@@ -929,6 +902,50 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_killer_1550i_name),
+
+	/* QnJ */
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_qnj_b0_jf_b0_cfg, iwl9461_160_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_qnj_b0_jf_b0_cfg, iwl9461_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_qnj_b0_jf_b0_cfg, iwl9462_160_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_qnj_b0_jf_b0_cfg, iwl9462_name),
+
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_qnj_b0_jf_b0_cfg, iwl9560_160_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_qnj_b0_jf_b0_cfg, iwl9560_name),
+
+	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1551,
+		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_qnj_b0_jf_b0_cfg, iwl9560_killer_1550s_name),
+	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1552,
+		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
+		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_qnj_b0_jf_b0_cfg, iwl9560_killer_1550i_name),
 #endif /* CONFIG_IWLMVM */
 };
 
-- 
2.25.1

