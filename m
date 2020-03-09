Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0DBB17D9A9
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2020 08:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgCIHQi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Mar 2020 03:16:38 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33054 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725796AbgCIHQg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Mar 2020 03:16:36 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1jBCeQ-0007CP-4t; Mon, 09 Mar 2020 09:16:34 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  9 Mar 2020 09:16:11 +0200
Message-Id: <iwlwifi.20200309091348.602bb33528cf.I3acacb07c69ed063c7f1ca78f2dce9b7b4ef3946@changeid>
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
Subject: [PATCH 05/13] iwlwifi: add Pu/PnJ/Th device values to differentiate them
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Pu, PnJ and Th devices have different combinations of PCI ID, MAC ID
and RF IDs.  Use these to differentiate them and choose the correct
configuration.

This also includes a change from using soc cfg's for 0x2526
devices (PnJ/Th), which was incorrect.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  9 ++++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 54 +++++++++----------
 2 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index e2b8f6b95678..7a985b317807 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -454,6 +454,8 @@ struct iwl_cfg {
 
 #define IWL_CFG_ANY (~0)
 
+#define IWL_CFG_MAC_TYPE_PU		0x31
+#define IWL_CFG_MAC_TYPE_PNJ		0x32
 #define IWL_CFG_MAC_TYPE_TH		0x32
 #define IWL_CFG_MAC_TYPE_QU		0x33
 
@@ -461,12 +463,18 @@ struct iwl_cfg {
 #define IWL_CFG_RF_TYPE_JF2		0x105
 #define IWL_CFG_RF_TYPE_JF1		0x108
 
+#define IWL_CFG_RF_ID_TH		0x1
+#define IWL_CFG_RF_ID_TH1		0x1
+#define IWL_CFG_RF_ID_JF		0x3
+#define IWL_CFG_RF_ID_JF1		0x6
+
 #define IWL_CFG_NO_160			0x0
 #define IWL_CFG_160			0x1
 
 #define IWL_CFG_CORES_BT		0x0
 #define IWL_CFG_CORES_BT_GNSS		0x5
 
+#define IWL_SUBDEVICE_RF_ID(subdevice)	((u16)((subdevice) & 0x00F0) >> 4)
 #define IWL_SUBDEVICE_NO_160(subdevice)	((u16)((subdevice) & 0x0100) >> 9)
 #define IWL_SUBDEVICE_CORES(subdevice)	((u16)((subdevice) & 0x1C00) >> 10)
 
@@ -475,6 +483,7 @@ struct iwl_dev_info {
 	u16 subdevice;
 	u16 mac_type;
 	u16 rf_type;
+	u8 rf_id;
 	u8 no_160;
 	u8 cores;
 	const struct iwl_cfg *cfg;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index f474d1426970..492aa4469608 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -941,36 +941,20 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 };
 MODULE_DEVICE_TABLE(pci, iwl_hw_card_ids);
 
-#define _IWL_DEV_INFO(_device, _subdevice, _mac_type, _rf_type, _no_160,   \
-		      _cores, _cfg, _name)				   \
+#define _IWL_DEV_INFO(_device, _subdevice, _mac_type, _rf_type, _rf_id,    \
+		      _no_160, _cores, _cfg, _name)			   \
 	{ .device = (_device), .subdevice = (_subdevice), .cfg = &(_cfg),  \
 	  .name = _name, .mac_type = _mac_type, .rf_type = _rf_type,	   \
-	  .no_160 = _no_160, .cores = _cores }
+	  .no_160 = _no_160, .cores = _cores, .rf_id = _rf_id, }
 
 #define IWL_DEV_INFO(_device, _subdevice, _cfg, _name) \
-	_IWL_DEV_INFO(_device, _subdevice, IWL_CFG_ANY, IWL_CFG_ANY,	\
-		      IWL_CFG_ANY, IWL_CFG_ANY, _cfg, _name)
+	_IWL_DEV_INFO(_device, _subdevice, IWL_CFG_ANY, IWL_CFG_ANY,	   \
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY, _cfg, _name)
 
 static const struct iwl_dev_info iwl_dev_info_table[] = {
 #if IS_ENABLED(CONFIG_IWLMVM)
 	IWL_DEV_INFO(0x2526, 0x1550, iwl9260_2ac_cfg, iwl9260_killer_1550_name),
 
-	IWL_DEV_INFO(0x2526, 0x0030, iwl9560_2ac_cfg, iwl9560_160_name),
-	IWL_DEV_INFO(0x2526, 0x0038, iwl9560_2ac_cfg, iwl9560_160_name),
-	IWL_DEV_INFO(0x2526, 0x003C, iwl9560_2ac_cfg, iwl9560_160_name),
-	IWL_DEV_INFO(0x2526, 0x4030, iwl9560_2ac_cfg, iwl9560_160_name),
-	IWL_DEV_INFO(0x2526, 0x2030, iwl9560_2ac_cfg_soc, iwl9560_160_name),
-	IWL_DEV_INFO(0x2526, 0x2034, iwl9560_2ac_cfg_soc, iwl9560_160_name),
-	IWL_DEV_INFO(0x2526, 0x4034, iwl9560_2ac_cfg_soc, iwl9560_160_name),
-
-	IWL_DEV_INFO(0x2526, 0x0034, iwl9560_2ac_cfg, iwl9560_name),
-	IWL_DEV_INFO(0x2526, 0x0230, iwl9560_2ac_cfg, iwl9560_name),
-	IWL_DEV_INFO(0x2526, 0x0234, iwl9560_2ac_cfg, iwl9560_name),
-	IWL_DEV_INFO(0x2526, 0x0238, iwl9560_2ac_cfg, iwl9560_name),
-	IWL_DEV_INFO(0x2526, 0x023C, iwl9560_2ac_cfg, iwl9560_name),
-	IWL_DEV_INFO(0x2526, 0x1030, iwl9560_2ac_cfg, iwl9560_name),
-	IWL_DEV_INFO(0x2526, 0x4234, iwl9560_2ac_cfg_soc, iwl9560_name),
-
 	IWL_DEV_INFO(0x2526, 0x0060, iwl9560_2ac_cfg_soc, iwl9461_name),
 	IWL_DEV_INFO(0x2526, 0x0064, iwl9560_2ac_cfg_soc, iwl9461_name),
 	IWL_DEV_INFO(0x2526, 0x0260, iwl9560_2ac_cfg_soc, iwl9461_name),
@@ -987,21 +971,30 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x2526, 0x1552, iwl9560_2ac_cfg_soc, iwl9560_killer_1550i_name),
 
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_RF_TYPE_TH, IWL_CFG_160,
-		      IWL_CFG_CORES_BT_GNSS,
+		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      iwl9560_2ac_cfg, iwl9560_160_name),
+	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      iwl9560_2ac_cfg, iwl9560_name),
+
+	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY,
+		      IWL_CFG_160, IWL_CFG_CORES_BT_GNSS,
 		      iwl9260_2ac_cfg, iwl9270_160_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_RF_TYPE_TH, IWL_CFG_NO_160,
-		      IWL_CFG_CORES_BT_GNSS,
+		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT_GNSS,
 		      iwl9260_2ac_cfg, iwl9270_name),
 
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_RF_TYPE_TH, IWL_CFG_160,
-		      IWL_CFG_CORES_BT,
+		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY,
+		      IWL_CFG_160, IWL_CFG_CORES_BT,
 		      iwl9260_2ac_cfg, iwl9260_160_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
-		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_RF_TYPE_TH, IWL_CFG_NO_160,
-		      IWL_CFG_CORES_BT,
+		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
 		      iwl9260_2ac_cfg, iwl9260_name),
 #endif /* CONFIG_IWLMVM */
 };
@@ -1052,6 +1045,9 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		    (dev_info->rf_type == (u16)IWL_CFG_ANY ||
 		     dev_info->rf_type ==
 		     CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id)) &&
+		    (dev_info->rf_id == (u8)IWL_CFG_ANY ||
+		     dev_info->rf_id ==
+		     IWL_SUBDEVICE_RF_ID(pdev->subsystem_device)) &&
 		    (dev_info->no_160 == (u8)IWL_CFG_ANY ||
 		     dev_info->no_160 ==
 		     IWL_SUBDEVICE_NO_160(pdev->subsystem_device)) &&
-- 
2.25.1

