Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4A73A3379
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jun 2021 20:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhFJSpy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Jun 2021 14:45:54 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:47451 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229935AbhFJSpx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Jun 2021 14:45:53 -0400
X-UUID: 032645850c2d477db0db35ca7d1f51a7-20210611
X-UUID: 032645850c2d477db0db35ca7d1f51a7-20210611
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1015333187; Fri, 11 Jun 2021 02:43:54 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 11 Jun 2021 02:43:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Jun 2021 02:43:52 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/4] mt76: mt7915: introduce mt7915_mcu_set_txbf()
Date:   Fri, 11 Jun 2021 02:43:46 +0800
Message-ID: <cdfdf6314d680143891739fc52f3e10e46a6d98f.1623347029.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <245a3745aea487793e40fbf82172c5367649bab3.1623347029.git.ryder.lee@mediatek.com>
References: <245a3745aea487793e40fbf82172c5367649bab3.1623347029.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use mt7915_mcu_set_txbf() to reduce global functions. This can be
easily extended to support other TxBF commands in further patches.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  3 +-
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  7 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 83 +++++++++----------
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  6 ++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 +-
 5 files changed, 50 insertions(+), 53 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 3961d46e0df8..c6e9a7038311 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -3,6 +3,7 @@
 
 #include "mt7915.h"
 #include "eeprom.h"
+#include "mcu.h"
 
 /** global debugfs **/
 
@@ -16,7 +17,7 @@ mt7915_implicit_txbf_set(void *data, u64 val)
 
 	dev->ibf = !!val;
 
-	return mt7915_mcu_set_txbf_type(dev);
+	return mt7915_mcu_set_txbf(dev, MT_BF_TYPE_UPDATE);
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index a0f8db9e3852..72b65799cc1a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -319,20 +319,19 @@ static int mt7915_txbf_init(struct mt7915_dev *dev)
 {
 	int ret;
 
-
 	if (dev->dbdc_support) {
-		ret = mt7915_mcu_set_txbf_module(dev);
+		ret = mt7915_mcu_set_txbf(dev, MT_BF_MODULE_UPDATE);
 		if (ret)
 			return ret;
 	}
 
 	/* trigger sounding packets */
-	ret = mt7915_mcu_set_txbf_sounding(dev);
+	ret = mt7915_mcu_set_txbf(dev, MT_BF_SOUNDING_ON);
 	if (ret)
 		return ret;
 
 	/* enable eBF */
-	return mt7915_mcu_set_txbf_type(dev);
+	return mt7915_mcu_set_txbf(dev, MT_BF_TYPE_UPDATE);
 }
 
 static int mt7915_register_ext_phy(struct mt7915_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index e28396938ce9..ca633c1bb8c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -3893,57 +3893,50 @@ int mt7915_mcu_set_ser(struct mt7915_dev *dev, u8 action, u8 set, u8 band)
 				 &req, sizeof(req), false);
 }
 
-int mt7915_mcu_set_txbf_module(struct mt7915_dev *dev)
+int mt7915_mcu_set_txbf(struct mt7915_dev *dev, u8 action)
 {
-#define MT_BF_MODULE_UPDATE               25
 	struct {
 		u8 action;
-		u8 bf_num;
-		u8 bf_bitmap;
-		u8 bf_sel[8];
-		u8 rsv[8];
+		union {
+			struct {
+				u8 snd_mode;
+				u8 sta_num;
+				u8 rsv;
+				u8 wlan_idx[4];
+				__le32 snd_period;	/* ms */
+			} __packed snd;
+			struct {
+				bool ebf;
+				bool ibf;
+				u8 rsv;
+			} __packed type;
+			struct {
+				u8 bf_num;
+				u8 bf_bitmap;
+				u8 bf_sel[8];
+				u8 rsv[5];
+			} __packed mod;
+		};
 	} __packed req = {
-		.action = MT_BF_MODULE_UPDATE,
-		.bf_num = 2,
-		.bf_bitmap = GENMASK(1, 0),
-	};
-
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(TXBF_ACTION), &req,
-				 sizeof(req), true);
-}
-
-int mt7915_mcu_set_txbf_type(struct mt7915_dev *dev)
-{
-#define MT_BF_TYPE_UPDATE		20
-	struct {
-		u8 action;
-		bool ebf;
-		bool ibf;
-		u8 rsv;
-	} __packed req = {
-		.action = MT_BF_TYPE_UPDATE,
-		.ebf = true,
-		.ibf = dev->ibf,
+		.action = action,
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(TXBF_ACTION), &req,
-				 sizeof(req), true);
-}
-
-int mt7915_mcu_set_txbf_sounding(struct mt7915_dev *dev)
-{
-#define MT_BF_PROCESSING		4
-	struct {
-		u8 action;
-		u8 snd_mode;
-		u8 sta_num;
-		u8 rsv;
-		u8 wlan_idx[4];
-		__le32 snd_period;	/* ms */
-	} __packed req = {
-		.action = true,
-		.snd_mode = MT_BF_PROCESSING,
-	};
+#define MT_BF_PROCESSING	4
+	switch (action) {
+	case MT_BF_SOUNDING_ON:
+		req.snd.snd_mode = MT_BF_PROCESSING;
+		break;
+	case MT_BF_TYPE_UPDATE:
+		req.type.ebf = true;
+		req.type.ibf = dev->ibf;
+		break;
+	case MT_BF_MODULE_UPDATE:
+		req.mod.bf_num = 2;
+		req.mod.bf_bitmap = GENMASK(1, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(TXBF_ACTION), &req,
 				 sizeof(req), true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 70ab06d9f954..9087a7771c35 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -1120,6 +1120,12 @@ enum {
 	MT_IBF = BIT(1)		/* implicit beamforming */
 };
 
+enum {
+	MT_BF_SOUNDING_ON = 1,
+	MT_BF_TYPE_UPDATE = 20,
+	MT_BF_MODULE_UPDATE = 25
+};
+
 #define MT7915_WTBL_UPDATE_MAX_SIZE	(sizeof(struct wtbl_req_hdr) +	\
 					 sizeof(struct wtbl_generic) +	\
 					 sizeof(struct wtbl_rx) +	\
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index e8cde81f8417..e4d1d2069801 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -356,9 +356,7 @@ int mt7915_mcu_set_pm(struct mt7915_dev *dev, int band, int enter);
 int mt7915_mcu_set_sku_en(struct mt7915_phy *phy, bool enable);
 int mt7915_mcu_set_txpower_sku(struct mt7915_phy *phy);
 int mt7915_mcu_get_txpower_sku(struct mt7915_phy *phy, s8 *txpower, int len);
-int mt7915_mcu_set_txbf_type(struct mt7915_dev *dev);
-int mt7915_mcu_set_txbf_module(struct mt7915_dev *dev);
-int mt7915_mcu_set_txbf_sounding(struct mt7915_dev *dev);
+int mt7915_mcu_set_txbf(struct mt7915_dev *dev, u8 action);
 int mt7915_mcu_set_fcc5_lpn(struct mt7915_dev *dev, int val);
 int mt7915_mcu_set_pulse_th(struct mt7915_dev *dev,
 			    const struct mt7915_dfs_pulse *pulse);
-- 
2.18.0

