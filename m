Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68053A4E64
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jun 2021 13:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhFLLfV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Jun 2021 07:35:21 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:47640 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231276AbhFLLfV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Jun 2021 07:35:21 -0400
Received: from [192.130.48.226] (helo=kveik.superpark.guest)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1ls1sj-001V8i-K9; Sat, 12 Jun 2021 14:32:55 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sat, 12 Jun 2021 14:32:43 +0300
Message-Id: <iwlwifi.20210612142637.00b220f4ba53.I1fe216a46e7d9c1316d681daa293064f16ff1899@changeid>
X-Mailer: git-send-email 2.32.0.rc2
In-Reply-To: <20210612113245.691117-1-luca@coelho.fi>
References: <20210612113245.691117-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 10/12] iwlwifi: pcie: remove CSR_HW_RF_ID_TYPE_CHIP_ID
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This is duplicated with CSR_HW_RFID_TYPE so just use the latter
for less typing/shorter lines.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |  5 +----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 12 ++++++------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index db312abd2e09..47e5a17c0f48 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -325,9 +325,6 @@ enum {
 #define CSR_HW_RF_ID_TYPE_GF		(0x0010D000)
 #define CSR_HW_RF_ID_TYPE_GF4		(0x0010E000)
 
-/* HW_RF CHIP ID  */
-#define CSR_HW_RF_ID_TYPE_CHIP_ID(_val) (((_val) >> 12) & 0xFFF)
-
 /* HW_RF CHIP STEP  */
 #define CSR_HW_RF_STEP(_val) (((_val) >> 8) & 0xF)
 
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 821dc6894155..d7106a51e8bf 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1235,14 +1235,14 @@ static int iwl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (cfg == &iwlax210_2ax_cfg_so_hr_a0) {
 		if (iwl_trans->hw_rev == CSR_HW_REV_TYPE_TY) {
 			iwl_trans->cfg = &iwlax210_2ax_cfg_ty_gf_a0;
-		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
-			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_JF)) {
+		} else if (CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id) ==
+			   CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_JF)) {
 			iwl_trans->cfg = &iwlax210_2ax_cfg_so_jf_b0;
-		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
-			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_GF)) {
+		} else if (CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id) ==
+			   CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_GF)) {
 			iwl_trans->cfg = &iwlax211_2ax_cfg_so_gf_a0;
-		} else if (CSR_HW_RF_ID_TYPE_CHIP_ID(iwl_trans->hw_rf_id) ==
-			   CSR_HW_RF_ID_TYPE_CHIP_ID(CSR_HW_RF_ID_TYPE_GF4)) {
+		} else if (CSR_HW_RFID_TYPE(iwl_trans->hw_rf_id) ==
+			   CSR_HW_RFID_TYPE(CSR_HW_RF_ID_TYPE_GF4)) {
 			iwl_trans->cfg = &iwlax411_2ax_cfg_so_gf4_a0;
 		}
 	}
-- 
2.32.0.rc2

