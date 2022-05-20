Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3499552E83B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 May 2022 11:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347310AbiETJEO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 05:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345288AbiETJEL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 05:04:11 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383ECEBA92
        for <linux-wireless@vger.kernel.org>; Fri, 20 May 2022 02:04:09 -0700 (PDT)
X-UUID: 063e452ae22145c285352fc32d5c090d-20220520
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:05af72a9-d834-4b35-a968-8c597e7029ab,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:9d14efe2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 063e452ae22145c285352fc32d5c090d-20220520
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 74039577; Fri, 20 May 2022 17:04:03 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 20 May 2022 17:04:01 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 20 May 2022 17:04:01 +0800
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
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH v2 2/3] mt76: mt7921: introduce ACPI SAR support
Date:   Fri, 20 May 2022 17:03:38 +0800
Message-ID: <9651be686a9d895b7aa750e1c969bd13ab7fae63.1653032296.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1653032296.git.deren.wu@mediatek.com>
References: <cover.1653032296.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

In ACPI SAR enabled device, mt7921 should read power limit in ACPI config.
The limit value would be applied to regular tx power settings in mt76.

Two major functionalities added:
1. Get SAR power table through ACPI.
2. Read power in Dynamic/Geo SAR table for tx power limit.

Table note
MTDS: Dynamic SAR table
MTGS: Geo SAR table
MTCL: Country List table (for 6GHz support)

Reviewed-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Co-developed-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7921/Makefile    |   1 +
 .../wireless/mediatek/mt76/mt7921/acpi_sar.c  | 279 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/acpi_sar.h  |  93 ++++++
 .../net/wireless/mediatek/mt76/mt7921/init.c  |   2 +
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  20 ++
 5 files changed, 395 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
index 0a146818c623..e5d2d2e131a2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -9,6 +9,7 @@ CFLAGS_trace.o := -I$(src)
 
 mt7921-common-y := mac.o mcu.o main.o init.o debugfs.o trace.o
 mt7921-common-$(CONFIG_NL80211_TESTMODE) += testmode.o
+mt7921-common-$(CONFIG_ACPI) += acpi_sar.o
 mt7921e-y := pci.o pci_mac.o pci_mcu.o dma.o
 mt7921s-y := sdio.o sdio_mac.o sdio_mcu.o
 mt7921u-y := usb.o usb_mac.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c b/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
new file mode 100644
index 000000000000..fb3d31b96682
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2022 MediaTek Inc. */
+
+#include <linux/acpi.h>
+#include "mt7921.h"
+
+static int
+mt7921_acpi_read(struct mt7921_dev *dev, u8 *method, u8 **tbl, u32 *len)
+{
+	struct acpi_buffer buf = { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object *sar_root, *sar_unit;
+	struct mt76_dev *mdev = &dev->mt76;
+	acpi_handle root, handle;
+	acpi_status status;
+	u32 i = 0;
+
+	root = ACPI_HANDLE(mdev->dev);
+	if (!root)
+		return -EOPNOTSUPP;
+
+	status = acpi_get_handle(root, method, &handle);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	status = acpi_evaluate_object(handle, NULL, NULL, &buf);
+	if (ACPI_FAILURE(status))
+		return -EIO;
+
+	sar_root = buf.pointer;
+	if (sar_root->type != ACPI_TYPE_PACKAGE ||
+	    sar_root->package.count < 4 ||
+	    sar_root->package.elements[0].type != ACPI_TYPE_INTEGER) {
+		dev_err(mdev->dev, "sar cnt = %d\n",
+			sar_root->package.count);
+		goto free;
+	}
+
+	if (!*tbl) {
+		*tbl = devm_kzalloc(mdev->dev, sar_root->package.count,
+				    GFP_KERNEL);
+		if (!*tbl)
+			goto free;
+	}
+	if (len)
+		*len = sar_root->package.count;
+
+	for (i = 0; i < sar_root->package.count; i++) {
+		sar_unit = &sar_root->package.elements[i];
+
+		if (sar_unit->type != ACPI_TYPE_INTEGER)
+			break;
+		*(*tbl + i) = (u8)sar_unit->integer.value;
+	}
+free:
+	kfree(sar_root);
+
+	return (i == sar_root->package.count) ? 0 : -EINVAL;
+}
+
+/* MTCL : Country List Table for 6G band */
+static int
+mt7921_asar_acpi_read_mtcl(struct mt7921_dev *dev, u8 **table, u8 *version)
+{
+	*version = (mt7921_acpi_read(dev, MT7921_ACPI_MTCL, table, 0) < 0)
+		   ? 1 : 2;
+	return 0;
+}
+
+/* MTDS : Dynamic SAR Power Table */
+static int
+mt7921_asar_acpi_read_mtds(struct mt7921_dev *dev, u8 **table, u8 version)
+{
+	int len, ret, sarlen, prelen, tblcnt;
+	bool enable;
+
+	ret = mt7921_acpi_read(dev, MT7921_ACPI_MTDS, table, &len);
+	if (ret)
+		return ret;
+
+	/* Table content validation */
+	switch (version) {
+	case 1:
+		enable = ((struct mt7921_asar_dyn *)*table)->enable;
+		sarlen = sizeof(struct mt7921_asar_dyn_limit);
+		prelen = sizeof(struct mt7921_asar_dyn);
+		break;
+	case 2:
+		enable = ((struct mt7921_asar_dyn_v2 *)*table)->enable;
+		sarlen = sizeof(struct mt7921_asar_dyn_limit_v2);
+		prelen = sizeof(struct mt7921_asar_dyn_v2);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	tblcnt = (len - prelen) / sarlen;
+	if (!enable ||
+	    tblcnt > MT7921_ASAR_MAX_DYN || tblcnt < MT7921_ASAR_MIN_DYN)
+		ret = -EINVAL;
+
+	return ret;
+}
+
+/* MTGS : Geo SAR Power Table */
+static int
+mt7921_asar_acpi_read_mtgs(struct mt7921_dev *dev, u8 **table, u8 version)
+{
+	int len, ret = 0, sarlen, prelen, tblcnt;
+
+	ret = mt7921_acpi_read(dev, MT7921_ACPI_MTGS, table, &len);
+	if (ret)
+		return ret;
+
+	/* Table content validation */
+	switch (version) {
+	case 1:
+		sarlen = sizeof(struct mt7921_asar_geo_limit);
+		prelen = sizeof(struct mt7921_asar_geo);
+		break;
+	case 2:
+		sarlen = sizeof(struct mt7921_asar_geo_limit_v2);
+		prelen = sizeof(struct mt7921_asar_geo_v2);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	tblcnt = (len - prelen) / sarlen;
+	if (tblcnt > MT7921_ASAR_MAX_GEO || tblcnt < MT7921_ASAR_MIN_GEO)
+		ret = -EINVAL;
+
+	return ret;
+}
+
+int mt7921_init_acpi_sar(struct mt7921_dev *dev)
+{
+	struct mt7921_acpi_sar *asar;
+	int ret;
+
+	asar = devm_kzalloc(dev->mt76.dev, sizeof(*asar), GFP_KERNEL);
+	if (!asar)
+		return -ENOMEM;
+
+	mt7921_asar_acpi_read_mtcl(dev, (u8 **)&asar->countrylist, &asar->ver);
+
+	/* MTDS is mandatory. Return error if table is invalid */
+	ret = mt7921_asar_acpi_read_mtds(dev, (u8 **)&asar->dyn, asar->ver);
+	if (ret) {
+		devm_kfree(dev->mt76.dev, asar->dyn);
+		devm_kfree(dev->mt76.dev, asar->countrylist);
+		devm_kfree(dev->mt76.dev, asar);
+		return ret;
+	}
+
+	/* MTGS is optional */
+	ret = mt7921_asar_acpi_read_mtgs(dev, (u8 **)&asar->geo, asar->ver);
+	if (ret) {
+		devm_kfree(dev->mt76.dev, asar->geo);
+		asar->geo = NULL;
+	}
+
+	dev->phy.acpisar = asar;
+
+	return 0;
+}
+
+static s8
+mt7921_asar_get_geo_pwr(struct mt7921_phy *phy,
+			enum nl80211_band band, s8 dyn_power)
+{
+	struct mt7921_acpi_sar *asar = phy->acpisar;
+	struct mt7921_asar_geo_band *band_pwr;
+	s8 geo_power;
+	u8 idx, max;
+
+	if (!asar->geo)
+		return dyn_power;
+
+	switch (phy->mt76->dev->region) {
+	case NL80211_DFS_FCC:
+		idx = 0;
+		break;
+	case NL80211_DFS_ETSI:
+		idx = 1;
+		break;
+	default: /* WW */
+		idx = 2;
+		break;
+	}
+
+	if (asar->ver == 1) {
+		band_pwr = &asar->geo->tbl[idx].band[0];
+		max = ARRAY_SIZE(asar->geo->tbl[idx].band);
+	} else {
+		band_pwr = &asar->geo_v2->tbl[idx].band[0];
+		max = ARRAY_SIZE(asar->geo_v2->tbl[idx].band);
+	}
+
+	switch (band) {
+	case NL80211_BAND_2GHZ:
+		idx = 0;
+		break;
+	case NL80211_BAND_5GHZ:
+		idx = 1;
+		break;
+	case NL80211_BAND_6GHZ:
+		idx = 2;
+		break;
+	default:
+		return dyn_power;
+	}
+
+	if (idx >= max)
+		return dyn_power;
+
+	geo_power = (band_pwr + idx)->pwr;
+	dyn_power += (band_pwr + idx)->offset;
+
+	return min(geo_power, dyn_power);
+}
+
+static s8
+mt7921_asar_range_pwr(struct mt7921_phy *phy,
+		      const struct cfg80211_sar_freq_ranges *range,
+		      u8 idx)
+{
+	const struct cfg80211_sar_capa *capa = phy->mt76->hw->wiphy->sar_capa;
+	struct mt7921_acpi_sar *asar = phy->acpisar;
+	u8 *limit, band, max;
+
+	if (!capa)
+		return 127;
+
+	if (asar->ver == 1) {
+		limit = &asar->dyn->tbl[0].frp[0];
+		max = ARRAY_SIZE(asar->dyn->tbl[0].frp);
+	} else {
+		limit = &asar->dyn_v2->tbl[0].frp[0];
+		max = ARRAY_SIZE(asar->dyn_v2->tbl[0].frp);
+	}
+
+	if (idx >= max)
+		return 127;
+
+	if (range->start_freq >= 5945)
+		band = NL80211_BAND_6GHZ;
+	else if (range->start_freq >= 5150)
+		band = NL80211_BAND_5GHZ;
+	else
+		band = NL80211_BAND_2GHZ;
+
+	return mt7921_asar_get_geo_pwr(phy, band, limit[idx]);
+}
+
+int mt7921_init_acpi_sar_power(struct mt7921_phy *phy, bool set_default)
+{
+	const struct cfg80211_sar_capa *capa = phy->mt76->hw->wiphy->sar_capa;
+	int i;
+
+	if (!phy->acpisar)
+		return 0;
+
+	/* When ACPI SAR enabled in HW, we should apply rules for .frp
+	 * 1. w/o .sar_specs : set ACPI SAR power as the defatul value
+	 * 2. w/  .sar_specs : set power with min(.sar_specs, ACPI_SAR)
+	 */
+	for (i = 0; i < capa->num_freq_ranges; i++) {
+		struct mt76_freq_range_power *frp = &phy->mt76->frp[i];
+
+		frp->range = set_default ? &capa->freq_ranges[i] : frp->range;
+		if (!frp->range)
+			continue;
+
+		frp->power = min_t(s8, set_default ? 127 : frp->power,
+				   mt7921_asar_range_pwr(phy, frp->range, i));
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h b/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h
new file mode 100644
index 000000000000..23f86bfae0c0
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/acpi_sar.h
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2022 MediaTek Inc. */
+
+#ifndef __MT7921_ACPI_SAR_H
+#define __MT7921_ACPI_SAR_H
+
+#define MT7921_ASAR_MIN_DYN		1
+#define MT7921_ASAR_MAX_DYN		8
+#define MT7921_ASAR_MIN_GEO		3
+#define MT7921_ASAR_MAX_GEO		8
+
+#define MT7921_ACPI_MTCL		"MTCL"
+#define MT7921_ACPI_MTDS		"MTDS"
+#define MT7921_ACPI_MTGS		"MTGS"
+
+struct mt7921_asar_dyn_limit {
+	u8 idx;
+	u8 frp[5];
+} __packed;
+
+struct mt7921_asar_dyn {
+	u8 names[4];
+	u8 enable;
+	u8 nr_tbl;
+	struct mt7921_asar_dyn_limit tbl[0];
+} __packed;
+
+struct mt7921_asar_dyn_limit_v2 {
+	u8 idx;
+	u8 frp[11];
+} __packed;
+
+struct mt7921_asar_dyn_v2 {
+	u8 names[4];
+	u8 enable;
+	u8 rsvd;
+	u8 nr_tbl;
+	struct mt7921_asar_dyn_limit_v2 tbl[0];
+} __packed;
+
+struct mt7921_asar_geo_band {
+	u8 pwr;
+	u8 offset;
+} __packed;
+
+struct mt7921_asar_geo_limit {
+	u8 idx;
+	/* 0:2G, 1:5G */
+	struct mt7921_asar_geo_band band[2];
+} __packed;
+
+struct mt7921_asar_geo {
+	u8 names[4];
+	u8 version;
+	u8 nr_tbl;
+	struct mt7921_asar_geo_limit tbl[0];
+} __packed;
+
+struct mt7921_asar_geo_limit_v2 {
+	u8 idx;
+	/* 0:2G, 1:5G, 2:6G */
+	struct mt7921_asar_geo_band band[3];
+} __packed;
+
+struct mt7921_asar_geo_v2 {
+	u8 names[4];
+	u8 version;
+	u8 rsvd;
+	u8 nr_tbl;
+	struct mt7921_asar_geo_limit_v2 tbl[0];
+} __packed;
+
+struct mt7921_asar_cl {
+	u8 names[4];
+	u8 version;
+	u8 mode_6g;
+	u8 cl6g[6];
+} __packed;
+
+struct mt7921_acpi_sar {
+	u8 ver;
+	union {
+		struct mt7921_asar_dyn *dyn;
+		struct mt7921_asar_dyn_v2 *dyn_v2;
+	};
+	union {
+		struct mt7921_asar_geo *geo;
+		struct mt7921_asar_geo_v2 *geo_v2;
+	};
+	struct mt7921_asar_cl *countrylist;
+};
+
+#endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 4a8675634f80..0c4e973d002e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -289,6 +289,8 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	if (!mt76_is_mmio(&dev->mt76))
 		hw->extra_tx_headroom += MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
 
+	mt7921_init_acpi_sar(dev);
+
 	ret = mt7921_init_wcid(dev);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 5ca584bb2fc6..8b26bece28ae 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -8,6 +8,7 @@
 #include <linux/ktime.h>
 #include "../mt76_connac_mcu.h"
 #include "regs.h"
+#include "acpi_sar.h"
 
 #define MT7921_MAX_INTERFACES		4
 #define MT7921_MAX_WMM_SETS		4
@@ -171,6 +172,9 @@ struct mt7921_phy {
 
 	struct sk_buff_head scan_event_list;
 	struct delayed_work scan_work;
+#ifdef CONFIG_ACPI
+	struct mt7921_acpi_sar *acpisar;
+#endif
 };
 
 #define mt7921_init_reset(dev)		((dev)->hif_ops->init_reset(dev))
@@ -481,4 +485,20 @@ int mt7921_mcu_uni_add_beacon_offload(struct mt7921_dev *dev,
 				      struct ieee80211_hw *hw,
 				      struct ieee80211_vif *vif,
 				      bool enable);
+#ifdef CONFIG_ACPI
+int mt7921_init_acpi_sar(struct mt7921_dev *dev);
+int mt7921_init_acpi_sar_power(struct mt7921_phy *phy, bool set_default);
+#else
+static inline int
+mt7921_init_acpi_sar(struct mt7921_dev *dev)
+{
+	return 0;
+}
+
+static inline int
+mt7921_init_acpi_sar_power(struct mt7921_phy *phy, bool set_default)
+{
+	return 0;
+}
+#endif
 #endif
-- 
2.18.0

