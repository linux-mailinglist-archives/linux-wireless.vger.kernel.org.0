Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F196C4682FE
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 07:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242060AbhLDGjp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 01:39:45 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:50338 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241903AbhLDGjo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 01:39:44 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mtOef-0017AH-DH; Sat, 04 Dec 2021 08:36:18 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat,  4 Dec 2021 08:35:55 +0200
Message-Id: <iwlwifi.20211204083238.c41548abd174.I6bb4f6058fd85e1dd92cd056b6eaca1cb4aa74a3@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204063555.769822-1-luca@coelho.fi>
References: <20211204063555.769822-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 12/12] iwlwifi: remove unused iwlax210_2ax_cfg_so_hr_a0 structure
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

We don't use this structure anymore, except for a check that will
never match, so we can remove this structure entirely.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c  |  7 -------
 drivers/net/wireless/intel/iwlwifi/iwl-config.h |  1 -
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c   | 15 ---------------
 3 files changed, 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index 7a06bbae178b..0467c1e9eeb3 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -699,13 +699,6 @@ const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0 = {
 	.num_rbds = IWL_NUM_RBDS_NON_HE,
 };
 
-const struct iwl_cfg iwlax210_2ax_cfg_so_hr_a0 = {
-	.name = "Intel(R) Wi-Fi 6 AX210 160MHz",
-	.fw_name_pre = IWL_SO_A_HR_B_FW_PRE,
-	IWL_DEVICE_AX210,
-	.num_rbds = IWL_NUM_RBDS_AX210_HE,
-};
-
 const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0 = {
 	.name = iwl_ax211_name,
 	.fw_name_pre = IWL_SO_A_GF_A_FW_PRE,
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-config.h b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
index d704e278b577..1ecde7c86368 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-config.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-config.h
@@ -610,7 +610,6 @@ extern const struct iwl_cfg killer1650x_2ax_cfg;
 extern const struct iwl_cfg killer1650w_2ax_cfg;
 extern const struct iwl_cfg iwl_qnj_b0_hr_b0_cfg;
 extern const struct iwl_cfg iwlax210_2ax_cfg_so_jf_b0;
-extern const struct iwl_cfg iwlax210_2ax_cfg_so_hr_a0;
 extern const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0;
 extern const struct iwl_cfg iwlax211_2ax_cfg_so_gf_a0_long;
 extern const struct iwl_cfg iwlax210_2ax_cfg_ty_gf_a0;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 93d789670f89..89f0390963c9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1498,21 +1498,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	    (iwl_trans->hw_rev & CSR_HW_REV_TYPE_MSK) == CSR_HW_REV_TYPE_7265D)
 		iwl_trans->cfg = cfg_7265d;
 
-	if (cfg == &iwlax210_2ax_cfg_so_hr_a0) {
-		if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_TY) {
-			iwl_trans->cfg = &iwlax210_2ax_cfg_ty_gf_a0;
-		} else if (CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id) ==
-			   CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_JF)) {
-			iwl_trans->cfg = &iwlax210_2ax_cfg_so_jf_b0;
-		} else if (CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id) ==
-			   CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_GF)) {
-			iwl_trans->cfg = &iwlax211_2ax_cfg_so_gf_a0;
-		} else if (CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id) ==
-			   CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_GF4)) {
-			iwl_trans->cfg = &iwlax411_2ax_cfg_so_gf4_a0;
-		}
-	}
-
 	/*
 	 * This is a hack to switch from Qu B0 to Qu C0.  We need to
 	 * do this for all cfgs that use Qu B0, except for those using
-- 
2.33.1

