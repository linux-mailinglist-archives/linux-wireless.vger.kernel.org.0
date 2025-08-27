Return-Path: <linux-wireless+bounces-26710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB3BB38807
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 18:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282C298069B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 16:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3019D28137A;
	Wed, 27 Aug 2025 16:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWTdArvd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A272773C1
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 16:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756313464; cv=none; b=PkryDYVWfd+k58U6NczEc/Fxrva9S1a9B1BR/wr14ZnVlkkylnfNRooM2RP57/v4fgwB+A7/u3mku1fuDg0FxTH/zddi7w8p5+sg+pkM4R7MHj7mQbIjGNCQ/1VLA2pV2fr/vtyf0X72zaTfutnkVDnpSqX8S4QaMo/niJmz+yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756313464; c=relaxed/simple;
	bh=z+IOaSlqcPB6WR+v9862RfzdiDIUV3P9+K0l3FdxqAs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=AGG0/GlLu+HhV3wgvcPIFiGClvWHarHS/9ycam9eUKC3lB96HDeGFcI+vwQ2seCybkipajoPZfswXSuIR+ZdIHnMWBOKNAkFZax6aAU/XmE1S8iHUQnJk2PwhTYeW4nr4AA5UtLFxOeuCd3pUjHF9FlNFjKX+VC7yeoESGaPu0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWTdArvd; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b0c8867so58291125e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 09:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756313461; x=1756918261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+dhr32P5KzMklFgDf5GcPx+2WRa07Q+C32PGORF7XFQ=;
        b=dWTdArvdDjQkm7vE4sUPR0llXga6Uf+dmnoSFuQnpi80d7YF9hVRXzz9ePgvqPfGaX
         iin02kyysw0YuM5eXbgCmaxNjgx8ap7+8wDh3MSvP+3uQvRq67JiqQHzS7vF87FbW7Y4
         a0yV/qRKLmfIjQ2/m55CkJ9YwqIMk64kgF7Tw6y2w2L1dXj9AnC/Fn8v9gPUqfK47ZIG
         xpeAT8LLnhuQOXopvMBl1BiXHUWNcBVX57FuA/zV+oMSyDbiy9UqXnxizr2RtVGB02Qm
         KGxr4obuSY86Tk25iRwkgBZ0qfFstjjlTzjTvX2lTnn2yxk1JJaVh16/s5lUvVIuLz2x
         uFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756313461; x=1756918261;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dhr32P5KzMklFgDf5GcPx+2WRa07Q+C32PGORF7XFQ=;
        b=Fef5PkMdx/ffTDLgr5nEyrs7hy5nEvPC2pUWppGmGmw5/nIupYGmPR1oX4/Ugb+IdI
         1KVd9p3GvLvAOQGzvKtB8lQGY40iModu9+CaF8G4JAWvfSJMokkw0FcplpDCWeTwKsrg
         8b2wnfXI35YfchkvSYAIiXLNbQtVPpm2YuQZLZK2AI2roS1vUAQ/0WhIxcmIekqtNwaw
         AzlWffRgkQvu9IPvBp/kBHHDrXsQB2ouR7rLtpukkhmst1g+G9xmbfcrEHbeKXTLyRpM
         XkpnPleG4qLKja7umZEA5gVsFy+t4aLpWUo/AiV2KscM4Epmk0S01WIqy4Uhhre9Y8WZ
         Dxcg==
X-Gm-Message-State: AOJu0YwdzGSoZOynNtT5iqVrj+LPJ27KO+bpBhrdeNNvDq/OnYMqe5xE
	sN0oB2exi5f9JQYlsvWlJWu+h9QDDpIdsNIIvjUfNTRdwurEPI/PH6Qu9qVcmg==
X-Gm-Gg: ASbGncu2djdCiaBRJazq1M86mbTJ0arbaAR5r7d9FKIydkcMUh6Ec8I7kUftXJwqcZM
	dvmZs2JGmMd0LcLzi8MlBy+Q7KbPQnzHvyA4gk5PHUReUN4Jufv/jfFLp3ZLHFnX7soN4ifJPLU
	KT2PLLk+1JHkSkR2dWUpA3/oGebIFSWliVcn1/trHwpa2w/xL2dCDfoWh0X31jOrv7JC6aM9ax+
	2xZ0k2DGsC5KUBhZzi17gX2eSF//aIzbNksmVDn7kKT9cCRXlxr/HqdLwF7PPrXIJdrCWr97nRL
	BCmrtLbcvBxuGj0PwSkXUfqN/uGLRrN5wGgNRQwtmpBPwmVaHyNgZXawFVJJhFA0EbFiX+HcbGY
	8Op/W9oHJ8MLRpeALefGGuM2TDbPkIA==
X-Google-Smtp-Source: AGHT+IHmKf3vCitcjfAbahOvbPIed55w+IeNEacAB/z8XfjNBn+3Kt9zTx18Zdl7SA6yGMrpqwQZGA==
X-Received: by 2002:a05:6000:2dc8:b0:3ca:2978:1062 with SMTP id ffacd0b85a97d-3ca29781466mr8145639f8f.15.1756313460550;
        Wed, 27 Aug 2025 09:51:00 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cd83ee224fsm968415f8f.57.2025.08.27.09.50.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Aug 2025 09:51:00 -0700 (PDT)
Message-ID: <95a0f788-e80e-4864-b07d-02d4cb721763@gmail.com>
Date: Wed, 27 Aug 2025 19:50:58 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v3 03/11] wifi: rtw89: usb: Prepare
 rtw89_usb_ops_mac_pre_init() for RTL8852CU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Language: en-US
In-Reply-To: <fac0abab-2334-4ae2-9a80-f3fd7808e392@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The registers used in rtw89_usb_ops_mac_pre_init() are located at
different offsets in RTL8852CU, so move them to struct rtw89_usb_info,
which is filled in each chip's driver.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change, messed up sending v1.

v3:
 - Move the registers to struct rtw89_usb_info instead of extending
   rtw89_usb_ops_mac_pre_init().
---
 drivers/net/wireless/realtek/rtw89/rtw8851bu.c |  4 ++++
 drivers/net/wireless/realtek/rtw89/rtw8852bu.c |  4 ++++
 drivers/net/wireless/realtek/rtw89/usb.c       | 13 ++++++++-----
 drivers/net/wireless/realtek/rtw89/usb.h       |  3 +++
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
index 95b8fb1a6425..3fcab1d94208 100644
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
index 62fccf441c10..5c91e123672a 100644
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
index 3b1ed87e706b..a3769b91bc1f 100644
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
2.50.1


