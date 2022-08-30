Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE8A5A5949
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 04:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiH3CVJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 22:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiH3CVI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 22:21:08 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306637CA91
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:21:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id v5so3526999plo.9
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RHopkjClYRCGGjKkbdyeKOpr+kFyb34b5lqs1q4lMTk=;
        b=tiFC6BwU/MFxDXvNUYeTIryd1R13wkZOSob5Q/25tNnfjoxTcqFISdKEmovN+sKC3W
         5h28YJ4+gP6/RTZ3YkO5Vc7SSt7HFzwB6JlJY1HeALRQ5hAtK0BuB1Xi/pgaQWmSajAE
         MTXh9IumfuBG6PheJr3P1da+skf4rwa/OjNLN2zC2nrGML/QN5OJw/pGXYGeFWrkgXkq
         Fv80Ql53Zhlw7mJsxfn2oGEiVts8Jok4UnE7vmJhAdab/TR5xWsHdhRNcnw7PzL5J5Sh
         eFw0LT8FaY38sCTrd8qL0ju7xEcIVlDlDvKv6ek445+7sce58/DusNnqgmlTQxIvpcw4
         sXGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RHopkjClYRCGGjKkbdyeKOpr+kFyb34b5lqs1q4lMTk=;
        b=Q+Mlsp0qp/gEsOKHPLLzd/fQSWzzEXGG7+XQw8bkJ+Ngg359gYNeHJQ5FCMxvc4zt0
         2RPJor9rbwHPrkLoTAEQ4nhPswjjIIas7lDQSreMmrPGgDmdzqnU9I1geyD0M8jecVkk
         cbmKQJfNrKCocOFsOvATee59P2aaWOdOknkMmxDQnifjF3QrVw0vQ59c0zZNIqfdkiRr
         7TPqjYC6vKRMhXylVe1yoVug7uvSoJJzs0FWgjVYM9lW6KppU0lq9zHZlArPjyEVWkUq
         NbdkiigczVy6mzmL+xyLG8BD4eNCG1KejFj6Vr5phHJFy4E05vkHAorjaf3MEJMma8P/
         fm7g==
X-Gm-Message-State: ACgBeo1humr7wzHS+BhvnVXTTXZV7pMIMjMu1Oay3pJzBMP4n1ouAtv6
        N13ruoS05VflN1QoArjfi89LNH5Wm5WcyjWd
X-Google-Smtp-Source: AA6agR7DepY9HWs5sOZD+g648m+XxFhhOOHix3j8CsF6Mg2Bfem21LCxL9svLEtA3v6ll+IlxD0jyg==
X-Received: by 2002:a17:902:aa49:b0:172:f8ed:1b27 with SMTP id c9-20020a170902aa4900b00172f8ed1b27mr19743879plr.52.1661826066642;
        Mon, 29 Aug 2022 19:21:06 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016d8d277c02sm8220050plb.25.2022.08.29.19.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 19:21:06 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v2 10/12] mac80211: support S1G rate encoding.
Date:   Tue, 30 Aug 2022 02:20:15 +0000
Message-Id: <20220830022017.51017-11-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830022017.51017-1-kieran.frewen@morsemicro.com>
References: <20220830022017.51017-1-kieran.frewen@morsemicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for receiving and transmitting S1G frames.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
---
 drivers/net/wireless/mac80211_hwsim.c |  2 +-
 include/net/mac80211.h                | 32 ++++++++++++++++----
 net/mac80211/cfg.c                    | 42 ++++++++++++++++++++-------
 net/mac80211/rx.c                     |  8 +++++
 net/mac80211/sta_info.c               |  7 +++++
 net/mac80211/sta_info.h               |  7 +++++
 net/mac80211/util.c                   | 30 ++++++++++++++++++-
 7 files changed, 110 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 6e55f153ff26..5ecbc80be338 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1575,7 +1575,7 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 	memset(&rx_status, 0, sizeof(rx_status));
 	rx_status.flag |= RX_FLAG_MACTIME_START;
 	rx_status.freq = chan->center_freq;
-	rx_status.freq_offset = chan->freq_offset ? 1 : 0;
+	rx_status.freq_offset = chan->freq_offset;
 	rx_status.band = chan->band;
 	if (info->control.rates[0].flags & IEEE80211_TX_RC_VHT_MCS) {
 		rx_status.rate_idx =
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 359edfa9ec1c..2e4a78301e3d 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -863,6 +863,10 @@ enum mac80211_tx_info_flags {
 #define IEEE80211_TX_CTL_STBC_SHIFT		23
 
 #define IEEE80211_TX_RC_S1G_MCS IEEE80211_TX_RC_VHT_MCS
+#define IEEE80211_TX_RC_2_MHZ_WIDTH IEEE80211_TX_RC_MCS
+#define IEEE80211_TX_RC_4_MHZ_WIDTH IEEE80211_TX_RC_40_MHZ_WIDTH
+#define IEEE80211_TX_RC_8_MHZ_WIDTH IEEE80211_TX_RC_80_MHZ_WIDTH
+#define IEEE80211_TX_RC_16_MHZ_WIDTH IEEE80211_TX_RC_160_MHZ_WIDTH
 
 /**
  * enum mac80211_tx_control_flags - flags to describe transmit control
@@ -1051,6 +1055,20 @@ ieee80211_rate_get_vht_nss(const struct ieee80211_tx_rate *rate)
 	return (rate->idx >> 4) + 1;
 }
 
+static inline u8
+ieee80211_rate_get_s1g_mcs(const struct ieee80211_tx_rate *rate)
+{
+	/* S1G uses the same MCS encoding as VHT */
+	return ieee80211_rate_get_vht_mcs(rate);
+}
+
+static inline u8
+ieee80211_rate_get_s1g_nss(const struct ieee80211_tx_rate *rate)
+{
+	/* S1G uses the same NSS encoding as VHT */
+	return ieee80211_rate_get_vht_nss(rate);
+}
+
 /**
  * struct ieee80211_tx_info - skb transmit information
  *
@@ -1435,6 +1453,7 @@ enum mac80211_rx_encoding {
 	RX_ENC_HT,
 	RX_ENC_VHT,
 	RX_ENC_HE,
+	RX_ENC_S1G,
 };
 
 /**
@@ -1491,10 +1510,11 @@ struct ieee80211_rx_status {
 	u32 device_timestamp;
 	u32 ampdu_reference;
 	u32 flag;
-	u16 freq: 13, freq_offset: 1;
+	u16 freq;
+	u16 freq_offset;
 	u8 enc_flags;
-	u8 encoding:2, bw:3, he_ru:3;
-	u8 he_gi:2, he_dcm:1;
+	u8 encoding:3, bw:5;
+	u8 he_ru:3, he_gi:2, he_dcm:1;
 	u8 rate_idx;
 	u8 nss;
 	u8 rx_flags;
@@ -1510,8 +1530,7 @@ struct ieee80211_rx_status {
 static inline u32
 ieee80211_rx_status_to_khz(struct ieee80211_rx_status *rx_status)
 {
-	return MHZ_TO_KHZ(rx_status->freq) +
-	       (rx_status->freq_offset ? 500 : 0);
+	return MHZ_TO_KHZ(rx_status->freq) + rx_status->freq_offset;
 }
 
 /**
@@ -6568,6 +6587,9 @@ bool rate_usable_index_exists(struct ieee80211_supported_band *sband,
 {
 	unsigned int i;
 
+	if (sband->band == NL80211_BAND_S1GHZ)
+		return true;
+
 	for (i = 0; i < sband->n_bitrates; i++)
 		if (rate_supported(sta, sband->band, i))
 			return true;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 03ed90ce9a84..7cbf85338c9e 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -747,8 +747,16 @@ void sta_set_rate_info_tx(struct sta_info *sta,
 			  const struct ieee80211_tx_rate *rate,
 			  struct rate_info *rinfo)
 {
+	struct ieee80211_supported_band *sband;
+
+	sband = ieee80211_get_sband(sta->sdata);
 	rinfo->flags = 0;
-	if (rate->flags & IEEE80211_TX_RC_MCS) {
+	if (rate->flags & IEEE80211_TX_RC_S1G_MCS &&
+	    sband->band == NL80211_BAND_S1GHZ) {
+		rinfo->flags |= RATE_INFO_FLAGS_S1G_MCS;
+		rinfo->mcs = ieee80211_rate_get_s1g_mcs(rate);
+		rinfo->nss = ieee80211_rate_get_s1g_nss(rate);
+	} else if (rate->flags & IEEE80211_TX_RC_MCS) {
 		rinfo->flags |= RATE_INFO_FLAGS_MCS;
 		rinfo->mcs = rate->idx;
 	} else if (rate->flags & IEEE80211_TX_RC_VHT_MCS) {
@@ -756,25 +764,37 @@ void sta_set_rate_info_tx(struct sta_info *sta,
 		rinfo->mcs = ieee80211_rate_get_vht_mcs(rate);
 		rinfo->nss = ieee80211_rate_get_vht_nss(rate);
 	} else {
-		struct ieee80211_supported_band *sband;
 		int shift = ieee80211_vif_get_shift(&sta->sdata->vif);
 		u16 brate;
 
-		sband = ieee80211_get_sband(sta->sdata);
 		WARN_ON_ONCE(sband && !sband->bitrates);
 		if (sband && sband->bitrates) {
 			brate = sband->bitrates[rate->idx].bitrate;
 			rinfo->legacy = DIV_ROUND_UP(brate, 1 << shift);
 		}
 	}
-	if (rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
-		rinfo->bw = RATE_INFO_BW_40;
-	else if (rate->flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
-		rinfo->bw = RATE_INFO_BW_80;
-	else if (rate->flags & IEEE80211_TX_RC_160_MHZ_WIDTH)
-		rinfo->bw = RATE_INFO_BW_160;
-	else
-		rinfo->bw = RATE_INFO_BW_20;
+	if (sband->band == NL80211_BAND_S1GHZ) {
+		if (rate->flags & IEEE80211_TX_RC_2_MHZ_WIDTH)
+			rinfo->bw = RATE_INFO_BW_2;
+		else if (rate->flags & IEEE80211_TX_RC_4_MHZ_WIDTH)
+			rinfo->bw = RATE_INFO_BW_4;
+		else if (rate->flags & IEEE80211_TX_RC_8_MHZ_WIDTH)
+			rinfo->bw = RATE_INFO_BW_8;
+		else if (rate->flags & IEEE80211_TX_RC_16_MHZ_WIDTH)
+			rinfo->bw = RATE_INFO_BW_16;
+		else
+			rinfo->bw = RATE_INFO_BW_1;
+	} else {
+		if (rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
+			rinfo->bw = RATE_INFO_BW_40;
+		else if (rate->flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
+			rinfo->bw = RATE_INFO_BW_80;
+		else if (rate->flags & IEEE80211_TX_RC_160_MHZ_WIDTH)
+			rinfo->bw = RATE_INFO_BW_160;
+		else
+			rinfo->bw = RATE_INFO_BW_20;
+	}
+
 	if (rate->flags & IEEE80211_TX_RC_SHORT_GI)
 		rinfo->flags |= RATE_INFO_FLAGS_SHORT_GI;
 }
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index d46eeebedb4b..9eab2af626d6 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5106,6 +5106,14 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
 				      status->rate_idx, status->nss))
 				goto drop;
 			break;
+		case RX_ENC_S1G:
+			if (WARN_ONCE(status->rate_idx > 10 ||
+				      !status->nss ||
+				      status->nss > 8,
+				      "Rate marked as a S1G rate but data is invalid: MCS: %d, NSS: %d\n",
+				      status->rate_idx, status->nss))
+				goto drop;
+			break;
 		default:
 			WARN_ON_ONCE(1);
 			fallthrough;
diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index cb23da9aff1e..331f5551477e 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2295,6 +2295,13 @@ static void sta_stats_decode_rate(struct ieee80211_local *local, u32 rate,
 		rinfo->he_ru_alloc = STA_STATS_GET(HE_RU, rate);
 		rinfo->he_dcm = STA_STATS_GET(HE_DCM, rate);
 		break;
+	case STA_STATS_RATE_TYPE_S1G:
+		rinfo->flags = RATE_INFO_FLAGS_S1G_MCS;
+		rinfo->mcs = STA_STATS_GET(S1G_MCS, rate);
+		rinfo->nss = STA_STATS_GET(S1G_NSS, rate);
+		if (STA_STATS_GET(SGI, rate))
+			rinfo->flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
 	}
 }
 
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 2eb3a9452e07..1c0547769803 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -935,6 +935,8 @@ enum sta_stats_type {
 #define STA_STATS_FIELD_VHT_NSS		GENMASK( 7,  4)
 #define STA_STATS_FIELD_HE_MCS		GENMASK( 3,  0)
 #define STA_STATS_FIELD_HE_NSS		GENMASK( 7,  4)
+#define STA_STATS_FIELD_S1G_MCS		GENMASK( 3,  0)
+#define STA_STATS_FIELD_S1G_NSS		GENMASK( 7,  4)
 #define STA_STATS_FIELD_BW		GENMASK(11,  8)
 #define STA_STATS_FIELD_SGI		GENMASK(12, 12)
 #define STA_STATS_FIELD_TYPE		GENMASK(15, 13)
@@ -979,6 +981,11 @@ static inline u32 sta_stats_encode_rate(struct ieee80211_rx_status *s)
 		r |= STA_STATS_FIELD(HE_RU, s->he_ru);
 		r |= STA_STATS_FIELD(HE_DCM, s->he_dcm);
 		break;
+	case RX_ENC_S1G:
+		r |= STA_STATS_FIELD(TYPE, STA_STATS_RATE_TYPE_S1G);
+		r |= STA_STATS_FIELD(S1G_NSS, s->nss);
+		r |= STA_STATS_FIELD(S1G_MCS, s->rate_idx);
+		break;
 	default:
 		WARN_ON(1);
 		return STA_STATS_RATE_INVALID;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 78e8c286011e..5147f688751d 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3929,7 +3929,7 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 	u64 ts = status->mactime;
 	struct rate_info ri;
 	u16 rate;
-	u8 n_ltf;
+	u8 n_ltf, guard_factor;
 
 	if (WARN_ON(!ieee80211_have_rx_timestamp(status)))
 		return 0;
@@ -4016,6 +4016,34 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 			ts += 4 * n_ltf;
 		}
 
+		break;
+	case RX_ENC_S1G:
+		/* Set to duration of S1G OFDM symbol with normal GI */
+		guard_factor = 40;
+		ri.flags |= RATE_INFO_FLAGS_S1G_MCS;
+		ri.mcs = status->rate_idx;
+		ri.nss = status->nss;
+		if (status->enc_flags & RX_ENC_FLAG_SHORT_GI) {
+			ri.flags |= RATE_INFO_FLAGS_SHORT_GI;
+			guard_factor = 36;
+		}
+
+		/*
+		 * See 80211-2020, section 23.3.2 for S1G PPDU
+		 * format and 23.3.6 for timing-related parameters.
+		 * Here using the general structure for S1G_1M as
+		 * in figure 23-3.
+		 */
+		if (status->flag & RX_FLAG_MACTIME_PLCP_START) {
+			mpdu_offset += 2;
+			ts += (14 * guard_factor);
+
+			/* Add S1G-LTFs per streams */
+			n_ltf = (ri.nss != 1) && (ri.nss % 2) ?
+				ri.nss + 1 : ri.nss;
+			ts += (guard_factor * n_ltf);
+		}
+
 		break;
 	default:
 		WARN_ON(1);
-- 
2.25.1

