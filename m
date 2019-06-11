Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3496B3C460
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 08:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391276AbfFKGjG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 02:39:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390485AbfFKGjG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 02:39:06 -0400
Received: from localhost.localdomain (unknown [151.66.40.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F10C208E3;
        Tue, 11 Jun 2019 06:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560235145;
        bh=W9NlIyP0WQ9e3JUAMkPsG9lN9isY5qtSwCOeh67zQgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S+rQnUVYdMrqFzl2ldB/NlXZX0SBb5MUDNYRnhtYmOTjBaPBT13P4DAE6Ej75/v1p
         Bu/ZhjUFqANMMCishmiPUeufin8+QxklyxuAOMuGZ9A9rqp832S9+hBgmWiBBygQI9
         l5HbpNUNqblwfaYk4uPtsJ3bfkz9x7UExYCh16v8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 2/2] mt76: mt7615: take into account extPA when configuring tx power
Date:   Tue, 11 Jun 2019 08:38:53 +0200
Message-Id: <a172b02f5beff2a3a5a817d322542c9a7bc2a184.1560234877.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1560234876.git.lorenzo@kernel.org>
References: <cover.1560234876.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When TSSI calibration is disabled (which it means the device has been
equipped with an external power amplifier) we need to refer to
different eeprom fields in order to properly configure tx power

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
please note I have not been able to test this patch since I have no devices
with external PA
---
 .../net/wireless/mediatek/mt76/mt7615/eeprom.c  | 12 +++++++++++-
 .../net/wireless/mediatek/mt76/mt7615/eeprom.h  | 17 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/init.c    |  9 ++++++---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 10 ++++++----
 .../net/wireless/mediatek/mt76/mt7615/mt7615.h  |  3 ++-
 5 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index 023c8bbc767d..dc94f52e6e8b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -110,7 +110,8 @@ static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
 	}
 }
 
-int mt7615_eeprom_get_power_index(struct ieee80211_channel *chan,
+int mt7615_eeprom_get_power_index(struct mt7615_dev *dev,
+				  struct ieee80211_channel *chan,
 				  u8 chain_idx)
 {
 	int index;
@@ -118,6 +119,15 @@ int mt7615_eeprom_get_power_index(struct ieee80211_channel *chan,
 	if (chain_idx > 3)
 		return -EINVAL;
 
+	/* TSSI disabled */
+	if (mt7615_ext_pa_enabled(dev, chan->band)) {
+		if (chan->band == NL80211_BAND_2GHZ)
+			return MT_EE_EXT_PA_2G_TARGET_POWER;
+		else
+			return MT_EE_EXT_PA_5G_TARGET_POWER;
+	}
+
+	/* TSSI enabled */
 	if (chan->band == NL80211_BAND_2GHZ) {
 		index = MT_EE_TX0_2G_TARGET_POWER + chain_idx * 6;
 	} else {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
index 3c9086b67f51..f4a4280768d2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
@@ -11,16 +11,22 @@ enum mt7615_eeprom_field {
 	MT_EE_VERSION =				0x002,
 	MT_EE_MAC_ADDR =			0x004,
 	MT_EE_NIC_CONF_0 =			0x034,
+	MT_EE_NIC_CONF_1 =			0x036,
 	MT_EE_WIFI_CONF =			0x03e,
 	MT_EE_TX0_2G_TARGET_POWER =		0x058,
 	MT_EE_TX0_5G_G0_TARGET_POWER =		0x070,
 	MT_EE_TX1_5G_G0_TARGET_POWER =		0x098,
+	MT_EE_EXT_PA_2G_TARGET_POWER =		0x0f2,
+	MT_EE_EXT_PA_5G_TARGET_POWER =		0x0f3,
 	MT_EE_TX2_5G_G0_TARGET_POWER =		0x142,
 	MT_EE_TX3_5G_G0_TARGET_POWER =		0x16a,
 
 	__MT_EE_MAX =				0x3bf
 };
 
+#define MT_EE_NIC_CONF_TSSI_2G			BIT(5)
+#define MT_EE_NIC_CONF_TSSI_5G			BIT(6)
+
 #define MT_EE_NIC_WIFI_CONF_BAND_SEL		GENMASK(5, 4)
 enum mt7615_eeprom_band {
 	MT_EE_DUAL_BAND,
@@ -59,4 +65,15 @@ mt7615_get_channel_group(int channel)
 	return MT_CH_5G_UNII_3;
 }
 
+static inline bool
+mt7615_ext_pa_enabled(struct mt7615_dev *dev, enum nl80211_band band)
+{
+	u8 *eep = dev->mt76.eeprom.data;
+
+	if (band == NL80211_BAND_5GHZ)
+		return !(eep[MT_EE_NIC_CONF_1 + 1] & MT_EE_NIC_CONF_TSSI_5G);
+	else
+		return !(eep[MT_EE_NIC_CONF_1 + 1] & MT_EE_NIC_CONF_TSSI_2G);
+}
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 3f826e4f1cd6..859de2454ec6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -9,6 +9,7 @@
 #include <linux/etherdevice.h>
 #include "mt7615.h"
 #include "mac.h"
+#include "eeprom.h"
 
 static void mt7615_phy_init(struct mt7615_dev *dev)
 {
@@ -169,18 +170,20 @@ static void
 mt7615_init_txpower(struct mt7615_dev *dev,
 		    struct ieee80211_supported_band *sband)
 {
-	int i, n_chains = hweight8(dev->mt76.antenna_mask);
+	int i, n_chains = hweight8(dev->mt76.antenna_mask), target_chains;
 	u8 *eep = (u8 *)dev->mt76.eeprom.data;
+	enum nl80211_band band = sband->band;
 
+	target_chains = mt7615_ext_pa_enabled(dev, band) ? 1 : n_chains;
 	for (i = 0; i < sband->n_channels; i++) {
 		struct ieee80211_channel *chan = &sband->channels[i];
 		u8 target_power = 0;
 		int j;
 
-		for (j = 0; j < n_chains; j++) {
+		for (j = 0; j < target_chains; j++) {
 			int index;
 
-			index = mt7615_eeprom_get_power_index(chan, j);
+			index = mt7615_eeprom_get_power_index(dev, chan, j);
 			target_power = max(target_power, eep[index]);
 		}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 79baa455034c..f3dd76f88ff1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1149,9 +1149,10 @@ int mt7615_mcu_set_tx_power(struct mt7615_dev *dev)
 {
 	int i, ret, n_chains = hweight8(dev->mt76.antenna_mask);
 	struct cfg80211_chan_def *chandef = &dev->mt76.chandef;
+	int freq = chandef->center_freq1, len, target_chains;
 	u8 *req, *data, *eep = (u8 *)dev->mt76.eeprom.data;
+	enum nl80211_band band = chandef->chan->band;
 	struct ieee80211_hw *hw = mt76_hw(dev);
-	int freq = chandef->center_freq1, len;
 	struct {
 		u8 center_chan;
 		u8 dbdc_idx;
@@ -1159,7 +1160,7 @@ int mt7615_mcu_set_tx_power(struct mt7615_dev *dev)
 		u8 rsv;
 	} __packed req_hdr = {
 		.center_chan = ieee80211_frequency_to_channel(freq),
-		.band = chandef->chan->band,
+		.band = band,
 	};
 	s8 tx_power;
 
@@ -1190,10 +1191,11 @@ int mt7615_mcu_set_tx_power(struct mt7615_dev *dev)
 	tx_power = max_t(s8, tx_power, 0);
 	dev->mt76.txpower_cur = tx_power;
 
-	for (i = 0; i < n_chains; i++) {
+	target_chains = mt7615_ext_pa_enabled(dev, band) ? 1 : n_chains;
+	for (i = 0; i < target_chains; i++) {
 		int index = -MT_EE_NIC_CONF_0;
 
-		ret = mt7615_eeprom_get_power_index(chandef->chan, i);
+		ret = mt7615_eeprom_get_power_index(dev, chandef->chan, i);
 		if (ret < 0)
 			goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 7c08d3b93a2a..f02ffcffe637 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -105,7 +105,8 @@ u32 mt7615_reg_map(struct mt7615_dev *dev, u32 addr);
 int mt7615_register_device(struct mt7615_dev *dev);
 void mt7615_unregister_device(struct mt7615_dev *dev);
 int mt7615_eeprom_init(struct mt7615_dev *dev);
-int mt7615_eeprom_get_power_index(struct ieee80211_channel *chan,
+int mt7615_eeprom_get_power_index(struct mt7615_dev *dev,
+				  struct ieee80211_channel *chan,
 				  u8 chain_idx);
 int mt7615_dma_init(struct mt7615_dev *dev);
 void mt7615_dma_cleanup(struct mt7615_dev *dev);
-- 
2.21.0

