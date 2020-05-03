Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09741C2D79
	for <lists+linux-wireless@lfdr.de>; Sun,  3 May 2020 17:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgECPbG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 May 2020 11:31:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbgECPbG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 May 2020 11:31:06 -0400
Received: from localhost.localdomain (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9147E20757;
        Sun,  3 May 2020 15:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588519865;
        bh=Y30zyGha8lAC7EiljQQ4NMoD45Xbrqbt2tMA+T/Ezm8=;
        h=From:To:Cc:Subject:Date:From;
        b=UnDu6cFP71gT8rvEUyhDyYMicmaQsWr546W8hapQTAw04q8+6jm9JZ9cuRluBIGGH
         xIoKbnyB/glEZ1Ygi5S+2HT8G/CY0FePk6Tpkuu5EpjoRgg4+rWgV2ewtuk9ObS53A
         l33xIBP6/BsWAxBCrbuzmVrwWaxVq1AO/wouoZQU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7615: fix delta tx power for mt7663
Date:   Sun,  3 May 2020 17:30:53 +0200
Message-Id: <0cf455450efd28fbd97df81af8a591428ba7b8cc.1588519828.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix mt7663 eeprom definitions for delta tx power parsing

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/eeprom.c  | 17 +++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/eeprom.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7615/init.c    | 10 +++-------
 .../net/wireless/mediatek/mt76/mt7615/mt7615.h  |  2 ++
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index 4fb9658b1083..2d4932f97e9e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -156,6 +156,23 @@ static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
 	dev->phy.chainmask = dev->chainmask;
 }
 
+int mt7615_eeprom_get_power_delta_index(struct mt7615_dev *dev,
+					enum nl80211_band band)
+{
+	/* assume the first rate has the highest power offset */
+	if (is_mt7663(&dev->mt76)) {
+		if (band == NL80211_BAND_2GHZ)
+			return MT_EE_TX0_5G_G0_TARGET_POWER;
+		else
+			return MT7663_EE_5G_RATE_POWER;
+	}
+
+	if (band == NL80211_BAND_2GHZ)
+		return MT_EE_2G_RATE_POWER;
+	else
+		return MT_EE_5G_RATE_POWER;
+}
+
 int mt7663_eeprom_get_target_power_index(struct mt7615_dev *dev,
 					 struct ieee80211_channel *chan,
 					 u8 chain_idx)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
index 2390b7137360..03a23c2bf776 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
@@ -31,6 +31,7 @@ enum mt7615_eeprom_field {
 	MT_EE_CALDATA_FLASH =			0x052,
 	MT_EE_TX0_2G_TARGET_POWER =		0x058,
 	MT_EE_TX0_5G_G0_TARGET_POWER =		0x070,
+	MT7663_EE_5G_RATE_POWER =		0x089,
 	MT_EE_TX1_5G_G0_TARGET_POWER =		0x098,
 	MT_EE_2G_RATE_POWER =			0x0be,
 	MT_EE_5G_RATE_POWER =			0x0d5,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/init.c b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
index 498022782d22..1262ced3727a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/init.c
@@ -222,17 +222,13 @@ void mt7615_init_txpower(struct mt7615_dev *dev,
 			 struct ieee80211_supported_band *sband)
 {
 	int i, n_chains = hweight8(dev->mphy.antenna_mask), target_chains;
+	int delta_idx, delta = mt76_tx_power_nss_delta(n_chains);
 	u8 *eep = (u8 *)dev->mt76.eeprom.data;
 	enum nl80211_band band = sband->band;
-	int delta = mt76_tx_power_nss_delta(n_chains);
 	u8 rate_val;
 
-	/* assume the first rate has the highest power offset */
-	if (band == NL80211_BAND_2GHZ)
-		rate_val = eep[MT_EE_2G_RATE_POWER];
-	else
-		rate_val = eep[MT_EE_5G_RATE_POWER];
-
+	delta_idx = mt7615_eeprom_get_power_delta_index(dev, band);
+	rate_val = eep[delta_idx];
 	if ((rate_val & ~MT_EE_RATE_POWER_MASK) ==
 	    (MT_EE_RATE_POWER_EN | MT_EE_RATE_POWER_SIGN))
 		delta += rate_val & MT_EE_RATE_POWER_MASK;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index b113eaa1a70e..36abfcf529d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -383,6 +383,8 @@ int mt7663_eeprom_get_target_power_index(struct mt7615_dev *dev,
 int mt7615_eeprom_get_target_power_index(struct mt7615_dev *dev,
 					 struct ieee80211_channel *chan,
 					 u8 chain_idx);
+int mt7615_eeprom_get_power_delta_index(struct mt7615_dev *dev,
+					enum nl80211_band band);
 int mt7615_wait_pdma_busy(struct mt7615_dev *dev);
 int mt7615_dma_init(struct mt7615_dev *dev);
 void mt7615_dma_cleanup(struct mt7615_dev *dev);
-- 
2.26.2

