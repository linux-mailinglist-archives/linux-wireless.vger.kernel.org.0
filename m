Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE6E440FE6
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Oct 2021 18:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhJaRv0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 Oct 2021 13:51:26 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:35918 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229732AbhJaRvZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 Oct 2021 13:51:25 -0400
X-UUID: dedf4ae4095f4c83bd468bf2b0a5e2c6-20211101
X-UUID: dedf4ae4095f4c83bd468bf2b0a5e2c6-20211101
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1684661763; Mon, 01 Nov 2021 01:48:50 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 1 Nov 2021 01:48:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs10n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Mon, 1 Nov 2021 01:48:49 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH v3] mt76: mt7915: add default calibrated data support
Date:   Mon, 1 Nov 2021 01:48:42 +0800
Message-ID: <20211031174842.3503-1-shayne.chen@mediatek.com>
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
v2: drop unnecessary goto and return
v3: simplify duplicate instances of mt7915_eeprom_load_default()
---
 .../wireless/mediatek/mt76/mt7915/eeprom.c    | 83 +++++++++++++++----
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 24 ++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  1 +
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 +
 4 files changed, 94 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index ee3d644..edd74d0 100644
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
+		return ret;
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
@@ -31,10 +78,16 @@ static int mt7915_eeprom_load(struct mt7915_dev *dev)
 
 	if (ret) {
 		dev->flash_mode = true;
-		ret = mt7915_eeprom_load_precal(dev);
 	} else {
+		u8 free_block_num;
 		u32 block_num, i;
 
+		mt7915_mcu_get_eeprom_free_block(dev, &free_block_num);
+		/* efuse info not enough */
+		if (free_block_num >= 29)
+			return -EINVAL;
+
+		/* read eeprom data from efuse */
 		block_num = DIV_ROUND_UP(MT7915_EEPROM_SIZE,
 					 MT7915_EEPROM_BLOCK_SIZE);
 		for (i = 0; i < block_num; i++)
@@ -42,20 +95,7 @@ static int mt7915_eeprom_load(struct mt7915_dev *dev)
 					      i * MT7915_EEPROM_BLOCK_SIZE);
 	}
 
-	return ret;
-}
-
-static int mt7915_check_eeprom(struct mt7915_dev *dev)
-{
-	u8 *eeprom = dev->mt76.eeprom.data;
-	u16 val = get_unaligned_le16(eeprom);
-
-	switch (val) {
-	case 0x7915:
-		return 0;
-	default:
-		return -EINVAL;
-	}
+	return mt7915_check_eeprom(dev);
 }
 
 void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
@@ -117,10 +157,17 @@ int mt7915_eeprom_init(struct mt7915_dev *dev)
 	int ret;
 
 	ret = mt7915_eeprom_load(dev);
-	if (ret < 0)
-		return ret;
+	if (ret < 0) {
+		if (ret != -EINVAL)
+			return ret;
+
+		dev_warn(dev->mt76.dev, "eeprom load fail, use default bin\n");
+		ret = mt7915_eeprom_load_default(dev);
+		if (ret)
+			return ret;
+	}
 
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

