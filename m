Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8123B3DDAB3
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 16:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbhHBOUH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 10:20:07 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50872 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236849AbhHBOTy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 10:19:54 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAYdb-001xoA-IQ; Mon, 02 Aug 2021 17:09:53 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 17:09:40 +0300
Message-Id: <iwlwifi.20210802170640.8b6a33544b4b.I55f97f70f8efa64db064a9207177a094c60ac8f1@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802140944.90143-1-luca@coelho.fi>
References: <20210802140944.90143-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 08/12] iwlwifi: pcie: dump error on FW reset handshake failures
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If the firmware crashes while we're waiting for the reset
handshake then it cannot possibly make progress anymore,
and we will just time out the wait. That's pointless, so
just stop waiting at that point.

Additionally, if it never acknowledges the reset handshake,
something went wrong.

Dump an error in both of these cases, but we need to do it
synchronously here since the device will be turned off.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h   |  9 ++++++++-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c         | 10 ++++++++--
 drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c | 11 ++++++++---
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 10d763fc3d50..6c3b0403b68f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -254,6 +254,13 @@ struct cont_rec {
 };
 #endif
 
+enum iwl_pcie_fw_reset_state {
+	FW_RESET_IDLE,
+	FW_RESET_REQUESTED,
+	FW_RESET_OK,
+	FW_RESET_ERROR,
+};
+
 /**
  * struct iwl_trans_pcie - PCIe transport specific data
  * @rxq: all the RX queue data
@@ -405,7 +412,7 @@ struct iwl_trans_pcie {
 	dma_addr_t base_rb_stts_dma;
 
 	bool fw_reset_handshake;
-	bool fw_reset_done;
+	enum iwl_pcie_fw_reset_state fw_reset_state;
 	wait_queue_head_t fw_reset_waitq;
 
 	char rf_name[32];
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 54bfc01ab34c..8e45eb38304b 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -2228,7 +2228,13 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 			"Microcode SW error detected. Restarting 0x%X.\n",
 			inta_fh);
 		isr_stats->sw++;
-		iwl_pcie_irq_handle_error(trans);
+		/* during FW reset flow report errors from there */
+		if (trans_pcie->fw_reset_state == FW_RESET_REQUESTED) {
+			trans_pcie->fw_reset_state = FW_RESET_ERROR;
+			wake_up(&trans_pcie->fw_reset_waitq);
+		} else {
+			iwl_pcie_irq_handle_error(trans);
+		}
 	}
 
 	/* After checking FH register check HW register */
@@ -2296,7 +2302,7 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 
 	if (inta_hw & MSIX_HW_INT_CAUSES_REG_RESET_DONE) {
 		IWL_DEBUG_ISR(trans, "Reset flow completed\n");
-		trans_pcie->fw_reset_done = true;
+		trans_pcie->fw_reset_state = FW_RESET_OK;
 		wake_up(&trans_pcie->fw_reset_waitq);
 	}
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index a34009357227..a266a35ff928 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -95,7 +95,7 @@ static void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int ret;
 
-	trans_pcie->fw_reset_done = false;
+	trans_pcie->fw_reset_state = FW_RESET_REQUESTED;
 
 	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
 		iwl_write_umac_prph(trans, UREG_NIC_SET_NMI_DRIVER,
@@ -106,10 +106,15 @@ static void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
 
 	/* wait 200ms */
 	ret = wait_event_timeout(trans_pcie->fw_reset_waitq,
-				 trans_pcie->fw_reset_done, FW_RESET_TIMEOUT);
-	if (!ret)
+				 trans_pcie->fw_reset_state != FW_RESET_REQUESTED,
+				 FW_RESET_TIMEOUT);
+	if (!ret || trans_pcie->fw_reset_state == FW_RESET_ERROR) {
 		IWL_INFO(trans,
 			 "firmware didn't ACK the reset - continue anyway\n");
+		iwl_trans_fw_error(trans, true);
+	}
+
+	trans_pcie->fw_reset_state = FW_RESET_IDLE;
 }
 
 void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
-- 
2.32.0

