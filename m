Return-Path: <linux-wireless+bounces-3406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F9C84FC40
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 19:47:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02181F221C6
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 18:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E275D7BAF6;
	Fri,  9 Feb 2024 18:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="CFHI0w1i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA3B33CF1
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504462; cv=none; b=HrU3uPUWR2icUP1+o1647DKfgiCPtzyfSEY/MuYFslFwT90kRBqqbNtNVZ/Xk3Y7ZYx6v36s0Yq+b6GQzY9clPgCGq2EB2SbhKAUex3By3hiZvCzPUAuv1IHjnQP83TBuX0VD+BHTYwt7hMpTqBYxme74Bx0vMI10dZdkyXcoRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504462; c=relaxed/simple;
	bh=mSvKP2lx/jNbenDUOluJpiHwAqSRGGeJRcpOZI+qVo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PBBt34Xn9HrNThQZ8GhN+W0Q7KPBHb6yoSORiwLTJqY8JqGsXnILkJ6FfnIoPqd6EHKzG3z/sq+IdPuEdMP+37ApZWiLEzJP8yGgjC9nJSPnuLIfIkxK8sj2CsXS9PkeiHhRb+/w08NOAuJWZNthvxm9zoxzGy4qkKeYmXqWqpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=CFHI0w1i; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=wbJSnReQFc/9odpkylJ9wr4/BsFMdmgUA8BGVUEiJVs=; b=CFHI0w1iX+f1vt/NGkP5z5AUFp
	F0qHa5kkpnB10yE9wmnwJbFTGZ1Kd0RGfPHCOTdNzTzEtd+ROe3SP3MD2NWFXd3jaQh9w8TRijPw+
	q9FhhSguEACVATYq+kAKSJRmtNs6LfB2L4z7aosH1VnjAaW+m7wI6iQt3r+/fZ7v+BPQ=;
Received: from p54ae9e7b.dip0.t-ipconnect.de ([84.174.158.123] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rYVuM-00CXf8-PU; Fri, 09 Feb 2024 19:47:30 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [RFC] mac80211: add AQL support for broadcast packets
Date: Fri,  9 Feb 2024 19:47:30 +0100
Message-ID: <20240209184730.69589-1-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
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
 net/mac80211/debugfs.c     | 19 +++++++++++++++----
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/main.c        |  1 +
 net/mac80211/sta_info.c    | 21 ++++++++++-----------
 net/mac80211/tx.c          | 14 +++++++-------
 6 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index a499bd7e1def..2f280c629aea 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3385,6 +3385,7 @@ enum wiphy_params_flags {
 /* The per TXQ device queue limit in airtime */
 #define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L	5000
 #define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H	12000
+#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_BC	50000
 
 /* The per interface airtime threshold to switch to lower queue limit */
 #define IEEE80211_AQL_THRESHOLD			24000
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index 74be49191e70..7ed671d16c05 100644
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
@@ -267,6 +271,7 @@ static ssize_t aql_txq_limit_write(struct file *file,
 	char buf[100];
 	u32 ac, q_limit_low, q_limit_high, q_limit_low_old, q_limit_high_old;
 	struct sta_info *sta;
+	int n;
 
 	if (count >= sizeof(buf))
 		return -EINVAL;
@@ -279,10 +284,16 @@ static ssize_t aql_txq_limit_write(struct file *file,
 	else
 		buf[count] = '\0';
 
-	if (sscanf(buf, "%u %u %u", &ac, &q_limit_low, &q_limit_high) != 3)
+	n = sscanf(buf, "%u %u %u", &ac, &q_limit_low, &q_limit_high);
+	if (n < 2)
 		return -EINVAL;
 
-	if (ac >= IEEE80211_NUM_ACS)
+	if (ac == IEEE80211_NUM_ACS) {
+		local->aql_txq_limit_bc = q_limit_low;
+		return count;
+	}
+
+	if (n != 3 || ac >= IEEE80211_NUM_ACS)
 		return -EINVAL;
 
 	q_limit_low_old = local->aql_txq_limit_low[ac];
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index eb32174984c3..f28fe17b1c21 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1305,10 +1305,12 @@ struct ieee80211_local {
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
index e05bcc35bc1e..4d87ca898e35 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -808,6 +808,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	spin_lock_init(&local->rx_path_lock);
 	spin_lock_init(&local->queue_stop_reason_lock);
 
+	local->aql_txq_limit_bc = IEEE80211_DEFAULT_AQL_TXQ_LIMIT_BC;
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		INIT_LIST_HEAD(&local->active_txqs[i]);
 		spin_lock_init(&local->active_txq_lock[i]);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 4391d8dd634b..412468f608de 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2347,28 +2347,27 @@ void ieee80211_sta_update_pending_airtime(struct ieee80211_local *local,
 					  struct sta_info *sta, u8 ac,
 					  u16 tx_airtime, bool tx_completed)
 {
+	atomic_t *counter;
 	int tx_pending;
 
 	if (!wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL))
 		return;
 
-	if (!tx_completed) {
-		if (sta)
-			atomic_add(tx_airtime,
-				   &sta->airtime[ac].aql_tx_pending);
+	if (sta)
+		counter = &sta->airtime[ac].aql_tx_pending;
+	else
+		counter = &local->aql_bc_pending_airtime;
 
+	if (!tx_completed) {
+		atomic_add(tx_airtime, counter);
 		atomic_add(tx_airtime, &local->aql_total_pending_airtime);
 		atomic_add(tx_airtime, &local->aql_ac_pending_airtime[ac]);
 		return;
 	}
 
-	if (sta) {
-		tx_pending = atomic_sub_return(tx_airtime,
-					       &sta->airtime[ac].aql_tx_pending);
-		if (tx_pending < 0)
-			atomic_cmpxchg(&sta->airtime[ac].aql_tx_pending,
-				       tx_pending, 0);
-	}
+	tx_pending = atomic_sub_return(tx_airtime, counter);
+	if (tx_pending < 0)
+		atomic_cmpxchg(counter, tx_pending, 0);
 
 	atomic_sub(tx_airtime, &local->aql_total_pending_airtime);
 	tx_pending = atomic_sub_return(tx_airtime,
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 68a48abc7287..b6293a5e4bbf 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3972,9 +3972,8 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 encap_out:
 	IEEE80211_SKB_CB(skb)->control.vif = vif;
 
-	if (tx.sta &&
-	    wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL)) {
-		bool ampdu = txq->ac != IEEE80211_AC_VO;
+	if (wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL)) {
+		bool ampdu = txq->sta && txq->ac != IEEE80211_AC_VO;
 		u32 airtime;
 
 		airtime = ieee80211_calc_expected_tx_airtime(hw, vif, txq->sta,
@@ -4144,7 +4143,8 @@ bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
 		return true;
 
 	if (!txq->sta)
-		return true;
+		return atomic_read(&local->aql_bc_pending_airtime) <
+		       local->aql_txq_limit_bc;
 
 	if (unlikely(txq->tid == IEEE80211_NUM_TIDS))
 		return true;
@@ -4193,15 +4193,15 @@ bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 
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
2.43.0


