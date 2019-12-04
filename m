Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B53D11339B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2019 19:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731911AbfLDSSC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Dec 2019 13:18:02 -0500
Received: from nbd.name ([46.4.11.11]:40952 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731806AbfLDSSB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Dec 2019 13:18:01 -0500
Received: from p5dcfb666.dip0.t-ipconnect.de ([93.207.182.102] helo=bertha.datto.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1icZDo-0005Od-ER; Wed, 04 Dec 2019 19:17:56 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 7/9] ath11k: move some tx_status parsing to debugfs code
Date:   Wed,  4 Dec 2019 19:17:43 +0100
Message-Id: <20191204181745.27297-8-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191204181745.27297-1-john@phrozen.org>
References: <20191204181745.27297-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some of the fields are only used by debugfs. Move the parsing of these
from the data hot path to the debugfs code.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/debugfs_sta.c | 66 +++++++++++--------
 drivers/net/wireless/ath/ath11k/hal_tx.c      | 19 +-----
 drivers/net/wireless/ath/ath11k/hal_tx.h      |  7 +-
 3 files changed, 39 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index 3c5f931e22a9..3cdc34218a7d 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -129,12 +129,17 @@ void ath11k_update_per_peer_stats_from_txcompl(struct ath11k *ar,
 {
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_per_peer_tx_stats *peer_stats = &ar->cached_stats;
+	enum hal_tx_rate_stats_pkt_type pkt_type;
+	enum hal_tx_rate_stats_sgi sgi;
+	enum hal_tx_rate_stats_bw bw;
 	struct ath11k_peer *peer;
 	struct ath11k_sta *arsta;
 	struct ieee80211_sta *sta;
+	u16 num_tones_in_ru;
 	u16 rate;
 	u8 rate_idx;
 	int ret;
+	u8 mcs;
 
 	rcu_read_lock();
 	spin_lock_bh(&ab->base_lock);
@@ -150,51 +155,54 @@ void ath11k_update_per_peer_stats_from_txcompl(struct ath11k *ar,
 	arsta = (struct ath11k_sta *)sta->drv_priv;
 
 	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
-
-	if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11A ||
-	    ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11B) {
-		ret = ath11k_mac_hw_ratecode_to_legacy_rate(ts->mcs,
-							    ts->pkt_type,
+	pkt_type = FIELD_GET(HAL_TX_RATE_STATS_INFO0_PKT_TYPE,
+			     ts->rate_stats);
+	mcs = FIELD_GET(HAL_TX_RATE_STATS_INFO0_MCS,
+			ts->rate_stats);
+	sgi = FIELD_GET(HAL_TX_RATE_STATS_INFO0_SGI,
+			ts->rate_stats);
+	num_tones_in_ru = FIELD_GET(HAL_TX_RATE_STATS_INFO0_TONES_IN_RU,
+				    ts->rate_stats);
+	bw = FIELD_GET(HAL_TX_RATE_STATS_INFO0_BW, ts->rate_stats);
+
+	if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11A ||
+	    pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11B) {
+		ret = ath11k_mac_hw_ratecode_to_legacy_rate(mcs,
+							    pkt_type,
 							    &rate_idx,
 							    &rate);
-		if (ret < 0) {
-			spin_unlock_bh(&ab->base_lock);
-			rcu_read_unlock();
-			return;
-		}
+		if (ret < 0)
+			goto err_out;
 		arsta->txrate.legacy = rate;
-	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11N) {
-		if (ts->mcs > 7) {
-			ath11k_warn(ab, "Invalid HT mcs index %d\n", ts->mcs);
-			spin_unlock_bh(&ab->base_lock);
-			rcu_read_unlock();
-			return;
+	} else if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11N) {
+		if (mcs > 7) {
+			ath11k_warn(ab, "Invalid HT mcs index %d\n", mcs);
+			goto err_out;
 		}
 
-		arsta->txrate.mcs = ts->mcs + 8 * (arsta->last_txrate.nss - 1);
+		arsta->txrate.mcs = mcs + 8 * (arsta->last_txrate.nss - 1);
 		arsta->txrate.flags = RATE_INFO_FLAGS_MCS;
-		if (ts->sgi)
+		if (sgi)
 			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
-	} else if (ts->pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AC) {
-		if (ts->mcs > 9) {
-			ath11k_warn(ab, "Invalid VHT mcs index %d\n", ts->mcs);
-			spin_unlock_bh(&ab->base_lock);
-			rcu_read_unlock();
-			return;
+	} else if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AC) {
+		if (mcs > 9) {
+			ath11k_warn(ab, "Invalid VHT mcs index %d\n", mcs);
+			goto err_out;
 		}
 
-		arsta->txrate.mcs = ts->mcs;
+		arsta->txrate.mcs = mcs;
 		arsta->txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
-		if (ts->sgi)
+		if (sgi)
 			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
-	} else {
-		/*TODO: update HE rates */
+	} else if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
+		/* TODO */
 	}
 
 	arsta->txrate.nss = arsta->last_txrate.nss;
-	arsta->txrate.bw = ath11k_mac_bw_to_mac80211_bw(ts->bw);
+	arsta->txrate.bw = ath11k_mac_bw_to_mac80211_bw(bw);
 
 	ath11k_accumulate_per_peer_tx_stats(arsta, peer_stats, rate_idx);
+err_out:
 	spin_unlock_bh(&ab->base_lock);
 	rcu_read_unlock();
 }
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.c b/drivers/net/wireless/ath/ath11k/hal_tx.c
index 72a51ed65a51..c2a3a9d2e534 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.c
@@ -127,24 +127,7 @@ void ath11k_hal_tx_status_parse(struct ath11k_base *ab,
 	if (!(desc->rate_stats.info0 & HAL_TX_RATE_STATS_INFO0_VALID))
 		return;
 
-	ts->flags |= HAL_TX_STATUS_FLAGS_RATE_STATS_VALID;
-	ts->tsf = desc->rate_stats.tsf;
-	ts->bw = FIELD_GET(HAL_TX_RATE_STATS_INFO0_BW, desc->rate_stats.info0);
-	ts->pkt_type = FIELD_GET(HAL_TX_RATE_STATS_INFO0_PKT_TYPE,
-				 desc->rate_stats.info0);
-	if (desc->rate_stats.info0 & HAL_TX_RATE_STATS_INFO0_STBC)
-		ts->flags |= HAL_TX_STATUS_FLAGS_RATE_STBC;
-	if (desc->rate_stats.info0 & HAL_TX_RATE_STATS_INFO0_LDPC)
-		ts->flags |= HAL_TX_STATUS_FLAGS_RATE_LDPC;
-	if (desc->rate_stats.info0 & HAL_TX_RATE_STATS_INFO0_OFDMA_TX)
-		ts->flags |= HAL_TX_STATUS_FLAGS_OFDMA;
-
-	ts->sgi = FIELD_GET(HAL_TX_RATE_STATS_INFO0_SGI,
-			    desc->rate_stats.info0);
-	ts->mcs = FIELD_GET(HAL_TX_RATE_STATS_INFO0_MCS,
-			    desc->rate_stats.info0);
-	ts->num_tones_in_ru = FIELD_GET(HAL_TX_RATE_STATS_INFO0_TONES_IN_RU,
-					desc->rate_stats.info0);
+	ts->rate_stats = desc->rate_stats.info0;
 }
 
 void ath11k_hal_tx_set_dscp_tid_map(struct ath11k_base *ab, int id)
diff --git a/drivers/net/wireless/ath/ath11k/hal_tx.h b/drivers/net/wireless/ath/ath11k/hal_tx.h
index 5217eaf9da50..cf99e2b31f9f 100644
--- a/drivers/net/wireless/ath/ath11k/hal_tx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_tx.h
@@ -51,17 +51,12 @@ struct hal_tx_status {
 	u32 desc_id;
 	enum hal_wbm_tqm_rel_reason status;
 	u8 ack_rssi;
-	enum hal_tx_rate_stats_bw bw;
-	enum hal_tx_rate_stats_pkt_type pkt_type;
-	enum hal_tx_rate_stats_sgi sgi;
-	u8 mcs;
-	u16 num_tones_in_ru;
 	u32 flags; /* %HAL_TX_STATUS_FLAGS_ */
-	u32 tsf;
 	u32 ppdu_id;
 	u8 try_cnt;
 	u8 tid;
 	u16 peer_id;
+	u32 rate_stats;
 };
 
 void ath11k_hal_tx_cmd_desc_setup(struct ath11k_base *ab, void *cmd,
-- 
2.20.1

