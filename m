Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7924B13BE53
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2020 12:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgAOLZ6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Jan 2020 06:25:58 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:40576 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbgAOLZ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Jan 2020 06:25:58 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1irgo7-008wNL-R1; Wed, 15 Jan 2020 12:25:55 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     toke@redhat.com, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] mac80211: use more bits for ack_frame_id
Date:   Wed, 15 Jan 2020 12:25:50 +0100
Message-Id: <20200115122549.b9a4ef9f4980.Ied52ed90150220b83a280009c590b65d125d087c@changeid>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

It turns out that this wasn't a good idea, I hit a test failure in
hwsim due to this. That particular failure was easily worked around,
but it raised questions: if an AP needs to, for example, send action
frames to each connected station, the current limit is nowhere near
enough (especially if those stations are sleeping and the frames are
queued for a while.)

Shuffle around some bits to make more room for ack_frame_id to allow
up to 8192 queued up frames, that's enough for queueing 4 frames to
each connected station, even at the maximum of 2007 stations on a
single AP.

We take the bits from band (which currently only 2 but I leave 3 in
case we add another band) and from the hw_queue, which can only need
4 since it has a limit of 16 queues.

Fixes: 6912daed05e1 ("mac80211: Shrink the size of ack_frame_id to make room for tx_time_est")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/mac80211.h | 11 +++++------
 net/mac80211/cfg.c     |  2 +-
 net/mac80211/tx.c      |  2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 6d4ea71523d2..64a249445c86 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1007,12 +1007,11 @@ ieee80211_rate_get_vht_nss(const struct ieee80211_tx_rate *rate)
 struct ieee80211_tx_info {
 	/* common information */
 	u32 flags;
-	u8 band;
-
-	u8 hw_queue;
-
-	u16 ack_frame_id:6;
-	u16 tx_time_est:10;
+	u32 band:3,
+	    ack_frame_id:13,
+	    hw_queue:4,
+	    tx_time_est:10;
+	/* 2 free bits */
 
 	union {
 		struct {
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index a11bd1669c13..5715c4606cff 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3431,7 +3431,7 @@ int ieee80211_attach_ack_skb(struct ieee80211_local *local, struct sk_buff *skb,
 
 	spin_lock_irqsave(&local->ack_status_lock, spin_flags);
 	id = idr_alloc(&local->ack_status_frames, ack_skb,
-		       1, 0x40, GFP_ATOMIC);
+		       1, 0x2000, GFP_ATOMIC);
 	spin_unlock_irqrestore(&local->ack_status_lock, spin_flags);
 
 	if (id < 0) {
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 4296d9d71311..4520cda6f523 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2443,7 +2443,7 @@ static int ieee80211_store_ack_skb(struct ieee80211_local *local,
 
 		spin_lock_irqsave(&local->ack_status_lock, flags);
 		id = idr_alloc(&local->ack_status_frames, ack_skb,
-			       1, 0x40, GFP_ATOMIC);
+			       1, 0x2000, GFP_ATOMIC);
 		spin_unlock_irqrestore(&local->ack_status_lock, flags);
 
 		if (id >= 0) {
-- 
2.24.1

