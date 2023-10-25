Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57AD7D73DA
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Oct 2023 21:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjJYTEL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Oct 2023 15:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbjJYTEH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Oct 2023 15:04:07 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AEC133
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 12:04:03 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E32D2300067
        for <linux-wireless@vger.kernel.org>; Wed, 25 Oct 2023 19:04:00 +0000 (UTC)
Received: from ben-dt5.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 6DD9613C2B5;
        Wed, 25 Oct 2023 12:04:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 6DD9613C2B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1698260640;
        bh=gN95yiWCln0UUx0X7aQGG9NI2lxwo9hk/K5rA/SeM0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CB1dX4Awjndn/MVdbgklHWBVKB43VyUMSZIn42P9dCv83RwsZwuIqOGxB2vET67p8
         a80UqC+XyG1hf8AJnUxgrckvVb5aseU98WJ6p71ZYHORWZk9794lJvzNcRwj3owFk9
         Ng9BZH3PisPc09umQo+N6KYRwiW6RxpHeYGsoCyU=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 05/12] wifi: mt76: mt7915: report tx-retries
Date:   Wed, 25 Oct 2023 12:03:47 -0700
Message-Id: <20231025190351.2141832-5-greearb@candelatech.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20231025190351.2141832-1-greearb@candelatech.com>
References: <20231025190351.2141832-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1698260641-o9bYsp4m2qlT
X-MDID-O: us5;at1;1698260641;o9bYsp4m2qlT;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/net/wireless/mediatek/mt76/mt76.h     |  8 +-
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  3 +-
 .../wireless/mediatek/mt76/mt76_connac2_mac.h |  1 +
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 76 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  1 +
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 27 ++++---
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  6 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  9 ++-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 14 ++--
 .../net/wireless/mediatek/mt76/mt7925/mac.c   |  3 +-
 .../net/wireless/mediatek/mt76/mt792x_core.c  |  4 +
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  4 +-
 drivers/net/wireless/mediatek/mt76/tx.c       | 13 +++-
 15 files changed, 137 insertions(+), 38 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index cb76053973aa..11651e5c9488 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1776,6 +1776,10 @@ void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
 
 	wi->sta_count++;
 
+	data[ei++] += stats->tx_attempts;
+	data[ei++] += stats->tx_failed;
+	data[ei++] += stats->tx_retries;
+	data[ei++] += stats->tx_mpdu_ok;
 	data[ei++] += stats->tx_mode[MT_PHY_TYPE_CCK];
 	data[ei++] += stats->tx_mode[MT_PHY_TYPE_OFDM];
 	data[ei++] += stats->tx_mode[MT_PHY_TYPE_HT];
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index d00a2da8d2f1..a9f3f66b4e3d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -274,13 +274,15 @@ enum mt76_phy_type {
 struct mt76_sta_stats {
 	u64 tx_mode[__MT_PHY_TYPE_MAX];
 	u64 tx_bw[5];		/* 20, 40, 80, 160, 320 */
+	/* frames that succeeded, perhaps after retry */
+	unsigned long tx_mpdu_ok;
 	u64 tx_nss[4];		/* 1, 2, 3, 4 */
 	u64 tx_mcs[16];		/* mcs idx */
 	u64 tx_bytes;
 	/* WED TX */
-	u32 tx_packets;		/* unit: MSDU */
-	u32 tx_retries;
-	u32 tx_failed;
+	unsigned long tx_attempts; /* Counting any retries. unit: MSDU */
+	unsigned long tx_retries; /* number of times frames were retried */
+	unsigned long tx_failed; /* failed even after retries */
 	/* WED RX */
 	u64 rx_bytes;
 	u32 rx_packets;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 1f29d8cd900c..6d5cf5e92885 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -428,7 +428,8 @@ int mt76_connac2_mac_fill_rx_rate(struct mt76_dev *dev,
 void mt76_connac2_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi);
 void mt76_connac2_txwi_free(struct mt76_dev *dev, struct mt76_txwi_cache *t,
 			    struct ieee80211_sta *sta,
-			    struct list_head *free_list);
+			    struct list_head *free_list,
+			    u32 tx_cnt, u32 tx_status, u32 ampdu);
 void mt76_connac2_tx_token_put(struct mt76_dev *dev);
 
 /* connac3 */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
index bd2a92467a97..6b280a639a74 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
@@ -37,6 +37,7 @@ enum {
 #define MT_TX_FREE_COUNT		GENMASK(12, 0)
 /* 0: success, others: dropped */
 #define MT_TX_FREE_STATUS		GENMASK(14, 13)
+#define MT_TX_FREE_HEAD_OF_PAGE         BIT(15)
 #define MT_TX_FREE_MSDU_ID		GENMASK(30, 16)
 #define MT_TX_FREE_PAIR			BIT(31)
 /* will support this field in further revision */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index ab9a4d9fecdb..c8619dab15be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -509,8 +509,10 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 			mt76_connac_lmac_mapping(skb_get_queue_mapping(skb));
 
 		/* mt7915 WA only counts WED path */
-		if (is_mt7915(dev) && mtk_wed_device_active(&dev->mmio.wed))
-			wcid->stats.tx_packets++;
+		if (is_mt7915(dev) && mtk_wed_device_active(&dev->mmio.wed)) {
+			wcid->stats.tx_attempts++;
+			wcid->stats.tx_mpdu_ok++;
+		}
 	}
 
 	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + sz_txd) |
@@ -1130,16 +1132,21 @@ EXPORT_SYMBOL_GPL(mt76_connac2_tx_check_aggr);
 
 void mt76_connac2_txwi_free(struct mt76_dev *dev, struct mt76_txwi_cache *t,
 			    struct ieee80211_sta *sta,
-			    struct list_head *free_list)
+			    struct list_head *free_list,
+			    u32 tx_cnt, u32 tx_status, u32 ampdu)
 {
 	struct mt76_wcid *wcid;
 	__le32 *txwi;
 	u16 wcid_idx;
+	struct ieee80211_tx_info *info;
+	struct ieee80211_tx_rate *rate;
 
 	mt76_connac_txp_skb_unmap(dev, t);
 	if (!t->skb)
 		goto out;
 
+	rcu_read_lock(); /* protect wcid access */
+
 	txwi = (__le32 *)mt76_get_txwi_ptr(dev, t);
 	if (sta) {
 		wcid = (struct mt76_wcid *)sta->drv_priv;
@@ -1162,6 +1169,67 @@ void mt76_connac2_txwi_free(struct mt76_dev *dev, struct mt76_txwi_cache *t,
 	if (sta && likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
 		mt76_connac2_tx_check_aggr(sta, txwi);
 
+	info = IEEE80211_SKB_CB(t->skb);
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
+		struct mt76_sta_stats *stats = &wcid->stats;
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
+		stats->tx_attempts += tx_cnt;
+		stats->tx_retries += tx_cnt - 1;
+
+		if (tx_status == 0)
+			stats->tx_mpdu_ok++;
+		else
+			stats->tx_failed++;
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
 	__mt76_tx_complete_skb(dev, wcid_idx, t->skb, free_list);
 out:
 	t->skb = NULL;
@@ -1176,7 +1244,7 @@ void mt76_connac2_tx_token_put(struct mt76_dev *dev)
 
 	spin_lock_bh(&dev->token_lock);
 	idr_for_each_entry(&dev->token, txwi, id) {
-		mt76_connac2_txwi_free(dev, txwi, NULL, NULL);
+		mt76_connac2_txwi_free(dev, txwi, NULL, NULL, 1, 0, 1);
 		dev->token_count--;
 	}
 	spin_unlock_bh(&dev->token_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 9f500151b293..fce4318a1031 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -342,6 +342,7 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
 	struct mt7915_dev *dev = phy->dev;
 
 	hw->queues = 4;
+	hw->max_report_rates = 1;
 	hw->max_rx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
 	hw->max_tx_aggregation_subframes = IEEE80211_MAX_AMPDU_BUF_HE;
 	hw->netdev_features = NETIF_F_RXCSUM;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 92d5b0fc99d1..ad20d10201b4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -904,6 +904,7 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 	for (cur_info = tx_info; count < total; cur_info++) {
 		u32 msdu, info;
 		u8 i;
+		u32 tx_cnt = 0, tx_status = 0, ampdu = 1;
 
 		if (WARN_ON_ONCE((void *)cur_info >= end))
 			return;
@@ -933,21 +934,14 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 		}
 
 		if (!mtk_wed_device_active(&mdev->mmio.wed) && wcid) {
-			u32 tx_retries = 0, tx_failed = 0;
-
 			if (v3 && (info & MT_TX_FREE_MPDU_HEADER_V3)) {
-				tx_retries =
-					FIELD_GET(MT_TX_FREE_COUNT_V3, info) - 1;
-				tx_failed = tx_retries +
-					!!FIELD_GET(MT_TX_FREE_STAT_V3, info);
+				tx_cnt = FIELD_GET(MT_TX_FREE_COUNT_V3, info);
+				tx_status = FIELD_GET(MT_TX_FREE_STAT_V3, info);
 			} else if (!v3 && (info & MT_TX_FREE_MPDU_HEADER)) {
-				tx_retries =
-					FIELD_GET(MT_TX_FREE_COUNT, info) - 1;
-				tx_failed = tx_retries +
-					!!FIELD_GET(MT_TX_FREE_STAT, info);
+				tx_cnt = FIELD_GET(MT_TX_FREE_COUNT, info);
+				tx_status = FIELD_GET(MT_TX_FREE_STAT, info);
+				ampdu = FIELD_GET(MT_TX_FREE_HEAD_OF_PAGE, info);
 			}
-			wcid->stats.tx_retries += tx_retries;
-			wcid->stats.tx_failed += tx_failed;
 		}
 
 		if (v3 && (info & MT_TX_FREE_MPDU_HEADER_V3))
@@ -966,7 +960,9 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 			if (!txwi)
 				continue;
 
-			mt76_connac2_txwi_free(mdev, txwi, sta, &free_list);
+			mt76_connac2_txwi_free(mdev, txwi, sta, &free_list, tx_cnt, tx_status, ampdu);
+			/* don't count retries twice, in case we are v3 */
+			tx_cnt = 1;
 		}
 	}
 
@@ -998,7 +994,10 @@ mt7915_mac_tx_free_v0(struct mt7915_dev *dev, void *data, int len)
 		if (!txwi)
 			continue;
 
-		mt76_connac2_txwi_free(mdev, txwi, NULL, &free_list);
+		/* TODO: Can we report tx_cnt, status, ampdu in this path? */
+		mt76_connac2_txwi_free(mdev, txwi, NULL, &free_list,
+				       1 /* tx_cnt */, 0 /* tx-status-ok */,
+				       1/* ampdu */);
 	}
 
 	mt7915_mac_tx_free_done(dev, &free_list, wake);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index a3fd54cc1911..e22d1d35161e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1113,7 +1113,7 @@ static void mt7915_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES64);
 
 		if (!mt7915_mcu_wed_wa_tx_stats(phy->dev, msta->wcid.idx)) {
-			sinfo->tx_packets = msta->wcid.stats.tx_packets;
+			sinfo->tx_packets = msta->wcid.stats.tx_mpdu_ok;
 			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
 		}
 
@@ -1358,6 +1358,10 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"ul_hetrig_4mu_cnt",
 
 	/* per vif counters */
+	"v_tx_mpdu_attempts", /* counting any retries */
+	"v_tx_mpdu_fail",  /* frames that failed even after retry */
+	"v_tx_mpdu_retry", /* number of times frames were retried */
+	"v_tx_mpdu_ok", /* frames that succeeded, perhaps after retry */
 	"v_tx_mode_cck",
 	"v_tx_mode_ofdm",
 	"v_tx_mode_ht",
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b22f06d4411a..3a4eec00ccb1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3841,10 +3841,13 @@ int mt7915_mcu_wed_wa_tx_stats(struct mt7915_dev *dev, u16 wlan_idx)
 	rcu_read_lock();
 
 	wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
-	if (wcid)
-		wcid->stats.tx_packets += le32_to_cpu(res->tx_packets);
-	else
+	if (wcid) {
+		/* TODO:  Nice if this path reported retries and failures */
+		wcid->stats.tx_attempts += le32_to_cpu(res->tx_packets);
+		wcid->stats.tx_mpdu_ok += le32_to_cpu(res->tx_packets);
+	} else {
 		ret = -EINVAL;
+	}
 
 	rcu_read_unlock();
 out:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 90e738126bf7..f3d61e77fa4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -512,7 +512,7 @@ static void mt7921_mac_tx_free(struct mt792x_dev *dev, void *data, int len)
 
 	for (i = 0; i < count; i++) {
 		u32 msdu, info = le32_to_cpu(tx_info[i]);
-		u8 stat;
+		u32 tx_status, tx_cnt, ampdu;
 
 		/* 1'b1: new wcid pair.
 		 * 1'b0: msdu_id with the same 'wcid pair' as above.
@@ -538,19 +538,17 @@ static void mt7921_mac_tx_free(struct mt792x_dev *dev, void *data, int len)
 		}
 
 		msdu = FIELD_GET(MT_TX_FREE_MSDU_ID, info);
-		stat = FIELD_GET(MT_TX_FREE_STATUS, info);
 
-		if (wcid) {
-			wcid->stats.tx_retries +=
-				FIELD_GET(MT_TX_FREE_COUNT, info) - 1;
-			wcid->stats.tx_failed += !!stat;
-		}
+		/* 0 = success, 1 dropped-by-hw, 2 dropped-by-cpu */
+		tx_status = FIELD_GET(MT_TX_FREE_STATUS, info);
+		tx_cnt = FIELD_GET(MT_TX_FREE_COUNT, info);
+		ampdu = FIELD_GET(MT_TX_FREE_HEAD_OF_PAGE, info);
 
 		txwi = mt76_token_release(mdev, msdu, &wake);
 		if (!txwi)
 			continue;
 
-		mt76_connac2_txwi_free(mdev, txwi, sta, &free_list);
+		mt76_connac2_txwi_free(mdev, txwi, sta, &free_list, tx_cnt, tx_status, ampdu);
 	}
 
 	if (wake)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 1b9fbd9a140d..3cd771ac35d1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -751,7 +751,8 @@ mt7925_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 
 		/* counting non-offloading skbs */
 		wcid->stats.tx_bytes += skb->len;
-		wcid->stats.tx_packets++;
+		wcid->stats.tx_attempts++;
+		wcid->stats.tx_mpdu_ok++;
 	}
 
 	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len + sz_txd) |
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index 502be22dbe36..f92a43d5f5b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -338,6 +338,10 @@ static const char mt792x_gstrings_stats[][ETH_GSTRING_LEN] = {
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
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 09c7a28a3d51..7bc25e52c054 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1008,7 +1008,7 @@ static void mt7996_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->rx_bytes = msta->wcid.stats.rx_bytes;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES64);
 
-		sinfo->tx_packets = msta->wcid.stats.tx_packets;
+		sinfo->tx_packets = msta->wcid.stats.tx_mpdu_ok;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
 
 		sinfo->rx_packets = msta->wcid.stats.rx_packets;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index bf917beb9439..3ac6667907f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -486,7 +486,9 @@ mt7996_mcu_rx_all_sta_info_event(struct mt7996_dev *dev, struct sk_buff *skb)
 			if (!wcid)
 				break;
 
-			wcid->stats.tx_packets +=
+			wcid->stats.tx_mpdu_ok +=
+				le32_to_cpu(res->msdu_cnt[i].tx_msdu_cnt);
+			wcid->stats.tx_attempts +=
 				le32_to_cpu(res->msdu_cnt[i].tx_msdu_cnt);
 			wcid->stats.rx_packets +=
 				le32_to_cpu(res->msdu_cnt[i].rx_msdu_cnt);
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 1809b03292c3..81c16a1c1fbe 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -67,6 +67,7 @@ mt76_tx_status_unlock(struct mt76_dev *dev, struct sk_buff_head *list)
 		wcid = rcu_dereference(dev->wcid[cb->wcid]);
 		if (wcid) {
 			status.sta = wcid_to_sta(wcid);
+			rs.try_count = 1;
 			if (status.sta && (wcid->rate.flags || wcid->rate.legacy)) {
 				rs.rate_idx = wcid->rate;
 				status.rates = &rs;
@@ -243,15 +244,25 @@ void __mt76_tx_complete_skb(struct mt76_dev *dev, u16 wcid_idx, struct sk_buff *
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
+               }
+       }
+
 
 	mt76_tx_check_non_aql(dev, wcid, skb);
 
-- 
2.40.0

