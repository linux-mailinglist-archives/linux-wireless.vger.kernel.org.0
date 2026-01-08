Return-Path: <linux-wireless+bounces-30554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F2ED03E6B
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BE4A4301CB75
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C6749849E;
	Thu,  8 Jan 2026 12:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="bQ0RDUek"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825F4498493
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873858; cv=none; b=nmTR6gLd4XOGwryvMj8CG/x/o5NBnhlF28ae7F+7qS5s6KWL0hPI2b+2xE9SZF+jT6V4QAut7iF/eR5hyhO3D+Bp1anwkOTpDwCd84YPfQ/gicRX9KEhdznl6zC1I4TbR3zfvMRwYqqoPWw8OPZRjc6kHV58Q2C3Mj4HO/I9O6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873858; c=relaxed/simple;
	bh=GBiefbcfVonlbwuibSnpoqfWwKd01DOtndP8HGDXnhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ev258VWUGY/90yw27v//Fvr8ACUMivt3Lf3SWhNNVKU+e//ev39pWyrca1ZkRmb4mQin03FCqw7gYbn+jB1VJHBxHAYVE89k490RI9oMNX5uVbFeJbIOaCZeZmeG0R4Gqa7XjNttLMT5AvIO9qPOnyqAe4enGlkJiCIiyt9fTGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=bQ0RDUek; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 608C4CgD4970691, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767873852; bh=rNQTH+tFHa8w+JeglWkl9Rcbg/6Y0Gb5+O3LvzOxsnM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=bQ0RDUek5yBPZGBAN0EoVkpZklIJKV/+1S3Uo7sYOjmCv4C6UfB86j1XE+ZE+WkwC
	 pLtQp9MAZ0x6/QJOdTT/K7bo9tJSN3EQzcixGG2wVIQ4Dw1TdzY0lPryNckOknO+uI
	 4SAaBj+kMpyy4VbYME1TRi+VX93hQgXQn5CuswjylmGbehsSGUCQj2t5Y2+MpxOqjt
	 g8FrwkGq+HZ+CYzyk+ZwpRNtRhgGWWpXZurQ5zFCK0xud8Hq5WlgxL3YVcy93MvE3x
	 /0vnXFpwLICfRf0tnArg1+4HHYdJR9IH98JG58SPNQYrQ69MN7VsAcCoKaenHoj/9D
	 3JxGEXqVOGkbg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 608C4CgD4970691
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 8 Jan 2026 20:04:12 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:04:13 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:04:12 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 8 Jan 2026 20:04:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>
Subject: [PATCH rtw-next 10/13] wifi: rtw89: mac: configure DMA_STOP1 by predefined mask
Date: Thu, 8 Jan 2026 20:03:17 +0800
Message-ID: <20260108120320.2217402-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260108120320.2217402-1-pkshih@realtek.com>
References: <20260108120320.2217402-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

For coming chip 8922DE, the DMA channel set is different from existing one,
so use predefined mask to handle the difference.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac_be.c | 14 +++++++-----
 drivers/net/wireless/realtek/rtw89/pci.h    | 25 ---------------------
 drivers/net/wireless/realtek/rtw89/pci_be.c |  4 ++++
 drivers/net/wireless/realtek/rtw89/reg.h    | 12 ++++++++++
 4 files changed, 24 insertions(+), 31 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 475d941d41a7..a0e5c99abb17 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -365,6 +365,8 @@ static void rtw89_mac_hci_func_en_be(struct rtw89_dev *rtwdev)
 
 static void rtw89_mac_dmac_func_pre_en_be(struct rtw89_dev *rtwdev)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	u32 mask;
 	u32 val;
 
 	val = rtw89_read32(rtwdev, R_BE_HAXI_INIT_CFG1);
@@ -388,12 +390,12 @@ static void rtw89_mac_dmac_func_pre_en_be(struct rtw89_dev *rtwdev)
 
 	rtw89_write32(rtwdev, R_BE_HAXI_INIT_CFG1, val);
 
-	rtw89_write32_clr(rtwdev, R_BE_HAXI_DMA_STOP1,
-			  B_BE_STOP_CH0 | B_BE_STOP_CH1 | B_BE_STOP_CH2 |
-			  B_BE_STOP_CH3 | B_BE_STOP_CH4 | B_BE_STOP_CH5 |
-			  B_BE_STOP_CH6 | B_BE_STOP_CH7 | B_BE_STOP_CH8 |
-			  B_BE_STOP_CH9 | B_BE_STOP_CH10 | B_BE_STOP_CH11 |
-			  B_BE_STOP_CH12 | B_BE_STOP_CH13 | B_BE_STOP_CH14);
+	if (chip->chip_id == RTL8922A)
+		mask = B_BE_TX_STOP1_MASK;
+	else
+		mask = B_BE_TX_STOP1_MASK_V1;
+
+	rtw89_write32_clr(rtwdev, R_BE_HAXI_DMA_STOP1, mask);
 
 	rtw89_write32_set(rtwdev, R_BE_DMAC_TABLE_CTRL, B_BE_DMAC_ADDR_MODE);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 16dfb0e79d77..64c080053fd1 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -767,31 +767,6 @@
 #define R_AX_WP_ADDR_H_SEL8_11 0x133C
 #define R_AX_WP_ADDR_H_SEL12_15 0x1340
 
-#define R_BE_HAXI_DMA_STOP1 0xB010
-#define B_BE_STOP_WPDMA BIT(31)
-#define B_BE_STOP_CH14 BIT(14)
-#define B_BE_STOP_CH13 BIT(13)
-#define B_BE_STOP_CH12 BIT(12)
-#define B_BE_STOP_CH11 BIT(11)
-#define B_BE_STOP_CH10 BIT(10)
-#define B_BE_STOP_CH9 BIT(9)
-#define B_BE_STOP_CH8 BIT(8)
-#define B_BE_STOP_CH7 BIT(7)
-#define B_BE_STOP_CH6 BIT(6)
-#define B_BE_STOP_CH5 BIT(5)
-#define B_BE_STOP_CH4 BIT(4)
-#define B_BE_STOP_CH3 BIT(3)
-#define B_BE_STOP_CH2 BIT(2)
-#define B_BE_STOP_CH1 BIT(1)
-#define B_BE_STOP_CH0 BIT(0)
-#define B_BE_TX_STOP1_MASK (B_BE_STOP_CH0 | B_BE_STOP_CH1 | \
-			    B_BE_STOP_CH2 | B_BE_STOP_CH3 | \
-			    B_BE_STOP_CH4 | B_BE_STOP_CH5 | \
-			    B_BE_STOP_CH6 | B_BE_STOP_CH7 | \
-			    B_BE_STOP_CH8 | B_BE_STOP_CH9 | \
-			    B_BE_STOP_CH10 | B_BE_STOP_CH11 | \
-			    B_BE_STOP_CH12)
-
 #define R_BE_CH0_TXBD_NUM_V1 0xB030
 #define R_BE_CH1_TXBD_NUM_V1 0xB032
 #define R_BE_CH2_TXBD_NUM_V1 0xB034
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 95efb1094b6c..148cce0df058 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -322,6 +322,7 @@ static void rtw89_pci_ser_setting_be(struct rtw89_dev *rtwdev)
 
 static void rtw89_pci_ctrl_txdma_ch_be(struct rtw89_dev *rtwdev, bool enable)
 {
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
 	u32 mask_all;
 	u32 val;
 
@@ -330,6 +331,9 @@ static void rtw89_pci_ctrl_txdma_ch_be(struct rtw89_dev *rtwdev, bool enable)
 		   B_BE_STOP_CH6 | B_BE_STOP_CH7 | B_BE_STOP_CH8 |
 		   B_BE_STOP_CH9 | B_BE_STOP_CH10 | B_BE_STOP_CH11;
 
+	/* mask out unsupported channels for certains chips */
+	mask_all &= info->dma_stop1.mask;
+
 	val = rtw89_read32(rtwdev, R_BE_HAXI_DMA_STOP1);
 	val |= B_BE_STOP_CH13 | B_BE_STOP_CH14;
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 79c976c25de5..bfb1ebcc9fc2 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -6065,6 +6065,18 @@
 #define B_BE_STOP_CH2 BIT(2)
 #define B_BE_STOP_CH1 BIT(1)
 #define B_BE_STOP_CH0 BIT(0)
+#define B_BE_TX_STOP1_MASK (B_BE_STOP_CH0 | B_BE_STOP_CH1 | \
+			    B_BE_STOP_CH2 | B_BE_STOP_CH3 | \
+			    B_BE_STOP_CH4 | B_BE_STOP_CH5 | \
+			    B_BE_STOP_CH6 | B_BE_STOP_CH7 | \
+			    B_BE_STOP_CH8 | B_BE_STOP_CH9 | \
+			    B_BE_STOP_CH10 | B_BE_STOP_CH11 | \
+			    B_BE_STOP_CH12 | B_BE_STOP_CH13 | \
+			    B_BE_STOP_CH14)
+#define B_BE_TX_STOP1_MASK_V1 (B_BE_STOP_CH0 | B_BE_STOP_CH2 | \
+			       B_BE_STOP_CH4 | B_BE_STOP_CH6 | \
+			       B_BE_STOP_CH8 | B_BE_STOP_CH10 | \
+			       B_BE_STOP_CH12)
 
 #define R_BE_HAXI_MST_WDT_TIMEOUT_SEL_V1 0xB02C
 #define B_BE_HAXI_MST_WDT_TIMEOUT_SEL_MASK GENMASK(4, 0)
-- 
2.25.1


