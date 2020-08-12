Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB69E242839
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 12:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgHLK2e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 06:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgHLK2e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 06:28:34 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C0EC061787
        for <linux-wireless@vger.kernel.org>; Wed, 12 Aug 2020 03:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uLCZOy2c4fjUcIIhKytItTacWq3Gg92xzgXyG5GO8H4=; b=SX/yKYFgY1c3QXSENIzZpKeYis
        3B1Nc31WiTpfW74n4/ircoGqJufzDzE925RwdVi8pYRIeXjt3EEiNKeQ/o8U4zGdBMj1SE2tjslg6
        4g5xQM0q17W9+ekQZQxr5ghh7wV5zjJ7NY3ju2e/UCVfOn1kR1Likq3AJ1NyHoQPjv7g=;
Received: from p54ae996c.dip0.t-ipconnect.de ([84.174.153.108] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k5nzk-0002U3-Np
        for linux-wireless@vger.kernel.org; Wed, 12 Aug 2020 12:28:32 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 6/8] mt76: mt7915: simplify aggregation session check
Date:   Wed, 12 Aug 2020 12:28:29 +0200
Message-Id: <20200812102831.11991-6-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812102831.11991-1-nbd@nbd.name>
References: <20200812102831.11991-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use the txwi data as primary source information to avoid touching skb data
Use bitfield instead of state variable + spinlock

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 44 +++++++------------
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  8 ++--
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 19 +-------
 3 files changed, 19 insertions(+), 52 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index dde1c93d6701..df9131d7af3d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -765,45 +765,29 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	return 0;
 }
 
-static inline bool
-mt7915_tx_check_aggr_tid(struct mt7915_sta *msta, u8 tid)
-{
-	bool ret = false;
-
-	spin_lock_bh(&msta->ampdu_lock);
-	if (msta->ampdu_state[tid] == MT7915_AGGR_STOP)
-		ret = true;
-	spin_unlock_bh(&msta->ampdu_lock);
-
-	return ret;
-}
-
 static void
-mt7915_tx_check_aggr(struct ieee80211_sta *sta, struct sk_buff *skb)
+mt7915_tx_check_aggr(struct ieee80211_sta *sta, __le32 *txwi)
 {
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct mt7915_sta *msta;
-	u16 tid;
-
-	if (!sta->ht_cap.ht_supported)
-		return;
+	u16 fc, tid;
+	u32 val;
 
-	if (skb_get_queue_mapping(skb) == IEEE80211_AC_VO)
+	if (!sta || !sta->ht_cap.ht_supported)
 		return;
 
-	if (unlikely(!ieee80211_is_data_qos(hdr->frame_control)))
+	tid = FIELD_GET(MT_TXD1_TID, le32_to_cpu(txwi[1]));
+	if (tid >= 6) /* skip VO queue */
 		return;
 
-	if (unlikely(skb->protocol == cpu_to_be16(ETH_P_PAE)))
+	val = le32_to_cpu(txwi[2]);
+	fc = FIELD_GET(MT_TXD2_FRAME_TYPE, val) << 2 |
+	     FIELD_GET(MT_TXD2_SUB_TYPE, val) << 4;
+	if (unlikely(fc != (IEEE80211_FTYPE_DATA | IEEE80211_STYPE_QOS_DATA)))
 		return;
 
 	msta = (struct mt7915_sta *)sta->drv_priv;
-	tid = ieee80211_get_tid(hdr);
-
-	if (mt7915_tx_check_aggr_tid(msta, tid)) {
+	if (!test_and_set_bit(tid, &msta->ampdu_state))
 		ieee80211_start_tx_ba_session(sta, tid, 0);
-		mt7915_set_aggr_state(msta, tid, MT7915_AGGR_PROGRESS);
-	}
 }
 
 static inline void
@@ -840,8 +824,6 @@ mt7915_tx_complete_status(struct mt76_dev *mdev, struct sk_buff *skb,
 
 	if (info->flags & IEEE80211_TX_CTL_AMPDU)
 		info->flags |= IEEE80211_TX_STAT_AMPDU;
-	else if (sta)
-		mt7915_tx_check_aggr(sta, skb);
 
 	if (stat)
 		ieee80211_tx_info_clear_status(info);
@@ -931,6 +913,10 @@ void mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 
 		mt7915_txp_skb_unmap(mdev, txwi);
 		if (txwi->skb) {
+			void *txwi_ptr = mt76_get_txwi_ptr(mdev, txwi);
+
+			if (likely(txwi->skb->protocol != cpu_to_be16(ETH_P_PAE)))
+				mt7915_tx_check_aggr(sta, txwi_ptr);
 			mt7915_tx_complete_status(mdev, txwi->skb, sta, stat);
 			txwi->skb = NULL;
 		}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 9e53f0db87f2..f3d26968735c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -498,7 +498,6 @@ int mt7915_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	INIT_LIST_HEAD(&msta->rc_list);
 	INIT_LIST_HEAD(&msta->stats_list);
 	INIT_LIST_HEAD(&msta->poll_list);
-	spin_lock_init(&msta->ampdu_lock);
 	msta->vif = mvif;
 	msta->wcid.sta = 1;
 	msta->wcid.idx = idx;
@@ -610,22 +609,21 @@ mt7915_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
 		mtxq->aggr = true;
 		mtxq->send_bar = false;
-		mt7915_set_aggr_state(msta, tid, MT7915_AGGR_OPERATIONAL);
 		mt7915_mcu_add_tx_ba(dev, params, true);
 		break;
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
-		mt7915_set_aggr_state(msta, tid, MT7915_AGGR_STOP);
+		clear_bit(tid, &msta->ampdu_state);
 		mt7915_mcu_add_tx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_START:
-		mt7915_set_aggr_state(msta, tid, MT7915_AGGR_START);
+		set_bit(tid, &msta->ampdu_state);
 		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
 		break;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
-		mt7915_set_aggr_state(msta, tid, MT7915_AGGR_STOP);
+		clear_bit(tid, &msta->ampdu_state);
 		mt7915_mcu_add_tx_ba(dev, params, false);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index f8b7752a201b..1a5f3922e46b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -58,13 +58,6 @@ enum mt7915_rxq_id {
 	MT7915_RXQ_MCU_WA,
 };
 
-enum mt7915_ampdu_state {
-	MT7915_AGGR_STOP,
-	MT7915_AGGR_PROGRESS,
-	MT7915_AGGR_START,
-	MT7915_AGGR_OPERATIONAL
-};
-
 struct mt7915_sta_stats {
 	struct rate_info prob_rate;
 	struct rate_info tx_rate;
@@ -86,8 +79,7 @@ struct mt7915_sta {
 
 	struct mt7915_sta_stats stats;
 
-	spinlock_t ampdu_lock;
-	enum mt7915_ampdu_state ampdu_state[IEEE80211_NUM_TIDS];
+	unsigned long ampdu_state;
 };
 
 struct mt7915_vif {
@@ -272,15 +264,6 @@ static inline u8 mt7915_lmac_mapping(struct mt7915_dev *dev, u8 ac)
 	return lmac_queue_map[ac];
 }
 
-static inline void
-mt7915_set_aggr_state(struct mt7915_sta *msta, u8 tid,
-		      enum mt7915_ampdu_state state)
-{
-	spin_lock_bh(&msta->ampdu_lock);
-	msta->ampdu_state[tid] = state;
-	spin_unlock_bh(&msta->ampdu_lock);
-}
-
 extern const struct ieee80211_ops mt7915_ops;
 extern struct pci_driver mt7915_pci_driver;
 
-- 
2.28.0

