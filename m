Return-Path: <linux-wireless+bounces-26644-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E9BB36F6F
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 18:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68098464C88
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 15:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD7F3164D7;
	Tue, 26 Aug 2025 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EHIbsie7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1237930ACE8
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223751; cv=none; b=Y/XdO92MWFae20AEMDh0wJpFrEzrH0MX5ATwoWaxU4t5GWY6auO9LeFbaL79QBuZ/8YNXLBb5qE25T9Pd1IYRt0lO7dXSwuZgz4IGwKvrGMeEPyIg8bxRUW3hMIKDyAH2NA7JpoWj3lXLfYmxTNKpSifowO8oJJlDvXXuWpXux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223751; c=relaxed/simple;
	bh=lzeQywqM8fmQCJxW7UwRoFlbVh21WUlhNYAC43iLGMk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l16fnI2289P4nbaswPaAqUEtLbJlvmgBiu4suVwJ9/XRiPo74YvG6QOr0ZTITxsId+bFRaHbGZzXxbMhwut+qjaK4D2VjnmrvckLQCtNUyoS06VWsHCpOCX0sCVLqpeyCql1bFQkCEXzgqRogjfTLD1B3cKEzcSGqC5j0un2/lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EHIbsie7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756223749; x=1787759749;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lzeQywqM8fmQCJxW7UwRoFlbVh21WUlhNYAC43iLGMk=;
  b=EHIbsie7BmWSy6g/uDlHzqJAJAdvEMbPBo/cf8p4iP2Z65nKtPJHrtEF
   1z3PkCZnE/iXgreqo8tgYdGTG9VUh9moz6Kt1qaIA2QSj2P928KTkERiq
   oT676+ZQg/ltAA7ibvA0Fp/Lgj3yWePx9EjHkmAbgikZGSbraLp61bepJ
   6jNjAMU5ApgkpDH+b+2HsUUMeF0lKTIE6lnN4RW2pGTPR/TzmYrb30faR
   vGHKTffIWPStovL6TB1/yaDvlkfrYutBKH96pg4Bgeld4LPP8RUPgRSIa
   39kmFj7NOCFFZAeA/j2RknWDb1Nz047tIoR+QxSld13B6sSGk77HPYPIv
   A==;
X-CSE-ConnectionGUID: I32S4GMgTeqbf8C033EkvA==
X-CSE-MsgGUID: TyLGhZl7S6+gOXaan5TI9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62108425"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62108425"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:41 -0700
X-CSE-ConnectionGUID: uNGVUeN2QLKvdEYHHGUQsA==
X-CSE-MsgGUID: 5venGNewThCvueT7XWq4SA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169218278"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:40 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 08/15] wifi: iwlwifi: mvm: remove d3 test code
Date: Tue, 26 Aug 2025 18:54:57 +0300
Message-Id: <20250826184046.6727aba3f4cf.I5d702f3fd031c52629c9fd8a3f4835c892f7543a@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
References: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This is no longer needed. Remove it from mvm, and a later patch will
remove it from the transport layer.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 188 ++----------------
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   1 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   3 -
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  10 -
 4 files changed, 20 insertions(+), 182 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 198a280b60f9..9b1e96f1767f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -1242,15 +1242,14 @@ static void iwl_mvm_free_nd(struct iwl_mvm *mvm)
 }
 
 static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
-			     struct cfg80211_wowlan *wowlan,
-			     bool test)
+			     struct cfg80211_wowlan *wowlan)
 {
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	struct ieee80211_vif *vif = NULL;
 	struct iwl_mvm_vif *mvmvif = NULL;
 	struct ieee80211_sta *ap_sta = NULL;
 	struct iwl_mvm_vif_link_info *mvm_link;
-	struct iwl_d3_manager_config d3_cfg_cmd_data = {
+	struct iwl_d3_manager_config d3_cfg_cmd = {
 		/*
 		 * Program the minimum sleep time to 10 seconds, as many
 		 * platforms have issues processing a wakeup signal while
@@ -1258,23 +1257,14 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 		 */
 		.min_sleep_time = cpu_to_le32(10 * 1000 * 1000),
 	};
-	struct iwl_host_cmd d3_cfg_cmd = {
-		.id = D3_CONFIG_CMD,
-		.flags = CMD_WANT_SKB,
-		.data[0] = &d3_cfg_cmd_data,
-		.len[0] = sizeof(d3_cfg_cmd_data),
-	};
 	int ret;
 	int len __maybe_unused;
 	bool unified_image = fw_has_capa(&mvm->fw->ucode_capa,
 					 IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
 
 	if (!wowlan) {
-		/*
-		 * mac80211 shouldn't get here, but for D3 test
-		 * it doesn't warrant a warning
-		 */
-		WARN_ON(!test);
+		/* mac80211 shouldn't get here */
+		WARN_ON(1);
 		return -EINVAL;
 	}
 
@@ -1351,7 +1341,7 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	if (mvm->d3_wake_sysassert)
-		d3_cfg_cmd_data.wakeup_flags |=
+		d3_cfg_cmd.wakeup_flags |=
 			cpu_to_le32(IWL_WAKEUP_D3_CONFIG_FW_ERROR);
 #endif
 
@@ -1364,21 +1354,14 @@ static int __iwl_mvm_suspend(struct ieee80211_hw *hw,
 		iwl_fw_dbg_stop_restart_recording(&mvm->fwrt, NULL, true);
 
 	/* must be last -- this switches firmware state */
-	ret = iwl_mvm_send_cmd(mvm, &d3_cfg_cmd);
+	ret = iwl_mvm_send_cmd_pdu(mvm, D3_CONFIG_CMD, 0, sizeof(d3_cfg_cmd),
+				   &d3_cfg_cmd);
 	if (ret)
 		goto out;
-#ifdef CONFIG_IWLWIFI_DEBUGFS
-	len = iwl_rx_packet_payload_len(d3_cfg_cmd.resp_pkt);
-	if (len >= sizeof(u32)) {
-		mvm->d3_test_pme_ptr =
-			le32_to_cpup((__le32 *)d3_cfg_cmd.resp_pkt->data);
-	}
-#endif
-	iwl_free_resp(&d3_cfg_cmd);
 
 	clear_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status);
 
-	ret = iwl_trans_d3_suspend(mvm->trans, test, !unified_image);
+	ret = iwl_trans_d3_suspend(mvm->trans, false, !unified_image);
  out:
 	if (ret < 0) {
 		iwl_mvm_free_nd(mvm);
@@ -1401,7 +1384,7 @@ int iwl_mvm_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wowlan)
 	iwl_fw_runtime_suspend(&mvm->fwrt);
 	mutex_unlock(&mvm->mutex);
 
-	return __iwl_mvm_suspend(hw, wowlan, false);
+	return __iwl_mvm_suspend(hw, wowlan);
 }
 
 struct iwl_multicast_key_data {
@@ -2590,7 +2573,6 @@ enum iwl_d3_notif {
 /* manage d3 resume data */
 struct iwl_d3_data {
 	struct iwl_wowlan_status_data *status;
-	bool test;
 	u32 d3_end_flags;
 	u32 notif_expected;	/* bitmap - see &enum iwl_d3_notif */
 	u32 notif_received;	/* bitmap - see &enum iwl_d3_notif */
@@ -2782,18 +2764,11 @@ iwl_mvm_choose_query_wakeup_reasons(struct iwl_mvm *mvm,
 
 	if (mvm->net_detect) {
 		iwl_mvm_query_netdetect_reasons(mvm, vif, d3_data);
-	} else {
-		bool keep = iwl_mvm_query_wakeup_reasons(mvm, vif,
-							 d3_data->status);
-
-#ifdef CONFIG_IWLWIFI_DEBUGFS
-		if (keep)
-			mvm->keep_vif = vif;
-#endif
-
-		return keep;
+		return false;
 	}
-	return false;
+
+	return iwl_mvm_query_wakeup_reasons(mvm, vif,
+					    d3_data->status);
 }
 
 #define IWL_WOWLAN_WAKEUP_REASON_HAS_WAKEUP_PKT (IWL_WOWLAN_WAKEUP_BY_MAGIC_PACKET | \
@@ -3006,7 +2981,7 @@ static bool iwl_mvm_wait_d3_notif(struct iwl_notif_wait_data *notif_wait,
 	return d3_data->notif_received == d3_data->notif_expected;
 }
 
-static int iwl_mvm_resume_firmware(struct iwl_mvm *mvm, bool test)
+static int iwl_mvm_resume_firmware(struct iwl_mvm *mvm)
 {
 	int ret;
 	enum iwl_d3_status d3_status;
@@ -3017,7 +2992,7 @@ static int iwl_mvm_resume_firmware(struct iwl_mvm *mvm, bool test)
 	bool reset = fw_has_capa(&mvm->fw->ucode_capa,
 				 IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
 
-	ret = iwl_trans_d3_resume(mvm->trans, &d3_status, test, !reset);
+	ret = iwl_trans_d3_resume(mvm->trans, &d3_status, false, !reset);
 	if (ret)
 		return ret;
 
@@ -3070,7 +3045,7 @@ static int iwl_mvm_d3_notif_wait(struct iwl_mvm *mvm,
 					   ARRAY_SIZE(d3_resume_notif),
 					   iwl_mvm_wait_d3_notif, d3_data);
 
-	ret = iwl_mvm_resume_firmware(mvm, d3_data->test);
+	ret = iwl_mvm_resume_firmware(mvm);
 	if (ret) {
 		iwl_remove_notification(&mvm->notif_wait, &wait_d3_notif);
 		return ret;
@@ -3090,13 +3065,12 @@ static inline bool iwl_mvm_d3_resume_notif_based(struct iwl_mvm *mvm)
 					D3_END_NOTIFICATION, 0);
 }
 
-static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
+static int __iwl_mvm_resume(struct iwl_mvm *mvm)
 {
 	struct ieee80211_vif *vif = NULL;
 	int ret = 1;
 	struct iwl_mvm_nd_results results = {};
 	struct iwl_d3_data d3_data = {
-		.test = test,
 		.notif_expected =
 			IWL_D3_NOTIF_WOWLAN_INFO |
 			IWL_D3_NOTIF_D3_END_NOTIF,
@@ -3161,7 +3135,7 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 		if (ret)
 			goto err;
 	} else {
-		ret = iwl_mvm_resume_firmware(mvm, test);
+		ret = iwl_mvm_resume_firmware(mvm);
 		if (ret < 0)
 			goto err;
 	}
@@ -3207,7 +3181,7 @@ static int __iwl_mvm_resume(struct iwl_mvm *mvm, bool test)
 	kfree(d3_data.status);
 	iwl_mvm_free_nd(mvm);
 
-	if (!d3_data.test && !mvm->net_detect)
+	if (!mvm->net_detect)
 		ieee80211_iterate_active_interfaces_mtx(mvm->hw,
 							IEEE80211_IFACE_ITER_NORMAL,
 							iwl_mvm_d3_disconnect_iter,
@@ -3246,7 +3220,7 @@ int iwl_mvm_resume(struct ieee80211_hw *hw)
 	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
 	int ret;
 
-	ret = __iwl_mvm_resume(mvm, false);
+	ret = __iwl_mvm_resume(mvm);
 
 	iwl_mvm_resume_tcm(mvm);
 
@@ -3334,125 +3308,3 @@ int iwl_mvm_fast_resume(struct iwl_mvm *mvm)
 
 	return ret;
 }
-
-#ifdef CONFIG_IWLWIFI_DEBUGFS
-static int iwl_mvm_d3_test_open(struct inode *inode, struct file *file)
-{
-	struct iwl_mvm *mvm = inode->i_private;
-	int err;
-
-	if (mvm->d3_test_active)
-		return -EBUSY;
-
-	file->private_data = inode->i_private;
-
-	iwl_mvm_pause_tcm(mvm, true);
-
-	iwl_fw_runtime_suspend(&mvm->fwrt);
-
-	/* start pseudo D3 */
-	rtnl_lock();
-	wiphy_lock(mvm->hw->wiphy);
-	err = __iwl_mvm_suspend(mvm->hw, mvm->hw->wiphy->wowlan_config, true);
-	wiphy_unlock(mvm->hw->wiphy);
-	rtnl_unlock();
-	if (err > 0)
-		err = -EINVAL;
-	if (err)
-		return err;
-
-	mvm->d3_test_active = true;
-	mvm->keep_vif = NULL;
-	return 0;
-}
-
-static ssize_t iwl_mvm_d3_test_read(struct file *file, char __user *user_buf,
-				    size_t count, loff_t *ppos)
-{
-	struct iwl_mvm *mvm = file->private_data;
-	unsigned long end = jiffies + 60 * HZ;
-	u32 pme_asserted;
-
-	while (true) {
-		/* read pme_ptr if available */
-		if (mvm->d3_test_pme_ptr) {
-			pme_asserted = iwl_trans_read_mem32(mvm->trans,
-						mvm->d3_test_pme_ptr);
-			if (pme_asserted)
-				break;
-		}
-
-		if (msleep_interruptible(100))
-			break;
-
-		if (time_is_before_jiffies(end)) {
-			IWL_ERR(mvm,
-				"ending pseudo-D3 with timeout after ~60 seconds\n");
-			return -ETIMEDOUT;
-		}
-	}
-
-	return 0;
-}
-
-static void iwl_mvm_d3_test_disconn_work_iter(void *_data, u8 *mac,
-					      struct ieee80211_vif *vif)
-{
-	/* skip the one we keep connection on */
-	if (_data == vif)
-		return;
-
-	if (vif->type == NL80211_IFTYPE_STATION)
-		ieee80211_connection_loss(vif);
-}
-
-static int iwl_mvm_d3_test_release(struct inode *inode, struct file *file)
-{
-	struct iwl_mvm *mvm = inode->i_private;
-	bool unified_image = fw_has_capa(&mvm->fw->ucode_capa,
-					 IWL_UCODE_TLV_CAPA_CNSLDTD_D3_D0_IMG);
-
-	mvm->d3_test_active = false;
-
-	iwl_fw_dbg_read_d3_debug_data(&mvm->fwrt);
-
-	rtnl_lock();
-	wiphy_lock(mvm->hw->wiphy);
-	__iwl_mvm_resume(mvm, true);
-	wiphy_unlock(mvm->hw->wiphy);
-	rtnl_unlock();
-
-	iwl_mvm_resume_tcm(mvm);
-
-	iwl_fw_runtime_resume(&mvm->fwrt);
-
-	iwl_abort_notification_waits(&mvm->notif_wait);
-	if (!unified_image) {
-		int remaining_time = 10;
-
-		ieee80211_restart_hw(mvm->hw);
-
-		/* wait for restart and disconnect all interfaces */
-		while (test_bit(IWL_MVM_STATUS_IN_HW_RESTART, &mvm->status) &&
-		       remaining_time > 0) {
-			remaining_time--;
-			msleep(1000);
-		}
-
-		if (remaining_time == 0)
-			IWL_ERR(mvm, "Timed out waiting for HW restart!\n");
-	}
-
-	ieee80211_iterate_active_interfaces_atomic(
-		mvm->hw, IEEE80211_IFACE_ITER_NORMAL,
-		iwl_mvm_d3_test_disconn_work_iter, mvm->keep_vif);
-
-	return 0;
-}
-
-const struct file_operations iwl_dbgfs_d3_test_ops = {
-	.open = iwl_mvm_d3_test_open,
-	.read = iwl_mvm_d3_test_read,
-	.release = iwl_mvm_d3_test_release,
-};
-#endif
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
index f0e184c8a81a..289a0db1f91f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c
@@ -2159,7 +2159,6 @@ void iwl_mvm_dbgfs_register(struct iwl_mvm *mvm)
 	MVM_DEBUGFS_ADD_FILE(uapsd_noagg_bssids, mvm->debugfs_dir, S_IRUSR);
 
 #ifdef CONFIG_PM_SLEEP
-	MVM_DEBUGFS_ADD_FILE(d3_test, mvm->debugfs_dir, 0400);
 	debugfs_create_bool("d3_wake_sysassert", 0600, mvm->debugfs_dir,
 			    &mvm->d3_wake_sysassert);
 	debugfs_create_u32("last_netdetect_scans", 0400, mvm->debugfs_dir,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index f02da4e0380f..b515028adc8f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1119,9 +1119,6 @@ struct iwl_mvm {
 	u8 offload_tid;
 #ifdef CONFIG_IWLWIFI_DEBUGFS
 	bool d3_wake_sysassert;
-	bool d3_test_active;
-	u32 d3_test_pme_ptr;
-	struct ieee80211_vif *keep_vif;
 	u32 last_netdetect_scans; /* no. of scans in the last net-detect wake */
 #endif
 #endif
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 62da0132f383..22602c32faa5 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -22,11 +22,6 @@ int iwl_mvm_send_cmd(struct iwl_mvm *mvm, struct iwl_host_cmd *cmd)
 {
 	int ret;
 
-#if defined(CONFIG_IWLWIFI_DEBUGFS) && defined(CONFIG_PM_SLEEP)
-	if (WARN_ON(mvm->d3_test_active))
-		return -EIO;
-#endif
-
 	/*
 	 * Synchronous commands from this op-mode must hold
 	 * the mutex, this ensures we don't try to send two
@@ -79,11 +74,6 @@ int iwl_mvm_send_cmd_status(struct iwl_mvm *mvm, struct iwl_host_cmd *cmd,
 
 	lockdep_assert_held(&mvm->mutex);
 
-#if defined(CONFIG_IWLWIFI_DEBUGFS) && defined(CONFIG_PM_SLEEP)
-	if (WARN_ON(mvm->d3_test_active))
-		return -EIO;
-#endif
-
 	/*
 	 * Only synchronous commands can wait for status,
 	 * we use WANT_SKB so the caller can't.
-- 
2.34.1


