Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2967497B0D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 15:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbfHUNiQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 09:38:16 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:37800 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727696AbfHUNiO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 09:38:14 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i0QoW-0000lZ-KA; Wed, 21 Aug 2019 16:38:13 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 21 Aug 2019 16:37:51 +0300
Message-Id: <20190821133800.23636-10-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190821133800.23636-1-luca@coelho.fi>
References: <20190821133800.23636-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH 09/18] iwlwifi: pcie: remove some more d0i3 code from the transport
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

CMD_SEND_IN_IDLE, CMD_MAKE_TRANS_IDLE and CMD_WAKE_UP_TRANS
are not used. Remove them.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 14 +----------
 .../wireless/intel/iwlwifi/pcie/internal.h    |  2 --
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  2 --
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 10 --------
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 24 -------------------
 5 files changed, 1 insertion(+), 51 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 7c63706eb07b..687eced8b548 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -159,10 +159,6 @@ static inline u32 iwl_rx_packet_payload_len(const struct iwl_rx_packet *pkt)
  * @CMD_ASYNC: Return right away and don't wait for the response
  * @CMD_WANT_SKB: Not valid with CMD_ASYNC. The caller needs the buffer of
  *	the response. The caller needs to call iwl_free_resp when done.
- * @CMD_SEND_IN_IDLE: The command should be sent even when the trans is idle.
- * @CMD_MAKE_TRANS_IDLE: The command response should mark the trans as idle.
- * @CMD_WAKE_UP_TRANS: The command response should wake up the trans
- *	(i.e. mark it as non-idle).
  * @CMD_WANT_ASYNC_CALLBACK: the op_mode's async callback function must be
  *	called after this command completes. Valid only with CMD_ASYNC.
  */
@@ -170,10 +166,7 @@ enum CMD_MODE {
 	CMD_ASYNC		= BIT(0),
 	CMD_WANT_SKB		= BIT(1),
 	CMD_SEND_IN_RFKILL	= BIT(2),
-	CMD_SEND_IN_IDLE	= BIT(3),
-	CMD_MAKE_TRANS_IDLE	= BIT(4),
-	CMD_WAKE_UP_TRANS	= BIT(5),
-	CMD_WANT_ASYNC_CALLBACK	= BIT(6),
+	CMD_WANT_ASYNC_CALLBACK	= BIT(3),
 };
 
 #define DEF_CMD_PAYLOAD_SIZE 320
@@ -659,11 +652,6 @@ enum iwl_plat_pm_mode {
 	IWL_PLAT_PM_MODE_D3,
 };
 
-/* Max time to wait for trans to become idle/non-idle on d0i3
- * enter/exit (in msecs).
- */
-#define IWL_TRANS_IDLE_TIMEOUT 2000
-
 /* Max time to wait for nmi interrupt */
 #define IWL_TRANS_NMI_TIMEOUT (HZ / 4)
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index b5534fc33539..97f9f0aa5c5f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -558,7 +558,6 @@ struct iwl_trans_pcie {
 	bool ucode_write_complete;
 	wait_queue_head_t ucode_write_waitq;
 	wait_queue_head_t wait_command_queue;
-	wait_queue_head_t d0i3_waitq;
 
 	u8 page_offs, dev_cmd_offs;
 
@@ -581,7 +580,6 @@ struct iwl_trans_pcie {
 	/*protect hw register */
 	spinlock_t reg_lock;
 	bool cmd_hold_nic_awake;
-	bool ref_cmd_in_flight;
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	struct cont_rec fw_mon_data;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 8d509ec0e113..d1981e77b8f6 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3594,8 +3594,6 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	/* Initialize the wait queue for commands */
 	init_waitqueue_head(&trans_pcie->wait_command_queue);
 
-	init_waitqueue_head(&trans_pcie->d0i3_waitq);
-
 	if (trans_pcie->msix_enabled) {
 		ret = iwl_pcie_init_msix_handler(pdev, trans_pcie);
 		if (ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
index 3a3ac81195dd..cee507d29238 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx-gen2.c
@@ -920,16 +920,6 @@ static int iwl_pcie_gen2_send_hcmd_sync(struct iwl_trans *trans,
 
 	IWL_DEBUG_INFO(trans, "Setting HCMD_ACTIVE for command %s\n", cmd_str);
 
-	if (pm_runtime_suspended(&trans_pcie->pci_dev->dev)) {
-		ret = wait_event_timeout(trans_pcie->d0i3_waitq,
-				 pm_runtime_active(&trans_pcie->pci_dev->dev),
-				 msecs_to_jiffies(IWL_TRANS_IDLE_TIMEOUT));
-		if (!ret) {
-			IWL_ERR(trans, "Timeout exiting D0i3 before hcmd\n");
-			return -ETIMEDOUT;
-		}
-	}
-
 	cmd_idx = iwl_pcie_gen2_enqueue_hcmd(trans, cmd);
 	if (cmd_idx < 0) {
 		ret = cmd_idx;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
index 45356195c228..9432374b69e2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/tx.c
@@ -1858,20 +1858,6 @@ void iwl_pcie_hcmd_complete(struct iwl_trans *trans,
 		wake_up(&trans_pcie->wait_command_queue);
 	}
 
-	if (meta->flags & CMD_MAKE_TRANS_IDLE) {
-		IWL_DEBUG_INFO(trans, "complete %s - mark trans as idle\n",
-			       iwl_get_cmd_string(trans, cmd->hdr.cmd));
-		set_bit(STATUS_TRANS_IDLE, &trans->status);
-		wake_up(&trans_pcie->d0i3_waitq);
-	}
-
-	if (meta->flags & CMD_WAKE_UP_TRANS) {
-		IWL_DEBUG_INFO(trans, "complete %s - clear trans idle flag\n",
-			       iwl_get_cmd_string(trans, cmd->hdr.cmd));
-		clear_bit(STATUS_TRANS_IDLE, &trans->status);
-		wake_up(&trans_pcie->d0i3_waitq);
-	}
-
 	meta->flags = 0;
 
 	spin_unlock_bh(&txq->lock);
@@ -1918,16 +1904,6 @@ static int iwl_pcie_send_hcmd_sync(struct iwl_trans *trans,
 	IWL_DEBUG_INFO(trans, "Setting HCMD_ACTIVE for command %s\n",
 		       iwl_get_cmd_string(trans, cmd->id));
 
-	if (pm_runtime_suspended(&trans_pcie->pci_dev->dev)) {
-		ret = wait_event_timeout(trans_pcie->d0i3_waitq,
-				 pm_runtime_active(&trans_pcie->pci_dev->dev),
-				 msecs_to_jiffies(IWL_TRANS_IDLE_TIMEOUT));
-		if (!ret) {
-			IWL_ERR(trans, "Timeout exiting D0i3 before hcmd\n");
-			return -ETIMEDOUT;
-		}
-	}
-
 	cmd_idx = iwl_pcie_enqueue_hcmd(trans, cmd);
 	if (cmd_idx < 0) {
 		ret = cmd_idx;
-- 
2.23.0.rc1

