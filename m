Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0AE0645E93
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 17:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbiLGQUV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 11:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLGQUU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 11:20:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5186A63D42
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 08:20:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C513261A8D
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 16:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D82ABC433C1;
        Wed,  7 Dec 2022 16:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670430018;
        bh=icPbs3Y2uT4Hhk3ZcAlFRZlxPB0gw2LOHaFs7YopztY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qf+g730QnG7wIEg1cvNRRAAAGcXLF6B+upNqZkk/flYFRDov38VhV/cFxQKV534iP
         1ZY+YwukWLx6r/RF+ukLhbcEUilmbnHjabsonVVLrjed6hRA+g55ogmLvv/oA8N2hp
         08E4YPWqmnHx9sRYu6meMp5D96IQw0/XmnI/L8MnTdxFXUE7PayW9TV1UWXT4O1cI1
         ujwNL2SdwFWd7rbOPopDnHMZ/oh1wlI2i7oRu1aeYOk6PIIDOUX3RnpZBa3nChAx3s
         t2gZksvmAYXOM3nPzI74LuPMTHuwaLciGvGBVNrFHMDoESCfjq1sItygtsUXii80K5
         WUBxHj4NG6TjA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, frank-w@public-files.de
Subject: [PATCH 4/4] wifi: mt76: mt7615: enable per-phy led support
Date:   Wed,  7 Dec 2022 17:19:45 +0100
Message-Id: <145fa94c806ab857ace8d6706305c28341aab1c1.1670429695.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1670429694.git.lorenzo@kernel.org>
References: <cover.1670429694.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce the capability to support per-phy led blinking. This is needed
for devices supporting dbdc.

Co-developed-by: Ryder Lee <ryder.Lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.Lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 85 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/mmio.c  | 16 ----
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  6 ++
 .../wireless/mediatek/mt76/mt7615/pci_init.c  | 58 -------------
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  1 +
 5 files changed, 92 insertions(+), 74 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 07a1fea94f66..5fa6f097ec30 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -443,6 +443,85 @@ mt7615_cap_dbdc_disable(struct mt7615_dev *dev)
 	mt76_set_stream_caps(&dev->mphy, true);
 }
 
+u32 mt7615_reg_map(struct mt7615_dev *dev, u32 addr)
+{
+	u32 base, offset;
+
+	if (is_mt7663(&dev->mt76)) {
+		base = addr & MT7663_MCU_PCIE_REMAP_2_BASE;
+		offset = addr & MT7663_MCU_PCIE_REMAP_2_OFFSET;
+	} else {
+		base = addr & MT_MCU_PCIE_REMAP_2_BASE;
+		offset = addr & MT_MCU_PCIE_REMAP_2_OFFSET;
+	}
+	mt76_wr(dev, MT_MCU_PCIE_REMAP_2, base);
+
+	return MT_PCIE_REMAP_BASE_2 + offset;
+}
+EXPORT_SYMBOL_GPL(mt7615_reg_map);
+
+static void
+mt7615_led_set_config(struct led_classdev *led_cdev,
+		      u8 delay_on, u8 delay_off)
+{
+	struct mt7615_dev *dev;
+	struct mt76_phy *mphy;
+	u32 val, addr;
+	u8 index;
+
+	mphy = container_of(led_cdev, struct mt76_phy, leds.cdev);
+	dev = container_of(mphy->dev, struct mt7615_dev, mt76);
+
+	if (!mt76_connac_pm_ref(mphy, &dev->pm))
+		return;
+
+	val = FIELD_PREP(MT_LED_STATUS_DURATION, 0xffff) |
+	      FIELD_PREP(MT_LED_STATUS_OFF, delay_off) |
+	      FIELD_PREP(MT_LED_STATUS_ON, delay_on);
+
+	index = dev->dbdc_support ? mphy->band_idx : mphy->leds.pin;
+	addr = mt7615_reg_map(dev, MT_LED_STATUS_0(index));
+	mt76_wr(dev, addr, val);
+	addr = mt7615_reg_map(dev, MT_LED_STATUS_1(index));
+	mt76_wr(dev, addr, val);
+
+	val = MT_LED_CTRL_REPLAY(index) | MT_LED_CTRL_KICK(index);
+	if (dev->mphy.leds.al)
+		val |= MT_LED_CTRL_POLARITY(index);
+	if (mphy->band_idx)
+		val |= MT_LED_CTRL_BAND(index);
+
+	addr = mt7615_reg_map(dev, MT_LED_CTRL);
+	mt76_wr(dev, addr, val);
+
+	mt76_connac_pm_unref(mphy, &dev->pm);
+}
+
+int mt7615_led_set_blink(struct led_classdev *led_cdev,
+			 unsigned long *delay_on,
+			 unsigned long *delay_off)
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
+EXPORT_SYMBOL_GPL(mt7615_led_set_blink);
+
+void mt7615_led_set_brightness(struct led_classdev *led_cdev,
+			       enum led_brightness brightness)
+{
+	if (!brightness)
+		mt7615_led_set_config(led_cdev, 0, 0xff);
+	else
+		mt7615_led_set_config(led_cdev, 0xff, 0);
+}
+EXPORT_SYMBOL_GPL(mt7615_led_set_brightness);
+
 int mt7615_register_ext_phy(struct mt7615_dev *dev)
 {
 	struct mt7615_phy *phy = mt7615_ext_phy(dev);
@@ -497,6 +576,12 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	for (i = 0; i <= MT_TXQ_PSD ; i++)
 		mphy->q_tx[i] = dev->mphy.q_tx[i];
 
+	/* init led callbacks */
+	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
+		mphy->leds.cdev.brightness_set = mt7615_led_set_brightness;
+		mphy->leds.cdev.blink_set = mt7615_led_set_blink;
+	}
+
 	ret = mt76_register_phy(mphy, true, mt76_rates,
 				ARRAY_SIZE(mt76_rates));
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index a784f9d9e935..83173efb56dc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -63,22 +63,6 @@ const u32 mt7663e_reg_map[] = {
 	[MT_EFUSE_ADDR_BASE]	= 0x78011000,
 };
 
-u32 mt7615_reg_map(struct mt7615_dev *dev, u32 addr)
-{
-	u32 base, offset;
-
-	if (is_mt7663(&dev->mt76)) {
-		base = addr & MT7663_MCU_PCIE_REMAP_2_BASE;
-		offset = addr & MT7663_MCU_PCIE_REMAP_2_OFFSET;
-	} else {
-		base = addr & MT_MCU_PCIE_REMAP_2_BASE;
-		offset = addr & MT_MCU_PCIE_REMAP_2_OFFSET;
-	}
-	mt76_wr(dev, MT_MCU_PCIE_REMAP_2, base);
-
-	return MT_PCIE_REMAP_BASE_2 + offset;
-}
-
 static void
 mt7615_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 087d4886162e..43591b4c1d9a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -376,6 +376,12 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 		      int irq, const u32 *map);
 u32 mt7615_reg_map(struct mt7615_dev *dev, u32 addr);
 
+u32 mt7615_reg_map(struct mt7615_dev *dev, u32 addr);
+int mt7615_led_set_blink(struct led_classdev *led_cdev,
+			 unsigned long *delay_on,
+			 unsigned long *delay_off);
+void mt7615_led_set_brightness(struct led_classdev *led_cdev,
+			       enum led_brightness brightness);
 void mt7615_init_device(struct mt7615_dev *dev);
 int mt7615_register_device(struct mt7615_dev *dev);
 void mt7615_unregister_device(struct mt7615_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index 506a3b561d4a..0680e002b981 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -66,64 +66,6 @@ static int mt7615_init_hardware(struct mt7615_dev *dev)
 	return 0;
 }
 
-static void
-mt7615_led_set_config(struct led_classdev *led_cdev,
-		      u8 delay_on, u8 delay_off)
-{
-	struct mt7615_dev *dev;
-	struct mt76_phy *mphy;
-	u32 val, addr;
-
-	mphy = container_of(led_cdev, struct mt76_phy, leds.cdev);
-	dev = container_of(mphy->dev, struct mt7615_dev, mt76);
-
-	if (!mt76_connac_pm_ref(mphy, &dev->pm))
-		return;
-
-	val = FIELD_PREP(MT_LED_STATUS_DURATION, 0xffff) |
-	      FIELD_PREP(MT_LED_STATUS_OFF, delay_off) |
-	      FIELD_PREP(MT_LED_STATUS_ON, delay_on);
-
-	addr = mt7615_reg_map(dev, MT_LED_STATUS_0(mphy->leds.pin));
-	mt76_wr(dev, addr, val);
-	addr = mt7615_reg_map(dev, MT_LED_STATUS_1(mphy->leds.pin));
-	mt76_wr(dev, addr, val);
-
-	val = MT_LED_CTRL_REPLAY(mphy->leds.pin) |
-	      MT_LED_CTRL_KICK(mphy->leds.pin);
-	if (mphy->leds.al)
-		val |= MT_LED_CTRL_POLARITY(mphy->leds.pin);
-	addr = mt7615_reg_map(dev, MT_LED_CTRL);
-	mt76_wr(dev, addr, val);
-
-	mt76_connac_pm_unref(mphy, &dev->pm);
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
 int mt7615_register_device(struct mt7615_dev *dev)
 {
 	int ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index fa1b9b26b399..7cecb22c569e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -544,6 +544,7 @@ enum mt7615_reg_base {
 #define MT_LED_CTRL_POLARITY(_n)	BIT(1 + (8 * (_n)))
 #define MT_LED_CTRL_TX_BLINK_MODE(_n)	BIT(2 + (8 * (_n)))
 #define MT_LED_CTRL_TX_MANUAL_BLINK(_n)	BIT(3 + (8 * (_n)))
+#define MT_LED_CTRL_BAND(_n)		BIT(4 + (8 * (_n)))
 #define MT_LED_CTRL_TX_OVER_BLINK(_n)	BIT(5 + (8 * (_n)))
 #define MT_LED_CTRL_KICK(_n)		BIT(7 + (8 * (_n)))
 
-- 
2.38.1

