Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE7B4B138B
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 17:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244855AbiBJQwk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 11:52:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244842AbiBJQwk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 11:52:40 -0500
Received: from farmhouse.coelho.fi (paleale.coelho.fi [176.9.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A0FF9
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 08:52:40 -0800 (PST)
Received: from 91-156-4-210.elisa-laajakaista.fi ([91.156.4.210] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <luca@coelho.fi>)
        id 1nICDQ-000Bxy-Lp;
        Thu, 10 Feb 2022 18:22:42 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@kernel.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Thu, 10 Feb 2022 18:22:26 +0200
Message-Id: <iwlwifi.20220210181930.dc67b3c04d0f.I5fbc552812ab91f2c4b158eee39f63c44575db1b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220210162234.285578-1-luca@coelho.fi>
References: <20220210162234.285578-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Subject: [PATCH 03/11] iwlwifi: mvm: remove iwl_mvm_disable_txq() flags argument
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

It's always zero, just remove it.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 21 ++++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index bf3aca0b2fc5..4cd3966182b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -316,7 +316,7 @@ static int iwl_mvm_invalidate_sta_queue(struct iwl_mvm *mvm, int queue,
 }
 
 static int iwl_mvm_disable_txq(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
-			       u16 *queueptr, u8 tid, u8 flags)
+			       u16 *queueptr, u8 tid)
 {
 	int queue = *queueptr;
 	struct iwl_scd_txq_cfg_cmd cmd = {
@@ -373,7 +373,7 @@ static int iwl_mvm_disable_txq(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 	mvm->queue_info[queue].reserved = false;
 
 	iwl_trans_txq_disable(mvm->trans, queue, false);
-	ret = iwl_mvm_send_cmd_pdu(mvm, SCD_QUEUE_CFG, flags,
+	ret = iwl_mvm_send_cmd_pdu(mvm, SCD_QUEUE_CFG, 0,
 				   sizeof(struct iwl_scd_txq_cfg_cmd), &cmd);
 
 	if (ret)
@@ -512,7 +512,7 @@ static int iwl_mvm_free_inactive_queue(struct iwl_mvm *mvm, int queue,
 		iwl_mvm_invalidate_sta_queue(mvm, queue,
 					     disable_agg_tids, false);
 
-	ret = iwl_mvm_disable_txq(mvm, old_sta, &queue_tmp, tid, 0);
+	ret = iwl_mvm_disable_txq(mvm, old_sta, &queue_tmp, tid);
 	if (ret) {
 		IWL_ERR(mvm,
 			"Failed to free inactive queue %d (ret=%d)\n",
@@ -1391,7 +1391,7 @@ static int iwl_mvm_sta_alloc_queue(struct iwl_mvm *mvm,
 
 out_err:
 	queue_tmp = queue;
-	iwl_mvm_disable_txq(mvm, sta, &queue_tmp, tid, 0);
+	iwl_mvm_disable_txq(mvm, sta, &queue_tmp, tid);
 
 	return ret;
 }
@@ -1837,8 +1837,7 @@ static void iwl_mvm_disable_sta_queues(struct iwl_mvm *mvm,
 		if (mvm_sta->tid_data[i].txq_id == IWL_MVM_INVALID_QUEUE)
 			continue;
 
-		iwl_mvm_disable_txq(mvm, sta, &mvm_sta->tid_data[i].txq_id, i,
-				    0);
+		iwl_mvm_disable_txq(mvm, sta, &mvm_sta->tid_data[i].txq_id, i);
 		mvm_sta->tid_data[i].txq_id = IWL_MVM_INVALID_QUEUE;
 	}
 
@@ -2046,7 +2045,7 @@ static int iwl_mvm_add_int_sta_with_queue(struct iwl_mvm *mvm, int macidx,
 	if (ret) {
 		if (!iwl_mvm_has_new_tx_api(mvm))
 			iwl_mvm_disable_txq(mvm, NULL, queue,
-					    IWL_MAX_TID_COUNT, 0);
+					    IWL_MAX_TID_COUNT);
 		return ret;
 	}
 
@@ -2118,7 +2117,7 @@ int iwl_mvm_rm_snif_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 	if (WARN_ON_ONCE(mvm->snif_sta.sta_id == IWL_MVM_INVALID_STA))
 		return -EINVAL;
 
-	iwl_mvm_disable_txq(mvm, NULL, &mvm->snif_queue, IWL_MAX_TID_COUNT, 0);
+	iwl_mvm_disable_txq(mvm, NULL, &mvm->snif_queue, IWL_MAX_TID_COUNT);
 	ret = iwl_mvm_rm_sta_common(mvm, mvm->snif_sta.sta_id);
 	if (ret)
 		IWL_WARN(mvm, "Failed sending remove station\n");
@@ -2135,7 +2134,7 @@ int iwl_mvm_rm_aux_sta(struct iwl_mvm *mvm)
 	if (WARN_ON_ONCE(mvm->aux_sta.sta_id == IWL_MVM_INVALID_STA))
 		return -EINVAL;
 
-	iwl_mvm_disable_txq(mvm, NULL, &mvm->aux_queue, IWL_MAX_TID_COUNT, 0);
+	iwl_mvm_disable_txq(mvm, NULL, &mvm->aux_queue, IWL_MAX_TID_COUNT);
 	ret = iwl_mvm_rm_sta_common(mvm, mvm->aux_sta.sta_id);
 	if (ret)
 		IWL_WARN(mvm, "Failed sending remove station\n");
@@ -2252,7 +2251,7 @@ static void iwl_mvm_free_bcast_sta_queues(struct iwl_mvm *mvm,
 	}
 
 	queue = *queueptr;
-	iwl_mvm_disable_txq(mvm, NULL, queueptr, IWL_MAX_TID_COUNT, 0);
+	iwl_mvm_disable_txq(mvm, NULL, queueptr, IWL_MAX_TID_COUNT);
 	if (iwl_mvm_has_new_tx_api(mvm))
 		return;
 
@@ -2487,7 +2486,7 @@ int iwl_mvm_rm_mcast_sta(struct iwl_mvm *mvm, struct ieee80211_vif *vif)
 
 	iwl_mvm_flush_sta(mvm, &mvmvif->mcast_sta, true);
 
-	iwl_mvm_disable_txq(mvm, NULL, &mvmvif->cab_queue, 0, 0);
+	iwl_mvm_disable_txq(mvm, NULL, &mvmvif->cab_queue, 0);
 
 	ret = iwl_mvm_rm_sta_common(mvm, mvmvif->mcast_sta.sta_id);
 	if (ret)
-- 
2.34.1

