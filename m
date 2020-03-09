Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C001917D9AB
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2020 08:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgCIHQj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Mar 2020 03:16:39 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33068 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726027AbgCIHQi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Mar 2020 03:16:38 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1jBCeR-0007CP-NM; Mon, 09 Mar 2020 09:16:36 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  9 Mar 2020 09:16:13 +0200
Message-Id: <iwlwifi.20200309091348.18d4304b5454.Ib168d186da88393e9ec46f0fca523edb48d9138e@changeid>
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
Subject: [PATCH 07/13] iwlwifi: move TH1 devices to the new table
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

TH1 devices can now be fully differentiated by using the device
parameters we have (particularly the RF_TYPE).  Start using these
parameters instead of hardcoding to specific subsystem device IDs.

This also fixes the name of one of the TH1 devices that was
erroneously using the 9260 struct and renames 9160 to 9162.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c   |  8 ++------
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  4 +++-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 14 ++++++++++----
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 97644a5be253..6fff67b7ebd0 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -178,23 +178,19 @@ const struct iwl_cfg_trans_params iwl9000_trans_cfg = {
 	.rf_id = true,
 };
 
-const struct iwl_cfg iwl9160_2ac_cfg = {
-	.name = "Intel(R) Dual Band Wireless AC 9160",
-	.fw_name_pre = IWL9260_FW_PRE,
-	IWL_DEVICE_9000,
-};
-
 const struct iwl_cfg iwl9260_2ac_cfg = {
 	.name = "Intel(R) Dual Band Wireless AC 9260",
 	.fw_name_pre = IWL9260_FW_PRE,
 	IWL_DEVICE_9000,
 };
 
+const char iwl9162_name[] = "Intel(R) Wireless-AC 9162";
 const char iwl9260_name[] = "Intel(R) Wireless-AC 9260";
 const char iwl9270_name[] = "Intel(R) Wireless-AC 9270";
 const char iwl9461_name[] = "Intel(R) Wireless-AC 9461";
 const char iwl9462_name[] = "Intel(R) Wireless-AC 9462";
 const char iwl9560_name[] = "Intel(R) Wireless-AC 9560";
+const char iwl9162_160_name[] = "Intel(R) Wireless-AC 9162 160MHz";
 const char iwl9260_160_name[] = "Intel(R) Wireless-AC 9260 160MHz";
 const char iwl9270_160_name[] = "Intel(R) Wireless-AC 9270 160MHz";
 const char iwl9461_160_name[] = "Intel(R) Wireless-AC 9461 160MHz";
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 72b84f0e72c1..f8244f809c14 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -460,6 +460,7 @@ struct iwl_cfg {
 #define IWL_CFG_MAC_TYPE_QU		0x33
 
 #define IWL_CFG_RF_TYPE_TH		0x105
+#define IWL_CFG_RF_TYPE_TH1		0x108
 #define IWL_CFG_RF_TYPE_JF2		0x105
 #define IWL_CFG_RF_TYPE_JF1		0x108
 
@@ -495,11 +496,13 @@ struct iwl_dev_info {
  * This list declares the config structures for all devices.
  */
 extern const struct iwl_cfg_trans_params iwl9000_trans_cfg;
+extern const char iwl9162_name[];
 extern const char iwl9260_name[];
 extern const char iwl9270_name[];
 extern const char iwl9461_name[];
 extern const char iwl9462_name[];
 extern const char iwl9560_name[];
+extern const char iwl9162_160_name[];
 extern const char iwl9260_160_name[];
 extern const char iwl9270_160_name[];
 extern const char iwl9461_160_name[];
@@ -574,7 +577,6 @@ extern const struct iwl_cfg iwl8260_2ac_cfg;
 extern const struct iwl_cfg iwl8265_2ac_cfg;
 extern const struct iwl_cfg iwl8275_2ac_cfg;
 extern const struct iwl_cfg iwl4165_2ac_cfg;
-extern const struct iwl_cfg iwl9160_2ac_cfg;
 extern const struct iwl_cfg iwl9260_2ac_cfg;
 extern const struct iwl_cfg iwl9260_2ac_160_cfg;
 extern const struct iwl_cfg iwl9260_killer_2ac_cfg;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index b56b1c31c2f0..6bd126c0b7f6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -567,11 +567,8 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x06F0, 0x42A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
 
 	{IWL_PCI_DEVICE(0x2526, PCI_ANY_ID, iwl9000_trans_cfg)},
+	{IWL_PCI_DEVICE(0x271B, PCI_ANY_ID, iwl9000_trans_cfg)},
 
-	{IWL_PCI_DEVICE(0x271B, 0x0010, iwl9160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x271B, 0x0014, iwl9160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x271B, 0x0210, iwl9160_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x271B, 0x0214, iwl9260_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x271C, 0x0214, iwl9260_2ac_cfg)},
 
 	{IWL_PCI_DEVICE(0x2720, 0x0034, iwl9560_2ac_cfg_qu_b0_jf_b0)},
@@ -992,6 +989,15 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 		      IWL_CFG_NO_160, IWL_CFG_CORES_BT_GNSS,
 		      iwl9260_2ac_cfg, iwl9270_name),
 
+	_IWL_DEV_INFO(0x271B, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_RF_TYPE_TH1, IWL_CFG_ANY,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9260_2ac_cfg, iwl9162_160_name),
+	_IWL_DEV_INFO(0x271B, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_RF_TYPE_TH1, IWL_CFG_ANY,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9260_2ac_cfg, iwl9162_name),
+
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_160, IWL_CFG_CORES_BT,
-- 
2.25.1

