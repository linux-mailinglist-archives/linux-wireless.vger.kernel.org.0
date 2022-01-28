Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBFC049F9CF
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jan 2022 13:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348577AbiA1Ms5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jan 2022 07:48:57 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37838 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348480AbiA1Ms4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jan 2022 07:48:56 -0500
Received: from 91-155-254-253.elisa-laajakaista.fi ([91.155.254.253] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nDQgQ-0002Bq-H8;
        Fri, 28 Jan 2022 14:48:55 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 28 Jan 2022 14:48:51 +0200
Message-Id: <iwlwifi.20220128144623.96f683a89b42.I14e2985bfd7ddd8a8d83eb1869b800c0e7f30db4@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128124851.538580-1-luca@coelho.fi>
References: <20220128124851.538580-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH for v5.17 2/2] iwlwifi: mvm: don't send SAR GEO command for 3160 devices
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

SAR GEO offsets are not supported on 3160 devices.  The code was
refactored and caused us to start sending the command anyway, which
causes a FW assertion failure.  Fix that only considering this feature
supported on FW API with major version is 17 if the device is not
3160.

Additionally, fix the caller of iwl_mvm_sar_geo_init() so that it
checks for the return value, which it was ignoring.

Reported-by: Len Brown <lenb@kernel.org>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Fixes: 78a19d5285d9 ("iwlwifi: mvm: Read the PPAG and SAR tables at INIT stage")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c | 11 ++++++-----
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h |  3 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  |  2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
index 790c96df58cb..c17ab53fcd8f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/acpi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
  * Copyright (C) 2017 Intel Deutschland GmbH
- * Copyright (C) 2019-2021 Intel Corporation
+ * Copyright (C) 2019-2022 Intel Corporation
  */
 #include <linux/uuid.h>
 #include "iwl-drv.h"
@@ -888,10 +888,11 @@ bool iwl_sar_geo_support(struct iwl_fw_runtime *fwrt)
 	 * only one using version 36, so skip this version entirely.
 	 */
 	return IWL_UCODE_SERIAL(fwrt->fw->ucode_ver) >= 38 ||
-	       IWL_UCODE_SERIAL(fwrt->fw->ucode_ver) == 17 ||
-	       (IWL_UCODE_SERIAL(fwrt->fw->ucode_ver) == 29 &&
-		((fwrt->trans->hw_rev & CSR_HW_REV_TYPE_MSK) ==
-		 CSR_HW_REV_TYPE_7265D));
+		(IWL_UCODE_SERIAL(fwrt->fw->ucode_ver) == 17 &&
+		 fwrt->trans->hw_rev != CSR_HW_REV_TYPE_3160) ||
+		(IWL_UCODE_SERIAL(fwrt->fw->ucode_ver) == 29 &&
+		 ((fwrt->trans->hw_rev & CSR_HW_REV_TYPE_MSK) ==
+		  CSR_HW_REV_TYPE_7265D));
 }
 IWL_EXPORT_SYMBOL(iwl_sar_geo_support);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
index f90d4662c164..8e10ba88afb3 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-csr.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2022 Intel Corporation
  * Copyright (C) 2013-2014 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -329,6 +329,7 @@ enum {
 #define CSR_HW_REV_TYPE_2x00		(0x0000100)
 #define CSR_HW_REV_TYPE_105		(0x0000110)
 #define CSR_HW_REV_TYPE_135		(0x0000120)
+#define CSR_HW_REV_TYPE_3160		(0x0000164)
 #define CSR_HW_REV_TYPE_7265D		(0x0000210)
 #define CSR_HW_REV_TYPE_NONE		(0x00001F0)
 #define CSR_HW_REV_TYPE_QNJ		(0x0000360)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 6f4690e56a46..ae589b3b8c46 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1741,7 +1741,7 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	ret = iwl_mvm_sar_init(mvm);
 	if (ret == 0)
 		ret = iwl_mvm_sar_geo_init(mvm);
-	else if (ret < 0)
+	if (ret < 0)
 		goto error;
 
 	ret = iwl_mvm_sgom_init(mvm);
-- 
2.34.1

