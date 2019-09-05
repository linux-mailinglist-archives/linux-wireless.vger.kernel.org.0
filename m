Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A382AA43E
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 15:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388762AbfIENWf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 09:22:35 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:41076 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388593AbfIENWe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 09:22:34 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1i5ria-00062D-PR; Thu, 05 Sep 2019 16:22:33 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Thu,  5 Sep 2019 16:22:03 +0300
Message-Id: <20190905132220.23970-5-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190905132220.23970-1-luca@coelho.fi>
References: <20190905132220.23970-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v2 04/21] iwlwifi: pcie: set iwl_trans->cfg later in the probe function
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

Instead of setting the cfg to iwl_trans already during allocation, set
it only later when we have had the time to decide which cfg to use.
This is part of the effort to be able to decide the cfg based on HW
revision and RF ID after iwl_trans_alloc() has been called.

For now, since we still have a bunch of code checking the HW revision
and the RF ID, we set iwl_trans->cfg early, even before we decided the
real cfg to use.  We only use the trans configuration at this point,
so this is fine for now.  In the future, the trans configuration will
be completely independent from the rest of the config structure, so
we'll be able to avoid this.

Additionally, we can't access the PRPH registers in iwl_trans_alloc()
anymore, so move the HW REV C-step check for family 8000 code later to
the probe function as well.  This step is probably not necessary, but
if that's the case it should be removed separately later on.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  2 --
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  1 -
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 28 ++++++++++++++++
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 33 +++++--------------
 4 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index d47ba334c7ac..28bdc9a9617e 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -66,7 +66,6 @@
 
 struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 				  struct device *dev,
-				  const struct iwl_cfg *cfg,
 				  const struct iwl_trans_ops *ops)
 {
 	struct iwl_trans *trans;
@@ -84,7 +83,6 @@ struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 #endif
 
 	trans->dev = dev;
-	trans->cfg = cfg;
 	trans->ops = ops;
 	trans->num_rx_queues = 1;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index 09ed0dd163eb..1b9bf9f94367 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1240,7 +1240,6 @@ static inline bool iwl_trans_dbg_ini_valid(struct iwl_trans *trans)
  *****************************************************/
 struct iwl_trans *iwl_trans_alloc(unsigned int priv_size,
 				  struct device *dev,
-				  const struct iwl_cfg *cfg,
 				  const struct iwl_trans_ops *ops);
 void iwl_trans_free(struct iwl_trans *trans);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 7177061f79ae..31c5e020bf25 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -994,6 +994,7 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	const struct iwl_cfg *cfg = (struct iwl_cfg *)(ent->driver_data);
 	const struct iwl_cfg *cfg_7265d __maybe_unused = NULL;
 	struct iwl_trans *iwl_trans;
+	unsigned long flags;
 	int ret;
 
 	if (WARN_ONCE(!cfg->trans.csr, "CSR addresses aren't configured\n"))
@@ -1023,6 +1024,18 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	iwl_trans->hw_rf_id = iwl_read32(iwl_trans, CSR_HW_RF_ID);
 
+	/*
+	 * We can already set the cfg to iwl_trans here, because the
+	 * only part we use at this point is the cfg_trans
+	 * information.  Once we decide the real cfg, we set it again
+	 * (happens later in this function).  TODO: this is only
+	 * temporary, while we're sorting out this whole thing, but in
+	 * the future it won't be necessary, because we will separate
+	 * the trans configuration entirely from the rest of the
+	 * config struct.
+	 */
+	iwl_trans->cfg = cfg;
+
 	if (cfg == &iwlax210_2ax_cfg_so_hr_a0) {
 		if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_TY) {
 			cfg = &iwlax210_2ax_cfg_ty_gf_a0;
@@ -1112,6 +1125,21 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* now set the real cfg we decided to use */
 	iwl_trans->cfg = cfg;
 
+	if (cfg->trans.device_family >= IWL_DEVICE_FAMILY_8000 &&
+	    iwl_trans_grab_nic_access(iwl_trans, &flags)) {
+		u32 hw_step;
+
+		hw_step = iwl_read_umac_prph_no_grab(iwl_trans, WFPM_CTRL_REG);
+		hw_step |= ENABLE_WFPM;
+		iwl_write_umac_prph_no_grab(iwl_trans, WFPM_CTRL_REG, hw_step);
+		hw_step = iwl_read_prph_no_grab(iwl_trans, CNVI_AUX_MISC_CHIP);
+		hw_step = (hw_step >> HW_STEP_LOCATION_BITS) & 0xF;
+		if (hw_step == 0x3)
+			iwl_trans->hw_rev = (iwl_trans->hw_rev & 0xFFFFFFF3) |
+				(SILICON_C_STEP << 2);
+		iwl_trans_release_nic_access(iwl_trans, &flags);
+	}
+
 	pci_set_drvdata(pdev, iwl_trans);
 	iwl_trans->drv = iwl_drv_start(iwl_trans);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index a1863b9bf1f6..c602e4914424 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -1578,14 +1578,16 @@ static int iwl_trans_pcie_d3_resume(struct iwl_trans *trans,
 	return 0;
 }
 
-static void iwl_pcie_set_interrupt_capa(struct pci_dev *pdev,
-					struct iwl_trans *trans)
+static void
+iwl_pcie_set_interrupt_capa(struct pci_dev *pdev,
+			    struct iwl_trans *trans,
+			    const struct iwl_cfg_trans_params *cfg_trans)
 {
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
 	int max_irqs, num_irqs, i, ret;
 	u16 pci_cmd;
 
-	if (!trans->cfg->trans.mq_rx_supported)
+	if (!cfg_trans->mq_rx_supported)
 		goto enable_msi;
 
 	max_irqs = min_t(u32, num_online_cpus() + 2, IWL_MAX_RX_HW_QUEUES);
@@ -3384,10 +3386,11 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 
 	if (cfg->trans.gen2)
 		trans = iwl_trans_alloc(sizeof(struct iwl_trans_pcie),
-					&pdev->dev, cfg, &trans_ops_pcie_gen2);
+					&pdev->dev, &trans_ops_pcie_gen2);
 	else
 		trans = iwl_trans_alloc(sizeof(struct iwl_trans_pcie),
-					&pdev->dev, cfg, &trans_ops_pcie);
+					&pdev->dev, &trans_ops_pcie);
+
 	if (!trans)
 		return ERR_PTR(-ENOMEM);
 
@@ -3482,8 +3485,6 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 	 * in the old format.
 	 */
 	if (cfg->trans.device_family >= IWL_DEVICE_FAMILY_8000) {
-		unsigned long flags;
-
 		trans->hw_rev = (trans->hw_rev & 0xfff0) |
 				(CSR_HW_REV_STEP(trans->hw_rev << 2) << 2);
 
@@ -3501,27 +3502,11 @@ struct iwl_trans *iwl_trans_pcie_alloc(struct pci_dev *pdev,
 		if (ret)
 			goto out_no_pci;
 
-		if (iwl_trans_grab_nic_access(trans, &flags)) {
-			u32 hw_step;
-
-			hw_step = iwl_read_umac_prph_no_grab(trans,
-							     WFPM_CTRL_REG);
-			hw_step |= ENABLE_WFPM;
-			iwl_write_umac_prph_no_grab(trans, WFPM_CTRL_REG,
-						    hw_step);
-			hw_step = iwl_read_prph_no_grab(trans,
-							CNVI_AUX_MISC_CHIP);
-			hw_step = (hw_step >> HW_STEP_LOCATION_BITS) & 0xF;
-			if (hw_step == 0x3)
-				trans->hw_rev = (trans->hw_rev & 0xFFFFFFF3) |
-						(SILICON_C_STEP << 2);
-			iwl_trans_release_nic_access(trans, &flags);
-		}
 	}
 
 	IWL_DEBUG_INFO(trans, "HW REV: 0x%0x\n", trans->hw_rev);
 
-	iwl_pcie_set_interrupt_capa(pdev, trans);
+	iwl_pcie_set_interrupt_capa(pdev, trans, &cfg->trans);
 	trans->hw_id = (pdev->device << 16) + pdev->subsystem_device;
 	snprintf(trans->hw_id_str, sizeof(trans->hw_id_str),
 		 "PCI ID: 0x%04X:0x%04X", pdev->device, pdev->subsystem_device);
-- 
2.23.0.rc1

