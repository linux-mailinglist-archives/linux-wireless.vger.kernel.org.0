Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8F64CF26C
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 08:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235751AbiCGHLi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 02:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiCGHLi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 02:11:38 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F03541BD
        for <linux-wireless@vger.kernel.org>; Sun,  6 Mar 2022 23:10:44 -0800 (PST)
X-UUID: 901ccaef91cf4054b1ecbdf4f0c83a29-20220307
X-UUID: 901ccaef91cf4054b1ecbdf4f0c83a29-20220307
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <meichia.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 311470122; Mon, 07 Mar 2022 15:10:37 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Mar 2022 15:10:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Mar 2022 15:10:35 +0800
From:   MeiChia Chiu <MeiChia.Chiu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        MeiChia Chiu <MeiChia.Chiu@mediatek.com>
Subject: [PATCH v3 3/4] mt76: mt7915: fix eeprom fields of txpower init values
Date:   Mon, 7 Mar 2022 15:10:27 +0800
Message-ID: <20220307071028.5711-3-MeiChia.Chiu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220307071028.5711-1-MeiChia.Chiu@mediatek.com>
References: <20220307071028.5711-1-MeiChia.Chiu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Shayne Chen <shayne.chen@mediatek.com>

A-die 7976 has different offset and uses different channel group
definition on txpower init values.

Fixes: 99ad32a4ca3a ("mt76: mt7915: add support for MT7986")
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/eeprom.c    | 52 ++++++++++---------
 .../wireless/mediatek/mt76/mt7915/eeprom.h    | 14 ++++-
 2 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 136a6adab3df..317c3bc2db44 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -263,32 +263,38 @@ int mt7915_eeprom_get_target_power(struct mt7915_dev *dev,
 {
 	u8 *eeprom = dev->mt76.eeprom.data;
 	int index, target_power;
-	bool tssi_on;
+	bool tssi_on, is_7976;
 
 	if (chain_idx > 3)
 		return -EINVAL;
 
 	tssi_on = mt7915_tssi_enabled(dev, chan->band);
+	is_7976 = mt7915_check_adie(dev, false) || is_mt7916(&dev->mt76);
 
 	if (chan->band == NL80211_BAND_2GHZ) {
-		u32 power = is_mt7915(&dev->mt76) ?
-			    MT_EE_TX0_POWER_2G : MT_EE_TX0_POWER_2G_V2;
-
-		index = power + chain_idx * 3;
-		target_power = eeprom[index];
+		if (is_7976) {
+			index = MT_EE_TX0_POWER_2G_V2 + chain_idx;
+			target_power = eeprom[index];
+		} else {
+			index = MT_EE_TX0_POWER_2G + chain_idx * 3;
+			target_power = eeprom[index];
 
-		if (!tssi_on)
-			target_power += eeprom[index + 1];
+			if (!tssi_on)
+				target_power += eeprom[index + 1];
+		}
 	} else {
-		int group = mt7915_get_channel_group(chan->hw_value);
-		u32 power = is_mt7915(&dev->mt76) ?
-			    MT_EE_TX0_POWER_5G : MT_EE_TX0_POWER_5G_V2;
+		int group = mt7915_get_channel_group(chan->hw_value, is_7976);
 
-		index = power + chain_idx * 12;
-		target_power = eeprom[index + group];
+		if (is_7976) {
+			index = MT_EE_TX0_POWER_5G_V2 + chain_idx * 5;
+			target_power = eeprom[index + group];
+		} else {
+			index = MT_EE_TX0_POWER_5G + chain_idx * 12;
+			target_power = eeprom[index + group];
 
-		if (!tssi_on)
-			target_power += eeprom[index + 8];
+			if (!tssi_on)
+				target_power += eeprom[index + 8];
+		}
 	}
 
 	return target_power;
@@ -297,20 +303,16 @@ int mt7915_eeprom_get_target_power(struct mt7915_dev *dev,
 s8 mt7915_eeprom_get_power_delta(struct mt7915_dev *dev, int band)
 {
 	u8 *eeprom = dev->mt76.eeprom.data;
-	u32 val;
+	u32 val, offs;
 	s8 delta;
-	u32 rate_2g, rate_5g;
-
-	rate_2g = is_mt7915(&dev->mt76) ?
-		  MT_EE_RATE_DELTA_2G : MT_EE_RATE_DELTA_2G_V2;
-
-	rate_5g = is_mt7915(&dev->mt76) ?
-		  MT_EE_RATE_DELTA_5G : MT_EE_RATE_DELTA_5G_V2;
+	bool is_7976 = mt7915_check_adie(dev, false) || is_mt7916(&dev->mt76);
 
 	if (band == NL80211_BAND_2GHZ)
-		val = eeprom[rate_2g];
+		offs = is_7976 ? MT_EE_RATE_DELTA_2G_V2 : MT_EE_RATE_DELTA_2G;
 	else
-		val = eeprom[rate_5g];
+		offs = is_7976 ? MT_EE_RATE_DELTA_5G_V2 : MT_EE_RATE_DELTA_5G;
+
+	val = eeprom[offs];
 
 	if (!(val & MT_EE_RATE_DELTA_EN))
 		return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
index 5dad5b0b5ac6..45760917c54d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
@@ -103,8 +103,20 @@ enum mt7915_sku_rate_group {
 };
 
 static inline int
-mt7915_get_channel_group(int channel)
+mt7915_get_channel_group(int channel, bool is_7976)
 {
+	if (is_7976) {
+		if (channel <= 64)
+			return 0;
+		if (channel <= 96)
+			return 1;
+		if (channel <= 128)
+			return 2;
+		if (channel <= 144)
+			return 3;
+		return 4;
+	}
+
 	if (channel >= 184 && channel <= 196)
 		return 0;
 	if (channel <= 48)
-- 
2.18.0

