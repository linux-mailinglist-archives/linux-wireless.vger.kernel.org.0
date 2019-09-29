Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70A7CC15FC
	for <lists+linux-wireless@lfdr.de>; Sun, 29 Sep 2019 17:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfI2Pqu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 29 Sep 2019 11:46:50 -0400
Received: from nbd.name ([46.4.11.11]:60948 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbfI2Pqt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 29 Sep 2019 11:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vzLSf4W2MqnvawZrbXtDcln1Ee/fJfkKoDrNmGwnYEQ=; b=tAszpfHHBn5Wyz0rCVlFduj8Zb
        epwUsFr5bxyureCSgIIMBRm3icqVPkhnDrNZUPVpVMd6h3/jNJEcSuMHhQ6sUAmGHLAmgIScvmDZo
        RJeYbjqgtrwxcfHXiQvGcovP1+/x5f1uGmr8WvEpEQkG50ZyVm9TgxxV/mIxo+GycyoM=;
Received: from p5b20652d.dip0.t-ipconnect.de ([91.32.101.45] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iEbPL-0002oR-EE; Sun, 29 Sep 2019 17:46:48 +0200
Received: by maeck.lan (Postfix, from userid 501)
        id 49D2C69F6069; Sun, 29 Sep 2019 17:46:46 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 2/2] mac80211: minstrel_ht: replace rate stats ewma with a better moving average
Date:   Sun, 29 Sep 2019 17:46:46 +0200
Message-Id: <20190929154646.90901-2-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190929154646.90901-1-nbd@nbd.name>
References: <20190929154646.90901-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rate success probability usually fluctuates a lot under normal conditions.
With a simple EWMA, noise and fluctuation can be reduced by increasing the
window length, but that comes at the cost of introducing lag on sudden
changes.

This change replaces the EWMA implementation with a moving average that's
designed to significantly reduce lag while keeping a bigger window size
by being better at filtering out noise.

It is only slightly more expensive than the simple EWMA and still avoids
divisions in its calculation.

The algorithm is adapted from an implementation intended for a completely
different field (stock market trading), where the tradeoff of lag vs
noise filtering is equally important. It is based on the "smoothing filter"
from http://www.stockspotter.com/files/PredictiveIndicators.pdf.

I have adapted it to fixed-point math with some constants so that it uses
only addition, bit shifts and multiplication

To better make use of the filtering and bigger window size, the update
interval time is cut in half.

For testing, the algorithm can be reverted to the older one via debugfs

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rc80211_minstrel.c    | 13 ++++---
 net/mac80211/rc80211_minstrel.h    | 57 +++++++++++++++++++++++++++++-
 net/mac80211/rc80211_minstrel_ht.c | 15 ++++++--
 3 files changed, 77 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel.c b/net/mac80211/rc80211_minstrel.c
index f73017e08111..d9b7bc7fdb33 100644
--- a/net/mac80211/rc80211_minstrel.c
+++ b/net/mac80211/rc80211_minstrel.c
@@ -157,14 +157,18 @@ minstrel_update_rates(struct minstrel_priv *mp, struct minstrel_sta_info *mi)
 * Recalculate statistics and counters of a given rate
 */
 void
-minstrel_calc_rate_stats(struct minstrel_rate_stats *mrs)
+minstrel_calc_rate_stats(struct minstrel_priv *mp,
+			 struct minstrel_rate_stats *mrs)
 {
 	unsigned int cur_prob;
 
 	if (unlikely(mrs->attempts > 0)) {
 		mrs->sample_skipped = 0;
 		cur_prob = MINSTREL_FRAC(mrs->success, mrs->attempts);
-		if (unlikely(!mrs->att_hist)) {
+		if (mp->new_avg) {
+			mrs->prob_ewma = minstrel_filter_avg_add(&mrs->avg,
+								 cur_prob);
+		} else if (unlikely(!mrs->att_hist)) {
 			mrs->prob_ewma = cur_prob;
 		} else {
 			/*update exponential weighted moving avarage */
@@ -200,7 +204,7 @@ minstrel_update_stats(struct minstrel_priv *mp, struct minstrel_sta_info *mi)
 		struct minstrel_rate_stats *tmp_mrs = &mi->r[tmp_prob_rate].stats;
 
 		/* Update statistics of success probability per rate */
-		minstrel_calc_rate_stats(mrs);
+		minstrel_calc_rate_stats(mp, mrs);
 
 		/* Sample less often below the 10% chance of success.
 		 * Sample less often above the 95% chance of success. */
@@ -289,7 +293,8 @@ minstrel_tx_status(void *priv, struct ieee80211_supported_band *sband,
 	if (mi->sample_deferred > 0)
 		mi->sample_deferred--;
 
-	if (time_after(jiffies, mi->last_stats_update + mp->update_interval))
+	if (time_after(jiffies, mi->last_stats_update +
+				mp->update_interval / (mp->new_avg ? 2 : 1)))
 		minstrel_update_stats(mp, mi);
 }
 
diff --git a/net/mac80211/rc80211_minstrel.h b/net/mac80211/rc80211_minstrel.h
index 51d8b2c846e7..360134848520 100644
--- a/net/mac80211/rc80211_minstrel.h
+++ b/net/mac80211/rc80211_minstrel.h
@@ -18,6 +18,19 @@
 /* number of highest throughput rates to consider*/
 #define MAX_THR_RATES 4
 
+/*
+ * Coefficients for moving average with noise filter (period=16),
+ * scaled by 10 bits
+ *
+ * a1 = exp(-pi * sqrt(2) / period)
+ * coeff2 = 2 * a1 * cos(sqrt(2) * 2 * pi / period)
+ * coeff3 = -sqr(a1)
+ * coeff1 = 1 - coeff2 - coeff3
+ */
+#define MINSTREL_AVG_COEFF1		0x00000495
+#define MINSTREL_AVG_COEFF2		0x00001499
+#define MINSTREL_AVG_COEFF3		-0x0000092e
+
 /*
  * Perform EWMA (Exponentially Weighted Moving Average) calculation
  */
@@ -32,6 +45,44 @@ minstrel_ewma(int old, int new, int weight)
 	return old + incr;
 }
 
+struct minstrel_avg_ctx {
+	s32 in_1;
+	s32 out_1;
+	s32 out_2;
+};
+
+static inline int minstrel_filter_avg_add(struct minstrel_avg_ctx *ctx, s32 in)
+{
+	s32 in_1 = ctx->in_1;
+	s32 out_1 = ctx->out_1;
+	s32 out_2 = ctx->out_2;
+	s32 val;
+
+	if (!in)
+		in += 1;
+
+	ctx->in_1 = in;
+	if (!in_1) {
+		val = out_1 = in;
+		goto out;
+	}
+
+	val = (MINSTREL_AVG_COEFF1 * (in + in_1) / 2) >> MINSTREL_SCALE;
+	val += (MINSTREL_AVG_COEFF2 * out_1) >> MINSTREL_SCALE;
+	val += (MINSTREL_AVG_COEFF3 * out_2) >> MINSTREL_SCALE;
+
+	if (val > 1 << MINSTREL_SCALE)
+		val = 1 << MINSTREL_SCALE;
+	if (val < 0)
+		val = 1;
+
+out:
+	ctx->out_2 = out_1;
+	ctx->out_1 = val;
+
+	return val;
+}
+
 struct minstrel_rate_stats {
 	/* current / last sampling period attempts/success counters */
 	u16 attempts, last_attempts;
@@ -40,6 +91,8 @@ struct minstrel_rate_stats {
 	/* total attempts/success counters */
 	u32 att_hist, succ_hist;
 
+	struct minstrel_avg_ctx avg;
+
 	/* prob_ewma - exponential weighted moving average of prob */
 	u16 prob_ewma;
 
@@ -95,6 +148,7 @@ struct minstrel_sta_info {
 struct minstrel_priv {
 	struct ieee80211_hw *hw;
 	bool has_mrr;
+	bool new_avg;
 	u32 sample_switch;
 	unsigned int cw_min;
 	unsigned int cw_max;
@@ -126,7 +180,8 @@ extern const struct rate_control_ops mac80211_minstrel;
 void minstrel_add_sta_debugfs(void *priv, void *priv_sta, struct dentry *dir);
 
 /* Recalculate success probabilities and counters for a given rate using EWMA */
-void minstrel_calc_rate_stats(struct minstrel_rate_stats *mrs);
+void minstrel_calc_rate_stats(struct minstrel_priv *mp,
+			      struct minstrel_rate_stats *mrs);
 int minstrel_get_tp_avg(struct minstrel_rate *mr, int prob_ewma);
 
 /* debugfs */
diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 21c74b200269..96c81392e617 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -737,7 +737,7 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 
 			mrs = &mg->rates[i];
 			mrs->retry_updated = false;
-			minstrel_calc_rate_stats(mrs);
+			minstrel_calc_rate_stats(mp, mrs);
 			cur_prob = mrs->prob_ewma;
 
 			if (minstrel_ht_get_tp_avg(mi, group, i, cur_prob) == 0)
@@ -773,6 +773,8 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 
 	/* try to sample all available rates during each interval */
 	mi->sample_count *= 8;
+	if (mp->new_avg)
+		mi->sample_count /= 2;
 
 	if (sample)
 		minstrel_ht_rate_sample_switch(mp, mi);
@@ -889,6 +891,7 @@ minstrel_ht_tx_status(void *priv, struct ieee80211_supported_band *sband,
 	struct ieee80211_tx_rate *ar = info->status.rates;
 	struct minstrel_rate_stats *rate, *rate2, *rate_sample = NULL;
 	struct minstrel_priv *mp = priv;
+	u32 update_interval = mp->update_interval / 2;
 	bool last, update = false;
 	bool sample_status = false;
 	int i;
@@ -943,6 +946,10 @@ minstrel_ht_tx_status(void *priv, struct ieee80211_supported_band *sband,
 
 	switch (mi->sample_mode) {
 	case MINSTREL_SAMPLE_IDLE:
+		if (mp->new_avg &&
+		    (mp->hw->max_rates > 1 ||
+		     mi->total_packets_cur < SAMPLE_SWITCH_THR))
+			update_interval /= 2;
 		break;
 
 	case MINSTREL_SAMPLE_ACTIVE:
@@ -983,8 +990,7 @@ minstrel_ht_tx_status(void *priv, struct ieee80211_supported_band *sband,
 		}
 	}
 
-	if (time_after(jiffies, mi->last_stats_update +
-				mp->update_interval / 2)) {
+	if (time_after(jiffies, mi->last_stats_update + update_interval)) {
 		update = true;
 		minstrel_ht_update_stats(mp, mi, true);
 	}
@@ -1665,6 +1671,7 @@ minstrel_ht_alloc(struct ieee80211_hw *hw, struct dentry *debugfsdir)
 
 	mp->hw = hw;
 	mp->update_interval = HZ / 10;
+	mp->new_avg = true;
 
 #ifdef CONFIG_MAC80211_DEBUGFS
 	mp->fixed_rate_idx = (u32) -1;
@@ -1672,6 +1679,8 @@ minstrel_ht_alloc(struct ieee80211_hw *hw, struct dentry *debugfsdir)
 			   &mp->fixed_rate_idx);
 	debugfs_create_u32("sample_switch", S_IRUGO | S_IWUSR, debugfsdir,
 			   &mp->sample_switch);
+	debugfs_create_bool("new_avg", S_IRUGO | S_IWUSR, debugfsdir,
+			   &mp->new_avg);
 #endif
 
 	minstrel_ht_init_cck_rates(mp);
-- 
2.17.0

