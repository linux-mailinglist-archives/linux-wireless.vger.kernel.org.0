Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D340D3941FA
	for <lists+linux-wireless@lfdr.de>; Fri, 28 May 2021 13:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhE1LkO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 May 2021 07:40:14 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51810 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229878AbhE1LkN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 May 2021 07:40:13 -0400
X-UUID: 85a70dd05d1c4bfbb84b379787c2b4a7-20210528
X-UUID: 85a70dd05d1c4bfbb84b379787c2b4a7-20210528
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 60272234; Fri, 28 May 2021 19:38:36 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 28 May 2021 19:38:34 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 May 2021 19:38:35 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>, <jemele@google.com>,
        <yenlinlai@google.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] mt76: mt7921: introduce mac tx done handling
Date:   Fri, 28 May 2021 19:38:09 +0800
Message-ID: <c55859b030762914d457bc538a5d3bc52cc8e826.1622201114.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

Instead of read tx status from mac table, add new mechanisam to hanele
tx done event for data frame, every 250ms

This event indicate the real tx status of this pkt in mac layer and
would help mac80211 correct status more frequently

Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 69 +++++++++++--------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 47 +++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   | 28 ++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +
 4 files changed, 117 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 212832b34674..9366d779cbc7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -13,6 +13,36 @@
 #define HE_PREP(f, m, v)	le16_encode_bits(le32_get_bits(v, MT_CRXV_HE_##m),\
 						 IEEE80211_RADIOTAP_HE_##f)
 
+static u8
+mt7921_next_pid(struct mt7921_dev *dev, struct mt76_wcid *wcid)
+{
+	wcid->packet_id = (wcid->packet_id + 1) & MT_PACKET_ID_MASK;
+	if (wcid->packet_id == MT_PACKET_ID_NO_ACK ||
+	    wcid->packet_id == MT_PACKET_ID_NO_SKB)
+		wcid->packet_id = MT_PACKET_ID_FIRST;
+	return wcid->packet_id;
+}
+
+unsigned long
+mt7921_next_txs_set(struct mt7921_dev *dev, struct mt76_wcid *wcid,
+		    u32 timeout)
+{
+	struct mt7921_sta *msta;
+
+	msta = container_of(wcid, struct mt7921_sta, wcid);
+	msta->next_txs_ts = jiffies + msecs_to_jiffies(timeout);
+	return msta->next_txs_ts;
+}
+
+bool
+mt7921_next_txs_timeout(struct mt7921_dev *dev, struct mt76_wcid *wcid)
+{
+	struct mt7921_sta *msta;
+
+	msta = container_of(wcid, struct mt7921_sta, wcid);
+	return time_is_before_jiffies(msta->next_txs_ts);
+}
+
 static struct mt76_wcid *mt7921_rx_get_wcid(struct mt7921_dev *dev,
 					    u16 idx, bool unicast)
 {
@@ -726,7 +756,7 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = info->control.vif;
 	struct mt76_phy *mphy = &dev->mphy;
-	u8 p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
+	u8 pid, p_fmt, q_idx, omac_idx = 0, wmm_idx = 0;
 	bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
 	u16 tx_count = 15;
 	u32 val;
@@ -795,6 +825,15 @@ void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
 		txwi[6] |= cpu_to_le32(val);
 		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
 	}
+
+	if ((FIELD_GET(MT_TXD2_FRAME_TYPE, txwi[2]) &
+		(IEEE80211_FTYPE_DATA >> 2)) &&
+		mt7921_next_txs_timeout(dev, wcid)) {
+		mt7921_next_txs_set(dev, wcid, 250);
+		pid = mt7921_next_pid(dev, wcid);
+		val = MT_TXD5_TX_STATUS_MCU | FIELD_PREP(MT_TXD5_PID, pid);
+		txwi[5] |= cpu_to_le32(val);
+	}
 }
 
 static void
@@ -1380,30 +1419,6 @@ mt7921_mac_update_mib_stats(struct mt7921_phy *phy)
 	}
 }
 
-static void
-mt7921_mac_sta_stats_work(struct mt7921_phy *phy)
-{
-	struct mt7921_dev *dev = phy->dev;
-	struct mt7921_sta *msta;
-	LIST_HEAD(list);
-
-	spin_lock_bh(&dev->sta_poll_lock);
-	list_splice_init(&phy->stats_list, &list);
-
-	while (!list_empty(&list)) {
-		msta = list_first_entry(&list, struct mt7921_sta, stats_list);
-		list_del_init(&msta->stats_list);
-		spin_unlock_bh(&dev->sta_poll_lock);
-
-		/* query wtbl info to report tx rate for further devices */
-		mt7921_get_wtbl_info(dev, msta->wcid.idx);
-
-		spin_lock_bh(&dev->sta_poll_lock);
-	}
-
-	spin_unlock_bh(&dev->sta_poll_lock);
-}
-
 void mt7921_mac_work(struct work_struct *work)
 {
 	struct mt7921_phy *phy;
@@ -1421,10 +1436,6 @@ void mt7921_mac_work(struct work_struct *work)
 
 		mt7921_mac_update_mib_stats(phy);
 	}
-	if (++phy->sta_work_count == 4) {
-		phy->sta_work_count = 0;
-		mt7921_mac_sta_stats_work(phy);
-	}
 
 	mt7921_mutex_release(phy->dev);
 	ieee80211_queue_delayed_work(phy->mt76->hw, &mphy->mac_work,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 5a4c695f73c9..e8cd767ea475 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -531,6 +531,49 @@ mt7921_mcu_low_power_event(struct mt7921_dev *dev, struct sk_buff *skb)
 	trace_lp_event(dev, event->state);
 }
 
+static void
+mt7921_mcu_tx_done_event(struct mt7921_dev *dev, struct sk_buff *skb)
+{
+	struct mt7921_mcu_tx_done_event *event;
+	struct mt7921_sta *msta;
+	struct mt7921_phy *mphy = &dev->phy;
+	struct mt7921_mcu_peer_cap peer;
+	struct ieee80211_sta *sta;
+	LIST_HEAD(list);
+
+	skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
+	event = (struct mt7921_mcu_tx_done_event *)skb->data;
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	list_splice_init(&mphy->stats_list, &list);
+
+	while (!list_empty(&list)) {
+		msta = list_first_entry(&list, struct mt7921_sta, stats_list);
+		list_del_init(&msta->stats_list);
+
+		if (msta->wcid.idx != event->wlan_idx)
+			continue;
+
+		spin_unlock_bh(&dev->sta_poll_lock);
+
+		sta = wcid_to_sta(&msta->wcid);
+
+		/* peer config based on IEEE SPEC */
+		memset(&peer, 0x0, sizeof(peer));
+		peer.bw = event->bw;
+		peer.g2 = !!(sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_20);
+		peer.g4 = !!(sta->ht_cap.cap & IEEE80211_HT_CAP_SGI_40);
+		peer.g8 = !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_80);
+		peer.g16 = !!(sta->vht_cap.cap & IEEE80211_VHT_CAP_SHORT_GI_160);
+		mt7921_mcu_tx_rate_parse(mphy->mt76, &peer,
+					 &msta->stats.tx_rate, event->tx_rate);
+
+		spin_lock_bh(&dev->sta_poll_lock);
+		break;
+	}
+	spin_unlock_bh(&dev->sta_poll_lock);
+}
+
 static void
 mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
 {
@@ -557,6 +600,9 @@ mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
 	case MCU_EVENT_LP_INFO:
 		mt7921_mcu_low_power_event(dev, skb);
 		break;
+	case MCU_EVENT_TX_DONE:
+		mt7921_mcu_tx_done_event(dev, skb);
+		break;
 	default:
 		break;
 	}
@@ -577,6 +623,7 @@ void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb)
 	    rxd->eid == MCU_EVENT_SCHED_SCAN_DONE ||
 	    rxd->eid == MCU_EVENT_BSS_ABSENCE ||
 	    rxd->eid == MCU_EVENT_SCAN_DONE ||
+	    rxd->eid == MCU_EVENT_TX_DONE ||
 	    rxd->eid == MCU_EVENT_DBG_MSG ||
 	    rxd->eid == MCU_EVENT_COREDUMP ||
 	    rxd->eid == MCU_EVENT_LP_INFO ||
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index 49823d0a3d0a..22ebef4add00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -81,6 +81,7 @@ enum {
 	MCU_EVENT_REG_ACCESS = 0x05,
 	MCU_EVENT_LP_INFO = 0x07,
 	MCU_EVENT_SCAN_DONE = 0x0d,
+	MCU_EVENT_TX_DONE = 0x0f,
 	MCU_EVENT_BSS_ABSENCE  = 0x11,
 	MCU_EVENT_BSS_BEACON_LOSS = 0x13,
 	MCU_EVENT_CH_PRIVILEGE = 0x18,
@@ -407,4 +408,31 @@ struct mt7921_txpwr_event {
 	struct mt7921_txpwr txpwr;
 } __packed;
 
+struct mt7921_mcu_tx_done_event {
+	u8 pid;
+	u8 status;
+	u16 seq;
+
+	u8 wlan_idx;
+	u8 tx_cnt;
+	u16 tx_rate;
+
+	u8 flag;
+	u8 tid;
+	u8 rsp_rate;
+	u8 mcs;
+
+	u8 bw;
+	u8 tx_pwr;
+	u8 reason;
+	u8 rsv0[1];
+
+	u32 delay;
+	u32 timestamp;
+	u32 applied_flag;
+
+	u8 txs[28];
+
+	u8 rsv1[32];
+} __packed;
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 59862ea4951c..a1e4276273d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -92,6 +92,8 @@ struct mt7921_sta {
 	unsigned long ampdu_state;
 
 	struct mt7921_sta_key_conf bip;
+
+	unsigned long next_txs_ts;
 };
 
 DECLARE_EWMA(rssi, 10, 8);
-- 
2.18.0

