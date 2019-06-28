Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0649459753
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 11:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbfF1JUs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 05:20:48 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54776 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726506AbfF1JUs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 05:20:48 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hgn3R-0001ny-Sf; Fri, 28 Jun 2019 12:20:26 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 13/20] iwlwifi: dbg_ini: remove redundant checking of ini mode
Date:   Fri, 28 Jun 2019 12:20:01 +0300
Message-Id: <20190628092008.11049-14-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628092008.11049-1-luca@coelho.fi>
References: <20190628092008.11049-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

There are several flows where the driver checks if it runs in ini mode.
Some of these flows are no longer used in ini mode or there is another
condition that check the ini mode in the same flow. Either way, those
conditions are redundant. Remove the redundant conditions.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c     |  5 +----
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h     |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/trans.c | 11 +++--------
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index d61def45af57..a00323d72be1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2023,7 +2023,7 @@ static void iwl_fw_error_dump(struct iwl_fw_runtime *fwrt)
 	if (!dump_file)
 		goto out;
 
-	if (!fwrt->trans->ini_valid && fwrt->dump.monitor_only)
+	if (fwrt->dump.monitor_only)
 		dump_mask &= IWL_FW_ERROR_DUMP_FW_MONITOR;
 
 	fw_error_dump.trans_ptr = iwl_trans_dump_data(fwrt->trans, dump_mask);
@@ -2275,9 +2275,6 @@ int iwl_fw_dbg_collect_trig(struct iwl_fw_runtime *fwrt,
 	int ret, len = 0;
 	char buf[64];
 
-	if (fwrt->trans->ini_valid)
-		return 0;
-
 	if (fmt) {
 		va_list ap;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index cff96d2a7e4c..54fc59639962 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -362,7 +362,7 @@ void iwl_fw_error_dump_wk(struct work_struct *work);
 
 static inline bool iwl_fw_dbg_type_on(struct iwl_fw_runtime *fwrt, u32 type)
 {
-	return (fwrt->fw->dbg.dump_mask & BIT(type) || fwrt->trans->ini_valid);
+	return (fwrt->fw->dbg.dump_mask & BIT(type));
 }
 
 static inline bool iwl_fw_dbg_is_d3_debug_enabled(struct iwl_fw_runtime *fwrt)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 6f5f7e9a894f..f6201a03ca35 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3021,10 +3021,6 @@ iwl_trans_pcie_dump_pointers(struct iwl_trans *trans,
 		base_high = DBGC_CUR_DBGBUF_BASE_ADDR_MSB;
 		write_ptr = DBGC_CUR_DBGBUF_STATUS;
 		wrap_cnt = DBGC_DBGBUF_WRAP_AROUND;
-	} else if (trans->ini_valid) {
-		base = iwl_umac_prph(trans, MON_BUFF_BASE_ADDR_VER2);
-		write_ptr = iwl_umac_prph(trans, MON_BUFF_WRPTR_VER2);
-		wrap_cnt = iwl_umac_prph(trans, MON_BUFF_CYCLE_CNT_VER2);
 	} else if (trans->dbg_dest_tlv) {
 		write_ptr = le32_to_cpu(trans->dbg_dest_tlv->write_ptr_reg);
 		wrap_cnt = le32_to_cpu(trans->dbg_dest_tlv->wrap_count);
@@ -3055,11 +3051,10 @@ iwl_trans_pcie_dump_monitor(struct iwl_trans *trans,
 {
 	u32 len = 0;
 
-	if ((trans->num_blocks &&
+	if (trans->dbg_dest_tlv ||
+	    (trans->num_blocks &&
 	     (trans->cfg->device_family == IWL_DEVICE_FAMILY_7000 ||
-	      trans->cfg->device_family >= IWL_DEVICE_FAMILY_AX210 ||
-	      trans->ini_valid)) ||
-	    (trans->dbg_dest_tlv && !trans->ini_valid)) {
+	      trans->cfg->device_family >= IWL_DEVICE_FAMILY_AX210))) {
 		struct iwl_fw_error_dump_fw_mon *fw_mon_data;
 
 		(*data)->type = cpu_to_le32(IWL_FW_ERROR_DUMP_FW_MONITOR);
-- 
2.20.1

