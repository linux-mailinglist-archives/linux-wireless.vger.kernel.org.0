Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A43727EF3B
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 18:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbgI3QbM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 12:31:12 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:53494 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725355AbgI3QbL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 12:31:11 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kNepu-002MPc-Sb; Wed, 30 Sep 2020 19:20:11 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Sep 2020 19:19:58 +0300
Message-Id: <iwlwifi.20200930191738.29b61ff6c78e.I235614bb2c255ee8ac49c2835796ac95a25215bf@changeid>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930161959.983283-1-luca@coelho.fi>
References: <20200930161959.983283-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 11/12] iwlwifi: yoyo: add support for internal buffer allocation in D3
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

With yoyo a user can configure the internal buffer allocation in
SMEM to hold more log space, which is used for debugging D3 state.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h |  4 +++-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c    | 10 +++++++---
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c        |  6 +++++-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 55e0c07659b8..95ada51d3f9e 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -301,6 +301,7 @@ struct iwl_fw_ini_hcmd_tlv {
  * @IWL_FW_INI_ALLOCATION_ID_DBGC1: allocation meant for DBGC1 configuration
  * @IWL_FW_INI_ALLOCATION_ID_DBGC2: allocation meant for DBGC2 configuration
  * @IWL_FW_INI_ALLOCATION_ID_DBGC3: allocation meant for DBGC3 configuration
+ * @IWL_FW_INI_ALLOCATION_ID_INTERNAL: allocation meant for Intreanl SMEM in D3
  * @IWL_FW_INI_ALLOCATION_NUM: number of allocation ids
 */
 enum iwl_fw_ini_allocation_id {
@@ -308,6 +309,7 @@ enum iwl_fw_ini_allocation_id {
 	IWL_FW_INI_ALLOCATION_ID_DBGC1,
 	IWL_FW_INI_ALLOCATION_ID_DBGC2,
 	IWL_FW_INI_ALLOCATION_ID_DBGC3,
+	IWL_FW_INI_ALLOCATION_ID_INTERNAL,
 	IWL_FW_INI_ALLOCATION_NUM,
 }; /* FW_DEBUG_TLV_ALLOCATION_ID_E_VER_1 */
 
@@ -347,7 +349,7 @@ enum iwl_fw_ini_buffer_location {
  * @IWL_FW_INI_REGION_CSR: CSR registers
  * @IWL_FW_INI_REGION_DRAM_IMR: IMR memory
  * @IWL_FW_INI_REGION_PCI_IOSF_CONFIG: PCI/IOSF config
- * @IWL_FW_INI_REGION_SPECIAL_DEVICE_MEMORY: special device memroy
+ * @IWL_FW_INI_REGION_SPECIAL_DEVICE_MEMORY: special device memory
  * @IWL_FW_INI_REGION_NUM: number of region types
  */
 enum iwl_fw_ini_region_type {
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index b3cc9f036f99..51ce93d21ffe 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -182,9 +182,13 @@ static int iwl_dbg_tlv_alloc_buf_alloc(struct iwl_trans *trans,
 	    alloc_id >= IWL_FW_INI_ALLOCATION_NUM)
 		goto err;
 
-	if ((buf_location == IWL_FW_INI_LOCATION_SRAM_PATH ||
-	     buf_location == IWL_FW_INI_LOCATION_NPK_PATH) &&
-	     alloc_id != IWL_FW_INI_ALLOCATION_ID_DBGC1)
+	if (buf_location == IWL_FW_INI_LOCATION_NPK_PATH &&
+	    alloc_id != IWL_FW_INI_ALLOCATION_ID_DBGC1)
+		goto err;
+
+	if (buf_location == IWL_FW_INI_LOCATION_SRAM_PATH &&
+	    alloc_id != IWL_FW_INI_ALLOCATION_ID_DBGC1 &&
+	    alloc_id != IWL_FW_INI_ALLOCATION_ID_INTERNAL)
 		goto err;
 
 	trans->dbg.fw_mon_cfg[alloc_id] = *alloc;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 078f5c2d2420..b86d62eff284 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -133,6 +133,7 @@ module_exit(iwl_mvm_exit);
 static void iwl_mvm_nic_config(struct iwl_op_mode *op_mode)
 {
 	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
+	struct iwl_trans_debug *dbg = &mvm->trans->dbg;
 	u8 radio_cfg_type, radio_cfg_step, radio_cfg_dash;
 	u32 reg_val = 0;
 	u32 phy_config = iwl_mvm_get_phy_config(mvm);
@@ -169,7 +170,10 @@ static void iwl_mvm_nic_config(struct iwl_op_mode *op_mode)
 	if (mvm->trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_8000)
 		reg_val |= CSR_HW_IF_CONFIG_REG_BIT_RADIO_SI;
 
-	if (iwl_fw_dbg_is_d3_debug_enabled(&mvm->fwrt))
+	if (iwl_fw_dbg_is_d3_debug_enabled(&mvm->fwrt) ||
+	    (iwl_trans_dbg_ini_valid(mvm->trans) &&
+	     dbg->fw_mon_cfg[IWL_FW_INI_ALLOCATION_ID_INTERNAL].buf_location)
+	    )
 		reg_val |= CSR_HW_IF_CONFIG_REG_D3_DEBUG;
 
 	iwl_trans_set_bits_mask(mvm->trans, CSR_HW_IF_CONFIG_REG,
-- 
2.28.0

