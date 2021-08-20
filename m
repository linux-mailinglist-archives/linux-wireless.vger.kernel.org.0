Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0263F2A85
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 13:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbhHTLEW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 07:04:22 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:57570 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239386AbhHTLEM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 07:04:12 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mH2J8-002IL4-4v; Fri, 20 Aug 2021 14:03:31 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 20 Aug 2021 14:03:16 +0300
Message-Id: <iwlwifi.20210820140104.8f8ce6f25ecd.Iec9b2e2615ce65e6aff5ce896589227a7030f4cf@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210820110318.260751-1-luca@coelho.fi>
References: <20210820110318.260751-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 10/12] iwlwifi: Add support for getting rf id with blank otp
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Matti Gottlieb <matti.gottlieb@intel.com>

When having a blank OTP the only way to get the rf id
and the cdb info is from prph registers.

Currently there is some implementation for this, but it
is located in the wrong place in the code (should be before
trying to understand what HW is connected and not after),
and it has a partial implementation.

Signed-off-by: Matti Gottlieb <matti.gottlieb@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  2 +-
 .../wireless/intel/iwlwifi/fw/error-dump.h    |  4 -
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h | 38 ++++++++
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 97 +++++++++++++++++++
 4 files changed, 136 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 6dcafd0a3d4b..b7f2f0662b82 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2077,7 +2077,7 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 	 */
 	hw_type = CSR_HW_REV_TYPE(fwrt->trans->hw_rev);
 	if (hw_type == IWL_AX210_HW_TYPE) {
-		u32 prph_val = iwl_read_prph(fwrt->trans, WFPM_OTP_CFG1_ADDR);
+		u32 prph_val = iwl_read_prph(fwrt->trans, WFPM_OTP_CFG1_ADDR_GEN2);
 		u32 is_jacket = !!(prph_val & WFPM_OTP_CFG1_IS_JACKET_BIT);
 		u32 is_cdb = !!(prph_val & WFPM_OTP_CFG1_IS_CDB_BIT);
 		u32 masked_bits = is_jacket | (is_cdb << 1);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index 521ca2bb0e92..9036b32ec765 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -342,10 +342,6 @@ struct iwl_fw_ini_dump_cfg_name {
 #define IWL_AX210_HW_TYPE 0x42
 /* How many bits to roll when adding to the HW type of AX210 HW */
 #define IWL_AX210_HW_TYPE_ADDITION_SHIFT 12
-/* This prph is used to tell apart HW_TYPE == 0x42 NICs */
-#define WFPM_OTP_CFG1_ADDR 0xd03098
-#define WFPM_OTP_CFG1_IS_JACKET_BIT BIT(4)
-#define WFPM_OTP_CFG1_IS_CDB_BIT BIT(5)
 
 /* struct iwl_fw_ini_dump_info - ini dump information
  * @version: dump version
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index d0a7d58336a9..972f8ba7a95f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -347,6 +347,12 @@
 #define RADIO_REG_SYS_MANUAL_DFT_0	0xAD4078
 #define RFIC_REG_RD			0xAD0470
 #define WFPM_CTRL_REG			0xA03030
+#define WFPM_CTRL_REG_GEN2		0xd03030
+#define WFPM_OTP_CFG1_ADDR		0x00a03098
+#define WFPM_OTP_CFG1_ADDR_GEN2		0x00d03098
+#define WFPM_OTP_CFG1_IS_JACKET_BIT	BIT(4)
+#define WFPM_OTP_CFG1_IS_CDB_BIT	BIT(5)
+
 #define WFPM_GP2			0xA030B4
 
 /* DBGI SRAM Register details */
@@ -399,10 +405,42 @@ enum {
 	LMPM_PAGE_PASS_NOTIF_POS = BIT(20),
 };
 
+/*
+ * struct iwl_crf_chip_id_reg
+ *
+ * type: bits 0-11
+ * reserved: bits 12-18
+ * slave_exist: bit 19
+ * dash: bits 20-23
+ * step: bits 24-26
+ * flavor: bits 27-31
+ */
+struct iwl_crf_chip_id_reg {
+	u32 type : 12;
+	u32 reserved : 7;
+	u32 slave_exist : 1;
+	u32 dash : 4;
+	u32 step : 4;
+	u32 flavor : 4;
+};
+
 #define UREG_CHICK		(0xA05C00)
 #define UREG_CHICK_MSI_ENABLE	BIT(24)
 #define UREG_CHICK_MSIX_ENABLE	BIT(25)
 
+#define SD_REG_VER		0xa29600
+#define SD_REG_VER_GEN2		0x00a2b800
+
+#define REG_CRF_ID_TYPE_JF_1			0x201
+#define REG_CRF_ID_TYPE_JF_2			0x202
+#define REG_CRF_ID_TYPE_HR_CDB			0x503
+#define REG_CRF_ID_TYPE_HR_NONE_CDB		0x504
+#define REG_CRF_ID_TYPE_HR_NONE_CDB_1X1	0x501
+#define REG_CRF_ID_TYPE_HR_NONE_CDB_CCP	0x532
+#define REG_CRF_ID_TYPE_GF			0x410
+#define REG_CRF_ID_TYPE_GF_TC			0xF08
+#define REG_CRF_ID_TYPE_MR			0x810
+
 #define HPM_DEBUG			0xA03440
 #define PERSISTENCE_BIT			BIT(12)
 #define PREG_WFPM_ACCESS		BIT(12)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index c42b72c64020..01011aa01bbf 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1120,6 +1120,93 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 #endif /* CONFIG_IWLMVM */
 };
 
+/*
+ * In case that there is no OTP on the NIC, get the rf id and cdb info
+ * from the prph registers.
+ */
+static int get_crf_id(struct iwl_trans *iwl_trans)
+{
+	int ret = 0;
+	u32 wfpm_ctrl_addr;
+	u32 wfpm_otp_cfg_addr;
+	u32 sd_reg_ver_addr;
+	u32 cdb = 0;
+	struct iwl_crf_chip_id_reg reg = {0};
+
+	if (iwl_trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+		wfpm_ctrl_addr = WFPM_CTRL_REG_GEN2;
+		wfpm_otp_cfg_addr = WFPM_OTP_CFG1_ADDR_GEN2;
+		sd_reg_ver_addr = SD_REG_VER_GEN2;
+	/* Qu/Pu families have other addresses */
+	} else {
+		wfpm_ctrl_addr = WFPM_CTRL_REG;
+		wfpm_otp_cfg_addr = WFPM_OTP_CFG1_ADDR;
+		sd_reg_ver_addr = SD_REG_VER;
+	}
+
+	if (iwl_trans_grab_nic_access(iwl_trans)) {
+		u32 val;
+
+		/* Enable access to peripheral registers */
+		val = iwl_read_umac_prph_no_grab(iwl_trans, wfpm_ctrl_addr);
+		val |= ENABLE_WFPM;
+		iwl_write_umac_prph_no_grab(iwl_trans, wfpm_ctrl_addr, val);
+
+		/* Read crf info */
+		val = iwl_read_prph_no_grab(iwl_trans, sd_reg_ver_addr);
+		memcpy(&reg, &val, sizeof(reg));
+
+		/* Read cdb info (also contains the jacket info if needed in the future */
+		cdb = iwl_read_umac_prph_no_grab(iwl_trans, wfpm_otp_cfg_addr);
+
+		/* Map between crf id to rf id */
+		switch (reg.type) {
+		case REG_CRF_ID_TYPE_JF_1:
+			iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_JF1 << 12);
+			break;
+		case REG_CRF_ID_TYPE_JF_2:
+			iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_JF2 << 12);
+			break;
+		case REG_CRF_ID_TYPE_HR_NONE_CDB:
+			iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_HR1 << 12);
+			break;
+		case REG_CRF_ID_TYPE_HR_CDB:
+			iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_HR2 << 12);
+			break;
+		case REG_CRF_ID_TYPE_GF:
+			iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_GF << 12);
+			break;
+		case REG_CRF_ID_TYPE_MR:
+			iwl_trans->hw_rf_id = (IWL_CFG_RF_TYPE_MR << 12);
+			break;
+		default:
+			ret = -EIO;
+			IWL_ERR(iwl_trans,
+				"Can find a correct rfid for crf id 0x%x\n",
+				reg.type);
+			iwl_trans_release_nic_access(iwl_trans);
+			goto out_get_crf_id;
+		}
+		iwl_trans_release_nic_access(iwl_trans);
+	} else {
+		IWL_ERR(iwl_trans, "Failed to grab nic access before reading crf id\n");
+		ret = -EIO;
+		goto out_get_crf_id;
+	}
+
+	/* Set CDB capabilities */
+	if (cdb & BIT(4)) {
+		iwl_trans->hw_rf_id += BIT(28);
+		IWL_INFO(iwl_trans, "Adding cdb to rf id\n");
+	}
+
+	IWL_INFO(iwl_trans, "Detected RF 0x%x from crf id 0x%x\n",
+		 iwl_trans->hw_rf_id, reg.type);
+
+out_get_crf_id:
+	return ret;
+}
+
 /* PCI registers */
 #define PCI_CFG_RETRY_TIMEOUT	0x041
 
@@ -1153,6 +1240,16 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	iwl_trans->hw_rf_id = iwl_read32(iwl_trans, CSR_HW_RF_ID);
 
+	/*
+	 * The RF_ID is set to zero in blank OTP so read version to
+	 * extract the RF_ID.
+	 * This is relevant only for family 9000 and up.
+	 */
+	if (iwl_trans->trans_cfg->rf_id &&
+	    iwl_trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_9000 &&
+	    !CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id) && get_crf_id(iwl_trans))
+		goto out_free_trans;
+
 	for (i = 0; i < ARRAY_SIZE(iwl_dev_info_table); i++) {
 		const struct iwl_dev_info *dev_info = &iwl_dev_info_table[i];
 		if ((dev_info->device == (u16)IWL_CFG_ANY ||
-- 
2.33.0

