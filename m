Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1989456D267
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jul 2022 03:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiGKBJb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Jul 2022 21:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiGKBJ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Jul 2022 21:09:27 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4467C16584
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:09:21 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b8so2165713pjo.5
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eACZUBR6D3EsRDShUX90rju2qike1PMAdJxvFDl2bkM=;
        b=LtRbp/byFZow/OrvLRqgZHxJin/wPOtLgSiTvBWFF58VFsGTLHNXQIsODzCy7Adpix
         V93uJGN3YyJkv/aaNYCBWrqCsl0oJmmZxDirSnerc1v5hcmvR6hejkIX8mg1VhzQqGtr
         cjMOG0HiyrvQArs+IDkUgZLMxcDVhuCGVqMbjDLkPoqN6nmn1u23nBuPD1uajTVopq75
         eAwnu6iBXyGhUR2ziIHRbQKHFLZadPyhtlLWvsuel3u2idAb1fPgDrJoyDp18FXvSUva
         y4iAUO0YMZSMRxe1/8QOBxpDVwLvkaMfinO6TEx3qKRaO+QTIUl6Nr1l80zTQEuszQ2w
         Zd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eACZUBR6D3EsRDShUX90rju2qike1PMAdJxvFDl2bkM=;
        b=h2COcp+EFtwKIlfJX6bDXpMcn/gaf/0Rqj7NKok2Z2ytWP7BmAmjLNFcSDWvHDJkKW
         vOtq7ilDQMPC0pppLQgXHf6745OoalC97snoAZJFahQCS8ajynuS6TnHeeIEHxebjRjI
         dxAaPVMF2/ZhCW02bYiUa0bN2RT02dASbBTrs49F0iEc+Di97qFwhgQUybkl8F9S/Sea
         PjuXMHNQ9mhvt0eOLtv7dMRIdKXgf9v/LaEL9H5gMAlIorMDKTTFVxS7PhHnagHdUz8/
         6ExrydHurrQx1VX9cPKnTV6VFvNHyg07Q7s9o1fkE1/QHXuGZIQF7ULDJYJ9mlZjye5S
         F4Fg==
X-Gm-Message-State: AJIora+jUM2b/w12zdtUs85XYskAmAMpX3HaujQE/X6HMO8Ign0x6yfm
        ZgKVNilITmYOWYOdozngmlK+Kg==
X-Google-Smtp-Source: AGRyM1uRrD4IaAIfGPcsQawoV0DnxGSEcmeBWUv6aunnK0+NCwcvT9yCqJDfqUYE3JJU6QV+eXVoog==
X-Received: by 2002:a17:902:a502:b0:151:8289:b19 with SMTP id s2-20020a170902a50200b0015182890b19mr15997453plq.149.1657501760715;
        Sun, 10 Jul 2022 18:09:20 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij5-20020a170902ab4500b0015e8d4eb1dbsm3341330plb.37.2022.07.10.18.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 18:09:20 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Bassem Dawood <bassem@morsemicro.com>
Subject: [PATCH 10/12] mac80211: support S1G rate encoding.
Date:   Mon, 11 Jul 2022 01:08:14 +0000
Message-Id: <20220711010816.45927-11-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
References: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
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
Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
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
index c5bb97b381cf..304249038ac6 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1547,7 +1547,7 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 	memset(&rx_status, 0, sizeof(rx_status));
 	rx_status.flag |= RX_FLAG_MACTIME_START;
 	rx_status.freq = chan->center_freq;
-	rx_status.freq_offset = chan->freq_offset ? 1 : 0;
+	rx_status.freq_offset = chan->freq_offset;
 	rx_status.band = chan->band;
 	if (info->control.rates[0].flags & IEEE80211_TX_RC_VHT_MCS) {
 		rx_status.rate_idx =
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 1fd461ed746d..93fe4b98017c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -848,6 +848,10 @@ enum mac80211_tx_info_flags {
 #define IEEE80211_TX_CTL_STBC_SHIFT		23
 
 #define IEEE80211_TX_RC_S1G_MCS IEEE80211_TX_RC_VHT_MCS
+#define IEEE80211_TX_RC_2_MHZ_WIDTH IEEE80211_TX_RC_MCS
+#define IEEE80211_TX_RC_4_MHZ_WIDTH IEEE80211_TX_RC_40_MHZ_WIDTH
+#define IEEE80211_TX_RC_8_MHZ_WIDTH IEEE80211_TX_RC_80_MHZ_WIDTH
+#define IEEE80211_TX_RC_16_MHZ_WIDTH IEEE80211_TX_RC_160_MHZ_WIDTH
 
 /**
  * enum mac80211_tx_control_flags - flags to describe transmit control
@@ -1028,6 +1032,20 @@ ieee80211_rate_get_vht_nss(const struct ieee80211_tx_rate *rate)
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
@@ -1408,6 +1426,7 @@ enum mac80211_rx_encoding {
 	RX_ENC_HT,
 	RX_ENC_VHT,
 	RX_ENC_HE,
+	RX_ENC_S1G,
 };
 
 /**
@@ -1458,10 +1477,11 @@ struct ieee80211_rx_status {
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
@@ -1477,8 +1497,7 @@ struct ieee80211_rx_status {
 static inline u32
 ieee80211_rx_status_to_khz(struct ieee80211_rx_status *rx_status)
 {
-	return MHZ_TO_KHZ(rx_status->freq) +
-	       (rx_status->freq_offset ? 500 : 0);
+	return MHZ_TO_KHZ(rx_status->freq) + rx_status->freq_offset;
 }
 
 /**
@@ -6506,6 +6525,9 @@ bool rate_usable_index_exists(struct ieee80211_supported_band *sband,
 {
 	unsigned int i;
 
+	if (sband->band == NL80211_BAND_S1GHZ)
+		return true;
+
 	for (i = 0; i < sband->n_bitrates; i++)
 		if (rate_supported(sta, sband->band, i))
 			return true;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index b4c2f4e9083e..a5511eb56dd9 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -743,8 +743,16 @@ void sta_set_rate_info_tx(struct sta_info *sta,
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
@@ -752,25 +760,37 @@ void sta_set_rate_info_tx(struct sta_info *sta,
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
index feab1d58e932..e0a2975d0959 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4982,6 +4982,14 @@ void ieee80211_rx_list(struct ieee80211_hw *hw, struct ieee80211_sta *pubsta,
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
index 014032369994..da03d4eef321 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2297,6 +2297,13 @@ static void sta_stats_decode_rate(struct ieee80211_local *local, u32 rate,
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
index 218430790660..d2173a191da4 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -931,6 +931,8 @@ enum sta_stats_type {
 #define STA_STATS_FIELD_VHT_NSS		GENMASK( 7,  4)
 #define STA_STATS_FIELD_HE_MCS		GENMASK( 3,  0)
 #define STA_STATS_FIELD_HE_NSS		GENMASK( 7,  4)
+#define STA_STATS_FIELD_S1G_MCS		GENMASK( 3,  0)
+#define STA_STATS_FIELD_S1G_NSS		GENMASK( 7,  4)
 #define STA_STATS_FIELD_BW		GENMASK(11,  8)
 #define STA_STATS_FIELD_SGI		GENMASK(12, 12)
 #define STA_STATS_FIELD_TYPE		GENMASK(15, 13)
@@ -975,6 +977,11 @@ static inline u32 sta_stats_encode_rate(struct ieee80211_rx_status *s)
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
index 51a2c1dee360..8b896aec5f8c 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3861,7 +3861,7 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
 	u64 ts = status->mactime;
 	struct rate_info ri;
 	u16 rate;
-	u8 n_ltf;
+	u8 n_ltf, guard_factor;
 
 	if (WARN_ON(!ieee80211_have_rx_timestamp(status)))
 		return 0;
@@ -3948,6 +3948,34 @@ u64 ieee80211_calculate_rx_timestamp(struct ieee80211_local *local,
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

