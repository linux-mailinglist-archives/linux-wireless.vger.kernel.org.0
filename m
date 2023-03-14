Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F456B9D6C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 18:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjCNRt5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 13:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjCNRtz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 13:49:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D317C3D3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 10:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678816193; x=1710352193;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QQ98Pit/8LzDUi7FFUlOSun7fcfv1oo9k/fWV0Ez64c=;
  b=Bkb5loB1j6gPHBxMZhJcA0HE1t4yRSDtHYOSXlHEyU/lStXFTBjm4qWp
   k6F29VqDqQVXI0XK6WE4Up/NYAVNc+Qh3i/Mv5fhXi4Q7RfVGGvL8UEat
   Fk7pdxhm0gzKkgvzwIUlfAZqlyOXxBx0SZ5pAWzgXqAkDwKt6Rk30ebMH
   s5ySRjzAP4gjkXsBIT374J/7ip2/A0idcKyQb/BWummvdfxzPSNrgnLLW
   tE2ehiQkfSILselVBHnt2GRSCadqMgM1S6jF9kdCL1tAnrruiEuxVFLyJ
   +bPVD9UTTPqx+KJUYWvuVfaEo71KD47zzedx9K28RQ3Zk1U/XSisjPC/R
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317149479"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="317149479"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:49:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768200434"
X-IronPort-AV: E=Sophos;i="5.98,260,1673942400"; 
   d="scan'208";a="768200434"
Received: from litalcoh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.192.4])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 10:49:50 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 01/22] wifi: iwlwifi: mvm: avoid sta lookup in queue alloc
Date:   Tue, 14 Mar 2023 19:49:13 +0200
Message-Id: <20230314194113.4d70868003e8.I3476fee5c12f5b1af2be5e2f38a9df7d66d02b62@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230314174934.893149-1-gregory.greenman@intel.com>
References: <20230314174934.893149-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In FW restart scenarios, we allocate the queues from the
iwl_mvm_realloc_queues_after_restart() function, but that
is called before we insert the station ID into our map
(mvm->fw_id_to_mac_id).

However, in all cases where we're actually allocating a
queue for a "real" (not bcast, aux, ...) station we have
the sta pointer already, so just pass it along to use it
instead of looking it up.

This fixes an issue where after restart we only allocated
a queue of size 16 (due to the ordering issue described
above), and thus never got good throughput again since no
aggregates could be formed on transmit.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 50 +++++++++++---------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 69634fb82a9b..46af2b422849 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -766,7 +766,25 @@ static int iwl_mvm_find_free_queue(struct iwl_mvm *mvm, u8 sta_id,
 	return -ENOSPC;
 }
 
+static int iwl_mvm_get_queue_size(struct ieee80211_sta *sta)
+{
+	/* this queue isn't used for traffic (cab_queue) */
+	if (!sta)
+		return IWL_MGMT_QUEUE_SIZE;
+
+	/* support for 1k ba size */
+	if (sta->deflink.eht_cap.has_eht)
+		return IWL_DEFAULT_QUEUE_SIZE_EHT;
+
+	/* support for 256 ba size */
+	if (sta->deflink.he_cap.has_he)
+		return IWL_DEFAULT_QUEUE_SIZE_HE;
+
+	return IWL_DEFAULT_QUEUE_SIZE;
+}
+
 static int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
+				   struct ieee80211_sta *sta,
 				   u8 sta_id, u8 tid, unsigned int timeout)
 {
 	int queue, size;
@@ -776,22 +794,7 @@ static int iwl_mvm_tvqm_enable_txq(struct iwl_mvm *mvm,
 		size = max_t(u32, IWL_MGMT_QUEUE_SIZE,
 			     mvm->trans->cfg->min_txq_size);
 	} else {
-		struct ieee80211_sta *sta;
-
-		rcu_read_lock();
-		sta = rcu_dereference(mvm->fw_id_to_mac_id[sta_id]);
-
-		/* this queue isn't used for traffic (cab_queue) */
-		if (IS_ERR_OR_NULL(sta)) {
-			size = IWL_MGMT_QUEUE_SIZE;
-		} else if (sta->deflink.he_cap.has_he) {
-			/* support for 256 ba size */
-			size = IWL_DEFAULT_QUEUE_SIZE_HE;
-		} else {
-			size = IWL_DEFAULT_QUEUE_SIZE;
-		}
-
-		rcu_read_unlock();
+		size = iwl_mvm_get_queue_size(sta);
 	}
 
 	/* take the min with bc tbl entries allowed */
@@ -836,7 +839,8 @@ static int iwl_mvm_sta_alloc_queue_tvqm(struct iwl_mvm *mvm,
 	IWL_DEBUG_TX_QUEUES(mvm,
 			    "Allocating queue for sta %d on tid %d\n",
 			    mvmsta->sta_id, tid);
-	queue = iwl_mvm_tvqm_enable_txq(mvm, mvmsta->sta_id, tid, wdg_timeout);
+	queue = iwl_mvm_tvqm_enable_txq(mvm, sta, mvmsta->sta_id,
+					tid, wdg_timeout);
 	if (queue < 0)
 		return queue;
 
@@ -1537,7 +1541,8 @@ static void iwl_mvm_realloc_queues_after_restart(struct iwl_mvm *mvm,
 			IWL_DEBUG_TX_QUEUES(mvm,
 					    "Re-mapping sta %d tid %d\n",
 					    mvm_sta->sta_id, i);
-			txq_id = iwl_mvm_tvqm_enable_txq(mvm, mvm_sta->sta_id,
+			txq_id = iwl_mvm_tvqm_enable_txq(mvm, sta,
+							 mvm_sta->sta_id,
 							 i, wdg);
 			/*
 			 * on failures, just set it to IWL_MVM_INVALID_QUEUE
@@ -2049,7 +2054,7 @@ static int iwl_mvm_enable_aux_snif_queue_tvqm(struct iwl_mvm *mvm, u8 sta_id)
 
 	WARN_ON(!iwl_mvm_has_new_tx_api(mvm));
 
-	return iwl_mvm_tvqm_enable_txq(mvm, sta_id, IWL_MAX_TID_COUNT,
+	return iwl_mvm_tvqm_enable_txq(mvm, NULL, sta_id, IWL_MAX_TID_COUNT,
 				       wdg_timeout);
 }
 
@@ -2233,7 +2238,7 @@ int iwl_mvm_send_add_bcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	 * to firmware so enable queue here - after the station was added
 	 */
 	if (iwl_mvm_has_new_tx_api(mvm)) {
-		queue = iwl_mvm_tvqm_enable_txq(mvm, bsta->sta_id,
+		queue = iwl_mvm_tvqm_enable_txq(mvm, NULL, bsta->sta_id,
 						IWL_MAX_TID_COUNT,
 						wdg_timeout);
 		if (queue < 0) {
@@ -2427,9 +2432,8 @@ int iwl_mvm_add_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	 * tfd_queue_mask.
 	 */
 	if (iwl_mvm_has_new_tx_api(mvm)) {
-		int queue = iwl_mvm_tvqm_enable_txq(mvm, msta->sta_id,
-						    0,
-						    timeout);
+		int queue = iwl_mvm_tvqm_enable_txq(mvm, NULL, msta->sta_id,
+						    0, timeout);
 		if (queue < 0) {
 			ret = queue;
 			goto err;
-- 
2.38.1

