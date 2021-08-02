Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D91F3DDFAF
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 20:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhHBS7L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 14:59:11 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51000 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229969AbhHBS7L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 14:59:11 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAd9O-001ySl-Ng; Mon, 02 Aug 2021 21:59:00 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 21:58:47 +0300
Message-Id: <iwlwifi.20210802215208.8535203d0ef7.Ib1695ce5de921b0472d0b1052e729e071573b863@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802185856.175567-1-luca@coelho.fi>
References: <20210802185856.175567-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 01/10] iwlwifi: yoyo: cleanup internal buffer allocation in D3
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

With recent changes in the firmware SRAM debug during D3 is
enabled by default and need not be enabled by driver.
cleaning the code to align the same.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h | 2 --
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c    | 3 +--
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c        | 6 +-----
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 5a2d9a1f7e73..15a6b3eb999a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -249,7 +249,6 @@ struct iwl_fw_ini_hcmd_tlv {
  * @IWL_FW_INI_ALLOCATION_ID_DBGC1: allocation meant for DBGC1 configuration
  * @IWL_FW_INI_ALLOCATION_ID_DBGC2: allocation meant for DBGC2 configuration
  * @IWL_FW_INI_ALLOCATION_ID_DBGC3: allocation meant for DBGC3 configuration
- * @IWL_FW_INI_ALLOCATION_ID_INTERNAL: allocation meant for Intreanl SMEM in D3
  * @IWL_FW_INI_ALLOCATION_NUM: number of allocation ids
 */
 enum iwl_fw_ini_allocation_id {
@@ -257,7 +256,6 @@ enum iwl_fw_ini_allocation_id {
 	IWL_FW_INI_ALLOCATION_ID_DBGC1,
 	IWL_FW_INI_ALLOCATION_ID_DBGC2,
 	IWL_FW_INI_ALLOCATION_ID_DBGC3,
-	IWL_FW_INI_ALLOCATION_ID_INTERNAL,
 	IWL_FW_INI_ALLOCATION_NUM,
 }; /* FW_DEBUG_TLV_ALLOCATION_ID_E_VER_1 */
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index c89db7b9585a..dc4bff681e52 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -131,8 +131,7 @@ static int iwl_dbg_tlv_alloc_buf_alloc(struct iwl_trans *trans,
 		goto err;
 
 	if (buf_location == IWL_FW_INI_LOCATION_SRAM_PATH &&
-	    alloc_id != IWL_FW_INI_ALLOCATION_ID_DBGC1 &&
-	    alloc_id != IWL_FW_INI_ALLOCATION_ID_INTERNAL)
+	    alloc_id != IWL_FW_INI_ALLOCATION_ID_DBGC1)
 		goto err;
 
 	trans->dbg.fw_mon_cfg[alloc_id] = *alloc;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index f1aa31150318..f57d2643135b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -78,7 +78,6 @@ module_exit(iwl_mvm_exit);
 static void iwl_mvm_nic_config(struct iwl_op_mode *op_mode)
 {
 	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
-	struct iwl_trans_debug *dbg = &mvm->trans->dbg;
 	u8 radio_cfg_type, radio_cfg_step, radio_cfg_dash;
 	u32 reg_val = 0;
 	u32 phy_config = iwl_mvm_get_phy_config(mvm);
@@ -115,10 +114,7 @@ static void iwl_mvm_nic_config(struct iwl_op_mode *op_mode)
 	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_8000)
 		reg_val |= CSR_HW_IF_CONFIG_REG_BIT_RADIO_SI;
 
-	if (iwl_fw_dbg_is_d3_debug_enabled(&mvm->fwrt) ||
-	    (iwl_trans_dbg_ini_valid(mvm->trans) &&
-	     dbg->fw_mon_cfg[IWL_FW_INI_ALLOCATION_ID_INTERNAL].buf_location)
-	    )
+	if (iwl_fw_dbg_is_d3_debug_enabled(&mvm->fwrt))
 		reg_val |= CSR_HW_IF_CONFIG_REG_D3_DEBUG;
 
 	iwl_trans_set_bits_mask(mvm->trans, CSR_HW_IF_CONFIG_REG,
-- 
2.32.0

