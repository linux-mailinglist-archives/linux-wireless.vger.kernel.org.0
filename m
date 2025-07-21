Return-Path: <linux-wireless+bounces-25692-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B35DB0B984
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 02:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32AE11896DAA
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Jul 2025 00:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DAC738DD1;
	Mon, 21 Jul 2025 00:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQgFwhIm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0877E3594B
	for <linux-wireless@vger.kernel.org>; Mon, 21 Jul 2025 00:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753057218; cv=none; b=nXkmtykOe+ZA4qeGLmsUBH3RMG8QKBiumi4tBU3VrF5gl9nDwFQQS3Ck/2Qg8S5khpoE6XcbUyuNYJi1U76+xz9IvqnRGfXncG6UVswSHbUoK9hejM07nU5WcgEBRpkkg2xPiKRAcoVhSNLGqd7Nnho7wPYe2dglezGmg1+bRSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753057218; c=relaxed/simple;
	bh=xLfs9GccRXj89pT3eWnn2qbPQiqkD02ATM1Q+vJYucc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OiR+Sbsa2KLf5MRD48bvQvDpfy7dp0lFRmZeEQev0nEuXPohz3ovibedh27VMdW2U9tfchsU1zSpoT9K7nAn+LhkyrRBRusn5gyWcPqfx9iBrBlWNwH6ZeK8qB+9iBzXz8lhV7LFRzxT15kQOAfwYrvUluR0bvTxvXzWuRsmpHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQgFwhIm; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b391ca6146eso3439138a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 20 Jul 2025 17:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753057216; x=1753662016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+QOGgYixiKgJ3Gj4wmhfqO/4utvXFNGruDxpU9/0YI=;
        b=OQgFwhImhrilbgHXYCLfgzemlzubzMLrcmmAGC60Ry6/q7JFN/YO3iSVGgsNPzQw0P
         xWNnpI+RA5LLvfh2GHx4Gjqt/IcgqcTkAbmtbzgPB/67D3xyIvBshY1qyKdDD7BRUiU7
         p3Tsffpxj7Fxzj2qKeL/khasjW26emNdbq5s+Sc3XgDjChf1wYwsy9o5/IXMm2Z3oErv
         L1XPo1dJHycqhd+DS0v/Oe+OvixJ+4JsO1CHA0wQmpm/ZLrqdDoXiownBvzKCoDf/eLN
         EDopvArF9WbELea+xfjovRsxcVBCCpr3SUmTlcT1bPP8rb16+AGEE0x5cfKjsL8r1c6z
         kQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753057216; x=1753662016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+QOGgYixiKgJ3Gj4wmhfqO/4utvXFNGruDxpU9/0YI=;
        b=Is7SyO1IB9sQeAyVMBDi8lay0euvV0vAbeiHkAOCcK44ugOVSL8jnW12elb/ra54YX
         fBtMPL2C6VpCmqDhhu1/qx5MM8/WoGojrOdhj+hadJ8jYNYq9pOHPB8lTWL/LAS2DE0d
         nvSSwANJ/NNp6pDiBDx5mcH6hE77C66IaPpNAa9ZAdyEUAgp1ML8W17FGrbaQIFQnugO
         FHzztQ/qYbpbhHfl8u5+To5+PoK5Z2tGG+6R3JhQHVcMMklMX1V1MCdTNojRClufNobS
         jOEzlyz3ltA7ec4JuSKMRWF7jWjYY84fpAc7QSSiMKq/+/r4smWnEtbYXX5fQV+0QDFG
         NiBQ==
X-Gm-Message-State: AOJu0YyXfgCDngviaVy5s4iJBDwDFEJSbFTXBQxelEfJ8zVVb4b/kkBa
	I3zNBD7Fw5Q8Xu7DyyZpHLVVE5aiKt7VcBEJ2OtQzVLcprQEMQEivUGWMy4FWaF7
X-Gm-Gg: ASbGncv/EbLThmVSbQTrAk463RL1Fu1MBUR3XIud1nRLRbIN0JiciehiOz8SDYEv2mf
	Y2OjTNCd6jvV0s/0LzhyYnnrsc9KHaFJ2WMzTN5YMLvN/LEvzxukAi+8F777cevICDtg9jmh1Lv
	mJ2a4OenFB2AULtqrTzXOeql9aIRntNokQu4UGPcDhgMpwmlj+IdtknSefjkhRk7qNMaK15gBht
	KQzSpdVNk1PYR7/g6B/jtZl071UyVLFHEKX5KkDoEOj3dRMLF4nC7U2C00rszDe33pkqNNIiYfy
	NPRJPaNP6UYcJ0D5bU8TUFJBkWWzI+4jvWvbSiy86+wbNKUibsDlZFVsqsWbA5JYD85zWoFCbI4
	4q8X1oU5g8mkUPWW544Wwmq6ni2yTRy7IU9AWNqqUKK6zcL5V4oaVmkKJ6RoNeGpILOOya3TOft
	w=
X-Google-Smtp-Source: AGHT+IGhPdre6vRF7myCtTV+CwL3ILs6v3oauuZxBiD6JD1Fk5ssztwYZQoF2pxR3o1os26AWGiLJw==
X-Received: by 2002:a05:6a20:6a10:b0:203:bb65:995a with SMTP id adf61e73a8af0-2390dc51b64mr23135334637.30.1753057215978;
        Sun, 20 Jul 2025 17:20:15 -0700 (PDT)
Received: from localhost.localdomain (syn-172-119-055-184.res.spectrum.com. [172.119.55.184])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d53fsm4661058b3a.105.2025.07.20.17.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 17:20:15 -0700 (PDT)
From: tnguy3333 <tnguy3333@gmail.com>
To: linux-wireless@vger.kernel.org,
	nbd@nbd.name,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com,
	sean.wang@mediatek.com,
	tnguy3333 <tnguy3333@gmail.com>
Subject: [PATCH 2/5] add to build and add firmware paths
Date: Sun, 20 Jul 2025 17:19:02 -0700
Message-Id: <20250721001905.11614-3-tnguy3333@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250721001905.11614-1-tnguy3333@gmail.com>
References: <20250721001905.11614-1-tnguy3333@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add mt7902 as a kernel module and add firmware paths

Signed-off-by: tnguy3333 <tnguy3333@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/Kconfig      |  1 +
 drivers/net/wireless/mediatek/mt76/Makefile     |  1 +
 drivers/net/wireless/mediatek/mt76/mt7902/pci.c | 16 +---------------
 drivers/net/wireless/mediatek/mt76/mt792x.h     |  6 ++++++
 4 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/Kconfig b/drivers/net/wireless/mediatek/mt76/Kconfig
index a86f800b8..a09ff43a8 100644
--- a/drivers/net/wireless/mediatek/mt76/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/Kconfig
@@ -45,3 +45,4 @@ source "drivers/net/wireless/mediatek/mt76/mt7915/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt7921/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt7996/Kconfig"
 source "drivers/net/wireless/mediatek/mt76/mt7925/Kconfig"
+source "drivers/net/wireless/mediatek/mt76/mt7902/Kconfig"
diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index 87512d101..b7fb4c1a1 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -45,3 +45,4 @@ obj-$(CONFIG_MT7915E) += mt7915/
 obj-$(CONFIG_MT7921_COMMON) += mt7921/
 obj-$(CONFIG_MT7996E) += mt7996/
 obj-$(CONFIG_MT7925_COMMON) += mt7925/
+obj-$(CONFIG_MT7902_COMMON) += mt7902/
diff --git a/drivers/net/wireless/mediatek/mt76/mt7902/pci.c b/drivers/net/wireless/mediatek/mt76/mt7902/pci.c
index 84fa2a8de..ec7e34b07 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7902/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7902/pci.c
@@ -14,18 +14,8 @@
 #include "mcu.h"
 
 static const struct pci_device_id mt7902_pci_device_table[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7961),
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7902),
 		.driver_data = (kernel_ulong_t)MT7902_FIRMWARE_WM },
-	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7922),
-		.driver_data = (kernel_ulong_t)MT7922_FIRMWARE_WM },
-	{ PCI_DEVICE(PCI_VENDOR_ID_ITTIM, 0x7922),
-		.driver_data = (kernel_ulong_t)MT7922_FIRMWARE_WM },
-	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0608),
-		.driver_data = (kernel_ulong_t)MT7902_FIRMWARE_WM },
-	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0616),
-		.driver_data = (kernel_ulong_t)MT7922_FIRMWARE_WM },
-	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7920),
-		.driver_data = (kernel_ulong_t)MT7920_FIRMWARE_WM },
 	{ },
 };
 
@@ -573,12 +563,8 @@ static struct pci_driver mt7902_pci_driver = {
 module_pci_driver(mt7902_pci_driver);
 
 MODULE_DEVICE_TABLE(pci, mt7902_pci_device_table);
-MODULE_FIRMWARE(MT7920_FIRMWARE_WM);
-MODULE_FIRMWARE(MT7920_ROM_PATCH);
 MODULE_FIRMWARE(MT7902_FIRMWARE_WM);
 MODULE_FIRMWARE(MT7902_ROM_PATCH);
-MODULE_FIRMWARE(MT7922_FIRMWARE_WM);
-MODULE_FIRMWARE(MT7922_ROM_PATCH);
 MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_DESCRIPTION("MediaTek MT7902E (PCIe) wireless driver");
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index e0359d431..07305988f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -40,11 +40,13 @@
 #define MT792x_MCU_INIT_RETRY_COUNT	10
 #define MT792x_WFSYS_INIT_RETRY_COUNT	2
 
+#define MT7902_FIRMWARE_WM      "mediatek/WIFI_RAM_CODE_MT7902_1.bin"
 #define MT7920_FIRMWARE_WM	"mediatek/WIFI_RAM_CODE_MT7961_1a.bin"
 #define MT7921_FIRMWARE_WM	"mediatek/WIFI_RAM_CODE_MT7961_1.bin"
 #define MT7922_FIRMWARE_WM	"mediatek/WIFI_RAM_CODE_MT7922_1.bin"
 #define MT7925_FIRMWARE_WM	"mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin"
 
+#define MT7902_ROM_PATCH	"mediatek/WIFI_MT7902_patch_mcu_1_1_hdr.bin"
 #define MT7920_ROM_PATCH	"mediatek/WIFI_MT7961_patch_mcu_1a_2_hdr.bin"
 #define MT7921_ROM_PATCH	"mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin"
 #define MT7922_ROM_PATCH	"mediatek/WIFI_MT7922_patch_mcu_1_1_hdr.bin"
@@ -446,6 +448,8 @@ void mt792x_config_mac_addr_list(struct mt792x_dev *dev);
 static inline char *mt792x_ram_name(struct mt792x_dev *dev)
 {
 	switch (mt76_chip(&dev->mt76)) {
+	case 0x7902:
+		return MT7902_FIRMWARE_WM;
 	case 0x7920:
 		return MT7920_FIRMWARE_WM;
 	case 0x7922:
@@ -460,6 +464,8 @@ static inline char *mt792x_ram_name(struct mt792x_dev *dev)
 static inline char *mt792x_patch_name(struct mt792x_dev *dev)
 {
 	switch (mt76_chip(&dev->mt76)) {
+	case 0x7902:
+		return MT7902_ROM_PATCH;
 	case 0x7920:
 		return MT7920_ROM_PATCH;
 	case 0x7922:
-- 
2.39.5


