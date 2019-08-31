Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39BAFA43C1
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 11:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfHaJtO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 05:49:14 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:39670 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726754AbfHaJtN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 05:49:13 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i400M-0002OQ-Jw; Sat, 31 Aug 2019 12:49:11 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 31 Aug 2019 12:48:48 +0300
Message-Id: <20190831094859.6391-9-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190831094859.6391-1-luca@coelho.fi>
References: <20190831094859.6391-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 08/19] iwlwifi: dbg_ini: use function to check if ini dbg mode is on
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

use iwl_trans_dbg_ini_valid function instead of a boolean value check if
dbg_ini mode is on. It is needed for a future patch.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c              | 4 ++--
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h              | 9 +++++----
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h           | 5 +++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c              | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h       | 2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c          | 2 +-
 7 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index f52427ec60e9..3679ba89ea9d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2101,7 +2101,7 @@ int iwl_fw_dbg_collect_desc(struct iwl_fw_runtime *fwrt,
 	u32 trig_type = le32_to_cpu(desc->trig_desc.type);
 	int ret;
 
-	if (fwrt->trans->dbg.ini_valid) {
+	if (iwl_trans_dbg_ini_valid(fwrt->trans)) {
 		ret = iwl_fw_dbg_ini_collect(fwrt, trig_type);
 		if (!ret)
 			iwl_fw_free_dump_desc(fwrt);
@@ -2381,7 +2381,7 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 	}
 
 	IWL_DEBUG_FW_INFO(fwrt, "WRT: data collection start\n");
-	if (fwrt->trans->dbg.ini_valid)
+	if (iwl_trans_dbg_ini_valid(fwrt->trans))
 		iwl_fw_error_ini_dump(fwrt, wk_idx);
 	else
 		iwl_fw_error_dump(fwrt);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 461331703ea6..8faea2571788 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -202,7 +202,7 @@ _iwl_fw_dbg_trigger_on(struct iwl_fw_runtime *fwrt,
 {
 	struct iwl_fw_dbg_trigger_tlv *trig;
 
-	if (fwrt->trans->dbg.ini_valid)
+	if (iwl_trans_dbg_ini_valid(fwrt->trans))
 		return NULL;
 
 	if (!iwl_fw_dbg_trigger_enabled(fwrt->fw, id))
@@ -229,8 +229,9 @@ iwl_fw_ini_trigger_on(struct iwl_fw_runtime *fwrt,
 	struct iwl_fw_ini_trigger *trig;
 	u32 usec;
 
-	if (!fwrt->trans->dbg.ini_valid || id == IWL_FW_TRIGGER_ID_INVALID ||
-	    id >= IWL_FW_TRIGGER_ID_NUM || !fwrt->dump.active_trigs[id].active)
+	if (!iwl_trans_dbg_ini_valid(fwrt->trans) ||
+	    id == IWL_FW_TRIGGER_ID_INVALID || id >= IWL_FW_TRIGGER_ID_NUM ||
+	    !fwrt->dump.active_trigs[id].active)
 		return false;
 
 	trig = fwrt->dump.active_trigs[id].trig;
@@ -394,7 +395,7 @@ static inline void iwl_fw_umac_set_alive_err_table(struct iwl_trans *trans,
 
 static inline void iwl_fw_error_collect(struct iwl_fw_runtime *fwrt)
 {
-	if (fwrt->trans->dbg.ini_valid && fwrt->trans->dbg.hw_error) {
+	if (iwl_trans_dbg_ini_valid(fwrt->trans) && fwrt->trans->dbg.hw_error) {
 		_iwl_fw_dbg_ini_collect(fwrt, IWL_FW_TRIGGER_ID_FW_HW_ERROR);
 		fwrt->trans->dbg.hw_error = false;
 	} else {
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 0fa4b100f109..731ffb4a33af 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1216,6 +1216,11 @@ static inline void iwl_trans_sync_nmi(struct iwl_trans *trans)
 		trans->ops->sync_nmi(trans);
 }
 
+static inline bool iwl_trans_dbg_ini_valid(struct iwl_trans *trans)
+{
+	return trans->dbg.ini_valid;
+}
+
 /*****************************************************
  * transport helper functions
  *****************************************************/
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index af46723f790f..d2baea22cba2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1304,7 +1304,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	if (ret)
 		IWL_ERR(mvm, "Failed to initialize Smart Fifo\n");
 
-	if (!mvm->trans->dbg.ini_valid) {
+	if (!iwl_trans_dbg_ini_valid(mvm->trans)) {
 		mvm->fwrt.dump.conf = FW_DBG_INVALID;
 		/* if we have a destination, assume EARLY START */
 		if (mvm->fw->dbg.dest_tlv)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
index 5e86783d616b..9b27c955b8dc 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/ctxt-info-gen3.c
@@ -96,7 +96,7 @@ int iwl_pcie_ctxt_info_gen3_init(struct iwl_trans *trans,
 		cpu_to_le64(trans_pcie->rxq->bd_dma);
 
 	/* Configure debug, for integration */
-	if (!trans->dbg.ini_valid)
+	if (!iwl_trans_dbg_ini_valid(trans))
 		iwl_pcie_alloc_fw_monitor(trans, 0);
 	if (trans->dbg.num_blocks) {
 		prph_sc_ctrl->hwm_cfg.hwm_base_addr =
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 95f78d8b4ae5..906e1da3923d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -1044,7 +1044,7 @@ static inline void __iwl_trans_pcie_set_bit(struct iwl_trans *trans,
 
 static inline bool iwl_pcie_dbg_on(struct iwl_trans *trans)
 {
-	return (trans->dbg.dest_tlv || trans->dbg.ini_valid);
+	return (trans->dbg.dest_tlv || iwl_trans_dbg_ini_valid(trans));
 }
 
 void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 48a209708852..41ecd1ede04b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -896,7 +896,7 @@ void iwl_pcie_apply_destination(struct iwl_trans *trans)
 	const struct iwl_fw_dbg_dest_tlv_v1 *dest = trans->dbg.dest_tlv;
 	int i;
 
-	if (trans->dbg.ini_valid) {
+	if (iwl_trans_dbg_ini_valid(trans)) {
 		if (!trans->dbg.num_blocks)
 			return;
 
-- 
2.23.0.rc1

