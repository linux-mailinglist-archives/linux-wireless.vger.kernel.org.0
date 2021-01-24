Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A955B301BD9
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Jan 2021 13:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbhAXM3P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Jan 2021 07:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbhAXM3N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Jan 2021 07:29:13 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2785DC061786
        for <linux-wireless@vger.kernel.org>; Sun, 24 Jan 2021 04:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8nToZNMSa2XbIwkJ3WZJMcL4hdq4XEq1N5xuZLgrFg0=; b=p3Gn4YGbeKwqUF7mwpB/KWhg6f
        oH0NYwrHvG0+6qE/7P/00lFr81nIG0tLKovhjto4rBvhyO6OGG+j2VtDSAHs1bD4qM3EOmf8e2rO0
        rJ//wzVd/I5TQyObF5USytBPmrQVnQtBEDhC1l7VFdnuNQHwVmtrFlYkT4uk7QFwEoEI=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l3eV4-00074g-S1; Sun, 24 Jan 2021 13:28:14 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 6/6] mac80211: minstrel_ht: remove sample rate switching code for constrained devices
Date:   Sun, 24 Jan 2021 13:28:12 +0100
Message-Id: <20210124122812.49929-6-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210124122812.49929-1-nbd@nbd.name>
References: <20210124122812.49929-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This was added to mitigate the effects of too much sampling on devices that
use a static global fallback table instead of configurable multi-rate retry.
Now that the sampling algorithm is improved, this code path no longer performs
any better than the standard probing on affected devices.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rc80211_minstrel_ht.c | 95 ++----------------------------
 net/mac80211/rc80211_minstrel_ht.h | 17 +-----
 2 files changed, 9 insertions(+), 103 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 95e10c4b1539..8e9e30c468a6 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -648,27 +648,6 @@ __minstrel_ht_get_sample_rate(struct minstrel_ht_sta *mi,
 	return 0;
 }
 
-static void
-minstrel_ht_rate_sample_switch(struct minstrel_priv *mp,
-			       struct minstrel_ht_sta *mi)
-{
-	u16 rate;
-
-	/*
-	 * Use rate switching instead of probing packets for devices with
-	 * little control over retry fallback behavior
-	 */
-	if (mp->hw->max_rates > 1)
-		return;
-
-	rate = __minstrel_ht_get_sample_rate(mi, MINSTREL_SAMPLE_TYPE_INC);
-	if (!rate)
-		return;
-
-	mi->sample_rate = rate;
-	mi->sample_mode = MINSTREL_SAMPLE_ACTIVE;
-}
-
 static inline int
 minstrel_ewma(int old, int new, int weight)
 {
@@ -1012,8 +991,7 @@ minstrel_ht_refill_sample_rates(struct minstrel_ht_sta *mi)
  *    higher throughput rates, even if the probablity is a bit lower
  */
 static void
-minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
-			 bool sample)
+minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi)
 {
 	struct minstrel_mcs_group_data *mg;
 	struct minstrel_rate_stats *mrs;
@@ -1023,18 +1001,6 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	u16 index;
 	bool ht_supported = mi->sta->ht_cap.ht_supported;
 
-	mi->sample_mode = MINSTREL_SAMPLE_IDLE;
-
-	if (sample) {
-		mi->total_packets_cur = mi->total_packets -
-					mi->total_packets_last;
-		mi->total_packets_last = mi->total_packets;
-	}
-	if (!mp->sample_switch)
-		sample = false;
-	if (mi->total_packets_cur < SAMPLE_SWITCH_THR && mp->sample_switch != 1)
-	    sample = false;
-
 	if (mi->ampdu_packets > 0) {
 		if (!ieee80211_hw_check(mp->hw, TX_STATUS_NO_AMPDU_LEN))
 			mi->avg_ampdu_len = minstrel_ewma(mi->avg_ampdu_len,
@@ -1149,16 +1115,12 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	minstrel_ht_prob_rate_reduce_streams(mi);
 	minstrel_ht_refill_sample_rates(mi);
 
-	if (sample)
-		minstrel_ht_rate_sample_switch(mp, mi);
-
 #ifdef CONFIG_MAC80211_DEBUGFS
 	/* use fixed index if set */
 	if (mp->fixed_rate_idx != -1) {
 		for (i = 0; i < 4; i++)
 			mi->max_tp_rate[i] = mp->fixed_rate_idx;
 		mi->max_prob_rate = mp->fixed_rate_idx;
-		mi->sample_mode = MINSTREL_SAMPLE_IDLE;
 	}
 #endif
 
@@ -1248,11 +1210,10 @@ minstrel_ht_tx_status(void *priv, struct ieee80211_supported_band *sband,
 	struct ieee80211_tx_info *info = st->info;
 	struct minstrel_ht_sta *mi = priv_sta;
 	struct ieee80211_tx_rate *ar = info->status.rates;
-	struct minstrel_rate_stats *rate, *rate2, *rate_sample = NULL;
+	struct minstrel_rate_stats *rate, *rate2;
 	struct minstrel_priv *mp = priv;
 	u32 update_interval = mp->update_interval;
 	bool last, update = false;
-	bool sample_status = false;
 	int i;
 
 	/* This packet was aggregated but doesn't carry status info */
@@ -1279,49 +1240,18 @@ minstrel_ht_tx_status(void *priv, struct ieee80211_supported_band *sband,
 	mi->ampdu_packets++;
 	mi->ampdu_len += info->status.ampdu_len;
 
-	if (mi->sample_mode != MINSTREL_SAMPLE_IDLE)
-		rate_sample = minstrel_get_ratestats(mi, mi->sample_rate);
-
 	last = !minstrel_ht_txstat_valid(mp, mi, &ar[0]);
 	for (i = 0; !last; i++) {
 		last = (i == IEEE80211_TX_MAX_RATES - 1) ||
 		       !minstrel_ht_txstat_valid(mp, mi, &ar[i + 1]);
 
 		rate = minstrel_ht_get_stats(mp, mi, &ar[i]);
-		if (rate == rate_sample)
-			sample_status = true;
-
 		if (last)
 			rate->success += info->status.ampdu_ack_len;
 
 		rate->attempts += ar[i].count * info->status.ampdu_len;
 	}
 
-	switch (mi->sample_mode) {
-	case MINSTREL_SAMPLE_IDLE:
-		if (mp->hw->max_rates > 1 ||
-		     mi->total_packets_cur < SAMPLE_SWITCH_THR)
-			update_interval /= 2;
-		break;
-
-	case MINSTREL_SAMPLE_ACTIVE:
-		if (!sample_status)
-			break;
-
-		mi->sample_mode = MINSTREL_SAMPLE_PENDING;
-		update = true;
-		break;
-
-	case MINSTREL_SAMPLE_PENDING:
-		if (sample_status)
-			break;
-
-		update = true;
-		minstrel_ht_update_stats(mp, mi, false);
-		break;
-	}
-
-
 	if (mp->hw->max_rates > 1) {
 		/*
 		 * check for sudden death of spatial multiplexing,
@@ -1344,7 +1274,7 @@ minstrel_ht_tx_status(void *priv, struct ieee80211_supported_band *sband,
 
 	if (time_after(jiffies, mi->last_stats_update + update_interval)) {
 		update = true;
-		minstrel_ht_update_stats(mp, mi, true);
+		minstrel_ht_update_stats(mp, mi);
 	}
 
 	if (update)
@@ -1523,18 +1453,14 @@ static void
 minstrel_ht_update_rates(struct minstrel_priv *mp, struct minstrel_ht_sta *mi)
 {
 	struct ieee80211_sta_rates *rates;
-	u16 first_rate = mi->max_tp_rate[0];
 	int i = 0;
 
-	if (mi->sample_mode == MINSTREL_SAMPLE_ACTIVE)
-		first_rate = mi->sample_rate;
-
 	rates = kzalloc(sizeof(*rates), GFP_ATOMIC);
 	if (!rates)
 		return;
 
 	/* Start with max_tp_rate[0] */
-	minstrel_ht_set_rate(mp, mi, rates, i++, first_rate);
+	minstrel_ht_set_rate(mp, mi, rates, i++, mi->max_tp_rate[0]);
 
 	if (mp->hw->max_rates >= 3) {
 		/* At least 3 tx rates supported, use max_tp_rate[1] next */
@@ -1593,11 +1519,6 @@ minstrel_ht_get_rate(void *priv, struct ieee80211_sta *sta, void *priv_sta,
 	    (info->control.flags & IEEE80211_TX_CTRL_PORT_CTRL_PROTO))
 		return;
 
-	if (mp->hw->max_rates == 1 && mp->sample_switch &&
-	    (mi->total_packets_cur >= SAMPLE_SWITCH_THR ||
-	     mp->sample_switch == 1))
-		return;
-
 	if (time_is_before_jiffies(mi->sample_time))
 		return;
 
@@ -1811,7 +1732,7 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 	minstrel_ht_update_ofdm(mp, mi, sband, sta);
 
 	/* create an initial rate table with the lowest supported rates */
-	minstrel_ht_update_stats(mp, mi, true);
+	minstrel_ht_update_stats(mp, mi);
 	minstrel_ht_update_rates(mp, mi);
 }
 
@@ -1927,8 +1848,6 @@ minstrel_ht_alloc(struct ieee80211_hw *hw)
 	if (!mp)
 		return NULL;
 
-	mp->sample_switch = -1;
-
 	/* contention window settings
 	 * Just an approximation. Using the per-queue values would complicate
 	 * the calculations and is probably unnecessary */
@@ -1948,7 +1867,7 @@ minstrel_ht_alloc(struct ieee80211_hw *hw)
 		mp->has_mrr = true;
 
 	mp->hw = hw;
-	mp->update_interval = HZ / 10;
+	mp->update_interval = HZ / 20;
 
 	minstrel_ht_init_cck_rates(mp);
 	for (i = 0; i < ARRAY_SIZE(mp->hw->wiphy->bands); i++)
@@ -1966,8 +1885,6 @@ static void minstrel_ht_add_debugfs(struct ieee80211_hw *hw, void *priv,
 	mp->fixed_rate_idx = (u32) -1;
 	debugfs_create_u32("fixed_rate_idx", S_IRUGO | S_IWUGO, debugfsdir,
 			   &mp->fixed_rate_idx);
-	debugfs_create_u32("sample_switch", S_IRUGO | S_IWUSR, debugfsdir,
-			   &mp->sample_switch);
 }
 #endif
 
diff --git a/net/mac80211/rc80211_minstrel_ht.h b/net/mac80211/rc80211_minstrel_ht.h
index 0d8c15f83f5d..06e7126727ad 100644
--- a/net/mac80211/rc80211_minstrel_ht.h
+++ b/net/mac80211/rc80211_minstrel_ht.h
@@ -75,7 +75,6 @@
 struct minstrel_priv {
 	struct ieee80211_hw *hw;
 	bool has_mrr;
-	u32 sample_switch;
 	unsigned int cw_min;
 	unsigned int cw_max;
 	unsigned int max_retry;
@@ -147,12 +146,6 @@ struct minstrel_mcs_group_data {
 	struct minstrel_rate_stats rates[MCS_GROUP_RATES];
 };
 
-enum minstrel_sample_mode {
-	MINSTREL_SAMPLE_IDLE,
-	MINSTREL_SAMPLE_ACTIVE,
-	MINSTREL_SAMPLE_PENDING,
-};
-
 struct minstrel_sample_category {
 	u8 sample_group;
 	u16 sample_rates[MINSTREL_SAMPLE_RATES];
@@ -182,23 +175,19 @@ struct minstrel_ht_sta {
 	unsigned int overhead_legacy;
 	unsigned int overhead_legacy_rtscts;
 
-	unsigned int total_packets_last;
-	unsigned int total_packets_cur;
 	unsigned int total_packets;
 	unsigned int sample_packets;
 
 	/* tx flags to add for frames for this sta */
 	u32 tx_flags;
 
-	unsigned long sample_time;
-	struct minstrel_sample_category sample[__MINSTREL_SAMPLE_TYPE_MAX];
+	u8 band;
 
 	u8 sample_seq;
-
-	enum minstrel_sample_mode sample_mode;
 	u16 sample_rate;
 
-	u8 band;
+	unsigned long sample_time;
+	struct minstrel_sample_category sample[__MINSTREL_SAMPLE_TYPE_MAX];
 
 	/* Bitfield of supported MCS rates of all groups */
 	u16 supported[MINSTREL_GROUPS_NB];
-- 
2.28.0

