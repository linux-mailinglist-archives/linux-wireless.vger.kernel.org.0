Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5E171CD9B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 19:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbfENRL0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 13:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbfENRL0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 13:11:26 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.66.17.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 969D82147A;
        Tue, 14 May 2019 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557853885;
        bh=zLCuhP1VvPxyjXWVaAhf+cVPR56+9JlIOX6NiqWjEw8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x3VLHzCT9Bno478xdYoSmavwJN6gvvvOzRJUkqV/f/irs0S/khlloKTVAP9mSR5Zn
         4V/VoL/l03hYQoxPVbETbE32jgNX81wAwRdwWbPJH5hI/beLhYuEiVKE1qNP8FmefO
         UhfvP5Hj0IzwGnl6wR8OSMbVCyszwoVksOdp3YeE=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: mt7615: add preliminary support for mtd eeprom parsing
Date:   Tue, 14 May 2019 19:11:14 +0200
Message-Id: <80210f745a12498fc6fc0f2616c2afb43658f0f6.1557853278.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557853278.git.lorenzo@kernel.org>
References: <cover.1557853278.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Calibration data are often available on a specific mtd partition on
embedded devices. Take into account eeprom calibration data if
available. Calibration free data parsing is currently missing

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/eeprom.c    | 32 +++++++++++++++----
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index dd5ab46a4f66..0313c604ea61 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -42,13 +42,13 @@ static int mt7615_efuse_read(struct mt7615_dev *dev, u32 base,
 
 static int mt7615_efuse_init(struct mt7615_dev *dev)
 {
-	u32 base = mt7615_reg_map(dev, MT_EFUSE_BASE);
-	int len = MT7615_EEPROM_SIZE;
-	int ret, i;
+	u32 val, base = mt7615_reg_map(dev, MT_EFUSE_BASE);
+	int i, len = MT7615_EEPROM_SIZE;
 	void *buf;
 
-	if (mt76_rr(dev, base + MT_EFUSE_BASE_CTRL) & MT_EFUSE_BASE_CTRL_EMPTY)
-		return -EINVAL;
+	val = mt76_rr(dev, base + MT_EFUSE_BASE_CTRL);
+	if (val & MT_EFUSE_BASE_CTRL_EMPTY)
+		return 0;
 
 	dev->mt76.otp.data = devm_kzalloc(dev->mt76.dev, len, GFP_KERNEL);
 	dev->mt76.otp.size = len;
@@ -57,6 +57,8 @@ static int mt7615_efuse_init(struct mt7615_dev *dev)
 
 	buf = dev->mt76.otp.data;
 	for (i = 0; i + 16 <= len; i += 16) {
+		int ret;
+
 		ret = mt7615_efuse_read(dev, base, i, buf + i);
 		if (ret)
 			return ret;
@@ -76,6 +78,18 @@ static int mt7615_eeprom_load(struct mt7615_dev *dev)
 	return mt7615_efuse_init(dev);
 }
 
+static int mt7615_check_eeprom(struct mt76_dev *dev)
+{
+	u16 val = get_unaligned_le16(dev->eeprom.data);
+
+	switch (val) {
+	case 0x7615:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 int mt7615_eeprom_init(struct mt7615_dev *dev)
 {
 	int ret;
@@ -84,7 +98,13 @@ int mt7615_eeprom_init(struct mt7615_dev *dev)
 	if (ret < 0)
 		return ret;
 
-	memcpy(dev->mt76.eeprom.data, dev->mt76.otp.data, MT7615_EEPROM_SIZE);
+	if (dev->mt76.otp.data) {
+		ret = mt7615_check_eeprom(&dev->mt76);
+		if (ret < 0)
+			memcpy(dev->mt76.eeprom.data, dev->mt76.otp.data,
+			       MT7615_EEPROM_SIZE);
+		/* TODO: take into account cal free data */
+	}
 
 	dev->mt76.cap.has_2ghz = true;
 	dev->mt76.cap.has_5ghz = true;
-- 
2.20.1

