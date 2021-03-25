Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B78349982
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Mar 2021 19:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhCYS3S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Mar 2021 14:29:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:51007 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230104AbhCYS3E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Mar 2021 14:29:04 -0400
X-UUID: 60b574c62f86417b947cc65e10f7d4f2-20210326
X-UUID: 60b574c62f86417b947cc65e10f7d4f2-20210326
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 797608230; Fri, 26 Mar 2021 02:28:59 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 26 Mar 2021 02:28:57 +0800
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
Subject: [PATCH v2 1/2] mt76: mt7615: cleanup mcu tx queue in mt7615_dma_reset()
Date:   Fri, 26 Mar 2021 02:28:55 +0800
Message-ID: <fdde0eb8c6dea0e81b5f5ae528085f1ccf53fef3.1616696376.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0275B13957BD8B2445E5A3E786A6A4A23CB3D92B8D2A1C5DF1F09CFD9856E9692000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Cleanup ext_phy and mcu tx queue so that mt7615_mac_reset_work() can
recover mt7615 normally.

Fixes: mt76: e637763b606 ("move mcu queues to mt76_dev q_mcu array")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
change since v2 - cleanup mphy_ext->q_tx
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index bb3f93d90f4e..4e41c12d08eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -2013,20 +2013,26 @@ mt7615_update_beacons(struct mt7615_dev *dev)
 
 void mt7615_dma_reset(struct mt7615_dev *dev)
 {
+	struct mt76_phy *mphy_ext = dev->mt76.phy2;
 	int i;
 
 	mt76_clear(dev, MT_WPDMA_GLO_CFG,
 		   MT_WPDMA_GLO_CFG_RX_DMA_EN | MT_WPDMA_GLO_CFG_TX_DMA_EN |
 		   MT_WPDMA_GLO_CFG_TX_WRITEBACK_DONE);
+
 	usleep_range(1000, 2000);
 
-	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WM], true);
-	for (i = 0; i < __MT_TXQ_MAX; i++)
+	for (i = 0; i < __MT_TXQ_MAX; i++) {
 		mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[i], true);
+		if (mphy_ext)
+			mt76_queue_tx_cleanup(dev, mphy_ext->q_tx[i], true);
+	}
 
-	mt76_for_each_q_rx(&dev->mt76, i) {
+	for (i = 0; i < __MT_MCUQ_MAX; i++)
+		mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[i], true);
+
+	mt76_for_each_q_rx(&dev->mt76, i)
 		mt76_queue_rx_reset(dev, i);
-	}
 
 	mt76_set(dev, MT_WPDMA_GLO_CFG,
 		 MT_WPDMA_GLO_CFG_RX_DMA_EN | MT_WPDMA_GLO_CFG_TX_DMA_EN |
-- 
2.18.0

