Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE66243CD1
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Aug 2020 17:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgHMPwT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Aug 2020 11:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHMPwT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Aug 2020 11:52:19 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F2FC061757
        for <linux-wireless@vger.kernel.org>; Thu, 13 Aug 2020 08:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EcmDpehXQVRR4b2VHpiPDhS5Td8u2I9W4Wg0/imCyv0=; b=hcQ66GTWRdrDYQ9/aEs0UABJGj
        +BnWV7/PTEhEHtiNcdWR05jTvf5+xBatgF/tYKmRXAgQNvBFC8bmpe6wJEpF/wWBIQSco99jHRZ1F
        7dNtITDMCr4LEOMCqYkoHj6Gj2Zjbnq9pjEQtRZ4zR7LXPXmq521yQpuxtEr9wGMJkhY=;
Received: from p54ae996c.dip0.t-ipconnect.de ([84.174.153.108] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k6FWY-0000Cc-3u; Thu, 13 Aug 2020 17:52:14 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 5.9 2/3] mac80211: factor out code to look up the average packet length duration for a rate
Date:   Thu, 13 Aug 2020 17:52:11 +0200
Message-Id: <20200813155212.97884-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813155212.97884-1-nbd@nbd.name>
References: <20200813155212.97884-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This will be used to enhance AQL estimated aggregation length

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/airtime.c | 120 +++++++++++++++++++++++++----------------
 1 file changed, 73 insertions(+), 47 deletions(-)

diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index 656c9a033714..2d959b22b141 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -405,18 +405,14 @@ ieee80211_calc_legacy_rate_duration(u16 bitrate, bool short_pre,
 	return duration;
 }
 
-u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
-			      struct ieee80211_rx_status *status,
-			      int len)
+static u32 ieee80211_get_rate_duration(struct ieee80211_hw *hw,
+				       struct ieee80211_rx_status *status,
+				       u32 *overhead)
 {
-	struct ieee80211_supported_band *sband;
-	const struct ieee80211_rate *rate;
 	bool sgi = status->enc_flags & RX_ENC_FLAG_SHORT_GI;
-	bool sp = status->enc_flags & RX_ENC_FLAG_SHORTPRE;
 	int bw, streams;
 	int group, idx;
 	u32 duration;
-	bool cck;
 
 	switch (status->bw) {
 	case RATE_INFO_BW_20:
@@ -437,20 +433,6 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
 	}
 
 	switch (status->encoding) {
-	case RX_ENC_LEGACY:
-		if (WARN_ON_ONCE(status->band > NL80211_BAND_5GHZ))
-			return 0;
-
-		sband = hw->wiphy->bands[status->band];
-		if (!sband || status->rate_idx >= sband->n_bitrates)
-			return 0;
-
-		rate = &sband->bitrates[status->rate_idx];
-		cck = rate->flags & IEEE80211_RATE_MANDATORY_B;
-
-		return ieee80211_calc_legacy_rate_duration(rate->bitrate, sp,
-							   cck, len);
-
 	case RX_ENC_VHT:
 		streams = status->nss;
 		idx = status->rate_idx;
@@ -477,13 +459,47 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
 
 	duration = airtime_mcs_groups[group].duration[idx];
 	duration <<= airtime_mcs_groups[group].shift;
+	*overhead = 36 + (streams << 2);
+
+	return duration;
+}
+
+
+u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
+			      struct ieee80211_rx_status *status,
+			      int len)
+{
+	struct ieee80211_supported_band *sband;
+	u32 duration, overhead = 0;
+
+	if (status->encoding == RX_ENC_LEGACY) {
+		const struct ieee80211_rate *rate;
+		bool sp = status->enc_flags & RX_ENC_FLAG_SHORTPRE;
+		bool cck;
+
+		if (WARN_ON_ONCE(status->band > NL80211_BAND_5GHZ))
+			return 0;
+
+		sband = hw->wiphy->bands[status->band];
+		if (!sband || status->rate_idx >= sband->n_bitrates)
+			return 0;
+
+		rate = &sband->bitrates[status->rate_idx];
+		cck = rate->flags & IEEE80211_RATE_MANDATORY_B;
+
+		return ieee80211_calc_legacy_rate_duration(rate->bitrate, sp,
+							   cck, len);
+	}
+
+	duration = ieee80211_get_rate_duration(hw, status, &overhead);
+	if (!duration)
+		return 0;
+
 	duration *= len;
 	duration /= AVG_PKT_SIZE;
 	duration /= 1024;
 
-	duration += 36 + (streams << 2);
-
-	return duration;
+	return duration + overhead;
 }
 EXPORT_SYMBOL_GPL(ieee80211_calc_rx_airtime);
 
@@ -530,46 +546,56 @@ static bool ieee80211_fill_rate_info(struct ieee80211_hw *hw,
 	return false;
 }
 
-static u32 ieee80211_calc_tx_airtime_rate(struct ieee80211_hw *hw,
-					  struct ieee80211_tx_rate *rate,
-					  struct rate_info *ri,
-					  u8 band, int len)
+static int ieee80211_fill_rx_status(struct ieee80211_rx_status *stat,
+				    struct ieee80211_hw *hw,
+				    struct ieee80211_tx_rate *rate,
+				    struct rate_info *ri, u8 band, int len)
 {
-	struct ieee80211_rx_status stat = {
-		.band = band,
-	};
+	memset(stat, 0, sizeof(*stat));
+	stat->band = band;
 
-	if (ieee80211_fill_rate_info(hw, &stat, band, ri))
-		goto out;
+	if (ieee80211_fill_rate_info(hw, stat, band, ri))
+		return 0;
 
 	if (rate->idx < 0 || !rate->count)
-		return 0;
+		return -1;
 
 	if (rate->flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
-		stat.bw = RATE_INFO_BW_80;
+		stat->bw = RATE_INFO_BW_80;
 	else if (rate->flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
-		stat.bw = RATE_INFO_BW_40;
+		stat->bw = RATE_INFO_BW_40;
 	else
-		stat.bw = RATE_INFO_BW_20;
+		stat->bw = RATE_INFO_BW_20;
 
-	stat.enc_flags = 0;
+	stat->enc_flags = 0;
 	if (rate->flags & IEEE80211_TX_RC_USE_SHORT_PREAMBLE)
-		stat.enc_flags |= RX_ENC_FLAG_SHORTPRE;
+		stat->enc_flags |= RX_ENC_FLAG_SHORTPRE;
 	if (rate->flags & IEEE80211_TX_RC_SHORT_GI)
-		stat.enc_flags |= RX_ENC_FLAG_SHORT_GI;
+		stat->enc_flags |= RX_ENC_FLAG_SHORT_GI;
 
-	stat.rate_idx = rate->idx;
+	stat->rate_idx = rate->idx;
 	if (rate->flags & IEEE80211_TX_RC_VHT_MCS) {
-		stat.encoding = RX_ENC_VHT;
-		stat.rate_idx = ieee80211_rate_get_vht_mcs(rate);
-		stat.nss = ieee80211_rate_get_vht_nss(rate);
+		stat->encoding = RX_ENC_VHT;
+		stat->rate_idx = ieee80211_rate_get_vht_mcs(rate);
+		stat->nss = ieee80211_rate_get_vht_nss(rate);
 	} else if (rate->flags & IEEE80211_TX_RC_MCS) {
-		stat.encoding = RX_ENC_HT;
+		stat->encoding = RX_ENC_HT;
 	} else {
-		stat.encoding = RX_ENC_LEGACY;
+		stat->encoding = RX_ENC_LEGACY;
 	}
 
-out:
+	return 0;
+}
+
+static u32 ieee80211_calc_tx_airtime_rate(struct ieee80211_hw *hw,
+					  struct ieee80211_tx_rate *rate,
+					  struct rate_info *ri,
+					  u8 band, int len)
+{
+	struct ieee80211_rx_status stat;
+
+	ieee80211_fill_rx_status(&stat, hw, rate, ri, band, len);
+
 	return ieee80211_calc_rx_airtime(hw, &stat, len);
 }
 
-- 
2.28.0

