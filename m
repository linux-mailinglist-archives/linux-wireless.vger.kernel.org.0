Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2302D91CF
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Dec 2020 03:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437909AbgLNCkL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Dec 2020 21:40:11 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:42028 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725804AbgLNCkL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Dec 2020 21:40:11 -0500
X-UUID: ee200a889e8e483fb8adf94bf7344844-20201214
X-UUID: ee200a889e8e483fb8adf94bf7344844-20201214
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 33038505; Mon, 14 Dec 2020 10:39:25 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Dec 2020 10:39:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Dec 2020 10:39:23 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH] mt76: mt7915: add support for flash mode
Date:   Mon, 14 Dec 2020 10:38:55 +0800
Message-ID: <20201214023855.28525-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for getting rf values from flash.
This is used for some test purposes and products.
If the mtd partition is configured in dts, driver will read from flash
to init eeprom command; if not, still init it with efuse's values.

An example:
&slot0 {
	mt7915@0,0 {
		reg = <0x0000 0 0 0 0>;
		device_type = "pci";
		mediatek,mtd-eeprom = <&factory 0x0000>;
	};
};

Acked-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/eeprom.c    |  5 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 56 ++++++++++++++++---
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  6 ++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
 4 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 7a2be3f61398..0a3ac07bab4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -22,7 +22,10 @@ static int mt7915_eeprom_load(struct mt7915_dev *dev)
 	if (ret < 0)
 		return ret;
 
-	memset(dev->mt76.eeprom.data, -1, MT7915_EEPROM_SIZE);
+	if (ret)
+		dev->flash_mode = true;
+	else
+		memset(dev->mt76.eeprom.data, -1, MT7915_EEPROM_SIZE);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 5fdd1a6d32ee..d8b6f9b06670 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3229,16 +3229,56 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 	return mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), true);
 }
 
+static int mt7915_mcu_set_eeprom_flash(struct mt7915_dev *dev)
+{
+#define TOTAL_PAGE_MASK		GENMASK(7, 5)
+#define PAGE_IDX_MASK		GENMASK(4, 2)
+#define PER_PAGE_SIZE		0x400
+	struct mt7915_mcu_eeprom req = { .buffer_mode = EE_MODE_BUFFER };
+	u8 total = MT7915_EEPROM_SIZE / PER_PAGE_SIZE;
+	u8 *eep = (u8 *)dev->mt76.eeprom.data;
+	int eep_len;
+	int i;
+
+	for (i = 0; i <= total; i++, eep += eep_len) {
+		struct sk_buff *skb;
+		int ret;
+
+		if (i == total)
+			eep_len = MT7915_EEPROM_SIZE % PER_PAGE_SIZE;
+		else
+			eep_len = PER_PAGE_SIZE;
+
+		skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
+					 sizeof(req) + eep_len);
+		if (!skb)
+			return -ENOMEM;
+
+		req.format = FIELD_PREP(TOTAL_PAGE_MASK, total) |
+			     FIELD_PREP(PAGE_IDX_MASK, i) | EE_FORMAT_WHOLE;
+		req.len = cpu_to_le16(eep_len);
+
+		skb_put_data(skb, &req, sizeof(req));
+		skb_put_data(skb, eep, eep_len);
+
+		ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+					    MCU_EXT_CMD_EFUSE_BUFFER_MODE, true);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int mt7915_mcu_set_eeprom(struct mt7915_dev *dev)
 {
-	struct req_hdr {
-		u8 buffer_mode;
-		u8 format;
-		__le16 len;
-	} __packed req = {
-		.buffer_mode = EE_MODE_EFUSE,
-		.format = EE_FORMAT_WHOLE,
-	};
+	struct mt7915_mcu_eeprom req;
+
+	if (dev->flash_mode)
+		return mt7915_mcu_set_eeprom_flash(dev);
+
+	req.buffer_mode = EE_MODE_EFUSE;
+	req.format = EE_FORMAT_WHOLE;
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
 				 &req, sizeof(req), true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index cd1a4256c843..30ec2ef4cc74 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -118,6 +118,12 @@ struct mt7915_mcu_rdd_report {
 	} hw_pulse[32];
 } __packed;
 
+struct mt7915_mcu_eeprom {
+	u8 buffer_mode;
+	u8 format;
+	__le16 len;
+} __packed;
+
 struct mt7915_mcu_eeprom_info {
 	__le32 addr;
 	__le32 valid;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 0339abf360d3..c0041240b6c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -168,6 +168,7 @@ struct mt7915_dev {
 	s8 **rate_power; /* TODO: use mt76_rate_power */
 
 	bool dbdc_support;
+	bool flash_mode;
 	bool fw_debug;
 
 #ifdef CONFIG_NL80211_TESTMODE
-- 
2.29.2

