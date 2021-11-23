Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D781745AC0C
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 20:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbhKWTNU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 14:13:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235934AbhKWTNQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 14:13:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 617DD60E8E;
        Tue, 23 Nov 2021 19:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637694608;
        bh=Uj8EbkvU8t6bAA8kLBCExqWCH1rpQ4Tlzi8m5ljg48M=;
        h=From:To:Cc:Subject:Date:From;
        b=YS34S133USPWYImcMpkGZGjBUAbuYKY2r2VsCT1LLOd+VG9OyF9gEgRyp6ST9abkL
         pLRumLDgE0xPQ2cddK2RqAdePv2CO+e8v/6oVrqBSALRZbAptFAdnMrwI2dyWtrjBr
         aTWPx0MTtEzcethv0ttIslVDIrupLRZWe0Pey49LhQNChNe8u+QmMRMH++crw/8FHC
         PK85H84CqWm22Q07M4OiDona3Y72W+gCLOUMEWs0yVrE7ff3ssNv7sL6ddiCVflsxn
         Y8NF5+WZcOcBX9bO0t4iw+Qx0i3DFalASs1lOUPzorQioUXvZr34WqSWVoE0L23PH3
         JJjegNv0WjeAA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7603: introduce SAR support
Date:   Tue, 23 Nov 2021 20:09:51 +0100
Message-Id: <19cd1f227457e37196a2c8658d05fb1b75daf815.1637694393.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add SAR spec support to mt7603 driver to allow configuring SAR power
limitations on the frequency ranges from the userland.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7603/main.c  | 31 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7603/mcu.c   |  4 +--
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 7ac4cd247a73..2b546bc05d82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -133,13 +133,15 @@ void mt7603_init_edcca(struct mt7603_dev *dev)
 }
 
 static int
-mt7603_set_channel(struct mt7603_dev *dev, struct cfg80211_chan_def *def)
+mt7603_set_channel(struct ieee80211_hw *hw, struct cfg80211_chan_def *def)
 {
+	struct mt7603_dev *dev = hw->priv;
 	u8 *rssi_data = (u8 *)dev->mt76.eeprom.data;
 	int idx, ret;
 	u8 bw = MT_BW_20;
 	bool failed = false;
 
+	ieee80211_stop_queues(hw);
 	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 
@@ -205,9 +207,28 @@ mt7603_set_channel(struct mt7603_dev *dev, struct cfg80211_chan_def *def)
 	if (failed)
 		mt7603_mac_work(&dev->mphy.mac_work.work);
 
+	ieee80211_wake_queues(hw);
+
 	return ret;
 }
 
+static int mt7603_set_sar_specs(struct ieee80211_hw *hw,
+				const struct cfg80211_sar_specs *sar)
+{
+	struct mt7603_dev *dev = hw->priv;
+	struct mt76_phy *mphy = &dev->mphy;
+	int err;
+
+	if (!cfg80211_chandef_valid(&mphy->chandef))
+		return -EINVAL;
+
+	err = mt76_init_sar_power(hw, sar);
+	if (err)
+		return err;
+
+	return mt7603_set_channel(hw, &mphy->chandef);
+}
+
 static int
 mt7603_config(struct ieee80211_hw *hw, u32 changed)
 {
@@ -215,11 +236,8 @@ mt7603_config(struct ieee80211_hw *hw, u32 changed)
 	int ret = 0;
 
 	if (changed & (IEEE80211_CONF_CHANGE_CHANNEL |
-		       IEEE80211_CONF_CHANGE_POWER)) {
-		ieee80211_stop_queues(hw);
-		ret = mt7603_set_channel(dev, &hw->conf.chandef);
-		ieee80211_wake_queues(hw);
-	}
+		       IEEE80211_CONF_CHANGE_POWER))
+		ret = mt7603_set_channel(hw, &hw->conf.chandef);
 
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
 		mutex_lock(&dev->mt76.mutex);
@@ -700,6 +718,7 @@ const struct ieee80211_ops mt7603_ops = {
 	.set_tim = mt76_set_tim,
 	.get_survey = mt76_get_survey,
 	.get_antenna = mt76_get_antenna,
+	.set_sar_specs = mt7603_set_sar_specs,
 };
 
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
index 6abfe6b19afa..7884b952b720 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
@@ -403,7 +403,7 @@ int mt7603_mcu_set_channel(struct mt7603_dev *dev)
 		.tx_streams = n_chains,
 		.rx_streams = n_chains,
 	};
-	s8 tx_power;
+	s8 tx_power = hw->conf.power_level * 2;
 	int i, ret;
 
 	if (dev->mphy.chandef.width == NL80211_CHAN_WIDTH_40) {
@@ -414,7 +414,7 @@ int mt7603_mcu_set_channel(struct mt7603_dev *dev)
 			req.center_chan -= 2;
 	}
 
-	tx_power = hw->conf.power_level * 2;
+	tx_power = mt76_get_sar_power(&dev->mphy, chandef->chan, tx_power);
 	if (dev->mphy.antenna_mask == 3)
 		tx_power -= 6;
 	tx_power = min(tx_power, dev->tx_power_limit);
-- 
2.31.1

