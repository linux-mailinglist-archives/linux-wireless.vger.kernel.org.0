Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 033A02DEA1
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 15:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfE2NkF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 09:40:05 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54352 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727097AbfE2NkE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 09:40:04 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hVyoE-00080o-GI; Wed, 29 May 2019 16:40:02 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Shahar S Matityahu <shahar.s.matityahu@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 3/7] iwlwifi: clear persistence bit according to device family
Date:   Wed, 29 May 2019 16:39:51 +0300
Message-Id: <20190529133955.31082-4-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133955.31082-1-luca@coelho.fi>
References: <20190529133955.31082-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shahar S Matityahu <shahar.s.matityahu@intel.com>

The driver attempts to clear persistence bit on any device familiy even
though only 9000 and 22000 families require it. Clear the bit only on
the relevant device families.

Each HW has different address to the write protection register. Use the
right register for each HW

Signed-off-by: Shahar S Matityahu <shahar.s.matityahu@intel.com>
Fixes: 8954e1eb2270 ("iwlwifi: trans: Clear persistence bit when starting the FW")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |  7 ++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 46 +++++++++++++------
 2 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 8e6a0c363c0d..925f308764bf 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -408,7 +408,12 @@ enum aux_misc_master1_en {
 #define AUX_MISC_MASTER1_SMPHR_STATUS	0xA20800
 #define RSA_ENABLE			0xA24B08
 #define PREG_AUX_BUS_WPROT_0		0xA04CC0
-#define PREG_PRPH_WPROT_0		0xA04CE0
+
+/* device family 9000 WPROT register */
+#define PREG_PRPH_WPROT_9000		0xA04CE0
+/* device family 22000 WPROT register */
+#define PREG_PRPH_WPROT_22000		0xA04D00
+
 #define SB_CPU_1_STATUS			0xA01E30
 #define SB_CPU_2_STATUS			0xA01E34
 #define UMAG_SB_CPU_1_STATUS		0xA038C0
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 803fcbac4152..e9d1075d91db 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1698,26 +1698,26 @@ static int iwl_pcie_init_msix_handler(struct pci_dev *pdev,
 	return 0;
 }
 
-static int _iwl_trans_pcie_start_hw(struct iwl_trans *trans, bool low_power)
+static int iwl_trans_pcie_clear_persistence_bit(struct iwl_trans *trans)
 {
-	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
-	u32 hpm;
-	int err;
-
-	lockdep_assert_held(&trans_pcie->mutex);
+	u32 hpm, wprot;
 
-	err = iwl_pcie_prepare_card_hw(trans);
-	if (err) {
-		IWL_ERR(trans, "Error while preparing HW: %d\n", err);
-		return err;
+	switch (trans->cfg->device_family) {
+	case IWL_DEVICE_FAMILY_9000:
+		wprot = PREG_PRPH_WPROT_9000;
+		break;
+	case IWL_DEVICE_FAMILY_22000:
+		wprot = PREG_PRPH_WPROT_22000;
+		break;
+	default:
+		return 0;
 	}
 
 	hpm = iwl_read_umac_prph_no_grab(trans, HPM_DEBUG);
 	if (hpm != 0xa5a5a5a0 && (hpm & PERSISTENCE_BIT)) {
-		int wfpm_val = iwl_read_umac_prph_no_grab(trans,
-							  PREG_PRPH_WPROT_0);
+		u32 wprot_val = iwl_read_umac_prph_no_grab(trans, wprot);
 
-		if (wfpm_val & PREG_WFPM_ACCESS) {
+		if (wprot_val & PREG_WFPM_ACCESS) {
 			IWL_ERR(trans,
 				"Error, can not clear persistence bit\n");
 			return -EPERM;
@@ -1726,6 +1726,26 @@ static int _iwl_trans_pcie_start_hw(struct iwl_trans *trans, bool low_power)
 					    hpm & ~PERSISTENCE_BIT);
 	}
 
+	return 0;
+}
+
+static int _iwl_trans_pcie_start_hw(struct iwl_trans *trans, bool low_power)
+{
+	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
+	int err;
+
+	lockdep_assert_held(&trans_pcie->mutex);
+
+	err = iwl_pcie_prepare_card_hw(trans);
+	if (err) {
+		IWL_ERR(trans, "Error while preparing HW: %d\n", err);
+		return err;
+	}
+
+	err = iwl_trans_pcie_clear_persistence_bit(trans);
+	if (err)
+		return err;
+
 	iwl_trans_pcie_sw_reset(trans);
 
 	err = iwl_pcie_apm_init(trans);
-- 
2.20.1

