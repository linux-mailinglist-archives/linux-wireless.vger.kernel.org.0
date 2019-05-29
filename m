Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19B862DE9F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 15:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfE2NkE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 09:40:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54342 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726828AbfE2NkE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 09:40:04 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hVyoD-00080o-Gn; Wed, 29 May 2019 16:40:01 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 1/7] iwlwifi: mvm: remove d3_sram debugfs file
Date:   Wed, 29 May 2019 16:39:49 +0300
Message-Id: <20190529133955.31082-2-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190529133955.31082-1-luca@coelho.fi>
References: <20190529133955.31082-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This debugfs file is really old, and cannot work properly since
the unified image support. Rather than trying to make it work,
which is difficult now due to multiple images (LMAC/UMAC etc.)
just remove it - we no longer need it since we properly do a FW
coredump even in D3 cases.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 22 -------
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 57 -------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 -
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  3 -
 4 files changed, 84 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 60f5d337f16d..e7e68fb2bd29 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1972,26 +1972,6 @@ static void iwl_mvm_query_netdetect_reasons(struct iwl_mvm *mvm,
 	}
 }
 
-static void iwl_mvm_read_d3_sram(struct iwl_mvm *mvm)
-{
-#ifdef CONFIG_IWLWIFI_DEBUGFS
-	const struct fw_img *img = &mvm->fw->img[IWL_UCODE_WOWLAN];
-	u32 len = img->sec[IWL_UCODE_SECTION_DATA].len;
-	u32 offs = img->sec[IWL_UCODE_SECTION_DATA].offset;
-
-	if (!mvm->store_d3_resume_sram)
-		return;
-
-	if (!mvm->d3_resume_sram) {
-		mvm->d3_resume_sram = kzalloc(len, GFP_KERNEL);
-		if (!mvm->d3_resume_sram)
-			return;
-	}
-
-	iwl_trans_read_mem_bytes(mvm->trans, offs, mvm->d3_resume_sram, len);
-#endif
-}
-
 static void iwl_mvm_d3_disconnect_iter(void *data, u8 *mac,
 				       struct ieee80211_vif *vif)
 {
@@ -2054,8 +2034,6 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 	}
 
 	iwl_fw_dbg_read_d3_debug_data(&mvm->fwrt);
-	/* query SRAM first in case we want event logging */
-	iwl_mvm_read_d3_sram(mvm);
 
 	if (iwl_mvm_check_rt_status(mvm, vif)) {
 		set_bit(STATUS_FW_ERROR, &mvm->trans->status);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index d4ff6b44de2c..5b1bb76c5d28 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1557,59 +1557,6 @@ static ssize_t iwl_dbgfs_bcast_filters_macs_write(struct iwl_mvm *mvm,
 }
 #endif
 
-#ifdef CONFIG_PM_SLEEP
-static ssize_t iwl_dbgfs_d3_sram_write(struct iwl_mvm *mvm, char *buf,
-				       size_t count, loff_t *ppos)
-{
-	int store;
-
-	if (sscanf(buf, "%d", &store) != 1)
-		return -EINVAL;
-
-	mvm->store_d3_resume_sram = store;
-
-	return count;
-}
-
-static ssize_t iwl_dbgfs_d3_sram_read(struct file *file, char __user *user_buf,
-				      size_t count, loff_t *ppos)
-{
-	struct iwl_mvm *mvm = file->private_data;
-	const struct fw_img *img;
-	int ofs, len, pos = 0;
-	size_t bufsz, ret;
-	char *buf;
-	u8 *ptr = mvm->d3_resume_sram;
-
-	img = &mvm->fw->img[IWL_UCODE_WOWLAN];
-	len = img->sec[IWL_UCODE_SECTION_DATA].len;
-
-	bufsz = len * 4 + 256;
-	buf = kzalloc(bufsz, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	pos += scnprintf(buf, bufsz, "D3 SRAM capture: %sabled\n",
-			 mvm->store_d3_resume_sram ? "en" : "dis");
-
-	if (ptr) {
-		for (ofs = 0; ofs < len; ofs += 16) {
-			pos += scnprintf(buf + pos, bufsz - pos,
-					 "0x%.4x %16ph\n", ofs, ptr + ofs);
-		}
-	} else {
-		pos += scnprintf(buf + pos, bufsz - pos,
-				 "(no data captured)\n");
-	}
-
-	ret = simple_read_from_buffer(user_buf, count, ppos, buf, pos);
-
-	kfree(buf);
-
-	return ret;
-}
-#endif
-
 #define PRINT_MVM_REF(ref) do {						\
 	if (mvm->refs[ref])						\
 		pos += scnprintf(buf + pos, bufsz - pos,		\
@@ -1940,9 +1887,6 @@ MVM_DEBUGFS_READ_WRITE_FILE_OPS(bcast_filters, 256);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(bcast_filters_macs, 256);
 #endif
 
-#ifdef CONFIG_PM_SLEEP
-MVM_DEBUGFS_READ_WRITE_FILE_OPS(d3_sram, 8);
-#endif
 #ifdef CONFIG_ACPI
 MVM_DEBUGFS_READ_FILE_OPS(sar_geo_profile);
 #endif
@@ -2159,7 +2103,6 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm, struct dentry *dbgfs_dir)
 #endif
 
 #ifdef CONFIG_PM_SLEEP
-	MVM_DEBUGFS_ADD_FILE(d3_sram, mvm->debugfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE(d3_test, mvm->debugfs_dir, 0400);
 	debugfs_create_bool("d3_wake_sysassert", 0600, mvm->debugfs_dir,
 			    &mvm->d3_wake_sysassert);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 8dc2a9850bc5..7b829a5be773 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1039,8 +1039,6 @@ struct iwl_mvm {
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	bool d3_wake_sysassert;
 	bool d3_test_active;
-	bool store_d3_resume_sram;
-	void *d3_resume_sram;
 	u32 d3_test_pme_ptr;
 	struct ieee80211_vif *keep_vif;
 	u32 last_netdetect_scans; /* no. of scans in the last net-detect wake */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index acd2fda12466..004de67f9157 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -918,9 +918,6 @@ static void iwl_op_mode_mvm_stop(struct iwl_op_mode *op_mode)
 	kfree(mvm->error_recovery_buf);
 	mvm->error_recovery_buf = NULL;
 
-#if defined(CONFIG_PM_SLEEP) && defined(CONFIG_IWLWIFI_DEBUGFS)
-	kfree(mvm->d3_resume_sram);
-#endif
 	iwl_trans_op_mode_leave(mvm->trans);
 
 	iwl_phy_db_free(mvm->phy_db);
-- 
2.20.1

