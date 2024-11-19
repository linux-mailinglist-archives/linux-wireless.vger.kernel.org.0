Return-Path: <linux-wireless+bounces-15509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC259D29BA
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 16:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467841F22BD4
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 15:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4311CF7C7;
	Tue, 19 Nov 2024 15:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1dRIShe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756FA1CCB35
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030561; cv=none; b=Rj/ntRDjuUA1/a1c7QQvA6+WMd22R/1GEUpdvf0onRwuYi167BEIqucrY02kq+g2OEmydBo6BHvWyKkDMvQ+Q+0SFf/zbskxphbiVL0lmYRyBeidAg4LPhYZyUMOe6hNBsixRfkoX3YLedDtayeE8Bf3VBcEwq3vrZwGCbvT73U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030561; c=relaxed/simple;
	bh=JLbZFaBNdt2zv06Ya9LuIXFXlV6nLbzpUxCHOkHPjH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XCFb4Cxi9VnhROwQcr9G7zCPm1Rty+fiDILVGiIRGU9DhJfV+tR/uAd2EXM/PzDPaQc3NcDnVJOBUrMxS2iDZnaTUh3kujmbfS8DBAljS8eyYm/n3JE2yq/TdJkS9F8TFrYLXjOg7H4ST5v9ooxFlBy2vED4pGzIrIZQyJl7E9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1dRIShe; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732030559; x=1763566559;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JLbZFaBNdt2zv06Ya9LuIXFXlV6nLbzpUxCHOkHPjH0=;
  b=a1dRIShef+QYg9qghbnR+rztd+yJVsBhWl0A28vdGRfwvIbn/Ixuh7XX
   By4BNkSLNf4Wkuf4tzyO0zpxAo1tfBtllYByGslI2m73Jwt2SmjJNv+Bc
   Cd/GE0ffR2s33Zmc/iyFg501OFpNav6M+mnxJMUmE5WO4wnjaDNa/k63y
   X5XHni0XlTsyal4YFpet/wbnUManG9vOigCz4bRq1sOyKFP+W+Pw2q4wn
   60bTHoBFMlg6WWqz7GgvLEP36NFTBLy/ljfbSo0LaARQawCDLUQybBuMN
   5v09wUwIL9L+/63WEK2JRFd9iN5/xkCNiKJrs6YHKMdTdmraZI/+qEY9J
   A==;
X-CSE-ConnectionGUID: 5dYvX1HsTZiuC0qDshhI5g==
X-CSE-MsgGUID: HnXTNpLYQz+2fIP4y0wimg==
X-IronPort-AV: E=McAfee;i="6700,10204,11261"; a="32284166"
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="32284166"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 07:35:59 -0800
X-CSE-ConnectionGUID: X66TWO1gQNaG+J/UgCLwlg==
X-CSE-MsgGUID: 8bnctkrtR6SVqEVErhiErA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,166,1728975600"; 
   d="scan'208";a="89180923"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 07:35:58 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 2/2] wifi: mac80211: fix a queue stall in certain cases of CSA
Date: Tue, 19 Nov 2024 17:35:40 +0200
Message-Id: <20241119173108.5ea90828c2cc.I4f89e58572fb71ae48e47a81e74595cac410fbac@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119153540.594699-1-miriam.rachel.korenblit@intel.com>
References: <20241119153540.594699-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

If we got an unprotected action frame with CSA and then we heard the
beacon with the CSA IE, we'll block the queues with the CSA reason
twice. Since this reason is refcounted, we won't wake up the queues
since we wake them up only once and the ref count will never reach 0.
This led to blocked queues that prevented any activity (even
disconnection wouldn't reset the queue state and the only way to recover
would be to reload the kernel module.

Fix this by not refcounting the CSA reason.
It becomes now pointless to maintain the csa_blocked_queues state.
Remove it.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Fixes: 414e090bc41d ("wifi: mac80211: restrict public action ECSA frame handling")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219447
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  2 +-
 include/net/mac80211.h                        |  4 +-
 net/mac80211/cfg.c                            |  3 +-
 net/mac80211/ieee80211_i.h                    | 49 +++++++++++++++----
 net/mac80211/iface.c                          | 12 ++---
 net/mac80211/mlme.c                           |  2 -
 net/mac80211/util.c                           | 23 ++-------
 7 files changed, 50 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
index a7a10e716e65..e96ddaeeeeff 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac-ctxt.c
@@ -1967,7 +1967,7 @@ void iwl_mvm_channel_switch_error_notif(struct iwl_mvm *mvm,
 	if (csa_err_mask & (CS_ERR_COUNT_ERROR |
 			    CS_ERR_LONG_DELAY_AFTER_CS |
 			    CS_ERR_TX_BLOCK_TIMER_EXPIRED))
-		ieee80211_channel_switch_disconnect(vif, true);
+		ieee80211_channel_switch_disconnect(vif);
 	rcu_read_unlock();
 }
 
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 333e0fae6796..5b712582f9a9 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -6770,14 +6770,12 @@ void ieee80211_chswitch_done(struct ieee80211_vif *vif, bool success,
 /**
  * ieee80211_channel_switch_disconnect - disconnect due to channel switch error
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
- * @block_tx: if %true, do not send deauth frame.
  *
  * Instruct mac80211 to disconnect due to a channel switch error. The channel
  * switch can request to block the tx and so, we need to make sure we do not send
  * a deauth frame in this case.
  */
-void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif,
-					 bool block_tx);
+void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif);
 
 /**
  * ieee80211_request_smps - request SM PS transition
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 6dfc61a9acd4..cddd1d1d0d43 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3674,13 +3674,12 @@ void ieee80211_csa_finish(struct ieee80211_vif *vif, unsigned int link_id)
 }
 EXPORT_SYMBOL(ieee80211_csa_finish);
 
-void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif, bool block_tx)
+void ieee80211_channel_switch_disconnect(struct ieee80211_vif *vif)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_local *local = sdata->local;
 
-	sdata->csa_blocked_queues = block_tx;
 	sdata_info(sdata, "channel switch failed, disconnecting\n");
 	wiphy_work_queue(local->hw.wiphy, &ifmgd->csa_connection_drop_work);
 }
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 3d3c9139ff5e..7a0242e937d3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1106,8 +1106,6 @@ struct ieee80211_sub_if_data {
 
 	unsigned long state;
 
-	bool csa_blocked_queues;
-
 	char name[IFNAMSIZ];
 
 	struct ieee80211_fragment_cache frags;
@@ -2411,17 +2409,13 @@ void ieee80211_send_4addr_nullfunc(struct ieee80211_local *local,
 				   struct ieee80211_sub_if_data *sdata);
 void ieee80211_sta_tx_notify(struct ieee80211_sub_if_data *sdata,
 			     struct ieee80211_hdr *hdr, bool ack, u16 tx_time);
-
+unsigned int
+ieee80211_get_vif_queues(struct ieee80211_local *local,
+			 struct ieee80211_sub_if_data *sdata);
 void ieee80211_wake_queues_by_reason(struct ieee80211_hw *hw,
 				     unsigned long queues,
 				     enum queue_stop_reason reason,
 				     bool refcounted);
-void ieee80211_stop_vif_queues(struct ieee80211_local *local,
-			       struct ieee80211_sub_if_data *sdata,
-			       enum queue_stop_reason reason);
-void ieee80211_wake_vif_queues(struct ieee80211_local *local,
-			       struct ieee80211_sub_if_data *sdata,
-			       enum queue_stop_reason reason);
 void ieee80211_stop_queues_by_reason(struct ieee80211_hw *hw,
 				     unsigned long queues,
 				     enum queue_stop_reason reason,
@@ -2432,6 +2426,43 @@ void ieee80211_wake_queue_by_reason(struct ieee80211_hw *hw, int queue,
 void ieee80211_stop_queue_by_reason(struct ieee80211_hw *hw, int queue,
 				    enum queue_stop_reason reason,
 				    bool refcounted);
+static inline void
+ieee80211_stop_vif_queues(struct ieee80211_local *local,
+			  struct ieee80211_sub_if_data *sdata,
+			  enum queue_stop_reason reason)
+{
+	ieee80211_stop_queues_by_reason(&local->hw,
+					ieee80211_get_vif_queues(local, sdata),
+					reason, true);
+}
+
+static inline void
+ieee80211_wake_vif_queues(struct ieee80211_local *local,
+			  struct ieee80211_sub_if_data *sdata,
+			  enum queue_stop_reason reason)
+{
+	ieee80211_wake_queues_by_reason(&local->hw,
+					ieee80211_get_vif_queues(local, sdata),
+					reason, true);
+}
+static inline void
+ieee80211_stop_vif_queues_norefcount(struct ieee80211_local *local,
+				     struct ieee80211_sub_if_data *sdata,
+				     enum queue_stop_reason reason)
+{
+	ieee80211_stop_queues_by_reason(&local->hw,
+					ieee80211_get_vif_queues(local, sdata),
+					reason, false);
+}
+static inline void
+ieee80211_wake_vif_queues_norefcount(struct ieee80211_local *local,
+				     struct ieee80211_sub_if_data *sdata,
+				     enum queue_stop_reason reason)
+{
+	ieee80211_wake_queues_by_reason(&local->hw,
+					ieee80211_get_vif_queues(local, sdata),
+					reason, false);
+}
 void ieee80211_add_pending_skb(struct ieee80211_local *local,
 			       struct sk_buff *skb);
 void ieee80211_add_pending_skbs(struct ieee80211_local *local,
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 6ef0990d3d29..af9055252e6d 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -2364,18 +2364,14 @@ void ieee80211_vif_block_queues_csa(struct ieee80211_sub_if_data *sdata)
 	if (ieee80211_hw_check(&local->hw, HANDLES_QUIET_CSA))
 		return;
 
-	ieee80211_stop_vif_queues(local, sdata,
-				  IEEE80211_QUEUE_STOP_REASON_CSA);
-	sdata->csa_blocked_queues = true;
+	ieee80211_stop_vif_queues_norefcount(local, sdata,
+					     IEEE80211_QUEUE_STOP_REASON_CSA);
 }
 
 void ieee80211_vif_unblock_queues_csa(struct ieee80211_sub_if_data *sdata)
 {
 	struct ieee80211_local *local = sdata->local;
 
-	if (sdata->csa_blocked_queues) {
-		ieee80211_wake_vif_queues(local, sdata,
-					  IEEE80211_QUEUE_STOP_REASON_CSA);
-		sdata->csa_blocked_queues = false;
-	}
+	ieee80211_wake_vif_queues_norefcount(local, sdata,
+					     IEEE80211_QUEUE_STOP_REASON_CSA);
 }
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 0303972c23e4..111066928b96 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2636,8 +2636,6 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	 */
 	link->conf->csa_active = true;
 	link->u.mgd.csa.blocked_tx = csa_ie.mode;
-	sdata->csa_blocked_queues =
-		csa_ie.mode && !ieee80211_hw_check(&local->hw, HANDLES_QUIET_CSA);
 
 	wiphy_work_queue(sdata->local->hw.wiphy,
 			 &ifmgd->csa_connection_drop_work);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 9f96c4dc037a..38c30e4ddda9 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -657,7 +657,7 @@ void ieee80211_wake_queues(struct ieee80211_hw *hw)
 }
 EXPORT_SYMBOL(ieee80211_wake_queues);
 
-static unsigned int
+unsigned int
 ieee80211_get_vif_queues(struct ieee80211_local *local,
 			 struct ieee80211_sub_if_data *sdata)
 {
@@ -669,7 +669,8 @@ ieee80211_get_vif_queues(struct ieee80211_local *local,
 		queues = 0;
 
 		for (ac = 0; ac < IEEE80211_NUM_ACS; ac++)
-			queues |= BIT(sdata->vif.hw_queue[ac]);
+			if (sdata->vif.hw_queue[ac] != IEEE80211_INVAL_HW_QUEUE)
+				queues |= BIT(sdata->vif.hw_queue[ac]);
 		if (sdata->vif.cab_queue != IEEE80211_INVAL_HW_QUEUE)
 			queues |= BIT(sdata->vif.cab_queue);
 	} else {
@@ -724,24 +725,6 @@ void ieee80211_flush_queues(struct ieee80211_local *local,
 	__ieee80211_flush_queues(local, sdata, 0, drop);
 }
 
-void ieee80211_stop_vif_queues(struct ieee80211_local *local,
-			       struct ieee80211_sub_if_data *sdata,
-			       enum queue_stop_reason reason)
-{
-	ieee80211_stop_queues_by_reason(&local->hw,
-					ieee80211_get_vif_queues(local, sdata),
-					reason, true);
-}
-
-void ieee80211_wake_vif_queues(struct ieee80211_local *local,
-			       struct ieee80211_sub_if_data *sdata,
-			       enum queue_stop_reason reason)
-{
-	ieee80211_wake_queues_by_reason(&local->hw,
-					ieee80211_get_vif_queues(local, sdata),
-					reason, true);
-}
-
 static void __iterate_interfaces(struct ieee80211_local *local,
 				 u32 iter_flags,
 				 void (*iterator)(void *data, u8 *mac,
-- 
2.34.1


