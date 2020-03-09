Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1555917D9AD
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2020 08:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgCIHQr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Mar 2020 03:16:47 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33108 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726428AbgCIHQq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Mar 2020 03:16:46 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1jBCeV-0007CP-3I; Mon, 09 Mar 2020 09:16:39 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  9 Mar 2020 09:16:17 +0200
Message-Id: <iwlwifi.20200309091348.11c65d195677.I8faf50b325282df4892520a3b21fbdedabbb64f0@changeid>
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
Subject: [PATCH 11/13] iwlwifi: move shared clock entries to new table
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

These devices can now also be fully differentiated by using the new
parameters.  Move them all to the new table format.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c | 46 ---------------
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 56 ++++++++++---------
 2 files changed, 29 insertions(+), 73 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 38442643ee5a..9fcc1d97d6b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -216,53 +216,7 @@ const struct iwl_cfg iwl9560_2ac_cfg_soc = {
 	.soc_latency = 5000,
 };
 
-const struct iwl_cfg iwl9461_2ac_cfg_shared_clk = {
-	.name = "Intel(R) Dual Band Wireless AC 9461",
-	.fw_name_pre = IWL9000_FW_PRE,
-	IWL_DEVICE_9000,
-	.integrated = true,
-	.soc_latency = 5000,
-	.extra_phy_cfg_flags = FW_PHY_CFG_SHARED_CLK
-};
-
-const struct iwl_cfg iwl9462_2ac_cfg_shared_clk = {
-	.name = "Intel(R) Dual Band Wireless AC 9462",
-	.fw_name_pre = IWL9000_FW_PRE,
-	IWL_DEVICE_9000,
-	.integrated = true,
-	.soc_latency = 5000,
-	.extra_phy_cfg_flags = FW_PHY_CFG_SHARED_CLK
-};
-
 const struct iwl_cfg iwl9560_2ac_cfg_shared_clk = {
-	.name = "Intel(R) Dual Band Wireless AC 9560",
-	.fw_name_pre = IWL9000_FW_PRE,
-	IWL_DEVICE_9000,
-	.integrated = true,
-	.soc_latency = 5000,
-	.extra_phy_cfg_flags = FW_PHY_CFG_SHARED_CLK
-};
-
-const struct iwl_cfg iwl9560_2ac_160_cfg_shared_clk = {
-	.name = "Intel(R) Wireless-AC 9560 160MHz",
-	.fw_name_pre = IWL9000_FW_PRE,
-	IWL_DEVICE_9000,
-	.integrated = true,
-	.soc_latency = 5000,
-	.extra_phy_cfg_flags = FW_PHY_CFG_SHARED_CLK
-};
-
-const struct iwl_cfg iwl9560_killer_2ac_cfg_shared_clk = {
-	.name = "Killer (R) Wireless-AC 1550i Wireless Network Adapter (9560NGW)",
-	.fw_name_pre = IWL9000_FW_PRE,
-	IWL_DEVICE_9000,
-	.integrated = true,
-	.soc_latency = 5000,
-	.extra_phy_cfg_flags = FW_PHY_CFG_SHARED_CLK
-};
-
-const struct iwl_cfg iwl9560_killer_s_2ac_cfg_shared_clk = {
-	.name = "Killer (R) Wireless-AC 1550s Wireless Network Adapter (9560NGW)",
 	.fw_name_pre = IWL9000_FW_PRE,
 	IWL_DEVICE_9000,
 	.integrated = true,
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 80e7fb884d57..95b2096b8030 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -570,6 +570,7 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x271B, PCI_ANY_ID, iwl9000_trans_cfg)},
 	{IWL_PCI_DEVICE(0x271C, PCI_ANY_ID, iwl9000_trans_cfg)},
 	{IWL_PCI_DEVICE(0x30DC, PCI_ANY_ID, iwl9000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x31DC, PCI_ANY_ID, iwl9000_trans_cfg)},
 	{IWL_PCI_DEVICE(0x9DF0, PCI_ANY_ID, iwl9000_trans_cfg)},
 	{IWL_PCI_DEVICE(0xA370, PCI_ANY_ID, iwl9000_trans_cfg)},
 
@@ -599,33 +600,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2720, 0x4234, iwl9560_2ac_cfg_qu_b0_jf_b0)},
 	{IWL_PCI_DEVICE(0x2720, 0x42A4, iwl9462_2ac_cfg_qu_b0_jf_b0)},
 
-	{IWL_PCI_DEVICE(0x31DC, 0x0030, iwl9560_2ac_160_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x0034, iwl9560_2ac_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x0038, iwl9560_2ac_160_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x003C, iwl9560_2ac_160_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x0060, iwl9461_2ac_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x0064, iwl9461_2ac_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x00A0, iwl9462_2ac_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x00A4, iwl9462_2ac_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x0230, iwl9560_2ac_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x0234, iwl9560_2ac_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x0238, iwl9560_2ac_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x023C, iwl9560_2ac_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x0260, iwl9461_2ac_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x0264, iwl9461_2ac_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x02A0, iwl9462_2ac_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x02A4, iwl9462_2ac_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x1030, iwl9560_2ac_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x1551, iwl9560_killer_s_2ac_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x1552, iwl9560_killer_2ac_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x2030, iwl9560_2ac_160_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x2034, iwl9560_2ac_160_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x4030, iwl9560_2ac_160_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x4034, iwl9560_2ac_160_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x40A4, iwl9462_2ac_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x4234, iwl9560_2ac_cfg_shared_clk)},
-	{IWL_PCI_DEVICE(0x31DC, 0x42A4, iwl9462_2ac_cfg_shared_clk)},
-
 	{IWL_PCI_DEVICE(0x34F0, 0x0030, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
 	{IWL_PCI_DEVICE(0x34F0, 0x0034, iwl9560_2ac_cfg_qu_b0_jf_b0)},
 	{IWL_PCI_DEVICE(0x34F0, 0x0038, iwl9560_2ac_160_cfg_qu_b0_jf_b0)},
@@ -858,9 +832,37 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x2526, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name),
 	IWL_DEV_INFO(0x30DC, 0x1551, iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_name),
 	IWL_DEV_INFO(0x30DC, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name),
+	IWL_DEV_INFO(0x31DC, 0x1551, iwl9560_2ac_cfg_shared_clk, iwl9560_killer_1550s_name),
+	IWL_DEV_INFO(0x31DC, 0x1552, iwl9560_2ac_cfg_shared_clk, iwl9560_killer_1550i_name),
 
 	IWL_DEV_INFO(0x271C, 0x0214, iwl9260_2ac_cfg, iwl9260_1_name),
 
+	_IWL_DEV_INFO(0x31DC, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_2ac_cfg_shared_clk, iwl9461_160_name),
+	_IWL_DEV_INFO(0x31DC, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_2ac_cfg_shared_clk, iwl9461_name),
+	_IWL_DEV_INFO(0x31DC, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_2ac_cfg_shared_clk, iwl9462_160_name),
+	_IWL_DEV_INFO(0x31DC, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_2ac_cfg_shared_clk, iwl9462_name),
+
+	_IWL_DEV_INFO(0x31DC, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_2ac_cfg_shared_clk, iwl9560_160_name),
+	_IWL_DEV_INFO(0x31DC, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_2ac_cfg_shared_clk, iwl9560_name),
+
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
 		      IWL_CFG_160, IWL_CFG_CORES_BT,
-- 
2.25.1

