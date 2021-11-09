Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB6B44B1FF
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Nov 2021 18:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbhKIRdF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Nov 2021 12:33:05 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40810 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234677AbhKIRdE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Nov 2021 12:33:04 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mkUwq-000o6M-7h; Tue, 09 Nov 2021 19:30:17 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Tue,  9 Nov 2021 19:30:14 +0200
Message-Id: <iwlwifi.20211109192950.486dfa9c4f35.I52a0411774b700bdc7dedb124d8b59bf99456eb2@changeid>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH] iwlwifi: mvm: retry init flow if failed
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

In some very rare cases the init flow may fail.  In many cases, this is
recoverable, so we can retry.  Implement a loop to retry two more times
after the first attempt failed.

This can happen in two different situations, namely during probe and
during mac80211 start.  For the first case, a simple loop is enough.
For the second case, we need to add a flag to prevent mac80211 from
trying to restart it as well, leaving full control with the driver.

Cc: <stable@vger.kernel.org>
Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  | 21 ++++++++++------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h  |  3 +++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 24 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  3 +++
 5 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 36196e07b1a0..b48a8ec80894 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1313,23 +1313,30 @@ _iwl_op_mode_start(struct iwl_drv *drv, struct iwlwifi_opmode_table *op)
 	const struct iwl_op_mode_ops *ops = op->ops;
 	struct dentry *dbgfs_dir = NULL;
 	struct iwl_op_mode *op_mode = NULL;
+	int retry, max_retry = !!iwlwifi_mod_params.fw_restart * IWL_MAX_INIT_RETRY;
+
+	for (retry = 0; retry <= max_retry; retry++) {
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-	drv->dbgfs_op_mode = debugfs_create_dir(op->name,
-						drv->dbgfs_drv);
-	dbgfs_dir = drv->dbgfs_op_mode;
+		drv->dbgfs_op_mode = debugfs_create_dir(op->name,
+							drv->dbgfs_drv);
+		dbgfs_dir = drv->dbgfs_op_mode;
 #endif
 
-	op_mode = ops->start(drv->trans, drv->trans->cfg, &drv->fw, dbgfs_dir);
+		op_mode = ops->start(drv->trans, drv->trans->cfg,
+				     &drv->fw, dbgfs_dir);
+
+		if (op_mode)
+			return op_mode;
+
+		IWL_ERR(drv, "retry init count %d\n", retry);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
-	if (!op_mode) {
 		debugfs_remove_recursive(drv->dbgfs_op_mode);
 		drv->dbgfs_op_mode = NULL;
-	}
 #endif
 
-	return op_mode;
+	return NULL;
 }
 
 static void _iwl_op_mode_stop(struct iwl_drv *drv)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
index 2e2d60a58692..0fd009e6d685 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.h
@@ -89,4 +89,7 @@ void iwl_drv_stop(struct iwl_drv *drv);
 #define IWL_EXPORT_SYMBOL(sym)
 #endif
 
+/* max retry for init flow */
+#define IWL_MAX_INIT_RETRY 2
+
 #endif /* __iwl_drv_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 9fb9c7dad314..897e3b91ddb2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -16,6 +16,7 @@
 #include <net/ieee80211_radiotap.h>
 #include <net/tcp.h>
 
+#include "iwl-drv.h"
 #include "iwl-op-mode.h"
 #include "iwl-io.h"
 #include "mvm.h"
@@ -1117,9 +1118,30 @@ static int iwl_mvm_mac_start(struct ieee80211_hw *hw)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int ret;
+	int retry, max_retry = 0;
 
 	mutex_lock(&mvm->mutex);
-	ret = __iwl_mvm_mac_start(mvm);
+
+	/* we are starting the mac not in error flow, and restart is enabled */
+	if (!test_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status) &&
+	    iwlwifi_mod_params.fw_restart) {
+		max_retry = IWL_MAX_INIT_RETRY;
+		/*
+		 * This will prevent mac80211 recovery flows to trigger during
+		 * init failures
+		 */
+		set_bit(IWL_MVM_STATUS_STARTING, &mvm->status);
+	}
+
+	for (retry = 0; retry <= max_retry; retry++) {
+		ret = __iwl_mvm_mac_start(mvm);
+		if (!ret)
+			break;
+
+		IWL_ERR(mvm, "mac start retry %d\n", retry);
+	}
+	clear_bit(IWL_MVM_STATUS_STARTING, &mvm->status);
+
 	mutex_unlock(&mvm->mutex);
 
 	return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 2b1dcd60e00f..a72d85086fe3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1123,6 +1123,8 @@ struct iwl_mvm {
  * @IWL_MVM_STATUS_FIRMWARE_RUNNING: firmware is running
  * @IWL_MVM_STATUS_NEED_FLUSH_P2P: need to flush P2P bcast STA
  * @IWL_MVM_STATUS_IN_D3: in D3 (or at least about to go into it)
+ * @IWL_MVM_STATUS_STARTING: starting mac,
+ *	used to disable restart flow while in STARTING state
  */
 enum iwl_mvm_status {
 	IWL_MVM_STATUS_HW_RFKILL,
@@ -1134,6 +1136,7 @@ enum iwl_mvm_status {
 	IWL_MVM_STATUS_FIRMWARE_RUNNING,
 	IWL_MVM_STATUS_NEED_FLUSH_P2P,
 	IWL_MVM_STATUS_IN_D3,
+	IWL_MVM_STATUS_STARTING,
 };
 
 /* Keep track of completed init configuration */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 232ad531d612..ce7160670aa7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1600,6 +1600,9 @@ void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
 	 */
 	if (!mvm->fw_restart && fw_error) {
 		iwl_fw_error_collect(&mvm->fwrt, false);
+	} else if (test_bit(IWL_MVM_STATUS_STARTING,
+			    &mvm->status)) {
+		IWL_ERR(mvm, "Starting mac, retry will be triggered anyway\n");
 	} else if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status)) {
 		struct iwl_mvm_reprobe *reprobe;
 
-- 
2.33.1

