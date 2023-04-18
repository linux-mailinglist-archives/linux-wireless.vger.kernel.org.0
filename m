Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A45B6E5DD9
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Apr 2023 11:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjDRJtC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 Apr 2023 05:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjDRJtB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 Apr 2023 05:49:01 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892AC10D9
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 02:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rQQoOMSTwWi7IrvL2Hh6poheIzA4pdFT7m5d7g86cZ8=; b=mv16JCZTVVwVS72ySOJjxiBrpc
        6ROBgY4XZTKjbNJ3/AnOdr82OT/KK5fIypID6qSNZAW2yhkA4mVuXapEXyxj0s52UmoRk50mgBkpN
        Frdyv2GJ72utvnUKVaRoviVvjHWWgLbElTKYUg7QJ3pmbYg/8iuYC8mNRPToBm4B5BhU=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=Maecks.lan)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pohxG-00Fwil-Dr
        for linux-wireless@vger.kernel.org; Tue, 18 Apr 2023 11:48:54 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/3] wifi: mt76: mt7615: increase eeprom size for mt7663
Date:   Tue, 18 Apr 2023 11:48:51 +0200
Message-Id: <20230418094853.95197-1-nbd@nbd.name>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7663 efuse has 0x600 bytes instead of 0x400. Increase the size in order
to fix issues with incomplete calibration data

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c | 7 ++++++-
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h | 1 +
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index 6dbaaf95ee38..68e88224b8b1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -47,6 +47,9 @@ static int mt7615_efuse_init(struct mt7615_dev *dev, u32 base)
 	void *buf;
 	u32 val;
 
+	if (is_mt7663(&dev->mt76))
+		len = MT7663_EEPROM_SIZE;
+
 	val = mt76_rr(dev, base + MT_EFUSE_BASE_CTRL);
 	if (val & MT_EFUSE_BASE_CTRL_EMPTY)
 		return 0;
@@ -72,6 +75,8 @@ static int mt7615_eeprom_load(struct mt7615_dev *dev, u32 addr)
 {
 	int ret;
 
+	BUILD_BUG_ON(MT7615_EEPROM_FULL_SIZE < MT7663_EEPROM_SIZE);
+
 	ret = mt76_eeprom_init(&dev->mt76, MT7615_EEPROM_FULL_SIZE);
 	if (ret < 0)
 		return ret;
@@ -336,7 +341,7 @@ int mt7615_eeprom_init(struct mt7615_dev *dev, u32 addr)
 	ret = mt7615_check_eeprom(&dev->mt76);
 	if (ret && dev->mt76.otp.data) {
 		memcpy(dev->mt76.eeprom.data, dev->mt76.otp.data,
-		       MT7615_EEPROM_SIZE);
+		       dev->mt76.otp.size);
 	} else {
 		dev->flash_eeprom = true;
 		mt7615_cal_free_data(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
index a024dee10362..a67fbb90f5b3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
@@ -46,7 +46,7 @@ enum mt7615_eeprom_field {
 
 	MT7615_EE_MAX =				0x3bf,
 	MT7622_EE_MAX =				0x3db,
-	MT7663_EE_MAX =				0x400,
+	MT7663_EE_MAX =				0x600,
 };
 
 #define MT_EE_RATE_POWER_MASK			GENMASK(5, 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 932cdad7e7d4..0381c53bc96a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -51,6 +51,7 @@
 #define MT7663_FIRMWARE_N9		"mediatek/mt7663_n9_rebb.bin"
 
 #define MT7615_EEPROM_SIZE		1024
+#define MT7663_EEPROM_SIZE		1536
 #define MT7615_TOKEN_SIZE		4096
 
 #define MT_FRAC_SCALE		12
-- 
2.39.0

