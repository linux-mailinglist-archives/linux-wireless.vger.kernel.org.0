Return-Path: <linux-wireless+bounces-2410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B54EB839755
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 19:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D79B51C2690E
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jan 2024 18:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5166881ABD;
	Tue, 23 Jan 2024 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DQ2vSMHc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6E58121F
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jan 2024 18:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033371; cv=none; b=WwJkD8gpTI/Clquwjdk/NdCLOsS1i8337MvNU8SlWj4+vjqae6nUlYSEM72PNLruDVLIipwwDRIoHQ5T4l9JgW9moFuaW25So328zJ2/+bpPUYm+9bVKygZ+lfuJXa0hGbuZ1JXNHVWxRm+spJDxLAdfL3Z7IbYa+1vyoZ6X5DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033371; c=relaxed/simple;
	bh=TjYJys63FTdvf394fn7HBhzQcTcgyVVoYLhGL/WsS1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fIiIAht7X67TSixNJS5svxmE0PBb1sKY4IFzLtCAsnPbLVRA9qBhbSrPytNydP1fCpYl4O97dyEqqS34L3N0D3OePHw1lCS9XYh36oh2flnv2Ec3E9RocxH2fAPC/L6SVBPCs2nEfHHemJWUMkJ/6M/AzoALXCwDO3hM0frLnAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DQ2vSMHc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706033370; x=1737569370;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TjYJys63FTdvf394fn7HBhzQcTcgyVVoYLhGL/WsS1o=;
  b=DQ2vSMHclgnXJrcLh1xpyxYPq0xS2j51oUUizMhPuHNaYMNbOdk3wU/z
   nH9JPsKOOmeKuhnoQb2m/fE8GdkFTFzns1k97Ol0rlMOkhbLhPzwsabAq
   DhXTkYLgPZYxm2v0iG6muobkeJgU93dPJQ8fMlrpZIiOE0vIhMBBDY+y1
   aEQ5CJZMNfdIQttYLwy0m9OmwthWtQYsw7ckjK78WMYqIPhOckKCGroeO
   2jI1xXDZETqkicj0VNNXlxjqfM+v/M2Qud34VSJg9iYXeEZ5564urkrn1
   MZaeSSWdlNHpQ7WbQlE8L8AU4VHBo+H1w+5NYeJRimSgZG+yR6nRfdHtz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="502122"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="502122"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:09:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1666653"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 10:09:25 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 15/15] wifi: iwlwifi: add support for a wiphy_work rx handler
Date: Tue, 23 Jan 2024 20:08:23 +0200
Message-Id: <20240123200528.ce83d16cdec8.I35ef53fa23f58b9ec17924099238b61deafcecd7@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
References: <20240123180823.2441162-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

The wiphy_work infra ensures that the entire worker will run
with the wiphy mutex. It is useful to have RX handlers
running as a wiphy_work, when we don't want the handler to
run in parallel with mac80211 work (to avoid races).

For example - BT notification can disable eSR starting from the next
patch.
In ieee80211_set_active_links we first check that eSR is
allowed, (drv_can_activate_links) and then activate it.
If the BT notif was received after drv_can_activate_links
(which returned true), and before the activation - eSR will be
activated when it shouldn't.
If BT notif is handled with the wiphy mutex, it can't run in
parallel to ieee80211_set_active_links, which also holds that
mutex.

Add the necessary infrastructure here, for use in the next commit.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 61 +++++++++++++++----
 3 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index fbe65284f046..85be483b9b7d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1342,6 +1342,7 @@ void iwl_mvm_mac_stop(struct ieee80211_hw *hw)
 	 * discover that its list is now empty.
 	 */
 	cancel_work_sync(&mvm->async_handlers_wk);
+	wiphy_work_cancel(hw->wiphy, &mvm->async_handlers_wiphy_wk);
 }
 
 struct iwl_mvm_phy_ctxt *iwl_mvm_get_free_phy_ctxt(struct iwl_mvm *mvm)
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 997f0395b97a..af5c8b4bb5a6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -848,6 +848,9 @@ struct iwl_mvm {
 	spinlock_t async_handlers_lock;
 	struct work_struct async_handlers_wk;
 
+	/* For async rx handlers that require the wiphy lock */
+	struct wiphy_work async_handlers_wiphy_wk;
+
 	struct work_struct roc_done_wk;
 
 	unsigned long init_status;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index adbbe19aeae5..38a84a54ff78 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -267,11 +267,15 @@ static void iwl_mvm_rx_thermal_dual_chain_req(struct iwl_mvm *mvm,
  *	it will be called from a worker with mvm->mutex held.
  * @RX_HANDLER_ASYNC_UNLOCKED : in case the handler needs to lock the
  *	mutex itself, it will be called from a worker without mvm->mutex held.
+ * @RX_HANDLER_ASYNC_LOCKED_WIPHY: If the handler needs to hold the wiphy lock
+ *	and mvm->mutex. Will be handled with the wiphy_work queue infra
+ *	instead of regular work queue.
  */
 enum iwl_rx_handler_context {
 	RX_HANDLER_SYNC,
 	RX_HANDLER_ASYNC_LOCKED,
 	RX_HANDLER_ASYNC_UNLOCKED,
+	RX_HANDLER_ASYNC_LOCKED_WIPHY,
 };
 
 /**
@@ -673,6 +677,8 @@ static const struct iwl_hcmd_arr iwl_mvm_groups[] = {
 
 /* this forward declaration can avoid to export the function */
 static void iwl_mvm_async_handlers_wk(struct work_struct *wk);
+static void iwl_mvm_async_handlers_wiphy_wk(struct wiphy *wiphy,
+					    struct wiphy_work *work);
 
 static u32 iwl_mvm_min_backoff(struct iwl_mvm *mvm)
 {
@@ -1265,6 +1271,8 @@ iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
 	INIT_LIST_HEAD(&mvm->add_stream_txqs);
 	spin_lock_init(&mvm->add_stream_lock);
 
+	wiphy_work_init(&mvm->async_handlers_wiphy_wk,
+			iwl_mvm_async_handlers_wiphy_wk);
 	init_waitqueue_head(&mvm->rx_sync_waitq);
 
 	mvm->queue_sync_state = 0;
@@ -1551,35 +1559,62 @@ void iwl_mvm_async_handlers_purge(struct iwl_mvm *mvm)
 	spin_unlock_bh(&mvm->async_handlers_lock);
 }
 
-static void iwl_mvm_async_handlers_wk(struct work_struct *wk)
+/*
+ * This function receives a bitmap of rx async handler contexts
+ * (&iwl_rx_handler_context) to handle, and runs only them
+ */
+static void iwl_mvm_async_handlers_by_context(struct iwl_mvm *mvm,
+					      u8 contexts)
 {
-	struct iwl_mvm *mvm =
-		container_of(wk, struct iwl_mvm, async_handlers_wk);
 	struct iwl_async_handler_entry *entry, *tmp;
 	LIST_HEAD(local_list);
 
-	/* Ensure that we are not in stop flow (check iwl_mvm_mac_stop) */
-
 	/*
-	 * Sync with Rx path with a lock. Remove all the entries from this list,
-	 * add them to a local one (lock free), and then handle them.
+	 * Sync with Rx path with a lock. Remove all the entries of the
+	 * wanted contexts from this list, add them to a local one (lock free),
+	 * and then handle them.
 	 */
 	spin_lock_bh(&mvm->async_handlers_lock);
-	list_splice_init(&mvm->async_handlers_list, &local_list);
+	list_for_each_entry_safe(entry, tmp, &mvm->async_handlers_list, list) {
+		if (!(BIT(entry->context) & contexts))
+			continue;
+		list_del(&entry->list);
+		list_add_tail(&entry->list, &local_list);
+	}
 	spin_unlock_bh(&mvm->async_handlers_lock);
 
 	list_for_each_entry_safe(entry, tmp, &local_list, list) {
-		if (entry->context == RX_HANDLER_ASYNC_LOCKED)
+		if (entry->context != RX_HANDLER_ASYNC_UNLOCKED)
 			mutex_lock(&mvm->mutex);
 		entry->fn(mvm, &entry->rxb);
 		iwl_free_rxb(&entry->rxb);
 		list_del(&entry->list);
-		if (entry->context == RX_HANDLER_ASYNC_LOCKED)
+		if (entry->context != RX_HANDLER_ASYNC_UNLOCKED)
 			mutex_unlock(&mvm->mutex);
 		kfree(entry);
 	}
 }
 
+static void iwl_mvm_async_handlers_wiphy_wk(struct wiphy *wiphy,
+					    struct wiphy_work *wk)
+{
+	struct iwl_mvm *mvm =
+		container_of(wk, struct iwl_mvm, async_handlers_wiphy_wk);
+	u8 contexts = BIT(RX_HANDLER_ASYNC_LOCKED_WIPHY);
+
+	iwl_mvm_async_handlers_by_context(mvm, contexts);
+}
+
+static void iwl_mvm_async_handlers_wk(struct work_struct *wk)
+{
+	struct iwl_mvm *mvm =
+		container_of(wk, struct iwl_mvm, async_handlers_wk);
+	u8 contexts = BIT(RX_HANDLER_ASYNC_LOCKED) |
+		      BIT(RX_HANDLER_ASYNC_UNLOCKED);
+
+	iwl_mvm_async_handlers_by_context(mvm, contexts);
+}
+
 static inline void iwl_mvm_rx_check_trigger(struct iwl_mvm *mvm,
 					    struct iwl_rx_packet *pkt)
 {
@@ -1659,7 +1694,11 @@ static void iwl_mvm_rx_common(struct iwl_mvm *mvm,
 		spin_lock(&mvm->async_handlers_lock);
 		list_add_tail(&entry->list, &mvm->async_handlers_list);
 		spin_unlock(&mvm->async_handlers_lock);
-		schedule_work(&mvm->async_handlers_wk);
+		if (rx_h->context == RX_HANDLER_ASYNC_LOCKED_WIPHY)
+			wiphy_work_queue(mvm->hw->wiphy,
+					 &mvm->async_handlers_wiphy_wk);
+		else
+			schedule_work(&mvm->async_handlers_wk);
 		break;
 	}
 }
-- 
2.34.1


