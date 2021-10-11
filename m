Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076D4428949
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 10:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbhJKJBT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 05:01:19 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:14089 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbhJKJBS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 05:01:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633942759; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=v9WMpdNVufoENl6Wl3y5AEDzggPWWsUfibC/ch8ZnD0=; b=uqzuVABUMjnU3ys1GLCWwwreD6waNi1yxMOlluFcxoNC9KSsMpwFiNUfqZcBUOryenMGSWql
 tQBNStoTONYVbnPPWbqGW81vVyLokjcx8HFqesWdrM5e88PgisNFYwZgvmtkbKiZDAlG+nRO
 iHaK38hduJOSeV2iRSy+/3hBce4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6163fcdcff0285fb0a9d465d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 08:59:08
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 825ACC43617; Mon, 11 Oct 2021 08:59:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C6CEC4338F;
        Mon, 11 Oct 2021 08:59:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 8C6CEC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH] ath11k: report tx bitrate for iw wlan station dump
Date:   Mon, 11 Oct 2021 04:58:58 -0400
Message-Id: <20211011085858.31269-1-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

HTT_T2H_MSG_TYPE_PPDU_STATS_IND is a message which include the ppdu
info, currently it is not report from firmware for ath11k, then the
tx bitrate of "iw wlan0 station dump" always show an invalid value
"tx bitrate: 6.0 MBit/s".

To address the issue, this is to parse the info of tx complete report
from firmware and indicate the tx rate to mac80211.

After that, "iw wlan0 station dump" show the correct tx bit rate such
as "tx bitrate: 1921.5 MBit/s 160MHz HE-MCS 9 HE-NSS 2 HE-GI 0 HE-DCM 0".

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h        |   1 +
 drivers/net/wireless/ath/ath11k/debugfs_sta.c |  78 +------------
 drivers/net/wireless/ath/ath11k/debugfs_sta.h |   2 -
 drivers/net/wireless/ath/ath11k/dp_rx.c       |  28 +----
 drivers/net/wireless/ath/ath11k/dp_tx.c       | 106 +++++++++++++++++-
 drivers/net/wireless/ath/ath11k/dp_tx.h       |   1 +
 drivers/net/wireless/ath/ath11k/hal_rx.c      |   4 +-
 drivers/net/wireless/ath/ath11k/hal_rx.h      |  27 -----
 drivers/net/wireless/ath/ath11k/mac.c         |  93 +++++++++++++++
 drivers/net/wireless/ath/ath11k/mac.h         |   3 +
 10 files changed, 210 insertions(+), 133 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 0f316dd1e3f9..8a5c7e034fdd 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -406,6 +406,7 @@ struct ath11k_sta {
 
 	struct work_struct update_wk;
 	struct rate_info txrate;
+	u32 peer_nss;
 	struct rate_info last_txrate;
 	u64 rx_duration;
 	u64 tx_duration;
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index 270c0edbb10f..263f30ec9e34 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -126,85 +126,9 @@ void ath11k_debugfs_sta_add_tx_stats(struct ath11k_sta *arsta,
 }
 
 void ath11k_debugfs_sta_update_txcompl(struct ath11k *ar,
-				       struct sk_buff *msdu,
 				       struct hal_tx_status *ts)
 {
-	struct ath11k_base *ab = ar->ab;
-	struct ath11k_per_peer_tx_stats *peer_stats = &ar->cached_stats;
-	enum hal_tx_rate_stats_pkt_type pkt_type;
-	enum hal_tx_rate_stats_sgi sgi;
-	enum hal_tx_rate_stats_bw bw;
-	struct ath11k_peer *peer;
-	struct ath11k_sta *arsta;
-	struct ieee80211_sta *sta;
-	u16 rate;
-	u8 rate_idx = 0;
-	int ret;
-	u8 mcs;
-
-	rcu_read_lock();
-	spin_lock_bh(&ab->base_lock);
-	peer = ath11k_peer_find_by_id(ab, ts->peer_id);
-	if (!peer || !peer->sta) {
-		ath11k_warn(ab, "failed to find the peer\n");
-		spin_unlock_bh(&ab->base_lock);
-		rcu_read_unlock();
-		return;
-	}
-
-	sta = peer->sta;
-	arsta = (struct ath11k_sta *)sta->drv_priv;
-
-	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
-	pkt_type = FIELD_GET(HAL_TX_RATE_STATS_INFO0_PKT_TYPE,
-			     ts->rate_stats);
-	mcs = FIELD_GET(HAL_TX_RATE_STATS_INFO0_MCS,
-			ts->rate_stats);
-	sgi = FIELD_GET(HAL_TX_RATE_STATS_INFO0_SGI,
-			ts->rate_stats);
-	bw = FIELD_GET(HAL_TX_RATE_STATS_INFO0_BW, ts->rate_stats);
-
-	if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11A ||
-	    pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11B) {
-		ret = ath11k_mac_hw_ratecode_to_legacy_rate(mcs,
-							    pkt_type,
-							    &rate_idx,
-							    &rate);
-		if (ret < 0)
-			goto err_out;
-		arsta->txrate.legacy = rate;
-	} else if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11N) {
-		if (mcs > 7) {
-			ath11k_warn(ab, "Invalid HT mcs index %d\n", mcs);
-			goto err_out;
-		}
-
-		arsta->txrate.mcs = mcs + 8 * (arsta->last_txrate.nss - 1);
-		arsta->txrate.flags = RATE_INFO_FLAGS_MCS;
-		if (sgi)
-			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
-	} else if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AC) {
-		if (mcs > 9) {
-			ath11k_warn(ab, "Invalid VHT mcs index %d\n", mcs);
-			goto err_out;
-		}
-
-		arsta->txrate.mcs = mcs;
-		arsta->txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
-		if (sgi)
-			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
-	} else if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
-		/* TODO */
-	}
-
-	arsta->txrate.nss = arsta->last_txrate.nss;
-	arsta->txrate.bw = ath11k_mac_bw_to_mac80211_bw(bw);
-
-	ath11k_debugfs_sta_add_tx_stats(arsta, peer_stats, rate_idx);
-
-err_out:
-	spin_unlock_bh(&ab->base_lock);
-	rcu_read_unlock();
+	ath11k_dp_tx_update_txcompl(ar, ts);
 }
 
 static ssize_t ath11k_dbg_sta_dump_tx_stats(struct file *file,
diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.h b/drivers/net/wireless/ath/ath11k/debugfs_sta.h
index 18dc65d9edcf..e6c11b3a40aa 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.h
@@ -19,7 +19,6 @@ void ath11k_debugfs_sta_add_tx_stats(struct ath11k_sta *arsta,
 				     struct ath11k_per_peer_tx_stats *peer_stats,
 				     u8 legacy_rate_idx);
 void ath11k_debugfs_sta_update_txcompl(struct ath11k *ar,
-				       struct sk_buff *msdu,
 				       struct hal_tx_status *ts);
 
 #else /* CONFIG_ATH11K_DEBUGFS */
@@ -34,7 +33,6 @@ ath11k_debugfs_sta_add_tx_stats(struct ath11k_sta *arsta,
 }
 
 static inline void ath11k_debugfs_sta_update_txcompl(struct ath11k *ar,
-						     struct sk_buff *msdu,
 						     struct hal_tx_status *ts)
 {
 }
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 11dfafd011d0..6d769ba1ca2b 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1332,25 +1332,6 @@ int ath11k_dp_htt_tlv_iter(struct ath11k_base *ab, const void *ptr, size_t len,
 	return 0;
 }
 
-static inline u32 ath11k_he_gi_to_nl80211_he_gi(u8 sgi)
-{
-	u32 ret = 0;
-
-	switch (sgi) {
-	case RX_MSDU_START_SGI_0_8_US:
-		ret = NL80211_RATE_INFO_HE_GI_0_8;
-		break;
-	case RX_MSDU_START_SGI_1_6_US:
-		ret = NL80211_RATE_INFO_HE_GI_1_6;
-		break;
-	case RX_MSDU_START_SGI_3_2_US:
-		ret = NL80211_RATE_INFO_HE_GI_3_2;
-		break;
-	}
-
-	return ret;
-}
-
 static void
 ath11k_update_per_peer_tx_stats(struct ath11k *ar,
 				struct htt_ppdu_stats *ppdu_stats, u8 user)
@@ -1474,14 +1455,15 @@ ath11k_update_per_peer_tx_stats(struct ath11k *ar,
 		arsta->txrate.mcs = mcs;
 		arsta->txrate.flags = RATE_INFO_FLAGS_HE_MCS;
 		arsta->txrate.he_dcm = dcm;
-		arsta->txrate.he_gi = ath11k_he_gi_to_nl80211_he_gi(sgi);
-		arsta->txrate.he_ru_alloc = ath11k_he_ru_tones_to_nl80211_he_ru_alloc(
-						(user_rate->ru_end -
+		arsta->txrate.he_gi = ath11k_mac_he_gi_to_nl80211_he_gi(sgi);
+		arsta->txrate.he_ru_alloc = ath11k_mac_phy_he_ru_to_nl80211_he_ru_alloc
+						((user_rate->ru_end -
 						 user_rate->ru_start) + 1);
 		break;
 	}
 
 	arsta->txrate.nss = nss;
+
 	arsta->txrate.bw = ath11k_mac_bw_to_mac80211_bw(bw);
 	arsta->tx_duration += tx_duration;
 	memcpy(&arsta->last_txrate, &arsta->txrate, sizeof(struct rate_info));
@@ -2317,7 +2299,7 @@ static void ath11k_dp_rx_h_rate(struct ath11k *ar, struct hal_rx_desc *rx_desc,
 		}
 		rx_status->encoding = RX_ENC_HE;
 		rx_status->nss = nss;
-		rx_status->he_gi = ath11k_he_gi_to_nl80211_he_gi(sgi);
+		rx_status->he_gi = ath11k_mac_he_gi_to_nl80211_he_gi(sgi);
 		rx_status->bw = ath11k_mac_bw_to_mac80211_bw(bw);
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 9164f3ee5270..37f53884e188 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -414,6 +414,105 @@ static void ath11k_dp_tx_cache_peer_stats(struct ath11k *ar,
 	}
 }
 
+void ath11k_dp_tx_update_txcompl(struct ath11k *ar, struct hal_tx_status *ts)
+{
+	struct ath11k_base *ab = ar->ab;
+	struct ath11k_per_peer_tx_stats *peer_stats = &ar->cached_stats;
+	enum hal_tx_rate_stats_pkt_type pkt_type;
+	enum hal_tx_rate_stats_sgi sgi;
+	enum hal_tx_rate_stats_bw bw;
+	struct ath11k_peer *peer;
+	struct ath11k_sta *arsta;
+	struct ieee80211_sta *sta;
+	u16 rate, ru_tones;
+	u8 mcs, rate_idx, ofdma;
+	int ret;
+
+	rcu_read_lock();
+	spin_lock_bh(&ab->base_lock);
+	peer = ath11k_peer_find_by_id(ab, ts->peer_id);
+	if (!peer || !peer->sta) {
+		ath11k_warn(ab, "failed to find the peer by id %u\n", ts->peer_id);
+		goto err_out;
+	}
+
+	sta = peer->sta;
+	arsta = (struct ath11k_sta *)sta->drv_priv;
+
+	memset(&arsta->txrate, 0, sizeof(arsta->txrate));
+	pkt_type = FIELD_GET(HAL_TX_RATE_STATS_INFO0_PKT_TYPE,
+			     ts->rate_stats);
+	mcs = FIELD_GET(HAL_TX_RATE_STATS_INFO0_MCS,
+			ts->rate_stats);
+	sgi = FIELD_GET(HAL_TX_RATE_STATS_INFO0_SGI,
+			ts->rate_stats);
+	bw = FIELD_GET(HAL_TX_RATE_STATS_INFO0_BW, ts->rate_stats);
+	ru_tones = FIELD_GET(HAL_TX_RATE_STATS_INFO0_TONES_IN_RU, ts->rate_stats);
+	ofdma = FIELD_GET(HAL_TX_RATE_STATS_INFO0_OFDMA_TX, ts->rate_stats);
+
+	if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11A ||
+	    pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11B) {
+		ret = ath11k_mac_hw_ratecode_to_legacy_rate(mcs,
+							    pkt_type,
+							    &rate_idx,
+							    &rate);
+		if (ret < 0)
+			goto err_out;
+		arsta->txrate.legacy = rate;
+	} else if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11N) {
+		if (mcs > 7) {
+			ath11k_warn(ab, "Invalid HT mcs index %d\n", mcs);
+			goto err_out;
+		}
+
+		arsta->txrate.mcs = mcs + 8 * (arsta->last_txrate.nss - 1);
+		arsta->txrate.flags = RATE_INFO_FLAGS_MCS;
+		if (sgi)
+			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+	} else if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AC) {
+		if (mcs > 9) {
+			ath11k_warn(ab, "Invalid VHT mcs index %d\n", mcs);
+			goto err_out;
+		}
+
+		arsta->txrate.mcs = mcs;
+		arsta->txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
+		if (sgi)
+			arsta->txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+	} else if (pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
+		if (mcs > 11) {
+			ath11k_warn(ab, "Invalid HE mcs index %d\n", mcs);
+			goto err_out;
+		}
+
+		arsta->txrate.mcs = mcs;
+		arsta->txrate.flags = RATE_INFO_FLAGS_HE_MCS;
+		arsta->txrate.he_gi = ath11k_mac_he_gi_to_nl80211_he_gi(sgi);
+	}
+
+	/* This is to prefer choose the real NSS value arsta->last_txrate.nss,
+	 * if it is invalid, then choose the NSS value while assoc.
+	 */
+	if (arsta->last_txrate.nss)
+		arsta->txrate.nss = arsta->last_txrate.nss;
+	else
+		arsta->txrate.nss = arsta->peer_nss;
+
+	arsta->txrate.bw = ath11k_mac_bw_to_mac80211_bw(bw);
+	if (ofdma && pkt_type == HAL_TX_RATE_STATS_PKT_TYPE_11AX) {
+		arsta->txrate.bw = RATE_INFO_BW_HE_RU;
+		arsta->txrate.he_ru_alloc =
+			ath11k_mac_he_ru_tones_to_nl80211_he_ru_alloc(ru_tones);
+	}
+
+	if (ath11k_debugfs_is_extd_tx_stats_enabled(ar))
+		ath11k_debugfs_sta_add_tx_stats(arsta, peer_stats, rate_idx);
+
+err_out:
+	spin_unlock_bh(&ab->base_lock);
+	rcu_read_unlock();
+}
+
 static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 				       struct sk_buff *msdu,
 				       struct hal_tx_status *ts)
@@ -461,7 +560,8 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 	    (info->flags & IEEE80211_TX_CTL_NO_ACK))
 		info->flags |= IEEE80211_TX_STAT_NOACK_TRANSMITTED;
 
-	if (ath11k_debugfs_is_extd_tx_stats_enabled(ar)) {
+	if (ath11k_debugfs_is_extd_tx_stats_enabled(ar) ||
+	    ab->hw_params.single_pdev_only) {
 		if (ts->flags & HAL_TX_STATUS_FLAGS_FIRST_MSDU) {
 			if (ar->last_ppdu_id == 0) {
 				ar->last_ppdu_id = ts->ppdu_id;
@@ -469,12 +569,12 @@ static void ath11k_dp_tx_complete_msdu(struct ath11k *ar,
 				   ar->cached_ppdu_id == ar->last_ppdu_id) {
 				ar->cached_ppdu_id = ar->last_ppdu_id;
 				ar->cached_stats.is_ampdu = true;
-				ath11k_debugfs_sta_update_txcompl(ar, msdu, ts);
+				ath11k_dp_tx_update_txcompl(ar, ts);
 				memset(&ar->cached_stats, 0,
 				       sizeof(struct ath11k_per_peer_tx_stats));
 			} else {
 				ar->cached_stats.is_ampdu = false;
-				ath11k_debugfs_sta_update_txcompl(ar, msdu, ts);
+				ath11k_dp_tx_update_txcompl(ar, ts);
 				memset(&ar->cached_stats, 0,
 				       sizeof(struct ath11k_per_peer_tx_stats));
 			}
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.h b/drivers/net/wireless/ath/ath11k/dp_tx.h
index f8a9f9c8e444..41455bc1c3eb 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.h
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.h
@@ -15,6 +15,7 @@ struct ath11k_dp_htt_wbm_tx_status {
 	int ack_rssi;
 };
 
+void ath11k_dp_tx_update_txcompl(struct ath11k *ar, struct hal_tx_status *ts);
 int ath11k_dp_tx_htt_h2t_ver_req_msg(struct ath11k_base *ab);
 int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 		 struct sk_buff *skb);
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 45c2f303891e..fd95bddee285 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -1037,7 +1037,9 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 
 		ru_tones = FIELD_GET(HAL_RX_HE_SIG_B1_MU_INFO_INFO0_RU_ALLOCATION,
 				     info0);
-		ppdu_info->ru_alloc = ath11k_he_ru_tones_to_nl80211_he_ru_alloc(ru_tones);
+		ppdu_info->ru_alloc =
+			ath11k_mac_phy_he_ru_to_nl80211_he_ru_alloc(ru_tones);
+
 		ppdu_info->reception_type = HAL_RX_RECEPTION_TYPE_MU_MIMO;
 		break;
 	}
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.h b/drivers/net/wireless/ath/ath11k/hal_rx.h
index 46597b15fb33..cd179dcb45a5 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.h
@@ -346,33 +346,6 @@ ath11k_hal_rx_parse_mon_status(struct ath11k_base *ab,
 			       struct hal_rx_mon_ppdu_info *ppdu_info,
 			       struct sk_buff *skb);
 
-static inline u32 ath11k_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
-{
-	u32 ret = 0;
-
-	switch (ru_tones) {
-	case RU_26:
-		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
-		break;
-	case RU_52:
-		ret = NL80211_RATE_INFO_HE_RU_ALLOC_52;
-		break;
-	case RU_106:
-		ret = NL80211_RATE_INFO_HE_RU_ALLOC_106;
-		break;
-	case RU_242:
-		ret = NL80211_RATE_INFO_HE_RU_ALLOC_242;
-		break;
-	case RU_484:
-		ret = NL80211_RATE_INFO_HE_RU_ALLOC_484;
-		break;
-	case RU_996:
-		ret = NL80211_RATE_INFO_HE_RU_ALLOC_996;
-		break;
-	}
-	return ret;
-}
-
 #define REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_0 0xDDBEEF
 #define REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_1 0xADBEEF
 #define REO_QUEUE_DESC_MAGIC_DEBUG_PATTERN_2 0xBDBEEF
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index daf964f34ea6..06ec80dd3c32 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -246,6 +246,93 @@ static const u32 ath11k_smps_map[] = {
 static int ath11k_start_vdev_delay(struct ieee80211_hw *hw,
 				   struct ieee80211_vif *vif);
 
+enum nl80211_he_ru_alloc ath11k_mac_phy_he_ru_to_nl80211_he_ru_alloc(u16 ru_phy)
+{
+	enum nl80211_he_ru_alloc ret;
+
+	switch (ru_phy) {
+	case RU_26:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
+		break;
+	case RU_52:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_52;
+		break;
+	case RU_106:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		break;
+	case RU_242:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_242;
+		break;
+	case RU_484:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_484;
+		break;
+	case RU_996:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_996;
+		break;
+	default:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
+		break;
+	}
+
+	return ret;
+}
+
+enum nl80211_he_ru_alloc ath11k_mac_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
+{
+	enum nl80211_he_ru_alloc ret;
+
+	switch (ru_tones) {
+	case 26:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
+		break;
+	case 52:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_52;
+		break;
+	case 106:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_106;
+		break;
+	case 242:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_242;
+		break;
+	case 484:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_484;
+		break;
+	case 996:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_996;
+		break;
+	case (996 * 2):
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
+		break;
+	default:
+		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
+		break;
+	}
+
+	return ret;
+}
+
+enum nl80211_he_gi ath11k_mac_he_gi_to_nl80211_he_gi(u8 sgi)
+{
+	enum nl80211_he_gi ret;
+
+	switch (sgi) {
+	case RX_MSDU_START_SGI_0_8_US:
+		ret = NL80211_RATE_INFO_HE_GI_0_8;
+		break;
+	case RX_MSDU_START_SGI_1_6_US:
+		ret = NL80211_RATE_INFO_HE_GI_1_6;
+		break;
+	case RX_MSDU_START_SGI_3_2_US:
+		ret = NL80211_RATE_INFO_HE_GI_3_2;
+		break;
+	default:
+		ret = NL80211_RATE_INFO_HE_GI_0_8;
+		break;
+	}
+
+	return ret;
+}
+
 u8 ath11k_mac_bw_to_mac80211_bw(u8 bw)
 {
 	u8 ret = 0;
@@ -1819,8 +1906,12 @@ static void ath11k_peer_assoc_prepare(struct ath11k *ar,
 				      struct peer_assoc_params *arg,
 				      bool reassoc)
 {
+	struct ath11k_sta *arsta;
+
 	lockdep_assert_held(&ar->conf_mutex);
 
+	arsta = (struct ath11k_sta *)sta->drv_priv;
+
 	memset(arg, 0, sizeof(*arg));
 
 	reinit_completion(&ar->peer_assoc_done);
@@ -1837,6 +1928,8 @@ static void ath11k_peer_assoc_prepare(struct ath11k *ar,
 	ath11k_peer_assoc_h_phymode(ar, vif, sta, arg);
 	ath11k_peer_assoc_h_smps(sta, arg);
 
+	arsta->peer_nss = arg->peer_nss;
+
 	/* TODO: amsdu_disable req? */
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index 0b2a1612f745..5bc227cb715f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -161,6 +161,9 @@ void ath11k_mac_drain_tx(struct ath11k *ar);
 void ath11k_mac_peer_cleanup_all(struct ath11k *ar);
 int ath11k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx);
 u8 ath11k_mac_bw_to_mac80211_bw(u8 bw);
+u32 ath11k_mac_he_gi_to_nl80211_he_gi(u8 sgi);
+enum nl80211_he_ru_alloc ath11k_mac_phy_he_ru_to_nl80211_he_ru_alloc(u16 ru_phy);
+enum nl80211_he_ru_alloc ath11k_mac_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones);
 enum ath11k_supported_bw ath11k_mac_mac80211_bw_to_ath11k_bw(enum rate_info_bw bw);
 enum hal_encrypt_type ath11k_dp_tx_get_encrypt_type(u32 cipher);
 void ath11k_mac_handle_beacon(struct ath11k *ar, struct sk_buff *skb);
-- 
2.31.1

