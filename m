Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F3878AF8D
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjH1MFv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjH1MF2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:05:28 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5D4120
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=dHPdFBlbr7V3tY+fwFyJRu8N0PfnlqeuFo9h2ZzEAk4=;
        t=1693224324; x=1694433924; b=erqmBQ1C9cfb/qINjxcfj9e0/HEFLnM58WpKzPFrbaL+odA
        f1TFjoqG7nHMZkeRWVd9o+IZR8m+JTpkL2WGSZ5qhCmcqOG+WtUs7H/hc1ZBZl3CaPpvJan2U98VD
        x1XhCQreh3JX2P956C88FOtFOAmRy22Qw+KDLfcJIAw5g7EtV4p+J0o+r361S4AvKEJ7Vail/KvIV
        Io4PmqMDLVR+JNQ0FTtH1t++TK20J0m28UK6xjVuW0qIMJCEdKSPuw2oQFnu/FlsDhjKUBfo9Vbih
        EAHveu1Q9MR4DQsk0vBdLbc1tRubKFCJOpJhG5YIyoyHzfEW5oQ7COM8RyVxWQVQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qaazi-00Gjgt-1I;
        Mon, 28 Aug 2023 14:05:22 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 07/40] wifi: mac80211: convert A-MPDU work to wiphy work
Date:   Mon, 28 Aug 2023 13:59:35 +0200
Message-ID: <20230828135927.3250f8704e8c.Ic6e0944a423436d578ab4c2b4271dc5dba6932fc@changeid>
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

Convert the A-MPDU work to wiphy work so it holds the
wiphy mutex and we can later guarantee that to drivers.
It might seem that we could run these concurrently for
different stations, but they're all on the ordered
mac80211 workqueue, so this shouldn't matter for that.

Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/agg-rx.c      | 12 +++++-------
 net/mac80211/agg-tx.c      |  8 ++++----
 net/mac80211/ht.c          |  6 +++---
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/sta_info.c    |  2 +-
 net/mac80211/sta_info.h    |  2 +-
 6 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index c6fa53230450..a686f1ce66cb 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2023 Intel Corporation
  */
 
 /**
@@ -140,7 +140,7 @@ void ieee80211_stop_rx_ba_session(struct ieee80211_vif *vif, u16 ba_rx_bitmap,
 		if (ba_rx_bitmap & BIT(i))
 			set_bit(i, sta->ampdu_mlme.tid_rx_stop_requested);
 
-	ieee80211_queue_work(&sta->local->hw, &sta->ampdu_mlme.work);
+	wiphy_work_queue(sta->local->hw.wiphy, &sta->ampdu_mlme.work);
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL(ieee80211_stop_rx_ba_session);
@@ -166,7 +166,7 @@ static void sta_rx_agg_session_timer_expired(struct timer_list *t)
 	       sta->sta.addr, tid);
 
 	set_bit(tid, sta->ampdu_mlme.tid_rx_timer_expired);
-	ieee80211_queue_work(&sta->local->hw, &sta->ampdu_mlme.work);
+	wiphy_work_queue(sta->local->hw.wiphy, &sta->ampdu_mlme.work);
 }
 
 static void sta_rx_agg_reorder_timer_expired(struct timer_list *t)
@@ -507,7 +507,6 @@ void ieee80211_manage_rx_ba_offl(struct ieee80211_vif *vif,
 				 const u8 *addr, unsigned int tid)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
-	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta;
 
 	rcu_read_lock();
@@ -516,7 +515,7 @@ void ieee80211_manage_rx_ba_offl(struct ieee80211_vif *vif,
 		goto unlock;
 
 	set_bit(tid, sta->ampdu_mlme.tid_rx_manage_offl);
-	ieee80211_queue_work(&local->hw, &sta->ampdu_mlme.work);
+	wiphy_work_queue(sta->local->hw.wiphy, &sta->ampdu_mlme.work);
  unlock:
 	rcu_read_unlock();
 }
@@ -526,7 +525,6 @@ void ieee80211_rx_ba_timer_expired(struct ieee80211_vif *vif,
 				   const u8 *addr, unsigned int tid)
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
-	struct ieee80211_local *local = sdata->local;
 	struct sta_info *sta;
 
 	rcu_read_lock();
@@ -535,7 +533,7 @@ void ieee80211_rx_ba_timer_expired(struct ieee80211_vif *vif,
 		goto unlock;
 
 	set_bit(tid, sta->ampdu_mlme.tid_rx_timer_expired);
-	ieee80211_queue_work(&local->hw, &sta->ampdu_mlme.work);
+	wiphy_work_queue(sta->local->hw.wiphy, &sta->ampdu_mlme.work);
 
  unlock:
 	rcu_read_unlock();
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index b6b772685881..3da0c55f13e2 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -743,7 +743,7 @@ int ieee80211_start_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid,
 	 */
 	sta->ampdu_mlme.tid_start_tx[tid] = tid_tx;
 
-	ieee80211_queue_work(&local->hw, &sta->ampdu_mlme.work);
+	wiphy_work_queue(local->hw.wiphy, &sta->ampdu_mlme.work);
 
 	/* this flow continues off the work */
  err_unlock_sta:
@@ -862,7 +862,7 @@ void ieee80211_start_tx_ba_cb_irqsafe(struct ieee80211_vif *vif,
 		goto out;
 
 	set_bit(HT_AGG_STATE_START_CB, &tid_tx->state);
-	ieee80211_queue_work(&local->hw, &sta->ampdu_mlme.work);
+	wiphy_work_queue(local->hw.wiphy, &sta->ampdu_mlme.work);
  out:
 	rcu_read_unlock();
 }
@@ -916,7 +916,7 @@ int ieee80211_stop_tx_ba_session(struct ieee80211_sta *pubsta, u16 tid)
 	}
 
 	set_bit(HT_AGG_STATE_WANT_STOP, &tid_tx->state);
-	ieee80211_queue_work(&local->hw, &sta->ampdu_mlme.work);
+	wiphy_work_queue(local->hw.wiphy, &sta->ampdu_mlme.work);
 
  unlock:
 	spin_unlock_bh(&sta->lock);
@@ -976,7 +976,7 @@ void ieee80211_stop_tx_ba_cb_irqsafe(struct ieee80211_vif *vif,
 		goto out;
 
 	set_bit(HT_AGG_STATE_STOP_CB, &tid_tx->state);
-	ieee80211_queue_work(&local->hw, &sta->ampdu_mlme.work);
+	wiphy_work_queue(local->hw.wiphy, &sta->ampdu_mlme.work);
  out:
 	rcu_read_unlock();
 }
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 05f98f0a91a8..e8feed05528a 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -333,7 +333,7 @@ void ieee80211_sta_tear_down_BA_sessions(struct sta_info *sta,
 	 * the BA session, so handle it to properly clean tid_tx data.
 	 */
 	if(reason == AGG_STOP_DESTROY_STA) {
-		cancel_work_sync(&sta->ampdu_mlme.work);
+		wiphy_work_cancel(sta->local->hw.wiphy, &sta->ampdu_mlme.work);
 
 		mutex_lock(&sta->ampdu_mlme.mtx);
 		for (i = 0; i < IEEE80211_NUM_TIDS; i++) {
@@ -350,7 +350,7 @@ void ieee80211_sta_tear_down_BA_sessions(struct sta_info *sta,
 	}
 }
 
-void ieee80211_ba_session_work(struct work_struct *work)
+void ieee80211_ba_session_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct sta_info *sta =
 		container_of(work, struct sta_info, ampdu_mlme.work);
@@ -416,7 +416,7 @@ void ieee80211_ba_session_work(struct work_struct *work)
 
 				mutex_unlock(&sta->ampdu_mlme.mtx);
 
-				ieee80211_queue_work(&sdata->local->hw, work);
+				wiphy_work_queue(sdata->local->hw.wiphy, work);
 				return;
 			}
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 338ab9e6e6b1..7604e43a441c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2134,7 +2134,7 @@ void ieee80211_start_tx_ba_cb(struct sta_info *sta, int tid,
 			      struct tid_ampdu_tx *tid_tx);
 void ieee80211_stop_tx_ba_cb(struct sta_info *sta, int tid,
 			     struct tid_ampdu_tx *tid_tx);
-void ieee80211_ba_session_work(struct work_struct *work);
+void ieee80211_ba_session_work(struct wiphy *wiphy, struct wiphy_work *work);
 void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid);
 void ieee80211_release_reorder_timeout(struct sta_info *sta, int tid);
 
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 7751f8ba960e..b68bf77b05d0 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -556,7 +556,7 @@ __sta_info_alloc(struct ieee80211_sub_if_data *sdata,
 	spin_lock_init(&sta->lock);
 	spin_lock_init(&sta->ps_lock);
 	INIT_WORK(&sta->drv_deliver_wk, sta_deliver_ps_frames);
-	INIT_WORK(&sta->ampdu_mlme.work, ieee80211_ba_session_work);
+	wiphy_work_init(&sta->ampdu_mlme.work, ieee80211_ba_session_work);
 	mutex_init(&sta->ampdu_mlme.mtx);
 #ifdef CONFIG_MAC80211_MESH
 	if (ieee80211_vif_is_mesh(&sdata->vif)) {
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 195b563132d6..1deab7e33a7c 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -291,7 +291,7 @@ struct sta_ampdu_mlme {
 	unsigned long agg_session_valid[BITS_TO_LONGS(IEEE80211_NUM_TIDS)];
 	unsigned long unexpected_agg[BITS_TO_LONGS(IEEE80211_NUM_TIDS)];
 	/* tx */
-	struct work_struct work;
+	struct wiphy_work work;
 	struct tid_ampdu_tx __rcu *tid_tx[IEEE80211_NUM_TIDS];
 	struct tid_ampdu_tx *tid_start_tx[IEEE80211_NUM_TIDS];
 	unsigned long last_addba_req_time[IEEE80211_NUM_TIDS];
-- 
2.41.0

