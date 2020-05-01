Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7751C2124
	for <lists+linux-wireless@lfdr.de>; Sat,  2 May 2020 01:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgEAXNo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 May 2020 19:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:56758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAXNo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 May 2020 19:13:44 -0400
Received: from lore-desk.lan (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10696205C9;
        Fri,  1 May 2020 23:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588374823;
        bh=5hBIs7ynppiec+Mcrs9/TWvkac65MInCkhDPsnn8QSk=;
        h=From:To:Cc:Subject:Date:From;
        b=kIbMK9FTS0+NRU3PUiXNElYXSAkBb+/jI/70vX+9ne/hXzpLPys9c8PBDZNlZ+zRP
         r2ROEhVt+1y1pIVpPK9qppuN9v/Cx1xCFzf9laCAWdeMcnh0YiUGf52NjIgG99mBcQ
         Kp4gl4j2O7+Q4dIPg415e5sNBDe9M4z1GBNykqpk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7663: read tx streams from eeprom
Date:   Sat,  2 May 2020 01:13:11 +0200
Message-Id: <a67ec5b853824c2561c96f880e9ebca199ffac53.1588374738.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Read tx stream configuration from eeprom/efuse partition

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c | 11 ++++++-----
 drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h |  3 +++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index 521705015036..7440ad13c74b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -130,14 +130,15 @@ mt7615_eeprom_parse_hw_band_cap(struct mt7615_dev *dev)
 static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
 {
 	u8 *eeprom = dev->mt76.eeprom.data;
-	u8 tx_mask;
+	u8 tx_mask, max_nss;
 
 	mt7615_eeprom_parse_hw_band_cap(dev);
 
 	if (is_mt7663(&dev->mt76)) {
-		tx_mask = 2;
+		max_nss = 2;
+		tx_mask = FIELD_GET(MT_EE_HW_CONF1_TX_MASK,
+				    eeprom[MT7663_EE_HW_CONF1]);
 	} else {
-		u8 max_nss;
 		u32 val;
 
 		/* read tx-rx mask from eeprom */
@@ -146,9 +147,9 @@ static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
 
 		tx_mask =  FIELD_GET(MT_EE_NIC_CONF_TX_MASK,
 				     eeprom[MT_EE_NIC_CONF_0]);
-		if (!tx_mask || tx_mask > max_nss)
-			tx_mask = max_nss;
 	}
+	if (!tx_mask || tx_mask > max_nss)
+		tx_mask = max_nss;
 
 	dev->chainmask = BIT(tx_mask) - 1;
 	dev->mphy.antenna_mask = dev->chainmask;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
index 3dd7009e5836..aad82b600c63 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
@@ -39,6 +39,7 @@ enum mt7615_eeprom_field {
 	MT7663_EE_TX0_2G_TARGET_POWER =		0x123,
 	MT_EE_TX2_5G_G0_TARGET_POWER =		0x142,
 	MT_EE_TX3_5G_G0_TARGET_POWER =		0x16a,
+	MT7663_EE_HW_CONF1 =			0x1b0,
 
 	MT7615_EE_MAX =				0x3bf,
 	MT7622_EE_MAX =				0x3db,
@@ -55,6 +56,8 @@ enum mt7615_eeprom_field {
 #define MT_EE_NIC_CONF_TX_MASK			GENMASK(7, 4)
 #define MT_EE_NIC_CONF_RX_MASK			GENMASK(3, 0)
 
+#define MT_EE_HW_CONF1_TX_MASK			GENMASK(2, 0)
+
 #define MT_EE_NIC_CONF_TSSI_2G			BIT(5)
 #define MT_EE_NIC_CONF_TSSI_5G			BIT(6)
 
-- 
2.25.4

