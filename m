Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52E71B7C15
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 18:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgDXQr2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 12:47:28 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58016 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728634AbgDXQr2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 12:47:28 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jS1U4-000OcH-VQ; Fri, 24 Apr 2020 19:47:25 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 24 Apr 2020 19:47:03 +0300
Message-Id: <iwlwifi.20200424194456.30b6b4aae1c1.If5e583835c9f7f2771a50ba1b2f33bb85f25b383@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424164707.2715869-1-luca@coelho.fi>
References: <20200424164707.2715869-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 07/11] iwlwifi: pcie: remove mangling for iwl_ax101_cfg_qu_hr
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

All devices that use iwl_ax101_cfg_qu_hr are recognized via the device
info table, so the cfg will never be iwl_ax101_cfg_qu_hr.  Remove the
code that converts this into QuZ and Qu-C, since it's not needed
anymore.

Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 23 -------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 5c216fa6505c..4146526b1278 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1062,29 +1062,6 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_GF4)) {
 			iwl_trans->cfg = &iwlax411_2ax_cfg_so_gf4_a0;
 		}
-	} else if (cfg == &iwl_ax101_cfg_qu_hr) {
-		if ((CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
-		     CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR) &&
-		     iwl_trans->hw_rev == CSR_HW_REV_TYPE_QNJ_B0) ||
-		    (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
-		     CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR1))) {
-			iwl_trans->cfg = &iwl22000_2ax_cfg_qnj_hr_b0;
-		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
-		    CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR) &&
-		    iwl_trans->hw_rev == CSR_HW_REV_TYPE_QUZ) {
-			iwl_trans->cfg = &iwl_ax101_cfg_quz_hr;
-		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
-			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HR)) {
-			iwl_trans->cfg = &iwl_ax101_cfg_qu_hr;
-		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
-			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_HRCDB)) {
-			IWL_ERR(iwl_trans, "RF ID HRCDB is not supported\n");
-			return -EINVAL;
-		} else {
-			IWL_ERR(iwl_trans, "Unrecognized RF ID 0x%08x\n",
-				CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id));
-			return -EINVAL;
-		}
 	}
 
 	/*
-- 
2.26.2

