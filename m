Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27F2594AE6
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 18:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfHSQuv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 12:50:51 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:37114 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727995AbfHSQuv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 12:50:51 -0400
Received: from [91.156.6.193] (helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hzkrO-0007zi-Cf; Mon, 19 Aug 2019 19:50:23 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 19 Aug 2019 19:49:58 +0300
Message-Id: <20190819165007.10181-14-luca@coelho.fi>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190819165007.10181-1-luca@coelho.fi>
References: <20190819165007.10181-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.2
Subject: [PATCH v3 13/22] iwlwifi: remove all the d0i3 references
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

As part of the d0i3 removal.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   9 -
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 111 ----------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   4 -
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 195 ------------------
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  49 -----
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  42 +---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  18 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   7 -
 drivers/net/wireless/intel/iwlwifi/mvm/tdls.c |   9 -
 .../wireless/intel/iwlwifi/mvm/time-event.c   |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |  12 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |   8 +-
 13 files changed, 11 insertions(+), 465 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
index cbd1a8eed620..f37d6fee0225 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-op-mode.h
@@ -8,7 +8,7 @@
  * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2015        Intel Deutschland GmbH
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2005 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2015        Intel Deutschland GmbH
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 3a8a0c43cb6e..7493cae70ea6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1106,7 +1106,6 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 		iwl_mvm_free_nd(mvm);
 
 		if (!unified_image) {
-			iwl_mvm_ref(mvm, IWL_MVM_REF_UCODE_DOWN);
 			if (mvm->fw_restart > 0) {
 				mvm->fw_restart--;
 				ieee80211_restart_hw(mvm->hw);
@@ -2115,14 +2114,6 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 	 * 2. We are using a unified image but had an error while exiting D3
 	 */
 	set_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status);
-	/*
-	 * When switching images we return 1, which causes mac80211
-	 * to do a reconfig with IEEE80211_RECONFIG_TYPE_RESTART.
-	 * This type of reconfig calls iwl_mvm_restart_complete(),
-	 * where we unref the IWL_MVM_REF_UCODE_DOWN, so we need
-	 * to take the reference here.
-	 */
-	iwl_mvm_ref(mvm, IWL_MVM_REF_UCODE_DOWN);
 
 	return 1;
 }
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index 0c188a82cfc1..6d67d3da31e0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -1056,19 +1056,11 @@ static ssize_t iwl_dbgfs_fw_restart_write(struct iwl_mvm *mvm, char *buf,
 static ssize_t iwl_dbgfs_fw_nmi_write(struct iwl_mvm *mvm, char *buf,
 				      size_t count, loff_t *ppos)
 {
-	int ret;
-
 	if (!iwl_mvm_firmware_running(mvm))
 		return -EIO;
 
-	ret = iwl_mvm_ref_sync(mvm, IWL_MVM_REF_NMI);
-	if (ret)
-		return ret;
-
 	iwl_force_nmi(mvm->trans);
 
-	iwl_mvm_unref(mvm, IWL_MVM_REF_NMI);
-
 	return count;
 }
 
@@ -1380,19 +1372,12 @@ static ssize_t iwl_dbgfs_fw_dbg_collect_write(struct iwl_mvm *mvm,
 					      char *buf, size_t count,
 					      loff_t *ppos)
 {
-	int ret;
-
-	ret = iwl_mvm_ref_sync(mvm, IWL_MVM_REF_PRPH_WRITE);
-	if (ret)
-		return ret;
 	if (count == 0)
 		return 0;
 
 	iwl_fw_dbg_collect(&mvm->fwrt, FW_DBG_TRIGGER_USER, buf,
 			   (count - 1), NULL);
 
-	iwl_mvm_unref(mvm, IWL_MVM_REF_PRPH_WRITE);
-
 	return count;
 }
 
@@ -1579,87 +1564,6 @@ static ssize_t iwl_dbgfs_bcast_filters_macs_write(struct iwl_mvm *mvm,
 }
 #endif
 
-#define PRINT_MVM_REF(ref) do {						\
-	if (mvm->refs[ref])						\
-		pos += scnprintf(buf + pos, bufsz - pos,		\
-				 "\t(0x%lx): %d %s\n",			\
-				 BIT(ref), mvm->refs[ref], #ref);	\
-} while (0)
-
-static ssize_t iwl_dbgfs_d0i3_refs_read(struct file *file,
-					char __user *user_buf,
-					size_t count, loff_t *ppos)
-{
-	struct iwl_mvm *mvm = file->private_data;
-	int i, pos = 0;
-	char buf[256];
-	const size_t bufsz = sizeof(buf);
-	u32 refs = 0;
-
-	for (i = 0; i < IWL_MVM_REF_COUNT; i++)
-		if (mvm->refs[i])
-			refs |= BIT(i);
-
-	pos += scnprintf(buf + pos, bufsz - pos, "taken mvm refs: 0x%x\n",
-			 refs);
-
-	PRINT_MVM_REF(IWL_MVM_REF_UCODE_DOWN);
-	PRINT_MVM_REF(IWL_MVM_REF_SCAN);
-	PRINT_MVM_REF(IWL_MVM_REF_ROC);
-	PRINT_MVM_REF(IWL_MVM_REF_ROC_AUX);
-	PRINT_MVM_REF(IWL_MVM_REF_P2P_CLIENT);
-	PRINT_MVM_REF(IWL_MVM_REF_AP_IBSS);
-	PRINT_MVM_REF(IWL_MVM_REF_USER);
-	PRINT_MVM_REF(IWL_MVM_REF_TX);
-	PRINT_MVM_REF(IWL_MVM_REF_TX_AGG);
-	PRINT_MVM_REF(IWL_MVM_REF_ADD_IF);
-	PRINT_MVM_REF(IWL_MVM_REF_START_AP);
-	PRINT_MVM_REF(IWL_MVM_REF_BSS_CHANGED);
-	PRINT_MVM_REF(IWL_MVM_REF_PREPARE_TX);
-	PRINT_MVM_REF(IWL_MVM_REF_PROTECT_TDLS);
-	PRINT_MVM_REF(IWL_MVM_REF_CHECK_CTKILL);
-	PRINT_MVM_REF(IWL_MVM_REF_PRPH_READ);
-	PRINT_MVM_REF(IWL_MVM_REF_PRPH_WRITE);
-	PRINT_MVM_REF(IWL_MVM_REF_NMI);
-	PRINT_MVM_REF(IWL_MVM_REF_TM_CMD);
-	PRINT_MVM_REF(IWL_MVM_REF_EXIT_WORK);
-	PRINT_MVM_REF(IWL_MVM_REF_PROTECT_CSA);
-	PRINT_MVM_REF(IWL_MVM_REF_FW_DBG_COLLECT);
-	PRINT_MVM_REF(IWL_MVM_REF_INIT_UCODE);
-	PRINT_MVM_REF(IWL_MVM_REF_SENDING_CMD);
-	PRINT_MVM_REF(IWL_MVM_REF_RX);
-
-	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
-}
-
-static ssize_t iwl_dbgfs_d0i3_refs_write(struct iwl_mvm *mvm, char *buf,
-					 size_t count, loff_t *ppos)
-{
-	unsigned long value;
-	int ret;
-	bool taken;
-
-	ret = kstrtoul(buf, 10, &value);
-	if (ret < 0)
-		return ret;
-
-	mutex_lock(&mvm->mutex);
-
-	taken = mvm->refs[IWL_MVM_REF_USER];
-	if (value == 1 && !taken)
-		iwl_mvm_ref(mvm, IWL_MVM_REF_USER);
-	else if (value == 0 && taken)
-		iwl_mvm_unref(mvm, IWL_MVM_REF_USER);
-	else
-		ret = -EINVAL;
-
-	mutex_unlock(&mvm->mutex);
-
-	if (ret < 0)
-		return ret;
-	return count;
-}
-
 #define MVM_DEBUGFS_WRITE_FILE_OPS(name, bufsz) \
 	_MVM_DEBUGFS_WRITE_FILE_OPS(name, bufsz, struct iwl_mvm)
 #define MVM_DEBUGFS_READ_WRITE_FILE_OPS(name, bufsz) \
@@ -1692,21 +1596,14 @@ iwl_dbgfs_prph_reg_read(struct file *file,
 	int pos = 0;
 	char buf[32];
 	const size_t bufsz = sizeof(buf);
-	int ret;
 
 	if (!mvm->dbgfs_prph_reg_addr)
 		return -EINVAL;
 
-	ret = iwl_mvm_ref_sync(mvm, IWL_MVM_REF_PRPH_READ);
-	if (ret)
-		return ret;
-
 	pos += scnprintf(buf + pos, bufsz - pos, "Reg 0x%x: (0x%x)\n",
 		mvm->dbgfs_prph_reg_addr,
 		iwl_read_prph(mvm->trans, mvm->dbgfs_prph_reg_addr));
 
-	iwl_mvm_unref(mvm, IWL_MVM_REF_PRPH_READ);
-
 	return simple_read_from_buffer(user_buf, count, ppos, buf, pos);
 }
 
@@ -1716,7 +1613,6 @@ iwl_dbgfs_prph_reg_write(struct iwl_mvm *mvm, char *buf,
 {
 	u8 args;
 	u32 value;
-	int ret;
 
 	args = sscanf(buf, "%i %i", &mvm->dbgfs_prph_reg_addr, &value);
 	/* if we only want to set the reg address - nothing more to do */
@@ -1727,13 +1623,8 @@ iwl_dbgfs_prph_reg_write(struct iwl_mvm *mvm, char *buf,
 	if (args != 2)
 		return -EINVAL;
 
-	ret = iwl_mvm_ref_sync(mvm, IWL_MVM_REF_PRPH_WRITE);
-	if (ret)
-		return ret;
-
 	iwl_write_prph(mvm->trans, mvm->dbgfs_prph_reg_addr, value);
 
-	iwl_mvm_unref(mvm, IWL_MVM_REF_PRPH_WRITE);
 out:
 	return count;
 }
@@ -1892,7 +1783,6 @@ MVM_DEBUGFS_WRITE_FILE_OPS(fw_nmi, 10);
 MVM_DEBUGFS_WRITE_FILE_OPS(bt_tx_prio, 10);
 MVM_DEBUGFS_WRITE_FILE_OPS(bt_force_ant, 10);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(scan_ant_rxchain, 8);
-MVM_DEBUGFS_READ_WRITE_FILE_OPS(d0i3_refs, 8);
 MVM_DEBUGFS_READ_WRITE_FILE_OPS(fw_dbg_conf, 8);
 MVM_DEBUGFS_WRITE_FILE_OPS(fw_dbg_collect, 64);
 MVM_DEBUGFS_WRITE_FILE_OPS(indirection_tbl,
@@ -2091,7 +1981,6 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm, struct dentry *dbgfs_dir)
 	MVM_DEBUGFS_ADD_FILE(bt_force_ant, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(scan_ant_rxchain, mvm->debugfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE(prph_reg, mvm->debugfs_dir, 0600);
-	MVM_DEBUGFS_ADD_FILE(d0i3_refs, mvm->debugfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE(fw_dbg_conf, mvm->debugfs_dir, 0600);
 	MVM_DEBUGFS_ADD_FILE(fw_dbg_collect, mvm->debugfs_dir, 0200);
 	MVM_DEBUGFS_ADD_FILE(send_echo_cmd, mvm->debugfs_dir, 0200);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index ed6453b2fc79..251e7c235aaa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1326,10 +1326,6 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 			goto error;
 	}
 
-	/* allow FW/transport low power modes if not during restart */
-	if (!test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
-		iwl_mvm_unref(mvm, IWL_MVM_REF_UCODE_DOWN);
-
 	if (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status))
 		iwl_mvm_send_recovery_cmd(mvm, ERROR_RECOVERY_UPDATE_DB);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 07d576d29086..b815d2b0b2ad 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -213,91 +213,6 @@ static int __iwl_mvm_mac_set_key(struct ieee80211_hw *hw,
 				 struct ieee80211_sta *sta,
 				 struct ieee80211_key_conf *key);
 
-void iwl_mvm_ref(struct iwl_mvm *mvm, enum iwl_mvm_ref_type ref_type)
-{
-	if (!iwl_mvm_is_d0i3_supported(mvm))
-		return;
-
-	IWL_DEBUG_RPM(mvm, "Take mvm reference - type %d\n", ref_type);
-	spin_lock_bh(&mvm->refs_lock);
-	mvm->refs[ref_type]++;
-	spin_unlock_bh(&mvm->refs_lock);
-	iwl_trans_ref(mvm->trans);
-}
-
-void iwl_mvm_unref(struct iwl_mvm *mvm, enum iwl_mvm_ref_type ref_type)
-{
-	if (!iwl_mvm_is_d0i3_supported(mvm))
-		return;
-
-	IWL_DEBUG_RPM(mvm, "Leave mvm reference - type %d\n", ref_type);
-	spin_lock_bh(&mvm->refs_lock);
-	if (WARN_ON(!mvm->refs[ref_type])) {
-		spin_unlock_bh(&mvm->refs_lock);
-		return;
-	}
-	mvm->refs[ref_type]--;
-	spin_unlock_bh(&mvm->refs_lock);
-	iwl_trans_unref(mvm->trans);
-}
-
-static void iwl_mvm_unref_all_except(struct iwl_mvm *mvm,
-				     enum iwl_mvm_ref_type except_ref)
-{
-	int i, j;
-
-	if (!iwl_mvm_is_d0i3_supported(mvm))
-		return;
-
-	spin_lock_bh(&mvm->refs_lock);
-	for (i = 0; i < IWL_MVM_REF_COUNT; i++) {
-		if (except_ref == i || !mvm->refs[i])
-			continue;
-
-		IWL_DEBUG_RPM(mvm, "Cleanup: remove mvm ref type %d (%d)\n",
-			      i, mvm->refs[i]);
-		for (j = 0; j < mvm->refs[i]; j++)
-			iwl_trans_unref(mvm->trans);
-		mvm->refs[i] = 0;
-	}
-	spin_unlock_bh(&mvm->refs_lock);
-}
-
-bool iwl_mvm_ref_taken(struct iwl_mvm *mvm)
-{
-	int i;
-	bool taken = false;
-
-	if (!iwl_mvm_is_d0i3_supported(mvm))
-		return true;
-
-	spin_lock_bh(&mvm->refs_lock);
-	for (i = 0; i < IWL_MVM_REF_COUNT; i++) {
-		if (mvm->refs[i]) {
-			taken = true;
-			break;
-		}
-	}
-	spin_unlock_bh(&mvm->refs_lock);
-
-	return taken;
-}
-
-int iwl_mvm_ref_sync(struct iwl_mvm *mvm, enum iwl_mvm_ref_type ref_type)
-{
-	iwl_mvm_ref(mvm, ref_type);
-
-	if (!wait_event_timeout(mvm->d0i3_exit_waitq,
-				!test_bit(IWL_MVM_STATUS_IN_D0I3, &mvm->status),
-				HZ)) {
-		WARN_ON_ONCE(1);
-		iwl_mvm_unref(mvm, ref_type);
-		return -EIO;
-	}
-
-	return 0;
-}
-
 static void iwl_mvm_reset_phy_ctxts(struct iwl_mvm *mvm)
 {
 	int i;
@@ -857,10 +772,6 @@ static bool iwl_mvm_defer_tx(struct iwl_mvm *mvm,
 
 	__skb_queue_tail(&mvm->d0i3_tx, skb);
 
-	/* trigger wakeup */
-	iwl_mvm_ref(mvm, IWL_MVM_REF_TX);
-	iwl_mvm_unref(mvm, IWL_MVM_REF_TX);
-
 	defer = true;
 out:
 	spin_unlock(&mvm->d0i3_tx_lock);
@@ -1080,7 +991,6 @@ static int iwl_mvm_mac_ampdu_action(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int ret;
-	bool tx_agg_ref = false;
 	struct ieee80211_sta *sta = params->sta;
 	enum ieee80211_ampdu_mlme_action action = params->action;
 	u16 tid = params->tid;
@@ -1095,31 +1005,6 @@ static int iwl_mvm_mac_ampdu_action(struct ieee80211_hw *hw,
 	if (!(mvm->nvm_data->sku_cap_11n_enable))
 		return -EACCES;
 
-	/* return from D0i3 before starting a new Tx aggregation */
-	switch (action) {
-	case IEEE80211_AMPDU_TX_START:
-	case IEEE80211_AMPDU_TX_STOP_CONT:
-	case IEEE80211_AMPDU_TX_STOP_FLUSH:
-	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
-	case IEEE80211_AMPDU_TX_OPERATIONAL:
-		/*
-		 * for tx start, wait synchronously until D0i3 exit to
-		 * get the correct sequence number for the tid.
-		 * additionally, some other ampdu actions use direct
-		 * target access, which is not handled automatically
-		 * by the trans layer (unlike commands), so wait for
-		 * d0i3 exit in these cases as well.
-		 */
-		ret = iwl_mvm_ref_sync(mvm, IWL_MVM_REF_TX_AGG);
-		if (ret)
-			return ret;
-
-		tx_agg_ref = true;
-		break;
-	default:
-		break;
-	}
-
 	mutex_lock(&mvm->mutex);
 
 	switch (action) {
@@ -1180,13 +1065,6 @@ static int iwl_mvm_mac_ampdu_action(struct ieee80211_hw *hw,
 	}
 	mutex_unlock(&mvm->mutex);
 
-	/*
-	 * If the tid is marked as started, we won't use it for offloaded
-	 * traffic on the next D0i3 entry. It's safe to unref.
-	 */
-	if (tx_agg_ref)
-		iwl_mvm_unref(mvm, IWL_MVM_REF_TX_AGG);
-
 	return ret;
 }
 
@@ -1210,11 +1088,6 @@ static void iwl_mvm_cleanup_iterator(void *data, u8 *mac,
 
 static void iwl_mvm_restart_cleanup(struct iwl_mvm *mvm)
 {
-	/* cleanup all stale references (scan, roc), but keep the
-	 * ucode_down ref until reconfig is complete
-	 */
-	iwl_mvm_unref_all_except(mvm, IWL_MVM_REF_UCODE_DOWN);
-
 	iwl_mvm_stop_device(mvm);
 
 	mvm->cur_aid = 0;
@@ -1272,14 +1145,6 @@ int __iwl_mvm_mac_start(struct iwl_mvm *mvm)
 		clear_bit(IWL_MVM_STATUS_HW_RESTART_REQUESTED, &mvm->status);
 		/* Clean up some internal and mac80211 state on restart */
 		iwl_mvm_restart_cleanup(mvm);
-	} else {
-		/* Hold the reference to prevent runtime suspend while
-		 * the start procedure runs.  It's a bit confusing
-		 * that the UCODE_DOWN reference is taken, but it just
-		 * means "UCODE is not UP yet". ( TODO: rename this
-		 * reference).
-		 */
-		iwl_mvm_ref(mvm, IWL_MVM_REF_UCODE_DOWN);
 	}
 	ret = iwl_mvm_up(mvm);
 
@@ -1339,9 +1204,6 @@ static void iwl_mvm_restart_complete(struct iwl_mvm *mvm)
 		IWL_ERR(mvm, "Failed to update quotas after restart (%d)\n",
 			ret);
 
-	/* allow transport/FW low power modes */
-	iwl_mvm_unref(mvm, IWL_MVM_REF_UCODE_DOWN);
-
 	iwl_mvm_send_recovery_cmd(mvm, ERROR_RECOVERY_END_OF_RECOVERY);
 
 	/*
@@ -1593,15 +1455,6 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
 	mvmvif->mvm = mvm;
 	RCU_INIT_POINTER(mvmvif->probe_resp_data, NULL);
 
-	/*
-	 * make sure D0i3 exit is completed, otherwise a target access
-	 * during tx queue configuration could be done when still in
-	 * D0i3 state.
-	 */
-	ret = iwl_mvm_ref_sync(mvm, IWL_MVM_REF_ADD_IF);
-	if (ret)
-		return ret;
-
 	/*
 	 * Not much to do here. The stack will not allow interface
 	 * types or combinations that we didn't advertise, so we
@@ -1737,8 +1590,6 @@ static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
  out_unlock:
 	mutex_unlock(&mvm->mutex);
 
-	iwl_mvm_unref(mvm, IWL_MVM_REF_ADD_IF);
-
 	return ret;
 }
 
@@ -2506,7 +2357,6 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 			iwl_mvm_sf_update(mvm, vif, false);
 			iwl_mvm_power_vif_assoc(mvm, vif);
 			if (vif->p2p) {
-				iwl_mvm_ref(mvm, IWL_MVM_REF_P2P_CLIENT);
 				iwl_mvm_update_smps(mvm, vif,
 						    IWL_MVM_SMPS_REQ_PROT,
 						    IEEE80211_SMPS_DYNAMIC);
@@ -2553,9 +2403,6 @@ static void iwl_mvm_bss_info_changed_station(struct iwl_mvm *mvm,
 			if (ret)
 				IWL_ERR(mvm, "failed to update quotas\n");
 
-			if (vif->p2p)
-				iwl_mvm_unref(mvm, IWL_MVM_REF_P2P_CLIENT);
-
 			/* this will take the cleared BSSID from bss_conf */
 			ret = iwl_mvm_mac_ctxt_changed(mvm, vif, false, NULL);
 			if (ret)
@@ -2643,14 +2490,6 @@ static int iwl_mvm_start_ap_ibss(struct ieee80211_hw *hw,
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
 	int ret, i;
 
-	/*
-	 * iwl_mvm_mac_ctxt_add() might read directly from the device
-	 * (the system time), so make sure it is available.
-	 */
-	ret = iwl_mvm_ref_sync(mvm, IWL_MVM_REF_START_AP);
-	if (ret)
-		return ret;
-
 	mutex_lock(&mvm->mutex);
 
 	/* Send the beacon template */
@@ -2746,8 +2585,6 @@ static int iwl_mvm_start_ap_ibss(struct ieee80211_hw *hw,
 	if (vif->p2p && mvm->p2p_device_vif)
 		iwl_mvm_mac_ctxt_changed(mvm, mvm->p2p_device_vif, false, NULL);
 
-	iwl_mvm_ref(mvm, IWL_MVM_REF_AP_IBSS);
-
 	iwl_mvm_bt_coex_vif_change(mvm);
 
 	/* we don't support TDLS during DCM */
@@ -2769,7 +2606,6 @@ static int iwl_mvm_start_ap_ibss(struct ieee80211_hw *hw,
 	iwl_mvm_mac_ctxt_remove(mvm, vif);
 out_unlock:
 	mutex_unlock(&mvm->mutex);
-	iwl_mvm_unref(mvm, IWL_MVM_REF_START_AP);
 	return ret;
 }
 
@@ -2807,8 +2643,6 @@ static void iwl_mvm_stop_ap_ibss(struct ieee80211_hw *hw,
 
 	iwl_mvm_bt_coex_vif_change(mvm);
 
-	iwl_mvm_unref(mvm, IWL_MVM_REF_AP_IBSS);
-
 	/* Need to update the P2P Device MAC (only GO, IBSS is single vif) */
 	if (vif->p2p && mvm->p2p_device_vif)
 		iwl_mvm_mac_ctxt_changed(mvm, mvm->p2p_device_vif, false, NULL);
@@ -2882,14 +2716,6 @@ static void iwl_mvm_bss_info_changed(struct ieee80211_hw *hw,
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 
-	/*
-	 * iwl_mvm_bss_info_changed_station() might call
-	 * iwl_mvm_protect_session(), which reads directly from
-	 * the device (the system time), so make sure it is available.
-	 */
-	if (iwl_mvm_ref_sync(mvm, IWL_MVM_REF_BSS_CHANGED))
-		return;
-
 	mutex_lock(&mvm->mutex);
 
 	if (changes & BSS_CHANGED_IDLE && !bss_conf->idle)
@@ -2913,7 +2739,6 @@ static void iwl_mvm_bss_info_changed(struct ieee80211_hw *hw,
 	}
 
 	mutex_unlock(&mvm->mutex);
-	iwl_mvm_unref(mvm, IWL_MVM_REF_BSS_CHANGED);
 }
 
 static int iwl_mvm_mac_hw_scan(struct ieee80211_hw *hw,
@@ -3473,13 +3298,6 @@ static void iwl_mvm_mac_mgd_prepare_tx(struct ieee80211_hw *hw,
 	u32 duration = IWL_MVM_TE_SESSION_PROTECTION_MAX_TIME_MS;
 	u32 min_duration = IWL_MVM_TE_SESSION_PROTECTION_MIN_TIME_MS;
 
-	/*
-	 * iwl_mvm_protect_session() reads directly from the device
-	 * (the system time), so make sure it is available.
-	 */
-	if (iwl_mvm_ref_sync(mvm, IWL_MVM_REF_PREPARE_TX))
-		return;
-
 	if (req_duration > duration)
 		duration = req_duration;
 
@@ -3487,8 +3305,6 @@ static void iwl_mvm_mac_mgd_prepare_tx(struct ieee80211_hw *hw,
 	/* Try really hard to protect the session and hear a beacon */
 	iwl_mvm_protect_session(mvm, vif, duration, min_duration, 500, false);
 	mutex_unlock(&mvm->mutex);
-
-	iwl_mvm_unref(mvm, IWL_MVM_REF_PREPARE_TX);
 }
 
 static int iwl_mvm_mac_sched_scan_start(struct ieee80211_hw *hw,
@@ -4304,23 +4120,12 @@ static int __iwl_mvm_assign_vif_chanctx(struct iwl_mvm *mvm,
 				 IWL_UCODE_TLV_CAPA_CHANNEL_SWITCH_CMD)) {
 			u32 duration = 3 * vif->bss_conf.beacon_int;
 
-
-			/* iwl_mvm_protect_session() reads directly from the
-			 * device (the system time), so make sure it is
-			 * available.
-			 */
-			ret = iwl_mvm_ref_sync(mvm, IWL_MVM_REF_PROTECT_CSA);
-			if (ret)
-				goto out_remove_binding;
-
 			/* Protect the session to make sure we hear the first
 			 * beacon on the new channel.
 			 */
 			iwl_mvm_protect_session(mvm, vif, duration, duration,
 						vif->bss_conf.beacon_int / 2,
 						true);
-
-			iwl_mvm_unref(mvm, IWL_MVM_REF_PROTECT_CSA);
 		}
 
 		iwl_mvm_update_quotas(mvm, false, NULL);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index e5703aa7935e..245e8c721102 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -258,38 +258,6 @@ enum iwl_mvm_smps_type_request {
 	NUM_IWL_MVM_SMPS_REQ,
 };
 
-enum iwl_mvm_ref_type {
-	IWL_MVM_REF_UCODE_DOWN,
-	IWL_MVM_REF_SCAN,
-	IWL_MVM_REF_ROC,
-	IWL_MVM_REF_ROC_AUX,
-	IWL_MVM_REF_P2P_CLIENT,
-	IWL_MVM_REF_AP_IBSS,
-	IWL_MVM_REF_USER,
-	IWL_MVM_REF_TX,
-	IWL_MVM_REF_TX_AGG,
-	IWL_MVM_REF_ADD_IF,
-	IWL_MVM_REF_START_AP,
-	IWL_MVM_REF_BSS_CHANGED,
-	IWL_MVM_REF_PREPARE_TX,
-	IWL_MVM_REF_PROTECT_TDLS,
-	IWL_MVM_REF_CHECK_CTKILL,
-	IWL_MVM_REF_PRPH_READ,
-	IWL_MVM_REF_PRPH_WRITE,
-	IWL_MVM_REF_NMI,
-	IWL_MVM_REF_TM_CMD,
-	IWL_MVM_REF_EXIT_WORK,
-	IWL_MVM_REF_PROTECT_CSA,
-	IWL_MVM_REF_FW_DBG_COLLECT,
-	IWL_MVM_REF_INIT_UCODE,
-	IWL_MVM_REF_SENDING_CMD,
-	IWL_MVM_REF_RX,
-
-	/* update debugfs.c when changing this */
-
-	IWL_MVM_REF_COUNT,
-};
-
 enum iwl_bt_force_ant_mode {
 	BT_FORCE_ANT_DIS = 0,
 	BT_FORCE_ANT_AUTO,
@@ -1014,10 +982,6 @@ struct iwl_mvm {
 	unsigned long fw_key_table[BITS_TO_LONGS(STA_KEY_MAX_NUM)];
 	u8 fw_key_deleted[STA_KEY_MAX_NUM];
 
-	/* references taken by the driver and spinlock protecting them */
-	spinlock_t refs_lock;
-	u8 refs[IWL_MVM_REF_COUNT];
-
 	u8 vif_count;
 	struct ieee80211_vif __rcu *vif_id_to_mac[NUM_MAC_INDEX_DRIVER];
 
@@ -1294,13 +1258,6 @@ iwl_mvm_rcu_dereference_vif_id(struct iwl_mvm *mvm, u8 vif_id, bool rcu)
 					 lockdep_is_held(&mvm->mutex));
 }
 
-static inline bool iwl_mvm_is_d0i3_supported(struct iwl_mvm *mvm)
-{
-	return !iwlwifi_mod_params.d0i3_disable &&
-		fw_has_capa(&mvm->fw->ucode_capa,
-			    IWL_UCODE_TLV_CAPA_D0I3_SUPPORT);
-}
-
 static inline bool iwl_mvm_is_adaptive_dwell_supported(struct iwl_mvm *mvm)
 {
 	return fw_has_api(&mvm->fw->ucode_capa,
@@ -1903,12 +1860,6 @@ int iwl_mvm_send_proto_offload(struct iwl_mvm *mvm,
 			       bool offload_ns,
 			       u32 cmd_flags);
 
-/* D0i3 */
-void iwl_mvm_ref(struct iwl_mvm *mvm, enum iwl_mvm_ref_type ref_type);
-void iwl_mvm_unref(struct iwl_mvm *mvm, enum iwl_mvm_ref_type ref_type);
-int iwl_mvm_ref_sync(struct iwl_mvm *mvm, enum iwl_mvm_ref_type ref_type);
-bool iwl_mvm_ref_taken(struct iwl_mvm *mvm);
-
 #ifdef CONFIG_PM
 void iwl_mvm_d0i3_enable_tx(struct iwl_mvm *mvm, __le16 *qos_seq);
 int iwl_mvm_enter_d0i3(struct iwl_op_mode *op_mode);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 2aa5320e9d1a..255b402f7b19 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -566,23 +566,16 @@ static void iwl_mvm_tx_unblock_dwork(struct work_struct *work)
 static int iwl_mvm_fwrt_dump_start(void *ctx)
 {
 	struct iwl_mvm *mvm = ctx;
-	int ret = 0;
 
 	mutex_lock(&mvm->mutex);
 
-	ret = iwl_mvm_ref_sync(mvm, IWL_MVM_REF_FW_DBG_COLLECT);
-	if (ret)
-		mutex_unlock(&mvm->mutex);
-
-	return ret;
+	return 0;
 }
 
 static void iwl_mvm_fwrt_dump_end(void *ctx)
 {
 	struct iwl_mvm *mvm = ctx;
 
-	iwl_mvm_unref(mvm, IWL_MVM_REF_FW_DBG_COLLECT);
-
 	mutex_unlock(&mvm->mutex);
 }
 
@@ -721,7 +714,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	INIT_LIST_HEAD(&mvm->add_stream_txqs);
 
 	spin_lock_init(&mvm->d0i3_tx_lock);
-	spin_lock_init(&mvm->refs_lock);
 	skb_queue_head_init(&mvm->d0i3_tx);
 	init_waitqueue_head(&mvm->d0i3_exit_waitq);
 	init_waitqueue_head(&mvm->rx_sync_waitq);
@@ -834,13 +826,11 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		goto out_free;
 
 	mutex_lock(&mvm->mutex);
-	iwl_mvm_ref(mvm, IWL_MVM_REF_INIT_UCODE);
 	err = iwl_run_init_mvm_ucode(mvm, true);
 	if (err && err != -ERFKILL)
 		iwl_fw_dbg_error_collect(&mvm->fwrt, FW_DBG_TRIGGER_DRIVER);
 	if (!iwlmvm_mod_params.init_dbg || !err)
 		iwl_mvm_stop_device(mvm);
-	iwl_mvm_unref(mvm, IWL_MVM_REF_INIT_UCODE);
 	mutex_unlock(&mvm->mutex);
 	if (err < 0) {
 		IWL_ERR(mvm, "Failed to run INIT ucode: %d\n", err);
@@ -872,11 +862,6 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	else
 		memset(&mvm->rx_stats, 0, sizeof(struct mvm_statistics_rx));
 
-	/* The transport always starts with a taken reference, we can
-	 * release it now if d0i3 is supported */
-	if (iwl_mvm_is_d0i3_supported(mvm))
-		iwl_trans_unref(mvm->trans);
-
 	iwl_mvm_toggle_tx_ant(mvm, &mvm->mgmt_last_antenna_idx);
 
 	return op_mode;
@@ -900,13 +885,6 @@ static void iwl_op_mode_mvm_stop(struct iwl_op_mode *op_mode)
 	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
 	int i;
 
-	/* If d0i3 is supported, we have released the reference that
-	 * the transport started with, so we should take it back now
-	 * that we are leaving.
-	 */
-	if (iwl_mvm_is_d0i3_supported(mvm))
-		iwl_trans_ref(mvm->trans);
-
 	iwl_mvm_leds_exit(mvm);
 
 	iwl_mvm_thermal_exit(mvm);
@@ -1320,9 +1298,6 @@ void iwl_mvm_nic_restart(struct iwl_mvm *mvm, bool fw_error)
 	} else if (mvm->fwrt.cur_fw_img == IWL_UCODE_REGULAR &&
 		   mvm->hw_registered &&
 		   !test_bit(STATUS_TRANS_DEAD, &mvm->trans->status)) {
-		/* don't let the transport/FW power down */
-		iwl_mvm_ref(mvm, IWL_MVM_REF_UCODE_DOWN);
-
 		if (mvm->fw->ucode_capa.error_log_size) {
 			u32 src_size = mvm->fw->ucode_capa.error_log_size;
 			u32 src_addr = mvm->fw->ucode_capa.error_log_addr;
@@ -1520,19 +1495,6 @@ int iwl_mvm_enter_d0i3(struct iwl_op_mode *op_mode)
 
 	set_bit(IWL_MVM_STATUS_IN_D0I3, &mvm->status);
 
-	/*
-	 * iwl_mvm_ref_sync takes a reference before checking the flag.
-	 * so by checking there is no held reference we prevent a state
-	 * in which iwl_mvm_ref_sync continues successfully while we
-	 * configure the firmware to enter d0i3
-	 */
-	if (iwl_mvm_ref_taken(mvm)) {
-		IWL_DEBUG_RPM(mvm->trans, "abort d0i3 due to taken ref\n");
-		clear_bit(IWL_MVM_STATUS_IN_D0I3, &mvm->status);
-		wake_up(&mvm->d0i3_exit_waitq);
-		return 1;
-	}
-
 	ieee80211_iterate_active_interfaces_atomic(mvm->hw,
 						   IEEE80211_IFACE_ITER_NORMAL,
 						   iwl_mvm_enter_d0i3_iterator,
@@ -1728,7 +1690,6 @@ static void iwl_mvm_d0i3_exit_work(struct work_struct *wk)
 	iwl_mvm_update_changed_regdom(mvm);
 
 	iwl_mvm_resume_tcm(mvm);
-	iwl_mvm_unref(mvm, IWL_MVM_REF_EXIT_WORK);
 	mutex_unlock(&mvm->mutex);
 }
 
@@ -1769,7 +1730,6 @@ int iwl_mvm_exit_d0i3(struct iwl_op_mode *op_mode)
 {
 	struct iwl_mvm *mvm = IWL_OP_MODE_GET_MVM(op_mode);
 
-	iwl_mvm_ref(mvm, IWL_MVM_REF_EXIT_WORK);
 	return _iwl_mvm_exit_d0i3(mvm);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 160b0db27103..0ad8ed23a455 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -8,6 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -29,6 +30,8 @@
  *
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
+ * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
+ * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -349,7 +352,6 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 	u32 rate_n_flags;
 	u32 rx_pkt_status;
 	u8 crypt_len = 0;
-	bool take_ref;
 
 	phy_info = &mvm->last_phy_info;
 	rx_res = (struct iwl_rx_mpdu_res_start *)pkt->data;
@@ -557,22 +559,8 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 		     ieee80211_is_probe_resp(hdr->frame_control)))
 		rx_status->boottime_ns = ktime_get_boottime_ns();
 
-	/* Take a reference briefly to kick off a d0i3 entry delay so
-	 * we can handle bursts of RX packets without toggling the
-	 * state too often.  But don't do this for beacons if we are
-	 * going to idle because the beacon filtering changes we make
-	 * cause the firmware to send us collateral beacons. */
-	take_ref = !(test_bit(STATUS_TRANS_GOING_IDLE, &mvm->trans->status) &&
-		     ieee80211_is_beacon(hdr->frame_control));
-
-	if (take_ref)
-		iwl_mvm_ref(mvm, IWL_MVM_REF_RX);
-
 	iwl_mvm_pass_packet_to_mac80211(mvm, sta, napi, skb, hdr, len,
 					crypt_len, rxb);
-
-	if (take_ref)
-		iwl_mvm_unref(mvm, IWL_MVM_REF_RX);
 }
 
 struct iwl_mvm_stat_data {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 5999b4ebd699..2652e6ce4089 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -512,7 +512,6 @@ void iwl_mvm_rx_lmac_scan_complete_notif(struct iwl_mvm *mvm,
 
 		mvm->scan_status &= ~IWL_MVM_SCAN_REGULAR;
 		ieee80211_scan_completed(mvm->hw, &info);
-		iwl_mvm_unref(mvm, IWL_MVM_REF_SCAN);
 		cancel_delayed_work(&mvm->scan_timeout_dwork);
 		iwl_mvm_resume_tcm(mvm);
 	} else {
@@ -1758,7 +1757,6 @@ int iwl_mvm_reg_scan_start(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 	IWL_DEBUG_SCAN(mvm, "Scan request was sent successfully\n");
 	mvm->scan_status |= IWL_MVM_SCAN_REGULAR;
 	mvm->scan_vif = iwl_mvm_vif_from_mac80211(vif);
-	iwl_mvm_ref(mvm, IWL_MVM_REF_SCAN);
 
 	schedule_delayed_work(&mvm->scan_timeout_dwork,
 			      msecs_to_jiffies(SCAN_TIMEOUT));
@@ -1884,7 +1882,6 @@ void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 		memcpy(info.tsf_bssid, mvm->scan_vif->bssid, ETH_ALEN);
 		ieee80211_scan_completed(mvm->hw, &info);
 		mvm->scan_vif = NULL;
-		iwl_mvm_unref(mvm, IWL_MVM_REF_SCAN);
 		cancel_delayed_work(&mvm->scan_timeout_dwork);
 		iwl_mvm_resume_tcm(mvm);
 	} else if (mvm->scan_uid_status[uid] == IWL_MVM_SCAN_SCHED) {
@@ -2099,10 +2096,6 @@ int iwl_mvm_scan_stop(struct iwl_mvm *mvm, int type, bool notify)
 	mvm->scan_status &= ~type;
 
 	if (type == IWL_MVM_SCAN_REGULAR) {
-		/* Since the rx handler won't do anything now, we have
-		 * to release the scan reference here.
-		 */
-		iwl_mvm_unref(mvm, IWL_MVM_REF_SCAN);
 		cancel_delayed_work(&mvm->scan_timeout_dwork);
 		if (notify) {
 			struct cfg80211_scan_info info = {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
index 9df21a8d1fc1..1851719e9f4b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tdls.c
@@ -205,19 +205,10 @@ void iwl_mvm_mac_mgd_protect_tdls_discover(struct ieee80211_hw *hw,
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	u32 duration = 2 * vif->bss_conf.dtim_period * vif->bss_conf.beacon_int;
 
-	/*
-	 * iwl_mvm_protect_session() reads directly from the device
-	 * (the system time), so make sure it is available.
-	 */
-	if (iwl_mvm_ref_sync(mvm, IWL_MVM_REF_PROTECT_TDLS))
-		return;
-
 	mutex_lock(&mvm->mutex);
 	/* Protect the session to hear the TDLS setup response on the channel */
 	iwl_mvm_protect_session(mvm, vif, duration, duration, 100, true);
 	mutex_unlock(&mvm->mutex);
-
-	iwl_mvm_unref(mvm, IWL_MVM_REF_PROTECT_TDLS);
 }
 
 static const char *
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 4d34e5ab1bff..a06bc63fb516 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -106,10 +106,8 @@ void iwl_mvm_roc_done_wk(struct work_struct *wk)
 	 * in the case that the time event actually completed in the firmware
 	 * (which is handled in iwl_mvm_te_handle_notif).
 	 */
-	if (test_and_clear_bit(IWL_MVM_STATUS_ROC_RUNNING, &mvm->status))
-		iwl_mvm_unref(mvm, IWL_MVM_REF_ROC);
-	if (test_and_clear_bit(IWL_MVM_STATUS_ROC_AUX_RUNNING, &mvm->status))
-		iwl_mvm_unref(mvm, IWL_MVM_REF_ROC_AUX);
+	clear_bit(IWL_MVM_STATUS_ROC_RUNNING, &mvm->status);
+	clear_bit(IWL_MVM_STATUS_ROC_AUX_RUNNING, &mvm->status);
 
 	synchronize_net();
 
@@ -357,7 +355,6 @@ static void iwl_mvm_te_handle_notif(struct iwl_mvm *mvm,
 
 		if (te_data->vif->type == NL80211_IFTYPE_P2P_DEVICE) {
 			set_bit(IWL_MVM_STATUS_ROC_RUNNING, &mvm->status);
-			iwl_mvm_ref(mvm, IWL_MVM_REF_ROC);
 			ieee80211_ready_on_channel(mvm->hw);
 		} else if (te_data->id == TE_CHANNEL_SWITCH_PERIOD) {
 			iwl_mvm_te_handle_notify_csa(mvm, te_data, notif);
@@ -405,7 +402,6 @@ static int iwl_mvm_aux_roc_te_handle_notif(struct iwl_mvm *mvm,
 	} else if (le32_to_cpu(notif->action) == TE_V2_NOTIF_HOST_EVENT_START) {
 		set_bit(IWL_MVM_STATUS_ROC_AUX_RUNNING, &mvm->status);
 		te_data->running = true;
-		iwl_mvm_ref(mvm, IWL_MVM_REF_ROC_AUX);
 		ieee80211_ready_on_channel(mvm->hw); /* Start TE */
 	} else {
 		IWL_DEBUG_TE(mvm,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
index 0b3e5c99d316..32a708301cfc 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -5,7 +5,7 @@
  *
  * GPL LICENSE SUMMARY
  *
- * Copyright(c) 2013 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2013 - 2014, 2019 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2016 Intel Deutschland GmbH
  *
@@ -27,7 +27,7 @@
  *
  * BSD LICENSE
  *
- * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
+ * Copyright(c) 2012 - 2014, 2019 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2014 Intel Mobile Communications GmbH
  * Copyright(c) 2015 - 2016 Intel Deutschland GmbH
  * All rights reserved.
@@ -298,16 +298,8 @@ static void check_exit_ctkill(struct work_struct *work)
 	if (__iwl_mvm_mac_start(mvm))
 		goto reschedule;
 
-	/* make sure the device is available for direct read/writes */
-	if (iwl_mvm_ref_sync(mvm, IWL_MVM_REF_CHECK_CTKILL)) {
-		__iwl_mvm_mac_stop(mvm);
-		goto reschedule;
-	}
-
 	ret = iwl_mvm_get_temp(mvm, &temp);
 
-	iwl_mvm_unref(mvm, IWL_MVM_REF_CHECK_CTKILL);
-
 	__iwl_mvm_mac_stop(mvm);
 
 	if (ret)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index b8e20a01c192..06ef853fb84a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -88,17 +88,11 @@ int iwl_mvm_send_cmd(struct iwl_mvm *mvm, struct iwl_host_cmd *cmd)
 	 * the mutex, this ensures we don't try to send two
 	 * (or more) synchronous commands at a time.
 	 */
-	if (!(cmd->flags & CMD_ASYNC)) {
+	if (!(cmd->flags & CMD_ASYNC))
 		lockdep_assert_held(&mvm->mutex);
-		if (!(cmd->flags & CMD_SEND_IN_IDLE))
-			iwl_mvm_ref(mvm, IWL_MVM_REF_SENDING_CMD);
-	}
 
 	ret = iwl_trans_send_cmd(mvm->trans, cmd);
 
-	if (!(cmd->flags & (CMD_ASYNC | CMD_SEND_IN_IDLE)))
-		iwl_mvm_unref(mvm, IWL_MVM_REF_SENDING_CMD);
-
 	/*
 	 * If the caller wants the SKB, then don't hide any problems, the
 	 * caller might access the response buffer which will be NULL if
-- 
2.23.0.rc1

