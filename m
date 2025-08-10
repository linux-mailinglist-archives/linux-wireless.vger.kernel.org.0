Return-Path: <linux-wireless+bounces-26237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BDCB1FC79
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Aug 2025 23:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 260657A2417
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Aug 2025 21:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5B228643F;
	Sun, 10 Aug 2025 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiCf10+a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5B7213248
	for <linux-wireless@vger.kernel.org>; Sun, 10 Aug 2025 21:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754863131; cv=none; b=o1uRJggCiSGzkxgukHTlvX0Gdy6Jl9358LhN9IfMUls9PF89lhr/xu9pWV495G1yvjNyX+0FxstM89nCj0h0Es49yni+YxzhkomLseJJSmph++dzXzpxuiSWtPqmlGW9+c63ZAAqVrj6TO3HeSH64mKmbd9QEw2p0YjzU3b/AJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754863131; c=relaxed/simple;
	bh=k0ld4mOK0AWGko5ZoWaFuIobyaLgTVPVLHqdLl9Bl+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WbVfJTYhN8EpIkRwVjvIWSatX1+ElCO6TedCZkF1l1PHgDynWcE5aEjQs+xAQntKsyu03qZPFcr8sVGlb94B4H5AdVUxzz/7fg+W60BCSOEBtCGAD4dYiSt7WXdN2Akc78576vpATVoHZgq0Kr+6TloTcj35qus28qw9uB4FIz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiCf10+a; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3b785a69454so2045204f8f.2
        for <linux-wireless@vger.kernel.org>; Sun, 10 Aug 2025 14:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754863128; x=1755467928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y1VXwaCfO9pAso/DdzzrAqugX5Ft61DWSe3sRMUZEF4=;
        b=hiCf10+azm3RAkGhZ85I9/qeaMsbv1c8/WuPmhUsBWTvM+Bh/pl9mCItR2GTJzVfZ7
         AiSQ8wJxjejfZh5/GJrXgene5fEhzZDESpHUwPqbX1470k81f9VJ2SXLJBRnq90cgJQG
         1khlYv6akkMUtwyVjnfUyxNohrLOFOvFDWzq3wbDWN/cK9CAkRxKFNPRvHlWpGT7Lzcp
         Tl2IBHA4hx1duyyudLXSKNT7C2UEuxahvfgozLycghYYZJPk6VenLegouuB+zxxIKWcJ
         2CdRLtU4fnGSDftw8wY1zFvgLRufurBpWtrkYzEn0pbiQL+FAjh8d5Gm2hzehQKl1gr8
         EPPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754863128; x=1755467928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1VXwaCfO9pAso/DdzzrAqugX5Ft61DWSe3sRMUZEF4=;
        b=qp+WExAV/CUUd0fxc2zBtnscIQh/BRj1ac6geU/PWY+jx0fQVGgaxuYaX1nLKZYPQ3
         4EPGh+tDoKQftdmjV1J4Y7qOJVOUohUJ4PFPXOS2ofMb3Nl1K7NGJ/hXH3mYNbKWSPNB
         S3Vzb2VRPvyeD4b9OWvEzxUyNOAYQmrclJgoNA756y8vdg0/mlsTTx1d1+oJZ2zirXE/
         /fXbgz9MwC8F7diOnpAyCPdVNhejT4RPLT2Uyw57E5fdhvyJXYJtQDDwpN8Q4sG93VkP
         9R5xsju8yJzjcUKl/FqqC/fssSRTuNzgPQ+CyGYssGeE/XSqLyIyjZRV1/GWkYqvD03q
         1fxw==
X-Forwarded-Encrypted: i=1; AJvYcCUKM+zOmT5yo6bxo7ngtd1eWfMabUV/MnE2SfSR8e4pX4SdYGiGQuNniBNyyjSiQhc9e5YWiczv2R1qVI0Kmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl2Tb+tB1Souph/g9nyeOO1qqILZphrWuUBILW1IjhmHD/ob/f
	ZU1XSIf3xJFGp8vzesc1o1BIwM3zoZIdMqHXxJ1Ovg8KDtNFXYcx4SUu9hVumg==
X-Gm-Gg: ASbGncuOmnHTOp1NIL0KSWLSrxNVjmqC02uFbVuxWtx2mfCEtJXZnjZPrUkxckAC7xC
	hB9zJqxSURtbP90fGAIRBxwUM3NpEIpn9rkOekwZ+vveDzU0m3XNtyRi0CxLtf989Z4avufIcQI
	5bpz71jJwQ/0FUtDlFkcG8MDceT/YPqq1sJgQUe/Np7FhrBP0Hb0GhmftE6GDBtvXfpo2Z4Zjwc
	CqZUUuWEdTu/79aqocZ9Az2eMhcjxHKM9kEK/pVr0P0R7fZ8is4WDkt/uatfTyf0PrBWoAPqbFK
	7NRUMkYs0ATHDdsFbnRovUj1DJdVGXqNooMKLyPScS80SFp5jw2hFp3Qqx8DSI6nQpqtlqK8H2T
	WEJk+iGF/Nwmg4/Nu7BUdmvJ6ck82EA==
X-Google-Smtp-Source: AGHT+IFrMuBuiTfTaHYpU7iB6wOaAI50FMfYkCYBNCoUo+5DfMOdbQF6wj+5QpP/RywBKUoffUkPvA==
X-Received: by 2002:a05:6000:220e:b0:3b8:f925:8d4 with SMTP id ffacd0b85a97d-3b900b35c4dmr9028746f8f.26.1754863128167;
        Sun, 10 Aug 2025 14:58:48 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4533f1sm38651352f8f.42.2025.08.10.14.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Aug 2025 14:58:47 -0700 (PDT)
Message-ID: <75148ebf-6c81-4c2a-a626-a56701a0ee6e@gmail.com>
Date: Mon, 11 Aug 2025 00:58:45 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2 02/11] wifi: rtw89: usb: Fix
 rtw89_usb_get_bulkout_id() for RTL8852CU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
 <3fcb3d66-4c01-4396-84b1-268bf4f0d2f6@gmail.com>
 <6e8f5326d25046fea5f2033bc6c9c5cb@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <6e8f5326d25046fea5f2033bc6c9c5cb@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/08/2025 08:54, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Sent: Saturday, August 2, 2025 4:53 AM
>> RTL8852CU can work in two bands at the same time, thus some USB bulk
>> out endpoints are dedicated to one band, others to the other band.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> v2:
>>  - No change, messed up sending v1.
>> ---
>>  drivers/net/wireless/realtek/rtw89/usb.c | 64 +++++++++++++++++-------
>>  1 file changed, 46 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
>> index 6cf89aee252e..eb9978a60d04 100644
>> --- a/drivers/net/wireless/realtek/rtw89/usb.c
>> +++ b/drivers/net/wireless/realtek/rtw89/usb.c
>> @@ -167,24 +167,52 @@ rtw89_usb_ops_check_and_reclaim_tx_resource(struct rtw89_dev *rtwdev,
>>         return 42; /* TODO some kind of calculation? */
>>  }
>>
>> -static u8 rtw89_usb_get_bulkout_id(u8 ch_dma)
>> +static u8 rtw89_usb_get_bulkout_id(struct rtw89_dev *rtwdev, u8 ch_dma)
>>  {
>> -       switch (ch_dma) {
>> -       case RTW89_DMA_ACH0:
>> -               return 3;
>> -       case RTW89_DMA_ACH1:
>> -               return 4;
>> -       case RTW89_DMA_ACH2:
>> -               return 5;
>> -       case RTW89_DMA_ACH3:
>> -               return 6;
>> -       default:
>> -       case RTW89_DMA_B0MG:
>> -               return 0;
>> -       case RTW89_DMA_B0HI:
>> -               return 1;
>> -       case RTW89_DMA_H2C:
>> -               return 2;
>> +       if (rtwdev->chip->chip_id == RTL8852C) {
> 
> Not sure if you like a rtw89_usb_info similar to rtw89_pci_info, so that
> the you can describe the difference between chips. Even make a mapping
> table. 
> 

Yes, that can work.

>> +               switch (ch_dma) {
>> +               case RTW89_DMA_ACH0:
>> +                       return 3;
>> +               case RTW89_DMA_ACH2:
>> +                       return 5;
>> +               case RTW89_DMA_ACH4:
>> +                       return 4;
>> +               case RTW89_DMA_ACH6:
>> +                       return 6;
>> +               default:
>> +                       rtw89_warn(rtwdev, "unexpected TX channel %d\n",
>> +                                  ch_dma);
>> +                       fallthrough;
>> +               case RTW89_DMA_B0MG:
>> +               case RTW89_DMA_B0HI:
>> +                       return 0;
>> +               case RTW89_DMA_B1MG:
>> +               case RTW89_DMA_B1HI:
>> +                       return 1;
>> +               case RTW89_DMA_H2C:
>> +                       return 2;
>> +               }
>> +       } else {
>> +               switch (ch_dma) {
>> +               case RTW89_DMA_ACH0:
>> +                       return 3;
>> +               case RTW89_DMA_ACH1:
>> +                       return 4;
>> +               case RTW89_DMA_ACH2:
>> +                       return 5;
>> +               case RTW89_DMA_ACH3:
>> +                       return 6;
>> +               default:
>> +                       rtw89_warn(rtwdev, "unexpected TX channel %d\n",
>> +                                  ch_dma);
>> +                       fallthrough;
>> +               case RTW89_DMA_B0MG:
>> +                       return 0;
>> +               case RTW89_DMA_B0HI:
>> +                       return 1;
>> +               case RTW89_DMA_H2C:
>> +                       return 2;
>> +               }
>>         }
>>  }
>>
>> @@ -251,7 +279,7 @@ static int rtw89_usb_write_port(struct rtw89_dev *rtwdev, u8 ch_dma,
>>         struct rtw89_usb *rtwusb = rtw89_usb_priv(rtwdev);
>>         struct usb_device *usbd = rtwusb->udev;
>>         struct urb *urb;
>> -       u8 bulkout_id = rtw89_usb_get_bulkout_id(ch_dma);
>> +       u8 bulkout_id = rtw89_usb_get_bulkout_id(rtwdev, ch_dma);
>>         unsigned int pipe;
>>         int ret;
>>
>> --
>> 2.50.0
> 


