Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A33F614F205
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 19:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgAaSRL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 13:17:11 -0500
Received: from nbd.name ([46.4.11.11]:59406 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgAaSRL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 13:17:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=022cjndfusktEnAtwNv7KPkrKvPAzM6MYI7iRQTgQ44=; b=kGRNMnO5Rw3PRKtksqP6wKDxKc
        FpuqhHuXKLJGnj/6byjf8CowiQwIXZxHopNCWb06bokiQ9yiveXgX7hqdNh+HrReHU2ZGKDQYmd7Z
        W2tm3btoQxxWNHbXTJJHaSSDGwab0AugVAcJTH9S5wRV9PcpR1zzsr232XIC8npn7khM=;
Received: from [80.255.7.125] (helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ixaqr-0001G4-BY
        for linux-wireless@vger.kernel.org; Fri, 31 Jan 2020 19:17:09 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 66E857AFF3AC; Fri, 31 Jan 2020 19:17:08 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: mt7615: implement hardware reset support
Date:   Fri, 31 Jan 2020 19:17:07 +0100
Message-Id: <20200131181708.62698-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When the firmware detects a problem, it needs the host to stop/reset DMA and
resume it again when the hardware state has been reset.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mcu.c      |   3 +-
 drivers/net/wireless/mediatek/mt76/mt76.h     |   1 +
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |   3 +-
 .../net/wireless/mediatek/mt76/mt7615/init.c  |   2 +
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 125 ++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |  10 ++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |   6 +
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  23 ++++
 8 files changed, 171 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mcu.c b/drivers/net/wireless/mediatek/mt76/mcu.c
index 2a976688804d..b0fb0830c9e1 100644
--- a/drivers/net/wireless/mediatek/mt76/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mcu.c
@@ -35,7 +35,8 @@ struct sk_buff *mt76_mcu_get_response(struct mt76_dev *dev,
 
 	timeout = expires - jiffies;
 	wait_event_timeout(dev->mmio.mcu.wait,
-			   !skb_queue_empty(&dev->mmio.mcu.res_q),
+			   (!skb_queue_empty(&dev->mmio.mcu.res_q) ||
+			    test_bit(MT76_MCU_RESET, &dev->phy.state)),
 			   timeout);
 	return skb_dequeue(&dev->mmio.mcu.res_q);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 560f9ec9c39c..0956785ad6f8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -274,6 +274,7 @@ enum {
 	MT76_STATE_MCU_RUNNING,
 	MT76_SCANNING,
 	MT76_RESET,
+	MT76_MCU_RESET,
 	MT76_REMOVED,
 	MT76_READING_STATS,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index aeccb35e14f3..1bc71f5081ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -265,7 +265,8 @@ int mt7615_dma_init(struct mt7615_dev *dev)
 		 MT_WPDMA_GLO_CFG_RX_DMA_EN);
 
 	/* enable interrupts for TX/RX rings */
-	mt7615_irq_enable(dev, MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL);
+	mt7615_irq_enable(dev, MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
+			       MT_INT_MCU_CMD);
 
 	if (is_mt7622(&dev->mt76))
 		mt7622_dma_sched_init(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 2f6ad2b24464..e7f251957fca 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -447,6 +447,8 @@ int mt7615_register_device(struct mt7615_dev *dev)
 	INIT_DELAYED_WORK(&dev->mt76.mac_work, mt7615_mac_work);
 	INIT_LIST_HEAD(&dev->sta_poll_list);
 	spin_lock_init(&dev->sta_poll_lock);
+	init_waitqueue_head(&dev->reset_wait);
+	INIT_WORK(&dev->reset_work, mt7615_mac_reset_work);
 
 	ret = mt7622_wmac_init(dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index c4fea7227cee..f98ae0be1b03 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1782,6 +1782,131 @@ void mt7615_mac_work(struct work_struct *work)
 				     MT7615_WATCHDOG_TIME);
 }
 
+static bool
+mt7615_wait_reset_state(struct mt7615_dev *dev, u32 state)
+{
+	bool ret;
+
+	ret = wait_event_timeout(dev->reset_wait,
+				 (READ_ONCE(dev->reset_state) & state),
+				 MT7615_RESET_TIMEOUT);
+	WARN(!ret, "Timeout waiting for MCU reset state %x\n", state);
+	return ret;
+}
+
+static void
+mt7615_update_vif_beacon(void *priv, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct ieee80211_hw *hw = priv;
+
+	mt7615_mcu_set_bcn(hw, vif, vif->bss_conf.enable_beacon);
+}
+
+static void
+mt7615_update_beacons(struct mt7615_dev *dev)
+{
+	ieee80211_iterate_active_interfaces(dev->mt76.hw,
+		IEEE80211_IFACE_ITER_RESUME_ALL,
+		mt7615_update_vif_beacon, dev->mt76.hw);
+
+	if (!dev->mt76.phy2)
+		return;
+
+	ieee80211_iterate_active_interfaces(dev->mt76.phy2->hw,
+		IEEE80211_IFACE_ITER_RESUME_ALL,
+		mt7615_update_vif_beacon, dev->mt76.phy2->hw);
+}
+
+static void
+mt7615_dma_reset(struct mt7615_dev *dev)
+{
+	int i;
+
+	mt76_clear(dev, MT_WPDMA_GLO_CFG,
+		   MT_WPDMA_GLO_CFG_RX_DMA_EN | MT_WPDMA_GLO_CFG_TX_DMA_EN |
+		   MT_WPDMA_GLO_CFG_TX_WRITEBACK_DONE);
+	usleep_range(1000, 2000);
+
+	for (i = 0; i < __MT_TXQ_MAX; i++)
+		mt76_queue_tx_cleanup(dev, i, true);
+
+	for (i = 0; i < ARRAY_SIZE(dev->mt76.q_rx); i++)
+		mt76_queue_rx_reset(dev, i);
+
+	mt76_set(dev, MT_WPDMA_GLO_CFG,
+		 MT_WPDMA_GLO_CFG_RX_DMA_EN | MT_WPDMA_GLO_CFG_TX_DMA_EN |
+		 MT_WPDMA_GLO_CFG_TX_WRITEBACK_DONE);
+}
+
+void mt7615_mac_reset_work(struct work_struct *work)
+{
+	struct mt7615_dev *dev;
+
+	dev = container_of(work, struct mt7615_dev, reset_work);
+
+	if (!(READ_ONCE(dev->reset_state) & MT_MCU_CMD_STOP_PDMA))
+		return;
+
+	ieee80211_stop_queues(mt76_hw(dev));
+	if (dev->mt76.phy2)
+		ieee80211_stop_queues(dev->mt76.phy2->hw);
+
+	set_bit(MT76_RESET, &dev->mphy.state);
+	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+	wake_up(&dev->mt76.mmio.mcu.wait);
+	cancel_delayed_work_sync(&dev->mt76.mac_work);
+
+	/* lock/unlock all queues to ensure that no tx is pending */
+	mt76_txq_schedule_all(&dev->mphy);
+	if (dev->mt76.phy2)
+		mt76_txq_schedule_all(dev->mt76.phy2);
+
+	tasklet_disable(&dev->mt76.tx_tasklet);
+	napi_disable(&dev->mt76.napi[0]);
+	napi_disable(&dev->mt76.napi[1]);
+	napi_disable(&dev->mt76.tx_napi);
+
+	mutex_lock(&dev->mt76.mutex);
+
+	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_PDMA_STOPPED);
+
+	if (mt7615_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
+		mt7615_dma_reset(dev);
+
+		mt76_wr(dev, MT_WPDMA_MEM_RNG_ERR, 0);
+
+		mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_PDMA_INIT);
+		mt7615_wait_reset_state(dev, MT_MCU_CMD_RECOVERY_DONE);
+	}
+
+	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
+	clear_bit(MT76_RESET, &dev->mphy.state);
+
+	tasklet_enable(&dev->mt76.tx_tasklet);
+	napi_enable(&dev->mt76.tx_napi);
+	napi_schedule(&dev->mt76.tx_napi);
+
+	napi_enable(&dev->mt76.napi[0]);
+	napi_schedule(&dev->mt76.napi[0]);
+
+	napi_enable(&dev->mt76.napi[1]);
+	napi_schedule(&dev->mt76.napi[1]);
+
+	ieee80211_wake_queues(mt76_hw(dev));
+	if (dev->mt76.phy2)
+		ieee80211_wake_queues(dev->mt76.phy2->hw);
+
+	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_RESET_DONE);
+	mt7615_wait_reset_state(dev, MT_MCU_CMD_NORMAL_STATE);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	mt7615_update_beacons(dev);
+
+	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
+				     MT7615_WATCHDOG_TIME);
+}
+
 static void mt7615_dfs_stop_radar_detector(struct mt7615_phy *phy)
 {
 	struct mt7615_dev *dev = phy->dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index fcd8a8b4e816..0b445471b6e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -53,6 +53,16 @@ static irqreturn_t mt7615_irq_handler(int irq, void *dev_instance)
 		napi_schedule(&dev->mt76.napi[1]);
 	}
 
+	if (intr & MT_INT_MCU_CMD) {
+		u32 val = mt76_rr(dev, MT_MCU_CMD);
+
+		if (val & MT_MCU_CMD_ERROR_MASK) {
+			dev->reset_state = val;
+			ieee80211_queue_work(mt76_hw(dev), &dev->reset_work);
+			wake_up(&dev->reset_wait);
+		}
+	}
+
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index b4748cf079b1..95973e49c4a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -18,6 +18,7 @@
 					 MT7615_MAX_INTERFACES)
 
 #define MT7615_WATCHDOG_TIME		(HZ / 10)
+#define MT7615_RESET_TIMEOUT		(30 * HZ)
 #define MT7615_RATE_RETRY		2
 
 #define MT7615_TX_RING_SIZE		1024
@@ -156,6 +157,10 @@ struct mt7615_dev {
 
 	struct work_struct mcu_work;
 
+	struct work_struct reset_work;
+	wait_queue_head_t reset_wait;
+	u32 reset_state;
+
 	struct list_head sta_poll_list;
 	spinlock_t sta_poll_lock;
 
@@ -352,6 +357,7 @@ void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb);
 int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 			    struct ieee80211_key_conf *key,
 			    enum set_key_cmd cmd);
+void mt7615_mac_reset_work(struct work_struct *work);
 
 int mt7615_mcu_set_dbdc(struct mt7615_dev *dev);
 int mt7615_mcu_set_eeprom(struct mt7615_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index abecb3bfbc4b..fe68f6b2cbf8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -35,6 +35,12 @@
 #define MT_CFG_LPCR_HOST_FW_OWN		BIT(0)
 #define MT_CFG_LPCR_HOST_DRV_OWN	BIT(1)
 
+#define MT_MCU_INT_EVENT		MT_HIF(0x1f8)
+#define MT_MCU_INT_EVENT_PDMA_STOPPED	BIT(0)
+#define MT_MCU_INT_EVENT_PDMA_INIT	BIT(1)
+#define MT_MCU_INT_EVENT_SER_TRIGGER	BIT(2)
+#define MT_MCU_INT_EVENT_RESET_DONE	BIT(3)
+
 #define MT_INT_SOURCE_CSR		MT_HIF(0x200)
 #define MT_INT_MASK_CSR			MT_HIF(0x204)
 #define MT_DELAY_INT_CFG		MT_HIF(0x210)
@@ -43,6 +49,7 @@
 #define MT_INT_RX_DONE_ALL		GENMASK(1, 0)
 #define MT_INT_TX_DONE_ALL		GENMASK(19, 4)
 #define MT_INT_TX_DONE(_n)		BIT((_n) + 4)
+#define MT_INT_MCU_CMD			BIT(30)
 
 #define MT_WPDMA_GLO_CFG		MT_HIF(0x208)
 #define MT_WPDMA_GLO_CFG_TX_DMA_EN	BIT(0)
@@ -63,6 +70,22 @@
 
 #define MT_WPDMA_RST_IDX		MT_HIF(0x20c)
 
+#define MT_WPDMA_MEM_RNG_ERR		MT_HIF(0x224)
+
+#define MT_MCU_CMD			MT_HIF(0x234)
+#define MT_MCU_CMD_CLEAR_FW_OWN		BIT(0)
+#define MT_MCU_CMD_STOP_PDMA_FW_RELOAD	BIT(1)
+#define MT_MCU_CMD_STOP_PDMA		BIT(2)
+#define MT_MCU_CMD_RESET_DONE		BIT(3)
+#define MT_MCU_CMD_RECOVERY_DONE	BIT(4)
+#define MT_MCU_CMD_NORMAL_STATE		BIT(5)
+#define MT_MCU_CMD_LMAC_ERROR		BIT(24)
+#define MT_MCU_CMD_PSE_ERROR		BIT(25)
+#define MT_MCU_CMD_PLE_ERROR		BIT(26)
+#define MT_MCU_CMD_PDMA_ERROR		BIT(27)
+#define MT_MCU_CMD_PCIE_ERROR		BIT(28)
+#define MT_MCU_CMD_ERROR_MASK		(GENMASK(5, 1) | GENMASK(28, 24))
+
 #define MT_TX_RING_BASE			MT_HIF(0x300)
 #define MT_RX_RING_BASE			MT_HIF(0x400)
 
-- 
2.24.0

