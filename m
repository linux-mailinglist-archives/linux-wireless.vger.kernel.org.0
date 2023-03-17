Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CBD6BE5FB
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 10:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCQJxh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 05:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjCQJxf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 05:53:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6AF23876
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 02:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=YleRCC4lp/YcoVW6tuHq3FnluoKvkvb80Y6Y4LMKehQ=; t=1679046812; x=1680256412; 
        b=WRN42hvrMbiReVCAVyhUWeAZwP5VPd9dN5aEDceNdy0T8jdB4+9YEdW3PXWCRzLDumy/XLZbu6n
        5OaxbtUyAEcKN/oJA6oVBHDRqey5hwQ2cdCp/gn4vuCq912Tzh46TYz6nw23xSvjKzTz1Qy2gMmTN
        p9cbJZR+6FK3F6tNuvCalyqAJr3cjJrmVVDiF6wC3RHxnrGpavXVpvn3sWLqYjdCfL2sw1n4/e+M5
        xgYdBbLxTWEe4LKUtHALBTdCzqJxSll+dpVO1im8o5wY1g7LPO4ptGhT/C660NpxwVKjTLbjSYo7c
        4jyY9m6iAzIvJYNZSLZEaLn+5WhEJVtPZT8w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pd6m8-0066kS-0R;
        Fri, 17 Mar 2023 10:53:28 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Benjamin Berg <benjamin.berg@intel.com>,
        Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Subject: [PATCH 1/2] wifi: iwlwifi: mvm: fix mvmtxq->stopped handling
Date:   Fri, 17 Mar 2023 10:53:24 +0100
Message-Id: <20230317105323.3893cb26df9d.I68fc8d1a16a7c6927ac92fe855ada741acb9fe14@changeid>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This could race if the queue is redirected while full, then
the flushing internally would start it while it's not yet
usable again. Fix it by using two state bits instead of just
one.

Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>
Tested-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 5 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 4 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c      | 5 ++++-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c      | 4 ++--
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 74ded790d5a4..af6d5c55c31e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -782,7 +782,10 @@ void iwl_mvm_mac_itxq_xmit(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
 
 	rcu_read_lock();
 	do {
-		while (likely(!mvmtxq->stopped &&
+		while (likely(!test_bit(IWL_MVM_TXQ_STATE_STOP_FULL,
+					&mvmtxq->state) &&
+			      !test_bit(IWL_MVM_TXQ_STATE_STOP_REDIRECT,
+					&mvmtxq->state) &&
 			      !test_bit(IWL_MVM_STATUS_IN_D3, &mvm->status))) {
 			skb = ieee80211_tx_dequeue(hw, txq);
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index d431145929be..569cf13bb03a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -732,7 +732,9 @@ struct iwl_mvm_txq {
 	struct list_head list;
 	u16 txq_id;
 	atomic_t tx_request;
-	bool stopped;
+#define IWL_MVM_TXQ_STATE_STOP_FULL	0
+#define IWL_MVM_TXQ_STATE_STOP_REDIRECT	1
+	unsigned long state;
 };
 
 static inline struct iwl_mvm_txq *
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 70926bb1df6c..467da97bd2fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1713,7 +1713,10 @@ static void iwl_mvm_queue_state_change(struct iwl_op_mode *op_mode,
 
 		txq = sta->txq[tid];
 		mvmtxq = iwl_mvm_txq_from_mac80211(txq);
-		mvmtxq->stopped = !start;
+		if (start)
+			clear_bit(IWL_MVM_TXQ_STATE_STOP_FULL, &mvmtxq->state);
+		else
+			set_bit(IWL_MVM_TXQ_STATE_STOP_FULL, &mvmtxq->state);
 
 		if (start && mvmsta->sta_state != IEEE80211_STA_NOTEXIST)
 			iwl_mvm_mac_itxq_xmit(mvm->hw, txq);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index e976c3cada1b..0f5697f0df50 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -710,7 +710,7 @@ static int iwl_mvm_redirect_queue(struct iwl_mvm *mvm, int queue, int tid,
 			    queue, iwl_mvm_ac_to_tx_fifo[ac]);
 
 	/* Stop the queue and wait for it to empty */
-	txq->stopped = true;
+	set_bit(IWL_MVM_TXQ_STATE_STOP_REDIRECT, &txq->state);
 
 	ret = iwl_trans_wait_tx_queues_empty(mvm->trans, BIT(queue));
 	if (ret) {
@@ -753,7 +753,7 @@ static int iwl_mvm_redirect_queue(struct iwl_mvm *mvm, int queue, int tid,
 
 out:
 	/* Continue using the queue */
-	txq->stopped = false;
+	clear_bit(IWL_MVM_TXQ_STATE_STOP_REDIRECT, &txq->state);
 
 	return ret;
 }
-- 
2.39.2

