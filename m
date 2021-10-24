Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4D8438955
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhJXN5g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 09:57:36 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58522 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231524AbhJXN5g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 09:57:36 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1medxx-000cvJ-IN; Sun, 24 Oct 2021 16:55:14 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 16:54:59 +0300
Message-Id: <iwlwifi.20211024165252.ef06ed58a26e.Ie9664a94b157c5781c481118d900ae428c26fdb3@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211024135506.285102-1-luca@coelho.fi>
References: <20211024135506.285102-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 04/11] iwlwifi: pcie: refactor dev_info lookup
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The large condition here is not very clear, refactor the code to
a separate function where we can more easily just check each of
the pieces separately.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 99 +++++++++++++------
 1 file changed, 68 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index fec1620bd593..adb3ad26b712 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -519,7 +519,7 @@ MODULE_DEVICE_TABLE(pci, iwl_hw_card_ids);
 #define IWL_DEV_INFO(_device, _subdevice, _cfg, _name) \
 	_IWL_DEV_INFO(_device, _subdevice, IWL_CFG_ANY, IWL_CFG_ANY,	   \
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,  \
-		      IWL_CFG_NO_CDB, _cfg, _name)
+		      IWL_CFG_ANY, _cfg, _name)
 
 static const struct iwl_dev_info iwl_dev_info_table[] = {
 #if IS_ENABLED(CONFIG_IWLMVM)
@@ -1312,13 +1312,67 @@ static int get_crf_id(struct iwl_trans *iwl_trans)
 /* PCI registers */
 #define PCI_CFG_RETRY_TIMEOUT	0x041
 
+static const struct iwl_dev_info *
+iwl_pci_find_dev_info(u16 device, u16 subsystem_device,
+		      u16 mac_type, u8 mac_step,
+		      u16 rf_type, u8 cdb, u8 rf_id, u8 no_160, u8 cores)
+{
+	const struct iwl_dev_info *ret = NULL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(iwl_dev_info_table); i++) {
+		const struct iwl_dev_info *dev_info = &iwl_dev_info_table[i];
+
+		if (dev_info->device != (u16)IWL_CFG_ANY &&
+		    dev_info->device != device)
+			continue;
+
+		if (dev_info->subdevice != (u16)IWL_CFG_ANY &&
+		    dev_info->subdevice != subsystem_device)
+			continue;
+
+		if (dev_info->mac_type != (u16)IWL_CFG_ANY &&
+		    dev_info->mac_type != mac_type)
+			continue;
+
+		if (dev_info->mac_step != (u8)IWL_CFG_ANY &&
+		    dev_info->mac_step != mac_step)
+			continue;
+
+		if (dev_info->rf_type != (u16)IWL_CFG_ANY &&
+		    dev_info->rf_type != rf_type)
+			continue;
+
+		if (dev_info->cdb != (u8)IWL_CFG_ANY &&
+		    dev_info->cdb != cdb)
+			continue;
+
+		if (dev_info->rf_id != (u8)IWL_CFG_ANY &&
+		    dev_info->rf_id != rf_id)
+			continue;
+
+		if (dev_info->no_160 != (u8)IWL_CFG_ANY &&
+		    dev_info->no_160 != no_160)
+			continue;
+
+		if (dev_info->cores != (u8)IWL_CFG_ANY &&
+		    dev_info->cores != cores)
+			continue;
+
+		ret = dev_info;
+	}
+
+	return ret;
+}
+
 static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	const struct iwl_cfg_trans_params *trans;
 	const struct iwl_cfg *cfg_7265d __maybe_unused = NULL;
+	const struct iwl_dev_info *dev_info;
 	struct iwl_trans *iwl_trans;
 	struct iwl_trans_pcie *trans_pcie;
-	int i, ret;
+	int ret;
 	const struct iwl_cfg *cfg;
 
 	trans = (void *)(ent->driver_data & ~TRANS_CFG_MARKER);
@@ -1370,35 +1424,18 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	    !CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id) && get_crf_id(iwl_trans))
 		goto out_free_trans;
 
-	for (i = 0; i < ARRAY_SIZE(iwl_dev_info_table); i++) {
-		const struct iwl_dev_info *dev_info = &iwl_dev_info_table[i];
-		if ((dev_info->device == (u16)IWL_CFG_ANY ||
-		     dev_info->device == pdev->device) &&
-		    (dev_info->subdevice == (u16)IWL_CFG_ANY ||
-		     dev_info->subdevice == pdev->subsystem_device) &&
-		    (dev_info->mac_type == (u16)IWL_CFG_ANY ||
-		     dev_info->mac_type ==
-		     CSR_HW_REV_TYPE(iwl_trans->hw_rev)) &&
-		    (dev_info->mac_step == (u8)IWL_CFG_ANY ||
-		     dev_info->mac_step ==
-		     CSR_HW_REV_STEP(iwl_trans->hw_rev)) &&
-		    (dev_info->rf_type == (u16)IWL_CFG_ANY ||
-		     dev_info->rf_type ==
-		     CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id)) &&
-		    (dev_info->cdb == IWL_CFG_NO_CDB ||
-		     CSR_HW_RFID_IS_CDB(iwl_trans->hw_rf_id)) &&
-		    (dev_info->rf_id == (u8)IWL_CFG_ANY ||
-		     dev_info->rf_id ==
-		     IWL_SUBDEVICE_RF_ID(pdev->subsystem_device)) &&
-		    (dev_info->no_160 == (u8)IWL_CFG_ANY ||
-		     dev_info->no_160 ==
-		     IWL_SUBDEVICE_NO_160(pdev->subsystem_device)) &&
-		    (dev_info->cores == (u8)IWL_CFG_ANY ||
-		     dev_info->cores ==
-		     IWL_SUBDEVICE_CORES(pdev->subsystem_device))) {
-			iwl_trans->cfg = dev_info->cfg;
-			iwl_trans->name = dev_info->name;
-		}
+	dev_info = iwl_pci_find_dev_info(pdev->device, pdev->subsystem_device,
+					 CSR_HW_REV_TYPE(iwl_trans->hw_rev),
+					 CSR_HW_REV_STEP(iwl_trans->hw_rev),
+					 CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id),
+					 CSR_HW_RFID_IS_CDB(iwl_trans->hw_rf_id),
+					 IWL_SUBDEVICE_RF_ID(pdev->subsystem_device),
+					 IWL_SUBDEVICE_NO_160(pdev->subsystem_device),
+					 IWL_SUBDEVICE_CORES(pdev->subsystem_device));
+
+	if (dev_info) {
+		iwl_trans->cfg = dev_info->cfg;
+		iwl_trans->name = dev_info->name;
 	}
 
 #if IS_ENABLED(CONFIG_IWLMVM)
-- 
2.33.0

