Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66AED17D9A6
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2020 08:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgCIHQf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Mar 2020 03:16:35 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33040 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726383AbgCIHQf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Mar 2020 03:16:35 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1jBCeO-0007CP-Lo; Mon, 09 Mar 2020 09:16:33 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  9 Mar 2020 09:16:09 +0200
Message-Id: <iwlwifi.20200309091348.a6bef6ee8fe1.I01f7a6f49aa60d2d61633a8a8b859015681eac5b@changeid>
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
Subject: [PATCH 03/13] iwlwifi: add mac/rf types and 160MHz to the device tables
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Add MAC ID, RF ID and the bit that tells us whether the device can
handle 160MHz bandwidth to the device struct.

This allows us to chose the correct structure and string depending on
these parameters.  Do so for all the 0x2526 devices we already moved
to the new table.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-config.h   | 15 +++++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 56 ++++++++++---------
 2 files changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index d95b1b513768..08ac4b1d18dd 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -454,9 +454,24 @@ struct iwl_cfg {
 
 #define IWL_CFG_ANY (~0)
 
+#define IWL_CFG_MAC_TYPE_TH		0x32
+#define IWL_CFG_MAC_TYPE_QU		0x33
+
+#define IWL_CFG_RF_TYPE_TH		0x105
+#define IWL_CFG_RF_TYPE_JF2		0x105
+#define IWL_CFG_RF_TYPE_JF1		0x108
+
+#define IWL_CFG_NO_160			0x0
+#define IWL_CFG_160			0x1
+
+#define IWL_SUBDEVICE_NO_160(subdevice)	((u16)((subdevice) & 0x0100) >> 9)
+
 struct iwl_dev_info {
 	u16 device;
 	u16 subdevice;
+	u16 mac_type;
+	u16 rf_type;
+	u8 no_160;
 	const struct iwl_cfg *cfg;
 	const char *name;
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 51f4f4e9aa30..ef023d61ef3a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -941,29 +941,18 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 };
 MODULE_DEVICE_TABLE(pci, iwl_hw_card_ids);
 
-#define IWL_DEV_INFO(_device, _subdevice, _cfg, _name)			 \
-	{ .device = (_device), .subdevice = (_subdevice), .cfg = &(_cfg), \
-	  .name = _name }
+#define _IWL_DEV_INFO(_device, _subdevice, _mac_type, _rf_type, _no_160,   \
+		      _cfg, _name)					   \
+	{ .device = (_device), .subdevice = (_subdevice), .cfg = &(_cfg),  \
+	  .name = _name, .mac_type = _mac_type, .rf_type = _rf_type,	   \
+	  .no_160 = _no_160, }
+
+#define IWL_DEV_INFO(_device, _subdevice, _cfg, _name) \
+	_IWL_DEV_INFO(_device, _subdevice, IWL_CFG_ANY, IWL_CFG_ANY,	\
+		      IWL_CFG_ANY, _cfg, _name)
 
 static const struct iwl_dev_info iwl_dev_info_table[] = {
 #if IS_ENABLED(CONFIG_IWLMVM)
-	IWL_DEV_INFO(0x2526, 0x0010, iwl9260_2ac_cfg, iwl9260_160_name),
-	IWL_DEV_INFO(0x2526, 0x0014, iwl9260_2ac_cfg, iwl9260_160_name),
-	IWL_DEV_INFO(0x2526, 0x0018, iwl9260_2ac_cfg, iwl9260_160_name),
-	IWL_DEV_INFO(0x2526, 0x001C, iwl9260_2ac_cfg, iwl9260_160_name),
-	IWL_DEV_INFO(0x2526, 0x6010, iwl9260_2ac_cfg, iwl9260_160_name),
-	IWL_DEV_INFO(0x2526, 0x6014, iwl9260_2ac_cfg, iwl9260_160_name),
-	IWL_DEV_INFO(0x2526, 0x8014, iwl9260_2ac_cfg, iwl9260_160_name),
-	IWL_DEV_INFO(0x2526, 0x8010, iwl9260_2ac_cfg, iwl9260_160_name),
-	IWL_DEV_INFO(0x2526, 0xA014, iwl9260_2ac_cfg, iwl9260_160_name),
-	IWL_DEV_INFO(0x2526, 0xE010, iwl9260_2ac_cfg, iwl9260_160_name),
-	IWL_DEV_INFO(0x2526, 0xE014, iwl9260_2ac_cfg, iwl9260_160_name),
-
-	IWL_DEV_INFO(0x2526, 0x0210, iwl9260_2ac_cfg, iwl9260_name),
-	IWL_DEV_INFO(0x2526, 0x0214, iwl9260_2ac_cfg, iwl9260_name),
-	IWL_DEV_INFO(0x2526, 0x1010, iwl9260_2ac_cfg, iwl9260_name),
-	IWL_DEV_INFO(0x2526, 0x1210, iwl9260_2ac_cfg, iwl9260_name),
-
 	IWL_DEV_INFO(0x2526, 0x1410, iwl9260_2ac_cfg, iwl9270_name),
 	IWL_DEV_INFO(0x2526, 0x1610, iwl9260_2ac_cfg, iwl9270_name),
 
@@ -999,6 +988,13 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 
 	IWL_DEV_INFO(0x2526, 0x1551, iwl9560_2ac_cfg_soc, iwl9560_killer_1550s_name),
 	IWL_DEV_INFO(0x2526, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name),
+
+	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_RF_TYPE_TH, IWL_CFG_160,
+		      iwl9260_2ac_cfg, iwl9260_160_name),
+	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_RF_TYPE_TH, IWL_CFG_NO_160,
+		      iwl9260_2ac_cfg, iwl9260_name),
 #endif /* CONFIG_IWLMVM */
 };
 
@@ -1034,13 +1030,23 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* the trans_cfg should never change, so set it now */
 	iwl_trans->trans_cfg = trans;
 
+	iwl_trans->hw_rf_id = iwl_read32(iwl_trans, CSR_HW_RF_ID);
+
 	for (i = 0; i < ARRAY_SIZE(iwl_dev_info_table); i++) {
 		const struct iwl_dev_info *dev_info = &iwl_dev_info_table[i];
-
-		if ((dev_info->device == IWL_CFG_ANY ||
+		if ((dev_info->device == (u16)IWL_CFG_ANY ||
 		     dev_info->device == pdev->device) &&
-		    (dev_info->subdevice == IWL_CFG_ANY ||
-		     dev_info->subdevice == pdev->subsystem_device)) {
+		    (dev_info->subdevice == (u16)IWL_CFG_ANY ||
+		     dev_info->subdevice == pdev->subsystem_device) &&
+		    (dev_info->mac_type == (u16)IWL_CFG_ANY ||
+		     dev_info->mac_type ==
+		     CSR_HW_REV_TYPE(iwl_trans->hw_rev)) &&
+		    (dev_info->rf_type == (u16)IWL_CFG_ANY ||
+		     dev_info->rf_type ==
+		     CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id)) &&
+		    (dev_info->no_160 == (u8)IWL_CFG_ANY ||
+		     dev_info->no_160 ==
+		     IWL_SUBDEVICE_NO_160(pdev->subsystem_device))) {
 			iwl_trans->cfg = dev_info->cfg;
 			iwl_trans->name = dev_info->name;
 			goto found;
@@ -1065,8 +1071,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	    (iwl_trans->hw_rev & CSR_HW_REV_TYPE_MSK) == CSR_HW_REV_TYPE_7265D)
 		iwl_trans->cfg = cfg_7265d;
 
-	iwl_trans->hw_rf_id = iwl_read32(iwl_trans, CSR_HW_RF_ID);
-
 	if (cfg == &iwlax210_2ax_cfg_so_hr_a0) {
 		if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_TY) {
 			iwl_trans->cfg = &iwlax210_2ax_cfg_ty_gf_a0;
-- 
2.25.1

