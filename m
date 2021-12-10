Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FB846FB10
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Dec 2021 08:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhLJHKF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Dec 2021 02:10:05 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50816 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233193AbhLJHKE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Dec 2021 02:10:04 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mvZz9-001F9v-7g; Fri, 10 Dec 2021 09:06:28 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 10 Dec 2021 09:06:14 +0200
Message-Id: <iwlwifi.20211210090244.db2722547eb2.I03dce63698befc2fd9105111c3015b8d6e36868a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210070621.236783-1-luca@coelho.fi>
References: <20211210070621.236783-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 04/11] iwlwifi: Read the correct addresses when getting the crf id
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Matti Gottlieb <matti.gottlieb@intel.com>

The original implementation checked the HW family, and as a result
of that used different addresses for the prph registers.

The old HWs addresses start with 0xa****** and the newer
ones start with 0xd******.

For this there are iwl_read/write_umac_prph functions that just add the
diff in the address automatically (in this case 0x300000), so the code will
be common for all HWs

In the original implementation the address given already had the 0xd******
causing the address to become 0x10***** (after adding the offset)

Change the registers to start with 0xa*****.

Signed-off-by: Matti Gottlieb <matti.gottlieb@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  2 --
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 18 +++++-------------
 3 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index a373a2bc964a..483b1446f2e6 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2110,7 +2110,7 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 	 */
 	hw_type = CSR_HW_REV_TYPE(fwrt->trans->hw_rev);
 	if (hw_type == IWL_AX210_HW_TYPE) {
-		u32 prph_val = iwl_read_prph(fwrt->trans, WFPM_OTP_CFG1_ADDR_GEN2);
+		u32 prph_val = iwl_read_umac_prph(fwrt->trans, WFPM_OTP_CFG1_ADDR);
 		u32 is_jacket = !!(prph_val & WFPM_OTP_CFG1_IS_JACKET_BIT);
 		u32 is_cdb = !!(prph_val & WFPM_OTP_CFG1_IS_CDB_BIT);
 		u32 masked_bits = is_jacket | (is_cdb << 1);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 2ca22e1b8bd9..95b3dae7b504 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -347,9 +347,7 @@
 #define RADIO_REG_SYS_MANUAL_DFT_0	0xAD4078
 #define RFIC_REG_RD			0xAD0470
 #define WFPM_CTRL_REG			0xA03030
-#define WFPM_CTRL_REG_GEN2		0xd03030
 #define WFPM_OTP_CFG1_ADDR		0x00a03098
-#define WFPM_OTP_CFG1_ADDR_GEN2		0x00d03098
 #define WFPM_OTP_CFG1_IS_JACKET_BIT	BIT(4)
 #define WFPM_OTP_CFG1_IS_CDB_BIT	BIT(5)
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index fb19c21d2c5b..3902f2fcb731 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1272,22 +1272,14 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 static int get_crf_id(struct iwl_trans *iwl_trans)
 {
 	int ret = 0;
-	u32 wfpm_ctrl_addr;
-	u32 wfpm_otp_cfg_addr;
 	u32 sd_reg_ver_addr;
 	u32 cdb = 0;
 	u32 val;
 
-	if (iwl_trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
-		wfpm_ctrl_addr = WFPM_CTRL_REG_GEN2;
-		wfpm_otp_cfg_addr = WFPM_OTP_CFG1_ADDR_GEN2;
+	if (iwl_trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		sd_reg_ver_addr = SD_REG_VER_GEN2;
-	/* Qu/Pu families have other addresses */
-	} else {
-		wfpm_ctrl_addr = WFPM_CTRL_REG;
-		wfpm_otp_cfg_addr = WFPM_OTP_CFG1_ADDR;
+	else
 		sd_reg_ver_addr = SD_REG_VER;
-	}
 
 	if (!iwl_trans_grab_nic_access(iwl_trans)) {
 		IWL_ERR(iwl_trans, "Failed to grab nic access before reading crf id\n");
@@ -1296,15 +1288,15 @@ static int get_crf_id(struct iwl_trans *iwl_trans)
 	}
 
 	/* Enable access to peripheral registers */
-	val = iwl_read_umac_prph_no_grab(iwl_trans, wfpm_ctrl_addr);
+	val = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_CTRL_REG);
 	val |= ENABLE_WFPM;
-	iwl_write_umac_prph_no_grab(iwl_trans, wfpm_ctrl_addr, val);
+	iwl_write_umac_prph_no_grab(iwl_trans, WFPM_CTRL_REG, val);
 
 	/* Read crf info */
 	val = iwl_read_prph_no_grab(iwl_trans, sd_reg_ver_addr);
 
 	/* Read cdb info (also contains the jacket info if needed in the future */
-	cdb = iwl_read_umac_prph_no_grab(iwl_trans, wfpm_otp_cfg_addr);
+	cdb = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_OTP_CFG1_ADDR);
 
 	/* Map between crf id to rf id */
 	switch (REG_CRF_ID_TYPE(val)) {
-- 
2.34.1

