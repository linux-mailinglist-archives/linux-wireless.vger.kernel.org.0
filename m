Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA5412517FA
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Aug 2020 13:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgHYLm7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Aug 2020 07:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbgHYLmf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Aug 2020 07:42:35 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072F5C061574
        for <linux-wireless@vger.kernel.org>; Tue, 25 Aug 2020 04:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=s1btEU4pVB7qjUZ+NZT1w7uWFECNet3LBQ5w/SxnKQ8=; b=Lb2aTpoMRHNO/W/ac/NDG5e4Ir
        qv8fCTpWuTjLFtIXxmiYXSdWSNCNtLWnc7THYtTmAfJbV0U0qU3sKir6pHnHoZDrUW1gvAnNgzdgj
        Hcmq1DBEf49gD3uqbWvXpaCHdKPTsmg3ezar+LAv61bcIfmg573F4gLSWMbsj0rzADok=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kAXLT-0000hM-7q; Tue, 25 Aug 2020 13:42:31 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Qin Wei <me@vonger.cn>
Subject: [PATCH v2 9/9] mt76: mt7603: check for single-stream EEPROM configuration
Date:   Tue, 25 Aug 2020 13:42:30 +0200
Message-Id: <20200825114230.90723-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825052909.36955-9-nbd@nbd.name>
References: <20200825052909.36955-9-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Some devices using MT7628 or MT7603 have only one antenna chain connected.
Detect these using the EEPROM rx/tx path settings

Reported-by: Qin Wei <me@vonger.cn>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
v2: move to eeprom.c to fix initialization order
 .../net/wireless/mediatek/mt76/mt7603/eeprom.c  | 17 +++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7603/eeprom.h  |  3 +++
 .../net/wireless/mediatek/mt76/mt7603/init.c    |  5 -----
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
index 3ee06e2577b8..01f1e0da5ee1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
@@ -147,8 +147,14 @@ static int mt7603_check_eeprom(struct mt76_dev *dev)
 	}
 }
 
+static inline bool is_mt7688(struct mt7603_dev *dev)
+{
+	return mt76_rr(dev, MT_EFUSE_BASE + 0x64) & BIT(4);
+}
+
 int mt7603_eeprom_init(struct mt7603_dev *dev)
 {
+	u8 *eeprom;
 	int ret;
 
 	ret = mt7603_eeprom_load(dev);
@@ -163,9 +169,16 @@ int mt7603_eeprom_init(struct mt7603_dev *dev)
 			       MT7603_EEPROM_SIZE);
 	}
 
+	eeprom = (u8 *)dev->mt76.eeprom.data;
 	dev->mt76.cap.has_2ghz = true;
-	memcpy(dev->mt76.macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
-	       ETH_ALEN);
+	memcpy(dev->mt76.macaddr, eeprom + MT_EE_MAC_ADDR, ETH_ALEN);
+
+	/* Check for 1SS devices */
+	dev->mphy.antenna_mask = 3;
+	if (FIELD_GET(MT_EE_NIC_CONF_0_RX_PATH, eeprom[MT_EE_NIC_CONF_0]) == 1 ||
+	    FIELD_GET(MT_EE_NIC_CONF_0_TX_PATH, eeprom[MT_EE_NIC_CONF_0]) == 1 ||
+	    is_mt7688(dev))
+		dev->mphy.antenna_mask = 1;
 
 	mt76_eeprom_override(&dev->mt76);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h
index b893facfba48..4687d6dc00dc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h
@@ -85,4 +85,7 @@ enum mt7603_eeprom_source {
 	MT_EE_SRC_FLASH,
 };
 
+#define MT_EE_NIC_CONF_0_RX_PATH		GENMASK(3, 0)
+#define MT_EE_NIC_CONF_0_TX_PATH		GENMASK(7, 4)
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 94196599797e..c4848fafd270 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -536,11 +536,6 @@ int mt7603_register_device(struct mt7603_dev *dev)
 	tasklet_init(&dev->mt76.pre_tbtt_tasklet, mt7603_pre_tbtt_tasklet,
 		     (unsigned long)dev);
 
-	/* Check for 7688, which only has 1SS */
-	dev->mphy.antenna_mask = 3;
-	if (mt76_rr(dev, MT_EFUSE_BASE + 0x64) & BIT(4))
-		dev->mphy.antenna_mask = 1;
-
 	dev->slottime = 9;
 	dev->sensitivity_limit = 28;
 	dev->dynamic_sensitivity = true;
-- 
2.28.0

