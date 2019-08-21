Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D88F098427
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 21:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbfHUTOs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 15:14:48 -0400
Received: from nbd.name ([46.4.11.11]:39506 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfHUTOr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 15:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TWWXZiaLLh61AqE6SYqCDUJTsdFYOBVH5suvDm8J1cQ=; b=HdPVQew22vAVj4iqe9k5m82y9q
        O4y/z5g+JvofNJYnHwIHZyH63tqYjbvoXDbKNalqOM7AjUHGvW0Pbe0VVAtuE5vhsdYbyo0suONW7
        NGY/IlNghgntHYMES2F97u7iie85Wzc0nTd/nwIhWCacT2vOS1Ef2iZfJN6DIH+FWwUM=;
Received: from p54ae9443.dip0.t-ipconnect.de ([84.174.148.67] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1i0W4D-0002e2-0K
        for linux-wireless@vger.kernel.org; Wed, 21 Aug 2019 21:14:46 +0200
Received: by maeck.local (Postfix, from userid 501)
        id A0A7863FB68B; Wed, 21 Aug 2019 21:14:43 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: apply calibration-free data from OTP
Date:   Wed, 21 Aug 2019 21:14:43 +0200
Message-Id: <20190821191443.36764-1-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MT7615 chips usually come pre-calibrated, even when used on embedded boards.
In that case, the on-flash EEPROM data needs to be merged with some data
from OTP ROM.
Run this merge if the external EEPROM data is valid and OTP has valid fields.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../wireless/mediatek/mt76/mt7615/eeprom.c    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
index dc94f52e6e8b..515bb58e19fd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
@@ -154,6 +154,42 @@ int mt7615_eeprom_get_power_index(struct mt7615_dev *dev,
 	return index;
 }
 
+static void mt7615_apply_cal_free_data(struct mt7615_dev *dev)
+{
+	static const u16 ical[] = {
+		0x53, 0x54, 0x55, 0x56, 0x57, 0x5c, 0x5d, 0x62, 0x63, 0x68,
+		0x69, 0x6e, 0x6f, 0x73, 0x74, 0x78, 0x79, 0x82, 0x83, 0x87,
+		0x88, 0x8c, 0x8d, 0x91, 0x92, 0x96, 0x97, 0x9b, 0x9c, 0xa0,
+		0xa1, 0xaa, 0xab, 0xaf, 0xb0, 0xb4, 0xb5, 0xb9, 0xba, 0xf4,
+		0xf7, 0xff,
+		0x140, 0x141, 0x145, 0x146, 0x14a, 0x14b, 0x154, 0x155, 0x159,
+		0x15a, 0x15e, 0x15f, 0x163, 0x164, 0x168, 0x169, 0x16d, 0x16e,
+		0x172, 0x173, 0x17c, 0x17d, 0x181, 0x182, 0x186, 0x187, 0x18b,
+		0x18c
+	};
+	static const u16 ical_nocheck[] = {
+		0x110, 0x111, 0x112, 0x113, 0x114, 0x115, 0x116, 0x117, 0x118,
+		0x1b5, 0x1b6, 0x1b7, 0x3ac, 0x3ad, 0x3ae, 0x3af, 0x3b0, 0x3b1,
+		0x3b2
+	};
+	u8 *eeprom = dev->mt76.eeprom.data;
+	u8 *otp = dev->mt76.otp.data;
+	int i;
+
+	if (!otp)
+		return;
+
+	for (i = 0; i < ARRAY_SIZE(ical); i++)
+		if (!otp[ical[i]])
+			return;
+
+	for (i = 0; i < ARRAY_SIZE(ical); i++)
+		eeprom[ical[i]] = otp[ical[i]];
+
+	for (i = 0; i < ARRAY_SIZE(ical_nocheck); i++)
+		eeprom[ical_nocheck[i]] = otp[ical_nocheck[i]];
+}
+
 int mt7615_eeprom_init(struct mt7615_dev *dev)
 {
 	int ret;
@@ -166,6 +202,8 @@ int mt7615_eeprom_init(struct mt7615_dev *dev)
 	if (ret && dev->mt76.otp.data)
 		memcpy(dev->mt76.eeprom.data, dev->mt76.otp.data,
 		       MT7615_EEPROM_SIZE);
+	else
+		mt7615_apply_cal_free_data(dev);
 
 	mt7615_eeprom_parse_hw_cap(dev);
 	memcpy(dev->mt76.macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
-- 
2.17.0

