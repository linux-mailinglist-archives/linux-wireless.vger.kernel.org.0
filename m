Return-Path: <linux-wireless+bounces-10872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAD8946515
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 23:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B07F1C20A00
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Aug 2024 21:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D28D481AB;
	Fri,  2 Aug 2024 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJKIkSUT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DCC1396
	for <linux-wireless@vger.kernel.org>; Fri,  2 Aug 2024 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722634322; cv=none; b=tdup02dgaRadw6FuSkYLGH7WYzFkHuHd7WruS386Gs3LRuBzhSmkd23CXvZIb3+UY9uOKIyV5HqLQYgO4qiPtzGHT3gyJoI2a01GILV/EQf7lm0iBAG3wcucnNasLiOCf7vv8FgOsn7c934RvyrvPg0+0oZPBswmR5+pzbtKaho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722634322; c=relaxed/simple;
	bh=HGx0O530dOwW5rZ+E8m7ukZZEOTOmkvWNaZiTvPZgUE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=fUxAcQx67gBjax7GHlwmDbuRKmGkkNQ1Ih3rl/QE+rsWITWnggBFBEuEwV/5szUhSC1Ss9jP7BxwqpH8L4U6yb31T5OQqR3xL8NbXV3Md5l3qjIF/7m2pjHU2H3GSwjmsx9dvcx/521CEW/3n+3hrDp/Ibc0Azv4NLi78PE/dNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJKIkSUT; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5b01af9b0c9so7735230a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 02 Aug 2024 14:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722634319; x=1723239119; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tz8UoTjHqnqY2V9WFS5GkOnrSV2Z/tdKX0vgvebcn3c=;
        b=gJKIkSUTPlSG5huXId560+55SygjU98S0mjpNuOsnveGedceSxmOVPh4zG1zB9FLbl
         TpNFyrd+MlvM2vsNWOZ8Mp7ITllrBH1gzDqZvw/NJIm4+5dgrXR50shiOdEwLpzKxFlR
         2Hi/J9P2+1tcwRIhIsDfG2SIsL22ToVYexhUZNkicoaQqSlp+wG/OQhZ1eO1Cm0LaV90
         YTWL0DYGvV+8Hbi1Dz9QxY6MCRPJQalKAAz/7Tv0NHFafBSGT515naL8nXE8/mkrFoP/
         W/BndRNoPQ9B3pWM2JF/faArzLxU6fss5B0xUWdExOh4G5LaEwQW5Xs9AwyYV7wVaTiM
         TNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722634319; x=1723239119;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tz8UoTjHqnqY2V9WFS5GkOnrSV2Z/tdKX0vgvebcn3c=;
        b=ToHyiafgpYVDO5+Q7tYX/l40zxbqZXFWG5cmso5hpFGrlbRU/QuPBRDD5KaWwrjadc
         H+ZQec1fUYOuDrEJNSUDAleFakWpd8eLgMeQpeWFS00RCACRpFzvEQ697udZPNgrrJIU
         oYnHbcExw95hnTAQACOkkdSliVcFoP4eoV4WLNluQgh5JvtSscV08cxFC6ixTUJlQMxN
         RKBICpKYkUrzQKSxA6gzfKnjdDJkrn07Qw33A1JmJpIMAaKuh5slPAQXptJfd8ImSklX
         upPr1Inzg79u3IfIG5Y4o8bSXBFVn4OviIzUwI9gdVkYJhgMhlaP+ZwL5mX3zQS8Vm2s
         0Vfw==
X-Gm-Message-State: AOJu0YzQ1kBPAOYdnchbTJ8I+iaFmMEQr+YlHuBKsuTXN2kaEMRh8s0V
	dpnr+ynAJb4DBapE9gJhLXtEtcUzrs5LYheLu924jT0DEZYMOiQnf5n60A==
X-Google-Smtp-Source: AGHT+IFN7kYlxmGFFTqfE/x+pAd+bNgOUok/II2Gj8Vyy2Ribk3/thUQEethbyapnFF6pT339AwCwg==
X-Received: by 2002:a05:6402:457:b0:5a1:1:27a9 with SMTP id 4fb4d7f45d1cf-5b7f429466dmr3731516a12.18.1722634319277;
        Fri, 02 Aug 2024 14:31:59 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839b298desm1519122a12.22.2024.08.02.14.31.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 14:31:58 -0700 (PDT)
Message-ID: <60856bbc-8701-4aee-804c-3d8c00d4f5c5@gmail.com>
Date: Sat, 3 Aug 2024 00:31:57 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v2 1/4] wifi: rtw88: usb: Init RX burst length according to
 USB speed
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Sascha Hauer <sha@pengutronix.de>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is needed in order to make USB RX aggregation work with RTL8811CU
(and presumably RTL8822BU and RTL8822CU also).

I don't know what BIT_DMA_BURST_CNT, BIT_DMA_MODE, and BIT_DROP_DATA_EN
are doing.

Tested with RTL8811CU and RTL8723DU.

The RX speed is unchanged in my tests.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Move the code to rtw_usb_interface_cfg.
 - Let RTL8723DU and all other USB devices use it, not just RTL8822CU,
   RTL8822BU, and RTL8821CU.
 - Use the speed member of struct usb_device to determine the USB speed
   instead of reading hardware registers.
 - Update the subject line.
 - Add more information to the commit message.
 - Rebase on top of the latest rtw-next.
---
 drivers/net/wireless/realtek/rtw88/reg.h |  6 ++++++
 drivers/net/wireless/realtek/rtw88/usb.c | 23 ++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index e7b24465f549..4d9b8668e8b0 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -322,6 +322,12 @@
 #define REG_RXDMA_DPR		0x028C
 #define REG_RXDMA_MODE		0x0290
 #define BIT_DMA_MODE		BIT(1)
+#define BIT_DMA_BURST_CNT	GENMASK(3, 2)
+#define BIT_DMA_BURST_SIZE	GENMASK(5, 4)
+#define BIT_DMA_BURST_SIZE_64	2
+#define BIT_DMA_BURST_SIZE_512	1
+#define BIT_DMA_BURST_SIZE_1024	0
+
 #define REG_RXPKTNUM		0x02B0
 
 #define REG_INT_MIG		0x0304
diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 9145c11a063e..1c40d46a7eb4 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -720,9 +720,30 @@ static void rtw_usb_link_ps(struct rtw_dev *rtwdev, bool enter)
 	/* empty function for rtw_hci_ops */
 }
 
+static void rtw_usb_init_burst_pkt_len(struct rtw_dev *rtwdev)
+{
+	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
+	enum usb_device_speed speed = rtwusb->udev->speed;
+	u8 rxdma, burst_size;
+
+	rxdma = BIT_DMA_BURST_CNT | BIT_DMA_MODE;
+
+	if (speed == USB_SPEED_SUPER)
+		burst_size = BIT_DMA_BURST_SIZE_1024;
+	else if (speed == USB_SPEED_HIGH)
+		burst_size = BIT_DMA_BURST_SIZE_512;
+	else
+		burst_size = BIT_DMA_BURST_SIZE_64;
+
+	u8p_replace_bits(&rxdma, burst_size, BIT_DMA_BURST_SIZE);
+
+	rtw_write8(rtwdev, REG_RXDMA_MODE, rxdma);
+	rtw_write16_set(rtwdev, REG_TXDMA_OFFSET_CHK, BIT_DROP_DATA_EN);
+}
+
 static void rtw_usb_interface_cfg(struct rtw_dev *rtwdev)
 {
-	/* empty function for rtw_hci_ops */
+	rtw_usb_init_burst_pkt_len(rtwdev);
 }
 
 static struct rtw_hci_ops rtw_usb_ops = {
-- 
2.45.2



