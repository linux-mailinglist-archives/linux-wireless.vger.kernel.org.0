Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A71C197B22
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 15:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbfHUNkN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 09:40:13 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:37866 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726484AbfHUNkN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 09:40:13 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i0QoY-0000lZ-6l; Wed, 21 Aug 2019 16:38:14 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 21 Aug 2019 16:37:53 +0300
Message-Id: <20190821133800.23636-12-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190821133800.23636-1-luca@coelho.fi>
References: <20190821133800.23636-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 11/18] iwlwifi: remove pm_runtime completely
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

This means:
1) stop calling pm_runtime_resume when starting the hardware
2) removing the unneeded low_power parameter to start / stop hw / fw
   transport ops
3) squashing transport functions that are now the same
   _iwl_trans_pcie_start_hw / iwl_trans_pcie_start_hw

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 33 ++++++-------------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  9 ++---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  1 -
 .../wireless/intel/iwlwifi/pcie/internal.h    |  5 ++-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  6 ++--
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 21 +++++-------
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  1 -
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  1 -
 8 files changed, 25 insertions(+), 52 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 687eced8b548..fce0112b3ad4 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -452,9 +452,8 @@ struct iwl_trans_rxq_dma_data {
  *
  * All the handlers MUST be implemented
  *
- * @start_hw: starts the HW. If low_power is true, the NIC needs to be taken
- *	out of a low power state. From that point on, the HW can send
- *	interrupts. May sleep.
+ * @start_hw: starts the HW. From that point on, the HW can send interrupts.
+ *	May sleep.
  * @op_mode_leave: Turn off the HW RF kill indication if on
  *	May sleep
  * @start_fw: allocates and inits all the resources for the transport
@@ -464,9 +463,8 @@ struct iwl_trans_rxq_dma_data {
  *	the SCD base address in SRAM, then provide it here, or 0 otherwise.
  *	May sleep
  * @stop_device: stops the whole device (embedded CPU put to reset) and stops
- *	the HW. If low_power is true, the NIC will be put in low power state.
- *	From that point on, the HW will be stopped but will still issue an
- *	interrupt if the HW RF kill switch is triggered.
+ *	the HW. From that point on, the HW will be stopped but will still issue
+ *	an interrupt if the HW RF kill switch is triggered.
  *	This callback must do the right thing and not crash even if %start_hw()
  *	was called but not &start_fw(). May sleep.
  * @d3_suspend: put the device into the correct mode for WoWLAN during
@@ -532,12 +530,12 @@ struct iwl_trans_rxq_dma_data {
  */
 struct iwl_trans_ops {
 
-	int (*start_hw)(struct iwl_trans *iwl_trans, bool low_power);
+	int (*start_hw)(struct iwl_trans *iwl_trans);
 	void (*op_mode_leave)(struct iwl_trans *iwl_trans);
 	int (*start_fw)(struct iwl_trans *trans, const struct fw_img *fw,
 			bool run_in_rfkill);
 	void (*fw_alive)(struct iwl_trans *trans, u32 scd_addr);
-	void (*stop_device)(struct iwl_trans *trans, bool low_power);
+	void (*stop_device)(struct iwl_trans *trans);
 
 	void (*d3_suspend)(struct iwl_trans *trans, bool test, bool reset);
 	int (*d3_resume)(struct iwl_trans *trans, enum iwl_d3_status *status,
@@ -819,16 +817,11 @@ static inline void iwl_trans_configure(struct iwl_trans *trans,
 	WARN_ON(iwl_cmd_groups_verify_sorted(trans_cfg));
 }
 
-static inline int _iwl_trans_start_hw(struct iwl_trans *trans, bool low_power)
+static inline int iwl_trans_start_hw(struct iwl_trans *trans)
 {
 	might_sleep();
 
-	return trans->ops->start_hw(trans, low_power);
-}
-
-static inline int iwl_trans_start_hw(struct iwl_trans *trans)
-{
-	return trans->ops->start_hw(trans, true);
+	return trans->ops->start_hw(trans);
 }
 
 static inline void iwl_trans_op_mode_leave(struct iwl_trans *trans)
@@ -864,21 +857,15 @@ static inline int iwl_trans_start_fw(struct iwl_trans *trans,
 	return trans->ops->start_fw(trans, fw, run_in_rfkill);
 }
 
-static inline void _iwl_trans_stop_device(struct iwl_trans *trans,
-					  bool low_power)
+static inline void iwl_trans_stop_device(struct iwl_trans *trans)
 {
 	might_sleep();
 
-	trans->ops->stop_device(trans, low_power);
+	trans->ops->stop_device(trans);
 
 	trans->state = IWL_TRANS_NO_FW;
 }
 
-static inline void iwl_trans_stop_device(struct iwl_trans *trans)
-{
-	_iwl_trans_stop_device(trans, true);
-}
-
 static inline void iwl_trans_d3_suspend(struct iwl_trans *trans, bool test,
 					bool reset)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 411a79e15333..0f6925a51435 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1141,13 +1141,8 @@ static int iwl_mvm_load_rt_fw(struct iwl_mvm *mvm)
 	}
 
 	iwl_fw_dbg_stop_sync(&mvm->fwrt);
-	/*
-	 * Stop and start the transport without entering low power
-	 * mode. This will save the state of other components on the
-	 * device that are triggered by the INIT firwmare (MFUART).
-	 */
-	_iwl_trans_stop_device(mvm->trans, false);
-	ret = _iwl_trans_start_hw(mvm->trans, false);
+	iwl_trans_stop_device(mvm->trans);
+	ret = iwl_trans_start_hw(mvm->trans);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 603a3c40d1c8..3927d5590bb3 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -65,7 +65,6 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
-#include <linux/pm_runtime.h>
 #include <linux/pci.h>
 #include <linux/acpi.h>
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 97f9f0aa5c5f..95f78d8b4ae5 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -1109,9 +1109,8 @@ int iwl_trans_pcie_gen2_tx(struct iwl_trans *trans, struct sk_buff *skb,
 			   struct iwl_device_cmd *dev_cmd, int txq_id);
 int iwl_trans_pcie_gen2_send_hcmd(struct iwl_trans *trans,
 				  struct iwl_host_cmd *cmd);
-void iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans,
-				     bool low_power);
-void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans, bool low_power);
+void iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans);
+void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans);
 void iwl_pcie_gen2_txq_unmap(struct iwl_trans *trans, int txq_id);
 void iwl_pcie_gen2_tx_free(struct iwl_trans *trans);
 void iwl_pcie_gen2_tx_stop(struct iwl_trans *trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 104b7cc75248..c099ad8b003f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -136,7 +136,7 @@ static void iwl_pcie_gen2_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 		      BIT(trans->cfg->csr->flag_init_done));
 }
 
-void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans, bool low_power)
+void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
@@ -215,7 +215,7 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans, bool low_power)
 	iwl_pcie_prepare_card_hw(trans);
 }
 
-void iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans, bool low_power)
+void iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	bool was_in_rfkill;
@@ -223,7 +223,7 @@ void iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans, bool low_power)
 	mutex_lock(&trans_pcie->mutex);
 	trans_pcie->opmode_down = true;
 	was_in_rfkill = test_bit(STATUS_RFKILL_OPMODE, &trans->status);
-	_iwl_trans_pcie_gen2_stop_device(trans, low_power);
+	_iwl_trans_pcie_gen2_stop_device(trans);
 	iwl_trans_pcie_handle_stop_rfkill(trans, was_in_rfkill);
 	mutex_unlock(&trans_pcie->mutex);
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index d1981e77b8f6..0972ef064514 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -69,7 +69,6 @@
 #include <linux/bitops.h>
 #include <linux/gfp.h>
 #include <linux/vmalloc.h>
-#include <linux/pm_runtime.h>
 #include <linux/module.h>
 #include <linux/wait.h>
 
@@ -1231,7 +1230,7 @@ static void iwl_pcie_init_msix(struct iwl_trans_pcie *trans_pcie)
 	trans_pcie->hw_mask = trans_pcie->hw_init_mask;
 }
 
-static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans, bool low_power)
+static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 
@@ -1448,7 +1447,7 @@ void iwl_trans_pcie_handle_stop_rfkill(struct iwl_trans *trans,
 		iwl_trans_pcie_rf_kill(trans, hw_rfkill);
 }
 
-static void iwl_trans_pcie_stop_device(struct iwl_trans *trans, bool low_power)
+static void iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	bool was_in_rfkill;
@@ -1456,7 +1455,7 @@ static void iwl_trans_pcie_stop_device(struct iwl_trans *trans, bool low_power)
 	mutex_lock(&trans_pcie->mutex);
 	trans_pcie->opmode_down = true;
 	was_in_rfkill = test_bit(STATUS_RFKILL_OPMODE, &trans->status);
-	_iwl_trans_pcie_stop_device(trans, low_power);
+	_iwl_trans_pcie_stop_device(trans);
 	iwl_trans_pcie_handle_stop_rfkill(trans, was_in_rfkill);
 	mutex_unlock(&trans_pcie->mutex);
 }
@@ -1472,9 +1471,9 @@ void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state)
 		 state ? "disabled" : "enabled");
 	if (iwl_op_mode_hw_rf_kill(trans->op_mode, state)) {
 		if (trans->cfg->gen2)
-			_iwl_trans_pcie_gen2_stop_device(trans, true);
+			_iwl_trans_pcie_gen2_stop_device(trans);
 		else
-			_iwl_trans_pcie_stop_device(trans, true);
+			_iwl_trans_pcie_stop_device(trans);
 	}
 }
 
@@ -1733,7 +1732,7 @@ static int iwl_trans_pcie_clear_persistence_bit(struct iwl_trans *trans)
 	return 0;
 }
 
-static int _iwl_trans_pcie_start_hw(struct iwl_trans *trans, bool low_power)
+static int _iwl_trans_pcie_start_hw(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int err;
@@ -1769,20 +1768,16 @@ static int _iwl_trans_pcie_start_hw(struct iwl_trans *trans, bool low_power)
 	/* ...rfkill can call stop_device and set it false if needed */
 	iwl_pcie_check_hw_rf_kill(trans);
 
-	/* Make sure we sync here, because we'll need full access later */
-	if (low_power)
-		pm_runtime_resume(trans->dev);
-
 	return 0;
 }
 
-static int iwl_trans_pcie_start_hw(struct iwl_trans *trans, bool low_power)
+static int iwl_trans_pcie_start_hw(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int ret;
 
 	mutex_lock(&trans_pcie->mutex);
-	ret = _iwl_trans_pcie_start_hw(trans, low_power);
+	ret = _iwl_trans_pcie_start_hw(trans);
 	mutex_unlock(&trans_pcie->mutex);
 
 	return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index cee507d29238..6c19711d5a10 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -50,7 +50,6 @@
  * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
  *****************************************************************************/
-#include <linux/pm_runtime.h>
 #include <net/tso.h>
 #include <linux/tcp.h>
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 9432374b69e2..8b7b918e71ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -65,7 +65,6 @@
 #include <linux/ieee80211.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
-#include <linux/pm_runtime.h>
 #include <net/ip6_checksum.h>
 #include <net/tso.h>
 
-- 
2.23.0.rc1

