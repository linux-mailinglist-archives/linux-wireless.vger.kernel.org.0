Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334256D70A0
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Apr 2023 01:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbjDDXYx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Apr 2023 19:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjDDXYw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Apr 2023 19:24:52 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB090F2
        for <linux-wireless@vger.kernel.org>; Tue,  4 Apr 2023 16:24:46 -0700 (PDT)
X-UUID: dff374ecd33f11eda9a90f0bb45854f4-20230405
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=n9XMvy51OEqtdAE/QuBmwe2k1vj/GmgHQkocayT1rVs=;
        b=U1QWS0+H5AvBbIRU8PUJlI2aPjfqSX1DSjBYMCm2B3yqwtHGG8Iny0elCU9meeAAXwy5ixmBinJom/xTZz04lK9kZ2dCLTH/O4dfG0Texeng+t+YztI9LFTRQ0kIMrdwBGK/y1ZMBurjD60l2FzAKrlr/2YUNsBDjmYmJTtEtvw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:d8bf1c7a-bb8f-4a8f-84b2-403d695a6457,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.22,REQID:d8bf1c7a-bb8f-4a8f-84b2-403d695a6457,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:120426c,CLOUDID:628ccef7-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:2304050403538M5IKTR9,BulkQuantity:6,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:41,QS:nil,BEC:nil,COL
        :0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: dff374ecd33f11eda9a90f0bb45854f4-20230405
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 682650904; Wed, 05 Apr 2023 07:24:41 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 5 Apr 2023 07:24:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 5 Apr 2023 07:24:39 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 1/3] wifi: mt76: mt7996: enable full system reset support
Date:   Wed, 5 Apr 2023 07:24:37 +0800
Message-ID: <6756ddde5aaaf29db4f62264bab7f28bb539b26f.1680650499.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

Add mt7996_reset() and refactor mt7996_mac_reset_work() to support
full system recovery.

Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/dma.c   |  64 ++++
 .../net/wireless/mediatek/mt76/mt7996/init.c  |  11 +-
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 284 +++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7996/main.c  |  18 +-
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   |  22 +-
 .../net/wireless/mediatek/mt76/mt7996/mmio.c  |   7 +-
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  17 +-
 .../net/wireless/mediatek/mt76/mt7996/regs.h  |  13 +-
 8 files changed, 365 insertions(+), 71 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
index c09fe4274935..534143465d9b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/dma.c
@@ -352,6 +352,70 @@ int mt7996_dma_init(struct mt7996_dev *dev)
 	return 0;
 }
 
+void mt7996_dma_reset(struct mt7996_dev *dev, bool force)
+{
+	struct mt76_phy *phy2 = dev->mt76.phys[MT_BAND1];
+	struct mt76_phy *phy3 = dev->mt76.phys[MT_BAND2];
+	u32 hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
+	int i;
+
+	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
+		   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+		   MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+
+	if (dev->hif2)
+		mt76_clear(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
+			   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
+			   MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+
+	usleep_range(1000, 2000);
+
+	for (i = 0; i < __MT_TXQ_MAX; i++) {
+		mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[i], true);
+		if (phy2)
+			mt76_queue_tx_cleanup(dev, phy2->q_tx[i], true);
+		if (phy3)
+			mt76_queue_tx_cleanup(dev, phy3->q_tx[i], true);
+	}
+
+	for (i = 0; i < __MT_MCUQ_MAX; i++)
+		mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[i], true);
+
+	mt76_for_each_q_rx(&dev->mt76, i)
+		mt76_queue_rx_cleanup(dev, &dev->mt76.q_rx[i]);
+
+	mt76_tx_status_check(&dev->mt76, true);
+
+	/* reset wfsys */
+	if (force)
+		mt7996_wfsys_reset(dev);
+
+	mt7996_dma_disable(dev, force);
+
+	/* reset hw queues */
+	for (i = 0; i < __MT_TXQ_MAX; i++) {
+		mt76_queue_reset(dev, dev->mphy.q_tx[i]);
+		if (phy2)
+			mt76_queue_reset(dev, phy2->q_tx[i]);
+		if (phy3)
+			mt76_queue_reset(dev, phy3->q_tx[i]);
+	}
+
+	for (i = 0; i < __MT_MCUQ_MAX; i++)
+		mt76_queue_reset(dev, dev->mt76.q_mcu[i]);
+
+	mt76_for_each_q_rx(&dev->mt76, i) {
+		mt76_queue_reset(dev, &dev->mt76.q_rx[i]);
+	}
+
+	mt76_tx_status_check(&dev->mt76, true);
+
+	mt76_for_each_q_rx(&dev->mt76, i)
+		mt76_queue_rx_reset(dev, i);
+
+	mt7996_dma_enable(dev);
+}
+
 void mt7996_dma_cleanup(struct mt7996_dev *dev)
 {
 	mt7996_dma_disable(dev, true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 946da93eed32..76501e42cd8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -99,9 +99,8 @@ static void mt7996_led_set_brightness(struct led_classdev *led_cdev,
 		mt7996_led_set_config(led_cdev, 0xff, 0);
 }
 
-static void
-mt7996_init_txpower(struct mt7996_dev *dev,
-		    struct ieee80211_supported_band *sband)
+void mt7996_init_txpower(struct mt7996_dev *dev,
+			 struct ieee80211_supported_band *sband)
 {
 	int i, nss = hweight8(dev->mphy.antenna_mask);
 	int nss_delta = mt76_tx_power_nss_delta(nss);
@@ -250,7 +249,7 @@ mt7996_mac_init_band(struct mt7996_dev *dev, u8 band)
 	mt76_rmw(dev, MT_WTBLOFF_RSCR(band), mask, set);
 }
 
-static void mt7996_mac_init(struct mt7996_dev *dev)
+void mt7996_mac_init(struct mt7996_dev *dev)
 {
 #define HIF_TXD_V2_1	4
 	int i;
@@ -284,7 +283,7 @@ static void mt7996_mac_init(struct mt7996_dev *dev)
 		mt7996_mac_init_band(dev, i);
 }
 
-static int mt7996_txbf_init(struct mt7996_dev *dev)
+int mt7996_txbf_init(struct mt7996_dev *dev)
 {
 	int ret;
 
@@ -886,6 +885,8 @@ int mt7996_register_device(struct mt7996_dev *dev)
 	if (ret)
 		return ret;
 
+	dev->recovery.hw_init_done = true;
+
 	return mt7996_init_debugfs(&dev->phy);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 3c3506c7c87a..f5c24985b905 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1706,7 +1706,7 @@ mt7996_wait_reset_state(struct mt7996_dev *dev, u32 state)
 	bool ret;
 
 	ret = wait_event_timeout(dev->reset_wait,
-				 (READ_ONCE(dev->reset_state) & state),
+				 (READ_ONCE(dev->recovery.state) & state),
 				 MT7996_RESET_TIMEOUT);
 
 	WARN(!ret, "Timeout waiting for MCU reset state %x\n", state);
@@ -1755,68 +1755,207 @@ mt7996_update_beacons(struct mt7996_dev *dev)
 					    mt7996_update_vif_beacon, phy3->hw);
 }
 
-static void
-mt7996_dma_reset(struct mt7996_dev *dev)
+void mt7996_tx_token_put(struct mt7996_dev *dev)
 {
-	struct mt76_phy *phy2 = dev->mt76.phys[MT_BAND1];
-	struct mt76_phy *phy3 = dev->mt76.phys[MT_BAND2];
-	u32 hif1_ofs = MT_WFDMA0_PCIE1(0) - MT_WFDMA0(0);
-	int i;
+	struct mt76_txwi_cache *txwi;
+	int id;
+
+	spin_lock_bh(&dev->mt76.token_lock);
+	idr_for_each_entry(&dev->mt76.token, txwi, id) {
+		mt7996_txwi_free(dev, txwi, NULL, NULL);
+		dev->mt76.token_count--;
+	}
+	spin_unlock_bh(&dev->mt76.token_lock);
+	idr_destroy(&dev->mt76.token);
+}
+
+static int
+mt7996_mac_restart(struct mt7996_dev *dev)
+{
+	struct mt7996_phy *phy2, *phy3;
+	struct mt76_dev *mdev = &dev->mt76;
+	int i, ret;
 
-	mt76_clear(dev, MT_WFDMA0_GLO_CFG,
-		   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
-		   MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+	phy2 = mt7996_phy2(dev);
+	phy3 = mt7996_phy3(dev);
 
-	if (dev->hif2)
-		mt76_clear(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
-			   MT_WFDMA0_GLO_CFG_TX_DMA_EN |
-			   MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+	if (dev->hif2) {
+		mt76_wr(dev, MT_INT1_MASK_CSR, 0x0);
+		mt76_wr(dev, MT_INT1_SOURCE_CSR, ~0);
+	}
 
-	usleep_range(1000, 2000);
+	if (dev_is_pci(mdev->dev)) {
+		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
+		if (dev->hif2)
+			mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0x0);
+	}
 
-	for (i = 0; i < __MT_TXQ_MAX; i++) {
-		mt76_queue_tx_cleanup(dev, dev->mphy.q_tx[i], true);
-		if (phy2)
-			mt76_queue_tx_cleanup(dev, phy2->q_tx[i], true);
-		if (phy3)
-			mt76_queue_tx_cleanup(dev, phy3->q_tx[i], true);
+	set_bit(MT76_RESET, &dev->mphy.state);
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+	wake_up(&dev->mt76.mcu.wait);
+	if (phy2) {
+		set_bit(MT76_RESET, &phy2->mt76->state);
+		set_bit(MT76_MCU_RESET, &phy2->mt76->state);
+	}
+	if (phy3) {
+		set_bit(MT76_RESET, &phy3->mt76->state);
+		set_bit(MT76_MCU_RESET, &phy3->mt76->state);
 	}
 
-	for (i = 0; i < __MT_MCUQ_MAX; i++)
-		mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[i], true);
+	/* lock/unlock all queues to ensure that no tx is pending */
+	mt76_txq_schedule_all(&dev->mphy);
+	if (phy2)
+		mt76_txq_schedule_all(phy2->mt76);
+	if (phy3)
+		mt76_txq_schedule_all(phy3->mt76);
 
-	mt76_for_each_q_rx(&dev->mt76, i)
-		mt76_queue_rx_reset(dev, i);
+	/* disable all tx/rx napi */
+	mt76_worker_disable(&dev->mt76.tx_worker);
+	mt76_for_each_q_rx(mdev, i) {
+		if (mdev->q_rx[i].ndesc)
+			napi_disable(&dev->mt76.napi[i]);
+	}
+	napi_disable(&dev->mt76.tx_napi);
+
+	/* token reinit */
+	mt7996_tx_token_put(dev);
+	idr_init(&dev->mt76.token);
+
+	mt7996_dma_reset(dev, true);
+
+	local_bh_disable();
+	mt76_for_each_q_rx(mdev, i) {
+		if (mdev->q_rx[i].ndesc) {
+			napi_enable(&dev->mt76.napi[i]);
+			napi_schedule(&dev->mt76.napi[i]);
+		}
+	}
+	local_bh_enable();
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+	clear_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+
+	mt76_wr(dev, MT_INT_MASK_CSR, dev->mt76.mmio.irqmask);
+	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
+	if (dev->hif2) {
+		mt76_wr(dev, MT_INT1_MASK_CSR, dev->mt76.mmio.irqmask);
+		mt76_wr(dev, MT_INT1_SOURCE_CSR, ~0);
+	}
+	if (dev_is_pci(mdev->dev)) {
+		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+		if (dev->hif2)
+			mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0xff);
+	}
+
+	/* load firmware */
+	ret = mt7996_mcu_init_firmware(dev);
+	if (ret)
+		goto out;
+
+	/* set the necessary init items */
+	ret = mt7996_mcu_set_eeprom(dev);
+	if (ret)
+		goto out;
+
+	mt7996_mac_init(dev);
+	mt7996_init_txpower(dev, &dev->mphy.sband_2g.sband);
+	mt7996_init_txpower(dev, &dev->mphy.sband_5g.sband);
+	mt7996_init_txpower(dev, &dev->mphy.sband_6g.sband);
+	ret = mt7996_txbf_init(dev);
+
+	if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state)) {
+		ret = mt7996_run(dev->mphy.hw);
+		if (ret)
+			goto out;
+	}
 
-	mt76_tx_status_check(&dev->mt76, true);
+	if (phy2 && test_bit(MT76_STATE_RUNNING, &phy2->mt76->state)) {
+		ret = mt7996_run(phy2->mt76->hw);
+		if (ret)
+			goto out;
+	}
 
-	/* re-init prefetch settings after reset */
-	mt7996_dma_prefetch(dev);
+	if (phy3 && test_bit(MT76_STATE_RUNNING, &phy3->mt76->state)) {
+		ret = mt7996_run(phy3->mt76->hw);
+		if (ret)
+			goto out;
+	}
+
+out:
+	/* reset done */
+	clear_bit(MT76_RESET, &dev->mphy.state);
+	if (phy2)
+		clear_bit(MT76_RESET, &phy2->mt76->state);
+	if (phy3)
+		clear_bit(MT76_RESET, &phy3->mt76->state);
 
-	mt76_set(dev, MT_WFDMA0_GLO_CFG,
-		 MT_WFDMA0_GLO_CFG_TX_DMA_EN | MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+	local_bh_disable();
+	napi_enable(&dev->mt76.tx_napi);
+	napi_schedule(&dev->mt76.tx_napi);
+	local_bh_enable();
 
-	if (dev->hif2)
-		mt76_set(dev, MT_WFDMA0_GLO_CFG + hif1_ofs,
-			 MT_WFDMA0_GLO_CFG_TX_DMA_EN |
-			 MT_WFDMA0_GLO_CFG_RX_DMA_EN);
+	mt76_worker_enable(&dev->mt76.tx_worker);
+	return ret;
 }
 
-void mt7996_tx_token_put(struct mt7996_dev *dev)
+static void
+mt7996_mac_full_reset(struct mt7996_dev *dev)
 {
-	struct mt76_txwi_cache *txwi;
-	int id;
+	struct mt7996_phy *phy2, *phy3;
+	int i;
 
-	spin_lock_bh(&dev->mt76.token_lock);
-	idr_for_each_entry(&dev->mt76.token, txwi, id) {
-		mt7996_txwi_free(dev, txwi, NULL, NULL);
-		dev->mt76.token_count--;
+	phy2 = mt7996_phy2(dev);
+	phy3 = mt7996_phy3(dev);
+	dev->recovery.hw_full_reset = true;
+
+	wake_up(&dev->mt76.mcu.wait);
+	ieee80211_stop_queues(mt76_hw(dev));
+	if (phy2)
+		ieee80211_stop_queues(phy2->mt76->hw);
+	if (phy3)
+		ieee80211_stop_queues(phy3->mt76->hw);
+
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
+	if (phy2)
+		cancel_delayed_work_sync(&phy2->mt76->mac_work);
+	if (phy3)
+		cancel_delayed_work_sync(&phy3->mt76->mac_work);
+
+	mutex_lock(&dev->mt76.mutex);
+	for (i = 0; i < 10; i++) {
+		if (!mt7996_mac_restart(dev))
+			break;
 	}
-	spin_unlock_bh(&dev->mt76.token_lock);
-	idr_destroy(&dev->mt76.token);
+	mutex_unlock(&dev->mt76.mutex);
+
+	if (i == 10)
+		dev_err(dev->mt76.dev, "chip full reset failed\n");
+
+	ieee80211_restart_hw(mt76_hw(dev));
+	if (phy2)
+		ieee80211_restart_hw(phy2->mt76->hw);
+	if (phy3)
+		ieee80211_restart_hw(phy3->mt76->hw);
+
+	ieee80211_wake_queues(mt76_hw(dev));
+	if (phy2)
+		ieee80211_wake_queues(phy2->mt76->hw);
+	if (phy3)
+		ieee80211_wake_queues(phy3->mt76->hw);
+
+	dev->recovery.hw_full_reset = false;
+	ieee80211_queue_delayed_work(mt76_hw(dev),
+				     &dev->mphy.mac_work,
+				     MT7996_WATCHDOG_TIME);
+	if (phy2)
+		ieee80211_queue_delayed_work(phy2->mt76->hw,
+					     &phy2->mt76->mac_work,
+					     MT7996_WATCHDOG_TIME);
+	if (phy3)
+		ieee80211_queue_delayed_work(phy3->mt76->hw,
+					     &phy3->mt76->mac_work,
+					     MT7996_WATCHDOG_TIME);
 }
 
-/* system error recovery */
 void mt7996_mac_reset_work(struct work_struct *work)
 {
 	struct mt7996_phy *phy2, *phy3;
@@ -1827,9 +1966,36 @@ void mt7996_mac_reset_work(struct work_struct *work)
 	phy2 = mt7996_phy2(dev);
 	phy3 = mt7996_phy3(dev);
 
-	if (!(READ_ONCE(dev->reset_state) & MT_MCU_CMD_STOP_DMA))
+	/* chip full reset */
+	if (dev->recovery.restart) {
+		/* disable WA/WM WDT */
+		mt76_clear(dev, MT_WFDMA0_MCU_HOST_INT_ENA,
+			   MT_MCU_CMD_WDT_MASK);
+
+		if (READ_ONCE(dev->recovery.state) & MT_MCU_CMD_WA_WDT)
+			dev->recovery.wa_reset_count++;
+		else
+			dev->recovery.wm_reset_count++;
+
+		mt7996_mac_full_reset(dev);
+
+		/* enable mcu irq */
+		mt7996_irq_enable(dev, MT_INT_MCU_CMD);
+		mt7996_irq_disable(dev, 0);
+
+		/* enable WA/WM WDT */
+		mt76_set(dev, MT_WFDMA0_MCU_HOST_INT_ENA, MT_MCU_CMD_WDT_MASK);
+
+		dev->recovery.state = MT_MCU_CMD_NORMAL_STATE;
+		dev->recovery.restart = false;
 		return;
+	}
 
+	if (!(READ_ONCE(dev->recovery.state) & MT_MCU_CMD_STOP_DMA))
+		return;
+
+	dev_info(dev->mt76.dev,"\n%s L1 SER recovery start.",
+		 wiphy_name(dev->mt76.hw->wiphy));
 	ieee80211_stop_queues(mt76_hw(dev));
 	if (phy2)
 		ieee80211_stop_queues(phy2->mt76->hw);
@@ -1858,7 +2024,7 @@ void mt7996_mac_reset_work(struct work_struct *work)
 	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_STOPPED);
 
 	if (mt7996_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
-		mt7996_dma_reset(dev);
+		mt7996_dma_reset(dev, false);
 
 		mt7996_tx_token_put(dev);
 		idr_init(&dev->mt76.token);
@@ -1913,6 +2079,32 @@ void mt7996_mac_reset_work(struct work_struct *work)
 		ieee80211_queue_delayed_work(phy3->mt76->hw,
 					     &phy3->mt76->mac_work,
 					     MT7996_WATCHDOG_TIME);
+	dev_info(dev->mt76.dev,"\n%s L1 SER recovery completed.",
+		 wiphy_name(dev->mt76.hw->wiphy));
+}
+
+void mt7996_reset(struct mt7996_dev *dev)
+{
+	if (!dev->recovery.hw_init_done)
+		return;
+
+	if (dev->recovery.hw_full_reset)
+		return;
+
+	/* wm/wa exception: do full recovery */
+	if (READ_ONCE(dev->recovery.state) & MT_MCU_CMD_WDT_MASK) {
+		dev->recovery.restart = true;
+		dev_info(dev->mt76.dev,
+			 "%s indicated firmware crash, attempting recovery\n",
+			 wiphy_name(dev->mt76.hw->wiphy));
+
+		mt7996_irq_disable(dev, MT_INT_MCU_CMD);
+		queue_work(dev->mt76.wq, &dev->reset_work);
+		return;
+	}
+
+	queue_work(dev->mt76.wq, &dev->reset_work);
+	wake_up(&dev->reset_wait);
 }
 
 void mt7996_mac_update_stats(struct mt7996_phy *phy)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 3e4da0350d96..67d02d30456e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -22,17 +22,13 @@ static bool mt7996_dev_running(struct mt7996_dev *dev)
 	return phy && test_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 }
 
-static int mt7996_start(struct ieee80211_hw *hw)
+int mt7996_run(struct ieee80211_hw *hw)
 {
 	struct mt7996_dev *dev = mt7996_hw_dev(hw);
 	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	bool running;
 	int ret;
 
-	flush_work(&dev->init_work);
-
-	mutex_lock(&dev->mt76.mutex);
-
 	running = mt7996_dev_running(dev);
 	if (!running) {
 		ret = mt7996_mcu_set_hdr_trans(dev, true);
@@ -63,6 +59,18 @@ static int mt7996_start(struct ieee80211_hw *hw)
 		mt7996_mac_reset_counters(phy);
 
 out:
+	return ret;
+}
+
+static int mt7996_start(struct ieee80211_hw *hw)
+{
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	int ret;
+
+	flush_work(&dev->init_work);
+
+	mutex_lock(&dev->mt76.mutex);
+	ret = mt7996_run(hw);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 8ad51cbfdbe8..a48522025867 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2523,17 +2523,10 @@ mt7996_mcu_init_rx_airtime(struct mt7996_dev *dev)
 				     MCU_WM_UNI_CMD(VOW), true);
 }
 
-int mt7996_mcu_init(struct mt7996_dev *dev)
+int mt7996_mcu_init_firmware(struct mt7996_dev *dev)
 {
-	static const struct mt76_mcu_ops mt7996_mcu_ops = {
-		.headroom = sizeof(struct mt76_connac2_mcu_txd), /* reuse */
-		.mcu_skb_send_msg = mt7996_mcu_send_message,
-		.mcu_parse_response = mt7996_mcu_parse_response,
-	};
 	int ret;
 
-	dev->mt76.mcu_ops = &mt7996_mcu_ops;
-
 	/* force firmware operation mode into normal state,
 	 * which should be set before firmware download stage.
 	 */
@@ -2574,6 +2567,19 @@ int mt7996_mcu_init(struct mt7996_dev *dev)
 				 MCU_WA_PARAM_RED, 0, 0);
 }
 
+int mt7996_mcu_init(struct mt7996_dev *dev)
+{
+	static const struct mt76_mcu_ops mt7996_mcu_ops = {
+		.headroom = sizeof(struct mt76_connac2_mcu_txd), /* reuse */
+		.mcu_skb_send_msg = mt7996_mcu_send_message,
+		.mcu_parse_response = mt7996_mcu_parse_response,
+	};
+
+	dev->mt76.mcu_ops = &mt7996_mcu_ops;
+
+	return mt7996_mcu_init_firmware(dev);
+}
+
 void mt7996_mcu_exit(struct mt7996_dev *dev)
 {
 	mt7996_mcu_restart(&dev->mt76);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 902370a2a639..536e8dd0edca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -289,10 +289,9 @@ static void mt7996_irq_tasklet(struct tasklet_struct *t)
 		u32 val = mt76_rr(dev, MT_MCU_CMD);
 
 		mt76_wr(dev, MT_MCU_CMD, val);
-		if (val & MT_MCU_CMD_ERROR_MASK) {
-			dev->reset_state = val;
-			ieee80211_queue_work(mt76_hw(dev), &dev->reset_work);
-			wake_up(&dev->reset_wait);
+		if (val & (MT_MCU_CMD_ERROR_MASK | MT_MCU_CMD_WDT_MASK)) {
+			dev->recovery.state = val;
+			mt7996_reset(dev);
 		}
 	}
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 018dfd2b36b0..45071f0dc2fe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -253,7 +253,14 @@ struct mt7996_dev {
 	struct work_struct rc_work;
 	struct work_struct reset_work;
 	wait_queue_head_t reset_wait;
-	u32 reset_state;
+	struct {
+		u32 state;
+		u32 wa_reset_count;
+		u32 wm_reset_count;
+		bool hw_full_reset:1;
+		bool hw_init_done:1;
+		bool restart:1;
+	} recovery;
 
 	struct list_head sta_rc_list;
 	struct list_head sta_poll_list;
@@ -386,9 +393,16 @@ int mt7996_eeprom_get_target_power(struct mt7996_dev *dev,
 				   struct ieee80211_channel *chan);
 s8 mt7996_eeprom_get_power_delta(struct mt7996_dev *dev, int band);
 int mt7996_dma_init(struct mt7996_dev *dev);
+void mt7996_dma_reset(struct mt7996_dev *dev, bool force);
 void mt7996_dma_prefetch(struct mt7996_dev *dev);
 void mt7996_dma_cleanup(struct mt7996_dev *dev);
+void mt7996_init_txpower(struct mt7996_dev *dev,
+			 struct ieee80211_supported_band *sband);
+int mt7996_txbf_init(struct mt7996_dev *dev);
+void mt7996_reset(struct mt7996_dev *dev);
+int mt7996_run(struct ieee80211_hw *hw);
 int mt7996_mcu_init(struct mt7996_dev *dev);
+int mt7996_mcu_init_firmware(struct mt7996_dev *dev);
 int mt7996_mcu_twt_agrt_update(struct mt7996_dev *dev,
 			       struct mt7996_vif *mvif,
 			       struct mt7996_twt_flow *flow,
@@ -479,6 +493,7 @@ static inline void mt7996_irq_disable(struct mt7996_dev *dev, u32 mask)
 		mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
 }
 
+void mt7996_mac_init(struct mt7996_dev *dev);
 u32 mt7996_mac_wtbl_lmac_addr(struct mt7996_dev *dev, u16 wcid, u8 dw);
 bool mt7996_mac_wtbl_update(struct mt7996_dev *dev, int idx, u32 mask);
 void mt7996_mac_reset_counters(struct mt7996_phy *phy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
index 7a28cae34e34..5ba74b49d65d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/regs.h
@@ -317,6 +317,8 @@ enum base_rev {
 #define MT_WFDMA0_RX_INT_PCIE_SEL		MT_WFDMA0(0x154)
 #define MT_WFDMA0_RX_INT_SEL_RING3		BIT(3)
 
+#define MT_WFDMA0_MCU_HOST_INT_ENA		MT_WFDMA0(0x1f4)
+
 #define MT_WFDMA0_GLO_CFG			MT_WFDMA0(0x208)
 #define MT_WFDMA0_GLO_CFG_TX_DMA_EN		BIT(0)
 #define MT_WFDMA0_GLO_CFG_RX_DMA_EN		BIT(2)
@@ -444,6 +446,10 @@ enum base_rev {
 #define MT_MCU_CMD_NORMAL_STATE			BIT(5)
 #define MT_MCU_CMD_ERROR_MASK			GENMASK(5, 1)
 
+#define MT_MCU_CMD_WA_WDT			BIT(31)
+#define MT_MCU_CMD_WM_WDT			BIT(30)
+#define MT_MCU_CMD_WDT_MASK			GENMASK(31, 30)
+
 /* l1/l2 remap */
 #define MT_HIF_REMAP_L1				0x155024
 #define MT_HIF_REMAP_L1_MASK			GENMASK(31, 16)
@@ -468,7 +474,10 @@ enum base_rev {
 #define MT_INFRA_MCU_END			0x7c3fffff
 
 /* FW MODE SYNC */
-#define MT_SWDEF_MODE				0x9143c
+#define MT_SWDEF_BASE				0x00401400
+
+#define MT_SWDEF(ofs)				(MT_SWDEF_BASE + (ofs))
+#define MT_SWDEF_MODE				MT_SWDEF(0x3c)
 #define MT_SWDEF_NORMAL_MODE			0
 
 /* LED */
@@ -506,7 +515,7 @@ enum base_rev {
 #define MT_TOP_MISC_FW_STATE			GENMASK(2, 0)
 
 #define MT_HW_REV				0x70010204
-#define MT_WF_SUBSYS_RST			0x70002600
+#define MT_WF_SUBSYS_RST			0x70028600
 
 /* PCIE MAC */
 #define MT_PCIE_MAC_BASE			0x74030000
-- 
2.18.0

