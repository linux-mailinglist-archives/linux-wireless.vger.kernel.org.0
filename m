Return-Path: <linux-wireless+bounces-4431-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A11873632
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 13:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EBD228977B
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Mar 2024 12:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2707B5F566;
	Wed,  6 Mar 2024 12:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="sIayK+nu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2210B7FBC1
	for <linux-wireless@vger.kernel.org>; Wed,  6 Mar 2024 12:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709727754; cv=none; b=CyADQfBOQwTcsuW7iSu4d5GNCPQ2aGHJryGVLDJmh25FPDdMsHb6Si3+8FmWehsOJzyoGF3zvmmXl6iIGu7Iuo7haZjsA93MEQcLppWPQlz+UyM3RmKMn8hxSiMLxF1Y8oyLy9jkBq/PNbALVtF2PNzDarUtcZQ1M/a8WI8S7Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709727754; c=relaxed/simple;
	bh=nRe8RH2VTIAgVuzquec1gm+fICk8S14gLv71IMAEGkE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o1/UVx9CFUcOfwMJfseOydhU4iQzSMydGbCVP7aCA+z21agt0eE+jMfqnZNlbDBKeC+0PhCsMIX/TUAQyM2UrI5xZRZUQlopg3bNN8l+mEhQTP4KGIoDbHaO8nuaDncH/nWDI0aWxla0JeAoVMMr6tMPcinLCqfgnTG8UobUgFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=sIayK+nu; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3018b734dbb411ee935d6952f98a51a9-20240306
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=jPqMXlO9tqjBlYdzngIc6OLypbW76M46+4gJOl+qW4s=;
	b=sIayK+nuPZeIB+rmGxGHRQ7qnfYorCjCKcHKfivo95m7L0XLaCBwgAs9IhUgtjSDcssxYyRs9xZ2NZZ8sSg+pcCZa4AQ0wuD/nsLb0PzvDXmKKUmD/JFgkgV+FBmYOg3+B0QbiP49Or6Vn+zhh1v8cKx44CiG9BJ9VNAxcfaQQE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:3e8a0314-d874-442f-8dd3-0b25087754c7,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:888d2f81-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3018b734dbb411ee935d6952f98a51a9-20240306
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <deren.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 602606993; Wed, 06 Mar 2024 20:22:24 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 6 Mar 2024 20:22:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 6 Mar 2024 20:22:22 +0800
From: Deren Wu <deren.wu@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Soul Huang <Soul.Huang@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, Leon Yen
	<Leon.Yen@mediatek.com>, Eric-SY Chang <Eric-SY.Chang@mediatek.com>, KM Lin
	<km.lin@mediatek.com>, Robin Chiu <robin.chiu@mediatek.com>, CH Yeh
	<ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>, Quan Zhou
	<quan.zhou@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen
	<shayne.chen@mediatek.com>, linux-wireless <linux-wireless@vger.kernel.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>, Deren Wu
	<deren.wu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: introduce mt7920 PCIe support
Date: Wed, 6 Mar 2024 20:22:14 +0800
Message-ID: <a538c837a1c3a5a360b10c33c83b57c6564821ae.1709727416.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N

mt7920e is a mt7921 series chipset with 802.11ax 2x2:2SS support.
The major difference is in firmware side only, at this moment.
This patch would add some mandatory changes for new chip id and
firmware download control.

Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac.h |  8 +++++++-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c  | 11 +++++++++--
 drivers/net/wireless/mediatek/mt76/mt792x.h      |  6 ++++++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 98d64d3d2993..91987bdf239d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -177,6 +177,11 @@ static inline bool is_mt7925(struct mt76_dev *dev)
 	return mt76_chip(dev) == 0x7925;
 }
 
+static inline bool is_mt7920(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7920;
+}
+
 static inline bool is_mt7922(struct mt76_dev *dev)
 {
 	return mt76_chip(dev) == 0x7922;
@@ -184,7 +189,7 @@ static inline bool is_mt7922(struct mt76_dev *dev)
 
 static inline bool is_mt7921(struct mt76_dev *dev)
 {
-	return mt76_chip(dev) == 0x7961 || is_mt7922(dev);
+	return mt76_chip(dev) == 0x7961 || is_mt7922(dev) || is_mt7920(dev);
 }
 
 static inline bool is_mt7663(struct mt76_dev *dev)
@@ -259,6 +264,7 @@ static inline bool is_mt76_fw_txp(struct mt76_dev *dev)
 {
 	switch (mt76_chip(dev)) {
 	case 0x7961:
+	case 0x7920:
 	case 0x7922:
 	case 0x7925:
 	case 0x7663:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index cda853e86676..0b69b225bc16 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -24,6 +24,8 @@ static const struct pci_device_id mt7921_pci_device_table[] = {
 		.driver_data = (kernel_ulong_t)MT7921_FIRMWARE_WM },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0616),
 		.driver_data = (kernel_ulong_t)MT7922_FIRMWARE_WM },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7920),
+		.driver_data = (kernel_ulong_t)MT7920_FIRMWARE_WM },
 	{ },
 };
 
@@ -269,9 +271,9 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	struct mt76_bus_ops *bus_ops;
 	struct mt792x_dev *dev;
 	struct mt76_dev *mdev;
+	u16 cmd, chipid;
 	u8 features;
 	int ret;
-	u16 cmd;
 
 	ret = pcim_enable_device(pdev);
 	if (ret)
@@ -345,7 +347,10 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_dev;
 
-	mdev->rev = (mt7921_l1_rr(dev, MT_HW_CHIPID) << 16) |
+	chipid = mt7921_l1_rr(dev, MT_HW_CHIPID);
+	if (chipid == 0x7961 && (mt7921_l1_rr(dev, MT_HW_BOUND) & BIT(7)))
+		chipid = 0x7920;
+	mdev->rev = (chipid << 16) |
 		    (mt7921_l1_rr(dev, MT_HW_REV) & 0xff);
 	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
@@ -551,6 +556,8 @@ static struct pci_driver mt7921_pci_driver = {
 module_pci_driver(mt7921_pci_driver);
 
 MODULE_DEVICE_TABLE(pci, mt7921_pci_device_table);
+MODULE_FIRMWARE(MT7920_FIRMWARE_WM);
+MODULE_FIRMWARE(MT7920_ROM_PATCH);
 MODULE_FIRMWARE(MT7921_FIRMWARE_WM);
 MODULE_FIRMWARE(MT7921_ROM_PATCH);
 MODULE_FIRMWARE(MT7922_FIRMWARE_WM);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index a8556de3d480..8c9fb5e98c6e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -36,10 +36,12 @@
 #define MT792x_MCU_INIT_RETRY_COUNT	10
 #define MT792x_WFSYS_INIT_RETRY_COUNT	2
 
+#define MT7920_FIRMWARE_WM	"mediatek/WIFI_RAM_CODE_MT7961_1a.bin"
 #define MT7921_FIRMWARE_WM	"mediatek/WIFI_RAM_CODE_MT7961_1.bin"
 #define MT7922_FIRMWARE_WM	"mediatek/WIFI_RAM_CODE_MT7922_1.bin"
 #define MT7925_FIRMWARE_WM	"mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin"
 
+#define MT7920_ROM_PATCH	"mediatek/WIFI_MT7961_patch_mcu_1a_2_hdr.bin"
 #define MT7921_ROM_PATCH	"mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin"
 #define MT7922_ROM_PATCH	"mediatek/WIFI_MT7922_patch_mcu_1_1_hdr.bin"
 #define MT7925_ROM_PATCH	"mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin"
@@ -326,6 +328,8 @@ int mt792x_mcu_fw_pmctrl(struct mt792x_dev *dev);
 static inline char *mt792x_ram_name(struct mt792x_dev *dev)
 {
 	switch (mt76_chip(&dev->mt76)) {
+	case 0x7920:
+		return MT7920_FIRMWARE_WM;
 	case 0x7922:
 		return MT7922_FIRMWARE_WM;
 	case 0x7925:
@@ -338,6 +342,8 @@ static inline char *mt792x_ram_name(struct mt792x_dev *dev)
 static inline char *mt792x_patch_name(struct mt792x_dev *dev)
 {
 	switch (mt76_chip(&dev->mt76)) {
+	case 0x7920:
+		return MT7920_ROM_PATCH;
 	case 0x7922:
 		return MT7922_ROM_PATCH;
 	case 0x7925:
-- 
2.18.0


