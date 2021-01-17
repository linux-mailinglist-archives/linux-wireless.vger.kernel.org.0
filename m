Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6C02F91E2
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 12:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbhAQLM1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 06:12:27 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:40650 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728329AbhAQLLf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 06:11:35 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1l15xH-003sZv-7p; Sun, 17 Jan 2021 13:10:47 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 17 Jan 2021 13:10:35 +0200
Message-Id: <iwlwifi.20210117130510.271f59887fd1.I8ff41236f4e11a25df83d76c982a2a30ba2b9903@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117111038.1402870-1-luca@coelho.fi>
References: <20210117111038.1402870-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 08/11] iwl-trans: iwlwifi: move sync NMI logic to trans
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

The code is not directly related to PCIe transport, and it will help
moving sync/async commands logic out of PCIe in the next patches.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   | 36 ++++++++++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 11 +++
 .../wireless/intel/iwlwifi/pcie/internal.h    |  1 -
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 72 +++++++------------
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  2 +-
 6 files changed, 75 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index 2ac20d0a30eb..afb023ccbc72 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -445,3 +445,39 @@ int iwl_finish_nic_init(struct iwl_trans *trans,
 	return err < 0 ? err : 0;
 }
 IWL_EXPORT_SYMBOL(iwl_finish_nic_init);
+
+void iwl_trans_sync_nmi_with_addr(struct iwl_trans *trans, u32 inta_addr,
+				  u32 sw_err_bit)
+{
+	unsigned long timeout = jiffies + IWL_TRANS_NMI_TIMEOUT;
+	bool interrupts_enabled = test_bit(STATUS_INT_ENABLED, &trans->status);
+
+	/* if the interrupts were already disabled, there is no point in
+	 * calling iwl_disable_interrupts
+	 */
+	if (interrupts_enabled)
+		iwl_trans_interrupts(trans, false);
+
+	iwl_force_nmi(trans);
+	while (time_after(timeout, jiffies)) {
+		u32 inta_hw = iwl_read32(trans, inta_addr);
+
+		/* Error detected by uCode */
+		if (inta_hw & sw_err_bit) {
+			/* Clear causes register */
+			iwl_write32(trans, inta_addr, inta_hw & sw_err_bit);
+			break;
+		}
+
+		mdelay(1);
+	}
+
+	/* enable interrupts only if there were already enabled before this
+	 * function to avoid a case were the driver enable interrupts before
+	 * proper configurations were made
+	 */
+	if (interrupts_enabled)
+		iwl_trans_interrupts(trans, true);
+
+	iwl_trans_fw_error(trans);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 2d65bb82f7fe..eb6430c69e67 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -514,6 +514,7 @@ struct iwl_trans_rxq_dma_data {
  *	of the trans debugfs
  * @set_pnvm: set the pnvm data in the prph scratch buffer, inside the
  *	context info.
+ * @interrupts: disable/enable interrupts to transport
  */
 struct iwl_trans_ops {
 
@@ -587,6 +588,7 @@ struct iwl_trans_ops {
 	void (*debugfs_cleanup)(struct iwl_trans *trans);
 	void (*sync_nmi)(struct iwl_trans *trans);
 	int (*set_pnvm)(struct iwl_trans *trans, const void *data, u32 len);
+	void (*interrupts)(struct iwl_trans *trans, bool enable);
 };
 
 /**
@@ -1409,6 +1411,9 @@ static inline void iwl_trans_sync_nmi(struct iwl_trans *trans)
 		trans->ops->sync_nmi(trans);
 }
 
+void iwl_trans_sync_nmi_with_addr(struct iwl_trans *trans, u32 inta_addr,
+				  u32 sw_err_bit);
+
 static inline int iwl_trans_set_pnvm(struct iwl_trans *trans,
 				     const void *data, u32 len)
 {
@@ -1430,6 +1435,12 @@ static inline bool iwl_trans_dbg_ini_valid(struct iwl_trans *trans)
 		trans->dbg.external_ini_cfg != IWL_INI_CFG_STATE_NOT_LOADED;
 }
 
+static inline void iwl_trans_interrupts(struct iwl_trans *trans, bool enable)
+{
+	if (trans->ops->interrupts)
+		trans->ops->interrupts(trans, enable);
+}
+
 /*****************************************************
  * transport helper functions
  *****************************************************/
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index f4281b51248b..e70be7c0f3d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -760,7 +760,6 @@ static inline bool iwl_pcie_dbg_on(struct iwl_trans *trans)
 
 void iwl_trans_pcie_rf_kill(struct iwl_trans *trans, bool state);
 void iwl_trans_pcie_dump_regs(struct iwl_trans *trans);
-void iwl_trans_pcie_sync_nmi(struct iwl_trans *trans);
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 void iwl_trans_pcie_dbgfs_register(struct iwl_trans *trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 5e6dc194fe14..44e738e8537e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3284,6 +3284,30 @@ static struct iwl_trans_dump_data
 	return dump_data;
 }
 
+static void iwl_trans_pci_interrupts(struct iwl_trans *trans, bool enable)
+{
+	if (enable)
+		iwl_enable_interrupts(trans);
+	else
+		iwl_disable_interrupts(trans);
+}
+
+static void iwl_trans_pcie_sync_nmi(struct iwl_trans *trans)
+{
+	u32 inta_addr, sw_err_bit;
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+
+	if (trans_pcie->msix_enabled) {
+		inta_addr = CSR_MSIX_HW_INT_CAUSES_AD;
+		sw_err_bit = MSIX_HW_INT_CAUSES_REG_SW_ERR;
+	} else {
+		inta_addr = CSR_INT;
+		sw_err_bit = CSR_INT_BIT_SW_ERR;
+	}
+
+	iwl_trans_sync_nmi_with_addr(trans, inta_addr, sw_err_bit);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int iwl_trans_pcie_suspend(struct iwl_trans *trans)
 {
@@ -3314,7 +3338,8 @@ static void iwl_trans_pcie_resume(struct iwl_trans *trans)
 	.dump_data = iwl_trans_pcie_dump_data,				\
 	.d3_suspend = iwl_trans_pcie_d3_suspend,			\
 	.d3_resume = iwl_trans_pcie_d3_resume,				\
-	.sync_nmi = iwl_trans_pcie_sync_nmi
+	.interrupts = iwl_trans_pci_interrupts,				\
+	.sync_nmi = iwl_trans_pcie_sync_nmi				\
 
 #ifdef CONFIG_PM_SLEEP
 #define IWL_TRANS_PM_OPS						\
@@ -3536,48 +3561,3 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	iwl_trans_free(trans);
 	return ERR_PTR(ret);
 }
-
-void iwl_trans_pcie_sync_nmi(struct iwl_trans *trans)
-{
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	unsigned long timeout = jiffies + IWL_TRANS_NMI_TIMEOUT;
-	bool interrupts_enabled = test_bit(STATUS_INT_ENABLED, &trans->status);
-	u32 inta_addr, sw_err_bit;
-
-	if (trans_pcie->msix_enabled) {
-		inta_addr = CSR_MSIX_HW_INT_CAUSES_AD;
-		sw_err_bit = MSIX_HW_INT_CAUSES_REG_SW_ERR;
-	} else {
-		inta_addr = CSR_INT;
-		sw_err_bit = CSR_INT_BIT_SW_ERR;
-	}
-
-	/* if the interrupts were already disabled, there is no point in
-	 * calling iwl_disable_interrupts
-	 */
-	if (interrupts_enabled)
-		iwl_disable_interrupts(trans);
-
-	iwl_force_nmi(trans);
-	while (time_after(timeout, jiffies)) {
-		u32 inta_hw = iwl_read32(trans, inta_addr);
-
-		/* Error detected by uCode */
-		if (inta_hw & sw_err_bit) {
-			/* Clear causes register */
-			iwl_write32(trans, inta_addr, inta_hw & sw_err_bit);
-			break;
-		}
-
-		mdelay(1);
-	}
-
-	/* enable interrupts only if there were already enabled before this
-	 * function to avoid a case were the driver enable interrupts before
-	 * proper configurations were made
-	 */
-	if (interrupts_enabled)
-		iwl_enable_interrupts(trans);
-
-	iwl_trans_fw_error(trans);
-}
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 8757246a90d5..563d12939854 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -303,7 +303,7 @@ static int iwl_pcie_gen2_send_hcmd_sync(struct iwl_trans *trans,
 			       cmd_str);
 		ret = -ETIMEDOUT;
 
-		iwl_trans_pcie_sync_nmi(trans);
+		iwl_trans_sync_nmi(trans);
 		goto cancel;
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 7d1785fb0e40..67b5fc0b8f3a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1320,7 +1320,7 @@ static int iwl_pcie_send_hcmd_sync(struct iwl_trans *trans,
 			       iwl_get_cmd_string(trans, cmd->id));
 		ret = -ETIMEDOUT;
 
-		iwl_trans_pcie_sync_nmi(trans);
+		iwl_trans_sync_nmi(trans);
 		goto cancel;
 	}
 
-- 
2.29.2

