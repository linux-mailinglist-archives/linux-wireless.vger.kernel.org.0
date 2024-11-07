Return-Path: <linux-wireless+bounces-15117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779029C12B1
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 00:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ADF71C225DF
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 23:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AD9218D88;
	Thu,  7 Nov 2024 23:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoI1xnqK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F4E1F4FCA
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 23:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731023036; cv=none; b=OYIRfaHiBrmFdsCOzDL6q9R3qb9AdHF6cxoA0BLv9pK5k9hIQ8TBI1Y1mpA9xsCO1xeR/+8uRh9nbCdQw4sBC00+ZnP68NjR9+sxhw8Qq2/UAuQWHZaYZjq/tEy+Purbzcea8T2AHxlueviWtZOSQ0XdPeY6Fr3ur8aAEjqooSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731023036; c=relaxed/simple;
	bh=BaOhUCYNUrw+nRemOpwUIi+k4Ws50Gr0wIJoxqq9z8k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=fmHvBKlGjQG+qe1h/rbZOxsebmFDtNWB4hI6cPKq6biol8Ww6JIYBjO+9cSmNKBW5eoE14xqxQfKtS/MAkkuEe88y2hhynyjzQt94ENRU00SWufxZyYSRKI2gSK7ez5rkeuDVXCIWPdR74Wvz8OY8oLKzAKENZ3O+xJ3IgzwqJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoI1xnqK; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d808ae924so964175f8f.0
        for <linux-wireless@vger.kernel.org>; Thu, 07 Nov 2024 15:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731023033; x=1731627833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7bjeHUfBQwfpwvGUFXIS7SPntIsGKPboqlE+Vlxq+rM=;
        b=HoI1xnqK+rLthvbw4m5GNuY8ka5HnvXc5Kr+RWyodmFOGjDsiiGa04DsV5PybuPyqs
         86h11MXk/+M/xkhOoPov1cdIIN99KLeFXqPBTIGu6XuEruNf+pxz8n8nACctgdkDBaYv
         Q7yIIrsjNGd76hKKhWYzaofohgjq7AEBVW1pA5G4ny1cNQJmLrvsRyb6SzFp9BVlvlVm
         94w5wBA0rrB1Metq4LtyBR9Unat48g3Cizzie5xQ/nbP61iQksDtD2iHFk2dnsVeESBn
         ssh9dcxWtr4cfMXbRlVtFm97ANq5u7jE9bhJDUk8OtUTvLIs8DQfq9ErznpBNFYWFoeX
         C40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731023033; x=1731627833;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7bjeHUfBQwfpwvGUFXIS7SPntIsGKPboqlE+Vlxq+rM=;
        b=dKMOilD0tRda5vm+3ssKxPc+Ho/rWKrRPPdM4/gTDt1mBqvONLTNKVnanpIX8vLAmD
         s+lt/A98vovy/neW0OzrvET9PpW1FQkW+WyXRwbNz5klzrOdYczXm9iWRYzWZ6t69VMB
         NBFJ4vo9buPjdX8Gv7xtMInaEAYpp9oLlNNq8dt/WIyGNPQ/KgleG/D2MXCQEBIlaGPr
         YNjHflC2F07ktvnbPKYQBiqLNLW+HATfWIKelSRRoczeCLZY+pB3Gu5FiV2cko9e5zYv
         Uj35Fr/BzvZEZYM9YwCau2wsJHnPe5TfkNg0oBV/rZ5QS10Bo/kIKRN6Nm2laXooCgd+
         A+gw==
X-Gm-Message-State: AOJu0YxZx8LQK/25JSkvJhQ2uJXwoJC/UWPVzWe4jjXB217nW0WMgQSS
	zhU0PinadmnVu1lVYsPn6OmmzG7aXSsaV6GL12KlfxTJbNWUUNgxV7kJ0g==
X-Google-Smtp-Source: AGHT+IF7uSWUg5jqDD9npKtpj6UHdRsuH3iP19Xkz4E6123aPToldOPACTOdxhj4oaQtyOX3hal0wA==
X-Received: by 2002:a5d:59a3:0:b0:37d:4fe9:b6a6 with SMTP id ffacd0b85a97d-381f186fb71mr630687f8f.29.1731023033200;
        Thu, 07 Nov 2024 15:43:53 -0800 (PST)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea93esm2872325f8f.66.2024.11.07.15.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Nov 2024 15:43:52 -0800 (PST)
Message-ID: <c7f9a5c0-a90f-4ebe-b7a0-401d300bfa13@gmail.com>
Date: Fri, 8 Nov 2024 01:43:50 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] wifi: rtw88: usb: Enable RX aggregation for 8821au/8812au
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <78ca9bcb-cd48-4c53-8514-7967bad6dfcf@gmail.com>
Content-Language: en-US
In-Reply-To: <78ca9bcb-cd48-4c53-8514-7967bad6dfcf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

USB RX aggregation improves the RX speed on certain ARM systems, like
the NanoPi NEO Core2. With RTL8811AU, before: 30 Mbps, after: 224 Mbps.

The out-of-tree driver uses aggregation size of 7 in USB 3 mode, but
that doesn't work here. rtw88 advertises support for receiving AMSDU
in AMPDU, so the AP sends larger frames, up to ~5100 bytes. With a size
of 7 RTL8812AU frequently tries to aggregate more frames than will fit
in 32768 bytes. Use a size of 6 instead.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/usb.c | 30 ++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 752bca05b9af..9172af63500b 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -790,6 +790,32 @@ static void rtw_usb_dynamic_rx_agg_v1(struct rtw_dev *rtwdev, bool enable)
 	rtw_write16(rtwdev, REG_RXDMA_AGG_PG_TH, val16);
 }
 
+static void rtw_usb_dynamic_rx_agg_v2(struct rtw_dev *rtwdev, bool enable)
+{
+	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
+	u8 size, timeout;
+	u16 val16;
+
+	if (rtwusb->udev->speed == USB_SPEED_SUPER) {
+		size = 0x6;
+		timeout = 0x1a;
+	} else {
+		size = 0x5;
+		timeout = 0x20;
+	}
+
+	if (!enable) {
+		size = 0x0;
+		timeout = 0x1;
+	}
+
+	val16 = u16_encode_bits(size, BIT_RXDMA_AGG_PG_TH) |
+		u16_encode_bits(timeout, BIT_DMA_AGG_TO_V1);
+
+	rtw_write16(rtwdev, REG_RXDMA_AGG_PG_TH, val16);
+	rtw_write8_set(rtwdev, REG_TXDMA_PQ_MAP, BIT_RXDMA_AGG_EN);
+}
+
 static void rtw_usb_dynamic_rx_agg(struct rtw_dev *rtwdev, bool enable)
 {
 	switch (rtwdev->chip->id) {
@@ -798,6 +824,10 @@ static void rtw_usb_dynamic_rx_agg(struct rtw_dev *rtwdev, bool enable)
 	case RTW_CHIP_TYPE_8821C:
 		rtw_usb_dynamic_rx_agg_v1(rtwdev, enable);
 		break;
+	case RTW_CHIP_TYPE_8821A:
+	case RTW_CHIP_TYPE_8812A:
+		rtw_usb_dynamic_rx_agg_v2(rtwdev, enable);
+		break;
 	case RTW_CHIP_TYPE_8723D:
 		/* Doesn't like aggregation. */
 		break;
-- 
2.47.0


