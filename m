Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8554213B0
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2019 08:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfEQG0P (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 May 2019 02:26:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbfEQG0P (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 May 2019 02:26:15 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.17.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3152F20833;
        Fri, 17 May 2019 06:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558074374;
        bh=GdNj1kVcG98Mh6w82ct3kOQTIhlA8j7gO0BlJ8ugMj0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uwk4G9ebyRl8DwRaQURcxQRs/yG/Okw/udEu3xItCEhZKomFLLtHuuGgsmHmQ/p6U
         p78CjlvQpXNhGIw9ytP3lmORySjpcHOUTy43+pxjSVpgj4+ECfwoDDejNHzPznaJno
         nszlyjhdYCpxOnXrLhEWhTYUwXe8Gmo60/PJNPBo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH v2] mt76: mt7615: add support for mtd eeprom parsing
Date:   Fri, 17 May 2019 08:26:05 +0200
Message-Id: <12c5ae00296007af2da0021cc0872dac9b6960dc.1558074163.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558074163.git.lorenzo@kernel.org>
References: <cover.1558074163.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Calibration data are often available on a specific mtd partition on
embedded devices. Take into account eeprom calibration data if
available.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- remove TODO comment
- take into account mtd partition even if otp one is empty
---
 .../wireless/mediatek/mt76/mt7615/eeprom.c    | 29 +++++++++++++++----
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index dd5ab46a4f66..1712f66520a8 100644
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
@@ -84,7 +98,10 @@ int mt7615_eeprom_init(struct mt7615_dev *dev)
 	if (ret < 0)
 		return ret;
 
-	memcpy(dev->mt76.eeprom.data, dev->mt76.otp.data, MT7615_EEPROM_SIZE);
+	ret = mt7615_check_eeprom(&dev->mt76);
+	if (ret && dev->mt76.otp.data)
+		memcpy(dev->mt76.eeprom.data, dev->mt76.otp.data,
+		       MT7615_EEPROM_SIZE);
 
 	dev->mt76.cap.has_2ghz = true;
 	dev->mt76.cap.has_5ghz = true;
-- 
2.20.1

