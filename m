Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22829251181
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Aug 2020 07:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgHYF3R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Aug 2020 01:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728333AbgHYF3Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Aug 2020 01:29:16 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BE4C0613ED
        for <linux-wireless@vger.kernel.org>; Mon, 24 Aug 2020 22:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TQUY20uymugMjzesOEr4DiO2q9rqRWCCRtR6t9JNX6c=; b=KZ/UJhulXhT4ttCslp4l2I8IZA
        lLV0z/sEPUIvtL8PWLRraZru242rMgkorwujOnym7aFkxmRtTnUQjStnDyv/Z3nNwZYMoj7ZWGrnD
        0AOd/N//9i42QbsErV3mrMOcIj/2IiE40rO9OWC/4fBNcSB1fcQeq752Ze2mLT3ieVxw=;
Received: from p5b206497.dip0.t-ipconnect.de ([91.32.100.151] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kARWC-0006jr-RD
        for linux-wireless@vger.kernel.org; Tue, 25 Aug 2020 07:29:12 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 9/9] mt76: mt7603: check for single-stream EEPROM configuration
Date:   Tue, 25 Aug 2020 07:29:09 +0200
Message-Id: <20200825052909.36955-9-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200825052909.36955-1-nbd@nbd.name>
References: <20200825052909.36955-1-nbd@nbd.name>
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
 drivers/net/wireless/mediatek/mt76/mt7603/eeprom.h |  3 +++
 drivers/net/wireless/mediatek/mt76/mt7603/init.c   | 12 ++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

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
index 94196599797e..43dbabccc083 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -510,11 +510,17 @@ mt7603_init_txpower(struct mt7603_dev *dev,
 	}
 }
 
+static inline bool is_mt7688(struct mt7603_dev *dev)
+{
+	return mt76_rr(dev, MT_EFUSE_BASE + 0x64) & BIT(4);
+}
+
 int mt7603_register_device(struct mt7603_dev *dev)
 {
 	struct mt76_bus_ops *bus_ops;
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct wiphy *wiphy = hw->wiphy;
+	u8 *eeprom = (u8 *)dev->mt76.eeprom.data;
 	int ret;
 
 	dev->bus_ops = dev->mt76.bus;
@@ -536,9 +542,11 @@ int mt7603_register_device(struct mt7603_dev *dev)
 	tasklet_init(&dev->mt76.pre_tbtt_tasklet, mt7603_pre_tbtt_tasklet,
 		     (unsigned long)dev);
 
-	/* Check for 7688, which only has 1SS */
+	/* Check for 1SS devices */
 	dev->mphy.antenna_mask = 3;
-	if (mt76_rr(dev, MT_EFUSE_BASE + 0x64) & BIT(4))
+	if (FIELD_GET(MT_EE_NIC_CONF_0_RX_PATH, eeprom[MT_EE_NIC_CONF_0]) == 1 ||
+	    FIELD_GET(MT_EE_NIC_CONF_0_TX_PATH, eeprom[MT_EE_NIC_CONF_0]) == 1 ||
+	    is_mt7688(dev))
 		dev->mphy.antenna_mask = 1;
 
 	dev->slottime = 9;
-- 
2.28.0

