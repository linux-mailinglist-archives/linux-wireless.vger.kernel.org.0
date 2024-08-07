Return-Path: <linux-wireless+bounces-11106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 670E394B2EF
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 00:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990EF1C2168E
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 22:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF0C14EC47;
	Wed,  7 Aug 2024 22:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHcXIdR2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D09146A7A
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723069183; cv=none; b=Wk83NpUz53yXaEM95/rQiTq3IB0idWjTvrBa7USX4RUZG42MlOkkS+KTVlLPIr/heK+M28EloN9en/JrCGgd2DbzuqHp9WUIG0EyT/yQMFxi/tCRY0q62K4zQwUvh+3yg8tpaQtPUp9RHJvo+Sq09HomF/qC6JU+rIkxWjbWTxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723069183; c=relaxed/simple;
	bh=9RaZLXyXmju0HkifB2luLpOJ/VCAdPA/SDtLvRODkHI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=DVbI87z8++VZwJWQcTLgiYy/oBlqjeH8TwJWMzstba+BsGPF6LhkEr5E1C/nos6PVV9pPcGczVZoUnf0GPNdQVo9EbSWE8VjXvEk7c7B8vYdfrC9htsw7rzUmqjsaBX/sYEl/4eOLoMN/M+50ihJSaMOw9F4Pvp/hBa1u20kJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHcXIdR2; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso30872966b.0
        for <linux-wireless@vger.kernel.org>; Wed, 07 Aug 2024 15:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723069180; x=1723673980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmDGTs8rq3T/++MCycT4WwVZ2D4e9REO/6u7dp24Dic=;
        b=ZHcXIdR2wwvfEyZeRC12sZVy2KQOHUgy1guC87vB5iDCSSqBz/qRCVRINgxx4juFDt
         S+dablPW5ZufDsSsk/Vpa6h/GyH8KyL27xrHd0Tn+MtvldGG2XwAlJ7m5cjwsOGJDc4F
         ZKzLD5rWNMw1v9IgCHcXLKujhU1n+yNBDeC96WtlmKkDtsCm7OMRNj4AXTf3WJcfs7L8
         fM9SQY6zNIpbxDPOm4Qs2XFF8ON8H6+R1lOQ9dHI6R+6n4owNoTdKcWZvTksaHC/Viyw
         bVVqP7NWdrcr9r4Fn3BhCIWeNPhTuq5EsJdQjoKLb7EqD4/sO1SIq9WaW6si6K5hNl9H
         EfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723069180; x=1723673980;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vmDGTs8rq3T/++MCycT4WwVZ2D4e9REO/6u7dp24Dic=;
        b=osbcGoQSTYzx0h6xdBQ/bXZ4tSHf4f8wUoCr2JKWDIud4pZBpAEMhN/EMFTPGUYk24
         XEUJqwfcsFD3+E0D8oaaOba2LC428DdyHXqR0wJtF7g51CKhKGdGaAX5LHQnBpZOXM6I
         cxHvz3w1jmk4b+DuhjWf14RShgSqnfRRhpyiCf8H24D5E/LD4hZEe3LDrQs47GdXVZpd
         QIa7YNR0t5GLFf9CIvKdZGA0UQ9uN5LB7ETbfRLhyFQMlOyiZ18VCTDhNvyfrpEYAZ+o
         Nkm4H66FNUr+PPxFnAIU2SheK81++vEDNzw+q7kxcozX47NsKHEfqbLzX1CGVku/nw8K
         yrxA==
X-Gm-Message-State: AOJu0YylQFVSG4lG1TLtrqkUIYYnAUATy/rDKV2bAXO/rxHvDBiBl2In
	/arNsexjq04Il9W4EPrzViRtEHW9FMFlIrh4ygb6h+/QGvIf18A2HkHPPg==
X-Google-Smtp-Source: AGHT+IF5p26tWRdWkeLITjIOz5+c9Cr2zjIPMpemEXp1Nam2I9zqVNdaC5Pjfyp/S4AhTjqI2bww6A==
X-Received: by 2002:a17:907:7206:b0:a7a:9ca6:528 with SMTP id a640c23a62f3a-a7dc4dbadc4mr1109560766b.11.1723069179621;
        Wed, 07 Aug 2024 15:19:39 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9bc3c9asm675376566b.37.2024.08.07.15.19.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 15:19:39 -0700 (PDT)
Message-ID: <ac569c6f-7129-4341-b523-901fe10cabff@gmail.com>
Date: Thu, 8 Aug 2024 01:19:36 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v4 1/4] wifi: rtw88: usb: Init RX burst length according to
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

Tested with RTL8822CU, RTL8811CU, and RTL8723DU.

The RX speed is unchanged in my tests.

Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v4:
 - Mention testing with RTL8822CU.

v3:
 - Add Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

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



