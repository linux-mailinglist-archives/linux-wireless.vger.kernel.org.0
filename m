Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76B14130EFD
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2020 09:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgAFIzX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Jan 2020 03:55:23 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51436 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726155AbgAFIzW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Jan 2020 03:55:22 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ioOAQ-0007qa-31; Mon, 06 Jan 2020 10:55:18 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  6 Jan 2020 10:55:02 +0200
Message-Id: <20200106085502.363205-13-luca@coelho.fi>
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
Subject: [PATCH 12/12] iwlwifi: add device name to device_info
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We have a lot of mostly duplicated data structures that are repeated
only because the device name string is different.  To avoid this, move
the string from the cfg to the trans structure and add it
independently from the rest of the configuration to the PCI mapping
tables.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |  4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  3 ++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 +
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 44 ++++++++++---------
 9 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index e7b95842bb60..379ea788e424 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -190,8 +190,10 @@ const struct iwl_cfg iwl9260_2ac_cfg = {
 	IWL_DEVICE_9000,
 };
 
+const char iwl9260_160_name[] = "Intel(R) Wireless-AC 9260 160MHz";
+const char iwl9560_160_name[] = "Intel(R) Wireless-AC 9560 160MHz";
+
 const struct iwl_cfg iwl9260_2ac_160_cfg = {
-	.name = "Intel(R) Wireless-AC 9260 160MHz",
 	.fw_name_pre = IWL9260_FW_PRE,
 	IWL_DEVICE_9000,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 4f2789bb3b5b..598ee7315558 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1255,7 +1255,7 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	 ************************/
 	hw = iwl_alloc_all();
 	if (!hw) {
-		pr_err("%s: Cannot allocate network device\n", cfg->name);
+		pr_err("%s: Cannot allocate network device\n", trans->name);
 		goto out;
 	}
 
@@ -1390,7 +1390,7 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	 * 2. Read REV register
 	 ***********************/
 	IWL_INFO(priv, "Detected %s, REV=0x%X\n",
-		priv->cfg->name, priv->trans->hw_rev);
+		priv->trans->name, priv->trans->hw_rev);
 
 	if (iwl_trans_start_hw(priv->trans))
 		goto out_free_hw;
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 09daf0f1f6f8..89d796821023 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -929,7 +929,7 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
 			cpu_to_le32(CSR_HW_REV_STEP(fwrt->trans->hw_rev));
 		memcpy(dump_info->fw_human_readable, fwrt->fw->human_readable,
 		       sizeof(dump_info->fw_human_readable));
-		strncpy(dump_info->dev_human_readable, fwrt->trans->cfg->name,
+		strncpy(dump_info->dev_human_readable, fwrt->trans->name,
 			sizeof(dump_info->dev_human_readable) - 1);
 		strncpy(dump_info->bus_human_readable, fwrt->dev->bus->name,
 			sizeof(dump_info->bus_human_readable) - 1);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 0af1a5184d82..be6a2bf9ce74 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -458,12 +458,15 @@ struct iwl_dev_info {
 	u16 device;
 	u16 subdevice;
 	const struct iwl_cfg *cfg;
+	const char *name;
 };
 
 /*
  * This list declares the config structures for all devices.
  */
 extern const struct iwl_cfg_trans_params iwl9000_trans_cfg;
+extern const char iwl9260_160_name[];
+extern const char iwl9560_160_name[];
 
 #if IS_ENABLED(CONFIG_IWLDVM)
 extern const struct iwl_cfg iwl5300_agn_cfg;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 58bee4442e20..ab547be4994b 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -859,6 +859,8 @@ struct iwl_trans {
 
 	enum iwl_plat_pm_mode system_pm_mode;
 
+	const char *name;
+
 	/* pointer to trans specific struct */
 	/*Ensure that this pointer will always be aligned to sizeof pointer */
 	char trans_specific[0] __aligned(sizeof(void *));
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index aa659162a7c2..190cf15b825c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -752,7 +752,7 @@ static ssize_t iwl_dbgfs_fw_ver_read(struct file *file, char __user *user_buf,
 	pos += scnprintf(pos, endpos - pos, "FW: %s\n",
 			 mvm->fwrt.fw->human_readable);
 	pos += scnprintf(pos, endpos - pos, "Device: %s\n",
-			 mvm->fwrt.trans->cfg->name);
+			 mvm->fwrt.trans->name);
 	pos += scnprintf(pos, endpos - pos, "Bus: %s\n",
 			 mvm->fwrt.dev->bus->name);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index 945c1ea5cda8..c46c00706cd5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -178,7 +178,7 @@ static int iwl_nvm_read_chunk(struct iwl_mvm *mvm, u16 section,
 		} else {
 			IWL_DEBUG_EEPROM(mvm->trans->dev,
 					 "NVM access command failed with status %d (device: %s)\n",
-					 ret, mvm->cfg->name);
+					 ret, mvm->trans->name);
 			ret = -ENODATA;
 		}
 		goto exit;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 1b07a8e8f069..dfe02440d474 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -830,7 +830,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	}
 
 	IWL_INFO(mvm, "Detected %s, REV=0x%X\n",
-		 mvm->cfg->name, mvm->trans->hw_rev);
+		 mvm->trans->name, mvm->trans->hw_rev);
 
 	if (iwlwifi_mod_params.nvm_file)
 		mvm->nvm_file_name = iwlwifi_mod_params.nvm_file;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index c2cb6283bc5a..9d8ffbecf5be 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -592,20 +592,10 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 	{IWL_PCI_DEVICE(0x2526, 0x1610, iwl9270_2ac_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x2030, iwl9560_2ac_160_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x2034, iwl9560_2ac_160_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x4010, iwl9260_2ac_160_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x4018, iwl9260_2ac_160_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x401C, iwl9260_2ac_160_cfg)},
 	{IWL_PCI_DEVICE(0x2526, 0x4034, iwl9560_2ac_160_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x40A4, iwl9462_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x4234, iwl9560_2ac_cfg_soc)},
 	{IWL_PCI_DEVICE(0x2526, 0x42A4, iwl9462_2ac_cfg_soc)},
-	{IWL_PCI_DEVICE(0x2526, 0x6010, iwl9260_2ac_160_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x6014, iwl9260_2ac_160_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x8014, iwl9260_2ac_160_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0x8010, iwl9260_2ac_160_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0xA014, iwl9260_2ac_160_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0xE010, iwl9260_2ac_160_cfg)},
-	{IWL_PCI_DEVICE(0x2526, 0xE014, iwl9260_2ac_160_cfg)},
 	{IWL_PCI_DEVICE(0x2526, PCI_ANY_ID, iwl9000_trans_cfg)},
 
 	{IWL_PCI_DEVICE(0x271B, 0x0010, iwl9160_2ac_cfg)},
@@ -981,19 +971,28 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 };
 MODULE_DEVICE_TABLE(pci, iwl_hw_card_ids);
 
-#define IWL_DEV_INFO(_device, _subdevice, _cfg) \
-	{.device = (_device), .subdevice = (_subdevice), .cfg = &(_cfg)}
+#define IWL_DEV_INFO(_device, _subdevice, _cfg, _name)			 \
+	{ .device = (_device), .subdevice = (_subdevice), .cfg = &(_cfg), \
+	  .name = _name }
 
 static const struct iwl_dev_info iwl_dev_info_table[] = {
 #if IS_ENABLED(CONFIG_IWLMVM)
-	IWL_DEV_INFO(0x2526, 0x0010, iwl9260_2ac_160_cfg),
-	IWL_DEV_INFO(0x2526, 0x0014, iwl9260_2ac_160_cfg),
-	IWL_DEV_INFO(0x2526, 0x0018, iwl9260_2ac_160_cfg),
-	IWL_DEV_INFO(0x2526, 0x001C, iwl9260_2ac_160_cfg),
-	IWL_DEV_INFO(0x2526, 0x0030, iwl9560_2ac_160_cfg),
-	IWL_DEV_INFO(0x2526, 0x0038, iwl9560_2ac_160_cfg),
-	IWL_DEV_INFO(0x2526, 0x003C, iwl9560_2ac_160_cfg),
-	IWL_DEV_INFO(0x2526, 0x4030, iwl9560_2ac_160_cfg),
+	IWL_DEV_INFO(0x2526, 0x0010, iwl9260_2ac_160_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0x0014, iwl9260_2ac_160_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0x0018, iwl9260_2ac_160_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0x001C, iwl9260_2ac_160_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0x6010, iwl9260_2ac_160_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0x6014, iwl9260_2ac_160_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0x8014, iwl9260_2ac_160_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0x8010, iwl9260_2ac_160_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0xA014, iwl9260_2ac_160_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0xE010, iwl9260_2ac_160_cfg, iwl9260_160_name),
+	IWL_DEV_INFO(0x2526, 0xE014, iwl9260_2ac_160_cfg, iwl9260_160_name),
+
+	IWL_DEV_INFO(0x2526, 0x0030, iwl9560_2ac_160_cfg, iwl9560_160_name),
+	IWL_DEV_INFO(0x2526, 0x0038, iwl9560_2ac_160_cfg, iwl9560_160_name),
+	IWL_DEV_INFO(0x2526, 0x003C, iwl9560_2ac_160_cfg, iwl9560_160_name),
+	IWL_DEV_INFO(0x2526, 0x4030, iwl9560_2ac_160_cfg, iwl9560_160_name),
 #endif /* CONFIG_IWLMVM */
 };
 
@@ -1037,6 +1036,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		    (dev_info->subdevice == IWL_CFG_ANY ||
 		     dev_info->subdevice == pdev->subsystem_device)) {
 			iwl_trans->cfg = dev_info->cfg;
+			iwl_trans->name = dev_info->name;
 			goto found;
 		}
 	}
@@ -1164,6 +1164,10 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		iwl_trans->cfg = cfg;
 
 found:
+	/* if we don't have a name yet, copy name from the old cfg */
+	if (!iwl_trans->name)
+		iwl_trans->name = iwl_trans->cfg->name;
+
 	if (iwl_trans->trans_cfg->mq_rx_supported) {
 		if (WARN_ON(!iwl_trans->cfg->num_rbds)) {
 			ret = -EINVAL;
-- 
2.24.1

