Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D867C4FBD
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Oct 2023 12:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbjJKKJ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Oct 2023 06:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbjJKKJf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Oct 2023 06:09:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE352127
        for <linux-wireless@vger.kernel.org>; Wed, 11 Oct 2023 03:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697018892; x=1728554892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3RFwc+wYuM8nID8gWdt+kBjgLC8KocgRStQpbhqJNtA=;
  b=d29496+3Lk3AbF+7CaSvI66/fPDHzvDZjARBqGMkfdiaQZur/eUApDB4
   hOchMfEQ+3HJNQSWQi7T1LB+qeKEAxvZkwubdaLiY68GWjFpOKV1VLsau
   ap+CL8Qc6WiHfqlTQRXdIjDy+iHZD2F/TxXi7IA79kpvyMDwT/oUXD7Rs
   5PTa6QxEi2Cpp9QESncAOjgloUqR65+bRs1zophGBiMLlxKIP/MkPsJAV
   AHevT5X7N6IDd8T0VrR3mLiUPRlbJWSRGDMyZM+jYbkvWdq2tZ11PLdK7
   UlDh2eXHIlGd5BUWd+eSUoLmgWY0A0UBM1D68f3AsX2uFeWPcggSZL1Au
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415670661"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="415670661"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:08:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1001050318"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="1001050318"
Received: from mzarix-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.94.125])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:08:10 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 13/16] wifi: iwlwifi: mvm: change iwl_mvm_flush_sta() API
Date:   Wed, 11 Oct 2023 13:07:28 +0300
Message-Id: <20231011130030.aeb3bf4204cd.I5b0e6d64a67455784bc8fbdaf9ceaf03699d9ce1@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231011100731.361200-1-gregory.greenman@intel.com>
References: <20231011100731.361200-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This API is type unsafe and needs an extra parameter to know
what kind of station was passed, so it has two, but really it
only needs two values. Just pass the values instead of doing
this type-unsafe dance, which will also make it better to use
for multi-link.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c  |  6 ++++--
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c   |  9 ++++++---
 .../wireless/intel/iwlwifi/mvm/time-event.c    |  7 ++++---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c    | 18 ++----------------
 6 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 7d96725da176..c142d5d0d414 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -5674,7 +5674,8 @@ void iwl_mvm_mac_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		}
 
 		if (drop) {
-			if (iwl_mvm_flush_sta(mvm, mvmsta, false))
+			if (iwl_mvm_flush_sta(mvm, mvmsta->deflink.sta_id,
+					      mvmsta->tfd_queue_msk))
 				IWL_ERR(mvm, "flush request fail\n");
 		} else {
 			if (iwl_mvm_has_new_tx_api(mvm))
@@ -5711,7 +5712,8 @@ void iwl_mvm_mac_flush_sta(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 		mvmsta = iwl_mvm_sta_from_mac80211(sta);
 
-		if (iwl_mvm_flush_sta(mvm, mvmsta, false))
+		if (iwl_mvm_flush_sta(mvm, mvmsta->deflink.sta_id,
+				      mvmsta->tfd_queue_msk))
 			IWL_ERR(mvm, "flush request fail\n");
 	}
 	mutex_unlock(&mvm->mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index 1464aad039e1..ca5e4fbcf8ce 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -347,7 +347,7 @@ static int iwl_mvm_mld_rm_int_sta(struct iwl_mvm *mvm,
 		return -EINVAL;
 
 	if (flush)
-		iwl_mvm_flush_sta(mvm, int_sta, true);
+		iwl_mvm_flush_sta(mvm, int_sta->sta_id, int_sta->tfd_queue_msk);
 
 	iwl_mvm_mld_disable_txq(mvm, BIT(int_sta->sta_id), queuptr, tid);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index fda5ad4723ac..f81f1ec3bb79 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -1674,7 +1674,7 @@ const char *iwl_mvm_get_tx_fail_reason(u32 status);
 static inline const char *iwl_mvm_get_tx_fail_reason(u32 status) { return ""; }
 #endif
 int iwl_mvm_flush_tx_path(struct iwl_mvm *mvm, u32 tfd_msk);
-int iwl_mvm_flush_sta(struct iwl_mvm *mvm, void *sta, bool internal);
+int iwl_mvm_flush_sta(struct iwl_mvm *mvm, u32 sta_id, u32 tfd_queue_mask);
 int iwl_mvm_flush_sta_tids(struct iwl_mvm *mvm, u32 sta_id, u16 tids);
 
 /* Utils to extract sta related data */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 61d564735d57..d67103d3eea9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -2098,7 +2098,8 @@ int iwl_mvm_rm_sta(struct iwl_mvm *mvm,
 		return ret;
 
 	/* flush its queues here since we are freeing mvm_sta */
-	ret = iwl_mvm_flush_sta(mvm, mvm_sta, false);
+	ret = iwl_mvm_flush_sta(mvm, mvm_sta->deflink.sta_id,
+				mvm_sta->tfd_queue_msk);
 	if (ret)
 		return ret;
 	if (iwl_mvm_has_new_tx_api(mvm)) {
@@ -2409,7 +2410,8 @@ void iwl_mvm_free_bcast_sta_queues(struct iwl_mvm *mvm,
 
 	lockdep_assert_held(&mvm->mutex);
 
-	iwl_mvm_flush_sta(mvm, &mvmvif->deflink.bcast_sta, true);
+	iwl_mvm_flush_sta(mvm, mvmvif->deflink.bcast_sta.sta_id,
+			  mvmvif->deflink.bcast_sta.tfd_queue_msk);
 
 	switch (vif->type) {
 	case NL80211_IFTYPE_AP:
@@ -2665,7 +2667,8 @@ int iwl_mvm_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	lockdep_assert_held(&mvm->mutex);
 
-	iwl_mvm_flush_sta(mvm, &mvmvif->deflink.mcast_sta, true);
+	iwl_mvm_flush_sta(mvm, mvmvif->deflink.mcast_sta.sta_id,
+			  mvmvif->deflink.mcast_sta.tfd_queue_msk);
 
 	iwl_mvm_disable_txq(mvm, NULL, mvmvif->deflink.mcast_sta.sta_id,
 			    &mvmvif->deflink.cab_queue, 0);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 5cfdb2526d56..7ab6cabda9a4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -81,8 +81,8 @@ void iwl_mvm_roc_done_wk(struct work_struct *wk)
 			struct ieee80211_vif *vif = mvm->p2p_device_vif;
 
 			mvmvif = iwl_mvm_vif_from_mac80211(vif);
-			iwl_mvm_flush_sta(mvm, &mvmvif->deflink.bcast_sta,
-					  true);
+			iwl_mvm_flush_sta(mvm, mvmvif->deflink.bcast_sta.sta_id,
+					  mvmvif->deflink.bcast_sta.tfd_queue_msk);
 
 			if (mvm->mld_api_is_used) {
 				iwl_mvm_mld_rm_bcast_sta(mvm, vif,
@@ -113,7 +113,8 @@ void iwl_mvm_roc_done_wk(struct work_struct *wk)
 	 */
 	if (test_and_clear_bit(IWL_MVM_STATUS_ROC_AUX_RUNNING, &mvm->status)) {
 		/* do the same in case of hot spot 2.0 */
-		iwl_mvm_flush_sta(mvm, &mvm->aux_sta, true);
+		iwl_mvm_flush_sta(mvm, mvm->aux_sta.sta_id,
+				  mvm->aux_sta.tfd_queue_msk);
 
 		if (mvm->mld_api_is_used) {
 			iwl_mvm_mld_rm_aux_sta(mvm);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 674ddf951b79..b0f3d51a7613 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -2317,24 +2317,10 @@ int iwl_mvm_flush_sta_tids(struct iwl_mvm *mvm, u32 sta_id, u16 tids)
 	return ret;
 }
 
-int iwl_mvm_flush_sta(struct iwl_mvm *mvm, void *sta, bool internal)
+int iwl_mvm_flush_sta(struct iwl_mvm *mvm, u32 sta_id, u32 tfd_queue_mask)
 {
-	u32 sta_id, tfd_queue_msk;
-
-	if (internal) {
-		struct iwl_mvm_int_sta *int_sta = sta;
-
-		sta_id = int_sta->sta_id;
-		tfd_queue_msk = int_sta->tfd_queue_msk;
-	} else {
-		struct iwl_mvm_sta *mvm_sta = sta;
-
-		sta_id = mvm_sta->deflink.sta_id;
-		tfd_queue_msk = mvm_sta->tfd_queue_msk;
-	}
-
 	if (iwl_mvm_has_new_tx_api(mvm))
 		return iwl_mvm_flush_sta_tids(mvm, sta_id, 0xffff);
 
-	return iwl_mvm_flush_tx_path(mvm, tfd_queue_msk);
+	return iwl_mvm_flush_tx_path(mvm, tfd_queue_mask);
 }
-- 
2.38.1

