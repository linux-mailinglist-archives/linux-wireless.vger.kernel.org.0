Return-Path: <linux-wireless+bounces-11038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7532E9496FD
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 19:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97EFB1C209F9
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 17:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C529F4C62E;
	Tue,  6 Aug 2024 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWQHFYHm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47D22066
	for <linux-wireless@vger.kernel.org>; Tue,  6 Aug 2024 17:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722965999; cv=none; b=O6Tb32JASYxZDcP4GVfSqWqLqrBboa+gjHcVKqHBODesCqS/jrBMBwwwy376QXcR74uaEbreVSGgWN6KJpqedTioe+NYv9th+20ovW6T85420gQut3DArbJT5Cd9dW3vUlwj3QdneEq0uiQ/z8izDHJ76/bAX9aYmVHTKTVRqSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722965999; c=relaxed/simple;
	bh=8v10EiR8fmwFKuTCYVbk/iN7VD1OxzrSnlIxpSSWBII=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=dV7nReyG97eaEpkT+U0O6+crGjzpseH4dIvAJkaXoUgkpiViqPbQtikUQwiE2vh5e4xaoRlgiUdLevECXotIE6a1yHg6KWOSVBzzfokwNY+rdX/X8A9xgUvpZqaKym60I85jq6eCEHTU0sVATWhQPJ2TI67/EwpxYPPzqxsp6rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWQHFYHm; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7ad02501c3so91666166b.2
        for <linux-wireless@vger.kernel.org>; Tue, 06 Aug 2024 10:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722965996; x=1723570796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rv2VT0KZMUtpwqkZKBoiIPgAdLzhKPHmAOmQsdHVXxA=;
        b=IWQHFYHmyvkacc/tl3JxE71rL/aC7fIWg76Ox0e+joax6JTlU2t0oH09VDEaxlKfBj
         zmyZ8oQJYf2LwqjDbs64FZkYOpWVVlC0aXN8zUt+nkIO+AgTSgaia/sA7C7wSpPdz4oQ
         BnTPiZeBJgdvg7t962R4bba6SIBSq/ZIziCaDZGg7jwGzISePx7ZkkxG3jvuKL1iZxtC
         L01kB8nV+LwASTPYU0cS+cMAkrQ1Lbc0Moq3o9hr2fAjIFUu6nOAXEa8XzWt/PkweQXH
         mXZPrUmv1SRFTLYJaP/mzIoARoAAqPPlWPfFPmpf0KoJQ2BzVw7ASA0+9c1Fi15BVSWl
         XIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722965996; x=1723570796;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rv2VT0KZMUtpwqkZKBoiIPgAdLzhKPHmAOmQsdHVXxA=;
        b=CrC7iQ3eNgYpEoyGGvtdXdVLk9uCK91YCbxtSrFIxPC51LqmNdTvi9o+twd8rSyaPo
         qNoszHy6SkbHwbz8N1S4jS2lWYDG7s0T2caLYGcLdvjZ7mTGpATJ0iMgcpFwwqH0IUZp
         9gd+N7YheWt+ikoZPcDPTGknXsXMJoVq/K0WyrdIQbMCQguN9TEhkYOXymqbzsN0bVIM
         Wt+ivBQzfXcZ57QoeCdZE2UTNlozw0XtiKiGcT3/xNOTjKOKxXYjgIOkAlvuQrRL/yfF
         3meJ2EMXkpcWdS3I9aznNds7oCkx9BeUpgzhlxBfjpt7Ecjw7PFrRhZDJByM0LZwroCY
         hTbg==
X-Gm-Message-State: AOJu0YzLFnkIpGL9KhniiFwENilEZh28rCZejAlmqgoBtcqsvyDF992R
	F8hHxdII62d2dFELUFAg0u68zUXkfQoopMLEBnp1nlW1Gth11v415WXiLQ==
X-Google-Smtp-Source: AGHT+IHydnXgalYUqiWVa9S4hyyqkKDA6J9vTBne4xO5mautr2PHlgL7w3gQe0KnY1OU5mGrOQKNQA==
X-Received: by 2002:a17:907:7fa9:b0:a77:dd1c:6276 with SMTP id a640c23a62f3a-a7dc4fdf7ecmr1383219466b.7.1722965995725;
        Tue, 06 Aug 2024 10:39:55 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec8879sm566711566b.211.2024.08.06.10.39.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 10:39:55 -0700 (PDT)
Message-ID: <acc5ccc7-e573-472f-96d2-582716046aa6@gmail.com>
Date: Tue, 6 Aug 2024 20:39:52 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: [PATCH v3 1/4] wifi: rtw88: usb: Init RX burst length according to
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

Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
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



