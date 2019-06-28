Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C8DE5975A
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 11:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbfF1JVw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 05:21:52 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54806 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726502AbfF1JVv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 05:21:51 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hgn3V-0001ny-5N; Fri, 28 Jun 2019 12:20:29 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 19/20] iwlwifi: dbg: debug recording stop and restart command remove
Date:   Fri, 28 Jun 2019 12:20:07 +0300
Message-Id: <20190628092008.11049-20-luca@coelho.fi>
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

The 0xF6 command used to start and stop the recording from 22560 devices
was removed. This is causing an assert when the driver tries to alter
the recording state.
Remove the use of the command.

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   | 47 +++++++------------
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  2 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  2 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  2 +-
 5 files changed, 22 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 38c30fd905ed..15beaea37e61 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2372,7 +2372,7 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 		goto out;
 	}
 
-	iwl_fw_dbg_stop_recording(fwrt, &params);
+	iwl_fw_dbg_stop_recording(fwrt->trans, &params);
 
 	IWL_DEBUG_FW_INFO(fwrt, "WRT: data collection start\n");
 	if (fwrt->trans->dbg.ini_valid)
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
index c2d91f645b0f..47470cf80e6d 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.h
@@ -263,23 +263,6 @@ _iwl_fw_dbg_trigger_simple_stop(struct iwl_fw_runtime *fwrt,
 					iwl_fw_dbg_get_trigger((fwrt)->fw,\
 							       (trig)))
 
-static inline int
-iwl_fw_dbg_start_stop_hcmd(struct iwl_fw_runtime *fwrt, bool start)
-{
-	struct iwl_ldbg_config_cmd cmd = {
-		.type = start ? cpu_to_le32(START_DEBUG_RECORDING) :
-				cpu_to_le32(STOP_DEBUG_RECORDING),
-	};
-	struct iwl_host_cmd hcmd = {
-		.id = LDBG_CONFIG_CMD,
-		.flags = CMD_ASYNC,
-		.data[0] = &cmd,
-		.len[0] = sizeof(cmd),
-	};
-
-	return iwl_trans_send_cmd(fwrt->trans, &hcmd);
-}
-
 static inline void
 _iwl_fw_dbg_stop_recording(struct iwl_trans *trans,
 			   struct iwl_fw_dbg_params *params)
@@ -306,21 +289,24 @@ _iwl_fw_dbg_stop_recording(struct iwl_trans *trans,
 }
 
 static inline void
-iwl_fw_dbg_stop_recording(struct iwl_fw_runtime *fwrt,
+iwl_fw_dbg_stop_recording(struct iwl_trans *trans,
 			  struct iwl_fw_dbg_params *params)
 {
 	/* if the FW crashed or not debug monitor cfg was given, there is
 	 * no point in stopping
 	 */
-	if (test_bit(STATUS_FW_ERROR, &fwrt->trans->status) ||
-	    (!fwrt->trans->dbg.dest_tlv &&
-	     fwrt->trans->dbg.ini_dest == IWL_FW_INI_LOCATION_INVALID))
+	if (test_bit(STATUS_FW_ERROR, &trans->status) ||
+	    (!trans->dbg.dest_tlv &&
+	     trans->dbg.ini_dest == IWL_FW_INI_LOCATION_INVALID))
 		return;
 
-	if (fwrt->trans->cfg->device_family < IWL_DEVICE_FAMILY_22560)
-		_iwl_fw_dbg_stop_recording(fwrt->trans, params);
-	else
-		iwl_fw_dbg_start_stop_hcmd(fwrt, false);
+	if (trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
+		IWL_ERR(trans,
+			"WRT: unsupported device family %d for debug stop recording\n",
+			trans->cfg->device_family);
+		return;
+	}
+	_iwl_fw_dbg_stop_recording(trans, params);
 }
 
 static inline void
@@ -362,10 +348,13 @@ iwl_fw_dbg_restart_recording(struct iwl_fw_runtime *fwrt,
 	     fwrt->trans->dbg.ini_dest == IWL_FW_INI_LOCATION_INVALID))
 		return;
 
-	if (fwrt->trans->cfg->device_family < IWL_DEVICE_FAMILY_22560)
-		_iwl_fw_dbg_restart_recording(fwrt->trans, params);
-	else
-		iwl_fw_dbg_start_stop_hcmd(fwrt, true);
+	if (fwrt->trans->cfg->device_family >= IWL_DEVICE_FAMILY_22560) {
+		IWL_ERR(fwrt,
+			"WRT: unsupported device family %d for debug restart recording\n",
+			fwrt->trans->cfg->device_family);
+		return;
+	}
+	_iwl_fw_dbg_restart_recording(fwrt->trans, params);
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	iwl_fw_set_dbg_rec_on(fwrt);
 #endif
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 47f1529b6491..9677955624e1 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1083,7 +1083,7 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 	 * recording automatically.
 	 */
 	if (mvm->trans->cfg->device_family < IWL_DEVICE_FAMILY_9000)
-		_iwl_fw_dbg_stop_recording(mvm->trans, NULL);
+		iwl_fw_dbg_stop_recording(mvm->trans, NULL);
 
 	/* must be last -- this switches firmware state */
 	ret = iwl_mvm_send_cmd(mvm, &d3_cfg_cmd);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 8507a7bdcfdd..a1533f025f5e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -148,7 +148,7 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans, bool low_power)
 	trans_pcie->is_down = true;
 
 	/* Stop dbgc before stopping device */
-	_iwl_fw_dbg_stop_recording(trans, NULL);
+	iwl_fw_dbg_stop_recording(trans, NULL);
 
 	/* tell the device to stop sending interrupts */
 	iwl_disable_interrupts(trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 13ebd948ccc0..ba2f4c7c52d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1243,7 +1243,7 @@ static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans, bool low_power)
 	trans_pcie->is_down = true;
 
 	/* Stop dbgc before stopping device */
-	_iwl_fw_dbg_stop_recording(trans, NULL);
+	iwl_fw_dbg_stop_recording(trans, NULL);
 
 	/* tell the device to stop sending interrupts */
 	iwl_disable_interrupts(trans);
-- 
2.20.1

