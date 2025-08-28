Return-Path: <linux-wireless+bounces-26754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 272BBB39CDD
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 14:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0D4BA0007D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 12:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A4630BBA6;
	Thu, 28 Aug 2025 12:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="fS9IFrVi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D1E3101C6
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383482; cv=none; b=cuB5NaocqrF8mdaB5APvumMQN9I4x8gXHmK9LY/GDPBgXA2xfqvQUCMhGwac7rFEkbCVDB86B2R6+4uYVXJsaPTB6yfSsPgEh0BPmiXiaMC27/r9AapCq+olgUDOEWdAC6OtM06b/OkpxXOPjdYzX+TaD9IGTHrh3oNurl4hE3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383482; c=relaxed/simple;
	bh=oEIY0TWxlh1TsB0J9OqBYnyyg5kfmfXmtW40yaSiJUo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cqIKrsTe114PsA3qjnSdFfGvH9lyFADZohJfInOQpnhb868CW5QV4EUsNUQyasQmJlS0Tdws6SZDi3JRdVBEyHasGUfCa+OuohEsq8dqbtrTBRzr8VeeeELpOP4G7FVARzuXbJWLdbE7l30AiJEhc5wB3Mmh3RQv+M5h3YZSCeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=fS9IFrVi; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=FH40bCZyR0T19YP6TIa1yVusJxHYJS73kzEgGPS7Fpk=; b=fS9IFrVi8AeS8U7FN1E6Tqi6Ow
	Pmooe1cb34jrgDZ0x9aaaDpMxq/F1yCCAyHxJjPrsNfs1M9jQwEhHEr4c7X8dL2RoXrpygEex8oSz
	5dgy6enJoRbwRQoAHV1+VY3wE3elV4b2UdKaNCtE6Zjab7PjZL8EOGcBchIzv4RwXWeU=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1urbZg-00GFXd-0O;
	Thu, 28 Aug 2025 14:17:52 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH 1/2] wifi: mac80211: factor out part of ieee80211_calc_expected_tx_airtime
Date: Thu, 28 Aug 2025 14:17:50 +0200
Message-ID: <20250828121751.78077-1-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create ieee80211_rate_expected_tx_airtime helper function, which returns
the expected tx airtime for a given rate and packet length in units of
1024 usec, for more accuracy.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/airtime.c     | 87 ++++++++++++++++++++++----------------
 net/mac80211/ieee80211_i.h |  5 +++
 2 files changed, 56 insertions(+), 36 deletions(-)

diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index c61df637232a..0c54cdbd753c 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -685,7 +685,7 @@ static int ieee80211_fill_rx_status(struct ieee80211_rx_status *stat,
 	if (ieee80211_fill_rate_info(hw, stat, band, ri))
 		return 0;
 
-	if (!ieee80211_rate_valid(rate))
+	if (!rate || !ieee80211_rate_valid(rate))
 		return -1;
 
 	if (rate->flags & IEEE80211_TX_RC_160_MHZ_WIDTH)
@@ -753,6 +753,53 @@ u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL_GPL(ieee80211_calc_tx_airtime);
 
+u32 ieee80211_rate_expected_tx_airtime(struct ieee80211_hw *hw,
+				       struct ieee80211_tx_rate *tx_rate,
+				       struct rate_info *ri,
+				       enum nl80211_band band,
+				       bool ampdu, int len)
+{
+	struct ieee80211_rx_status stat;
+	u32 duration, overhead;
+	u8 agg_shift;
+
+	if (ieee80211_fill_rx_status(&stat, hw, tx_rate, ri, band, len))
+		return 0;
+
+	if (stat.encoding == RX_ENC_LEGACY || !ampdu)
+		return ieee80211_calc_rx_airtime(hw, &stat, len) * 1024;
+
+	duration = ieee80211_get_rate_duration(hw, &stat, &overhead);
+
+	/*
+	 * Assume that HT/VHT transmission on any AC except VO will
+	 * use aggregation. Since we don't have reliable reporting
+	 * of aggregation length, assume an average size based on the
+	 * tx rate.
+	 * This will not be very accurate, but much better than simply
+	 * assuming un-aggregated tx in all cases.
+	 */
+	if (duration > 400 * 1024) /* <= VHT20 MCS2 1S */
+		agg_shift = 1;
+	else if (duration > 250 * 1024) /* <= VHT20 MCS3 1S or MCS1 2S */
+		agg_shift = 2;
+	else if (duration > 150 * 1024) /* <= VHT20 MCS5 1S or MCS2 2S */
+		agg_shift = 3;
+	else if (duration > 70 * 1024) /* <= VHT20 MCS5 2S */
+		agg_shift = 4;
+	else if (stat.encoding != RX_ENC_HE ||
+		 duration > 20 * 1024) /* <= HE40 MCS6 2S */
+		agg_shift = 5;
+	else
+		agg_shift = 6;
+
+	duration *= len;
+	duration /= AVG_PKT_SIZE;
+	duration += (overhead * 1024 >> agg_shift);
+
+	return duration;
+}
+
 u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_sta *pubsta,
@@ -775,45 +822,13 @@ u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 	if (pubsta) {
 		struct sta_info *sta = container_of(pubsta, struct sta_info,
 						    sta);
-		struct ieee80211_rx_status stat;
 		struct ieee80211_tx_rate *tx_rate = &sta->deflink.tx_stats.last_rate;
 		struct rate_info *ri = &sta->deflink.tx_stats.last_rate_info;
-		u32 duration, overhead;
-		u8 agg_shift;
+		u32 duration;
 
-		if (ieee80211_fill_rx_status(&stat, hw, tx_rate, ri, band, len))
-			return 0;
-
-		if (stat.encoding == RX_ENC_LEGACY || !ampdu)
-			return ieee80211_calc_rx_airtime(hw, &stat, len);
-
-		duration = ieee80211_get_rate_duration(hw, &stat, &overhead);
-		/*
-		 * Assume that HT/VHT transmission on any AC except VO will
-		 * use aggregation. Since we don't have reliable reporting
-		 * of aggregation length, assume an average size based on the
-		 * tx rate.
-		 * This will not be very accurate, but much better than simply
-		 * assuming un-aggregated tx in all cases.
-		 */
-		if (duration > 400 * 1024) /* <= VHT20 MCS2 1S */
-			agg_shift = 1;
-		else if (duration > 250 * 1024) /* <= VHT20 MCS3 1S or MCS1 2S */
-			agg_shift = 2;
-		else if (duration > 150 * 1024) /* <= VHT20 MCS5 1S or MCS2 2S */
-			agg_shift = 3;
-		else if (duration > 70 * 1024) /* <= VHT20 MCS5 2S */
-			agg_shift = 4;
-		else if (stat.encoding != RX_ENC_HE ||
-			 duration > 20 * 1024) /* <= HE40 MCS6 2S */
-			agg_shift = 5;
-		else
-			agg_shift = 6;
-
-		duration *= len;
-		duration /= AVG_PKT_SIZE;
+		duration = ieee80211_rate_expected_tx_airtime(hw, tx_rate, ri,
+							      band, true, len);
 		duration /= 1024;
-		duration += (overhead >> agg_shift);
 
 		return max_t(u32, duration, 4);
 	}
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 8afa2404eaa8..d693314596f7 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2816,6 +2816,11 @@ u8 *ieee80211_get_bssid(struct ieee80211_hdr *hdr, size_t len,
 
 extern const struct ethtool_ops ieee80211_ethtool_ops;
 
+u32 ieee80211_rate_expected_tx_airtime(struct ieee80211_hw *hw,
+				       struct ieee80211_tx_rate *tx_rate,
+				       struct rate_info *ri,
+				       enum nl80211_band band,
+				       bool ampdu, int len);
 u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_sta *pubsta,
-- 
2.51.0


