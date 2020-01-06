Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08ABC130EFC
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 09:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgAFIzW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 03:55:22 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51428 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726422AbgAFIzV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 03:55:21 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ioOAP-0007qa-9y; Mon, 06 Jan 2020 10:55:17 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  6 Jan 2020 10:55:01 +0200
Message-Id: <20200106085502.363205-12-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106085502.363205-1-luca@coelho.fi>
References: <20200106085502.363205-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 11/12] iwlwifi: implement a new device configuration table
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Add a new device table that contains information that can be checked
at runtime in order to decide which configuration to use.  This allows
us to map the full cfg independently from the tran-specific
configuration.

This is the first step in creating the new table.  Subsequent patches
will add the possibility of checking different values at runtime in
order to make the decision.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  6 +++
 .../net/wireless/intel/iwlwifi/iwl-config.h   | 10 +++++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 42 +++++++++++++++----
 3 files changed, 49 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 79390f880efb..e7b95842bb60 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -171,6 +171,12 @@ static const struct iwl_tt_params iwl9000_tt_params = {
 		},							\
 	}
 
+const struct iwl_cfg_trans_params iwl9000_trans_cfg = {
+	.device_family = IWL_DEVICE_FAMILY_9000,
+	.base_params = &iwl9000_base_params,
+	.mq_rx_supported = true,
+	.rf_id = true,
+};
 
 const struct iwl_cfg iwl9160_2ac_cfg = {
 	.name = "Intel(R) Dual Band Wireless AC 9160",
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index bbeb5fc3caad..0af1a5184d82 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -452,9 +452,19 @@ struct iwl_cfg {
 	const struct iwl_fw_mon_regs mon_smem_regs;
 };
 
+#define IWL_CFG_ANY (~0)
+
+struct iwl_dev_info {
+	u16 device;
+	u16 subdevice;
+	const struct iwl_cfg *cfg;
+};
+
 /*
  * This list declares the config structures for all devices.
  */
+extern const struct iwl_cfg_trans_params iwl9000_trans_cfg;
+
 #if IS_ENABLED(CONFIG_IWLDVM)
 extern const struct iwl_cfg iwl5300_agn_cfg;
 extern const struct iwl_cfg iwl5100_agn_cfg;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 5eb528d2111f..c2cb6283bc5a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -565,14 +565,8 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x06F0, 0x40A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
 	{IWL_PCI_DEVICE(0x06F0, 0x4234, iwl9560_2ac_cfg_quz_a0_jf_b0_soc)},
 	{IWL_PCI_DEVICE(0x06F0, 0x42A4, iwl9462_2ac_cfg_quz_a0_jf_b0_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x0010, iwl9260_2ac_160_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x0014, iwl9260_2ac_160_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x0018, iwl9260_2ac_160_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x001C, iwl9260_2ac_160_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x0030, iwl9560_2ac_160_cfg)},
+
 	{IWL_PCI_DEVICE(0x2526, 0x0034, iwl9560_2ac_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x0038, iwl9560_2ac_160_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x003C, iwl9560_2ac_160_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x0060, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x0064, iwl9461_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x00A0, iwl9462_2ac_cfg_soc)},
@@ -601,7 +595,6 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2526, 0x4010, iwl9260_2ac_160_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x4018, iwl9260_2ac_160_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x401C, iwl9260_2ac_160_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x4030, iwl9560_2ac_160_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x4034, iwl9560_2ac_160_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x40A4, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x4234, iwl9560_2ac_cfg_soc)},
@@ -613,6 +606,8 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2526, 0xA014, iwl9260_2ac_160_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0xE010, iwl9260_2ac_160_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0xE014, iwl9260_2ac_160_cfg)},
+	{IWL_PCI_DEVICE(0x2526, PCI_ANY_ID, iwl9000_trans_cfg)},
+
 	{IWL_PCI_DEVICE(0x271B, 0x0010, iwl9160_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x271B, 0x0014, iwl9160_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x271B, 0x0210, iwl9160_2ac_cfg)},
@@ -986,6 +981,22 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 };
 MODULE_DEVICE_TABLE(pci, iwl_hw_card_ids);
 
+#define IWL_DEV_INFO(_device, _subdevice, _cfg) \
+	{.device = (_device), .subdevice = (_subdevice), .cfg = &(_cfg)}
+
+static const struct iwl_dev_info iwl_dev_info_table[] = {
+#if IS_ENABLED(CONFIG_IWLMVM)
+	IWL_DEV_INFO(0x2526, 0x0010, iwl9260_2ac_160_cfg),
+	IWL_DEV_INFO(0x2526, 0x0014, iwl9260_2ac_160_cfg),
+	IWL_DEV_INFO(0x2526, 0x0018, iwl9260_2ac_160_cfg),
+	IWL_DEV_INFO(0x2526, 0x001C, iwl9260_2ac_160_cfg),
+	IWL_DEV_INFO(0x2526, 0x0030, iwl9560_2ac_160_cfg),
+	IWL_DEV_INFO(0x2526, 0x0038, iwl9560_2ac_160_cfg),
+	IWL_DEV_INFO(0x2526, 0x003C, iwl9560_2ac_160_cfg),
+	IWL_DEV_INFO(0x2526, 0x4030, iwl9560_2ac_160_cfg),
+#endif /* CONFIG_IWLMVM */
+};
+
 /* PCI registers */
 #define PCI_CFG_RETRY_TIMEOUT	0x041
 
@@ -997,7 +1008,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct iwl_trans *iwl_trans;
 	struct iwl_trans_pcie *trans_pcie;
 	unsigned long flags;
-	int ret;
+	int i, ret;
 	/*
 	 * This is needed for backwards compatibility with the old
 	 * tables, so we don't need to change all the config structs
@@ -1018,6 +1029,18 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* the trans_cfg should never change, so set it now */
 	iwl_trans->trans_cfg = trans;
 
+	for (i = 0; i < ARRAY_SIZE(iwl_dev_info_table); i++) {
+		const struct iwl_dev_info *dev_info = &iwl_dev_info_table[i];
+
+		if ((dev_info->device == IWL_CFG_ANY ||
+		     dev_info->device == pdev->device) &&
+		    (dev_info->subdevice == IWL_CFG_ANY ||
+		     dev_info->subdevice == pdev->subsystem_device)) {
+			iwl_trans->cfg = dev_info->cfg;
+			goto found;
+		}
+	}
+
 #if IS_ENABLED(CONFIG_IWLMVM)
 	/*
 	 * special-case 7265D, it has the same PCI IDs.
@@ -1140,6 +1163,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!iwl_trans->cfg)
 		iwl_trans->cfg = cfg;
 
+found:
 	if (iwl_trans->trans_cfg->mq_rx_supported) {
 		if (WARN_ON(!iwl_trans->cfg->num_rbds)) {
 			ret = -EINVAL;
-- 
2.24.1

