Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E93D010DE1B
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfK3PbD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:31:03 -0500
Received: from nbd.name ([46.4.11.11]:56042 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbfK3Pat (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=/yTGbD6Dl3ALUxwSX1jptkEiWqb5AKGpOm7oJRGI2ac=; b=KXSVTqBRkCOGtHKxw/hwULMqQ5
        14TxNiL4Rds53/s8k1FOaDB8dPdvf2EdHaKB69pwJKnTchADHt/6EWkGbXQpj44nu/1Xp6ttPxpgm
        6+NvVNxZ/SoInPplpFhwRkf80xtRKWlKgonLxuZeLeHbP1E12Pc7+TgxS3UWbDGY0Fig=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hr-0006hg-6X
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:47 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 06F1B721EBD8; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 23/29] mt76: mt7615: rework chainmask handling
Date:   Sat, 30 Nov 2019 16:30:39 +0100
Message-Id: <20191130153045.28105-23-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move chainmask to struct mt7615_phy and instead of needlessly making the
format similar to values for older chips, make it refer to the actual chain
bits used for the rx/tx path.
This is important for multiple wiphy support, where for a secondary phy,
antenna_mask will start at 0, and chainmask will start at the chain offset
(bit 2)

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    | 7 +++++--
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h | 3 ++-
 3 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index 7e540f0ec94d..61a3fba240ba 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -124,8 +124,8 @@ static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
 	if (!tx_mask || tx_mask > max_nss)
 		tx_mask = max_nss;
 
-	dev->chainmask = tx_mask << 8 | rx_mask;
 	dev->mphy.antenna_mask = BIT(tx_mask) - 1;
+	dev->phy.chainmask = dev->mphy.antenna_mask;
 }
 
 int mt7615_eeprom_get_power_index(struct mt7615_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index dc0d598f5498..a19c406c2231 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1304,6 +1304,7 @@ int mt7615_mcu_set_channel(struct mt7615_phy *phy)
 	struct mt7615_dev *dev = phy->dev;
 	struct cfg80211_chan_def *chandef = &phy->mt76->chandef;
 	int freq1 = chandef->center_freq1, freq2 = chandef->center_freq2;
+	u8 n_chains = hweight8(phy->mt76->antenna_mask);
 	struct {
 		u8 control_chan;
 		u8 center_chan;
@@ -1325,8 +1326,8 @@ int mt7615_mcu_set_channel(struct mt7615_phy *phy)
 	} req = {
 		.control_chan = chandef->chan->hw_value,
 		.center_chan = ieee80211_frequency_to_channel(freq1),
-		.tx_streams = (dev->chainmask >> 8) & 0xf,
-		.rx_streams_mask = dev->mphy.antenna_mask,
+		.tx_streams = n_chains,
+		.rx_streams_mask = n_chains,
 		.center_chan2 = ieee80211_frequency_to_channel(freq2),
 	};
 	int ret;
@@ -1373,6 +1374,8 @@ int mt7615_mcu_set_channel(struct mt7615_phy *phy)
 	if (ret)
 		return ret;
 
+	req.rx_streams_mask = phy->chainmask;
+
 	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RX_PATH,
 				   &req, sizeof(req), true);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 3c8d96992b60..37d3b0971292 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -90,6 +90,8 @@ struct mt7615_phy {
 	s8 ofdm_sensitivity;
 	s8 cck_sensitivity;
 
+	u16 chainmask;
+
 	u8 rdd_state;
 	int dfs_state;
 };
@@ -101,7 +103,6 @@ struct mt7615_dev {
 	};
 
 	struct mt7615_phy phy;
-	u16 chainmask;
 	u32 vif_mask;
 	u32 omac_mask;
 
-- 
2.24.0

