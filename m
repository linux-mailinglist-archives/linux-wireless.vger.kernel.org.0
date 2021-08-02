Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1356E3DDFB6
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 20:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhHBS7Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 14:59:16 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:51022 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230442AbhHBS7P (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 14:59:15 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAd9S-001ySl-Nm; Mon, 02 Aug 2021 21:59:04 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 21:58:51 +0300
Message-Id: <iwlwifi.20210802215208.00a137364a95.I059a2abac948965458862941ee7db6a2e1076fa6@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802185856.175567-1-luca@coelho.fi>
References: <20210802185856.175567-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 05/10] iwlwifi: pcie: implement Bz device startup
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Device startup changed in Bz, some register bits moved around.
Change the code accordingly.

The new Bz hardware changes also the way we wake it (grab NIC
access) and the way we disable bus mastering, update the driver
code accordingly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  8 ++++
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   | 17 ++++++---
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 24 ++++++++++--
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 38 ++++++++++++++-----
 4 files changed, 68 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index 004a1b02bea8..704ff2ada122 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -266,6 +266,14 @@
 #define CSR_GP_CNTRL_REG_FLAG_RFKILL_WAKE_L1A_EN     (0x04000000)
 #define CSR_GP_CNTRL_REG_FLAG_HW_RF_KILL_SW          (0x08000000)
 
+/* From Bz we use these instead during init/reset flow */
+#define CSR_GP_CNTRL_REG_FLAG_MAC_INIT			BIT(6)
+#define CSR_GP_CNTRL_REG_FLAG_ROM_START			BIT(7)
+#define CSR_GP_CNTRL_REG_FLAG_MAC_STATUS		BIT(20)
+#define CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ		BIT(21)
+#define CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_STATUS	BIT(28)
+#define CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_REQ	BIT(29)
+#define CSR_GP_CNTRL_REG_FLAG_SW_RESET			BIT(31)
 
 /* HW REV */
 #define CSR_HW_REV_DASH(_val)          (((_val) & 0x0000003) >> 0)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-io.c b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
index 2a0be1fafdf9..dba54b3297d1 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-io.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-io.c
@@ -398,6 +398,7 @@ int iwl_dump_fh(struct iwl_trans *trans, char **buf)
 int iwl_finish_nic_init(struct iwl_trans *trans,
 			const struct iwl_cfg_trans_params *cfg_trans)
 {
+	u32 poll_ready;
 	int err;
 
 	if (cfg_trans->bisr_workaround) {
@@ -409,7 +410,16 @@ int iwl_finish_nic_init(struct iwl_trans *trans,
 	 * Set "initialization complete" bit to move adapter from
 	 * D0U* --> D0A* (powered-up active) state.
 	 */
-	iwl_set_bit(trans, CSR_GP_CNTRL, CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
+	if (cfg_trans->device_family >= IWL_DEVICE_FAMILY_BZ) {
+		iwl_set_bit(trans, CSR_GP_CNTRL,
+			    CSR_GP_CNTRL_REG_FLAG_MAC_CLOCK_READY |
+			    CSR_GP_CNTRL_REG_FLAG_MAC_INIT);
+		poll_ready = CSR_GP_CNTRL_REG_FLAG_MAC_STATUS;
+	} else {
+		iwl_set_bit(trans, CSR_GP_CNTRL,
+			    CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
+		poll_ready = CSR_GP_CNTRL_REG_FLAG_MAC_CLOCK_READY;
+	}
 
 	if (cfg_trans->device_family == IWL_DEVICE_FAMILY_8000)
 		udelay(2);
@@ -419,10 +429,7 @@ int iwl_finish_nic_init(struct iwl_trans *trans,
 	 * device-internal resources is supported, e.g. iwl_write_prph()
 	 * and accesses to uCode SRAM.
 	 */
-	err = iwl_poll_bit(trans, CSR_GP_CNTRL,
-			   CSR_GP_CNTRL_REG_FLAG_MAC_CLOCK_READY,
-			   CSR_GP_CNTRL_REG_FLAG_MAC_CLOCK_READY,
-			   25000);
+	err = iwl_poll_bit(trans, CSR_GP_CNTRL, poll_ready, poll_ready, 25000);
 	if (err < 0)
 		IWL_DEBUG_INFO(trans, "Failed to wake NIC\n");
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index a266a35ff928..fa416b42bd9d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -87,7 +87,12 @@ static void iwl_pcie_gen2_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 	 * Clear "initialization complete" bit to move adapter from
 	 * D0A* (powered-up Active) --> D0U* (Uninitialized) state.
 	 */
-	iwl_clear_bit(trans, CSR_GP_CNTRL, CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		iwl_clear_bit(trans, CSR_GP_CNTRL,
+			      CSR_GP_CNTRL_REG_FLAG_MAC_INIT);
+	else
+		iwl_clear_bit(trans, CSR_GP_CNTRL,
+			      CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
 }
 
 static void iwl_trans_pcie_fw_reset_handshake(struct iwl_trans *trans)
@@ -159,9 +164,17 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 		iwl_pcie_ctxt_info_free(trans);
 
 	/* Make sure (redundant) we've released our request to stay awake */
-	iwl_clear_bit(trans, CSR_GP_CNTRL,
-		      CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		iwl_clear_bit(trans, CSR_GP_CNTRL,
+			      CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ);
+	else
+		iwl_clear_bit(trans, CSR_GP_CNTRL,
+			      CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
 
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+		iwl_set_bit(trans, CSR_GP_CNTRL,
+			    CSR_GP_CNTRL_REG_FLAG_SW_RESET);
+	}
 	/* Stop the device, and put it in low power state */
 	iwl_pcie_gen2_apm_stop(trans, false);
 
@@ -441,7 +454,10 @@ int iwl_trans_pcie_gen2_start_fw(struct iwl_trans *trans,
 
 	iwl_pcie_set_ltr(trans);
 
-	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
+		iwl_set_bit(trans, CSR_GP_CNTRL,
+			    CSR_GP_CNTRL_REG_FLAG_ROM_START);
+	else if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_AX210)
 		iwl_write_umac_prph(trans, UREG_CPU_INIT_RUN, 1);
 	else
 		iwl_write_prph(trans, UREG_CPU_INIT_RUN, 1);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 65cc25cbb9ec..86a949440486 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -449,11 +449,23 @@ void iwl_pcie_apm_stop_master(struct iwl_trans *trans)
 	int ret;
 
 	/* stop device's busmaster DMA activity */
-	iwl_set_bit(trans, CSR_RESET, CSR_RESET_REG_FLAG_STOP_MASTER);
 
-	ret = iwl_poll_bit(trans, CSR_RESET,
-			   CSR_RESET_REG_FLAG_MASTER_DISABLED,
-			   CSR_RESET_REG_FLAG_MASTER_DISABLED, 100);
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+		iwl_set_bit(trans, CSR_GP_CNTRL,
+			    CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_REQ);
+
+		ret = iwl_poll_bit(trans, CSR_GP_CNTRL,
+				   CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_STATUS,
+				   CSR_GP_CNTRL_REG_FLAG_BUS_MASTER_DISABLE_STATUS,
+				   100);
+	} else {
+		iwl_set_bit(trans, CSR_RESET, CSR_RESET_REG_FLAG_STOP_MASTER);
+
+		ret = iwl_poll_bit(trans, CSR_RESET,
+				   CSR_RESET_REG_FLAG_MASTER_DISABLED,
+				   CSR_RESET_REG_FLAG_MASTER_DISABLED, 100);
+	}
+
 	if (ret < 0)
 		IWL_WARN(trans, "Master Disable Timed Out, 100 usec\n");
 
@@ -1995,15 +2007,24 @@ bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 {
 	int ret;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	u32 write = CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ;
+	u32 mask = CSR_GP_CNTRL_REG_FLAG_MAC_CLOCK_READY |
+		   CSR_GP_CNTRL_REG_FLAG_GOING_TO_SLEEP;
+	u32 poll = CSR_GP_CNTRL_REG_VAL_MAC_ACCESS_EN;
 
 	spin_lock(&trans_pcie->reg_lock);
 
 	if (trans_pcie->cmd_hold_nic_awake)
 		goto out;
 
+	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ) {
+		write = CSR_GP_CNTRL_REG_FLAG_BZ_MAC_ACCESS_REQ;
+		mask = CSR_GP_CNTRL_REG_FLAG_MAC_STATUS;
+		poll = CSR_GP_CNTRL_REG_FLAG_MAC_STATUS;
+	}
+
 	/* this bit wakes up the NIC */
-	__iwl_trans_pcie_set_bit(trans, CSR_GP_CNTRL,
-				 CSR_GP_CNTRL_REG_FLAG_MAC_ACCESS_REQ);
+	__iwl_trans_pcie_set_bit(trans, CSR_GP_CNTRL, write);
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_8000)
 		udelay(2);
 
@@ -2027,10 +2048,7 @@ bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 	 * 5000 series and later (including 1000 series) have non-volatile SRAM,
 	 * and do not save/restore SRAM when power cycling.
 	 */
-	ret = iwl_poll_bit(trans, CSR_GP_CNTRL,
-			   CSR_GP_CNTRL_REG_VAL_MAC_ACCESS_EN,
-			   (CSR_GP_CNTRL_REG_FLAG_MAC_CLOCK_READY |
-			    CSR_GP_CNTRL_REG_FLAG_GOING_TO_SLEEP), 15000);
+	ret = iwl_poll_bit(trans, CSR_GP_CNTRL, poll, mask, 15000);
 	if (unlikely(ret < 0)) {
 		u32 cntrl = iwl_read32(trans, CSR_GP_CNTRL);
 
-- 
2.32.0

