Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAECA3C815A
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jul 2021 11:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238701AbhGNJVu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jul 2021 05:21:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40620 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238400AbhGNJVs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jul 2021 05:21:48 -0400
X-UUID: a1f8c2877c554d6d8db5ddffdc0d5861-20210714
X-UUID: a1f8c2877c554d6d8db5ddffdc0d5861-20210714
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 218521449; Wed, 14 Jul 2021 17:18:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 14 Jul 2021 17:18:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 14 Jul 2021 17:18:52 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 2/4] mt76: mt7915: cleanup -Wunused-but-set-variable
Date:   Wed, 14 Jul 2021 17:18:49 +0800
Message-ID: <35bffb8d7f4fd01c576e826aaca723c75454e550.1626253920.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <50730853fe09fb75418484770a0c95c23b44deb5.1626253920.git.ryder.lee@mediatek.com>
References: <50730853fe09fb75418484770a0c95c23b44deb5.1626253920.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Cleanup -Wunused-but-set-variable everywhere in driver.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 2462704094b0..70ec8ca94fcc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1162,7 +1162,6 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 	count = FIELD_GET(MT_TX_FREE_MSDU_CNT, le16_to_cpu(free->ctrl));
 	for (i = 0; i < count; i++) {
 		u32 msdu, info = le32_to_cpu(free->info[i]);
-		u8 stat;
 
 		/*
 		 * 1'b1: new wcid pair.
@@ -1170,7 +1169,6 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 		 */
 		if (info & MT_TX_FREE_PAIR) {
 			struct mt7915_sta *msta;
-			struct mt7915_phy *phy;
 			struct mt76_wcid *wcid;
 			u16 idx;
 
@@ -1182,7 +1180,6 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 				continue;
 
 			msta = container_of(wcid, struct mt7915_sta, wcid);
-			phy = msta->vif->phy;
 			spin_lock_bh(&dev->sta_poll_lock);
 			if (list_empty(&msta->stats_list))
 				list_add_tail(&msta->stats_list, &phy->stats_list);
@@ -1193,8 +1190,6 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, struct sk_buff *skb)
 		}
 
 		msdu = FIELD_GET(MT_TX_FREE_MSDU_ID, info);
-		stat = FIELD_GET(MT_TX_FREE_STATUS, info);
-
 		txwi = mt76_token_release(mdev, msdu, &wake);
 		if (!txwi)
 			continue;
@@ -1333,15 +1328,11 @@ void mt7915_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 
 void mt7915_tx_complete_skb(struct mt76_dev *mdev, struct mt76_queue_entry *e)
 {
-	struct mt7915_dev *dev;
-
 	if (!e->txwi) {
 		dev_kfree_skb_any(e->skb);
 		return;
 	}
 
-	dev = container_of(mdev, struct mt7915_dev, mt76);
-
 	/* error path */
 	if (e->skb == DMA_DUMMY_DATA) {
 		struct mt76_txwi_cache *t;
-- 
2.29.2

