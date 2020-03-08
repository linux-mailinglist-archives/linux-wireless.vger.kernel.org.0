Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0F317D6B2
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2020 23:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgCHWJh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Mar 2020 18:09:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726359AbgCHWJh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Mar 2020 18:09:37 -0400
Received: from localhost.localdomain (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 565FC206D5;
        Sun,  8 Mar 2020 22:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583705376;
        bh=ClEtp1En2MFQuA84YM8YGq24ONE/Krkd5mLZB2J//C0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hdzJ+wtnpzyxQlO/Bg4i95s0vOa44ndyUWwdLtACgMtWzOk5qXW9I7tyrhbfd2Gkj
         418vrORU3vH1glYdPJrD5Chuw4BATY/3lfA+K4gXaRGxRDMr9bJfUAwzqdJQC+y7mz
         Zy5X8Z6PiLPLJmGcOOXlWkPCdBqmOL3KflSyB/4A=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com
Subject: [PATCH v2 18/25] mt76: mt7615: introduce mt7615_eeprom_parse_hw_band_cap routine
Date:   Sun,  8 Mar 2020 23:08:30 +0100
Message-Id: <0e2ba90afc633dd7834ed479c10dd69b17f447b1.1583705012.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583705012.git.lorenzo@kernel.org>
References: <cover.1583705012.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce mt7615_eeprom_parse_hw_band_cap routine in order to configure
supported band for mt7663e and mt7622 devices since they do not rely on
eeprom data to enable 2GHz/5GHz bands

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/eeprom.c    | 30 +++++++++++++++----
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index 5220c18e711f..b1091694569e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -91,11 +91,23 @@ static int mt7615_check_eeprom(struct mt76_dev *dev)
 	}
 }
 
-static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
+static void
+mt7615_eeprom_parse_hw_band_cap(struct mt7615_dev *dev)
 {
-	u8 *eeprom = dev->mt76.eeprom.data;
-	u8 tx_mask, max_nss;
-	u32 val;
+	u8 val, *eeprom = dev->mt76.eeprom.data;
+
+	if (is_mt7663(&dev->mt76)) {
+		/* dual band */
+		dev->mt76.cap.has_2ghz = true;
+		dev->mt76.cap.has_5ghz = true;
+		return;
+	}
+
+	if (is_mt7622(&dev->mt76)) {
+		/* 2GHz only */
+		dev->mt76.cap.has_2ghz = true;
+		return;
+	}
 
 	val = FIELD_GET(MT_EE_NIC_WIFI_CONF_BAND_SEL,
 			eeprom[MT_EE_WIFI_CONF]);
@@ -111,9 +123,15 @@ static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
 		dev->mt76.cap.has_5ghz = true;
 		break;
 	}
+}
+
+static void mt7615_eeprom_parse_hw_cap(struct mt7615_dev *dev)
+{
+	u8 *eeprom = dev->mt76.eeprom.data;
+	u8 tx_mask, max_nss;
+	u32 val;
 
-	if (is_mt7622(&dev->mt76))
-		dev->mt76.cap.has_5ghz = false;
+	mt7615_eeprom_parse_hw_band_cap(dev);
 
 	/* read tx-rx mask from eeprom */
 	val = mt76_rr(dev, MT_TOP_STRAP_STA);
-- 
2.24.1

