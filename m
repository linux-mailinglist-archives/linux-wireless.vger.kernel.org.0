Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064253428AF
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 23:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhCSW2f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 18:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhCSW2F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 18:28:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253BBC061760
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 15:28:05 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lNNb9-000keW-8R; Fri, 19 Mar 2021 23:28:03 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: don't apply flow control on management frames
Date:   Fri, 19 Mar 2021 23:28:01 +0100
Message-Id: <20210319232800.0e876c800866.Id2b66eb5a17f3869b776c39b5ca713272ea09d5d@changeid>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In some cases (depending on the driver, but it's true e.g. for
iwlwifi) we're using an internal TXQ for management packets,
mostly to simplify the code and to have a place to queue them.
However, it appears that in certain cases we can confuse the
code and management frames are dropped, which is certainly not
what we want.

Short-circuit the processing of management frames. To keep the
impact minimal, only put them on the frags queue and check the
tid == management only for doing that and to skip the airtime
fairness checks, if applicable.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/tx.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 5d06de61047a..b2d09acb9fb0 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2014  Intel Mobile Communications GmbH
- * Copyright (C) 2018-2020 Intel Corporation
+ * Copyright (C) 2018-2021 Intel Corporation
  *
  * Transmit and frame generation functions.
  */
@@ -1388,8 +1388,17 @@ static void ieee80211_txq_enqueue(struct ieee80211_local *local,
 	ieee80211_set_skb_enqueue_time(skb);
 
 	spin_lock_bh(&fq->lock);
-	fq_tin_enqueue(fq, tin, flow_idx, skb,
-		       fq_skb_free_func);
+	/*
+	 * For management frames, don't really apply codel etc.,
+	 * we don't want to apply any shaping or anything we just
+	 * want to simplify the driver API by having them on the
+	 * txqi.
+	 */
+	if (unlikely(txqi->txq.tid == IEEE80211_NUM_TIDS))
+		__skb_queue_tail(&txqi->frags, skb);
+	else
+		fq_tin_enqueue(fq, tin, flow_idx, skb,
+			       fq_skb_free_func);
 	spin_unlock_bh(&fq->lock);
 }
 
@@ -3835,6 +3844,9 @@ bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
 	if (!txq->sta)
 		return true;
 
+	if (unlikely(txq->tid == IEEE80211_NUM_TIDS))
+		return true;
+
 	sta = container_of(txq->sta, struct sta_info, sta);
 	if (atomic_read(&sta->airtime[txq->ac].aql_tx_pending) <
 	    sta->airtime[txq->ac].aql_limit_low)
-- 
2.30.2

