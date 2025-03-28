Return-Path: <linux-wireless+bounces-20918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF30EA743A6
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 06:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88F911892708
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Mar 2025 05:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FF82116F0;
	Fri, 28 Mar 2025 05:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ajgSkviY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCF3211285
	for <linux-wireless@vger.kernel.org>; Fri, 28 Mar 2025 05:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743141247; cv=none; b=I2oPeGNw/AQjW4eU4tuUTMXpZ/rvj68EVy6FgSafkX3smHk1hNPwvV/MN1RsXi1u9WlnckVTBxVdnJmpnPQPGBPFld0v9qelsSWOw1X7MuhURPlr4SY9UvJQRgP2SUoF6zbKrHYqpuFI7GHJ2B2CFvWdYzK67txzGl7d/ULjxw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743141247; c=relaxed/simple;
	bh=yIu7UdfvnEdYFVRqLA/cc9n4vsWFXbwi/T/4p9bIl1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cURUZwcB5+PPsmqIYoIJBU/0oSXz1feVJgeN9BHgqGXbDPypeGbK3bC/1zA3jakDTErQ42Q3cgDfCB3mLDnEJPIsbeDXIdi93tQ5m+JJlKtRlSFbRw7KnE727cdD+CQ3bDsGg0DLEXoziOpvFuFb9mqfGeWejwbPLe6QR+kp/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ajgSkviY; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 0a64dd540b9911f08eb9c36241bbb6fb-20250328
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=QsdUmFFLDZj5FPXjU9QE40sGSmXARWdokfpO+ZrHuO8=;
	b=ajgSkviYP64/QoYGi6Jo/SNixJK7xGj/jNb0YTa8LOPaQmQxL04LtbH1ReKAsH9hDOazBcCuAFyGFWwHScSRnnIvJz+C4ZvOEwOCoXpOPWKZ3iD7YVIBPQYrLUU7d+K0lrkPiXkg+J8cKhrZpr8G3F37I3qop40CWw54zHfNA6Q=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:6c352f96-0de0-4905-a1c1-18974050b023,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:c964ab4a-a527-43d8-8af6-bc8b32d9f5e9,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 0a64dd540b9911f08eb9c36241bbb6fb-20250328
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw02.mediatek.com
	(envelope-from <shayne.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1459550172; Fri, 28 Mar 2025 13:53:58 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Fri, 28 Mar 2025 13:53:56 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Fri, 28 Mar 2025 13:53:56 +0800
From: Shayne Chen <shayne.chen@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>
CC: linux-wireless <linux-wireless@vger.kernel.org>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, Evelyn Tsai
	<evelyn.tsai@mediatek.com>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Shayne Chen <shayne.chen@mediatek.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH 01/10] wifi: mt76: mt7996: add macros for pci decive id
Date: Fri, 28 Mar 2025 13:50:49 +0800
Message-ID: <20250328055058.1648755-2-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250328055058.1648755-1-shayne.chen@mediatek.com>
References: <20250328055058.1648755-1-shayne.chen@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

The chipset name (i.e., brand name) used by the driver may cause confusion
with the PCI device ID when adding support for new chipsets.

| Chipset name | PCI device id  |
|--------------|----------------|
| 7996         | 0x7990, 0x7991 |
| 7992         | 0x7992, 0x799a |
| 7990         | 0x7993, 0x799b |

To prevent confusion, replace the code that directly uses the device ID
with macros. This is a preliminary patch to support mt7990 chipset.

Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7996/coredump.c  |  4 ++--
 .../net/wireless/mediatek/mt76/mt7996/eeprom.c    |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7996/init.c  |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c   |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7996/mmio.c  |  6 +++---
 .../net/wireless/mediatek/mt76/mt7996/mt7996.h    |  9 +++++++--
 drivers/net/wireless/mediatek/mt76/mt7996/pci.c   | 15 ++++++++-------
 7 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/coredump.c b/drivers/net/wireless/mediatek/mt76/mt7996/coredump.c
index ccab0d7b9be4..303d6e80a666 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/coredump.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/coredump.c
@@ -48,8 +48,8 @@ const struct mt7996_mem_region*
 mt7996_coredump_get_mem_layout(struct mt7996_dev *dev, u32 *num)
 {
 	switch (mt76_chip(&dev->mt76)) {
-	case 0x7990:
-	case 0x7991:
+	case MT7996_DEVICE_ID:
+	case MT7996_DEVICE_ID_2:
 		*num = ARRAY_SIZE(mt7996_mem_regions);
 		return &mt7996_mem_regions[0];
 	default:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
index 53dfac02f8af..51b09956486b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
@@ -13,9 +13,9 @@ static int mt7996_check_eeprom(struct mt7996_dev *dev)
 	u16 val = get_unaligned_le16(eeprom);
 
 	switch (val) {
-	case 0x7990:
+	case MT7996_DEVICE_ID:
 		return is_mt7996(&dev->mt76) ? 0 : -EINVAL;
-	case 0x7992:
+	case MT7992_DEVICE_ID:
 		return is_mt7992(&dev->mt76) ? 0 : -EINVAL;
 	default:
 		return -EINVAL;
@@ -25,7 +25,7 @@ static int mt7996_check_eeprom(struct mt7996_dev *dev)
 static char *mt7996_eeprom_name(struct mt7996_dev *dev)
 {
 	switch (mt76_chip(&dev->mt76)) {
-	case 0x7992:
+	case MT7992_DEVICE_ID:
 		switch (dev->var.type) {
 		case MT7992_VAR_TYPE_23:
 			if (dev->var.fem == MT7996_FEM_INT)
@@ -39,7 +39,7 @@ static char *mt7996_eeprom_name(struct mt7996_dev *dev)
 				return MT7992_EEPROM_DEFAULT_MIX;
 			return MT7992_EEPROM_DEFAULT;
 		}
-	case 0x7990:
+	case MT7996_DEVICE_ID:
 	default:
 		switch (dev->var.type) {
 		case MT7996_VAR_TYPE_233:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 6b660424aedc..f017d30e1c49 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -929,13 +929,13 @@ static int mt7996_variant_type_init(struct mt7996_dev *dev)
 	u8 var_type;
 
 	switch (mt76_chip(&dev->mt76)) {
-	case 0x7990:
+	case MT7996_DEVICE_ID:
 		if (val & MT_PAD_GPIO_2ADIE_TBTC)
 			var_type = MT7996_VAR_TYPE_233;
 		else
 			var_type = MT7996_VAR_TYPE_444;
 		break;
-	case 0x7992:
+	case MT7992_DEVICE_ID:
 		if (val & MT_PAD_GPIO_ADIE_SINGLE)
 			var_type = MT7992_VAR_TYPE_23;
 		else if (u32_get_bits(val, MT_PAD_GPIO_ADIE_COMB_7992))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index ddd555942c73..81cc50ae55b0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -13,7 +13,7 @@
 #define fw_name(_dev, name, ...)	({			\
 	char *_fw;						\
 	switch (mt76_chip(&(_dev)->mt76)) {			\
-	case 0x7992:						\
+	case MT7992_DEVICE_ID:						\
 		switch ((_dev)->var.type) {			\
 		case MT7992_VAR_TYPE_23:			\
 			_fw = MT7992_##name##_23;		\
@@ -22,7 +22,7 @@
 			_fw = MT7992_##name;			\
 		}						\
 		break;						\
-	case 0x7990:						\
+	case MT7996_DEVICE_ID:						\
 	default:						\
 		switch ((_dev)->var.type) {			\
 		case MT7996_VAR_TYPE_233:			\
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
index 13b188e281bd..8b07883f45cc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mmio.c
@@ -350,7 +350,7 @@ int mt7996_mmio_wed_init(struct mt7996_dev *dev, void *pdev_ptr,
 				     MT_RXQ_RING_BASE(MT7996_RXQ_BAND0) +
 				     MT7996_RXQ_BAND0 * MT_RING_SIZE;
 
-		wed->wlan.id = 0x7991;
+		wed->wlan.id = MT7996_DEVICE_ID_2;
 		wed->wlan.tx_tbit[0] = ffs(MT_INT_TX_DONE_BAND2) - 1;
 	} else {
 		wed->wlan.hw_rro = dev->has_rro; /* default on */
@@ -443,13 +443,13 @@ static int mt7996_mmio_init(struct mt76_dev *mdev,
 	spin_lock_init(&dev->reg_lock);
 
 	switch (device_id) {
-	case 0x7990:
+	case MT7996_DEVICE_ID:
 		dev->reg.base = mt7996_reg_base;
 		dev->reg.offs_rev = mt7996_offs;
 		dev->reg.map = mt7996_reg_map;
 		dev->reg.map_size = ARRAY_SIZE(mt7996_reg_map);
 		break;
-	case 0x7992:
+	case MT7992_DEVICE_ID:
 		dev->reg.base = mt7996_reg_base;
 		dev->reg.offs_rev = mt7992_offs;
 		dev->reg.map = mt7996_reg_map;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 43e646ed6094..bc22c3e12d94 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -30,6 +30,11 @@
 #define MT7996_RX_MCU_RING_SIZE		512
 #define MT7996_RX_MCU_RING_SIZE_WA	1024
 
+#define MT7996_DEVICE_ID		0x7990
+#define MT7996_DEVICE_ID_2		0x7991
+#define MT7992_DEVICE_ID		0x7992
+#define MT7992_DEVICE_ID_2		0x799a
+
 #define MT7996_FIRMWARE_WA		"mediatek/mt7996/mt7996_wa.bin"
 #define MT7996_FIRMWARE_WM		"mediatek/mt7996/mt7996_wm.bin"
 #define MT7996_FIRMWARE_DSP		"mediatek/mt7996/mt7996_dsp.bin"
@@ -471,11 +476,11 @@ static inline bool
 mt7996_has_background_radar(struct mt7996_dev *dev)
 {
 	switch (mt76_chip(&dev->mt76)) {
-	case 0x7990:
+	case MT7996_DEVICE_ID:
 		if (dev->var.type == MT7996_VAR_TYPE_233)
 			return false;
 		break;
-	case 0x7992:
+	case MT7992_DEVICE_ID:
 		if (dev->var.type == MT7992_VAR_TYPE_23)
 			return false;
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
index 04056181368a..a4338367aaa1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/pci.c
@@ -16,14 +16,14 @@ static DEFINE_SPINLOCK(hif_lock);
 static u32 hif_idx;
 
 static const struct pci_device_id mt7996_pci_device_table[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7990) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7992) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, MT7996_DEVICE_ID) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, MT7992_DEVICE_ID) },
 	{ },
 };
 
 static const struct pci_device_id mt7996_hif_device_table[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7991) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x799a) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, MT7996_DEVICE_ID_2) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, MT7992_DEVICE_ID_2) },
 	{ },
 };
 
@@ -63,8 +63,8 @@ static struct mt7996_hif *mt7996_pci_init_hif2(struct pci_dev *pdev)
 {
 	hif_idx++;
 
-	if (!pci_get_device(PCI_VENDOR_ID_MEDIATEK, 0x7991, NULL) &&
-	    !pci_get_device(PCI_VENDOR_ID_MEDIATEK, 0x799a, NULL))
+	if (!pci_get_device(PCI_VENDOR_ID_MEDIATEK, MT7996_DEVICE_ID_2, NULL) &&
+	    !pci_get_device(PCI_VENDOR_ID_MEDIATEK, MT7992_DEVICE_ID_2, NULL))
 		return NULL;
 
 	writel(hif_idx | MT_PCIE_RECOG_ID_SEM,
@@ -121,7 +121,8 @@ static int mt7996_pci_probe(struct pci_dev *pdev,
 
 	mt76_pci_disable_aspm(pdev);
 
-	if (id->device == 0x7991 || id->device == 0x799a)
+	if (id->device == MT7996_DEVICE_ID_2 ||
+	    id->device == MT7992_DEVICE_ID_2)
 		return mt7996_pci_hif2_probe(pdev);
 
 	dev = mt7996_mmio_probe(&pdev->dev, pcim_iomap_table(pdev)[0],
-- 
2.39.2


