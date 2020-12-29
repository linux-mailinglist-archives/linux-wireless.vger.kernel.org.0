Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A032E720C
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Dec 2020 17:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgL2QCM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Dec 2020 11:02:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgL2QCL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Dec 2020 11:02:11 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB2FC061798
        for <linux-wireless@vger.kernel.org>; Tue, 29 Dec 2020 08:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6Vp5QL6igyE+LoOTEVA+LT3X/f/m6os1IGsMRvsQtBY=; b=PkeFDrPicOgiQneU/j5IKIGLgM
        M2HhbCmXS4AdndTh3v6MCWiXyN2734DZRUbVs/BgxsaW2Hnda/wxvBztE5MQtd7CEt/2GA0M+r1cf
        l4K//iVN1SMc+1Ex0j4SBuWOXU9cpD7NpG7SI4ghweKrWWMW5ZlOJWU8lqPAdNrkWmu4=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kuHRA-0005ka-P6; Tue, 29 Dec 2020 17:01:28 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 7/8] mac80211: minstrel_ht: fix max probability rate selection
Date:   Tue, 29 Dec 2020 17:01:24 +0100
Message-Id: <20201229160125.92794-7-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201229160125.92794-1-nbd@nbd.name>
References: <20201229160125.92794-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

- do not select rates faster than the max throughput rate if probability is lower
- reset previous rate before sorting again

This ensures that the max prob rate gets set to a more reliable rate

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rc80211_minstrel_ht.c | 46 ++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index dcc4394a872a..45ae66024ace 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -495,12 +495,13 @@ minstrel_ht_sort_best_tp_rates(struct minstrel_ht_sta *mi, u16 index,
  * Find and set the topmost probability rate per sta and per group
  */
 static void
-minstrel_ht_set_best_prob_rate(struct minstrel_ht_sta *mi, u16 index)
+minstrel_ht_set_best_prob_rate(struct minstrel_ht_sta *mi, u16 *dest, u16 index)
 {
 	struct minstrel_mcs_group_data *mg;
 	struct minstrel_rate_stats *mrs;
 	int tmp_group, tmp_idx, tmp_tp_avg, tmp_prob;
-	int max_tp_group, cur_tp_avg, cur_group, cur_idx;
+	int max_tp_group, max_tp_idx, max_tp_prob;
+	int cur_tp_avg, cur_group, cur_idx;
 	int max_gpr_group, max_gpr_idx;
 	int max_gpr_tp_avg, max_gpr_prob;
 
@@ -509,18 +510,26 @@ minstrel_ht_set_best_prob_rate(struct minstrel_ht_sta *mi, u16 index)
 	mg = &mi->groups[index / MCS_GROUP_RATES];
 	mrs = &mg->rates[index % MCS_GROUP_RATES];
 
-	tmp_group = mi->max_prob_rate / MCS_GROUP_RATES;
-	tmp_idx = mi->max_prob_rate % MCS_GROUP_RATES;
+	tmp_group = *dest / MCS_GROUP_RATES;
+	tmp_idx = *dest % MCS_GROUP_RATES;
 	tmp_prob = mi->groups[tmp_group].rates[tmp_idx].prob_avg;
 	tmp_tp_avg = minstrel_ht_get_tp_avg(mi, tmp_group, tmp_idx, tmp_prob);
 
 	/* if max_tp_rate[0] is from MCS_GROUP max_prob_rate get selected from
 	 * MCS_GROUP as well as CCK_GROUP rates do not allow aggregation */
 	max_tp_group = mi->max_tp_rate[0] / MCS_GROUP_RATES;
+	max_tp_idx = mi->max_tp_rate[0] % MCS_GROUP_RATES;
+	max_tp_prob = mi->groups[max_tp_group].rates[max_tp_idx].prob_avg;
+
 	if (minstrel_ht_is_legacy_group(index / MCS_GROUP_RATES) &&
 	    !minstrel_ht_is_legacy_group(max_tp_group))
 		return;
 
+	/* skip rates faster than max tp rate with lower prob */
+	if (minstrel_get_duration(mi->max_tp_rate[0]) > minstrel_get_duration(index) &&
+	    mrs->prob_avg < max_tp_prob)
+		return;
+
 	max_gpr_group = mg->max_group_prob_rate / MCS_GROUP_RATES;
 	max_gpr_idx = mg->max_group_prob_rate % MCS_GROUP_RATES;
 	max_gpr_prob = mi->groups[max_gpr_group].rates[max_gpr_idx].prob_avg;
@@ -538,7 +547,7 @@ minstrel_ht_set_best_prob_rate(struct minstrel_ht_sta *mi, u16 index)
 			mg->max_group_prob_rate = index;
 	} else {
 		if (mrs->prob_avg > tmp_prob)
-			mi->max_prob_rate = index;
+			*dest = index;
 		if (mrs->prob_avg > max_gpr_prob)
 			mg->max_group_prob_rate = index;
 	}
@@ -816,7 +825,8 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	struct minstrel_rate_stats *mrs;
 	int group, i, j, cur_prob;
 	u16 tmp_mcs_tp_rate[MAX_THR_RATES], tmp_group_tp_rate[MAX_THR_RATES];
-	u16 tmp_legacy_tp_rate[MAX_THR_RATES], index;
+	u16 tmp_legacy_tp_rate[MAX_THR_RATES], tmp_max_prob_rate;
+	u16 index;
 	bool ht_supported = mi->sta->ht_cap.ht_supported;
 
 	mi->sample_mode = MINSTREL_SAMPLE_IDLE;
@@ -903,9 +913,6 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 			/* Find max throughput rate set within a group */
 			minstrel_ht_sort_best_tp_rates(mi, index,
 						       tmp_group_tp_rate);
-
-			/* Find max probability rate per group and global */
-			minstrel_ht_set_best_prob_rate(mi, index);
 		}
 
 		memcpy(mg->max_group_tp_rate, tmp_group_tp_rate,
@@ -917,6 +924,27 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 					 tmp_legacy_tp_rate);
 	memcpy(mi->max_tp_rate, tmp_mcs_tp_rate, sizeof(mi->max_tp_rate));
 
+	for (group = 0; group < ARRAY_SIZE(minstrel_mcs_groups); group++) {
+		if (!mi->supported[group])
+			continue;
+
+		mg = &mi->groups[group];
+		mg->max_group_prob_rate = MCS_GROUP_RATES * group;
+
+		for (i = 0; i < MCS_GROUP_RATES; i++) {
+			if (!(mi->supported[group] & BIT(i)))
+				continue;
+
+			index = MCS_GROUP_RATES * group + i;
+
+			/* Find max probability rate per group and global */
+			minstrel_ht_set_best_prob_rate(mi, &tmp_max_prob_rate,
+						       index);
+		}
+	}
+
+	mi->max_prob_rate = tmp_max_prob_rate;
+
 	/* Try to increase robustness of max_prob_rate*/
 	minstrel_ht_prob_rate_reduce_streams(mi);
 
-- 
2.28.0

