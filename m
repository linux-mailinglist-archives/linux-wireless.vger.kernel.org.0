Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C8F3C815B
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jul 2021 11:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238809AbhGNJVu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jul 2021 05:21:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40602 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238763AbhGNJVt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jul 2021 05:21:49 -0400
X-UUID: a179d4c343dc448aaed56ff74f96e318-20210714
X-UUID: a179d4c343dc448aaed56ff74f96e318-20210714
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 936326407; Wed, 14 Jul 2021 17:18:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Jul 2021 17:18:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Jul 2021 17:18:53 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 3/4] mt76: mt7915: report tx rate directly from tx status
Date:   Wed, 14 Jul 2021 17:18:50 +0800
Message-ID: <ad91daf63f1101a20aea586d61926606bf10270b.1626253920.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <50730853fe09fb75418484770a0c95c23b44deb5.1626253920.git.ryder.lee@mediatek.com>
References: <50730853fe09fb75418484770a0c95c23b44deb5.1626253920.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Report tx rate from tx status packets instead of receving periodic mcu
event. This improves flexibility, accuracy and AQL performance, and
simplifies code flow for better readability.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v2 - remove an unused variable.
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |   2 +
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  47 -----
 .../net/wireless/mediatek/mt76/mt7915/init.c  |   2 -
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 172 ++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  26 ++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 168 -----------------
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  43 -----
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  17 --
 drivers/net/wireless/mediatek/mt76/tx.c       |   6 +-
 9 files changed, 152 insertions(+), 331 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 25c5ceef5257..b41faedee001 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -244,6 +244,8 @@ struct mt76_wcid {
 	struct ewma_signal rssi;
 	int inactive_count;
 
+	struct rate_info rate;
+
 	u16 idx;
 	u8 hw_key_idx;
 	u8 hw_key_idx2;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 64048243e34b..1a48b09d0cb7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -377,56 +377,9 @@ static int mt7915_sta_fixed_rate_set(void *data, u64 rate)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_fixed_rate, NULL,
 			 mt7915_sta_fixed_rate_set, "%llx\n");
 
-static int
-mt7915_sta_stats_show(struct seq_file *s, void *data)
-{
-	struct ieee80211_sta *sta = s->private;
-	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
-	struct mt7915_sta_stats *stats = &msta->stats;
-	struct rate_info *rate = &stats->prob_rate;
-	static const char * const bw[] = {
-		"BW20", "BW5", "BW10", "BW40",
-		"BW80", "BW160", "BW_HE_RU"
-	};
-
-	if (!rate->legacy && !rate->flags)
-		return 0;
-
-	seq_puts(s, "Probing rate - ");
-	if (rate->flags & RATE_INFO_FLAGS_MCS)
-		seq_puts(s, "HT ");
-	else if (rate->flags & RATE_INFO_FLAGS_VHT_MCS)
-		seq_puts(s, "VHT ");
-	else if (rate->flags & RATE_INFO_FLAGS_HE_MCS)
-		seq_puts(s, "HE ");
-	else
-		seq_printf(s, "Bitrate %d\n", rate->legacy);
-
-	if (rate->flags) {
-		seq_printf(s, "%s NSS%d MCS%d ",
-			   bw[rate->bw], rate->nss, rate->mcs);
-
-		if (rate->flags & RATE_INFO_FLAGS_SHORT_GI)
-			seq_puts(s, "SGI ");
-		else if (rate->he_gi)
-			seq_puts(s, "HE GI ");
-
-		if (rate->he_dcm)
-			seq_puts(s, "DCM ");
-	}
-
-	seq_printf(s, "\nPPDU PER: %ld.%1ld%%\n",
-		   stats->per / 10, stats->per % 10);
-
-	return 0;
-}
-
-DEFINE_SHOW_ATTRIBUTE(mt7915_sta_stats);
-
 void mt7915_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta, struct dentry *dir)
 {
 	debugfs_create_file("fixed_rate", 0600, dir, sta, &fops_fixed_rate);
-	debugfs_create_file("stats", 0400, dir, sta, &mt7915_sta_stats_fops);
 }
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 4798d6344305..eb4c4991d020 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -350,7 +350,6 @@ static int mt7915_register_ext_phy(struct mt7915_dev *dev)
 	mphy->chainmask = dev->chainmask & ~dev->mphy.chainmask;
 	mphy->antenna_mask = BIT(hweight8(mphy->chainmask)) - 1;
 
-	INIT_LIST_HEAD(&phy->stats_list);
 	INIT_DELAYED_WORK(&mphy->mac_work, mt7915_mac_work);
 
 	mt7915_eeprom_parse_band_config(phy);
@@ -787,7 +786,6 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	dev->phy.dev = dev;
 	dev->phy.mt76 = &dev->mt76.phy;
 	dev->mt76.phy.priv = &dev->phy;
-	INIT_LIST_HEAD(&dev->phy.stats_list);
 	INIT_WORK(&dev->rc_work, mt7915_mac_sta_rc_work);
 	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7915_mac_work);
 	INIT_LIST_HEAD(&dev->sta_rc_list);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 70ec8ca94fcc..6de79d646ca1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -88,15 +88,14 @@ bool mt7915_mac_wtbl_update(struct mt7915_dev *dev, int idx, u32 mask)
 			 0, 5000);
 }
 
-static u32 mt7915_mac_wtbl_lmac_addr(struct mt7915_dev *dev, u16 wcid)
+static u32 mt7915_mac_wtbl_lmac_addr(struct mt7915_dev *dev, u16 wcid, u8 dw)
 {
 	mt76_wr(dev, MT_WTBLON_TOP_WDUCR,
 		FIELD_PREP(MT_WTBLON_TOP_WDUCR_GROUP, (wcid >> 7)));
 
-	return MT_WTBL_LMAC_OFFS(wcid, 0);
+	return MT_WTBL_LMAC_OFFS(wcid, dw);
 }
 
-/* TODO: use txfree airtime info to avoid runtime accessing in the long run */
 static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 {
 	static const u8 ac_to_tid[] = {
@@ -107,6 +106,7 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 	};
 	struct ieee80211_sta *sta;
 	struct mt7915_sta *msta;
+	struct rate_info *rate;
 	u32 tx_time[IEEE80211_NUM_ACS], rx_time[IEEE80211_NUM_ACS];
 	LIST_HEAD(sta_poll_list);
 	int i;
@@ -119,8 +119,9 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 
 	while (true) {
 		bool clear = false;
-		u32 addr;
+		u32 addr, val;
 		u16 idx;
+		u8 bw;
 
 		spin_lock_bh(&dev->sta_poll_lock);
 		if (list_empty(&sta_poll_list)) {
@@ -133,7 +134,7 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 		spin_unlock_bh(&dev->sta_poll_lock);
 
 		idx = msta->wcid.idx;
-		addr = mt7915_mac_wtbl_lmac_addr(dev, idx) + 20 * 4;
+		addr = mt7915_mac_wtbl_lmac_addr(dev, idx, 20);
 
 		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
 			u32 tx_last = msta->airtime_ac[i];
@@ -174,6 +175,42 @@ static void mt7915_mac_sta_poll(struct mt7915_dev *dev)
 			ieee80211_sta_register_airtime(sta, tid, tx_cur,
 						       rx_cur);
 		}
+
+		/*
+		 * We don't support reading GI info from txs packets.
+		 * For accurate tx status reporting and AQL improvement,
+		 * we need to make sure that flags match so polling GI
+		 * from per-sta counters directly.
+		 */
+		rate = &msta->wcid.rate;
+		addr = mt7915_mac_wtbl_lmac_addr(dev, idx, 7);
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
+		} else if (rate->flags & RATE_INFO_FLAGS_VHT_MCS) {
+			if (val & BIT(12 + bw))
+				rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
+			else
+				rate->flags &= ~RATE_INFO_FLAGS_SHORT_GI;
+		}
 	}
 
 	rcu_read_unlock();
@@ -1016,6 +1053,17 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (!wcid)
 		wcid = &dev->mt76.global_wcid;
 
+	if (sta) {
+		struct mt7915_sta *msta;
+
+		msta = (struct mt7915_sta *)sta->drv_priv;
+
+		if (time_after(jiffies, msta->stats.jiffies + HZ / 4)) {
+			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
+			msta->stats.jiffies = jiffies;
+		}
+	}
+
 	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
 
 	mt7915_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, pid, key,
@@ -1181,8 +1229,6 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 
 			msta = container_of(wcid, struct mt7915_sta, wcid);
 			spin_lock_bh(&dev->sta_poll_lock);
-			if (list_empty(&msta->stats_list))
-				list_add_tail(&msta->stats_list, &phy->stats_list);
 			if (list_empty(&msta->poll_list))
 				list_add_tail(&msta->poll_list, &dev->sta_poll_list);
 			spin_unlock_bh(&dev->sta_poll_lock);
@@ -1216,18 +1262,25 @@ static bool
 mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 		       __le32 *txs_data)
 {
+	struct ieee80211_supported_band *sband;
 	struct mt76_dev *mdev = &dev->mt76;
+	struct mt76_phy *mphy;
 	struct ieee80211_tx_info *info;
 	struct sk_buff_head list;
+	struct rate_info rate = {};
 	struct sk_buff *skb;
+	bool cck = false;
+	u32 txrate, txs;
 
 	mt76_tx_status_lock(mdev, &list);
 	skb = mt76_tx_status_skb_get(mdev, wcid, pid, &list);
 	if (!skb)
 		goto out;
 
+	txs = le32_to_cpu(txs_data[0]);
+
 	info = IEEE80211_SKB_CB(skb);
-	if (!(txs_data[0] & le32_to_cpu(MT_TXS0_ACK_ERROR_MASK)))
+	if (!(txs & MT_TXS0_ACK_ERROR_MASK))
 		info->flags |= IEEE80211_TX_STAT_ACK;
 
 	info->status.ampdu_len = 1;
@@ -1235,9 +1288,81 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
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
+		mphy = &dev->mphy;
+		if (wcid->ext_phy && dev->mt76.phy2)
+			mphy = dev->mt76.phy2;
+
+		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
+			sband = &mphy->sband_5g.sband;
+		else
+			sband = &mphy->sband_2g.sband;
+
+		rate.mcs = mt76_get_rate(mphy->dev, sband, rate.mcs, cck);
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
@@ -1728,30 +1853,6 @@ mt7915_mac_update_stats(struct mt7915_phy *phy)
 	}
 }
 
-static void
-mt7915_mac_sta_stats_work(struct mt7915_phy *phy)
-{
-	struct mt7915_dev *dev = phy->dev;
-	struct mt7915_sta *msta;
-	LIST_HEAD(list);
-
-	spin_lock_bh(&dev->sta_poll_lock);
-	list_splice_init(&phy->stats_list, &list);
-
-	while (!list_empty(&list)) {
-		msta = list_first_entry(&list, struct mt7915_sta, stats_list);
-		list_del_init(&msta->stats_list);
-		spin_unlock_bh(&dev->sta_poll_lock);
-
-		/* use MT_TX_FREE_RATE to report Tx rate for further devices */
-		mt7915_mcu_get_tx_rate(dev, RATE_CTRL_RU_INFO, msta->wcid.idx);
-
-		spin_lock_bh(&dev->sta_poll_lock);
-	}
-
-	spin_unlock_bh(&dev->sta_poll_lock);
-}
-
 void mt7915_mac_sta_rc_work(struct work_struct *work)
 {
 	struct mt7915_dev *dev = container_of(work, struct mt7915_dev, rc_work);
@@ -1808,11 +1909,6 @@ void mt7915_mac_work(struct work_struct *work)
 		mt7915_mac_update_stats(phy);
 	}
 
-	if (++phy->sta_work_count == 10) {
-		phy->sta_work_count = 0;
-		mt7915_mac_sta_stats_work(phy);
-	}
-
 	mutex_unlock(&mphy->dev->mutex);
 
 	mt76_tx_status_check(mphy->dev, NULL, false);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index c25f8da590dd..953d5caae5c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -231,7 +231,6 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	idx = MT7915_WTBL_RESERVED - mvif->idx;
 
 	INIT_LIST_HEAD(&mvif->sta.rc_list);
-	INIT_LIST_HEAD(&mvif->sta.stats_list);
 	INIT_LIST_HEAD(&mvif->sta.poll_list);
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.ext_phy = mvif->band_idx;
@@ -618,7 +617,6 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		return -ENOSPC;
 
 	INIT_LIST_HEAD(&msta->rc_list);
-	INIT_LIST_HEAD(&msta->stats_list);
 	INIT_LIST_HEAD(&msta->poll_list);
 	msta->vif = mvif;
 	msta->wcid.sta = 1;
@@ -652,8 +650,6 @@ void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	spin_lock_bh(&dev->sta_poll_lock);
 	if (!list_empty(&msta->poll_list))
 		list_del_init(&msta->poll_list);
-	if (!list_empty(&msta->stats_list))
-		list_del_init(&msta->stats_list);
 	if (!list_empty(&msta->rc_list))
 		list_del_init(&msta->rc_list);
 	spin_unlock_bh(&dev->sta_poll_lock);
@@ -926,7 +922,7 @@ static void mt7915_sta_statistics(struct ieee80211_hw *hw,
 {
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
-	struct mt7915_sta_stats *stats = &msta->stats;
+	struct rate_info *txrate = &msta->wcid.rate;
 	struct rate_info rxrate = {};
 
 	if (!mt7915_mcu_get_rx_rate(phy, vif, sta, &rxrate)) {
@@ -934,20 +930,20 @@ static void mt7915_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BITRATE);
 	}
 
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
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 4d2e5b5e6389..8d646aa3d084 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -488,152 +488,6 @@ mt7915_mcu_rx_radar_detected(struct mt7915_dev *dev, struct sk_buff *skb)
 	dev->hw_pattern++;
 }
 
-static int
-mt7915_mcu_tx_rate_parse(struct mt76_phy *mphy, struct mt7915_mcu_ra_info *ra,
-			 struct rate_info *rate, u16 r)
-{
-	struct ieee80211_supported_band *sband;
-	u16 ru_idx = le16_to_cpu(ra->ru_idx);
-	bool cck = false;
-
-	rate->mcs = FIELD_GET(MT_RA_RATE_MCS, r);
-	rate->nss = FIELD_GET(MT_RA_RATE_NSS, r) + 1;
-
-	switch (FIELD_GET(MT_RA_RATE_TX_MODE, r)) {
-	case MT_PHY_TYPE_CCK:
-		cck = true;
-		fallthrough;
-	case MT_PHY_TYPE_OFDM:
-		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
-			sband = &mphy->sband_5g.sband;
-		else
-			sband = &mphy->sband_2g.sband;
-
-		rate->mcs = mt76_get_rate(mphy->dev, sband, rate->mcs, cck);
-		rate->legacy = sband->bitrates[rate->mcs].bitrate;
-		break;
-	case MT_PHY_TYPE_HT:
-	case MT_PHY_TYPE_HT_GF:
-		rate->mcs += (rate->nss - 1) * 8;
-		if (rate->mcs > 31)
-			return -EINVAL;
-
-		rate->flags = RATE_INFO_FLAGS_MCS;
-		if (ra->gi)
-			rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
-		break;
-	case MT_PHY_TYPE_VHT:
-		if (rate->mcs > 9)
-			return -EINVAL;
-
-		rate->flags = RATE_INFO_FLAGS_VHT_MCS;
-		if (ra->gi)
-			rate->flags |= RATE_INFO_FLAGS_SHORT_GI;
-		break;
-	case MT_PHY_TYPE_HE_SU:
-	case MT_PHY_TYPE_HE_EXT_SU:
-	case MT_PHY_TYPE_HE_TB:
-	case MT_PHY_TYPE_HE_MU:
-		if (ra->gi > NL80211_RATE_INFO_HE_GI_3_2 || rate->mcs > 11)
-			return -EINVAL;
-
-		rate->he_gi = ra->gi;
-		rate->he_dcm = FIELD_GET(MT_RA_RATE_DCM_EN, r);
-		rate->flags = RATE_INFO_FLAGS_HE_MCS;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (ru_idx) {
-		switch (ru_idx) {
-		case 1 ... 2:
-			rate->he_ru_alloc = NL80211_RATE_INFO_HE_RU_ALLOC_996;
-			break;
-		case 3 ... 6:
-			rate->he_ru_alloc = NL80211_RATE_INFO_HE_RU_ALLOC_484;
-			break;
-		case 7 ... 14:
-			rate->he_ru_alloc = NL80211_RATE_INFO_HE_RU_ALLOC_242;
-			break;
-		default:
-			rate->he_ru_alloc = NL80211_RATE_INFO_HE_RU_ALLOC_106;
-			break;
-		}
-		rate->bw = RATE_INFO_BW_HE_RU;
-	} else {
-		u8 bw = mt7915_mcu_chan_bw(&mphy->chandef) -
-			FIELD_GET(MT_RA_RATE_BW, r);
-
-		switch (bw) {
-		case IEEE80211_STA_RX_BW_160:
-			rate->bw = RATE_INFO_BW_160;
-			break;
-		case IEEE80211_STA_RX_BW_80:
-			rate->bw = RATE_INFO_BW_80;
-			break;
-		case IEEE80211_STA_RX_BW_40:
-			rate->bw = RATE_INFO_BW_40;
-			break;
-		default:
-			rate->bw = RATE_INFO_BW_20;
-			break;
-		}
-	}
-
-	return 0;
-}
-
-static void
-mt7915_mcu_tx_rate_report(struct mt7915_dev *dev, struct sk_buff *skb)
-{
-	struct mt7915_mcu_ra_info *ra = (struct mt7915_mcu_ra_info *)skb->data;
-	struct rate_info rate = {}, prob_rate = {};
-	u16 probe = le16_to_cpu(ra->prob_up_rate);
-	u16 attempts = le16_to_cpu(ra->attempts);
-	u16 curr = le16_to_cpu(ra->curr_rate);
-	u16 wcidx = le16_to_cpu(ra->wlan_idx);
-	struct ieee80211_tx_status status = {};
-	struct mt76_phy *mphy = &dev->mphy;
-	struct mt7915_sta_stats *stats;
-	struct mt7915_sta *msta;
-	struct mt76_wcid *wcid;
-
-	if (wcidx >= MT76_N_WCIDS)
-		return;
-
-	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
-	if (!wcid)
-		return;
-
-	msta = container_of(wcid, struct mt7915_sta, wcid);
-	stats = &msta->stats;
-
-	if (msta->wcid.ext_phy && dev->mt76.phy2)
-		mphy = dev->mt76.phy2;
-
-	/* current rate */
-	if (!mt7915_mcu_tx_rate_parse(mphy, ra, &rate, curr))
-		stats->tx_rate = rate;
-
-	/* probing rate */
-	if (!mt7915_mcu_tx_rate_parse(mphy, ra, &prob_rate, probe))
-		stats->prob_rate = prob_rate;
-
-	if (attempts) {
-		u16 success = le16_to_cpu(ra->success);
-
-		stats->per = 1000 * (attempts - success) / attempts;
-	}
-
-	status.sta = wcid_to_sta(wcid);
-	if (!status.sta)
-		return;
-
-	status.rate = &stats->tx_rate;
-	ieee80211_tx_status_ext(mphy->hw, &status);
-}
-
 static void
 mt7915_mcu_rx_log_message(struct mt7915_dev *dev, struct sk_buff *skb)
 {
@@ -672,9 +526,6 @@ mt7915_mcu_rx_ext_event(struct mt7915_dev *dev, struct sk_buff *skb)
 	case MCU_EXT_EVENT_CSA_NOTIFY:
 		mt7915_mcu_rx_csa_notify(dev, skb);
 		break;
-	case MCU_EXT_EVENT_RATE_REPORT:
-		mt7915_mcu_tx_rate_report(dev, skb);
-		break;
 	case MCU_EXT_EVENT_FW_LOG_2_HOST:
 		mt7915_mcu_rx_log_message(dev, skb);
 		break;
@@ -706,7 +557,6 @@ void mt7915_mcu_rx_event(struct mt7915_dev *dev, struct sk_buff *skb)
 	    rxd->ext_eid == MCU_EXT_EVENT_FW_LOG_2_HOST ||
 	    rxd->ext_eid == MCU_EXT_EVENT_ASSERT_DUMP ||
 	    rxd->ext_eid == MCU_EXT_EVENT_PS_SYNC ||
-	    rxd->ext_eid == MCU_EXT_EVENT_RATE_REPORT ||
 	    !rxd->seq)
 		mt7915_mcu_rx_unsolicited_event(dev, skb);
 	else
@@ -3736,24 +3586,6 @@ int mt7915_mcu_set_thermal_throttling(struct mt7915_phy *phy, u8 state)
 				 &req, sizeof(req), false);
 }
 
-int mt7915_mcu_get_tx_rate(struct mt7915_dev *dev, u32 cmd, u16 wlan_idx)
-{
-	struct {
-		__le32 cmd;
-		__le16 wlan_idx;
-		__le16 ru_idx;
-		__le16 direction;
-		__le16 dump_group;
-	} req = {
-		.cmd = cpu_to_le32(cmd),
-		.wlan_idx = cpu_to_le16(wlan_idx),
-		.dump_group = cpu_to_le16(1),
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(RATE_CTRL), &req,
-				 sizeof(req), false);
-}
-
 int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index edd3ba3a0c2d..31c31a2a532b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -43,7 +43,6 @@ enum {
 	MCU_EXT_EVENT_ASSERT_DUMP = 0x23,
 	MCU_EXT_EVENT_RDD_REPORT = 0x3a,
 	MCU_EXT_EVENT_CSA_NOTIFY = 0x4f,
-	MCU_EXT_EVENT_RATE_REPORT = 0x87,
 };
 
 enum {
@@ -164,41 +163,6 @@ struct mt7915_mcu_eeprom_info {
 	u8 data[16];
 } __packed;
 
-struct mt7915_mcu_ra_info {
-	struct mt7915_mcu_rxd rxd;
-
-	__le32 event_id;
-	__le16 wlan_idx;
-	__le16 ru_idx;
-	__le16 direction;
-	__le16 dump_group;
-
-	__le32 suggest_rate;
-	__le32 min_rate;	/* for dynamic sounding */
-	__le32 max_rate;	/* for dynamic sounding */
-	__le32 init_rate_down_rate;
-
-	__le16 curr_rate;
-	__le16 init_rate_down_total;
-	__le16 init_rate_down_succ;
-	__le16 success;
-	__le16 attempts;
-
-	__le16 prev_rate;
-	__le16 prob_up_rate;
-	u8 no_rate_up_cnt;
-	u8 ppdu_cnt;
-	u8 gi;
-
-	u8 try_up_fail;
-	u8 try_up_total;
-	u8 suggest_wf;
-	u8 try_up_check;
-	u8 prob_up_period;
-	u8 prob_down_pending;
-} __packed;
-
-
 struct mt7915_mcu_phy_rx_info {
 	u8 category;
 	u8 rate;
@@ -210,12 +174,6 @@ struct mt7915_mcu_phy_rx_info {
 	u8 bw;
 };
 
-#define MT_RA_RATE_NSS			GENMASK(8, 6)
-#define MT_RA_RATE_MCS			GENMASK(3, 0)
-#define MT_RA_RATE_TX_MODE		GENMASK(12, 9)
-#define MT_RA_RATE_DCM_EN		BIT(4)
-#define MT_RA_RATE_BW			GENMASK(14, 13)
-
 struct mt7915_mcu_mib {
 	__le32 band;
 	__le32 offs;
@@ -318,7 +276,6 @@ enum {
 	MCU_EXT_CMD_MWDS_SUPPORT = 0x80,
 	MCU_EXT_CMD_SET_SER_TRIGGER = 0x81,
 	MCU_EXT_CMD_SCS_CTRL = 0x82,
-	MCU_EXT_CMD_RATE_CTRL = 0x87,
 	MCU_EXT_CMD_FW_DBG_CTRL = 0x95,
 	MCU_EXT_CMD_SET_RDD_TH = 0x9d,
 	MCU_EXT_CMD_SET_SPR = 0xa8,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 3f613fae6218..a9c36b515aa6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -65,10 +65,6 @@ enum mt7915_rxq_id {
 };
 
 struct mt7915_sta_stats {
-	struct rate_info prob_rate;
-	struct rate_info tx_rate;
-
-	unsigned long per;
 	unsigned long changed;
 	unsigned long jiffies;
 };
@@ -83,7 +79,6 @@ struct mt7915_sta {
 
 	struct mt7915_vif *vif;
 
-	struct list_head stats_list;
 	struct list_head poll_list;
 	struct list_head rc_list;
 	u32 airtime_ac[8];
@@ -94,7 +89,6 @@ struct mt7915_sta {
 
 	struct mt7915_sta_key_conf bip;
 };
-
 struct mt7915_vif {
 	u16 idx;
 	u8 omac_idx;
@@ -151,9 +145,6 @@ struct mt7915_phy {
 
 	struct mib_stats mib;
 	struct mt76_channel_state state_ts;
-	struct list_head stats_list;
-
-	u8 sta_work_count;
 
 #ifdef CONFIG_NL80211_TESTMODE
 	struct {
@@ -250,13 +241,6 @@ enum mt7915_rdd_cmd {
 	RDD_IRQ_OFF,
 };
 
-enum {
-	RATE_CTRL_RU_INFO,
-	RATE_CTRL_FIXED_RATE_INFO,
-	RATE_CTRL_DUMP_INFO,
-	RATE_CTRL_MU_INFO,
-};
-
 static inline struct mt7915_phy *
 mt7915_hw_phy(struct ieee80211_hw *hw)
 {
@@ -367,7 +351,6 @@ int mt7915_mcu_apply_tx_dpd(struct mt7915_phy *phy);
 int mt7915_mcu_get_chan_mib_info(struct mt7915_phy *phy, bool chan_switch);
 int mt7915_mcu_get_temperature(struct mt7915_phy *phy);
 int mt7915_mcu_set_thermal_throttling(struct mt7915_phy *phy, u8 state);
-int mt7915_mcu_get_tx_rate(struct mt7915_dev *dev, u32 cmd, u16 wlan_idx);
 int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, struct rate_info *rate);
 int mt7915_mcu_rdd_cmd(struct mt7915_dev *dev, enum mt7915_rdd_cmd cmd,
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index f0f7a913eaab..6f302acb6e69 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -64,9 +64,13 @@ mt76_tx_status_unlock(struct mt76_dev *dev, struct sk_buff_head *list)
 		struct mt76_wcid *wcid;
 
 		wcid = rcu_dereference(dev->wcid[cb->wcid]);
-		if (wcid)
+		if (wcid) {
 			status.sta = wcid_to_sta(wcid);
 
+			if (status.sta)
+				status.rate = &wcid->rate;
+		}
+
 		hw = mt76_tx_status_get_hw(dev, skb);
 		ieee80211_tx_status_ext(hw, &status);
 	}
-- 
2.29.2

