Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5622DD80F
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 19:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgLQSO3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 13:14:29 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46170 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731390AbgLQSO2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 13:14:28 -0500
X-UUID: daf0fe9604b3489484936cd7af23ca60-20201218
X-UUID: daf0fe9604b3489484936cd7af23ca60-20201218
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 828278959; Fri, 18 Dec 2020 02:13:27 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 18 Dec 2020 02:13:26 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Dec 2020 02:13:23 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <Eric.Liang@mediatek.com>,
        <ryder.lee@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH -next v3 5/8] mt76: mt7921: add EEPROM support
Date:   Fri, 18 Dec 2020 02:13:18 +0800
Message-ID: <fb3afa6f28368fddcaca480c8f7206911e2bd875.1608227863.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1608227863.git.objelf@gmail.com>
References: <cover.1608227863.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Add EEPROM support to MT7921 to determine the capability the card has
such as indentificaiton, MAC address, the band and antenna number the
card able to support.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Co-developed-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Soul Huang <Soul.Huang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7921/Makefile    |   2 +-
 .../wireless/mediatek/mt76/mt7921/eeprom.c    | 101 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/eeprom.h    |  27 +++++
 3 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
index 13721f4cdd43..622749311fc6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/Makefile
@@ -2,4 +2,4 @@
 
 obj-$(CONFIG_MT7921E) += mt7921e.o
 
-mt7921e-y := pci.o mcu.o mac.o dma.o
+mt7921e-y := pci.o mcu.o mac.o dma.o eeprom.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c
new file mode 100644
index 000000000000..dddbd3b43aa9
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include "mt7921.h"
+#include "eeprom.h"
+
+static u32 mt7921_eeprom_read(struct mt7921_dev *dev, u32 offset)
+{
+	u8 *data = dev->mt76.eeprom.data;
+
+	if (data[offset] == 0xff)
+		mt7921_mcu_get_eeprom(dev, offset);
+
+	return data[offset];
+}
+
+static int mt7921_eeprom_load(struct mt7921_dev *dev)
+{
+	int ret;
+
+	ret = mt76_eeprom_init(&dev->mt76, MT7921_EEPROM_SIZE);
+	if (ret < 0)
+		return ret;
+
+	memset(dev->mt76.eeprom.data, -1, MT7921_EEPROM_SIZE);
+
+	return 0;
+}
+
+static int mt7921_check_eeprom(struct mt7921_dev *dev)
+{
+	u8 *eeprom = dev->mt76.eeprom.data;
+	u16 val;
+
+	mt7921_eeprom_read(dev, MT_EE_CHIP_ID);
+	val = get_unaligned_le16(eeprom);
+
+	switch (val) {
+	case 0x7961:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+void mt7921_eeprom_parse_band_config(struct mt7921_phy *phy)
+{
+	struct mt7921_dev *dev = phy->dev;
+	u32 val;
+
+	val = mt7921_eeprom_read(dev, MT_EE_WIFI_CONF);
+	val = FIELD_GET(MT_EE_WIFI_CONF_BAND_SEL, val);
+
+	switch (val) {
+	case MT_EE_5GHZ:
+		phy->mt76->cap.has_5ghz = true;
+		break;
+	case MT_EE_2GHZ:
+		phy->mt76->cap.has_2ghz = true;
+		break;
+	default:
+		phy->mt76->cap.has_2ghz = true;
+		phy->mt76->cap.has_5ghz = true;
+		break;
+	}
+}
+
+static void mt7921_eeprom_parse_hw_cap(struct mt7921_dev *dev)
+{
+	u8 tx_mask, *eeprom = dev->mt76.eeprom.data;
+
+	mt7921_eeprom_parse_band_config(&dev->phy);
+
+	/* read tx mask from eeprom (0: 1Tx, 1: 2Tx) */
+	tx_mask = FIELD_GET(MT_EE_WIFI_CONF_TX_MASK, eeprom[MT_EE_WIFI_CONF]);
+	tx_mask = tx_mask + 1;
+	dev->chainmask = BIT(tx_mask) - 1;
+	dev->mphy.antenna_mask = dev->chainmask;
+	dev->phy.chainmask = dev->mphy.antenna_mask;
+}
+
+int mt7921_eeprom_init(struct mt7921_dev *dev)
+{
+	int ret;
+
+	ret = mt7921_eeprom_load(dev);
+	if (ret < 0)
+		return ret;
+
+	ret = mt7921_check_eeprom(dev);
+	if (ret)
+		return ret;
+
+	mt7921_eeprom_parse_hw_cap(dev);
+	memcpy(dev->mphy.macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
+	       ETH_ALEN);
+
+	mt76_eeprom_override(&dev->mphy);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h
new file mode 100644
index 000000000000..54f30401343c
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/eeprom.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#ifndef __MT7921_EEPROM_H
+#define __MT7921_EEPROM_H
+
+#include "mt7921.h"
+
+enum mt7921_eeprom_field {
+	MT_EE_CHIP_ID =		0x000,
+	MT_EE_VERSION =		0x002,
+	MT_EE_MAC_ADDR =	0x004,
+	MT_EE_WIFI_CONF =	0x07c,
+	__MT_EE_MAX =		0x3bf
+};
+
+#define MT_EE_WIFI_CONF_TX_MASK			BIT(0)
+#define MT_EE_WIFI_CONF_BAND_SEL		GENMASK(3, 2)
+
+enum mt7921_eeprom_band {
+	MT_EE_NA,
+	MT_EE_5GHZ,
+	MT_EE_2GHZ,
+	MT_EE_DUAL_BAND,
+};
+
+#endif
-- 
2.25.1

