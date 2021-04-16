Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FEF361F15
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Apr 2021 13:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240600AbhDPLri (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Apr 2021 07:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240164AbhDPLrh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Apr 2021 07:47:37 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92F0C061574
        for <linux-wireless@vger.kernel.org>; Fri, 16 Apr 2021 04:47:12 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lXMwI-00CXeP-1s; Fri, 16 Apr 2021 13:47:10 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: properly process TXQ management frames
Date:   Fri, 16 Apr 2021 13:47:04 +0200
Message-Id: <20210416134702.ef8486a64293.If0a9025b39c71bb91b11dd6ac45547aba682df34@changeid>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

My previous commit to not apply flow control to management frames
that are going over TXQs (which is currently only the case for
iwlwifi, I think) broke things, with iwlwifi firmware crashing on
certain frames. As it turns out, that was due to the frame being
too short: space for the MIC wasn't added at the end of encrypted
management frames.

Clearly, this is due to using the 'frags' queue - this is meant
only for frames that have already been processed for TX, and the
code in ieee80211_tx_dequeue() just returns them. This caused all
management frames to now not get any TX processing.

To fix this, use IEEE80211_TX_INTCFL_NEED_TXPROCESSING (which is
currently used only in other circumstances) to indicate that the
frames need processing, and clear it immediately after so that,
at least in theory, MMPDUs can be fragmented.

Fixes: 73bc9e0af594 ("mac80211: don't apply flow control on management frames")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/tx.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 3d6c5b8ec0c2..8aeb60182f10 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -1394,11 +1394,14 @@ static void ieee80211_txq_enqueue(struct ieee80211_local *local,
 	 * want to simplify the driver API by having them on the
 	 * txqi.
 	 */
-	if (unlikely(txqi->txq.tid == IEEE80211_NUM_TIDS))
+	if (unlikely(txqi->txq.tid == IEEE80211_NUM_TIDS)) {
+		IEEE80211_SKB_CB(skb)->control.flags |=
+			IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
 		__skb_queue_tail(&txqi->frags, skb);
-	else
+	} else {
 		fq_tin_enqueue(fq, tin, flow_idx, skb,
 			       fq_skb_free_func);
+	}
 	spin_unlock_bh(&fq->lock);
 }
 
@@ -3587,10 +3590,16 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 
 	/* Make sure fragments stay together. */
 	skb = __skb_dequeue(&txqi->frags);
-	if (skb)
-		goto out;
+	if (unlikely(skb)) {
+		if (!(IEEE80211_SKB_CB(skb)->control.flags &
+				IEEE80211_TX_INTCFL_NEED_TXPROCESSING))
+			goto out;
+		IEEE80211_SKB_CB(skb)->control.flags &=
+			~IEEE80211_TX_INTCFL_NEED_TXPROCESSING;
+	} else {
+		skb = fq_tin_dequeue(fq, tin, fq_tin_dequeue_func);
+	}
 
-	skb = fq_tin_dequeue(fq, tin, fq_tin_dequeue_func);
 	if (!skb)
 		goto out;
 
-- 
2.30.2

