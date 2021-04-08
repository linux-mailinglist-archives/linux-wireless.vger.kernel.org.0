Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5103589DC
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 18:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbhDHQhE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 12:37:04 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:38898 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231918AbhDHQhD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 12:37:03 -0400
X-UUID: 74594ef0ae6d422ba954c802ec9e0de8-20210409
X-UUID: 74594ef0ae6d422ba954c802ec9e0de8-20210409
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1491575745; Fri, 09 Apr 2021 00:36:46 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 9 Apr 2021 00:36:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Apr 2021 00:36:45 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] mt76: mt7915: add mmio.c
Date:   Fri, 9 Apr 2021 00:36:31 +0800
Message-ID: <da0e79891df201e9c0240aa8bfd023039a97448f.1617845351.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add mmio.c in order to use mt76_bus_ops throughout the driver.
It will be also shared with the future APSoC revision.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/Makefile    |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/dma.c   | 108 -------------
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  11 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  16 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   |  18 +--
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 152 ++++++++++++++++++
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  75 +--------
 .../net/wireless/mediatek/mt76/mt7915/pci.c   |  13 +-
 8 files changed, 177 insertions(+), 218 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7915/mmio.c

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/Makefile b/drivers/net/wireless/mediatek/mt76/mt7915/Makefile
index cc2054dffa98..40c8061787e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/Makefile
@@ -3,6 +3,6 @@
 obj-$(CONFIG_MT7915E) += mt7915e.o
 
 mt7915e-y := pci.o init.o dma.o eeprom.o main.o mcu.o mac.o \
-	     debugfs.o
+	     debugfs.o mmio.o
 
 mt7915e-$(CONFIG_NL80211_TESTMODE) += testmode.o
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
index 3c961bf55e97..9fe09870f8f0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
@@ -110,121 +110,13 @@ void mt7915_dma_prefetch(struct mt7915_dev *dev)
 		__mt7915_dma_prefetch(dev, MT_WFDMA1_PCIE1_BASE - MT_WFDMA1_BASE);
 }
 
-static u32 __mt7915_reg_addr(struct mt7915_dev *dev, u32 addr)
-{
-	static const struct {
-		u32 phys;
-		u32 mapped;
-		u32 size;
-	} fixed_map[] = {
-		{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA PCIE0 MCU DMA0 */
-		{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA PCIE0 MCU DMA1 */
-		{ 0x58000000, 0x06000, 0x1000 }, /* WFDMA PCIE1 MCU DMA0 (MEM_DMA) */
-		{ 0x59000000, 0x07000, 0x1000 }, /* WFDMA PCIE1 MCU DMA1 */
-		{ 0x7c000000, 0xf0000, 0x10000 }, /* CONN_INFRA */
-		{ 0x7c020000, 0xd0000, 0x10000 }, /* CONN_INFRA, WFDMA */
-		{ 0x80020000, 0xb0000, 0x10000 }, /* WF_TOP_MISC_OFF */
-		{ 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
-		{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
-		{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
-		{ 0x820cc000, 0x0e000, 0x2000 }, /* WF_UMAC_TOP (PP) */
-		{ 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
-		{ 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
-		{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
-		{ 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
-		{ 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
-		{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
-		{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
-		{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
-		{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
-		{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
-		{ 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
-		{ 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
-		{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
-		{ 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
-		{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
-		{ 0x820f0000, 0xa0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
-		{ 0x820f1000, 0xa0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
-		{ 0x820f2000, 0xa0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
-		{ 0x820f3000, 0xa0c00, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
-		{ 0x820f4000, 0xa1000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
-		{ 0x820f5000, 0xa1400, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
-		{ 0x820f7000, 0xa1e00, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
-		{ 0x820f9000, 0xa3400, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
-		{ 0x820fa000, 0xa4000, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
-		{ 0x820fb000, 0xa4200, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
-		{ 0x820fc000, 0xa4600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
-		{ 0x820fd000, 0xa4800, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
-	};
-	int i;
-
-	if (addr < 0x100000)
-		return addr;
-
-	for (i = 0; i < ARRAY_SIZE(fixed_map); i++) {
-		u32 ofs;
-
-		if (addr < fixed_map[i].phys)
-			continue;
-
-		ofs = addr - fixed_map[i].phys;
-		if (ofs > fixed_map[i].size)
-			continue;
-
-		return fixed_map[i].mapped + ofs;
-	}
-
-	if ((addr >= 0x18000000 && addr < 0x18c00000) ||
-	    (addr >= 0x70000000 && addr < 0x78000000) ||
-	    (addr >= 0x7c000000 && addr < 0x7c400000))
-		return mt7915_reg_map_l1(dev, addr);
-
-	return mt7915_reg_map_l2(dev, addr);
-}
-
-static u32 mt7915_rr(struct mt76_dev *mdev, u32 offset)
-{
-	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
-	u32 addr = __mt7915_reg_addr(dev, offset);
-
-	return dev->bus_ops->rr(mdev, addr);
-}
-
-static void mt7915_wr(struct mt76_dev *mdev, u32 offset, u32 val)
-{
-	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
-	u32 addr = __mt7915_reg_addr(dev, offset);
-
-	dev->bus_ops->wr(mdev, addr, val);
-}
-
-static u32 mt7915_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
-{
-	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
-	u32 addr = __mt7915_reg_addr(dev, offset);
-
-	return dev->bus_ops->rmw(mdev, addr, mask, val);
-}
-
 int mt7915_dma_init(struct mt7915_dev *dev)
 {
 	/* Increase buffer size to receive large VHT/HE MPDUs */
-	struct mt76_bus_ops *bus_ops;
 	int rx_buf_size = MT_RX_BUF_SIZE * 2;
 	u32 hif1_ofs = 0;
 	int ret;
 
-	dev->bus_ops = dev->mt76.bus;
-	bus_ops = devm_kmemdup(dev->mt76.dev, dev->bus_ops, sizeof(*bus_ops),
-			       GFP_KERNEL);
-	if (!bus_ops)
-		return -ENOMEM;
-
-	bus_ops->rr = mt7915_rr;
-	bus_ops->wr = mt7915_wr;
-	bus_ops->rmw = mt7915_rmw;
-	dev->mt76.bus = bus_ops;
-
 	mt76_dma_attach(&dev->mt76);
 
 	if (dev->hif2)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 261f5ab23721..1b688bd5c52c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -299,7 +299,6 @@ static void mt7915_init_work(struct work_struct *work)
 static void mt7915_wfsys_reset(struct mt7915_dev *dev)
 {
 	u32 val = MT_TOP_PWR_KEY | MT_TOP_PWR_SW_PWR_ON | MT_TOP_PWR_PWR_ON;
-	u32 reg = mt7915_reg_map_l1(dev, MT_TOP_MISC);
 
 #define MT_MCU_DUMMY_RANDOM	GENMASK(15, 0)
 #define MT_MCU_DUMMY_DEFAULT	GENMASK(31, 16)
@@ -331,7 +330,7 @@ static void mt7915_wfsys_reset(struct mt7915_dev *dev)
 	}
 
 	/* wfsys reset won't clear host registers */
-	mt76_clear(dev, reg, MT_TOP_MISC_FW_STATE);
+	mt76_clear(dev, MT_TOP_MISC, MT_TOP_MISC_FW_STATE);
 
 	msleep(100);
 }
@@ -339,7 +338,6 @@ static void mt7915_wfsys_reset(struct mt7915_dev *dev)
 static int mt7915_init_hardware(struct mt7915_dev *dev)
 {
 	int ret, idx;
-	u32 val;
 
 	mt76_wr(dev, MT_INT_SOURCE_CSR, ~0);
 
@@ -347,12 +345,11 @@ static int mt7915_init_hardware(struct mt7915_dev *dev)
 	spin_lock_init(&dev->token_lock);
 	idr_init(&dev->token);
 
-	dev->dbdc_support = !!(mt7915_l1_rr(dev, MT_HW_BOUND) & BIT(5));
-
-	val = mt76_rr(dev, mt7915_reg_map_l1(dev, MT_TOP_MISC));
+	dev->dbdc_support = !!(mt76_rr(dev, MT_HW_BOUND) & BIT(5));
 
 	/* If MCU was already running, it is likely in a bad state */
-	if (FIELD_GET(MT_TOP_MISC_FW_STATE, val) > FW_STATE_FW_DOWNLOAD)
+	if (mt76_get_field(dev, MT_TOP_MISC, MT_TOP_MISC_FW_STATE) >
+	    FW_STATE_FW_DOWNLOAD)
 		mt7915_wfsys_reset(dev);
 
 	ret = mt7915_dma_init(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 0924ae074db2..e61dfe966f0a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1297,8 +1297,8 @@ void mt7915_mac_cca_stats_reset(struct mt7915_phy *phy)
 	bool ext_phy = phy != &dev->phy;
 	u32 reg = MT_WF_PHY_RX_CTRL1(ext_phy);
 
-	mt7915_l2_clear(dev, reg, MT_WF_PHY_RX_CTRL1_STSCNT_EN);
-	mt7915_l2_set(dev, reg, BIT(11) | BIT(9));
+	mt76_clear(dev, reg, MT_WF_PHY_RX_CTRL1_STSCNT_EN);
+	mt76_set(dev, reg, BIT(11) | BIT(9));
 }
 
 void mt7915_mac_reset_counters(struct mt7915_phy *phy)
@@ -1391,12 +1391,12 @@ void mt7915_mac_set_timing(struct mt7915_phy *phy)
 
 void mt7915_mac_enable_nf(struct mt7915_dev *dev, bool ext_phy)
 {
-	mt7915_l2_set(dev, MT_WF_PHY_RXTD12(ext_phy),
-		      MT_WF_PHY_RXTD12_IRPI_SW_CLR_ONLY |
-		      MT_WF_PHY_RXTD12_IRPI_SW_CLR);
+	mt76_set(dev, MT_WF_PHY_RXTD12(ext_phy),
+		 MT_WF_PHY_RXTD12_IRPI_SW_CLR_ONLY |
+		 MT_WF_PHY_RXTD12_IRPI_SW_CLR);
 
-	mt7915_l2_set(dev, MT_WF_PHY_RX_CTRL1(ext_phy),
-		      FIELD_PREP(MT_WF_PHY_RX_CTRL1_IPI_EN, 0x5));
+	mt76_set(dev, MT_WF_PHY_RX_CTRL1(ext_phy),
+		 FIELD_PREP(MT_WF_PHY_RX_CTRL1_IPI_EN, 0x5));
 }
 
 static u8
@@ -1411,7 +1411,7 @@ mt7915_phy_get_nf(struct mt7915_phy *phy, int idx)
 		u32 reg = MT_WF_IRPI(nss + (idx << dev->dbdc_support));
 
 		for (i = 0; i < ARRAY_SIZE(nf_power); i++, reg += 4) {
-			val = mt7915_l2_rr(dev, reg);
+			val = mt76_rr(dev, reg);
 			sum += val * nf_power[i];
 			n += val;
 		}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 639f65d63add..0b739ed8ce33 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2542,11 +2542,9 @@ static int mt7915_mcu_start_patch(struct mt7915_dev *dev)
 
 static int mt7915_driver_own(struct mt7915_dev *dev)
 {
-	u32 reg = mt7915_reg_map_l1(dev, MT_TOP_LPCR_HOST_BAND0);
-
-	mt76_wr(dev, reg, MT_TOP_LPCR_HOST_DRV_OWN);
-	if (!mt76_poll_msec(dev, reg, MT_TOP_LPCR_HOST_FW_OWN,
-			    0, 500)) {
+	mt76_wr(dev, MT_TOP_LPCR_HOST_BAND0, MT_TOP_LPCR_HOST_DRV_OWN);
+	if (!mt76_poll_msec(dev, MT_TOP_LPCR_HOST_BAND0,
+			    MT_TOP_LPCR_HOST_FW_OWN, 0, 500)) {
 		dev_err(dev->mt76.dev, "Timeout for driver own\n");
 		return -EIO;
 	}
@@ -2784,7 +2782,6 @@ static int mt7915_load_ram(struct mt7915_dev *dev)
 
 static int mt7915_load_firmware(struct mt7915_dev *dev)
 {
-	u32 reg = mt7915_reg_map_l1(dev, MT_TOP_MISC);
 	int ret;
 
 	ret = mt7915_load_patch(dev);
@@ -2795,7 +2792,7 @@ static int mt7915_load_firmware(struct mt7915_dev *dev)
 	if (ret)
 		return ret;
 
-	if (!mt76_poll_msec(dev, reg, MT_TOP_MISC_FW_STATE,
+	if (!mt76_poll_msec(dev, MT_TOP_MISC, MT_TOP_MISC_FW_STATE,
 			    FIELD_PREP(MT_TOP_MISC_FW_STATE,
 				       FW_STATE_WACPU_RDY), 1000)) {
 		dev_err(dev->mt76.dev, "Timeout for initializing firmware\n");
@@ -2883,18 +2880,15 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 
 void mt7915_mcu_exit(struct mt7915_dev *dev)
 {
-	u32 reg = mt7915_reg_map_l1(dev, MT_TOP_MISC);
-
 	__mt76_mcu_restart(&dev->mt76);
-	if (!mt76_poll_msec(dev, reg, MT_TOP_MISC_FW_STATE,
+	if (!mt76_poll_msec(dev, MT_TOP_MISC, MT_TOP_MISC_FW_STATE,
 			    FIELD_PREP(MT_TOP_MISC_FW_STATE,
 				       FW_STATE_FW_DOWNLOAD), 1000)) {
 		dev_err(dev->mt76.dev, "Failed to exit mcu\n");
 		return;
 	}
 
-	reg = mt7915_reg_map_l1(dev, MT_TOP_LPCR_HOST_BAND0);
-	mt76_wr(dev, reg, MT_TOP_LPCR_HOST_FW_OWN);
+	mt76_wr(dev, MT_TOP_LPCR_HOST_BAND0, MT_TOP_LPCR_HOST_FW_OWN);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
new file mode 100644
index 000000000000..af712a936ef6
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2020 MediaTek Inc. */
+
+#include "mt7915.h"
+
+static u32 mt7915_reg_map_l1(struct mt7915_dev *dev, u32 addr)
+{
+	u32 offset = FIELD_GET(MT_HIF_REMAP_L1_OFFSET, addr);
+	u32 base = FIELD_GET(MT_HIF_REMAP_L1_BASE, addr);
+
+	mt76_rmw_field(dev, MT_HIF_REMAP_L1, MT_HIF_REMAP_L1_MASK, base);
+	/* use read to push write */
+	mt76_rr(dev, MT_HIF_REMAP_L1);
+
+	return MT_HIF_REMAP_BASE_L1 + offset;
+}
+
+static u32 mt7915_reg_map_l2(struct mt7915_dev *dev, u32 addr)
+{
+	u32 offset = FIELD_GET(MT_HIF_REMAP_L2_OFFSET, addr);
+	u32 base = FIELD_GET(MT_HIF_REMAP_L2_BASE, addr);
+
+	mt76_rmw_field(dev, MT_HIF_REMAP_L2, MT_HIF_REMAP_L2_MASK, base);
+	/* use read to push write */
+	mt76_rr(dev, MT_HIF_REMAP_L2);
+
+	return MT_HIF_REMAP_BASE_L2 + offset;
+}
+
+static u32 __mt7915_reg_addr(struct mt7915_dev *dev, u32 addr)
+{
+	static const struct {
+		u32 phys;
+		u32 mapped;
+		u32 size;
+	} fixed_map[] = {
+		{ 0x54000000, 0x02000, 0x1000 }, /* WFDMA PCIE0 MCU DMA0 */
+		{ 0x55000000, 0x03000, 0x1000 }, /* WFDMA PCIE0 MCU DMA1 */
+		{ 0x58000000, 0x06000, 0x1000 }, /* WFDMA PCIE1 MCU DMA0 (MEM_DMA) */
+		{ 0x59000000, 0x07000, 0x1000 }, /* WFDMA PCIE1 MCU DMA1 */
+		{ 0x7c000000, 0xf0000, 0x10000 }, /* CONN_INFRA */
+		{ 0x7c020000, 0xd0000, 0x10000 }, /* CONN_INFRA, WFDMA */
+		{ 0x80020000, 0xb0000, 0x10000 }, /* WF_TOP_MISC_OFF */
+		{ 0x81020000, 0xc0000, 0x10000 }, /* WF_TOP_MISC_ON */
+		{ 0x820c0000, 0x08000, 0x4000 }, /* WF_UMAC_TOP (PLE) */
+		{ 0x820c8000, 0x0c000, 0x2000 }, /* WF_UMAC_TOP (PSE) */
+		{ 0x820cc000, 0x0e000, 0x2000 }, /* WF_UMAC_TOP (PP) */
+		{ 0x820ce000, 0x21c00, 0x0200 }, /* WF_LMAC_TOP (WF_SEC) */
+		{ 0x820cf000, 0x22000, 0x1000 }, /* WF_LMAC_TOP (WF_PF) */
+		{ 0x820d0000, 0x30000, 0x10000 }, /* WF_LMAC_TOP (WF_WTBLON) */
+		{ 0x820e0000, 0x20000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_CFG) */
+		{ 0x820e1000, 0x20400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_TRB) */
+		{ 0x820e2000, 0x20800, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_AGG) */
+		{ 0x820e3000, 0x20c00, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_ARB) */
+		{ 0x820e4000, 0x21000, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_TMAC) */
+		{ 0x820e5000, 0x21400, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_RMAC) */
+		{ 0x820e7000, 0x21e00, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_DMA) */
+		{ 0x820e9000, 0x23400, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_WTBLOFF) */
+		{ 0x820ea000, 0x24000, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_ETBF) */
+		{ 0x820eb000, 0x24200, 0x0400 }, /* WF_LMAC_TOP BN0 (WF_LPON) */
+		{ 0x820ec000, 0x24600, 0x0200 }, /* WF_LMAC_TOP BN0 (WF_INT) */
+		{ 0x820ed000, 0x24800, 0x0800 }, /* WF_LMAC_TOP BN0 (WF_MIB) */
+		{ 0x820f0000, 0xa0000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_CFG) */
+		{ 0x820f1000, 0xa0600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_TRB) */
+		{ 0x820f2000, 0xa0800, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_AGG) */
+		{ 0x820f3000, 0xa0c00, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_ARB) */
+		{ 0x820f4000, 0xa1000, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_TMAC) */
+		{ 0x820f5000, 0xa1400, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_RMAC) */
+		{ 0x820f7000, 0xa1e00, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_DMA) */
+		{ 0x820f9000, 0xa3400, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_WTBLOFF) */
+		{ 0x820fa000, 0xa4000, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_ETBF) */
+		{ 0x820fb000, 0xa4200, 0x0400 }, /* WF_LMAC_TOP BN1 (WF_LPON) */
+		{ 0x820fc000, 0xa4600, 0x0200 }, /* WF_LMAC_TOP BN1 (WF_INT) */
+		{ 0x820fd000, 0xa4800, 0x0800 }, /* WF_LMAC_TOP BN1 (WF_MIB) */
+	};
+	int i;
+
+	if (addr < 0x100000)
+		return addr;
+
+	for (i = 0; i < ARRAY_SIZE(fixed_map); i++) {
+		u32 ofs;
+
+		if (addr < fixed_map[i].phys)
+			continue;
+
+		ofs = addr - fixed_map[i].phys;
+		if (ofs > fixed_map[i].size)
+			continue;
+
+		return fixed_map[i].mapped + ofs;
+	}
+
+	if ((addr >= 0x18000000 && addr < 0x18c00000) ||
+	    (addr >= 0x70000000 && addr < 0x78000000) ||
+	    (addr >= 0x7c000000 && addr < 0x7c400000))
+		return mt7915_reg_map_l1(dev, addr);
+
+	return mt7915_reg_map_l2(dev, addr);
+}
+
+static u32 mt7915_rr(struct mt76_dev *mdev, u32 offset)
+{
+	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
+	u32 addr = __mt7915_reg_addr(dev, offset);
+
+	return dev->bus_ops->rr(mdev, addr);
+}
+
+static void mt7915_wr(struct mt76_dev *mdev, u32 offset, u32 val)
+{
+	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
+	u32 addr = __mt7915_reg_addr(dev, offset);
+
+	dev->bus_ops->wr(mdev, addr, val);
+}
+
+static u32 mt7915_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
+{
+	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
+	u32 addr = __mt7915_reg_addr(dev, offset);
+
+	return dev->bus_ops->rmw(mdev, addr, mask, val);
+}
+
+int mt7915_mmio_init(struct mt76_dev *mdev, void __iomem *mem_base, int irq)
+{
+	struct mt76_bus_ops *bus_ops;
+	struct mt7915_dev *dev;
+
+	dev = container_of(mdev, struct mt7915_dev, mt76);
+	mt76_mmio_init(&dev->mt76, mem_base);
+
+	dev->bus_ops = dev->mt76.bus;
+	bus_ops = devm_kmemdup(dev->mt76.dev, dev->bus_ops, sizeof(*bus_ops),
+			       GFP_KERNEL);
+	if (!bus_ops)
+		return -ENOMEM;
+
+	bus_ops->rr = mt7915_rr;
+	bus_ops->wr = mt7915_wr;
+	bus_ops->rmw = mt7915_rmw;
+	dev->mt76.bus = bus_ops;
+
+	mdev->rev = (mt76_rr(dev, MT_HW_CHIPID) << 16) |
+		    (mt76_rr(dev, MT_HW_REV) & 0xff);
+	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
+
+	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+
+	return 0;
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 1160d1bf8a7c..3df1d3e95b25 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -394,80 +394,6 @@ static inline void mt7915_irq_disable(struct mt7915_dev *dev, u32 mask)
 		mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
 }
 
-static inline u32
-mt7915_reg_map_l1(struct mt7915_dev *dev, u32 addr)
-{
-	u32 offset = FIELD_GET(MT_HIF_REMAP_L1_OFFSET, addr);
-	u32 base = FIELD_GET(MT_HIF_REMAP_L1_BASE, addr);
-
-	mt76_rmw_field(dev, MT_HIF_REMAP_L1, MT_HIF_REMAP_L1_MASK, base);
-	/* use read to push write */
-	mt76_rr(dev, MT_HIF_REMAP_L1);
-
-	return MT_HIF_REMAP_BASE_L1 + offset;
-}
-
-static inline u32
-mt7915_l1_rr(struct mt7915_dev *dev, u32 addr)
-{
-	return mt76_rr(dev, mt7915_reg_map_l1(dev, addr));
-}
-
-static inline void
-mt7915_l1_wr(struct mt7915_dev *dev, u32 addr, u32 val)
-{
-	mt76_wr(dev, mt7915_reg_map_l1(dev, addr), val);
-}
-
-static inline u32
-mt7915_l1_rmw(struct mt7915_dev *dev, u32 addr, u32 mask, u32 val)
-{
-	val |= mt7915_l1_rr(dev, addr) & ~mask;
-	mt7915_l1_wr(dev, addr, val);
-
-	return val;
-}
-
-#define mt7915_l1_set(dev, addr, val)	mt7915_l1_rmw(dev, addr, 0, val)
-#define mt7915_l1_clear(dev, addr, val)	mt7915_l1_rmw(dev, addr, val, 0)
-
-static inline u32
-mt7915_reg_map_l2(struct mt7915_dev *dev, u32 addr)
-{
-	u32 offset = FIELD_GET(MT_HIF_REMAP_L2_OFFSET, addr);
-	u32 base = FIELD_GET(MT_HIF_REMAP_L2_BASE, addr);
-
-	mt76_rmw_field(dev, MT_HIF_REMAP_L2, MT_HIF_REMAP_L2_MASK, base);
-	/* use read to push write */
-	mt76_rr(dev, MT_HIF_REMAP_L2);
-
-	return MT_HIF_REMAP_BASE_L2 + offset;
-}
-
-static inline u32
-mt7915_l2_rr(struct mt7915_dev *dev, u32 addr)
-{
-	return mt76_rr(dev, mt7915_reg_map_l2(dev, addr));
-}
-
-static inline void
-mt7915_l2_wr(struct mt7915_dev *dev, u32 addr, u32 val)
-{
-	mt76_wr(dev, mt7915_reg_map_l2(dev, addr), val);
-}
-
-static inline u32
-mt7915_l2_rmw(struct mt7915_dev *dev, u32 addr, u32 mask, u32 val)
-{
-	val |= mt7915_l2_rr(dev, addr) & ~mask;
-	mt7915_l2_wr(dev, addr, val);
-
-	return val;
-}
-
-#define mt7915_l2_set(dev, addr, val)	mt7915_l2_rmw(dev, addr, 0, val)
-#define mt7915_l2_clear(dev, addr, val)	mt7915_l2_rmw(dev, addr, val, 0)
-
 bool mt7915_mac_wtbl_update(struct mt7915_dev *dev, int idx, u32 mask);
 void mt7915_mac_reset_counters(struct mt7915_phy *phy);
 void mt7915_mac_cca_stats_reset(struct mt7915_phy *phy);
@@ -486,6 +412,7 @@ void mt7915_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 void mt7915_mac_work(struct work_struct *work);
 void mt7915_mac_reset_work(struct work_struct *work);
 void mt7915_mac_sta_rc_work(struct work_struct *work);
+int mt7915_mmio_init(struct mt76_dev *mdev, void __iomem *mem_base, int irq);
 int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 			  enum mt76_txq_id qid, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 13880cc9c9e8..75769595d1e1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -201,7 +201,7 @@ static void mt7915_pci_init_hif2(struct mt7915_dev *dev)
 	}
 
 	/* master switch of PCIe tnterrupt enable */
-	mt7915_l1_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0xff);
+	mt76_wr(dev, MT_PCIE1_MAC_INT_ENABLE, 0xff);
 }
 
 static int mt7915_pci_hif2_probe(struct pci_dev *pdev)
@@ -274,15 +274,12 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto error;
 
-	mt76_mmio_init(&dev->mt76, pcim_iomap_table(pdev)[0]);
-	mdev->rev = (mt7915_l1_rr(dev, MT_HW_CHIPID) << 16) |
-		    (mt7915_l1_rr(dev, MT_HW_REV) & 0xff);
-	dev_dbg(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
-
-	mt76_wr(dev, MT_INT_MASK_CSR, 0);
+	ret = mt7915_mmio_init(mdev, pcim_iomap_table(pdev)[0], pdev->irq);
+	if (ret)
+		goto error;
 
 	/* master switch of PCIe tnterrupt enable */
-	mt7915_l1_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
+	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 
 	ret = devm_request_irq(mdev->dev, pdev->irq, mt7915_irq_handler,
 			       IRQF_SHARED, KBUILD_MODNAME, dev);
-- 
2.18.0

