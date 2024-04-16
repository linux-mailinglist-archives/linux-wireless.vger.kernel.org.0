Return-Path: <linux-wireless+bounces-6389-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AE38A692A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 12:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 223ECB2356D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 10:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7574B12A16D;
	Tue, 16 Apr 2024 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKNURtWF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C640B129E88
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 10:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264885; cv=none; b=RkwyxR8qW81Iw1eG9GWzodPMvYXNsnlvXQe+3FdNEZWj8nj1eAB8xIO8GqCgUM3yonG6YWYXe/cMVp4GG/tLCceA1+6tqzs7fxGgP1dGI5Q59BcjcLC+KNp0oQreXdrRepF5b/+frqcHQFJHDDh9gPk72pMF5z4ZYK/SGEFsOw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264885; c=relaxed/simple;
	bh=aWbvrjGleNQOYvzUqMcG0J0NzG5Cv5W8aWNGL5WOjBU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nnzDGQ4FrnK7b6XdhsmkwBshb4f4CtrrWTyZckWXhfPL/oEFbRQIfVt7gyo4rx6aiudjfmQwEtti0Gks85hfNxCjZNqDGjO0cUjd+7UecxUNHjShqRhjNeAzAxd1wKW+g8axUMc5wbCeV/Lu3/a4r/cHR4Bc6La0koPJ4TOC/LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKNURtWF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713264884; x=1744800884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aWbvrjGleNQOYvzUqMcG0J0NzG5Cv5W8aWNGL5WOjBU=;
  b=cKNURtWFHqSnIu0WOQZ9gAv1Qp2lJyEJt8yP81v7guapqjiXUyg3EF0V
   h4TPUMR64Iien8OCuFiVmWCzhR/xXqaL00ICyXRsxWx9wyyuMG8H5Af7q
   Rahx/PrvzQNfejLqCaP6+ul30H/pJkqvALgjwl8L4R0y1pzltpwMMBAxw
   1u6Cc3TcoEulAxPEIlWVj1qBHaZu6OiWBRtUlWmWhZnFPst/4nVTV7rE8
   jJF4CqKVQAfv5WpwBdxT1oh0tj6pFk0jbYz/499D44nmwpqFwcqvgxnRj
   31VJVJpGmv5s0p9hUG5h9auNaZppxqqrV9T83bdbrsiuSjzhqIkNH+6yj
   w==;
X-CSE-ConnectionGUID: f+k68XHtTwWi4yZumEPp9Q==
X-CSE-MsgGUID: ucMY2EEbQRCnh9tRyWp3Sg==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8556063"
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="8556063"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:44 -0700
X-CSE-ConnectionGUID: Fui4OTt7RQ+urkh5D909jg==
X-CSE-MsgGUID: z53rzBvbSvCzGB86MkiKaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,205,1708416000"; 
   d="scan'208";a="26872564"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 03:54:43 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 12/16] wifi: iwlwifi: mvm: implement EMLSR prevention mechanism.
Date: Tue, 16 Apr 2024 13:54:07 +0300
Message-Id: <20240416134215.d820ee98b300.I6406db40cf25eabdba602afd783466473b909216@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
References: <20240416105411.706221-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Address scenarios where repeated entry and exit from EMLSR occur, such as
encountering missed beacons on a specific link,
while still discovering that link during a scan.

To mitigate this, introduce the EMLSR prevention mechanism, which operates
as follows:
- On each exit from EMLSR event, record the timestamp and the exit
  reason.
- If two consecutive exits happen for the same reason within a
  400-second window, enforce a 300-second EMLSR prevention.
- If a third exit for the same reason occurs within 400 seconds from the
  second exit, enforce an extended EMLSR prevention of 600 seconds.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/link.c | 52 +++++++++++++++++++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 25 +++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  | 23 ++++++++
 3 files changed, 100 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/link.c b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
index acbe8e6f14c8..4bb71a14ac3b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/link.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/link.c
@@ -712,6 +712,55 @@ u8 iwl_mvm_get_other_link(struct ieee80211_vif *vif, u8 link_id)
 	}
 }
 
+/* Reasons that can cause esr prevention */
+#define IWL_MVM_ESR_PREVENT_REASONS	IWL_MVM_ESR_EXIT_MISSED_BEACON
+#define IWL_MVM_PREVENT_ESR_TIMEOUT	(HZ * 400)
+#define IWL_MVM_ESR_PREVENT_SHORT	(HZ * 300)
+#define IWL_MVM_ESR_PREVENT_LONG	(HZ * 600)
+
+static void iwl_mvm_recalc_esr_prevention(struct iwl_mvm *mvm,
+					  struct iwl_mvm_vif *mvmvif,
+					  enum iwl_mvm_esr_state reason)
+{
+	unsigned long now = jiffies;
+	unsigned long delay;
+	bool timeout_expired =
+		time_after(now, mvmvif->last_esr_exit.ts +
+				IWL_MVM_PREVENT_ESR_TIMEOUT);
+
+	if (WARN_ON(!(IWL_MVM_ESR_PREVENT_REASONS & reason)))
+		return;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	mvmvif->last_esr_exit.ts = now;
+
+	if (timeout_expired ||
+	    mvmvif->last_esr_exit.reason != reason) {
+		mvmvif->last_esr_exit.reason = reason;
+		mvmvif->exit_same_reason_count = 1;
+		return;
+	}
+
+	mvmvif->exit_same_reason_count++;
+	if (WARN_ON(mvmvif->exit_same_reason_count < 2 ||
+		    mvmvif->exit_same_reason_count > 3))
+		return;
+
+	mvmvif->esr_disable_reason |= IWL_MVM_ESR_BLOCKED_PREVENTION;
+
+	delay = mvmvif->exit_same_reason_count == 2 ?
+		IWL_MVM_ESR_PREVENT_SHORT :
+		IWL_MVM_ESR_PREVENT_LONG;
+
+	IWL_DEBUG_INFO(mvm,
+		       "Preventing EMLSR for %ld seconds due to %u exits with the reason 0x%x\n",
+		       delay / HZ, mvmvif->exit_same_reason_count, reason);
+
+	wiphy_delayed_work_queue(mvm->hw->wiphy,
+				 &mvmvif->prevent_esr_done_wk, delay);
+}
+
 /* API to exit eSR mode */
 void iwl_mvm_exit_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		      enum iwl_mvm_esr_state reason,
@@ -738,6 +787,9 @@ void iwl_mvm_exit_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
 		       reason, vif->active_links, new_active_links);
 
 	ieee80211_set_active_links_async(vif, new_active_links);
+
+	if (IWL_MVM_ESR_PREVENT_REASONS & reason)
+		iwl_mvm_recalc_esr_prevention(mvm, mvmvif, reason);
 }
 
 void iwl_mvm_block_esr(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index efe9205a7cf2..ddf27e6d2df2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1612,6 +1612,19 @@ static int iwl_mvm_alloc_bcast_mcast_sta(struct iwl_mvm *mvm,
 					IWL_STA_MULTICAST);
 }
 
+static void iwl_mvm_prevent_esr_done_wk(struct wiphy *wiphy,
+					struct wiphy_work *wk)
+{
+	struct iwl_mvm_vif *mvmvif =
+		container_of(wk, struct iwl_mvm_vif, prevent_esr_done_wk.work);
+	struct iwl_mvm *mvm = mvmvif->mvm;
+	struct ieee80211_vif *vif = iwl_mvm_get_bss_vif(mvm);
+
+	mutex_lock(&mvm->mutex);
+	iwl_mvm_unblock_esr(mvm, vif, IWL_MVM_ESR_BLOCKED_PREVENTION);
+	mutex_unlock(&mvm->mutex);
+}
+
 void iwl_mvm_mac_init_mvmvif(struct iwl_mvm *mvm, struct iwl_mvm_vif *mvmvif)
 {
 	lockdep_assert_held(&mvm->mutex);
@@ -1621,6 +1634,9 @@ void iwl_mvm_mac_init_mvmvif(struct iwl_mvm *mvm, struct iwl_mvm_vif *mvmvif)
 
 	INIT_DELAYED_WORK(&mvmvif->csa_work,
 			  iwl_mvm_channel_switch_disconnect_wk);
+
+	wiphy_delayed_work_init(&mvmvif->prevent_esr_done_wk,
+				iwl_mvm_prevent_esr_done_wk);
 }
 
 static int iwl_mvm_mac_add_interface(struct ieee80211_hw *hw,
@@ -1764,6 +1780,9 @@ void iwl_mvm_prepare_mac_removal(struct iwl_mvm *mvm,
 		flush_work(&mvm->roc_done_wk);
 	}
 
+	wiphy_delayed_work_cancel(mvm->hw->wiphy,
+				  &mvmvif->prevent_esr_done_wk);
+
 	cancel_delayed_work_sync(&mvmvif->csa_work);
 }
 
@@ -3906,6 +3925,9 @@ iwl_mvm_sta_state_assoc_to_authorized(struct iwl_mvm *mvm,
 		callbacks->mac_ctxt_changed(mvm, vif, false);
 		iwl_mvm_mei_host_associated(mvm, vif, mvm_sta);
 
+		memset(&mvmvif->last_esr_exit, 0,
+		       sizeof(mvmvif->last_esr_exit));
+
 		/* Calculate eSR mode due to BT coex */
 		iwl_mvm_bt_coex_update_vif_esr(mvm, vif);
 
@@ -3962,6 +3984,9 @@ iwl_mvm_sta_state_authorized_to_assoc(struct iwl_mvm *mvm,
 
 		/* disable beacon filtering */
 		iwl_mvm_disable_beacon_filter(mvm, vif);
+
+		wiphy_delayed_work_cancel(mvm->hw->wiphy,
+					  &mvmvif->prevent_esr_done_wk);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 3f13b346bfc6..920fd0afbb59 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -354,15 +354,29 @@ struct iwl_mvm_vif_link_info {
  * reasons - use iwl_mvm_exit_esr().
  *
  * @IWL_MVM_ESR_BLOCKED_COEX: COEX is preventing the enablement of EMLSR
+ * @IWL_MVM_ESR_BLOCKED_PREVENTION: Prevent EMLSR to avoid entering and exiting
+ *	in a loop.
  * @IWL_MVM_ESR_EXIT_MISSED_BEACON: exited EMLSR due to missed beacons
  */
 enum iwl_mvm_esr_state {
 	IWL_MVM_ESR_BLOCKED_COEX	= 0x1,
+	IWL_MVM_ESR_BLOCKED_PREVENTION	= 0x2,
 	IWL_MVM_ESR_EXIT_MISSED_BEACON	= 0x10000,
 };
 
 #define IWL_MVM_BLOCK_ESR_REASONS 0xffff
 
+/**
+ * struct iwl_mvm_esr_exit - details of the last exit from EMLSR mode.
+ * @reason: The reason for the last exit from EMLSR.
+ *	&iwl_mvm_prevent_esr_reasons. Will be 0 before exiting EMLSR.
+ * @ts: the time stamp of the last time we existed EMLSR.
+ */
+struct iwl_mvm_esr_exit {
+	unsigned long ts;
+	enum iwl_mvm_esr_state reason;
+};
+
 /**
  * struct iwl_mvm_vif - data per Virtual Interface, it is a MAC context
  * @mvm: pointer back to the mvm struct
@@ -404,6 +418,11 @@ enum iwl_mvm_esr_state {
  * @link_selection_primary: primary link selected by link selection
  * @primary_link: primary link in eSR. Valid only for an associated MLD vif,
  *	and in eSR mode. Valid only for a STA.
+ * @last_esr_exit: Details of the last exit from EMLSR.
+ * @exit_same_reason_count: The number of times we exited due to the specified
+ *	@last_esr_exit::reason, only counting exits due to
+ *	&IWL_MVM_ESR_PREVENT_REASONS.
+ * @prevent_esr_done_wk: work that should be done when esr prevention ends.
  */
 struct iwl_mvm_vif {
 	struct iwl_mvm *mvm;
@@ -497,6 +516,10 @@ struct iwl_mvm_vif {
 	u16 link_selection_res;
 	u8 link_selection_primary;
 	u8 primary_link;
+	struct iwl_mvm_esr_exit last_esr_exit;
+	u8 exit_same_reason_count;
+	struct wiphy_delayed_work prevent_esr_done_wk;
+
 	struct iwl_mvm_vif_link_info deflink;
 	struct iwl_mvm_vif_link_info *link[IEEE80211_MLD_MAX_NUM_LINKS];
 };
-- 
2.34.1


