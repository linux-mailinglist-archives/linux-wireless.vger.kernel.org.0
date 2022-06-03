Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0E653CD64
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 18:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344026AbiFCQnL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 12:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244604AbiFCQnL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 12:43:11 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54F844A34
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 09:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=YFAuZK3IjSVFKlxIy72wF5nE/Y62njySheaIF4pGFsg=; b=LJaISMF+MY/DRHLzjfmbhPUAhb
        wwH0aOv8cjrKWd7G5lmJ+mWLbioTnMDwq+BhVDm9psbfxZN0dpGi9uBDYrbyhP115aTo1rqAPHGCB
        uiMpFIn2cfMZnUHX33qfQ7Ska3ZIYltftx6MFj96woHB30MUlowQLkS9wns7SbcKOo/g=;
Received: from p200300daa70ef200855b9684f56ef019.dip0.t-ipconnect.de ([2003:da:a70e:f200:855b:9684:f56e:f019] helo=Maecks.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1nxAOB-0001lB-Ob; Fri, 03 Jun 2022 18:43:07 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 1/2] mac80211: fix overflow issues in airtime fairness code
Date:   Fri,  3 Jun 2022 18:43:06 +0200
Message-Id: <20220603164307.92189-1-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The airtime weight calculation overflows with a default weight value of 256
whenever more than 8ms worth of airtime is reported.
Bigger weight values impose even smaller limits on maximum airtime values.
This can mess up airtime based calculations for drivers that don't report
per-PPDU airtime values, but batch up values instead.

Fix this by reordering multiplications/shifts and by reducing unnecessary
intermediate precision (which was lost in a later stage anyway).

The new shift value limits the maximum weight to 4096, which should be more
than enough. Any values bigger than that will be clamped to the upper limit.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/ieee80211_i.h | 42 ++++++++++++--------------------------
 net/mac80211/sta_info.c    | 20 +++++++-----------
 2 files changed, 20 insertions(+), 42 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 86ef0a46a68c..5ca4c2c6aa3c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1677,50 +1677,34 @@ static inline struct airtime_info *to_airtime_info(struct ieee80211_txq *txq)
 /* To avoid divisions in the fast path, we keep pre-computed reciprocals for
  * airtime weight calculations. There are two different weights to keep track
  * of: The per-station weight and the sum of weights per phy.
- *
- * For the per-station weights (kept in airtime_info below), we use 32-bit
- * reciprocals with a devisor of 2^19. This lets us keep the multiplications and
- * divisions for the station weights as 32-bit operations at the cost of a bit
- * of rounding error for high weights; but the choice of divisor keeps rounding
- * errors <10% for weights <2^15, assuming no more than 8ms of airtime is
- * reported at a time.
- *
- * For the per-phy sum of weights the values can get higher, so we use 64-bit
- * operations for those with a 32-bit divisor, which should avoid any
- * significant rounding errors.
+ * The per-sta shift value supports weight values of 1-4096
  */
-#define IEEE80211_RECIPROCAL_DIVISOR_64 0x100000000ULL
-#define IEEE80211_RECIPROCAL_SHIFT_64 32
-#define IEEE80211_RECIPROCAL_DIVISOR_32 0x80000U
-#define IEEE80211_RECIPROCAL_SHIFT_32 19
+#define IEEE80211_RECIPROCAL_SHIFT_SUM	24
+#define IEEE80211_RECIPROCAL_SHIFT_STA	12
+#define IEEE80211_WEIGHT_SHIFT		8
 
-static inline void airtime_weight_set(struct airtime_info *air_info, u16 weight)
+static inline void airtime_weight_set(struct airtime_info *air_info, u32 weight)
 {
+	weight = min_t(u32, weight, BIT(IEEE80211_RECIPROCAL_SHIFT_STA));
 	if (air_info->weight == weight)
 		return;
 
 	air_info->weight = weight;
-	if (weight) {
-		air_info->weight_reciprocal =
-			IEEE80211_RECIPROCAL_DIVISOR_32 / weight;
-	} else {
-		air_info->weight_reciprocal = 0;
-	}
+	if (weight)
+		weight = BIT(IEEE80211_RECIPROCAL_SHIFT_STA) / weight;
+	air_info->weight_reciprocal = weight;
 }
 
 static inline void airtime_weight_sum_set(struct airtime_sched_info *air_sched,
-					  int weight_sum)
+					  u32 weight_sum)
 {
 	if (air_sched->weight_sum == weight_sum)
 		return;
 
 	air_sched->weight_sum = weight_sum;
-	if (air_sched->weight_sum) {
-		air_sched->weight_sum_reciprocal = IEEE80211_RECIPROCAL_DIVISOR_64;
-		do_div(air_sched->weight_sum_reciprocal, air_sched->weight_sum);
-	} else {
-		air_sched->weight_sum_reciprocal = 0;
-	}
+	if (weight_sum)
+		weight_sum = BIT(IEEE80211_RECIPROCAL_SHIFT_SUM) / weight_sum;
+	air_sched->weight_sum_reciprocal = weight_sum;
 }
 
 /* A problem when trying to enforce airtime fairness is that we want to divide
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index e04a0905e941..2f1cf9d4e68d 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -1906,9 +1906,9 @@ void ieee80211_register_airtime(struct ieee80211_txq *txq,
 {
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(txq->vif);
 	struct ieee80211_local *local = sdata->local;
-	u64 weight_sum, weight_sum_reciprocal;
 	struct airtime_sched_info *air_sched;
 	struct airtime_info *air_info;
+	u64 weight_sum_reciprocal;
 	u32 airtime = 0;
 
 	air_sched = &local->airtime[txq->ac];
@@ -1919,27 +1919,21 @@ void ieee80211_register_airtime(struct ieee80211_txq *txq,
 	if (local->airtime_flags & AIRTIME_USE_RX)
 		airtime += rx_airtime;
 
-	/* Weights scale so the unit weight is 256 */
-	airtime <<= 8;
-
 	spin_lock_bh(&air_sched->lock);
 
 	air_info->tx_airtime += tx_airtime;
 	air_info->rx_airtime += rx_airtime;
 
-	if (air_sched->weight_sum) {
-		weight_sum = air_sched->weight_sum;
+	if (air_sched->weight_sum)
 		weight_sum_reciprocal = air_sched->weight_sum_reciprocal;
-	} else {
-		weight_sum = air_info->weight;
+	else
 		weight_sum_reciprocal = air_info->weight_reciprocal;
-	}
 
 	/* Round the calculation of global vt */
-	air_sched->v_t += (u64)((airtime + (weight_sum >> 1)) *
-				weight_sum_reciprocal) >> IEEE80211_RECIPROCAL_SHIFT_64;
-	air_info->v_t += (u32)((airtime + (air_info->weight >> 1)) *
-			       air_info->weight_reciprocal) >> IEEE80211_RECIPROCAL_SHIFT_32;
+	air_sched->v_t += ((u64)airtime * weight_sum_reciprocal) >>
+			  (IEEE80211_RECIPROCAL_SHIFT_SUM - IEEE80211_WEIGHT_SHIFT);
+	air_info->v_t += (airtime * air_info->weight_reciprocal) >>
+			 (IEEE80211_RECIPROCAL_SHIFT_STA - IEEE80211_WEIGHT_SHIFT);
 	ieee80211_resort_txq(&local->hw, txq);
 
 	spin_unlock_bh(&air_sched->lock);
-- 
2.36.1

