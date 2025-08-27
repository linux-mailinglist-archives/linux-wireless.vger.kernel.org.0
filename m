Return-Path: <linux-wireless+bounces-26709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DD8B38802
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 18:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325A04645DF
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 16:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3232323E340;
	Wed, 27 Aug 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffvLiTOX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C3F22E004
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313378; cv=none; b=i0iId0PrK5agTO1Gqvo0lGIiPN3XEZH7e4xQRyRgw1yCXctjci85JPSJ0yHZjoDnyWWppNTRndxnCagGwBK/VR5J2kK+LsMyQpD9sown0951w1J3pmynLcNRuOU5WAHW2222PYB9dLZxsHq/2wLxsdmcUe3eFZc6jftdgoWWMag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313378; c=relaxed/simple;
	bh=P2kXU/K7w6S2TLUg5fp3iVMnk7XIKSzkaPvYQH9LWPo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YPJmi2RpLC2B0G7VXeYbfVD6UttAYIWFnq++2F1EbG3mhQmj2ei2ouBo2bipVlZBNHDake21w9YYGEPC3mm9ESXA+H6LflvAJZztTdq7/rFnILusLqNgGM8sFm8hPpbNQ9gf+5dnj8iln1U/VvUVKeOExrnaEqXYqLjyDad3nTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffvLiTOX; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45b6b5ccad6so7286065e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 09:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756313374; x=1756918174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JNN+E7tpaR3x4499UY/wZUdMgULNzXPU2/DCZGiDUcQ=;
        b=ffvLiTOXT82fwUlIkzmIGLYsieGggGSDPOApJUdG680UKVSPl63vfqMAxJ1jmZmyPh
         FN4yz0Ln5ePjINtVf1dUZX66EFjQvRAUnhDqi6hsUbJrA659JfooOjtCilNlHn4v93qG
         IWopbXlZjLUtO5D0Nyr+imk+UVk89tf0S3X07yJDRPkIbJK1ltJjrO73dqe+1FM9y1rx
         CrsI/SVnPj77frTCkucUiOuN+zhsf08QsIvUH9K96kKb8OlcjTUiZy4NPGpNX0KybqlN
         dlaRAz3emtd0PP2KWhHVogcXG0QajyvP7ptzbgzCyLCSzhwQdzc+KmvSh35GMhGpjxdR
         N62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756313374; x=1756918174;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNN+E7tpaR3x4499UY/wZUdMgULNzXPU2/DCZGiDUcQ=;
        b=DmiEDzEpsvnZwbfOkQKVGOpxOUlXk9X5FTARgjsjE0Ep1t7Jr62oKwPekQy9vxq8CO
         THOiVTdKD3hw/jqJQOWNFVrTrJNYhJLkm0h9y/K4WfqgkomNmsHYhZlOaBGAOeMm+wGr
         fRSjKSyiAuK2BrdGgat+X8IRc9qX1bz+mQcrjSn/hfNXhhTFd0zIULD2qJHQmjGJPUSF
         Ds6/tgBroQxSK2C13upPocfrOozuLDMrF6v9CUyR5ePc18bBT2cPPyCyKDZHbZJg4LsY
         TB7+SkrGkHijpMqoP+7rkQYvhZGcJQ9kzhCUVrAbD3V1TED5oGo+9mjgdWhPWC2mAN1j
         lOjg==
X-Gm-Message-State: AOJu0YzC5vgnKtSOas4i6Da0QCJyfSvNnv67KyL4ORDze6u8BGGVyLm7
	+Qp2up3r3Tlpnb3UWtPK8i5VOHPM1SG8GL5yr99FANJ6wRvuRS3tdOXO2WzirQ==
X-Gm-Gg: ASbGnctlKMLMCCRTahzx1ozWZ3ZO/YR+sXmS/LOCNfa6I72zKgcTVh7C9wTjFQf6WOr
	FDeeSXkYl95qrB414oNGRwyd8mtvEN6l2o/lOoDZn+66LTBd1mekmJ0HK6MGArITr4qk8BjOiTb
	IyHWpqxXRqZ+nYYWBGKGR1Gb3eUkg4vH2+jDPLXsZdO0NLjPDIdLM+fIx1NAxQvmjN4xUJdNpSh
	3djFc5mN4pPPvGH4snhjnFLoRsBdeJy1FRENkVhKpDltFiNi0lDjySxiicQx3a6KR0s9H+OyZYd
	w8R5HEzcEN3rnbTEm/sGYVZIbueN51W7zTyRFeAtAwzg+fbsyXidFgZLHsIDiPB4F8xF6i0GTMs
	X+hibOVRMlQI012KtxMllGViQAmaqVQ==
X-Google-Smtp-Source: AGHT+IGkn81jp0ZK/vAlEbDHkQqyn7WsxMii/a0bVqik4lUIU05MoU/a0LlLVggJfcLtfRhQCUAOLQ==
X-Received: by 2002:a05:600c:45d4:b0:459:e3a1:a0c4 with SMTP id 5b1f17b1804b1-45b517d27b2mr198810385e9.30.1756313374437;
        Wed, 27 Aug 2025 09:49:34 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cb901975adsm7381910f8f.8.2025.08.27.09.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 09:49:34 -0700 (PDT)
Message-ID: <9e4a9bca-1ec0-441b-9743-0759b6bda26e@gmail.com>
Date: Wed, 27 Aug 2025 19:49:32 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 02/11] wifi: rtw89: usb: Move bulk out map to new
 struct rtw89_usb_info
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Language: en-US
In-Reply-To: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8852AU, RTL8852CU, and RTL8922AU will need a different TX channel
to bulk out endpoint mapping, so create a new struct rtw89_usb_info
and move the mapping there. Initialise it in each chip's driver.

Struct rtw89_usb_info will also hold some registers which are located
at different offsets in RTL8852CU compared to the other wifi 6 chips.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change, messed up sending v1.

v3:
 - Move the bulk out map to the new struct rtw89_usb_info instead of
   adding the new mapping to rtw89_usb_get_bulkout_id().
---
 drivers/net/wireless/realtek/rtw89/core.h     |  2 ++
 .../net/wireless/realtek/rtw89/rtw8851bu.c    | 15 +++++++++++
 .../net/wireless/realtek/rtw89/rtw8852bu.c    | 15 +++++++++++
 drivers/net/wireless/realtek/rtw89/usb.c      | 25 +++----------------
 drivers/net/wireless/realtek/rtw89/usb.h      |  5 ++++
 5 files changed, 40 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ff3362d1f602..779b6fa87824 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -15,6 +15,7 @@
 
 struct rtw89_dev;
 struct rtw89_pci_info;
+struct rtw89_usb_info;
 struct rtw89_mac_gen_def;
 struct rtw89_phy_gen_def;
 struct rtw89_fw_blacklist;
@@ -4510,6 +4511,7 @@ struct rtw89_chip_variant {
 
 union rtw89_bus_info {
 	const struct rtw89_pci_info *pci;
+	const struct rtw89_usb_info *usb;
 };
 
 struct rtw89_driver_info {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
index c3722547c6b0..95b8fb1a6425 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
@@ -7,10 +7,25 @@
 #include "rtw8851b.h"
 #include "usb.h"
 
+static const struct rtw89_usb_info rtw8851b_usb_info = {
+	.bulkout_id = {
+		[RTW89_DMA_ACH0] = 3,
+		[RTW89_DMA_ACH1] = 4,
+		[RTW89_DMA_ACH2] = 5,
+		[RTW89_DMA_ACH3] = 6,
+		[RTW89_DMA_B0MG] = 0,
+		[RTW89_DMA_B0HI] = 1,
+		[RTW89_DMA_H2C] = 2,
+	},
+};
+
 static const struct rtw89_driver_info rtw89_8851bu_info = {
 	.chip = &rtw8851b_chip_info,
 	.variant = NULL,
 	.quirks = NULL,
+	.bus = {
+		.usb = &rtw8851b_usb_info,
+	}
 };
 
 static const struct usb_device_id rtw_8851bu_id_table[] = {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
index b315cb997758..62fccf441c10 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
@@ -7,10 +7,25 @@
 #include "rtw8852b.h"
 #include "usb.h"
 
+static const struct rtw89_usb_info rtw8852b_usb_info = {
+	.bulkout_id = {
+		[RTW89_DMA_ACH0] = 3,
+		[RTW89_DMA_ACH1] = 4,
+		[RTW89_DMA_ACH2] = 5,
+		[RTW89_DMA_ACH3] = 6,
+		[RTW89_DMA_B0MG] = 0,
+		[RTW89_DMA_B0HI] = 1,
+		[RTW89_DMA_H2C] = 2,
+	},
+};
+
 static const struct rtw89_driver_info rtw89_8852bu_info = {
 	.chip = &rtw8852b_chip_info,
 	.variant = NULL,
 	.quirks = NULL,
+	.bus = {
+		.usb = &rtw8852b_usb_info,
+	}
 };
 
 static const struct usb_device_id rtw_8852bu_id_table[] = {
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 6cf89aee252e..3b1ed87e706b 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -167,27 +167,6 @@ rtw89_usb_ops_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
 	return 42; /* TODO some kind of calculation? */
 }
 
-static u8 rtw89_usb_get_bulkout_id(u8 ch_dma)
-{
-	switch (ch_dma) {
-	case RTW89_DMA_ACH0:
-		return 3;
-	case RTW89_DMA_ACH1:
-		return 4;
-	case RTW89_DMA_ACH2:
-		return 5;
-	case RTW89_DMA_ACH3:
-		return 6;
-	default:
-	case RTW89_DMA_B0MG:
-		return 0;
-	case RTW89_DMA_B0HI:
-		return 1;
-	case RTW89_DMA_H2C:
-		return 2;
-	}
-}
-
 static void rtw89_usb_write_port_complete(struct urb *urb)
 {
 	struct rtw89_usb_tx_ctrl_block *txcb = urb->context;
@@ -249,9 +228,10 @@ static int rtw89_usb_write_port(struct rtw89_dev *rtwdev, u8 ch_dma,
 				void *data, int len, void *context)
 {
 	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+	const struct rtw89_usb_info *info = rtwusb->info;
 	struct usb_device *usbd = rtwusb->udev;
 	struct urb *urb;
-	u8 bulkout_id = rtw89_usb_get_bulkout_id(ch_dma);
+	u8 bulkout_id = info->bulkout_id[ch_dma];
 	unsigned int pipe;
 	int ret;
 
@@ -949,6 +929,7 @@ int rtw89_usb_probe(struct usb_interface *intf,
 
 	rtwusb = rtw89_usb_priv(rtwdev);
 	rtwusb->rtwdev = rtwdev;
+	rtwusb->info = info->bus.usb;
 
 	rtwdev->hci.ops = &rtw89_usb_ops;
 	rtwdev->hci.type = RTW89_HCI_TYPE_USB;
diff --git a/drivers/net/wireless/realtek/rtw89/usb.h b/drivers/net/wireless/realtek/rtw89/usb.h
index c1b4bfa20979..a27c698a424c 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.h
+++ b/drivers/net/wireless/realtek/rtw89/usb.h
@@ -20,6 +20,10 @@
 #define RTW89_MAX_ENDPOINT_NUM		9
 #define RTW89_MAX_BULKOUT_NUM		7
 
+struct rtw89_usb_info {
+	u8 bulkout_id[RTW89_DMA_CH_NUM];
+};
+
 struct rtw89_usb_rx_ctrl_block {
 	struct rtw89_dev *rtwdev;
 	struct urb *rx_urb;
@@ -35,6 +39,7 @@ struct rtw89_usb_tx_ctrl_block {
 struct rtw89_usb {
 	struct rtw89_dev *rtwdev;
 	struct usb_device *udev;
+	const struct rtw89_usb_info *info;
 
 	__le32 *vendor_req_buf;
 
-- 
2.50.1


