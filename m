Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661F94A97B5
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Feb 2022 11:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236026AbiBDKZ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Feb 2022 05:25:27 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:37970 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1358282AbiBDKZZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Feb 2022 05:25:25 -0500
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nFvmM-0005zM-Ti;
        Fri, 04 Feb 2022 12:25:23 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri,  4 Feb 2022 12:25:08 +0200
Message-Id: <iwlwifi.20220204122220.068c6052689b.Idbb7a87c2fd93619c1765c7f4ed15190c3fef2a7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204102511.606112-1-luca@coelho.fi>
References: <20220204102511.606112-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 09/12] iwlwifi: remove unused macros
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Found with W=2, remove unused macros in C files. In one case
move the macro under the corresponding ifdef.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/cfg/22000.c   | 2 --
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c      | 3 ---
 drivers/net/wireless/intel/iwlwifi/iwl-phy-db.c  | 4 +---
 drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c | 2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c      | 2 --
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c      | 2 --
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c    | 1 -
 7 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
index c7bda7246f0d..1fa29a35273d 100644
--- a/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/22000.c
@@ -121,8 +121,6 @@
 		IWL_BZ_A_FM_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_GL_A_FM_A_MODULE_FIRMWARE(api) \
 		IWL_GL_A_FM_A_FW_PRE __stringify(api) ".ucode"
-#define IWL_BZ_Z_GF_A_MODULE_FIRMWARE(api) \
-	IWL_BZ_Z_GF_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_A_FM_A_MODULE_FIRMWARE(api) \
 	IWL_BNJ_A_FM_A_FW_PRE __stringify(api) ".ucode"
 #define IWL_BNJ_A_FM4_A_MODULE_FIRMWARE(api) \
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 0a5d860e489e..238ba4384cd1 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -303,9 +303,6 @@ static void iwl_fw_dump_txf(struct iwl_fw_runtime *fwrt,
 	iwl_trans_release_nic_access(fwrt->trans);
 }
 
-#define IWL8260_ICCM_OFFSET		0x44000 /* Only for B-step */
-#define IWL8260_ICCM_LEN		0xC000 /* Only for B-step */
-
 struct iwl_prph_range {
 	u32 start, end;
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-phy-db.c b/drivers/net/wireless/intel/iwlwifi/iwl-phy-db.c
index 5378315d0179..0a93ac769f66 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-phy-db.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-phy-db.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2005-2014, 2020 Intel Corporation
+ * Copyright (C) 2005-2014, 2020-2021 Intel Corporation
  * Copyright (C) 2016 Intel Deutschland GmbH
  */
 #include <linux/slab.h>
@@ -13,8 +13,6 @@
 #include "iwl-op-mode.h"
 #include "iwl-trans.h"
 
-#define CHANNEL_NUM_SIZE	4	/* num of channels in calib_ch size */
-
 struct iwl_phy_db_entry {
 	u16	size;
 	u8	*data;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index be11161bc57d..a90323e2075f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1369,8 +1369,8 @@ static ssize_t iwl_dbgfs_dbg_time_point_write(struct iwl_mvm *mvm,
 	return count;
 }
 
-#define ADD_TEXT(...) pos += scnprintf(buf + pos, bufsz - pos, __VA_ARGS__)
 #ifdef CONFIG_IWLWIFI_BCAST_FILTERING
+#define ADD_TEXT(...) pos += scnprintf(buf + pos, bufsz - pos, __VA_ARGS__)
 static ssize_t iwl_dbgfs_bcast_filters_read(struct file *file,
 					    char __user *user_buf,
 					    size_t count, loff_t *ppos)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 14e067c834e8..1e78599b63e3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -25,8 +25,6 @@
 #define MVM_UCODE_ALIVE_TIMEOUT	(HZ)
 #define MVM_UCODE_CALIB_TIMEOUT	(2 * HZ)
 
-#define UCODE_VALID_OK	cpu_to_le32(0x1)
-
 #define IWL_PPAG_MASK 3
 #define IWL_PPAG_ETSI_MASK BIT(0)
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
index f4d02f9fe16d..62114616317c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rs.c
@@ -454,8 +454,6 @@ static const u16 expected_tpt_mimo2_160MHz[4][IWL_RATE_COUNT] = {
 	{0, 0, 0, 0, 971, 0, 1925, 2861, 3779, 5574, 7304, 8147, 8976, 10592, 11640},
 };
 
-#define MCS_INDEX_PER_STREAM	(8)
-
 static const char *rs_pretty_lq_type(enum iwl_table_type type)
 {
 	static const char * const lq_types[] = {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 901df916baa4..9377549b1af5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -20,7 +20,6 @@
 #define IWL_SCAN_DWELL_FRAGMENTED	44
 #define IWL_SCAN_DWELL_EXTENDED		90
 #define IWL_SCAN_NUM_OF_FRAGS		3
-#define IWL_SCAN_LAST_2_4_CHN		14
 
 /* adaptive dwell max budget time [TU] for full scan */
 #define IWL_SCAN_ADWELL_MAX_BUDGET_FULL_SCAN 300
-- 
2.34.1

