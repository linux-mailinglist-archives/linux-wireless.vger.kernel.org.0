Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0F77166B50
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2020 01:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgBUAIN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Feb 2020 19:08:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:38712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729373AbgBUAIM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Feb 2020 19:08:12 -0500
Received: from localhost.localdomain (unknown [151.48.137.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 112382071E;
        Fri, 21 Feb 2020 00:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582243692;
        bh=7+18sp25jTYgLmeUI9KTxSL/+oFBGmYyxBuYYLoCKzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EWk6w7Z5YEMH3Vl4DDfAjhUzlMo4fIzVY6rR0NNt+Nwb6wpHLs5O5qlB/2yvBhxqB
         eLdbXhhtGEPMpwSrx6P3YqTVGIE3NeFdrjExhL0j/NBe6fAspQ5Oqd0kB5qY/5DtwO
         Xm9eFNiyAds9Jbp270HFzkc/nO4fHunOGtmf2mJs=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, ryder.lee@mediatek.com
Subject: [PATCH 5/8] mt76: mt7615: add mt7663e support to mt7615_mcu_set_eeprom
Date:   Fri, 21 Feb 2020 01:07:32 +0100
Message-Id: <f74bbe919011acfb69462989efbf4d107d1cc443.1582243031.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1582243031.git.lorenzo@kernel.org>
References: <cover.1582243031.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Extend mt7615_mcu_set_eeprom routine in order to be reused
adding mt7663e support to mt7615 driver

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt7615/eeprom.h    |  2 ++
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 21 ++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
index 18c7301521b7..8a2a64b7fcd3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.h
@@ -18,11 +18,13 @@ enum mt7615_eeprom_field {
 	MT_EE_TX1_5G_G0_TARGET_POWER =		0x098,
 	MT_EE_EXT_PA_2G_TARGET_POWER =		0x0f2,
 	MT_EE_EXT_PA_5G_TARGET_POWER =		0x0f3,
+	MT7663_EE_TX0_2G_TARGET_POWER =		0x123,
 	MT_EE_TX2_5G_G0_TARGET_POWER =		0x142,
 	MT_EE_TX3_5G_G0_TARGET_POWER =		0x16a,
 
 	MT7615_EE_MAX =				0x3bf,
 	MT7622_EE_MAX =				0x3db,
+	MT7663_EE_MAX =				0x400,
 };
 
 #define MT_EE_NIC_CONF_TX_MASK			GENMASK(7, 4)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index a244585d78df..fbf892750e2c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -731,18 +731,29 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
 {
 	struct {
 		u8 buffer_mode;
-		u8 pad;
+		u8 content_format;
 		__le16 len;
 	} __packed req_hdr = {
 		.buffer_mode = 1,
 	};
-	int ret, len, eep_len;
+	int ret, len, eep_len, offset;
 	u8 *req, *eep = (u8 *)dev->mt76.eeprom.data;
 
-	if (is_mt7622(&dev->mt76))
+	switch (mt76_chip(&dev->mt76)) {
+	case 0x7622:
 		eep_len = MT7622_EE_MAX - MT_EE_NIC_CONF_0;
-	else
+		offset = MT_EE_NIC_CONF_0;
+		break;
+	case 0x7663:
+		eep_len = MT7663_EE_MAX - MT_EE_CHIP_ID;
+		req_hdr.content_format = 1;
+		offset = MT_EE_CHIP_ID;
+		break;
+	default:
 		eep_len = MT7615_EE_MAX - MT_EE_NIC_CONF_0;
+		offset = MT_EE_NIC_CONF_0;
+		break;
+	}
 
 	len = sizeof(req_hdr) + eep_len;
 	req = kzalloc(len, GFP_KERNEL);
@@ -751,7 +762,7 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
 
 	req_hdr.len = cpu_to_le16(eep_len);
 	memcpy(req, &req_hdr, sizeof(req_hdr));
-	memcpy(req + sizeof(req_hdr), eep + MT_EE_NIC_CONF_0, eep_len);
+	memcpy(req + sizeof(req_hdr), eep + offset, eep_len);
 
 	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
 				  req, len, true);
-- 
2.24.1

