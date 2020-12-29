Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2B72E7211
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Dec 2020 17:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726672AbgL2QCp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Dec 2020 11:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgL2QCo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Dec 2020 11:02:44 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EBDC06179C
        for <linux-wireless@vger.kernel.org>; Tue, 29 Dec 2020 08:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QExxLmDG55ZQ2i8DPuFwpm0iD9NHmjaGDbJobrrhtIA=; b=hfZ/4xNtpj5eNi/Z8nMM+atn/R
        TaUSZkbLWG0MhWDjc/rFwmQpwXsA1NV5Jbxb73miOTLSn6dUD3qoELVuXbrdGX8QyqUU6vlmZD8/g
        sagxDVpMd8grxcRu1rqkXiBB1q4NQ2hkrA9oBRa5mO+I17LN9UjbzxeRNJy/024a8bek=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kuHRA-0005ka-4v; Tue, 29 Dec 2020 17:01:28 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 4/8] mac80211: minstrel_ht: remove old ewma based rate average code
Date:   Tue, 29 Dec 2020 17:01:21 +0100
Message-Id: <20201229160125.92794-4-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201229160125.92794-1-nbd@nbd.name>
References: <20201229160125.92794-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The new noise filter has been the default for a while now with no reported
downside and significant improvement compared to the old code.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rc80211_minstrel_ht.c | 31 ++++++++----------------------
 net/mac80211/rc80211_minstrel_ht.h |  1 -
 2 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index fb72b014b32c..62bb3c1b0bb5 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -769,17 +769,8 @@ minstrel_ht_calc_rate_stats(struct minstrel_priv *mp,
 	if (unlikely(mrs->attempts > 0)) {
 		mrs->sample_skipped = 0;
 		cur_prob = MINSTREL_FRAC(mrs->success, mrs->attempts);
-		if (mp->new_avg) {
-			minstrel_filter_avg_add(&mrs->prob_avg,
-						&mrs->prob_avg_1, cur_prob);
-		} else if (unlikely(!mrs->att_hist)) {
-			mrs->prob_avg = cur_prob;
-		} else {
-			/*update exponential weighted moving avarage */
-			mrs->prob_avg = minstrel_ewma(mrs->prob_avg,
-						      cur_prob,
-						      EWMA_LEVEL);
-		}
+		minstrel_filter_avg_add(&mrs->prob_avg,
+					&mrs->prob_avg_1, cur_prob);
 		mrs->att_hist += mrs->attempts;
 		mrs->succ_hist += mrs->success;
 	} else {
@@ -913,10 +904,8 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	/* Try to increase robustness of max_prob_rate*/
 	minstrel_ht_prob_rate_reduce_streams(mi);
 
-	/* try to sample all available rates during each interval */
-	mi->sample_count *= 8;
-	if (mp->new_avg)
-		mi->sample_count /= 2;
+	/* try to sample half of all available rates during each interval */
+	mi->sample_count *= 4;
 
 	if (sample)
 		minstrel_ht_rate_sample_switch(mp, mi);
@@ -1040,7 +1029,7 @@ minstrel_ht_tx_status(void *priv, struct ieee80211_supported_band *sband,
 	struct ieee80211_tx_rate *ar = info->status.rates;
 	struct minstrel_rate_stats *rate, *rate2, *rate_sample = NULL;
 	struct minstrel_priv *mp = priv;
-	u32 update_interval = mp->update_interval / 2;
+	u32 update_interval = mp->update_interval;
 	bool last, update = false;
 	bool sample_status = false;
 	int i;
@@ -1090,9 +1079,8 @@ minstrel_ht_tx_status(void *priv, struct ieee80211_supported_band *sband,
 
 	switch (mi->sample_mode) {
 	case MINSTREL_SAMPLE_IDLE:
-		if (mp->new_avg &&
-		    (mp->hw->max_rates > 1 ||
-		     mi->total_packets_cur < SAMPLE_SWITCH_THR))
+		if (mp->hw->max_rates > 1 ||
+		     mi->total_packets_cur < SAMPLE_SWITCH_THR)
 			update_interval /= 2;
 		break;
 
@@ -1832,8 +1820,7 @@ minstrel_ht_alloc(struct ieee80211_hw *hw)
 		mp->has_mrr = true;
 
 	mp->hw = hw;
-	mp->update_interval = HZ / 10;
-	mp->new_avg = true;
+	mp->update_interval = HZ / 20;
 
 	minstrel_ht_init_cck_rates(mp);
 	for (i = 0; i < ARRAY_SIZE(mp->hw->wiphy->bands); i++)
@@ -1853,8 +1840,6 @@ static void minstrel_ht_add_debugfs(struct ieee80211_hw *hw, void *priv,
 			   &mp->fixed_rate_idx);
 	debugfs_create_u32("sample_switch", S_IRUGO | S_IWUSR, debugfsdir,
 			   &mp->sample_switch);
-	debugfs_create_bool("new_avg", S_IRUGO | S_IWUSR, debugfsdir,
-			   &mp->new_avg);
 }
 #endif
 
diff --git a/net/mac80211/rc80211_minstrel_ht.h b/net/mac80211/rc80211_minstrel_ht.h
index 25c3664bddde..7d6d0b720f6d 100644
--- a/net/mac80211/rc80211_minstrel_ht.h
+++ b/net/mac80211/rc80211_minstrel_ht.h
@@ -60,7 +60,6 @@
 struct minstrel_priv {
 	struct ieee80211_hw *hw;
 	bool has_mrr;
-	bool new_avg;
 	u32 sample_switch;
 	unsigned int cw_min;
 	unsigned int cw_max;
-- 
2.28.0

