Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36852438959
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Oct 2021 15:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231754AbhJXN5m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Oct 2021 09:57:42 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58546 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231713AbhJXN5k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Oct 2021 09:57:40 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1medy1-000cvJ-Sp; Sun, 24 Oct 2021 16:55:18 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 24 Oct 2021 16:55:03 +0300
Message-Id: <iwlwifi.20211024165252.f674cd409b8e.I519f554d0a22d4711077785ec2bd7c564997241f@changeid>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211024135506.285102-1-luca@coelho.fi>
References: <20211024135506.285102-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 08/11] iwlwifi: pcie: update sw error interrupt for BZ family
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mike Golant <michael.golant@intel.com>

The cause for sw error in BZ device family was changed

Signed-off-by: Mike Golant <michael.golant@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  1 +
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  9 +++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 45 ++++++++++++++-----
 3 files changed, 42 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index 2c4d70fb32fa..ff79a2ecb242 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -605,6 +605,7 @@ enum msix_hw_int_causes {
 	MSIX_HW_INT_CAUSES_REG_WAKEUP		= BIT(1),
 	MSIX_HW_INT_CAUSES_REG_IML              = BIT(1),
 	MSIX_HW_INT_CAUSES_REG_RESET_DONE	= BIT(2),
+	MSIX_HW_INT_CAUSES_REG_SW_ERR_BZ	= BIT(5),
 	MSIX_HW_INT_CAUSES_REG_CT_KILL		= BIT(6),
 	MSIX_HW_INT_CAUSES_REG_RF_KILL		= BIT(7),
 	MSIX_HW_INT_CAUSES_REG_PERIODIC		= BIT(8),
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 8e45eb38304b..14602d6d6699 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -2149,6 +2149,7 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 	u32 inta_fh_msk = ~MSIX_FH_INT_CAUSES_DATA_QUEUE;
 	u32 inta_fh, inta_hw;
 	bool polling = false;
+	bool sw_err;
 
 	if (trans_pcie->shared_vec_mask & IWL_SHARED_IRQ_NON_RX)
 		inta_fh_msk |= MSIX_FH_INT_CAUSES_Q0;
@@ -2221,9 +2222,13 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 		wake_up(&trans_pcie->ucode_write_waitq);
 	}
 
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		sw_err = inta_hw & MSIX_HW_INT_CAUSES_REG_SW_ERR_BZ;
+	else
+		sw_err = inta_hw & MSIX_HW_INT_CAUSES_REG_SW_ERR;
+
 	/* Error detected by uCode */
-	if ((inta_fh & MSIX_FH_INT_CAUSES_FH_ERR) ||
-	    (inta_hw & MSIX_HW_INT_CAUSES_REG_SW_ERR)) {
+	if ((inta_fh & MSIX_FH_INT_CAUSES_FH_ERR) || sw_err) {
 		IWL_ERR(trans,
 			"Microcode SW error detected. Restarting 0x%X.\n",
 			inta_fh);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 262795368bfe..1efb53f78a62 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1062,7 +1062,7 @@ struct iwl_causes_list {
 	u8 addr;
 };
 
-static struct iwl_causes_list causes_list[] = {
+static const struct iwl_causes_list causes_list_common[] = {
 	{MSIX_FH_INT_CAUSES_D2S_CH0_NUM,	CSR_MSIX_FH_INT_MASK_AD, 0},
 	{MSIX_FH_INT_CAUSES_D2S_CH1_NUM,	CSR_MSIX_FH_INT_MASK_AD, 0x1},
 	{MSIX_FH_INT_CAUSES_S2D,		CSR_MSIX_FH_INT_MASK_AD, 0x3},
@@ -1073,30 +1073,50 @@ static struct iwl_causes_list causes_list[] = {
 	{MSIX_HW_INT_CAUSES_REG_CT_KILL,	CSR_MSIX_HW_INT_MASK_AD, 0x16},
 	{MSIX_HW_INT_CAUSES_REG_RF_KILL,	CSR_MSIX_HW_INT_MASK_AD, 0x17},
 	{MSIX_HW_INT_CAUSES_REG_PERIODIC,	CSR_MSIX_HW_INT_MASK_AD, 0x18},
-	{MSIX_HW_INT_CAUSES_REG_SW_ERR,		CSR_MSIX_HW_INT_MASK_AD, 0x29},
 	{MSIX_HW_INT_CAUSES_REG_SCD,		CSR_MSIX_HW_INT_MASK_AD, 0x2A},
 	{MSIX_HW_INT_CAUSES_REG_FH_TX,		CSR_MSIX_HW_INT_MASK_AD, 0x2B},
 	{MSIX_HW_INT_CAUSES_REG_HW_ERR,		CSR_MSIX_HW_INT_MASK_AD, 0x2D},
 	{MSIX_HW_INT_CAUSES_REG_HAP,		CSR_MSIX_HW_INT_MASK_AD, 0x2E},
 };
 
+static const struct iwl_causes_list causes_list_pre_bz[] = {
+	{MSIX_HW_INT_CAUSES_REG_SW_ERR,		CSR_MSIX_HW_INT_MASK_AD, 0x29},
+};
+
+static const struct iwl_causes_list causes_list_bz[] = {
+	{MSIX_HW_INT_CAUSES_REG_SW_ERR_BZ,	CSR_MSIX_HW_INT_MASK_AD, 0x29},
+};
+
+static void iwl_pcie_map_list(struct iwl_trans *trans,
+			      const struct iwl_causes_list *causes,
+			      int arr_size, int val)
+{
+	int i;
+
+	for (i = 0; i < arr_size; i++) {
+		iwl_write8(trans, CSR_MSIX_IVAR(causes[i].addr), val);
+		iwl_clear_bit(trans, causes[i].mask_reg,
+			      causes[i].cause_num);
+	}
+}
+
 static void iwl_pcie_map_non_rx_causes(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie =  IWL_TRANS_GET_PCIE_TRANS(trans);
 	int val = trans_pcie->def_irq | MSIX_NON_AUTO_CLEAR_CAUSE;
-	int i, arr_size = ARRAY_SIZE(causes_list);
-	struct iwl_causes_list *causes = causes_list;
-
 	/*
 	 * Access all non RX causes and map them to the default irq.
 	 * In case we are missing at least one interrupt vector,
 	 * the first interrupt vector will serve non-RX and FBQ causes.
 	 */
-	for (i = 0; i < arr_size; i++) {
-		iwl_write8(trans, CSR_MSIX_IVAR(causes[i].addr), val);
-		iwl_clear_bit(trans, causes[i].mask_reg,
-			      causes[i].cause_num);
-	}
+	iwl_pcie_map_list(trans, causes_list_common,
+			  ARRAY_SIZE(causes_list_common), val);
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		iwl_pcie_map_list(trans, causes_list_bz,
+				  ARRAY_SIZE(causes_list_bz), val);
+	else
+		iwl_pcie_map_list(trans, causes_list_pre_bz,
+				  ARRAY_SIZE(causes_list_pre_bz), val);
 }
 
 static void iwl_pcie_map_rx_causes(struct iwl_trans *trans)
@@ -3384,7 +3404,10 @@ static void iwl_trans_pcie_sync_nmi(struct iwl_trans *trans)
 
 	if (trans_pcie->msix_enabled) {
 		inta_addr = CSR_MSIX_HW_INT_CAUSES_AD;
-		sw_err_bit = MSIX_HW_INT_CAUSES_REG_SW_ERR;
+		if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+			sw_err_bit = MSIX_HW_INT_CAUSES_REG_SW_ERR_BZ;
+		else
+			sw_err_bit = MSIX_HW_INT_CAUSES_REG_SW_ERR;
 	} else {
 		inta_addr = CSR_INT;
 		sw_err_bit = CSR_INT_BIT_SW_ERR;
-- 
2.33.0

