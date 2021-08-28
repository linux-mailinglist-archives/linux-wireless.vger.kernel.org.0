Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804463FA6E1
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Aug 2021 19:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhH1RDf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 28 Aug 2021 13:03:35 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:53422 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234596AbhH1RDe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 28 Aug 2021 13:03:34 -0400
X-UUID: e81cefa2a9ce4a109b35045f81b25b3c-20210829
X-UUID: e81cefa2a9ce4a109b35045f81b25b3c-20210829
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 462488537; Sun, 29 Aug 2021 01:02:41 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 29 Aug 2021 01:02:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 29 Aug 2021 01:02:39 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        MeiChia Chiu <meichia.chiu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Money Wang <money.wang@mediatek.com>
Subject: [PATCH v3] mt76: mt7915: add LED support
Date:   Sun, 29 Aug 2021 01:02:38 +0800
Message-ID: <b6d1ea7152f41b503fd8f8a1b709a29e96e0c7a9.1630169881.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: MeiChia Chiu <meichia.chiu@mediatek.com>

Initialize brightness_set and blink_set callbacks to enable LED support.
The base 0x7c000000 is MCU space so driver can't touch it, and should
map the LED base to 0x18000000 host's view.

Signed-off-by: MeiChia Chiu <meichia.chiu@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Money Wang <money.wang@mediatek.com>
---
v3 - initialize the variable
v2 - define the registers as being in the 0x18000000 range
---
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 69 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7915/regs.h  | 19 +++++
 3 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index ba41ed38a4c5..6208f5662704 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -187,6 +187,64 @@ static int mt7915_thermal_init(struct mt7915_phy *phy)
 	return 0;
 }
 
+static void mt7915_led_set_config(struct led_classdev *led_cdev,
+				  u8 delay_on, u8 delay_off)
+{
+	struct mt7915_dev *dev;
+	struct mt76_dev *mt76;
+	u32 val;
+
+	mt76 = container_of(led_cdev, struct mt76_dev, led_cdev);
+	dev = container_of(mt76, struct mt7915_dev, mt76);
+
+	/* select TX blink mode, 2: only data frames */
+	mt76_rmw_field(dev, MT_TMAC_TCR0(0), MT_TMAC_TCR0_TX_BLINK, 2);
+
+	/* enable LED */
+	mt76_wr(dev, MT_LED_EN(0), 1);
+
+	/* set LED Tx blink on/off time */
+	val = FIELD_PREP(MT_LED_TX_BLINK_ON_MASK, delay_on) |
+	      FIELD_PREP(MT_LED_TX_BLINK_OFF_MASK, delay_off);
+	mt76_wr(dev, MT_LED_TX_BLINK(0), val);
+
+	/* control LED */
+	val = MT_LED_CTRL_BLINK_MODE | MT_LED_CTRL_KICK;
+	if (dev->mt76.led_al)
+		val |= MT_LED_CTRL_POLARITY;
+
+	mt76_wr(dev, MT_LED_CTRL(0), val);
+	mt76_clear(dev, MT_LED_CTRL(0), MT_LED_CTRL_KICK);
+}
+
+static int mt7915_led_set_blink(struct led_classdev *led_cdev,
+				unsigned long *delay_on,
+				unsigned long *delay_off)
+{
+	u16 delta_on = 0, delta_off = 0;
+
+#define HW_TICK		10
+#define TO_HW_TICK(_t)	(((_t) > HW_TICK) ? ((_t) / HW_TICK) : HW_TICK)
+
+	if (*delay_on)
+		delta_on = TO_HW_TICK(*delay_on);
+	if (*delay_off)
+		delta_off = TO_HW_TICK(*delay_off);
+
+	mt7915_led_set_config(led_cdev, delta_on, delta_off);
+
+	return 0;
+}
+
+static void mt7915_led_set_brightness(struct led_classdev *led_cdev,
+				      enum led_brightness brightness)
+{
+	if (!brightness)
+		mt7915_led_set_config(led_cdev, 0, 0xff);
+	else
+		mt7915_led_set_config(led_cdev, 0xff, 0);
+}
+
 static void
 mt7915_init_txpower(struct mt7915_dev *dev,
 		    struct ieee80211_supported_band *sband)
@@ -341,6 +399,11 @@ static void mt7915_mac_init(struct mt7915_dev *dev)
 				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
 	for (i = 0; i < 2; i++)
 		mt7915_mac_init_band(dev, i);
+
+	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
+		i = dev->mt76.led_pin ? MT_LED_GPIO_MUX3 : MT_LED_GPIO_MUX2;
+		mt76_rmw_field(dev, i, MT_LED_GPIO_SEL_MASK, 4);
+	}
 }
 
 static int mt7915_txbf_init(struct mt7915_dev *dev)
@@ -847,6 +910,12 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	dev->mt76.test_ops = &mt7915_testmode_ops;
 #endif
 
+	/* init led callbacks */
+	if (IS_ENABLED(CONFIG_MT76_LEDS)) {
+		dev->mt76.led_cdev.brightness_set = mt7915_led_set_brightness;
+		dev->mt76.led_cdev.blink_set = mt7915_led_set_blink;
+	}
+
 	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
 				   ARRAY_SIZE(mt76_rates));
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index bb5522446eab..1f6ba306c850 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -95,8 +95,7 @@ static u32 __mt7915_reg_addr(struct mt7915_dev *dev, u32 addr)
 	}
 
 	if ((addr >= 0x18000000 && addr < 0x18c00000) ||
-	    (addr >= 0x70000000 && addr < 0x78000000) ||
-	    (addr >= 0x7c000000 && addr < 0x7c400000))
+	    (addr >= 0x70000000 && addr < 0x78000000))
 		return mt7915_reg_map_l1(dev, addr);
 
 	return mt7915_reg_map_l2(dev, addr);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index 724988f16107..05eb70645a7c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -57,6 +57,7 @@
 #define MT_WF_TMAC(_band, ofs)		(MT_WF_TMAC_BASE(_band) + (ofs))
 
 #define MT_TMAC_TCR0(_band)		MT_WF_TMAC(_band, 0)
+#define MT_TMAC_TCR0_TX_BLINK		GENMASK(7, 6)
 #define MT_TMAC_TCR0_TBTT_STOP_CTRL	BIT(25)
 
 #define MT_TMAC_CDTR(_band)		MT_WF_TMAC(_band, 0x090)
@@ -435,6 +436,20 @@
 #define MT_SWDEF_ICAP_MODE		1
 #define MT_SWDEF_SPECTRUM_MODE		2
 
+#define MT_LED_TOP_BASE			0x18013000
+#define MT_LED_PHYS(_n)			(MT_LED_TOP_BASE + (_n))
+
+#define MT_LED_CTRL(_n)			MT_LED_PHYS(0x00 + ((_n) * 4))
+#define MT_LED_CTRL_KICK		BIT(7)
+#define MT_LED_CTRL_BLINK_MODE		BIT(2)
+#define MT_LED_CTRL_POLARITY		BIT(1)
+
+#define MT_LED_TX_BLINK(_n)		MT_LED_PHYS(0x10 + ((_n) * 4))
+#define MT_LED_TX_BLINK_ON_MASK		GENMASK(7, 0)
+#define MT_LED_TX_BLINK_OFF_MASK        GENMASK(15, 8)
+
+#define MT_LED_EN(_n)			MT_LED_PHYS(0x40 + ((_n) * 4))
+
 #define MT_TOP_BASE			0x18060000
 #define MT_TOP(ofs)			(MT_TOP_BASE + (ofs))
 
@@ -445,6 +460,10 @@
 #define MT_TOP_MISC			MT_TOP(0xf0)
 #define MT_TOP_MISC_FW_STATE		GENMASK(2, 0)
 
+#define MT_LED_GPIO_MUX2                0x70005058 /* GPIO 18 */
+#define MT_LED_GPIO_MUX3                0x7000505C /* GPIO 26 */
+#define MT_LED_GPIO_SEL_MASK            GENMASK(11, 8)
+
 #define MT_HW_BOUND			0x70010020
 #define MT_HW_CHIPID			0x70010200
 #define MT_HW_REV			0x70010204
-- 
2.29.2

