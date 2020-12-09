Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D600A2D450A
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 16:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732112AbgLIPGG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 10:06:06 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:35466 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730267AbgLIPGG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 10:06:06 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kn11p-003Dg4-Rz; Wed, 09 Dec 2020 17:05:18 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed,  9 Dec 2020 17:05:06 +0200
Message-Id: <iwlwifi.20201209170243.b98ebe93bae4.I13de65e0ffcb4186dd4c1a465f66df2e98c9a947@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209150514.944056-1-luca@coelho.fi>
References: <20201209150514.944056-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 03/11] iwlwifi: support firmware reset handshake
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

There are some races in the hardware that can possibly lead to
a bus lockup later during a restart when we manage to kill the
firmware at a bad time (while it's accessing the bus).

To work around this, add support for a new handshake between
firmware and driver to ensure that the firmware is in a well-
known state before we kill it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  3 +++
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  1 +
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  2 ++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  2 ++
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  3 +++
 .../wireless/intel/iwlwifi/pcie/internal.h    |  4 +++
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  6 +++++
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 26 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  4 +++
 9 files changed, 51 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/file.h b/drivers/net/wireless/intel/iwlwifi/fw/file.h
index 4c3a1a18dc80..597bc88479ba 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/file.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/file.h
@@ -359,6 +359,8 @@ typedef unsigned int __bitwise iwl_ucode_tlv_capa_t;
  *	initiator and responder
  * @IWL_UCODE_TLV_CAPA_MLME_OFFLOAD: supports MLME offload
  * @IWL_UCODE_TLV_CAPA_PROTECTED_TWT: Supports protection of TWT action frames
+ * @IWL_UCODE_TLV_CAPA_FW_RESET_HANDSHAKE: Supports the firmware handshake in
+ *	reset flow
  *
  * @NUM_IWL_UCODE_TLV_CAPA: number of bits used
  */
@@ -404,6 +406,7 @@ enum iwl_ucode_tlv_capa {
 	IWL_UCODE_TLV_CAPA_TAS_CFG			= (__force iwl_ucode_tlv_capa_t)53,
 	IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD		= (__force iwl_ucode_tlv_capa_t)54,
 	IWL_UCODE_TLV_CAPA_PROTECTED_TWT		= (__force iwl_ucode_tlv_capa_t)56,
+	IWL_UCODE_TLV_CAPA_FW_RESET_HANDSHAKE		= (__force iwl_ucode_tlv_capa_t)57,
 
 	/* set 2 */
 	IWL_UCODE_TLV_CAPA_EXTENDED_DTS_MEASURE		= (__force iwl_ucode_tlv_capa_t)64,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index ddee780fea11..ec97b6c94c1f 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -573,6 +573,7 @@ enum msix_hw_int_causes {
 	MSIX_HW_INT_CAUSES_REG_ALIVE		= BIT(0),
 	MSIX_HW_INT_CAUSES_REG_WAKEUP		= BIT(1),
 	MSIX_HW_INT_CAUSES_REG_IML              = BIT(1),
+	MSIX_HW_INT_CAUSES_REG_RESET_DONE	= BIT(2),
 	MSIX_HW_INT_CAUSES_REG_CT_KILL		= BIT(6),
 	MSIX_HW_INT_CAUSES_REG_RF_KILL		= BIT(7),
 	MSIX_HW_INT_CAUSES_REG_PERIODIC		= BIT(8),
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 33753b890003..0b03fdedc1f7 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -55,6 +55,7 @@
 /* Device NMI register and value for 9000 family and above hw's */
 #define UREG_NIC_SET_NMI_DRIVER 0x00a05c10
 #define UREG_NIC_SET_NMI_DRIVER_NMI_FROM_DRIVER BIT(24)
+#define UREG_NIC_SET_NMI_DRIVER_RESET_HANDSHAKE (BIT(24) | BIT(25))
 
 /* Shared registers (0x0..0x3ff, via target indirect or periphery */
 #define SHR_BASE	0x00a10000
@@ -399,6 +400,7 @@ enum {
 
 #define UREG_DOORBELL_TO_ISR6		0xA05C04
 #define UREG_DOORBELL_TO_ISR6_NMI_BIT	BIT(0)
+#define UREG_DOORBELL_TO_ISR6_RESET_HANDSHAKE (BIT(0) | BIT(1))
 #define UREG_DOORBELL_TO_ISR6_SUSPEND	BIT(18)
 #define UREG_DOORBELL_TO_ISR6_RESUME	BIT(19)
 #define UREG_DOORBELL_TO_ISR6_PNVM	BIT(20)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 2c9dd3ff21eb..2d65bb82f7fe 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -380,6 +380,7 @@ struct iwl_hcmd_arr {
  * @command_groups_size: number of command groups, to avoid illegal access
  * @cb_data_offs: offset inside skb->cb to store transport data at, must have
  *	space for at least two pointers
+ * @fw_reset_handshake: firmware supports reset flow handshake
  */
 struct iwl_trans_config {
 	struct iwl_op_mode *op_mode;
@@ -397,6 +398,7 @@ struct iwl_trans_config {
 	int command_groups_size;
 
 	u8 cb_data_offs;
+	bool fw_reset_handshake;
 };
 
 struct iwl_trans_dump_data {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 4d7a3ff06049..fc5e66bc7c58 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -728,6 +728,9 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		 sizeof(mvm->hw->wiphy->fw_version),
 		 "%s", fw->fw_version);
 
+	trans_cfg.fw_reset_handshake = fw_has_capa(&mvm->fw->ucode_capa,
+						   IWL_UCODE_TLV_CAPA_FW_RESET_HANDSHAKE);
+
 	/* Configure transport layer */
 	iwl_trans_configure(mvm->trans, &trans_cfg);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 309dec9d5a08..a528d3d99c5a 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -406,6 +406,10 @@ struct iwl_trans_pcie {
 
 	void *base_rb_stts;
 	dma_addr_t base_rb_stts_dma;
+
+	bool fw_reset_handshake;
+	bool fw_reset_done;
+	wait_queue_head_t fw_reset_waitq;
 };
 
 static inline struct iwl_trans_pcie *
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index e82356abd0c4..37bbd9a07f36 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -2242,6 +2242,12 @@ irqreturn_t iwl_pcie_irq_msix_handler(int irq, void *dev_id)
 		iwl_pcie_irq_handle_error(trans);
 	}
 
+	if (inta_hw & MSIX_HW_INT_CAUSES_REG_RESET_DONE) {
+		IWL_DEBUG_ISR(trans, "Reset flow completed\n");
+		trans_pcie->fw_reset_done = true;
+		wake_up(&trans_pcie->fw_reset_waitq);
+	}
+
 	iwl_pcie_clear_irq(trans, entry);
 
 	lock_map_release(&trans->sync_cmd_lockdep_map);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index c25a2fba3b17..c602b815dcc2 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -88,6 +88,28 @@ static void iwl_pcie_gen2_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 	iwl_clear_bit(trans, CSR_GP_CNTRL, CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
 }
 
+static void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int ret;
+
+	trans_pcie->fw_reset_done = false;
+
+	if (trans->trans_cfg->device_family < IWL_DEVICE_FAMILY_AX210)
+		iwl_write_umac_prph(trans, UREG_NIC_SET_NMI_DRIVER,
+				    UREG_NIC_SET_NMI_DRIVER_RESET_HANDSHAKE);
+	else
+		iwl_write_umac_prph(trans, UREG_DOORBELL_TO_ISR6,
+				    UREG_DOORBELL_TO_ISR6_RESET_HANDSHAKE);
+
+	/* wait 200ms */
+	ret = wait_event_timeout(trans_pcie->fw_reset_waitq,
+				 trans_pcie->fw_reset_done, HZ / 5);
+	if (!ret)
+		IWL_ERR(trans,
+			"firmware didn't ACK the reset - continue anyway\n");
+}
+
 void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -97,6 +119,10 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 	if (trans_pcie->is_down)
 		return;
 
+	if (trans_pcie->fw_reset_handshake &&
+	    trans->state >= IWL_TRANS_FW_STARTED)
+		iwl_trans_pcie_fw_reset_handshake(trans);
+
 	trans_pcie->is_down = true;
 
 	/* tell the device to stop sending interrupts */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index fd5b7e760985..c373fa411730 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1048,6 +1048,7 @@ static struct iwl_causes_list causes_list[] = {
 	{MSIX_FH_INT_CAUSES_FH_ERR,		CSR_MSIX_FH_INT_MASK_AD, 0x5},
 	{MSIX_HW_INT_CAUSES_REG_ALIVE,		CSR_MSIX_HW_INT_MASK_AD, 0x10},
 	{MSIX_HW_INT_CAUSES_REG_WAKEUP,		CSR_MSIX_HW_INT_MASK_AD, 0x11},
+	{MSIX_HW_INT_CAUSES_REG_RESET_DONE,	CSR_MSIX_HW_INT_MASK_AD, 0x12},
 	{MSIX_HW_INT_CAUSES_REG_CT_KILL,	CSR_MSIX_HW_INT_MASK_AD, 0x16},
 	{MSIX_HW_INT_CAUSES_REG_RF_KILL,	CSR_MSIX_HW_INT_MASK_AD, 0x17},
 	{MSIX_HW_INT_CAUSES_REG_PERIODIC,	CSR_MSIX_HW_INT_MASK_AD, 0x18},
@@ -1889,6 +1890,8 @@ static void iwl_trans_pcie_configure(struct iwl_trans *trans,
 	 */
 	if (trans_pcie->napi_dev.reg_state != NETREG_DUMMY)
 		init_dummy_netdev(&trans_pcie->napi_dev);
+
+	trans_pcie->fw_reset_handshake = trans_cfg->fw_reset_handshake;
 }
 
 void iwl_trans_pcie_free(struct iwl_trans *trans)
@@ -3385,6 +3388,7 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	spin_lock_init(&trans_pcie->alloc_page_lock);
 	mutex_init(&trans_pcie->mutex);
 	init_waitqueue_head(&trans_pcie->ucode_write_waitq);
+	init_waitqueue_head(&trans_pcie->fw_reset_waitq);
 
 	trans_pcie->rba.alloc_wq = alloc_workqueue("rb_allocator",
 						   WQ_HIGHPRI | WQ_UNBOUND, 1);
-- 
2.29.2

