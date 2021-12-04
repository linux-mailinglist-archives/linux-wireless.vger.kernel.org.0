Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F462468612
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 16:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355169AbhLDPx3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 10:53:29 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50520 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1355129AbhLDPx1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 10:53:27 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtXIV-0017qB-Ie; Sat, 04 Dec 2021 17:50:00 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 17:49:44 +0200
Message-Id: <iwlwifi.20211204174546.75e29a2ab68d.Id3064feda2ce7a77c116c6d6e71ce5ff447c6e86@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204154944.914175-1-luca@coelho.fi>
References: <20211204154944.914175-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 12/12] iwlwifi: mvm: optionally suppress assert log
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Normally, when we hit an assert, we print out all the
assert data. However, in certain tests, when we trigger
it from debugfs intentionally, that can be useless and
confusing.

Allow writing the string "nolog\n" to the fw_nmi and
fw_restart files suppressing the assert dump as well
as - in the case of fw_restart - the

  iwlwifi 0000:00:00.0: FW error in SYNC CMD REPLY_ERROR

message.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-trans.h   | 3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 8 ++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h     | 3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c     | 4 +++-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c    | 7 +++++--
 5 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 9dea8f9bbcae..e7c6e7bc5277 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -296,6 +296,8 @@ enum iwl_d3_status {
  *	are sent
  * @STATUS_TRANS_IDLE: the trans is idle - general commands are not to be sent
  * @STATUS_TRANS_DEAD: trans is dead - avoid any read/write operation
+ * @STATUS_SUPPRESS_CMD_ERROR_ONCE: suppress "FW error in SYNC CMD" once,
+ *	e.g. for testing
  */
 enum iwl_trans_status {
 	STATUS_SYNC_HCMD_ACTIVE,
@@ -308,6 +310,7 @@ enum iwl_trans_status {
 	STATUS_TRANS_GOING_IDLE,
 	STATUS_TRANS_IDLE,
 	STATUS_TRANS_DEAD,
+	STATUS_SUPPRESS_CMD_ERROR_ONCE,
 };
 
 static inline int
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index ff66001d507e..f1e9d2c99051 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1022,6 +1022,11 @@ static ssize_t iwl_dbgfs_fw_restart_write(struct iwl_mvm *mvm, char *buf,
 	if (mvm->fw_restart >= 0)
 		mvm->fw_restart++;
 
+	if (count == 6 && !strcmp(buf, "nolog\n")) {
+		set_bit(IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE, &mvm->status);
+		set_bit(STATUS_SUPPRESS_CMD_ERROR_ONCE, &mvm->trans->status);
+	}
+
 	/* take the return value to make compiler happy - it will fail anyway */
 	ret = iwl_mvm_send_cmd_pdu(mvm,
 				   WIDE_ID(LONG_GROUP, REPLY_ERROR),
@@ -1038,6 +1043,9 @@ static ssize_t iwl_dbgfs_fw_nmi_write(struct iwl_mvm *mvm, char *buf,
 	if (!iwl_mvm_firmware_running(mvm))
 		return -EIO;
 
+	if (count == 6 && !strcmp(buf, "nolog\n"))
+		set_bit(IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE, &mvm->status);
+
 	iwl_force_nmi(mvm->trans);
 
 	return count;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f7ff7f2e3928..92d6e3dbbb62 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1137,6 +1137,8 @@ struct iwl_mvm {
  * @IWL_MVM_STATUS_FIRMWARE_RUNNING: firmware is running
  * @IWL_MVM_STATUS_NEED_FLUSH_P2P: need to flush P2P bcast STA
  * @IWL_MVM_STATUS_IN_D3: in D3 (or at least about to go into it)
+ * @IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE: suppress one error log
+ *	if this is set, when intentionally triggered
  */
 enum iwl_mvm_status {
 	IWL_MVM_STATUS_HW_RFKILL,
@@ -1148,6 +1150,7 @@ enum iwl_mvm_status {
 	IWL_MVM_STATUS_FIRMWARE_RUNNING,
 	IWL_MVM_STATUS_NEED_FLUSH_P2P,
 	IWL_MVM_STATUS_IN_D3,
+	IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE,
 };
 
 struct iwl_mvm_csme_conn_info {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index cc1879e10c65..6bb4e4d9d95a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1841,7 +1841,9 @@ static void iwl_mvm_nic_error(struct iwl_op_mode *op_mode, bool sync)
 {
 	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
 
-	if (!test_bit(STATUS_TRANS_DEAD, &mvm->trans->status))
+	if (!test_bit(STATUS_TRANS_DEAD, &mvm->trans->status) &&
+	    !test_and_clear_bit(IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE,
+				&mvm->status))
 		iwl_mvm_dump_nic_error_log(mvm);
 
 	if (sync) {
diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 451b06069350..b72d075b6dd3 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -1752,8 +1752,11 @@ static int iwl_trans_txq_send_hcmd_sync(struct iwl_trans *trans,
 	}
 
 	if (test_bit(STATUS_FW_ERROR, &trans->status)) {
-		IWL_ERR(trans, "FW error in SYNC CMD %s\n", cmd_str);
-		dump_stack();
+		if (!test_and_clear_bit(STATUS_SUPPRESS_CMD_ERROR_ONCE,
+					&trans->status)) {
+			IWL_ERR(trans, "FW error in SYNC CMD %s\n", cmd_str);
+			dump_stack();
+		}
 		ret = -EIO;
 		goto cancel;
 	}
-- 
2.33.1

