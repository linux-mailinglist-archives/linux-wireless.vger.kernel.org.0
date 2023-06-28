Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324CE740A0A
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjF1H4d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:56:33 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:41438 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229652AbjF1HyO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:54:14 -0400
X-UUID: a7779334158211ee9cb5633481061a41-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kFG5BbBk6Z4khU778jwNXVIqj0Ay4jexiae7zGfqS2o=;
        b=cITopDN+qJ+ZjadolLM1xgqcgsPj8lKv9bffz5pZiZVgpk4khrHm1lMXFhRwInmZk4NkW06buhQhOax+U6N/oVDxhl9DdLkLzO7OcgcpHcuLmXGVjxeDOPcvJv3o1+7gZPn2ureUBTuMdfH/myceZ6EPZqEfCEA5lYJX3qwsK9g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:71ec22dd-dc11-43e6-ad47-9dca57cdaff0,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:01c9525,CLOUDID:da889b0d-c22b-45ab-8a43-3004e9216b56,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a7779334158211ee9cb5633481061a41-20230628
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 54329994; Wed, 28 Jun 2023 15:08:59 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:08:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:08:58 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 05/11] wifi: mt76: mt7921: move acpi_sar code in mt792x-lib module
Date:   Wed, 28 Jun 2023 15:07:18 +0800
Message-ID: <3cf24da1a670c4ce1e09f43842e47e79fd5d9b91.1687920269.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1687920269.git.deren.wu@mediatek.com>
References: <cover.1687920269.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Move acpi_sar code in mt792x-lib module since it is shared between
mt7921 and mt7925 driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/Makefile   |   1 +
 .../wireless/mediatek/mt76/mt7921/Makefile    |   1 -
 .../wireless/mediatek/mt76/mt7921/acpi_sar.h  | 105 ---------------
 .../net/wireless/mediatek/mt76/mt7921/init.c  |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  11 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |   2 +-
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  24 ----
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  23 ++++
 .../{mt7921/acpi_sar.c => mt792x_acpi_sar.c}  | 125 ++++++++++--------
 .../wireless/mediatek/mt76/mt792x_acpi_sar.h  | 105 +++++++++++++++
 10 files changed, 202 insertions(+), 197 deletions(-)
 delete mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h
 rename drivers/net/wireless/mediatek/mt76/{mt7921/acpi_sar.c => mt792x_acpi_sar.c} (64%)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h

diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index d6231948dd6e..f8a1928d62b2 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -33,6 +33,7 @@ mt76-connac-lib-y := mt76_connac_mcu.o mt76_connac_mac.o mt76_connac3_mac.o
 
 mt792x-lib-y := mt792x_core.o mt792x_mac.o mt792x_trace.o \
 		mt792x_debugfs.o mt792x_dma.o
+mt792x-lib-$(CONFIG_ACPI) += mt792x_acpi_sar.o
 
 obj-$(CONFIG_MT76x0_COMMON) += mt76x0/
 obj-$(CONFIG_MT76x2_COMMON) += mt76x2/
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
index fd82dff76dae..f380ec4b6de1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -7,7 +7,6 @@ obj-$(CONFIG_MT7921U) += mt7921u.o
 
 mt7921-common-y := mac.o mcu.o main.o init.o debugfs.o
 mt7921-common-$(CONFIG_NL80211_TESTMODE) += testmode.o
-mt7921-common-$(CONFIG_ACPI) += acpi_sar.o
 mt7921e-y := pci.o pci_mac.o pci_mcu.o dma.o
 mt7921s-y := sdio.o sdio_mac.o sdio_mcu.o
 mt7921u-y := usb.o usb_mac.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h b/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h
deleted file mode 100644
index 6f2c4a572572..000000000000
--- a/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h
+++ /dev/null
@@ -1,105 +0,0 @@
-/* SPDX-License-Identifier: ISC */
-/* Copyright (C) 2022 MediaTek Inc. */
-
-#ifndef __MT7921_ACPI_SAR_H
-#define __MT7921_ACPI_SAR_H
-
-#define MT7921_ASAR_MIN_DYN		1
-#define MT7921_ASAR_MAX_DYN		8
-#define MT7921_ASAR_MIN_GEO		3
-#define MT7921_ASAR_MAX_GEO		8
-#define MT7921_ASAR_MIN_FG		8
-
-#define MT7921_ACPI_MTCL		"MTCL"
-#define MT7921_ACPI_MTDS		"MTDS"
-#define MT7921_ACPI_MTGS		"MTGS"
-#define MT7921_ACPI_MTFG		"MTFG"
-
-struct mt7921_asar_dyn_limit {
-	u8 idx;
-	u8 frp[5];
-} __packed;
-
-struct mt7921_asar_dyn {
-	u8 names[4];
-	u8 enable;
-	u8 nr_tbl;
-	DECLARE_FLEX_ARRAY(struct mt7921_asar_dyn_limit, tbl);
-} __packed;
-
-struct mt7921_asar_dyn_limit_v2 {
-	u8 idx;
-	u8 frp[11];
-} __packed;
-
-struct mt7921_asar_dyn_v2 {
-	u8 names[4];
-	u8 enable;
-	u8 rsvd;
-	u8 nr_tbl;
-	DECLARE_FLEX_ARRAY(struct mt7921_asar_dyn_limit_v2, tbl);
-} __packed;
-
-struct mt7921_asar_geo_band {
-	u8 pwr;
-	u8 offset;
-} __packed;
-
-struct mt7921_asar_geo_limit {
-	u8 idx;
-	/* 0:2G, 1:5G */
-	struct mt7921_asar_geo_band band[2];
-} __packed;
-
-struct mt7921_asar_geo {
-	u8 names[4];
-	u8 version;
-	u8 nr_tbl;
-	DECLARE_FLEX_ARRAY(struct mt7921_asar_geo_limit, tbl);
-} __packed;
-
-struct mt7921_asar_geo_limit_v2 {
-	u8 idx;
-	/* 0:2G, 1:5G, 2:6G */
-	struct mt7921_asar_geo_band band[3];
-} __packed;
-
-struct mt7921_asar_geo_v2 {
-	u8 names[4];
-	u8 version;
-	u8 rsvd;
-	u8 nr_tbl;
-	DECLARE_FLEX_ARRAY(struct mt7921_asar_geo_limit_v2, tbl);
-} __packed;
-
-struct mt7921_asar_cl {
-	u8 names[4];
-	u8 version;
-	u8 mode_6g;
-	u8 cl6g[6];
-} __packed;
-
-struct mt7921_asar_fg {
-	u8 names[4];
-	u8 version;
-	u8 rsvd;
-	u8 nr_flag;
-	u8 rsvd1;
-	u8 flag[];
-} __packed;
-
-struct mt7921_acpi_sar {
-	u8 ver;
-	union {
-		struct mt7921_asar_dyn *dyn;
-		struct mt7921_asar_dyn_v2 *dyn_v2;
-	};
-	union {
-		struct mt7921_asar_geo *geo;
-		struct mt7921_asar_geo_v2 *geo_v2;
-	};
-	struct mt7921_asar_cl *countrylist;
-	struct mt7921_asar_fg *fg;
-};
-
-#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 3ff0205919c2..7b8876bf8fc8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -230,7 +230,7 @@ int mt7921_register_device(struct mt792x_dev *dev)
 	if (!mt76_is_mmio(&dev->mt76))
 		hw->extra_tx_headroom += MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
 
-	mt7921_init_acpi_sar(dev);
+	mt792x_init_acpi_sar(dev);
 
 	ret = mt792x_init_wcid(dev);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 73f29fed216f..0844d28b3223 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1153,19 +1153,16 @@ int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
 			  const struct cfg80211_sar_specs *sar)
 {
 	struct mt76_phy *mphy = hw->priv;
-	int err;
 
 	if (sar) {
-		err = mt76_init_sar_power(hw, sar);
+		int err = mt76_init_sar_power(hw, sar);
+
 		if (err)
 			return err;
 	}
+	mt792x_init_acpi_sar_power(mt792x_hw_phy(hw), !sar);
 
-	mt7921_init_acpi_sar_power(mt792x_hw_phy(hw), !sar);
-
-	err = mt76_connac_mcu_set_rate_txpower(mphy);
-
-	return err;
+	return mt76_connac_mcu_set_rate_txpower(mphy);
 }
 
 static int mt7921_set_sar_specs(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index bd40ca489447..e9caf750bca5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1197,7 +1197,7 @@ int __mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 	} __packed req = {
 		.idx = idx,
 		.env = env_cap,
-		.acpi_conf = mt7921_acpi_get_flags(&dev->phy),
+		.acpi_conf = mt792x_acpi_get_flags(&dev->phy),
 	};
 	int ret, valid_cnt = 0;
 	u8 i, *pos;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 0c60a1559041..3ba873ec6bc4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -6,7 +6,6 @@
 
 #include "../mt792x.h"
 #include "regs.h"
-#include "acpi_sar.h"
 
 #define MT7921_PM_TIMEOUT		(HZ / 12)
 #define MT7921_HW_SCAN_TIMEOUT		(HZ / 10)
@@ -345,29 +344,6 @@ int mt7921_mcu_uni_add_beacon_offload(struct mt792x_dev *dev,
 				      struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif,
 				      bool enable);
-#ifdef CONFIG_ACPI
-int mt7921_init_acpi_sar(struct mt792x_dev *dev);
-int mt7921_init_acpi_sar_power(struct mt792x_phy *phy, bool set_default);
-u8 mt7921_acpi_get_flags(struct mt792x_phy *phy);
-#else
-static inline int
-mt7921_init_acpi_sar(struct mt792x_dev *dev)
-{
-	return 0;
-}
-
-static inline int
-mt7921_init_acpi_sar_power(struct mt792x_phy *phy, bool set_default)
-{
-	return 0;
-}
-
-static inline u8
-mt7921_acpi_get_flags(struct mt792x_phy *phy)
-{
-	return 0;
-}
-#endif
 int mt7921_set_tx_sar_pwr(struct ieee80211_hw *hw,
 			  const struct cfg80211_sar_specs *sar);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 54ff9627530f..1ed688186fe7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -9,6 +9,7 @@
 
 #include "mt76_connac_mcu.h"
 #include "mt792x_regs.h"
+#include "mt792x_acpi_sar.h"
 
 #define MT792x_MAX_INTERFACES	4
 #define MT792x_WTBL_SIZE	20
@@ -297,4 +298,26 @@ int __mt792xe_mcu_drv_pmctrl(struct mt792x_dev *dev);
 int mt792xe_mcu_drv_pmctrl(struct mt792x_dev *dev);
 int mt792xe_mcu_fw_pmctrl(struct mt792x_dev *dev);
 
+#ifdef CONFIG_ACPI
+int mt792x_init_acpi_sar(struct mt792x_dev *dev);
+int mt792x_init_acpi_sar_power(struct mt792x_phy *phy, bool set_default);
+u8 mt792x_acpi_get_flags(struct mt792x_phy *phy);
+#else
+static inline int mt792x_init_acpi_sar(struct mt792x_dev *dev)
+{
+	return 0;
+}
+
+static inline int mt792x_init_acpi_sar_power(struct mt792x_phy *phy,
+					     bool set_default)
+{
+	return 0;
+}
+
+static inline u8 mt792x_acpi_get_flags(struct mt792x_phy *phy)
+{
+	return 0;
+}
+#endif
+
 #endif /* __MT7925_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
similarity index 64%
rename from drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
rename to drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
index 057767ab45ff..303c0f5c9c66 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.c
@@ -1,15 +1,15 @@
 // SPDX-License-Identifier: ISC
-/* Copyright (C) 2022 MediaTek Inc. */
+/* Copyright (C) 2023 MediaTek Inc. */
 
 #include <linux/acpi.h>
-#include "mt7921.h"
+#include "mt792x.h"
 
 static int
-mt7921_acpi_read(struct mt792x_dev *dev, u8 *method, u8 **tbl, u32 *len)
+mt792x_acpi_read(struct mt792x_dev *dev, u8 *method, u8 **tbl, u32 *len)
 {
 	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
-	union acpi_object *sar_root, *sar_unit;
 	struct mt76_dev *mdev = &dev->mt76;
+	union acpi_object *sar_root;
 	acpi_handle root, handle;
 	acpi_status status;
 	u32 i = 0;
@@ -45,18 +45,20 @@ mt7921_acpi_read(struct mt792x_dev *dev, u8 *method, u8 **tbl, u32 *len)
 			goto free;
 		}
 	}
+
 	if (len)
 		*len = sar_root->package.count;
 
 	for (i = 0; i < sar_root->package.count; i++) {
-		sar_unit = &sar_root->package.elements[i];
+		union acpi_object *sar_unit = &sar_root->package.elements[i];
 
 		if (sar_unit->type != ACPI_TYPE_INTEGER)
 			break;
+
 		*(*tbl + i) = (u8)sar_unit->integer.value;
 	}
-	ret = (i == sar_root->package.count) ? 0 : -EINVAL;
 
+	ret = i == sar_root->package.count ? 0 : -EINVAL;
 free:
 	kfree(sar_root);
 
@@ -64,36 +66,37 @@ mt7921_acpi_read(struct mt792x_dev *dev, u8 *method, u8 **tbl, u32 *len)
 }
 
 /* MTCL : Country List Table for 6G band */
-static int
-mt7921_asar_acpi_read_mtcl(struct mt792x_dev *dev, u8 **table, u8 *version)
+static void
+mt792x_asar_acpi_read_mtcl(struct mt792x_dev *dev, u8 **table, u8 *version)
 {
-	*version = (mt7921_acpi_read(dev, MT7921_ACPI_MTCL, table, NULL) < 0)
-		   ? 1 : 2;
-	return 0;
+	if (mt792x_acpi_read(dev, MT792x_ACPI_MTCL, table, NULL) < 0)
+		*version = 1;
+	else
+		*version = 2;
 }
 
 /* MTDS : Dynamic SAR Power Table */
 static int
-mt7921_asar_acpi_read_mtds(struct mt792x_dev *dev, u8 **table, u8 version)
+mt792x_asar_acpi_read_mtds(struct mt792x_dev *dev, u8 **table, u8 version)
 {
 	int len, ret, sarlen, prelen, tblcnt;
 	bool enable;
 
-	ret = mt7921_acpi_read(dev, MT7921_ACPI_MTDS, table, &len);
+	ret = mt792x_acpi_read(dev, MT792x_ACPI_MTDS, table, &len);
 	if (ret)
 		return ret;
 
 	/* Table content validation */
 	switch (version) {
 	case 1:
-		enable = ((struct mt7921_asar_dyn *)*table)->enable;
-		sarlen = sizeof(struct mt7921_asar_dyn_limit);
-		prelen = sizeof(struct mt7921_asar_dyn);
+		enable = ((struct mt792x_asar_dyn *)*table)->enable;
+		sarlen = sizeof(struct mt792x_asar_dyn_limit);
+		prelen = sizeof(struct mt792x_asar_dyn);
 		break;
 	case 2:
-		enable = ((struct mt7921_asar_dyn_v2 *)*table)->enable;
-		sarlen = sizeof(struct mt7921_asar_dyn_limit_v2);
-		prelen = sizeof(struct mt7921_asar_dyn_v2);
+		enable = ((struct mt792x_asar_dyn_v2 *)*table)->enable;
+		sarlen = sizeof(struct mt792x_asar_dyn_limit_v2);
+		prelen = sizeof(struct mt792x_asar_dyn_v2);
 		break;
 	default:
 		return -EINVAL;
@@ -101,88 +104,89 @@ mt7921_asar_acpi_read_mtds(struct mt792x_dev *dev, u8 **table, u8 version)
 
 	tblcnt = (len - prelen) / sarlen;
 	if (!enable ||
-	    tblcnt > MT7921_ASAR_MAX_DYN || tblcnt < MT7921_ASAR_MIN_DYN)
-		ret = -EINVAL;
+	    tblcnt > MT792x_ASAR_MAX_DYN || tblcnt < MT792x_ASAR_MIN_DYN)
+		return -EINVAL;
 
-	return ret;
+	return 0;
 }
 
 /* MTGS : Geo SAR Power Table */
 static int
-mt7921_asar_acpi_read_mtgs(struct mt792x_dev *dev, u8 **table, u8 version)
+mt792x_asar_acpi_read_mtgs(struct mt792x_dev *dev, u8 **table, u8 version)
 {
-	int len, ret = 0, sarlen, prelen, tblcnt;
+	int len, ret, sarlen, prelen, tblcnt;
 
-	ret = mt7921_acpi_read(dev, MT7921_ACPI_MTGS, table, &len);
+	ret = mt792x_acpi_read(dev, MT792x_ACPI_MTGS, table, &len);
 	if (ret)
 		return ret;
 
 	/* Table content validation */
 	switch (version) {
 	case 1:
-		sarlen = sizeof(struct mt7921_asar_geo_limit);
-		prelen = sizeof(struct mt7921_asar_geo);
+		sarlen = sizeof(struct mt792x_asar_geo_limit);
+		prelen = sizeof(struct mt792x_asar_geo);
 		break;
 	case 2:
-		sarlen = sizeof(struct mt7921_asar_geo_limit_v2);
-		prelen = sizeof(struct mt7921_asar_geo_v2);
+		sarlen = sizeof(struct mt792x_asar_geo_limit_v2);
+		prelen = sizeof(struct mt792x_asar_geo_v2);
 		break;
 	default:
 		return -EINVAL;
 	}
 
 	tblcnt = (len - prelen) / sarlen;
-	if (tblcnt > MT7921_ASAR_MAX_GEO || tblcnt < MT7921_ASAR_MIN_GEO)
-		ret = -EINVAL;
+	if (tblcnt > MT792x_ASAR_MAX_GEO || tblcnt < MT792x_ASAR_MIN_GEO)
+		return -EINVAL;
 
-	return ret;
+	return 0;
 }
 
 /* MTFG : Flag Table */
 static int
-mt7921_asar_acpi_read_mtfg(struct mt792x_dev *dev, u8 **table)
+mt792x_asar_acpi_read_mtfg(struct mt792x_dev *dev, u8 **table)
 {
 	int len, ret;
 
-	ret = mt7921_acpi_read(dev, MT7921_ACPI_MTFG, table, &len);
+	ret = mt792x_acpi_read(dev, MT792x_ACPI_MTFG, table, &len);
 	if (ret)
 		return ret;
 
-	if (len < MT7921_ASAR_MIN_FG)
-		ret = -EINVAL;
+	if (len < MT792x_ASAR_MIN_FG)
+		return -EINVAL;
 
-	return ret;
+	return 0;
 }
 
-int mt7921_init_acpi_sar(struct mt792x_dev *dev)
+int mt792x_init_acpi_sar(struct mt792x_dev *dev)
 {
-	struct mt7921_acpi_sar *asar;
+	struct mt792x_acpi_sar *asar;
 	int ret;
 
 	asar = devm_kzalloc(dev->mt76.dev, sizeof(*asar), GFP_KERNEL);
 	if (!asar)
 		return -ENOMEM;
 
-	mt7921_asar_acpi_read_mtcl(dev, (u8 **)&asar->countrylist, &asar->ver);
+	mt792x_asar_acpi_read_mtcl(dev, (u8 **)&asar->countrylist, &asar->ver);
 
 	/* MTDS is mandatory. Return error if table is invalid */
-	ret = mt7921_asar_acpi_read_mtds(dev, (u8 **)&asar->dyn, asar->ver);
+	ret = mt792x_asar_acpi_read_mtds(dev, (u8 **)&asar->dyn, asar->ver);
 	if (ret) {
 		devm_kfree(dev->mt76.dev, asar->dyn);
 		devm_kfree(dev->mt76.dev, asar->countrylist);
 		devm_kfree(dev->mt76.dev, asar);
+
 		return ret;
 	}
 
 	/* MTGS is optional */
-	ret = mt7921_asar_acpi_read_mtgs(dev, (u8 **)&asar->geo, asar->ver);
+	ret = mt792x_asar_acpi_read_mtgs(dev, (u8 **)&asar->geo, asar->ver);
 	if (ret) {
 		devm_kfree(dev->mt76.dev, asar->geo);
 		asar->geo = NULL;
 	}
 
 	/* MTFG is optional */
-	ret = mt7921_asar_acpi_read_mtfg(dev, (u8 **)&asar->fg);
+	ret = mt792x_asar_acpi_read_mtfg(dev, (u8 **)&asar->fg);
 	if (ret) {
 		devm_kfree(dev->mt76.dev, asar->fg);
 		asar->fg = NULL;
@@ -191,13 +195,14 @@ int mt7921_init_acpi_sar(struct mt792x_dev *dev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt792x_init_acpi_sar);
 
 static s8
-mt7921_asar_get_geo_pwr(struct mt792x_phy *phy,
+mt792x_asar_get_geo_pwr(struct mt792x_phy *phy,
 			enum nl80211_band band, s8 dyn_power)
 {
-	struct mt7921_acpi_sar *asar = phy->acpisar;
-	struct mt7921_asar_geo_band *band_pwr;
+	struct mt792x_acpi_sar *asar = phy->acpisar;
+	struct mt792x_asar_geo_band *band_pwr;
 	s8 geo_power;
 	u8 idx, max;
 
@@ -248,12 +253,12 @@ mt7921_asar_get_geo_pwr(struct mt792x_phy *phy,
 }
 
 static s8
-mt7921_asar_range_pwr(struct mt792x_phy *phy,
+mt792x_asar_range_pwr(struct mt792x_phy *phy,
 		      const struct cfg80211_sar_freq_ranges *range,
 		      u8 idx)
 {
 	const struct cfg80211_sar_capa *capa = phy->mt76->hw->wiphy->sar_capa;
-	struct mt7921_acpi_sar *asar = phy->acpisar;
+	struct mt792x_acpi_sar *asar = phy->acpisar;
 	u8 *limit, band, max;
 
 	if (!capa)
@@ -277,10 +282,10 @@ mt7921_asar_range_pwr(struct mt792x_phy *phy,
 	else
 		band = NL80211_BAND_2GHZ;
 
-	return mt7921_asar_get_geo_pwr(phy, band, limit[idx]);
+	return mt792x_asar_get_geo_pwr(phy, band, limit[idx]);
 }
 
-int mt7921_init_acpi_sar_power(struct mt792x_phy *phy, bool set_default)
+int mt792x_init_acpi_sar_power(struct mt792x_phy *phy, bool set_default)
 {
 	const struct cfg80211_sar_capa *capa = phy->mt76->hw->wiphy->sar_capa;
 	int i;
@@ -300,22 +305,23 @@ int mt7921_init_acpi_sar_power(struct mt792x_phy *phy, bool set_default)
 			continue;
 
 		frp->power = min_t(s8, set_default ? 127 : frp->power,
-				   mt7921_asar_range_pwr(phy, frp->range, i));
+				   mt792x_asar_range_pwr(phy, frp->range, i));
 	}
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mt792x_init_acpi_sar_power);
 
-u8 mt7921_acpi_get_flags(struct mt792x_phy *phy)
+u8 mt792x_acpi_get_flags(struct mt792x_phy *phy)
 {
-	struct mt7921_acpi_sar *acpisar = phy->acpisar;
-	struct mt7921_asar_fg *fg;
+	struct mt792x_acpi_sar *acpisar = phy->acpisar;
+	struct mt792x_asar_fg *fg;
 	struct {
 		u8 acpi_idx;
 		u8 chip_idx;
 	} map[] = {
-		{1, 1},
-		{4, 2},
+		{ 1, 1 },
+		{ 4, 2 },
 	};
 	u8 flags = BIT(0);
 	int i, j;
@@ -330,12 +336,15 @@ u8 mt7921_acpi_get_flags(struct mt792x_phy *phy)
 	/* pickup necessary settings per device and
 	 * translate the index of bitmap for chip command.
 	 */
-	for (i = 0; i < fg->nr_flag; i++)
-		for (j = 0; j < ARRAY_SIZE(map); j++)
+	for (i = 0; i < fg->nr_flag; i++) {
+		for (j = 0; j < ARRAY_SIZE(map); j++) {
 			if (fg->flag[i] == map[j].acpi_idx) {
 				flags |= BIT(map[j].chip_idx);
 				break;
 			}
+		}
+	}
 
 	return flags;
 }
+EXPORT_SYMBOL_GPL(mt792x_acpi_get_flags);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h
new file mode 100644
index 000000000000..d6d332e863ba
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_acpi_sar.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#ifndef __MT7921_ACPI_SAR_H
+#define __MT7921_ACPI_SAR_H
+
+#define MT792x_ASAR_MIN_DYN		1
+#define MT792x_ASAR_MAX_DYN		8
+#define MT792x_ASAR_MIN_GEO		3
+#define MT792x_ASAR_MAX_GEO		8
+#define MT792x_ASAR_MIN_FG		8
+
+#define MT792x_ACPI_MTCL		"MTCL"
+#define MT792x_ACPI_MTDS		"MTDS"
+#define MT792x_ACPI_MTGS		"MTGS"
+#define MT792x_ACPI_MTFG		"MTFG"
+
+struct mt792x_asar_dyn_limit {
+	u8 idx;
+	u8 frp[5];
+} __packed;
+
+struct mt792x_asar_dyn {
+	u8 names[4];
+	u8 enable;
+	u8 nr_tbl;
+	DECLARE_FLEX_ARRAY(struct mt792x_asar_dyn_limit, tbl);
+} __packed;
+
+struct mt792x_asar_dyn_limit_v2 {
+	u8 idx;
+	u8 frp[11];
+} __packed;
+
+struct mt792x_asar_dyn_v2 {
+	u8 names[4];
+	u8 enable;
+	u8 rsvd;
+	u8 nr_tbl;
+	DECLARE_FLEX_ARRAY(struct mt792x_asar_dyn_limit_v2, tbl);
+} __packed;
+
+struct mt792x_asar_geo_band {
+	u8 pwr;
+	u8 offset;
+} __packed;
+
+struct mt792x_asar_geo_limit {
+	u8 idx;
+	/* 0:2G, 1:5G */
+	struct mt792x_asar_geo_band band[2];
+} __packed;
+
+struct mt792x_asar_geo {
+	u8 names[4];
+	u8 version;
+	u8 nr_tbl;
+	DECLARE_FLEX_ARRAY(struct mt792x_asar_geo_limit, tbl);
+} __packed;
+
+struct mt792x_asar_geo_limit_v2 {
+	u8 idx;
+	/* 0:2G, 1:5G, 2:6G */
+	struct mt792x_asar_geo_band band[3];
+} __packed;
+
+struct mt792x_asar_geo_v2 {
+	u8 names[4];
+	u8 version;
+	u8 rsvd;
+	u8 nr_tbl;
+	DECLARE_FLEX_ARRAY(struct mt792x_asar_geo_limit_v2, tbl);
+} __packed;
+
+struct mt792x_asar_cl {
+	u8 names[4];
+	u8 version;
+	u8 mode_6g;
+	u8 cl6g[6];
+} __packed;
+
+struct mt792x_asar_fg {
+	u8 names[4];
+	u8 version;
+	u8 rsvd;
+	u8 nr_flag;
+	u8 rsvd1;
+	u8 flag[];
+} __packed;
+
+struct mt792x_acpi_sar {
+	u8 ver;
+	union {
+		struct mt792x_asar_dyn *dyn;
+		struct mt792x_asar_dyn_v2 *dyn_v2;
+	};
+	union {
+		struct mt792x_asar_geo *geo;
+		struct mt792x_asar_geo_v2 *geo_v2;
+	};
+	struct mt792x_asar_cl *countrylist;
+	struct mt792x_asar_fg *fg;
+};
+
+#endif
-- 
2.18.0

