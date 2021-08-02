Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1DA43DDBEC
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 17:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234579AbhHBPIg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 11:08:36 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:53873 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234807AbhHBPId (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 11:08:33 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.166])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id CD56FA006D
        for <linux-wireless@vger.kernel.org>; Mon,  2 Aug 2021 15:08:18 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 90CE990006F
        for <linux-wireless@vger.kernel.org>; Mon,  2 Aug 2021 15:08:18 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 2049213C2B4;
        Mon,  2 Aug 2021 08:08:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 2049213C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627916898;
        bh=2Gnqxo4Ws9RusvXsjO+S0AGrgZmuNSggb2Z/+9aLzhs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cWk4c+yEuUxgacRgERQGiENyVQx/0tdyJKtSFqO6hWxeptdTqIeK81+I61pR3FHTX
         rq8g1PCcJdgyVvFqmjqrfKeGX/JBGdj+RlA09nliwSCkkiFxM6Q+YP5l1S+Wet9Tn2
         QnMwmyrvd6kFQGSLe8JMd/8oIUgbSPp9pQPQDue4=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v6 2/7] mt76: mt7915: add tx stats gathered from tx-status callbacks
Date:   Mon,  2 Aug 2021 08:08:03 -0700
Message-Id: <20210802150808.30113-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210802150808.30113-1-greearb@candelatech.com>
References: <20210802150808.30113-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1627916899-W9GkwK7DEl8o
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
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 36 +++++++++++++++----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 14 ++++++++
 3 files changed, 44 insertions(+), 7 deletions(-)

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
index f1574538315d..6f445999e516 100644
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
+	u32 txrate, txs, txs5, txs6, txs7, mode;
 
 	mt76_tx_status_lock(mdev, &list);
 	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
@@ -1322,6 +1322,9 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 		goto out;
 
 	txs = le32_to_cpu(txs_data[0]);
+	txs5 = le32_to_cpu(txs_data[5]);
+	txs6 = le32_to_cpu(txs_data[6]);
+	txs7 = le32_to_cpu(txs_data[7]);
 
 	info = IEEE80211_SKB_CB(skb);
 	if (!(txs & MT_TXS0_ACK_ERROR_MASK))
@@ -1333,15 +1336,27 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 
 	info->status.rates[0].idx = -1;
 
-	if (!wcid->sta)
-		goto out;
+	stats->tx_mpdu_attempts += FIELD_GET(MT_TXS5_F1_MPDU_TX_COUNT, txs5);
+	stats->tx_mpdu_fail += FIELD_GET(MT_TXS6_F1_MPDU_FAIL_COUNT, txs6);
+	stats->tx_mpdu_retry += FIELD_GET(MT_TXS7_F1_MPDU_RETRY_COUNT, txs7);
 
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
@@ -1389,18 +1404,24 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
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
@@ -1443,12 +1464,13 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
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
index 33be449309e0..a8617ba69a21 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -64,6 +64,16 @@ enum mt7915_rxq_id {
 	MT7915_RXQ_MCU_WA_EXT,
 };
 
+struct mt7915_sta_stats {
+	unsigned long tx_mpdu_attempts;
+	unsigned long tx_mpdu_fail;
+	unsigned long tx_mpdu_retry;
+	unsigned long tx_mode[MT_PHY_TYPE_HE_LAST]; /* See mt76_phy_type */
+	unsigned long tx_bw[4]; /* 20, 40, 80, 160 */
+	unsigned long tx_nss[4]; /* 1, 2, 3, 4 */
+	unsigned long tx_mcs[16]; /* mcs idx */
+};
+
 struct mt7915_sta_key_conf {
 	s8 keyidx;
 	u8 key[16];
@@ -82,8 +92,11 @@ struct mt7915_sta {
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
@@ -103,6 +116,7 @@ struct mib_stats {
 	u32 rts_cnt;
 	u32 rts_retries_cnt;
 	u32 ba_miss_cnt;
+	/* Add more stats here, updated from mac_update_stats */
 };
 
 struct mt7915_hif {
-- 
2.20.1

