Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4853035B2DE
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 11:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235366AbhDKJr3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 05:47:29 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44444 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S235319AbhDKJqz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 05:46:55 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1lVWfr-000Jkq-Ct; Sun, 11 Apr 2021 12:46:37 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Sun, 11 Apr 2021 12:46:23 +0300
Message-Id: <iwlwifi.20210411124417.179fee442115.Ib6eabe86cfda0b6044f07c07448c366b6e07e53d@changeid>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210411094630.431873-1-luca@coelho.fi>
References: <20210411094630.431873-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 05/12] iwlwifi: mvm: umac error table mismatch
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Roee Goldfiner <roee.h.goldfiner@intel.com>

umac_error_table In TLV address was read using mask on MSB
but on the same table in alive message it was without which
caused mismatch in devices with different memory region MSB

Signed-off-by: Roee Goldfiner <roee.h.goldfiner@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/img.h  | 5 ++++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c | 4 +---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c  | 5 +++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/img.h b/drivers/net/wireless/intel/iwlwifi/fw/img.h
index 1dee4714e505..153a3529e77a 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/img.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/img.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2005-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
@@ -116,6 +116,9 @@ struct fw_img {
 #define PAGING_CMD_NUM_OF_PAGES_IN_LAST_GRP_POS	0
 #define PAGING_TLV_SECURE_MASK 1
 
+/* FW MSB Mask for regions/cache_control */
+#define FW_ADDR_CACHE_CONTROL 0xC0000000UL
+
 /**
  * struct iwl_fw_paging
  * @fw_paging_phys: page phy pointer
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index eb168dc535d4..884750bf7840 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2005-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -550,8 +550,6 @@ static int iwl_parse_v1_v2_firmware(struct iwl_drv *drv,
 	return 0;
 }
 
-#define FW_ADDR_CACHE_CONTROL 0xC0000000
-
 static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 				const struct firmware *ucode_raw,
 				struct iwl_firmware_pieces *pieces,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index be831dd2c05c..9a3981f43050 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2012-2014, 2018-2020 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2021 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -186,7 +186,8 @@ static bool iwl_alive_fn(struct iwl_notif_wait_data *notif_wait,
 		mvm->trans->dbg.lmac_error_event_table[1] =
 			le32_to_cpu(lmac2->dbg_ptrs.error_event_table_ptr);
 
-	umac_error_table = le32_to_cpu(umac->dbg_ptrs.error_info_addr);
+	umac_error_table = le32_to_cpu(umac->dbg_ptrs.error_info_addr) &
+							~FW_ADDR_CACHE_CONTROL;
 
 	if (umac_error_table) {
 		if (umac_error_table >=
-- 
2.31.0

