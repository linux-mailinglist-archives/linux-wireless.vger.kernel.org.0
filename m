Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0B07409DA
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjF1Hwd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:52:33 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:38880 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230093AbjF1Hw2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:52:28 -0400
X-UUID: 68f279d0158211ee9cb5633481061a41-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6PDqreba8OPai+PIacZji7W6uuUKmIkJ+VvFQSiME2A=;
        b=G1cYTcOcUAARSE1Ff+rvkgQLjiMFpK31lhuH3iPsy7+fdubNKwLPhkRr9YlWCq5Cl8LUz2h11rKeCok4ikDH39cHs25jHy3Q84pqn2ZNt5XN3U4okU2/ZiDFARZyCb1Nvg6f/w3F/nGlTaDA8k2zoq9yn/wgkpBeHjG+yUeT2IY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:840a0f70-0c37-46a3-b6cd-63dc0ebc18ed,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.27,REQID:840a0f70-0c37-46a3-b6cd-63dc0ebc18ed,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:01c9525,CLOUDID:4c694f0d-26a8-467f-b838-f99719a9c083,B
        ulkID:230628150716YS40BVMD,BulkQuantity:0,Recheck:0,SF:28|17|19|48|38|29,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: 68f279d0158211ee9cb5633481061a41-20230628
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 504911790; Wed, 28 Jun 2023 15:07:14 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:07:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:07:14 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 04/16] wifi: mt76: mt7921: rename mt7921_sta in mt792x_sta
Date:   Wed, 28 Jun 2023 15:05:50 +0800
Message-ID: <cf4a3db00340bcc1ae447b1a0eb2d50ed341a1b1.1687919628.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1687919628.git.deren.wu@mediatek.com>
References: <cover.1687919628.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

This is a preliminary patch to introduce WiFi7 chipset support

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 22 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 22 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  8 +++----
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  8 +++----
 .../wireless/mediatek/mt76/mt7921/pci_mac.c   |  2 +-
 6 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index f2a6fd61863b..df32f4f1b636 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -140,7 +140,7 @@ mt7921_init_wiphy(struct ieee80211_hw *hw)
 
 	phy->slottime = 9;
 
-	hw->sta_data_size = sizeof(struct mt7921_sta);
+	hw->sta_data_size = sizeof(struct mt792x_sta);
 	hw->vif_data_size = sizeof(struct mt792x_vif);
 
 	if (dev->fw_features & MT7921_FW_CAP_CNM) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 44b0122073f8..d4cf2ff18102 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -23,7 +23,7 @@ static u32 mt7921_mac_wtbl_lmac_addr(int idx, u8 offset)
 static struct mt76_wcid *mt7921_rx_get_wcid(struct mt7921_dev *dev,
 					    u16 idx, bool unicast)
 {
-	struct mt7921_sta *sta;
+	struct mt792x_sta *sta;
 	struct mt76_wcid *wcid;
 
 	if (idx >= ARRAY_SIZE(dev->mt76.wcid))
@@ -36,7 +36,7 @@ static struct mt76_wcid *mt7921_rx_get_wcid(struct mt7921_dev *dev,
 	if (!wcid->sta)
 		return NULL;
 
-	sta = container_of(wcid, struct mt7921_sta, wcid);
+	sta = container_of(wcid, struct mt792x_sta, wcid);
 	if (!sta->vif)
 		return NULL;
 
@@ -61,7 +61,7 @@ static void mt7921_mac_sta_poll(struct mt7921_dev *dev)
 		[IEEE80211_AC_VO] = 6
 	};
 	struct ieee80211_sta *sta;
-	struct mt7921_sta *msta;
+	struct mt792x_sta *msta;
 	u32 tx_time[IEEE80211_NUM_ACS], rx_time[IEEE80211_NUM_ACS];
 	LIST_HEAD(sta_poll_list);
 	struct rate_info *rate;
@@ -84,7 +84,7 @@ static void mt7921_mac_sta_poll(struct mt7921_dev *dev)
 			break;
 		}
 		msta = list_first_entry(&sta_poll_list,
-					struct mt7921_sta, wcid.poll_list);
+					struct mt792x_sta, wcid.poll_list);
 		list_del_init(&msta->wcid.poll_list);
 		spin_unlock_bh(&dev->mt76.sta_poll_lock);
 
@@ -248,7 +248,7 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	u32 rxd2 = le32_to_cpu(rxd[2]);
 	u32 rxd3 = le32_to_cpu(rxd[3]);
 	u32 rxd4 = le32_to_cpu(rxd[4]);
-	struct mt7921_sta *msta = NULL;
+	struct mt792x_sta *msta = NULL;
 	u16 seq_ctrl = 0;
 	__le16 fc = 0;
 	u8 mode = 0;
@@ -279,7 +279,7 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 	status->wcid = mt7921_rx_get_wcid(dev, idx, unicast);
 
 	if (status->wcid) {
-		msta = container_of(status->wcid, struct mt7921_sta, wcid);
+		msta = container_of(status->wcid, struct mt792x_sta, wcid);
 		spin_lock_bh(&dev->mt76.sta_poll_lock);
 		if (list_empty(&msta->wcid.poll_list))
 			list_add_tail(&msta->wcid.poll_list,
@@ -513,7 +513,7 @@ mt7921_mac_fill_rx(struct mt7921_dev *dev, struct sk_buff *skb)
 
 void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data)
 {
-	struct mt7921_sta *msta = NULL;
+	struct mt792x_sta *msta = NULL;
 	struct mt76_wcid *wcid;
 	__le32 *txs_data = data;
 	u16 wcidx;
@@ -537,7 +537,7 @@ void mt7921_mac_add_txs(struct mt7921_dev *dev, void *data)
 	if (!wcid)
 		goto out;
 
-	msta = container_of(wcid, struct mt7921_sta, wcid);
+	msta = container_of(wcid, struct mt792x_sta, wcid);
 
 	mt76_connac2_mac_add_txs_skb(&dev->mt76, wcid, pid, txs_data);
 	if (!wcid->sta)
@@ -582,7 +582,7 @@ static void mt7921_mac_tx_free(struct mt7921_dev *dev, void *data, int len)
 		 * 1'b0: msdu_id with the same 'wcid pair' as above.
 		 */
 		if (info & MT_TX_FREE_PAIR) {
-			struct mt7921_sta *msta;
+			struct mt792x_sta *msta;
 			u16 idx;
 
 			count++;
@@ -592,7 +592,7 @@ static void mt7921_mac_tx_free(struct mt7921_dev *dev, void *data, int len)
 			if (!sta)
 				continue;
 
-			msta = container_of(wcid, struct mt7921_sta, wcid);
+			msta = container_of(wcid, struct mt792x_sta, wcid);
 			spin_lock_bh(&mdev->sta_poll_lock);
 			if (list_empty(&msta->wcid.poll_list))
 				list_add_tail(&msta->wcid.poll_list,
@@ -1140,7 +1140,7 @@ int mt7921_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		wcid = &dev->mt76.global_wcid;
 
 	if (sta) {
-		struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+		struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 
 		if (time_after(jiffies, msta->last_txs + HZ / 4)) {
 			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index de8c3a02cf4b..bd449423e5b3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -342,7 +342,7 @@ static void mt7921_remove_interface(struct ieee80211_hw *hw,
 				    struct ieee80211_vif *vif)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt7921_sta *msta = &mvif->sta;
+	struct mt792x_sta *msta = &mvif->sta;
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 	int idx = msta->wcid.idx;
@@ -508,7 +508,7 @@ static int mt7921_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 {
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
-	struct mt7921_sta *msta = sta ? (struct mt7921_sta *)sta->drv_priv :
+	struct mt792x_sta *msta = sta ? (struct mt792x_sta *)sta->drv_priv :
 				  &mvif->sta;
 	struct mt76_wcid *wcid = &msta->wcid;
 	u8 *wcid_keyidx = &wcid->hw_key_idx;
@@ -756,7 +756,7 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta)
 {
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
-	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 	int ret, idx;
 
@@ -797,7 +797,7 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			  struct ieee80211_sta *sta)
 {
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
-	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
 	mt7921_mutex_acquire(dev);
@@ -822,7 +822,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta)
 {
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
-	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 
 	mt76_connac_free_pending_tx_skbs(&dev->pm, &msta->wcid);
 	mt76_connac_pm_wake(&dev->mphy, &dev->pm);
@@ -877,9 +877,9 @@ static void mt7921_tx(struct ieee80211_hw *hw,
 	int qid;
 
 	if (control->sta) {
-		struct mt7921_sta *sta;
+		struct mt792x_sta *sta;
 
-		sta = (struct mt7921_sta *)control->sta->drv_priv;
+		sta = (struct mt792x_sta *)control->sta->drv_priv;
 		wcid = &sta->wcid;
 	}
 
@@ -924,7 +924,7 @@ mt7921_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 	struct ieee80211_sta *sta = params->sta;
 	struct ieee80211_txq *txq = sta->txq[params->tid];
-	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	u16 tid = params->tid;
 	u16 ssn = params->ssn;
 	struct mt76_txq *mtxq;
@@ -1120,7 +1120,7 @@ mt7921_get_et_sset_count(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 static void
 mt7921_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
 {
-	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt76_ethtool_worker_info *wi = wi_data;
 
 	if (msta->vif->mt76.idx != wi->idx)
@@ -1387,7 +1387,7 @@ static void mt7921_sta_statistics(struct ieee80211_hw *hw,
 				  struct ieee80211_sta *sta,
 				  struct station_info *sinfo)
 {
-	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct rate_info *txrate = &msta->wcid.rate;
 
 	if (!txrate->legacy && !txrate->flags)
@@ -1500,7 +1500,7 @@ static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
 					 struct ieee80211_sta *sta,
 					 bool enabled)
 {
-	struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt7921_dev *dev = mt7921_hw_dev(hw);
 
 	mt7921_mutex_acquire(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 4d8b4c802739..1d1e8ee5bd3d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -343,7 +343,7 @@ int mt7921_mcu_uni_tx_ba(struct mt7921_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable)
 {
-	struct mt7921_sta *msta = (struct mt7921_sta *)params->sta->drv_priv;
+	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
 
 	if (enable && !params->amsdu)
 		msta->wcid.amsdu = false;
@@ -357,7 +357,7 @@ int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable)
 {
-	struct mt7921_sta *msta = (struct mt7921_sta *)params->sta->drv_priv;
+	struct mt792x_sta *msta = (struct mt792x_sta *)params->sta->drv_priv;
 
 	return mt76_connac_mcu_sta_ba(&dev->mt76, &msta->vif->mt76, params,
 				      MCU_UNI_CMD(STA_REC_UPDATE),
@@ -933,9 +933,9 @@ int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *sta,
 		.offload_fw = true,
 		.rcpi = to_rcpi(rssi),
 	};
-	struct mt7921_sta *msta;
+	struct mt792x_sta *msta;
 
-	msta = sta ? (struct mt7921_sta *)sta->drv_priv : NULL;
+	msta = sta ? (struct mt792x_sta *)sta->drv_priv : NULL;
 	info.wcid = msta ? &msta->wcid : &mvif->sta.wcid;
 	info.newly = msta ? state != MT76_STA_INFO_STATE_ASSOC : true;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 6ec5b19f3c25..4d409ba3fc21 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -128,7 +128,7 @@ struct mt7921_sdio_intr {
 #define to_rcpi(rssi)			(2 * (rssi) + 220)
 
 struct mt792x_vif;
-struct mt7921_sta;
+struct mt792x_sta;
 
 enum mt7921_txq_id {
 	MT7921_TXQ_BAND0,
@@ -145,7 +145,7 @@ enum mt7921_rxq_id {
 
 DECLARE_EWMA(avg_signal, 10, 8)
 
-struct mt7921_sta {
+struct mt792x_sta {
 	struct mt76_wcid wcid; /* must be first */
 
 	struct mt792x_vif *vif;
@@ -165,8 +165,8 @@ DECLARE_EWMA(rssi, 10, 8);
 struct mt792x_vif {
 	struct mt76_vif mt76; /* must be first */
 
-	struct mt7921_sta sta;
-	struct mt7921_sta *wep_sta;
+	struct mt792x_sta sta;
+	struct mt792x_sta *wep_sta;
 
 	struct mt7921_phy *phy;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
index 978c90a034cf..32bba86727a5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
@@ -32,7 +32,7 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		return id;
 
 	if (sta) {
-		struct mt7921_sta *msta = (struct mt7921_sta *)sta->drv_priv;
+		struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 
 		if (time_after(jiffies, msta->last_txs + HZ / 4)) {
 			info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
-- 
2.18.0

