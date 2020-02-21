Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBF8C166B52
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2020 01:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgBUAIP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Feb 2020 19:08:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729410AbgBUAIP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Feb 2020 19:08:15 -0500
Received: from localhost.localdomain (unknown [151.48.137.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5623208E4;
        Fri, 21 Feb 2020 00:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582243694;
        bh=ClEtp1En2MFQuA84YM8YGq24ONE/Krkd5mLZB2J//C0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D8dP9SSzbJ1cf/okAc6TYaCO/Df6j6qc0A+tr9UhMAn+7395JHvt3kalYGVcRTbAv
         wl1x80pFqRTnlpuw5VtZAAdvl0xGRVtzook9ce2hr+KY1U/RpjoJ+wJX1Ilg424Zgk
         SqTysTeIk7q4cllO9GkDNBGbJh35Nq70v6727pMM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, ryder.lee@mediatek.com
Subject: [PATCH 6/8] mt76: mt7615: introduce mt7615_eeprom_parse_hw_band_cap routine
Date:   Fri, 21 Feb 2020 01:07:33 +0100
Message-Id: <11c3f562ee4b39244f7b40f2abd6378c4595e89d.1582243031.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1582243031.git.lorenzo@kernel.org>
References: <cover.1582243031.git.lorenzo@kernel.org>
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

