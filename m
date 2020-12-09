Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE4E2D4BD8
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Dec 2020 21:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388543AbgLIU3x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Dec 2020 15:29:53 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:36619 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388540AbgLIU3x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Dec 2020 15:29:53 -0500
X-UUID: fccb5bba5e8a44008ebba8e078e39880-20201210
X-UUID: fccb5bba5e8a44008ebba8e078e39880-20201210
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 784248791; Thu, 10 Dec 2020 04:29:03 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Dec 2020 04:29:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Dec 2020 04:29:00 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 1/2] mt76: mt7915: reset token when mac_reset happens
Date:   Thu, 10 Dec 2020 04:28:57 +0800
Message-ID: <69d62cd40ae52e0ddd5b26ba96bc7480385585a5.1607542812.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E1EAA8FC69FA8F5D066B51544A5C0CFD20CEEB1BBDE26E51B64D0F5CCECE27602000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Reset buffering token in mt7915_mac_reset_work() to avoid possible leakege,
which leads to Tx stop after mac reset.

Tested-by: Bo Jiao <bo.jiao@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
change since v2 - rebase on top of latest codebase
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 18 +-------------
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 24 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index ed4635bd151a..255ccd7e3d27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -672,28 +672,12 @@ int mt7915_register_device(struct mt7915_dev *dev)
 
 void mt7915_unregister_device(struct mt7915_dev *dev)
 {
-	struct mt76_txwi_cache *txwi;
-	int id;
-
 	mt7915_unregister_ext_phy(dev);
 	mt76_unregister_device(&dev->mt76);
 	mt7915_mcu_exit(dev);
 	mt7915_dma_cleanup(dev);
 
-	spin_lock_bh(&dev->token_lock);
-	idr_for_each_entry(&dev->token, txwi, id) {
-		mt7915_txp_skb_unmap(&dev->mt76, txwi);
-		if (txwi->skb) {
-			struct ieee80211_hw *hw;
-
-			hw = mt76_tx_status_get_hw(&dev->mt76, txwi->skb);
-			ieee80211_free_txskb(hw, txwi->skb);
-		}
-		mt76_put_txwi(&dev->mt76, txwi);
-		dev->token_count--;
-	}
-	spin_unlock_bh(&dev->token_lock);
-	idr_destroy(&dev->token);
+	mt7915_tx_token_put(dev);
 
 	mt76_free_device(&dev->mt76);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index f504eeb221f9..1b4d65310b88 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1485,6 +1485,27 @@ mt7915_dma_reset(struct mt7915_phy *phy)
 		 MT_WFDMA1_GLO_CFG_TX_DMA_EN | MT_WFDMA1_GLO_CFG_RX_DMA_EN);
 }
 
+void mt7915_tx_token_put(struct mt7915_dev *dev)
+{
+	struct mt76_txwi_cache *txwi;
+	int id;
+
+	spin_lock_bh(&dev->token_lock);
+	idr_for_each_entry(&dev->token, txwi, id) {
+		mt7915_txp_skb_unmap(&dev->mt76, txwi);
+		if (txwi->skb) {
+			struct ieee80211_hw *hw;
+
+			hw = mt76_tx_status_get_hw(&dev->mt76, txwi->skb);
+			ieee80211_free_txskb(hw, txwi->skb);
+		}
+		mt76_put_txwi(&dev->mt76, txwi);
+		dev->token_count--;
+	}
+	spin_unlock_bh(&dev->token_lock);
+	idr_destroy(&dev->token);
+}
+
 /* system error recovery */
 void mt7915_mac_reset_work(struct work_struct *work)
 {
@@ -1525,6 +1546,9 @@ void mt7915_mac_reset_work(struct work_struct *work)
 
 	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_STOPPED);
 
+	mt7915_tx_token_put(dev);
+	idr_init(&dev->token);
+
 	if (mt7915_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
 		mt7915_dma_reset(&dev->phy);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 0339abf360d3..94bed8a3a050 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -463,6 +463,7 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  struct ieee80211_sta *sta,
 			  struct mt76_tx_info *tx_info);
 void mt7915_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e);
+void mt7915_tx_token_put(struct mt7915_dev *dev);
 int mt7915_init_tx_queues(struct mt7915_phy *phy, int idx, int n_desc);
 void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb);
-- 
2.18.0

