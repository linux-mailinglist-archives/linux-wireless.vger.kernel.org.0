Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97C7CCFF91
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 19:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfJHRLm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 13:11:42 -0400
Received: from nbd.name ([46.4.11.11]:40296 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfJHRLm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 13:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WhX5UkJK7wKLEtLIWVZw8/knD+6zSoDZOePQW4MzDFk=; b=ERt2XsVhsMnMarpk4hqIa38a+h
        sKcDnyMpV0nNw5OQp44R/frSPH7WBpvNMXripK5PvD9m/viUtXt1QE9V4uUfHsGolQDN1vZvBfXNc
        CeryyH/NKMVfKCL9mApZ9EVHwxBwHnxB7caCCVZCbdje9len0et4BNbjD3eN0qDWVQzg=;
Received: from p54ae92e8.dip0.t-ipconnect.de ([84.174.146.232] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iHt1Q-0006Pw-42; Tue, 08 Oct 2019 19:11:40 +0200
Received: by maeck.local (Postfix, from userid 501)
        id 770C36AF2798; Tue,  8 Oct 2019 19:11:39 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v2 3/3] mac80211: minstrel_ht: rename prob_ewma to prob_avg, use it for the new average
Date:   Tue,  8 Oct 2019 19:11:39 +0200
Message-Id: <20191008171139.96476-3-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20191008171139.96476-1-nbd@nbd.name>
References: <20191008171139.96476-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reduces per-rate data structure size

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rc80211_minstrel.c            | 40 ++++++++---------
 net/mac80211/rc80211_minstrel.h            | 23 ++++------
 net/mac80211/rc80211_minstrel_debugfs.c    |  8 ++--
 net/mac80211/rc80211_minstrel_ht.c         | 50 +++++++++++-----------
 net/mac80211/rc80211_minstrel_ht.h         |  2 +-
 net/mac80211/rc80211_minstrel_ht_debugfs.c |  8 ++--
 6 files changed, 63 insertions(+), 68 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel.c b/net/mac80211/rc80211_minstrel.c
index d9b7bc7fdb33..86bc469a28bc 100644
--- a/net/mac80211/rc80211_minstrel.c
+++ b/net/mac80211/rc80211_minstrel.c
@@ -70,7 +70,7 @@ rix_to_ndx(struct minstrel_sta_info *mi, int rix)
 }
 
 /* return current EMWA throughput */
-int minstrel_get_tp_avg(struct minstrel_rate *mr, int prob_ewma)
+int minstrel_get_tp_avg(struct minstrel_rate *mr, int prob_avg)
 {
 	int usecs;
 
@@ -79,13 +79,13 @@ int minstrel_get_tp_avg(struct minstrel_rate *mr, int prob_ewma)
 		usecs = 1000000;
 
 	/* reset thr. below 10% success */
-	if (mr->stats.prob_ewma < MINSTREL_FRAC(10, 100))
+	if (mr->stats.prob_avg < MINSTREL_FRAC(10, 100))
 		return 0;
 
-	if (prob_ewma > MINSTREL_FRAC(90, 100))
+	if (prob_avg > MINSTREL_FRAC(90, 100))
 		return MINSTREL_TRUNC(100000 * (MINSTREL_FRAC(90, 100) / usecs));
 	else
-		return MINSTREL_TRUNC(100000 * (prob_ewma / usecs));
+		return MINSTREL_TRUNC(100000 * (prob_avg / usecs));
 }
 
 /* find & sort topmost throughput rates */
@@ -98,8 +98,8 @@ minstrel_sort_best_tp_rates(struct minstrel_sta_info *mi, int i, u8 *tp_list)
 
 	for (j = MAX_THR_RATES; j > 0; --j) {
 		tmp_mrs = &mi->r[tp_list[j - 1]].stats;
-		if (minstrel_get_tp_avg(&mi->r[i], cur_mrs->prob_ewma) <=
-		    minstrel_get_tp_avg(&mi->r[tp_list[j - 1]], tmp_mrs->prob_ewma))
+		if (minstrel_get_tp_avg(&mi->r[i], cur_mrs->prob_avg) <=
+		    minstrel_get_tp_avg(&mi->r[tp_list[j - 1]], tmp_mrs->prob_avg))
 			break;
 	}
 
@@ -166,15 +166,15 @@ minstrel_calc_rate_stats(struct minstrel_priv *mp,
 		mrs->sample_skipped = 0;
 		cur_prob = MINSTREL_FRAC(mrs->success, mrs->attempts);
 		if (mp->new_avg) {
-			mrs->prob_ewma = minstrel_filter_avg_add(&mrs->avg,
-								 cur_prob);
+			minstrel_filter_avg_add(&mrs->prob_avg,
+						&mrs->prob_avg_1, cur_prob);
 		} else if (unlikely(!mrs->att_hist)) {
-			mrs->prob_ewma = cur_prob;
+			mrs->prob_avg = cur_prob;
 		} else {
 			/*update exponential weighted moving avarage */
-			mrs->prob_ewma = minstrel_ewma(mrs->prob_ewma,
-						       cur_prob,
-						       EWMA_LEVEL);
+			mrs->prob_avg = minstrel_ewma(mrs->prob_avg,
+						      cur_prob,
+						      EWMA_LEVEL);
 		}
 		mrs->att_hist += mrs->attempts;
 		mrs->succ_hist += mrs->success;
@@ -208,8 +208,8 @@ minstrel_update_stats(struct minstrel_priv *mp, struct minstrel_sta_info *mi)
 
 		/* Sample less often below the 10% chance of success.
 		 * Sample less often above the 95% chance of success. */
-		if (mrs->prob_ewma > MINSTREL_FRAC(95, 100) ||
-		    mrs->prob_ewma < MINSTREL_FRAC(10, 100)) {
+		if (mrs->prob_avg > MINSTREL_FRAC(95, 100) ||
+		    mrs->prob_avg < MINSTREL_FRAC(10, 100)) {
 			mr->adjusted_retry_count = mrs->retry_count >> 1;
 			if (mr->adjusted_retry_count > 2)
 				mr->adjusted_retry_count = 2;
@@ -229,14 +229,14 @@ minstrel_update_stats(struct minstrel_priv *mp, struct minstrel_sta_info *mi)
 		 * choose the maximum throughput rate as max_prob_rate
 		 * (2) if all success probabilities < 95%, the rate with
 		 * highest success probability is chosen as max_prob_rate */
-		if (mrs->prob_ewma >= MINSTREL_FRAC(95, 100)) {
-			tmp_cur_tp = minstrel_get_tp_avg(mr, mrs->prob_ewma);
+		if (mrs->prob_avg >= MINSTREL_FRAC(95, 100)) {
+			tmp_cur_tp = minstrel_get_tp_avg(mr, mrs->prob_avg);
 			tmp_prob_tp = minstrel_get_tp_avg(&mi->r[tmp_prob_rate],
-							  tmp_mrs->prob_ewma);
+							  tmp_mrs->prob_avg);
 			if (tmp_cur_tp >= tmp_prob_tp)
 				tmp_prob_rate = i;
 		} else {
-			if (mrs->prob_ewma >= tmp_mrs->prob_ewma)
+			if (mrs->prob_avg >= tmp_mrs->prob_avg)
 				tmp_prob_rate = i;
 		}
 	}
@@ -426,7 +426,7 @@ minstrel_get_rate(void *priv, struct ieee80211_sta *sta,
 	 * has a probability of >95%, we shouldn't be attempting
 	 * to use it, as this only wastes precious airtime */
 	if (!mrr_capable &&
-	   (mi->r[ndx].stats.prob_ewma > MINSTREL_FRAC(95, 100)))
+	   (mi->r[ndx].stats.prob_avg > MINSTREL_FRAC(95, 100)))
 		return;
 
 	mi->prev_sample = true;
@@ -577,7 +577,7 @@ static u32 minstrel_get_expected_throughput(void *priv_sta)
 	 * computing cur_tp
 	 */
 	tmp_mrs = &mi->r[idx].stats;
-	tmp_cur_tp = minstrel_get_tp_avg(&mi->r[idx], tmp_mrs->prob_ewma) * 10;
+	tmp_cur_tp = minstrel_get_tp_avg(&mi->r[idx], tmp_mrs->prob_avg) * 10;
 	tmp_cur_tp = tmp_cur_tp * 1200 * 8 / 1024;
 
 	return tmp_cur_tp;
diff --git a/net/mac80211/rc80211_minstrel.h b/net/mac80211/rc80211_minstrel.h
index 31f6f02ab765..dbb43bcd3c45 100644
--- a/net/mac80211/rc80211_minstrel.h
+++ b/net/mac80211/rc80211_minstrel.h
@@ -47,14 +47,10 @@ minstrel_ewma(int old, int new, int weight)
 	return old + incr;
 }
 
-struct minstrel_avg_ctx {
-	s32 prev[2];
-};
-
-static inline int minstrel_filter_avg_add(struct minstrel_avg_ctx *ctx, s32 in)
+static inline int minstrel_filter_avg_add(u16 *prev_1, u16 *prev_2, s32 in)
 {
-	s32 out_1 = ctx->prev[0];
-	s32 out_2 = ctx->prev[1];
+	s32 out_1 = *prev_1;
+	s32 out_2 = *prev_2;
 	s32 val;
 
 	if (!in)
@@ -76,8 +72,8 @@ static inline int minstrel_filter_avg_add(struct minstrel_avg_ctx *ctx, s32 in)
 		val = 1;
 
 out:
-	ctx->prev[1] = out_1;
-	ctx->prev[0] = val;
+	*prev_2 = out_1;
+	*prev_1 = val;
 
 	return val;
 }
@@ -90,10 +86,9 @@ struct minstrel_rate_stats {
 	/* total attempts/success counters */
 	u32 att_hist, succ_hist;
 
-	struct minstrel_avg_ctx avg;
-
-	/* prob_ewma - exponential weighted moving average of prob */
-	u16 prob_ewma;
+	/* prob_avg - moving average of prob */
+	u16 prob_avg;
+	u16 prob_avg_1;
 
 	/* maximum retry counts */
 	u8 retry_count;
@@ -181,7 +176,7 @@ void minstrel_add_sta_debugfs(void *priv, void *priv_sta, struct dentry *dir);
 /* Recalculate success probabilities and counters for a given rate using EWMA */
 void minstrel_calc_rate_stats(struct minstrel_priv *mp,
 			      struct minstrel_rate_stats *mrs);
-int minstrel_get_tp_avg(struct minstrel_rate *mr, int prob_ewma);
+int minstrel_get_tp_avg(struct minstrel_rate *mr, int prob_avg);
 
 /* debugfs */
 int minstrel_stats_open(struct inode *inode, struct file *file);
diff --git a/net/mac80211/rc80211_minstrel_debugfs.c b/net/mac80211/rc80211_minstrel_debugfs.c
index c8afd85b51a0..9b8e0daeb7bb 100644
--- a/net/mac80211/rc80211_minstrel_debugfs.c
+++ b/net/mac80211/rc80211_minstrel_debugfs.c
@@ -90,8 +90,8 @@ minstrel_stats_open(struct inode *inode, struct file *file)
 		p += sprintf(p, "%6u ", mr->perfect_tx_time);
 
 		tp_max = minstrel_get_tp_avg(mr, MINSTREL_FRAC(100,100));
-		tp_avg = minstrel_get_tp_avg(mr, mrs->prob_ewma);
-		eprob = MINSTREL_TRUNC(mrs->prob_ewma * 1000);
+		tp_avg = minstrel_get_tp_avg(mr, mrs->prob_avg);
+		eprob = MINSTREL_TRUNC(mrs->prob_avg * 1000);
 
 		p += sprintf(p, "%4u.%1u    %4u.%1u     %3u.%1u"
 				"     %3u   %3u %-3u   "
@@ -147,8 +147,8 @@ minstrel_stats_csv_open(struct inode *inode, struct file *file)
 		p += sprintf(p, "%u,",mr->perfect_tx_time);
 
 		tp_max = minstrel_get_tp_avg(mr, MINSTREL_FRAC(100,100));
-		tp_avg = minstrel_get_tp_avg(mr, mrs->prob_ewma);
-		eprob = MINSTREL_TRUNC(mrs->prob_ewma * 1000);
+		tp_avg = minstrel_get_tp_avg(mr, mrs->prob_avg);
+		eprob = MINSTREL_TRUNC(mrs->prob_avg * 1000);
 
 		p += sprintf(p, "%u.%u,%u.%u,%u.%u,%u,%u,%u,"
 				"%llu,%llu,%d,%d\n",
diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 96c81392e617..694a31978a04 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -346,12 +346,12 @@ minstrel_ht_avg_ampdu_len(struct minstrel_ht_sta *mi)
  */
 int
 minstrel_ht_get_tp_avg(struct minstrel_ht_sta *mi, int group, int rate,
-		       int prob_ewma)
+		       int prob_avg)
 {
 	unsigned int nsecs = 0;
 
 	/* do not account throughput if sucess prob is below 10% */
-	if (prob_ewma < MINSTREL_FRAC(10, 100))
+	if (prob_avg < MINSTREL_FRAC(10, 100))
 		return 0;
 
 	if (group != MINSTREL_CCK_GROUP)
@@ -365,11 +365,11 @@ minstrel_ht_get_tp_avg(struct minstrel_ht_sta *mi, int group, int rate,
 	 * account for collision related packet error rate fluctuation
 	 * (prob is scaled - see MINSTREL_FRAC above)
 	 */
-	if (prob_ewma > MINSTREL_FRAC(90, 100))
+	if (prob_avg > MINSTREL_FRAC(90, 100))
 		return MINSTREL_TRUNC(100000 * ((MINSTREL_FRAC(90, 100) * 1000)
 								      / nsecs));
 	else
-		return MINSTREL_TRUNC(100000 * ((prob_ewma * 1000) / nsecs));
+		return MINSTREL_TRUNC(100000 * ((prob_avg * 1000) / nsecs));
 }
 
 /*
@@ -389,13 +389,13 @@ minstrel_ht_sort_best_tp_rates(struct minstrel_ht_sta *mi, u16 index,
 
 	cur_group = index / MCS_GROUP_RATES;
 	cur_idx = index  % MCS_GROUP_RATES;
-	cur_prob = mi->groups[cur_group].rates[cur_idx].prob_ewma;
+	cur_prob = mi->groups[cur_group].rates[cur_idx].prob_avg;
 	cur_tp_avg = minstrel_ht_get_tp_avg(mi, cur_group, cur_idx, cur_prob);
 
 	do {
 		tmp_group = tp_list[j - 1] / MCS_GROUP_RATES;
 		tmp_idx = tp_list[j - 1] % MCS_GROUP_RATES;
-		tmp_prob = mi->groups[tmp_group].rates[tmp_idx].prob_ewma;
+		tmp_prob = mi->groups[tmp_group].rates[tmp_idx].prob_avg;
 		tmp_tp_avg = minstrel_ht_get_tp_avg(mi, tmp_group, tmp_idx,
 						    tmp_prob);
 		if (cur_tp_avg < tmp_tp_avg ||
@@ -432,7 +432,7 @@ minstrel_ht_set_best_prob_rate(struct minstrel_ht_sta *mi, u16 index)
 
 	tmp_group = mi->max_prob_rate / MCS_GROUP_RATES;
 	tmp_idx = mi->max_prob_rate % MCS_GROUP_RATES;
-	tmp_prob = mi->groups[tmp_group].rates[tmp_idx].prob_ewma;
+	tmp_prob = mi->groups[tmp_group].rates[tmp_idx].prob_avg;
 	tmp_tp_avg = minstrel_ht_get_tp_avg(mi, tmp_group, tmp_idx, tmp_prob);
 
 	/* if max_tp_rate[0] is from MCS_GROUP max_prob_rate get selected from
@@ -444,11 +444,11 @@ minstrel_ht_set_best_prob_rate(struct minstrel_ht_sta *mi, u16 index)
 
 	max_gpr_group = mg->max_group_prob_rate / MCS_GROUP_RATES;
 	max_gpr_idx = mg->max_group_prob_rate % MCS_GROUP_RATES;
-	max_gpr_prob = mi->groups[max_gpr_group].rates[max_gpr_idx].prob_ewma;
+	max_gpr_prob = mi->groups[max_gpr_group].rates[max_gpr_idx].prob_avg;
 
-	if (mrs->prob_ewma > MINSTREL_FRAC(75, 100)) {
+	if (mrs->prob_avg > MINSTREL_FRAC(75, 100)) {
 		cur_tp_avg = minstrel_ht_get_tp_avg(mi, cur_group, cur_idx,
-						    mrs->prob_ewma);
+						    mrs->prob_avg);
 		if (cur_tp_avg > tmp_tp_avg)
 			mi->max_prob_rate = index;
 
@@ -458,9 +458,9 @@ minstrel_ht_set_best_prob_rate(struct minstrel_ht_sta *mi, u16 index)
 		if (cur_tp_avg > max_gpr_tp_avg)
 			mg->max_group_prob_rate = index;
 	} else {
-		if (mrs->prob_ewma > tmp_prob)
+		if (mrs->prob_avg > tmp_prob)
 			mi->max_prob_rate = index;
-		if (mrs->prob_ewma > max_gpr_prob)
+		if (mrs->prob_avg > max_gpr_prob)
 			mg->max_group_prob_rate = index;
 	}
 }
@@ -482,12 +482,12 @@ minstrel_ht_assign_best_tp_rates(struct minstrel_ht_sta *mi,
 
 	tmp_group = tmp_cck_tp_rate[0] / MCS_GROUP_RATES;
 	tmp_idx = tmp_cck_tp_rate[0] % MCS_GROUP_RATES;
-	tmp_prob = mi->groups[tmp_group].rates[tmp_idx].prob_ewma;
+	tmp_prob = mi->groups[tmp_group].rates[tmp_idx].prob_avg;
 	tmp_cck_tp = minstrel_ht_get_tp_avg(mi, tmp_group, tmp_idx, tmp_prob);
 
 	tmp_group = tmp_mcs_tp_rate[0] / MCS_GROUP_RATES;
 	tmp_idx = tmp_mcs_tp_rate[0] % MCS_GROUP_RATES;
-	tmp_prob = mi->groups[tmp_group].rates[tmp_idx].prob_ewma;
+	tmp_prob = mi->groups[tmp_group].rates[tmp_idx].prob_avg;
 	tmp_mcs_tp = minstrel_ht_get_tp_avg(mi, tmp_group, tmp_idx, tmp_prob);
 
 	if (tmp_cck_tp_rate && tmp_cck_tp > tmp_mcs_tp) {
@@ -518,7 +518,7 @@ minstrel_ht_prob_rate_reduce_streams(struct minstrel_ht_sta *mi)
 			continue;
 
 		tmp_idx = mg->max_group_prob_rate % MCS_GROUP_RATES;
-		tmp_prob = mi->groups[group].rates[tmp_idx].prob_ewma;
+		tmp_prob = mi->groups[group].rates[tmp_idx].prob_avg;
 
 		if (tmp_tp < minstrel_ht_get_tp_avg(mi, group, tmp_idx, tmp_prob) &&
 		   (minstrel_mcs_groups[group].streams < tmp_max_streams)) {
@@ -623,7 +623,7 @@ minstrel_ht_rate_sample_switch(struct minstrel_priv *mp,
 	 * If that fails, look again for a rate that is at least as fast
 	 */
 	mrs = minstrel_get_ratestats(mi, mi->max_tp_rate[0]);
-	faster_rate = mrs->prob_ewma > MINSTREL_FRAC(75, 100);
+	faster_rate = mrs->prob_avg > MINSTREL_FRAC(75, 100);
 	minstrel_ht_find_probe_rates(mi, rates, &n_rates, faster_rate);
 	if (!n_rates && faster_rate)
 		minstrel_ht_find_probe_rates(mi, rates, &n_rates, false);
@@ -738,7 +738,7 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 			mrs = &mg->rates[i];
 			mrs->retry_updated = false;
 			minstrel_calc_rate_stats(mp, mrs);
-			cur_prob = mrs->prob_ewma;
+			cur_prob = mrs->prob_avg;
 
 			if (minstrel_ht_get_tp_avg(mi, group, i, cur_prob) == 0)
 				continue;
@@ -1012,7 +1012,7 @@ minstrel_calc_retransmit(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	unsigned int overhead = 0, overhead_rtscts = 0;
 
 	mrs = minstrel_get_ratestats(mi, index);
-	if (mrs->prob_ewma < MINSTREL_FRAC(1, 10)) {
+	if (mrs->prob_avg < MINSTREL_FRAC(1, 10)) {
 		mrs->retry_count = 1;
 		mrs->retry_count_rtscts = 1;
 		return;
@@ -1069,7 +1069,7 @@ minstrel_ht_set_rate(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	if (!mrs->retry_updated)
 		minstrel_calc_retransmit(mp, mi, index);
 
-	if (mrs->prob_ewma < MINSTREL_FRAC(20, 100) || !mrs->retry_count) {
+	if (mrs->prob_avg < MINSTREL_FRAC(20, 100) || !mrs->retry_count) {
 		ratetbl->rate[offset].count = 2;
 		ratetbl->rate[offset].count_rts = 2;
 		ratetbl->rate[offset].count_cts = 2;
@@ -1103,11 +1103,11 @@ minstrel_ht_set_rate(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 }
 
 static inline int
-minstrel_ht_get_prob_ewma(struct minstrel_ht_sta *mi, int rate)
+minstrel_ht_get_prob_avg(struct minstrel_ht_sta *mi, int rate)
 {
 	int group = rate / MCS_GROUP_RATES;
 	rate %= MCS_GROUP_RATES;
-	return mi->groups[group].rates[rate].prob_ewma;
+	return mi->groups[group].rates[rate].prob_avg;
 }
 
 static int
@@ -1119,7 +1119,7 @@ minstrel_ht_get_max_amsdu_len(struct minstrel_ht_sta *mi)
 	unsigned int duration;
 
 	/* Disable A-MSDU if max_prob_rate is bad */
-	if (mi->groups[group].rates[rate].prob_ewma < MINSTREL_FRAC(50, 100))
+	if (mi->groups[group].rates[rate].prob_avg < MINSTREL_FRAC(50, 100))
 		return 1;
 
 	duration = g->duration[rate];
@@ -1142,7 +1142,7 @@ minstrel_ht_get_max_amsdu_len(struct minstrel_ht_sta *mi)
 	 * data packet size
 	 */
 	if (duration > MCS_DURATION(1, 0, 260) ||
-	    (minstrel_ht_get_prob_ewma(mi, mi->max_tp_rate[0]) <
+	    (minstrel_ht_get_prob_avg(mi, mi->max_tp_rate[0]) <
 	     MINSTREL_FRAC(75, 100)))
 		return 3200;
 
@@ -1247,7 +1247,7 @@ minstrel_get_sample_rate(struct minstrel_priv *mp, struct minstrel_ht_sta *mi)
 	 * rate, to avoid wasting airtime.
 	 */
 	sample_dur = minstrel_get_duration(sample_idx);
-	if (mrs->prob_ewma > MINSTREL_FRAC(95, 100) ||
+	if (mrs->prob_avg > MINSTREL_FRAC(95, 100) ||
 	    minstrel_get_duration(mi->max_prob_rate) * 3 < sample_dur)
 		return -1;
 
@@ -1705,7 +1705,7 @@ static u32 minstrel_ht_get_expected_throughput(void *priv_sta)
 
 	i = mi->max_tp_rate[0] / MCS_GROUP_RATES;
 	j = mi->max_tp_rate[0] % MCS_GROUP_RATES;
-	prob = mi->groups[i].rates[j].prob_ewma;
+	prob = mi->groups[i].rates[j].prob_avg;
 
 	/* convert tp_avg from pkt per second in kbps */
 	tp_avg = minstrel_ht_get_tp_avg(mi, i, j, prob) * 10;
diff --git a/net/mac80211/rc80211_minstrel_ht.h b/net/mac80211/rc80211_minstrel_ht.h
index f938701e7ab7..53ea3c29debf 100644
--- a/net/mac80211/rc80211_minstrel_ht.h
+++ b/net/mac80211/rc80211_minstrel_ht.h
@@ -119,6 +119,6 @@ struct minstrel_ht_sta_priv {
 
 void minstrel_ht_add_sta_debugfs(void *priv, void *priv_sta, struct dentry *dir);
 int minstrel_ht_get_tp_avg(struct minstrel_ht_sta *mi, int group, int rate,
-			   int prob_ewma);
+			   int prob_avg);
 
 #endif
diff --git a/net/mac80211/rc80211_minstrel_ht_debugfs.c b/net/mac80211/rc80211_minstrel_ht_debugfs.c
index 5a6e9f3edc04..bebb71917742 100644
--- a/net/mac80211/rc80211_minstrel_ht_debugfs.c
+++ b/net/mac80211/rc80211_minstrel_ht_debugfs.c
@@ -98,8 +98,8 @@ minstrel_ht_stats_dump(struct minstrel_ht_sta *mi, int i, char *p)
 		p += sprintf(p, "%6u  ", tx_time);
 
 		tp_max = minstrel_ht_get_tp_avg(mi, i, j, MINSTREL_FRAC(100, 100));
-		tp_avg = minstrel_ht_get_tp_avg(mi, i, j, mrs->prob_ewma);
-		eprob = MINSTREL_TRUNC(mrs->prob_ewma * 1000);
+		tp_avg = minstrel_ht_get_tp_avg(mi, i, j, mrs->prob_avg);
+		eprob = MINSTREL_TRUNC(mrs->prob_avg * 1000);
 
 		p += sprintf(p, "%4u.%1u    %4u.%1u     %3u.%1u"
 				"     %3u   %3u %-3u   "
@@ -243,8 +243,8 @@ minstrel_ht_stats_csv_dump(struct minstrel_ht_sta *mi, int i, char *p)
 		p += sprintf(p, "%u,", tx_time);
 
 		tp_max = minstrel_ht_get_tp_avg(mi, i, j, MINSTREL_FRAC(100, 100));
-		tp_avg = minstrel_ht_get_tp_avg(mi, i, j, mrs->prob_ewma);
-		eprob = MINSTREL_TRUNC(mrs->prob_ewma * 1000);
+		tp_avg = minstrel_ht_get_tp_avg(mi, i, j, mrs->prob_avg);
+		eprob = MINSTREL_TRUNC(mrs->prob_avg * 1000);
 
 		p += sprintf(p, "%u.%u,%u.%u,%u.%u,%u,%u,"
 				"%u,%llu,%llu,",
-- 
2.17.0

