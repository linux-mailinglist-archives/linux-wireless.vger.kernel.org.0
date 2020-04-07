Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5B101A0A61
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2020 11:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgDGJqo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Apr 2020 05:46:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgDGJqn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Apr 2020 05:46:43 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D84DE20801;
        Tue,  7 Apr 2020 09:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586252801;
        bh=lgVXqFC1fMeTDCtn8FVLIAPu3RFLwTdvCliiJHQqtbs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cE90n9heZW05pF51wbl69bDv36da/ijkjTUjfJK3Dc1NVDAwRPMjWQlY8WUarb4k+
         S+Ee4upbuDSz0LhkFpJk1gO4h5y4z2ZY2P2cwVnuyeje5lvA+l186ns9ObNG26vDvf
         KxW0I8HIxjnPGL2jRKX4FJ1F8O/iVBPAESYhSQgY=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] mt76: mt7615: move core shared code in mt7615-common module
Date:   Tue,  7 Apr 2020 11:46:28 +0200
Message-Id: <c6685da7a8fa245dc0d66e822268605ef5ee5976.1586252669.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586252669.git.lorenzo@kernel.org>
References: <cover.1586252669.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Create mt7615-common module in order to collect shared code between usb
and mmio code. Move the following source files in mt7615-common module:
- main.c
- init.c
- mcu.c
- mac.c
- debugfs.c
- eeprom.c
- trace.c

Create the following source files for mmio only source code and move them
in mt7615e module:
- pci_init.c
- dma.c
- pci_mac.c

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/Makefile   |   2 +-
 .../net/wireless/mediatek/mt76/mt7615/Kconfig |   7 +-
 .../wireless/mediatek/mt76/mt7615/Makefile    |   7 +-
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |   1 +
 .../net/wireless/mediatek/mt76/mt7615/dma.c   |  39 ----
 .../wireless/mediatek/mt76/mt7615/eeprom.c    |   1 +
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 176 ++------------
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 216 ++++--------------
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 147 ++++++------
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  15 +-
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  |  30 +++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  57 ++++-
 .../wireless/mediatek/mt76/mt7615/pci_init.c  | 171 ++++++++++++++
 .../wireless/mediatek/mt76/mt7615/pci_mac.c   | 179 +++++++++++++++
 14 files changed, 589 insertions(+), 459 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c

diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index d7a1ddc9e407..a1dfafec431b 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -26,4 +26,4 @@ mt76x02-usb-y := mt76x02_usb_mcu.o mt76x02_usb_core.o
 obj-$(CONFIG_MT76x0_COMMON) += mt76x0/
 obj-$(CONFIG_MT76x2_COMMON) += mt76x2/
 obj-$(CONFIG_MT7603E) += mt7603/
-obj-$(CONFIG_MT7615E) += mt7615/
+obj-$(CONFIG_MT7615_COMMON) += mt7615/
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
index 6afd4aea67ed..16385767d8b9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Kconfig
@@ -1,7 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+config MT7615_COMMON
+	tristate
+	select MT76_CORE
+
 config MT7615E
 	tristate "MediaTek MT7615E (PCIe) support"
-	select MT76_CORE
+	select MT7615_COMMON
 	depends on MAC80211
 	depends on PCI
 	help
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
index 5c6a220ed7e3..2a7937b4394f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/Makefile
@@ -1,9 +1,12 @@
 #SPDX-License-Identifier: ISC
 
+obj-$(CONFIG_MT7615_COMMON) += mt7615-common.o
 obj-$(CONFIG_MT7615E) += mt7615e.o
 
 CFLAGS_trace.o := -I$(src)
 
-mt7615e-y := pci.o init.o dma.o eeprom.o main.o mcu.o mac.o mmio.o \
-	     debugfs.o trace.o
+mt7615-common-y := main.o init.o mcu.o eeprom.o mac.o \
+		   debugfs.o trace.o
+
+mt7615e-y := pci.o pci_init.o dma.o pci_mac.o mmio.o
 mt7615e-$(CONFIG_MT7622_WMAC) += soc.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index 777c7f9bd760..2d9a46d05a1b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -323,3 +323,4 @@ int mt7615_init_debugfs(struct mt7615_dev *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt7615_init_debugfs);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
index b19f208e3d54..b0ba0e7807bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/dma.c
@@ -94,45 +94,6 @@ mt7615_init_tx_queues(struct mt7615_dev *dev)
 	return 0;
 }
 
-void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
-			 struct sk_buff *skb)
-{
-	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-	__le32 *rxd = (__le32 *)skb->data;
-	__le32 *end = (__le32 *)&skb->data[skb->len];
-	enum rx_pkt_type type;
-	u16 flag;
-
-	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
-	flag = FIELD_GET(MT_RXD0_PKT_FLAG, le32_to_cpu(rxd[0]));
-	if (type == PKT_TYPE_RX_EVENT && flag == 0x1)
-		type = PKT_TYPE_NORMAL_MCU;
-
-	switch (type) {
-	case PKT_TYPE_TXS:
-		for (rxd++; rxd + 7 <= end; rxd += 7)
-			mt7615_mac_add_txs(dev, rxd);
-		dev_kfree_skb(skb);
-		break;
-	case PKT_TYPE_TXRX_NOTIFY:
-		mt7615_mac_tx_free(dev, skb);
-		break;
-	case PKT_TYPE_RX_EVENT:
-		mt7615_mcu_rx_event(dev, skb);
-		break;
-	case PKT_TYPE_NORMAL_MCU:
-	case PKT_TYPE_NORMAL:
-		if (!mt7615_mac_fill_rx(dev, skb)) {
-			mt76_rx(&dev->mt76, q, skb);
-			return;
-		}
-		/* fall through */
-	default:
-		dev_kfree_skb(skb);
-		break;
-	}
-}
-
 static void
 mt7615_tx_cleanup(struct mt7615_dev *dev)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index 7a09427463b0..521705015036 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -297,3 +297,4 @@ int mt7615_eeprom_init(struct mt7615_dev *dev, u32 addr)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt7615_eeprom_init);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 6acaaf2732df..e89f1f6b2c42 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -12,12 +12,13 @@
 #include "mac.h"
 #include "eeprom.h"
 
-static void mt7615_phy_init(struct mt7615_dev *dev)
+void mt7615_phy_init(struct mt7615_dev *dev)
 {
 	/* disable rf low power beacon mode */
 	mt76_set(dev, MT_WF_PHY_WF2_RFCTRL0(0), MT_WF_PHY_WF2_RFCTRL0_LPBCN_EN);
 	mt76_set(dev, MT_WF_PHY_WF2_RFCTRL0(1), MT_WF_PHY_WF2_RFCTRL0_LPBCN_EN);
 }
+EXPORT_SYMBOL_GPL(mt7615_phy_init);
 
 static void
 mt7615_init_mac_chain(struct mt7615_dev *dev, int chain)
@@ -77,7 +78,7 @@ mt7615_init_mac_chain(struct mt7615_dev *dev, int chain)
 	}
 }
 
-static void mt7615_mac_init(struct mt7615_dev *dev)
+void mt7615_mac_init(struct mt7615_dev *dev)
 {
 	int i;
 
@@ -123,6 +124,7 @@ static void mt7615_mac_init(struct mt7615_dev *dev)
 		mt7615_init_mac_chain(dev, 1);
 	}
 }
+EXPORT_SYMBOL_GPL(mt7615_mac_init);
 
 bool mt7615_wait_for_mcu_init(struct mt7615_dev *dev)
 {
@@ -130,52 +132,7 @@ bool mt7615_wait_for_mcu_init(struct mt7615_dev *dev)
 
 	return test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
 }
-
-static void mt7615_init_work(struct work_struct *work)
-{
-	struct mt7615_dev *dev = container_of(work, struct mt7615_dev, mcu_work);
-
-	if (mt7615_mcu_init(dev))
-		return;
-
-	mt7615_mcu_set_eeprom(dev);
-	mt7615_mac_init(dev);
-	mt7615_phy_init(dev);
-	mt7615_mcu_del_wtbl_all(dev);
-}
-
-static int mt7615_init_hardware(struct mt7615_dev *dev)
-{
-	u32 addr = mt7615_reg_map(dev, MT_EFUSE_BASE);
-	int ret, idx;
-
-	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
-
-	INIT_WORK(&dev->mcu_work, mt7615_init_work);
-	spin_lock_init(&dev->token_lock);
-	idr_init(&dev->token);
-
-	ret = mt7615_eeprom_init(dev, addr);
-	if (ret < 0)
-		return ret;
-
-	ret = mt7615_dma_init(dev);
-	if (ret)
-		return ret;
-
-	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
-
-	/* Beacon and mgmt frames should occupy wcid 0 */
-	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7615_WTBL_STA - 1);
-	if (idx)
-		return -ENOSPC;
-
-	dev->mt76.global_wcid.idx = idx;
-	dev->mt76.global_wcid.hw_key_idx = -1;
-	rcu_assign_pointer(dev->mt76.wcid[idx], &dev->mt76.global_wcid);
-
-	return 0;
-}
+EXPORT_SYMBOL_GPL(mt7615_wait_for_mcu_init);
 
 #define CCK_RATE(_idx, _rate) {						\
 	.bitrate = _rate,						\
@@ -190,7 +147,7 @@ static int mt7615_init_hardware(struct mt7615_dev *dev)
 	.hw_value_short = (MT_PHY_TYPE_OFDM << 8) | (_idx),		\
 }
 
-static struct ieee80211_rate mt7615_rates[] = {
+struct ieee80211_rate mt7615_rates[] = {
 	CCK_RATE(0, 10),
 	CCK_RATE(1, 20),
 	CCK_RATE(2, 55),
@@ -204,6 +161,7 @@ static struct ieee80211_rate mt7615_rates[] = {
 	OFDM_RATE(8,  480),
 	OFDM_RATE(12, 540),
 };
+EXPORT_SYMBOL_GPL(mt7615_rates);
 
 static const struct ieee80211_iface_limit if_limits[] = {
 	{
@@ -229,61 +187,8 @@ static const struct ieee80211_iface_combination if_comb[] = {
 	}
 };
 
-static void
-mt7615_led_set_config(struct led_classdev *led_cdev,
-		      u8 delay_on, u8 delay_off)
-{
-	struct mt7615_dev *dev;
-	struct mt76_dev *mt76;
-	u32 val, addr;
-
-	mt76 = container_of(led_cdev, struct mt76_dev, led_cdev);
-	dev = container_of(mt76, struct mt7615_dev, mt76);
-	val = FIELD_PREP(MT_LED_STATUS_DURATION, 0xffff) |
-	      FIELD_PREP(MT_LED_STATUS_OFF, delay_off) |
-	      FIELD_PREP(MT_LED_STATUS_ON, delay_on);
-
-	addr = mt7615_reg_map(dev, MT_LED_STATUS_0(mt76->led_pin));
-	mt76_wr(dev, addr, val);
-	addr = mt7615_reg_map(dev, MT_LED_STATUS_1(mt76->led_pin));
-	mt76_wr(dev, addr, val);
-
-	val = MT_LED_CTRL_REPLAY(mt76->led_pin) |
-	      MT_LED_CTRL_KICK(mt76->led_pin);
-	if (mt76->led_al)
-		val |= MT_LED_CTRL_POLARITY(mt76->led_pin);
-	addr = mt7615_reg_map(dev, MT_LED_CTRL);
-	mt76_wr(dev, addr, val);
-}
-
-static int
-mt7615_led_set_blink(struct led_classdev *led_cdev,
-		     unsigned long *delay_on,
-		     unsigned long *delay_off)
-{
-	u8 delta_on, delta_off;
-
-	delta_off = max_t(u8, *delay_off / 10, 1);
-	delta_on = max_t(u8, *delay_on / 10, 1);
-
-	mt7615_led_set_config(led_cdev, delta_on, delta_off);
-
-	return 0;
-}
-
-static void
-mt7615_led_set_brightness(struct led_classdev *led_cdev,
-			  enum led_brightness brightness)
-{
-	if (!brightness)
-		mt7615_led_set_config(led_cdev, 0, 0xff);
-	else
-		mt7615_led_set_config(led_cdev, 0xff, 0);
-}
-
-static void
-mt7615_init_txpower(struct mt7615_dev *dev,
-		    struct ieee80211_supported_band *sband)
+void mt7615_init_txpower(struct mt7615_dev *dev,
+			 struct ieee80211_supported_band *sband)
 {
 	int i, n_chains = hweight8(dev->mphy.antenna_mask), target_chains;
 	u8 *eep = (u8 *)dev->mt76.eeprom.data;
@@ -309,6 +214,7 @@ mt7615_init_txpower(struct mt7615_dev *dev,
 		chan->orig_mpwr = target_power;
 	}
 }
+EXPORT_SYMBOL_GPL(mt7615_init_txpower);
 
 static void
 mt7615_regd_notifier(struct wiphy *wiphy,
@@ -449,6 +355,7 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mt7615_register_ext_phy);
 
 void mt7615_unregister_ext_phy(struct mt7615_dev *dev)
 {
@@ -462,6 +369,7 @@ void mt7615_unregister_ext_phy(struct mt7615_dev *dev)
 	mt76_unregister_phy(mphy);
 	ieee80211_free_hw(mphy->hw);
 }
+EXPORT_SYMBOL_GPL(mt7615_unregister_ext_phy);
 
 void mt7615_init_device(struct mt7615_dev *dev)
 {
@@ -487,62 +395,4 @@ void mt7615_init_device(struct mt7615_dev *dev)
 	mt7615_cap_dbdc_disable(dev);
 	dev->phy.dfs_state = -1;
 }
-
-int mt7615_register_device(struct mt7615_dev *dev)
-{
-	int ret;
-
-	mt7615_init_device(dev);
-
-	/* init led callbacks */
-	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-		dev->mt76.led_cdev.brightness_set = mt7615_led_set_brightness;
-		dev->mt76.led_cdev.blink_set = mt7615_led_set_blink;
-	}
-
-	ret = mt7622_wmac_init(dev);
-	if (ret)
-		return ret;
-
-	ret = mt7615_init_hardware(dev);
-	if (ret)
-		return ret;
-
-	ret = mt76_register_device(&dev->mt76, true, mt7615_rates,
-				   ARRAY_SIZE(mt7615_rates));
-	if (ret)
-		return ret;
-
-	ieee80211_queue_work(mt76_hw(dev), &dev->mcu_work);
-	mt7615_init_txpower(dev, &dev->mphy.sband_2g.sband);
-	mt7615_init_txpower(dev, &dev->mphy.sband_5g.sband);
-
-	return mt7615_init_debugfs(dev);
-}
-
-void mt7615_unregister_device(struct mt7615_dev *dev)
-{
-	struct mt76_txwi_cache *txwi;
-	bool mcu_running;
-	int id;
-
-	mcu_running = mt7615_wait_for_mcu_init(dev);
-
-	mt7615_unregister_ext_phy(dev);
-	mt76_unregister_device(&dev->mt76);
-	if (mcu_running)
-		mt7615_mcu_exit(dev);
-	mt7615_dma_cleanup(dev);
-
-	spin_lock_bh(&dev->token_lock);
-	idr_for_each_entry(&dev->token, txwi, id) {
-		mt7615_txp_skb_unmap(&dev->mt76, txwi);
-		if (txwi->skb)
-			dev_kfree_skb_any(txwi->skb);
-		mt76_put_txwi(&dev->mt76, txwi);
-	}
-	spin_unlock_bh(&dev->token_lock);
-	idr_destroy(&dev->token);
-
-	mt76_free_device(&dev->mt76);
-}
+EXPORT_SYMBOL_GPL(mt7615_init_device);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 1ef988883660..026d770de2ef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -181,7 +181,7 @@ mt7615_get_status_freq_info(struct mt7615_dev *dev, struct mt76_phy *mphy,
 	status->freq = ieee80211_channel_to_frequency(chfreq, status->band);
 }
 
-int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
+static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	struct mt76_phy *mphy = &dev->mt76.phy;
@@ -424,40 +424,7 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 void mt7615_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps)
 {
 }
-
-void mt7615_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
-			    struct mt76_queue_entry *e)
-{
-	if (!e->txwi) {
-		dev_kfree_skb_any(e->skb);
-		return;
-	}
-
-	/* error path */
-	if (e->skb == DMA_DUMMY_DATA) {
-		struct mt76_txwi_cache *t;
-		struct mt7615_dev *dev;
-		struct mt7615_txp_common *txp;
-		u16 token;
-
-		dev = container_of(mdev, struct mt7615_dev, mt76);
-		txp = mt7615_txwi_to_txp(mdev, e->txwi);
-
-		if (is_mt7615(&dev->mt76))
-			token = le16_to_cpu(txp->fw.token);
-		else
-			token = le16_to_cpu(txp->hw.msdu_id[0]) &
-				~MT_MSDU_ID_VALID;
-
-		spin_lock_bh(&dev->token_lock);
-		t = idr_remove(&dev->token, token);
-		spin_unlock_bh(&dev->token_lock);
-		e->skb = t ? t->skb : NULL;
-	}
-
-	if (e->skb)
-		mt76_tx_complete_skb(mdev, e->skb);
-}
+EXPORT_SYMBOL_GPL(mt7615_sta_ps);
 
 static u16
 mt7615_mac_tx_rate_val(struct mt7615_dev *dev,
@@ -672,6 +639,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt7615_mac_write_txwi);
 
 static void
 mt7615_txp_skb_unmap_fw(struct mt76_dev *dev, struct mt7615_fw_txp *txp)
@@ -722,6 +690,7 @@ void mt7615_txp_skb_unmap(struct mt76_dev *dev,
 	else
 		mt7615_txp_skb_unmap_hw(dev, &txp->hw);
 }
+EXPORT_SYMBOL_GPL(mt7615_txp_skb_unmap);
 
 bool mt7615_mac_wtbl_update(struct mt7615_dev *dev, int idx, u32 mask)
 {
@@ -807,6 +776,7 @@ void mt7615_mac_sta_poll(struct mt7615_dev *dev)
 
 	rcu_read_unlock();
 }
+EXPORT_SYMBOL_GPL(mt7615_mac_sta_poll);
 
 static void
 mt7615_mac_update_rate_desc(struct mt7615_phy *phy, struct mt7615_sta *sta,
@@ -962,6 +932,7 @@ void mt7615_mac_set_rates(struct mt7615_phy *phy, struct mt7615_sta *sta,
 	sta->rate_count = 2 * MT7615_RATE_RETRY * n_rates;
 	sta->wcid.tx_info |= MT_WCID_TX_INFO_SET;
 }
+EXPORT_SYMBOL_GPL(mt7615_mac_set_rates);
 
 int mt7615_mac_wtbl_update_key(struct mt7615_dev *dev,
 			       struct mt76_wcid *wcid,
@@ -1099,136 +1070,6 @@ int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev,
 	return err;
 }
 
-static void
-mt7615_write_hw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
-		    void *txp_ptr, u32 id)
-{
-	struct mt7615_hw_txp *txp = txp_ptr;
-	struct mt7615_txp_ptr *ptr = &txp->ptr[0];
-	int nbuf = tx_info->nbuf - 1;
-	int i;
-
-	tx_info->buf[0].len = MT_TXD_SIZE + sizeof(*txp);
-	tx_info->nbuf = 1;
-
-	txp->msdu_id[0] = cpu_to_le16(id | MT_MSDU_ID_VALID);
-
-	for (i = 0; i < nbuf; i++) {
-		u32 addr = tx_info->buf[i + 1].addr;
-		u16 len = tx_info->buf[i + 1].len;
-
-		if (i == nbuf - 1)
-			len |= MT_TXD_LEN_MSDU_LAST |
-			       MT_TXD_LEN_AMSDU_LAST;
-
-		if (i & 1) {
-			ptr->buf1 = cpu_to_le32(addr);
-			ptr->len1 = cpu_to_le16(len);
-			ptr++;
-		} else {
-			ptr->buf0 = cpu_to_le32(addr);
-			ptr->len0 = cpu_to_le16(len);
-		}
-	}
-}
-
-static void
-mt7615_write_fw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
-		    void *txp_ptr, u32 id)
-{
-	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)tx_info->skb->data;
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
-	struct ieee80211_key_conf *key = info->control.hw_key;
-	struct ieee80211_vif *vif = info->control.vif;
-	struct mt7615_fw_txp *txp = txp_ptr;
-	int nbuf = tx_info->nbuf - 1;
-	int i;
-
-	for (i = 0; i < nbuf; i++) {
-		txp->buf[i] = cpu_to_le32(tx_info->buf[i + 1].addr);
-		txp->len[i] = cpu_to_le16(tx_info->buf[i + 1].len);
-	}
-	txp->nbuf = nbuf;
-
-	/* pass partial skb header to fw */
-	tx_info->buf[0].len = MT_TXD_SIZE + sizeof(*txp);
-	tx_info->buf[1].len = MT_CT_PARSE_LEN;
-	tx_info->nbuf = MT_CT_DMA_BUF_NUM;
-
-	txp->flags = cpu_to_le16(MT_CT_INFO_APPLY_TXD);
-
-	if (!key)
-		txp->flags |= cpu_to_le16(MT_CT_INFO_NONE_CIPHER_FRAME);
-
-	if (ieee80211_is_mgmt(hdr->frame_control))
-		txp->flags |= cpu_to_le16(MT_CT_INFO_MGMT_FRAME);
-
-	if (vif) {
-		struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
-
-		txp->bss_idx = mvif->idx;
-	}
-
-	txp->token = cpu_to_le16(id);
-	txp->rept_wds_wcid = 0xff;
-}
-
-int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
-			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
-			  struct ieee80211_sta *sta,
-			  struct mt76_tx_info *tx_info)
-{
-	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-	struct mt7615_sta *msta = container_of(wcid, struct mt7615_sta, wcid);
-	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
-	struct ieee80211_key_conf *key = info->control.hw_key;
-	int pid, id;
-	u8 *txwi = (u8 *)txwi_ptr;
-	struct mt76_txwi_cache *t;
-	void *txp;
-
-	if (!wcid)
-		wcid = &dev->mt76.global_wcid;
-
-	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
-
-	if (info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) {
-		struct mt7615_phy *phy = &dev->phy;
-
-		if ((info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY) && mdev->phy2)
-			phy = mdev->phy2->priv;
-
-		spin_lock_bh(&dev->mt76.lock);
-		mt7615_mac_set_rates(phy, msta, &info->control.rates[0],
-				     msta->rates);
-		msta->rate_probe = true;
-		spin_unlock_bh(&dev->mt76.lock);
-	}
-
-	t = (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
-	t->skb = tx_info->skb;
-
-	spin_lock_bh(&dev->token_lock);
-	id = idr_alloc(&dev->token, t, 0, MT7615_TOKEN_SIZE, GFP_ATOMIC);
-	spin_unlock_bh(&dev->token_lock);
-	if (id < 0)
-		return id;
-
-	mt7615_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, sta,
-			      pid, key, false);
-
-	txp = txwi + MT_TXD_SIZE;
-	memset(txp, 0, sizeof(struct mt7615_txp_common));
-	if (is_mt7615(&dev->mt76))
-		mt7615_write_fw_txp(dev, tx_info, txp, id);
-	else
-		mt7615_write_hw_txp(dev, tx_info, txp, id);
-
-	tx_info->skb = DMA_DUMMY_DATA;
-
-	return 0;
-}
-
 static bool mt7615_fill_txs(struct mt7615_dev *dev, struct mt7615_sta *sta,
 			    struct ieee80211_tx_info *info, __le32 *txs_data)
 {
@@ -1406,7 +1247,7 @@ static bool mt7615_mac_add_txs_skb(struct mt7615_dev *dev,
 	return !!skb;
 }
 
-void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
+static void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
 {
 	struct ieee80211_tx_info info = {};
 	struct ieee80211_sta *sta = NULL;
@@ -1483,7 +1324,7 @@ mt7615_mac_tx_free_token(struct mt7615_dev *dev, u16 token)
 	mt76_put_txwi(mdev, txwi);
 }
 
-void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
+static void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
 {
 	struct mt7615_tx_free *free = (struct mt7615_tx_free *)skb->data;
 	u8 i, count;
@@ -1504,6 +1345,46 @@ void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb)
 	dev_kfree_skb(skb);
 }
 
+void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
+			 struct sk_buff *skb)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	__le32 *rxd = (__le32 *)skb->data;
+	__le32 *end = (__le32 *)&skb->data[skb->len];
+	enum rx_pkt_type type;
+	u16 flag;
+
+	type = FIELD_GET(MT_RXD0_PKT_TYPE, le32_to_cpu(rxd[0]));
+	flag = FIELD_GET(MT_RXD0_PKT_FLAG, le32_to_cpu(rxd[0]));
+	if (type == PKT_TYPE_RX_EVENT && flag == 0x1)
+		type = PKT_TYPE_NORMAL_MCU;
+
+	switch (type) {
+	case PKT_TYPE_TXS:
+		for (rxd++; rxd + 7 <= end; rxd += 7)
+			mt7615_mac_add_txs(dev, rxd);
+		dev_kfree_skb(skb);
+		break;
+	case PKT_TYPE_TXRX_NOTIFY:
+		mt7615_mac_tx_free(dev, skb);
+		break;
+	case PKT_TYPE_RX_EVENT:
+		mt7615_mcu_rx_event(dev, skb);
+		break;
+	case PKT_TYPE_NORMAL_MCU:
+	case PKT_TYPE_NORMAL:
+		if (!mt7615_mac_fill_rx(dev, skb)) {
+			mt76_rx(&dev->mt76, q, skb);
+			return;
+		}
+		/* fall through */
+	default:
+		dev_kfree_skb(skb);
+		break;
+	}
+}
+EXPORT_SYMBOL_GPL(mt7615_queue_rx_skb);
+
 static void
 mt7615_mac_set_default_sensitivity(struct mt7615_phy *phy)
 {
@@ -1756,6 +1637,7 @@ void mt7615_update_channel(struct mt76_dev *mdev)
 	/* reset obss airtime */
 	mt76_set(dev, MT_WF_RMAC_MIB_TIME0, MT_WF_RMAC_MIB_RXTIME_CLR);
 }
+EXPORT_SYMBOL_GPL(mt7615_update_channel);
 
 static void
 mt7615_mac_update_mib_stats(struct mt7615_phy *phy)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index b346080458bc..fec1c60197ee 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -4,11 +4,10 @@
  * Author: Roy Luo <royluo@google.com>
  *         Ryder Lee <ryder.lee@mediatek.com>
  *         Felix Fietkau <nbd@nbd.name>
+ *         Lorenzo Bianconi <lorenzo@kernel.org>
  */
 
 #include <linux/etherdevice.h>
-#include <linux/platform_device.h>
-#include <linux/pci.h>
 #include <linux/module.h>
 #include "mt7615.h"
 #include "mcu.h"
@@ -25,7 +24,7 @@ static bool mt7615_dev_running(struct mt7615_dev *dev)
 	return phy && test_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 }
 
-static int mt7615_start(struct ieee80211_hw *hw)
+int mt7615_start(struct ieee80211_hw *hw)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
@@ -68,6 +67,7 @@ static int mt7615_start(struct ieee80211_hw *hw)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt7615_start);
 
 static void mt7615_stop(struct ieee80211_hw *hw)
 {
@@ -127,8 +127,8 @@ static int get_omac_idx(enum nl80211_iftype type, u32 mask)
 	return -1;
 }
 
-static int mt7615_add_interface(struct ieee80211_hw *hw,
-				struct ieee80211_vif *vif)
+int mt7615_add_interface(struct ieee80211_hw *hw,
+			 struct ieee80211_vif *vif)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
@@ -190,9 +190,10 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mt7615_add_interface);
 
-static void mt7615_remove_interface(struct ieee80211_hw *hw,
-				    struct ieee80211_vif *vif)
+void mt7615_remove_interface(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_sta *msta = &mvif->sta;
@@ -219,6 +220,7 @@ static void mt7615_remove_interface(struct ieee80211_hw *hw,
 		list_del_init(&msta->poll_list);
 	spin_unlock_bh(&dev->sta_poll_lock);
 }
+EXPORT_SYMBOL_GPL(mt7615_remove_interface);
 
 static void mt7615_init_dfs_state(struct mt7615_phy *phy)
 {
@@ -281,9 +283,9 @@ static int mt7615_set_channel(struct mt7615_phy *phy)
 	return ret;
 }
 
-static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
-			  struct ieee80211_vif *vif, struct ieee80211_sta *sta,
-			  struct ieee80211_key_conf *key)
+int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+		   struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+		   struct ieee80211_key_conf *key)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
@@ -331,8 +333,9 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 
 	return mt7615_mac_wtbl_set_key(dev, wcid, key, cmd);
 }
+EXPORT_SYMBOL_GPL(mt7615_set_key);
 
-static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
+int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
@@ -361,10 +364,10 @@ static int mt7615_config(struct ieee80211_hw *hw, u32 changed)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mt7615_config);
 
-static int
-mt7615_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
-	       const struct ieee80211_tx_queue_params *params)
+int mt7615_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		   u16 queue, const struct ieee80211_tx_queue_params *params)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
@@ -373,11 +376,12 @@ mt7615_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif, u16 queue,
 
 	return mt7615_mcu_set_wmm(dev, queue, params);
 }
+EXPORT_SYMBOL_GPL(mt7615_conf_tx);
 
-static void mt7615_configure_filter(struct ieee80211_hw *hw,
-				    unsigned int changed_flags,
-				    unsigned int *total_flags,
-				    u64 multicast)
+void mt7615_configure_filter(struct ieee80211_hw *hw,
+			     unsigned int changed_flags,
+			     unsigned int *total_flags,
+			     u64 multicast)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
@@ -427,11 +431,12 @@ static void mt7615_configure_filter(struct ieee80211_hw *hw,
 	else
 		mt76_set(dev, MT_WF_RFCR1(band), ctl_flags);
 }
+EXPORT_SYMBOL_GPL(mt7615_configure_filter);
 
-static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
-				    struct ieee80211_vif *vif,
-				    struct ieee80211_bss_conf *info,
-				    u32 changed)
+void mt7615_bss_info_changed(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_bss_conf *info,
+			     u32 changed)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
@@ -461,6 +466,7 @@ static void mt7615_bss_info_changed(struct ieee80211_hw *hw,
 
 	mutex_unlock(&dev->mt76.mutex);
 }
+EXPORT_SYMBOL_GPL(mt7615_bss_info_changed);
 
 static void
 mt7615_channel_switch_beacon(struct ieee80211_hw *hw,
@@ -499,6 +505,7 @@ int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt7615_mac_sta_add);
 
 void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta)
@@ -515,10 +522,11 @@ void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		list_del_init(&msta->poll_list);
 	spin_unlock_bh(&dev->sta_poll_lock);
 }
+EXPORT_SYMBOL_GPL(mt7615_mac_sta_remove);
 
-static void mt7615_sta_rate_tbl_update(struct ieee80211_hw *hw,
-				       struct ieee80211_vif *vif,
-				       struct ieee80211_sta *sta)
+void mt7615_sta_rate_tbl_update(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
@@ -540,10 +548,11 @@ static void mt7615_sta_rate_tbl_update(struct ieee80211_hw *hw,
 	msta->rate_probe = false;
 	spin_unlock_bh(&dev->mt76.lock);
 }
+EXPORT_SYMBOL_GPL(mt7615_sta_rate_tbl_update);
 
-static void mt7615_tx(struct ieee80211_hw *hw,
-		      struct ieee80211_tx_control *control,
-		      struct sk_buff *skb)
+void mt7615_tx(struct ieee80211_hw *hw,
+	       struct ieee80211_tx_control *control,
+	       struct sk_buff *skb)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt76_phy *mphy = hw->priv;
@@ -567,8 +576,9 @@ static void mt7615_tx(struct ieee80211_hw *hw,
 
 	mt76_tx(mphy, control->sta, wcid, skb);
 }
+EXPORT_SYMBOL_GPL(mt7615_tx);
 
-static int mt7615_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
+int mt7615_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
@@ -579,10 +589,10 @@ static int mt7615_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt7615_set_rts_threshold);
 
-static int
-mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		    struct ieee80211_ampdu_params *params)
+int mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			struct ieee80211_ampdu_params *params)
 {
 	enum ieee80211_ampdu_mlme_action action = params->action;
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
@@ -634,22 +644,23 @@ mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mt7615_ampdu_action);
 
-static int
-mt7615_sta_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-	       struct ieee80211_sta *sta)
+int mt7615_sta_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		   struct ieee80211_sta *sta)
 {
     return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NOTEXIST,
 			  IEEE80211_STA_NONE);
 }
+EXPORT_SYMBOL_GPL(mt7615_sta_add);
 
-static int
-mt7615_sta_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-		  struct ieee80211_sta *sta)
+int mt7615_sta_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		      struct ieee80211_sta *sta)
 {
     return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NONE,
 			  IEEE80211_STA_NOTEXIST);
 }
+EXPORT_SYMBOL_GPL(mt7615_sta_remove);
 
 static int
 mt7615_get_stats(struct ieee80211_hw *hw,
@@ -686,17 +697,17 @@ mt7615_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	return tsf.t64;
 }
 
-static void
-mt7615_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
+void mt7615_set_coverage_class(struct ieee80211_hw *hw,
+			       s16 coverage_class)
 {
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 
 	phy->coverage_class = max_t(s16, coverage_class, 0);
 	mt7615_mac_set_timing(phy);
 }
+EXPORT_SYMBOL_GPL(mt7615_set_coverage_class);
 
-static int
-mt7615_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
+int mt7615_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
@@ -726,6 +737,7 @@ mt7615_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt7615_set_antenna);
 
 void mt7615_scan_work(struct work_struct *work)
 {
@@ -761,27 +773,27 @@ void mt7615_scan_work(struct work_struct *work)
 	}
 }
 
-static int
-mt7615_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-	       struct ieee80211_scan_request *req)
+int mt7615_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		   struct ieee80211_scan_request *req)
 {
 	struct mt76_phy *mphy = hw->priv;
 
 	return mt7615_mcu_hw_scan(mphy->priv, vif, req);
 }
+EXPORT_SYMBOL_GPL(mt7615_hw_scan);
 
-static void
-mt7615_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+void mt7615_cancel_hw_scan(struct ieee80211_hw *hw,
+			   struct ieee80211_vif *vif)
 {
 	struct mt76_phy *mphy = hw->priv;
 
 	mt7615_mcu_cancel_hw_scan(mphy->priv, vif);
 }
+EXPORT_SYMBOL_GPL(mt7615_cancel_hw_scan);
 
-static int
-mt7615_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-			struct cfg80211_sched_scan_request *req,
-			struct ieee80211_scan_ies *ies)
+int mt7615_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			    struct cfg80211_sched_scan_request *req,
+			    struct ieee80211_scan_ies *ies)
 {
 	struct mt76_phy *mphy = hw->priv;
 	int err;
@@ -792,14 +804,16 @@ mt7615_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	return mt7615_mcu_sched_scan_enable(mphy->priv, vif, true);
 }
+EXPORT_SYMBOL_GPL(mt7615_start_sched_scan);
 
-static int
-mt7615_stop_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+int mt7615_stop_sched_scan(struct ieee80211_hw *hw,
+			   struct ieee80211_vif *vif)
 {
 	struct mt76_phy *mphy = hw->priv;
 
 	return mt7615_mcu_sched_scan_enable(mphy->priv, vif, false);
 }
+EXPORT_SYMBOL_GPL(mt7615_stop_sched_scan);
 
 const struct ieee80211_ops mt7615_ops = {
 	.tx = mt7615_tx,
@@ -835,31 +849,6 @@ const struct ieee80211_ops mt7615_ops = {
 	.sched_scan_start = mt7615_start_sched_scan,
 	.sched_scan_stop = mt7615_stop_sched_scan,
 };
+EXPORT_SYMBOL_GPL(mt7615_ops);
 
-static int __init mt7615_init(void)
-{
-	int ret;
-
-	ret = pci_register_driver(&mt7615_pci_driver);
-	if (ret)
-		return ret;
-
-	if (IS_ENABLED(CONFIG_MT7622_WMAC)) {
-		ret = platform_driver_register(&mt7622_wmac_driver);
-		if (ret)
-			pci_unregister_driver(&mt7615_pci_driver);
-	}
-
-	return ret;
-}
-
-static void __exit mt7615_exit(void)
-{
-	if (IS_ENABLED(CONFIG_MT7622_WMAC))
-		platform_driver_unregister(&mt7622_wmac_driver);
-	pci_unregister_driver(&mt7615_pci_driver);
-}
-
-module_init(mt7615_init);
-module_exit(mt7615_exit);
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index b236612dd033..be51141369d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -152,6 +152,7 @@ void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 		break;
 	}
 }
+EXPORT_SYMBOL_GPL(mt7615_mcu_fill_msg);
 
 static int __mt7615_mcu_msg_send(struct mt7615_dev *dev, struct sk_buff *skb,
 				 int cmd, int *wait_seq)
@@ -215,6 +216,7 @@ int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(mt7615_mcu_wait_response);
 
 static int
 mt7615_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
@@ -238,9 +240,8 @@ mt7615_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	return ret;
 }
 
-static int
-mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
-		    int len, bool wait_resp)
+int mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
+			int len, bool wait_resp)
 {
 	struct sk_buff *skb;
 
@@ -250,6 +251,7 @@ mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 
 	return __mt76_mcu_skb_send_msg(mdev, skb, cmd, wait_resp);
 }
+EXPORT_SYMBOL_GPL(mt7615_mcu_msg_send);
 
 static void
 mt7615_mcu_csa_finish(void *priv, u8 *mac, struct ieee80211_vif *vif)
@@ -1629,11 +1631,12 @@ static int mt7615_mcu_start_firmware(struct mt7615_dev *dev, u32 addr,
 				   &req, sizeof(req), true);
 }
 
-static int mt7615_mcu_restart(struct mt76_dev *dev)
+int mt7615_mcu_restart(struct mt76_dev *dev)
 {
 	return __mt76_mcu_send_msg(dev, MCU_CMD_RESTART_DL_REQ, NULL,
 				   0, true);
 }
+EXPORT_SYMBOL_GPL(mt7615_mcu_restart);
 
 static int mt7615_mcu_patch_sem_ctrl(struct mt7615_dev *dev, bool get)
 {
@@ -2165,6 +2168,7 @@ int mt7615_mcu_init(struct mt7615_dev *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt7615_mcu_init);
 
 void mt7615_mcu_exit(struct mt7615_dev *dev)
 {
@@ -2172,6 +2176,7 @@ void mt7615_mcu_exit(struct mt7615_dev *dev)
 	mt7615_firmware_own(dev);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
 }
+EXPORT_SYMBOL_GPL(mt7615_mcu_exit);
 
 int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
 {
@@ -2214,6 +2219,7 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
 	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				       MCU_EXT_CMD_EFUSE_BUFFER_MODE, true);
 }
+EXPORT_SYMBOL_GPL(mt7615_mcu_set_eeprom);
 
 int mt7615_mcu_set_mac_enable(struct mt7615_dev *dev, int band, bool enable)
 {
@@ -2355,6 +2361,7 @@ int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev)
 	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_WTBL_UPDATE,
 				   &req, sizeof(req), true);
 }
+EXPORT_SYMBOL_GPL(mt7615_mcu_del_wtbl_all);
 
 int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
 		       enum mt7615_rdd_cmd cmd, u8 index,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index d2eff5442824..99ab944ddfb8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -1,5 +1,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pci.h>
 
 #include "mt7615.h"
 #include "regs.h"
@@ -172,3 +174,31 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 	ieee80211_free_hw(mt76_hw(dev));
 	return ret;
 }
+
+static int __init mt7615_init(void)
+{
+	int ret;
+
+	ret = pci_register_driver(&mt7615_pci_driver);
+	if (ret)
+		return ret;
+
+	if (IS_ENABLED(CONFIG_MT7622_WMAC)) {
+		ret = platform_driver_register(&mt7622_wmac_driver);
+		if (ret)
+			pci_unregister_driver(&mt7615_pci_driver);
+	}
+
+	return ret;
+}
+
+static void __exit mt7615_exit(void)
+{
+	if (IS_ENABLED(CONFIG_MT7622_WMAC))
+		platform_driver_unregister(&mt7622_wmac_driver);
+	pci_unregister_driver(&mt7615_pci_driver);
+}
+
+module_init(mt7615_init);
+module_exit(mt7615_exit);
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 65a2b30fc588..344b45a9510c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -337,6 +337,7 @@ mt7615_ext_phy(struct mt7615_dev *dev)
 	return phy->priv;
 }
 
+extern struct ieee80211_rate mt7615_rates[12];
 extern const struct ieee80211_ops mt7615_ops;
 extern const u32 mt7615e_reg_map[__MT_BASE_MAX];
 extern const u32 mt7663e_reg_map[__MT_BASE_MAX];
@@ -417,6 +418,57 @@ static inline bool mt7615_firmware_offload(struct mt7615_dev *dev)
 }
 
 void mt7615_scan_work(struct work_struct *work);
+int mt7615_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		   struct ieee80211_scan_request *req);
+void mt7615_cancel_hw_scan(struct ieee80211_hw *hw,
+			   struct ieee80211_vif *vif);
+int mt7615_start_sched_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			    struct cfg80211_sched_scan_request *req,
+			    struct ieee80211_scan_ies *ies);
+int mt7615_stop_sched_scan(struct ieee80211_hw *hw,
+			   struct ieee80211_vif *vif);
+void mt7615_tx(struct ieee80211_hw *hw,
+	       struct ieee80211_tx_control *control,
+	       struct sk_buff *skb);
+void mt7615_set_coverage_class(struct ieee80211_hw *hw,
+			       s16 coverage_class);
+int mt7615_set_antenna(struct ieee80211_hw *hw, u32 tx_ant,
+		       u32 rx_ant);
+int mt7615_start(struct ieee80211_hw *hw);
+int mt7615_add_interface(struct ieee80211_hw *hw,
+			 struct ieee80211_vif *vif);
+void mt7615_remove_interface(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif);
+int mt7615_sta_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		   struct ieee80211_sta *sta);
+int mt7615_sta_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		      struct ieee80211_sta *sta);
+int mt7615_config(struct ieee80211_hw *hw, u32 changed);
+int mt7615_conf_tx(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		   u16 queue, const struct ieee80211_tx_queue_params *params);
+void mt7615_configure_filter(struct ieee80211_hw *hw,
+			     unsigned int changed_flags,
+			     unsigned int *total_flags,
+			     u64 multicast);
+void mt7615_bss_info_changed(struct ieee80211_hw *hw,
+			     struct ieee80211_vif *vif,
+			     struct ieee80211_bss_conf *info,
+			     u32 changed);
+int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
+		   struct ieee80211_vif *vif, struct ieee80211_sta *sta,
+		   struct ieee80211_key_conf *key);
+int mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			struct ieee80211_ampdu_params *params);
+int mt7615_set_rts_threshold(struct ieee80211_hw *hw, u32 val);
+void mt7615_sta_rate_tbl_update(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta);
+void mt7615_init_txpower(struct mt7615_dev *dev,
+			 struct ieee80211_supported_band *sband);
+void mt7615_phy_init(struct mt7615_dev *dev);
+void mt7615_mac_init(struct mt7615_dev *dev);
+
+int mt7615_mcu_restart(struct mt76_dev *dev);
 void mt7615_update_channel(struct mt76_dev *mdev);
 bool mt7615_mac_wtbl_update(struct mt7615_dev *dev, int idx, u32 mask);
 void mt7615_mac_reset_counters(struct mt7615_dev *dev);
@@ -429,9 +481,6 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 			  struct ieee80211_sta *sta, int pid,
 			  struct ieee80211_key_conf *key, bool beacon);
 void mt7615_mac_set_timing(struct mt7615_phy *phy);
-int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb);
-void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data);
-void mt7615_mac_tx_free(struct mt7615_dev *dev, struct sk_buff *skb);
 int mt7615_mac_wtbl_set_key(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 			    struct ieee80211_key_conf *key,
 			    enum set_key_cmd cmd);
@@ -451,6 +500,8 @@ int mt7615_mac_wtbl_update_key(struct mt7615_dev *dev,
 void mt7615_mac_reset_work(struct work_struct *work);
 
 int mt7615_mcu_wait_response(struct mt7615_dev *dev, int cmd, int seq);
+int mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
+			int len, bool wait_resp);
 int mt7615_mcu_set_dbdc(struct mt7615_dev *dev);
 int mt7615_mcu_set_eeprom(struct mt7615_dev *dev);
 int mt7615_mcu_set_mac_enable(struct mt7615_dev *dev, int band, bool enable);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
new file mode 100644
index 000000000000..4d9c90f5fc07
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2019 MediaTek Inc.
+ *
+ * Author: Roy Luo <royluo@google.com>
+ *         Ryder Lee <ryder.lee@mediatek.com>
+ *         Felix Fietkau <nbd@nbd.name>
+ *         Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#include <linux/etherdevice.h>
+#include "mt7615.h"
+#include "mac.h"
+#include "eeprom.h"
+
+static void mt7615_init_work(struct work_struct *work)
+{
+	struct mt7615_dev *dev = container_of(work, struct mt7615_dev,
+					      mcu_work);
+
+	if (mt7615_mcu_init(dev))
+		return;
+
+	mt7615_mcu_set_eeprom(dev);
+	mt7615_mac_init(dev);
+	mt7615_phy_init(dev);
+	mt7615_mcu_del_wtbl_all(dev);
+}
+
+static int mt7615_init_hardware(struct mt7615_dev *dev)
+{
+	u32 addr = mt7615_reg_map(dev, MT_EFUSE_BASE);
+	int ret, idx;
+
+	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
+
+	INIT_WORK(&dev->mcu_work, mt7615_init_work);
+	spin_lock_init(&dev->token_lock);
+	idr_init(&dev->token);
+
+	ret = mt7615_eeprom_init(dev, addr);
+	if (ret < 0)
+		return ret;
+
+	ret = mt7615_dma_init(dev);
+	if (ret)
+		return ret;
+
+	set_bit(MT76_STATE_INITIALIZED, &dev->mphy.state);
+
+	/* Beacon and mgmt frames should occupy wcid 0 */
+	idx = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7615_WTBL_STA - 1);
+	if (idx)
+		return -ENOSPC;
+
+	dev->mt76.global_wcid.idx = idx;
+	dev->mt76.global_wcid.hw_key_idx = -1;
+	rcu_assign_pointer(dev->mt76.wcid[idx], &dev->mt76.global_wcid);
+
+	return 0;
+}
+
+static void
+mt7615_led_set_config(struct led_classdev *led_cdev,
+		      u8 delay_on, u8 delay_off)
+{
+	struct mt7615_dev *dev;
+	struct mt76_dev *mt76;
+	u32 val, addr;
+
+	mt76 = container_of(led_cdev, struct mt76_dev, led_cdev);
+	dev = container_of(mt76, struct mt7615_dev, mt76);
+	val = FIELD_PREP(MT_LED_STATUS_DURATION, 0xffff) |
+	      FIELD_PREP(MT_LED_STATUS_OFF, delay_off) |
+	      FIELD_PREP(MT_LED_STATUS_ON, delay_on);
+
+	addr = mt7615_reg_map(dev, MT_LED_STATUS_0(mt76->led_pin));
+	mt76_wr(dev, addr, val);
+	addr = mt7615_reg_map(dev, MT_LED_STATUS_1(mt76->led_pin));
+	mt76_wr(dev, addr, val);
+
+	val = MT_LED_CTRL_REPLAY(mt76->led_pin) |
+	      MT_LED_CTRL_KICK(mt76->led_pin);
+	if (mt76->led_al)
+		val |= MT_LED_CTRL_POLARITY(mt76->led_pin);
+	addr = mt7615_reg_map(dev, MT_LED_CTRL);
+	mt76_wr(dev, addr, val);
+}
+
+static int
+mt7615_led_set_blink(struct led_classdev *led_cdev,
+		     unsigned long *delay_on,
+		     unsigned long *delay_off)
+{
+	u8 delta_on, delta_off;
+
+	delta_off = max_t(u8, *delay_off / 10, 1);
+	delta_on = max_t(u8, *delay_on / 10, 1);
+
+	mt7615_led_set_config(led_cdev, delta_on, delta_off);
+
+	return 0;
+}
+
+static void
+mt7615_led_set_brightness(struct led_classdev *led_cdev,
+			  enum led_brightness brightness)
+{
+	if (!brightness)
+		mt7615_led_set_config(led_cdev, 0, 0xff);
+	else
+		mt7615_led_set_config(led_cdev, 0xff, 0);
+}
+
+int mt7615_register_device(struct mt7615_dev *dev)
+{
+	int ret;
+
+	mt7615_init_device(dev);
+
+	/* init led callbacks */
+	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
+		dev->mt76.led_cdev.brightness_set = mt7615_led_set_brightness;
+		dev->mt76.led_cdev.blink_set = mt7615_led_set_blink;
+	}
+
+	ret = mt7622_wmac_init(dev);
+	if (ret)
+		return ret;
+
+	ret = mt7615_init_hardware(dev);
+	if (ret)
+		return ret;
+
+	ret = mt76_register_device(&dev->mt76, true, mt7615_rates,
+				   ARRAY_SIZE(mt7615_rates));
+	if (ret)
+		return ret;
+
+	ieee80211_queue_work(mt76_hw(dev), &dev->mcu_work);
+	mt7615_init_txpower(dev, &dev->mphy.sband_2g.sband);
+	mt7615_init_txpower(dev, &dev->mphy.sband_5g.sband);
+
+	return mt7615_init_debugfs(dev);
+}
+
+void mt7615_unregister_device(struct mt7615_dev *dev)
+{
+	struct mt76_txwi_cache *txwi;
+	bool mcu_running;
+	int id;
+
+	mcu_running = mt7615_wait_for_mcu_init(dev);
+
+	mt7615_unregister_ext_phy(dev);
+	mt76_unregister_device(&dev->mt76);
+	if (mcu_running)
+		mt7615_mcu_exit(dev);
+	mt7615_dma_cleanup(dev);
+
+	spin_lock_bh(&dev->token_lock);
+	idr_for_each_entry(&dev->token, txwi, id) {
+		mt7615_txp_skb_unmap(&dev->mt76, txwi);
+		if (txwi->skb)
+			dev_kfree_skb_any(txwi->skb);
+		mt76_put_txwi(&dev->mt76, txwi);
+	}
+	spin_unlock_bh(&dev->token_lock);
+	idr_destroy(&dev->token);
+
+	mt76_free_device(&dev->mt76);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
new file mode 100644
index 000000000000..7fba1c39060f
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc.
+ *
+ * Author: Ryder Lee <ryder.lee@mediatek.com>
+ *         Roy Luo <royluo@google.com>
+ *         Felix Fietkau <nbd@nbd.name>
+ *         Lorenzo Bianconi <lorenzo@kernel.org>
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/timekeeping.h>
+
+#include "mt7615.h"
+#include "../dma.h"
+#include "mac.h"
+
+void mt7615_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
+			    struct mt76_queue_entry *e)
+{
+	if (!e->txwi) {
+		dev_kfree_skb_any(e->skb);
+		return;
+	}
+
+	/* error path */
+	if (e->skb == DMA_DUMMY_DATA) {
+		struct mt76_txwi_cache *t;
+		struct mt7615_dev *dev;
+		struct mt7615_txp_common *txp;
+		u16 token;
+
+		dev = container_of(mdev, struct mt7615_dev, mt76);
+		txp = mt7615_txwi_to_txp(mdev, e->txwi);
+
+		if (is_mt7615(&dev->mt76))
+			token = le16_to_cpu(txp->fw.token);
+		else
+			token = le16_to_cpu(txp->hw.msdu_id[0]) &
+				~MT_MSDU_ID_VALID;
+
+		spin_lock_bh(&dev->token_lock);
+		t = idr_remove(&dev->token, token);
+		spin_unlock_bh(&dev->token_lock);
+		e->skb = t ? t->skb : NULL;
+	}
+
+	if (e->skb)
+		mt76_tx_complete_skb(mdev, e->skb);
+}
+
+static void
+mt7615_write_hw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
+		    void *txp_ptr, u32 id)
+{
+	struct mt7615_hw_txp *txp = txp_ptr;
+	struct mt7615_txp_ptr *ptr = &txp->ptr[0];
+	int nbuf = tx_info->nbuf - 1;
+	int i;
+
+	tx_info->buf[0].len = MT_TXD_SIZE + sizeof(*txp);
+	tx_info->nbuf = 1;
+
+	txp->msdu_id[0] = cpu_to_le16(id | MT_MSDU_ID_VALID);
+
+	for (i = 0; i < nbuf; i++) {
+		u32 addr = tx_info->buf[i + 1].addr;
+		u16 len = tx_info->buf[i + 1].len;
+
+		if (i == nbuf - 1)
+			len |= MT_TXD_LEN_MSDU_LAST |
+			       MT_TXD_LEN_AMSDU_LAST;
+
+		if (i & 1) {
+			ptr->buf1 = cpu_to_le32(addr);
+			ptr->len1 = cpu_to_le16(len);
+			ptr++;
+		} else {
+			ptr->buf0 = cpu_to_le32(addr);
+			ptr->len0 = cpu_to_le16(len);
+		}
+	}
+}
+
+static void
+mt7615_write_fw_txp(struct mt7615_dev *dev, struct mt76_tx_info *tx_info,
+		    void *txp_ptr, u32 id)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)tx_info->skb->data;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
+	struct ieee80211_key_conf *key = info->control.hw_key;
+	struct ieee80211_vif *vif = info->control.vif;
+	struct mt7615_fw_txp *txp = txp_ptr;
+	int nbuf = tx_info->nbuf - 1;
+	int i;
+
+	for (i = 0; i < nbuf; i++) {
+		txp->buf[i] = cpu_to_le32(tx_info->buf[i + 1].addr);
+		txp->len[i] = cpu_to_le16(tx_info->buf[i + 1].len);
+	}
+	txp->nbuf = nbuf;
+
+	/* pass partial skb header to fw */
+	tx_info->buf[0].len = MT_TXD_SIZE + sizeof(*txp);
+	tx_info->buf[1].len = MT_CT_PARSE_LEN;
+	tx_info->nbuf = MT_CT_DMA_BUF_NUM;
+
+	txp->flags = cpu_to_le16(MT_CT_INFO_APPLY_TXD);
+
+	if (!key)
+		txp->flags |= cpu_to_le16(MT_CT_INFO_NONE_CIPHER_FRAME);
+
+	if (ieee80211_is_mgmt(hdr->frame_control))
+		txp->flags |= cpu_to_le16(MT_CT_INFO_MGMT_FRAME);
+
+	if (vif) {
+		struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
+
+		txp->bss_idx = mvif->idx;
+	}
+
+	txp->token = cpu_to_le16(id);
+	txp->rept_wds_wcid = 0xff;
+}
+
+int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
+			  struct ieee80211_sta *sta,
+			  struct mt76_tx_info *tx_info)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	struct mt7615_sta *msta = container_of(wcid, struct mt7615_sta, wcid);
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx_info->skb);
+	struct ieee80211_key_conf *key = info->control.hw_key;
+	int pid, id;
+	u8 *txwi = (u8 *)txwi_ptr;
+	struct mt76_txwi_cache *t;
+	void *txp;
+
+	if (!wcid)
+		wcid = &dev->mt76.global_wcid;
+
+	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
+
+	if (info->flags & IEEE80211_TX_CTL_RATE_CTRL_PROBE) {
+		struct mt7615_phy *phy = &dev->phy;
+
+		if ((info->hw_queue & MT_TX_HW_QUEUE_EXT_PHY) && mdev->phy2)
+			phy = mdev->phy2->priv;
+
+		spin_lock_bh(&dev->mt76.lock);
+		mt7615_mac_set_rates(phy, msta, &info->control.rates[0],
+				     msta->rates);
+		msta->rate_probe = true;
+		spin_unlock_bh(&dev->mt76.lock);
+	}
+
+	t = (struct mt76_txwi_cache *)(txwi + mdev->drv->txwi_size);
+	t->skb = tx_info->skb;
+
+	spin_lock_bh(&dev->token_lock);
+	id = idr_alloc(&dev->token, t, 0, MT7615_TOKEN_SIZE, GFP_ATOMIC);
+	spin_unlock_bh(&dev->token_lock);
+	if (id < 0)
+		return id;
+
+	mt7615_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, sta,
+			      pid, key, false);
+
+	txp = txwi + MT_TXD_SIZE;
+	memset(txp, 0, sizeof(struct mt7615_txp_common));
+	if (is_mt7615(&dev->mt76))
+		mt7615_write_fw_txp(dev, tx_info, txp, id);
+	else
+		mt7615_write_hw_txp(dev, tx_info, txp, id);
+
+	tx_info->skb = DMA_DUMMY_DATA;
+
+	return 0;
+}
-- 
2.25.2

