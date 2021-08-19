Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EFF3F153A
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 10:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237269AbhHSIdN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 04:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237341AbhHSIdI (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 04:33:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0247D610FA;
        Thu, 19 Aug 2021 08:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629361953;
        bh=mAeAZgI+H5L9UuRYdgQAEcmx/gsQ/i6fr2RtCwkAaEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PlAwlrqvkY7X2Ta4mRrn4UnDqei5EplN8Cn1K9wlo8tTtapwAfJ98jCaiK+E9HAKz
         v6mDODQfS9TauiLuQq61lS317mxTa0JXn08zqGdbM8vB0NLqtVNrnXQUdGJFcJMVxH
         QYrw7czFARjAt3FvRDx71OJMT+wM2WrO7IjIrvyWZJ4yMFHlEEkftvIiipVsqDPS8Q
         +HE6V31c9zE4FtcAHc8LH7rLz7K5FGvY8VPtxdWJDPlLLECNoV/nNFRio5094Q7Blh
         hZ95+mI3Ki+vgfkDsNUAaSyst9a4XaeQa8TulY7FcMPuNHgGjj7cOb0pvXUey2+mu7
         1CgoZZkHz1bpw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH v2 3/5] mt76: mt7921: report tx rate directly from tx status
Date:   Thu, 19 Aug 2021 10:32:03 +0200
Message-Id: <359037c562a124527c78012da1b81abaadba147e.1629361688.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629361688.git.lorenzo@kernel.org>
References: <cover.1629361688.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Report tx rate from tx status packets instead of receiving periodic mcu
event. This improves flexibility, accuracy and AQL performance, and
simplifies code flow for better readability.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 225 +++++++++++-------
 .../net/wireless/mediatek/mt76/mt7921/mac.h   |   4 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  22 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   2 -
 4 files changed, 152 insertions(+), 101 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 83eed0797314..ea8222bb0c77 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -61,6 +61,7 @@ static void mt7921_mac_sta_poll(struct mt7921_dev *dev)
 	struct mt7921_sta *msta;
 	u32 tx_time[IEEE80211_NUM_ACS], rx_time[IEEE80211_NUM_ACS];
 	LIST_HEAD(sta_poll_list);
+	struct rate_info *rate;
 	int i;
 
 	spin_lock_bh(&dev->sta_poll_lock);
@@ -71,8 +72,9 @@ static void mt7921_mac_sta_poll(struct mt7921_dev *dev)
 
 	while (true) {
 		bool clear = false;
-		u32 addr;
+		u32 addr, val;
 		u16 idx;
+		u8 bw;
 
 		spin_lock_bh(&dev->sta_poll_lock);
 		if (list_empty(&sta_poll_list)) {
@@ -126,6 +128,42 @@ static void mt7921_mac_sta_poll(struct mt7921_dev *dev)
 			ieee80211_sta_register_airtime(sta, tid, tx_cur,
 						       rx_cur);
 		}
+
+		/* We don't support reading GI info from txs packets.
+		 * For accurate tx status reporting and AQL improvement,
+		 * we need to make sure that flags match so polling GI
+		 * from per-sta counters directly.
+		 */
+		rate = &msta->wcid.rate;
+		addr = MT_WTBL_LMAC_OFFS(idx, 0) + 7 * 4;
+		val = mt76_rr(dev, addr);
+
+		switch (rate->bw) {
+		case RATE_INFO_BW_160:
+			bw = IEEE80211_STA_RX_BW_160;
+			break;
+		case RATE_INFO_BW_80:
+			bw = IEEE80211_STA_RX_BW_80;
+			break;
+		case RATE_INFO_BW_40:
+			bw = IEEE80211_STA_RX_BW_40;
+			break;
+		default:
+			bw = IEEE80211_STA_RX_BW_20;
+			break;
+		}
+
+		if (rate->flags & RATE_INFO_FLAGS_HE_MCS) {
+			u8 offs = 24 + 2 * bw;
+
+			rate->he_gi = (val & (0x3 << offs)) >> offs;
+		} else if (rate->flags &
+			   (RATE_INFO_FLAGS_VHT_MCS | RATE_INFO_FLAGS_MCS)) {
+			if (val & BIT(12 + bw))
+				rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
+			else
+				rate->flags &= ~RATE_INFO_FLAGS_SHORT_GI;
+		}
 	}
 
 	rcu_read_unlock();
@@ -783,24 +821,6 @@ mt7921_mac_write_txwi_80211(struct mt7921_dev *dev, __le32 *txwi,
 	txwi[7] |= cpu_to_le32(val);
 }
 
-static void mt7921_update_txs(struct mt76_wcid *wcid, __le32 *txwi)
-{
-	struct mt7921_sta *msta = container_of(wcid, struct mt7921_sta, wcid);
-	u32 pid, frame_type;
-
-	frame_type = FIELD_GET(MT_TXD2_FRAME_TYPE, le32_to_cpu(txwi[2]));
-	if (!(frame_type & (IEEE80211_FTYPE_DATA >> 2)))
-		return;
-
-	if (time_is_after_eq_jiffies(msta->next_txs_ts))
-		return;
-
-	msta->next_txs_ts = jiffies + msecs_to_jiffies(250);
-	pid = mt76_get_next_pkt_id(wcid);
-	txwi[5] |= cpu_to_le32(MT_TXD5_TX_STATUS_MCU |
-			       FIELD_PREP(MT_TXD5_PID, pid));
-}
-
 static void
 mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 		      struct sk_buff *skb, struct mt76_wcid *wcid,
@@ -885,8 +905,6 @@ mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 		txwi[6] |= cpu_to_le32(val);
 		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
 	}
-
-	mt7921_update_txs(wcid, txwi);
 }
 
 static void
@@ -928,10 +946,9 @@ int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
 	struct ieee80211_key_conf *key = info->control.hw_key;
-	struct mt76_tx_cb *cb = mt76_tx_skb_cb(tx_info->skb);
 	struct mt76_txwi_cache *t;
 	struct mt7921_txp_common *txp;
-	int id;
+	int id, pid;
 	u8 *txwi = (u8 *)txwi_ptr;
 
 	if (unlikely(tx_info->skb->len <= ETH_HLEN))
@@ -940,8 +957,6 @@ int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (!wcid)
 		wcid = &dev->mt76.global_wcid;
 
-	cb->wcid = wcid->idx;
-
 	t = (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
 	t->skb = tx_info->skb;
 
@@ -949,8 +964,18 @@ int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (id < 0)
 		return id;
 
+	if (sta) {
+		struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+
+		if (time_after(jiffies, msta->stats.jiffies + HZ / 4)) {
+			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+			msta->stats.jiffies = jiffies;
+		}
+	}
+
+	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
 	mt7921_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
-			      MT_PACKET_ID_NO_SKB, false);
+			      pid, false);
 
 	txp = (struct mt7921_txp_common *)(txwi + MT_TXD_SIZE);
 	memset(txp, 0, sizeof(struct mt7921_txp_common));
@@ -986,42 +1011,6 @@ mt7921_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 		ieee80211_start_tx_ba_session(sta, tid, 0);
 }
 
-static void
-mt7921_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
-			  struct ieee80211_sta *sta, bool clear_status,
-			  struct list_head *free_list)
-{
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
-	struct ieee80211_tx_status status = {
-		.sta = sta,
-		.info = info,
-		.skb = skb,
-		.free_list = free_list,
-	};
-	struct ieee80211_hw *hw;
-
-	if (sta) {
-		struct mt7921_sta *msta;
-
-		msta = (struct mt7921_sta *)sta->drv_priv;
-		status.rate = &msta->stats.tx_rate;
-	}
-
-	hw = mt76_tx_status_get_hw(mdev, skb);
-
-	if (info->flags & IEEE80211_TX_CTL_AMPDU)
-		info->flags |= IEEE80211_TX_STAT_AMPDU;
-
-	if (clear_status)
-		ieee80211_tx_info_clear_status(info);
-
-	if (!(info->flags & IEEE80211_TX_CTL_NO_ACK))
-		info->flags |= IEEE80211_TX_STAT_ACK;
-
-	info->status.tx_time = 0;
-	ieee80211_tx_status_ext(hw, &status);
-}
-
 static void
 mt7921_txp_skb_unmap(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 {
@@ -1059,31 +1048,27 @@ mt7921_txwi_free(struct mt7921_dev *dev, struct mt76_txwi_cache *t,
 		 struct list_head *free_list)
 {
 	struct mt76_dev *mdev = &dev->mt76;
-	struct ieee80211_tx_info *info;
 	__le32 *txwi;
+	u16 wcid_idx;
 
 	mt7921_txp_skb_unmap(mdev, t);
 	if (!t->skb)
 		goto out;
 
-	if (!sta)
-		goto out;
-
 	txwi = (__le32 *)mt76_get_txwi_ptr(mdev, t);
-	if (likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
-		mt7921_tx_check_aggr(sta, txwi);
-
-	info = IEEE80211_SKB_CB(t->skb);
-	if (!info->tx_time_est) {
+	if (sta) {
 		struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
-		int pending;
 
-		pending = atomic_dec_return(&wcid->non_aql_packets);
-		if (pending < 0)
-			atomic_cmpxchg(&wcid->non_aql_packets, pending, 0);
+		if (likely(t->skb->protocol != cpu_to_be16(ETH_P_PAE)))
+			mt7921_tx_check_aggr(sta, txwi);
+
+		wcid_idx = wcid->idx;
+	} else {
+		wcid_idx = FIELD_GET(MT_TXD1_WLAN_IDX, le32_to_cpu(txwi[1]));
 	}
 
-	mt7921_tx_complete_status(mdev, t->skb, sta, clear_status, free_list);
+	__mt76_tx_complete_skb(mdev, wcid_idx, t->skb, free_list);
+
 out:
 	t->skb = NULL;
 	mt76_put_txwi(mdev, t);
@@ -1169,10 +1154,14 @@ static bool
 mt7921_mac_add_txs_skb(struct mt7921_dev *dev, struct mt76_wcid *wcid, int pid,
 		       __le32 *txs_data)
 {
+	struct ieee80211_supported_band *sband;
 	struct mt76_dev *mdev = &dev->mt76;
 	struct ieee80211_tx_info *info;
+	struct rate_info rate = {};
 	struct sk_buff_head list;
 	struct sk_buff *skb;
+	bool cck = false;
+	u32 txrate, txs;
 
 	mt76_tx_status_lock(mdev, &list);
 	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
@@ -1180,7 +1169,8 @@ mt7921_mac_add_txs_skb(struct mt7921_dev *dev, struct mt76_wcid *wcid, int pid,
 		goto out;
 
 	info = IEEE80211_SKB_CB(skb);
-	if (!(txs_data[0] & le32_to_cpu(MT_TXS0_ACK_ERROR_MASK)))
+	txs = le32_to_cpu(txs_data[0]);
+	if (!(txs & MT_TXS0_ACK_ERROR_MASK))
 		info->flags |= IEEE80211_TX_STAT_ACK;
 
 	info->status.ampdu_len = 1;
@@ -1188,9 +1178,77 @@ mt7921_mac_add_txs_skb(struct mt7921_dev *dev, struct mt76_wcid *wcid, int pid,
 					IEEE80211_TX_STAT_ACK);
 
 	info->status.rates[0].idx = -1;
-	mt76_tx_status_skb_done(mdev, skb, &list);
+
+	if (!wcid->sta)
+		goto out;
+
+	txrate = FIELD_GET(MT_TXS0_TX_RATE, txs);
+
+	rate.mcs = FIELD_GET(MT_TX_RATE_IDX, txrate);
+	rate.nss = FIELD_GET(MT_TX_RATE_NSS, txrate) + 1;
+
+	switch (FIELD_GET(MT_TX_RATE_MODE, txrate)) {
+	case MT_PHY_TYPE_CCK:
+		cck = true;
+		fallthrough;
+	case MT_PHY_TYPE_OFDM:
+		if (dev->mphy.chandef.chan->band == NL80211_BAND_5GHZ)
+			sband = &dev->mphy.sband_5g.sband;
+		else
+			sband = &dev->mphy.sband_2g.sband;
+
+		rate.mcs = mt76_get_rate(dev->mphy.dev, sband, rate.mcs, cck);
+		rate.legacy = sband->bitrates[rate.mcs].bitrate;
+		break;
+	case MT_PHY_TYPE_HT:
+	case MT_PHY_TYPE_HT_GF:
+		rate.mcs += (rate.nss - 1) * 8;
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
+	switch (FIELD_GET(MT_TXS0_BW, txs)) {
+	case IEEE80211_STA_RX_BW_160:
+		rate.bw = RATE_INFO_BW_160;
+		break;
+	case IEEE80211_STA_RX_BW_80:
+		rate.bw = RATE_INFO_BW_80;
+		break;
+	case IEEE80211_STA_RX_BW_40:
+		rate.bw = RATE_INFO_BW_40;
+		break;
+	default:
+		rate.bw = RATE_INFO_BW_20;
+		break;
+	}
+	wcid->rate = rate;
 
 out:
+	mt76_tx_status_skb_done(mdev, skb, &list);
 	mt76_tx_status_unlock(mdev, &list);
 
 	return !!skb;
@@ -1305,15 +1363,8 @@ void mt7921_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 		e->skb = t ? t->skb : NULL;
 	}
 
-	if (e->skb) {
-		struct mt76_tx_cb *cb = mt76_tx_skb_cb(e->skb);
-		struct mt76_wcid *wcid;
-
-		wcid = rcu_dereference(dev->mt76.wcid[cb->wcid]);
-
-		mt7921_tx_complete_status(mdev, e->skb, wcid_to_sta(wcid), 0,
-					  NULL);
-	}
+	if (e->skb)
+		mt76_tx_complete_skb(mdev, e->wcid, e->skb);
 }
 
 void mt7921_mac_reset_counters(struct mt7921_phy *phy)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
index 4b29d2728f4d..1e4b07dd0b63 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
@@ -317,8 +317,10 @@ struct mt7921_tx_free {
 /* will support this field in further revision */
 #define MT_TX_FREE_RATE			GENMASK(13, 0)
 
-#define MT_TXS0_ACK_ERROR_MASK		GENMASK(18, 16)
+#define MT_TXS0_BW			GENMASK(30, 29)
 #define MT_TXS0_TXS_FORMAT		GENMASK(24, 23)
+#define MT_TXS0_ACK_ERROR_MASK		GENMASK(18, 16)
+#define MT_TXS0_TX_RATE			GENMASK(13, 0)
 
 #define MT_TXS2_WCID			GENMASK(25, 16)
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 7ce014de3443..874c7c18ad09 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1012,22 +1012,22 @@ static void mt7921_sta_statistics(struct ieee80211_hw *hw,
 				  struct station_info *sinfo)
 {
 	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
-	struct mt7921_sta_stats *stats = &msta->stats;
+	struct rate_info *txrate = &msta->wcid.rate;
 
-	if (!stats->tx_rate.legacy && !stats->tx_rate.flags)
+	if (!txrate->legacy && !txrate->flags)
 		return;
 
-	if (stats->tx_rate.legacy) {
-		sinfo->txrate.legacy = stats->tx_rate.legacy;
+	if (txrate->legacy) {
+		sinfo->txrate.legacy = txrate->legacy;
 	} else {
-		sinfo->txrate.mcs = stats->tx_rate.mcs;
-		sinfo->txrate.nss = stats->tx_rate.nss;
-		sinfo->txrate.bw = stats->tx_rate.bw;
-		sinfo->txrate.he_gi = stats->tx_rate.he_gi;
-		sinfo->txrate.he_dcm = stats->tx_rate.he_dcm;
-		sinfo->txrate.he_ru_alloc = stats->tx_rate.he_ru_alloc;
+		sinfo->txrate.mcs = txrate->mcs;
+		sinfo->txrate.nss = txrate->nss;
+		sinfo->txrate.bw = txrate->bw;
+		sinfo->txrate.he_gi = txrate->he_gi;
+		sinfo->txrate.he_dcm = txrate->he_dcm;
+		sinfo->txrate.he_ru_alloc = txrate->he_ru_alloc;
 	}
-	sinfo->txrate.flags = stats->tx_rate.flags;
+	sinfo->txrate.flags = txrate->flags;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 761fc605e5e9..26f175ef505e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -93,8 +93,6 @@ struct mt7921_sta {
 	unsigned long ampdu_state;
 
 	struct mt7921_sta_key_conf bip;
-
-	unsigned long next_txs_ts;
 };
 
 DECLARE_EWMA(rssi, 10, 8);
-- 
2.31.1

