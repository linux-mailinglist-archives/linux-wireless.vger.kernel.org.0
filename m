Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1D15203B5
	for <lists+linux-wireless@lfdr.de>; Mon,  9 May 2022 19:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239766AbiEIRoR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 May 2022 13:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239745AbiEIRoQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 May 2022 13:44:16 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AFEF68BB
        for <linux-wireless@vger.kernel.org>; Mon,  9 May 2022 10:40:21 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso11319wma.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 May 2022 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rMwq9lZNdK380h8KTpihGZ/utFyvqLSsYESPrR+MTfM=;
        b=mEBrhxcGRCbCtHCeiz4grsbFsr9prl/usFhiEcxacjffgRN12xMpIgu97Yq0XCN8XD
         IW6xtjmCwtYlRGwdg5kHOonN8chcApM6xRglGXqje5TPWPxtWVg8UMg4sTWt/tAcckua
         6Ur1+af4ZliDNPIaj6MRcMlHMSc498N9hDhhAe4RG6QegxIQOuRzB+gB7JONHWqDXjZe
         ZmlZxS9OjUvgKRanBZsqFt3QLvXRbS8YZRwwPUrh3+Y6S5CYweB2U3gGq3rbaWIlzzc7
         MuFZc0uFOrZ0T9tL5sBwWElUJMmK0YvsUmQSrYWWoEiDBUIlTYu2EKNlG5e66dGhnBZF
         aZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rMwq9lZNdK380h8KTpihGZ/utFyvqLSsYESPrR+MTfM=;
        b=TmcdMUKT0Fd3G0bUrYvd33Eh3kjK6rHAkx4G1zhBTgs9cTHcXHDVxSK/B3y9ocqdow
         5TPfQ5rrdtx1MP+y0kQVrWRgqV8/Gagoi1yn/J3qGdi2rDqsjEYbIldM+DUsXh53PmzF
         1Lrmlrv3/rfij94qGXkbd5cHavLiDIJvMX5l8nzjFGvrjaFNu7bzmbjY3yyLKDe6u2BW
         akKlxIhHbl6Sd+0xa7+vHo8usdlVgrfQgPkNSRJwaGL27sq/rJnIpzPhcVjTWgr6HUsH
         Dthn/3t80AVjVzPS25gKTWaqWx1ah3VWXDE+cE5zhe7u1PJ3I5qPvPU+ZF+xnR3FU6tT
         uJuw==
X-Gm-Message-State: AOAM532KWB0s9VdGWymBF9M2FRgMmR9Fabm+LKAjaxCzRR7kg8aUyhiF
        xP8wQpJ20OlXwKvOf2ixuMfUQef3KRg=
X-Google-Smtp-Source: ABdhPJzwFiufYMx9CZhLNNbEk4Xh57KMYz2z9uH8P8Ux/A5M25Uu3IH9+n5miI1gZcHnly+cTEd8NA==
X-Received: by 2002:a05:600c:4f52:b0:394:61af:a168 with SMTP id m18-20020a05600c4f5200b0039461afa168mr23582783wmq.114.1652118020134;
        Mon, 09 May 2022 10:40:20 -0700 (PDT)
Received: from build-server.fritz.box (p200300c56f11c200880d3dfffedefb04.dip0.t-ipconnect.de. [2003:c5:6f11:c200:880d:3dff:fede:fb04])
        by smtp.gmail.com with ESMTPSA id bh26-20020a05600c3d1a00b003942a244ee8sm14106253wmb.45.2022.05.09.10.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 10:40:19 -0700 (PDT)
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, johannes@sipsolutions.net,
        thomas.huehn@hs-nordhausen.de, greearb@candelatech.com,
        kvalo@kernel.org, Jonas Jelonek <jelonek.jonas@gmail.com>
Subject: [PATCH v4 2/2] mac80211: minstrel_ht: support ieee80211_rate_status
Date:   Mon,  9 May 2022 19:39:58 +0200
Message-Id: <20220509173958.1398201-3-jelonek.jonas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220509173958.1398201-1-jelonek.jonas@gmail.com>
References: <20220509173958.1398201-1-jelonek.jonas@gmail.com>
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
                Linux 5.10.113

Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
---
 net/mac80211/rc80211_minstrel_ht.c | 138 +++++++++++++++++++++++++++--
 net/mac80211/rc80211_minstrel_ht.h |   2 +-
 2 files changed, 131 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/rc80211_minstrel_ht.c b/net/mac80211/rc80211_minstrel_ht.c
index 7b1f5c045e06..3533c78df691 100644
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
@@ -385,6 +406,50 @@ minstrel_ht_get_stats(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
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
+		if ((mi->supported[group] & BIT(idx + 4)) &&
+							mi->use_short_preamble)
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
@@ -1152,6 +1217,40 @@ minstrel_ht_txstat_valid(struct minstrel_priv *mp, struct minstrel_ht_sta *mi,
 	return false;
 }
 
+/*
+ * Check whether rate_status contains valid information.
+ */
+static bool
+minstrel_ht_ri_txstat_valid(struct minstrel_priv *mp,
+			    struct minstrel_ht_sta *mi,
+			    struct ieee80211_rate_status *rate_status)
+{
+	int i;
+
+	if (!rate_status)
+		return false;
+	if (!rate_status->try_count)
+		return false;
+
+	if (rate_status->rate_idx.flags & RATE_INFO_FLAGS_MCS ||
+	    rate_status->rate_idx.flags & RATE_INFO_FLAGS_VHT_MCS)
+		return true;
+
+	for (i = 0; i < ARRAY_SIZE(mp->cck_rates); i++) {
+		if (rate_status->rate_idx.legacy ==
+		    minstrel_cck_bitrates[ mp->cck_rates[i] ])
+			return true;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(mp->ofdm_rates); i++) {
+		if (rate_status->rate_idx.legacy ==
+		    minstrel_ofdm_bitrates[ mp->ofdm_rates[mi->band][i] ])
+			return true;
+	}
+
+	return false;
+}
+
 static void
 minstrel_downgrade_rate(struct minstrel_ht_sta *mi, u16 *idx, bool primary)
 {
@@ -1217,16 +1316,34 @@ minstrel_ht_tx_status(void *priv, struct ieee80211_supported_band *sband,
 	mi->ampdu_packets++;
 	mi->ampdu_len += info->status.ampdu_len;
 
-	last = !minstrel_ht_txstat_valid(mp, mi, &ar[0]);
-	for (i = 0; !last; i++) {
-		last = (i == IEEE80211_TX_MAX_RATES - 1) ||
-		       !minstrel_ht_txstat_valid(mp, mi, &ar[i + 1]);
+	if (st->rates && st->n_rates) {
+		last = !minstrel_ht_ri_txstat_valid(mp, mi, &(st->rates[0]));
+		for (i = 0; !last; i++) {
+			last = (i == st->n_rates - 1) ||
+				!minstrel_ht_ri_txstat_valid(mp, mi,
+							&(st->rates[i + 1]));
+
+			rate = minstrel_ht_ri_get_stats(mp, mi,
+							&(st->rates[i]));
+
+			if (last)
+				rate->success += info->status.ampdu_ack_len;
+
+			rate->attempts += st->rates[i].try_count *
+					  info->status.ampdu_len;
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
@@ -1583,6 +1700,7 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
 	u16 ht_cap = sta->deflink.ht_cap.cap;
 	struct ieee80211_sta_vht_cap *vht_cap = &sta->deflink.vht_cap;
 	const struct ieee80211_rate *ctl_rate;
+	struct sta_info *sta_info;
 	bool ldpc, erp;
 	int use_vht;
 	int n_supported = 0;
@@ -1701,6 +1819,10 @@ minstrel_ht_update_caps(void *priv, struct ieee80211_supported_band *sband,
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

