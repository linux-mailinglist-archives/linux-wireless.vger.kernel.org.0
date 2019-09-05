Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51229AA448
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 15:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388829AbfIENWz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 09:22:55 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:41168 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388828AbfIENWy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 09:22:54 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i5rih-00062D-8z; Thu, 05 Sep 2019 16:22:39 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  5 Sep 2019 16:22:09 +0300
Message-Id: <20190905132220.23970-11-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190905132220.23970-1-luca@coelho.fi>
References: <20190905132220.23970-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 10/21] iwlwifi: add support for suspend-resume flow for new device generation
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

The new device generation has a slightly different suspend resume flow
Currently, the way the driver instruct the device to move to D3 is by
sending D3_CONFIG_CMD.
Instead of using the host command the indication is by writing to the
doorbell interrupt.
The FW will respond with interrupt to indicate transition completion.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  5 ++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 12 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 20 +++---
 .../wireless/intel/iwlwifi/pcie/internal.h    |  4 ++
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  | 21 ++++--
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 69 ++++++++++++++++---
 6 files changed, 102 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 8d930bfe0727..f47e0f97acf8 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -451,6 +451,8 @@ enum {
 
 #define UREG_DOORBELL_TO_ISR6		0xA05C04
 #define UREG_DOORBELL_TO_ISR6_NMI_BIT	BIT(0)
+#define UREG_DOORBELL_TO_ISR6_SUSPEND	BIT(18)
+#define UREG_DOORBELL_TO_ISR6_RESUME	BIT(19)
 
 #define FSEQ_ERROR_CODE			0xA340C8
 #define FSEQ_TOP_INIT_VERSION		0xA34038
@@ -460,4 +462,7 @@ enum {
 #define FSEQ_ALIVE_TOKEN		0xA340F0
 #define FSEQ_CNVI_ID			0xA3408C
 #define FSEQ_CNVR_ID			0xA34090
+
+#define IWL_D3_SLEEP_STATUS_SUSPEND	0xD3
+#define IWL_D3_SLEEP_STATUS_RESUME	0xD0
 #endif				/* __iwl_prph_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 4152ae972aa7..b6c79f45d1ec 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -537,7 +537,7 @@ struct iwl_trans_ops {
 	void (*fw_alive)(struct iwl_trans *trans, u32 scd_addr);
 	void (*stop_device)(struct iwl_trans *trans);
 
-	void (*d3_suspend)(struct iwl_trans *trans, bool test, bool reset);
+	int (*d3_suspend)(struct iwl_trans *trans, bool test, bool reset);
 	int (*d3_resume)(struct iwl_trans *trans, enum iwl_d3_status *status,
 			 bool test, bool reset);
 
@@ -883,12 +883,14 @@ static inline void iwl_trans_stop_device(struct iwl_trans *trans)
 	trans->state = IWL_TRANS_NO_FW;
 }
 
-static inline void iwl_trans_d3_suspend(struct iwl_trans *trans, bool test,
-					bool reset)
+static inline int iwl_trans_d3_suspend(struct iwl_trans *trans, bool test,
+				       bool reset)
 {
 	might_sleep();
-	if (trans->ops->d3_suspend)
-		trans->ops->d3_suspend(trans, test, reset);
+	if (!trans->ops->d3_suspend)
+		return 0;
+
+	return trans->ops->d3_suspend(trans, test, reset);
 }
 
 static inline int iwl_trans_d3_resume(struct iwl_trans *trans,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index cd7172d7f72e..66d610a2f3d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1068,7 +1068,7 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 
 	clear_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status);
 
-	iwl_trans_d3_suspend(mvm->trans, test, !unified_image);
+	ret = iwl_trans_d3_suspend(mvm->trans, test, !unified_image);
  out:
 	if (ret < 0) {
 		iwl_mvm_free_nd(mvm);
@@ -1930,15 +1930,6 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 	if (IS_ERR_OR_NULL(vif))
 		goto err;
 
-	ret = iwl_trans_d3_resume(mvm->trans, &d3_status, test, !unified_image);
-	if (ret)
-		goto err;
-
-	if (d3_status != IWL_D3_STATUS_ALIVE) {
-		IWL_INFO(mvm, "Device was reset during suspend\n");
-		goto err;
-	}
-
 	iwl_fw_dbg_read_d3_debug_data(&mvm->fwrt);
 
 	if (iwl_mvm_check_rt_status(mvm, vif)) {
@@ -1950,6 +1941,15 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 		goto err;
 	}
 
+	ret = iwl_trans_d3_resume(mvm->trans, &d3_status, test, !unified_image);
+	if (ret)
+		goto err;
+
+	if (d3_status != IWL_D3_STATUS_ALIVE) {
+		IWL_INFO(mvm, "Device was reset during suspend\n");
+		goto err;
+	}
+
 	if (d0i3_first) {
 		ret = iwl_mvm_send_cmd_pdu(mvm, D0I3_END_CMD, 0, 0, NULL);
 		if (ret < 0) {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index f07559b3633a..1047d48beaa5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -558,8 +558,10 @@ struct iwl_trans_pcie {
 	void __iomem *hw_base;
 
 	bool ucode_write_complete;
+	bool sx_complete;
 	wait_queue_head_t ucode_write_waitq;
 	wait_queue_head_t wait_command_queue;
+	wait_queue_head_t sx_waitq;
 
 	u8 page_offs, dev_cmd_offs;
 
@@ -1117,4 +1119,6 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans);
 void iwl_pcie_gen2_txq_unmap(struct iwl_trans *trans, int txq_id);
 void iwl_pcie_gen2_tx_free(struct iwl_trans *trans);
 void iwl_pcie_gen2_tx_stop(struct iwl_trans *trans);
+void iwl_pcie_d3_complete_suspend(struct iwl_trans *trans,
+				  bool test, bool reset);
 #endif /* __iwl_trans_int_pcie_h__ */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index fce8c500ec02..19dd075f2f63 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -2196,12 +2196,23 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 			iwl_pcie_irq_handle_error(trans);
 		}
 	} else if (inta_hw & MSIX_HW_INT_CAUSES_REG_WAKEUP) {
-		/* uCode wakes up after power-down sleep */
-		IWL_DEBUG_ISR(trans, "Wakeup interrupt\n");
-		iwl_pcie_rxq_check_wrptr(trans);
-		iwl_pcie_txq_check_wrptrs(trans);
+		u32 sleep_notif =
+			le32_to_cpu(trans_pcie->prph_info->sleep_notif);
+		if (sleep_notif == IWL_D3_SLEEP_STATUS_SUSPEND ||
+		    sleep_notif == IWL_D3_SLEEP_STATUS_RESUME) {
+			IWL_DEBUG_ISR(trans,
+				      "Sx interrupt: sleep notification = 0x%x\n",
+				      sleep_notif);
+			trans_pcie->sx_complete = true;
+			wake_up(&trans_pcie->sx_waitq);
+		} else {
+			/* uCode wakes up after power-down sleep */
+			IWL_DEBUG_ISR(trans, "Wakeup interrupt\n");
+			iwl_pcie_rxq_check_wrptr(trans);
+			iwl_pcie_txq_check_wrptrs(trans);
 
-		isr_stats->wakeup++;
+			isr_stats->wakeup++;
+		}
 	}
 
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_IML) {
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index ae4f84016c3c..5ab87a8dc907 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1478,15 +1478,9 @@ void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state)
 	}
 }
 
-static void iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool test,
-				      bool reset)
+void iwl_pcie_d3_complete_suspend(struct iwl_trans *trans,
+				  bool test, bool reset)
 {
-	if (!reset) {
-		/* Enable persistence mode to avoid reset */
-		iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
-			    CSR_HW_IF_CONFIG_REG_PERSIST_MODE);
-	}
-
 	iwl_disable_interrupts(trans);
 
 	/*
@@ -1517,6 +1511,42 @@ static void iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool test,
 	iwl_pcie_set_pwr(trans, true);
 }
 
+static int iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool test,
+				     bool reset)
+{
+	int ret;
+	struct iwl_trans_pcie *trans_pcie =  IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	/*
+	 * Family IWL_DEVICE_FAMILY_AX210 and above persist mode is set by FW.
+	 */
+	if (!reset && trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210) {
+		/* Enable persistence mode to avoid reset */
+		iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
+			    CSR_HW_IF_CONFIG_REG_PERSIST_MODE);
+	}
+
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+		iwl_write_umac_prph(trans, UREG_DOORBELL_TO_ISR6,
+				    UREG_DOORBELL_TO_ISR6_SUSPEND);
+
+		ret = wait_event_timeout(trans_pcie->sx_waitq,
+					 trans_pcie->sx_complete, 2 * HZ);
+		/*
+		 * Invalidate it toward resume.
+		 */
+		trans_pcie->sx_complete = false;
+
+		if (!ret) {
+			IWL_ERR(trans, "Timeout entering D3\n");
+			return -ETIMEDOUT;
+		}
+	}
+	iwl_pcie_d3_complete_suspend(trans, test, reset);
+
+	return 0;
+}
+
 static int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 				    enum iwl_d3_status *status,
 				    bool test,  bool reset)
@@ -1528,7 +1558,7 @@ static int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 	if (test) {
 		iwl_enable_interrupts(trans);
 		*status = IWL_D3_STATUS_ALIVE;
-		return 0;
+		goto out;
 	}
 
 	iwl_set_bit(trans, CSR_GP_CNTRL,
@@ -1575,6 +1605,25 @@ static int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 	else
 		*status = IWL_D3_STATUS_ALIVE;
 
+out:
+	if (*status == IWL_D3_STATUS_ALIVE &&
+	    trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
+		trans_pcie->sx_complete = false;
+		iwl_write_umac_prph(trans, UREG_DOORBELL_TO_ISR6,
+				    UREG_DOORBELL_TO_ISR6_RESUME);
+
+		ret = wait_event_timeout(trans_pcie->sx_waitq,
+					 trans_pcie->sx_complete, 2 * HZ);
+		/*
+		 * Invalidate it toward next suspend.
+		 */
+		trans_pcie->sx_complete = false;
+
+		if (!ret) {
+			IWL_ERR(trans, "Timeout exiting D3\n");
+			return -ETIMEDOUT;
+		}
+	}
 	return 0;
 }
 
@@ -3514,6 +3563,8 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	/* Initialize the wait queue for commands */
 	init_waitqueue_head(&trans_pcie->wait_command_queue);
 
+	init_waitqueue_head(&trans_pcie->sx_waitq);
+
 	if (trans_pcie->msix_enabled) {
 		ret = iwl_pcie_init_msix_handler(pdev, trans_pcie);
 		if (ret)
-- 
2.23.0.rc1

