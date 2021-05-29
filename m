Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5BD394BEB
	for <lists+linux-wireless@lfdr.de>; Sat, 29 May 2021 13:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhE2LNe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 29 May 2021 07:13:34 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54379 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229614AbhE2LNd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 29 May 2021 07:13:33 -0400
X-UUID: f9922accfe8747f88df9b0ede9c4db1f-20210529
X-UUID: f9922accfe8747f88df9b0ede9c4db1f-20210529
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 841726352; Sat, 29 May 2021 19:11:54 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 29 May 2021 19:11:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 29 May 2021 19:11:53 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] mt76: mt7915: read all eeprom fields from fw in efuse mode
Date:   Sat, 29 May 2021 19:11:50 +0800
Message-ID: <20210529111150.21611-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If efuse mode is used, read all values from fw during eeprom init,
which makes it more convinient to check if rf values in efuse are
properly burned.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/eeprom.c    | 44 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  5 ++-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 8ededf2..ee3d644 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -4,22 +4,12 @@
 #include "mt7915.h"
 #include "eeprom.h"
 
-static u32 mt7915_eeprom_read(struct mt7915_dev *dev, u32 offset)
-{
-	u8 *data = dev->mt76.eeprom.data;
-
-	if (data[offset] == 0xff && !dev->flash_mode)
-		mt7915_mcu_get_eeprom(dev, offset);
-
-	return data[offset];
-}
-
 static int mt7915_eeprom_load_precal(struct mt7915_dev *dev)
 {
 	struct mt76_dev *mdev = &dev->mt76;
-	u32 val;
+	u8 *eeprom = mdev->eeprom.data;
+	u32 val = eeprom[MT_EE_DO_PRE_CAL];
 
-	val = mt7915_eeprom_read(dev, MT_EE_DO_PRE_CAL);
 	if (val != (MT_EE_WIFI_CAL_DPD | MT_EE_WIFI_CAL_GROUP))
 		return 0;
 
@@ -43,7 +33,13 @@ static int mt7915_eeprom_load(struct mt7915_dev *dev)
 		dev->flash_mode = true;
 		ret = mt7915_eeprom_load_precal(dev);
 	} else {
-		memset(dev->mt76.eeprom.data, -1, MT7915_EEPROM_SIZE);
+		u32 block_num, i;
+
+		block_num = DIV_ROUND_UP(MT7915_EEPROM_SIZE,
+					 MT7915_EEPROM_BLOCK_SIZE);
+		for (i = 0; i < block_num; i++)
+			mt7915_mcu_get_eeprom(dev,
+					      i * MT7915_EEPROM_BLOCK_SIZE);
 	}
 
 	return ret;
@@ -52,10 +48,7 @@ static int mt7915_eeprom_load(struct mt7915_dev *dev)
 static int mt7915_check_eeprom(struct mt7915_dev *dev)
 {
 	u8 *eeprom = dev->mt76.eeprom.data;
-	u16 val;
-
-	mt7915_eeprom_read(dev, MT_EE_CHIP_ID);
-	val = get_unaligned_le16(eeprom);
+	u16 val = get_unaligned_le16(eeprom);
 
 	switch (val) {
 	case 0x7915:
@@ -69,9 +62,10 @@ void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
+	u8 *eeprom = dev->mt76.eeprom.data;
 	u32 val;
 
-	val = mt7915_eeprom_read(dev, MT_EE_WIFI_CONF + ext_phy);
+	val = eeprom[MT_EE_WIFI_CONF + ext_phy];
 	val = FIELD_GET(MT_EE_WIFI_CONF0_BAND_SEL, val);
 	if (val == MT_EE_BAND_SEL_DEFAULT && dev->dbdc_support)
 		val = ext_phy ? MT_EE_BAND_SEL_5GHZ : MT_EE_BAND_SEL_2GHZ;
@@ -143,6 +137,7 @@ int mt7915_eeprom_get_target_power(struct mt7915_dev *dev,
 				   struct ieee80211_channel *chan,
 				   u8 chain_idx)
 {
+	u8 *eeprom = dev->mt76.eeprom.data;
 	int index, target_power;
 	bool tssi_on;
 
@@ -153,18 +148,18 @@ int mt7915_eeprom_get_target_power(struct mt7915_dev *dev,
 
 	if (chan->band == NL80211_BAND_2GHZ) {
 		index = MT_EE_TX0_POWER_2G + chain_idx * 3;
-		target_power = mt7915_eeprom_read(dev, index);
+		target_power = eeprom[index];
 
 		if (!tssi_on)
-			target_power += mt7915_eeprom_read(dev, index + 1);
+			target_power += eeprom[index + 1];
 	} else {
 		int group = mt7915_get_channel_group(chan->hw_value);
 
 		index = MT_EE_TX0_POWER_5G + chain_idx * 12;
-		target_power = mt7915_eeprom_read(dev, index + group);
+		target_power = eeprom[index + group];
 
 		if (!tssi_on)
-			target_power += mt7915_eeprom_read(dev, index + 8);
+			target_power += eeprom[index + 8];
 	}
 
 	return target_power;
@@ -172,13 +167,14 @@ int mt7915_eeprom_get_target_power(struct mt7915_dev *dev,
 
 s8 mt7915_eeprom_get_power_delta(struct mt7915_dev *dev, int band)
 {
+	u8 *eeprom = dev->mt76.eeprom.data;
 	u32 val;
 	s8 delta;
 
 	if (band == NL80211_BAND_2GHZ)
-		val = mt7915_eeprom_read(dev, MT_EE_RATE_DELTA_2G);
+		val = eeprom[MT_EE_RATE_DELTA_2G];
 	else
-		val = mt7915_eeprom_read(dev, MT_EE_RATE_DELTA_5G);
+		val = eeprom[MT_EE_RATE_DELTA_5G];
 
 	if (!(val & MT_EE_RATE_DELTA_EN))
 		return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index dcf2d4d..e716feb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3316,7 +3316,8 @@ int mt7915_mcu_set_eeprom(struct mt7915_dev *dev)
 int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset)
 {
 	struct mt7915_mcu_eeprom_info req = {
-		.addr = cpu_to_le32(round_down(offset, 16)),
+		.addr = cpu_to_le32(round_down(offset,
+				    MT7915_EEPROM_BLOCK_SIZE)),
 	};
 	struct mt7915_mcu_eeprom_info *res;
 	struct sk_buff *skb;
@@ -3330,7 +3331,7 @@ int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset)
 
 	res = (struct mt7915_mcu_eeprom_info *)skb->data;
 	buf = dev->mt76.eeprom.data + le32_to_cpu(res->addr);
-	memcpy(buf, res->data, 16);
+	memcpy(buf, res->data, MT7915_EEPROM_BLOCK_SIZE);
 	dev_kfree_skb(skb);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index c4bf8ed..4a79a10 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -31,6 +31,7 @@
 #define MT7915_ROM_PATCH		"mediatek/mt7915_rom_patch.bin"
 
 #define MT7915_EEPROM_SIZE		3584
+#define MT7915_EEPROM_BLOCK_SIZE	16
 #define MT7915_TOKEN_SIZE		8192
 
 #define MT7915_CFEND_RATE_DEFAULT	0x49	/* OFDM 24M */
-- 
2.18.0

