Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF5855ACC5
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jun 2022 23:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiFYVYV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Jun 2022 17:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbiFYVYS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Jun 2022 17:24:18 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6378713E02
        for <linux-wireless@vger.kernel.org>; Sat, 25 Jun 2022 14:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=eGkHjL62lzVEuflfVIs8TV10+RYMQXREA5k2pVcnqA0=; b=jkiBueSdtXqkbMDNkWSSdG0Aca
        x9OoFpXq3gBH32lrPDzWzYb5EeLYQyrjGVQVAxz+iPlnzILmjqjIeQVjwuonLg6R3uH5G27IF6QMo
        70/IN1DjFcbA6P4x1qmROxvnAhBS0+G18jibAEeOiAcfFQ9TlIPAlHfwD/J/tGYa5lJY=;
Received: from p200300daa733bc000d99dad39793d523.dip0.t-ipconnect.de ([2003:da:a733:bc00:d99:dad3:9793:d523] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1o5DGH-0003Vi-T6; Sat, 25 Jun 2022 23:24:13 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     toke@kernel.org, johannes@sipsolutions.net
Subject: [PATCH 5/7] mac80211: add a per-PHY AQL limit to improve fairness
Date:   Sat, 25 Jun 2022 23:24:09 +0200
Message-Id: <20220625212411.36675-5-nbd@nbd.name>
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

In order to maintain fairness, the amount of queueing needs to be limited
beyond the simple per-station AQL budget, otherwise the driver can simply
repeatedly do scheduling rounds until all queues that have not used their
AQL budget become eligble.

To be conservative, use the high AQL limit for the first txq and add half
of the low AQL for each subsequent queue.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/main.c        |  1 +
 net/mac80211/sta_info.c    | 10 +++++++---
 net/mac80211/tx.c          | 35 ++++++++++++++++++++++++++++++++++-
 4 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index c5a76bec03a4..7c199bd66f73 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1239,6 +1239,7 @@ struct ieee80211_local {
 	u32 aql_txq_limit_high[IEEE80211_NUM_ACS];
 	u32 aql_threshold;
 	atomic_t aql_total_pending_airtime;
+	atomic_t aql_ac_pending_airtime[IEEE80211_NUM_ACS];
 
 	const struct ieee80211_ops *ops;
 
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index e6c1cafbe9e5..929bbdf55213 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -789,6 +789,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 		local->aql_txq_limit_low[i] = IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L;
 		local->aql_txq_limit_high[i] =
 			IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H;
+		atomic_set(&local->aql_ac_pending_airtime[i], 0);
 	}
 
 	local->airtime_flags = AIRTIME_USE_TX | AIRTIME_USE_RX;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index a1a2118b4bf0..28ab55a072c6 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2075,6 +2075,7 @@ void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
 				   &sta->airtime[ac].aql_tx_pending);
 
 		atomic_add(tx_airtime, &local->aql_total_pending_airtime);
+		atomic_add(tx_airtime, &local->aql_ac_pending_airtime[ac]);
 		return;
 	}
 
@@ -2086,14 +2087,17 @@ void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
 				       tx_pending, 0);
 	}
 
+	atomic_sub(tx_airtime, &local->aql_total_pending_airtime);
 	tx_pending = atomic_sub_return(tx_airtime,
-				       &local->aql_total_pending_airtime);
+				       &local->aql_ac_pending_airtime[ac]);
 	if (WARN_ONCE(tx_pending < 0,
 		      "Device %s AC %d pending airtime underflow: %u, %u",
 		      wiphy_name(local->hw.wiphy), ac, tx_pending,
-		      tx_airtime))
-		atomic_cmpxchg(&local->aql_total_pending_airtime,
+		      tx_airtime)) {
+		atomic_cmpxchg(&local->aql_ac_pending_airtime[ac],
 			       tx_pending, 0);
+		atomic_sub(tx_pending, &local->aql_total_pending_airtime);
+	}
 }
 
 int sta_info_move_state(struct sta_info *sta,
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 71c1d2a5eef3..b2430cf8332b 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3846,6 +3846,9 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 
 	spin_lock_bh(&local->active_txq_lock[ac]);
 
+	if (!local->schedule_round[ac])
+		goto out;
+
  begin:
 	txqi = list_first_entry_or_null(&local->active_txqs[ac],
 					struct txq_info,
@@ -3967,6 +3970,25 @@ bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL(ieee80211_txq_airtime_check);
 
+static bool
+ieee80211_txq_schedule_airtime_check(struct ieee80211_local *local, u8 ac)
+{
+	unsigned int num_txq = 0;
+	struct txq_info *txq;
+	u32 aql_limit;
+
+	if (!wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL))
+		return true;
+
+	list_for_each_entry(txq, &local->active_txqs[ac], schedule_order)
+		num_txq++;
+
+	aql_limit = (num_txq - 1) * local->aql_txq_limit_low[ac] / 2 +
+		    local->aql_txq_limit_high[ac];
+
+	return atomic_read(&local->aql_ac_pending_airtime[ac]) < aql_limit;
+}
+
 bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 				struct ieee80211_txq *txq)
 {
@@ -3983,6 +4005,9 @@ bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 	if (list_empty(&txqi->schedule_order))
 		goto out;
 
+	if (!ieee80211_txq_schedule_airtime_check(local, ac))
+		goto out;
+
 	list_for_each_entry_safe(iter, tmp, &local->active_txqs[ac],
 				 schedule_order) {
 		if (iter == txqi)
@@ -4022,7 +4047,15 @@ void ieee80211_txq_schedule_start(struct ieee80211_hw *hw, u8 ac)
 	struct ieee80211_local *local = hw_to_local(hw);
 
 	spin_lock_bh(&local->active_txq_lock[ac]);
-	local->schedule_round[ac]++;
+
+	if (ieee80211_txq_schedule_airtime_check(local, ac)) {
+		local->schedule_round[ac]++;
+		if (!local->schedule_round[ac])
+			local->schedule_round[ac]++;
+	} else {
+		local->schedule_round[ac] = 0;
+	}
+
 	spin_unlock_bh(&local->active_txq_lock[ac]);
 }
 EXPORT_SYMBOL(ieee80211_txq_schedule_start);
-- 
2.36.1

