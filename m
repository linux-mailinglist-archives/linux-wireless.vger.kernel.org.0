Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B18DF5FB3D
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2019 17:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfGDPx1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Jul 2019 11:53:27 -0400
Received: from nbd.name ([46.4.11.11]:38250 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbfGDPx1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Jul 2019 11:53:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=lY+QornffsIh56FvB5mn0yL43erCL/rhMor+NmRpYdE=; b=j9LU29Wi/vMG80F1PiBcKVcoC8
        iYwusbK2h7q4ZB9eGxGbZLwXUZepBKRJgD4HgTzPjwl1KERo/5RG7KWC+4J4PaB2lzmp32FI4xIQc
        Hj0WVSjWLiwp0mYfskQ7uViNxP3cjdzPmQ7e+qV5qVcKHHEDqcoUhYWOdAblHqrg7rQ4=;
Received: from p54ae9425.dip0.t-ipconnect.de ([84.174.148.37] helo=maeck-3.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hj432-0004qV-Uk
        for linux-wireless@vger.kernel.org; Thu, 04 Jul 2019 17:53:25 +0200
Received: by maeck-3.local (Postfix, from userid 501)
        id 611AC6165C12; Thu,  4 Jul 2019 17:53:24 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/4] mt76: mt7615: sync with mt7603 rate control changes
Date:   Thu,  4 Jul 2019 17:53:24 +0200
Message-Id: <20190704155324.56693-4-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190704155324.56693-1-nbd@nbd.name>
References: <20190704155324.56693-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

- Store the previous and current rate set in the driver + the TSF value
  at the time of the switch.
- Use the tx status TSF value to determine which rate set needs to be used
  as reference.
- Report only short or long GI rates for a single status event, not a mix.
- The hardware reports the last used rate index. Use it along with the
  retry count to figure out what rate was used for the first attempt.
- Use the same retry count value for all rate slots to make this calculation
  work.
- Derive the probe rate from the current rateset instead of the skb cb
- Do not wait for a status report for the probe frame before removing the
  probe rate from the rate table. Do it immediately after it was referenced
  in a tx status report.
- Use the first half of the first rate retry budget for the probe rate
  in order to avoid using too many retries on that rate
- Switch from lower rates to higher rates more conservatively
- enable hardware rate up/down selection

Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  19 ++-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 129 +++++++++++++-----
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  11 +-
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |   9 ++
 4 files changed, 124 insertions(+), 44 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index a6c2a132f960..280db9445d94 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -45,11 +45,19 @@ static void mt7615_mac_init(struct mt7615_dev *dev)
 	mt76_wr(dev, MT_DMA_DCR0, MT_DMA_DCR0_RX_VEC_DROP |
 		FIELD_PREP(MT_DMA_DCR0_MAX_RX_LEN, 3072));
 
-	mt76_wr(dev, MT_AGG_ARUCR, FIELD_PREP(MT_AGG_ARxCR_LIMIT(0), 7));
+	mt76_wr(dev, MT_AGG_ARUCR,
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(0), 7) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(1), 2) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(2), 2) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(3), 2) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(4), 1) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(5), 1) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(6), 1) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(7), 1));
+
 	mt76_wr(dev, MT_AGG_ARDCR,
-		FIELD_PREP(MT_AGG_ARxCR_LIMIT(0), 0) |
-		FIELD_PREP(MT_AGG_ARxCR_LIMIT(1),
-			   max_t(int, 0, MT7615_RATE_RETRY - 2)) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(0), MT7615_RATE_RETRY - 1) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(1), MT7615_RATE_RETRY - 1) |
 		FIELD_PREP(MT_AGG_ARxCR_LIMIT(2), MT7615_RATE_RETRY - 1) |
 		FIELD_PREP(MT_AGG_ARxCR_LIMIT(3), MT7615_RATE_RETRY - 1) |
 		FIELD_PREP(MT_AGG_ARxCR_LIMIT(4), MT7615_RATE_RETRY - 1) |
@@ -58,8 +66,7 @@ static void mt7615_mac_init(struct mt7615_dev *dev)
 		FIELD_PREP(MT_AGG_ARxCR_LIMIT(7), MT7615_RATE_RETRY - 1));
 
 	mt76_wr(dev, MT_AGG_ARCR,
-		(MT_AGG_ARCR_INIT_RATE1 |
-		 FIELD_PREP(MT_AGG_ARCR_RTS_RATE_THR, 2) |
+		(FIELD_PREP(MT_AGG_ARCR_RTS_RATE_THR, 2) |
 		 MT_AGG_ARCR_RATE_DOWN_RATIO_EN |
 		 FIELD_PREP(MT_AGG_ARCR_RATE_DOWN_RATIO, 1) |
 		 FIELD_PREP(MT_AGG_ARCR_RATE_UP_EXTRA_TH, 4)));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index b896d8ce9e72..5bfb4594b8ee 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -451,6 +451,7 @@ void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 			  struct ieee80211_tx_rate *probe_rate,
 			  struct ieee80211_tx_rate *rates)
 {
+	struct ieee80211_tx_rate *ref;
 	int wcid = sta->wcid.idx;
 	u32 addr = MT_WTBL_BASE + wcid * MT_WTBL_ENTRY_SIZE;
 	bool stbc = false;
@@ -459,7 +460,8 @@ void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 	u16 val[4];
 	u16 probe_val;
 	u32 w5, w27;
-	int i;
+	bool rateset;
+	int i, k;
 
 	if (!mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY, 0, 5000))
 		return;
@@ -467,6 +469,43 @@ void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 	for (i = n_rates; i < 4; i++)
 		rates[i] = rates[n_rates - 1];
 
+	rateset = !(sta->rate_set_tsf & BIT(0));
+	memcpy(sta->rateset[rateset].rates, rates,
+	       sizeof(sta->rateset[rateset].rates));
+	if (probe_rate) {
+		sta->rateset[rateset].probe_rate = *probe_rate;
+		ref = &sta->rateset[rateset].probe_rate;
+	} else {
+		sta->rateset[rateset].probe_rate.idx = -1;
+		ref = &sta->rateset[rateset].rates[0];
+	}
+
+	rates = sta->rateset[rateset].rates;
+	for (i = 0; i < ARRAY_SIZE(sta->rateset[rateset].rates); i++) {
+		/*
+		 * We don't support switching between short and long GI
+		 * within the rate set. For accurate tx status reporting, we
+		 * need to make sure that flags match.
+		 * For improved performance, avoid duplicate entries by
+		 * decrementing the MCS index if necessary
+		 */
+		if ((ref->flags ^ rates[i].flags) & IEEE80211_TX_RC_SHORT_GI)
+			rates[i].flags ^= IEEE80211_TX_RC_SHORT_GI;
+
+		for (k = 0; k < i; k++) {
+			if (rates[i].idx != rates[k].idx)
+				continue;
+			if ((rates[i].flags ^ rates[k].flags) &
+			    (IEEE80211_TX_RC_40_MHZ_WIDTH |
+			     IEEE80211_TX_RC_80_MHZ_WIDTH |
+			     IEEE80211_TX_RC_160_MHZ_WIDTH))
+				continue;
+
+			rates[i].idx--;
+		}
+
+	}
+
 	val[0] = mt7615_mac_tx_rate_val(dev, &rates[0], stbc, &bw);
 	bw_prev = bw;
 
@@ -513,17 +552,17 @@ void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 	mt76_wr(dev, MT_WTBL_RIUCR1,
 		FIELD_PREP(MT_WTBL_RIUCR1_RATE0, probe_val) |
 		FIELD_PREP(MT_WTBL_RIUCR1_RATE1, val[0]) |
-		FIELD_PREP(MT_WTBL_RIUCR1_RATE2_LO, val[0]));
+		FIELD_PREP(MT_WTBL_RIUCR1_RATE2_LO, val[1]));
 
 	mt76_wr(dev, MT_WTBL_RIUCR2,
-		FIELD_PREP(MT_WTBL_RIUCR2_RATE2_HI, val[0] >> 8) |
+		FIELD_PREP(MT_WTBL_RIUCR2_RATE2_HI, val[1] >> 8) |
 		FIELD_PREP(MT_WTBL_RIUCR2_RATE3, val[1]) |
-		FIELD_PREP(MT_WTBL_RIUCR2_RATE4, val[1]) |
+		FIELD_PREP(MT_WTBL_RIUCR2_RATE4, val[2]) |
 		FIELD_PREP(MT_WTBL_RIUCR2_RATE5_LO, val[2]));
 
 	mt76_wr(dev, MT_WTBL_RIUCR3,
 		FIELD_PREP(MT_WTBL_RIUCR3_RATE5_HI, val[2] >> 4) |
-		FIELD_PREP(MT_WTBL_RIUCR3_RATE6, val[2]) |
+		FIELD_PREP(MT_WTBL_RIUCR3_RATE6, val[3]) |
 		FIELD_PREP(MT_WTBL_RIUCR3_RATE7, val[3]));
 
 	mt76_wr(dev, MT_WTBL_UPDATE,
@@ -533,6 +572,9 @@ void mt7615_mac_set_rates(struct mt7615_dev *dev, struct mt7615_sta *sta,
 
 	mt76_wr(dev, addr + 27 * 4, w27);
 
+	mt76_set(dev, MT_LPON_T0CR, MT_LPON_T0CR_MODE); /* TSF read */
+	sta->rate_set_tsf = (mt76_rr(dev, MT_LPON_UTTR0) & ~BIT(0)) | rateset;
+
 	if (!(sta->wcid.tx_info & MT_WCID_TX_INFO_SET))
 		mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY, 0, 5000);
 
@@ -562,9 +604,9 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 
 	if (info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) {
 		spin_lock_bh(&dev->mt76.lock);
-		msta->rate_probe = true;
 		mt7615_mac_set_rates(dev, msta, &info->control.rates[0],
 				     msta->rates);
+		msta->rate_probe = true;
 		spin_unlock_bh(&dev->mt76.lock);
 	}
 
@@ -616,9 +658,13 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 			    struct ieee80211_tx_info *info, __le32 *txs_data)
 {
 	struct ieee80211_supported_band *sband;
-	int i, idx, count, final_idx = 0;
+	struct mt7615_rate_set *rs;
+	int first_idx = 0, last_idx;
+	int i, idx, count;
 	bool fixed_rate, ack_timeout;
 	bool probe, ampdu, cck = false;
+	bool rs_idx;
+	u32 rate_set_tsf;
 	u32 final_rate, final_rate_flags, final_nss, txs;
 
 	fixed_rate = info->status.rates[0].count;
@@ -629,6 +675,7 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 
 	txs = le32_to_cpu(txs_data[3]);
 	count = FIELD_GET(MT_TXS3_TX_COUNT, txs);
+	last_idx = FIELD_GET(MT_TXS3_LAST_TX_RATE, txs);
 
 	txs = le32_to_cpu(txs_data[0]);
 	final_rate = FIELD_GET(MT_TXS0_TX_RATE, txs);
@@ -650,38 +697,56 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 	if (ampdu || (info->flags & IEEE80211_TX_CTL_AMPDU))
 		info->flags |= IEEE80211_TX_STAT_AMPDU | IEEE80211_TX_CTL_AMPDU;
 
+	first_idx = max_t(int, 0, last_idx - (count + 1) / MT7615_RATE_RETRY);
+
 	if (fixed_rate && !probe) {
 		info->status.rates[0].count = count;
+		i = 0;
 		goto out;
 	}
 
-	for (i = 0, idx = 0; i < ARRAY_SIZE(info->status.rates); i++) {
-		int cur_count = min_t(int, count, 2 * MT7615_RATE_RETRY);
+	rate_set_tsf = READ_ONCE(sta->rate_set_tsf);
+	rs_idx = !((u32)(FIELD_GET(MT_TXS4_F0_TIMESTAMP, le32_to_cpu(txs_data[4])) -
+			 rate_set_tsf) < 1000000);
+	rs_idx ^= rate_set_tsf & BIT(0);
+	rs = &sta->rateset[rs_idx];
 
-		if (!i && probe) {
-			cur_count = 1;
-		} else {
-			info->status.rates[i] = sta->rates[idx];
-			idx++;
-		}
+	if (!first_idx && rs->probe_rate.idx >= 0) {
+		info->status.rates[0] = rs->probe_rate;
 
-		if (i && info->status.rates[i].idx < 0) {
-			info->status.rates[i - 1].count += count;
-			break;
+		spin_lock_bh(&dev->mt76.lock);
+		if (sta->rate_probe) {
+			mt7615_mac_set_rates(dev, sta, NULL, sta->rates);
+			sta->rate_probe = false;
 		}
+		spin_unlock_bh(&dev->mt76.lock);
+	} else
+		info->status.rates[0] = rs->rates[first_idx / 2];
+	info->status.rates[0].count = 0;
 
-		if (!count) {
-			info->status.rates[i].idx = -1;
-			break;
-		}
+	for (i = 0, idx = first_idx; count && idx <= last_idx; idx++) {
+		struct ieee80211_tx_rate *cur_rate;
+		int cur_count;
 
-		info->status.rates[i].count = cur_count;
-		final_idx = i;
+		cur_rate = &rs->rates[idx / 2];
+		cur_count = min_t(int, MT7615_RATE_RETRY, count);
 		count -= cur_count;
+
+		if (idx && (cur_rate->idx != info->status.rates[i].idx ||
+			    cur_rate->flags != info->status.rates[i].flags)) {
+			i++;
+			if (i == ARRAY_SIZE(info->status.rates))
+				break;
+
+			info->status.rates[i] = *cur_rate;
+			info->status.rates[i].count = 0;
+		}
+
+		info->status.rates[i].count += cur_count;
 	}
 
 out:
-	final_rate_flags = info->status.rates[final_idx].flags;
+	final_rate_flags = info->status.rates[i].flags;
 
 	switch (FIELD_GET(MT_TX_RATE_MODE, final_rate)) {
 	case MT_PHY_TYPE_CCK:
@@ -713,8 +778,8 @@ static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 		return false;
 	}
 
-	info->status.rates[final_idx].idx = final_rate;
-	info->status.rates[final_idx].flags = final_rate_flags;
+	info->status.rates[i].idx = final_rate;
+	info->status.rates[i].flags = final_rate_flags;
 
 	return true;
 }
@@ -735,16 +800,6 @@ static bool mt7615_mac_add_txs_skb(struct mt7615_dev *dev,
 	if (skb) {
 		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 
-		if (info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) {
-			spin_lock_bh(&dev->mt76.lock);
-			if (sta->rate_probe) {
-				mt7615_mac_set_rates(dev, sta, NULL,
-						     sta->rates);
-				sta->rate_probe = false;
-			}
-			spin_unlock_bh(&dev->mt76.lock);
-		}
-
 		if (!mt7615_fill_txs(dev, sta, info, txs_data)) {
 			ieee80211_tx_info_clear_status(info);
 			info->status.rates[0].idx = -1;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 1135023507b1..2f43101343c3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -42,12 +42,21 @@ enum mt7615_hw_txq_id {
 	MT7615_TXQ_FWDL,
 };
 
+struct mt7615_rate_set {
+	struct ieee80211_tx_rate probe_rate;
+	struct ieee80211_tx_rate rates[4];
+};
+
 struct mt7615_sta {
 	struct mt76_wcid wcid; /* must be first */
 
 	struct mt7615_vif *vif;
 
-	struct ieee80211_tx_rate rates[8];
+	struct ieee80211_tx_rate rates[4];
+
+	struct mt7615_rate_set rateset[2];
+	u32 rate_set_tsf;
+
 	u8 rate_count;
 	u8 n_rates;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index ea40581dc870..f2cd858730c3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -187,6 +187,15 @@
 
 #define MT_WTBL_W27_CC_BW_SEL		GENMASK(6, 5)
 
+#define MT_LPON_BASE			0x24200
+#define MT_LPON(_n)			(MT_LPON_BASE + (_n))
+
+#define MT_LPON_T0CR			MT_LPON(0x010)
+#define MT_LPON_T0CR_MODE		GENMASK(1, 0)
+
+#define MT_LPON_UTTR0			MT_LPON(0x018)
+#define MT_LPON_UTTR1			MT_LPON(0x01c)
+
 #define MT_EFUSE_BASE			0x81070000
 #define MT_EFUSE_BASE_CTRL		0x000
 #define MT_EFUSE_BASE_CTRL_EMPTY	BIT(30)
-- 
2.17.0

