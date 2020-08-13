Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6369B243CD0
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Aug 2020 17:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHMPwU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Aug 2020 11:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgHMPwT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Aug 2020 11:52:19 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70CCC061384
        for <linux-wireless@vger.kernel.org>; Thu, 13 Aug 2020 08:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=kYglcNj8/+I8pmxtgchmAGHMlWTTzciOicDgj460Lbc=; b=r/058piGzC2TJ57ZPP/Tq4ir/N
        9tTIUG6o7QY0pBzkE15alx891So2eFvjGTKqNYWZMB0EYl88E3nKdjTbbHK/0uoa6tfurS3Um0jUL
        keoD5+gvsEJ2RVukpBAFGPAlZ5puf88b+cE3oU/70tJB+YY+xRriR39RNgEOVb0F6YWg=;
Received: from p54ae996c.dip0.t-ipconnect.de ([84.174.153.108] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k6FWY-0000Cc-Aj; Thu, 13 Aug 2020 17:52:14 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH 5.9 3/3] mac80211: improve AQL aggregation estimation for low data rates
Date:   Thu, 13 Aug 2020 17:52:12 +0200
Message-Id: <20200813155212.97884-3-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813155212.97884-1-nbd@nbd.name>
References: <20200813155212.97884-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Links with low data rates use much smaller aggregates and are much more
sensitive to latency added by bufferbloat.
Tune the assumed aggregation length based on the tx rate duration.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/airtime.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index 2d959b22b141..6a46771f9d54 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -646,27 +646,40 @@ u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 	if (pubsta) {
 		struct sta_info *sta = container_of(pubsta, struct sta_info,
 						    sta);
+		struct ieee80211_rx_status stat;
 		struct ieee80211_tx_rate *rate = &sta->tx_stats.last_rate;
 		struct rate_info *ri = &sta->tx_stats.last_rate_info;
-		u32 airtime;
+		u32 duration, overhead;
+		u8 agg_shift;
 
-		if (!(rate->flags & (IEEE80211_TX_RC_VHT_MCS |
-				     IEEE80211_TX_RC_MCS)))
-			ampdu = false;
+		ieee80211_fill_rx_status(&stat, hw, rate, ri, band, len);
 
+		if (stat.encoding == RX_ENC_LEGACY || !ampdu)
+			return ieee80211_calc_rx_airtime(hw, &stat, len);
+
+		duration = ieee80211_get_rate_duration(hw, &stat, &overhead);
 		/*
 		 * Assume that HT/VHT transmission on any AC except VO will
 		 * use aggregation. Since we don't have reliable reporting
-		 * of aggregation length, assume an average of 16.
+		 * of aggregation length, assume an average size based on the
+		 * tx rate.
 		 * This will not be very accurate, but much better than simply
-		 * assuming un-aggregated tx.
+		 * assuming un-aggregated tx in all cases.
 		 */
-		airtime = ieee80211_calc_tx_airtime_rate(hw, rate, ri, band,
-							 ampdu ? len * 16 : len);
-		if (ampdu)
-			airtime /= 16;
-
-		return airtime;
+		if (duration > 400) /* <= VHT20 MCS2 1S */
+			agg_shift = 1;
+		else if (duration > 250) /* <= VHT20 MCS3 1S or MCS1 2S */
+			agg_shift = 2;
+		else if (duration > 150) /* <= VHT20 MCS5 1S or MCS3 2S */
+			agg_shift = 3;
+		else
+			agg_shift = 4;
+
+		duration *= len;
+		duration /= AVG_PKT_SIZE;
+		duration /= 1024;
+
+		return duration + (overhead >> agg_shift);
 	}
 
 	if (!conf)
-- 
2.28.0

