Return-Path: <linux-wireless+bounces-16831-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E819FD1BA
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 09:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5F2163E7D
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 08:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B71E14AD3D;
	Fri, 27 Dec 2024 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ghHxJMoK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7301B7083A
	for <linux-wireless@vger.kernel.org>; Fri, 27 Dec 2024 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286501; cv=none; b=reIgKNt8b4nRPLDPRY7YevF2BFfcAf3GKjBYzzcSz1U1kHfShdU8XbTPGvgueXFjg6zZVIRLLcTBPyLAKdgHV72KQYs5bQQ0Sm+uK1gPF2Re+GkdZ3zt2ikcgNONmZvAxiZjCLoKHkxbdnTEoikrwo5MXfKArFpEGnnT564XmKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286501; c=relaxed/simple;
	bh=ODRkovnb1kujw9VH74R/cFKQdM8A6Y+ABp8F0/B2j9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CB/UjRUJ/slkHaX2vW8TpPfoxHTAs3iaTeXQ+q86OchVmRUhtP0x8pFDx0iZnspPLxOFhsSkgXkYzfPzwyPt8gq1BLhbbA3lTfUCEKOpYPXKHWh4RTohdQY20qnOT7xZwAluniWHY5aoGWrC6xbx0tq7Z+kPbDJyyZqYLp6l8SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ghHxJMoK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735286499; x=1766822499;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ODRkovnb1kujw9VH74R/cFKQdM8A6Y+ABp8F0/B2j9k=;
  b=ghHxJMoKtZJ6Bv1PaYGTv8fYS/iFh8B/HIeyUYPc0AKH9x8glXJarvPt
   Na2HvtvvVgbVYgItKpokTV0FgS62Jjw4fKIM2YR9z94iCY5Ml38kVARnt
   qhrwVMWP7aWyPdJR0VhXHEeREiHEwT3TKRXJqcp4y4QOG0WxpMHKt2nbf
   Lymaq6p3x31wFlWuW7kVebneb9/9ROF4Gs3SNk3SpIQZ9ANygJCQxA8x2
   J3GOUnL4ytClSz51n/G+eD+kxr3XBX2VGmmw8PuTM6m8e0zhG4bym1nYR
   ySshlqDv8r+hAT0Nc7wlEuj6C2drdmBdJQDQahTMK8+L3E+4oLfUCD2PB
   g==;
X-CSE-ConnectionGUID: ewUIEiFlRbiAOiS+6kiLYg==
X-CSE-MsgGUID: 0wP9eoh1TjKnIu3AIVSwow==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46690952"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="46690952"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:39 -0800
X-CSE-ConnectionGUID: FiWPU2/AS/2yP5dwfssvNg==
X-CSE-MsgGUID: c5XKbPh2QwGhMKxSu89MJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="99858341"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:37 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 09/17] wifi: iwlwifi: return ERR_PTR from opmode start()
Date: Fri, 27 Dec 2024 10:01:04 +0200
Message-Id: <20241227095718.3fe5031d5784.I7307996c91dac69619ff9c616b8a077423fac19f@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
References: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

In order to restrict the retry loops for timeouts, first
pass the error code up using ERR_PTR(). This of course
requires all existing functions to be updated accordingly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/main.c | 34 ++++++++++++-------
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 24 +++++++++----
 3 files changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/main.c b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
index 2c4363662efd..4f5846953fa3 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/main.c
@@ -1241,7 +1241,7 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 		STATISTICS_NOTIFICATION,
 		REPLY_TX,
 	};
-	int i;
+	int i, err;
 
 	/************************
 	 * 1. Allocating HW data
@@ -1249,6 +1249,7 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	hw = iwl_alloc_all();
 	if (!hw) {
 		pr_err("%s: Cannot allocate network device\n", trans->name);
+		err = -ENOMEM;
 		goto out;
 	}
 
@@ -1299,8 +1300,10 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 		break;
 	}
 
-	if (WARN_ON(!priv->lib))
+	if (WARN_ON(!priv->lib)) {
+		err = -ENODEV;
 		goto out_free_hw;
+	}
 
 	/*
 	 * Populate the state variables that the transport layer needs
@@ -1377,12 +1380,14 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	IWL_INFO(priv, "Detected %s, REV=0x%X\n",
 		priv->trans->name, priv->trans->hw_rev);
 
-	if (iwl_trans_start_hw(priv->trans))
+	err = iwl_trans_start_hw(priv->trans);
+	if (err)
 		goto out_free_hw;
 
 	/* Read the EEPROM */
-	if (iwl_read_eeprom(priv->trans, &priv->eeprom_blob,
-			    &priv->eeprom_blob_size)) {
+	err = iwl_read_eeprom(priv->trans, &priv->eeprom_blob,
+			      &priv->eeprom_blob_size);
+	if (err) {
 		IWL_ERR(priv, "Unable to init EEPROM\n");
 		goto out_free_hw;
 	}
@@ -1393,13 +1398,17 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	priv->nvm_data = iwl_parse_eeprom_data(priv->trans, priv->cfg,
 					       priv->eeprom_blob,
 					       priv->eeprom_blob_size);
-	if (!priv->nvm_data)
+	if (!priv->nvm_data) {
+		err = -ENOMEM;
 		goto out_free_eeprom_blob;
+	}
 
-	if (iwl_nvm_check_version(priv->nvm_data, priv->trans))
+	err = iwl_nvm_check_version(priv->nvm_data, priv->trans);
+	if (err)
 		goto out_free_eeprom;
 
-	if (iwl_eeprom_init_hw_params(priv))
+	err = iwl_eeprom_init_hw_params(priv);
+	if (err)
 		goto out_free_eeprom;
 
 	/* extract MAC Address */
@@ -1446,7 +1455,8 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 		atomic_set(&priv->queue_stop_count[i], 0);
 	}
 
-	if (iwl_init_drv(priv))
+	err = iwl_init_drv(priv);
+	if (err)
 		goto out_free_eeprom;
 
 	/* At this point both hw and priv are initialized. */
@@ -1480,7 +1490,8 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 	 *
 	 * 7. Setup and register with mac80211 and debugfs
 	 **************************************************/
-	if (iwlagn_mac_setup_register(priv, &fw->ucode_capa))
+	err = iwlagn_mac_setup_register(priv, &fw->ucode_capa);
+	if (err)
 		goto out_destroy_workqueue;
 
 	iwl_dbgfs_register(priv, dbgfs_dir);
@@ -1500,8 +1511,7 @@ static struct iwl_op_mode *iwl_op_mode_dvm_start(struct iwl_trans *trans,
 out_free_hw:
 	ieee80211_free_hw(priv->hw);
 out:
-	op_mode = NULL;
-	return op_mode;
+	return ERR_PTR(err);
 }
 
 static void iwl_op_mode_dvm_stop(struct iwl_op_mode *op_mode)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index c620911a1193..d7bf996d3a82 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -1429,7 +1429,7 @@ _iwl_op_mode_start(struct iwl_drv *drv, struct iwlwifi_opmode_table *op)
 		op_mode = ops->start(drv->trans, drv->trans->cfg,
 				     &drv->fw, dbgfs_dir);
 
-		if (op_mode)
+		if (!IS_ERR(op_mode))
 			return op_mode;
 
 		if (test_bit(STATUS_TRANS_DEAD, &drv->trans->status))
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 06b05e076cd2..623122cadd32 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1285,6 +1285,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	size_t scan_size;
 	u32 min_backoff;
 	struct iwl_mvm_csme_conn_info *csme_conn_info __maybe_unused;
+	int err;
 
 	/*
 	 * We use IWL_STATION_COUNT_MAX to check the validity of the station
@@ -1302,7 +1303,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 				iwl_mvm_has_mld_api(fw) ? &iwl_mvm_mld_hw_ops :
 				&iwl_mvm_hw_ops);
 	if (!hw)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	if (trans->trans_cfg->device_family >= IWL_DEVICE_FAMILY_BZ)
 		max_agg = 512;
@@ -1347,8 +1348,10 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		trans->rx_mpdu_cmd_hdr_size =
 			sizeof(struct iwl_rx_mpdu_res_start);
 
-		if (WARN_ON(trans->num_rx_queues > 1))
+		if (WARN_ON(trans->num_rx_queues > 1)) {
+			err = -EINVAL;
 			goto out_free;
+		}
 	}
 
 	mvm->fw_restart = iwlwifi_mod_params.fw_restart ? -1 : 0;
@@ -1425,8 +1428,10 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		iwl_fw_lookup_notif_ver(mvm->fw, LOCATION_GROUP,
 					TOF_RANGE_RESPONSE_NOTIF, 5);
 	/* we only support up to version 9 */
-	if (WARN_ON_ONCE(mvm->cmd_ver.range_resp > 9))
+	if (WARN_ON_ONCE(mvm->cmd_ver.range_resp > 9)) {
+		err = -EINVAL;
 		goto out_free;
+	}
 
 	/*
 	 * Populate the state variables that the transport layer needs
@@ -1489,6 +1494,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	mvm->phy_db = iwl_phy_db_init(trans);
 	if (!mvm->phy_db) {
 		IWL_ERR(mvm, "Cannot init phy_db\n");
+		err = -ENOMEM;
 		goto out_free;
 	}
 
@@ -1501,8 +1507,10 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	scan_size = iwl_mvm_scan_size(mvm);
 
 	mvm->scan_cmd = kmalloc(scan_size, GFP_KERNEL);
-	if (!mvm->scan_cmd)
+	if (!mvm->scan_cmd) {
+		err = -ENOMEM;
 		goto out_free;
+	}
 	mvm->scan_cmd_size = scan_size;
 
 	/* invalidate ids to prevent accidental removal of sta_id 0 */
@@ -1531,7 +1539,8 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	iwl_mvm_mei_scan_filter_init(&mvm->mei_scan_filter);
 
-	if (iwl_mvm_start_get_nvm(mvm)) {
+	err = iwl_mvm_start_get_nvm(mvm);
+	if (err) {
 		/*
 		 * Getting NVM failed while CSME is the owner, but we are
 		 * registered to MEI, we'll get the NVM later when it'll be
@@ -1544,7 +1553,8 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	}
 
 
-	if (iwl_mvm_start_post_nvm(mvm))
+	err = iwl_mvm_start_post_nvm(mvm);
+	if (err)
 		goto out_thermal_exit;
 
 	return op_mode;
@@ -1564,7 +1574,7 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	iwl_trans_op_mode_leave(trans);
 
 	ieee80211_free_hw(mvm->hw);
-	return NULL;
+	return ERR_PTR(err);
 }
 
 void iwl_mvm_stop_device(struct iwl_mvm *mvm)
-- 
2.34.1


