Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDC067FED
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jul 2019 17:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfGNPoi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Jul 2019 11:44:38 -0400
Received: from nbd.name ([46.4.11.11]:59416 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728278AbfGNPoh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Jul 2019 11:44:37 -0400
Received: from p5dcfb359.dip0.t-ipconnect.de ([93.207.179.89] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1hmgfz-0007cJ-8c; Sun, 14 Jul 2019 17:44:35 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH 4/6] ath11k: drop tx_info from ath11k_sta
Date:   Sun, 14 Jul 2019 17:44:17 +0200
Message-Id: <20190714154419.11854-5-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190714154419.11854-1-john@phrozen.org>
References: <20190714154419.11854-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We will start using ieee80211_tx_status_ext() so we do not need to track
tx rates inside a struct ieee80211_tx_info. It is currently not possible
to populate that struct with HE rate info anyhow.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/core.h  |  1 -
 drivers/net/wireless/ath/ath11k/dp_rx.c | 52 +------------------------
 2 files changed, 2 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 2375a5b9ec42..1255eb417e58 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -331,7 +331,6 @@ struct ath11k_sta {
 	u32 smps;
 
 	struct work_struct update_wk;
-	struct ieee80211_tx_info tx_info;
 	struct rate_info txrate;
 	struct rate_info last_txrate;
 	u64 rx_duration;
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index fdf8311e12ae..01080de7d919 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1009,25 +1009,6 @@ static u8 ath11k_bw_to_mac80211_bw(u8 bw)
 	return ret;
 }
 
-static u32 ath11k_bw_to_mac80211_bwflags(u8 bw)
-{
-	u32 bwflags = 0;
-
-	switch (bw) {
-	case ATH11K_BW_40:
-		bwflags = IEEE80211_TX_RC_40_MHZ_WIDTH;
-		break;
-	case ATH11K_BW_80:
-		bwflags = IEEE80211_TX_RC_80_MHZ_WIDTH;
-		break;
-	case ATH11K_BW_160:
-		bwflags = IEEE80211_TX_RC_160_MHZ_WIDTH;
-		break;
-	}
-
-	return bwflags;
-}
-
 static void
 ath11k_update_per_peer_tx_stats(struct ath11k *ar,
 				struct htt_ppdu_user_stats *usr_stats)
@@ -1037,7 +1018,6 @@ ath11k_update_per_peer_tx_stats(struct ath11k *ar,
 	struct ieee80211_sta *sta;
 	struct ath11k_sta *arsta;
 	struct htt_ppdu_stats_user_rate *user_rate;
-	struct ieee80211_chanctx_conf *conf = NULL;
 	struct ath11k_per_peer_tx_stats *peer_stats = &ar->peer_tx_stats;
 	int ret;
 	u8 flags, mcs, nss, bw, sgi, rate_idx = 0;
@@ -1108,62 +1088,34 @@ ath11k_update_per_peer_tx_stats(struct ath11k *ar,
 	arsta = (struct ath11k_sta *)sta->drv_priv;
 
 	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
-	memset(&arsta->tx_info.status, 0, sizeof(arsta->tx_info.status));
 
 	switch (flags) {
 	case WMI_RATE_PREAMBLE_OFDM:
 		arsta->txrate.legacy = rate;
-		if (arsta->arvif && arsta->arvif->vif)
-			conf = rcu_dereference(arsta->arvif->vif->chanctx_conf);
-		if (conf && conf->def.chan->band == NL80211_BAND_5GHZ)
-			arsta->tx_info.status.rates[0].idx = rate_idx - 4;
 		break;
 	case WMI_RATE_PREAMBLE_CCK:
 		arsta->txrate.legacy = rate;
-		arsta->tx_info.status.rates[0].idx = rate_idx;
-		if (mcs > ATH11K_HW_RATE_CCK_LP_1M &&
-		    mcs <= ATH11K_HW_RATE_CCK_SP_2M)
-			arsta->tx_info.status.rates[0].flags |=
-					IEEE80211_TX_RC_USE_SHORT_PREAMBLE;
 		break;
 	case WMI_RATE_PREAMBLE_HT:
 		arsta->txrate.mcs = mcs + 8 * (nss - 1);
-		arsta->tx_info.status.rates[0].idx = arsta->txrate.mcs;
 		arsta->txrate.flags = RATE_INFO_FLAGS_MCS;
-		arsta->tx_info.status.rates[0].flags |= IEEE80211_TX_RC_MCS;
-		if (sgi) {
+		if (sgi)
 			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
-			arsta->tx_info.status.rates[0].flags |=
-					IEEE80211_TX_RC_SHORT_GI;
-		}
 		break;
 	case WMI_RATE_PREAMBLE_VHT:
 		arsta->txrate.mcs = mcs;
-		ieee80211_rate_set_vht(&arsta->tx_info.status.rates[0], mcs, nss);
 		arsta->txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
-		arsta->tx_info.status.rates[0].flags |= IEEE80211_TX_RC_VHT_MCS;
-		if (sgi) {
+		if (sgi)
 			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
-			arsta->tx_info.status.rates[0].flags |=
-						IEEE80211_TX_RC_SHORT_GI;
-		}
 		break;
 	}
 
 	arsta->txrate.nss = nss;
 	arsta->txrate.bw = ath11k_bw_to_mac80211_bw(bw);
-	arsta->tx_info.status.rates[0].flags |= ath11k_bw_to_mac80211_bwflags(bw);
 
 	memcpy(&arsta->last_txrate, &arsta->txrate, sizeof(struct rate_info));
 
-	if (succ_pkts) {
-		arsta->tx_info.flags = IEEE80211_TX_STAT_ACK;
-		arsta->tx_info.status.rates[0].count = 1;
-		ieee80211_tx_rate_update(ar->hw, sta, &arsta->tx_info);
-	}
-
 	memset(peer_stats, 0, sizeof(*peer_stats));
-
 	peer_stats->succ_pkts = succ_pkts;
 	peer_stats->succ_bytes = succ_bytes;
 	peer_stats->is_ampdu = is_ampdu;
-- 
2.20.1

