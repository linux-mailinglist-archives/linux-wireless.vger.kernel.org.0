Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE5A4616A5
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 14:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377668AbhK2Nig (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 08:38:36 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:49850 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1377765AbhK2Ng3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 08:36:29 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1mrgmI-0012xo-8W; Mon, 29 Nov 2021 15:33:06 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon, 29 Nov 2021 15:32:47 +0200
Message-Id: <iwlwifi.20211129152938.d5fceeb7e166.I555fef8e67d93fff3d9a304886c4a9f8b322e591@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211129133248.83829-1-luca@coelho.fi>
References: <20211129133248.83829-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 15/16] mac80211: agg-tx: don't schedule_and_wake_txq() under sta->lock
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When we call ieee80211_agg_start_txq(), that will in turn call
schedule_and_wake_txq(). Called from ieee80211_stop_tx_ba_cb()
this is done under sta->lock, which leads to certain circular
lock dependencies, as reported by Chris Murphy:
https://lore.kernel.org/r/CAJCQCtSXJ5qA4bqSPY=oLRMbv-irihVvP7A2uGutEbXQVkoNaw@mail.gmail.com

In general, ieee80211_agg_start_txq() is usually not called
with sta->lock held, only in this one place. But it's always
called with sta->ampdu_mlme.mtx held, and that's therefore
clearly sufficient.

Change ieee80211_stop_tx_ba_cb() to also call it without the
sta->lock held, by factoring it out of ieee80211_remove_tid_tx()
(which is only called in this one place).

This breaks the locking chain and makes it less likely that
we'll have similar locking chain problems in the future.

Reported-by: Chris Murphy <lists@colorremedies.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/agg-tx.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 430a58587538..4dd56daed89b 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2020 Intel Corporation
+ * Copyright (C) 2018 - 2021 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -213,6 +213,8 @@ ieee80211_agg_start_txq(struct sta_info *sta, int tid, bool enable)
 	struct ieee80211_txq *txq = sta->sta.txq[tid];
 	struct txq_info *txqi;
 
+	lockdep_assert_held(&sta->ampdu_mlme.mtx);
+
 	if (!txq)
 		return;
 
@@ -290,7 +292,6 @@ static void ieee80211_remove_tid_tx(struct sta_info *sta, int tid)
 	ieee80211_assign_tid_tx(sta, tid, NULL);
 
 	ieee80211_agg_splice_finish(sta->sdata, tid);
-	ieee80211_agg_start_txq(sta, tid, false);
 
 	kfree_rcu(tid_tx, rcu_head);
 }
@@ -889,6 +890,7 @@ void ieee80211_stop_tx_ba_cb(struct sta_info *sta, int tid,
 {
 	struct ieee80211_sub_if_data *sdata = sta->sdata;
 	bool send_delba = false;
+	bool start_txq = false;
 
 	ht_dbg(sdata, "Stopping Tx BA session for %pM tid %d\n",
 	       sta->sta.addr, tid);
@@ -906,10 +908,14 @@ void ieee80211_stop_tx_ba_cb(struct sta_info *sta, int tid,
 		send_delba = true;
 
 	ieee80211_remove_tid_tx(sta, tid);
+	start_txq = true;
 
  unlock_sta:
 	spin_unlock_bh(&sta->lock);
 
+	if (start_txq)
+		ieee80211_agg_start_txq(sta, tid, false);
+
 	if (send_delba)
 		ieee80211_send_delba(sdata, sta->sta.addr, tid,
 			WLAN_BACK_INITIATOR, WLAN_REASON_QSTA_NOT_USE);
-- 
2.33.1

