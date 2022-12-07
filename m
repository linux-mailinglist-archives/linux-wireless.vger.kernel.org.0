Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E1C645E91
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 17:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiLGQUO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 11:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiLGQUM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 11:20:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCD463BB0
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 08:20:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE40B61A8E
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 16:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2813C433D6;
        Wed,  7 Dec 2022 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670430010;
        bh=c6LYEbxhoLNVhgph1a5LfYBFy4FX6Dl8pJz3TdTHvGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kuFhSmRUNza+7wrwHUmJ91tj/j3HPS7NEcpB1e/Czdxto/8yXGR7o44p8dj8Ufvuf
         c+WOky4m54djXcg5NKdCI5W4a14lZA2C1jrpVmI3tM7r4QgxiATpfuqtCZ3TLFtVm7
         ymOQK+etdj4Dba/cMk+gd+iTSAxdGi9EQUSiVCSnwt5ucoECnNnxLPW3BkBy6CNdUO
         89bhmYX9Ta6bapOYqLFsTffR71BAwGtTbp4N8m7Fpi+ymq/sd0r85ew2zj794zJBa9
         0HcGLD8q/hIH8vEhSIptpOpqd0RTwEj1+WQMUy00PPZAVwRasZljK4gOMi7Zybn0RY
         lww9ZdSszVvQw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, frank-w@public-files.de
Subject: [PATCH 2/4] wifi: mt76: move leds struct in mt76_phy
Date:   Wed,  7 Dec 2022 17:19:43 +0100
Message-Id: <2fad074178be3c43ca019ba54006f8bc37bae226.1670429695.git.lorenzo@kernel.org>
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

Move leds struct in mt76_phy in order to have leds associated to phy
(e.g. in dbdc mode) instead of per device.

Tested-by: Frank Wunderlich <frank-w@public-files.de>
Co-developed-by: Ryder Lee <ryder.Lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.Lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/debugfs.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c | 48 +++++++++++--------
 drivers/net/wireless/mediatek/mt76/mt76.h     | 14 +++---
 .../net/wireless/mediatek/mt76/mt7603/init.c  | 30 ++++++------
 .../wireless/mediatek/mt76/mt7615/pci_init.c  | 26 +++++-----
 .../net/wireless/mediatek/mt76/mt76x02_util.c | 31 ++++++------
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 14 +++---
 .../net/wireless/mediatek/mt76/mt7996/init.c  | 14 +++---
 8 files changed, 92 insertions(+), 87 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/debugfs.c b/drivers/net/wireless/mediatek/mt76/debugfs.c
index 5579b67d686c..57fbcc83e074 100644
--- a/drivers/net/wireless/mediatek/mt76/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/debugfs.c
@@ -112,7 +112,7 @@ mt76_register_debugfs_fops(struct mt76_phy *phy,
 	if (!dir)
 		return NULL;
 
-	debugfs_create_u8("led_pin", 0600, dir, &dev->leds.pin);
+	debugfs_create_u8("led_pin", 0600, dir, &phy->leds.pin);
 	debugfs_create_u32("regidx", 0600, dir, &dev->debugfs_reg);
 	debugfs_create_file_unsafe("regval", 0600, dir, dev, fops);
 	debugfs_create_file_unsafe("napi_threaded", 0600, dir, dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 96ce7811b630..ad7274de5694 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -192,42 +192,48 @@ static const struct cfg80211_sar_capa mt76_sar_capa = {
 	.freq_ranges = &mt76_sar_freq_ranges[0],
 };
 
-static int mt76_led_init(struct mt76_dev *dev)
+static int mt76_led_init(struct mt76_phy *phy)
 {
-	struct device_node *np = dev->dev->of_node;
-	struct ieee80211_hw *hw = dev->hw;
-	int led_pin;
+	struct mt76_dev *dev = phy->dev;
+	struct ieee80211_hw *hw = phy->hw;
 
-	if (!dev->leds.cdev.brightness_set && !dev->leds.cdev.blink_set)
+	if (!phy->leds.cdev.brightness_set && !phy->leds.cdev.blink_set)
 		return 0;
 
-	snprintf(dev->leds.name, sizeof(dev->leds.name),
-		 "mt76-%s", wiphy_name(hw->wiphy));
+	snprintf(phy->leds.name, sizeof(phy->leds.name), "mt76-%s",
+		 wiphy_name(hw->wiphy));
 
-	dev->leds.cdev.name = dev->leds.name;
-	dev->leds.cdev.default_trigger =
+	phy->leds.cdev.name = phy->leds.name;
+	phy->leds.cdev.default_trigger =
 		ieee80211_create_tpt_led_trigger(hw,
 					IEEE80211_TPT_LEDTRIG_FL_RADIO,
 					mt76_tpt_blink,
 					ARRAY_SIZE(mt76_tpt_blink));
 
-	np = of_get_child_by_name(np, "led");
-	if (np) {
-		if (!of_property_read_u32(np, "led-sources", &led_pin))
-			dev->leds.pin = led_pin;
-		dev->leds.al = of_property_read_bool(np, "led-active-low");
-		of_node_put(np);
+	if (phy == &dev->phy) {
+		struct device_node *np = dev->dev->of_node;
+
+		np = of_get_child_by_name(np, "led");
+		if (np) {
+			int led_pin;
+
+			if (!of_property_read_u32(np, "led-sources", &led_pin))
+				phy->leds.pin = led_pin;
+			phy->leds.al = of_property_read_bool(np,
+							     "led-active-low");
+			of_node_put(np);
+		}
 	}
 
-	return led_classdev_register(dev->dev, &dev->leds.cdev);
+	return led_classdev_register(dev->dev, &phy->leds.cdev);
 }
 
-static void mt76_led_cleanup(struct mt76_dev *dev)
+static void mt76_led_cleanup(struct mt76_phy *phy)
 {
-	if (!dev->leds.cdev.brightness_set && !dev->leds.cdev.blink_set)
+	if (!phy->leds.cdev.brightness_set && !phy->leds.cdev.blink_set)
 		return;
 
-	led_classdev_unregister(&dev->leds.cdev);
+	led_classdev_unregister(&phy->leds.cdev);
 }
 
 static void mt76_init_stream_cap(struct mt76_phy *phy,
@@ -653,7 +659,7 @@ int mt76_register_device(struct mt76_dev *dev, bool vht,
 	mt76_check_sband(&dev->phy, &phy->sband_6g, NL80211_BAND_6GHZ);
 
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-		ret = mt76_led_init(dev);
+		ret = mt76_led_init(phy);
 		if (ret)
 			return ret;
 	}
@@ -674,7 +680,7 @@ void mt76_unregister_device(struct mt76_dev *dev)
 	struct ieee80211_hw *hw = dev->hw;
 
 	if (IS_ENABLED(CONFIG_MT76_LEDS))
-		mt76_led_cleanup(dev);
+		mt76_led_cleanup(&dev->phy);
 	mt76_tx_status_check(dev, true);
 	ieee80211_unregister_hw(hw);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 8c34b1f8acc0..1037d23bc4d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -731,6 +731,13 @@ struct mt76_phy {
 	} rx_amsdu[__MT_RXQ_MAX];
 
 	struct mt76_freq_range_power *frp;
+
+	struct {
+		struct led_classdev cdev;
+		char name[32];
+		bool al;
+		u8 pin;
+	} leds;
 };
 
 struct mt76_dev {
@@ -830,13 +837,6 @@ struct mt76_dev {
 		struct mt76_usb usb;
 		struct mt76_sdio sdio;
 	};
-
-	struct {
-		struct led_classdev cdev;
-		char name[32];
-		bool al;
-		u8 pin;
-	} leds;
 };
 
 struct mt76_power_limits {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index a44c7b3a6e02..9a2e632d577a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -330,10 +330,10 @@ static const struct ieee80211_iface_combination if_comb[] = {
 	}
 };
 
-static void mt7603_led_set_config(struct mt76_dev *mt76, u8 delay_on,
+static void mt7603_led_set_config(struct mt76_phy *mphy, u8 delay_on,
 				  u8 delay_off)
 {
-	struct mt7603_dev *dev = container_of(mt76, struct mt7603_dev,
+	struct mt7603_dev *dev = container_of(mphy->dev, struct mt7603_dev,
 					      mt76);
 	u32 val, addr;
 
@@ -341,15 +341,15 @@ static void mt7603_led_set_config(struct mt76_dev *mt76, u8 delay_on,
 	      FIELD_PREP(MT_LED_STATUS_OFF, delay_off) |
 	      FIELD_PREP(MT_LED_STATUS_ON, delay_on);
 
-	addr = mt7603_reg_map(dev, MT_LED_STATUS_0(mt76->leds.pin));
+	addr = mt7603_reg_map(dev, MT_LED_STATUS_0(mphy->leds.pin));
 	mt76_wr(dev, addr, val);
-	addr = mt7603_reg_map(dev, MT_LED_STATUS_1(mt76->leds.pin));
+	addr = mt7603_reg_map(dev, MT_LED_STATUS_1(mphy->leds.pin));
 	mt76_wr(dev, addr, val);
 
-	val = MT_LED_CTRL_REPLAY(mt76->leds.pin) |
-	      MT_LED_CTRL_KICK(mt76->leds.pin);
-	if (mt76->leds.al)
-		val |= MT_LED_CTRL_POLARITY(mt76->leds.pin);
+	val = MT_LED_CTRL_REPLAY(mphy->leds.pin) |
+	      MT_LED_CTRL_KICK(mphy->leds.pin);
+	if (mphy->leds.al)
+		val |= MT_LED_CTRL_POLARITY(mphy->leds.pin);
 	addr = mt7603_reg_map(dev, MT_LED_CTRL);
 	mt76_wr(dev, addr, val);
 }
@@ -358,27 +358,27 @@ static int mt7603_led_set_blink(struct led_classdev *led_cdev,
 				unsigned long *delay_on,
 				unsigned long *delay_off)
 {
-	struct mt76_dev *mt76 = container_of(led_cdev, struct mt76_dev,
+	struct mt76_phy *mphy = container_of(led_cdev, struct mt76_phy,
 					     leds.cdev);
 	u8 delta_on, delta_off;
 
 	delta_off = max_t(u8, *delay_off / 10, 1);
 	delta_on = max_t(u8, *delay_on / 10, 1);
 
-	mt7603_led_set_config(mt76, delta_on, delta_off);
+	mt7603_led_set_config(mphy, delta_on, delta_off);
 	return 0;
 }
 
 static void mt7603_led_set_brightness(struct led_classdev *led_cdev,
 				      enum led_brightness brightness)
 {
-	struct mt76_dev *mt76 = container_of(led_cdev, struct mt76_dev,
+	struct mt76_phy *mphy = container_of(led_cdev, struct mt76_phy,
 					     leds.cdev);
 
 	if (!brightness)
-		mt7603_led_set_config(mt76, 0, 0xff);
+		mt7603_led_set_config(mphy, 0, 0xff);
 	else
-		mt7603_led_set_config(mt76, 0xff, 0);
+		mt7603_led_set_config(mphy, 0xff, 0);
 }
 
 static u32 __mt7603_reg_addr(struct mt7603_dev *dev, u32 addr)
@@ -535,8 +535,8 @@ int mt7603_register_device(struct mt7603_dev *dev)
 
 	/* init led callbacks */
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-		dev->mt76.leds.cdev.brightness_set = mt7603_led_set_brightness;
-		dev->mt76.leds.cdev.blink_set = mt7603_led_set_blink;
+		dev->mphy.leds.cdev.brightness_set = mt7603_led_set_brightness;
+		dev->mphy.leds.cdev.blink_set = mt7603_led_set_blink;
 	}
 
 	wiphy->reg_notifier = mt7603_regd_notifier;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index 944bae068dab..506a3b561d4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -71,32 +71,32 @@ mt7615_led_set_config(struct led_classdev *led_cdev,
 		      u8 delay_on, u8 delay_off)
 {
 	struct mt7615_dev *dev;
-	struct mt76_dev *mt76;
+	struct mt76_phy *mphy;
 	u32 val, addr;
 
-	mt76 = container_of(led_cdev, struct mt76_dev, leds.cdev);
-	dev = container_of(mt76, struct mt7615_dev, mt76);
+	mphy = container_of(led_cdev, struct mt76_phy, leds.cdev);
+	dev = container_of(mphy->dev, struct mt7615_dev, mt76);
 
-	if (!mt76_connac_pm_ref(&dev->mphy, &dev->pm))
+	if (!mt76_connac_pm_ref(mphy, &dev->pm))
 		return;
 
 	val = FIELD_PREP(MT_LED_STATUS_DURATION, 0xffff) |
 	      FIELD_PREP(MT_LED_STATUS_OFF, delay_off) |
 	      FIELD_PREP(MT_LED_STATUS_ON, delay_on);
 
-	addr = mt7615_reg_map(dev, MT_LED_STATUS_0(mt76->leds.pin));
+	addr = mt7615_reg_map(dev, MT_LED_STATUS_0(mphy->leds.pin));
 	mt76_wr(dev, addr, val);
-	addr = mt7615_reg_map(dev, MT_LED_STATUS_1(mt76->leds.pin));
+	addr = mt7615_reg_map(dev, MT_LED_STATUS_1(mphy->leds.pin));
 	mt76_wr(dev, addr, val);
 
-	val = MT_LED_CTRL_REPLAY(mt76->leds.pin) |
-	      MT_LED_CTRL_KICK(mt76->leds.pin);
-	if (mt76->leds.al)
-		val |= MT_LED_CTRL_POLARITY(mt76->leds.pin);
+	val = MT_LED_CTRL_REPLAY(mphy->leds.pin) |
+	      MT_LED_CTRL_KICK(mphy->leds.pin);
+	if (mphy->leds.al)
+		val |= MT_LED_CTRL_POLARITY(mphy->leds.pin);
 	addr = mt7615_reg_map(dev, MT_LED_CTRL);
 	mt76_wr(dev, addr, val);
 
-	mt76_connac_pm_unref(&dev->mphy, &dev->pm);
+	mt76_connac_pm_unref(mphy, &dev->pm);
 }
 
 static int
@@ -133,8 +133,8 @@ int mt7615_register_device(struct mt7615_dev *dev)
 
 	/* init led callbacks */
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-		dev->mt76.leds.cdev.brightness_set = mt7615_led_set_brightness;
-		dev->mt76.leds.cdev.blink_set = mt7615_led_set_blink;
+		dev->mphy.leds.cdev.brightness_set = mt7615_led_set_brightness;
+		dev->mphy.leds.cdev.blink_set = mt7615_led_set_blink;
 	}
 
 	ret = mt7622_wmac_init(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 56abc1bdb9fb..7451a63206a5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -87,10 +87,9 @@ static const struct ieee80211_iface_combination mt76x02u_if_comb[] = {
 };
 
 static void
-mt76x02_led_set_config(struct mt76_dev *mdev, u8 delay_on,
-		       u8 delay_off)
+mt76x02_led_set_config(struct mt76_phy *mphy, u8 delay_on, u8 delay_off)
 {
-	struct mt76x02_dev *dev = container_of(mdev, struct mt76x02_dev,
+	struct mt76x02_dev *dev = container_of(mphy->dev, struct mt76x02_dev,
 					       mt76);
 	u32 val;
 
@@ -98,13 +97,13 @@ mt76x02_led_set_config(struct mt76_dev *mdev, u8 delay_on,
 	      FIELD_PREP(MT_LED_STATUS_OFF, delay_off) |
 	      FIELD_PREP(MT_LED_STATUS_ON, delay_on);
 
-	mt76_wr(dev, MT_LED_S0(mdev->leds.pin), val);
-	mt76_wr(dev, MT_LED_S1(mdev->leds.pin), val);
+	mt76_wr(dev, MT_LED_S0(mphy->leds.pin), val);
+	mt76_wr(dev, MT_LED_S1(mphy->leds.pin), val);
 
-	val = MT_LED_CTRL_REPLAY(mdev->leds.pin) |
-	      MT_LED_CTRL_KICK(mdev->leds.pin);
-	if (mdev->leds.al)
-		val |= MT_LED_CTRL_POLARITY(mdev->leds.pin);
+	val = MT_LED_CTRL_REPLAY(mphy->leds.pin) |
+	      MT_LED_CTRL_KICK(mphy->leds.pin);
+	if (mphy->leds.al)
+		val |= MT_LED_CTRL_POLARITY(mphy->leds.pin);
 	mt76_wr(dev, MT_LED_CTRL, val);
 }
 
@@ -113,14 +112,14 @@ mt76x02_led_set_blink(struct led_classdev *led_cdev,
 		      unsigned long *delay_on,
 		      unsigned long *delay_off)
 {
-	struct mt76_dev *mdev = container_of(led_cdev, struct mt76_dev,
+	struct mt76_phy *mphy = container_of(led_cdev, struct mt76_phy,
 					     leds.cdev);
 	u8 delta_on, delta_off;
 
 	delta_off = max_t(u8, *delay_off / 10, 1);
 	delta_on = max_t(u8, *delay_on / 10, 1);
 
-	mt76x02_led_set_config(mdev, delta_on, delta_off);
+	mt76x02_led_set_config(mphy, delta_on, delta_off);
 
 	return 0;
 }
@@ -129,13 +128,13 @@ static void
 mt76x02_led_set_brightness(struct led_classdev *led_cdev,
 			   enum led_brightness brightness)
 {
-	struct mt76_dev *mdev = container_of(led_cdev, struct mt76_dev,
+	struct mt76_phy *mphy = container_of(led_cdev, struct mt76_phy,
 					     leds.cdev);
 
 	if (!brightness)
-		mt76x02_led_set_config(mdev, 0, 0xff);
+		mt76x02_led_set_config(mphy, 0, 0xff);
 	else
-		mt76x02_led_set_config(mdev, 0xff, 0);
+		mt76x02_led_set_config(mphy, 0xff, 0);
 }
 
 int mt76x02_init_device(struct mt76x02_dev *dev)
@@ -167,9 +166,9 @@ int mt76x02_init_device(struct mt76x02_dev *dev)
 
 		/* init led callbacks */
 		if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-			dev->mt76.leds.cdev.brightness_set =
+			dev->mphy.leds.cdev.brightness_set =
 					mt76x02_led_set_brightness;
-			dev->mt76.leds.cdev.blink_set = mt76x02_led_set_blink;
+			dev->mphy.leds.cdev.blink_set = mt76x02_led_set_blink;
 		}
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index bae6c2701323..f7b8675e940c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -209,11 +209,11 @@ static void mt7915_led_set_config(struct led_classdev *led_cdev,
 				  u8 delay_on, u8 delay_off)
 {
 	struct mt7915_dev *dev;
-	struct mt76_dev *mt76;
+	struct mt76_phy *mphy;
 	u32 val;
 
-	mt76 = container_of(led_cdev, struct mt76_dev, leds.cdev);
-	dev = container_of(mt76, struct mt7915_dev, mt76);
+	mphy = container_of(led_cdev, struct mt76_phy, leds.cdev);
+	dev = container_of(mphy->dev, struct mt7915_dev, mt76);
 
 	/* select TX blink mode, 2: only data frames */
 	mt76_rmw_field(dev, MT_TMAC_TCR0(0), MT_TMAC_TCR0_TX_BLINK, 2);
@@ -228,7 +228,7 @@ static void mt7915_led_set_config(struct led_classdev *led_cdev,
 
 	/* control LED */
 	val = MT_LED_CTRL_BLINK_MODE | MT_LED_CTRL_KICK;
-	if (dev->mt76.leds.al)
+	if (mphy->leds.al)
 		val |= MT_LED_CTRL_POLARITY;
 
 	mt76_wr(dev, MT_LED_CTRL(0), val);
@@ -498,7 +498,7 @@ void mt7915_mac_init(struct mt7915_dev *dev)
 		mt7915_mac_init_band(dev, i);
 
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-		i = dev->mt76.leds.pin ? MT_LED_GPIO_MUX3 : MT_LED_GPIO_MUX2;
+		i = dev->mphy.leds.pin ? MT_LED_GPIO_MUX3 : MT_LED_GPIO_MUX2;
 		mt76_rmw_field(dev, i, MT_LED_GPIO_SEL_MASK, 4);
 	}
 }
@@ -1141,8 +1141,8 @@ int mt7915_register_device(struct mt7915_dev *dev)
 
 	/* init led callbacks */
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-		dev->mt76.leds.cdev.brightness_set = mt7915_led_set_brightness;
-		dev->mt76.leds.cdev.blink_set = mt7915_led_set_blink;
+		dev->mphy.leds.cdev.brightness_set = mt7915_led_set_brightness;
+		dev->mphy.leds.cdev.blink_set = mt7915_led_set_blink;
 	}
 
 	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 2923606d5f5e..64e8dfd06e9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -46,11 +46,11 @@ static void mt7996_led_set_config(struct led_classdev *led_cdev,
 				  u8 delay_on, u8 delay_off)
 {
 	struct mt7996_dev *dev;
-	struct mt76_dev *mt76;
+	struct mt76_phy *mphy;
 	u32 val;
 
-	mt76 = container_of(led_cdev, struct mt76_dev, leds.cdev);
-	dev = container_of(mt76, struct mt7996_dev, mt76);
+	mphy = container_of(led_cdev, struct mt76_phy, leds.cdev);
+	dev = container_of(mphy->dev, struct mt7996_dev, mt76);
 
 	/* select TX blink mode, 2: only data frames */
 	mt76_rmw_field(dev, MT_TMAC_TCR0(0), MT_TMAC_TCR0_TX_BLINK, 2);
@@ -65,7 +65,7 @@ static void mt7996_led_set_config(struct led_classdev *led_cdev,
 
 	/* control LED */
 	val = MT_LED_CTRL_BLINK_MODE | MT_LED_CTRL_KICK;
-	if (dev->mt76.leds.al)
+	if (mphy->leds.al)
 		val |= MT_LED_CTRL_POLARITY;
 
 	mt76_wr(dev, MT_LED_CTRL(0), val);
@@ -261,7 +261,7 @@ static void mt7996_mac_init(struct mt7996_dev *dev)
 				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-		i = dev->mt76.leds.pin ? MT_LED_GPIO_MUX3 : MT_LED_GPIO_MUX2;
+		i = dev->mphy.leds.pin ? MT_LED_GPIO_MUX3 : MT_LED_GPIO_MUX2;
 		mt76_rmw_field(dev, i, MT_LED_GPIO_SEL_MASK, 4);
 	}
 
@@ -787,8 +787,8 @@ int mt7996_register_device(struct mt7996_dev *dev)
 
 	/* init led callbacks */
 	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-		dev->mt76.leds.cdev.brightness_set = mt7996_led_set_brightness;
-		dev->mt76.leds.cdev.blink_set = mt7996_led_set_blink;
+		dev->mphy.leds.cdev.brightness_set = mt7996_led_set_brightness;
+		dev->mphy.leds.cdev.blink_set = mt7996_led_set_blink;
 	}
 
 	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
-- 
2.38.1

