Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5788078AFA3
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjH1MG0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjH1MFy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:54 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FFB125
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=j2bjlLlZmyEjQRRil6euvo0eGfe3gJfOZWGOV7ReiTo=;
        t=1693224350; x=1694433950; b=pPYuduiCGTUyAUiSeST0SGq5rozb191Oj5KA466FtlVTqhq
        /3SMBYoQpaqUWkDtOmePV3EGVsjLm5onrw1mCCfQt+y/IxM/Bi0W0/O/QS2BoBFNTQgdPTA5Yzst0
        YJdXua/2FQOisqVZBGWgOaGYOiaXo3oOyOe0givBV+su37i8DK3QqdNFi4bCwiLsbRDssEN/sjMLn
        lUNQRnTTS3SgiXckdmO5eyIOLJjgIPQXyzPdvOW0ukRdbP5FA8YrPH8GSct2Sh6Npu8ziEcSp5hqf
        Nf8s+89RzIZoC3jkGZfUI7lCejIXJQ/uOMl7JrHADvVUJ6pSTt1ykLvO6b5QPFoA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qab08-00Gjgt-02;
        Mon, 28 Aug 2023 14:05:48 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 36/40] wifi: mac80211: remove ampdu_mlme.mtx
Date:   Mon, 28 Aug 2023 14:00:04 +0200
Message-ID: <20230828135928.ebaef378d5cc.I20a7e1429d329345c4d8fe004dedef82a0dee0d5@changeid>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828115927.116700-41-johannes@sipsolutions.net>
References: <20230828115927.116700-41-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We now hold the wiphy mutex everywhere that we use or
needed the A-MPDU locking, so we don't need this mutex
any more. Remove it.

Most of this change was done automatically with spatch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/agg-rx.c      | 51 +++++++++++---------------------------
 net/mac80211/agg-tx.c      | 49 ++++++++++++------------------------
 net/mac80211/ht.c          | 38 +++++++++++++---------------
 net/mac80211/ieee80211_i.h | 14 ++++-------
 net/mac80211/key.c         |  6 ++---
 net/mac80211/sta_info.c    |  1 -
 net/mac80211/sta_info.h    | 18 +++++---------
 7 files changed, 60 insertions(+), 117 deletions(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index a686f1ce66cb..9bffac7a4974 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -55,8 +55,8 @@ static void ieee80211_free_tid_rx(struct rcu_head *h)
 	kfree(tid_rx);
 }
 
-void ___ieee80211_stop_rx_ba_session(struct sta_info *sta, u16 tid,
-				     u16 initiator, u16 reason, bool tx)
+void __ieee80211_stop_rx_ba_session(struct sta_info *sta, u16 tid,
+				    u16 initiator, u16 reason, bool tx)
 {
 	struct ieee80211_local *local = sta->local;
 	struct tid_ampdu_rx *tid_rx;
@@ -69,10 +69,10 @@ void ___ieee80211_stop_rx_ba_session(struct sta_info *sta, u16 tid,
 		.ssn = 0,
 	};
 
-	lockdep_assert_held(&sta->ampdu_mlme.mtx);
+	lockdep_assert_wiphy(sta->local->hw.wiphy);
 
 	tid_rx = rcu_dereference_protected(sta->ampdu_mlme.tid_rx[tid],
-					lockdep_is_held(&sta->ampdu_mlme.mtx));
+					lockdep_is_held(&sta->local->hw.wiphy->mtx));
 
 	if (!test_bit(tid, sta->ampdu_mlme.agg_session_valid))
 		return;
@@ -114,14 +114,6 @@ void ___ieee80211_stop_rx_ba_session(struct sta_info *sta, u16 tid,
 	call_rcu(&tid_rx->rcu_head, ieee80211_free_tid_rx);
 }
 
-void __ieee80211_stop_rx_ba_session(struct sta_info *sta, u16 tid,
-				    u16 initiator, u16 reason, bool tx)
-{
-	mutex_lock(&sta->ampdu_mlme.mtx);
-	___ieee80211_stop_rx_ba_session(sta, tid, initiator, reason, tx);
-	mutex_unlock(&sta->ampdu_mlme.mtx);
-}
-
 void ieee80211_stop_rx_ba_session(struct ieee80211_vif *vif, u16 ba_rx_bitmap,
 				  const u8 *addr)
 {
@@ -250,11 +242,11 @@ static void ieee80211_send_addba_resp(struct sta_info *sta, u8 *da, u16 tid,
 	ieee80211_tx_skb(sdata, skb);
 }
 
-void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
-				      u8 dialog_token, u16 timeout,
-				      u16 start_seq_num, u16 ba_policy, u16 tid,
-				      u16 buf_size, bool tx, bool auto_seq,
-				      const struct ieee80211_addba_ext_ie *addbaext)
+void __ieee80211_start_rx_ba_session(struct sta_info *sta,
+				     u8 dialog_token, u16 timeout,
+				     u16 start_seq_num, u16 ba_policy, u16 tid,
+				     u16 buf_size, bool tx, bool auto_seq,
+				     const struct ieee80211_addba_ext_ie *addbaext)
 {
 	struct ieee80211_local *local = sta->sdata->local;
 	struct tid_ampdu_rx *tid_agg_rx;
@@ -270,6 +262,8 @@ void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
 	u16 status = WLAN_STATUS_REQUEST_DECLINED;
 	u16 max_buf_size;
 
+	lockdep_assert_wiphy(sta->local->hw.wiphy);
+
 	if (tid >= IEEE80211_FIRST_TSPEC_TSID) {
 		ht_dbg(sta->sdata,
 		       "STA %pM requests BA session on unsupported tid %d\n",
@@ -325,9 +319,6 @@ void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
 	ht_dbg(sta->sdata, "AddBA Req buf_size=%d for %pM\n",
 	       buf_size, sta->sta.addr);
 
-	/* examine state machine */
-	lockdep_assert_held(&sta->ampdu_mlme.mtx);
-
 	if (test_bit(tid, sta->ampdu_mlme.agg_session_valid)) {
 		if (sta->ampdu_mlme.tid_rx_token[tid] == dialog_token) {
 			struct tid_ampdu_rx *tid_rx;
@@ -355,9 +346,9 @@ void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
 				   sta->sta.addr, tid);
 
 		/* delete existing Rx BA session on the same tid */
-		___ieee80211_stop_rx_ba_session(sta, tid, WLAN_BACK_RECIPIENT,
-						WLAN_STATUS_UNSPECIFIED_QOS,
-						false);
+		__ieee80211_stop_rx_ba_session(sta, tid, WLAN_BACK_RECIPIENT,
+					       WLAN_STATUS_UNSPECIFIED_QOS,
+					       false);
 	}
 
 	if (ieee80211_hw_check(&local->hw, SUPPORTS_REORDERING_BUFFER)) {
@@ -444,20 +435,6 @@ void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
 					  timeout, addbaext);
 }
 
-static void __ieee80211_start_rx_ba_session(struct sta_info *sta,
-					    u8 dialog_token, u16 timeout,
-					    u16 start_seq_num, u16 ba_policy,
-					    u16 tid, u16 buf_size, bool tx,
-					    bool auto_seq,
-					    const struct ieee80211_addba_ext_ie *addbaext)
-{
-	mutex_lock(&sta->ampdu_mlme.mtx);
-	___ieee80211_start_rx_ba_session(sta, dialog_token, timeout,
-					 start_seq_num, ba_policy, tid,
-					 buf_size, tx, auto_seq, addbaext);
-	mutex_unlock(&sta->ampdu_mlme.mtx);
-}
-
 void ieee80211_process_addba_request(struct ieee80211_local *local,
 				     struct sta_info *sta,
 				     struct ieee80211_mgmt *mgmt,
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 3da0c55f13e2..0627abb09f0e 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -142,7 +142,7 @@ EXPORT_SYMBOL(ieee80211_send_bar);
 void ieee80211_assign_tid_tx(struct sta_info *sta, int tid,
 			     struct tid_ampdu_tx *tid_tx)
 {
-	lockdep_assert_held(&sta->ampdu_mlme.mtx);
+	lockdep_assert_wiphy(sta->local->hw.wiphy);
 	lockdep_assert_held(&sta->lock);
 	rcu_assign_pointer(sta->ampdu_mlme.tid_tx[tid], tid_tx);
 }
@@ -213,7 +213,7 @@ ieee80211_agg_start_txq(struct sta_info *sta, int tid, bool enable)
 	struct ieee80211_txq *txq = sta->sta.txq[tid];
 	struct txq_info *txqi;
 
-	lockdep_assert_held(&sta->ampdu_mlme.mtx);
+	lockdep_assert_wiphy(sta->local->hw.wiphy);
 
 	if (!txq)
 		return;
@@ -271,7 +271,7 @@ static void ieee80211_remove_tid_tx(struct sta_info *sta, int tid)
 {
 	struct tid_ampdu_tx *tid_tx;
 
-	lockdep_assert_held(&sta->ampdu_mlme.mtx);
+	lockdep_assert_wiphy(sta->local->hw.wiphy);
 	lockdep_assert_held(&sta->lock);
 
 	tid_tx = rcu_dereference_protected_tid_tx(sta, tid);
@@ -296,8 +296,8 @@ static void ieee80211_remove_tid_tx(struct sta_info *sta, int tid)
 	kfree_rcu(tid_tx, rcu_head);
 }
 
-int ___ieee80211_stop_tx_ba_session(struct sta_info *sta, u16 tid,
-				    enum ieee80211_agg_stop_reason reason)
+int __ieee80211_stop_tx_ba_session(struct sta_info *sta, u16 tid,
+				   enum ieee80211_agg_stop_reason reason)
 {
 	struct ieee80211_local *local = sta->local;
 	struct tid_ampdu_tx *tid_tx;
@@ -311,7 +311,7 @@ int ___ieee80211_stop_tx_ba_session(struct sta_info *sta, u16 tid,
 	};
 	int ret;
 
-	lockdep_assert_held(&sta->ampdu_mlme.mtx);
+	lockdep_assert_wiphy(sta->local->hw.wiphy);
 
 	switch (reason) {
 	case AGG_STOP_DECLINED:
@@ -461,7 +461,7 @@ static void ieee80211_send_addba_with_timeout(struct sta_info *sta,
 			 test_bit(HT_AGG_STATE_WANT_STOP, &tid_tx->state)))
 		return;
 
-	lockdep_assert_held(&sta->ampdu_mlme.mtx);
+	lockdep_assert_wiphy(sta->local->hw.wiphy);
 
 	/* activate the timer for the recipient's addBA response */
 	mod_timer(&tid_tx->addba_resp_timer, jiffies + ADDBA_RESP_INTERVAL);
@@ -764,7 +764,7 @@ static void ieee80211_agg_tx_operational(struct ieee80211_local *local,
 		.ssn = 0,
 	};
 
-	lockdep_assert_held(&sta->ampdu_mlme.mtx);
+	lockdep_assert_wiphy(sta->local->hw.wiphy);
 
 	tid_tx = rcu_dereference_protected_tid_tx(sta, tid);
 	params.buf_size = tid_tx->buf_size;
@@ -801,7 +801,7 @@ void ieee80211_start_tx_ba_cb(struct sta_info *sta, int tid,
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	struct ieee80211_local *local = sdata->local;
 
-	lockdep_assert_held(&sta->ampdu_mlme.mtx);
+	lockdep_assert_wiphy(sta->local->hw.wiphy);
 
 	if (WARN_ON(test_and_set_bit(HT_AGG_STATE_DRV_READY, &tid_tx->state)))
 		return;
@@ -868,20 +868,6 @@ void ieee80211_start_tx_ba_cb_irqsafe(struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL(ieee80211_start_tx_ba_cb_irqsafe);
 
-int __ieee80211_stop_tx_ba_session(struct sta_info *sta, u16 tid,
-				   enum ieee80211_agg_stop_reason reason)
-{
-	int ret;
-
-	mutex_lock(&sta->ampdu_mlme.mtx);
-
-	ret = ___ieee80211_stop_tx_ba_session(sta, tid, reason);
-
-	mutex_unlock(&sta->ampdu_mlme.mtx);
-
-	return ret;
-}
-
 int ieee80211_stop_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid)
 {
 	struct sta_info *sta = container_of(pubsta, struct sta_info, sta);
@@ -993,6 +979,8 @@ void ieee80211_process_addba_resp(struct ieee80211_local *local,
 	u16 capab, tid, buf_size;
 	bool amsdu;
 
+	lockdep_assert_wiphy(sta->local->hw.wiphy);
+
 	capab = le16_to_cpu(mgmt->u.action.u.addba_resp.capab);
 	amsdu = capab & IEEE80211_ADDBA_PARAM_AMSDU_MASK;
 	tid = u16_get_bits(capab, IEEE80211_ADDBA_PARAM_TID_MASK);
@@ -1003,16 +991,14 @@ void ieee80211_process_addba_resp(struct ieee80211_local *local,
 	if (!amsdu && txq)
 		set_bit(IEEE80211_TXQ_NO_AMSDU, &to_txq_info(txq)->flags);
 
-	mutex_lock(&sta->ampdu_mlme.mtx);
-
 	tid_tx = rcu_dereference_protected_tid_tx(sta, tid);
 	if (!tid_tx)
-		goto out;
+		return;
 
 	if (mgmt->u.action.u.addba_resp.dialog_token != tid_tx->dialog_token) {
 		ht_dbg(sta->sdata, "wrong addBA response token, %pM tid %d\n",
 		       sta->sta.addr, tid);
-		goto out;
+		return;
 	}
 
 	del_timer_sync(&tid_tx->addba_resp_timer);
@@ -1030,7 +1016,7 @@ void ieee80211_process_addba_resp(struct ieee80211_local *local,
 		ht_dbg(sta->sdata,
 		       "got addBA resp for %pM tid %d but we already gave up\n",
 		       sta->sta.addr, tid);
-		goto out;
+		return;
 	}
 
 	/*
@@ -1044,7 +1030,7 @@ void ieee80211_process_addba_resp(struct ieee80211_local *local,
 		if (test_and_set_bit(HT_AGG_STATE_RESPONSE_RECEIVED,
 				     &tid_tx->state)) {
 			/* ignore duplicate response */
-			goto out;
+			return;
 		}
 
 		tid_tx->buf_size = buf_size;
@@ -1065,9 +1051,6 @@ void ieee80211_process_addba_resp(struct ieee80211_local *local,
 		}
 
 	} else {
-		___ieee80211_stop_tx_ba_session(sta, tid, AGG_STOP_DECLINED);
+		__ieee80211_stop_tx_ba_session(sta, tid, AGG_STOP_DECLINED);
 	}
-
- out:
-	mutex_unlock(&sta->ampdu_mlme.mtx);
 }
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index e8feed05528a..68cea2685224 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -316,16 +316,16 @@ void ieee80211_sta_tear_down_BA_sessions(struct sta_info *sta,
 {
 	int i;
 
-	mutex_lock(&sta->ampdu_mlme.mtx);
+	lockdep_assert_wiphy(sta->local->hw.wiphy);
+
 	for (i = 0; i <  IEEE80211_NUM_TIDS; i++)
-		___ieee80211_stop_rx_ba_session(sta, i, WLAN_BACK_RECIPIENT,
-						WLAN_REASON_QSTA_LEAVE_QBSS,
-						reason != AGG_STOP_DESTROY_STA &&
-						reason != AGG_STOP_PEER_REQUEST);
+		__ieee80211_stop_rx_ba_session(sta, i, WLAN_BACK_RECIPIENT,
+					       WLAN_REASON_QSTA_LEAVE_QBSS,
+					       reason != AGG_STOP_DESTROY_STA &&
+					       reason != AGG_STOP_PEER_REQUEST);
 
 	for (i = 0; i <  IEEE80211_NUM_TIDS; i++)
-		___ieee80211_stop_tx_ba_session(sta, i, reason);
-	mutex_unlock(&sta->ampdu_mlme.mtx);
+		__ieee80211_stop_tx_ba_session(sta, i, reason);
 
 	/*
 	 * In case the tear down is part of a reconfigure due to HW restart
@@ -335,7 +335,6 @@ void ieee80211_sta_tear_down_BA_sessions(struct sta_info *sta,
 	if(reason == AGG_STOP_DESTROY_STA) {
 		wiphy_work_cancel(sta->local->hw.wiphy, &sta->ampdu_mlme.work);
 
-		mutex_lock(&sta->ampdu_mlme.mtx);
 		for (i = 0; i < IEEE80211_NUM_TIDS; i++) {
 			struct tid_ampdu_tx *tid_tx =
 				rcu_dereference_protected_tid_tx(sta, i);
@@ -346,7 +345,6 @@ void ieee80211_sta_tear_down_BA_sessions(struct sta_info *sta,
 			if (test_and_clear_bit(HT_AGG_STATE_STOP_CB, &tid_tx->state))
 				ieee80211_stop_tx_ba_cb(sta, i, tid_tx);
 		}
-		mutex_unlock(&sta->ampdu_mlme.mtx);
 	}
 }
 
@@ -358,32 +356,33 @@ void ieee80211_ba_session_work(struct wiphy *wiphy, struct wiphy_work *work)
 	bool blocked;
 	int tid;
 
+	lockdep_assert_wiphy(sta->local->hw.wiphy);
+
 	/* When this flag is set, new sessions should be blocked. */
 	blocked = test_sta_flag(sta, WLAN_STA_BLOCK_BA);
 
-	mutex_lock(&sta->ampdu_mlme.mtx);
 	for (tid = 0; tid < IEEE80211_NUM_TIDS; tid++) {
 		if (test_and_clear_bit(tid, sta->ampdu_mlme.tid_rx_timer_expired))
-			___ieee80211_stop_rx_ba_session(
+			__ieee80211_stop_rx_ba_session(
 				sta, tid, WLAN_BACK_RECIPIENT,
 				WLAN_REASON_QSTA_TIMEOUT, true);
 
 		if (test_and_clear_bit(tid,
 				       sta->ampdu_mlme.tid_rx_stop_requested))
-			___ieee80211_stop_rx_ba_session(
+			__ieee80211_stop_rx_ba_session(
 				sta, tid, WLAN_BACK_RECIPIENT,
 				WLAN_REASON_UNSPECIFIED, true);
 
 		if (!blocked &&
 		    test_and_clear_bit(tid,
 				       sta->ampdu_mlme.tid_rx_manage_offl))
-			___ieee80211_start_rx_ba_session(sta, 0, 0, 0, 1, tid,
-							 IEEE80211_MAX_AMPDU_BUF_HT,
-							 false, true, NULL);
+			__ieee80211_start_rx_ba_session(sta, 0, 0, 0, 1, tid,
+							IEEE80211_MAX_AMPDU_BUF_HT,
+							false, true, NULL);
 
 		if (test_and_clear_bit(tid + IEEE80211_NUM_TIDS,
 				       sta->ampdu_mlme.tid_rx_manage_offl))
-			___ieee80211_stop_rx_ba_session(
+			__ieee80211_stop_rx_ba_session(
 				sta, tid, WLAN_BACK_RECIPIENT,
 				0, false);
 
@@ -414,8 +413,6 @@ void ieee80211_ba_session_work(struct wiphy *wiphy, struct wiphy_work *work)
 				 */
 				synchronize_net();
 
-				mutex_unlock(&sta->ampdu_mlme.mtx);
-
 				wiphy_work_queue(sdata->local->hw.wiphy, work);
 				return;
 			}
@@ -448,12 +445,11 @@ void ieee80211_ba_session_work(struct wiphy *wiphy, struct wiphy_work *work)
 		    test_and_clear_bit(HT_AGG_STATE_START_CB, &tid_tx->state))
 			ieee80211_start_tx_ba_cb(sta, tid, tid_tx);
 		if (test_and_clear_bit(HT_AGG_STATE_WANT_STOP, &tid_tx->state))
-			___ieee80211_stop_tx_ba_session(sta, tid,
-							AGG_STOP_LOCAL_REQUEST);
+			__ieee80211_stop_tx_ba_session(sta, tid,
+						       AGG_STOP_LOCAL_REQUEST);
 		if (test_and_clear_bit(HT_AGG_STATE_STOP_CB, &tid_tx->state))
 			ieee80211_stop_tx_ba_cb(sta, tid, tid_tx);
 	}
-	mutex_unlock(&sta->ampdu_mlme.mtx);
 }
 
 void ieee80211_send_delba(struct ieee80211_sub_if_data *sdata,
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index cc671b471542..7a8f950644ff 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2097,15 +2097,13 @@ int ieee80211_send_smps_action(struct ieee80211_sub_if_data *sdata,
 bool ieee80211_smps_is_restrictive(enum ieee80211_smps_mode smps_mode_old,
 				   enum ieee80211_smps_mode smps_mode_new);
 
-void ___ieee80211_stop_rx_ba_session(struct sta_info *sta, u16 tid,
-				     u16 initiator, u16 reason, bool stop);
 void __ieee80211_stop_rx_ba_session(struct sta_info *sta, u16 tid,
 				    u16 initiator, u16 reason, bool stop);
-void ___ieee80211_start_rx_ba_session(struct sta_info *sta,
-				      u8 dialog_token, u16 timeout,
-				      u16 start_seq_num, u16 ba_policy, u16 tid,
-				      u16 buf_size, bool tx, bool auto_seq,
-				      const struct ieee80211_addba_ext_ie *addbaext);
+void __ieee80211_start_rx_ba_session(struct sta_info *sta,
+				     u8 dialog_token, u16 timeout,
+				     u16 start_seq_num, u16 ba_policy, u16 tid,
+				     u16 buf_size, bool tx, bool auto_seq,
+				     const struct ieee80211_addba_ext_ie *addbaext);
 void ieee80211_sta_tear_down_BA_sessions(struct sta_info *sta,
 					 enum ieee80211_agg_stop_reason reason);
 void ieee80211_process_delba(struct ieee80211_sub_if_data *sdata,
@@ -2122,8 +2120,6 @@ void ieee80211_process_addba_request(struct ieee80211_local *local,
 
 int __ieee80211_stop_tx_ba_session(struct sta_info *sta, u16 tid,
 				   enum ieee80211_agg_stop_reason reason);
-int ___ieee80211_stop_tx_ba_session(struct sta_info *sta, u16 tid,
-				    enum ieee80211_agg_stop_reason reason);
 void ieee80211_start_tx_ba_cb(struct sta_info *sta, int tid,
 			      struct tid_ampdu_tx *tid_tx);
 void ieee80211_stop_tx_ba_cb(struct sta_info *sta, int tid,
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index 44053951a1da..ac410f6632b5 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -311,11 +311,9 @@ static void ieee80211_pairwise_rekey(struct ieee80211_key *old,
 			 * job done for the few ms we need it.)
 			 */
 			set_sta_flag(sta, WLAN_STA_BLOCK_BA);
-			mutex_lock(&sta->ampdu_mlme.mtx);
 			for (i = 0; i <  IEEE80211_NUM_TIDS; i++)
-				___ieee80211_stop_tx_ba_session(sta, i,
-								AGG_STOP_LOCAL_REQUEST);
-			mutex_unlock(&sta->ampdu_mlme.mtx);
+				__ieee80211_stop_tx_ba_session(sta, i,
+							       AGG_STOP_LOCAL_REQUEST);
 		}
 	} else if (old) {
 		/* Rekey without Extended Key ID.
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index eee541251c48..abcc280acd38 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -554,7 +554,6 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	spin_lock_init(&sta->ps_lock);
 	INIT_WORK(&sta->drv_deliver_wk, sta_deliver_ps_frames);
 	wiphy_work_init(&sta->ampdu_mlme.work, ieee80211_ba_session_work);
-	mutex_init(&sta->ampdu_mlme.mtx);
 #ifdef CONFIG_MAC80211_MESH
 	if (ieee80211_vif_is_mesh(&sdata->vif)) {
 		sta->mesh = kzalloc(sizeof(*sta->mesh), gfp);
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index c3cce280bc0f..aaf45d8523a1 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -259,9 +259,6 @@ struct tid_ampdu_rx {
 /**
  * struct sta_ampdu_mlme - STA aggregation information.
  *
- * @mtx: mutex to protect all TX data (except non-NULL assignments
- *	to tid_tx[idx], which are protected by the sta spinlock)
- *	tid_start_tx is also protected by sta->lock.
  * @tid_rx: aggregation info for Rx per TID -- RCU protected
  * @tid_rx_token: dialog tokens for valid aggregation sessions
  * @tid_rx_timer_expired: bitmap indicating on which TIDs the
@@ -275,13 +272,13 @@ struct tid_ampdu_rx {
  *	unexpected aggregation related frames outside a session
  * @work: work struct for starting/stopping aggregation
  * @tid_tx: aggregation info for Tx per TID
- * @tid_start_tx: sessions where start was requested
+ * @tid_start_tx: sessions where start was requested, not just protected
+ *	by wiphy mutex but also sta->lock
  * @last_addba_req_time: timestamp of the last addBA request.
  * @addba_req_num: number of times addBA request has been sent.
  * @dialog_token_allocator: dialog token enumerator for each new session;
  */
 struct sta_ampdu_mlme {
-	struct mutex mtx;
 	/* rx */
 	struct tid_ampdu_rx __rcu *tid_rx[IEEE80211_NUM_TIDS];
 	u8 tid_rx_token[IEEE80211_NUM_TIDS];
@@ -796,13 +793,10 @@ static inline void sta_info_pre_move_state(struct sta_info *sta,
 void ieee80211_assign_tid_tx(struct sta_info *sta, int tid,
 			     struct tid_ampdu_tx *tid_tx);
 
-static inline struct tid_ampdu_tx *
-rcu_dereference_protected_tid_tx(struct sta_info *sta, int tid)
-{
-	return rcu_dereference_protected(sta->ampdu_mlme.tid_tx[tid],
-					 lockdep_is_held(&sta->lock) ||
-					 lockdep_is_held(&sta->ampdu_mlme.mtx));
-}
+#define rcu_dereference_protected_tid_tx(sta, tid)			\
+	rcu_dereference_protected((sta)->ampdu_mlme.tid_tx[tid],	\
+				  lockdep_is_held(&(sta)->lock) ||	\
+				  lockdep_is_held(&(sta)->local->hw.wiphy->mtx));
 
 /* Maximum number of frames to buffer per power saving station per AC */
 #define STA_MAX_TX_BUFFER	64
-- 
2.41.0

