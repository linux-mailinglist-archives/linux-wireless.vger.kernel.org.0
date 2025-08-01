Return-Path: <linux-wireless+bounces-26095-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C7EB18859
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 22:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909ABAA4778
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Aug 2025 20:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D7E2139CE;
	Fri,  1 Aug 2025 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FD8WoG3e"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FA11DE4DC
	for <linux-wireless@vger.kernel.org>; Fri,  1 Aug 2025 20:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754081565; cv=none; b=NNK9elpXws8vs8k5pox9PcNJKMFbUc0B2XHMGaqlq+3/r6dV/HDzTG/B6wEQsgOQqmkaRSgdpU/0qvABkqVmgTV8kOkx44GMNN90T64GUMe7q4AtWRqgA4/N2ogQEIsggF+C9E5RIh05A1qM3jueymCJ7U8uRhY6JGUSmJlIiZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754081565; c=relaxed/simple;
	bh=g0l7Sl5TLvGwkPUOoWmUelUaQ6WV0Ikj6b2QkkLInSg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eGkgLnGzjWPquZG7EAFSfeTEsFITXu72jrYX3uXh1H/qVSH/GWpFIq4wvJjXeJyHacw9b+oJOd62RhhRJhO40SdQwCmFDCM+Joj8tF3NaJbQemGQO4xXf4L7+WdO+Kt6OdwB5Qike1vjzEYRCaFbzZR3/L5o+JQjNtu5Shm9SJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FD8WoG3e; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae3b336e936so281921366b.3
        for <linux-wireless@vger.kernel.org>; Fri, 01 Aug 2025 13:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754081561; x=1754686361; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uB4WBgIHXnHP/LQ6FwLe/vNCCTUIHiKyoLf1XDfzQh0=;
        b=FD8WoG3e2MZKDImV70cf8ZBkEUM03TcwmZhefSPqNnYwEu1pd6RjOKNQHjBP4tZxW3
         hdMibhToR567SWVUiSLjAihVig1OQ1hf+xVxT4M3rp660czP5YDGsLYCHO8/AzqiB33I
         YxhxdPstg8vjG3dKEbEdUhAyPVGyBVWmlUssKy9MUjIXwjaVf4TACpDrAICjZMCwkkTp
         mIZ1K5wyF3B1zD+UKXHaoDVhSIWxHmXvEscxdWEbTkk/A/jTSmiycT9oGP7MtjfLCvsD
         r77PNX0l29/Io0wq9uJ4UddxxsEr0dSLIGPsoJ9ANSrw7A6b6i4J9jzgFdyK+sUYTT3V
         /Esw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754081561; x=1754686361;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uB4WBgIHXnHP/LQ6FwLe/vNCCTUIHiKyoLf1XDfzQh0=;
        b=Qt724v9YoyEh55sORrCsiTnf/CdWBRTUz852Qd6jFyF+41R2B61+jeLXkSaSKU3TWg
         2Tt4x7zIKXXldRXyReUGB3b5xZOcBNW9bjzhIvREDX8HgVCZ37Iw6lme+HFxnmlWiU12
         pm+sewj6DX8wJ/OjwBnEu6dOiAXpE0aEpupWOUab4o3XpRU7hjhW8b/2eIKXim/oQeif
         WUn/hF0VAx0gbSe095jcklMxIbYltM/WWI6IWMO+bT/7lHGOZwtsC8ZEdiyTcTgRTocQ
         13mSSiCh8a6V2otX1e2nuyfTpQdu23KF1rpW/66jNx1XvNqYUsLpTMvUgBaO5hz5SIXG
         rgzA==
X-Gm-Message-State: AOJu0YyVJZ7Z242RGVex1egcF3H1rPEUeBOcO5lX+bD1spDfVk12m5kT
	hg35jBAwRnDq7fNeI86f51ToQcfbN9/qo22thpc0Mod5xVVXxj6DjFV8Qe8ojQ==
X-Gm-Gg: ASbGncvNzt+gY25lx7/fJtpaNAmENFE0ECGOSrDOk+uHt97ySEz4IeZxVCvd4/SjIkH
	sH4xEAtaWML1kWGABTqNWL06JzmHj3g9B524FJOo/pudQbY+ZJzfrNPHAA/0d4FKHlvy886PXHD
	lVDPKekd1F9JuMSebKkkSLEQWYJO1mbGOvH2PIoG2F9dFf5m2V1WTClynlNyev0LDgf0fBslrZb
	9MacEGcd0FLYa63/SLGb9hsMSVOOSVsVtHpip5F1d+PNpK6OzBQTPTDUkpx9LZad6TtnBWd0ShW
	BAQdpY3UNCg1HI0FG0Kcb1bArxPEtIw8STqBmmsreobYNA+5ELELz+au/pEfkImBt+CNjIFbgBq
	+dImzD/cnKdFUCMxwsjmAsbeMAWS69Q==
X-Google-Smtp-Source: AGHT+IETaI2G3i3rK0Kl3v7THBcbhKglGMbM4lYe52p8Mr4d2sHzmpC0x/QuJ6wL9OFNopE67nXcIA==
X-Received: by 2002:a17:907:7f0f:b0:ae0:ded9:7f31 with SMTP id a640c23a62f3a-af94001f8dbmr142629266b.20.1754081560880;
        Fri, 01 Aug 2025 13:52:40 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a078a11sm338809266b.7.2025.08.01.13.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Aug 2025 13:52:40 -0700 (PDT)
Message-ID: <3fcb3d66-4c01-4396-84b1-268bf4f0d2f6@gmail.com>
Date: Fri, 1 Aug 2025 23:52:39 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH rtw-next v2 02/11] wifi: rtw89: usb: Fix
 rtw89_usb_get_bulkout_id() for RTL8852CU
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
Content-Language: en-US
In-Reply-To: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

RTL8852CU can work in two bands at the same time, thus some USB bulk
out endpoints are dedicated to one band, others to the other band.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change, messed up sending v1.
---
 drivers/net/wireless/realtek/rtw89/usb.c | 64 +++++++++++++++++-------
 1 file changed, 46 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
index 6cf89aee252e..eb9978a60d04 100644
--- a/drivers/net/wireless/realtek/rtw89/usb.c
+++ b/drivers/net/wireless/realtek/rtw89/usb.c
@@ -167,24 +167,52 @@ rtw89_usb_ops_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
 	return 42; /* TODO some kind of calculation? */
 }
 
-static u8 rtw89_usb_get_bulkout_id(u8 ch_dma)
+static u8 rtw89_usb_get_bulkout_id(struct rtw89_dev *rtwdev, u8 ch_dma)
 {
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
+	if (rtwdev->chip->chip_id == RTL8852C) {
+		switch (ch_dma) {
+		case RTW89_DMA_ACH0:
+			return 3;
+		case RTW89_DMA_ACH2:
+			return 5;
+		case RTW89_DMA_ACH4:
+			return 4;
+		case RTW89_DMA_ACH6:
+			return 6;
+		default:
+			rtw89_warn(rtwdev, "unexpected TX channel %d\n",
+				   ch_dma);
+			fallthrough;
+		case RTW89_DMA_B0MG:
+		case RTW89_DMA_B0HI:
+			return 0;
+		case RTW89_DMA_B1MG:
+		case RTW89_DMA_B1HI:
+			return 1;
+		case RTW89_DMA_H2C:
+			return 2;
+		}
+	} else {
+		switch (ch_dma) {
+		case RTW89_DMA_ACH0:
+			return 3;
+		case RTW89_DMA_ACH1:
+			return 4;
+		case RTW89_DMA_ACH2:
+			return 5;
+		case RTW89_DMA_ACH3:
+			return 6;
+		default:
+			rtw89_warn(rtwdev, "unexpected TX channel %d\n",
+				   ch_dma);
+			fallthrough;
+		case RTW89_DMA_B0MG:
+			return 0;
+		case RTW89_DMA_B0HI:
+			return 1;
+		case RTW89_DMA_H2C:
+			return 2;
+		}
 	}
 }
 
@@ -251,7 +279,7 @@ static int rtw89_usb_write_port(struct rtw89_dev *rtwdev, u8 ch_dma,
 	struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
 	struct usb_device *usbd = rtwusb->udev;
 	struct urb *urb;
-	u8 bulkout_id = rtw89_usb_get_bulkout_id(ch_dma);
+	u8 bulkout_id = rtw89_usb_get_bulkout_id(rtwdev, ch_dma);
 	unsigned int pipe;
 	int ret;
 
-- 
2.50.0


