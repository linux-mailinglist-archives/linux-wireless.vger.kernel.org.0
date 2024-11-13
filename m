Return-Path: <linux-wireless+bounces-15282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA1D9C7EF1
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 00:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 125871F21C77
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 23:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108B118BB82;
	Wed, 13 Nov 2024 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOonnaN/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384AC18C01F
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 23:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731541808; cv=none; b=u/kvjSoWG3cheTIj/TVb/G6uti7R9mAH/AL9CYsOqapdOVL8j4k+nVWrALWJmoV55P1L2ruFJkgBrLHIQpjJfXiXisscX0LQNo5rLyq5yLCbHohMx43N0EwGMnU0+/Bpkq95vkQqglbK9dYFCmWuFuQLjOkXHdDiC9kyzFlABTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731541808; c=relaxed/simple;
	bh=SX5RQBrVs199g7Qo51fsyXxM1Ai9YfO+CkK8tObeo9c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=rD3bPjVnqjQLBP7Fv3Pb45/OOPlqnsVAZocShPMNUjBRELTPoTIoBgrZAyjYWKTPh9UeMYugSHqCje5jJdO5xIEtEBfCzMxQ9997cdrVHNpZ8OJrf8If9LRlTWZhHlaijTVeaIOLMbwRkxie/optct2cKfk7Q66m+iaBs7Bwios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOonnaN/; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539f2b95775so1387e87.1
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 15:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731541804; x=1732146604; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TbiB3M4CrSuuQ3+5hb3yF9mlQ1appiO/e0gheUQs82w=;
        b=KOonnaN/ZWp5FQCd05eLjp+4AMm8eRznHKaiXDoEM8RpWUDvXkmZEoc8x+r4k52/jI
         OscL+pgUSMN3FNvu2CirmFvRxyzHAbUyKAGKkDoYnWMjUhbu1QT+zC7LadoM2TymqqeO
         Z9rHzW/q6ABioZMguIIs4QDdQ/hqTX/j3veLjWpTQq8YjzQNaBIbMrobqIpMY6RRfgec
         VzLlORwkRmFPzBdUSTHXDmyCeG84rkxan0z2gs67UC9r4QkxBfeH031oVTD4Ln2EIjCP
         lN2QE3I3TgliT1xJP5bJ5eO5vBQGrPjeRX8G04ZnkCN1eTew/gPVmdpjsrEQxTz3Up7t
         NL2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731541804; x=1732146604;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TbiB3M4CrSuuQ3+5hb3yF9mlQ1appiO/e0gheUQs82w=;
        b=Xf7q4rXt4WUOxrYtMfGM4VQkyTFJFlA4z/CaiG3dM2HkXhxhe/XO50WmSuL7eW3K85
         4vy5Bka4NoL4mDIhZZGGVi55DwcPYjneYPWJaGyPajDbKymHtZZ0XFbUYIoT6pfiNIS5
         AXtpBf64JcqyeZdM06Dj/q+4jKktnRf/5P9vcbK1QrRBhSsTsjymk3Ch+7CHwFE5BoTj
         ZYKnnNiguFbQd398VX2W7iSKfsZDjH9bhcao5Fkv+Ixq3ZtAZGlybIVQxIzDLtYXwARM
         QFuxhrb9jsuQdQkyM+YvQ4tJfW5c1wIMTuVC8cNncG4Um5OIuHJ8ovn6okfxOUlBwWCU
         DNjw==
X-Forwarded-Encrypted: i=1; AJvYcCUrCQu3DkglnG+xJf4WtVr+938oa1YtEqL1nEefssEmNSeTZO1ouN+LQYgZrOvgpUo0c2xKptjesMvSn7MsQw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm/HlWAsz+SecRBBtOG2phNmNDU6a9gNTKhI2/VR2Cs4FzvzUS
	FoexfluLRLuQzlDMBARdWwOrq2m6eyQJ58k0K8SNqy+CzVpp2nihvfXeqw==
X-Google-Smtp-Source: AGHT+IHQ5RANP+n8or+6zL+BL0TEFQLSqOpiOJjmhpnpuSyMWYTF7yXtDMdeWqOz4fmbpxqCrW9+EA==
X-Received: by 2002:a05:6512:3c88:b0:536:53e3:feae with SMTP id 2adb3069b0e04-53da5c2755dmr117612e87.11.1731541803860;
        Wed, 13 Nov 2024 15:50:03 -0800 (PST)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0a4c210sm927800466b.78.2024.11.13.15.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 15:50:02 -0800 (PST)
Message-ID: <f9223971-a679-42ec-b0df-44f60a93a10f@gmail.com>
Date: Thu, 14 Nov 2024 01:50:00 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 2/2] wifi: rtw88: usb: Enable RX aggregation for
 8821au/8812au
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <78ca9bcb-cd48-4c53-8514-7967bad6dfcf@gmail.com>
 <c7f9a5c0-a90f-4ebe-b7a0-401d300bfa13@gmail.com>
 <dbba24025d024b31948dc23cd0c2f772@realtek.com>
Content-Language: en-US
In-Reply-To: <dbba24025d024b31948dc23cd0c2f772@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/11/2024 04:40, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>
>> USB RX aggregation improves the RX speed on certain ARM systems, like
>> the NanoPi NEO Core2. With RTL8811AU, before: 30 Mbps, after: 224 Mbps.
>>
>> The out-of-tree driver uses aggregation size of 7 in USB 3 mode, but
>> that doesn't work here. rtw88 advertises support for receiving AMSDU
>> in AMPDU, so the AP sends larger frames, up to ~5100 bytes. With a size
>> of 7 RTL8812AU frequently tries to aggregate more frames than will fit
>> in 32768 bytes. Use a size of 6 instead.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw88/usb.c | 30 ++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
>> index 752bca05b9af..9172af63500b 100644
>> --- a/drivers/net/wireless/realtek/rtw88/usb.c
>> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
>> @@ -790,6 +790,32 @@ static void rtw_usb_dynamic_rx_agg_v1(struct rtw_dev *rtwdev, bool enable)
>>         rtw_write16(rtwdev, REG_RXDMA_AGG_PG_TH, val16);
>>  }
>>
>> +static void rtw_usb_dynamic_rx_agg_v2(struct rtw_dev *rtwdev, bool enable)
>> +{
>> +       struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
>> +       u8 size, timeout;
>> +       u16 val16;
>> +
> 
> How about a shortcut?
> 
> if (!enable) {
> 	size = 0x0;
> 	timeout = 0x1;
> 
> 	goto rx_agg;
> }
> 
>> +       if (rtwusb->udev->speed == USB_SPEED_SUPER) {
>> +               size = 0x6;
>> +               timeout = 0x1a;
>> +       } else {
>> +               size = 0x5;
>> +               timeout = 0x20;
>> +       }
>> +
>> +       if (!enable) {
>> +               size = 0x0;
>> +               timeout = 0x1;
>> +       }
>> +
> 
> rx_agg:
> 
>> +       val16 = u16_encode_bits(size, BIT_RXDMA_AGG_PG_TH) |
>> +               u16_encode_bits(timeout, BIT_DMA_AGG_TO_V1);
>> +
>> +       rtw_write16(rtwdev, REG_RXDMA_AGG_PG_TH, val16);
>> +       rtw_write8_set(rtwdev, REG_TXDMA_PQ_MAP, BIT_RXDMA_AGG_EN);
>> +}

Hmm, I don't like it. What about this?

	if (!enable) {
		size = 0x0;
		timeout = 0x1;
	} else if (rtwusb->udev->speed == USB_SPEED_SUPER) {
		size = 0x6;
		timeout = 0x1a;
	} else {
		size = 0x5;
		timeout = 0x20;
	}

