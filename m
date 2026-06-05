Return-Path: <linux-wireless+bounces-37417-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YRiiL1PEImqudQEAu9opvQ
	(envelope-from <linux-wireless+bounces-37417-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 14:42:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EF6648426
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Jun 2026 14:42:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nbd.name header.s=20160729 header.b=YFI0GS8P;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37417-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37417-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nbd.name (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 202373059A7E
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2026 12:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F80837F007;
	Fri,  5 Jun 2026 12:31:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA2E30568D
	for <linux-wireless@vger.kernel.org>; Fri,  5 Jun 2026 12:31:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662663; cv=none; b=XzMhePgcA34JYvB0I6X1eCWlLhriWIeX2+bDAvK9hLHC0I+0z8YkdCXi6uIwdtpwzd1pSUbb9/2sRcT1i8SBP+o8C2Bo0JJhOD+QwbnZEqoHdEzPs+tWqb/zCfCnUfNgPfsPG6jDEhLi2G1zzjCowE8CijH8MH3bgmLcV+i7AR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662663; c=relaxed/simple;
	bh=3e6ruo7NWmjtKJJtrfDaV2m23uDQJ1+835pS0fgtvPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iLis7RFwh6Q0aO/4JQdXcv8BMYgAbAfeQ+L2ehJp75QRau2RpMKuhIDGV3U5N+uUExAVtrx8nfVK9/XbTwJCbgph2tBc40MWj6HDTQqR6MVA2B0wc9YLKqwD20e0E9LLv8daVHD3MYeFqN6yc2FsgCbRGtN8jHYSsKX+ckBg1GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=YFI0GS8P; arc=none smtp.client-ip=46.4.11.11
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ZILSpxZgsw1SL69ap7kvmU5TxNRMD7YPy/NiG1dI4Us=; b=YFI0GS8PHBt3HMbDTQDs1Q2fOi
	GdOhGq65x4hDonK7UqDItaAdjAxoUNeGMsycJfb+R5kImaIzHN5bl4xK0GtlPmhGUVqN7AGVja+jr
	FEhSNi1bqfZ63YDu3wh7VbO5ayriDcQWE6qhwAB6ugzgVno34Uz4LE+47bPyn5Ys+L/Q=;
Received: from p200300cadf03d5009ebf0dfffe00fa2d.dip0.t-ipconnect.de ([2003:ca:df03:d500:9ebf:dff:fe00:fa2d] helo=max)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1wVThO-0090er-1f;
	Fri, 05 Jun 2026 14:30:54 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH wireless-next v3 3/4] wifi: mac80211: add AQL support for multicast packets
Date: Fri,  5 Jun 2026 12:30:48 +0000
Message-ID: <20260605123049.1128869-3-nbd@nbd.name>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605123049.1128869-1-nbd@nbd.name>
References: <20260605123049.1128869-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.14 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37417-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:johannes@sipsolutions.net,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nbd.name:-];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nbd.name:mid,nbd.name:from_mime,nbd.name:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21EF6648426

Excessive multicast traffic with little competing unicast traffic can easily
flood hardware queues, leading to throughput issues. Additionally, filling
the hardware queues with too many packets breaks FQ for multicast data.
Fix this by enabling AQL for multicast packets.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2: fix broadcast/multicast inconsistency

 include/net/cfg80211.h     |  1 +
 include/net/mac80211.h     |  2 +-
 net/mac80211/debugfs.c     | 13 ++++++++--
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/main.c        |  1 +
 net/mac80211/sta_info.c    | 17 ++++++++++++-
 net/mac80211/sta_info.h    |  3 ++-
 net/mac80211/status.c      |  5 ++--
 net/mac80211/tx.c          | 52 ++++++++++++++++++++------------------
 9 files changed, 65 insertions(+), 31 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 69dc9a978861..69414934c7fa 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -3722,6 +3722,7 @@ enum wiphy_params_flags {
 /* The per TXQ device queue limit in airtime */
 #define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L	5000
 #define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H	12000
+#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_MC	50000
 
 /* The per interface airtime threshold to switch to lower queue limit */
 #define IEEE80211_AQL_THRESHOLD			24000
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 4fb579805e0f..77409e4e28e8 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1354,8 +1354,8 @@ struct ieee80211_tx_info {
 	    status_data_idr:1,
 	    status_data:13,
 	    hw_queue:4,
+	    tx_time_mc:1,
 	    tx_time_est:10;
-	/* 1 free bit */
 
 	union {
 		struct {
diff --git a/net/mac80211/debugfs.c b/net/mac80211/debugfs.c
index a4d5461f6480..8ebf5bcf3c0e 100644
--- a/net/mac80211/debugfs.c
+++ b/net/mac80211/debugfs.c
@@ -210,11 +210,13 @@ static ssize_t aql_pending_read(struct file *file,
 			"VI     %u us\n"
 			"BE     %u us\n"
 			"BK     %u us\n"
+			"MC     %u us\n"
 			"total  %u us\n",
 			atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_VO]),
 			atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_VI]),
 			atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_BE]),
 			atomic_read(&local->aql_ac_pending_airtime[IEEE80211_AC_BK]),
+			atomic_read(&local->aql_mc_pending_airtime),
 			atomic_read(&local->aql_total_pending_airtime));
 	return simple_read_from_buffer(user_buf, count, ppos,
 				       buf, len);
@@ -239,7 +241,8 @@ static ssize_t aql_txq_limit_read(struct file *file,
 			"VO	%u		%u\n"
 			"VI	%u		%u\n"
 			"BE	%u		%u\n"
-			"BK	%u		%u\n",
+			"BK	%u		%u\n"
+			"MC	%u\n",
 			local->aql_txq_limit_low[IEEE80211_AC_VO],
 			local->aql_txq_limit_high[IEEE80211_AC_VO],
 			local->aql_txq_limit_low[IEEE80211_AC_VI],
@@ -247,7 +250,8 @@ static ssize_t aql_txq_limit_read(struct file *file,
 			local->aql_txq_limit_low[IEEE80211_AC_BE],
 			local->aql_txq_limit_high[IEEE80211_AC_BE],
 			local->aql_txq_limit_low[IEEE80211_AC_BK],
-			local->aql_txq_limit_high[IEEE80211_AC_BK]);
+			local->aql_txq_limit_high[IEEE80211_AC_BK],
+			local->aql_txq_limit_mc);
 	return simple_read_from_buffer(user_buf, count, ppos,
 				       buf, len);
 }
@@ -273,6 +277,11 @@ static ssize_t aql_txq_limit_write(struct file *file,
 	else
 		buf[count] = '\0';
 
+	if (sscanf(buf, "mcast %u", &q_limit_low) == 1) {
+		local->aql_txq_limit_mc = q_limit_low;
+		return count;
+	}
+
 	if (sscanf(buf, "%u %u %u", &ac, &q_limit_low, &q_limit_high) != 3)
 		return -EINVAL;
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 896397e9408f..1646291182ba 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1452,10 +1452,12 @@ struct ieee80211_local {
 	spinlock_t handle_wake_tx_queue_lock;
 
 	u16 airtime_flags;
+	u32 aql_txq_limit_mc;
 	u32 aql_txq_limit_low[IEEE80211_NUM_ACS];
 	u32 aql_txq_limit_high[IEEE80211_NUM_ACS];
 	u32 aql_threshold;
 	atomic_t aql_total_pending_airtime;
+	atomic_t aql_mc_pending_airtime;
 	atomic_t aql_ac_pending_airtime[IEEE80211_NUM_ACS];
 
 	const struct ieee80211_ops *ops;
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 90d295cc364f..3adb941f407f 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -988,6 +988,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 	spin_lock_init(&local->rx_path_lock);
 	spin_lock_init(&local->queue_stop_reason_lock);
 
+	local->aql_txq_limit_mc = IEEE80211_DEFAULT_AQL_TXQ_LIMIT_MC;
 	for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 		INIT_LIST_HEAD(&local->active_txqs[i]);
 		spin_lock_init(&local->active_txq_lock[i]);
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 2bc5cab76261..b4abe1230cc2 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2470,13 +2470,28 @@ EXPORT_SYMBOL(ieee80211_sta_recalc_aggregates);
 
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
+			atomic_add(tx_airtime, &local->aql_mc_pending_airtime);
+			return;
+		}
+
+		tx_pending = atomic_sub_return(tx_airtime,
+					       &local->aql_mc_pending_airtime);
+		if (tx_pending < 0)
+			atomic_cmpxchg(&local->aql_mc_pending_airtime,
+				       tx_pending, 0);
+		return;
+	}
+
 	if (!tx_completed) {
 		if (sta)
 			atomic_add(tx_airtime,
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 39608a0abbb5..6ad0586c68c7 100644
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
index 8716eda8317d..f0acd8196468 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -752,7 +752,7 @@ static void ieee80211_report_used_skb(struct ieee80211_local *local,
 		ieee80211_sta_update_pending_airtime(local, sta,
 						     skb_get_queue_mapping(skb),
 						     tx_time_est,
-						     true);
+						     true, info->tx_time_mc);
 		rcu_read_unlock();
 	}
 
@@ -1161,10 +1161,11 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
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
index 933c86ca21c3..d1c8398584af 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -4027,20 +4027,20 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
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
@@ -4092,6 +4092,7 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
 	struct ieee80211_txq *ret = NULL;
 	struct txq_info *txqi = NULL, *head = NULL;
 	bool found_eligible_txq = false;
+	bool aql_check;
 
 	spin_lock_bh(&local->active_txq_lock[ac]);
 
@@ -4115,26 +4116,28 @@ struct ieee80211_txq *ieee80211_next_txq(struct ieee80211_hw *hw, u8 ac)
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
 
@@ -4201,7 +4204,8 @@ bool ieee80211_txq_airtime_check(struct ieee80211_hw *hw,
 		return true;
 
 	if (!txq->sta)
-		return true;
+		return atomic_read(&local->aql_mc_pending_airtime) <
+		       local->aql_txq_limit_mc;
 
 	if (unlikely(txq->tid == IEEE80211_NUM_TIDS))
 		return true;
@@ -4250,15 +4254,15 @@ bool ieee80211_txq_may_transmit(struct ieee80211_hw *hw,
 
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
2.53.0


