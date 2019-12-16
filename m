Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F989120696
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Dec 2019 14:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbfLPNFS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Dec 2019 08:05:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:58840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbfLPNFR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Dec 2019 08:05:17 -0500
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BB9E206CB;
        Mon, 16 Dec 2019 13:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576501517;
        bh=upTQzzBmJZihfHoCrF3kyF8fKekcfVTlcKwQi0NcJzM=;
        h=From:To:Cc:Subject:Date:From;
        b=BEPnC1wt5BPYBqxrR6SiPEUnOAh2096lIBmUneATCo3qPuLnKHO/Q2lviaNyiBSAI
         +nybFW7jObRfvHkR+OzPABgjQ9kzFx8i8/J1jqDhhVP4hDCZh0rW8bpXuslMb0N8j5
         IVcYJKJGQ8id2cmKFagHdJqZ3VR7U6NA1JUwiZHg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        ryder.lee@mediatek.com
Subject: [PATCH v3] mt76: mt7615: introduce LED support
Date:   Mon, 16 Dec 2019 14:05:05 +0100
Message-Id: <8c365ff2b1603b7fef6bf544820df9a0f176f232.1576501084.git.lorenzo@kernel.org>
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
Changes since v2:
- remove _MASK suffix from register definitions and move the code in init.c
Changes since v1:
- rely on FIELD_PREP for LED register definitions
---
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 58 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/regs.h  | 18 ++++++
 2 files changed, 76 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index eb7c6b9e3d4d..a3fd68452377 100644
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
index 26d121646787..ad58c02220af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -345,6 +345,24 @@
 
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
+#define MT_LED_STATUS_OFF		GENMASK(31, 24)
+#define MT_LED_STATUS_ON		GENMASK(23, 16)
+#define MT_LED_STATUS_DURATION		GENMASK(15, 0)
+
 #define MT_EFUSE_BASE			0x81070000
 #define MT_EFUSE_BASE_CTRL		0x000
 #define MT_EFUSE_BASE_CTRL_EMPTY	BIT(30)
-- 
2.21.0

