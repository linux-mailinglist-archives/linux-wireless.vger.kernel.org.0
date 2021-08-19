Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4431C3F153B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 10:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237366AbhHSIdN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 04:33:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237350AbhHSIdL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 04:33:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B665861131;
        Thu, 19 Aug 2021 08:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629361954;
        bh=+GGwgETkdXQEMsotIT4wL7pgWPnky9YANdtfcL+xak0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=URSA5MGNgBh8Wv5qLwUjqDpskkfumBdUR7CnAaR9Bbt+Njk2NlYx7fG3L1qUwvJy9
         NED0ha9O2ShAM1vpxFyz4XEf4+TfeLD3AZeV6D9mxCXOBMoyp2RUwNmK4sN3xCBtPe
         5r+TbE3s2tOmzMD3fkDi92NK85dvOFqDPlcS6ky/JEHjpPgN5voEzWkrvzyDJ79poV
         x4qmznhhg97iZ8poYZSr5pv88ncU2KcZr5PjTr6AVP4Wjadr65hBhaekl0CxxO+UlS
         kAWGlbrLgO0HFXw+2nms+U3U/hSQgbcFIwIHCJphILEuDzYXkbuQNDeamcn0p75ZzC
         5V+uWPIskDtpA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH v2 4/5] mt76: mt7921: remove mcu rate reporting code
Date:   Thu, 19 Aug 2021 10:32:04 +0200
Message-Id: <118ceeb0c055c01c3f0807a6d2ca6d34d232fbdb.1629361688.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629361688.git.lorenzo@kernel.org>
References: <cover.1629361688.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove unused tx rate reporting through mcu tx done event since
now tx status is fully supported

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  |   1 -
 .../net/wireless/mediatek/mt76/mt7921/mac.c   |   2 -
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   4 -
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 133 ------------------
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  47 -------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |   2 -
 6 files changed, 189 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 1f37e64b6038..e067ab78be1b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -202,7 +202,6 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	mutex_init(&dev->pm.mutex);
 	init_waitqueue_head(&dev->pm.wait);
 	spin_lock_init(&dev->pm.txq_lock);
-	INIT_LIST_HEAD(&dev->phy.stats_list);
 	INIT_DELAYED_WORK(&dev->mphy.mac_work, mt7921_mac_work);
 	INIT_DELAYED_WORK(&dev->phy.scan_work, mt7921_scan_work);
 	INIT_DELAYED_WORK(&dev->coredump.work, mt7921_coredump_work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index ea8222bb0c77..1d15599c782a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1118,8 +1118,6 @@ mt7921_mac_tx_free(struct mt7921_dev *dev, struct sk_buff *skb)
 			msta = container_of(wcid, struct mt7921_sta, wcid);
 			phy = msta->vif->phy;
 			spin_lock_bh(&dev->sta_poll_lock);
-			if (list_empty(&msta->stats_list))
-				list_add_tail(&msta->stats_list, &phy->stats_list);
 			if (list_empty(&msta->poll_list))
 				list_add_tail(&msta->poll_list, &dev->sta_poll_list);
 			spin_unlock_bh(&dev->sta_poll_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 874c7c18ad09..8a7b4e78c097 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -264,7 +264,6 @@ static int mt7921_add_interface(struct ieee80211_hw *hw,
 
 	idx = MT7921_WTBL_RESERVED - mvif->mt76.idx;
 
-	INIT_LIST_HEAD(&mvif->sta.stats_list);
 	INIT_LIST_HEAD(&mvif->sta.poll_list);
 	mvif->sta.wcid.idx = idx;
 	mvif->sta.wcid.ext_phy = mvif->mt76.band_idx;
@@ -581,7 +580,6 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	if (idx < 0)
 		return -ENOSPC;
 
-	INIT_LIST_HEAD(&msta->stats_list);
 	INIT_LIST_HEAD(&msta->poll_list);
 	msta->vif = mvif;
 	msta->wcid.sta = 1;
@@ -657,8 +655,6 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	spin_lock_bh(&dev->sta_poll_lock);
 	if (!list_empty(&msta->poll_list))
 		list_del_init(&msta->poll_list);
-	if (!list_empty(&msta->stats_list))
-		list_del_init(&msta->stats_list);
 	spin_unlock_bh(&dev->sta_poll_lock);
 
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index cadb633639d3..f49fc8078125 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -322,94 +322,6 @@ mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	return mt76_tx_queue_skb_raw(dev, mdev->q_mcu[txq], skb, 0);
 }
 
-static void
-mt7921_mcu_tx_rate_parse(struct mt76_phy *mphy,
-			 struct mt7921_mcu_peer_cap *peer,
-			 struct rate_info *rate, u16 r)
-{
-	struct ieee80211_supported_band *sband;
-	u16 flags = 0;
-	u8 txmode = FIELD_GET(MT_WTBL_RATE_TX_MODE, r);
-	u8 gi = 0;
-	u8 bw = 0;
-
-	rate->mcs = FIELD_GET(MT_WTBL_RATE_MCS, r);
-	rate->nss = FIELD_GET(MT_WTBL_RATE_NSS, r) + 1;
-
-	switch (peer->bw) {
-	case IEEE80211_STA_RX_BW_160:
-		gi = peer->g16;
-		break;
-	case IEEE80211_STA_RX_BW_80:
-		gi = peer->g8;
-		break;
-	case IEEE80211_STA_RX_BW_40:
-		gi = peer->g4;
-		break;
-	default:
-		gi = peer->g2;
-		break;
-	}
-
-	gi = txmode >= MT_PHY_TYPE_HE_SU ?
-		FIELD_GET(MT_WTBL_RATE_HE_GI, gi) :
-		FIELD_GET(MT_WTBL_RATE_GI, gi);
-
-	switch (txmode) {
-	case MT_PHY_TYPE_CCK:
-	case MT_PHY_TYPE_OFDM:
-		if (mphy->chandef.chan->band == NL80211_BAND_5GHZ)
-			sband = &mphy->sband_5g.sband;
-		else
-			sband = &mphy->sband_2g.sband;
-
-		rate->legacy = sband->bitrates[rate->mcs].bitrate;
-		break;
-	case MT_PHY_TYPE_HT:
-	case MT_PHY_TYPE_HT_GF:
-		flags |= RATE_INFO_FLAGS_MCS;
-
-		if (gi)
-			flags |= RATE_INFO_FLAGS_SHORT_GI;
-		break;
-	case MT_PHY_TYPE_VHT:
-		flags |= RATE_INFO_FLAGS_VHT_MCS;
-
-		if (gi)
-			flags |= RATE_INFO_FLAGS_SHORT_GI;
-		break;
-	case MT_PHY_TYPE_HE_SU:
-	case MT_PHY_TYPE_HE_EXT_SU:
-	case MT_PHY_TYPE_HE_TB:
-	case MT_PHY_TYPE_HE_MU:
-		rate->he_gi = gi;
-		rate->he_dcm = FIELD_GET(MT_RA_RATE_DCM_EN, r);
-
-		flags |= RATE_INFO_FLAGS_HE_MCS;
-		break;
-	default:
-		break;
-	}
-	rate->flags = flags;
-
-	bw = mt7921_mcu_chan_bw(&mphy->chandef) - FIELD_GET(MT_RA_RATE_BW, r);
-
-	switch (bw) {
-	case IEEE80211_STA_RX_BW_160:
-		rate->bw = RATE_INFO_BW_160;
-		break;
-	case IEEE80211_STA_RX_BW_80:
-		rate->bw = RATE_INFO_BW_80;
-		break;
-	case IEEE80211_STA_RX_BW_40:
-		rate->bw = RATE_INFO_BW_40;
-		break;
-	default:
-		rate->bw = RATE_INFO_BW_20;
-		break;
-	}
-}
-
 static void
 mt7921_mcu_scan_event(struct mt7921_dev *dev, struct sk_buff *skb)
 {
@@ -509,48 +421,6 @@ mt7921_mcu_low_power_event(struct mt7921_dev *dev, struct sk_buff *skb)
 	trace_lp_event(dev, event->state);
 }
 
-static void
-mt7921_mcu_tx_done_event(struct mt7921_dev *dev, struct sk_buff *skb)
-{
-	struct mt7921_mcu_tx_done_event *event;
-	struct mt7921_sta *msta;
-	struct mt7921_phy *mphy = &dev->phy;
-	struct mt7921_mcu_peer_cap peer;
-	struct ieee80211_sta *sta;
-	LIST_HEAD(list);
-
-	skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
-	event = (struct mt7921_mcu_tx_done_event *)skb->data;
-
-	spin_lock_bh(&dev->sta_poll_lock);
-	list_splice_init(&mphy->stats_list, &list);
-
-	while (!list_empty(&list)) {
-		msta = list_first_entry(&list, struct mt7921_sta, stats_list);
-		list_del_init(&msta->stats_list);
-
-		if (msta->wcid.idx != event->wlan_idx)
-			continue;
-
-		spin_unlock_bh(&dev->sta_poll_lock);
-
-		sta = wcid_to_sta(&msta->wcid);
-
-		/* peer config based on IEEE SPEC */
-		memset(&peer, 0x0, sizeof(peer));
-		peer.bw = event->bw;
-		peer.g2 = !!(sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_20);
-		peer.g4 = !!(sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_40);
-		peer.g8 = !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80);
-		peer.g16 = !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_160);
-		mt7921_mcu_tx_rate_parse(mphy->mt76, &peer,
-					 &msta->stats.tx_rate,
-					 le16_to_cpu(event->tx_rate));
-		return;
-	}
-	spin_unlock_bh(&dev->sta_poll_lock);
-}
-
 static void
 mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
 {
@@ -577,9 +447,6 @@ mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
 	case MCU_EVENT_LP_INFO:
 		mt7921_mcu_low_power_event(dev, skb);
 		break;
-	case MCU_EVENT_TX_DONE:
-		mt7921_mcu_tx_done_event(dev, skb);
-		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index 2ff7ffcd01ef..945015ab62cc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -259,25 +259,6 @@ struct mt7921_mcu_ant_id_config {
 	u8 ant_id[4];
 } __packed;
 
-struct mt7921_mcu_peer_cap {
-	struct mt7921_mcu_ant_id_config ant_id_config;
-
-	u8 power_offset;
-	u8 bw_selector;
-	u8 change_bw_rate_n;
-	u8 bw;
-	u8 spe_idx;
-
-	u8 g2;
-	u8 g4;
-	u8 g8;
-	u8 g16;
-
-	u8 mmss;
-	u8 ampdu_factor;
-	u8 rsv[1];
-} __packed;
-
 struct mt7921_txpwr_req {
 	u8 ver;
 	u8 action;
@@ -293,34 +274,6 @@ struct mt7921_txpwr_event {
 	struct mt7921_txpwr txpwr;
 } __packed;
 
-struct mt7921_mcu_tx_done_event {
-	u8 pid;
-	u8 status;
-	__le16 seq;
-
-	u8 wlan_idx;
-	u8 tx_cnt;
-	__le16 tx_rate;
-
-	u8 flag;
-	u8 tid;
-	u8 rsp_rate;
-	u8 mcs;
-
-	u8 bw;
-	u8 tx_pwr;
-	u8 reason;
-	u8 rsv0[1];
-
-	__le32 delay;
-	__le32 timestamp;
-	__le32 applied_flag;
-
-	u8 txs[28];
-
-	u8 rsv1[32];
-} __packed;
-
 enum {
 	TM_SWITCH_MODE,
 	TM_SET_AT_CMD,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 26f175ef505e..61fa53af3840 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -84,7 +84,6 @@ struct mt7921_sta {
 
 	struct mt7921_vif *vif;
 
-	struct list_head stats_list;
 	struct list_head poll_list;
 	u32 airtime_ac[8];
 
@@ -136,7 +135,6 @@ struct mt7921_phy {
 	u32 ampdu_ref;
 
 	struct mib_stats mib;
-	struct list_head stats_list;
 
 	u8 sta_work_count;
 
-- 
2.31.1

