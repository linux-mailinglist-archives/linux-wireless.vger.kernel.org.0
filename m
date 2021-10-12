Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB7642AFD4
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Oct 2021 00:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbhJLWy2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Oct 2021 18:54:28 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:1710 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbhJLWy1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Oct 2021 18:54:27 -0400
X-UUID: a3e667764ccf42c68df96a792f3f8e6e-20211012
X-UUID: a3e667764ccf42c68df96a792f3f8e6e-20211012
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1200445039; Tue, 12 Oct 2021 15:52:23 -0700
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 12 Oct 2021 15:52:21 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Oct 2021 06:52:21 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Mark-YW.Chen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v4 02/16] mt76: mt7921: refactor dma.c to be pcie specific
Date:   Wed, 13 Oct 2021 06:51:55 +0800
Message-ID: <546e27cf15780093260070e59519fcb8a575d25e.1634077769.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1634077769.git.objelf@gmail.com>
References: <cover.1634077769.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

This is a preliminary patch to introduce mt7921s support.

make dma.c be used dedicately for mt7921e.

by moving out mt7921_tx_cleanup from dma.c to mcu.c and then renaming
mt7921_tx_cleanup to refect the exact thing the function actually does.

Finally, dma.c totally become pcie specific one, only needed to
be compiled only when CONFIG_MT7921E is enabled.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c    | 8 +-------
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 7 ++++++-
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index 802e40e42040..d3e2036a1974 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -19,12 +19,6 @@ int mt7921_init_tx_queues(struct mt7921_phy *phy, int idx, int n_desc)
 	return 0;
 }
 
-void mt7921_tx_cleanup(struct mt7921_dev *dev)
-{
-	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WM], false);
-	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WA], false);
-}
-
 static int mt7921_poll_tx(struct napi_struct *napi, int budget)
 {
 	struct mt7921_dev *dev;
@@ -37,7 +31,7 @@ static int mt7921_poll_tx(struct napi_struct *napi, int budget)
 		return 0;
 	}
 
-	mt7921_tx_cleanup(dev);
+	mt7921_mcu_tx_cleanup(dev);
 	if (napi_complete(napi))
 		mt7921_irq_enable(dev, MT_INT_TX_DONE_ALL);
 	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 0857d523bb06..eb27d8ab4a8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1386,7 +1386,7 @@ void mt7921_pm_wake_work(struct work_struct *work)
 		mt76_for_each_q_rx(&dev->mt76, i)
 			napi_schedule(&dev->mt76.napi[i]);
 		mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
-		mt7921_tx_cleanup(dev);
+		mt7921_mcu_tx_cleanup(dev);
 		if (test_bit(MT76_STATE_RUNNING, &mphy->state))
 			ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
 						     MT7921_WATCHDOG_TIME);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 70c0f41180a1..a6c3661b2bdd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -316,6 +316,12 @@ static inline bool mt7921_dma_need_reinit(struct mt7921_dev *dev)
 	return !mt76_get_field(dev, MT_WFDMA_DUMMY_CR, MT_WFDMA_NEED_REINIT);
 }
 
+static inline void mt7921_mcu_tx_cleanup(struct mt7921_dev *dev)
+{
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WM], false);
+	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WA], false);
+}
+
 int mt7921_mac_init(struct mt7921_dev *dev);
 bool mt7921_mac_wtbl_update(struct mt7921_dev *dev, int idx, u32 mask);
 void mt7921_mac_reset_counters(struct mt7921_phy *phy);
@@ -330,7 +336,6 @@ void mt7921_mac_work(struct work_struct *work);
 void mt7921_mac_reset_work(struct work_struct *work);
 void mt7921_mac_update_mib_stats(struct mt7921_phy *phy);
 void mt7921_reset(struct mt76_dev *mdev);
-void mt7921_tx_cleanup(struct mt7921_dev *dev);
 int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			   enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			   struct ieee80211_sta *sta,
-- 
2.25.1

