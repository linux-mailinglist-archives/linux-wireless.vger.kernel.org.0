Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58A6645E92
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 17:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiLGQUS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 11:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiLGQUR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 11:20:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6FB63D50
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 08:20:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBD4261A8E
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 16:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B9EC433C1;
        Wed,  7 Dec 2022 16:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670430014;
        bh=0Q3Izb3iTBAcCoW3Hmw3F1D4m2axJqXzBOMAik2D73c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMx9vwDG4zP9qYvfNvbz4MZ6DtBsursJf0V9GK0id3CZpce/JMUdjSFoX8ZZ10AIZ
         5bO7swv8Nzpwbrh1KlgZgWYGDZJhERSq2di3Flytpg66opwQFHHrGu9xJIzbyXqAt3
         ZZTjUbPpyXPyaOsUWWAZrJ1QIZWUtSX09u8y/eJCd6hzLQOaZNI7TIsVo6T4ille5i
         l/RHCNMf68MPLP+Az+/eVnKofC7Y9nNFxLCUXFkYxz8zvA1BYyROdrGHYsYQCyg2LW
         VdnZQ9fMhf2Iuwxr5iBKUZMF1ekV7jFPjfsGetIgiGMJRumurB5hxghxsYJ4IueqEU
         OWJEP6yXhp5XQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, frank-w@public-files.de
Subject: [PATCH 3/4] wifi: mt76: mt7915: enable per-phy led support
Date:   Wed,  7 Dec 2022 17:19:44 +0100
Message-Id: <6332063e4f9735cf86eb64d11aafc2149d84523e.1670429695.git.lorenzo@kernel.org>
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

Tested-by: Frank Wunderlich <frank-w@public-files.de>
Co-developed-by: Ryder Lee <ryder.Lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.Lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c |   8 ++
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 118 ++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7915/regs.h  |  12 +-
 3 files changed, 109 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index ad7274de5694..7fe7f68acc24 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -523,6 +523,12 @@ int mt76_register_phy(struct mt76_phy *phy, bool vht,
 			return ret;
 	}
 
+	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
+		ret = mt76_led_init(phy);
+		if (ret)
+			return ret;
+	}
+
 	wiphy_read_of_freq_limits(phy->hw->wiphy);
 	mt76_check_sband(phy, &phy->sband_2g, NL80211_BAND_2GHZ);
 	mt76_check_sband(phy, &phy->sband_5g, NL80211_BAND_5GHZ);
@@ -542,6 +548,8 @@ void mt76_unregister_phy(struct mt76_phy *phy)
 {
 	struct mt76_dev *dev = phy->dev;
 
+	if (IS_ENABLED(CONFIG_MT76_LEDS))
+		mt76_led_cleanup(phy);
 	mt76_tx_status_check(dev, true);
 	ieee80211_unregister_hw(phy->hw);
 	dev->phys[phy->band_idx] = NULL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index f7b8675e940c..571c94835942 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -215,24 +215,25 @@ static void mt7915_led_set_config(struct led_classdev *led_cdev,
 	mphy = container_of(led_cdev, struct mt76_phy, leds.cdev);
 	dev = container_of(mphy->dev, struct mt7915_dev, mt76);
 
-	/* select TX blink mode, 2: only data frames */
-	mt76_rmw_field(dev, MT_TMAC_TCR0(0), MT_TMAC_TCR0_TX_BLINK, 2);
+	/* set PWM mode */
+	val = FIELD_PREP(MT_LED_STATUS_DURATION, 0xffff) |
+	      FIELD_PREP(MT_LED_STATUS_OFF, delay_off) |
+	      FIELD_PREP(MT_LED_STATUS_ON, delay_on);
+	mt76_wr(dev, MT_LED_STATUS_0(mphy->band_idx), val);
+	mt76_wr(dev, MT_LED_STATUS_1(mphy->band_idx), val);
 
 	/* enable LED */
-	mt76_wr(dev, MT_LED_EN(0), 1);
-
-	/* set LED Tx blink on/off time */
-	val = FIELD_PREP(MT_LED_TX_BLINK_ON_MASK, delay_on) |
-	      FIELD_PREP(MT_LED_TX_BLINK_OFF_MASK, delay_off);
-	mt76_wr(dev, MT_LED_TX_BLINK(0), val);
+	mt76_wr(dev, MT_LED_EN(mphy->band_idx), 1);
 
 	/* control LED */
-	val = MT_LED_CTRL_BLINK_MODE | MT_LED_CTRL_KICK;
-	if (mphy->leds.al)
+	val = MT_LED_CTRL_KICK;
+	if (dev->mphy.leds.al)
 		val |= MT_LED_CTRL_POLARITY;
+	if (mphy->band_idx)
+		val |= MT_LED_CTRL_BAND;
 
-	mt76_wr(dev, MT_LED_CTRL(0), val);
-	mt76_clear(dev, MT_LED_CTRL(0), MT_LED_CTRL_KICK);
+	mt76_wr(dev, MT_LED_CTRL(mphy->band_idx), val);
+	mt76_clear(dev, MT_LED_CTRL(mphy->band_idx), MT_LED_CTRL_KICK);
 }
 
 static int mt7915_led_set_blink(struct led_classdev *led_cdev,
@@ -319,9 +320,10 @@ mt7915_regd_notifier(struct wiphy *wiphy,
 }
 
 static void
-mt7915_init_wiphy(struct ieee80211_hw *hw)
+mt7915_init_wiphy(struct mt7915_phy *phy)
 {
-	struct mt7915_phy *phy = mt7915_hw_phy(hw);
+	struct mt76_phy *mphy = phy->mt76;
+	struct ieee80211_hw *hw = mphy->hw;
 	struct mt76_dev *mdev = &phy->dev->mt76;
 	struct wiphy *wiphy = hw->wiphy;
 	struct mt7915_dev *dev = phy->dev;
@@ -415,6 +417,12 @@ mt7915_init_wiphy(struct ieee80211_hw *hw)
 
 	wiphy->available_antennas_rx = phy->mt76->antenna_mask;
 	wiphy->available_antennas_tx = phy->mt76->antenna_mask;
+
+	/* init led callbacks */
+	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
+		mphy->leds.cdev.brightness_set = mt7915_led_set_brightness;
+		mphy->leds.cdev.blink_set = mt7915_led_set_blink;
+	}
 }
 
 static void
@@ -473,6 +481,72 @@ mt7915_mac_init_band(struct mt7915_dev *dev, u8 band)
 	mt76_rmw(dev, MT_WTBLOFF_TOP_RSCR(band), mask, set);
 }
 
+static void
+mt7915_init_led_mux(struct mt7915_dev *dev)
+{
+	if (!IS_ENABLED(CONFIG_MT76_LEDS))
+		return;
+
+	if (dev->dbdc_support) {
+		switch (mt76_chip(&dev->mt76)) {
+		case 0x7915:
+			mt76_rmw_field(dev, MT_LED_GPIO_MUX2,
+				       GENMASK(11, 8), 4);
+			mt76_rmw_field(dev, MT_LED_GPIO_MUX3,
+				       GENMASK(11, 8), 4);
+			break;
+		case 0x7986:
+			mt76_rmw_field(dev, MT_LED_GPIO_MUX0,
+				       GENMASK(7, 4), 1);
+			mt76_rmw_field(dev, MT_LED_GPIO_MUX0,
+				       GENMASK(11, 8), 1);
+			break;
+		case 0x7916:
+			mt76_rmw_field(dev, MT_LED_GPIO_MUX1,
+				       GENMASK(27, 24), 3);
+			mt76_rmw_field(dev, MT_LED_GPIO_MUX1,
+				       GENMASK(31, 28), 3);
+			break;
+		default:
+			break;
+		}
+	} else if (dev->mphy.leds.pin) {
+		switch (mt76_chip(&dev->mt76)) {
+		case 0x7915:
+			mt76_rmw_field(dev, MT_LED_GPIO_MUX3,
+				       GENMASK(11, 8), 4);
+			break;
+		case 0x7986:
+			mt76_rmw_field(dev, MT_LED_GPIO_MUX0,
+				       GENMASK(11, 8), 1);
+			break;
+		case 0x7916:
+			mt76_rmw_field(dev, MT_LED_GPIO_MUX1,
+				       GENMASK(31, 28), 3);
+			break;
+		default:
+			break;
+		}
+	} else {
+		switch (mt76_chip(&dev->mt76)) {
+		case 0x7915:
+			mt76_rmw_field(dev, MT_LED_GPIO_MUX2,
+				       GENMASK(11, 8), 4);
+			break;
+		case 0x7986:
+			mt76_rmw_field(dev, MT_LED_GPIO_MUX0,
+				       GENMASK(7, 4), 1);
+			break;
+		case 0x7916:
+			mt76_rmw_field(dev, MT_LED_GPIO_MUX1,
+				       GENMASK(27, 24), 3);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 void mt7915_mac_init(struct mt7915_dev *dev)
 {
 	int i;
@@ -497,10 +571,7 @@ void mt7915_mac_init(struct mt7915_dev *dev)
 	for (i = 0; i < 2; i++)
 		mt7915_mac_init_band(dev, i);
 
-	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-		i = dev->mphy.leds.pin ? MT_LED_GPIO_MUX3 : MT_LED_GPIO_MUX2;
-		mt76_rmw_field(dev, i, MT_LED_GPIO_SEL_MASK, 4);
-	}
+	mt7915_init_led_mux(dev);
 }
 
 int mt7915_txbf_init(struct mt7915_dev *dev)
@@ -569,7 +640,7 @@ mt7915_register_ext_phy(struct mt7915_dev *dev, struct mt7915_phy *phy)
 	mt76_eeprom_override(mphy);
 
 	/* init wiphy according to mphy and phy */
-	mt7915_init_wiphy(mphy->hw);
+	mt7915_init_wiphy(phy);
 
 	ret = mt76_register_phy(mphy, true, mt76_rates,
 				ARRAY_SIZE(mt76_rates));
@@ -1104,7 +1175,6 @@ static void mt7915_stop_hardware(struct mt7915_dev *dev)
 
 int mt7915_register_device(struct mt7915_dev *dev)
 {
-	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct mt7915_phy *phy2;
 	int ret;
 
@@ -1133,18 +1203,12 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	if (ret)
 		goto free_phy2;
 
-	mt7915_init_wiphy(hw);
+	mt7915_init_wiphy(&dev->phy);
 
 #ifdef CONFIG_NL80211_TESTMODE
 	dev->mt76.test_ops = &mt7915_testmode_ops;
 #endif
 
-	/* init led callbacks */
-	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
-		dev->mphy.leds.cdev.brightness_set = mt7915_led_set_brightness;
-		dev->mphy.leds.cdev.blink_set = mt7915_led_set_blink;
-	}
-
 	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
 				   ARRAY_SIZE(mt76_rates));
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index aca1b2f1e9e3..56ed97a90847 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -1055,6 +1055,7 @@ enum offs_rev {
 
 #define MT_LED_CTRL(_n)			MT_LED_PHYS(0x00 + ((_n) * 4))
 #define MT_LED_CTRL_KICK		BIT(7)
+#define MT_LED_CTRL_BAND		BIT(4)
 #define MT_LED_CTRL_BLINK_MODE		BIT(2)
 #define MT_LED_CTRL_POLARITY		BIT(1)
 
@@ -1062,11 +1063,18 @@ enum offs_rev {
 #define MT_LED_TX_BLINK_ON_MASK		GENMASK(7, 0)
 #define MT_LED_TX_BLINK_OFF_MASK        GENMASK(15, 8)
 
+#define MT_LED_STATUS_0(_n)		MT_LED_PHYS(0x20 + ((_n) * 8))
+#define MT_LED_STATUS_1(_n)		MT_LED_PHYS(0x24 + ((_n) * 8))
+#define MT_LED_STATUS_OFF		GENMASK(31, 24)
+#define MT_LED_STATUS_ON		GENMASK(23, 16)
+#define MT_LED_STATUS_DURATION		GENMASK(15, 0)
+
 #define MT_LED_EN(_n)			MT_LED_PHYS(0x40 + ((_n) * 4))
 
+#define MT_LED_GPIO_MUX0		0x70005050 /* GPIO 1 and GPIO 2 */
+#define MT_LED_GPIO_MUX1		0x70005054 /* GPIO 14 and 15 */
 #define MT_LED_GPIO_MUX2                0x70005058 /* GPIO 18 */
-#define MT_LED_GPIO_MUX3                0x7000505C /* GPIO 26 */
-#define MT_LED_GPIO_SEL_MASK            GENMASK(11, 8)
+#define MT_LED_GPIO_MUX3		0x7000505c /* GPIO 26 */
 
 /* MT TOP */
 #define MT_TOP_BASE			0x18060000
-- 
2.38.1

