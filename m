Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92914CF26D
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 08:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbiCGHLk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 02:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiCGHLk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 02:11:40 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C09541BD
        for <linux-wireless@vger.kernel.org>; Sun,  6 Mar 2022 23:10:46 -0800 (PST)
X-UUID: c0185319df25487684e4ba52363958a9-20220307
X-UUID: c0185319df25487684e4ba52363958a9-20220307
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <meichia.chiu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 853844526; Mon, 07 Mar 2022 15:10:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 7 Mar 2022 15:10:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Mar 2022 15:10:38 +0800
From:   MeiChia Chiu <MeiChia.Chiu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        MeiChia Chiu <MeiChia.Chiu@mediatek.com>
Subject: [PATCH v3 4/4] mt76: mt7915: add txpower init for 6GHz
Date:   Mon, 7 Mar 2022 15:10:28 +0800
Message-ID: <20220307071028.5711-4-MeiChia.Chiu@mediatek.com>
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

Add support to init txpower values of 6GHz band.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: MeiChia Chiu <MeiChia.Chiu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/eeprom.c    | 15 +++++++++++----
 .../net/wireless/mediatek/mt76/mt7915/eeprom.h    | 13 ++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt7915/init.c  |  2 ++
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 317c3bc2db44..5b133bcdab17 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -282,8 +282,8 @@ int mt7915_eeprom_get_target_power(struct mt7915_dev *dev,
 			if (!tssi_on)
 				target_power += eeprom[index + 1];
 		}
-	} else {
-		int group = mt7915_get_channel_group(chan->hw_value, is_7976);
+	} else if (chan->band == NL80211_BAND_5GHZ) {
+		int group = mt7915_get_channel_group_5g(chan->hw_value, is_7976);
 
 		if (is_7976) {
 			index = MT_EE_TX0_POWER_5G_V2 + chain_idx * 5;
@@ -295,6 +295,11 @@ int mt7915_eeprom_get_target_power(struct mt7915_dev *dev,
 			if (!tssi_on)
 				target_power += eeprom[index + 8];
 		}
+	} else {
+		int group = mt7915_get_channel_group_6g(chan->hw_value);
+
+		index = MT_EE_TX0_POWER_6G_V2 + chain_idx * 8;
+		target_power = is_7976 ? eeprom[index + group] : 0;
 	}
 
 	return target_power;
@@ -309,12 +314,14 @@ s8 mt7915_eeprom_get_power_delta(struct mt7915_dev *dev, int band)
 
 	if (band == NL80211_BAND_2GHZ)
 		offs = is_7976 ? MT_EE_RATE_DELTA_2G_V2 : MT_EE_RATE_DELTA_2G;
-	else
+	else if (band == NL80211_BAND_5GHZ)
 		offs = is_7976 ? MT_EE_RATE_DELTA_5G_V2 : MT_EE_RATE_DELTA_5G;
+	else
+		offs = is_7976 ? MT_EE_RATE_DELTA_6G_V2 : 0;
 
 	val = eeprom[offs];
 
-	if (!(val & MT_EE_RATE_DELTA_EN))
+	if (!offs || !(val & MT_EE_RATE_DELTA_EN))
 		return 0;
 
 	delta = FIELD_GET(MT_EE_RATE_DELTA_MASK, val);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
index 45760917c54d..7578ac6d0be6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h
@@ -25,8 +25,10 @@ enum mt7915_eeprom_field {
 	MT_EE_TX0_POWER_5G =	0x34b,
 	MT_EE_RATE_DELTA_2G_V2 = 0x7d3,
 	MT_EE_RATE_DELTA_5G_V2 = 0x81e,
+	MT_EE_RATE_DELTA_6G_V2 = 0x884, /* 6g fields only appear in eeprom v2 */
 	MT_EE_TX0_POWER_2G_V2 =	0x441,
 	MT_EE_TX0_POWER_5G_V2 =	0x445,
+	MT_EE_TX0_POWER_6G_V2 =	0x465,
 	MT_EE_ADIE_FT_VERSION =	0x9a0,
 
 	__MT_EE_MAX =		0xe00,
@@ -103,7 +105,7 @@ enum mt7915_sku_rate_group {
 };
 
 static inline int
-mt7915_get_channel_group(int channel, bool is_7976)
+mt7915_get_channel_group_5g(int channel, bool is_7976)
 {
 	if (is_7976) {
 		if (channel <= 64)
@@ -134,6 +136,15 @@ mt7915_get_channel_group(int channel, bool is_7976)
 	return 7;
 }
 
+static inline int
+mt7915_get_channel_group_6g(int channel)
+{
+	if (channel <= 29)
+		return 0;
+
+	return DIV_ROUND_UP(channel - 29, 32);
+}
+
 static inline bool
 mt7915_tssi_enabled(struct mt7915_dev *dev, enum nl80211_band band)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 9a696687d61c..668244e0d11e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -312,6 +312,7 @@ mt7915_regd_notifier(struct wiphy *wiphy,
 
 	mt7915_init_txpower(dev, &mphy->sband_2g.sband);
 	mt7915_init_txpower(dev, &mphy->sband_5g.sband);
+	mt7915_init_txpower(dev, &mphy->sband_6g.sband);
 
 	mphy->dfs_state = MT_DFS_STATE_UNKNOWN;
 	mt7915_dfs_init_radar_detector(phy);
@@ -558,6 +559,7 @@ static void mt7915_init_work(struct work_struct *work)
 	mt7915_mac_init(dev);
 	mt7915_init_txpower(dev, &dev->mphy.sband_2g.sband);
 	mt7915_init_txpower(dev, &dev->mphy.sband_5g.sband);
+	mt7915_init_txpower(dev, &dev->mphy.sband_6g.sband);
 	mt7915_txbf_init(dev);
 }
 
-- 
2.18.0

