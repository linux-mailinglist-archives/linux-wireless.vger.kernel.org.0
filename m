Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 303C259757
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 11:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbfF1JVj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 05:21:39 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54788 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726506AbfF1JVj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 05:21:39 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hgn3U-0001ny-2A; Fri, 28 Jun 2019 12:20:28 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 17/20] iwlwifi: dbg_ini: fix debug monitor stop and restart in ini mode
Date:   Fri, 28 Jun 2019 12:20:05 +0300
Message-Id: <20190628092008.11049-18-luca@coelho.fi>
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

In ini debug mode the recording does not restart unless legacy monitor
configuration is also given.

Add dbg_ini_dest field to trans to indicate the debug monitor
destination to solve this.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 19 +++++++++++++-----
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   | 20 ++++++++++++++++++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 ++
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 8dc56f14a5cb..38c30fd905ed 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2381,11 +2381,7 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 		iwl_fw_error_dump(fwrt);
 	IWL_DEBUG_FW_INFO(fwrt, "WRT: data collection done\n");
 
-	/* start recording again if the firmware is not crashed */
-	if (!test_bit(STATUS_FW_ERROR, &fwrt->trans->status) &&
-	    fwrt->fw->dbg.dest_tlv) {
-		iwl_fw_dbg_restart_recording(fwrt, &params);
-	}
+	iwl_fw_dbg_restart_recording(fwrt, &params);
 
 out:
 	clear_bit(wk_idx, &fwrt->dump.active_wks);
@@ -2516,6 +2512,17 @@ static void iwl_fw_dbg_buffer_apply(struct iwl_fw_runtime *fwrt,
 	int block_idx = trans->dbg.num_blocks;
 	u32 buf_location = le32_to_cpu(alloc->tlv.buffer_location);
 
+	if (fwrt->trans->dbg.ini_dest == IWL_FW_INI_LOCATION_INVALID)
+		fwrt->trans->dbg.ini_dest = buf_location;
+
+	if (buf_location != fwrt->trans->dbg.ini_dest) {
+		WARN(fwrt,
+		     "WRT: attempt to override buffer location on apply point %d\n",
+		     pnt);
+
+		return;
+	}
+
 	if (buf_location == IWL_FW_INI_LOCATION_SRAM_PATH) {
 		IWL_DEBUG_FW(trans, "WRT: applying SMEM buffer destination\n");
 		/* set sram monitor by enabling bit 7 */
@@ -2832,6 +2839,8 @@ static void iwl_fw_dbg_ini_reset_cfg(struct iwl_fw_runtime *fwrt)
 	       sizeof(fwrt->dump.internal_dbg_cfg_name));
 	memset(fwrt->dump.external_dbg_cfg_name, 0,
 	       sizeof(fwrt->dump.external_dbg_cfg_name));
+
+	fwrt->trans->dbg.ini_dest = IWL_FW_INI_LOCATION_INVALID;
 }
 
 void iwl_fw_dbg_apply_point(struct iwl_fw_runtime *fwrt,
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index 06cdf272e38d..c2d91f645b0f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -309,6 +309,14 @@ static inline void
 iwl_fw_dbg_stop_recording(struct iwl_fw_runtime *fwrt,
 			  struct iwl_fw_dbg_params *params)
 {
+	/* if the FW crashed or not debug monitor cfg was given, there is
+	 * no point in stopping
+	 */
+	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status) ||
+	    (!fwrt->trans->dbg.dest_tlv &&
+	     fwrt->trans->dbg.ini_dest == IWL_FW_INI_LOCATION_INVALID))
+		return;
+
 	if (fwrt->trans->cfg->device_family < IWL_DEVICE_FAMILY_22560)
 		_iwl_fw_dbg_stop_recording(fwrt->trans, params);
 	else
@@ -335,7 +343,9 @@ _iwl_fw_dbg_restart_recording(struct iwl_trans *trans,
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 static inline void iwl_fw_set_dbg_rec_on(struct iwl_fw_runtime *fwrt)
 {
-	if (fwrt->fw->dbg.dest_tlv && fwrt->cur_fw_img == IWL_UCODE_REGULAR)
+	if (fwrt->cur_fw_img == IWL_UCODE_REGULAR &&
+	    (fwrt->fw->dbg.dest_tlv ||
+	     fwrt->trans->dbg.ini_dest != IWL_FW_INI_LOCATION_INVALID))
 		fwrt->trans->dbg.rec_on = true;
 }
 #endif
@@ -344,6 +354,14 @@ static inline void
 iwl_fw_dbg_restart_recording(struct iwl_fw_runtime *fwrt,
 			     struct iwl_fw_dbg_params *params)
 {
+	/* if the FW crashed or not debug monitor cfg was given, there is
+	 * no point in restarting
+	 */
+	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status) ||
+	    (!fwrt->trans->dbg.dest_tlv &&
+	     fwrt->trans->dbg.ini_dest == IWL_FW_INI_LOCATION_INVALID))
+		return;
+
 	if (fwrt->trans->cfg->device_family < IWL_DEVICE_FAMILY_22560)
 		_iwl_fw_dbg_restart_recording(fwrt->trans, params);
 	else
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 90707c576ce4..0f8aeb111b0e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -738,6 +738,7 @@ struct iwl_self_init_dram {
  * @num_blocks: number of blocks in fw_mon
  * @fw_mon: address of the buffers for firmware monitor
  * @hw_error: equals true if hw error interrupt was received from the FW
+ * @ini_dest: debug monitor destination uses &enum iwl_fw_ini_buffer_location
  */
 struct iwl_trans_debug {
 	u8 n_dest_reg;
@@ -761,6 +762,7 @@ struct iwl_trans_debug {
 	struct iwl_dram_data fw_mon[IWL_FW_INI_APPLY_NUM];
 
 	bool hw_error;
+	enum iwl_fw_ini_buffer_location ini_dest;
 };
 
 /**
-- 
2.20.1

