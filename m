Return-Path: <linux-wireless+bounces-7204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5338BC804
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 09:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800651C212CF
	for <lists+linux-wireless@lfdr.de>; Mon,  6 May 2024 07:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6A25337A;
	Mon,  6 May 2024 07:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atqjDKEf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6317A6BFD4
	for <linux-wireless@vger.kernel.org>; Mon,  6 May 2024 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979092; cv=none; b=F6hE9dlmp/8VqULH8YIleGE730iRmgkdxaAsXCj1j5Q0X2XkWVpbb+qHQeYL+36O3/oXMvCFzZdQlWD3wq64undKsRn7aTMC8XkicuVrc8hp6T1W4Vbhe1jFgj4STo1EafWnFgZSs+qJq1xDNBjNTk3T7VHUpcVgofhFxLgmlrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979092; c=relaxed/simple;
	bh=6mbx6aXnDh3aO1zM2Yii8Ssp7YCaKk5LCrFOYjkOa6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WD3U+uXe6hH7Go2dOMBAyQM/R5GWOgyjZFs0JcqlvV9w2C68UD/u7yYBFiTgmi1Qu1ONfa4IE40A5/9j0kM/nKGFoS4yZAdgfHMcSohNk9yUIgAc9Pod58kuo4Yni3BYFlbDhTJswF2bc32BgKmlO1mniAa6adhgvo0ENJNcoWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atqjDKEf; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714979091; x=1746515091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6mbx6aXnDh3aO1zM2Yii8Ssp7YCaKk5LCrFOYjkOa6Q=;
  b=atqjDKEfzePiTWnbmWPDs554W073L+s3qAacHmRFxNDFe4uut2fJScJS
   AdgLiGmFXE8EkHBiAsxUuio64jWJq6KioDeSwmBdzpr1SiOQt5kL5tO68
   ZFafkRTNrf4nUwY2QxH7ZipZCkvXinM6nldhBHwASvbteXUxPsG6SeMYp
   wm7MwI0zs1tEnee20uk9Jj9OAfC8m6cOkAZ4JR25rzwDs0ZR/MvPkx20/
   etpef3EEZmWdt96LH9c7SU/+3thvANgkQZKIEX4fwN34ERPINIANnXy37
   srg0LshvRtUTDxa7r6TEQcJTaK4KO5RXuOCXhjbSYg1IbtT1uXr4dCzak
   g==;
X-CSE-ConnectionGUID: v19wHC6vQM+6sA8lR56i6g==
X-CSE-MsgGUID: ak2yeC7wRamLkifndoTK3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11064"; a="10638207"
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="10638207"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:43 -0700
X-CSE-ConnectionGUID: LKLER9tRSmasPOD7edo76g==
X-CSE-MsgGUID: sr0TcyoBTQG3RgDQJ0GChA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,257,1708416000"; 
   d="scan'208";a="59264928"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2024 00:04:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 07/15] wifi: iwlwifi: mvm: Fix race in scan completion
Date: Mon,  6 May 2024 10:04:11 +0300
Message-Id: <20240506095953.1f484a86324b.I63ed445a47f144546948c74ae6df85587fdb4ce3@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
References: <20240506070419.1821330-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

The move of the scan complete notification handling to the wiphy worker
introduced a race between scan complete notification and scan abort:

- The wiphy lock is held, e.g., for rfkill handling etc.
- Scan complete notification is received but not handled yet.
- Scan abort is triggered, and scan abort is sent to the FW. Once the
  scan abort command is sent successfully, the flow synchronously waits
  for the scan complete notification. However, as the scan complete
  notification was already received but not processed yet, this hangs for
  a second and continues leaving the scan status in an inconsistent
  state.
- Once scan complete handling is started (when the wiphy lock is not held)
  since the scan status is not an inconsistent state, a warning is issued
  and the scan complete notification is not handled.

To fix this issue, switch back the scan complete notification to be
asynchronously handling, and only move the link selection logic to
a worker (which was the original reason for the move to use wiphy lock).

While at it, refactor some prints to improve debug data.

Fixes: 07bf5297d392 ("wifi: iwlwifi: mvm: Implement new link selection algorithm")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  2 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 27 +++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 54 +++++++++----------
 4 files changed, 55 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 57a0d8af9b28..fb49deda3346 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1350,6 +1350,7 @@ void iwl_mvm_mac_stop(struct ieee80211_hw *hw)
 	iwl_mvm_scan_stop(mvm, IWL_MVM_SCAN_INT_MLO, false);
 	mutex_unlock(&mvm->mutex);
 
+	wiphy_work_cancel(mvm->hw->wiphy, &mvm->trig_link_selection_wk);
 	wiphy_work_flush(mvm->hw->wiphy, &mvm->async_handlers_wiphy_wk);
 	flush_work(&mvm->async_handlers_wk);
 	flush_work(&mvm->add_stream_wk);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index cb4088149d85..b292276de4ae 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -937,6 +937,8 @@ struct iwl_mvm {
 	/* For async rx handlers that require the wiphy lock */
 	struct wiphy_work async_handlers_wiphy_wk;
 
+	struct wiphy_work trig_link_selection_wk;
+
 	struct work_struct roc_done_wk;
 
 	unsigned long init_status;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 155a44e8ab07..b27a03207938 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -383,7 +383,7 @@ static const struct iwl_rx_handlers iwl_mvm_rx_handlers[] = {
 			   iwl_mvm_rx_scan_match_found,
 			   RX_HANDLER_SYNC),
 	RX_HANDLER(SCAN_COMPLETE_UMAC, iwl_mvm_rx_umac_scan_complete_notif,
-		   RX_HANDLER_ASYNC_LOCKED_WIPHY,
+		   RX_HANDLER_ASYNC_LOCKED,
 		   struct iwl_umac_scan_complete),
 	RX_HANDLER(SCAN_ITERATION_COMPLETE_UMAC,
 		   iwl_mvm_rx_umac_scan_iter_complete_notif, RX_HANDLER_SYNC,
@@ -1171,6 +1171,27 @@ static const struct iwl_mei_ops mei_ops = {
 	.nic_stolen = iwl_mvm_mei_nic_stolen,
 };
 
+static void iwl_mvm_find_link_selection_vif(void *_data, u8 *mac,
+					    struct ieee80211_vif *vif)
+{
+	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+
+	if (ieee80211_vif_is_mld(vif) && mvmvif->authorized)
+		iwl_mvm_select_links(mvmvif->mvm, vif);
+}
+
+static void iwl_mvm_trig_link_selection(struct wiphy *wiphy,
+					struct wiphy_work *wk)
+{
+	struct iwl_mvm *mvm =
+		container_of(wk, struct iwl_mvm, trig_link_selection_wk);
+
+	ieee80211_iterate_active_interfaces(mvm->hw,
+					    IEEE80211_IFACE_ITER_NORMAL,
+					    iwl_mvm_find_link_selection_vif,
+					    NULL);
+}
+
 static struct iwl_op_mode *
 iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 		      const struct iwl_fw *fw, struct dentry *dbgfs_dir)
@@ -1302,6 +1323,10 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 
 	wiphy_work_init(&mvm->async_handlers_wiphy_wk,
 			iwl_mvm_async_handlers_wiphy_wk);
+
+	wiphy_work_init(&mvm->trig_link_selection_wk,
+			iwl_mvm_trig_link_selection);
+
 	init_waitqueue_head(&mvm->rx_sync_waitq);
 
 	mvm->queue_sync_state = 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 433280b3c03e..49ec515b5bad 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -3178,23 +3178,6 @@ int iwl_mvm_sched_scan_start(struct iwl_mvm *mvm,
 	return ret;
 }
 
-static void iwl_mvm_find_link_selection_vif(void *_data, u8 *mac,
-					    struct ieee80211_vif *vif)
-{
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-
-	if (ieee80211_vif_is_mld(vif) && mvmvif->authorized)
-		iwl_mvm_select_links(mvmvif->mvm, vif);
-}
-
-static void iwl_mvm_post_scan_link_selection(struct iwl_mvm *mvm)
-{
-	ieee80211_iterate_active_interfaces(mvm->hw,
-					    IEEE80211_IFACE_ITER_NORMAL,
-					    iwl_mvm_find_link_selection_vif,
-					    NULL);
-}
-
 void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 					 struct iwl_rx_cmd_buffer *rxb)
 {
@@ -3206,6 +3189,21 @@ void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 
 	mvm->mei_scan_filter.is_mei_limited_scan = false;
 
+	IWL_DEBUG_SCAN(mvm,
+		       "Scan completed: uid=%u type=%u, status=%s, EBS=%s\n",
+		       uid, mvm->scan_uid_status[uid],
+		       notif->status == IWL_SCAN_OFFLOAD_COMPLETED ?
+				"completed" : "aborted",
+		       iwl_mvm_ebs_status_str(notif->ebs_status));
+
+	IWL_DEBUG_SCAN(mvm, "Scan completed: scan_status=0x%x\n",
+		       mvm->scan_status);
+
+	IWL_DEBUG_SCAN(mvm,
+		       "Scan completed: line=%u, iter=%u, elapsed time=%u\n",
+		       notif->last_schedule, notif->last_iter,
+		       __le32_to_cpu(notif->time_from_last_iter));
+
 	if (WARN_ON(!(mvm->scan_uid_status[uid] & mvm->scan_status)))
 		return;
 
@@ -3244,16 +3242,9 @@ void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 	}
 
 	mvm->scan_status &= ~mvm->scan_uid_status[uid];
-	IWL_DEBUG_SCAN(mvm,
-		       "Scan completed, uid %u type %u, status %s, EBS status %s\n",
-		       uid, mvm->scan_uid_status[uid],
-		       notif->status == IWL_SCAN_OFFLOAD_COMPLETED ?
-				"completed" : "aborted",
-		       iwl_mvm_ebs_status_str(notif->ebs_status));
-	IWL_DEBUG_SCAN(mvm,
-		       "Last line %d, Last iteration %d, Time from last iteration %d\n",
-		       notif->last_schedule, notif->last_iter,
-		       __le32_to_cpu(notif->time_from_last_iter));
+
+	IWL_DEBUG_SCAN(mvm, "Scan completed: after update: scan_status=0x%x\n",
+		       mvm->scan_status);
 
 	if (notif->ebs_status != IWL_SCAN_EBS_SUCCESS &&
 	    notif->ebs_status != IWL_SCAN_EBS_INACTIVE)
@@ -3262,7 +3253,7 @@ void iwl_mvm_rx_umac_scan_complete_notif(struct iwl_mvm *mvm,
 	mvm->scan_uid_status[uid] = 0;
 
 	if (select_links)
-		iwl_mvm_post_scan_link_selection(mvm);
+		wiphy_work_queue(mvm->hw->wiphy, &mvm->trig_link_selection_wk);
 }
 
 void iwl_mvm_rx_umac_scan_iter_complete_notif(struct iwl_mvm *mvm,
@@ -3487,6 +3478,10 @@ int iwl_mvm_scan_stop(struct iwl_mvm *mvm, int type, bool notify)
 {
 	int ret;
 
+	IWL_DEBUG_SCAN(mvm,
+		       "Request to stop scan: type=0x%x, status=0x%x\n",
+		       type, mvm->scan_status);
+
 	if (!(mvm->scan_status & type))
 		return 0;
 
@@ -3498,6 +3493,9 @@ int iwl_mvm_scan_stop(struct iwl_mvm *mvm, int type, bool notify)
 	ret = iwl_mvm_scan_stop_wait(mvm, type);
 	if (!ret)
 		mvm->scan_status |= type << IWL_MVM_SCAN_STOPPING_SHIFT;
+	else
+		IWL_DEBUG_SCAN(mvm, "Failed to stop scan\n");
+
 out:
 	/* Clear the scan status so the next scan requests will
 	 * succeed and mark the scan as stopping, so that the Rx
-- 
2.34.1


