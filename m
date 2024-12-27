Return-Path: <linux-wireless+bounces-16826-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F859FD1B5
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 09:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D2C1613D0
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 08:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAB34D8C8;
	Fri, 27 Dec 2024 08:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="doWyhczb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014E514B956
	for <linux-wireless@vger.kernel.org>; Fri, 27 Dec 2024 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286493; cv=none; b=YoRzYWUAI5XxXXnY75cTOmfs5gjD/89/FLHPtdM5atr5w29bd4grKdAVbqNTChK9u3mcFpA2UXjehanN6siBfUKY71nc8zlK0cpZOXX6lVISRWm7cTS9V6Lx33Etine/dt1BApIPQLW4KITtzib/q08BST/IQOIfowrJCgtOuyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286493; c=relaxed/simple;
	bh=7cHb/vz9JCm9Q6O4LQgx0TAsCuvumqX8+NUZI1GPxrE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iT2oSy6g4lNJDMv6+Qn7wRxY4K/+K7bbekb4OfXWCRmRRXSeHG1vPAZGmZy0VTu7FnRONqvFQZrRlFisAiJktabriVFn+kdIcPYXKdRcXZCPOyEKX8TxtDziqLFSjKSQA+dpIlmDFnWVxttgOZBHe46sqpqewOggTDWNEbqCVAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=doWyhczb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735286490; x=1766822490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7cHb/vz9JCm9Q6O4LQgx0TAsCuvumqX8+NUZI1GPxrE=;
  b=doWyhczb4SNdDkbeGtHkgZqoFaESGC28XDnlnQv3z1ZttbZu8Gw9IyKr
   mTg7gk0v9FJAVoIpLReF6tfvPeXzdWfFxNvxCIm0nWxIsaAcUDIujkKvy
   c8gBeXN4uiOHdqrCzUyiSL+4PiugxvjYhNLx2x3B0h5gHdwb3q63HyYEv
   WtJlsYAHhiDsVz8D9GwFCrXZFWWGMdD7FYTDSwE+paOBH7ZuIYWZK/Yty
   h+d1SND1Rz4IXMXyrAsHShtoRQzIYANjxChnnWK+8sVOdv2ZBK4E7DR4I
   k7Y08xKjVQ7XzngjxnCGxoF0bF8oQA84okqYnYObnRWVNFwViH6DUkTcn
   Q==;
X-CSE-ConnectionGUID: VHKuJ57cSW2VjeOUwfrESg==
X-CSE-MsgGUID: eGnYl8iYRkOGjx1p4hd+wQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46690916"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="46690916"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:29 -0800
X-CSE-ConnectionGUID: emiLkYZxTN6ev7QID/TWgw==
X-CSE-MsgGUID: 6cF+6AHrQhWv3SvjhcgeBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="99858218"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:28 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 03/17] wifi: iwlwifi: mvm: skip short statistics window when updating EMLSR
Date: Fri, 27 Dec 2024 10:00:58 +0200
Message-Id: <20241227095718.0eb0f2044535.Ic2af92737ccfc873f3b6c228704238ebb9f983ca@changeid>
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

From: Benjamin Berg <benjamin.berg@intel.com>

The statistics are not synchronized with the time that we enter EMLSR.
This means that we can receive the statistic notification just after
having cleared the counters, causing us to immediately exit EMLSR again.

Fix this by checking that most of the time for the window has passed. If
that is not the case, ignore this window and wait for the next
notification.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c | 36 -------------------
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   | 16 +++++++++
 2 files changed, 16 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
index cc54c33dcb02..6bc881f14fd4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c
@@ -208,32 +208,6 @@ static unsigned int iwl_mvm_mld_count_active_links(struct iwl_mvm_vif *mvmvif)
 	return n_active;
 }
 
-static void iwl_mvm_restart_mpdu_count(struct iwl_mvm *mvm,
-				       struct iwl_mvm_vif *mvmvif)
-{
-	struct ieee80211_sta *ap_sta = mvmvif->ap_sta;
-	struct iwl_mvm_sta *mvmsta;
-
-	lockdep_assert_held(&mvm->mutex);
-
-	if (!ap_sta)
-		return;
-
-	mvmsta = iwl_mvm_sta_from_mac80211(ap_sta);
-	if (!mvmsta->mpdu_counters)
-		return;
-
-	for (int q = 0; q < mvm->trans->num_rx_queues; q++) {
-		spin_lock_bh(&mvmsta->mpdu_counters[q].lock);
-		memset(mvmsta->mpdu_counters[q].per_link, 0,
-		       sizeof(mvmsta->mpdu_counters[q].per_link));
-		mvmsta->mpdu_counters[q].window_start = jiffies;
-		spin_unlock_bh(&mvmsta->mpdu_counters[q].lock);
-	}
-
-	IWL_DEBUG_INFO(mvm, "MPDU counters are cleared\n");
-}
-
 static int iwl_mvm_esr_mode_active(struct iwl_mvm *mvm,
 				   struct ieee80211_vif *vif)
 {
@@ -267,13 +241,6 @@ static int iwl_mvm_esr_mode_active(struct iwl_mvm *mvm,
 	else
 		mvmvif->primary_link = __ffs(vif->active_links);
 
-	/*
-	 * Restart the MPDU counters and the counting window, so when the
-	 * statistics arrive (which is where we look at the counters) we
-	 * will be at the end of the window.
-	 */
-	iwl_mvm_restart_mpdu_count(mvm, mvmvif);
-
 	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_ESR_LINK_UP,
 			       NULL);
 
@@ -445,9 +412,6 @@ static int iwl_mvm_esr_mode_inactive(struct iwl_mvm *mvm,
 			break;
 	}
 
-	/* Start a new counting window */
-	iwl_mvm_restart_mpdu_count(mvm, mvmvif);
-
 	iwl_dbg_tlv_time_point(&mvm->fwrt, IWL_FW_INI_TIME_ESR_LINK_DOWN,
 			       NULL);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index 9e72db9bab40..00aac76e8509 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -962,6 +962,9 @@ iwl_mvm_stat_iterator_all_links(struct iwl_mvm *mvm,
 #define SEC_LINK_MIN_TX 3000
 #define SEC_LINK_MIN_RX 400
 
+/* Accept a ~20% short window to avoid issues due to jitter */
+#define IWL_MVM_TPT_MIN_COUNT_WINDOW (IWL_MVM_TPT_COUNT_WINDOW_SEC * HZ * 4 / 5)
+
 static void iwl_mvm_update_esr_mode_tpt(struct iwl_mvm *mvm)
 {
 	struct ieee80211_vif *bss_vif = iwl_mvm_get_bss_vif(mvm);
@@ -971,6 +974,7 @@ static void iwl_mvm_update_esr_mode_tpt(struct iwl_mvm *mvm)
 	unsigned long sec_link_tx = 0, sec_link_rx = 0;
 	u8 sec_link_tx_perc, sec_link_rx_perc;
 	u8 sec_link;
+	bool skip = false;
 
 	lockdep_assert_held(&mvm->mutex);
 
@@ -1010,13 +1014,25 @@ static void iwl_mvm_update_esr_mode_tpt(struct iwl_mvm *mvm)
 		/*
 		 * In EMLSR we have statistics every 5 seconds, so we can reset
 		 * the counters upon every statistics notification.
+		 * The FW sends the notification regularly, but it will be
+		 * misaligned at the start. Skipping the measurement if it is
+		 * short will synchronize us.
 		 */
+		if (jiffies - mvmsta->mpdu_counters[q].window_start <
+		    IWL_MVM_TPT_MIN_COUNT_WINDOW)
+			skip = true;
+		mvmsta->mpdu_counters[q].window_start = jiffies;
 		memset(mvmsta->mpdu_counters[q].per_link, 0,
 		       sizeof(mvmsta->mpdu_counters[q].per_link));
 
 		spin_unlock_bh(&mvmsta->mpdu_counters[q].lock);
 	}
 
+	if (skip) {
+		IWL_DEBUG_INFO(mvm, "MPDU statistics window was short\n");
+		return;
+	}
+
 	IWL_DEBUG_INFO(mvm, "total Tx MPDUs: %ld. total Rx MPDUs: %ld\n",
 		       total_tx, total_rx);
 
-- 
2.34.1


