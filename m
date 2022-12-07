Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8D7645E90
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 17:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiLGQUM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 11:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiLGQUK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 11:20:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D37B63BA7
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 08:20:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E08F1B81EC2
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 16:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A4CC433C1;
        Wed,  7 Dec 2022 16:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670430006;
        bh=LMAPxS2ILkUQW8OGcUhpCgiA9iYeocW5pO1VkcJjFVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M+pJqC1q8adVE8V+QbYPXaCXxv40bujDwA+TkDaBmh2bDriwV86nXZLXD1YaR5X1W
         xCn53bE7vegMhFG5VCqubOoPE2dp7GWErOLVPwnZA+cWBYJpNO0fU7A0ReHSF8TkOn
         C6qPhAExhzUhn+P7oGMEvicT+287eIqWB3mvHOtzr7c2bdkwyWSlgZd2pdtAN3vPmP
         Ygs0b0SKqS7Be+j5XN7mc5W3Biy4R+jJIl9vtKNBR4Btzh7y/5I+WKPvR7GYWVfmmP
         XAozZnaGZmb3cVd8NDn9zIRn9sdIZb18ZCA1A4G2t/ZjSwLiYzR6YzYXhzniZQnjgz
         m2ldo5HplcI5Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, frank-w@public-files.de
Subject: [PATCH 1/4] wifi: mt76: move leds field in leds struct
Date:   Wed,  7 Dec 2022 17:19:42 +0100
Message-Id: <bcee5455cfbbdec164a3c1a98fabc183ddc5f11d.1670429695.git.lorenzo@kernel.org>
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

This is a preliminary patch to support per-phy leds.

Tested-by: Frank Wunderlich <frank-w@public-files.de>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c | 18 ++++++++---------
 drivers/net/wireless/mediatek/mt76/mt76.h     | 12 ++++++-----
 .../net/wireless/mediatek/mt76/mt7603/init.c  | 20 +++++++++----------
 .../wireless/mediatek/mt76/mt7615/pci_init.c  | 18 ++++++++---------
 .../net/wireless/mediatek/mt76/mt76x02_util.c | 20 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 10 +++++-----
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 10 +++++-----
 8 files changed, 56 insertions(+), 54 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index 11b0b3d62f29..5579b67d686c 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -112,7 +112,7 @@ mt76_register_debugfs_fops(struct mt76_phy *phy,
 	if (!dir)
 		return NULL;
 
-	debugfs_create_u8("led_pin", 0600, dir, &dev->led_pin);
+	debugfs_create_u8("led_pin", 0600, dir, &dev->leds.pin);
 	debugfs_create_u32("regidx", 0600, dir, &dev->debugfs_reg);
 	debugfs_create_file_unsafe("regval", 0600, dir, dev, fops);
 	debugfs_create_file_unsafe("napi_threaded", 0600, dir, dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index fc608b369b3c..96ce7811b630 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -198,14 +198,14 @@ static int mt76_led_init(struct mt76_dev *dev)
 	struct ieee80211_hw *hw = dev->hw;
 	int led_pin;
 
-	if (!dev->led_cdev.brightness_set && !dev->led_cdev.blink_set)
+	if (!dev->leds.cdev.brightness_set && !dev->leds.cdev.blink_set)
 		return 0;
 
-	snprintf(dev->led_name, sizeof(dev->led_name),
+	snprintf(dev->leds.name, sizeof(dev->leds.name),
 		 "mt76-%s", wiphy_name(hw->wiphy));
 
-	dev->led_cdev.name = dev->led_name;
-	dev->led_cdev.default_trigger =
+	dev->leds.cdev.name = dev->leds.name;
+	dev->leds.cdev.default_trigger =
 		ieee80211_create_tpt_led_trigger(hw,
 					IEEE80211_TPT_LEDTRIG_FL_RADIO,
 					mt76_tpt_blink,
@@ -214,20 +214,20 @@ static int mt76_led_init(struct mt76_dev *dev)
 	np = of_get_child_by_name(np, "led");
 	if (np) {
 		if (!of_property_read_u32(np, "led-sources", &led_pin))
-			dev->led_pin = led_pin;
-		dev->led_al = of_property_read_bool(np, "led-active-low");
+			dev->leds.pin = led_pin;
+		dev->leds.al = of_property_read_bool(np, "led-active-low");
 		of_node_put(np);
 	}
 
-	return led_classdev_register(dev->dev, &dev->led_cdev);
+	return led_classdev_register(dev->dev, &dev->leds.cdev);
 }
 
 static void mt76_led_cleanup(struct mt76_dev *dev)
 {
-	if (!dev->led_cdev.brightness_set && !dev->led_cdev.blink_set)
+	if (!dev->leds.cdev.brightness_set && !dev->leds.cdev.blink_set)
 		return;
 
-	led_classdev_unregister(&dev->led_cdev);
+	led_classdev_unregister(&dev->leds.cdev);
 }
 
 static void mt76_init_stream_cap(struct mt76_phy *phy,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 32a77a0ae9da..8c34b1f8acc0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -812,11 +812,6 @@ struct mt76_dev {
 
 	u32 debugfs_reg;
 
-	struct led_classdev led_cdev;
-	char led_name[32];
-	bool led_al;
-	u8 led_pin;
-
 	u8 csa_complete;
 
 	u32 rxfilter;
@@ -835,6 +830,13 @@ struct mt76_dev {
 		struct mt76_usb usb;
 		struct mt76_sdio sdio;
 	};
+
+	struct {
+		struct led_classdev cdev;
+		char name[32];
+		bool al;
+		u8 pin;
+	} leds;
 };
 
 struct mt76_power_limits {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 031d39a48a55..a44c7b3a6e02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -341,15 +341,15 @@ static void mt7603_led_set_config(struct mt76_dev *mt76, u8 delay_on,
 	      FIELD_PREP(MT_LED_STATUS_OFF, delay_off) |
 	      FIELD_PREP(MT_LED_STATUS_ON, delay_on);
 
-	addr = mt7603_reg_map(dev, MT_LED_STATUS_0(mt76->led_pin));
+	addr = mt7603_reg_map(dev, MT_LED_STATUS_0(mt76->leds.pin));
 	mt76_wr(dev, addr, val);
-	addr = mt7603_reg_map(dev, MT_LED_STATUS_1(mt76->led_pin));
+	addr = mt7603_reg_map(dev, MT_LED_STATUS_1(mt76->leds.pin));
 	mt76_wr(dev, addr, val);
 
-	val = MT_LED_CTRL_REPLAY(mt76->led_pin) |
-	      MT_LED_CTRL_KICK(mt76->led_pin);
-	if (mt76->led_al)
-		val |= MT_LED_CTRL_POLARITY(mt76->led_pin);
+	val = MT_LED_CTRL_REPLAY(mt76->leds.pin) |
+	      MT_LED_CTRL_KICK(mt76->leds.pin);
+	if (mt76->leds.al)
+		val |= MT_LED_CTRL_POLARITY(mt76->leds.pin);
 	addr = mt7603_reg_map(dev, MT_LED_CTRL);
 	mt76_wr(dev, addr, val);
 }
@@ -359,7 +359,7 @@ static int mt7603_led_set_blink(struct led_classdev *led_cdev,
 				unsigned long *delay_off)
 {
 	struct mt76_dev *mt76 = container_of(led_cdev, struct mt76_dev,
-					     led_cdev);
+					     leds.cdev);
 	u8 delta_on, delta_off;
 
 	delta_off = max_t(u8, *delay_off / 10, 1);
@@ -373,7 +373,7 @@ static void mt7603_led_set_brightness(struct led_classdev *led_cdev,
 				      enum led_brightness brightness)
 {
 	struct mt76_dev *mt76 = container_of(led_cdev, struct mt76_dev,
-					     led_cdev);
+					     leds.cdev);
 
 	if (!brightness)
 		mt7603_led_set_config(mt76, 0, 0xff);
@@ -535,8 +535,8 @@ int mt7603_register_device(struct mt7603_dev *dev)
 
 	/* init led callbacks */
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-		dev->mt76.led_cdev.brightness_set = mt7603_led_set_brightness;
-		dev->mt76.led_cdev.blink_set = mt7603_led_set_blink;
+		dev->mt76.leds.cdev.brightness_set = mt7603_led_set_brightness;
+		dev->mt76.leds.cdev.blink_set = mt7603_led_set_blink;
 	}
 
 	wiphy->reg_notifier = mt7603_regd_notifier;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index 87b4aa52ee0f..944bae068dab 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -74,7 +74,7 @@ mt7615_led_set_config(struct led_classdev *led_cdev,
 	struct mt76_dev *mt76;
 	u32 val, addr;
 
-	mt76 = container_of(led_cdev, struct mt76_dev, led_cdev);
+	mt76 = container_of(led_cdev, struct mt76_dev, leds.cdev);
 	dev = container_of(mt76, struct mt7615_dev, mt76);
 
 	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm))
@@ -84,15 +84,15 @@ mt7615_led_set_config(struct led_classdev *led_cdev,
 	      FIELD_PREP(MT_LED_STATUS_OFF, delay_off) |
 	      FIELD_PREP(MT_LED_STATUS_ON, delay_on);
 
-	addr = mt7615_reg_map(dev, MT_LED_STATUS_0(mt76->led_pin));
+	addr = mt7615_reg_map(dev, MT_LED_STATUS_0(mt76->leds.pin));
 	mt76_wr(dev, addr, val);
-	addr = mt7615_reg_map(dev, MT_LED_STATUS_1(mt76->led_pin));
+	addr = mt7615_reg_map(dev, MT_LED_STATUS_1(mt76->leds.pin));
 	mt76_wr(dev, addr, val);
 
-	val = MT_LED_CTRL_REPLAY(mt76->led_pin) |
-	      MT_LED_CTRL_KICK(mt76->led_pin);
-	if (mt76->led_al)
-		val |= MT_LED_CTRL_POLARITY(mt76->led_pin);
+	val = MT_LED_CTRL_REPLAY(mt76->leds.pin) |
+	      MT_LED_CTRL_KICK(mt76->leds.pin);
+	if (mt76->leds.al)
+		val |= MT_LED_CTRL_POLARITY(mt76->leds.pin);
 	addr = mt7615_reg_map(dev, MT_LED_CTRL);
 	mt76_wr(dev, addr, val);
 
@@ -133,8 +133,8 @@ int mt7615_register_device(struct mt7615_dev *dev)
 
 	/* init led callbacks */
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-		dev->mt76.led_cdev.brightness_set = mt7615_led_set_brightness;
-		dev->mt76.led_cdev.blink_set = mt7615_led_set_blink;
+		dev->mt76.leds.cdev.brightness_set = mt7615_led_set_brightness;
+		dev->mt76.leds.cdev.blink_set = mt7615_led_set_blink;
 	}
 
 	ret = mt7622_wmac_init(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 604ddcc21123..56abc1bdb9fb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -98,13 +98,13 @@ mt76x02_led_set_config(struct mt76_dev *mdev, u8 delay_on,
 	      FIELD_PREP(MT_LED_STATUS_OFF, delay_off) |
 	      FIELD_PREP(MT_LED_STATUS_ON, delay_on);
 
-	mt76_wr(dev, MT_LED_S0(mdev->led_pin), val);
-	mt76_wr(dev, MT_LED_S1(mdev->led_pin), val);
+	mt76_wr(dev, MT_LED_S0(mdev->leds.pin), val);
+	mt76_wr(dev, MT_LED_S1(mdev->leds.pin), val);
 
-	val = MT_LED_CTRL_REPLAY(mdev->led_pin) |
-	      MT_LED_CTRL_KICK(mdev->led_pin);
-	if (mdev->led_al)
-		val |= MT_LED_CTRL_POLARITY(mdev->led_pin);
+	val = MT_LED_CTRL_REPLAY(mdev->leds.pin) |
+	      MT_LED_CTRL_KICK(mdev->leds.pin);
+	if (mdev->leds.al)
+		val |= MT_LED_CTRL_POLARITY(mdev->leds.pin);
 	mt76_wr(dev, MT_LED_CTRL, val);
 }
 
@@ -114,7 +114,7 @@ mt76x02_led_set_blink(struct led_classdev *led_cdev,
 		      unsigned long *delay_off)
 {
 	struct mt76_dev *mdev = container_of(led_cdev, struct mt76_dev,
-					     led_cdev);
+					     leds.cdev);
 	u8 delta_on, delta_off;
 
 	delta_off = max_t(u8, *delay_off / 10, 1);
@@ -130,7 +130,7 @@ mt76x02_led_set_brightness(struct led_classdev *led_cdev,
 			   enum led_brightness brightness)
 {
 	struct mt76_dev *mdev = container_of(led_cdev, struct mt76_dev,
-					     led_cdev);
+					     leds.cdev);
 
 	if (!brightness)
 		mt76x02_led_set_config(mdev, 0, 0xff);
@@ -167,9 +167,9 @@ int mt76x02_init_device(struct mt76x02_dev *dev)
 
 		/* init led callbacks */
 		if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-			dev->mt76.led_cdev.brightness_set =
+			dev->mt76.leds.cdev.brightness_set =
 					mt76x02_led_set_brightness;
-			dev->mt76.led_cdev.blink_set = mt76x02_led_set_blink;
+			dev->mt76.leds.cdev.blink_set = mt76x02_led_set_blink;
 		}
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index c810c31fbd6e..bae6c2701323 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -212,7 +212,7 @@ static void mt7915_led_set_config(struct led_classdev *led_cdev,
 	struct mt76_dev *mt76;
 	u32 val;
 
-	mt76 = container_of(led_cdev, struct mt76_dev, led_cdev);
+	mt76 = container_of(led_cdev, struct mt76_dev, leds.cdev);
 	dev = container_of(mt76, struct mt7915_dev, mt76);
 
 	/* select TX blink mode, 2: only data frames */
@@ -228,7 +228,7 @@ static void mt7915_led_set_config(struct led_classdev *led_cdev,
 
 	/* control LED */
 	val = MT_LED_CTRL_BLINK_MODE | MT_LED_CTRL_KICK;
-	if (dev->mt76.led_al)
+	if (dev->mt76.leds.al)
 		val |= MT_LED_CTRL_POLARITY;
 
 	mt76_wr(dev, MT_LED_CTRL(0), val);
@@ -498,7 +498,7 @@ void mt7915_mac_init(struct mt7915_dev *dev)
 		mt7915_mac_init_band(dev, i);
 
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-		i = dev->mt76.led_pin ? MT_LED_GPIO_MUX3 : MT_LED_GPIO_MUX2;
+		i = dev->mt76.leds.pin ? MT_LED_GPIO_MUX3 : MT_LED_GPIO_MUX2;
 		mt76_rmw_field(dev, i, MT_LED_GPIO_SEL_MASK, 4);
 	}
 }
@@ -1141,8 +1141,8 @@ int mt7915_register_device(struct mt7915_dev *dev)
 
 	/* init led callbacks */
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-		dev->mt76.led_cdev.brightness_set = mt7915_led_set_brightness;
-		dev->mt76.led_cdev.blink_set = mt7915_led_set_blink;
+		dev->mt76.leds.cdev.brightness_set = mt7915_led_set_brightness;
+		dev->mt76.leds.cdev.blink_set = mt7915_led_set_blink;
 	}
 
 	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 46b290526092..2923606d5f5e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -49,7 +49,7 @@ static void mt7996_led_set_config(struct led_classdev *led_cdev,
 	struct mt76_dev *mt76;
 	u32 val;
 
-	mt76 = container_of(led_cdev, struct mt76_dev, led_cdev);
+	mt76 = container_of(led_cdev, struct mt76_dev, leds.cdev);
 	dev = container_of(mt76, struct mt7996_dev, mt76);
 
 	/* select TX blink mode, 2: only data frames */
@@ -65,7 +65,7 @@ static void mt7996_led_set_config(struct led_classdev *led_cdev,
 
 	/* control LED */
 	val = MT_LED_CTRL_BLINK_MODE | MT_LED_CTRL_KICK;
-	if (dev->mt76.led_al)
+	if (dev->mt76.leds.al)
 		val |= MT_LED_CTRL_POLARITY;
 
 	mt76_wr(dev, MT_LED_CTRL(0), val);
@@ -261,7 +261,7 @@ static void mt7996_mac_init(struct mt7996_dev *dev)
 				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-		i = dev->mt76.led_pin ? MT_LED_GPIO_MUX3 : MT_LED_GPIO_MUX2;
+		i = dev->mt76.leds.pin ? MT_LED_GPIO_MUX3 : MT_LED_GPIO_MUX2;
 		mt76_rmw_field(dev, i, MT_LED_GPIO_SEL_MASK, 4);
 	}
 
@@ -787,8 +787,8 @@ int mt7996_register_device(struct mt7996_dev *dev)
 
 	/* init led callbacks */
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-		dev->mt76.led_cdev.brightness_set = mt7996_led_set_brightness;
-		dev->mt76.led_cdev.blink_set = mt7996_led_set_blink;
+		dev->mt76.leds.cdev.brightness_set = mt7996_led_set_brightness;
+		dev->mt76.leds.cdev.blink_set = mt7996_led_set_blink;
 	}
 
 	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
-- 
2.38.1

