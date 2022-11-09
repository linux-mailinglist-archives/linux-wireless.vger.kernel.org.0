Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C6E6234B3
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 21:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiKIUgx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Nov 2022 15:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiKIUgw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Nov 2022 15:36:52 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC692C653
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 12:36:44 -0800 (PST)
X-UUID: 9ab3e52ca84e4fdd86b95b7d893922d2-20221110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Z+qII7YlWMqDqcT0NOUKoxtvoASrdk9RSBdx6300LPo=;
        b=Hdafb5i6b2f3efL1nhVQhx65RhtmdC6s6xQO4ygwahYfoTGM6LGtfp6t2hMkQsLcuGbPTvgIHUkRyDStzO6P9qLBALQFyCZaaUjzv6gZTglU9NupnsGkHHQj2X2cA6RhcgIz2DR9dmHPt6bePknLlfzoSD8GdZZn8WSkGUogMYo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:a43bf51d-9db3-456a-b366-e7a808660abc,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:62cd327,CLOUDID:191a185d-100c-4555-952b-a62c895efded,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 9ab3e52ca84e4fdd86b95b7d893922d2-20221110
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1318535957; Thu, 10 Nov 2022 04:36:36 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 10 Nov 2022 04:36:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 10 Nov 2022 04:36:35 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v3 2/4] wifi: mt76: mt7915: enable full system reset support
Date:   Thu, 10 Nov 2022 04:36:32 +0800
Message-ID: <e8f7b70d0d119234917bd79c16c41f79c222e8f8.1668024217.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <3e6ef9fb1d2e09d415b4c489cc9c62134a05b3c1.1668024217.git.ryder.lee@mediatek.com>
References: <3e6ef9fb1d2e09d415b4c489cc9c62134a05b3c1.1668024217.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <bo.jiao@mediatek.com>

Add mt7915_reset() and refactor mt7915_mac_reset_work() to support
full system recovery.

Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Bo Jiao <bo.jiao@mediatek.com>
---
change since v2 - change dev_info to make it easier to see that firmware crashed while looking at dmesg.
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  11 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 214 +++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  18 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  24 +-
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |   7 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  15 +-
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |   4 +
 7 files changed, 267 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 324db5291c85..1f39aa3e3f3d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -262,9 +262,8 @@ static void mt7915_led_set_brightness(struct led_classdev *led_cdev,
 		mt7915_led_set_config(led_cdev, 0xff, 0);
 }
 
-static void
-mt7915_init_txpower(struct mt7915_dev *dev,
-		    struct ieee80211_supported_band *sband)
+void mt7915_init_txpower(struct mt7915_dev *dev,
+			 struct ieee80211_supported_band *sband)
 {
 	int i, n_chains = hweight8(dev->mphy.antenna_mask);
 	int nss_delta = mt76_tx_power_nss_delta(n_chains);
@@ -446,7 +445,7 @@ mt7915_mac_init_band(struct mt7915_dev *dev, u8 band)
 	mt76_clear(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN);
 }
 
-static void mt7915_mac_init(struct mt7915_dev *dev)
+void mt7915_mac_init(struct mt7915_dev *dev)
 {
 	int i;
 	u32 rx_len = is_mt7915(&dev->mt76) ? 0x400 : 0x680;
@@ -476,7 +475,7 @@ static void mt7915_mac_init(struct mt7915_dev *dev)
 	}
 }
 
-static int mt7915_txbf_init(struct mt7915_dev *dev)
+int mt7915_txbf_init(struct mt7915_dev *dev)
 {
 	int ret;
 
@@ -1117,6 +1116,8 @@ int mt7915_register_device(struct mt7915_dev *dev)
 			goto unreg_thermal;
 	}
 
+	dev->recovery.hw_init_done = true;
+
 	mt7915_init_debugfs(&dev->phy);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 3b1259f14de6..69ce3b39aa53 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1265,7 +1265,7 @@ mt7915_wait_reset_state(struct mt7915_dev *dev, u32 state)
 	bool ret;
 
 	ret = wait_event_timeout(dev->reset_wait,
-				 (READ_ONCE(dev->reset_state) & state),
+				 (READ_ONCE(dev->recovery.state) & state),
 				 MT7915_RESET_TIMEOUT);
 
 	WARN(!ret, "Timeout waiting for MCU reset state %x\n", state);
@@ -1320,6 +1320,171 @@ void mt7915_tx_token_put(struct mt7915_dev *dev)
 	idr_destroy(&dev->mt76.token);
 }
 
+static int
+mt7915_mac_restart(struct mt7915_dev *dev)
+{
+	struct mt7915_phy *phy2;
+	struct mt76_phy *ext_phy;
+	struct mt76_dev *mdev = &dev->mt76;
+	int i, ret;
+	u32 irq_mask;
+
+	ext_phy = dev->mt76.phys[MT_BAND1];
+	phy2 = ext_phy ? ext_phy->priv : NULL;
+
+	if (dev->hif2) {
+		mt76_wr(dev, MT_INT1_MASK_CSR, 0x0);
+		mt76_wr(dev, MT_INT1_SOURCE_CSR, ~0);
+	}
+
+	if (dev_is_pci(mdev->dev)) {
+		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
+		if (dev->hif2)
+			mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0x0);
+	}
+
+	set_bit(MT76_RESET, &dev->mphy.state);
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+	wake_up(&dev->mt76.mcu.wait);
+	if (ext_phy) {
+		set_bit(MT76_RESET, &ext_phy->state);
+		set_bit(MT76_MCU_RESET, &ext_phy->state);
+	}
+
+	/* lock/unlock all queues to ensure that no tx is pending */
+	mt76_txq_schedule_all(&dev->mphy);
+	if (ext_phy)
+		mt76_txq_schedule_all(ext_phy);
+
+	/* disable all tx/rx napi */
+	mt76_worker_disable(&dev->mt76.tx_worker);
+	mt76_for_each_q_rx(mdev, i) {
+		if (mdev->q_rx[i].ndesc)
+			napi_disable(&dev->mt76.napi[i]);
+	}
+	napi_disable(&dev->mt76.tx_napi);
+
+	/* token reinit */
+	mt7915_tx_token_put(dev);
+	idr_init(&dev->mt76.token);
+
+	mt7915_dma_reset(dev, true);
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
+
+	if (dev->hif2) {
+		mt76_wr(dev, MT_INT1_MASK_CSR, irq_mask);
+		mt76_wr(dev, MT_INT1_SOURCE_CSR, ~0);
+	}
+	if (dev_is_pci(mdev->dev)) {
+		mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+		if (dev->hif2)
+			mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0xff);
+	}
+
+	/* load firmware */
+	ret = mt7915_mcu_init_firmware(dev);
+	if (ret)
+		goto out;
+
+	/* set the necessary init items */
+	ret = mt7915_mcu_set_eeprom(dev);
+	if (ret)
+		goto out;
+
+	mt7915_mac_init(dev);
+	mt7915_init_txpower(dev, &dev->mphy.sband_2g.sband);
+	mt7915_init_txpower(dev, &dev->mphy.sband_5g.sband);
+	ret = mt7915_txbf_init(dev);
+
+	if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state)) {
+		ret = mt7915_run(dev->mphy.hw);
+		if (ret)
+			goto out;
+	}
+
+	if (ext_phy && test_bit(MT76_STATE_RUNNING, &ext_phy->state)) {
+		ret = mt7915_run(ext_phy->hw);
+		if (ret)
+			goto out;
+	}
+
+out:
+	/* reset done */
+	clear_bit(MT76_RESET, &dev->mphy.state);
+	if (phy2)
+		clear_bit(MT76_RESET, &phy2->mt76->state);
+
+	local_bh_disable();
+	napi_enable(&dev->mt76.tx_napi);
+	napi_schedule(&dev->mt76.tx_napi);
+	local_bh_enable();
+
+	mt76_worker_enable(&dev->mt76.tx_worker);
+
+	return ret;
+}
+
+static void
+mt7915_mac_full_reset(struct mt7915_dev *dev)
+{
+	struct mt7915_phy *phy2;
+	struct mt76_phy *ext_phy;
+	int i;
+
+	ext_phy = dev->mt76.phys[MT_BAND1];
+	phy2 = ext_phy ? ext_phy->priv : NULL;
+
+	dev->recovery.hw_full_reset = true;
+
+	wake_up(&dev->mt76.mcu.wait);
+	ieee80211_stop_queues(mt76_hw(dev));
+	if (ext_phy)
+		ieee80211_stop_queues(ext_phy->hw);
+
+	cancel_delayed_work_sync(&dev->mphy.mac_work);
+	if (ext_phy)
+		cancel_delayed_work_sync(&ext_phy->mac_work);
+
+	mutex_lock(&dev->mt76.mutex);
+	for (i = 0; i < 10; i++) {
+		if (!mt7915_mac_restart(dev))
+			break;
+	}
+	mutex_unlock(&dev->mt76.mutex);
+
+	if (i == 10)
+		dev_err(dev->mt76.dev, "chip full reset failed\n");
+
+	ieee80211_restart_hw(mt76_hw(dev));
+	if (ext_phy)
+		ieee80211_restart_hw(ext_phy->hw);
+
+	ieee80211_wake_queues(mt76_hw(dev));
+	if (ext_phy)
+		ieee80211_wake_queues(ext_phy->hw);
+
+	dev->recovery.hw_full_reset = false;
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mphy.mac_work,
+				     MT7915_WATCHDOG_TIME);
+	if (ext_phy)
+		ieee80211_queue_delayed_work(ext_phy->hw,
+					     &ext_phy->mac_work,
+					     MT7915_WATCHDOG_TIME);
+}
+
 /* system error recovery */
 void mt7915_mac_reset_work(struct work_struct *work)
 {
@@ -1332,7 +1497,28 @@ void mt7915_mac_reset_work(struct work_struct *work)
 	ext_phy = dev->mt76.phys[MT_BAND1];
 	phy2 = ext_phy ? ext_phy->priv : NULL;
 
-	if (!(READ_ONCE(dev->reset_state) & MT_MCU_CMD_STOP_DMA))
+	/* chip full reset */
+	if (dev->recovery.restart) {
+		/* disable WA/WM WDT */
+		mt76_clear(dev, MT_WFDMA0_MCU_HOST_INT_ENA,
+			   MT_MCU_CMD_WDT_MASK);
+
+		mt7915_mac_full_reset(dev);
+
+		/* enable mcu irq */
+		mt7915_irq_enable(dev, MT_INT_MCU_CMD);
+		mt7915_irq_disable(dev, 0);
+
+		/* enable WA/WM WDT */
+		mt76_set(dev, MT_WFDMA0_MCU_HOST_INT_ENA, MT_MCU_CMD_WDT_MASK);
+
+		dev->recovery.state = MT_MCU_CMD_NORMAL_STATE;
+		dev->recovery.restart = false;
+		return;
+	}
+
+	/* chip partial reset */
+	if (!(READ_ONCE(dev->recovery.state) & MT_MCU_CMD_STOP_DMA))
 		return;
 
 	ieee80211_stop_queues(mt76_hw(dev));
@@ -1406,6 +1592,30 @@ void mt7915_mac_reset_work(struct work_struct *work)
 					     MT7915_WATCHDOG_TIME);
 }
 
+void mt7915_reset(struct mt7915_dev *dev)
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
+		mt7915_irq_disable(dev, MT_INT_MCU_CMD);
+		queue_work(dev->mt76.wq, &dev->reset_work);
+		return;
+	}
+
+	queue_work(dev->mt76.wq, &dev->reset_work);
+	wake_up(&dev->reset_wait);
+}
+
 void mt7915_mac_update_stats(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 6de49b93387e..32c362965dc4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -20,17 +20,13 @@ static bool mt7915_dev_running(struct mt7915_dev *dev)
 	return phy && test_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 }
 
-static int mt7915_start(struct ieee80211_hw *hw)
+int mt7915_run(struct ieee80211_hw *hw)
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	bool running;
 	int ret;
 
-	flush_work(&dev->init_work);
-
-	mutex_lock(&dev->mt76.mutex);
-
 	running = mt7915_dev_running(dev);
 
 	if (!running) {
@@ -80,6 +76,18 @@ static int mt7915_start(struct ieee80211_hw *hw)
 		mt7915_mac_reset_counters(phy);
 
 out:
+	return ret;
+}
+
+static int mt7915_start(struct ieee80211_hw *hw)
+{
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+	int ret;
+
+	flush_work(&dev->init_work);
+
+	mutex_lock(&dev->mt76.mutex);
+	ret = mt7915_run(hw);
 	mutex_unlock(&dev->mt76.mutex);
 
 	return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 65ae959859e7..17fe29d8fd71 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2249,18 +2249,10 @@ mt7915_mcu_init_rx_airtime(struct mt7915_dev *dev)
 				 sizeof(req), true);
 }
 
-int mt7915_mcu_init(struct mt7915_dev *dev)
+int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
 {
-	static const struct mt76_mcu_ops mt7915_mcu_ops = {
-		.headroom = sizeof(struct mt76_connac2_mcu_txd),
-		.mcu_skb_send_msg = mt7915_mcu_send_message,
-		.mcu_parse_response = mt7915_mcu_parse_response,
-		.mcu_restart = mt76_connac_mcu_restart,
-	};
 	int ret;
 
-	dev->mt76.mcu_ops = &mt7915_mcu_ops;
-
 	/* force firmware operation mode into normal state,
 	 * which should be set before firmware download stage.
 	 */
@@ -2309,6 +2301,20 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 				 MCU_WA_PARAM_RED, 0, 0);
 }
 
+int mt7915_mcu_init(struct mt7915_dev *dev)
+{
+	static const struct mt76_mcu_ops mt7915_mcu_ops = {
+		.headroom = sizeof(struct mt76_connac2_mcu_txd),
+		.mcu_skb_send_msg = mt7915_mcu_send_message,
+		.mcu_parse_response = mt7915_mcu_parse_response,
+		.mcu_restart = mt76_connac_mcu_restart,
+	};
+
+	dev->mt76.mcu_ops = &mt7915_mcu_ops;
+
+	return mt7915_mcu_init_firmware(dev);
+}
+
 void mt7915_mcu_exit(struct mt7915_dev *dev)
 {
 	__mt76_mcu_restart(&dev->mt76);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index be1b8ea711c7..032af46289af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -746,10 +746,9 @@ static void mt7915_irq_tasklet(struct tasklet_struct *t)
 		u32 val = mt76_rr(dev, MT_MCU_CMD);
 
 		mt76_wr(dev, MT_MCU_CMD, val);
-		if (val & MT_MCU_CMD_ERROR_MASK) {
-			dev->reset_state = val;
-			queue_work(dev->mt76.wq, &dev->reset_work);
-			wake_up(&dev->reset_wait);
+		if (val & (MT_MCU_CMD_ERROR_MASK | MT_MCU_CMD_WDT_MASK)) {
+			dev->recovery.state = val;
+			mt7915_reset(dev);
 		}
 	}
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 5af26e60e902..49caf7b21a20 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -303,7 +303,13 @@ struct mt7915_dev {
 	struct work_struct rc_work;
 	struct work_struct reset_work;
 	wait_queue_head_t reset_wait;
-	u32 reset_state;
+
+	struct {
+		u32 state;
+		bool hw_full_reset:1;
+		bool hw_init_done:1;
+		bool restart:1;
+	} recovery;
 
 	struct list_head sta_rc_list;
 	struct list_head sta_poll_list;
@@ -444,7 +450,13 @@ int mt7915_dma_init(struct mt7915_dev *dev, struct mt7915_phy *phy2);
 void mt7915_dma_prefetch(struct mt7915_dev *dev);
 void mt7915_dma_cleanup(struct mt7915_dev *dev);
 int mt7915_dma_reset(struct mt7915_dev *dev, bool force);
+int mt7915_txbf_init(struct mt7915_dev *dev);
+void mt7915_init_txpower(struct mt7915_dev *dev,
+			 struct ieee80211_supported_band *sband);
+void mt7915_reset(struct mt7915_dev *dev);
+int mt7915_run(struct ieee80211_hw *hw);
 int mt7915_mcu_init(struct mt7915_dev *dev);
+int mt7915_mcu_init_firmware(struct mt7915_dev *dev);
 int mt7915_mcu_twt_agrt_update(struct mt7915_dev *dev,
 			       struct mt7915_vif *mvif,
 			       struct mt7915_twt_flow *flow,
@@ -544,6 +556,7 @@ static inline void mt7915_irq_disable(struct mt7915_dev *dev, u32 mask)
 		mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
 }
 
+void mt7915_mac_init(struct mt7915_dev *dev);
 u32 mt7915_mac_wtbl_lmac_addr(struct mt7915_dev *dev, u16 wcid, u8 dw);
 bool mt7915_mac_wtbl_update(struct mt7915_dev *dev, int idx, u32 mask);
 void mt7915_mac_reset_counters(struct mt7915_phy *phy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 5180dd931835..9120380d74c6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -541,6 +541,8 @@ enum offs_rev {
 #define MT_WFDMA0_BUSY_ENA_TX_FIFO1	BIT(1)
 #define MT_WFDMA0_BUSY_ENA_RX_FIFO	BIT(2)
 
+#define MT_WFDMA0_MCU_HOST_INT_ENA	MT_WFDMA0(0x1f4)
+
 #define MT_WFDMA0_GLO_CFG		MT_WFDMA0(0x208)
 #define MT_WFDMA0_GLO_CFG_TX_DMA_EN	BIT(0)
 #define MT_WFDMA0_GLO_CFG_RX_DMA_EN	BIT(2)
@@ -709,6 +711,8 @@ enum offs_rev {
 #define MT_MCU_CMD_NORMAL_STATE		BIT(5)
 #define MT_MCU_CMD_ERROR_MASK		GENMASK(5, 1)
 
+#define MT_MCU_CMD_WDT_MASK		GENMASK(31, 30)
+
 /* TOP RGU */
 #define MT_TOP_RGU_BASE			0x18000000
 #define MT_TOP_PWR_CTRL			(MT_TOP_RGU_BASE + (0x0))
-- 
2.36.1

