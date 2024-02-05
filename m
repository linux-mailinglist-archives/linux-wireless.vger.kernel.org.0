Return-Path: <linux-wireless+bounces-3169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E678084A6D6
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 22:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FBFC291524
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 21:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD4C58212;
	Mon,  5 Feb 2024 19:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4iyQeAX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C119F58222
	for <linux-wireless@vger.kernel.org>; Mon,  5 Feb 2024 19:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707160910; cv=none; b=DuejN3dlsbUTwxmV+26mccjlUqDJeF2fokLMT2y1Vg+e6M3Qk2OeBjC2QT6SmjB5P6/lDUY98VnuC7L2j7ovpdMPu9SCH144WIlq8V+9qeNr/9emqH76O5F+36wu6tdvyGXukYE6M42C/krtrLifYx4p6afzhI9WpOoy9IJmKQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707160910; c=relaxed/simple;
	bh=KeiLr04OgiF0V18B+twugtnCZuskrrqhWdOW3eM6tzc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HJr2oOawH681FSfSGcl2Fdu7qKMTTXw5Mj3nuMhsU1G5md5b0o/tMv+5UIUscMN0pQOigZqhi0FqPElDBjaYlQ5t3qFCIPYLQ/ECd12ALO6FHccJC16NFZseuwX68Z975JAwGZJTlQfVgUBfK47z4VZXKH8BtxpXzrJAyYXUsxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4iyQeAX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707160908; x=1738696908;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KeiLr04OgiF0V18B+twugtnCZuskrrqhWdOW3eM6tzc=;
  b=V4iyQeAX6+TPBHBXANR/CHAqDck9UQIWAOQAw1iqQY5fVa8QJt8b+NWz
   0aJDnHMkC/bJXlHextbnH68hyRgxEHm7qJzk2YQ3vHqnyPI3Lkl8smsJJ
   GV56uZRvQ08us6HZ3BjTOPZ5xCwxVug6w94fdZ8FW7TyOHtKdv/QUPNJi
   r1Y1kBgFNb7R0u9HqRaEATvjKMh6tvpJoQIB9+VJC0bZrAO8maTFJrVZ7
   N08V0yfHrZ4xTY5VSHt5c6v7yP+Dl/v9yH1pqnBMpRFusytLNKLU+C6xs
   st60WoWqllD4EUFpNr+9LSasoEncpmO+HXyeSRZKHL3gDs8un2xGhiwZj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4381602"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4381602"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:21:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5403116"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 11:21:48 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 06/15] wifi: iwlwifi: mvm: remove IWL_MVM_STATUS_NEED_FLUSH_P2P
Date: Mon,  5 Feb 2024 21:21:06 +0200
Message-Id: <20240205211151.0494f75de311.Ic4aacacf7581a5c9046c4f1df87cbb67470853e7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
References: <20240205192115.2320146-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This is set when a P2P ROC ends, and uses as an indication inside
iwl_mvm_roc_done_wk that the resources used for this ROC (sta/link)
needs to be flushed/deactivated (respectively).
But we also have IWL_MVM_STATUS_ROC_RUNNING, which is set whenever
P2P ROC starts, and is not even used in iwl_mvm_roc_done_wk.
Use IWL_MVM_STATUS_ROC_RUNNING as an indicator, and remove the redundant
bit.
While at it, add a call to synchronize_net also for the
AUX ROC case, which is missing in the existing code.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  4 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   | 89 ++++++++-----------
 2 files changed, 38 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 37195cb5f70b..167e4acd093a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
 /*
- * Copyright (C) 2012-2014, 2018-2023 Intel Corporation
+ * Copyright (C) 2012-2014, 2018-2024 Intel Corporation
  * Copyright (C) 2013-2015 Intel Mobile Communications GmbH
  * Copyright (C) 2016-2017 Intel Deutschland GmbH
  */
@@ -1220,7 +1220,6 @@ struct iwl_mvm {
  * @IWL_MVM_STATUS_IN_HW_RESTART: HW restart is active
  * @IWL_MVM_STATUS_ROC_AUX_RUNNING: AUX remain-on-channel is running
  * @IWL_MVM_STATUS_FIRMWARE_RUNNING: firmware is running
- * @IWL_MVM_STATUS_NEED_FLUSH_P2P: need to flush P2P bcast STA
  * @IWL_MVM_STATUS_IN_D3: in D3 (or at least about to go into it)
  * @IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE: suppress one error log
  *	if this is set, when intentionally triggered
@@ -1235,7 +1234,6 @@ enum iwl_mvm_status {
 	IWL_MVM_STATUS_IN_HW_RESTART,
 	IWL_MVM_STATUS_ROC_AUX_RUNNING,
 	IWL_MVM_STATUS_FIRMWARE_RUNNING,
-	IWL_MVM_STATUS_NEED_FLUSH_P2P,
 	IWL_MVM_STATUS_IN_D3,
 	IWL_MVM_STATUS_SUPPRESS_ERROR_LOG_ONCE,
 	IWL_MVM_STATUS_STARTING,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index c3518585c20e..658f6f20391c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -45,32 +45,24 @@ void iwl_mvm_te_clear_data(struct iwl_mvm *mvm,
 	te_data->link_id = -1;
 }
 
-void iwl_mvm_roc_done_wk(struct work_struct *wk)
+static void iwl_mvm_cleanup_roc(struct iwl_mvm *mvm)
 {
-	struct iwl_mvm *mvm = container_of(wk, struct iwl_mvm, roc_done_wk);
-
 	/*
 	 * Clear the ROC_RUNNING status bit.
 	 * This will cause the TX path to drop offchannel transmissions.
 	 * That would also be done by mac80211, but it is racy, in particular
-	 * in the case that the time event actually completed in the firmware
-	 * (which is handled in iwl_mvm_te_handle_notif).
-	 */
-	clear_bit(IWL_MVM_STATUS_ROC_RUNNING, &mvm->status);
-
-	synchronize_net();
-
-	/*
-	 * Flush the offchannel queue -- this is called when the time
+	 * in the case that the time event actually completed in the firmware.
+	 *
+	 * Also flush the offchannel queue -- this is called when the time
 	 * event finishes or is canceled, so that frames queued for it
 	 * won't get stuck on the queue and be transmitted in the next
 	 * time event.
 	 */
-
-	mutex_lock(&mvm->mutex);
-	if (test_and_clear_bit(IWL_MVM_STATUS_NEED_FLUSH_P2P, &mvm->status)) {
+	if (test_and_clear_bit(IWL_MVM_STATUS_ROC_RUNNING, &mvm->status)) {
 		struct iwl_mvm_vif *mvmvif;
 
+		synchronize_net();
+
 		/*
 		 * NB: access to this pointer would be racy, but the flush bit
 		 * can only be set when we had a P2P-Device VIF, and we have a
@@ -105,21 +97,16 @@ void iwl_mvm_roc_done_wk(struct work_struct *wk)
 		}
 	}
 
-	/*
-	 * Clear the ROC_AUX_RUNNING status bit.
-	 * This will cause the TX path to drop offchannel transmissions.
-	 * That would also be done by mac80211, but it is racy, in particular
-	 * in the case that the time event actually completed in the firmware
-	 * (which is handled in iwl_mvm_te_handle_notif).
-	 */
+	/* Do the same for AUX ROC */
 	if (test_and_clear_bit(IWL_MVM_STATUS_ROC_AUX_RUNNING, &mvm->status)) {
-		/* do the same in case of hot spot 2.0 */
+		synchronize_net();
+
 		iwl_mvm_flush_sta(mvm, mvm->aux_sta.sta_id,
 				  mvm->aux_sta.tfd_queue_msk);
 
 		if (mvm->mld_api_is_used) {
 			iwl_mvm_mld_rm_aux_sta(mvm);
-			goto out_unlock;
+			return;
 		}
 
 		/* In newer version of this command an aux station is added only
@@ -128,8 +115,14 @@ void iwl_mvm_roc_done_wk(struct work_struct *wk)
 		if (iwl_mvm_has_new_station_api(mvm->fw))
 			iwl_mvm_rm_aux_sta(mvm);
 	}
+}
 
-out_unlock:
+void iwl_mvm_roc_done_wk(struct work_struct *wk)
+{
+	struct iwl_mvm *mvm = container_of(wk, struct iwl_mvm, roc_done_wk);
+
+	mutex_lock(&mvm->mutex);
+	iwl_mvm_cleanup_roc(mvm);
 	mutex_unlock(&mvm->mutex);
 }
 
@@ -294,18 +287,6 @@ static void iwl_mvm_te_check_trigger(struct iwl_mvm *mvm,
 	}
 }
 
-static void iwl_mvm_p2p_roc_finished(struct iwl_mvm *mvm)
-{
-	/*
-	 * If the IWL_MVM_STATUS_NEED_FLUSH_P2P is already set, then the
-	 * roc_done_wk is already scheduled or running, so don't schedule it
-	 * again to avoid a race where the roc_done_wk clears this bit after
-	 * it is set here, affecting the next run of the roc_done_wk.
-	 */
-	if (!test_and_set_bit(IWL_MVM_STATUS_NEED_FLUSH_P2P, &mvm->status))
-		iwl_mvm_roc_finished(mvm);
-}
-
 /*
  * Handles a FW notification for an event that is known to the driver.
  *
@@ -357,7 +338,7 @@ static void iwl_mvm_te_handle_notif(struct iwl_mvm *mvm,
 		switch (te_data->vif->type) {
 		case NL80211_IFTYPE_P2P_DEVICE:
 			ieee80211_remain_on_channel_expired(mvm->hw);
-			iwl_mvm_p2p_roc_finished(mvm);
+			iwl_mvm_roc_finished(mvm);
 			break;
 		case NL80211_IFTYPE_STATION:
 			/*
@@ -782,7 +763,7 @@ static bool __iwl_mvm_remove_time_event(struct iwl_mvm *mvm,
 			iwl_mvm_cancel_session_protection(mvm, vif, id,
 							  link_id);
 			if (iftype == NL80211_IFTYPE_P2P_DEVICE) {
-				iwl_mvm_p2p_roc_finished(mvm);
+				iwl_mvm_roc_finished(mvm);
 			}
 		}
 		return false;
@@ -972,7 +953,7 @@ void iwl_mvm_rx_session_protect_notif(struct iwl_mvm *mvm,
 		/* End TE, notify mac80211 */
 		mvmvif->time_event_data.id = SESSION_PROTECT_CONF_MAX_ID;
 		mvmvif->time_event_data.link_id = -1;
-		iwl_mvm_p2p_roc_finished(mvm);
+		iwl_mvm_roc_finished(mvm);
 		ieee80211_remain_on_channel_expired(mvm->hw);
 	} else if (le32_to_cpu(notif->start)) {
 		if (WARN_ON(mvmvif->time_event_data.id !=
@@ -1244,17 +1225,13 @@ void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 			IWL_UCODE_TLV_CAPA_SESSION_PROT_CMD)) {
 		mvmvif = iwl_mvm_vif_from_mac80211(vif);
 
-		if (vif->type == NL80211_IFTYPE_P2P_DEVICE) {
+		if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
 			iwl_mvm_cancel_session_protection(mvm, vif,
 							  mvmvif->time_event_data.id,
 							  mvmvif->time_event_data.link_id);
-			iwl_mvm_p2p_roc_finished(mvm);
-		} else {
+		else
 			iwl_mvm_roc_station_remove(mvm, mvmvif);
-			iwl_mvm_roc_finished(mvm);
-		}
-
-		return;
+		goto cleanup_roc;
 	}
 
 	te_data = iwl_mvm_get_roc_te(mvm);
@@ -1265,13 +1242,21 @@ void iwl_mvm_stop_roc(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	mvmvif = iwl_mvm_vif_from_mac80211(te_data->vif);
 
-	if (te_data->vif->type == NL80211_IFTYPE_P2P_DEVICE) {
+	if (te_data->vif->type == NL80211_IFTYPE_P2P_DEVICE)
 		iwl_mvm_remove_time_event(mvm, mvmvif, te_data);
-		iwl_mvm_p2p_roc_finished(mvm);
-	} else {
+	else
 		iwl_mvm_remove_aux_roc_te(mvm, mvmvif, te_data);
-		iwl_mvm_roc_finished(mvm);
-	}
+
+cleanup_roc:
+	/*
+	 * In case we get here before the ROC event started,
+	 * (so the status bit isn't set) set it here so iwl_mvm_cleanup_roc will
+	 * cleanup things properly
+	 */
+	set_bit(vif->type == NL80211_IFTYPE_P2P_DEVICE ?
+		IWL_MVM_STATUS_ROC_RUNNING : IWL_MVM_STATUS_ROC_AUX_RUNNING,
+		&mvm->status);
+	iwl_mvm_cleanup_roc(mvm);
 }
 
 void iwl_mvm_remove_csa_period(struct iwl_mvm *mvm,
-- 
2.34.1


