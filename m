Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31CD8305C7B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jan 2021 14:08:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313796AbhAZWqN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jan 2021 17:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395043AbhAZS7D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Jan 2021 13:59:03 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E94C061794
        for <linux-wireless@vger.kernel.org>; Tue, 26 Jan 2021 10:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0cOrM8llVmwunEZdSp78B7BFxEYegyk7QngSvKGqTSs=; b=bQTyJ3+Az/P5hLauinc2Ggq4ac
        kntb44q6gYe8RO8RHz2GRcd8sbS5OJkKnMmu5lrbRtx+DNDtSqEnh186b2WS0QQtHmDPlNAFxOA3b
        UsYkIdqNPIt9YAB+WagqICQZFjNx/RDD7HZv8ZOM3kX1hO7KbQcbev1hSDtpI2M87dJo=;
Received: from p54ae953c.dip0.t-ipconnect.de ([84.174.149.60] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l4TXT-0003cb-W8; Tue, 26 Jan 2021 19:58:08 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v2 1/6] mac80211: minstrel_ht: use bitfields to encode rate indexes
Date:   Tue, 26 Jan 2021 19:58:01 +0100
Message-Id: <20210126185806.61770-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of a lot of divisions and modulo operations
Reduces code size and improves performance

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2: fix uninitialized variable warning

 net/mac80211/rc80211_minstrel_ht.c         | 126 +++++++++++----------
 net/mac80211/rc80211_minstrel_ht.h         |  13 +++
 net/mac80211/rc80211_minstrel_ht_debugfs.c |   4 +-
 3 files changed, 79 insertions(+), 64 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index bfa550068de4..8974c3510489 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -379,13 +379,13 @@ minstrel_ht_get_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 static inline struct minstrel_rate_stats *
 minstrel_get_ratestats(struct minstrel_ht_sta *mi, int index)
 {
-	return &mi->groups[index / MCS_GROUP_RATES].rates[index % MCS_GROUP_RATES];
+	return &mi->groups[MI_RATE_GROUP(index)].rates[MI_RATE_IDX(index)];
 }
 
 static inline int minstrel_get_duration(int index)
 {
-	const struct mcs_group *group = &minstrel_mcs_groups[index / MCS_GROUP_RATES];
-	unsigned int duration = group->duration[index % MCS_GROUP_RATES];
+	const struct mcs_group *group = &minstrel_mcs_groups[MI_RATE_GROUP(index)];
+	unsigned int duration = group->duration[MI_RATE_IDX(index)];
 
 	return duration << group->shift;
 }
@@ -398,7 +398,7 @@ minstrel_ht_avg_ampdu_len(struct minstrel_ht_sta *mi)
 	if (mi->avg_ampdu_len)
 		return MINSTREL_TRUNC(mi->avg_ampdu_len);
 
-	if (minstrel_ht_is_legacy_group(mi->max_tp_rate[0] / MCS_GROUP_RATES))
+	if (minstrel_ht_is_legacy_group(MI_RATE_GROUP(mi->max_tp_rate[0])))
 		return 1;
 
 	duration = minstrel_get_duration(mi->max_tp_rate[0]);
@@ -465,14 +465,14 @@ minstrel_ht_sort_best_tp_rates(struct minstrel_ht_sta *mi, u16 index,
 	int tmp_group, tmp_idx, tmp_tp_avg, tmp_prob;
 	int j = MAX_THR_RATES;
 
-	cur_group = index / MCS_GROUP_RATES;
-	cur_idx = index  % MCS_GROUP_RATES;
+	cur_group = MI_RATE_GROUP(index);
+	cur_idx = MI_RATE_IDX(index);
 	cur_prob = mi->groups[cur_group].rates[cur_idx].prob_avg;
 	cur_tp_avg = minstrel_ht_get_tp_avg(mi, cur_group, cur_idx, cur_prob);
 
 	do {
-		tmp_group = tp_list[j - 1] / MCS_GROUP_RATES;
-		tmp_idx = tp_list[j - 1] % MCS_GROUP_RATES;
+		tmp_group = MI_RATE_GROUP(tp_list[j - 1]);
+		tmp_idx = MI_RATE_IDX(tp_list[j - 1]);
 		tmp_prob = mi->groups[tmp_group].rates[tmp_idx].prob_avg;
 		tmp_tp_avg = minstrel_ht_get_tp_avg(mi, tmp_group, tmp_idx,
 						    tmp_prob);
@@ -504,23 +504,23 @@ minstrel_ht_set_best_prob_rate(struct minstrel_ht_sta *mi, u16 *dest, u16 index)
 	int max_gpr_group, max_gpr_idx;
 	int max_gpr_tp_avg, max_gpr_prob;
 
-	cur_group = index / MCS_GROUP_RATES;
-	cur_idx = index % MCS_GROUP_RATES;
-	mg = &mi->groups[index / MCS_GROUP_RATES];
-	mrs = &mg->rates[index % MCS_GROUP_RATES];
+	cur_group = MI_RATE_GROUP(index);
+	cur_idx = MI_RATE_IDX(index);
+	mg = &mi->groups[cur_group];
+	mrs = &mg->rates[cur_idx];
 
-	tmp_group = *dest / MCS_GROUP_RATES;
-	tmp_idx = *dest % MCS_GROUP_RATES;
+	tmp_group = MI_RATE_GROUP(*dest);
+	tmp_idx = MI_RATE_IDX(*dest);
 	tmp_prob = mi->groups[tmp_group].rates[tmp_idx].prob_avg;
 	tmp_tp_avg = minstrel_ht_get_tp_avg(mi, tmp_group, tmp_idx, tmp_prob);
 
 	/* if max_tp_rate[0] is from MCS_GROUP max_prob_rate get selected from
 	 * MCS_GROUP as well as CCK_GROUP rates do not allow aggregation */
-	max_tp_group = mi->max_tp_rate[0] / MCS_GROUP_RATES;
-	max_tp_idx = mi->max_tp_rate[0] % MCS_GROUP_RATES;
+	max_tp_group = MI_RATE_GROUP(mi->max_tp_rate[0]);
+	max_tp_idx = MI_RATE_IDX(mi->max_tp_rate[0]);
 	max_tp_prob = mi->groups[max_tp_group].rates[max_tp_idx].prob_avg;
 
-	if (minstrel_ht_is_legacy_group(index / MCS_GROUP_RATES) &&
+	if (minstrel_ht_is_legacy_group(MI_RATE_GROUP(index)) &&
 	    !minstrel_ht_is_legacy_group(max_tp_group))
 		return;
 
@@ -529,8 +529,8 @@ minstrel_ht_set_best_prob_rate(struct minstrel_ht_sta *mi, u16 *dest, u16 index)
 	    mrs->prob_avg < max_tp_prob)
 		return;
 
-	max_gpr_group = mg->max_group_prob_rate / MCS_GROUP_RATES;
-	max_gpr_idx = mg->max_group_prob_rate % MCS_GROUP_RATES;
+	max_gpr_group = MI_RATE_GROUP(mg->max_group_prob_rate);
+	max_gpr_idx = MI_RATE_IDX(mg->max_group_prob_rate);
 	max_gpr_prob = mi->groups[max_gpr_group].rates[max_gpr_idx].prob_avg;
 
 	if (mrs->prob_avg > MINSTREL_FRAC(75, 100)) {
@@ -567,13 +567,13 @@ minstrel_ht_assign_best_tp_rates(struct minstrel_ht_sta *mi,
 	unsigned int tmp_group, tmp_idx, tmp_cck_tp, tmp_mcs_tp, tmp_prob;
 	int i;
 
-	tmp_group = tmp_legacy_tp_rate[0] / MCS_GROUP_RATES;
-	tmp_idx = tmp_legacy_tp_rate[0] % MCS_GROUP_RATES;
+	tmp_group = MI_RATE_GROUP(tmp_legacy_tp_rate[0]);
+	tmp_idx = MI_RATE_IDX(tmp_legacy_tp_rate[0]);
 	tmp_prob = mi->groups[tmp_group].rates[tmp_idx].prob_avg;
 	tmp_cck_tp = minstrel_ht_get_tp_avg(mi, tmp_group, tmp_idx, tmp_prob);
 
-	tmp_group = tmp_mcs_tp_rate[0] / MCS_GROUP_RATES;
-	tmp_idx = tmp_mcs_tp_rate[0] % MCS_GROUP_RATES;
+	tmp_group = MI_RATE_GROUP(tmp_mcs_tp_rate[0]);
+	tmp_idx = MI_RATE_IDX(tmp_mcs_tp_rate[0]);
 	tmp_prob = mi->groups[tmp_group].rates[tmp_idx].prob_avg;
 	tmp_mcs_tp = minstrel_ht_get_tp_avg(mi, tmp_group, tmp_idx, tmp_prob);
 
@@ -600,14 +600,14 @@ minstrel_ht_prob_rate_reduce_streams(struct minstrel_ht_sta *mi)
 	if (!mi->sta->ht_cap.ht_supported)
 		return;
 
-	tmp_max_streams = minstrel_mcs_groups[mi->max_tp_rate[0] /
-			  MCS_GROUP_RATES].streams;
+	group = MI_RATE_GROUP(mi->max_tp_rate[0]);
+	tmp_max_streams = minstrel_mcs_groups[group].streams;
 	for (group = 0; group < ARRAY_SIZE(minstrel_mcs_groups); group++) {
 		mg = &mi->groups[group];
 		if (!mi->supported[group] || group == MINSTREL_CCK_GROUP)
 			continue;
 
-		tmp_idx = mg->max_group_prob_rate % MCS_GROUP_RATES;
+		tmp_idx = MI_RATE_IDX(mg->max_group_prob_rate);
 		tmp_prob = mi->groups[group].rates[tmp_idx].prob_avg;
 
 		if (tmp_tp < minstrel_ht_get_tp_avg(mi, group, tmp_idx, tmp_prob) &&
@@ -644,8 +644,8 @@ minstrel_ht_find_probe_rates(struct minstrel_ht_sta *mi, u16 *rates, int *n_rate
 	int i, g, max_dur;
 	int tp_idx;
 
-	tp_group = &minstrel_mcs_groups[mi->max_tp_rate[0] / MCS_GROUP_RATES];
-	tp_idx = mi->max_tp_rate[0] % MCS_GROUP_RATES;
+	tp_group = &minstrel_mcs_groups[MI_RATE_GROUP(mi->max_tp_rate[0])];
+	tp_idx = MI_RATE_IDX(mi->max_tp_rate[0]);
 
 	max_dur = minstrel_get_duration(mi->max_tp_rate[0]);
 	if (faster_rate)
@@ -670,7 +670,7 @@ minstrel_ht_find_probe_rates(struct minstrel_ht_sta *mi, u16 *rates, int *n_rate
 			if ((group->duration[i] << group->shift) > max_dur)
 				continue;
 
-			idx = g * MCS_GROUP_RATES + i;
+			idx = MI_RATE(g, i);
 			if (idx == mi->max_tp_rate[0])
 				continue;
 
@@ -712,10 +712,10 @@ minstrel_ht_rate_sample_switch(struct minstrel_priv *mp,
 
 	/* If no suitable rate was found, try to pick the next one in the group */
 	if (!n_rates) {
-		int g_idx = mi->max_tp_rate[0] / MCS_GROUP_RATES;
+		int g_idx = MI_RATE_GROUP(mi->max_tp_rate[0]);
 		u16 supported = mi->supported[g_idx];
 
-		supported >>= mi->max_tp_rate[0] % MCS_GROUP_RATES;
+		supported >>= MI_RATE_IDX(mi->max_tp_rate[0]);
 		for (i = 0; supported; supported >>= 1, i++) {
 			if (!(supported & 1))
 				continue;
@@ -854,24 +854,27 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	mi->sample_slow = 0;
 	mi->sample_count = 0;
 
-	memset(tmp_mcs_tp_rate, 0, sizeof(tmp_mcs_tp_rate));
-	memset(tmp_legacy_tp_rate, 0, sizeof(tmp_legacy_tp_rate));
 	if (mi->supported[MINSTREL_CCK_GROUP])
-		for (j = 0; j < ARRAY_SIZE(tmp_legacy_tp_rate); j++)
-			tmp_legacy_tp_rate[j] = MINSTREL_CCK_GROUP * MCS_GROUP_RATES;
+		group = MINSTREL_CCK_GROUP;
 	else if (mi->supported[MINSTREL_OFDM_GROUP])
-		for (j = 0; j < ARRAY_SIZE(tmp_legacy_tp_rate); j++)
-			tmp_legacy_tp_rate[j] = MINSTREL_OFDM_GROUP * MCS_GROUP_RATES;
+		group = MINSTREL_OFDM_GROUP;
+	else
+		group = 0;
+
+	index = MI_RATE(group, 0);
+	for (j = 0; j < ARRAY_SIZE(tmp_legacy_tp_rate); j++)
+		tmp_legacy_tp_rate[j] = index;
 
 	if (mi->supported[MINSTREL_VHT_GROUP_0])
-		index = MINSTREL_VHT_GROUP_0 * MCS_GROUP_RATES;
+		group = MINSTREL_VHT_GROUP_0;
 	else if (ht_supported)
-		index = MINSTREL_HT_GROUP_0 * MCS_GROUP_RATES;
+		group = MINSTREL_HT_GROUP_0;
 	else if (mi->supported[MINSTREL_CCK_GROUP])
-		index = MINSTREL_CCK_GROUP * MCS_GROUP_RATES;
+		group = MINSTREL_CCK_GROUP;
 	else
-		index = MINSTREL_OFDM_GROUP * MCS_GROUP_RATES;
+		group = MINSTREL_OFDM_GROUP;
 
+	index = MI_RATE(group, 0);
 	tmp_max_prob_rate = index;
 	for (j = 0; j < ARRAY_SIZE(tmp_mcs_tp_rate); j++)
 		tmp_mcs_tp_rate[j] = index;
@@ -888,7 +891,7 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 
 		/* (re)Initialize group rate indexes */
 		for(j = 0; j < MAX_THR_RATES; j++)
-			tmp_group_tp_rate[j] = MCS_GROUP_RATES * group;
+			tmp_group_tp_rate[j] = MI_RATE(group, 0);
 
 		if (group == MINSTREL_CCK_GROUP && ht_supported)
 			tp_rate = tmp_legacy_tp_rate;
@@ -897,7 +900,7 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 			if (!(mi->supported[group] & BIT(i)))
 				continue;
 
-			index = MCS_GROUP_RATES * group + i;
+			index = MI_RATE(group, i);
 
 			mrs = &mg->rates[i];
 			mrs->retry_updated = false;
@@ -929,13 +932,13 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 			continue;
 
 		mg = &mi->groups[group];
-		mg->max_group_prob_rate = MCS_GROUP_RATES * group;
+		mg->max_group_prob_rate = MI_RATE(group, 0);
 
 		for (i = 0; i < MCS_GROUP_RATES; i++) {
 			if (!(mi->supported[group] & BIT(i)))
 				continue;
 
-			index = MCS_GROUP_RATES * group + i;
+			index = MI_RATE(group, i);
 
 			/* Find max probability rate per group and global */
 			minstrel_ht_set_best_prob_rate(mi, &tmp_max_prob_rate,
@@ -1022,7 +1025,7 @@ minstrel_downgrade_rate(struct minstrel_ht_sta *mi, u16 *idx, bool primary)
 {
 	int group, orig_group;
 
-	orig_group = group = *idx / MCS_GROUP_RATES;
+	orig_group = group = MI_RATE_GROUP(*idx);
 	while (group > 0) {
 		group--;
 
@@ -1206,7 +1209,7 @@ minstrel_calc_retransmit(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	ctime += (t_slot * cw) >> 1;
 	cw = min((cw << 1) | 1, mp->cw_max);
 
-	if (minstrel_ht_is_legacy_group(index / MCS_GROUP_RATES)) {
+	if (minstrel_ht_is_legacy_group(MI_RATE_GROUP(index))) {
 		overhead = mi->overhead_legacy;
 		overhead_rtscts = mi->overhead_legacy_rtscts;
 	} else {
@@ -1239,7 +1242,7 @@ static void
 minstrel_ht_set_rate(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
                      struct ieee80211_sta_rates *ratetbl, int offset, int index)
 {
-	int group_idx = index / MCS_GROUP_RATES;
+	int group_idx = MI_RATE_GROUP(index);
 	const struct mcs_group *group = &minstrel_mcs_groups[group_idx];
 	struct minstrel_rate_stats *mrs;
 	u8 idx;
@@ -1259,7 +1262,7 @@ minstrel_ht_set_rate(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 		ratetbl->rate[offset].count_rts = mrs->retry_count_rtscts;
 	}
 
-	index %= MCS_GROUP_RATES;
+	index = MI_RATE_IDX(index);
 	if (group_idx == MINSTREL_CCK_GROUP)
 		idx = mp->cck_rates[index % ARRAY_SIZE(mp->cck_rates)];
 	else if (group_idx == MINSTREL_OFDM_GROUP)
@@ -1289,17 +1292,17 @@ minstrel_ht_set_rate(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 static inline int
 minstrel_ht_get_prob_avg(struct minstrel_ht_sta *mi, int rate)
 {
-	int group = rate / MCS_GROUP_RATES;
-	rate %= MCS_GROUP_RATES;
+	int group = MI_RATE_GROUP(rate);
+	rate = MI_RATE_IDX(rate);
 	return mi->groups[group].rates[rate].prob_avg;
 }
 
 static int
 minstrel_ht_get_max_amsdu_len(struct minstrel_ht_sta *mi)
 {
-	int group = mi->max_prob_rate / MCS_GROUP_RATES;
+	int group = MI_RATE_GROUP(mi->max_prob_rate);
 	const struct mcs_group *g = &minstrel_mcs_groups[group];
-	int rate = mi->max_prob_rate % MCS_GROUP_RATES;
+	int rate = MI_RATE_IDX(mi->max_prob_rate);
 	unsigned int duration;
 
 	/* Disable A-MSDU if max_prob_rate is bad */
@@ -1405,7 +1408,7 @@ minstrel_get_sample_rate(struct minstrel_priv *mp, struct minstrel_ht_sta *mi)
 		return -1;
 
 	mrs = &mg->rates[sample_idx];
-	sample_idx += sample_group * MCS_GROUP_RATES;
+	sample_idx += MI_RATE(sample_group, 0);
 
 	tp_rate1 = mi->max_tp_rate[0];
 
@@ -1455,8 +1458,7 @@ minstrel_get_sample_rate(struct minstrel_priv *mp, struct minstrel_ht_sta *mi)
 	 * if the link is working perfectly.
 	 */
 
-	cur_max_tp_streams = minstrel_mcs_groups[tp_rate1 /
-		MCS_GROUP_RATES].streams;
+	cur_max_tp_streams = minstrel_mcs_groups[MI_RATE_GROUP(tp_rate1)].streams;
 	if (sample_dur >= minstrel_get_duration(tp_rate2) &&
 	    (cur_max_tp_streams - 1 <
 	     minstrel_mcs_groups[sample_group].streams ||
@@ -1484,7 +1486,7 @@ minstrel_ht_get_rate(void *priv, struct ieee80211_sta *sta, void *priv_sta,
 	int sample_idx;
 
 	if (!(info->flags & IEEE80211_TX_CTL_AMPDU) &&
-	    !minstrel_ht_is_legacy_group(mi->max_prob_rate / MCS_GROUP_RATES))
+	    !minstrel_ht_is_legacy_group(MI_RATE_GROUP(mi->max_prob_rate)))
 		minstrel_aggr_check(sta, txrc->skb);
 
 	info->flags |= mi->tx_flags;
@@ -1512,8 +1514,8 @@ minstrel_ht_get_rate(void *priv, struct ieee80211_sta *sta, void *priv_sta,
 	if (sample_idx < 0)
 		return;
 
-	sample_group = &minstrel_mcs_groups[sample_idx / MCS_GROUP_RATES];
-	sample_idx %= MCS_GROUP_RATES;
+	sample_group = &minstrel_mcs_groups[MI_RATE_GROUP(sample_idx)];
+	sample_idx = MI_RATE_IDX(sample_idx);
 
 	if (sample_group == &minstrel_mcs_groups[MINSTREL_CCK_GROUP] &&
 	    (sample_idx >= 4) != txrc->short_preamble)
@@ -1529,7 +1531,7 @@ minstrel_ht_get_rate(void *priv, struct ieee80211_sta *sta, void *priv_sta,
 		int idx = sample_idx % ARRAY_SIZE(mp->ofdm_rates[0]);
 		rate->idx = mp->ofdm_rates[mi->band][idx];
 	} else if (sample_group->flags & IEEE80211_TX_RC_VHT_MCS) {
-		ieee80211_rate_set_vht(rate, sample_idx % MCS_GROUP_RATES,
+		ieee80211_rate_set_vht(rate, MI_RATE_IDX(sample_idx),
 				       sample_group->streams);
 	} else {
 		rate->idx = sample_idx + (sample_group->streams - 1) * 8;
@@ -1898,8 +1900,8 @@ static u32 minstrel_ht_get_expected_throughput(void *priv_sta)
 	struct minstrel_ht_sta *mi = priv_sta;
 	int i, j, prob, tp_avg;
 
-	i = mi->max_tp_rate[0] / MCS_GROUP_RATES;
-	j = mi->max_tp_rate[0] % MCS_GROUP_RATES;
+	i = MI_RATE_GROUP(mi->max_tp_rate[0]);
+	j = MI_RATE_IDX(mi->max_tp_rate[0]);
 	prob = mi->groups[i].rates[j].prob_avg;
 
 	/* convert tp_avg from pkt per second in kbps */
diff --git a/net/mac80211/rc80211_minstrel_ht.h b/net/mac80211/rc80211_minstrel_ht.h
index 7d6d0b720f6d..5912f7dc5267 100644
--- a/net/mac80211/rc80211_minstrel_ht.h
+++ b/net/mac80211/rc80211_minstrel_ht.h
@@ -6,6 +6,8 @@
 #ifndef __RC_MINSTREL_HT_H
 #define __RC_MINSTREL_HT_H
 
+#include <linux/bitfield.h>
+
 /* number of highest throughput rates to consider*/
 #define MAX_THR_RATES 4
 #define SAMPLE_COLUMNS	10	/* number of columns in sample table */
@@ -57,6 +59,17 @@
 
 #define MCS_GROUP_RATES		10
 
+#define MI_RATE_IDX_MASK	GENMASK(3, 0)
+#define MI_RATE_GROUP_MASK	GENMASK(15, 4)
+
+#define MI_RATE(_group, _idx)				\
+	(FIELD_PREP(MI_RATE_GROUP_MASK, _group) |	\
+	 FIELD_PREP(MI_RATE_IDX_MASK, _idx))
+
+#define MI_RATE_IDX(_rate) FIELD_GET(MI_RATE_IDX_MASK, _rate)
+#define MI_RATE_GROUP(_rate) FIELD_GET(MI_RATE_GROUP_MASK, _rate)
+
+
 struct minstrel_priv {
 	struct ieee80211_hw *hw;
 	bool has_mrr;
diff --git a/net/mac80211/rc80211_minstrel_ht_debugfs.c b/net/mac80211/rc80211_minstrel_ht_debugfs.c
index 3b7af242cde6..067d10383fa7 100644
--- a/net/mac80211/rc80211_minstrel_ht_debugfs.c
+++ b/net/mac80211/rc80211_minstrel_ht_debugfs.c
@@ -56,7 +56,7 @@ minstrel_ht_stats_dump(struct minstrel_ht_sta *mi, int i, char *p)
 
 	for (j = 0; j < MCS_GROUP_RATES; j++) {
 		struct minstrel_rate_stats *mrs = &mi->groups[i].rates[j];
-		int idx = i * MCS_GROUP_RATES + j;
+		int idx = MI_RATE(i, j);
 		unsigned int duration;
 
 		if (!(mi->supported[i] & BIT(j)))
@@ -201,7 +201,7 @@ minstrel_ht_stats_csv_dump(struct minstrel_ht_sta *mi, int i, char *p)
 
 	for (j = 0; j < MCS_GROUP_RATES; j++) {
 		struct minstrel_rate_stats *mrs = &mi->groups[i].rates[j];
-		int idx = i * MCS_GROUP_RATES + j;
+		int idx = MI_RATE(i, j);
 		unsigned int duration;
 
 		if (!(mi->supported[i] & BIT(j)))
-- 
2.28.0

