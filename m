Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885DA24DAF9
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Aug 2020 18:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgHUQbz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Aug 2020 12:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgHUQat (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Aug 2020 12:30:49 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA3DC061573
        for <linux-wireless@vger.kernel.org>; Fri, 21 Aug 2020 09:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uQhJQQITnz3C7SLVQCD8u+Bt7Iip0mypnEhGuUSJQ30=; b=jSr/Rf3OVabsTM5ssWvTEPl2c6
        O8ImjrVlg6xnELOffGzRvJHN4GK0l+b+d8AuFrw32W9QXFse4HnQum73CpJYMBKaHKZYJ9/8Laieb
        edYpGFaLmi9tENdHwUQlB6HzmZNB/UsG++58Oim57R6subCaQ33z3KnmuT43uI+EeG6c=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k99wF-0003et-3a; Fri, 21 Aug 2020 18:30:47 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 5.9 v2 1/3] mac80211: use rate provided via status->rate on ieee80211_tx_status_ext for AQL
Date:   Fri, 21 Aug 2020 18:30:43 +0200
Message-Id: <20200821163045.62140-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since ieee80211_tx_info does not have enough room to encode HE rates, HE
drivers use status->rate to provide rate info.
Store it in struct sta_info and use it for AQL.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/airtime.c  | 53 +++++++++++++++++++++++++++++++++++++++--
 net/mac80211/sta_info.h |  1 +
 net/mac80211/status.c   | 12 ++++++----
 3 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index 366f76c9003d..656c9a033714 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -487,14 +487,61 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
 }
 EXPORT_SYMBOL_GPL(ieee80211_calc_rx_airtime);
 
+static bool ieee80211_fill_rate_info(struct ieee80211_hw *hw,
+				     struct ieee80211_rx_status *stat, u8 band,
+				     struct rate_info *ri)
+{
+	struct ieee80211_supported_band *sband = hw->wiphy->bands[band];
+	int i;
+
+	if (!ri || !sband)
+	    return false;
+
+	stat->bw = ri->bw;
+	stat->nss = ri->nss;
+	stat->rate_idx = ri->mcs;
+
+	if (ri->flags & RATE_INFO_FLAGS_HE_MCS)
+		stat->encoding = RX_ENC_HE;
+	else if (ri->flags & RATE_INFO_FLAGS_VHT_MCS)
+		stat->encoding = RX_ENC_VHT;
+	else if (ri->flags & RATE_INFO_FLAGS_MCS)
+		stat->encoding = RX_ENC_HT;
+	else
+		stat->encoding = RX_ENC_LEGACY;
+
+	if (ri->flags & RATE_INFO_FLAGS_SHORT_GI)
+		stat->enc_flags |= RX_ENC_FLAG_SHORT_GI;
+
+	stat->he_gi = ri->he_gi;
+
+	if (stat->encoding != RX_ENC_LEGACY)
+		return true;
+
+	stat->rate_idx = 0;
+	for (i = 0; i < sband->n_bitrates; i++) {
+		if (ri->legacy != sband->bitrates[i].bitrate)
+			continue;
+
+		stat->rate_idx = i;
+		return true;
+	}
+
+	return false;
+}
+
 static u32 ieee80211_calc_tx_airtime_rate(struct ieee80211_hw *hw,
 					  struct ieee80211_tx_rate *rate,
+					  struct rate_info *ri,
 					  u8 band, int len)
 {
 	struct ieee80211_rx_status stat = {
 		.band = band,
 	};
 
+	if (ieee80211_fill_rate_info(hw, &stat, band, ri))
+		goto out;
+
 	if (rate->idx < 0 || !rate->count)
 		return 0;
 
@@ -522,6 +569,7 @@ static u32 ieee80211_calc_tx_airtime_rate(struct ieee80211_hw *hw,
 		stat.encoding = RX_ENC_LEGACY;
 	}
 
+out:
 	return ieee80211_calc_rx_airtime(hw, &stat, len);
 }
 
@@ -536,7 +584,7 @@ u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
 		struct ieee80211_tx_rate *rate = &info->status.rates[i];
 		u32 cur_duration;
 
-		cur_duration = ieee80211_calc_tx_airtime_rate(hw, rate,
+		cur_duration = ieee80211_calc_tx_airtime_rate(hw, rate, NULL,
 							      info->band, len);
 		if (!cur_duration)
 			break;
@@ -573,6 +621,7 @@ u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 		struct sta_info *sta = container_of(pubsta, struct sta_info,
 						    sta);
 		struct ieee80211_tx_rate *rate = &sta->tx_stats.last_rate;
+		struct rate_info *ri = &sta->tx_stats.last_rate_info;
 		u32 airtime;
 
 		if (!(rate->flags & (IEEE80211_TX_RC_VHT_MCS |
@@ -586,7 +635,7 @@ u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 		 * This will not be very accurate, but much better than simply
 		 * assuming un-aggregated tx.
 		 */
-		airtime = ieee80211_calc_tx_airtime_rate(hw, rate, band,
+		airtime = ieee80211_calc_tx_airtime_rate(hw, rate, ri, band,
 							 ampdu ? len * 16 : len);
 		if (ampdu)
 			airtime /= 16;
diff --git a/net/mac80211/sta_info.h b/net/mac80211/sta_info.h
index 9d398c9daa4c..8060d142e4f1 100644
--- a/net/mac80211/sta_info.h
+++ b/net/mac80211/sta_info.h
@@ -611,6 +611,7 @@ struct sta_info {
 		u64 packets[IEEE80211_NUM_ACS];
 		u64 bytes[IEEE80211_NUM_ACS];
 		struct ieee80211_tx_rate last_rate;
+		struct rate_info last_rate_info;
 		u64 msdu[IEEE80211_NUM_TIDS + 1];
 	} tx_stats;
 	u16 tid_seq[IEEE80211_QOS_CTL_TID_MASK + 1];
diff --git a/net/mac80211/status.c b/net/mac80211/status.c
index adb1d30ce06e..6de63f1d8c7b 100644
--- a/net/mac80211/status.c
+++ b/net/mac80211/status.c
@@ -1137,9 +1137,17 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 	struct ieee80211_tx_info *info = status->info;
 	struct ieee80211_sta *pubsta = status->sta;
 	struct ieee80211_supported_band *sband;
+	struct sta_info *sta;
 	int retry_count;
 	bool acked, noack_success;
 
+	if (pubsta) {
+		sta = container_of(pubsta, struct sta_info, sta);
+
+		if (status->rate)
+			sta->tx_stats.last_rate_info = *status->rate;
+	}
+
 	if (status->skb)
 		return __ieee80211_tx_status(hw, status);
 
@@ -1154,10 +1162,6 @@ void ieee80211_tx_status_ext(struct ieee80211_hw *hw,
 	noack_success = !!(info->flags & IEEE80211_TX_STAT_NOACK_TRANSMITTED);
 
 	if (pubsta) {
-		struct sta_info *sta;
-
-		sta = container_of(pubsta, struct sta_info, sta);
-
 		if (!acked && !noack_success)
 			sta->status_stats.retry_failed++;
 		sta->status_stats.retry_count += retry_count;
-- 
2.28.0

