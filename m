Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147D0193F79
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 14:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgCZNKB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 09:10:01 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:44354 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726260AbgCZNKA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 09:10:00 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <luca@coelho.fi>)
        id 1jHSGk-00044K-Ij; Thu, 26 Mar 2020 15:09:59 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 26 Mar 2020 15:09:38 +0200
Message-Id: <iwlwifi.20200326150855.0f27423fec75.If67daab123a27c1cbddef000d6a3f212aa6309ef@changeid>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200326130943.623208-1-luca@coelho.fi>
References: <20200326130943.623208-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.4
Subject: [PATCH v2 07/12] mac80211: agg-tx: add an option to defer ADDBA transmit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Driver tells mac80211 to sends ADDBA with SSN (starting sequence number)
from the head of the queue, while the transmission of all the frames in the
queue may take a while, which causes the peer to time out. In order to
fix this scenario, add an option to defer ADDBA transmit until queue
is drained.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 include/net/mac80211.h  |  6 +++++-
 net/mac80211/agg-tx.c   | 12 +++++++++++-
 net/mac80211/sta_info.h |  2 ++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index f2b0a7795d0a..bcf706798e52 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -3119,7 +3119,10 @@ enum ieee80211_filter_flags {
  * @IEEE80211_AMPDU_RX_START: start RX aggregation
  * @IEEE80211_AMPDU_RX_STOP: stop RX aggregation
  * @IEEE80211_AMPDU_TX_START: start TX aggregation, the driver must either
- *	call ieee80211_start_tx_ba_cb_irqsafe() or return the special
+ *	call ieee80211_start_tx_ba_cb_irqsafe() or
+ *	call ieee80211_start_tx_ba_cb_irqsafe() with status
+ *	%IEEE80211_AMPDU_TX_START_DELAY_ADDBA to delay addba after
+ *	ieee80211_start_tx_ba_cb_irqsafe is called, or just return the special
  *	status %IEEE80211_AMPDU_TX_START_IMMEDIATE.
  * @IEEE80211_AMPDU_TX_OPERATIONAL: TX aggregation has become operational
  * @IEEE80211_AMPDU_TX_STOP_CONT: stop TX aggregation but continue transmitting
@@ -3145,6 +3148,7 @@ enum ieee80211_ampdu_mlme_action {
 };
 
 #define IEEE80211_AMPDU_TX_START_IMMEDIATE 1
+#define IEEE80211_AMPDU_TX_START_DELAY_ADDBA 2
 
 /**
  * struct ieee80211_ampdu_params - AMPDU action parameters
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 32f40c4f3120..c2d5f512526d 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -483,6 +483,8 @@ static void ieee80211_send_addba_with_timeout(struct sta_info *sta,
 				     tid_tx->dialog_token,
 				     sta->tid_seq[tid] >> 4,
 				     buf_size, tid_tx->timeout);
+
+	WARN_ON(test_and_set_bit(HT_AGG_STATE_SENT_ADDBA, &tid_tx->state));
 }
 
 void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
@@ -521,7 +523,9 @@ void ieee80211_tx_ba_session_handle_start(struct sta_info *sta, int tid)
 
 	params.ssn = sta->tid_seq[tid] >> 4;
 	ret = drv_ampdu_action(local, sdata, &params);
-	if (ret == IEEE80211_AMPDU_TX_START_IMMEDIATE) {
+	if (ret == IEEE80211_AMPDU_TX_START_DELAY_ADDBA) {
+		return;
+	} else if (ret == IEEE80211_AMPDU_TX_START_IMMEDIATE) {
 		/*
 		 * We didn't send the request yet, so don't need to check
 		 * here if we already got a response, just mark as driver
@@ -765,6 +769,12 @@ void ieee80211_start_tx_ba_cb(struct sta_info *sta, int tid,
 	if (WARN_ON(test_and_set_bit(HT_AGG_STATE_DRV_READY, &tid_tx->state)))
 		return;
 
+	if (!test_bit(HT_AGG_STATE_SENT_ADDBA, &tid_tx->state)) {
+		ieee80211_send_addba_with_timeout(sta, tid_tx);
+		/* RESPONSE_RECEIVED state whould trigger the flow again */
+		return;
+	}
+
 	if (test_bit(HT_AGG_STATE_RESPONSE_RECEIVED, &tid_tx->state))
 		ieee80211_agg_tx_operational(local, sta, tid);
 }
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 364a35414d05..78ab18eee1ec 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -3,6 +3,7 @@
  * Copyright 2002-2005, Devicescape Software, Inc.
  * Copyright 2013-2014  Intel Mobile Communications GmbH
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
+ * Copyright(c) 2020 Intel Corporation
  */
 
 #ifndef STA_INFO_H
@@ -115,6 +116,7 @@ enum ieee80211_sta_info_flags {
 #define HT_AGG_STATE_WANT_STOP		5
 #define HT_AGG_STATE_START_CB		6
 #define HT_AGG_STATE_STOP_CB		7
+#define HT_AGG_STATE_SENT_ADDBA		8
 
 DECLARE_EWMA(avg_signal, 10, 8)
 enum ieee80211_agg_stop_reason {
-- 
2.25.1

