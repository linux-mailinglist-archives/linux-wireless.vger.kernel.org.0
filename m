Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85015349981
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Mar 2021 19:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhCYS3R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Mar 2021 14:29:17 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46350 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229989AbhCYS3C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Mar 2021 14:29:02 -0400
X-UUID: ce7fd3c3451e4f9b92ce1096b8f5d375-20210326
X-UUID: ce7fd3c3451e4f9b92ce1096b8f5d375-20210326
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1477624052; Fri, 26 Mar 2021 02:28:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 26 Mar 2021 02:28:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 26 Mar 2021 02:28:57 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 2/2] mt76: mt7915: cleanup mcu tx queue in mt7915_dma_reset()
Date:   Fri, 26 Mar 2021 02:28:56 +0800
Message-ID: <70cadb225568bd81b6e7927f3a1db3565c4c3adf.1616696376.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <fdde0eb8c6dea0e81b5f5ae528085f1ccf53fef3.1616696376.git.ryder.lee@mediatek.com>
References: <fdde0eb8c6dea0e81b5f5ae528085f1ccf53fef3.1616696376.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Cleanup mcu queues in mt7915_mac_reset_work().

Fixes: mt76: e637763b606 ("move mcu queues to mt76_dev q_mcu array")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index d3a6312c058c..0924ae074db2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1515,9 +1515,8 @@ mt7915_update_beacons(struct mt7915_dev *dev)
 }
 
 static void
-mt7915_dma_reset(struct mt7915_phy *phy)
+mt7915_dma_reset(struct mt7915_dev *dev)
 {
-	struct mt7915_dev *dev = phy->dev;
 	struct mt76_phy *mphy_ext = dev->mt76.phy2;
 	u32 hif1_ofs = MT_WFDMA1_PCIE1_BASE - MT_WFDMA1_BASE;
 	int i;
@@ -1534,18 +1533,20 @@ mt7915_dma_reset(struct mt7915_phy *phy)
 			   (MT_WFDMA1_GLO_CFG_TX_DMA_EN |
 			    MT_WFDMA1_GLO_CFG_RX_DMA_EN));
 	}
+
 	usleep_range(1000, 2000);
 
-	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WA], true);
 	for (i = 0; i < __MT_TXQ_MAX; i++) {
-		mt76_queue_tx_cleanup(dev, phy->mt76->q_tx[i], true);
+		mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[i], true);
 		if (mphy_ext)
 			mt76_queue_tx_cleanup(dev, mphy_ext->q_tx[i], true);
 	}
 
-	mt76_for_each_q_rx(&dev->mt76, i) {
+	for (i = 0; i < __MT_MCUQ_MAX; i++)
+		mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[i], true);
+
+	mt76_for_each_q_rx(&dev->mt76, i)
 		mt76_queue_rx_reset(dev, i);
-	}
 
 	/* re-init prefetch settings after reset */
 	mt7915_dma_prefetch(dev);
@@ -1630,7 +1631,7 @@ void mt7915_mac_reset_work(struct work_struct *work)
 	idr_init(&dev->token);
 
 	if (mt7915_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
-		mt7915_dma_reset(&dev->phy);
+		mt7915_dma_reset(dev);
 
 		mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_INIT);
 		mt7915_wait_reset_state(dev, MT_MCU_CMD_RECOVERY_DONE);
-- 
2.18.0

