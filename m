Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1650301BD7
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Jan 2021 13:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbhAXM3C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Jan 2021 07:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbhAXM26 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Jan 2021 07:28:58 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FA8C0613ED
        for <linux-wireless@vger.kernel.org>; Sun, 24 Jan 2021 04:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5veCM6KrAG6x0DwEDau66T++uASL0DmZa65fQunhSPc=; b=of3RYuDzBzFzSqxb7232JEADtx
        wQE2GGqX7cSuYzZ4rDXvMZkofbaWDF9QfLblqs8/UIhevWVS3qYyXH6O1VJAG76GZhFHREP0yB/45
        sYOOOOdRkuzX696p27DfFmr5f9vm6unZxbritTZAyo5N9u8aC3y/EJVO0wgDzx4WpQdI=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l3eV4-00074g-76; Sun, 24 Jan 2021 13:28:14 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 3/6] mac80211: minstrel_ht: reduce the need to sample slower rates
Date:   Sun, 24 Jan 2021 13:28:09 +0100
Message-Id: <20210124122812.49929-3-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210124122812.49929-1-nbd@nbd.name>
References: <20210124122812.49929-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to more gracefully be able to fall back to lower rates without too
much throughput fluctuations, initialize all untested rates below tested ones
to the maximum probabilty of higher rates.
Usually this leads to untested lower rates getting initialized with a
probability value of 100%, making them better candidates for fallback without
having to rely on random probing

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rc80211_minstrel_ht.c | 18 ++++++++----------
 net/mac80211/rc80211_minstrel_ht.h |  2 --
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 2ef748ca5355..22adcebb8d51 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -791,14 +791,11 @@ minstrel_ht_calc_rate_stats(struct minstrel_priv *mp,
 	unsigned int cur_prob;
 
 	if (unlikely(mrs->attempts > 0)) {
-		mrs->sample_skipped = 0;
 		cur_prob = MINSTREL_FRAC(mrs->success, mrs->attempts);
 		minstrel_filter_avg_add(&mrs->prob_avg,
 					&mrs->prob_avg_1, cur_prob);
 		mrs->att_hist += mrs->attempts;
 		mrs->succ_hist += mrs->success;
-	} else {
-		mrs->sample_skipped++;
 	}
 
 	mrs->last_success = mrs->success;
@@ -851,7 +848,6 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 		mi->ampdu_packets = 0;
 	}
 
-	mi->sample_slow = 0;
 	mi->sample_count = 0;
 
 	memset(tmp_mcs_tp_rate, 0, sizeof(tmp_mcs_tp_rate));
@@ -883,6 +879,7 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	/* Find best rate sets within all MCS groups*/
 	for (group = 0; group < ARRAY_SIZE(minstrel_mcs_groups); group++) {
 		u16 *tp_rate = tmp_mcs_tp_rate;
+		u16 last_prob = 0;
 
 		mg = &mi->groups[group];
 		if (!mi->supported[group])
@@ -897,7 +894,7 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 		if (group == MINSTREL_CCK_GROUP && ht_supported)
 			tp_rate = tmp_legacy_tp_rate;
 
-		for (i = 0; i < MCS_GROUP_RATES; i++) {
+		for (i = MCS_GROUP_RATES - 1; i >= 0; i--) {
 			if (!(mi->supported[group] & BIT(i)))
 				continue;
 
@@ -906,6 +903,11 @@ minstrel_ht_update_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 			mrs = &mg->rates[i];
 			mrs->retry_updated = false;
 			minstrel_ht_calc_rate_stats(mp, mrs);
+
+			if (mrs->att_hist)
+				last_prob = max(last_prob, mrs->prob_avg);
+			else
+				mrs->prob_avg = max(last_prob, mrs->prob_avg);
 			cur_prob = mrs->prob_avg;
 
 			if (minstrel_ht_get_tp_avg(mi, group, i, cur_prob) == 0)
@@ -1470,13 +1472,9 @@ minstrel_get_sample_rate(struct minstrel_priv *mp, struct minstrel_ht_sta *mi)
 	if (sample_dur >= minstrel_get_duration(tp_rate2) &&
 	    (cur_max_tp_streams - 1 <
 	     minstrel_mcs_groups[sample_group].streams ||
-	     sample_dur >= minstrel_get_duration(mi->max_prob_rate))) {
-		if (mrs->sample_skipped < 20)
+	     sample_dur >= minstrel_get_duration(mi->max_prob_rate)))
 			return -1;
 
-		if (mi->sample_slow++ > 2)
-			return -1;
-	}
 	mi->sample_tries--;
 
 	return sample_idx;
diff --git a/net/mac80211/rc80211_minstrel_ht.h b/net/mac80211/rc80211_minstrel_ht.h
index 5912f7dc5267..ebb2b88f44d9 100644
--- a/net/mac80211/rc80211_minstrel_ht.h
+++ b/net/mac80211/rc80211_minstrel_ht.h
@@ -123,7 +123,6 @@ struct minstrel_rate_stats {
 	u8 retry_count;
 	u8 retry_count_rtscts;
 
-	u8 sample_skipped;
 	bool retry_updated;
 };
 
@@ -179,7 +178,6 @@ struct minstrel_ht_sta {
 	u8 sample_wait;
 	u8 sample_tries;
 	u8 sample_count;
-	u8 sample_slow;
 
 	enum minstrel_sample_mode sample_mode;
 	u16 sample_rate;
-- 
2.28.0

