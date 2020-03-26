Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9EE193E80
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 13:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgCZMBE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 08:01:04 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44122 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728181AbgCZMBE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 08:01:04 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHRC1-0003we-Ed; Thu, 26 Mar 2020 14:01:01 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 14:00:36 +0200
Message-Id: <20200326120042.578777-7-luca@coelho.fi>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326120042.578777-1-luca@coelho.fi>
References: <20200326120042.578777-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH 06/12] mac80211: agg-tx: refactor sending addba
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

We move the actual arming the timer and sending ADDBA to a function
for the use in different places calling the same logic.

Change-Id: I75934e6464535fbf43969acc796bc886291e79a5
Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/agg-tx.c | 67 +++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 33da6f738c99..32f40c4f3120 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2019 Intel Corporation
+ * Copyright (C) 2018 - 2020 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -448,6 +448,43 @@ static void sta_addba_resp_timer_expired(struct timer_list *t)
 	ieee80211_stop_tx_ba_session(&sta->sta, tid);
 }
 
+static void ieee80211_send_addba_with_timeout(struct sta_info *sta,
+					      struct tid_ampdu_tx *tid_tx)
+{
+	struct ieee80211_sub_if_data *sdata = sta->sdata;
+	struct ieee80211_local *local = sta->local;
+	u8 tid = tid_tx->tid;
+	u16 buf_size;
+
+	/* activate the timer for the recipient's addBA response */
+	mod_timer(&tid_tx->addba_resp_timer, jiffies + ADDBA_RESP_INTERVAL);
+	ht_dbg(sdata, "activated addBA response timer on %pM tid %d\n",
+	       sta->sta.addr, tid);
+
+	spin_lock_bh(&sta->lock);
+	sta->ampdu_mlme.last_addba_req_time[tid] = jiffies;
+	sta->ampdu_mlme.addba_req_num[tid]++;
+	spin_unlock_bh(&sta->lock);
+
+	if (sta->sta.he_cap.has_he) {
+		buf_size = local->hw.max_tx_aggregation_subframes;
+	} else {
+		/*
+		 * We really should use what the driver told us it will
+		 * transmit as the maximum, but certain APs (e.g. the
+		 * LinkSys WRT120N with FW v1.0.07 build 002 Jun 18 2012)
+		 * will crash when we use a lower number.
+		 */
+		buf_size = IEEE80211_MAX_AMPDU_BUF_HT;
+	}
+
+	/* send AddBA request */
+	ieee80211_send_addba_request(sdata, sta->sta.addr, tid,
+				     tid_tx->dialog_token,
+				     sta->tid_seq[tid] >> 4,
+				     buf_size, tid_tx->timeout);
+}
+
 void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 {
 	struct tid_ampdu_tx *tid_tx;
@@ -462,7 +499,6 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 		.timeout = 0,
 	};
 	int ret;
-	u16 buf_size;
 
 	tid_tx = rcu_dereference_protected_tid_tx(sta, tid);
 
@@ -508,32 +544,7 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 		return;
 	}
 
-	/* activate the timer for the recipient's addBA response */
-	mod_timer(&tid_tx->addba_resp_timer, jiffies + ADDBA_RESP_INTERVAL);
-	ht_dbg(sdata, "activated addBA response timer on %pM tid %d\n",
-	       sta->sta.addr, tid);
-
-	spin_lock_bh(&sta->lock);
-	sta->ampdu_mlme.last_addba_req_time[tid] = jiffies;
-	sta->ampdu_mlme.addba_req_num[tid]++;
-	spin_unlock_bh(&sta->lock);
-
-	if (sta->sta.he_cap.has_he) {
-		buf_size = local->hw.max_tx_aggregation_subframes;
-	} else {
-		/*
-		 * We really should use what the driver told us it will
-		 * transmit as the maximum, but certain APs (e.g. the
-		 * LinkSys WRT120N with FW v1.0.07 build 002 Jun 18 2012)
-		 * will crash when we use a lower number.
-		 */
-		buf_size = IEEE80211_MAX_AMPDU_BUF_HT;
-	}
-
-	/* send AddBA request */
-	ieee80211_send_addba_request(sdata, sta->sta.addr, tid,
-				     tid_tx->dialog_token, params.ssn,
-				     buf_size, tid_tx->timeout);
+	ieee80211_send_addba_with_timeout(sta, tid_tx);
 }
 
 /*
-- 
2.25.1

