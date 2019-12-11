Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E59411AD43
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2019 15:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbfLKOVy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Dec 2019 09:21:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729671AbfLKOVx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Dec 2019 09:21:53 -0500
Received: from localhost.localdomain (unknown [151.66.51.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7447420836;
        Wed, 11 Dec 2019 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576074113;
        bh=oS1HX2Zz3pkj+fcsDVFQhTLyKHsA0rs2aYnadytMw7Q=;
        h=From:To:Cc:Subject:Date:From;
        b=MUW5j7VJmFxui5Fq0Ex4iyV4ZPicB3cXx5zfYnt5SNsYOHYC6u0WPifFcvKYVA+JW
         KEFiIXFYycWMlboKckAKSUyQNn8ZXpfFDCzcXJouirSHyW0B8wqL1ZfMvdn895vxv3
         OARXOvTQvlRVhwEmkYzO8jDVwfsAl134GyI4pc2w=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com
Subject: [PATCH] mt76: mt7615: introduce LED support
Date:   Wed, 11 Dec 2019 15:21:41 +0100
Message-Id: <378747af00fdd3e64e9f5d7724f1b84759f95e8f.1576074028.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Initialize brightness_set and blink_set callbacks to
mt7615_led_set_brightness and mt7615_led_set_blink in order to enable
LED support in mt7615 driver

Tested-by: Deng Qingfang <dengqf6@mail2.sysu.edu.cn>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 58 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/regs.h  | 27 +++++++++
 2 files changed, 85 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index eb7c6b9e3d4d..c25ba5fc3cdc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -196,6 +196,58 @@ static const struct ieee80211_iface_combination if_comb[] = {
 	}
 };
 
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
+	val = MT_LED_STATUS_DURATION(0xffff) |
+	      MT_LED_STATUS_OFF(delay_off) |
+	      MT_LED_STATUS_ON(delay_on);
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
 static void
 mt7615_init_txpower(struct mt7615_dev *dev,
 		    struct ieee80211_supported_band *sband)
@@ -383,6 +435,12 @@ int mt7615_register_device(struct mt7615_dev *dev)
 	mt7615_cap_dbdc_disable(dev);
 	dev->phy.dfs_state = -1;
 
+	/* init led callbacks */
+	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
+		dev->mt76.led_cdev.brightness_set = mt7615_led_set_brightness;
+		dev->mt76.led_cdev.blink_set = mt7615_led_set_blink;
+	}
+
 	ret = mt76_register_device(&dev->mt76, true, mt7615_rates,
 				   ARRAY_SIZE(mt7615_rates));
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 26d121646787..3234ae0761b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -345,6 +345,33 @@
 
 #define MT_TX_AGG_CNT(n)		MT_WF_MIB(0xa8 + ((n) << 2))
 
+#define MT_LED_BASE_PHYS		0x80024000
+#define MT_LED_PHYS(_n)			(MT_LED_BASE_PHYS + (_n))
+
+#define MT_LED_CTRL			MT_LED_PHYS(0x00)
+
+#define MT_LED_CTRL_REPLAY(_n)		BIT(0 + (8 * (_n)))
+#define MT_LED_CTRL_POLARITY(_n)	BIT(1 + (8 * (_n)))
+#define MT_LED_CTRL_TX_BLINK_MODE(_n)	BIT(2 + (8 * (_n)))
+#define MT_LED_CTRL_TX_MANUAL_BLINK(_n)	BIT(3 + (8 * (_n)))
+#define MT_LED_CTRL_TX_OVER_BLINK(_n)	BIT(5 + (8 * (_n)))
+#define MT_LED_CTRL_KICK(_n)		BIT(7 + (8 * (_n)))
+
+#define MT_LED_STATUS_0(_n)		MT_LED_PHYS(0x10 + ((_n) * 8))
+#define MT_LED_STATUS_1(_n)		MT_LED_PHYS(0x14 + ((_n) * 8))
+#define MT_LED_STATUS_OFF_MASK		GENMASK(31, 24)
+#define MT_LED_STATUS_OFF(_v)		(((_v) << \
+					  __ffs(MT_LED_STATUS_OFF_MASK)) & \
+					 MT_LED_STATUS_OFF_MASK)
+#define MT_LED_STATUS_ON_MASK		GENMASK(23, 16)
+#define MT_LED_STATUS_ON(_v)		(((_v) << \
+					  __ffs(MT_LED_STATUS_ON_MASK)) & \
+					 MT_LED_STATUS_ON_MASK)
+#define MT_LED_STATUS_DURATION_MASK	GENMASK(15, 0)
+#define MT_LED_STATUS_DURATION(_v)	(((_v) << \
+					  __ffs(MT_LED_STATUS_DURATION_MASK)) &\
+					 MT_LED_STATUS_DURATION_MASK)
+
 #define MT_EFUSE_BASE			0x81070000
 #define MT_EFUSE_BASE_CTRL		0x000
 #define MT_EFUSE_BASE_CTRL_EMPTY	BIT(30)
-- 
2.21.0

