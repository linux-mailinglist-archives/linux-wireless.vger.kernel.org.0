Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61F3155ACC2
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jun 2022 23:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiFYVYU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Jun 2022 17:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbiFYVYS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Jun 2022 17:24:18 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628E313DFB
        for <linux-wireless@vger.kernel.org>; Sat, 25 Jun 2022 14:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Eydjmw08IZtNOgZB7kcJhC4+t2I797gxn39dKQvpt9k=; b=VV4oWvPDGpLxHEidirky0hgM2J
        Q40JIeFD1HBlgz0+XlZCySR0TaKUtj2ieQ5nz6bIZgrkd7ZocrieJpF38ts4Qw58kzizngmQOoie0
        sLH5BXrMLpAcpY+f0wQ1jXSrNCjGaAMPhOMcJPLmyrOVOBOcQtrOmci8PgQ2bJJ4O9sA=;
Received: from p200300daa733bc000d99dad39793d523.dip0.t-ipconnect.de ([2003:da:a733:bc00:d99:dad3:9793:d523] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o5DGH-0003Vi-Lj; Sat, 25 Jun 2022 23:24:13 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     toke@kernel.org, johannes@sipsolutions.net
Subject: [PATCH 4/7] mac80211: keep recently active tx queues in scheduling list
Date:   Sat, 25 Jun 2022 23:24:08 +0200
Message-Id: <20220625212411.36675-4-nbd@nbd.name>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220625212411.36675-1-nbd@nbd.name>
References: <20220625212411.36675-1-nbd@nbd.name>
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

This allows proper deficit accounting to ensure that they don't carry their
deficit until the next time they become active

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/ieee80211_i.h |  7 +++++++
 net/mac80211/sta_info.h    |  1 +
 net/mac80211/tx.c          | 40 ++++++++++++++++++++++++++++++++++----
 3 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8ef27e0f9371..c5a76bec03a4 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -83,6 +83,13 @@ extern const u8 ieee80211_ac_to_qos_mask[IEEE80211_NUM_ACS];
 
 #define IEEE80211_MAX_NAN_INSTANCE_ID 255
 
+
+/*
+ * Keep a station's queues on the active list for deficit accounting purposes
+ * if it was active or queued during the last 100ms
+ */
+#define AIRTIME_ACTIVE_DURATION (HZ / 10)
+
 struct ieee80211_bss {
 	u32 device_ts_beacon, device_ts_presp;
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 785fefe8c41a..aa599f82b065 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -138,6 +138,7 @@ enum ieee80211_agg_stop_reason {
 struct airtime_info {
 	u64 rx_airtime;
 	u64 tx_airtime;
+	u32 last_active;
 	s32 deficit;
 	atomic_t aql_tx_pending; /* Estimated airtime for frames pending */
 	u32 aql_limit_low;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0509486ac40a..71c1d2a5eef3 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3807,6 +3807,36 @@ static inline s32 ieee80211_sta_deficit(struct sta_info *sta, u8 ac)
 	return air_info->deficit - atomic_read(&air_info->aql_tx_pending);
 }
 
+static void
+ieee80211_txq_set_active(struct txq_info *txqi)
+{
+	struct sta_info *sta;
+
+	if (!txqi->txq.sta)
+		return;
+
+	sta = container_of(txqi->txq.sta, struct sta_info, sta);
+	sta->airtime[txqi->txq.ac].last_active = (u32)jiffies;
+}
+
+static bool
+ieee80211_txq_keep_active(struct txq_info *txqi)
+{
+	struct sta_info *sta;
+	u32 diff;
+
+	if (!txqi->txq.sta)
+		return false;
+
+	sta = container_of(txqi->txq.sta, struct sta_info, sta);
+	if (ieee80211_sta_deficit(sta, txqi->txq.ac) >= 0)
+		return false;
+
+	diff = (u32)jiffies - sta->airtime[txqi->txq.ac].last_active;
+
+	return diff <= AIRTIME_ACTIVE_DURATION;
+}
+
 struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 {
 	struct ieee80211_local *local = hw_to_local(hw);
@@ -3853,7 +3883,6 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 		}
 	}
 
-
 	if (txqi->schedule_round == local->schedule_round[ac])
 		goto out;
 
@@ -3873,12 +3902,13 @@ void __ieee80211_schedule_txq(struct ieee80211_hw *hw,
 {
 	struct ieee80211_local *local = hw_to_local(hw);
 	struct txq_info *txqi = to_txq_info(txq);
+	bool has_queue;
 
 	spin_lock_bh(&local->active_txq_lock[txq->ac]);
 
+	has_queue = force || txq_has_queue(txq);
 	if (list_empty(&txqi->schedule_order) &&
-	    (force || !skb_queue_empty(&txqi->frags) ||
-	     txqi->tin.backlog_packets)) {
+	    (has_queue || ieee80211_txq_keep_active(txqi))) {
 		/* If airtime accounting is active, always enqueue STAs at the
 		 * head of the list to ensure that they only get moved to the
 		 * back by the airtime DRR scheduler once they have a negative
@@ -3886,7 +3916,7 @@ void __ieee80211_schedule_txq(struct ieee80211_hw *hw,
 		 * get immediately moved to the back of the list on the next
 		 * call to ieee80211_next_txq().
 		 */
-		if (txqi->txq.sta && local->airtime_flags &&
+		if (txqi->txq.sta && local->airtime_flags && has_queue &&
 		    wiphy_ext_feature_isset(local->hw.wiphy,
 					    NL80211_EXT_FEATURE_AIRTIME_FAIRNESS))
 			list_add(&txqi->schedule_order,
@@ -3894,6 +3924,8 @@ void __ieee80211_schedule_txq(struct ieee80211_hw *hw,
 		else
 			list_add_tail(&txqi->schedule_order,
 				      &local->active_txqs[txq->ac]);
+		if (has_queue)
+			ieee80211_txq_set_active(txqi);
 	}
 
 	spin_unlock_bh(&local->active_txq_lock[txq->ac]);
-- 
2.36.1

