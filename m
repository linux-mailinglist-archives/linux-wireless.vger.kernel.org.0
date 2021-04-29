Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB05636E712
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Apr 2021 10:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbhD2Id1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Apr 2021 04:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:47334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229963AbhD2Id0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Apr 2021 04:33:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B09361185;
        Thu, 29 Apr 2021 08:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619685160;
        bh=4x0n6tElxUEy88zSNLhwWTsuVxFHuswrY51b/xU7j5g=;
        h=From:To:Cc:Subject:Date:From;
        b=P7JU+iLM3ioRYArrpf+R5pOFRqa22fK+P3G9rJuPBES7aExunWCVkYv15JCmYl/I5
         UBVNIfVXIs/Wp+/UekyT/0U/CHF9QG8XO1RwOfATCn9pEY1W37+T9Bwjx59r0zBeAk
         L2gPPH8/TUPxfSHleABtGIS6Bru+NBim2iTBxqLaK05S6NOKyuPV5s2j9uGJRCe4tm
         uyFozJnHLABigYEJE1JXZ1YOdW6GNpFv3CkGv5E3FWyIUz6agxGyIhTq6stRkSKc1s
         hkQzx3/sXPNYAy9NDpPLpTsYyAN0DFWOew6mf5uOK+WxDhZc+48j8JveSbWr3yoy5o
         MJtSG0XUln5cA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: move mt76_rates in mt76 module
Date:   Thu, 29 Apr 2021 10:32:34 +0200
Message-Id: <a8da66822d9dbfd7afbebcd915f1c4e1bb59d41f.1619685085.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_rates array in mt76 module and remove duplicated code since it
is shared by all drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 16 +++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     | 15 ++++++++
 .../net/wireless/mediatek/mt76/mt7603/init.c  | 13 -------
 .../net/wireless/mediatek/mt76/mt7615/init.c  | 33 ++---------------
 .../wireless/mediatek/mt76/mt7615/pci_init.c  |  4 +--
 .../wireless/mediatek/mt76/mt7615/usb_sdio.c  |  4 +--
 .../net/wireless/mediatek/mt76/mt76x02_util.c | 16 +++------
 .../net/wireless/mediatek/mt76/mt7915/init.c  | 36 +++----------------
 .../net/wireless/mediatek/mt76/mt7921/init.c  | 32 ++---------------
 9 files changed, 48 insertions(+), 121 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 977acab0360a..fa9f80686272 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -83,6 +83,22 @@ static const struct ieee80211_tpt_blink mt76_tpt_blink[] = {
 	{ .throughput = 300 * 1024, .blink_time =  50 },
 };
 
+struct ieee80211_rate mt76_rates[] = {
+	CCK_RATE(0, 10),
+	CCK_RATE(1, 20),
+	CCK_RATE(2, 55),
+	CCK_RATE(3, 110),
+	OFDM_RATE(11, 60),
+	OFDM_RATE(15, 90),
+	OFDM_RATE(10, 120),
+	OFDM_RATE(14, 180),
+	OFDM_RATE(9,  240),
+	OFDM_RATE(13, 360),
+	OFDM_RATE(8,  480),
+	OFDM_RATE(12, 540),
+};
+EXPORT_SYMBOL_GPL(mt76_rates);
+
 static int mt76_led_init(struct mt76_dev *dev)
 {
 	struct device_node *np = dev->dev->of_node;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 36ede65919f8..2e6a277b91d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -738,6 +738,21 @@ enum mt76_phy_type {
 	MT_PHY_TYPE_HE_MU,
 };
 
+#define CCK_RATE(_idx, _rate) {					\
+	.bitrate = _rate,					\
+	.flags = IEEE80211_RATE_SHORT_PREAMBLE,			\
+	.hw_value = (MT_PHY_TYPE_CCK << 8) | (_idx),		\
+	.hw_value_short = (MT_PHY_TYPE_CCK << 8) | (4 + _idx),	\
+}
+
+#define OFDM_RATE(_idx, _rate) {				\
+	.bitrate = _rate,					\
+	.hw_value = (MT_PHY_TYPE_OFDM << 8) | (_idx),		\
+	.hw_value_short = (MT_PHY_TYPE_OFDM << 8) | (_idx),	\
+}
+
+extern struct ieee80211_rate mt76_rates[12];
+
 #define __mt76_rr(dev, ...)	(dev)->bus->rr((dev), __VA_ARGS__)
 #define __mt76_wr(dev, ...)	(dev)->bus->wr((dev), __VA_ARGS__)
 #define __mt76_rmw(dev, ...)	(dev)->bus->rmw((dev), __VA_ARGS__)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index e1b2cfa56074..b46097ea334a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -304,19 +304,6 @@ mt7603_init_hardware(struct mt7603_dev *dev)
 	return 0;
 }
 
-#define CCK_RATE(_idx, _rate) {					\
-	.bitrate = _rate,					\
-	.flags = IEEE80211_RATE_SHORT_PREAMBLE,			\
-	.hw_value = (MT_PHY_TYPE_CCK << 8) | (_idx),		\
-	.hw_value_short = (MT_PHY_TYPE_CCK << 8) | (4 + _idx),	\
-}
-
-#define OFDM_RATE(_idx, _rate) {				\
-	.bitrate = _rate,					\
-	.hw_value = (MT_PHY_TYPE_OFDM << 8) | (_idx),		\
-	.hw_value_short = (MT_PHY_TYPE_OFDM << 8) | (_idx),	\
-}
-
 static struct ieee80211_rate mt7603_rates[] = {
 	CCK_RATE(0, 10),
 	CCK_RATE(1, 20),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index d20f05a7717d..ecc3ca9eb658 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -174,35 +174,6 @@ bool mt7615_wait_for_mcu_init(struct mt7615_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt7615_wait_for_mcu_init);
 
-#define CCK_RATE(_idx, _rate) {						\
-	.bitrate = _rate,						\
-	.flags = IEEE80211_RATE_SHORT_PREAMBLE,				\
-	.hw_value = (MT_PHY_TYPE_CCK << 8) | (_idx),			\
-	.hw_value_short = (MT_PHY_TYPE_CCK << 8) | (4 + (_idx)),	\
-}
-
-#define OFDM_RATE(_idx, _rate) {					\
-	.bitrate = _rate,						\
-	.hw_value = (MT_PHY_TYPE_OFDM << 8) | (_idx),			\
-	.hw_value_short = (MT_PHY_TYPE_OFDM << 8) | (_idx),		\
-}
-
-struct ieee80211_rate mt7615_rates[] = {
-	CCK_RATE(0, 10),
-	CCK_RATE(1, 20),
-	CCK_RATE(2, 55),
-	CCK_RATE(3, 110),
-	OFDM_RATE(11, 60),
-	OFDM_RATE(15, 90),
-	OFDM_RATE(10, 120),
-	OFDM_RATE(14, 180),
-	OFDM_RATE(9,  240),
-	OFDM_RATE(13, 360),
-	OFDM_RATE(8,  480),
-	OFDM_RATE(12, 540),
-};
-EXPORT_SYMBOL_GPL(mt7615_rates);
-
 static const struct ieee80211_iface_limit if_limits[] = {
 	{
 		.max = 1,
@@ -472,8 +443,8 @@ int mt7615_register_ext_phy(struct mt7615_dev *dev)
 	for (i = 0; i <= MT_TXQ_PSD ; i++)
 		mphy->q_tx[i] = dev->mphy.q_tx[i];
 
-	ret = mt76_register_phy(mphy, true, mt7615_rates,
-				ARRAY_SIZE(mt7615_rates));
+	ret = mt76_register_phy(mphy, true, mt76_rates,
+				ARRAY_SIZE(mt76_rates));
 	if (ret)
 		ieee80211_free_hw(mphy->hw);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
index ec8ec1a2033f..273fda08bfa2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_init.c
@@ -147,8 +147,8 @@ int mt7615_register_device(struct mt7615_dev *dev)
 	if (ret)
 		return ret;
 
-	ret = mt76_register_device(&dev->mt76, true, mt7615_rates,
-				   ARRAY_SIZE(mt7615_rates));
+	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
+				   ARRAY_SIZE(mt76_rates));
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index 7010101f6b14..75a05f8dd7e7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -324,8 +324,8 @@ int mt7663_usb_sdio_register_device(struct mt7615_dev *dev)
 			hw->max_tx_fragments = 1;
 	}
 
-	err = mt76_register_device(&dev->mt76, true, mt7615_rates,
-				   ARRAY_SIZE(mt7615_rates));
+	err = mt76_register_device(&dev->mt76, true, mt76_rates,
+				   ARRAY_SIZE(mt76_rates));
 	if (err < 0)
 		return err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 02db5d66735d..ccdbab341271 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -7,24 +7,18 @@
 #include <linux/module.h>
 #include "mt76x02.h"
 
-#define CCK_RATE(_idx, _rate) {					\
+#define MT76x02_CCK_RATE(_idx, _rate) {					\
 	.bitrate = _rate,					\
 	.flags = IEEE80211_RATE_SHORT_PREAMBLE,			\
 	.hw_value = (MT_PHY_TYPE_CCK << 8) | (_idx),		\
 	.hw_value_short = (MT_PHY_TYPE_CCK << 8) | (8 + (_idx)),	\
 }
 
-#define OFDM_RATE(_idx, _rate) {				\
-	.bitrate = _rate,					\
-	.hw_value = (MT_PHY_TYPE_OFDM << 8) | (_idx),		\
-	.hw_value_short = (MT_PHY_TYPE_OFDM << 8) | (_idx),	\
-}
-
 struct ieee80211_rate mt76x02_rates[] = {
-	CCK_RATE(0, 10),
-	CCK_RATE(1, 20),
-	CCK_RATE(2, 55),
-	CCK_RATE(3, 110),
+	MT76x02_CCK_RATE(0, 10),
+	MT76x02_CCK_RATE(1, 20),
+	MT76x02_CCK_RATE(2, 55),
+	MT76x02_CCK_RATE(3, 110),
 	OFDM_RATE(0, 60),
 	OFDM_RATE(1, 90),
 	OFDM_RATE(2, 120),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 822f3aa6bb8b..8b5546c32a41 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -7,34 +7,6 @@
 #include "mcu.h"
 #include "eeprom.h"
 
-#define CCK_RATE(_idx, _rate) {						\
-	.bitrate = _rate,						\
-	.flags = IEEE80211_RATE_SHORT_PREAMBLE,				\
-	.hw_value = (MT_PHY_TYPE_CCK << 8) | (_idx),			\
-	.hw_value_short = (MT_PHY_TYPE_CCK << 8) | (4 + (_idx)),	\
-}
-
-#define OFDM_RATE(_idx, _rate) {					\
-	.bitrate = _rate,						\
-	.hw_value = (MT_PHY_TYPE_OFDM << 8) | (_idx),			\
-	.hw_value_short = (MT_PHY_TYPE_OFDM << 8) | (_idx),		\
-}
-
-static struct ieee80211_rate mt7915_rates[] = {
-	CCK_RATE(0, 10),
-	CCK_RATE(1, 20),
-	CCK_RATE(2, 55),
-	CCK_RATE(3, 110),
-	OFDM_RATE(11, 60),
-	OFDM_RATE(15, 90),
-	OFDM_RATE(10, 120),
-	OFDM_RATE(14, 180),
-	OFDM_RATE(9,  240),
-	OFDM_RATE(13, 360),
-	OFDM_RATE(8,  480),
-	OFDM_RATE(12, 540),
-};
-
 static const struct ieee80211_iface_limit if_limits[] = {
 	{
 		.max = 1,
@@ -281,8 +253,8 @@ static int mt7915_register_ext_phy(struct mt7915_dev *dev)
 	if (ret)
 		goto error;
 
-	ret = mt76_register_phy(mphy, true, mt7915_rates,
-				ARRAY_SIZE(mt7915_rates));
+	ret = mt76_register_phy(mphy, true, mt76_rates,
+				ARRAY_SIZE(mt76_rates));
 	if (ret)
 		goto error;
 
@@ -731,8 +703,8 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	dev->mt76.test_ops = &mt7915_testmode_ops;
 #endif
 
-	ret = mt76_register_device(&dev->mt76, true, mt7915_rates,
-				   ARRAY_SIZE(mt7915_rates));
+	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
+				   ARRAY_SIZE(mt76_rates));
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index fe28bf4050c4..225f4d327a4e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -7,34 +7,6 @@
 #include "mcu.h"
 #include "eeprom.h"
 
-#define CCK_RATE(_idx, _rate) {						\
-	.bitrate = _rate,						\
-	.flags = IEEE80211_RATE_SHORT_PREAMBLE,				\
-	.hw_value = (MT_PHY_TYPE_CCK << 8) | (_idx),			\
-	.hw_value_short = (MT_PHY_TYPE_CCK << 8) | (4 + (_idx)),	\
-}
-
-#define OFDM_RATE(_idx, _rate) {					\
-	.bitrate = _rate,						\
-	.hw_value = (MT_PHY_TYPE_OFDM << 8) | (_idx),			\
-	.hw_value_short = (MT_PHY_TYPE_OFDM << 8) | (_idx),		\
-}
-
-static struct ieee80211_rate mt7921_rates[] = {
-	CCK_RATE(0, 10),
-	CCK_RATE(1, 20),
-	CCK_RATE(2, 55),
-	CCK_RATE(3, 110),
-	OFDM_RATE(11, 60),
-	OFDM_RATE(15, 90),
-	OFDM_RATE(10, 120),
-	OFDM_RATE(14, 180),
-	OFDM_RATE(9,  240),
-	OFDM_RATE(13, 360),
-	OFDM_RATE(8,  480),
-	OFDM_RATE(12, 540),
-};
-
 static const struct ieee80211_iface_limit if_limits[] = {
 	{
 		.max = MT7921_MAX_INTERFACES,
@@ -260,8 +232,8 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	mt76_set_stream_caps(&dev->mphy, true);
 	mt7921_set_stream_he_caps(&dev->phy);
 
-	ret = mt76_register_device(&dev->mt76, true, mt7921_rates,
-				   ARRAY_SIZE(mt7921_rates));
+	ret = mt76_register_device(&dev->mt76, true, mt76_rates,
+				   ARRAY_SIZE(mt76_rates));
 	if (ret)
 		return ret;
 
-- 
2.30.2

