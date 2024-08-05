Return-Path: <linux-wireless+bounces-10967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777F19481FA
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 20:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C075DB21057
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 18:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E60E15E5BE;
	Mon,  5 Aug 2024 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="D/hFvhmT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD22815ECE8
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 18:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722884117; cv=none; b=Rvsm/4rlJ1Pz3pEMnJxmLGv7FTJ6Y44sfbHgsFZwZxm3nNoPw3YcQ7Zc0incpXt2Le9tJcr7hpZmiAHV7TaAAfr4TZe4OT8xp0pvn1+CE48ZVMxjzuNEhQs0Slf5w6Hv/eojPIrU2+ShalG1aw1GNIh3XoSvefKiNNbeOfhrblQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722884117; c=relaxed/simple;
	bh=hsgs6Qr160Hjgwxz89tLKSbFoDJLBk9PR7/SnD1+R6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+wafr/BCePN904D3KoqDME+XRNqYjOhoFVhNA4D0JCgvl9fbVjazvahRhjrypbgdi76VTaLLD5GxWxNkad5y3YJevzoa+Fg37mqKFc9W8d9KT+3l0f5HNEc+Kl241iQbxzD6Qr5+3ZKBahJDKPT0aWe+2z9wYKVde3n6cLRv6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=D/hFvhmT; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=/ydHc58IE31jszXm6/VrZqLYRUVpLFtw5PLDnre3II0=; b=D/hFvhmTjCaSB/Pnpfb7zugeZ0
	BOmwsJBdzL2eJ6K4N7pW1GwHbXujJFOblgaqbKVz6F8C1oVdGqPLZNY/iiqBrLiQKXPn9z7YcfF5l
	ERF9MUO+pEsRklsPkisWLISLjqUtkPgc5nxHx8EgoAkVmTY+scB/ELBwVVuWcLCUonl4=;
Received: from p54ae9b72.dip0.t-ipconnect.de ([84.174.155.114] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sb2Oy-00EH3F-0E;
	Mon, 05 Aug 2024 20:25:48 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH] wifi: mac80211: add AQL support for broadcast packets
Date: Mon,  5 Aug 2024 20:25:47 +0200
Message-ID: <20240805182547.14971-1-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Excessive broadcast traffic with little competing unicast traffic can easily
flood hardware queues, leading to throughput issues. Additionally, filling
the hardware queues with too many packets breaks FQ for broadcast data.
Fix this by enabling AQL for broadcast packets.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/cfg80211.h     |  1 +
 include/net/mac80211.h     |  2 +-
 net/mac80211/debugfs.c     | 13 +++++++--
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/main.c        |  1 +
 net/mac80211/sta_info.c    | 17 +++++++++++-
 net/mac80211/sta_info.h    |  3 ++-
 net/mac80211/status.c      |  5 ++--
 net/mac80211/tx.c          | 55 ++++++++++++++++++++------------------
 9 files changed, 66 insertions(+), 33 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 192d72c8b465..c2a9af1e3c5e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3420,6 +3420,7 @@ enum wiphy_params_flags {
 /* The per TXQ device queue limit in airtime */
 #define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L	5000
 #define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H	12000
+#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_BC	50000
 
 /* The per interface airtime threshold to switch to lower queue limit */
 #define IEEE80211_AQL_THRESHOLD			24000
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 0a04eaf5343c..5bdc6e05be1b 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1221,8 +1221,8 @@ struct ieee80211_tx_info {
 	    status_data_idr:1,
 	    status_data:13,
 	    hw_queue:4,
+	    tx_time_mc:1,
 	    tx_time_est:10;
-	/* 1 free bit */
 
 	union {
 		struct {
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 02b5476a4376..a5aa5e02b2e1 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -215,11 +215,13 @@ static ssize_t aql_pending_read(struct file *file,
 			"VI     %u us\n"
 			"BE     %u us\n"
 			"BK     %u us\n"
+			"BC/MC  %u us\n"
 			"total  %u us\n",
 			atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_VO]),
 			atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_VI]),
 			atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_BE]),
 			atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_BK]),
+			atomic_read(&local->aql_bc_pending_airtime),
 			atomic_read(&local->aql_total_pending_airtime));
 	return simple_read_from_buffer(user_buf, count, ppos,
 				       buf, len);
@@ -245,7 +247,8 @@ static ssize_t aql_txq_limit_read(struct file *file,
 			"VO	%u		%u\n"
 			"VI	%u		%u\n"
 			"BE	%u		%u\n"
-			"BK	%u		%u\n",
+			"BK	%u		%u\n"
+			"BC/MC	%u\n",
 			local->aql_txq_limit_low[IEEE80211_AC_VO],
 			local->aql_txq_limit_high[IEEE80211_AC_VO],
 			local->aql_txq_limit_low[IEEE80211_AC_VI],
@@ -253,7 +256,8 @@ static ssize_t aql_txq_limit_read(struct file *file,
 			local->aql_txq_limit_low[IEEE80211_AC_BE],
 			local->aql_txq_limit_high[IEEE80211_AC_BE],
 			local->aql_txq_limit_low[IEEE80211_AC_BK],
-			local->aql_txq_limit_high[IEEE80211_AC_BK]);
+			local->aql_txq_limit_high[IEEE80211_AC_BK],
+			local->aql_txq_limit_bc);
 	return simple_read_from_buffer(user_buf, count, ppos,
 				       buf, len);
 }
@@ -279,6 +283,11 @@ static ssize_t aql_txq_limit_write(struct file *file,
 	else
 		buf[count] = '\0';
 
+	if (sscanf(buf, "mcast %u", &q_limit_low) == 1) {
+		local->aql_txq_limit_bc = q_limit_low;
+		return count;
+	}
+
 	if (sscanf(buf, "%u %u %u", &ac, &q_limit_low, &q_limit_high) != 3)
 		return -EINVAL;
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a3485e4c6132..304cce0b771d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1349,10 +1349,12 @@ struct ieee80211_local {
 	spinlock_t handle_wake_tx_queue_lock;
 
 	u16 airtime_flags;
+	u32 aql_txq_limit_bc;
 	u32 aql_txq_limit_low[IEEE80211_NUM_ACS];
 	u32 aql_txq_limit_high[IEEE80211_NUM_ACS];
 	u32 aql_threshold;
 	atomic_t aql_total_pending_airtime;
+	atomic_t aql_bc_pending_airtime;
 	atomic_t aql_ac_pending_airtime[IEEE80211_NUM_ACS];
 
 	const struct ieee80211_ops *ops;
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index a3104b6ea6f0..6abf85a58133 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -952,6 +952,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	spin_lock_init(&local->rx_path_lock);
 	spin_lock_init(&local->queue_stop_reason_lock);
 
+	local->aql_txq_limit_bc = IEEE80211_DEFAULT_AQL_TXQ_LIMIT_BC;
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		INIT_LIST_HEAD(&local->active_txqs[i]);
 		spin_lock_init(&local->active_txq_lock[i]);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index aa22f09e6d14..ed73f5b7af81 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2352,13 +2352,28 @@ EXPORT_SYMBOL(ieee80211_sta_recalc_aggregates);
 
 void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
 					  struct sta_info *sta, u8 ac,
-					  u16 tx_airtime, bool tx_completed)
+					  u16 tx_airtime, bool tx_completed,
+					  bool mcast)
 {
 	int tx_pending;
 
 	if (!wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL))
 		return;
 
+	if (mcast) {
+		if (!tx_completed) {
+			atomic_add(tx_airtime, &local->aql_bc_pending_airtime);
+			return;
+		}
+
+		tx_pending = atomic_sub_return(tx_airtime,
+					       &local->aql_bc_pending_airtime);
+		if (tx_pending < 0)
+			atomic_cmpxchg(&local->aql_bc_pending_airtime,
+				       tx_pending, 0);
+		return;
+	}
+
 	if (!tx_completed) {
 		if (sta)
 			atomic_add(tx_airtime,
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 9195d5a2de0a..ad449f8dfa76 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -147,7 +147,8 @@ struct airtime_info {
 
 void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
 					  struct sta_info *sta, u8 ac,
-					  u16 tx_airtime, bool tx_completed);
+					  u16 tx_airtime, bool tx_completed,
+					  bool mcast);
 
 struct sta_info;
 
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index dd8f857a1fbc..2ef98964a485 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -734,7 +734,7 @@ static void ieee80211_report_used_skb(struct ieee80211_local *local,
 		ieee80211_sta_update_pending_airtime(local, sta,
 						     skb_get_queue_mapping(skb),
 						     tx_time_est,
-						     true);
+						     true, info->tx_time_mc);
 		rcu_read_unlock();
 	}
 
@@ -1158,10 +1158,11 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 		/* Do this here to avoid the expensive lookup of the sta
 		 * in ieee80211_report_used_skb().
 		 */
+		bool mcast = IEEE80211_SKB_CB(skb)->tx_time_mc;
 		ieee80211_sta_update_pending_airtime(local, sta,
 						     skb_get_queue_mapping(skb),
 						     tx_time_est,
-						     true);
+						     true, mcast);
 		ieee80211_info_set_tx_time_est(IEEE80211_SKB_CB(skb), 0);
 	}
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 72a9ba8bc5fd..dfa532d44280 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2554,7 +2554,7 @@ static u16 ieee80211_store_ack_skb(struct ieee80211_local *local,
 
 		spin_lock_irqsave(&local->ack_status_lock, flags);
 		id = idr_alloc(&local->ack_status_frames, ack_skb,
-			       1, 0x2000, GFP_ATOMIC);
+			       1, 0x1000, GFP_ATOMIC);
 		spin_unlock_irqrestore(&local->ack_status_lock, flags);
 
 		if (id >= 0) {
@@ -3981,20 +3981,20 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 encap_out:
 	info->control.vif = vif;
 
-	if (tx.sta &&
-	    wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL)) {
-		bool ampdu = txq->ac != IEEE80211_AC_VO;
+	if (wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL)) {
+		bool ampdu = txq->sta && txq->ac != IEEE80211_AC_VO;
 		u32 airtime;
 
 		airtime = ieee80211_calc_expected_tx_airtime(hw, vif, txq->sta,
 							     skb->len, ampdu);
-		if (airtime) {
-			airtime = ieee80211_info_set_tx_time_est(info, airtime);
-			ieee80211_sta_update_pending_airtime(local, tx.sta,
-							     txq->ac,
-							     airtime,
-							     false);
-		}
+		if (!airtime)
+			return skb;
+
+		airtime = ieee80211_info_set_tx_time_est(info, airtime);
+		info->tx_time_mc = !tx.sta;
+		ieee80211_sta_update_pending_airtime(local, tx.sta, txq->ac,
+						     airtime, false,
+						     info->tx_time_mc);
 	}
 
 	return skb;
@@ -4046,6 +4046,7 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 	struct ieee80211_txq *ret = NULL;
 	struct txq_info *txqi = NULL, *head = NULL;
 	bool found_eligible_txq = false;
+	bool aql_check;
 
 	spin_lock_bh(&local->active_txq_lock[ac]);
 
@@ -4069,26 +4070,27 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 	if (!head)
 		head = txqi;
 
+	aql_check = ieee80211_txq_airtime_check(hw, &txqi->txq);
+	if (aql_check)
+		found_eligible_txq = true;
+
 	if (txqi->txq.sta) {
 		struct sta_info *sta = container_of(txqi->txq.sta,
 						    struct sta_info, sta);
-		bool aql_check = ieee80211_txq_airtime_check(hw, &txqi->txq);
-		s32 deficit = ieee80211_sta_deficit(sta, txqi->txq.ac);
 
-		if (aql_check)
-			found_eligible_txq = true;
-
-		if (deficit < 0)
+		if (ieee80211_sta_deficit(sta, txqi->txq.ac) < 0) {
 			sta->airtime[txqi->txq.ac].deficit +=
 				sta->airtime_weight;
-
-		if (deficit < 0 || !aql_check) {
-			list_move_tail(&txqi->schedule_order,
-				       &local->active_txqs[txqi->txq.ac]);
-			goto begin;
+			aql_check = false;
 		}
 	}
 
+	if (!aql_check) {
+		list_move_tail(&txqi->schedule_order,
+				   &local->active_txqs[txqi->txq.ac]);
+		goto begin;
+	}
+
 	if (txqi->schedule_round == local->schedule_round[ac])
 		goto out;
 
@@ -4153,7 +4155,8 @@ bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
 		return true;
 
 	if (!txq->sta)
-		return true;
+		return atomic_read(&local->aql_bc_pending_airtime) <
+		       local->aql_txq_limit_bc;
 
 	if (unlikely(txq->tid == IEEE80211_NUM_TIDS))
 		return true;
@@ -4202,15 +4205,15 @@ bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 
 	spin_lock_bh(&local->active_txq_lock[ac]);
 
-	if (!txqi->txq.sta)
-		goto out;
-
 	if (list_empty(&txqi->schedule_order))
 		goto out;
 
 	if (!ieee80211_txq_schedule_airtime_check(local, ac))
 		goto out;
 
+	if (!txqi->txq.sta)
+		goto out;
+
 	list_for_each_entry_safe(iter, tmp, &local->active_txqs[ac],
 				 schedule_order) {
 		if (iter == txqi)
-- 
2.44.0


