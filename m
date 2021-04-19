Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF533645E1
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Apr 2021 16:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbhDSOVd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Apr 2021 10:21:33 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48984 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232452AbhDSOVc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Apr 2021 10:21:32 -0400
X-UUID: 0822cb5e665f47c19192faf82f51e6cd-20210419
X-UUID: 0822cb5e665f47c19192faf82f51e6cd-20210419
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 700161532; Mon, 19 Apr 2021 22:21:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Apr 2021 22:21:00 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Apr 2021 22:21:00 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v2 2/6] mt76: mt7921: introduce mt7921_wpdma_reset utility routine
Date:   Mon, 19 Apr 2021 22:20:55 +0800
Message-ID: <1618842059-8192-3-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1618842059-8192-1-git-send-email-sean.wang@mediatek.com>
References: <1618842059-8192-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Introduce mt7921_wpdma_reset routine to reset wpdma during chip reset
or driver_own request.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7921/dma.c   | 44 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7921/mac.c   | 29 ++----------
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  2 +-
 3 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index 0c577a5bac13..af4b6cf38929 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -229,7 +229,7 @@ static int mt7921_dmashdl_disabled(struct mt7921_dev *dev)
 	return 0;
 }
 
-int mt7921_dma_reset(struct mt7921_dev *dev, bool force)
+static int mt7921_dma_reset(struct mt7921_dev *dev, bool force)
 {
 	int i;
 
@@ -300,6 +300,48 @@ int mt7921_dma_reset(struct mt7921_dev *dev, bool force)
 	return 0;
 }
 
+int mt7921_wfsys_reset(struct mt7921_dev *dev)
+{
+	mt76_set(dev, 0x70002600, BIT(0));
+	msleep(200);
+	mt76_clear(dev, 0x70002600, BIT(0));
+
+	if (!__mt76_poll_msec(&dev->mt76, MT_WFSYS_SW_RST_B,
+			      WFSYS_SW_INIT_DONE, WFSYS_SW_INIT_DONE, 500))
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+int mt7921_wpdma_reset(struct mt7921_dev *dev, bool force)
+{
+	int i, err;
+
+	/* clean up hw queues */
+	for (i = 0; i < ARRAY_SIZE(dev->mt76.phy.q_tx); i++)
+		mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[i], true);
+
+	for (i = 0; i < ARRAY_SIZE(dev->mt76.q_mcu); i++)
+		mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[i], true);
+
+	mt76_for_each_q_rx(&dev->mt76, i)
+		mt76_queue_rx_cleanup(dev, &dev->mt76.q_rx[i]);
+
+	if (force) {
+		err = mt7921_wfsys_reset(dev);
+		if (err)
+			return err;
+	}
+	err = mt7921_dma_reset(dev, force);
+	if (err)
+		return err;
+
+	mt76_for_each_q_rx(&dev->mt76, i)
+		mt76_queue_rx_reset(dev, i);
+
+	return 0;
+}
+
 int mt7921_dma_init(struct mt7921_dev *dev)
 {
 	/* Increase buffer size to receive large VHT/HE MPDUs */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 9aadb598019d..98daf03884a3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1204,16 +1204,6 @@ void mt7921_update_channel(struct mt76_dev *mdev)
 	mt76_connac_power_save_sched(&dev->mphy, &dev->pm);
 }
 
-int mt7921_wfsys_reset(struct mt7921_dev *dev)
-{
-	mt76_set(dev, 0x70002600, BIT(0));
-	msleep(200);
-	mt76_clear(dev, 0x70002600, BIT(0));
-
-	return __mt76_poll_msec(&dev->mt76, MT_WFSYS_SW_RST_B,
-				WFSYS_SW_INIT_DONE, WFSYS_SW_INIT_DONE, 500);
-}
-
 void mt7921_tx_token_put(struct mt7921_dev *dev)
 {
 	struct mt76_txwi_cache *txwi;
@@ -1273,21 +1263,11 @@ mt7921_mac_reset(struct mt7921_dev *dev)
 	mt7921_tx_token_put(dev);
 	idr_init(&dev->token);
 
-	/* clean up hw queues */
-	for (i = 0; i < ARRAY_SIZE(dev->mt76.phy.q_tx); i++)
-		mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[i], true);
-
-	for (i = 0; i < ARRAY_SIZE(dev->mt76.q_mcu); i++)
-		mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[i], true);
-
-	mt76_for_each_q_rx(&dev->mt76, i)
-		mt76_queue_rx_cleanup(dev, &dev->mt76.q_rx[i]);
-
-	mt7921_wfsys_reset(dev);
-	mt7921_dma_reset(dev, true);
+	err = mt7921_wpdma_reset(dev, true);
+	if (err)
+		return err;
 
 	mt76_for_each_q_rx(&dev->mt76, i) {
-		mt76_queue_rx_reset(dev, i);
 		napi_enable(&dev->mt76.napi[i]);
 		napi_schedule(&dev->mt76.napi[i]);
 	}
@@ -1301,9 +1281,6 @@ mt7921_mac_reset(struct mt7921_dev *dev)
 
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
-	mt7921_irq_enable(dev,
-			  MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
-			  MT_INT_MCU_CMD);
 
 	err = mt7921_run_firmware(dev);
 	if (err)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 58cfa2bbeba5..67cb0a647066 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -253,7 +253,7 @@ int mt7921_eeprom_get_target_power(struct mt7921_dev *dev,
 				   u8 chain_idx);
 void mt7921_eeprom_init_sku(struct mt7921_dev *dev);
 int mt7921_dma_init(struct mt7921_dev *dev);
-int mt7921_dma_reset(struct mt7921_dev *dev, bool force);
+int mt7921_wpdma_reset(struct mt7921_dev *dev, bool force);
 void mt7921_dma_cleanup(struct mt7921_dev *dev);
 int mt7921_run_firmware(struct mt7921_dev *dev);
 int mt7921_mcu_init(struct mt7921_dev *dev);
-- 
2.25.1

