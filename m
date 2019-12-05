Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0073113C16
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2019 08:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbfLEHEC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Dec 2019 02:04:02 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50496 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725867AbfLEHEC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Dec 2019 02:04:02 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1iclB9-00069j-F9; Thu, 05 Dec 2019 09:04:00 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  5 Dec 2019 09:03:54 +0200
Message-Id: <20191205070354.231246-1-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH v5.5] iwlwifi: pcie: move power gating workaround earlier in the flow
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We need to reset the NIC after setting the bits to enable power
gating and that cannot be done too late in the flow otherwise it
cleans other registers and things that were already configured,
causing initialization to fail.

In order to fix this, move the function to the common code in trans.c
so it can be called directly from there at an earlier point, just
after the reset we already do during initialization.

Fixes: 9a47cb988338 ("iwlwifi: pcie: add workaround for power gating in integrated 22000")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205719
Cc: stable@ver.kernel.org # 5.4+
Reported-by: Anders Kaseorg <andersk@mit.edu>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 25 ----------------
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 30 +++++++++++++++++++
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
index 0252716c0b24..0d8b2a8ffa5d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans-gen2.c
@@ -57,24 +57,6 @@
 #include "internal.h"
 #include "fw/dbg.h"
 
-static int iwl_pcie_gen2_force_power_gating(struct iwl_trans *trans)
-{
-	iwl_set_bits_prph(trans, HPM_HIPM_GEN_CFG,
-			  HPM_HIPM_GEN_CFG_CR_FORCE_ACTIVE);
-	udelay(20);
-	iwl_set_bits_prph(trans, HPM_HIPM_GEN_CFG,
-			  HPM_HIPM_GEN_CFG_CR_PG_EN |
-			  HPM_HIPM_GEN_CFG_CR_SLP_EN);
-	udelay(20);
-	iwl_clear_bits_prph(trans, HPM_HIPM_GEN_CFG,
-			    HPM_HIPM_GEN_CFG_CR_FORCE_ACTIVE);
-
-	iwl_trans_sw_reset(trans);
-	iwl_clear_bit(trans, CSR_GP_CNTRL, CSR_GP_CNTRL_REG_FLAG_INIT_DONE);
-
-	return 0;
-}
-
 /*
  * Start up NIC's basic functionality after it has been reset
  * (e.g. after platform boot, or shutdown via iwl_pcie_apm_stop())
@@ -110,13 +92,6 @@ int iwl_pcie_gen2_apm_init(struct iwl_trans *trans)
 
 	iwl_pcie_apm_config(trans);
 
-	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22000 &&
-	    trans->cfg->integrated) {
-		ret = iwl_pcie_gen2_force_power_gating(trans);
-		if (ret)
-			return ret;
-	}
-
 	ret = iwl_finish_nic_init(trans, trans->trans_cfg);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index af9bc6b64542..a0677131634d 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1783,6 +1783,29 @@ static int iwl_trans_pcie_clear_persistence_bit(struct iwl_trans *trans)
 	return 0;
 }
 
+static int iwl_pcie_gen2_force_power_gating(struct iwl_trans *trans)
+{
+	int ret;
+
+	ret = iwl_finish_nic_init(trans, trans->trans_cfg);
+	if (ret < 0)
+		return ret;
+
+	iwl_set_bits_prph(trans, HPM_HIPM_GEN_CFG,
+			  HPM_HIPM_GEN_CFG_CR_FORCE_ACTIVE);
+	udelay(20);
+	iwl_set_bits_prph(trans, HPM_HIPM_GEN_CFG,
+			  HPM_HIPM_GEN_CFG_CR_PG_EN |
+			  HPM_HIPM_GEN_CFG_CR_SLP_EN);
+	udelay(20);
+	iwl_clear_bits_prph(trans, HPM_HIPM_GEN_CFG,
+			    HPM_HIPM_GEN_CFG_CR_FORCE_ACTIVE);
+
+	iwl_trans_pcie_sw_reset(trans);
+
+	return 0;
+}
+
 static int _iwl_trans_pcie_start_hw(struct iwl_trans *trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -1802,6 +1825,13 @@ static int _iwl_trans_pcie_start_hw(struct iwl_trans *trans)
 
 	iwl_trans_pcie_sw_reset(trans);
 
+	if (trans->trans_cfg->device_family == IWL_DEVICE_FAMILY_22000 &&
+	    trans->cfg->integrated) {
+		err = iwl_pcie_gen2_force_power_gating(trans);
+		if (err)
+			return err;
+	}
+
 	err = iwl_pcie_apm_init(trans);
 	if (err)
 		return err;
-- 
2.24.0

