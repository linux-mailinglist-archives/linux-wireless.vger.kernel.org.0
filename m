Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 099D3350CB8
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Apr 2021 04:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhDACcF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Mar 2021 22:32:05 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:42897 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229497AbhDACbr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Mar 2021 22:31:47 -0400
X-UUID: fa5eee72cc9749b7b013c379c294a30c-20210401
X-UUID: fa5eee72cc9749b7b013c379c294a30c-20210401
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1372645251; Thu, 01 Apr 2021 10:31:44 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 1 Apr 2021 10:31:43 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 1 Apr 2021 10:31:42 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] mt76: mt7915: fix txpower init for TSSI off chips
Date:   Thu, 1 Apr 2021 10:31:29 +0800
Message-ID: <20210401023129.31941-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix incorrect txpower init value for TSSI off chips which causes
too small txpower.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/eeprom.c    | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index a7ffc20..18be0d6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -124,7 +124,7 @@ int mt7915_eeprom_get_target_power(struct mt7915_dev *dev,
 				   struct ieee80211_channel *chan,
 				   u8 chain_idx)
 {
-	int index;
+	int index, target_power;
 	bool tssi_on;
 
 	if (chain_idx > 3)
@@ -133,15 +133,22 @@ int mt7915_eeprom_get_target_power(struct mt7915_dev *dev,
 	tssi_on = mt7915_tssi_enabled(dev, chan->band);
 
 	if (chan->band == NL80211_BAND_2GHZ) {
-		index = MT_EE_TX0_POWER_2G + chain_idx * 3 + !tssi_on;
+		index = MT_EE_TX0_POWER_2G + chain_idx * 3;
+		target_power = mt7915_eeprom_read(dev, index);
+
+		if (!tssi_on)
+			target_power += mt7915_eeprom_read(dev, index + 1);
 	} else {
-		int group = tssi_on ?
-			    mt7915_get_channel_group(chan->hw_value) : 8;
+		int group = mt7915_get_channel_group(chan->hw_value);
+
+		index = MT_EE_TX0_POWER_5G + chain_idx * 12;
+		target_power = mt7915_eeprom_read(dev, index + group);
 
-		index = MT_EE_TX0_POWER_5G + chain_idx * 12 + group;
+		if (!tssi_on)
+			target_power += mt7915_eeprom_read(dev, index + 8);
 	}
 
-	return mt7915_eeprom_read(dev, index);
+	return target_power;
 }
 
 s8 mt7915_eeprom_get_power_delta(struct mt7915_dev *dev, int band)
-- 
2.18.0

