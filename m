Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43772E8C08
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Jan 2021 12:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbhACLxh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Jan 2021 06:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbhACLxg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Jan 2021 06:53:36 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E6DC061794
        for <linux-wireless@vger.kernel.org>; Sun,  3 Jan 2021 03:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ra/7qYAAMYOCPxDtf3cMLa0r8cjlTYiBAU3EkMz0ZlI=; b=o86KWk2kfg82XIwojXdjKF4xXO
        IzalurdD6rMa21CHMgFx/frMDeaj670qelWOaDaWfB7RI2cTxeaMuavyRwNW+EYsElJgRDd/wXu+P
        MCjuat4FpS2SJGn0pnlXVs8fkYskjQKmfdWK0juabLeV4Q8bH4p0n9g9+Ho/264lUQAs=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kw1vC-0000gv-6R; Sun, 03 Jan 2021 12:51:42 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH v2 2/8] mac80211: minstrel_ht: add support for OFDM rates on non-HT clients
Date:   Sun,  3 Jan 2021 12:51:34 +0100
Message-Id: <20210103115140.18614-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210103115140.18614-1-nbd@nbd.name>
References: <20210103115140.18614-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The legacy minstrel code is essentially unmaintained and receives only very
little testing. In order to bring the significant algorithm improvements from
minstrel_ht to legacy clients, this patch adds support for OFDM rates to
minstrel_ht and removes the fallback to the legacy codepath.
This also makes it work much better on hardware with rate selection constraints,
e.g. mt76.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rc80211_minstrel.h            |   1 +
 net/mac80211/rc80211_minstrel_ht.c         | 283 ++++++++++++++-------
 net/mac80211/rc80211_minstrel_ht.h         |  17 +-
 net/mac80211/rc80211_minstrel_ht_debugfs.c |  39 ++-
 4 files changed, 224 insertions(+), 116 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel.h b/net/mac80211/rc80211_minstrel.h
index 86cd80b3ffde..1b6d859a81e2 100644
--- a/net/mac80211/rc80211_minstrel.h
+++ b/net/mac80211/rc80211_minstrel.h
@@ -152,6 +152,7 @@ struct minstrel_priv {
 	unsigned int lookaround_rate_mrr;
 
 	u8 cck_rates[4];
+	u8 ofdm_rates[NUM_NL80211_BANDS][8];
 
 #ifdef CONFIG_MAC80211_DEBUGFS
 	/*
diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 167d4fa5adf1..247557bff26c 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -163,6 +163,38 @@
 
 #define CCK_GROUP __CCK_GROUP(CCK_GROUP_SHIFT)
 
+#define OFDM_DURATION(_bitrate)				\
+	(1000 * (16 /* SIFS + signal ext */ +		\
+	 16 /* T_PREAMBLE */ +				\
+	 4 /* T_SIGNAL */ +				\
+	 4 * (((16 + 80 * (AVG_PKT_SIZE + 4) + 6) /	\
+	      ((_bitrate) * 4)))))
+
+#define OFDM_DURATION_LIST(_s)				\
+	OFDM_DURATION(60) >> _s,			\
+	OFDM_DURATION(90) >> _s,			\
+	OFDM_DURATION(120) >> _s,			\
+	OFDM_DURATION(180) >> _s,			\
+	OFDM_DURATION(240) >> _s,			\
+	OFDM_DURATION(360) >> _s,			\
+	OFDM_DURATION(480) >> _s,			\
+	OFDM_DURATION(540) >> _s
+
+#define __OFDM_GROUP(_s)				\
+	[MINSTREL_OFDM_GROUP] = {			\
+		.streams = 1,				\
+		.flags = 0,				\
+		.shift = _s,				\
+		.duration = {				\
+			OFDM_DURATION_LIST(_s),		\
+		}					\
+	}
+
+#define OFDM_GROUP_SHIFT				\
+	GROUP_SHIFT(OFDM_DURATION(60))
+
+#define OFDM_GROUP __OFDM_GROUP(OFDM_GROUP_SHIFT)
+
 
 static bool minstrel_vht_only = true;
 module_param(minstrel_vht_only, bool, 0644);
@@ -199,6 +231,7 @@ const struct mcs_group minstrel_mcs_groups[] = {
 	MCS_GROUP(4, 1, BW_40),
 
 	CCK_GROUP,
+	OFDM_GROUP,
 
 	VHT_GROUP(1, 0, BW_20),
 	VHT_GROUP(2, 0, BW_20),
@@ -231,6 +264,8 @@ const struct mcs_group minstrel_mcs_groups[] = {
 	VHT_GROUP(4, 1, BW_80),
 };
 
+const s16 minstrel_cck_bitrates[4] = { 10, 20, 55, 110 };
+const s16 minstrel_ofdm_bitrates[8] = { 60, 90, 120, 180, 240, 360, 480, 540 };
 static u8 sample_table[SAMPLE_COLUMNS][MCS_GROUP_RATES] __read_mostly;
 
 static void
@@ -275,6 +310,13 @@ minstrel_get_valid_vht_rates(int bw, int nss, __le16 mcs_map)
 	return 0x3ff & ~mask;
 }
 
+static bool
+minstrel_ht_is_legacy_group(int group)
+{
+	return group == MINSTREL_CCK_GROUP ||
+	       group == MINSTREL_OFDM_GROUP;
+}
+
 /*
  * Look up an MCS group index based on mac80211 rate information
  */
@@ -304,21 +346,34 @@ minstrel_ht_get_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	if (rate->flags & IEEE80211_TX_RC_MCS) {
 		group = minstrel_ht_get_group_idx(rate);
 		idx = rate->idx % 8;
-	} else if (rate->flags & IEEE80211_TX_RC_VHT_MCS) {
+		goto out;
+	}
+
+	if (rate->flags & IEEE80211_TX_RC_VHT_MCS) {
 		group = minstrel_vht_get_group_idx(rate);
 		idx = ieee80211_rate_get_vht_mcs(rate);
-	} else {
-		group = MINSTREL_CCK_GROUP;
+		goto out;
+	}
 
-		for (idx = 0; idx < ARRAY_SIZE(mp->cck_rates); idx++)
-			if (rate->idx == mp->cck_rates[idx])
-				break;
+	group = MINSTREL_CCK_GROUP;
+	for (idx = 0; idx < ARRAY_SIZE(mp->cck_rates); idx++) {
+		if (rate->idx != mp->cck_rates[idx])
+			continue;
 
 		/* short preamble */
 		if ((mi->supported[group] & BIT(idx + 4)) &&
 		    (rate->flags & IEEE80211_TX_RC_USE_SHORT_PREAMBLE))
-			idx += 4;
+				idx += 4;
+		goto out;
 	}
+
+	group = MINSTREL_OFDM_GROUP;
+	for (idx = 0; idx < ARRAY_SIZE(mp->ofdm_rates[0]); idx++)
+		if (rate->idx == mp->ofdm_rates[mi->band][idx])
+			goto out;
+
+	idx = 0;
+out:
 	return &mi->groups[group].rates[idx];
 }
 
@@ -352,7 +407,7 @@ minstrel_ht_get_tp_avg(struct minstrel_ht_sta *mi, int group, int rate,
 	if (prob_avg < MINSTREL_FRAC(10, 100))
 		return 0;
 
-	if (group == MINSTREL_CCK_GROUP)
+	if (minstrel_ht_is_legacy_group(group))
 		overhead = mi->overhead_legacy;
 	else
 		ampdu_len = minstrel_ht_avg_ampdu_len(mi);
@@ -439,8 +494,8 @@ minstrel_ht_set_best_prob_rate(struct minstrel_ht_sta *mi, u16 index)
 	/* if max_tp_rate[0] is from MCS_GROUP max_prob_rate get selected from
 	 * MCS_GROUP as well as CCK_GROUP rates do not allow aggregation */
 	max_tp_group = mi->max_tp_rate[0] / MCS_GROUP_RATES;
-	if((index / MCS_GROUP_RATES == MINSTREL_CCK_GROUP) &&
-	    (max_tp_group != MINSTREL_CCK_GROUP))
+	if (minstrel_ht_is_legacy_group(index / MCS_GROUP_RATES) &&
+	    !minstrel_ht_is_legacy_group(max_tp_group))
 		return;
 
 	max_gpr_group = mg->max_group_prob_rate / MCS_GROUP_RATES;
@@ -476,13 +531,13 @@ minstrel_ht_set_best_prob_rate(struct minstrel_ht_sta *mi, u16 index)
 static void
 minstrel_ht_assign_best_tp_rates(struct minstrel_ht_sta *mi,
 				 u16 tmp_mcs_tp_rate[MAX_THR_RATES],
-				 u16 tmp_cck_tp_rate[MAX_THR_RATES])
+				 u16 tmp_legacy_tp_rate[MAX_THR_RATES])
 {
 	unsigned int tmp_group, tmp_idx, tmp_cck_tp, tmp_mcs_tp, tmp_prob;
 	int i;
 
-	tmp_group = tmp_cck_tp_rate[0] / MCS_GROUP_RATES;
-	tmp_idx = tmp_cck_tp_rate[0] % MCS_GROUP_RATES;
+	tmp_group = tmp_legacy_tp_rate[0] / MCS_GROUP_RATES;
+	tmp_idx = tmp_legacy_tp_rate[0] % MCS_GROUP_RATES;
 	tmp_prob = mi->groups[tmp_group].rates[tmp_idx].prob_avg;
 	tmp_cck_tp = minstrel_ht_get_tp_avg(mi, tmp_group, tmp_idx, tmp_prob);
 
@@ -493,7 +548,7 @@ minstrel_ht_assign_best_tp_rates(struct minstrel_ht_sta *mi,
 
 	if (tmp_cck_tp > tmp_mcs_tp) {
 		for(i = 0; i < MAX_THR_RATES; i++) {
-			minstrel_ht_sort_best_tp_rates(mi, tmp_cck_tp_rate[i],
+			minstrel_ht_sort_best_tp_rates(mi, tmp_legacy_tp_rate[i],
 						       tmp_mcs_tp_rate);
 		}
 	}
@@ -511,6 +566,9 @@ minstrel_ht_prob_rate_reduce_streams(struct minstrel_ht_sta *mi)
 	int tmp_max_streams, group, tmp_idx, tmp_prob;
 	int tmp_tp = 0;
 
+	if (!mi->sta->ht_cap.ht_supported)
+		return;
+
 	tmp_max_streams = minstrel_mcs_groups[mi->max_tp_rate[0] /
 			  MCS_GROUP_RATES].streams;
 	for (group = 0; group < ARRAY_SIZE(minstrel_mcs_groups); group++) {
@@ -675,7 +733,8 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	struct minstrel_rate_stats *mrs;
 	int group, i, j, cur_prob;
 	u16 tmp_mcs_tp_rate[MAX_THR_RATES], tmp_group_tp_rate[MAX_THR_RATES];
-	u16 tmp_cck_tp_rate[MAX_THR_RATES], index;
+	u16 tmp_legacy_tp_rate[MAX_THR_RATES], index;
+	bool ht_supported = mi->sta->ht_cap.ht_supported;
 
 	mi->sample_mode = MINSTREL_SAMPLE_IDLE;
 
@@ -704,21 +763,29 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	mi->sample_count = 0;
 
 	memset(tmp_mcs_tp_rate, 0, sizeof(tmp_mcs_tp_rate));
-	memset(tmp_cck_tp_rate, 0, sizeof(tmp_cck_tp_rate));
+	memset(tmp_legacy_tp_rate, 0, sizeof(tmp_legacy_tp_rate));
 	if (mi->supported[MINSTREL_CCK_GROUP])
-		for (j = 0; j < ARRAY_SIZE(tmp_cck_tp_rate); j++)
-			tmp_cck_tp_rate[j] = MINSTREL_CCK_GROUP * MCS_GROUP_RATES;
+		for (j = 0; j < ARRAY_SIZE(tmp_legacy_tp_rate); j++)
+			tmp_legacy_tp_rate[j] = MINSTREL_CCK_GROUP * MCS_GROUP_RATES;
+	else if (mi->supported[MINSTREL_OFDM_GROUP])
+		for (j = 0; j < ARRAY_SIZE(tmp_legacy_tp_rate); j++)
+			tmp_legacy_tp_rate[j] = MINSTREL_OFDM_GROUP * MCS_GROUP_RATES;
 
 	if (mi->supported[MINSTREL_VHT_GROUP_0])
 		index = MINSTREL_VHT_GROUP_0 * MCS_GROUP_RATES;
-	else
+	else if (ht_supported)
 		index = MINSTREL_HT_GROUP_0 * MCS_GROUP_RATES;
+	else if (mi->supported[MINSTREL_CCK_GROUP])
+		index = MINSTREL_CCK_GROUP * MCS_GROUP_RATES;
+	else
+		index = MINSTREL_OFDM_GROUP * MCS_GROUP_RATES;
 
 	for (j = 0; j < ARRAY_SIZE(tmp_mcs_tp_rate); j++)
 		tmp_mcs_tp_rate[j] = index;
 
 	/* Find best rate sets within all MCS groups*/
 	for (group = 0; group < ARRAY_SIZE(minstrel_mcs_groups); group++) {
+		u16 *tp_rate = tmp_mcs_tp_rate;
 
 		mg = &mi->groups[group];
 		if (!mi->supported[group])
@@ -730,6 +797,9 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 		for(j = 0; j < MAX_THR_RATES; j++)
 			tmp_group_tp_rate[j] = MCS_GROUP_RATES * group;
 
+		if (group == MINSTREL_CCK_GROUP && ht_supported)
+			tp_rate = tmp_legacy_tp_rate;
+
 		for (i = 0; i < MCS_GROUP_RATES; i++) {
 			if (!(mi->supported[group] & BIT(i)))
 				continue;
@@ -745,13 +815,7 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 				continue;
 
 			/* Find max throughput rate set */
-			if (group != MINSTREL_CCK_GROUP) {
-				minstrel_ht_sort_best_tp_rates(mi, index,
-							       tmp_mcs_tp_rate);
-			} else if (group == MINSTREL_CCK_GROUP) {
-				minstrel_ht_sort_best_tp_rates(mi, index,
-							       tmp_cck_tp_rate);
-			}
+			minstrel_ht_sort_best_tp_rates(mi, index, tp_rate);
 
 			/* Find max throughput rate set within a group */
 			minstrel_ht_sort_best_tp_rates(mi, index,
@@ -766,7 +830,8 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	}
 
 	/* Assign new rate set per sta */
-	minstrel_ht_assign_best_tp_rates(mi, tmp_mcs_tp_rate, tmp_cck_tp_rate);
+	minstrel_ht_assign_best_tp_rates(mi, tmp_mcs_tp_rate,
+					 tmp_legacy_tp_rate);
 	memcpy(mi->max_tp_rate, tmp_mcs_tp_rate, sizeof(mi->max_tp_rate));
 
 	/* Try to increase robustness of max_prob_rate*/
@@ -795,8 +860,11 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 }
 
 static bool
-minstrel_ht_txstat_valid(struct minstrel_priv *mp, struct ieee80211_tx_rate *rate)
+minstrel_ht_txstat_valid(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
+			 struct ieee80211_tx_rate *rate)
 {
+	int i;
+
 	if (rate->idx < 0)
 		return false;
 
@@ -807,10 +875,15 @@ minstrel_ht_txstat_valid(struct minstrel_priv *mp, struct ieee80211_tx_rate *rat
 	    rate->flags & IEEE80211_TX_RC_VHT_MCS)
 		return true;
 
-	return rate->idx == mp->cck_rates[0] ||
-	       rate->idx == mp->cck_rates[1] ||
-	       rate->idx == mp->cck_rates[2] ||
-	       rate->idx == mp->cck_rates[3];
+	for (i = 0; i < ARRAY_SIZE(mp->cck_rates); i++)
+		if (rate->idx == mp->cck_rates[i])
+			return true;
+
+	for (i = 0; i < ARRAY_SIZE(mp->ofdm_rates[0]); i++)
+		if (rate->idx == mp->ofdm_rates[mi->band][i])
+			return true;
+
+	return false;
 }
 
 static void
@@ -897,11 +970,6 @@ minstrel_ht_tx_status(void *priv, struct ieee80211_supported_band *sband,
 	bool sample_status = false;
 	int i;
 
-	if (!msp->is_ht)
-		return mac80211_minstrel.tx_status_ext(priv, sband,
-						       &msp->legacy, st);
-
-
 	/* This packet was aggregated but doesn't carry status info */
 	if ((info->flags & IEEE80211_TX_CTL_AMPDU) &&
 	    !(info->flags & IEEE80211_TX_STAT_AMPDU))
@@ -930,10 +998,10 @@ minstrel_ht_tx_status(void *priv, struct ieee80211_supported_band *sband,
 	if (mi->sample_mode != MINSTREL_SAMPLE_IDLE)
 		rate_sample = minstrel_get_ratestats(mi, mi->sample_rate);
 
-	last = !minstrel_ht_txstat_valid(mp, &ar[0]);
+	last = !minstrel_ht_txstat_valid(mp, mi, &ar[0]);
 	for (i = 0; !last; i++) {
 		last = (i == IEEE80211_TX_MAX_RATES - 1) ||
-		       !minstrel_ht_txstat_valid(mp, &ar[i + 1]);
+		       !minstrel_ht_txstat_valid(mp, mi, &ar[i + 1]);
 
 		rate = minstrel_ht_get_stats(mp, mi, &ar[i]);
 		if (rate == rate_sample)
@@ -1031,7 +1099,7 @@ minstrel_calc_retransmit(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	ctime += (t_slot * cw) >> 1;
 	cw = min((cw << 1) | 1, mp->cw_max);
 
-	if (index / MCS_GROUP_RATES == MINSTREL_CCK_GROUP) {
+	if (minstrel_ht_is_legacy_group(index / MCS_GROUP_RATES)) {
 		overhead = mi->overhead_legacy;
 		overhead_rtscts = mi->overhead_legacy_rtscts;
 	} else {
@@ -1064,7 +1132,8 @@ static void
 minstrel_ht_set_rate(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
                      struct ieee80211_sta_rates *ratetbl, int offset, int index)
 {
-	const struct mcs_group *group = &minstrel_mcs_groups[index / MCS_GROUP_RATES];
+	int group_idx = index / MCS_GROUP_RATES;
+	const struct mcs_group *group = &minstrel_mcs_groups[group_idx];
 	struct minstrel_rate_stats *mrs;
 	u8 idx;
 	u16 flags = group->flags;
@@ -1083,13 +1152,17 @@ minstrel_ht_set_rate(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 		ratetbl->rate[offset].count_rts = mrs->retry_count_rtscts;
 	}
 
-	if (index / MCS_GROUP_RATES == MINSTREL_CCK_GROUP)
+	index %= MCS_GROUP_RATES;
+	if (group_idx == MINSTREL_CCK_GROUP)
 		idx = mp->cck_rates[index % ARRAY_SIZE(mp->cck_rates)];
+	else if (group_idx == MINSTREL_OFDM_GROUP)
+		idx = mp->ofdm_rates[mi->band][index %
+					       ARRAY_SIZE(mp->ofdm_rates[0])];
 	else if (flags & IEEE80211_TX_RC_VHT_MCS)
 		idx = ((group->streams - 1) << 4) |
-		      ((index % MCS_GROUP_RATES) & 0xF);
+		      (index & 0xF);
 	else
-		idx = index % MCS_GROUP_RATES + (group->streams - 1) * 8;
+		idx = index + (group->streams - 1) * 8;
 
 	/* enable RTS/CTS if needed:
 	 *  - if station is in dynamic SMPS (and streams > 1)
@@ -1304,11 +1377,8 @@ minstrel_ht_get_rate(void *priv, struct ieee80211_sta *sta, void *priv_sta,
 	struct minstrel_priv *mp = priv;
 	int sample_idx;
 
-	if (!msp->is_ht)
-		return mac80211_minstrel.get_rate(priv, sta, &msp->legacy, txrc);
-
 	if (!(info->flags & IEEE80211_TX_CTL_AMPDU) &&
-	    mi->max_prob_rate / MCS_GROUP_RATES != MINSTREL_CCK_GROUP)
+	    !minstrel_ht_is_legacy_group(mi->max_prob_rate / MCS_GROUP_RATES))
 		minstrel_aggr_check(sta, txrc->skb);
 
 	info->flags |= mi->tx_flags;
@@ -1349,6 +1419,9 @@ minstrel_ht_get_rate(void *priv, struct ieee80211_sta *sta, void *priv_sta,
 	if (sample_group == &minstrel_mcs_groups[MINSTREL_CCK_GROUP]) {
 		int idx = sample_idx % ARRAY_SIZE(mp->cck_rates);
 		rate->idx = mp->cck_rates[idx];
+	} else if (sample_group == &minstrel_mcs_groups[MINSTREL_OFDM_GROUP]) {
+		int idx = sample_idx % ARRAY_SIZE(mp->ofdm_rates[0]);
+		rate->idx = mp->ofdm_rates[mi->band][idx];
 	} else if (sample_group->flags & IEEE80211_TX_RC_VHT_MCS) {
 		ieee80211_rate_set_vht(rate, sample_idx % MCS_GROUP_RATES,
 				       sample_group->streams);
@@ -1369,11 +1442,13 @@ minstrel_ht_update_cck(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	if (sband->band != NL80211_BAND_2GHZ)
 		return;
 
-	if (!ieee80211_hw_check(mp->hw, SUPPORTS_HT_CCK_RATES))
+	if (sta->ht_cap.ht_supported &&
+	    !ieee80211_hw_check(mp->hw, SUPPORTS_HT_CCK_RATES))
 		return;
 
 	for (i = 0; i < 4; i++) {
-		if (!rate_supported(sta, sband->band, mp->cck_rates[i]))
+		if (mp->cck_rates[i] == 0xff ||
+		    !rate_supported(sta, sband->band, mp->cck_rates[i]))
 			continue;
 
 		mi->supported[MINSTREL_CCK_GROUP] |= BIT(i);
@@ -1382,10 +1457,31 @@ minstrel_ht_update_cck(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	}
 }
 
+static void
+minstrel_ht_update_ofdm(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
+			struct ieee80211_supported_band *sband,
+			struct ieee80211_sta *sta)
+{
+	const u8 *rates;
+	int i;
+
+	if (sta->ht_cap.ht_supported)
+		return;
+
+	rates = mp->ofdm_rates[sband->band];
+	for (i = 0; i < ARRAY_SIZE(mp->ofdm_rates[0]); i++) {
+		if (rates[i] == 0xff ||
+		    !rate_supported(sta, sband->band, rates[i]))
+			continue;
+
+		mi->supported[MINSTREL_OFDM_GROUP] |= BIT(i);
+	}
+}
+
 static void
 minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 			struct cfg80211_chan_def *chandef,
-                        struct ieee80211_sta *sta, void *priv_sta)
+			struct ieee80211_sta *sta, void *priv_sta)
 {
 	struct minstrel_priv *mp = priv;
 	struct minstrel_ht_sta_priv *msp = priv_sta;
@@ -1401,10 +1497,6 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 	int stbc;
 	int i;
 
-	/* fall back to the old minstrel for legacy stations */
-	if (!sta->ht_cap.ht_supported)
-		goto use_legacy;
-
 	BUILD_BUG_ON(ARRAY_SIZE(minstrel_mcs_groups) != MINSTREL_GROUPS_NB);
 
 	if (vht_cap->vht_supported)
@@ -1412,10 +1504,10 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 	else
 		use_vht = 0;
 
-	msp->is_ht = true;
 	memset(mi, 0, sizeof(*mi));
 
 	mi->sta = sta;
+	mi->band = sband->band;
 	mi->last_stats_update = jiffies;
 
 	ack_dur = ieee80211_frame_duration(sband->band, 10, 60, 1, 1, 0);
@@ -1464,10 +1556,8 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 		int bw, nss;
 
 		mi->supported[i] = 0;
-		if (i == MINSTREL_CCK_GROUP) {
-			minstrel_ht_update_cck(mp, mi, sband, sta);
+		if (minstrel_ht_is_legacy_group(i))
 			continue;
-		}
 
 		if (gflags & IEEE80211_TX_RC_SHORT_GI) {
 			if (gflags & IEEE80211_TX_RC_40_MHZ_WIDTH) {
@@ -1528,22 +1618,12 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 			n_supported++;
 	}
 
-	if (!n_supported)
-		goto use_legacy;
+	minstrel_ht_update_cck(mp, mi, sband, sta);
+	minstrel_ht_update_ofdm(mp, mi, sband, sta);
 
 	/* create an initial rate table with the lowest supported rates */
 	minstrel_ht_update_stats(mp, mi, true);
 	minstrel_ht_update_rates(mp, mi);
-
-	return;
-
-use_legacy:
-	msp->is_ht = false;
-	memset(&msp->legacy, 0, sizeof(msp->legacy));
-	msp->legacy.r = msp->ratelist;
-	msp->legacy.sample_table = msp->sample_table;
-	return mac80211_minstrel.rate_init(priv, sband, chandef, sta,
-					   &msp->legacy);
 }
 
 static void
@@ -1611,40 +1691,70 @@ minstrel_ht_free_sta(void *priv, struct ieee80211_sta *sta, void *priv_sta)
 }
 
 static void
-minstrel_ht_init_cck_rates(struct minstrel_priv *mp)
+minstrel_ht_fill_rate_array(u8 *dest, struct ieee80211_supported_band *sband,
+			    const s16 *bitrates, int n_rates, u32 rate_flags)
 {
-	static const int bitrates[4] = { 10, 20, 55, 110 };
-	struct ieee80211_supported_band *sband;
-	u32 rate_flags = ieee80211_chandef_rate_flags(&mp->hw->conf.chandef);
 	int i, j;
 
-	sband = mp->hw->wiphy->bands[NL80211_BAND_2GHZ];
-	if (!sband)
-		return;
-
 	for (i = 0; i < sband->n_bitrates; i++) {
 		struct ieee80211_rate *rate = &sband->bitrates[i];
 
-		if (rate->flags & IEEE80211_RATE_ERP_G)
-			continue;
-
 		if ((rate_flags & sband->bitrates[i].flags) != rate_flags)
 			continue;
 
-		for (j = 0; j < ARRAY_SIZE(bitrates); j++) {
+		for (j = 0; j < n_rates; j++) {
 			if (rate->bitrate != bitrates[j])
 				continue;
 
-			mp->cck_rates[j] = i;
+			dest[j] = i;
 			break;
 		}
 	}
 }
 
+static void
+minstrel_ht_init_cck_rates(struct minstrel_priv *mp)
+{
+	static const s16 bitrates[4] = { 10, 20, 55, 110 };
+	struct ieee80211_supported_band *sband;
+	u32 rate_flags = ieee80211_chandef_rate_flags(&mp->hw->conf.chandef);
+
+	memset(mp->cck_rates, 0xff, sizeof(mp->cck_rates));
+	sband = mp->hw->wiphy->bands[NL80211_BAND_2GHZ];
+	if (!sband)
+		return;
+
+	BUILD_BUG_ON(ARRAY_SIZE(mp->cck_rates) != ARRAY_SIZE(bitrates));
+	minstrel_ht_fill_rate_array(mp->cck_rates, sband,
+				    minstrel_cck_bitrates,
+				    ARRAY_SIZE(minstrel_cck_bitrates),
+				    rate_flags);
+}
+
+static void
+minstrel_ht_init_ofdm_rates(struct minstrel_priv *mp, enum nl80211_band band)
+{
+	static const s16 bitrates[8] = { 60, 90, 120, 180, 240, 360, 480, 540 };
+	struct ieee80211_supported_band *sband;
+	u32 rate_flags = ieee80211_chandef_rate_flags(&mp->hw->conf.chandef);
+
+	memset(mp->ofdm_rates[band], 0xff, sizeof(mp->ofdm_rates[band]));
+	sband = mp->hw->wiphy->bands[band];
+	if (!sband)
+		return;
+
+	BUILD_BUG_ON(ARRAY_SIZE(mp->ofdm_rates[band]) != ARRAY_SIZE(bitrates));
+	minstrel_ht_fill_rate_array(mp->ofdm_rates[band], sband,
+				    minstrel_ofdm_bitrates,
+				    ARRAY_SIZE(minstrel_ofdm_bitrates),
+				    rate_flags);
+}
+
 static void *
 minstrel_ht_alloc(struct ieee80211_hw *hw)
 {
 	struct minstrel_priv *mp;
+	int i;
 
 	mp = kzalloc(sizeof(struct minstrel_priv), GFP_ATOMIC);
 	if (!mp)
@@ -1681,6 +1791,8 @@ minstrel_ht_alloc(struct ieee80211_hw *hw)
 	mp->new_avg = true;
 
 	minstrel_ht_init_cck_rates(mp);
+	for (i = 0; i < ARRAY_SIZE(mp->hw->wiphy->bands); i++)
+	    minstrel_ht_init_ofdm_rates(mp, i);
 
 	return mp;
 }
@@ -1713,9 +1825,6 @@ static u32 minstrel_ht_get_expected_throughput(void *priv_sta)
 	struct minstrel_ht_sta *mi = &msp->ht;
 	int i, j, prob, tp_avg;
 
-	if (!msp->is_ht)
-		return mac80211_minstrel.get_expected_throughput(priv_sta);
-
 	i = mi->max_tp_rate[0] / MCS_GROUP_RATES;
 	j = mi->max_tp_rate[0] % MCS_GROUP_RATES;
 	prob = mi->groups[i].rates[j].prob_avg;
diff --git a/net/mac80211/rc80211_minstrel_ht.h b/net/mac80211/rc80211_minstrel_ht.h
index 11300fa48a2f..3321630ebeea 100644
--- a/net/mac80211/rc80211_minstrel_ht.h
+++ b/net/mac80211/rc80211_minstrel_ht.h
@@ -18,14 +18,15 @@
 				 MINSTREL_HT_STREAM_GROUPS)
 #define MINSTREL_VHT_GROUPS_NB	(MINSTREL_MAX_STREAMS *		\
 				 MINSTREL_VHT_STREAM_GROUPS)
-#define MINSTREL_CCK_GROUPS_NB	1
+#define MINSTREL_LEGACY_GROUPS_NB	2
 #define MINSTREL_GROUPS_NB	(MINSTREL_HT_GROUPS_NB +	\
 				 MINSTREL_VHT_GROUPS_NB +	\
-				 MINSTREL_CCK_GROUPS_NB)
+				 MINSTREL_LEGACY_GROUPS_NB)
 
 #define MINSTREL_HT_GROUP_0	0
 #define MINSTREL_CCK_GROUP	(MINSTREL_HT_GROUP_0 + MINSTREL_HT_GROUPS_NB)
-#define MINSTREL_VHT_GROUP_0	(MINSTREL_CCK_GROUP + 1)
+#define MINSTREL_OFDM_GROUP	(MINSTREL_CCK_GROUP + 1)
+#define MINSTREL_VHT_GROUP_0	(MINSTREL_OFDM_GROUP + 1)
 
 #define MCS_GROUP_RATES		10
 
@@ -37,6 +38,8 @@ struct mcs_group {
 	u16 duration[MCS_GROUP_RATES];
 };
 
+extern const s16 minstrel_cck_bitrates[4];
+extern const s16 minstrel_ofdm_bitrates[8];
 extern const struct mcs_group minstrel_mcs_groups[];
 
 struct minstrel_mcs_group_data {
@@ -99,6 +102,8 @@ struct minstrel_ht_sta {
 	/* current MCS group to be sampled */
 	u8 sample_group;
 
+	u8 band;
+
 	/* Bitfield of supported MCS rates of all groups */
 	u16 supported[MINSTREL_GROUPS_NB];
 
@@ -107,13 +112,9 @@ struct minstrel_ht_sta {
 };
 
 struct minstrel_ht_sta_priv {
-	union {
-		struct minstrel_ht_sta ht;
-		struct minstrel_sta_info legacy;
-	};
+	struct minstrel_ht_sta ht;
 	void *ratelist;
 	void *sample_table;
-	bool is_ht;
 };
 
 void minstrel_ht_add_sta_debugfs(void *priv, void *priv_sta, struct dentry *dir);
diff --git a/net/mac80211/rc80211_minstrel_ht_debugfs.c b/net/mac80211/rc80211_minstrel_ht_debugfs.c
index bebb71917742..75ecc3318b50 100644
--- a/net/mac80211/rc80211_minstrel_ht_debugfs.c
+++ b/net/mac80211/rc80211_minstrel_ht_debugfs.c
@@ -52,7 +52,6 @@ minstrel_ht_stats_dump(struct minstrel_ht_sta *mi, int i, char *p)
 
 	for (j = 0; j < MCS_GROUP_RATES; j++) {
 		struct minstrel_rate_stats *mrs = &mi->groups[i].rates[j];
-		static const int bitrates[4] = { 10, 20, 55, 110 };
 		int idx = i * MCS_GROUP_RATES + j;
 		unsigned int duration;
 
@@ -67,6 +66,9 @@ minstrel_ht_stats_dump(struct minstrel_ht_sta *mi, int i, char *p)
 			p += sprintf(p, "VHT%c0 ", htmode);
 			p += sprintf(p, "%cGI ", gimode);
 			p += sprintf(p, "%d  ", mg->streams);
+		} else if (i == MINSTREL_OFDM_GROUP) {
+			p += sprintf(p, "OFDM       ");
+			p += sprintf(p, "1 ");
 		} else {
 			p += sprintf(p, "CCK    ");
 			p += sprintf(p, "%cP  ", j < 4 ? 'L' : 'S');
@@ -84,7 +86,12 @@ minstrel_ht_stats_dump(struct minstrel_ht_sta *mi, int i, char *p)
 		} else if (gflags & IEEE80211_TX_RC_VHT_MCS) {
 			p += sprintf(p, "  MCS%-1u/%1u", j, mg->streams);
 		} else {
-			int r = bitrates[j % 4];
+			int r;
+
+			if (i == MINSTREL_OFDM_GROUP)
+				r = minstrel_ofdm_bitrates[j % 8];
+			else
+				r = minstrel_cck_bitrates[j % 4];
 
 			p += sprintf(p, "   %2u.%1uM", r / 10, r % 10);
 		}
@@ -124,16 +131,8 @@ minstrel_ht_stats_open(struct inode *inode, struct file *file)
 	struct minstrel_ht_sta *mi = &msp->ht;
 	struct minstrel_debugfs_info *ms;
 	unsigned int i;
-	int ret;
 	char *p;
 
-	if (!msp->is_ht) {
-		inode->i_private = &msp->legacy;
-		ret = minstrel_stats_open(inode, file);
-		inode->i_private = msp;
-		return ret;
-	}
-
 	ms = kmalloc(32768, GFP_KERNEL);
 	if (!ms)
 		return -ENOMEM;
@@ -199,7 +198,6 @@ minstrel_ht_stats_csv_dump(struct minstrel_ht_sta *mi, int i, char *p)
 
 	for (j = 0; j < MCS_GROUP_RATES; j++) {
 		struct minstrel_rate_stats *mrs = &mi->groups[i].rates[j];
-		static const int bitrates[4] = { 10, 20, 55, 110 };
 		int idx = i * MCS_GROUP_RATES + j;
 		unsigned int duration;
 
@@ -214,6 +212,8 @@ minstrel_ht_stats_csv_dump(struct minstrel_ht_sta *mi, int i, char *p)
 			p += sprintf(p, "VHT%c0,", htmode);
 			p += sprintf(p, "%cGI,", gimode);
 			p += sprintf(p, "%d,", mg->streams);
+		} else if (i == MINSTREL_OFDM_GROUP) {
+			p += sprintf(p, "OFDM,,1,");
 		} else {
 			p += sprintf(p, "CCK,");
 			p += sprintf(p, "%cP,", j < 4 ? 'L' : 'S');
@@ -231,7 +231,13 @@ minstrel_ht_stats_csv_dump(struct minstrel_ht_sta *mi, int i, char *p)
 		} else if (gflags & IEEE80211_TX_RC_VHT_MCS) {
 			p += sprintf(p, ",MCS%-1u/%1u,", j, mg->streams);
 		} else {
-			int r = bitrates[j % 4];
+			int r;
+
+			if (i == MINSTREL_OFDM_GROUP)
+				r = minstrel_ofdm_bitrates[j % 8];
+			else
+				r = minstrel_cck_bitrates[j % 4];
+
 			p += sprintf(p, ",%2u.%1uM,", r / 10, r % 10);
 		}
 
@@ -274,18 +280,9 @@ minstrel_ht_stats_csv_open(struct inode *inode, struct file *file)
 	struct minstrel_ht_sta *mi = &msp->ht;
 	struct minstrel_debugfs_info *ms;
 	unsigned int i;
-	int ret;
 	char *p;
 
-	if (!msp->is_ht) {
-		inode->i_private = &msp->legacy;
-		ret = minstrel_stats_csv_open(inode, file);
-		inode->i_private = msp;
-		return ret;
-	}
-
 	ms = kmalloc(32768, GFP_KERNEL);
-
 	if (!ms)
 		return -ENOMEM;
 
-- 
2.28.0

