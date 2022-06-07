Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC6F53F9CC
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jun 2022 11:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239698AbiFGJ3x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jun 2022 05:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbiFGJ3f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jun 2022 05:29:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E3B527C3
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 02:29:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4448F611E4
        for <linux-wireless@vger.kernel.org>; Tue,  7 Jun 2022 09:29:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 753DAC3411C;
        Tue,  7 Jun 2022 09:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654594144;
        bh=j+TQHAaXAIDqrUgKqhFIloUUvxHdrBXzWBCvRZDfmys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lC2w3DiCldMoPfBti5F3xQ1UtlESptaWR1Suq8BcyCxoYekJClZrfyGYb+cXT495K
         1JWci5byd2THiP02zF5Sy1yn12AeeX6ypi2nLh4B5iCcVqRfLtfId8TeH6pZh27FIB
         9pao/gcpPvYJtggmufH2xqwGw8OFrWlkJ7pnZlXWdPX6xc0ErRUfT85rzCua+3DNiK
         F26n4tRxACgzOi76ovE6aR3AIS7OH+fiHAFiC/3ioAwG+j5uarT+Scj/mPuL/PpkSD
         MiloVq062UFNtU6JBp8UQkxZxn84l84wOvzFA8lsO1lVvMDj32bLpysOPUwy0kRjMw
         uYwr8dL3tqJ3w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com, sean.wang@mediatek.com
Subject: [PATCH 5/5] mt76: connac: move mt76_connac2_mac_add_txs_skb in connac module
Date:   Tue,  7 Jun 2022 11:28:41 +0200
Message-Id: <104e650bf260ce1840b1c64429cb35495e40d989.1654593918.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1654593918.git.lorenzo@kernel.org>
References: <cover.1654593918.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_connac2_mac_add_txs_skb in mt76-connac module since it is
shared between connac2 devices (mt7921 and mt7915)

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |   3 +
 .../wireless/mediatek/mt76/mt76_connac_mac.c  | 122 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 126 +-----------------
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 122 +----------------
 4 files changed, 130 insertions(+), 243 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index a9d7a269fcf3..6b8d6c5d621a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -250,5 +250,8 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 				 struct sk_buff *skb, struct mt76_wcid *wcid,
 				 struct ieee80211_key_conf *key, int pid,
 				 u32 changed);
+bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
+				  int pid, __le32 *txs_data,
+				  struct mt76_sta_stats *stats);
 
 #endif /* __MT76_CONNAC_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 0ea795565c88..3f2680b8c2c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -399,3 +399,125 @@ void mt76_connac2_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
 	}
 }
 EXPORT_SYMBOL_GPL(mt76_connac2_mac_write_txwi);
+
+bool mt76_connac2_mac_add_txs_skb(struct mt76_dev *dev, struct mt76_wcid *wcid,
+				  int pid, __le32 *txs_data,
+				  struct mt76_sta_stats *stats)
+{
+	struct ieee80211_supported_band *sband;
+	struct mt76_phy *mphy;
+	struct ieee80211_tx_info *info;
+	struct sk_buff_head list;
+	struct rate_info rate = {};
+	struct sk_buff *skb;
+	bool cck = false;
+	u32 txrate, txs, mode;
+
+	mt76_tx_status_lock(dev, &list);
+	skb = mt76_tx_status_skb_get(dev, wcid, pid, &list);
+	if (!skb)
+		goto out;
+
+	txs = le32_to_cpu(txs_data[0]);
+
+	info = IEEE80211_SKB_CB(skb);
+	if (!(txs & MT_TXS0_ACK_ERROR_MASK))
+		info->flags |= IEEE80211_TX_STAT_ACK;
+
+	info->status.ampdu_len = 1;
+	info->status.ampdu_ack_len = !!(info->flags &
+					IEEE80211_TX_STAT_ACK);
+
+	info->status.rates[0].idx = -1;
+
+	txrate = FIELD_GET(MT_TXS0_TX_RATE, txs);
+
+	rate.mcs = FIELD_GET(MT_TX_RATE_IDX, txrate);
+	rate.nss = FIELD_GET(MT_TX_RATE_NSS, txrate) + 1;
+
+	if (rate.nss - 1 < ARRAY_SIZE(stats->tx_nss))
+		stats->tx_nss[rate.nss - 1]++;
+	if (rate.mcs < ARRAY_SIZE(stats->tx_mcs))
+		stats->tx_mcs[rate.mcs]++;
+
+	mode = FIELD_GET(MT_TX_RATE_MODE, txrate);
+	switch (mode) {
+	case MT_PHY_TYPE_CCK:
+		cck = true;
+		fallthrough;
+	case MT_PHY_TYPE_OFDM:
+		mphy = &dev->phy;
+		if (wcid->ext_phy && dev->phy2)
+			mphy = dev->phy2;
+
+		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
+			sband = &mphy->sband_5g.sband;
+		else if (mphy->chandef.chan->band == NL80211_BAND_6GHZ)
+			sband = &mphy->sband_6g.sband;
+		else
+			sband = &mphy->sband_2g.sband;
+
+		rate.mcs = mt76_get_rate(mphy->dev, sband, rate.mcs, cck);
+		rate.legacy = sband->bitrates[rate.mcs].bitrate;
+		break;
+	case MT_PHY_TYPE_HT:
+	case MT_PHY_TYPE_HT_GF:
+		if (rate.mcs > 31)
+			goto out;
+
+		rate.flags = RATE_INFO_FLAGS_MCS;
+		if (wcid->rate.flags & RATE_INFO_FLAGS_SHORT_GI)
+			rate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+		break;
+	case MT_PHY_TYPE_VHT:
+		if (rate.mcs > 9)
+			goto out;
+
+		rate.flags = RATE_INFO_FLAGS_VHT_MCS;
+		break;
+	case MT_PHY_TYPE_HE_SU:
+	case MT_PHY_TYPE_HE_EXT_SU:
+	case MT_PHY_TYPE_HE_TB:
+	case MT_PHY_TYPE_HE_MU:
+		if (rate.mcs > 11)
+			goto out;
+
+		rate.he_gi = wcid->rate.he_gi;
+		rate.he_dcm = FIELD_GET(MT_TX_RATE_DCM, txrate);
+		rate.flags = RATE_INFO_FLAGS_HE_MCS;
+		break;
+	default:
+		goto out;
+	}
+
+	stats->tx_mode[mode]++;
+
+	switch (FIELD_GET(MT_TXS0_BW, txs)) {
+	case IEEE80211_STA_RX_BW_160:
+		rate.bw = RATE_INFO_BW_160;
+		stats->tx_bw[3]++;
+		break;
+	case IEEE80211_STA_RX_BW_80:
+		rate.bw = RATE_INFO_BW_80;
+		stats->tx_bw[2]++;
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		rate.bw = RATE_INFO_BW_40;
+		stats->tx_bw[1]++;
+		break;
+	default:
+		rate.bw = RATE_INFO_BW_20;
+		stats->tx_bw[0]++;
+		break;
+	}
+	wcid->rate = rate;
+
+out:
+	if (skb)
+		mt76_tx_status_skb_done(dev, skb, &list);
+
+	mt76_tx_status_unlock(dev, &list);
+
+	return !!skb;
+}
+EXPORT_SYMBOL_GPL(mt76_connac2_mac_add_txs_skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 932dfe0eaeff..428c4fd9a0a6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1345,128 +1345,6 @@ mt7915_mac_tx_free_v0(struct mt7915_dev *dev, void *data, int len)
 	mt7915_mac_tx_free_done(dev, &free_list, wake);
 }
 
-static bool
-mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
-		       __le32 *txs_data, struct mt76_sta_stats *stats)
-{
-	struct ieee80211_supported_band *sband;
-	struct mt76_dev *mdev = &dev->mt76;
-	struct mt76_phy *mphy;
-	struct ieee80211_tx_info *info;
-	struct sk_buff_head list;
-	struct rate_info rate = {};
-	struct sk_buff *skb;
-	bool cck = false;
-	u32 txrate, txs, mode;
-
-	mt76_tx_status_lock(mdev, &list);
-	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
-	if (!skb)
-		goto out_no_skb;
-
-	txs = le32_to_cpu(txs_data[0]);
-
-	info = IEEE80211_SKB_CB(skb);
-	if (!(txs & MT_TXS0_ACK_ERROR_MASK))
-		info->flags |= IEEE80211_TX_STAT_ACK;
-
-	info->status.ampdu_len = 1;
-	info->status.ampdu_ack_len = !!(info->flags &
-					IEEE80211_TX_STAT_ACK);
-
-	info->status.rates[0].idx = -1;
-
-	txrate = FIELD_GET(MT_TXS0_TX_RATE, txs);
-
-	rate.mcs = FIELD_GET(MT_TX_RATE_IDX, txrate);
-	rate.nss = FIELD_GET(MT_TX_RATE_NSS, txrate) + 1;
-
-	if (rate.nss - 1 < ARRAY_SIZE(stats->tx_nss))
-		stats->tx_nss[rate.nss - 1]++;
-	if (rate.mcs < ARRAY_SIZE(stats->tx_mcs))
-		stats->tx_mcs[rate.mcs]++;
-
-	mode = FIELD_GET(MT_TX_RATE_MODE, txrate);
-	switch (mode) {
-	case MT_PHY_TYPE_CCK:
-		cck = true;
-		fallthrough;
-	case MT_PHY_TYPE_OFDM:
-		mphy = &dev->mphy;
-		if (wcid->ext_phy && dev->mt76.phy2)
-			mphy = dev->mt76.phy2;
-
-		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
-			sband = &mphy->sband_5g.sband;
-		else if (mphy->chandef.chan->band == NL80211_BAND_6GHZ)
-			sband = &mphy->sband_6g.sband;
-		else
-			sband = &mphy->sband_2g.sband;
-
-		rate.mcs = mt76_get_rate(mphy->dev, sband, rate.mcs, cck);
-		rate.legacy = sband->bitrates[rate.mcs].bitrate;
-		break;
-	case MT_PHY_TYPE_HT:
-	case MT_PHY_TYPE_HT_GF:
-		if (rate.mcs > 31)
-			goto out;
-
-		rate.flags = RATE_INFO_FLAGS_MCS;
-		if (wcid->rate.flags & RATE_INFO_FLAGS_SHORT_GI)
-			rate.flags |= RATE_INFO_FLAGS_SHORT_GI;
-		break;
-	case MT_PHY_TYPE_VHT:
-		if (rate.mcs > 9)
-			goto out;
-
-		rate.flags = RATE_INFO_FLAGS_VHT_MCS;
-		break;
-	case MT_PHY_TYPE_HE_SU:
-	case MT_PHY_TYPE_HE_EXT_SU:
-	case MT_PHY_TYPE_HE_TB:
-	case MT_PHY_TYPE_HE_MU:
-		if (rate.mcs > 11)
-			goto out;
-
-		rate.he_gi = wcid->rate.he_gi;
-		rate.he_dcm = FIELD_GET(MT_TX_RATE_DCM, txrate);
-		rate.flags = RATE_INFO_FLAGS_HE_MCS;
-		break;
-	default:
-		goto out;
-	}
-
-	stats->tx_mode[mode]++;
-
-	switch (FIELD_GET(MT_TXS0_BW, txs)) {
-	case IEEE80211_STA_RX_BW_160:
-		rate.bw = RATE_INFO_BW_160;
-		stats->tx_bw[3]++;
-		break;
-	case IEEE80211_STA_RX_BW_80:
-		rate.bw = RATE_INFO_BW_80;
-		stats->tx_bw[2]++;
-		break;
-	case IEEE80211_STA_RX_BW_40:
-		rate.bw = RATE_INFO_BW_40;
-		stats->tx_bw[1]++;
-		break;
-	default:
-		rate.bw = RATE_INFO_BW_20;
-		stats->tx_bw[0]++;
-		break;
-	}
-	wcid->rate = rate;
-
-out:
-	mt76_tx_status_skb_done(mdev, skb, &list);
-
-out_no_skb:
-	mt76_tx_status_unlock(mdev, &list);
-
-	return !!skb;
-}
-
 static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 {
 	struct mt7915_sta *msta = NULL;
@@ -1495,8 +1373,8 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 
 	msta = container_of(wcid, struct mt7915_sta, wcid);
 
-	mt7915_mac_add_txs_skb(dev, wcid, pid, txs_data, &msta->stats);
-
+	mt76_connac2_mac_add_txs_skb(&dev->mt76, wcid, pid, txs_data,
+				     &msta->stats);
 	if (!wcid->sta)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index ae1dafc536c9..ccaf4d539852 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -833,123 +833,6 @@ void mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 }
 EXPORT_SYMBOL_GPL(mt7921_tx_check_aggr);
 
-static bool
-mt7921_mac_add_txs_skb(struct mt7921_dev *dev, struct mt76_wcid *wcid, int pid,
-		       __le32 *txs_data)
-{
-	struct mt7921_sta *msta = container_of(wcid, struct mt7921_sta, wcid);
-	struct mt76_sta_stats *stats = &msta->stats;
-	struct ieee80211_supported_band *sband;
-	struct mt76_dev *mdev = &dev->mt76;
-	struct ieee80211_tx_info *info;
-	struct rate_info rate = {};
-	struct sk_buff_head list;
-	u32 txrate, txs, mode;
-	struct sk_buff *skb;
-	bool cck = false;
-
-	mt76_tx_status_lock(mdev, &list);
-	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
-	if (!skb)
-		goto out;
-
-	info = IEEE80211_SKB_CB(skb);
-	txs = le32_to_cpu(txs_data[0]);
-	if (!(txs & MT_TXS0_ACK_ERROR_MASK))
-		info->flags |= IEEE80211_TX_STAT_ACK;
-
-	info->status.ampdu_len = 1;
-	info->status.ampdu_ack_len = !!(info->flags &
-					IEEE80211_TX_STAT_ACK);
-
-	info->status.rates[0].idx = -1;
-
-	if (!wcid->sta)
-		goto out;
-
-	txrate = FIELD_GET(MT_TXS0_TX_RATE, txs);
-
-	rate.mcs = FIELD_GET(MT_TX_RATE_IDX, txrate);
-	rate.nss = FIELD_GET(MT_TX_RATE_NSS, txrate) + 1;
-
-	if (rate.nss - 1 < ARRAY_SIZE(stats->tx_nss))
-		stats->tx_nss[rate.nss - 1]++;
-	if (rate.mcs < ARRAY_SIZE(stats->tx_mcs))
-		stats->tx_mcs[rate.mcs]++;
-
-	mode = FIELD_GET(MT_TX_RATE_MODE, txrate);
-	switch (mode) {
-	case MT_PHY_TYPE_CCK:
-		cck = true;
-		fallthrough;
-	case MT_PHY_TYPE_OFDM:
-		if (dev->mphy.chandef.chan->band == NL80211_BAND_5GHZ)
-			sband = &dev->mphy.sband_5g.sband;
-		else
-			sband = &dev->mphy.sband_2g.sband;
-
-		rate.mcs = mt76_get_rate(dev->mphy.dev, sband, rate.mcs, cck);
-		rate.legacy = sband->bitrates[rate.mcs].bitrate;
-		break;
-	case MT_PHY_TYPE_HT:
-	case MT_PHY_TYPE_HT_GF:
-		if (rate.mcs > 31)
-			goto out;
-
-		rate.flags = RATE_INFO_FLAGS_MCS;
-		if (wcid->rate.flags & RATE_INFO_FLAGS_SHORT_GI)
-			rate.flags |= RATE_INFO_FLAGS_SHORT_GI;
-		break;
-	case MT_PHY_TYPE_VHT:
-		if (rate.mcs > 9)
-			goto out;
-
-		rate.flags = RATE_INFO_FLAGS_VHT_MCS;
-		break;
-	case MT_PHY_TYPE_HE_SU:
-	case MT_PHY_TYPE_HE_EXT_SU:
-	case MT_PHY_TYPE_HE_TB:
-	case MT_PHY_TYPE_HE_MU:
-		if (rate.mcs > 11)
-			goto out;
-
-		rate.he_gi = wcid->rate.he_gi;
-		rate.he_dcm = FIELD_GET(MT_TX_RATE_DCM, txrate);
-		rate.flags = RATE_INFO_FLAGS_HE_MCS;
-		break;
-	default:
-		goto out;
-	}
-	stats->tx_mode[mode]++;
-
-	switch (FIELD_GET(MT_TXS0_BW, txs)) {
-	case IEEE80211_STA_RX_BW_160:
-		rate.bw = RATE_INFO_BW_160;
-		stats->tx_bw[3]++;
-		break;
-	case IEEE80211_STA_RX_BW_80:
-		rate.bw = RATE_INFO_BW_80;
-		stats->tx_bw[2]++;
-		break;
-	case IEEE80211_STA_RX_BW_40:
-		rate.bw = RATE_INFO_BW_40;
-		stats->tx_bw[1]++;
-		break;
-	default:
-		rate.bw = RATE_INFO_BW_20;
-		stats->tx_bw[0]++;
-		break;
-	}
-	wcid->rate = rate;
-
-out:
-	if (skb)
-		mt76_tx_status_skb_done(mdev, skb, &list);
-	mt76_tx_status_unlock(mdev, &list);
-
-	return !!skb;
-}
-
 void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data)
 {
 	struct mt7921_sta *msta = NULL;
@@ -976,12 +859,13 @@ void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data)
 	if (!wcid)
 		goto out;
 
-	mt7921_mac_add_txs_skb(dev, wcid, pid, txs_data);
+	msta = container_of(wcid, struct mt7921_sta, wcid);
 
+	mt76_connac2_mac_add_txs_skb(&dev->mt76, wcid, pid, txs_data,
+				     &msta->stats);
 	if (!wcid->sta)
 		goto out;
 
-	msta = container_of(wcid, struct mt7921_sta, wcid);
 	spin_lock_bh(&dev->sta_poll_lock);
 	if (list_empty(&msta->poll_list))
 		list_add_tail(&msta->poll_list, &dev->sta_poll_list);
-- 
2.35.3

