Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F80343C4AF
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 10:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240761AbhJ0ILE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 04:11:04 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:37184 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231396AbhJ0ILE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 04:11:04 -0400
X-UUID: 75109b8a2abf440ca1f419c40b93c59a-20211027
X-UUID: 75109b8a2abf440ca1f419c40b93c59a-20211027
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 170485711; Wed, 27 Oct 2021 16:08:34 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 27 Oct 2021 16:08:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Oct 2021 16:08:32 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH] mt76: mt7915: add default calibrated data support
Date:   Wed, 27 Oct 2021 16:07:47 +0800
Message-ID: <20211027080747.24388-1-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Load the default eeprom data when the content of flash/efuse is invalid.
This could help to eliminate some issues due to incorrect or
insufficient rf values.

Co-developed-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/eeprom.c    | 83 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 24 ++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 +
 4 files changed, 98 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index ee3d644..626ea4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: ISC
 /* Copyright (C) 2020 MediaTek Inc. */
 
+#include <linux/firmware.h>
 #include "mt7915.h"
 #include "eeprom.h"
 
@@ -10,6 +11,9 @@ static int mt7915_eeprom_load_precal(struct mt7915_dev *dev)
 	u8 *eeprom = mdev->eeprom.data;
 	u32 val = eeprom[MT_EE_DO_PRE_CAL];
 
+	if (!dev->flash_mode)
+		return 0;
+
 	if (val != (MT_EE_WIFI_CAL_DPD | MT_EE_WIFI_CAL_GROUP))
 		return 0;
 
@@ -21,6 +25,49 @@ static int mt7915_eeprom_load_precal(struct mt7915_dev *dev)
 	return mt76_get_of_eeprom(mdev, dev->cal, MT_EE_PRECAL, val);
 }
 
+static int mt7915_check_eeprom(struct mt7915_dev *dev)
+{
+	u8 *eeprom = dev->mt76.eeprom.data;
+	u16 val = get_unaligned_le16(eeprom);
+
+	switch (val) {
+	case 0x7915:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int
+mt7915_eeprom_load_default(struct mt7915_dev *dev)
+{
+	char *default_bin = MT7915_EEPROM_DEFAULT;
+	u8 *eeprom = dev->mt76.eeprom.data;
+	const struct firmware *fw = NULL;
+	int ret;
+
+	if (dev->dbdc_support)
+		default_bin = MT7915_EEPROM_DEFAULT_DBDC;
+
+	ret = request_firmware(&fw, default_bin, dev->mt76.dev);
+	if (ret)
+		goto out;
+
+	if (!fw || !fw->data) {
+		dev_err(dev->mt76.dev, "Invalid default bin\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	memcpy(eeprom, fw->data, MT7915_EEPROM_SIZE);
+	dev->flash_mode = true;
+
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+
 static int mt7915_eeprom_load(struct mt7915_dev *dev)
 {
 	int ret;
@@ -31,8 +78,8 @@ static int mt7915_eeprom_load(struct mt7915_dev *dev)
 
 	if (ret) {
 		dev->flash_mode = true;
-		ret = mt7915_eeprom_load_precal(dev);
 	} else {
+		/* read eeprom data from efuse */
 		u32 block_num, i;
 
 		block_num = DIV_ROUND_UP(MT7915_EEPROM_SIZE,
@@ -42,20 +89,28 @@ static int mt7915_eeprom_load(struct mt7915_dev *dev)
 					      i * MT7915_EEPROM_BLOCK_SIZE);
 	}
 
-	return ret;
-}
-
-static int mt7915_check_eeprom(struct mt7915_dev *dev)
-{
-	u8 *eeprom = dev->mt76.eeprom.data;
-	u16 val = get_unaligned_le16(eeprom);
+	if (!dev->flash_mode) {
+		u8 free_block_num;
+
+		mt7915_mcu_get_eeprom_free_block(dev, &free_block_num);
+		if (free_block_num >= 29) {
+			dev_warn(dev->mt76.dev,
+				 "efuse info not enough, use default bin\n");
+			ret = mt7915_eeprom_load_default(dev);
+			if (ret)
+				return ret;
+		}
+	}
 
-	switch (val) {
-	case 0x7915:
-		return 0;
-	default:
-		return -EINVAL;
+	ret = mt7915_check_eeprom(dev);
+	if (ret) {
+		dev_warn(dev->mt76.dev, "eeprom check fail, use default bin\n");
+		ret = mt7915_eeprom_load_default(dev);
+		if (ret)
+			return ret;
 	}
+
+	return ret;
 }
 
 void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
@@ -120,7 +175,7 @@ int mt7915_eeprom_init(struct mt7915_dev *dev)
 	if (ret < 0)
 		return ret;
 
-	ret = mt7915_check_eeprom(dev);
+	ret = mt7915_eeprom_load_precal(dev);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index b054663..ee9952d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3580,6 +3580,30 @@ int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset)
 	return 0;
 }
 
+int mt7915_mcu_get_eeprom_free_block(struct mt7915_dev *dev, u8 *block_num)
+{
+	struct {
+		u8 _rsv;
+		u8 version;
+		u8 die_idx;
+		u8 _rsv2;
+	} __packed req = {
+		.version = 1,
+	};
+	struct sk_buff *skb;
+	int ret;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_QUERY(EFUSE_FREE_BLOCK), &req,
+					sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	*block_num = *(u8 *)skb->data;
+	dev_kfree_skb(skb);
+
+	return 0;
+}
+
 static int mt7915_mcu_set_pre_cal(struct mt7915_dev *dev, u8 idx,
 				  u8 *data, u32 len, int cmd)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index b563e7c..e9f39ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -278,6 +278,7 @@ enum {
 	MCU_EXT_CMD_MUAR_UPDATE = 0x48,
 	MCU_EXT_CMD_RX_AIRTIME_CTRL = 0x4a,
 	MCU_EXT_CMD_SET_RX_PATH = 0x4e,
+	MCU_EXT_CMD_EFUSE_FREE_BLOCK = 0x4f,
 	MCU_EXT_CMD_TX_POWER_FEATURE_CTRL = 0x58,
 	MCU_EXT_CMD_GET_MIB_INFO = 0x5a,
 	MCU_EXT_CMD_MWDS_SUPPORT = 0x80,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index e69b4c8..c6c846d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -30,6 +30,9 @@
 #define MT7915_FIRMWARE_WM		"mediatek/mt7915_wm.bin"
 #define MT7915_ROM_PATCH		"mediatek/mt7915_rom_patch.bin"
 
+#define MT7915_EEPROM_DEFAULT		"mediatek/mt7915_eeprom.bin"
+#define MT7915_EEPROM_DEFAULT_DBDC	"mediatek/mt7915_eeprom_dbdc.bin"
+
 #define MT7915_EEPROM_SIZE		3584
 #define MT7915_EEPROM_BLOCK_SIZE	16
 #define MT7915_TOKEN_SIZE		8192
@@ -423,6 +426,7 @@ int mt7915_mcu_set_fixed_rate_ctrl(struct mt7915_dev *dev,
 				   void *data, u32 field);
 int mt7915_mcu_set_eeprom(struct mt7915_dev *dev);
 int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset);
+int mt7915_mcu_get_eeprom_free_block(struct mt7915_dev *dev, u8 *block_num);
 int mt7915_mcu_set_mac(struct mt7915_dev *dev, int band, bool enable,
 		       bool hdr_trans);
 int mt7915_mcu_set_test_param(struct mt7915_dev *dev, u8 param, bool test_mode,
-- 
2.25.1

