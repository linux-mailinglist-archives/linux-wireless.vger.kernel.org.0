Return-Path: <linux-wireless+bounces-28460-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D9EC2862F
	for <lists+linux-wireless@lfdr.de>; Sat, 01 Nov 2025 20:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 05EA84E576B
	for <lists+linux-wireless@lfdr.de>; Sat,  1 Nov 2025 19:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6702586C9;
	Sat,  1 Nov 2025 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZWwfkgTg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E171990C7
	for <linux-wireless@vger.kernel.org>; Sat,  1 Nov 2025 19:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762024983; cv=none; b=B53NVkc1SjGgGwTa6yvk6QN3kxBZyBgYGRxiE8ivRL4dtoSz6LfvMZFEb8xNkv3phnkn31YXmaE//uHoSRd5DJ8QwxnXLnheHf+z1R1xqJ0DBCpvhJE6yS2QMJPJy5kg6Kk/foYMuRbtKSV/v5IZoVYhB1Wb8DbFvLvfiZ1Q6Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762024983; c=relaxed/simple;
	bh=fNUpOYMdtfq58QTrQPK6+ao7+Cg9EciIaZiPtFfbamE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=d2xHKm9CKqhMNLyjAFsLPQXCFoXjlDlgvcu8ONjdN7492Mvnvpic/OTI6e/fw6BRQGODx8jbZ+iyyg5/8OZnlfB+e7rsbBoHRqZgo493qDxIB+4l0/gj4mBp3bSh/N+tFz4k1JCis3cwhkIiwx5XzDRuFoZ7WickoDiXpQMZee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZWwfkgTg; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47710acf715so15727435e9.1
        for <linux-wireless@vger.kernel.org>; Sat, 01 Nov 2025 12:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762024978; x=1762629778; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SomoDcUqdR6RRjKmqsanNWJSMyTy8R1ZzU6yBNKeWjA=;
        b=ZWwfkgTge5fxNJbhzQHneUDtAc+aYSKjYP2PekB0FfBk1Z/E5u6IZBVxA4+P9oR2dM
         3pnVF3UhgwUKXibx1qhdl3aET//+H+qQ6uFOMC9BlKzPx6sxqfZDMldG2q6TbOUvGn1H
         nAaQbrbVxLSkhX23YOp0kbOZKfrBywGlLJv0VSBdy4AzG5XJy6rW3y+01kNKoCky10ql
         zD4Z8QMPJfdE4wmD49HpxRGtzZmM9Fsff19Fn/Ebq3yAHC1o3xOp+xwIFgjPdIdLSuXO
         kagMBQo8iok25e8dZlZR+3ikDxFYEbCE8SHM/6xSP0rtif0yu/yEvYZaqwydPvLltZ5A
         gDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762024978; x=1762629778;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SomoDcUqdR6RRjKmqsanNWJSMyTy8R1ZzU6yBNKeWjA=;
        b=nRCP4mdDm2J/QBPG4TkdLSskv55/QUg+b+4xtodK2KpYyk68Wxad7HOuiIbKRfswXX
         Vbv1QbzPhn8PdEjfbMp0ab4YgiAAPRy4ghH7aWLXzrmgl95+L7U9afUBG6Gevx6TGkAr
         ItouGYI3K0YcYtqS6xnhN/jhLN1HllzEUnTn+d3VW1S9yO6qkPX1f2f0+7rKVeDAfBVk
         kQLYifXkF+V/FQriLhCDh/96MVuOinntrKkWx+wtJO6D1idjQ8zO1gOL4RARxfaWhtPf
         y/VOf8sVObKpzGG917TznjRmvlyQ9EKHu+jgMvp3MsoVi4If+JLYHFEsnjFIxK13QZ02
         NOuQ==
X-Gm-Message-State: AOJu0YwUJLYzbRVsvvW5c78fnk6tqtVRcZipzpiNz/A2I3C6sAs+RrV2
	C5t3eDHsTxnZzO79T+PcxJieOMBu15c48b7Txou2PnwdWa4AeLpUCK+Pf/lGNQ==
X-Gm-Gg: ASbGncvBQ5S980hSgq5n10BlHVsNDydzr/0JSaEIGZFV4NH63Xxl89Y4g+OPn/aUWjy
	9R0j9uGk9t2/dpnwv7JCfEac8hGNiacxGhBp0n2ZVWct/PXK0TJTBeIZ7sJMDeZVvnnfugeLJ9U
	9bCzlkT4JMoiw/x7CnbyIJKKmtmm4XotfsxtcNVFLofohiR53Ps/iUG9MA6NGW70wguXF7aLWEZ
	A+r6BmUglnmvZJY0VDNBuSD5+uv4a7D+epmY7o1ooWZx9qf49bTp1EE7QZBLy4wo8F/QzZbmMZW
	37tnQDjIwpAIs1bbl3GUV0apscdK/Xp9E4hOdn3QPdowyU3ZIPFCtpGLCzqhlNAmgjP7NcHCOtY
	a9w7+BYzOjZ7fRAPKJ15yYRTkM2qltmBlOAio75yoC5yvM29DQP3o8nvlaIlxY4z4QBepzxVbgw
	tBjI/VLIDSQ6+VQEZtcNE=
X-Google-Smtp-Source: AGHT+IFrdAjrXrJJgmg6971hRJKB5u9Os4Sic7xyf5bEPWkikSrL4ImucgQgVwESE/Q1Zh8y73eIeg==
X-Received: by 2002:a05:600c:c4a7:b0:475:de81:563a with SMTP id 5b1f17b1804b1-477308b22a2mr72507985e9.33.1762024977659;
        Sat, 01 Nov 2025 12:22:57 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c383b75sm73774605e9.11.2025.11.01.12.22.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Nov 2025 12:22:57 -0700 (PDT)
Message-ID: <36b823c9-2cb5-4191-8492-2a291f9dc1db@gmail.com>
Date: Sat, 1 Nov 2025 21:22:56 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v4 04/12] wifi: rtw89: usb: Prepare
 rtw89_usb_ops_mac_pre_init() for RTL8852CU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Language: en-US
In-Reply-To: <1d0b14ff-333c-462e-a420-ce6bdf298fe6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The registers used in rtw89_usb_ops_mac_pre_init() are located at
different offsets in RTL8852CU, so move them to struct rtw89_usb_info,
which is filled in each chip's driver.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Acked-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - No change, messed up sending v1.

v3:
 - Move the registers to struct rtw89_usb_info instead of extending
   rtw89_usb_ops_mac_pre_init().

v4:
 - Add Acked-by.
---
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c |  4 ++++
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c |  4 ++++
 drivers/net/wireless/realtek/rtw89/usb.c       | 13 ++++++++-----
 drivers/net/wireless/realtek/rtw89/usb.h       |  3 +++
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
index c39acbec12a9..9cc682872d24 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
@@ -5,9 +5,13 @@
 #include <linux/module.h>
 #include <linux/usb.h>
 #include "rtw8851b.h"
+#include "reg.h"
 #include "usb.h"
 
 static const struct rtw89_usb_info rtw8851b_usb_info = {
+	.usb_host_request_2		= R_AX_USB_HOST_REQUEST_2,
+	.usb_wlan0_1			= R_AX_USB_WLAN0_1,
+	.hci_func_en			= R_AX_HCI_FUNC_EN,
 	.bulkout_id = {
 		[RTW89_DMA_ACH0] = 3,
 		[RTW89_DMA_ACH1] = 4,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
index 28e69473918e..b913cae95e3b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bu.c
@@ -5,9 +5,13 @@
 #include <linux/module.h>
 #include <linux/usb.h>
 #include "rtw8852b.h"
+#include "reg.h"
 #include "usb.h"
 
 static const struct rtw89_usb_info rtw8852b_usb_info = {
+	.usb_host_request_2		= R_AX_USB_HOST_REQUEST_2,
+	.usb_wlan0_1			= R_AX_USB_WLAN0_1,
+	.hci_func_en			= R_AX_HCI_FUNC_EN,
 	.bulkout_id = {
 		[RTW89_DMA_ACH0] = 3,
 		[RTW89_DMA_ACH1] = 4,
diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 8c0129d54b6c..ea1d8726ec3f 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -678,20 +678,23 @@ static int rtw89_usb_ops_deinit(struct rtw89_dev *rtwdev)
 
 static int rtw89_usb_ops_mac_pre_init(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
+	const struct rtw89_usb_info *info = rtwusb->info;
 	u32 val32;
 
-	rtw89_write32_set(rtwdev, R_AX_USB_HOST_REQUEST_2, B_AX_R_USBIO_MODE);
+	rtw89_write32_set(rtwdev, info->usb_host_request_2,
+			  B_AX_R_USBIO_MODE);
 
 	/* fix USB IO hang suggest by chihhanli@realtek.com */
-	rtw89_write32_clr(rtwdev, R_AX_USB_WLAN0_1,
+	rtw89_write32_clr(rtwdev, info->usb_wlan0_1,
 			  B_AX_USBRX_RST | B_AX_USBTX_RST);
 
-	val32 = rtw89_read32(rtwdev, R_AX_HCI_FUNC_EN);
+	val32 = rtw89_read32(rtwdev, info->hci_func_en);
 	val32 &= ~(B_AX_HCI_RXDMA_EN | B_AX_HCI_TXDMA_EN);
-	rtw89_write32(rtwdev, R_AX_HCI_FUNC_EN, val32);
+	rtw89_write32(rtwdev, info->hci_func_en, val32);
 
 	val32 |= B_AX_HCI_RXDMA_EN | B_AX_HCI_TXDMA_EN;
-	rtw89_write32(rtwdev, R_AX_HCI_FUNC_EN, val32);
+	rtw89_write32(rtwdev, info->hci_func_en, val32);
 	/* fix USB TRX hang suggest by chihhanli@realtek.com */
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/usb.h b/drivers/net/wireless/realtek/rtw89/usb.h
index a27c698a424c..be3a9fbe42c0 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.h
+++ b/drivers/net/wireless/realtek/rtw89/usb.h
@@ -21,6 +21,9 @@
 #define RTW89_MAX_BULKOUT_NUM		7
 
 struct rtw89_usb_info {
+	u32 usb_host_request_2;
+	u32 usb_wlan0_1;
+	u32 hci_func_en;
 	u8 bulkout_id[RTW89_DMA_CH_NUM];
 };
 
-- 
2.51.1


