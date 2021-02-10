Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7B8D3166CB
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 13:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhBJMdW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 07:33:22 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:45102 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231937AbhBJMao (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 07:30:44 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l9ocg-0049Yg-9Y; Wed, 10 Feb 2021 14:29:34 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 10 Feb 2021 14:29:23 +0200
Message-Id: <iwlwifi.20210210142629.7b40184d9899.I3bb2cf9b9afb0457583f786dc52d4d1b1ad75ffc@changeid>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210210122927.315774-1-luca@coelho.fi>
References: <20210210122927.315774-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.4
Subject: [PATCH v2 08/12] iwlwifi: pcie: add CDB bit to the device configuration parsing
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Matti Gottlieb <matti.gottlieb@intel.com>

Some new devices contain an extra bit in the CRF ID register to denote
that they support CDB.  Add definitions and macros to be able to
support it and add the "NO_CDB" to all existing entired.

Signed-off-by: Matti Gottlieb <matti.gottlieb@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   4 +
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |   2 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 152 +++++++++---------
 3 files changed, 83 insertions(+), 75 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index b72142a247d0..4a8f7489fc4d 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -445,6 +445,9 @@ struct iwl_cfg {
 #define IWL_CFG_CORES_BT		0x0
 #define IWL_CFG_CORES_BT_GNSS		0x5
 
+#define IWL_CFG_NO_CDB			0x0
+#define IWL_CFG_CDB			0x1
+
 #define IWL_SUBDEVICE_RF_ID(subdevice)	((u16)((subdevice) & 0x00F0) >> 4)
 #define IWL_SUBDEVICE_NO_160(subdevice)	((u16)((subdevice) & 0x0200) >> 9)
 #define IWL_SUBDEVICE_CORES(subdevice)	((u16)((subdevice) & 0x1C00) >> 10)
@@ -458,6 +461,7 @@ struct iwl_dev_info {
 	u8 rf_id;
 	u8 no_160;
 	u8 cores;
+	u8 cdb;
 	const struct iwl_cfg *cfg;
 	const char *name;
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index fe0c03c8d390..6ccde7e30211 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -277,6 +277,8 @@
 #define CSR_HW_RFID_DASH(_val)         (((_val) & 0x00000F0) >> 4)
 #define CSR_HW_RFID_STEP(_val)         (((_val) & 0x0000F00) >> 8)
 #define CSR_HW_RFID_TYPE(_val)         (((_val) & 0x0FFF000) >> 12)
+#define CSR_HW_RFID_IS_CDB(_val)       (((_val) & 0x10000000) >> 28)
+#define CSR_HW_RFID_IS_JACKET(_val)    (((_val) & 0x20000000) >> 29)
 
 /**
  *  hw_rev values
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 3e149141fec5..80d17f0ca3fe 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -497,16 +497,16 @@ static const struct pci_device_id iwl_hw_card_ids[] = {
 MODULE_DEVICE_TABLE(pci, iwl_hw_card_ids);
 
 #define _IWL_DEV_INFO(_device, _subdevice, _mac_type, _mac_step, _rf_type, \
-		      _rf_id, _no_160, _cores, _cfg, _name)		   \
+		      _rf_id, _no_160, _cores, _cdb, _cfg, _name)		   \
 	{ .device = (_device), .subdevice = (_subdevice), .cfg = &(_cfg),  \
 	  .name = _name, .mac_type = _mac_type, .rf_type = _rf_type,	   \
 	  .no_160 = _no_160, .cores = _cores, .rf_id = _rf_id,		   \
-	  .mac_step = _mac_step }
+	  .mac_step = _mac_step, .cdb = _cdb }
 
 #define IWL_DEV_INFO(_device, _subdevice, _cfg, _name) \
 	_IWL_DEV_INFO(_device, _subdevice, IWL_CFG_ANY, IWL_CFG_ANY,	   \
 		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_ANY,  \
-		      _cfg, _name)
+		      IWL_CFG_NO_CDB, _cfg, _name)
 
 static const struct iwl_dev_info iwl_dev_info_table[] = {
 #if IS_ENABLED(CONFIG_IWLMVM)
@@ -632,98 +632,98 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_2ac_cfg_soc, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_2ac_cfg_soc, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_2ac_cfg_soc, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_2ac_cfg_soc, iwl9462_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_2ac_cfg_soc, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PU, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_2ac_cfg_soc, iwl9560_name),
 
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9461_160_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9461_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9462_160_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9462_name),
 
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9560_160_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_PNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9560_name),
 
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT_GNSS,
+		      IWL_CFG_160, IWL_CFG_CORES_BT_GNSS, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9270_160_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT_GNSS,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT_GNSS, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9270_name),
 
 	_IWL_DEV_INFO(0x271B, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_TH1, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9162_160_name),
 	_IWL_DEV_INFO(0x271B, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_TH1, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9162_name),
 
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9260_160_name),
 	_IWL_DEV_INFO(0x2526, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_TH, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_TH, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9260_2ac_cfg, iwl9260_name),
 
 /* Qu with Jf */
@@ -731,176 +731,176 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9462_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9560_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1551,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9560_killer_1550s_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1552,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_b0_jf_b0_cfg, iwl9560_killer_1550i_name),
 
 	/* Qu C step */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9462_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9560_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1551,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9560_killer_1550s_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1552,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qu_c0_jf_b0_cfg, iwl9560_killer_1550i_name),
 
 	/* QuZ */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9462_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1551,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_killer_1550s_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1552,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_quz_a0_jf_b0_cfg, iwl9560_killer_1550i_name),
 
 	/* QnJ */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qnj_b0_jf_b0_cfg, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qnj_b0_jf_b0_cfg, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qnj_b0_jf_b0_cfg, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qnj_b0_jf_b0_cfg, iwl9462_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qnj_b0_jf_b0_cfg, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qnj_b0_jf_b0_cfg, iwl9560_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1551,
 		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qnj_b0_jf_b0_cfg, iwl9560_killer_1550s_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, 0x1552,
 		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl9560_qnj_b0_jf_b0_cfg, iwl9560_killer_1550i_name),
 
 /* Qu with Hr */
@@ -908,128 +908,128 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_qu_b0_hr1_b0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_qu_b0_hr_b0, iwl_ax203_name),
 
 	/* Qu C step */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_qu_c0_hr1_b0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QU, SILICON_C_STEP,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_qu_c0_hr_b0, iwl_ax203_name),
 
 	/* QuZ */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_quz_a0_hr1_b0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QUZ, SILICON_B_STEP,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_ANY,
+		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_quz_a0_hr_b0, iwl_ax203_name),
 
 /* QnJ with Hr */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_QNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_qnj_b0_hr_b0_cfg, iwl_ax201_name),
 
 /* SnJ with Jf */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl_cfg_snj_a0_jf_b0, iwl9461_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl_cfg_snj_a0_jf_b0, iwl9461_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl_cfg_snj_a0_jf_b0, iwl9462_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF1, IWL_CFG_RF_ID_JF1_DIV,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl_cfg_snj_a0_jf_b0, iwl9462_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl_cfg_snj_a0_jf_b0, iwl9560_160_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_JF2, IWL_CFG_RF_ID_JF,
-		      IWL_CFG_NO_160, IWL_CFG_CORES_BT,
+		      IWL_CFG_NO_160, IWL_CFG_CORES_BT, IWL_CFG_NO_CDB,
 		      iwl_cfg_snj_a0_jf_b0, iwl9560_name),
 
 /* SnJ with Hr */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_snj_hr_b0, iwl_ax101_name),
 
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_snj_hr_b0, iwl_ax201_name),
 
 /* Ma */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_GF, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_ma_a0_gf_a0, iwl_ax211_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_MA, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_ma_a0_mr_a0, iwl_ma_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SNJ, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_MR, IWL_CFG_ANY,
-		      IWL_CFG_ANY, IWL_CFG_ANY,
+		      IWL_CFG_ANY, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_snj_a0_mr_a0, iwl_ma_name),
 
 /* So with Hr */
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_ANY,
+		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax203_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
-		      IWL_CFG_NO_160, IWL_CFG_ANY,
+		      IWL_CFG_NO_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax203_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR1, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_ANY,
+		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax101_name),
 	_IWL_DEV_INFO(IWL_CFG_ANY, IWL_CFG_ANY,
 		      IWL_CFG_MAC_TYPE_SO, IWL_CFG_ANY,
 		      IWL_CFG_RF_TYPE_HR2, IWL_CFG_ANY,
-		      IWL_CFG_160, IWL_CFG_ANY,
+		      IWL_CFG_160, IWL_CFG_ANY, IWL_CFG_NO_CDB,
 		      iwl_cfg_so_a0_hr_a0, iwl_ax201_name)
 
 #endif /* CONFIG_IWLMVM */
@@ -1080,6 +1080,8 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		    (dev_info->rf_type == (u16)IWL_CFG_ANY ||
 		     dev_info->rf_type ==
 		     CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id)) &&
+		    (dev_info->cdb == IWL_CFG_NO_CDB ||
+		     CSR_HW_RFID_IS_CDB(iwl_trans->hw_rf_id)) &&
 		    (dev_info->rf_id == (u8)IWL_CFG_ANY ||
 		     dev_info->rf_id ==
 		     IWL_SUBDEVICE_RF_ID(pdev->subsystem_device)) &&
-- 
2.30.0

