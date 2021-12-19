Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC0B47A02A
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 11:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbhLSKSb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 05:18:31 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:51352 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235575AbhLSKSa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 05:18:30 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mytGt-001O3b-Gr; Sun, 19 Dec 2021 12:18:28 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 19 Dec 2021 12:18:13 +0200
Message-Id: <iwlwifi.20211219121514.d59b29653a1e.I7b3be4a1ad1a9d5d0e86259740e89ac113c9348b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211219101820.85153-1-luca@coelho.fi>
References: <20211219101820.85153-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 05/12] iwlwifi: yoyo: support TLV-based firmware reset
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mukesh Sisodiya <mukesh.sisodiya@intel.com>

Support resetting the firmware via TLV-based debugging.  When applied,
this will cause the driver to reset the firmware when the debugging
is triggered.

Signed-off-by: Mukesh Sisodiya <mukesh.sisodiya@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   | 15 ++++++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  3 ++
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 43 ++++++++++++++++++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 13 ++++--
 5 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
index 62b527b3a6c5..456b7eaac570 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h
@@ -124,7 +124,7 @@ struct iwl_fw_ini_region_internal_buffer {
  * @id: region id. Max id is &IWL_FW_INI_MAX_REGION_ID
  * @type: region type. One of &enum iwl_fw_ini_region_type
  * @sub_type: region sub type
- * @sub_type_ver: region sub type
+ * @sub_type_ver: region sub type version
  * @reserved: not in use
  * @name: region name
  * @dev_addr: device address configuration. Used by
@@ -483,4 +483,17 @@ enum iwl_fw_ini_trigger_apply_policy {
 	IWL_FW_INI_APPLY_POLICY_OVERRIDE_CFG		= BIT(9),
 	IWL_FW_INI_APPLY_POLICY_OVERRIDE_DATA		= BIT(10),
 };
+
+/**
+ * enum iwl_fw_ini_trigger_reset_fw_policy - Determines how to handle reset
+ *
+ * @IWL_FW_INI_RESET_FW_MODE_NOTHING: do not stop FW and reload (default)
+ * @IWL_FW_INI_RESET_FW_MODE_STOP_FW_ONLY: stop FW without reload FW
+ * @IWL_FW_INI_RESET_FW_MODE_STOP_AND_RELOAD_FW: stop FW with reload FW
+ */
+enum iwl_fw_ini_trigger_reset_fw_policy {
+	IWL_FW_INI_RESET_FW_MODE_NOTHING = 0,
+	IWL_FW_INI_RESET_FW_MODE_STOP_FW_ONLY,
+	IWL_FW_INI_RESET_FW_MODE_STOP_AND_RELOAD_FW
+};
 #endif
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 483b1446f2e6..35af228be3aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -2719,6 +2719,9 @@ static void iwl_fw_dbg_collect_sync(struct iwl_fw_runtime *fwrt, u8 wk_idx)
 
 	iwl_fw_dbg_stop_restart_recording(fwrt, &params, false);
 
+	if (fwrt->trans->dbg.last_tp_resetfw == IWL_FW_INI_RESET_FW_MODE_STOP_FW_ONLY)
+		iwl_force_nmi(fwrt->trans);
+
 out:
 	if (iwl_trans_dbg_ini_valid(fwrt->trans)) {
 		iwl_fw_error_dump_data_free(dump_data);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
index c2fbda2ffe7e..c73672d61356 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c
@@ -233,6 +233,7 @@ static int iwl_dbg_tlv_alloc_trigger(struct iwl_trans *trans,
 	const struct iwl_fw_ini_trigger_tlv *trig = (const void *)tlv->data;
 	struct iwl_fw_ini_trigger_tlv *dup_trig;
 	u32 tp = le32_to_cpu(trig->time_point);
+	u32 rf = le32_to_cpu(trig->reset_fw);
 	struct iwl_ucode_tlv *dup = NULL;
 	int ret;
 
@@ -247,6 +248,10 @@ static int iwl_dbg_tlv_alloc_trigger(struct iwl_trans *trans,
 		return -EINVAL;
 	}
 
+	IWL_DEBUG_FW(trans,
+		     "WRT: time point %u for trigger TLV with reset_fw %u\n",
+		     tp, rf);
+	trans->dbg.last_tp_resetfw = 0xFF;
 	if (!le32_to_cpu(trig->occurrences)) {
 		dup = kmemdup(tlv, sizeof(*tlv) + le32_to_cpu(tlv->length),
 				GFP_KERNEL);
@@ -1166,6 +1171,8 @@ iwl_dbg_tlv_tp_trigger(struct iwl_fw_runtime *fwrt, bool sync,
 		u32 num_data = iwl_tlv_array_len(&node->tlv, dump_data.trig,
 						 data);
 		int ret, i;
+		u32 tp = le32_to_cpu(dump_data.trig->time_point);
+
 
 		if (!num_data) {
 			ret = iwl_fw_dbg_ini_collect(fwrt, &dump_data, sync);
@@ -1184,8 +1191,42 @@ iwl_dbg_tlv_tp_trigger(struct iwl_fw_runtime *fwrt, bool sync,
 				break;
 			}
 		}
-	}
 
+		fwrt->trans->dbg.restart_required = FALSE;
+		IWL_DEBUG_INFO(fwrt, "WRT: tp %d, reset_fw %d\n",
+			       tp, dump_data.trig->reset_fw);
+		IWL_DEBUG_INFO(fwrt, "WRT: restart_required %d, last_tp_resetfw %d\n",
+			       fwrt->trans->dbg.restart_required,
+			       fwrt->trans->dbg.last_tp_resetfw);
+
+		if (fwrt->trans->trans_cfg->device_family ==
+		    IWL_DEVICE_FAMILY_9000) {
+			fwrt->trans->dbg.restart_required = TRUE;
+		} else if (tp == IWL_FW_INI_TIME_POINT_FW_ASSERT &&
+			   fwrt->trans->dbg.last_tp_resetfw ==
+			   IWL_FW_INI_RESET_FW_MODE_STOP_FW_ONLY) {
+			fwrt->trans->dbg.restart_required = FALSE;
+			fwrt->trans->dbg.last_tp_resetfw = 0xFF;
+			IWL_DEBUG_FW(fwrt, "WRT: FW_ASSERT due to reset_fw_mode-no restart\n");
+		} else if (le32_to_cpu(dump_data.trig->reset_fw) ==
+			   IWL_FW_INI_RESET_FW_MODE_STOP_AND_RELOAD_FW) {
+			IWL_DEBUG_INFO(fwrt, "WRT: stop and reload firmware\n");
+			fwrt->trans->dbg.restart_required = TRUE;
+		} else if (le32_to_cpu(dump_data.trig->reset_fw) ==
+			   IWL_FW_INI_RESET_FW_MODE_STOP_FW_ONLY) {
+			IWL_DEBUG_INFO(fwrt, "WRT: stop only and no reload firmware\n");
+			fwrt->trans->dbg.restart_required = FALSE;
+			fwrt->trans->dbg.last_tp_resetfw =
+				le32_to_cpu(dump_data.trig->reset_fw);
+		} else if (le32_to_cpu(dump_data.trig->reset_fw) ==
+			   IWL_FW_INI_RESET_FW_MODE_NOTHING) {
+			IWL_DEBUG_INFO(fwrt,
+				       "WRT: nothing need to be done after debug collection\n");
+		} else {
+			IWL_ERR(fwrt, "WRT: wrong resetfw %d\n",
+				le32_to_cpu(dump_data.trig->reset_fw));
+		}
+	}
 	return 0;
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index b8428dc3b6d2..1bcaa3598785 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -783,6 +783,8 @@ struct iwl_trans_debug {
 
 	u32 domains_bitmap;
 	u32 ucode_preset;
+	bool restart_required;
+	u32 last_tp_resetfw;
 };
 
 struct iwl_dma_ptr {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 2b42b1b1fe60..83d5df52f2af 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1836,9 +1836,16 @@ void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
 
 		iwl_fw_error_collect(&mvm->fwrt, false);
 
-		if (fw_error && mvm->fw_restart > 0)
+		if (fw_error && mvm->fw_restart > 0) {
 			mvm->fw_restart--;
-		ieee80211_restart_hw(mvm->hw);
+			ieee80211_restart_hw(mvm->hw);
+		} else if (mvm->fwrt.trans->dbg.restart_required) {
+			IWL_DEBUG_INFO(mvm, "FW restart requested after debug collection\n");
+			mvm->fwrt.trans->dbg.restart_required = FALSE;
+			ieee80211_restart_hw(mvm->hw);
+		} else if (mvm->trans->trans_cfg->device_family <= IWL_DEVICE_FAMILY_8000) {
+			ieee80211_restart_hw(mvm->hw);
+		}
 	}
 }
 
@@ -1869,7 +1876,7 @@ static void iwl_mvm_nic_error(struct iwl_op_mode *op_mode, bool sync)
 	if (!test_bit(IWL_MVM_STATUS_FIRMWARE_RUNNING, &mvm->status))
 		return;
 
-	iwl_mvm_nic_restart(mvm, true);
+	iwl_mvm_nic_restart(mvm, false);
 }
 
 static void iwl_mvm_cmd_queue_full(struct iwl_op_mode *op_mode)
-- 
2.34.1

