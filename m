Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8689D54D13
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2019 13:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbfFYLBb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jun 2019 07:01:31 -0400
Received: from nbd.name ([46.4.11.11]:33642 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729421AbfFYLBb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jun 2019 07:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+PMzwbpgEmsKInsOUNP98123UzcrZ7d4jQoQ4Zz/D2A=; b=VBsTb0qrY5Mdeb7H5Hr15mUB4a
        1TiXfmWtcMVM+oJRtgwXmzrND6tI9GfnOQ3y0NLKOirHB+tBXfV6ckKpD4XYFtAkQbhSj/8aDWxrq
        uU1MhlJI518U886ps8r8xC8CyvcWvcBXwKRhVmyDye/Uzn99ZoH1zpvW8oZFk1ytIZn4=;
Received: from p5b2063ee.dip0.t-ipconnect.de ([91.32.99.238] helo=maeck-3.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1hfjCb-0004oG-Co
        for linux-wireless@vger.kernel.org; Tue, 25 Jun 2019 13:01:29 +0200
Received: by maeck-3.local (Postfix, from userid 501)
        id E1F7A5F9A1A1; Tue, 25 Jun 2019 13:01:23 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: mt7603: rework and fix tx status reporting
Date:   Tue, 25 Jun 2019 13:01:22 +0200
Message-Id: <20190625110123.12979-1-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tx status reporting on mt7603 has a number of issues:

- the hardware can alter the first rate index, but it is not reported to
  the driver
- probing is very imprecise, because it alters the per-client rate set,
  but only considers info->status.rates for rate selection of a single probe
  packet
- short/long GI selection has limitations, which are not accurately reported
  to mac80211
- if rates are changed while packets are in flight, tx status reports for
  the old rate set might be processed based on the new selection

This led to very suboptimal rate selection with minstrel_ht.

This patch completely reworks tx status reporting to get rid of these
limitations:

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

With this patch, throughput under bad link conditions is improved
significantly, and there is a lot less rate fluctuation going on.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7603/init.c  |   5 +-
 .../net/wireless/mediatek/mt76/mt7603/mac.c   | 127 +++++++++++++-----
 .../wireless/mediatek/mt76/mt7603/mt7603.h    |  11 +-
 .../net/wireless/mediatek/mt76/mt7603/regs.h  |   6 +
 4 files changed, 108 insertions(+), 41 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index bce51997ff3b..d666e26afe90 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -229,9 +229,8 @@ mt7603_mac_init(struct mt7603_dev *dev)
 
 	mt76_wr(dev, MT_AGG_ARUCR, FIELD_PREP(MT_AGG_ARxCR_LIMIT(0), 7));
 	mt76_wr(dev, MT_AGG_ARDCR,
-		FIELD_PREP(MT_AGG_ARxCR_LIMIT(0), 0) |
-		FIELD_PREP(MT_AGG_ARxCR_LIMIT(1),
-			   max_t(int, 0, MT7603_RATE_RETRY - 2)) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(0), MT7603_RATE_RETRY - 1) |
+		FIELD_PREP(MT_AGG_ARxCR_LIMIT(1), MT7603_RATE_RETRY - 1) |
 		FIELD_PREP(MT_AGG_ARxCR_LIMIT(2), MT7603_RATE_RETRY - 1) |
 		FIELD_PREP(MT_AGG_ARxCR_LIMIT(3), MT7603_RATE_RETRY - 1) |
 		FIELD_PREP(MT_AGG_ARxCR_LIMIT(4), MT7603_RATE_RETRY - 1) |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 6629dd64cc22..e2ad5c769072 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -591,6 +591,7 @@ void mt7603_wtbl_set_rates(struct mt7603_dev *dev, struct mt7603_sta *sta,
 			   struct ieee80211_tx_rate *probe_rate,
 			   struct ieee80211_tx_rate *rates)
 {
+	struct ieee80211_tx_rate *ref;
 	int wcid = sta->wcid.idx;
 	u32 addr = mt7603_wtbl2_addr(wcid);
 	bool stbc = false;
@@ -599,7 +600,8 @@ void mt7603_wtbl_set_rates(struct mt7603_dev *dev, struct mt7603_sta *sta,
 	u16 val[4];
 	u16 probe_val;
 	u32 w9 = mt76_rr(dev, addr + 9 * 4);
-	int i;
+	bool rateset;
+	int i, k;
 
 	if (!mt76_poll(dev, MT_WTBL_UPDATE, MT_WTBL_UPDATE_BUSY, 0, 5000))
 		return;
@@ -607,6 +609,41 @@ void mt7603_wtbl_set_rates(struct mt7603_dev *dev, struct mt7603_sta *sta,
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
+			    IEEE80211_TX_RC_40_MHZ_WIDTH)
+				continue;
+
+			rates[i].idx--;
+		}
+
+	}
+
 	w9 &= MT_WTBL2_W9_SHORT_GI_20 | MT_WTBL2_W9_SHORT_GI_40 |
 	      MT_WTBL2_W9_SHORT_GI_80;
 
@@ -650,19 +687,22 @@ void mt7603_wtbl_set_rates(struct mt7603_dev *dev, struct mt7603_sta *sta,
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
 
+	mt76_set(dev, MT_LPON_T0CR, MT_LPON_T0CR_MODE); /* TSF read */
+	sta->rate_set_tsf = (mt76_rr(dev, MT_LPON_UTTR0) & ~BIT(0)) | rateset;
+
 	mt76_wr(dev, MT_WTBL_UPDATE,
 		FIELD_PREP(MT_WTBL_UPDATE_WLAN_IDX, wcid) |
 		MT_WTBL_UPDATE_RATE_UPDATE |
@@ -889,9 +929,9 @@ int mt7603_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 
 	if (info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) {
 		spin_lock_bh(&dev->mt76.lock);
-		msta->rate_probe = true;
 		mt7603_wtbl_set_rates(dev, msta, &info->control.rates[0],
 				      msta->rates);
+		msta->rate_probe = true;
 		spin_unlock_bh(&dev->mt76.lock);
 	}
 
@@ -906,9 +946,12 @@ mt7603_fill_txs(struct mt7603_dev *dev, struct mt7603_sta *sta,
 		struct ieee80211_tx_info *info, __le32 *txs_data)
 {
 	struct ieee80211_supported_band *sband;
-	int final_idx = 0;
+	struct mt7603_rate_set *rs;
+	int first_idx = 0, last_idx;
+	u32 rate_set_tsf;
 	u32 final_rate;
 	u32 final_rate_flags;
+	bool rs_idx;
 	bool ack_timeout;
 	bool fixed_rate;
 	bool probe;
@@ -925,6 +968,7 @@ mt7603_fill_txs(struct mt7603_dev *dev, struct mt7603_sta *sta,
 	txs = le32_to_cpu(txs_data[4]);
 	ampdu = !fixed_rate && (txs & MT_TXS4_AMPDU);
 	count = FIELD_GET(MT_TXS4_TX_COUNT, txs);
+	last_idx = FIELD_GET(MT_TXS4_LAST_TX_RATE, txs);
 
 	txs = le32_to_cpu(txs_data[0]);
 	final_rate = FIELD_GET(MT_TXS0_TX_RATE, txs);
@@ -946,38 +990,57 @@ mt7603_fill_txs(struct mt7603_dev *dev, struct mt7603_sta *sta,
 	if (ampdu || (info->flags & IEEE80211_TX_CTL_AMPDU))
 		info->flags |= IEEE80211_TX_STAT_AMPDU | IEEE80211_TX_CTL_AMPDU;
 
+	first_idx = max_t(int, 0, last_idx - (count + 1) / MT7603_RATE_RETRY);
+
 	if (fixed_rate && !probe) {
 		info->status.rates[0].count = count;
+		i = 0;
 		goto out;
 	}
 
-	for (i = 0, idx = 0; i < ARRAY_SIZE(info->status.rates); i++) {
-		int cur_count = min_t(int, count, 2 * MT7603_RATE_RETRY);
+	rate_set_tsf = ACCESS_ONCE(sta->rate_set_tsf);
+	rs_idx = !((u32)(FIELD_GET(MT_TXS1_F0_TIMESTAMP, le32_to_cpu(txs_data[1])) -
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
+			mt7603_wtbl_set_rates(dev, sta, NULL,
+					      sta->rates);
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
+		cur_count = min_t(int, MT7603_RATE_RETRY, count);
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
@@ -1004,8 +1067,8 @@ mt7603_fill_txs(struct mt7603_dev *dev, struct mt7603_sta *sta,
 		return false;
 	}
 
-	info->status.rates[final_idx].idx = final_rate;
-	info->status.rates[final_idx].flags = final_rate_flags;
+	info->status.rates[i].idx = final_rate;
+	info->status.rates[i].flags = final_rate_flags;
 
 	return true;
 }
@@ -1026,16 +1089,6 @@ mt7603_mac_add_txs_skb(struct mt7603_dev *dev, struct mt7603_sta *sta, int pid,
 	if (skb) {
 		struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 
-		if (info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) {
-			spin_lock_bh(&dev->mt76.lock);
-			if (sta->rate_probe) {
-				mt7603_wtbl_set_rates(dev, sta, NULL,
-						      sta->rates);
-				sta->rate_probe = false;
-			}
-			spin_unlock_bh(&dev->mt76.lock);
-		}
-
 		if (!mt7603_fill_txs(dev, sta, info, txs_data)) {
 			ieee80211_tx_info_clear_status(info);
 			info->status.rates[0].idx = -1;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 944dc9a11a15..60f8269daae7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -51,6 +51,11 @@ enum mt7603_bw {
 	MT_BW_80,
 };
 
+struct mt7603_rate_set {
+	struct ieee80211_tx_rate probe_rate;
+	struct ieee80211_tx_rate rates[4];
+};
+
 struct mt7603_sta {
 	struct mt76_wcid wcid; /* must be first */
 
@@ -58,7 +63,11 @@ struct mt7603_sta {
 
 	struct sk_buff_head psq;
 
-	struct ieee80211_tx_rate rates[8];
+	struct ieee80211_tx_rate rates[4];
+
+	struct mt7603_rate_set rateset[2];
+	u32 rate_set_tsf;
+
 	u8 rate_count;
 	u8 n_rates;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/regs.h b/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
index 9d257d5c309d..eb9eefe8e125 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/regs.h
@@ -480,6 +480,12 @@ enum {
 #define MT_LPON_BASE			0x24000
 #define MT_LPON(n)			(MT_LPON_BASE + (n))
 
+#define MT_LPON_T0CR			MT_LPON(0x010)
+#define MT_LPON_T0CR_MODE		GENMASK(1, 0)
+
+#define MT_LPON_UTTR0			MT_LPON(0x018)
+#define MT_LPON_UTTR1			MT_LPON(0x01c)
+
 #define MT_LPON_BTEIR			MT_LPON(0x020)
 #define MT_LPON_BTEIR_MBSS_MODE		GENMASK(31, 29)
 
-- 
2.17.0

