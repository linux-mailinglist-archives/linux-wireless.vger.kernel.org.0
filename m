Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9703422CDC6
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Jul 2020 20:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgGXS2W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Jul 2020 14:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgGXS2V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Jul 2020 14:28:21 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B637DC0619D3
        for <linux-wireless@vger.kernel.org>; Fri, 24 Jul 2020 11:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=+bFG/P2tkhDrKOjNW3CVk9SiDulandhIz4gSl0EUF4E=; b=tm+nvLKmI7QlhMD7lb3jm2RqhK
        YeJ7KNUrfLKT7jNw1iWugxjJqDJSy3+1jkhbmSUlM3iX965SqsvVWnS/fzG8+lc+Oo3u028hlex/i
        BZuXUFUo4vdALx+KYmgZaoWtuievM0ZkMhWeUERV5sUiRnx/7rzBRGdYi/ktO9jsZ2XM=;
Received: from p5b206d80.dip0.t-ipconnect.de ([91.32.109.128] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jz2Qc-0007Yq-3j; Fri, 24 Jul 2020 20:28:18 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
Subject: [PATCH] mac80211: improve AQL tx airtime estimation
Date:   Fri, 24 Jul 2020 20:28:16 +0200
Message-Id: <20200724182816.18678-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

AQL does not take into account that most HT/VHT/HE traffic is A-MPDU aggregated.
Because of that, the per-packet airtime overhead is vastly overestimated.
Improve it by assuming an average aggregation length of 16 for non-legacy
traffic if not using the VO AC queue.
This should improve performance with high data rates, especially with multiple
stations

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/airtime.c     | 26 +++++++++++++++++++++-----
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/tx.c          |  3 ++-
 3 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/airtime.c b/net/mac80211/airtime.c
index 9fc2968856c0..366f76c9003d 100644
--- a/net/mac80211/airtime.c
+++ b/net/mac80211/airtime.c
@@ -551,7 +551,7 @@ EXPORT_SYMBOL_GPL(ieee80211_calc_tx_airtime);
 u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_sta *pubsta,
-				       int len)
+				       int len, bool ampdu)
 {
 	struct ieee80211_supported_band *sband;
 	struct ieee80211_chanctx_conf *conf;
@@ -572,10 +572,26 @@ u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 	if (pubsta) {
 		struct sta_info *sta = container_of(pubsta, struct sta_info,
 						    sta);
-
-		return ieee80211_calc_tx_airtime_rate(hw,
-						      &sta->tx_stats.last_rate,
-						      band, len);
+		struct ieee80211_tx_rate *rate = &sta->tx_stats.last_rate;
+		u32 airtime;
+
+		if (!(rate->flags & (IEEE80211_TX_RC_VHT_MCS |
+				     IEEE80211_TX_RC_MCS)))
+			ampdu = false;
+
+		/*
+		 * Assume that HT/VHT transmission on any AC except VO will
+		 * use aggregation. Since we don't have reliable reporting
+		 * of aggregation length, assume an average of 16.
+		 * This will not be very accurate, but much better than simply
+		 * assuming un-aggregated tx.
+		 */
+		airtime = ieee80211_calc_tx_airtime_rate(hw, rate, band,
+							 ampdu ? len * 16 : len);
+		if (ampdu)
+			airtime /= 16;
+
+		return airtime;
 	}
 
 	if (!conf)
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index ec1a71ac65f2..28b154c6e72d 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2290,7 +2290,7 @@ extern const struct ethtool_ops ieee80211_ethtool_ops;
 u32 ieee80211_calc_expected_tx_airtime(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       struct ieee80211_sta *pubsta,
-				       int len);
+				       int len, bool ampdu);
 #ifdef CONFIG_MAC80211_NOINLINE
 #define debug_noinline noinline
 #else
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 1a2941e5244f..a4e7ef6b0457 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3721,10 +3721,11 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 
 	if (vif &&
 	    wiphy_ext_feature_isset(local->hw.wiphy, NL80211_EXT_FEATURE_AQL)) {
+		bool ampdu = txq->ac != IEEE80211_AC_VO;
 		u32 airtime;
 
 		airtime = ieee80211_calc_expected_tx_airtime(hw, vif, txq->sta,
-							     skb->len);
+							     skb->len, ampdu);
 		if (airtime) {
 			airtime = ieee80211_info_set_tx_time_est(info, airtime);
 			ieee80211_sta_update_pending_airtime(local, tx.sta,
-- 
2.24.0

