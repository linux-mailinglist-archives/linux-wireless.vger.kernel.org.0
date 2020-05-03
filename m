Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF361C2D6D
	for <lists+linux-wireless@lfdr.de>; Sun,  3 May 2020 17:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgECPYC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 May 2020 11:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728147AbgECPYC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 May 2020 11:24:02 -0400
Received: from localhost.localdomain (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11EA9206E9;
        Sun,  3 May 2020 15:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588519441;
        bh=aerzNM8cIdMUwLFZGgOBSfzc7fpEB+0XmDZfGNzl+Ic=;
        h=From:To:Cc:Subject:Date:From;
        b=VhlBocAe6uVSH5ZAxJ683/HpUapGLPuSlBB7MLLKghejOUfO1E1LhZi6yAOmD6Rz0
         kVHq/XcjKY0o6o4hYNQANvuZjd+j6xWs7PnK7Agghn8sXx+Km7TnRTMF+r2HwvshSV
         FYbFxWDlmYV8YeyC2Ze8x+1Q6EqP7sJCpSryLrOE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7663: fix target power parsing
Date:   Sun,  3 May 2020 17:23:54 +0200
Message-Id: <9016ffdd9f7c13c0587b05e61138af1389ad86d3.1588519313.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix target parsing from eeprom/efuse partition for 7663 chipsets

Fixes: f40ac0f3d3c0 ("mt76: mt7615: introduce mt7663e support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/eeprom.c    | 27 ++++++++++++++++---
 .../wireless/mediatek/mt76/mt7615/eeprom.h    | 17 +++++++++++-
 .../net/wireless/mediatek/mt76/mt7615/init.c  |  6 ++++-
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  9 ++++---
 4 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index 7440ad13c74b..4fb9658b1083 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -156,9 +156,30 @@ static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
 	dev->phy.chainmask = dev->chainmask;
 }
 
-int mt7615_eeprom_get_power_index(struct mt7615_dev *dev,
-				  struct ieee80211_channel *chan,
-				  u8 chain_idx)
+int mt7663_eeprom_get_target_power_index(struct mt7615_dev *dev,
+					 struct ieee80211_channel *chan,
+					 u8 chain_idx)
+{
+	int index, group;
+
+	if (chain_idx > 1)
+		return -EINVAL;
+
+	if (chan->band == NL80211_BAND_2GHZ)
+		return MT7663_EE_TX0_2G_TARGET_POWER + (chain_idx << 4);
+
+	group = mt7615_get_channel_group(chan->hw_value);
+	if (chain_idx == 1)
+		index = MT7663_EE_TX1_5G_G0_TARGET_POWER;
+	else
+		index = MT7663_EE_TX0_5G_G0_TARGET_POWER;
+
+	return index + group * 3;
+}
+
+int mt7615_eeprom_get_target_power_index(struct mt7615_dev *dev,
+					 struct ieee80211_channel *chan,
+					 u8 chain_idx)
 {
 	int index;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
index aad82b600c63..2390b7137360 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
@@ -34,12 +34,14 @@ enum mt7615_eeprom_field {
 	MT_EE_TX1_5G_G0_TARGET_POWER =		0x098,
 	MT_EE_2G_RATE_POWER =			0x0be,
 	MT_EE_5G_RATE_POWER =			0x0d5,
+	MT7663_EE_TX0_2G_TARGET_POWER =		0x0e3,
 	MT_EE_EXT_PA_2G_TARGET_POWER =		0x0f2,
 	MT_EE_EXT_PA_5G_TARGET_POWER =		0x0f3,
-	MT7663_EE_TX0_2G_TARGET_POWER =		0x123,
 	MT_EE_TX2_5G_G0_TARGET_POWER =		0x142,
 	MT_EE_TX3_5G_G0_TARGET_POWER =		0x16a,
 	MT7663_EE_HW_CONF1 =			0x1b0,
+	MT7663_EE_TX0_5G_G0_TARGET_POWER =	0x245,
+	MT7663_EE_TX1_5G_G0_TARGET_POWER =	0x2b5,
 
 	MT7615_EE_MAX =				0x3bf,
 	MT7622_EE_MAX =				0x3db,
@@ -110,4 +112,17 @@ mt7615_ext_pa_enabled(struct mt7615_dev *dev, enum nl80211_band band)
 		return !(eep[MT_EE_NIC_CONF_1 + 1] & MT_EE_NIC_CONF_TSSI_2G);
 }
 
+static inline int
+mt7615_eeprom_get_power_index(struct mt7615_dev *dev,
+			      struct ieee80211_channel *chan,
+			      u8 chain_idx)
+{
+	if (is_mt7663(&dev->mt76))
+		return mt7663_eeprom_get_target_power_index(dev, chan,
+							    chain_idx);
+	else
+		return mt7615_eeprom_get_target_power_index(dev, chan,
+							    chain_idx);
+}
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index d831d647d237..498022782d22 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -237,7 +237,11 @@ void mt7615_init_txpower(struct mt7615_dev *dev,
 	    (MT_EE_RATE_POWER_EN | MT_EE_RATE_POWER_SIGN))
 		delta += rate_val & MT_EE_RATE_POWER_MASK;
 
-	target_chains = mt7615_ext_pa_enabled(dev, band) ? 1 : n_chains;
+	if (!is_mt7663(&dev->mt76) && mt7615_ext_pa_enabled(dev, band))
+		target_chains = 1;
+	else
+		target_chains = n_chains;
+
 	for (i = 0; i < sband->n_channels; i++) {
 		struct ieee80211_channel *chan = &sband->channels[i];
 		u8 target_power = 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index af897fe5c508..b113eaa1a70e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -377,9 +377,12 @@ void mt7615_unregister_device(struct mt7615_dev *dev);
 int mt7615_register_ext_phy(struct mt7615_dev *dev);
 void mt7615_unregister_ext_phy(struct mt7615_dev *dev);
 int mt7615_eeprom_init(struct mt7615_dev *dev, u32 addr);
-int mt7615_eeprom_get_power_index(struct mt7615_dev *dev,
-				  struct ieee80211_channel *chan,
-				  u8 chain_idx);
+int mt7663_eeprom_get_target_power_index(struct mt7615_dev *dev,
+					 struct ieee80211_channel *chan,
+					 u8 chain_idx);
+int mt7615_eeprom_get_target_power_index(struct mt7615_dev *dev,
+					 struct ieee80211_channel *chan,
+					 u8 chain_idx);
 int mt7615_wait_pdma_busy(struct mt7615_dev *dev);
 int mt7615_dma_init(struct mt7615_dev *dev);
 void mt7615_dma_cleanup(struct mt7615_dev *dev);
-- 
2.26.2

