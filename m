Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81534C56A7
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Feb 2022 16:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbiBZPji (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Feb 2022 10:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiBZPji (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Feb 2022 10:39:38 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE85EB5
        for <linux-wireless@vger.kernel.org>; Sat, 26 Feb 2022 07:39:03 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u1so8768183wrg.11
        for <linux-wireless@vger.kernel.org>; Sat, 26 Feb 2022 07:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P9Gg21QR2rK3IJD7YN/otyUvr3oMSAWG7+Rk4mdJdw8=;
        b=QMZ6S+jBkEmb7O4NUtyKvfHTrdBI3qdhsP6E8uuQHxNPMkyCsfQ0rtcCUZiRH5zwZ+
         zDlZdyBuGZd8PIyffkYDzSs94eZ+AcMzLoLCmQZrOvSqUqeWWrUxDx41gfR0po9tM1Hc
         Mq0aexO2uEtTKDn49UZXBmHKm0vDQFh1GghGQ9ftsXqCMiBoFcutUIQkbhxpcIwLAj4a
         47WfTR5vLkp8OTJ2j8n9KIXkfpWI47oms2LdrlOhWJC/zkbr7AyNmE6Yvy1gXd6zV4E5
         2ZXXT7zeT4jdyMNSLtSMQ1lnKay0En5visjyTFV8rsCV+roYZ6RJshFi+6O4KXcaFqXM
         HHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P9Gg21QR2rK3IJD7YN/otyUvr3oMSAWG7+Rk4mdJdw8=;
        b=d6ozYx6SIPMIByBYBG42zJFewWY5iICc1+Tn8X/c08+DIItQAwtW4fOUJZsZFyFoXh
         yuYwT3Oi2+Ql+qG0YqMg1WeIYAcYI61IPE6jgGVC4Ndo7eRadwzzodii2HcAWYk2kxSP
         jUYbH29bkkTtgMM3jn2jQiTW+B4p+3V7yLGzpD/I/zn0EvQZNcUDNQNXDrNnsttUM3zO
         ztxg3Zb/LBDTeHMxiqu8vx74gimJcpuPx/gSpb9KP9MztfvAwpsj5EHBcxpOQ5LnGS+b
         modF1YUFcUSIShH1rVwzCcZK9AaYpgT9yQZn0wyzILWRkxn8ohnfDCkt0LPkVaXFnS6a
         ppDw==
X-Gm-Message-State: AOAM53242cGKTck7LUbZ2I4hJph5UiskJuFWj28OdOXpbJlWoFzcIqKz
        VVG3+x1jsAc2KPX47/vffXp5zJR0LCB0Wg==
X-Google-Smtp-Source: ABdhPJxxup+jwWMRvuA9VoF273bXLojKorlQ+WQ+GGsGusA3e/31cVVcX4AdUGgSqdu8kKhrxHll0w==
X-Received: by 2002:adf:f5c5:0:b0:1ed:bc44:63e4 with SMTP id k5-20020adff5c5000000b001edbc4463e4mr9942101wrp.236.1645889941934;
        Sat, 26 Feb 2022 07:39:01 -0800 (PST)
Received: from build-server.fritz.box (p200300c56f4ead00880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f4e:ad00:880d:3dff:fede:fb04])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c19c900b0037c050d73dcsm10239054wmq.46.2022.02.26.07.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 07:39:01 -0800 (PST)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     kvalo@kernel.org, ndb@nbd.name, johannes@sipsolutions.net,
        Jonas Jelonek <jelonek.jonas@gmail.com>,
        Thomas Huehn <thomas.huehn@hs-nordhausen.de>
Subject: [PATCH 2/2] mac80211: minstrel_ht: support ieee80211_rate_status
Date:   Sat, 26 Feb 2022 16:38:43 +0100
Message-Id: <20220226153843.912-3-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220226153843.912-1-jelonek.jonas@gmail.com>
References: <20220226153843.912-1-jelonek.jonas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds support for the new struct ieee80211_rate_status and its
annotation in struct ieee80211_tx_status in minstrel_ht.

In minstrel_ht_tx_status, a check for the presence of instances of the
new struct in ieee80211_tx_status is added. Based on this, minstrel_ht
then gets and updates internal rate stats with either struct
ieee80211_rate_status or ieee80211_tx_info->status.rates.
Adjusted variants of minstrel_ht_txstat_valid, minstrel_ht_get_stats,
minstrel_{ht/vht}_get_group_idx are added which use struct
ieee80211_rate_status and struct rate_info instead of the legacy structs.

struct rate_info from cfg80211.h does not provide whether short preamble
was used for the transmission. So we retrieve this information from VIF
and STA configuration and cache it in a new flag in struct minstrel_ht_sta
per rate control instance.

Compile-Tested: current wireless-next tree with all flags on
Tested-on: Xiaomi 4A Gigabit (MediaTek MT7603E, MT7612E) with OpenWrt
                Linux 5.10.83

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
Acked-by: Thomas Huehn <thomas.huehn@hs-nordhausen.de>
---
 net/mac80211/rc80211_minstrel_ht.c | 131 +++++++++++++++++++++++++++--
 net/mac80211/rc80211_minstrel_ht.h |   2 +-
 2 files changed, 124 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 9c3b7fc377c1..68e3a972c2fc 100644
--- a/net/mac80211/rc80211_minstrel_ht.c
+++ b/net/mac80211/rc80211_minstrel_ht.c
@@ -333,6 +333,16 @@ minstrel_ht_get_group_idx(struct ieee80211_tx_rate *rate)
 			 !!(rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH));
 }
 
+/*
+ * Look up an MCS group index based on new cfg80211 rate_info.
+ */
+static int
+minstrel_ht_ri_get_group_idx(struct rate_info *rate) {
+	return GROUP_IDX((rate->mcs / 8) + 1,
+			 !!(rate->flags & RATE_INFO_FLAGS_SHORT_GI),
+			 !!(rate->bw & RATE_INFO_BW_40));
+}
+
 static int
 minstrel_vht_get_group_idx(struct ieee80211_tx_rate *rate)
 {
@@ -342,6 +352,17 @@ minstrel_vht_get_group_idx(struct ieee80211_tx_rate *rate)
 			     2*!!(rate->flags & IEEE80211_TX_RC_80_MHZ_WIDTH));
 }
 
+/*
+ * Look up an MCS group index based on new cfg80211 rate_info.
+ */
+static int
+minstrel_vht_ri_get_group_idx(struct rate_info *rate) {
+	return VHT_GROUP_IDX(rate->nss,
+			     !!(rate->flags & RATE_INFO_FLAGS_SHORT_GI),
+			     !!(rate->bw & RATE_INFO_BW_40) +
+			     2*!!(rate->bw & RATE_INFO_BW_80));
+}
+
 static struct minstrel_rate_stats *
 minstrel_ht_get_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 		      struct ieee80211_tx_rate *rate)
@@ -382,6 +403,49 @@ minstrel_ht_get_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	return &mi->groups[group].rates[idx];
 }
 
+/*
+ * Get the minstrel rate statistics for specified STA and rate info.
+ */
+static struct minstrel_rate_stats *
+minstrel_ht_ri_get_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
+			  struct ieee80211_rate_status *rate_status)
+{
+	int group, idx;
+	struct rate_info *rate = &rate_status->rate_idx;
+
+	if (rate->flags & RATE_INFO_FLAGS_MCS) {
+		group = minstrel_ht_ri_get_group_idx(rate);
+		idx = rate->mcs % 8;
+		goto out;
+	}
+
+	if (rate->flags & RATE_INFO_FLAGS_VHT_MCS) {
+		group = minstrel_vht_ri_get_group_idx(rate);
+		idx = rate->mcs;
+		goto out;
+	}
+
+	group = MINSTREL_CCK_GROUP;
+	for (idx = 0; idx < ARRAY_SIZE(mp->cck_rates); idx++) {
+		if (rate->legacy != minstrel_cck_bitrates[ mp->cck_rates[idx] ])
+			continue;
+
+		/* short preamble */
+		if ((mi->supported[group] & BIT(idx + 4)) && mi->use_short_preamble)
+			idx += 4;
+		goto out;
+	}
+
+	group = MINSTREL_OFDM_GROUP;
+	for (idx = 0; idx < ARRAY_SIZE(mp->ofdm_rates[0]); idx++)
+		if (rate->legacy == minstrel_ofdm_bitrates[ mp->ofdm_rates[mi->band][idx] ])
+			goto out;
+
+	idx = 0;
+out:
+	return &mi->groups[group].rates[idx];
+}
+
 static inline struct minstrel_rate_stats *
 minstrel_get_ratestats(struct minstrel_ht_sta *mi, int index)
 {
@@ -1149,6 +1213,37 @@ minstrel_ht_txstat_valid(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	return false;
 }
 
+/*
+ * Check whether rate_status contains valid information.
+ */
+static bool
+minstrel_ht_ri_txstat_valid(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
+			     struct ieee80211_rate_status *rate_status)
+{
+	int i;
+
+	if (!rate_status)
+		return false;
+	if (!rate_status->retry_count)
+		return false;
+
+	if (rate_status->rate_idx.flags & RATE_INFO_FLAGS_MCS ||
+	    rate_status->rate_idx.flags & RATE_INFO_FLAGS_VHT_MCS)
+		return true;
+
+	for (i = 0; i < ARRAY_SIZE(mp->cck_rates); i++) {
+		if (rate_status->rate_idx.legacy == minstrel_cck_bitrates[ mp->cck_rates[i] ])
+			return true;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(mp->ofdm_rates); i++) {
+		if (rate_status->rate_idx.legacy == minstrel_ofdm_bitrates[ mp->ofdm_rates[mi->band][i] ])
+			return true;
+	}
+
+	return false;
+}
+
 static void
 minstrel_downgrade_rate(struct minstrel_ht_sta *mi, u16 *idx, bool primary)
 {
@@ -1214,16 +1309,31 @@ minstrel_ht_tx_status(void *priv, struct ieee80211_supported_band *sband,
 	mi->ampdu_packets++;
 	mi->ampdu_len += info->status.ampdu_len;
 
-	last = !minstrel_ht_txstat_valid(mp, mi, &ar[0]);
-	for (i = 0; !last; i++) {
-		last = (i == IEEE80211_TX_MAX_RATES - 1) ||
-		       !minstrel_ht_txstat_valid(mp, mi, &ar[i + 1]);
+	if (unlikely(st->rates && st->n_rates)) {
+		last = !minstrel_ht_ri_txstat_valid(mp, mi, &(st->rates[0]));
+		for (i = 0; !last; i++) {
+			last = (i == st->n_rates - 1) ||
+				!minstrel_ht_ri_txstat_valid(mp, mi, &(st->rates[i + 1]));
+
+			rate = minstrel_ht_ri_get_stats(mp, mi, &(st->rates[i]));
+
+			if (last)
+				rate->success += info->status.ampdu_ack_len;
+
+			rate->attempts += st->rates[i].retry_count * info->status.ampdu_len;
+		}
+	} else {
+		last = !minstrel_ht_txstat_valid(mp, mi, &ar[0]);
+		for (i = 0; !last; i++) {
+			last = (i == IEEE80211_TX_MAX_RATES - 1) ||
+				!minstrel_ht_txstat_valid(mp, mi, &ar[i + 1]);
 
-		rate = minstrel_ht_get_stats(mp, mi, &ar[i]);
-		if (last)
-			rate->success += info->status.ampdu_ack_len;
+			rate = minstrel_ht_get_stats(mp, mi, &ar[i]);
+			if (last)
+				rate->success += info->status.ampdu_ack_len;
 
-		rate->attempts += ar[i].count * info->status.ampdu_len;
+			rate->attempts += ar[i].count * info->status.ampdu_len;
+		}
 	}
 
 	if (mp->hw->max_rates > 1) {
@@ -1576,6 +1686,7 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 {
 	struct minstrel_priv *mp = priv;
 	struct minstrel_ht_sta *mi = priv_sta;
+	struct sta_info *sta_info;
 	struct ieee80211_mcs_info *mcs = &sta->ht_cap.mcs;
 	u16 ht_cap = sta->ht_cap.cap;
 	struct ieee80211_sta_vht_cap *vht_cap = &sta->vht_cap;
@@ -1698,6 +1809,10 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 			n_supported++;
 	}
 
+	sta_info = container_of(sta, struct sta_info, sta);
+	mi->use_short_preamble = test_sta_flag(sta_info, WLAN_STA_SHORT_PREAMBLE) &&
+				 sta_info->sdata->vif.bss_conf.use_short_preamble;
+
 	minstrel_ht_update_cck(mp, mi, sband, sta);
 	minstrel_ht_update_ofdm(mp, mi, sband, sta);
 
diff --git a/net/mac80211/rc80211_minstrel_ht.h b/net/mac80211/rc80211_minstrel_ht.h
index 06e7126727ad..1766ff0c78d3 100644
--- a/net/mac80211/rc80211_minstrel_ht.h
+++ b/net/mac80211/rc80211_minstrel_ht.h
@@ -180,7 +180,7 @@ struct minstrel_ht_sta {
 
 	/* tx flags to add for frames for this sta */
 	u32 tx_flags;
-
+	bool use_short_preamble;
 	u8 band;
 
 	u8 sample_seq;
-- 
2.30.2

