Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E2F46860A
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 16:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347690AbhLDPxT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 10:53:19 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50472 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1347440AbhLDPxT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 10:53:19 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtXIM-0017qB-SW; Sat, 04 Dec 2021 17:49:52 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 17:49:36 +0200
Message-Id: <iwlwifi.20211204174545.458f9d98ac21.I40b9a22df1ab8178cc838fc83d5190e689dfac6a@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204154944.914175-1-luca@coelho.fi>
References: <20211204154944.914175-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 04/12] iwlwifi: pcie: retake ownership after reset
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In most cases, unless shutting down the NIC, we really need
to retake ownership after doing a software reset of the NIC.
Encode that into the API so we "automatically" do it, even
in case of workarounds, and don't keep forgetting it like a
few of the places we have did.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  |  4 ++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  8 +++--
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  8 ++---
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 35 ++++++++++++-------
 4 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dump.c b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
index 016b3a4c5f51..358fc2d999d5 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dump.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dump.c
@@ -212,7 +212,9 @@ static void iwl_fwrt_dump_lmac_error_log(struct iwl_fw_runtime *fwrt, u8 lmac_nu
 		IWL_ERR(trans, "HW error, resetting before reading\n");
 
 		/* reset the device */
-		iwl_trans_sw_reset(trans);
+		err = iwl_trans_sw_reset(trans, true);
+		if (err)
+			return;
 
 		err = iwl_finish_nic_init(trans);
 		if (err)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 947ed82b7f19..9dea8f9bbcae 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -593,7 +593,7 @@ struct iwl_trans_ops {
 	void (*configure)(struct iwl_trans *trans,
 			  const struct iwl_trans_config *trans_cfg);
 	void (*set_pmi)(struct iwl_trans *trans, bool state);
-	void (*sw_reset)(struct iwl_trans *trans);
+	int (*sw_reset)(struct iwl_trans *trans, bool retake_ownership);
 	bool (*grab_nic_access)(struct iwl_trans *trans);
 	void (*release_nic_access)(struct iwl_trans *trans);
 	void (*set_bits_mask)(struct iwl_trans *trans, u32 reg, u32 mask,
@@ -1386,10 +1386,12 @@ static inline void iwl_trans_set_pmi(struct iwl_trans *trans, bool state)
 		trans->ops->set_pmi(trans, state);
 }
 
-static inline void iwl_trans_sw_reset(struct iwl_trans *trans)
+static inline int iwl_trans_sw_reset(struct iwl_trans *trans,
+				     bool retake_ownership)
 {
 	if (trans->ops->sw_reset)
-		trans->ops->sw_reset(trans);
+		return trans->ops->sw_reset(trans, retake_ownership);
+	return 0;
 }
 
 static inline void
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 645cb4dd4e5a..72b5b69bfe5e 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -81,7 +81,7 @@ static void iwl_pcie_gen2_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 	/* Stop device's DMA activity */
 	iwl_pcie_apm_stop_master(trans);
 
-	iwl_trans_sw_reset(trans);
+	iwl_trans_sw_reset(trans, false);
 
 	/*
 	 * Clear "initialization complete" bit to move adapter from
@@ -166,7 +166,8 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 	/* Stop the device, and put it in low power state */
 	iwl_pcie_gen2_apm_stop(trans, false);
 
-	iwl_trans_sw_reset(trans);
+	/* re-take ownership to prevent other users from stealing the device */
+	iwl_trans_sw_reset(trans, true);
 
 	/*
 	 * Upon stop, the IVAR table gets erased, so msi-x won't
@@ -196,9 +197,6 @@ void _iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
 	 * interrupt
 	 */
 	iwl_enable_rfkill_int(trans);
-
-	/* re-take ownership to prevent other users from stealing the device */
-	iwl_pcie_prepare_card_hw(trans);
 }
 
 void iwl_trans_pcie_gen2_stop_device(struct iwl_trans *trans)
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 0aeab8acc247..a63386a01232 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -127,7 +127,8 @@ void iwl_trans_pcie_dump_regs(struct iwl_trans *trans)
 	kfree(buf);
 }
 
-static void iwl_trans_pcie_sw_reset(struct iwl_trans *trans)
+static int iwl_trans_pcie_sw_reset(struct iwl_trans *trans,
+				   bool retake_ownership)
 {
 	/* Reset entire device - do controller reset (results in SHRD_HW_RST) */
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
@@ -137,6 +138,11 @@ static void iwl_trans_pcie_sw_reset(struct iwl_trans *trans)
 		iwl_set_bit(trans, CSR_RESET,
 			    CSR_RESET_REG_FLAG_SW_RESET);
 	usleep_range(5000, 6000);
+
+	if (retake_ownership)
+		return iwl_pcie_prepare_card_hw(trans);
+
+	return 0;
 }
 
 static void iwl_pcie_free_fw_monitor(struct iwl_trans *trans)
@@ -382,9 +388,11 @@ static void iwl_pcie_apm_lp_xtal_enable(struct iwl_trans *trans)
 	__iwl_trans_pcie_set_bit(trans, CSR_GP_CNTRL,
 				 CSR_GP_CNTRL_REG_FLAG_XTAL_ON);
 
-	iwl_trans_pcie_sw_reset(trans);
+	ret = iwl_trans_pcie_sw_reset(trans, true);
+
+	if (!ret)
+		ret = iwl_finish_nic_init(trans);
 
-	ret = iwl_finish_nic_init(trans);
 	if (WARN_ON(ret)) {
 		/* Release XTAL ON request */
 		__iwl_trans_pcie_clear_bit(trans, CSR_GP_CNTRL,
@@ -409,7 +417,10 @@ static void iwl_pcie_apm_lp_xtal_enable(struct iwl_trans *trans)
 				 apmg_xtal_cfg_reg |
 				 SHR_APMG_XTAL_CFG_XTAL_ON_REQ);
 
-	iwl_trans_pcie_sw_reset(trans);
+	ret = iwl_trans_pcie_sw_reset(trans, true);
+	if (ret)
+		IWL_ERR(trans,
+			"iwl_pcie_apm_lp_xtal_enable: failed to retake NIC ownership\n");
 
 	/* Enable LP XTAL by indirect access through CSR */
 	apmg_gp1_reg = iwl_trans_pcie_read_shr(trans, SHR_APMG_GP1_REG);
@@ -515,7 +526,7 @@ static void iwl_pcie_apm_stop(struct iwl_trans *trans, bool op_mode_leave)
 		return;
 	}
 
-	iwl_trans_pcie_sw_reset(trans);
+	iwl_trans_pcie_sw_reset(trans, false);
 
 	/*
 	 * Clear "initialization complete" bit to move adapter from
@@ -1261,7 +1272,8 @@ static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 	/* Stop the device, and put it in low power state */
 	iwl_pcie_apm_stop(trans, false);
 
-	iwl_trans_pcie_sw_reset(trans);
+	/* re-take ownership to prevent other users from stealing the device */
+	iwl_trans_pcie_sw_reset(trans, true);
 
 	/*
 	 * Upon stop, the IVAR table gets erased, so msi-x won't
@@ -1291,9 +1303,6 @@ static void _iwl_trans_pcie_stop_device(struct iwl_trans *trans)
 	 * interrupt
 	 */
 	iwl_enable_rfkill_int(trans);
-
-	/* re-take ownership to prevent other users from stealing the device */
-	iwl_pcie_prepare_card_hw(trans);
 }
 
 void iwl_pcie_synchronize_irqs(struct iwl_trans *trans)
@@ -1802,9 +1811,7 @@ static int iwl_pcie_gen2_force_power_gating(struct iwl_trans *trans)
 	iwl_clear_bits_prph(trans, HPM_HIPM_GEN_CFG,
 			    HPM_HIPM_GEN_CFG_CR_FORCE_ACTIVE);
 
-	iwl_trans_pcie_sw_reset(trans);
-
-	return 0;
+	return iwl_trans_pcie_sw_reset(trans, true);
 }
 
 static int _iwl_trans_pcie_start_hw(struct iwl_trans *trans)
@@ -1824,7 +1831,9 @@ static int _iwl_trans_pcie_start_hw(struct iwl_trans *trans)
 	if (err)
 		return err;
 
-	iwl_trans_pcie_sw_reset(trans);
+	err = iwl_trans_pcie_sw_reset(trans, true);
+	if (err)
+		return err;
 
 	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22000 &&
 	    trans->trans_cfg->integrated) {
-- 
2.33.1

