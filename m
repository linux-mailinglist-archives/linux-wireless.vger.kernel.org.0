Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 884333CA493
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jul 2021 19:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhGORhV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jul 2021 13:37:21 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:55222 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229682AbhGORhV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jul 2021 13:37:21 -0400
X-UUID: 7550ccc9b3aa4897a15cede05f98d214-20210716
X-UUID: 7550ccc9b3aa4897a15cede05f98d214-20210716
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 76352194; Fri, 16 Jul 2021 01:34:23 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 16 Jul 2021 01:34:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 16 Jul 2021 01:34:22 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Jimmy Hu <Jimmy.Hu@mediatek.com>, <jemele@google.com>,
        <yenlinlai@google.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] mt76: mt7921: Add mt7922 support
Date:   Fri, 16 Jul 2021 01:34:19 +0800
Message-ID: <27e39fd3c6d70837772e56f85bf9b01e8beeca47.1626370282.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

Add new chip mt7922 in mt7921 module with following items
1. new chip ID / fw bin name
2. is_mt7922()
	check chip type for different fw files
3. mt7921_get_data_mode()
	check security type of fw (backward compatible)

Co-developed-by: Jimmy Hu <Jimmy.Hu@mediatek.com>
Signed-off-by: Jimmy Hu <Jimmy.Hu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |  7 +-
 .../wireless/mediatek/mt76/mt7921/eeprom.c    |  1 +
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 71 +++++++++++++++++--
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  3 +
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  3 +
 5 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index f49d97d0a1c5..e7f01c2978a2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -85,9 +85,14 @@ struct mt76_connac_coredump {
 
 extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
 
+static inline bool is_mt7922(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7922;
+}
+
 static inline bool is_mt7921(struct mt76_dev *dev)
 {
-	return mt76_chip(dev) == 0x7961;
+	return mt76_chip(dev) == 0x7961 || is_mt7922(dev);
 }
 
 static inline bool is_mt7663(struct mt76_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c
index 691d14a1a7bf..4d0a4aeac6bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c
@@ -36,6 +36,7 @@ static int mt7921_check_eeprom(struct mt7921_dev *dev)
 	val = get_unaligned_le16(eeprom);
 
 	switch (val) {
+	case 0x7922:
 	case 0x7961:
 		return 0;
 	default:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 35d57d94dadd..5672198a94e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -82,9 +82,17 @@ struct mt7921_fw_region {
 #define FW_START_OVERRIDE		BIT(0)
 #define FW_START_WORKING_PDA_CR4	BIT(2)
 
+#define PATCH_SEC_NOT_SUPPORT		GENMASK(31, 0)
 #define PATCH_SEC_TYPE_MASK		GENMASK(15, 0)
 #define PATCH_SEC_TYPE_INFO		0x2
 
+#define PATCH_SEC_ENC_TYPE_MASK		GENMASK(31, 24)
+#define PATCH_SEC_ENC_TYPE_PLAIN		0x00
+#define PATCH_SEC_ENC_TYPE_AES			0x01
+#define PATCH_SEC_ENC_TYPE_SCRAMBLE		0x02
+#define PATCH_SEC_ENC_SCRAMBLE_INFO_MASK	GENMASK(15, 0)
+#define PATCH_SEC_ENC_AES_KEY_MASK		GENMASK(7, 0)
+
 #define to_wcid_lo(id)			FIELD_GET(GENMASK(7, 0), (u16)id)
 #define to_wcid_hi(id)			FIELD_GET(GENMASK(9, 8), (u16)id)
 
@@ -738,6 +746,46 @@ static int mt7921_driver_own(struct mt7921_dev *dev)
 	return 0;
 }
 
+static u32 mt7921_get_data_mode(struct mt7921_dev *dev, u32 info)
+{
+	u32 mode = DL_MODE_NEED_RSP;
+
+	if (info == PATCH_SEC_NOT_SUPPORT)
+		return mode;
+
+	switch (FIELD_GET(PATCH_SEC_ENC_TYPE_MASK, info)) {
+	case PATCH_SEC_ENC_TYPE_PLAIN:
+		break;
+	case PATCH_SEC_ENC_TYPE_AES:
+		mode |= DL_MODE_ENCRYPT;
+		mode |= FIELD_PREP(DL_MODE_KEY_IDX,
+				(info & PATCH_SEC_ENC_AES_KEY_MASK)) & DL_MODE_KEY_IDX;
+		mode |= DL_MODE_RESET_SEC_IV;
+		break;
+	case PATCH_SEC_ENC_TYPE_SCRAMBLE:
+		mode |= DL_MODE_ENCRYPT;
+		mode |= DL_CONFIG_ENCRY_MODE_SEL;
+		mode |= DL_MODE_RESET_SEC_IV;
+		break;
+	default:
+		dev_err(dev->mt76.dev, "Encryption type not support!\n");
+	}
+
+	return mode;
+}
+
+static char *mt7921_patch_name(struct mt7921_dev *dev)
+{
+	char *ret;
+
+	if (is_mt7922(&dev->mt76))
+		ret = MT7922_ROM_PATCH;
+	else
+		ret = MT7921_ROM_PATCH;
+
+	return ret;
+}
+
 static int mt7921_load_patch(struct mt7921_dev *dev)
 {
 	const struct mt7921_patch_hdr *hdr;
@@ -755,7 +803,7 @@ static int mt7921_load_patch(struct mt7921_dev *dev)
 		return -EAGAIN;
 	}
 
-	ret = request_firmware(&fw, MT7921_ROM_PATCH, dev->mt76.dev);
+	ret = request_firmware(&fw, mt7921_patch_name(dev), dev->mt76.dev);
 	if (ret)
 		goto out;
 
@@ -773,7 +821,8 @@ static int mt7921_load_patch(struct mt7921_dev *dev)
 	for (i = 0; i < be32_to_cpu(hdr->desc.n_region); i++) {
 		struct mt7921_patch_sec *sec;
 		const u8 *dl;
-		u32 len, addr;
+		u32 len, addr, mode;
+		u32 sec_info = 0;
 
 		sec = (struct mt7921_patch_sec *)(fw->data + sizeof(*hdr) +
 						  i * sizeof(*sec));
@@ -786,9 +835,11 @@ static int mt7921_load_patch(struct mt7921_dev *dev)
 		addr = be32_to_cpu(sec->info.addr);
 		len = be32_to_cpu(sec->info.len);
 		dl = fw->data + be32_to_cpu(sec->offs);
+		sec_info = be32_to_cpu(sec->info.sec_key_idx);
+		mode = mt7921_get_data_mode(dev, sec_info);
 
 		ret = mt76_connac_mcu_init_download(&dev->mt76, addr, len,
-						    DL_MODE_NEED_RSP);
+						    mode);
 		if (ret) {
 			dev_err(dev->mt76.dev, "Download request failed\n");
 			goto out;
@@ -885,13 +936,25 @@ mt7921_mcu_send_ram_firmware(struct mt7921_dev *dev,
 	return mt76_connac_mcu_start_firmware(&dev->mt76, override, option);
 }
 
+static char *mt7921_ram_name(struct mt7921_dev *dev)
+{
+	char *ret;
+
+	if (is_mt7922(&dev->mt76))
+		ret = MT7922_FIRMWARE_WM;
+	else
+		ret = MT7921_FIRMWARE_WM;
+
+	return ret;
+}
+
 static int mt7921_load_ram(struct mt7921_dev *dev)
 {
 	const struct mt7921_fw_trailer *hdr;
 	const struct firmware *fw;
 	int ret;
 
-	ret = request_firmware(&fw, MT7921_FIRMWARE_WM, dev->mt76.dev);
+	ret = request_firmware(&fw, mt7921_ram_name(dev), dev->mt76.dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 6e9e4dfb3928..51bcaa599268 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -33,6 +33,9 @@
 #define MT7921_FIRMWARE_WM		"mediatek/WIFI_RAM_CODE_MT7961_1.bin"
 #define MT7921_ROM_PATCH		"mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin"
 
+#define MT7922_FIRMWARE_WM		"mediatek/WIFI_RAM_CODE_MT7922_1.bin"
+#define MT7922_ROM_PATCH		"mediatek/WIFI_MT7922_patch_mcu_1_1_hdr.bin"
+
 #define MT7921_EEPROM_SIZE		3584
 #define MT7921_TOKEN_SIZE		8192
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 33782e1ee312..97ca8290881f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -14,6 +14,7 @@
 
 static const struct pci_device_id mt7921_pci_device_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7961) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7922) },
 	{ },
 };
 
@@ -336,6 +337,8 @@ module_pci_driver(mt7921_pci_driver);
 MODULE_DEVICE_TABLE(pci, mt7921_pci_device_table);
 MODULE_FIRMWARE(MT7921_FIRMWARE_WM);
 MODULE_FIRMWARE(MT7921_ROM_PATCH);
+MODULE_FIRMWARE(MT7922_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7922_ROM_PATCH);
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.25.1

