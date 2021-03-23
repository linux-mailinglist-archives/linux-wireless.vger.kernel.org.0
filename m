Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E0234698E
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Mar 2021 21:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhCWUF2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Mar 2021 16:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbhCWUFN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Mar 2021 16:05:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14AEC061574
        for <linux-wireless@vger.kernel.org>; Tue, 23 Mar 2021 13:05:12 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lOnGy-002FKb-5M; Tue, 23 Mar 2021 21:05:04 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: fix TXQ AC confusion
Date:   Tue, 23 Mar 2021 21:05:01 +0100
Message-Id: <20210323210500.bf4d50afea4a.I136ffde910486301f8818f5442e3c9bf8670a9c4@changeid>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Normally, TXQs have

  txq->tid = tid;
  txq->ac = ieee80211_ac_from_tid(tid);

However, the special management TXQ actually has

  txq->tid = IEEE80211_NUM_TIDS; // 16
  txq->ac = IEEE80211_AC_VO;

This makes sense, but ieee80211_ac_from_tid(16) is the same
as ieee80211_ac_from_tid(0) which is just IEEE80211_AC_BE.

Now, normally this is fine. However, if the netdev queues
were stopped, then the code in ieee80211_tx_dequeue() will
propagate the stop from the interface (vif->txqs_stopped[])
if the AC 2 (ieee80211_ac_from_tid(txq->tid)) is marked as
stopped. On wake, however, __ieee80211_wake_txqs() will wake
the TXQ if AC 0 (txq->ac) is woken up.

If a driver stops all queues with ieee80211_stop_tx_queues()
and then wakes them again with ieee80211_wake_tx_queues(),
the ieee80211_wake_txqs() tasklet will run to resync queue
and TXQ state. If all queues were woken, then what'll happen
is that _ieee80211_wake_txqs() will run in order of HW queues
0-3, typically (and certainly for iwlwifi) corresponding to
ACs 0-3, so it'll call __ieee80211_wake_txqs() for each AC in
order 0-3.

When __ieee80211_wake_txqs() is called for AC 0 (VO) that'll
wake up the management TXQ (remember its tid is 16), and the
driver's wake_tx_queue() will be called. That tries to get a
frame, which will immediately *stop* the TXQ again, because
now we check against AC 2, and AC 2 hasn't yet been marked as
woken up again in sdata->vif.txqs_stopped[] since we're only
in the __ieee80211_wake_txqs() call for AC 0.

Thus, the management TXQ will never be started again.

Fix this by checking txq->ac directly instead of calculating
the AC as ieee80211_ac_from_tid(txq->tid).

Fixes: adf8ed01e4fd ("mac80211: add an optional TXQ for other PS-buffered frames")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index b2d09acb9fb0..4b261581593f 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3582,7 +3582,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 	    test_bit(IEEE80211_TXQ_STOP_NETIF_TX, &txqi->flags))
 		goto out;
 
-	if (vif->txqs_stopped[ieee80211_ac_from_tid(txq->tid)]) {
+	if (vif->txqs_stopped[txq->ac]) {
 		set_bit(IEEE80211_TXQ_STOP_NETIF_TX, &txqi->flags);
 		goto out;
 	}
-- 
2.30.2

