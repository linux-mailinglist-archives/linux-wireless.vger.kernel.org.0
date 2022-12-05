Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA2A6424B4
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 09:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiLEIgh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 03:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiLEIgb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 03:36:31 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C44167D7
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 00:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670229390; x=1701765390;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6cIAr/Ioh2kPFhXJOd3CCQVq7jXxQ13Lf9i0kOAu3Ps=;
  b=isGKwbYTJ1GnYF/dTrR3AwJdV3yEwE/DhxzQiHwNSpFjnhze5Xa0yQtG
   GnYRj2w6jYcci4QbQ+7cQ4v2ebntxVsmsz7EgPXO42OlaPlpC1CNHhG1F
   h8HL8GnRvc5olPXCxRTkph6By7odxtyDfNqq06g9vQSas7Yr5y6KkDCVh
   1DFRDrHNGwiKylY2EksQul0WxhkIvOy+dhNiXFq7AilXDhq0RJh6vc331
   wPuNi2w3tUajK5kEfcV0kwNzSSObmK021FGgxnbXiE+9cRk5uD6mTeY2u
   nS2bSkBSq3bUqtJvNaAaPy7rz4ckrk8zlWWX+v5tomM51jQi66xVWykBx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="316323072"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="316323072"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:17 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10551"; a="752100363"
X-IronPort-AV: E=Sophos;i="5.96,218,1665471600"; 
   d="scan'208";a="752100363"
Received: from eamit-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.181.23])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 00:36:15 -0800
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/11] wifi: iwlwifi: modify new queue allocation command
Date:   Mon,  5 Dec 2022 10:35:39 +0200
Message-Id: <20221205102808.2925b38d3929.Ib8467711590c1969817c3321509eb131f4230e15@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221205083548.236620-1-gregory.greenman@intel.com>
References: <20221205083548.236620-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Follow a new firmware API changes and update the queue allocation
command in the remove/modify cases to take the station mask and
TID instead of the queue ID.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 .../wireless/intel/iwlwifi/fw/api/datapath.h  | 16 +++++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  | 26 ++++++++++++-------
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
index d07982d8c897..9263413ee06f 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/datapath.h
@@ -382,9 +382,11 @@ enum iwl_scd_queue_cfg_operation {
  * @u.add.cb_size: size code
  * @u.add.bc_dram_addr: byte-count table IOVA
  * @u.add.tfdq_dram_addr: TFD queue IOVA
- * @u.remove.queue: queue ID for removal
- * @u.modify.sta_mask: new station mask for modify
- * @u.modify.queue: queue ID to modify
+ * @u.remove.sta_mask: station mask of queue to remove
+ * @u.remove.tid: TID of queue to remove
+ * @u.modify.old_sta_mask: old station mask for modify
+ * @u.modify.tid: TID of queue to modify
+ * @u.modify.new_sta_mask: new station mask for modify
  */
 struct iwl_scd_queue_cfg_cmd {
 	__le32 operation;
@@ -399,11 +401,13 @@ struct iwl_scd_queue_cfg_cmd {
 			__le64 tfdq_dram_addr;
 		} __packed add; /* TX_QUEUE_CFG_CMD_ADD_API_S_VER_1 */
 		struct {
-			__le32 queue;
+			__le32 sta_mask;
+			__le32 tid;
 		} __packed remove; /* TX_QUEUE_CFG_CMD_REMOVE_API_S_VER_1 */
 		struct {
-			__le32 sta_mask;
-			__le32 queue;
+			__le32 old_sta_mask;
+			__le32 tid;
+			__le32 new_sta_mask;
 		} __packed modify; /* TX_QUEUE_CFG_CMD_MODIFY_API_S_VER_1 */
 	} __packed u; /* TX_QUEUE_CFG_CMD_OPERATION_API_U_VER_1 */
 } __packed; /* TX_QUEUE_CFG_CMD_API_S_VER_3 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 515dd3e0730d..6c9c5d6e7783 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -316,7 +316,7 @@ static int iwl_mvm_invalidate_sta_queue(struct iwl_mvm *mvm, int queue,
 }
 
 static int iwl_mvm_disable_txq(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
-			       u16 *queueptr, u8 tid)
+			       int sta_id, u16 *queueptr, u8 tid)
 {
 	int queue = *queueptr;
 	struct iwl_scd_txq_cfg_cmd cmd = {
@@ -333,7 +333,8 @@ static int iwl_mvm_disable_txq(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 					     SCD_QUEUE_CONFIG_CMD);
 			struct iwl_scd_queue_cfg_cmd remove_cmd = {
 				.operation = cpu_to_le32(IWL_SCD_QUEUE_REMOVE),
-				.u.remove.queue = cpu_to_le32(queue),
+				.u.remove.tid = cpu_to_le32(tid),
+				.u.remove.sta_mask = cpu_to_le32(BIT(sta_id)),
 			};
 
 			ret = iwl_mvm_send_cmd_pdu(mvm, cmd_id, 0,
@@ -531,7 +532,7 @@ static int iwl_mvm_free_inactive_queue(struct iwl_mvm *mvm, int queue,
 		iwl_mvm_invalidate_sta_queue(mvm, queue,
 					     disable_agg_tids, false);
 
-	ret = iwl_mvm_disable_txq(mvm, old_sta, &queue_tmp, tid);
+	ret = iwl_mvm_disable_txq(mvm, old_sta, sta_id, &queue_tmp, tid);
 	if (ret) {
 		IWL_ERR(mvm,
 			"Failed to free inactive queue %d (ret=%d)\n",
@@ -1408,7 +1409,7 @@ static int iwl_mvm_sta_alloc_queue(struct iwl_mvm *mvm,
 
 out_err:
 	queue_tmp = queue;
-	iwl_mvm_disable_txq(mvm, sta, &queue_tmp, tid);
+	iwl_mvm_disable_txq(mvm, sta, mvmsta->sta_id, &queue_tmp, tid);
 
 	return ret;
 }
@@ -1854,7 +1855,8 @@ static void iwl_mvm_disable_sta_queues(struct iwl_mvm *mvm,
 		if (mvm_sta->tid_data[i].txq_id == IWL_MVM_INVALID_QUEUE)
 			continue;
 
-		iwl_mvm_disable_txq(mvm, sta, &mvm_sta->tid_data[i].txq_id, i);
+		iwl_mvm_disable_txq(mvm, sta, mvm_sta->sta_id,
+				    &mvm_sta->tid_data[i].txq_id, i);
 		mvm_sta->tid_data[i].txq_id = IWL_MVM_INVALID_QUEUE;
 	}
 
@@ -2065,7 +2067,7 @@ static int iwl_mvm_add_int_sta_with_queue(struct iwl_mvm *mvm, int macidx,
 	ret = iwl_mvm_add_int_sta_common(mvm, sta, addr, macidx, maccolor);
 	if (ret) {
 		if (!iwl_mvm_has_new_tx_api(mvm))
-			iwl_mvm_disable_txq(mvm, NULL, queue,
+			iwl_mvm_disable_txq(mvm, NULL, sta->sta_id, queue,
 					    IWL_MAX_TID_COUNT);
 		return ret;
 	}
@@ -2138,7 +2140,8 @@ int iwl_mvm_rm_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	if (WARN_ON_ONCE(mvm->snif_sta.sta_id == IWL_MVM_INVALID_STA))
 		return -EINVAL;
 
-	iwl_mvm_disable_txq(mvm, NULL, &mvm->snif_queue, IWL_MAX_TID_COUNT);
+	iwl_mvm_disable_txq(mvm, NULL, mvm->snif_sta.sta_id,
+			    &mvm->snif_queue, IWL_MAX_TID_COUNT);
 	ret = iwl_mvm_rm_sta_common(mvm, mvm->snif_sta.sta_id);
 	if (ret)
 		IWL_WARN(mvm, "Failed sending remove station\n");
@@ -2155,7 +2158,8 @@ int iwl_mvm_rm_aux_sta(struct iwl_mvm *mvm)
 	if (WARN_ON_ONCE(mvm->aux_sta.sta_id == IWL_MVM_INVALID_STA))
 		return -EINVAL;
 
-	iwl_mvm_disable_txq(mvm, NULL, &mvm->aux_queue, IWL_MAX_TID_COUNT);
+	iwl_mvm_disable_txq(mvm, NULL, mvm->aux_sta.sta_id,
+			    &mvm->aux_queue, IWL_MAX_TID_COUNT);
 	ret = iwl_mvm_rm_sta_common(mvm, mvm->aux_sta.sta_id);
 	if (ret)
 		IWL_WARN(mvm, "Failed sending remove station\n");
@@ -2272,7 +2276,8 @@ static void iwl_mvm_free_bcast_sta_queues(struct iwl_mvm *mvm,
 	}
 
 	queue = *queueptr;
-	iwl_mvm_disable_txq(mvm, NULL, queueptr, IWL_MAX_TID_COUNT);
+	iwl_mvm_disable_txq(mvm, NULL, mvmvif->bcast_sta.sta_id,
+			    queueptr, IWL_MAX_TID_COUNT);
 	if (iwl_mvm_has_new_tx_api(mvm))
 		return;
 
@@ -2507,7 +2512,8 @@ int iwl_mvm_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	iwl_mvm_flush_sta(mvm, &mvmvif->mcast_sta, true);
 
-	iwl_mvm_disable_txq(mvm, NULL, &mvmvif->cab_queue, 0);
+	iwl_mvm_disable_txq(mvm, NULL, mvmvif->mcast_sta.sta_id,
+			    &mvmvif->cab_queue, 0);
 
 	ret = iwl_mvm_rm_sta_common(mvm, mvmvif->mcast_sta.sta_id);
 	if (ret)
-- 
2.35.3

