Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7442C7960
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Nov 2020 14:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgK2NQ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Nov 2020 08:16:28 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:33462 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727073AbgK2NQ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Nov 2020 08:16:27 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1kjMXU-0035gF-Sh; Sun, 29 Nov 2020 15:14:53 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sun, 29 Nov 2020 15:14:41 +0200
Message-Id: <iwlwifi.20201129151117.e12fbd3f2b4e.Iff3879405c15758ba661c430e77dc2160ddada1c@changeid>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201129131442.1857561-1-luca@coelho.fi>
References: <20201129131442.1857561-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 11/12] iwlwifi: pcie: remove obsolete pre-release support code
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We no longer need code that was introduced to differentiate
between two early versions of 8260.

We can remove this convoluted way to get the hardware version
that was needed because of a bug in the register's
configuration.

Moreover, since we no longer need to access the PRPH
registers, we no longer need to wake up the device,
request ownership, etc...
Remove all that.

This allows us to get the rid of the obsolete comment
about the AUX bus MISC address space which should have
been moved when this code was moved away from here.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h  |  4 ----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c  | 16 ----------------
 .../net/wireless/intel/iwlwifi/pcie/trans.c    | 18 +-----------------
 3 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
index 4417fefe834e..6c44a49640be 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-prph.h
@@ -406,10 +406,6 @@ enum {
 #define CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM		0xA29890
 #define CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR	0xA29938
 
-enum {
-	HW_STEP_LOCATION_BITS = 24,
-};
-
 #define PREG_AUX_BUS_WPROT_0		0xA04CC0
 
 /* device family 9000 WPROT register */
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 129021f26791..86d2859374c8 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1000,7 +1000,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	const struct iwl_cfg *cfg_7265d __maybe_unused = NULL;
 	struct iwl_trans *iwl_trans;
 	struct iwl_trans_pcie *trans_pcie;
-	unsigned long flags;
 	int i, ret;
 	/*
 	 * This is needed for backwards compatibility with the old
@@ -1130,21 +1129,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		trans_pcie->num_rx_bufs = RX_QUEUE_SIZE;
 	}
 
-	if (iwl_trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_8000 &&
-	    iwl_trans_grab_nic_access(iwl_trans, &flags)) {
-		u32 hw_step;
-
-		hw_step = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_CTRL_REG);
-		hw_step |= ENABLE_WFPM;
-		iwl_write_umac_prph_no_grab(iwl_trans, WFPM_CTRL_REG, hw_step);
-		hw_step = iwl_read_prph_no_grab(iwl_trans, CNVI_AUX_MISC_CHIP);
-		hw_step = (hw_step >> HW_STEP_LOCATION_BITS) & 0xF;
-		if (hw_step == 0x3)
-			iwl_trans->hw_rev = (iwl_trans->hw_rev & 0xFFFFFFF3) |
-				(SILICON_C_STEP << 2);
-		iwl_trans_release_nic_access(iwl_trans, &flags);
-	}
-
 	pci_set_drvdata(pdev, iwl_trans);
 	iwl_trans->drv = iwl_drv_start(iwl_trans);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index 32b87d18b766..9551f7a8c4bd 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -3518,26 +3518,10 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	 * "dash" value). To keep hw_rev backwards compatible - we'll store it
 	 * in the old format.
 	 */
-	if (cfg_trans->device_family >= IWL_DEVICE_FAMILY_8000) {
+	if (cfg_trans->device_family >= IWL_DEVICE_FAMILY_8000)
 		trans->hw_rev = (trans->hw_rev & 0xfff0) |
 				(CSR_HW_REV_STEP(trans->hw_rev << 2) << 2);
 
-		ret = iwl_pcie_prepare_card_hw(trans);
-		if (ret) {
-			IWL_WARN(trans, "Exit HW not ready\n");
-			goto out_no_pci;
-		}
-
-		/*
-		 * in-order to recognize C step driver should read chip version
-		 * id located at the AUX bus MISC address space.
-		 */
-		ret = iwl_finish_nic_init(trans, cfg_trans);
-		if (ret)
-			goto out_no_pci;
-
-	}
-
 	IWL_DEBUG_INFO(trans, "HW REV: 0x%0x\n", trans->hw_rev);
 
 	iwl_pcie_set_interrupt_capa(pdev, trans, cfg_trans);
-- 
2.29.2

