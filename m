Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A49D510DE0C
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfK3Pav (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:30:51 -0500
Received: from nbd.name ([46.4.11.11]:56078 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbfK3Pau (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rS0bkBHSGbwPl/WyLGj9BCmKgUBvZ/uiNFuljgXkKdM=; b=rGHvUlxMb0fCw8kxRHmGVi1H4d
        BHd2NS1Eh5YNXgpBDtN//AJAYRNq6f7PNlvMLOD+k/onWiQlij9r4YmcUsQEUctTgPuYbhKWWtBsZ
        o6sO0Cr4Rin0O9BS3hZBouvUxH5tX9xPlarahfuLoCBY6/7xlWEizspf5+sT6iYkxNVs=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hr-0006iS-S3
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:48 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 0DD4A721EBED; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 09/29] mt76: move state from struct mt76_dev to mt76_phy
Date:   Sat, 30 Nov 2019 16:30:25 +0100
Message-Id: <20191130153045.28105-9-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allows keeping per-wiphy state separate

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 16 +++++++-------
 drivers/net/wireless/mediatek/mt76/mt76.h     | 15 +++++++++----
 .../net/wireless/mediatek/mt76/mt7603/core.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  4 ++--
 .../net/wireless/mediatek/mt76/mt7603/main.c  |  8 +++----
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  4 ++--
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  8 +++----
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  4 ++--
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x0/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   |  8 +++----
 .../wireless/mediatek/mt76/mt76x0/pci_mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x0/phy.c   | 10 ++++-----
 .../net/wireless/mediatek/mt76/mt76x0/usb.c   | 14 ++++++------
 .../wireless/mediatek/mt76/mt76x0/usb_mcu.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_dfs.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  4 ++--
 .../net/wireless/mediatek/mt76/mt76x02_mac.h  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |  8 +++----
 .../wireless/mediatek/mt76/mt76x02_usb_core.c |  2 +-
 .../wireless/mediatek/mt76/mt76x02_usb_mcu.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_util.c |  2 +-
 .../wireless/mediatek/mt76/mt76x2/pci_init.c  |  2 +-
 .../wireless/mediatek/mt76/mt76x2/pci_main.c  | 10 ++++-----
 .../wireless/mediatek/mt76/mt76x2/pci_phy.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x2/usb.c   |  2 +-
 .../wireless/mediatek/mt76/mt76x2/usb_init.c  |  2 +-
 .../wireless/mediatek/mt76/mt76x2/usb_mac.c   |  2 +-
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  | 10 ++++-----
 .../wireless/mediatek/mt76/mt76x2/usb_phy.c   |  2 +-
 drivers/net/wireless/mediatek/mt76/tx.c       |  6 ++---
 drivers/net/wireless/mediatek/mt76/usb.c      | 22 +++++++++----------
 34 files changed, 97 insertions(+), 90 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index da2d072cd0ea..40a181c941c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -402,7 +402,10 @@ EXPORT_SYMBOL_GPL(mt76_free_device);
 
 void mt76_rx(struct mt76_dev *dev, enum mt76_rxq_id q, struct sk_buff *skb)
 {
-	if (!test_bit(MT76_STATE_RUNNING, &dev->state)) {
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	struct mt76_phy *phy = mt76_dev_phy(dev, status->ext_phy);
+
+	if (!test_bit(MT76_STATE_RUNNING, &phy->state)) {
 		dev_kfree_skb(skb);
 		return;
 	}
@@ -458,9 +461,6 @@ void mt76_update_survey(struct mt76_dev *dev)
 {
 	ktime_t cur_time;
 
-	if (!test_bit(MT76_STATE_RUNNING, &dev->state))
-		return;
-
 	if (dev->drv->update_survey)
 		dev->drv->update_survey(dev);
 
@@ -1062,17 +1062,17 @@ EXPORT_SYMBOL_GPL(mt76_get_rate);
 void mt76_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  const u8 *mac)
 {
-	struct mt76_dev *dev = hw->priv;
+	struct mt76_phy *phy = hw->priv;
 
-	set_bit(MT76_SCANNING, &dev->state);
+	set_bit(MT76_SCANNING, &phy->state);
 }
 EXPORT_SYMBOL_GPL(mt76_sw_scan);
 
 void mt76_sw_scan_complete(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
-	struct mt76_dev *dev = hw->priv;
+	struct mt76_phy *phy = hw->priv;
 
-	clear_bit(MT76_SCANNING, &dev->state);
+	clear_bit(MT76_SCANNING, &phy->state);
 }
 EXPORT_SYMBOL_GPL(mt76_sw_scan_complete);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index a522c7a5e294..441a9a81eb44 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -458,6 +458,8 @@ struct mt76_phy {
 	struct ieee80211_hw *hw;
 	struct mt76_dev *dev;
 
+	unsigned long state;
+
 	struct cfg80211_chan_def chandef;
 	struct ieee80211_channel *main_chan;
 
@@ -518,7 +520,6 @@ struct mt76_dev {
 
 	u8 macaddr[ETH_ALEN];
 	u32 rev;
-	unsigned long state;
 
 	u32 aggr_stats[32];
 
@@ -660,12 +661,18 @@ void mt76_seq_puts_array(struct seq_file *file, const char *str,
 int mt76_eeprom_init(struct mt76_dev *dev, int len);
 void mt76_eeprom_override(struct mt76_dev *dev);
 
+static inline struct mt76_phy *
+mt76_dev_phy(struct mt76_dev *dev, bool phy_ext)
+{
+	if (phy_ext && dev->phy2)
+		return dev->phy2;
+	return &dev->phy;
+}
+
 static inline struct ieee80211_hw *
 mt76_phy_hw(struct mt76_dev *dev, bool phy_ext)
 {
-	if (phy_ext && dev->phy2)
-		return dev->phy2->hw;
-	return dev->phy.hw;
+	return mt76_dev_phy(dev, phy_ext)->hw;
 }
 
 static inline u8 *
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/core.c b/drivers/net/wireless/mediatek/mt76/mt7603/core.c
index e5af4f3389cc..693a91be070a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/core.c
@@ -17,7 +17,7 @@ irqreturn_t mt7603_irq_handler(int irq, void *dev_instance)
 	intr = mt76_rr(dev, MT_INT_SOURCE_CSR);
 	mt76_wr(dev, MT_INT_SOURCE_CSR, intr);
 
-	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mt76.state))
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
 		return IRQ_NONE;
 
 	intr &= dev->mt76.mmio.irqmask;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 4fb0cf8e4f75..2ca07dd4db4b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -284,7 +284,7 @@ mt7603_init_hardware(struct mt7603_dev *dev)
 	mt76_wr(dev, MT_WPDMA_GLO_CFG, 0x52000850);
 	mt7603_mac_dma_start(dev);
 	dev->rxfilter = mt76_rr(dev, MT_WF_RFCR);
-	set_bit(MT76_STATE_INITIALIZED, &dev->mt76.state);
+	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 
 	for (i = 0; i < MT7603_WTBL_SIZE; i++) {
 		mt76_wr(dev, MT_PSE_RTA, MT_PSE_RTA_BUSY | MT_PSE_RTA_WRITE |
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 588b21694ea3..8a41bf118ed8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1389,7 +1389,7 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 	int i;
 
 	ieee80211_stop_queues(dev->mt76.hw);
-	set_bit(MT76_RESET, &dev->mt76.state);
+	set_bit(MT76_RESET, &dev->mphy.state);
 
 	/* lock/unlock all queues to ensure that no tx is pending */
 	mt76_txq_schedule_all(&dev->mphy);
@@ -1439,7 +1439,7 @@ static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 	mt7603_irq_enable(dev, mask);
 
 skip_dma_reset:
-	clear_bit(MT76_RESET, &dev->mt76.state);
+	clear_bit(MT76_RESET, &dev->mphy.state);
 	mutex_unlock(&dev->mt76.mutex);
 
 	tasklet_enable(&dev->mt76.tx_tasklet);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 2df06487f7fd..6da7caaaade1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -16,7 +16,7 @@ mt7603_start(struct ieee80211_hw *hw)
 	mt7603_mac_reset_counters(dev);
 	mt7603_mac_start(dev);
 	dev->mphy.survey_time = ktime_get_boottime();
-	set_bit(MT76_STATE_RUNNING, &dev->mt76.state);
+	set_bit(MT76_STATE_RUNNING, &dev->mphy.state);
 	mt7603_mac_work(&dev->mt76.mac_work.work);
 
 	return 0;
@@ -27,7 +27,7 @@ mt7603_stop(struct ieee80211_hw *hw)
 {
 	struct mt7603_dev *dev = hw->priv;
 
-	clear_bit(MT76_STATE_RUNNING, &dev->mt76.state);
+	clear_bit(MT76_STATE_RUNNING, &dev->mphy.state);
 	cancel_delayed_work_sync(&dev->mt76.mac_work);
 	mt7603_mac_stop(dev);
 }
@@ -143,7 +143,7 @@ mt7603_set_channel(struct mt7603_dev *dev, struct cfg80211_chan_def *def)
 	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 
 	mutex_lock(&dev->mt76.mutex);
-	set_bit(MT76_RESET, &dev->mt76.state);
+	set_bit(MT76_RESET, &dev->mphy.state);
 
 	mt7603_beacon_set_timer(dev, -1, 0);
 	mt76_set_channel(&dev->mphy);
@@ -176,7 +176,7 @@ mt7603_set_channel(struct mt7603_dev *dev, struct cfg80211_chan_def *def)
 	mt7603_mac_set_timing(dev);
 	mt7603_mac_start(dev);
 
-	clear_bit(MT76_RESET, &dev->mt76.state);
+	clear_bit(MT76_RESET, &dev->mphy.state);
 
 	mt76_txq_schedule_all(&dev->mphy);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 5b12cb4d2765..e071cafe80e4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -123,7 +123,7 @@ static int mt7615_init_hardware(struct mt7615_dev *dev)
 	if (ret)
 		return ret;
 
-	set_bit(MT76_STATE_INITIALIZED, &dev->mt76.state);
+	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 
 	ret = mt7615_mcu_init(dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 83a219d21d3a..727af49ca666 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -72,7 +72,7 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	bool unicast, remove_pad, insert_ccmp_hdr = false;
 	int i, idx;
 
-	if (!test_bit(MT76_STATE_RUNNING, &dev->mt76.state))
+	if (!test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
 		return -EINVAL;
 
 	memset(status, 0, sizeof(*status));
@@ -1485,7 +1485,7 @@ int mt7615_dfs_init_radar_detector(struct mt7615_dev *dev)
 	if (dev->mt76.region == NL80211_DFS_UNSET)
 		return 0;
 
-	if (test_bit(MT76_SCANNING, &dev->mt76.state))
+	if (test_bit(MT76_SCANNING, &dev->mphy.state))
 		return 0;
 
 	if (dev->dfs_state == chandef->chan->dfs_state)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 0f9fd859b597..cc5651a4441e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -19,7 +19,7 @@ static int mt7615_start(struct ieee80211_hw *hw)
 	mt7615_mac_reset_counters(dev);
 
 	dev->mphy.survey_time = ktime_get_boottime();
-	set_bit(MT76_STATE_RUNNING, &dev->mt76.state);
+	set_bit(MT76_STATE_RUNNING, &dev->mphy.state);
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
 				     MT7615_WATCHDOG_TIME);
 
@@ -30,7 +30,7 @@ static void mt7615_stop(struct ieee80211_hw *hw)
 {
 	struct mt7615_dev *dev = hw->priv;
 
-	clear_bit(MT76_STATE_RUNNING, &dev->mt76.state);
+	clear_bit(MT76_STATE_RUNNING, &dev->mphy.state);
 	cancel_delayed_work_sync(&dev->mt76.mac_work);
 }
 
@@ -151,7 +151,7 @@ static int mt7615_set_channel(struct mt7615_dev *dev)
 	cancel_delayed_work_sync(&dev->mt76.mac_work);
 
 	mutex_lock(&dev->mt76.mutex);
-	set_bit(MT76_RESET, &dev->mt76.state);
+	set_bit(MT76_RESET, &dev->mphy.state);
 
 	mt7615_dfs_check_channel(dev);
 
@@ -168,7 +168,7 @@ static int mt7615_set_channel(struct mt7615_dev *dev)
 	mt7615_mac_reset_counters(dev);
 
 out:
-	clear_bit(MT76_RESET, &dev->mt76.state);
+	clear_bit(MT76_RESET, &dev->mphy.state);
 	mutex_unlock(&dev->mt76.mutex);
 
 	mt76_txq_schedule_all(&dev->mphy);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index e6773d3bacfd..1aba10e6b5cb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -104,7 +104,7 @@ static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 	if (wait_seq)
 		*wait_seq = seq;
 
-	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mt76.state))
+	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state))
 		qid = MT_TXQ_MCU;
 	else
 		qid = MT_TXQ_FWDL;
@@ -561,7 +561,7 @@ int mt7615_mcu_init(struct mt7615_dev *dev)
 	if (ret)
 		return ret;
 
-	set_bit(MT76_STATE_MCU_RUNNING, &dev->mt76.state);
+	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index 1eb1eb659c3f..dd9ee80dbef7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -43,7 +43,7 @@ static irqreturn_t mt7615_irq_handler(int irq, void *dev_instance)
 	intr = mt76_rr(dev, MT_INT_SOURCE_CSR);
 	mt76_wr(dev, MT_INT_SOURCE_CSR, intr);
 
-	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mt76.state))
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
 		return IRQ_NONE;
 
 	intr &= dev->mt76.mmio.irqmask;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
index c2383bb48cfd..50b3bba19ddb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
@@ -46,7 +46,7 @@ int mt76x0_config(struct ieee80211_hw *hw, u32 changed)
 	if (changed & IEEE80211_CONF_CHANGE_POWER) {
 		dev->mt76.txpower_conf = hw->conf.power_level * 2;
 
-		if (test_bit(MT76_STATE_RUNNING, &dev->mt76.state))
+		if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
 			mt76x0_phy_set_txpower(dev);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index e2974e0ae1fc..88ff51400f8f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -20,7 +20,7 @@ static int mt76x0e_start(struct ieee80211_hw *hw)
 				     MT_MAC_WORK_INTERVAL);
 	ieee80211_queue_delayed_work(dev->mt76.hw, &dev->cal_work,
 				     MT_CALIBRATE_INTERVAL);
-	set_bit(MT76_STATE_RUNNING, &dev->mt76.state);
+	set_bit(MT76_STATE_RUNNING, &dev->mphy.state);
 
 	return 0;
 }
@@ -47,7 +47,7 @@ static void mt76x0e_stop(struct ieee80211_hw *hw)
 {
 	struct mt76x02_dev *dev = hw->priv;
 
-	clear_bit(MT76_STATE_RUNNING, &dev->mt76.state);
+	clear_bit(MT76_STATE_RUNNING, &dev->mphy.state);
 	mt76x0e_stop_hw(dev);
 }
 
@@ -124,7 +124,7 @@ static int mt76x0e_register_device(struct mt76x02_dev *dev)
 	if (err < 0)
 		return err;
 
-	set_bit(MT76_STATE_INITIALIZED, &dev->mt76.state);
+	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 
 	return 0;
 }
@@ -195,7 +195,7 @@ mt76x0e_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 static void mt76x0e_cleanup(struct mt76x02_dev *dev)
 {
-	clear_bit(MT76_STATE_INITIALIZED, &dev->mt76.state);
+	clear_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	mt76x0_chip_onoff(dev, false, false);
 	mt76x0e_stop_hw(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci_mcu.c
index 038187b390ce..007c762c6db1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci_mcu.c
@@ -126,7 +126,7 @@ int mt76x0e_mcu_init(struct mt76x02_dev *dev)
 	if (err < 0)
 		return err;
 
-	set_bit(MT76_STATE_MCU_RUNNING, &dev->mt76.state);
+	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
index 2502faa296fd..9b1ae77b8fd2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -23,7 +23,7 @@ mt76x0_rf_csr_wr(struct mt76x02_dev *dev, u32 offset, u8 value)
 	int ret = 0;
 	u8 bank, reg;
 
-	if (test_bit(MT76_REMOVED, &dev->mt76.state))
+	if (test_bit(MT76_REMOVED, &dev->mphy.state))
 		return -ENODEV;
 
 	bank = MT_RF_BANK(offset);
@@ -62,7 +62,7 @@ static int mt76x0_rf_csr_rr(struct mt76x02_dev *dev, u32 offset)
 	u32 val;
 	u8 bank, reg;
 
-	if (test_bit(MT76_REMOVED, &dev->mt76.state))
+	if (test_bit(MT76_REMOVED, &dev->mphy.state))
 		return -ENODEV;
 
 	bank = MT_RF_BANK(offset);
@@ -109,7 +109,7 @@ mt76x0_rf_wr(struct mt76x02_dev *dev, u32 offset, u8 val)
 		};
 
 		WARN_ON_ONCE(!test_bit(MT76_STATE_MCU_RUNNING,
-				       &dev->mt76.state));
+				       &dev->mphy.state));
 		return mt76_wr_rp(dev, MT_MCU_MEMMAP_RF, &pair, 1);
 	} else {
 		return mt76x0_rf_csr_wr(dev, offset, val);
@@ -127,7 +127,7 @@ static int mt76x0_rf_rr(struct mt76x02_dev *dev, u32 offset)
 		};
 
 		WARN_ON_ONCE(!test_bit(MT76_STATE_MCU_RUNNING,
-				       &dev->mt76.state));
+				       &dev->mphy.state));
 		ret = mt76_rd_rp(dev, MT_MCU_MEMMAP_RF, &pair, 1);
 		val = pair.value;
 	} else {
@@ -933,7 +933,7 @@ void mt76x0_phy_set_channel(struct mt76x02_dev *dev,
 		      FIELD_PREP(MT_EXT_CCA_CFG_CCA3, 0) |
 		      FIELD_PREP(MT_EXT_CCA_CFG_CCA_MASK, BIT(3)),
 	};
-	bool scan = test_bit(MT76_SCANNING, &dev->mt76.state);
+	bool scan = test_bit(MT76_SCANNING, &dev->mphy.state);
 	int ch_group_index, freq, freq1;
 	u8 channel;
 	u32 val;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
index 65ba9fc6ea0b..abf0a19ee70e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb.c
@@ -71,7 +71,7 @@ static void mt76x0_init_usb_dma(struct mt76x02_dev *dev)
 
 static void mt76x0u_cleanup(struct mt76x02_dev *dev)
 {
-	clear_bit(MT76_STATE_INITIALIZED, &dev->mt76.state);
+	clear_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 	mt76x0_chip_onoff(dev, false, false);
 	mt76u_queues_deinit(&dev->mt76);
 }
@@ -80,13 +80,13 @@ static void mt76x0u_stop(struct ieee80211_hw *hw)
 {
 	struct mt76x02_dev *dev = hw->priv;
 
-	clear_bit(MT76_STATE_RUNNING, &dev->mt76.state);
+	clear_bit(MT76_STATE_RUNNING, &dev->mphy.state);
 	cancel_delayed_work_sync(&dev->cal_work);
 	cancel_delayed_work_sync(&dev->mt76.mac_work);
 	mt76u_stop_tx(&dev->mt76);
 	mt76x02u_exit_beacon_config(dev);
 
-	if (test_bit(MT76_REMOVED, &dev->mt76.state))
+	if (test_bit(MT76_REMOVED, &dev->mphy.state))
 		return;
 
 	if (!mt76_poll(dev, MT_USB_DMA_CFG, MT_USB_DMA_CFG_TX_BUSY, 0, 1000))
@@ -112,7 +112,7 @@ static int mt76x0u_start(struct ieee80211_hw *hw)
 				     MT_MAC_WORK_INTERVAL);
 	ieee80211_queue_delayed_work(dev->mt76.hw, &dev->cal_work,
 				     MT_CALIBRATE_INTERVAL);
-	set_bit(MT76_STATE_RUNNING, &dev->mt76.state);
+	set_bit(MT76_STATE_RUNNING, &dev->mphy.state);
 	return 0;
 }
 
@@ -192,7 +192,7 @@ static int mt76x0u_register_device(struct mt76x02_dev *dev)
 	else
 		hw->max_tx_fragments = 1;
 
-	set_bit(MT76_STATE_INITIALIZED, &dev->mt76.state);
+	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 
 	return 0;
 
@@ -283,7 +283,7 @@ static int mt76x0u_probe(struct usb_interface *usb_intf,
 static void mt76x0_disconnect(struct usb_interface *usb_intf)
 {
 	struct mt76x02_dev *dev = usb_get_intfdata(usb_intf);
-	bool initialized = test_bit(MT76_STATE_INITIALIZED, &dev->mt76.state);
+	bool initialized = test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 
 	if (!initialized)
 		return;
@@ -304,7 +304,7 @@ static int __maybe_unused mt76x0_suspend(struct usb_interface *usb_intf,
 	struct mt76x02_dev *dev = usb_get_intfdata(usb_intf);
 
 	mt76u_stop_rx(&dev->mt76);
-	clear_bit(MT76_STATE_MCU_RUNNING, &dev->mt76.state);
+	clear_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
 	mt76x0_chip_onoff(dev, false, false);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c
index 888a930a5e08..45502fd4693f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c
@@ -168,7 +168,7 @@ int mt76x0u_mcu_init(struct mt76x02_dev *dev)
 	if (ret < 0)
 		return ret;
 
-	set_bit(MT76_STATE_MCU_RUNNING, &dev->mt76.state);
+	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
index f6cb2b6490a9..ff6a9e4daac0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_dfs.c
@@ -616,7 +616,7 @@ static void mt76x02_dfs_tasklet(unsigned long arg)
 	u32 engine_mask;
 	int i;
 
-	if (test_bit(MT76_SCANNING, &dev->mt76.state))
+	if (test_bit(MT76_SCANNING, &dev->mphy.state))
 		goto out;
 
 	if (time_is_before_jiffies(dfs_pd->last_sw_check +
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 965c93b6009b..8a4396941ef2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -775,7 +775,7 @@ int mt76x02_mac_process_rx(struct mt76x02_dev *dev, struct sk_buff *skb,
 	u8 wcid;
 	int len;
 
-	if (!test_bit(MT76_STATE_RUNNING, &dev->mt76.state))
+	if (!test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
 		return -EINVAL;
 
 	if (rxinfo & MT_RXINFO_L2PAD)
@@ -868,7 +868,7 @@ void mt76x02_mac_poll_tx_status(struct mt76x02_dev *dev, bool irq)
 	u8 update = 1;
 	bool ret;
 
-	if (!test_bit(MT76_STATE_RUNNING, &dev->mt76.state))
+	if (!test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
 		return;
 
 	trace_mac_txstat_poll(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
index 7d946aa77182..37445bc7b546 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
@@ -152,7 +152,7 @@ static inline bool mt76x02_wait_for_mac(struct mt76_dev *dev)
 	int i;
 
 	for (i = 0; i < 500; i++) {
-		if (test_bit(MT76_REMOVED, &dev->state))
+		if (test_bit(MT76_REMOVED, &dev->phy.state))
 			return false;
 
 		switch (dev->bus->rr(dev, MAC_CSR0)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 7d463f7bc87f..e7ba9bf82d98 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -261,7 +261,7 @@ irqreturn_t mt76x02_irq_handler(int irq, void *dev_instance)
 	intr = mt76_rr(dev, MT_INT_SOURCE_CSR);
 	mt76_wr(dev, MT_INT_SOURCE_CSR, intr);
 
-	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mt76.state))
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
 		return IRQ_NONE;
 
 	trace_dev_irq(dev, intr, dev->mt76.mmio.irqmask);
@@ -402,7 +402,7 @@ static void mt76x02_reset_state(struct mt76x02_dev *dev)
 
 	lockdep_assert_held(&dev->mt76.mutex);
 
-	clear_bit(MT76_STATE_RUNNING, &dev->mt76.state);
+	clear_bit(MT76_STATE_RUNNING, &dev->mphy.state);
 
 	rcu_read_lock();
 	ieee80211_iter_keys_rcu(dev->mt76.hw, NULL, mt76x02_key_sync, NULL);
@@ -441,7 +441,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 	int i;
 
 	ieee80211_stop_queues(dev->mt76.hw);
-	set_bit(MT76_RESET, &dev->mt76.state);
+	set_bit(MT76_RESET, &dev->mphy.state);
 
 	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	tasklet_disable(&dev->mt76.tx_tasklet);
@@ -496,7 +496,7 @@ static void mt76x02_watchdog_reset(struct mt76x02_dev *dev)
 
 	mutex_unlock(&dev->mt76.mutex);
 
-	clear_bit(MT76_RESET, &dev->mt76.state);
+	clear_bit(MT76_RESET, &dev->mphy.state);
 
 	tasklet_enable(&dev->mt76.tx_tasklet);
 	napi_enable(&dev->mt76.tx_napi);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index d03d3c8e296c..5cf015c1ef5d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -280,7 +280,7 @@ EXPORT_SYMBOL_GPL(mt76x02u_init_beacon_config);
 
 void mt76x02u_exit_beacon_config(struct mt76x02_dev *dev)
 {
-	if (!test_bit(MT76_REMOVED, &dev->mt76.state))
+	if (!test_bit(MT76_REMOVED, &dev->mphy.state))
 		mt76_clear(dev, MT_BEACON_TIME_CFG,
 			   MT_BEACON_TIME_CFG_TIMER_EN |
 			   MT_BEACON_TIME_CFG_SYNC_MODE |
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
index a993cd7e9948..106ff4b3e6ff 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_mcu.c
@@ -87,7 +87,7 @@ __mt76x02u_mcu_send_msg(struct mt76_dev *dev, struct sk_buff *skb,
 	u8 seq = 0;
 	u32 info;
 
-	if (test_bit(MT76_REMOVED, &dev->state))
+	if (test_bit(MT76_REMOVED, &dev->phy.state))
 		return 0;
 
 	if (wait_resp) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 837ba7f01f31..d226112494d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -602,7 +602,7 @@ void mt76x02_sw_scan_complete(struct ieee80211_hw *hw,
 {
 	struct mt76x02_dev *dev = hw->priv;
 
-	clear_bit(MT76_SCANNING, &dev->mt76.state);
+	clear_bit(MT76_SCANNING, &dev->mphy.state);
 	if (dev->cal.gain_init_done) {
 		/* Restore AGC gain and resume calibration after scanning. */
 		dev->cal.low_gain = -1;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
index bae05a088b5e..c69579e5f647 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_init.c
@@ -239,7 +239,7 @@ static int mt76x2_init_hardware(struct mt76x02_dev *dev)
 	if (ret)
 		return ret;
 
-	set_bit(MT76_STATE_INITIALIZED, &dev->mt76.state);
+	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 	mt76x02_mac_start(dev);
 
 	ret = mt76x2_mcu_init(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index 8c639cbc99ed..1f2db374ed51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -22,7 +22,7 @@ mt76x2_start(struct ieee80211_hw *hw)
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->wdt_work,
 				     MT_WATCHDOG_TIME);
 
-	set_bit(MT76_STATE_RUNNING, &dev->mt76.state);
+	set_bit(MT76_STATE_RUNNING, &dev->mphy.state);
 	return 0;
 }
 
@@ -31,7 +31,7 @@ mt76x2_stop(struct ieee80211_hw *hw)
 {
 	struct mt76x02_dev *dev = hw->priv;
 
-	clear_bit(MT76_STATE_RUNNING, &dev->mt76.state);
+	clear_bit(MT76_STATE_RUNNING, &dev->mphy.state);
 	mt76x2_stop_hardware(dev);
 }
 
@@ -45,7 +45,7 @@ mt76x2_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 	tasklet_disable(&dev->dfs_pd.dfs_tasklet);
 
 	mutex_lock(&dev->mt76.mutex);
-	set_bit(MT76_RESET, &dev->mt76.state);
+	set_bit(MT76_RESET, &dev->mphy.state);
 
 	mt76_set_channel(&dev->mphy);
 
@@ -57,7 +57,7 @@ mt76x2_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 
 	mt76x2_mac_resume(dev);
 
-	clear_bit(MT76_RESET, &dev->mt76.state);
+	clear_bit(MT76_RESET, &dev->mphy.state);
 	mutex_unlock(&dev->mt76.mutex);
 
 	tasklet_enable(&dev->dfs_pd.dfs_tasklet);
@@ -91,7 +91,7 @@ mt76x2_config(struct ieee80211_hw *hw, u32 changed)
 		/* convert to per-chain power for 2x2 devices */
 		dev->mt76.txpower_conf -= 6;
 
-		if (test_bit(MT76_STATE_RUNNING, &dev->mt76.state)) {
+		if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state)) {
 			mt76x2_phy_set_txpower(dev);
 			mt76x02_tx_set_txpwr_auto(dev, dev->mt76.txpower_conf);
 		}
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
index 83d00bf74218..e996b736a690 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_phy.c
@@ -118,7 +118,7 @@ int mt76x2_phy_set_channel(struct mt76x02_dev *dev,
 			   struct cfg80211_chan_def *chandef)
 {
 	struct ieee80211_channel *chan = chandef->chan;
-	bool scan = test_bit(MT76_SCANNING, &dev->mt76.state);
+	bool scan = test_bit(MT76_SCANNING, &dev->mphy.state);
 	enum nl80211_band band = chan->band;
 	u8 channel;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
index b64ad816cc25..2c07063eadfe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb.c
@@ -86,7 +86,7 @@ static void mt76x2u_disconnect(struct usb_interface *intf)
 	struct mt76x02_dev *dev = usb_get_intfdata(intf);
 	struct ieee80211_hw *hw = mt76_hw(dev);
 
-	set_bit(MT76_REMOVED, &dev->mt76.state);
+	set_bit(MT76_REMOVED, &dev->mphy.state);
 	ieee80211_unregister_hw(hw);
 	mt76x2u_cleanup(dev);
 	mt76u_deinit(&dev->mt76);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
index 89b04da23db9..62e5e89baf23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
@@ -218,7 +218,7 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
 	else
 		hw->max_tx_fragments = 1;
 
-	set_bit(MT76_STATE_INITIALIZED, &dev->mt76.state);
+	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
 
 	mt76x02_init_debugfs(dev);
 	mt76x2_init_txpower(dev, &dev->mphy.sband_2g.sband);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c
index 59cbe826188a..eaa622833f85 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_mac.c
@@ -98,7 +98,7 @@ int mt76x2u_mac_stop(struct mt76x02_dev *dev)
 	bool stopped = false;
 	u32 rts_cfg;
 
-	if (test_bit(MT76_REMOVED, &dev->mt76.state))
+	if (test_bit(MT76_REMOVED, &dev->mphy.state))
 		return -EIO;
 
 	rts_cfg = mt76_rr(dev, MT_TX_RTS_CFG);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index 24f2caf7bb66..e51b9d38221b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -17,7 +17,7 @@ static int mt76x2u_start(struct ieee80211_hw *hw)
 
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
 				     MT_MAC_WORK_INTERVAL);
-	set_bit(MT76_STATE_RUNNING, &dev->mt76.state);
+	set_bit(MT76_STATE_RUNNING, &dev->mphy.state);
 
 	return 0;
 }
@@ -26,7 +26,7 @@ static void mt76x2u_stop(struct ieee80211_hw *hw)
 {
 	struct mt76x02_dev *dev = hw->priv;
 
-	clear_bit(MT76_STATE_RUNNING, &dev->mt76.state);
+	clear_bit(MT76_STATE_RUNNING, &dev->mphy.state);
 	mt76u_stop_tx(&dev->mt76);
 	mt76x2u_stop_hw(dev);
 }
@@ -41,7 +41,7 @@ mt76x2u_set_channel(struct mt76x02_dev *dev,
 	mt76x02_pre_tbtt_enable(dev, false);
 
 	mutex_lock(&dev->mt76.mutex);
-	set_bit(MT76_RESET, &dev->mt76.state);
+	set_bit(MT76_RESET, &dev->mphy.state);
 
 	mt76_set_channel(&dev->mphy);
 
@@ -52,7 +52,7 @@ mt76x2u_set_channel(struct mt76x02_dev *dev,
 	mt76x02_mac_cc_reset(dev);
 	mt76x2_mac_resume(dev);
 
-	clear_bit(MT76_RESET, &dev->mt76.state);
+	clear_bit(MT76_RESET, &dev->mphy.state);
 	mutex_unlock(&dev->mt76.mutex);
 
 	mt76x02_pre_tbtt_enable(dev, true);
@@ -83,7 +83,7 @@ mt76x2u_config(struct ieee80211_hw *hw, u32 changed)
 		/* convert to per-chain power for 2x2 devices */
 		dev->mt76.txpower_conf -= 6;
 
-		if (test_bit(MT76_STATE_RUNNING, &dev->mt76.state))
+		if (test_bit(MT76_STATE_RUNNING, &dev->mphy.state))
 			mt76x2_phy_set_txpower(dev);
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c
index d4d9b40ba8d9..a04a98f5ce1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_phy.c
@@ -82,7 +82,7 @@ int mt76x2u_phy_set_channel(struct mt76x02_dev *dev,
 		      FIELD_PREP(MT_EXT_CCA_CFG_CCA3, 0) |
 		      FIELD_PREP(MT_EXT_CCA_CFG_CCA_MASK, BIT(3)),
 	};
-	bool scan = test_bit(MT76_SCANNING, &dev->mt76.state);
+	bool scan = test_bit(MT76_SCANNING, &dev->mphy.state);
 	struct ieee80211_channel *chan = chandef->chan;
 	u8 channel = chan->hw_value, bw, bw_index;
 	int ch_group_index, freq, freq1, ret;
diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index c993ad7ef2e3..eff522dbda34 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -442,7 +442,7 @@ mt76_txq_send_burst(struct mt76_phy *phy, struct mt76_sw_queue *sq,
 		if (probe)
 			break;
 
-		if (test_bit(MT76_RESET, &dev->state))
+		if (test_bit(MT76_RESET, &phy->state))
 			return -EBUSY;
 
 		skb = mt76_txq_dequeue(phy, mtxq, false);
@@ -498,7 +498,7 @@ mt76_txq_schedule_list(struct mt76_phy *phy, enum mt76_txq_id qid)
 		if (sq->swq_queued >= 4)
 			break;
 
-		if (test_bit(MT76_RESET, &dev->state)) {
+		if (test_bit(MT76_RESET, &phy->state)) {
 			ret = -EBUSY;
 			break;
 		}
@@ -604,7 +604,7 @@ void mt76_wake_tx_queue(struct ieee80211_hw *hw, struct ieee80211_txq *txq)
 	struct mt76_phy *phy = hw->priv;
 	struct mt76_dev *dev = phy->dev;
 
-	if (!test_bit(MT76_STATE_RUNNING, &dev->state))
+	if (!test_bit(MT76_STATE_RUNNING, &phy->state))
 		return;
 
 	tasklet_schedule(&dev->tx_tasklet);
diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wireless/mediatek/mt76/usb.c
index 3478cff9ab9a..8561d1bd7e6a 100644
--- a/drivers/net/wireless/mediatek/mt76/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/usb.c
@@ -29,13 +29,13 @@ static int __mt76u_vendor_request(struct mt76_dev *dev, u8 req,
 	pipe = (req_type & USB_DIR_IN) ? usb_rcvctrlpipe(udev, 0)
 				       : usb_sndctrlpipe(udev, 0);
 	for (i = 0; i < MT_VEND_REQ_MAX_RETRY; i++) {
-		if (test_bit(MT76_REMOVED, &dev->state))
+		if (test_bit(MT76_REMOVED, &dev->phy.state))
 			return -EIO;
 
 		ret = usb_control_msg(udev, pipe, req, req_type, val,
 				      offset, buf, len, MT_VEND_REQ_TOUT_MS);
 		if (ret == -ENODEV)
-			set_bit(MT76_REMOVED, &dev->state);
+			set_bit(MT76_REMOVED, &dev->phy.state);
 		if (ret >= 0 || ret == -ENODEV)
 			return ret;
 		usleep_range(5000, 10000);
@@ -200,7 +200,7 @@ static int
 mt76u_wr_rp(struct mt76_dev *dev, u32 base,
 	    const struct mt76_reg_pair *data, int n)
 {
-	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->state))
+	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state))
 		return dev->mcu_ops->mcu_wr_rp(dev, base, data, n);
 	else
 		return mt76u_req_wr_rp(dev, base, data, n);
@@ -227,7 +227,7 @@ static int
 mt76u_rd_rp(struct mt76_dev *dev, u32 base,
 	    struct mt76_reg_pair *data, int n)
 {
-	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->state))
+	if (test_bit(MT76_STATE_MCU_RUNNING, &dev->phy.state))
 		return dev->mcu_ops->mcu_rd_rp(dev, base, data, n);
 	else
 		return mt76u_req_rd_rp(dev, base, data, n);
@@ -464,7 +464,7 @@ mt76u_process_rx_entry(struct mt76_dev *dev, struct urb *urb)
 	int len, nsgs = 1;
 	struct sk_buff *skb;
 
-	if (!test_bit(MT76_STATE_INITIALIZED, &dev->state))
+	if (!test_bit(MT76_STATE_INITIALIZED, &dev->phy.state))
 		return 0;
 
 	len = mt76u_get_rx_entry_len(data, urb->actual_length);
@@ -696,7 +696,7 @@ static void mt76u_tx_tasklet(unsigned long data)
 
 		mt76_txq_schedule(&dev->phy, i);
 
-		if (!test_and_set_bit(MT76_READING_STATS, &dev->state))
+		if (!test_and_set_bit(MT76_READING_STATS, &dev->phy.state))
 			queue_work(dev->usb.stat_wq, &dev->usb.stat_work);
 		if (wake)
 			ieee80211_wake_queue(dev->hw, i);
@@ -714,7 +714,7 @@ static void mt76u_tx_status_data(struct work_struct *work)
 	dev = container_of(usb, struct mt76_dev, usb);
 
 	while (true) {
-		if (test_bit(MT76_REMOVED, &dev->state))
+		if (test_bit(MT76_REMOVED, &dev->phy.state))
 			break;
 
 		if (!dev->drv->tx_status_data(dev, &update))
@@ -722,10 +722,10 @@ static void mt76u_tx_status_data(struct work_struct *work)
 		count++;
 	}
 
-	if (count && test_bit(MT76_STATE_RUNNING, &dev->state))
+	if (count && test_bit(MT76_STATE_RUNNING, &dev->phy.state))
 		queue_work(usb->stat_wq, &usb->stat_work);
 	else
-		clear_bit(MT76_READING_STATS, &dev->state);
+		clear_bit(MT76_READING_STATS, &dev->phy.state);
 }
 
 static void mt76u_complete_tx(struct urb *urb)
@@ -806,7 +806,7 @@ static void mt76u_tx_kick(struct mt76_dev *dev, struct mt76_queue *q)
 		err = usb_submit_urb(urb, GFP_ATOMIC);
 		if (err < 0) {
 			if (err == -ENODEV)
-				set_bit(MT76_REMOVED, &dev->state);
+				set_bit(MT76_REMOVED, &dev->phy.state);
 			else
 				dev_err(dev->dev, "tx urb submit failed:%d\n",
 					err);
@@ -905,7 +905,7 @@ void mt76u_stop_tx(struct mt76_dev *dev)
 	}
 
 	cancel_work_sync(&dev->usb.stat_work);
-	clear_bit(MT76_READING_STATS, &dev->state);
+	clear_bit(MT76_READING_STATS, &dev->phy.state);
 
 	mt76_tx_status_check(dev, NULL, true);
 }
-- 
2.24.0

