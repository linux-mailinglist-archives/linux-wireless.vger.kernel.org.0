Return-Path: <linux-wireless+bounces-15302-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D7D9C8ECB
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 16:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2D5F1F22682
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 15:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D938753365;
	Thu, 14 Nov 2024 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcQP0cAV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B4A19AA5D
	for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 15:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599295; cv=none; b=l9Glcf1CYiiOZjHKIQVprfASuErdxQfwb3hNuk1HsbpRIsurvKg7hXogH4QinwnyX53o+5YMilXg6jhte5j/4GTJWt51aHcE98G/3X1FEplHAUiH2pdjcj67O2PAyOxQ51SMlCgI2c99ld13fiIP2KdASB0MwrUmKR8sLLMXiMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599295; c=relaxed/simple;
	bh=qjAq2C0ijk7unSydPcU8ULh0epulUToMshqXcqIg5gA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=UPNWyBPgQjAPSXNXOk647gf69u/QEiWOeg7BFn/MS+KoAPJnW3fhHuFNLiwFegqVHJGvmtbOaqSEEdQU88H1LD3bO6NMaft+tObVBRm8OZvVxp09dftiz8cO1X5BcBIx8bbnZWtIu7gUNjKVRsB5JpE79tLZ9TllzBMXojTWRk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcQP0cAV; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cf84214e9bso450630a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 14 Nov 2024 07:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731599292; x=1732204092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aCnknGYMtmfmU+0ndu85QSTgjvuszj35beaca2ITwbk=;
        b=YcQP0cAVP5Pq0keFSvgiRn3ogQ/YZTHQmcEG9MfPxnSvlDBdN+OUxS/+MdearFENeE
         Q0sxo7O/C72glTby+no2jtPt0at6vmivtl4UYEh+aN+vK3Of89D7YWlWWv0WRkmYHpwb
         NoxCzXmEh5A7g8tFPqh76Yz9QPWjirYKWSonnknnzTxu1hucmJqyZ0zKrxawb+5Tasxc
         oCHGkg1qHnfFwaES0PLbWIsv4zHyDPF1wsvrXmpVaXRVjB3PeP2kiE591Z9V22QNjZMq
         qLMkhhLvAK2P6yGIe2E2Cu4J8RpvspRIpyB69Xh7MjRCNv1bZzQx35xbcYfnDZsczebr
         0P3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731599292; x=1732204092;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aCnknGYMtmfmU+0ndu85QSTgjvuszj35beaca2ITwbk=;
        b=eVAtTMU6TNKTq564POljxV7kU21l3xq2CkO4oIBftI8idZLGHLelu2zfVUtwKB9mxV
         PHbXM4jiCR6PMkVwOHiJmh512MJQPqKMkrx8gmuLfVGmD40eVIYB4SJTu92Doyjoxzlw
         dC50ivfUQexPWe32p/Vrkntn+FfRzV1L1UeKJnWnboVfizLRIxYOqPpLue0Wnzx1dNu3
         /pU6XojgK2ALkYW6XNHBDVljVeJ36Cod+yMTEezUiQgqXM8yZC4ZAEkyqbzJ78qWuEGO
         6UDbqzBymGBz1M6/C4klPfGoQcFENvwsm7ZUsNoRoYZOi8ZKVQ9CJEZlimVL2sCH1Zpf
         RPNg==
X-Gm-Message-State: AOJu0YwXz3aDxjkqwUzZ1bLSn0eQdn3jqsL/ehFh74vuEDXbN2ZghNOT
	qVRgo6kHjFDEY6k4jflk9GVTW8qIVd4/tdq309+COh3aI6Pw2l4pmsrDZg==
X-Google-Smtp-Source: AGHT+IE/1DqNd9HHgpplZdg4isFPkzg7eUaoCShEfiLFN1XyuPGjuG8G1P/9pbWuRfGCD8m48DlGTw==
X-Received: by 2002:a17:907:3fa2:b0:a9a:7f91:8c76 with SMTP id a640c23a62f3a-a9eefcec58dmr2578999166b.0.1731599291745;
        Thu, 14 Nov 2024 07:48:11 -0800 (PST)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e045390sm76033366b.154.2024.11.14.07.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 07:48:11 -0800 (PST)
Message-ID: <63012163-a425-4b15-b830-43f279c06b73@gmail.com>
Date: Thu, 14 Nov 2024 17:48:09 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/2] wifi: rtw88: usb: Enable RX aggregation for
 8821au/8812au
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <19cda72b-f1f1-4b69-8369-0e4376b646bf@gmail.com>
Content-Language: en-US
In-Reply-To: <19cda72b-f1f1-4b69-8369-0e4376b646bf@gmail.com>
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
v2:
 - Check for !enable first.
---
 drivers/net/wireless/realtek/rtw88/usb.c | 28 ++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
index 6f64c3fd96ae..91360d1b7b68 100644
--- a/drivers/net/wireless/realtek/rtw88/usb.c
+++ b/drivers/net/wireless/realtek/rtw88/usb.c
@@ -790,6 +790,30 @@ static void rtw_usb_dynamic_rx_agg_v1(struct rtw_dev *rtwdev, bool enable)
 	rtw_write16(rtwdev, REG_RXDMA_AGG_PG_TH, val16);
 }
 
+static void rtw_usb_dynamic_rx_agg_v2(struct rtw_dev *rtwdev, bool enable)
+{
+	struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
+	u8 size, timeout;
+	u16 val16;
+
+	if (!enable) {
+		size = 0x0;
+		timeout = 0x1;
+	} else if (rtwusb->udev->speed == USB_SPEED_SUPER) {
+		size = 0x6;
+		timeout = 0x1a;
+	} else {
+		size = 0x5;
+		timeout = 0x20;
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
@@ -798,6 +822,10 @@ static void rtw_usb_dynamic_rx_agg(struct rtw_dev *rtwdev, bool enable)
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


