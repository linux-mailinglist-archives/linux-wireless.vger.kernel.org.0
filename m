Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24BC1B8586
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 12:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbgDYKFU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Apr 2020 06:05:20 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:58274 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726359AbgDYKFU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Apr 2020 06:05:20 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jSHgT-000P3t-GZ; Sat, 25 Apr 2020 13:05:18 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 25 Apr 2020 13:04:59 +0300
Message-Id: <iwlwifi.20200425130140.330ea11d17ae.Ie59b25430a308090b15112ac6deedf4fbf487ff1@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200425100459.2778317-1-luca@coelho.fi>
References: <20200425100459.2778317-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 11/11] iwlwifi: dbg_ini: differentiate ax210 hw with same hw type
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Liad Kaufman <liad.kaufman@intel.com>

There are several "flavors" of HW that have the same HW type, but
can be told apart after reading a certain perph register. This
is easy to do in runtime, but more complicated to do when looking
at the logs offline.

To make it easier to tell apart these "flavors" when looking at
the dumped dbg info, add these bits to the HW type, allowing
simple differentiation.

Signed-off-by: Liad Kaufman <liad.kaufman@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 22 ++++++++++++++++++-
 .../wireless/intel/iwlwifi/fw/error-dump.h    | 13 +++++++++--
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 2a271aad8106..4d3687cc83a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -1958,6 +1958,7 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 	struct iwl_fw_ini_dump_cfg_name *cfg_name;
 	u32 size = sizeof(*tlv) + sizeof(*dump);
 	u32 num_of_cfg_names = 0;
+	u32 hw_type;
 
 	list_for_each_entry(node, &fwrt->trans->dbg.debug_info_tlv_list, list) {
 		size += sizeof(*cfg_name);
@@ -1986,7 +1987,26 @@ static u32 iwl_dump_ini_info(struct iwl_fw_runtime *fwrt,
 	dump->ver_subtype = cpu_to_le32(fwrt->dump.fw_ver.subtype);
 
 	dump->hw_step = cpu_to_le32(CSR_HW_REV_STEP(fwrt->trans->hw_rev));
-	dump->hw_type = cpu_to_le32(CSR_HW_REV_TYPE(fwrt->trans->hw_rev));
+
+	/*
+	 * Several HWs all have type == 0x42, so we'll override this value
+	 * according to the detected HW
+	 */
+	hw_type = CSR_HW_REV_TYPE(fwrt->trans->hw_rev);
+	if (hw_type == IWL_AX210_HW_TYPE) {
+		u32 prph_val = iwl_read_prph(fwrt->trans, WFPM_OTP_CFG1_ADDR);
+		u32 is_jacket = !!(prph_val & WFPM_OTP_CFG1_IS_JACKET_BIT);
+		u32 is_cdb = !!(prph_val & WFPM_OTP_CFG1_IS_CDB_BIT);
+		u32 masked_bits = is_jacket | (is_cdb << 1);
+
+		/*
+		 * The HW type depends on certain bits in this case, so add
+		 * these bits to the HW type. We won't have collisions since we
+		 * add these bits after the highest possible bit in the mask.
+		 */
+		hw_type |= masked_bits << IWL_AX210_HW_TYPE_ADDITION_SHIFT;
+	}
+	dump->hw_type = cpu_to_le32(hw_type);
 
 	dump->rf_id_flavor =
 		cpu_to_le32(CSR_HW_RFID_FLAVOR(fwrt->trans->hw_rf_id));
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
index f008e1bbfdf4..72bfc64580ab 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/error-dump.h
@@ -8,7 +8,7 @@
  * Copyright(c) 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2014 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2018 - 2020 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2014 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2018 - 2020 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -394,6 +394,15 @@ struct iwl_fw_ini_dump_cfg_name {
 	u8 cfg_name[IWL_FW_INI_MAX_CFG_NAME];
 } __packed;
 
+/* AX210's HW type */
+#define IWL_AX210_HW_TYPE 0x42
+/* How many bits to roll when adding to the HW type of AX210 HW */
+#define IWL_AX210_HW_TYPE_ADDITION_SHIFT 12
+/* This prph is used to tell apart HW_TYPE == 0x42 NICs */
+#define WFPM_OTP_CFG1_ADDR 0xd03098
+#define WFPM_OTP_CFG1_IS_JACKET_BIT BIT(4)
+#define WFPM_OTP_CFG1_IS_CDB_BIT BIT(5)
+
 /* struct iwl_fw_ini_dump_info - ini dump information
  * @version: dump version
  * @time_point: time point that caused the dump collection
-- 
2.26.2

