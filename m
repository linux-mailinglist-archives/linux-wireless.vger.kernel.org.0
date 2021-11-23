Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56CD8459D22
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Nov 2021 08:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234499AbhKWHxw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Nov 2021 02:53:52 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:56504 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234464AbhKWHxq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Nov 2021 02:53:46 -0500
X-UUID: 6b21885bebed444b9845b5f95d3e86fe-20211123
X-UUID: 6b21885bebed444b9845b5f95d3e86fe-20211123
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1258051714; Tue, 23 Nov 2021 15:50:36 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 23 Nov 2021 15:50:35 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 23 Nov
 2021 15:50:35 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 23 Nov 2021 15:50:34 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH v3 10/11] mt76: mt7915: add mt7916 calibrated data support
Date:   Tue, 23 Nov 2021 15:49:54 +0800
Message-ID: <369ff3d8db30ea1a6da665d5ef2ba05148173819.1637652742.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1637652742.git.Bo.Jiao@mediatek.com>
References: <cover.1637652742.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

Adjust proper eeprom size and add default calibrated data support
for mt7916.

Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
Reviewed-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c | 11 ++++++++---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c    |  7 ++++---
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h |  8 ++++++++
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index 40dcbeb..6aa749b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -35,6 +35,7 @@ static int mt7915_check_eeprom(struct mt7915_dev *dev)
 
 	switch (val) {
 	case 0x7915:
+	case 0x7916:
 		return 0;
 	default:
 		return -EINVAL;
@@ -52,6 +53,9 @@ mt7915_eeprom_load_default(struct mt7915_dev *dev)
 	if (dev->dbdc_support)
 		default_bin = MT7915_EEPROM_DEFAULT_DBDC;
 
+	if (!is_mt7915(&dev->mt76))
+		default_bin = MT7916_EEPROM_DEFAULT;
+
 	ret = request_firmware(&fw, default_bin, dev->mt76.dev);
 	if (ret)
 		return ret;
@@ -62,7 +66,7 @@ mt7915_eeprom_load_default(struct mt7915_dev *dev)
 		goto out;
 	}
 
-	memcpy(eeprom, fw->data, MT7915_EEPROM_SIZE);
+	memcpy(eeprom, fw->data, mt7915_eeprom_size(dev));
 	dev->flash_mode = true;
 
 out:
@@ -74,8 +78,9 @@ out:
 static int mt7915_eeprom_load(struct mt7915_dev *dev)
 {
 	int ret;
+	u16 eeprom_size = mt7915_eeprom_size(dev);
 
-	ret = mt76_eeprom_init(&dev->mt76, MT7915_EEPROM_SIZE);
+	ret = mt76_eeprom_init(&dev->mt76, eeprom_size);
 	if (ret < 0)
 		return ret;
 
@@ -91,7 +96,7 @@ static int mt7915_eeprom_load(struct mt7915_dev *dev)
 			return -EINVAL;
 
 		/* read eeprom data from efuse */
-		block_num = DIV_ROUND_UP(MT7915_EEPROM_SIZE,
+		block_num = DIV_ROUND_UP(eeprom_size,
 					 MT7915_EEPROM_BLOCK_SIZE);
 		for (i = 0; i < block_num; i++)
 			mt7915_mcu_get_eeprom(dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 42a9135..668c617 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3514,7 +3514,8 @@ static int mt7915_mcu_set_eeprom_flash(struct mt7915_dev *dev)
 #define PAGE_IDX_MASK		GENMASK(4, 2)
 #define PER_PAGE_SIZE		0x400
 	struct mt7915_mcu_eeprom req = { .buffer_mode = EE_MODE_BUFFER };
-	u8 total = DIV_ROUND_UP(MT7915_EEPROM_SIZE, PER_PAGE_SIZE);
+	u16 eeprom_size = mt7915_eeprom_size(dev);
+	u8 total = DIV_ROUND_UP(eeprom_size, PER_PAGE_SIZE);
 	u8 *eep = (u8 *)dev->mt76.eeprom.data;
 	int eep_len;
 	int i;
@@ -3523,8 +3524,8 @@ static int mt7915_mcu_set_eeprom_flash(struct mt7915_dev *dev)
 		struct sk_buff *skb;
 		int ret;
 
-		if (i == total - 1 && !!(MT7915_EEPROM_SIZE % PER_PAGE_SIZE))
-			eep_len = MT7915_EEPROM_SIZE % PER_PAGE_SIZE;
+		if (i == total - 1 && !!(eeprom_size % PER_PAGE_SIZE))
+			eep_len = eeprom_size % PER_PAGE_SIZE;
 		else
 			eep_len = PER_PAGE_SIZE;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index e8fbe69..4cc2666 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -37,8 +37,11 @@
 
 #define MT7915_EEPROM_DEFAULT		"mediatek/mt7915_eeprom.bin"
 #define MT7915_EEPROM_DEFAULT_DBDC	"mediatek/mt7915_eeprom_dbdc.bin"
+#define MT7916_EEPROM_DEFAULT		"mediatek/mt7916_eeprom.bin"
 
 #define MT7915_EEPROM_SIZE		3584
+#define MT7916_EEPROM_SIZE		4096
+
 #define MT7915_EEPROM_BLOCK_SIZE	16
 #define MT7915_TOKEN_SIZE		8192
 
@@ -483,6 +486,11 @@ static inline u16 mt7915_wtbl_size(struct mt7915_dev *dev)
 	return is_mt7915(&dev->mt76) ? MT7915_WTBL_SIZE : MT7916_WTBL_SIZE;
 }
 
+static inline u16 mt7915_eeprom_size(struct mt7915_dev *dev)
+{
+	return is_mt7915(&dev->mt76) ? MT7915_EEPROM_SIZE : MT7916_EEPROM_SIZE;
+}
+
 void mt7915_dual_hif_set_irq_mask(struct mt7915_dev *dev, bool write_reg,
 				  u32 clear, u32 set);
 
-- 
2.18.0

