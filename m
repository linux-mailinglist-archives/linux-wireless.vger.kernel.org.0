Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9BC3E022F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Aug 2021 15:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbhHDNn4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Aug 2021 09:43:56 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:43890 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236659AbhHDNnz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Aug 2021 09:43:55 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.218])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 37EA41C0071
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 13:43:42 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 0B7DF84008B
        for <linux-wireless@vger.kernel.org>; Wed,  4 Aug 2021 13:43:42 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id ABC9F13C2B3;
        Wed,  4 Aug 2021 06:43:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com ABC9F13C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628084621;
        bh=cExO42V5Dd+kPiHmqDtB5z8/O4BCwqkahf84uYsvJCM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EySUvlKcxpHqw4LvBXe8qx8Zfyz2f1eioRsmKcnO2co/1X5fq9sfi7tACTvfjKAfZ
         NxZoagbfqwsoXo6s96uE+YnWDnIb5rD6cD59jzCzWtkuE2tsV0bEJJYqcYSW1vEVrD
         BRokjEbZKDvOv0La1yMBjumX/+8ITRy1xc32l03A=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v7 2/7] mt76: mt7915: add tx stats gathered from tx-status callbacks
Date:   Wed,  4 Aug 2021 06:43:30 -0700
Message-Id: <20210804134337.2582-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210804134337.2582-1-greearb@candelatech.com>
References: <20210804134337.2582-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628084622-1g-r__m3G_i6
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Add tx-mode (ofdma, ht, vht, HE) histogram,
tx-ru-idx histogram, and tx-bandwidth histogram.
Also add tx attempts and tx success counters.

All of this is per-station.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 31 ++++++++++++++-----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 11 +++++++
 3 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index b41faedee001..436bf2b8e2cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -755,6 +755,7 @@ enum mt76_phy_type {
 	MT_PHY_TYPE_HE_EXT_SU,
 	MT_PHY_TYPE_HE_TB,
 	MT_PHY_TYPE_HE_MU,
+	MT_PHY_TYPE_HE_LAST, /* keep last */
 };
 
 #define CCK_RATE(_idx, _rate) {					\
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index f1574538315d..a17b02613bd2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1304,7 +1304,7 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 
 static bool
 mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
-		       __le32 *txs_data)
+		       __le32 *txs_data, struct mt7915_sta_stats *stats)
 {
 	struct ieee80211_supported_band *sband;
 	struct mt76_dev *mdev = &dev->mt76;
@@ -1314,7 +1314,7 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 	struct rate_info rate = {};
 	struct sk_buff *skb;
 	bool cck = false;
-	u32 txrate, txs;
+	u32 txrate, txs, mode;
 
 	mt76_tx_status_lock(mdev, &list);
 	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
@@ -1333,15 +1333,23 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 
 	info->status.rates[0].idx = -1;
 
-	if (!wcid->sta)
-		goto out;
-
 	txrate = FIELD_GET(MT_TXS0_TX_RATE, txs);
 
 	rate.mcs = FIELD_GET(MT_TX_RATE_IDX, txrate);
 	rate.nss = FIELD_GET(MT_TX_RATE_NSS, txrate) + 1;
 
-	switch (FIELD_GET(MT_TX_RATE_MODE, txrate)) {
+	stats->tx_nss[rate.nss - 1]++;
+	/* It appears that rate.mcs even for HT may be small, considering in HT
+	 * code below it is multiplied... but not certain on that,
+	 * so code safely.
+	 */
+	if (rate.mcs >= ARRAY_SIZE(stats->tx_mcs))
+		stats->tx_mcs[ARRAY_SIZE(stats->tx_mcs) - 1]++;
+	else
+		stats->tx_mcs[rate.mcs]++;
+
+	mode = FIELD_GET(MT_TX_RATE_MODE, txrate);
+	switch (mode) {
 	case MT_PHY_TYPE_CCK:
 		cck = true;
 		fallthrough;
@@ -1389,18 +1397,24 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 		goto out;
 	}
 
+	stats->tx_mode[mode]++;
+
 	switch (FIELD_GET(MT_TXS0_BW, txs)) {
 	case IEEE80211_STA_RX_BW_160:
 		rate.bw = RATE_INFO_BW_160;
+		stats->tx_bw[3]++;
 		break;
 	case IEEE80211_STA_RX_BW_80:
 		rate.bw = RATE_INFO_BW_80;
+		stats->tx_bw[2]++;
 		break;
 	case IEEE80211_STA_RX_BW_40:
 		rate.bw = RATE_INFO_BW_40;
+		stats->tx_bw[1]++;
 		break;
 	default:
 		rate.bw = RATE_INFO_BW_20;
+		stats->tx_bw[0]++;
 		break;
 	}
 	wcid->rate = rate;
@@ -1443,12 +1457,13 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 	if (!wcid)
 		goto out;
 
-	mt7915_mac_add_txs_skb(dev, wcid, pid, txs_data);
+	msta = container_of(wcid, struct mt7915_sta, wcid);
+
+	mt7915_mac_add_txs_skb(dev, wcid, pid, txs_data, &msta->stats);
 
 	if (!wcid->sta)
 		goto out;
 
-	msta = container_of(wcid, struct mt7915_sta, wcid);
 	spin_lock_bh(&dev->sta_poll_lock);
 	if (list_empty(&msta->poll_list))
 		list_add_tail(&msta->poll_list, &dev->sta_poll_list);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 33be449309e0..9e024efe2175 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -64,6 +64,13 @@ enum mt7915_rxq_id {
 	MT7915_RXQ_MCU_WA_EXT,
 };
 
+struct mt7915_sta_stats {
+	unsigned long tx_mode[MT_PHY_TYPE_HE_LAST]; /* See mt76_phy_type */
+	unsigned long tx_bw[4]; /* 20, 40, 80, 160 */
+	unsigned long tx_nss[4]; /* 1, 2, 3, 4 */
+	unsigned long tx_mcs[16]; /* mcs idx */
+};
+
 struct mt7915_sta_key_conf {
 	s8 keyidx;
 	u8 key[16];
@@ -82,8 +89,11 @@ struct mt7915_sta {
 	unsigned long jiffies;
 	unsigned long ampdu_state;
 
+	struct mt7915_sta_stats stats;
+
 	struct mt7915_sta_key_conf bip;
 };
+
 struct mt7915_vif {
 	u16 idx;
 	u8 omac_idx;
@@ -103,6 +113,7 @@ struct mib_stats {
 	u32 rts_cnt;
 	u32 rts_retries_cnt;
 	u32 ba_miss_cnt;
+	/* Add more stats here, updated from mac_update_stats */
 };
 
 struct mt7915_hif {
-- 
2.20.1

