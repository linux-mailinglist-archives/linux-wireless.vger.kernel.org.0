Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83F517D9A7
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Mar 2020 08:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgCIHQg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Mar 2020 03:16:36 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:33046 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726027AbgCIHQf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Mar 2020 03:16:35 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1jBCeP-0007CP-Ce; Mon, 09 Mar 2020 09:16:33 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon,  9 Mar 2020 09:16:10 +0200
Message-Id: <iwlwifi.20200309091348.1f958e558d05.I45492bb57cbbeb4cc0ec84313bade4def7377a27@changeid>
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
Subject: [PATCH 04/13] iwlwifi: add GNSS differentiation to the device tables
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Devices that also include a GNSS module have different names, so add a
new device option to differentiate them, according to the values we
have in the modules section of the subsystem device ID.

Additionally, convert the two applicable devices to use this value
instead of hardcoded subsystem IDs.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  1 +
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  6 +++++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 25 +++++++++++++------
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
index 3693adf3d510..af4911876a40 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/9000.c
@@ -196,6 +196,7 @@ const char iwl9461_name[] = "Intel(R) Wireless-AC 9461";
 const char iwl9462_name[] = "Intel(R) Wireless-AC 9462";
 const char iwl9560_name[] = "Intel(R) Wireless-AC 9560";
 const char iwl9260_160_name[] = "Intel(R) Wireless-AC 9260 160MHz";
+const char iwl9270_160_name[] = "Intel(R) Wireless-AC 9270 160MHz";
 const char iwl9560_160_name[] = "Intel(R) Wireless-AC 9560 160MHz";
 
 const char iwl9260_killer_1550_name[] =
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index 08ac4b1d18dd..e2b8f6b95678 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -464,7 +464,11 @@ struct iwl_cfg {
 #define IWL_CFG_NO_160			0x0
 #define IWL_CFG_160			0x1
 
+#define IWL_CFG_CORES_BT		0x0
+#define IWL_CFG_CORES_BT_GNSS		0x5
+
 #define IWL_SUBDEVICE_NO_160(subdevice)	((u16)((subdevice) & 0x0100) >> 9)
+#define IWL_SUBDEVICE_CORES(subdevice)	((u16)((subdevice) & 0x1C00) >> 10)
 
 struct iwl_dev_info {
 	u16 device;
@@ -472,6 +476,7 @@ struct iwl_dev_info {
 	u16 mac_type;
 	u16 rf_type;
 	u8 no_160;
+	u8 cores;
 	const struct iwl_cfg *cfg;
 	const char *name;
 };
@@ -486,6 +491,7 @@ extern const char iwl9461_name[];
 extern const char iwl9462_name[];
 extern const char iwl9560_name[];
 extern const char iwl9260_160_name[];
+extern const char iwl9270_160_name[];
 extern const char iwl9560_160_name[];
 extern const char iwl9260_killer_1550_name[];
 extern const char iwl9560_killer_1550i_name[];
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index ef023d61ef3a..f474d1426970 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -942,20 +942,17 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 MODULE_DEVICE_TABLE(pci, iwl_hw_card_ids);
 
 #define _IWL_DEV_INFO(_device, _subdevice, _mac_type, _rf_type, _no_160,   \
-		      _cfg, _name)					   \
+		      _cores, _cfg, _name)				   \
 	{ .device = (_device), .subdevice = (_subdevice), .cfg = &(_cfg),  \
 	  .name = _name, .mac_type = _mac_type, .rf_type = _rf_type,	   \
-	  .no_160 = _no_160, }
+	  .no_160 = _no_160, .cores = _cores }
 
 #define IWL_DEV_INFO(_device, _subdevice, _cfg, _name) \
 	_IWL_DEV_INFO(_device, _subdevice, IWL_CFG_ANY, IWL_CFG_ANY,	\
-		      IWL_CFG_ANY, _cfg, _name)
+		      IWL_CFG_ANY, IWL_CFG_ANY, _cfg, _name)
 
 static const struct iwl_dev_info iwl_dev_info_table[] = {
 #if IS_ENABLED(CONFIG_IWLMVM)
-	IWL_DEV_INFO(0x2526, 0x1410, iwl9260_2ac_cfg, iwl9270_name),
-	IWL_DEV_INFO(0x2526, 0x1610, iwl9260_2ac_cfg, iwl9270_name),
-
 	IWL_DEV_INFO(0x2526, 0x1550, iwl9260_2ac_cfg, iwl9260_killer_1550_name),
 
 	IWL_DEV_INFO(0x2526, 0x0030, iwl9560_2ac_cfg, iwl9560_160_name),
@@ -991,9 +988,20 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_RF_TYPE_TH, IWL_CFG_160,
+		      IWL_CFG_CORES_BT_GNSS,
+		      iwl9260_2ac_cfg, iwl9270_160_name),
+	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_RF_TYPE_TH, IWL_CFG_NO_160,
+		      IWL_CFG_CORES_BT_GNSS,
+		      iwl9260_2ac_cfg, iwl9270_name),
+
+	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
+		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_RF_TYPE_TH, IWL_CFG_160,
+		      IWL_CFG_CORES_BT,
 		      iwl9260_2ac_cfg, iwl9260_160_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_RF_TYPE_TH, IWL_CFG_NO_160,
+		      IWL_CFG_CORES_BT,
 		      iwl9260_2ac_cfg, iwl9260_name),
 #endif /* CONFIG_IWLMVM */
 };
@@ -1046,7 +1054,10 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		     CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id)) &&
 		    (dev_info->no_160 == (u8)IWL_CFG_ANY ||
 		     dev_info->no_160 ==
-		     IWL_SUBDEVICE_NO_160(pdev->subsystem_device))) {
+		     IWL_SUBDEVICE_NO_160(pdev->subsystem_device)) &&
+		    (dev_info->cores == (u8)IWL_CFG_ANY ||
+		     dev_info->cores ==
+		     IWL_SUBDEVICE_CORES(pdev->subsystem_device))) {
 			iwl_trans->cfg = dev_info->cfg;
 			iwl_trans->name = dev_info->name;
 			goto found;
-- 
2.25.1

