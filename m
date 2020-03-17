Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A669188AC0
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 17:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgCQQmZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 12:42:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgCQQmY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 12:42:24 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D54D620738;
        Tue, 17 Mar 2020 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584463344;
        bh=/Ds2yt1LMHxTq8JqlrCE4xj/w3NW71MR4QrZ+i3Qins=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dV7SsBevteJDvdS99PcFmbhSbD0y+CD/epiTe3qjWauyja67lDBg/OOhorZDFDai1
         H47vzhHMKezmZfTtBG5HxLaGzu9a6GbM80gcwhC/JeFAlfMpGkhbgm8aBFbZKXhLZW
         NpE3IgX2MFaZGKr3KotLRMX2HMt9Kb+QGO6xpRZI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 17/25] mt76: mt7615: add mt7663e support to mt7615_mcu_set_eeprom
Date:   Tue, 17 Mar 2020 17:41:24 +0100
Message-Id: <67f665ca06e0228a2af3a4f66eb20a8d9c05c911.1584463004.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1584463004.git.lorenzo@kernel.org>
References: <cover.1584463004.git.lorenzo@kernel.org>
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
index 9d044f23340e..e73cd3cb014a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1539,19 +1539,30 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
 {
 	struct {
 		u8 buffer_mode;
-		u8 pad;
+		u8 content_format;
 		__le16 len;
 	} __packed req_hdr = {
 		.buffer_mode = 1,
 	};
 	u8 *eep = (u8 *)dev->mt76.eeprom.data;
 	struct sk_buff *skb;
-	int eep_len;
+	int eep_len, offset;
 
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
 
 	req_hdr.len = cpu_to_le16(eep_len);
 
@@ -1560,7 +1571,7 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
 		return -ENOMEM;
 
 	skb_put_data(skb, &req_hdr, sizeof(req_hdr));
-	skb_put_data(skb, eep + MT_EE_NIC_CONF_0, eep_len);
+	skb_put_data(skb, eep + offset, eep_len);
 
 	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				       MCU_EXT_CMD_EFUSE_BUFFER_MODE, true);
-- 
2.25.1

