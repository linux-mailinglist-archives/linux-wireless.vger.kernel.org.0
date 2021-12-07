Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E51846BD38
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 15:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbhLGOJZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 09:09:25 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50656 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232119AbhLGOJY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 09:09:24 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mub6O-001BBF-7r; Tue, 07 Dec 2021 16:05:53 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Tue,  7 Dec 2021 16:05:51 +0200
Message-Id: <iwlwifi.20211207160459.2e81a14d1f80.Ia5287e37fb3439d805336837361f6491f958e465@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <iwlwifi.20211204083238.64d2ea8b61f2.Ia5287e37fb3439d805336837361f6491f958e465@changeid>
References: <iwlwifi.20211204083238.64d2ea8b61f2.Ia5287e37fb3439d805336837361f6491f958e465@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v2 03/12] iwlwifi: support 4-bits in MAC step value
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mike Golant <michael.golant@intel.com>

We have a MAC component (which is inside the SoC) and it has several
different HW steps.  3 bits used to be enough but now we need 4-bits
to represent all the different steps.

Properly support 4-bits in the MAC step value by refactoring all the
current handling of the MAC step/dash.

Already from family 8000 and up the dash (bits 0-1) no longer exists
and the step (until 8000 bits 2-3) consists of the dash bits as well.

To do this remove the CSR_HW_REV_STEP and the CSR_HW_REV_DASH
macros, replace them with CSR_HW_REV_STEP_DASH and add hw_rev_step
into the trans struct.

In addition remove the CSR_HW_IF_CONFIG_REG_MSK_MAC_STEP and
CSR_HW_IF_CONFIG_REG_MSK_MAC_DASH macros and create a new macro
combining the 2 (this way we don't need shifting or anything else.)

Signed-off-by: Matti Gottlieb <matti.gottlieb@intel.com>
Signed-off-by: Mike Golant <michael.golant@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---

In v2, reword commit subject, first paragraph and some other small
things in the commit message.

 drivers/net/wireless/intel/iwlwifi/dvm/main.c      |  8 ++------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c        |  4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h       | 14 ++++++--------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c       |  4 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h     |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c       | 10 +++-------
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c      |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c    |  5 +++--
 9 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index fbd57a2b2bd5..90b9becd1673 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1974,12 +1974,8 @@ static void iwl_nic_config(struct iwl_op_mode *op_mode)
 
 	/* SKU Control */
 	iwl_trans_set_bits_mask(priv->trans, CSR_HW_IF_CONFIG_REG,
-				CSR_HW_IF_CONFIG_REG_MSK_MAC_DASH |
-				CSR_HW_IF_CONFIG_REG_MSK_MAC_STEP,
-				(CSR_HW_REV_STEP(priv->trans->hw_rev) <<
-					CSR_HW_IF_CONFIG_REG_POS_MAC_STEP) |
-				(CSR_HW_REV_DASH(priv->trans->hw_rev) <<
-					CSR_HW_IF_CONFIG_REG_POS_MAC_DASH));
+				CSR_HW_IF_CONFIG_REG_MSK_MAC_STEP_DASH,
+				CSR_HW_REV_STEP_DASH(priv->trans->hw_rev));
 
 	/* write radio config values to register */
 	if (priv->nvm_data->radio_cfg_type <= EEPROM_RF_CONFIG_TYPE_MAX) {
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index a39013c401c9..c8a08bdfefa4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -880,7 +880,7 @@ iwl_fw_error_dump_file(struct iwl_fw_runtime *fwrt,
 		dump_info->hw_type =
 			cpu_to_le32(CSR_HW_REV_TYPE(fwrt->trans->hw_rev));
 		dump_info->hw_step =
-			cpu_to_le32(CSR_HW_REV_STEP(fwrt->trans->hw_rev));
+			cpu_to_le32(fwrt->trans->hw_rev_step);
 		memcpy(dump_info->fw_human_readable, fwrt->fw->human_readable,
 		       sizeof(dump_info->fw_human_readable));
 		strncpy(dump_info->dev_human_readable, fwrt->trans->name,
@@ -2099,7 +2099,7 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 	dump->ver_type = cpu_to_le32(fwrt->dump.fw_ver.type);
 	dump->ver_subtype = cpu_to_le32(fwrt->dump.fw_ver.subtype);
 
-	dump->hw_step = cpu_to_le32(CSR_HW_REV_STEP(fwrt->trans->hw_rev));
+	dump->hw_step = cpu_to_le32(fwrt->trans->hw_rev_step);
 
 	/*
 	 * Several HWs all have type == 0x42, so we'll override this value
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index ff79a2ecb242..cfea20e507b3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -143,8 +143,7 @@
 #define CSR_FUNC_SCRATCH_INIT_VALUE		(0x01010101)
 
 /* Bits for CSR_HW_IF_CONFIG_REG */
-#define CSR_HW_IF_CONFIG_REG_MSK_MAC_DASH	(0x00000003)
-#define CSR_HW_IF_CONFIG_REG_MSK_MAC_STEP	(0x0000000C)
+#define CSR_HW_IF_CONFIG_REG_MSK_MAC_STEP_DASH	(0x0000000F)
 #define CSR_HW_IF_CONFIG_REG_BIT_MONITOR_SRAM	(0x00000080)
 #define CSR_HW_IF_CONFIG_REG_MSK_BOARD_VER	(0x000000C0)
 #define CSR_HW_IF_CONFIG_REG_BIT_MAC_SI		(0x00000100)
@@ -287,8 +286,7 @@
 #define CSR_GP_CNTRL_REG_FLAG_SW_RESET			BIT(31)
 
 /* HW REV */
-#define CSR_HW_REV_DASH(_val)          (((_val) & 0x0000003) >> 0)
-#define CSR_HW_REV_STEP(_val)          (((_val) & 0x000000C) >> 2)
+#define CSR_HW_REV_STEP_DASH(_val)     ((_val) & CSR_HW_IF_CONFIG_REG_MSK_MAC_STEP_DASH)
 #define CSR_HW_REV_TYPE(_val)          (((_val) & 0x000FFF0) >> 4)
 
 /* HW RFID */
@@ -328,10 +326,10 @@ enum {
 #define CSR_HW_REV_TYPE_7265D		(0x0000210)
 #define CSR_HW_REV_TYPE_NONE		(0x00001F0)
 #define CSR_HW_REV_TYPE_QNJ		(0x0000360)
-#define CSR_HW_REV_TYPE_QNJ_B0		(0x0000364)
-#define CSR_HW_REV_TYPE_QU_B0		(0x0000334)
-#define CSR_HW_REV_TYPE_QU_C0		(0x0000338)
-#define CSR_HW_REV_TYPE_QUZ		(0x0000354)
+#define CSR_HW_REV_TYPE_QNJ_B0		(0x0000361)
+#define CSR_HW_REV_TYPE_QU_B0		(0x0000331)
+#define CSR_HW_REV_TYPE_QU_C0		(0x0000332)
+#define CSR_HW_REV_TYPE_QUZ		(0x0000351)
 #define CSR_HW_REV_TYPE_HR_CDB		(0x0000340)
 #define CSR_HW_REV_TYPE_SO		(0x0000370)
 #define CSR_HW_REV_TYPE_TY		(0x0000420)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 36196e07b1a0..026116629040 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -163,8 +163,8 @@ static int iwl_request_firmware(struct iwl_drv *drv, bool first)
 	char tag[8];
 
 	if (drv->trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_9000 &&
-	    (CSR_HW_REV_STEP(drv->trans->hw_rev) != SILICON_B_STEP &&
-	     CSR_HW_REV_STEP(drv->trans->hw_rev) != SILICON_C_STEP)) {
+	    (drv->trans->hw_rev_step != SILICON_B_STEP &&
+	     drv->trans->hw_rev_step != SILICON_C_STEP)) {
 		IWL_ERR(drv,
 			"Only HW steps B and C are currently supported (0x%0x)\n",
 			drv->trans->hw_rev);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
index 0cd4718372f5..9ef89ff09105 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
@@ -1609,7 +1609,7 @@ int iwl_read_external_nvm(struct iwl_trans *trans,
 
 		/* nvm file validation, dword_buff[2] holds the file version */
 		if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_8000 &&
-		    CSR_HW_REV_STEP(trans->hw_rev) == SILICON_C_STEP &&
+		    trans->hw_rev_step == SILICON_C_STEP &&
 		    le32_to_cpu(dword_buff[2]) < 0xE4A) {
 			ret = -EFAULT;
 			goto out;
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index a4060af50201..947ed82b7f19 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -938,6 +938,7 @@ struct iwl_trans_txqs {
  * @hw_id: a u32 with the ID of the device / sub-device.
  *	Set during transport allocation.
  * @hw_id_str: a string with info about HW ID. Set during transport allocation.
+ * @hw_rev_step: The mac step of the HW
  * @pm_support: set to true in start_hw if link pm is supported
  * @ltr_enabled: set to true if the LTR is enabled
  * @wide_cmd_header: true when ucode supports wide command header format
@@ -971,6 +972,7 @@ struct iwl_trans {
 	struct device *dev;
 	u32 max_skb_frags;
 	u32 hw_rev;
+	u32 hw_rev_step;
 	u32 hw_rf_id;
 	u32 hw_id;
 	char hw_id_str[52];
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 3ab0217abeea..cd04f24dd7fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -78,7 +78,7 @@ static void iwl_mvm_nic_config(struct iwl_op_mode *op_mode)
 {
 	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
 	u8 radio_cfg_type, radio_cfg_step, radio_cfg_dash;
-	u32 reg_val = 0;
+	u32 reg_val;
 	u32 phy_config = iwl_mvm_get_phy_config(mvm);
 
 	radio_cfg_type = (phy_config & FW_PHY_CFG_RADIO_TYPE) >>
@@ -89,10 +89,7 @@ static void iwl_mvm_nic_config(struct iwl_op_mode *op_mode)
 			 FW_PHY_CFG_RADIO_DASH_POS;
 
 	/* SKU control */
-	reg_val |= CSR_HW_REV_STEP(mvm->trans->hw_rev) <<
-				CSR_HW_IF_CONFIG_REG_POS_MAC_STEP;
-	reg_val |= CSR_HW_REV_DASH(mvm->trans->hw_rev) <<
-				CSR_HW_IF_CONFIG_REG_POS_MAC_DASH;
+	reg_val = CSR_HW_REV_STEP_DASH(mvm->trans->hw_rev);
 
 	/* radio configuration */
 	reg_val |= radio_cfg_type << CSR_HW_IF_CONFIG_REG_POS_PHY_TYPE;
@@ -117,8 +114,7 @@ static void iwl_mvm_nic_config(struct iwl_op_mode *op_mode)
 		reg_val |= CSR_HW_IF_CONFIG_REG_D3_DEBUG;
 
 	iwl_trans_set_bits_mask(mvm->trans, CSR_HW_IF_CONFIG_REG,
-				CSR_HW_IF_CONFIG_REG_MSK_MAC_DASH |
-				CSR_HW_IF_CONFIG_REG_MSK_MAC_STEP |
+				CSR_HW_IF_CONFIG_REG_MSK_MAC_STEP_DASH |
 				CSR_HW_IF_CONFIG_REG_MSK_PHY_TYPE |
 				CSR_HW_IF_CONFIG_REG_MSK_PHY_STEP |
 				CSR_HW_IF_CONFIG_REG_MSK_PHY_DASH |
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 5c56da36fc84..db8b62e432eb 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1450,7 +1450,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	dev_info = iwl_pci_find_dev_info(pdev->device, pdev->subsystem_device,
 					 CSR_HW_REV_TYPE(iwl_trans->hw_rev),
-					 CSR_HW_REV_STEP(iwl_trans->hw_rev),
+					 iwl_trans->hw_rev_step,
 					 CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id),
 					 CSR_HW_RFID_IS_CDB(iwl_trans->hw_rf_id),
 					 IWL_SUBDEVICE_RF_ID(pdev->subsystem_device),
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 451b28de1392..f607edd41baa 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3616,8 +3616,9 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	 * in the old format.
 	 */
 	if (cfg_trans->device_family >= IWL_DEVICE_FAMILY_8000)
-		trans->hw_rev = (trans->hw_rev & 0xfff0) |
-				(CSR_HW_REV_STEP(trans->hw_rev << 2) << 2);
+		trans->hw_rev_step = trans->hw_rev & 0xF;
+	else
+		trans->hw_rev_step = (trans->hw_rev & 0xC) >> 2;
 
 	IWL_DEBUG_INFO(trans, "HW REV: 0x%0x\n", trans->hw_rev);
 
-- 
2.33.1

