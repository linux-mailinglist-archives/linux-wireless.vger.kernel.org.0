Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E54583572
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 01:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbiG0XBr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 19:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiG0XBo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 19:01:44 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DAC20BC8
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 16:01:42 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.50.13])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id AD9D82006B;
        Wed, 27 Jul 2022 23:01:40 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 6343144007B;
        Wed, 27 Jul 2022 23:01:40 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id E383713C2B5;
        Wed, 27 Jul 2022 16:01:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com E383713C2B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1658962900;
        bh=iNPpF5eBazapsbPEYZRJvxx9G/EA3qaLanT0Pqanj2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvS573ZpwFKBDggh5rNhDZvqT3oNt5xAkWQtaElqBrF+82uVs+3Rli9M0Lf3RspCX
         4enOfKGO3zqsUU9CvsYL2p4M7MKr99V91OW67vHz83mtBAEo58JHDpI4G4YKziu7S4
         PQpnAmu4x2ES6to8qT9UAHzwNfFPcQLboF9c5zgw=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     nbd@nbd.name, Ben Greear <greearb@candelatech.com>
Subject: [PATCH 05/12] wifi: mt76: mt7915: report tx-retries
Date:   Wed, 27 Jul 2022 16:01:15 -0700
Message-Id: <20220727230122.29842-5-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220727230122.29842-1-greearb@candelatech.com>
References: <20220727230122.29842-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1658962901-AVRoz5JIHZQD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

mac80211 stack will only report tx-status for skb claiming to be
ampdu heads, so lie a bit in mt7915 and set the flag so that mac80211
will record status for each skb.

mt7915 appears to report retry status on an individual per-skb manner,
so that method above seems to work.

Re-constitute the txinfo status rate info so that the rix and flags
is also at least close to correct.  No direct way to report HE
rates that way, so mac80211 might could use some tweaking in
the ieee80211_tx_status_ext to take both info and status->rate
into account.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |  4 +
 drivers/net/wireless/mediatek/mt76/mt76.h     |  5 +
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 95 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/mac.h   |  6 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  4 +
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  4 +
 drivers/net/wireless/mediatek/mt76/tx.c       | 18 +++-
 8 files changed, 129 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 18b5de55334c..242e055fa475 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1628,6 +1628,10 @@ void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
 
 	wi->sta_count++;
 
+	data[ei++] += stats->tx_mpdu_attempts;
+	data[ei++] += stats->tx_mpdu_fail;
+	data[ei++] += stats->tx_mpdu_retry;
+	data[ei++] += stats->tx_mpdu_ok;
 	data[ei++] += stats->tx_mode[MT_PHY_TYPE_CCK];
 	data[ei++] += stats->tx_mode[MT_PHY_TYPE_OFDM];
 	data[ei++] += stats->tx_mode[MT_PHY_TYPE_HT];
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index f994d1e18ac6..62a5e2ad6764 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -826,6 +826,11 @@ enum mt76_phy_type {
 };
 
 struct mt76_sta_stats {
+	unsigned long tx_mpdu_attempts; /* counting any retries */
+	unsigned long tx_mpdu_fail; /* frames that failed even after retry */
+	/* frames that succeeded, perhaps after retry */
+	unsigned long tx_mpdu_ok;
+	unsigned long tx_mpdu_retry; /* number of times frames were retried */
 	u64 tx_mode[__MT_PHY_TYPE_HE_MAX];
 	u64 tx_bw[4];		/* 20, 40, 80, 160 */
 	u64 tx_nss[4];		/* 1, 2, 3, 4 */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index b4ceb78c6745..5af9fade3a17 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -329,6 +329,7 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 	struct mt7915_dev *dev = phy->dev;
 
 	hw->queues = 4;
+	hw->max_report_rates = 1;
 	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
 	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
 	hw->netdev_features = NETIF_F_RXCSUM;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index cf4d11c0a88d..800028a713a0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1428,18 +1428,23 @@ mt7915_txp_skb_unmap(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 
 static void
 mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
-		 struct ieee80211_sta *sta, struct list_head *free_list)
+		 struct ieee80211_sta *sta, struct list_head *free_list,
+		 u32 tx_cnt, u32 tx_status, u32 ampdu)
 {
 	struct mt76_dev *mdev = &dev->mt76;
 	struct mt7915_sta *msta;
 	struct mt76_wcid *wcid;
 	__le32 *txwi;
 	u16 wcid_idx;
+	struct ieee80211_tx_info *info;
+	struct ieee80211_tx_rate *rate;
 
 	mt7915_txp_skb_unmap(mdev, t);
 	if (!t->skb)
 		goto out;
 
+	rcu_read_lock(); /* protect wcid access */
+
 	txwi = (__le32 *)mt76_get_txwi_ptr(mdev, t);
 	if (sta) {
 		wcid = (struct mt76_wcid *)sta->drv_priv;
@@ -1462,6 +1467,74 @@ mt7915_txwi_free(struct mt7915_dev *dev, struct mt76_txwi_cache *t,
 	if (sta && likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
 		mt7915_tx_check_aggr(sta, txwi);
 
+	info = IEEE80211_SKB_CB(t->skb);
+
+	/* Cannot clear all of info->status, we need the driver private
+	 * status intact.
+	 */
+	info->status.flags = 0;
+
+	rate = &info->status.rates[0];
+	rate->idx = -1; /* will over-write below if we found wcid */
+	info->status.rates[1].idx = -1; /* terminate rate list */
+
+	/* force TX_STAT_AMPDU to be set, or mac80211 will ignore status */
+	if (ampdu || (info->flags & IEEE80211_TX_CTL_AMPDU)) {
+		info->flags |= IEEE80211_TX_STAT_AMPDU | IEEE80211_TX_CTL_AMPDU;
+		info->status.ampdu_len = 1;
+	}
+
+	/* update info status based on cached wcid rate info since
+	 * txfree path doesn't give us a lot of info.
+	 */
+	if (wcid) {
+		struct mt7915_sta *msta = container_of(wcid, struct mt7915_sta, wcid);
+		struct mt76_sta_stats *stats = &msta->stats;
+
+		if (wcid->rate.flags & RATE_INFO_FLAGS_MCS) {
+			rate->flags |= IEEE80211_TX_RC_MCS;
+			rate->idx = wcid->rate.mcs + wcid->rate.nss * 8;
+		} else if (wcid->rate.flags & RATE_INFO_FLAGS_VHT_MCS) {
+			rate->flags |= IEEE80211_TX_RC_VHT_MCS;
+			rate->idx = (wcid->rate.nss << 4) | wcid->rate.mcs;
+		} else if (wcid->rate.flags & RATE_INFO_FLAGS_HE_MCS) {
+			rate->idx = (wcid->rate.nss << 4) | wcid->rate.mcs;
+		} else {
+			rate->idx = wcid->rate.mcs;
+		}
+
+		switch (wcid->rate.bw) {
+		case RATE_INFO_BW_160:
+			rate->flags |= IEEE80211_TX_RC_160_MHZ_WIDTH;
+			break;
+		case RATE_INFO_BW_80:
+			rate->flags |= IEEE80211_TX_RC_80_MHZ_WIDTH;
+			break;
+		case RATE_INFO_BW_40:
+			rate->flags |= IEEE80211_TX_RC_40_MHZ_WIDTH;
+			break;
+		}
+
+		stats->tx_mpdu_attempts += tx_cnt;
+		stats->tx_mpdu_retry += tx_cnt - 1;
+
+		if (tx_status == 0)
+			stats->tx_mpdu_ok++;
+		else
+			stats->tx_mpdu_fail++;
+	}
+
+	rcu_read_unlock();
+
+	/* Apply the values that this txfree path reports */
+	rate->count = tx_cnt;
+	if (tx_status == 0) {
+		info->flags |= IEEE80211_TX_STAT_ACK;
+		info->status.ampdu_ack_len = 1;
+	} else {
+		info->flags &= ~IEEE80211_TX_STAT_ACK;
+	}
+
 	__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
 
 out:
@@ -1527,6 +1600,7 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 	for (cur_info = &free->info[0]; count < total; cur_info++) {
 		u32 msdu, info = le32_to_cpu(*cur_info);
 		u8 i;
+		u32 tx_cnt, tx_status, ampdu;
 
 		/*
 		 * 1'b1: new wcid pair.
@@ -1559,15 +1633,25 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 				msdu = (info >> (15 * i)) & MT_TX_FREE_MSDU_ID_V3;
 				if (msdu == MT_TX_FREE_MSDU_ID_V3)
 					continue;
+
+				/* TODO:  How to get tx_cnt, tx_status, ampdu*/
+				tx_status = 0;
+				tx_cnt = 1;
+				ampdu = 1;
 			} else {
 				msdu = FIELD_GET(MT_TX_FREE_MSDU_ID, info);
+
+				tx_cnt = FIELD_GET(MT_TX_FREE_TXCNT, info);
+				/* 0 = success, 1 dropped-by-hw, 2 dropped-by-cpu */
+				tx_status = FIELD_GET(MT_TX_FREE_STATUS_V1, info);
+				ampdu = FIELD_GET(MT_TX_FREE_HEAD_OF_PAGE, info);
 			}
 			count++;
 			txwi = mt76_token_release(mdev, msdu, &wake);
 			if (!txwi)
 				continue;
 
-			mt7915_txwi_free(dev, txwi, sta, &free_list);
+			mt7915_txwi_free(dev, txwi, sta, &free_list, tx_cnt, tx_status, ampdu);
 		}
 	}
 
@@ -1599,7 +1683,10 @@ mt7915_mac_tx_free_v0(struct mt7915_dev *dev, void *data, int len)
 		if (!txwi)
 			continue;
 
-		mt7915_txwi_free(dev, txwi, NULL, &free_list);
+		/* TODO: Can we report tx_cnt, status, ampdu in this path? */
+		mt7915_txwi_free(dev, txwi, NULL, &free_list,
+				 1 /* tx_cnt */, 0 /* tx-status-ok */,
+				 0/* ampdu */);
 	}
 
 	mt7915_mac_tx_free_done(dev, &free_list, wake);
@@ -2132,7 +2219,7 @@ void mt7915_tx_token_put(struct mt7915_dev *dev)
 
 	spin_lock_bh(&dev->mt76.token_lock);
 	idr_for_each_entry(&dev->mt76.token, txwi, id) {
-		mt7915_txwi_free(dev, txwi, NULL, NULL);
+		mt7915_txwi_free(dev, txwi, NULL, NULL, 0, 1, 0);
 		dev->mt76.token_count--;
 	}
 	spin_unlock_bh(&dev->mt76.token_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index 503a4b90ad11..a3774df64e8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -307,7 +307,7 @@ struct mt7915_tx_free {
 	__le16 rx_byte_cnt;
 	__le16 ctrl;
 	__le32 txd;
-	__le32 info[];
+	__le32 info[]; /* DW3+ */
 } __packed __aligned(4);
 
 #define MT_TX_FREE_VER			GENMASK(18, 16)
@@ -320,6 +320,10 @@ struct mt7915_tx_free {
 #define MT_TX_FREE_LATENCY		GENMASK(12, 0)
 /* when configured for txcount mode.  See MT_PLE_HOST_RPT0_TX_LATENCY. */
 #define MT_TX_FREE_TXCNT		GENMASK(12, 0)
+/* 0: success, others: dropped */
+#define MT_TX_FREE_STATUS_V1		GENMASK(14, 13)
+/* 0:  not MPDU, 1:  MSDU is head pkt of TXD page (MPDU) */
+#define MT_TX_FREE_HEAD_OF_PAGE		BIT(15)
 #define MT_TX_FREE_MSDU_ID		GENMASK(30, 16)
 #define MT_TX_FREE_PAIR			BIT(31)
 #define MT_TX_FREE_MPDU_HEADER		BIT(30)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 710ca757fb52..910dc36bacc3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1158,6 +1158,10 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"rx_ba_cnt",
 
 	/* per vif counters */
+	"v_tx_mpdu_attempts", /* counting any retries */
+	"v_tx_mpdu_fail",  /* frames that failed even after retry */
+	"v_tx_mpdu_retry", /* number of times frames were retried */
+	"v_tx_mpdu_ok", /* frames that succeeded, perhaps after retry */
 	"v_tx_mode_cck",
 	"v_tx_mode_ofdm",
 	"v_tx_mode_ht",
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 80279f342109..ac78fcf285bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -987,6 +987,10 @@ static const char mt7921_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"rx_ampdu_bytes_cnt",
 	"rx_ba_cnt",
 	/* per vif counters */
+	"v_tx_mpdu_attempts", /* counting any retries */
+	"v_tx_mpdu_fail",  /* frames that failed even after retry */
+	"v_tx_mpdu_retry", /* number of times frames were retried */
+	"v_tx_mpdu_ok", /* frames that succeeded, perhaps after retry */
 	"v_tx_mode_cck",
 	"v_tx_mode_ofdm",
 	"v_tx_mode_ht",
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 1d08d99e298c..4e24116abc14 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -62,12 +62,15 @@ mt76_tx_status_unlock(struct mt76_dev *dev, struct sk_buff_head *list)
 		};
 		struct mt76_tx_cb *cb = mt76_tx_skb_cb(skb);
 		struct mt76_wcid *wcid;
+		struct ieee80211_rate_status status_rate = { 0 };
 
 		wcid = rcu_dereference(dev->wcid[cb->wcid]);
 		if (wcid) {
 			status.sta = wcid_to_sta(wcid);
-			status.rates = NULL;
-			status.n_rates = 0;
+			status.rates = &status_rate;
+			status.n_rates = 1;
+			status_rate.rate_idx = wcid->rate;
+			status_rate.try_count = 1;
 		}
 
 		hw = mt76_tx_status_get_hw(dev, skb);
@@ -228,15 +231,24 @@ void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *
 	struct ieee80211_tx_status status = {
 		.skb = skb,
 		.free_list = free_list,
+		.info = IEEE80211_SKB_CB(skb),
 	};
 	struct mt76_wcid *wcid = NULL;
 	struct ieee80211_hw *hw;
 	struct sk_buff_head list;
+	struct ieee80211_rate_status status_rate = { 0 };
 
 	rcu_read_lock();
 
-	if (wcid_idx < ARRAY_SIZE(dev->wcid))
+	if (wcid_idx < ARRAY_SIZE(dev->wcid)) {
 		wcid = rcu_dereference(dev->wcid[wcid_idx]);
+		if (wcid) {
+			status.rates = &status_rate;
+			status.n_rates = 1;
+			status_rate.rate_idx = wcid->rate;
+			status_rate.try_count = 1;
+		}
+	}
 
 	mt76_tx_check_non_aql(dev, wcid, skb);
 
-- 
2.20.1

