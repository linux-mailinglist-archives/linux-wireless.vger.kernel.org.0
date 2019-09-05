Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70F3DAA3F6
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 15:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388364AbfIENMz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 09:12:55 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:40940 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388329AbfIENMy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 09:12:54 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i5rZE-0005yI-7V; Thu, 05 Sep 2019 16:12:52 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  5 Sep 2019 16:12:30 +0300
Message-Id: <20190905131241.23487-8-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190905131241.23487-1-luca@coelho.fi>
References: <20190905131241.23487-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 07/18] iwlwifi: remove the opmode's d0i3 handlers
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Remove the now unneeded functions that called those from the
transport layer.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  | 23 ------
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 70 -------------------
 .../wireless/intel/iwlwifi/pcie/internal.h    |  3 -
 3 files changed, 96 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
index f37d6fee0225..3008a5246be8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
@@ -140,9 +140,6 @@ struct iwl_cfg;
  * @nic_config: configure NIC, called before firmware is started.
  *	May sleep
  * @wimax_active: invoked when WiMax becomes active. May sleep
- * @enter_d0i3: configure the fw to enter d0i3. return 1 to indicate d0i3
- *	entrance is aborted (e.g. due to held reference). May sleep.
- * @exit_d0i3: configure the fw to exit d0i3. May sleep.
  */
 struct iwl_op_mode_ops {
 	struct iwl_op_mode *(*start)(struct iwl_trans *trans,
@@ -164,8 +161,6 @@ struct iwl_op_mode_ops {
 	void (*cmd_queue_full)(struct iwl_op_mode *op_mode);
 	void (*nic_config)(struct iwl_op_mode *op_mode);
 	void (*wimax_active)(struct iwl_op_mode *op_mode);
-	int (*enter_d0i3)(struct iwl_op_mode *op_mode);
-	int (*exit_d0i3)(struct iwl_op_mode *op_mode);
 };
 
 int iwl_opmode_register(const char *name, const struct iwl_op_mode_ops *ops);
@@ -258,22 +253,4 @@ static inline void iwl_op_mode_wimax_active(struct iwl_op_mode *op_mode)
 	op_mode->ops->wimax_active(op_mode);
 }
 
-static inline int iwl_op_mode_enter_d0i3(struct iwl_op_mode *op_mode)
-{
-	might_sleep();
-
-	if (!op_mode->ops->enter_d0i3)
-		return 0;
-	return op_mode->ops->enter_d0i3(op_mode);
-}
-
-static inline int iwl_op_mode_exit_d0i3(struct iwl_op_mode *op_mode)
-{
-	might_sleep();
-
-	if (!op_mode->ops->exit_d0i3)
-		return 0;
-	return op_mode->ops->exit_d0i3(op_mode);
-}
-
 #endif /* __iwl_op_mode_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 10c9167d78fa..603a3c40d1c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1150,76 +1150,6 @@ static int iwl_pci_resume(struct device *device)
 	return 0;
 }
 
-int iwl_pci_fw_enter_d0i3(struct iwl_trans *trans)
-{
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	int ret;
-
-	if (test_bit(STATUS_FW_ERROR, &trans->status))
-		return 0;
-
-	set_bit(STATUS_TRANS_GOING_IDLE, &trans->status);
-
-	/* config the fw */
-	ret = iwl_op_mode_enter_d0i3(trans->op_mode);
-	if (ret == 1) {
-		IWL_DEBUG_RPM(trans, "aborting d0i3 entrance\n");
-		clear_bit(STATUS_TRANS_GOING_IDLE, &trans->status);
-		return -EBUSY;
-	}
-	if (ret)
-		goto err;
-
-	ret = wait_event_timeout(trans_pcie->d0i3_waitq,
-				 test_bit(STATUS_TRANS_IDLE, &trans->status),
-				 msecs_to_jiffies(IWL_TRANS_IDLE_TIMEOUT));
-	if (!ret) {
-		IWL_ERR(trans, "Timeout entering D0i3\n");
-		ret = -ETIMEDOUT;
-		goto err;
-	}
-
-	clear_bit(STATUS_TRANS_GOING_IDLE, &trans->status);
-
-	return 0;
-err:
-	clear_bit(STATUS_TRANS_GOING_IDLE, &trans->status);
-	iwl_trans_fw_error(trans);
-	return ret;
-}
-
-int iwl_pci_fw_exit_d0i3(struct iwl_trans *trans)
-{
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	int ret;
-
-	/* sometimes a D0i3 entry is not followed through */
-	if (!test_bit(STATUS_TRANS_IDLE, &trans->status))
-		return 0;
-
-	/* config the fw */
-	ret = iwl_op_mode_exit_d0i3(trans->op_mode);
-	if (ret)
-		goto err;
-
-	/* we clear STATUS_TRANS_IDLE only when D0I3_END command is completed */
-
-	ret = wait_event_timeout(trans_pcie->d0i3_waitq,
-				 !test_bit(STATUS_TRANS_IDLE, &trans->status),
-				 msecs_to_jiffies(IWL_TRANS_IDLE_TIMEOUT));
-	if (!ret) {
-		IWL_ERR(trans, "Timeout exiting D0i3\n");
-		ret = -ETIMEDOUT;
-		goto err;
-	}
-
-	return 0;
-err:
-	clear_bit(STATUS_TRANS_IDLE, &trans->status);
-	iwl_trans_fw_error(trans);
-	return ret;
-}
-
 static const struct dev_pm_ops iwl_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(iwl_pci_suspend,
 				iwl_pci_resume)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 6bf2a816e221..b5534fc33539 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -1059,9 +1059,6 @@ void iwl_trans_pcie_dbgfs_register(struct iwl_trans *trans);
 static inline void iwl_trans_pcie_dbgfs_register(struct iwl_trans *trans) { }
 #endif
 
-int iwl_pci_fw_exit_d0i3(struct iwl_trans *trans);
-int iwl_pci_fw_enter_d0i3(struct iwl_trans *trans);
-
 void iwl_pcie_rx_allocator_work(struct work_struct *data);
 
 /* common functions that are used by gen2 transport */
-- 
2.23.0.rc1

