Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7594682F8
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 07:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbhLDGjf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 01:39:35 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50302 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238276AbhLDGjd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 01:39:33 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtOeU-0017AH-MK; Sat, 04 Dec 2021 08:36:07 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 08:35:49 +0200
Message-Id: <iwlwifi.20211204083238.63f3d150689a.Iaeb6f9b007e81b1a5a02144b0281935e4613cb78@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204063555.769822-1-luca@coelho.fi>
References: <20211204063555.769822-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 06/12] iwlwifi: pcie: support Bz suspend/resume trigger
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Haim Dreyfuss <haim.dreyfuss@intel.com>

Instead of using two bits in the doorbell interrupt, the new Bz
devices have a new CSR_IPC_SLEEP_CONTROL register to let drivers
indicate the desired transition before triggering the doorbell
interrupt.

Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  4 +
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  7 ++
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 75 ++++++++++---------
 3 files changed, 52 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index 046a01f5988b..21d8249980fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -105,6 +105,10 @@
 /* GIO Chicken Bits (PCI Express bus link power management) */
 #define CSR_GIO_CHICKEN_BITS    (CSR_BASE+0x100)
 
+#define CSR_IPC_SLEEP_CONTROL	(CSR_BASE + 0x114)
+#define CSR_IPC_SLEEP_CONTROL_SUSPEND	0x3
+#define CSR_IPC_SLEEP_CONTROL_RESUME	0
+
 /* Doorbell NMI (since Bz) */
 #define CSR_DOORBELL_VECTOR	(CSR_BASE + 0x130)
 #define CSR_DOORBELL_VECTOR_NMI	BIT(1)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index a84ab02cf9d7..2ca22e1b8bd9 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -455,6 +455,13 @@ enum {
 #define UREG_DOORBELL_TO_ISR6_RESUME	BIT(19)
 #define UREG_DOORBELL_TO_ISR6_PNVM	BIT(20)
 
+/*
+ * From BZ family driver triggers this bit for suspend and resume
+ * The driver should update CSR_IPC_SLEEP_CONTROL before triggering
+ * this interrupt with suspend/resume value
+ */
+#define UREG_DOORBELL_TO_ISR6_SLEEP_CTRL	BIT(31)
+
 #define CNVI_MBOX_C			0xA3400C
 
 #define FSEQ_ERROR_CODE			0xA340C8
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index f607edd41baa..0aeab8acc247 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1499,33 +1499,54 @@ void iwl_pcie_d3_complete_suspend(struct iwl_trans *trans,
 	iwl_pcie_set_pwr(trans, true);
 }
 
+static int iwl_pcie_d3_handshake(struct iwl_trans *trans, bool suspend)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int ret;
+
+	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_AX210) {
+		iwl_write_umac_prph(trans, UREG_DOORBELL_TO_ISR6,
+				    suspend ? UREG_DOORBELL_TO_ISR6_SUSPEND :
+					      UREG_DOORBELL_TO_ISR6_RESUME);
+	} else if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+		iwl_write32(trans, CSR_IPC_SLEEP_CONTROL,
+			    suspend ? CSR_IPC_SLEEP_CONTROL_SUSPEND :
+				      CSR_IPC_SLEEP_CONTROL_RESUME);
+		iwl_write_umac_prph(trans, UREG_DOORBELL_TO_ISR6,
+				    UREG_DOORBELL_TO_ISR6_SLEEP_CTRL);
+	} else {
+		return 0;
+	}
+
+	ret = wait_event_timeout(trans_pcie->sx_waitq,
+				 trans_pcie->sx_complete, 2 * HZ);
+
+	/* Invalidate it toward next suspend or resume */
+	trans_pcie->sx_complete = false;
+
+	if (!ret) {
+		IWL_ERR(trans, "Timeout %s D3\n",
+			suspend ? "entering" : "exiting");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static int iwl_trans_pcie_d3_suspend(struct iwl_trans *trans, bool test,
 				     bool reset)
 {
 	int ret;
-	struct iwl_trans_pcie *trans_pcie =  IWL_TRANS_GET_PCIE_TRANS(trans);
 
 	if (!reset)
 		/* Enable persistence mode to avoid reset */
 		iwl_set_bit(trans, CSR_HW_IF_CONFIG_REG,
 			    CSR_HW_IF_CONFIG_REG_PERSIST_MODE);
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
-		iwl_write_umac_prph(trans, UREG_DOORBELL_TO_ISR6,
-				    UREG_DOORBELL_TO_ISR6_SUSPEND);
-
-		ret = wait_event_timeout(trans_pcie->sx_waitq,
-					 trans_pcie->sx_complete, 2 * HZ);
-		/*
-		 * Invalidate it toward resume.
-		 */
-		trans_pcie->sx_complete = false;
+	ret = iwl_pcie_d3_handshake(trans, true);
+	if (ret)
+		return ret;
 
-		if (!ret) {
-			IWL_ERR(trans, "Timeout entering D3\n");
-			return -ETIMEDOUT;
-		}
-	}
 	iwl_pcie_d3_complete_suspend(trans, test, reset);
 
 	return 0;
@@ -1542,6 +1563,7 @@ static int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 	if (test) {
 		iwl_enable_interrupts(trans);
 		*status = IWL_D3_STATUS_ALIVE;
+		ret = 0;
 		goto out;
 	}
 
@@ -1590,25 +1612,10 @@ static int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 		*status = IWL_D3_STATUS_ALIVE;
 
 out:
-	if (*status == IWL_D3_STATUS_ALIVE &&
-	    trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210) {
-		trans_pcie->sx_complete = false;
-		iwl_write_umac_prph(trans, UREG_DOORBELL_TO_ISR6,
-				    UREG_DOORBELL_TO_ISR6_RESUME);
+	if (*status == IWL_D3_STATUS_ALIVE)
+		ret = iwl_pcie_d3_handshake(trans, false);
 
-		ret = wait_event_timeout(trans_pcie->sx_waitq,
-					 trans_pcie->sx_complete, 2 * HZ);
-		/*
-		 * Invalidate it toward next suspend.
-		 */
-		trans_pcie->sx_complete = false;
-
-		if (!ret) {
-			IWL_ERR(trans, "Timeout exiting D3\n");
-			return -ETIMEDOUT;
-		}
-	}
-	return 0;
+	return ret;
 }
 
 static void
-- 
2.33.1

