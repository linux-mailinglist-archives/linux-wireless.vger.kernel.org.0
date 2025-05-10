Return-Path: <linux-wireless+bounces-22808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB26AB23AF
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 13:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 654787AB8AD
	for <lists+linux-wireless@lfdr.de>; Sat, 10 May 2025 11:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB632550C6;
	Sat, 10 May 2025 11:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+ES9qoo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168062566FB
	for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746877895; cv=none; b=UXz7RG3e9dtL3dAx5UNFNcB04V5FE9F4I+12ydjrM7aGnPuo7oeUcE3Re0TxQ6WZ+IxWOyRkH4WQbUlma7V9I9UWtWLkTTZ9pgP2+I8NN2cEWzSwwxuB/Pxmh7aIi04LnRosZbrtj9ZlIAAPaGEjKPxIwLlF6CR2R7c6PIJo/S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746877895; c=relaxed/simple;
	bh=w2PweNLb2drafgyfNTiHbvdT1dgPrhnnIoX3n/kIoBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H9jWkuQAWjz42dpz0ddbbB0mb0Cz0112ITQefWbpPRsrWmKAW3euW1ZqG6vkXR8r7XlfWgm1+AvtVJQvFqiecCu6uc3nzF0MeVi32AlGsbjMX+KDuVjHSuSAY+C6f4aCCzhRODJbkRxlhi3cDvavLr78xmOrOBtXXnzXK/nhxfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+ES9qoo; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad23db02350so69157066b.1
        for <linux-wireless@vger.kernel.org>; Sat, 10 May 2025 04:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746877892; x=1747482692; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ERqcZdE/QgSkPEx9C6J58UbTP4pxZU9OAJ3VS5FDc0Q=;
        b=e+ES9qoo9LOXoLMdP9NzGhUYmCrT0EVOBYm3K79j8SORuO1RX+rNLg5KPmXLq/5OpH
         dUlLTIxTAynRVXMHwgKwJGxJntHOVP6hZAfTJbeI0ZoWkLVaDoSY+/vXMZCDpKpJlIAn
         sOUqtpLp4v4fjv1zN8uFbPjooLrbcsL4ch6tB/X0Xo0JTGb9tRlGE5b1P+EXCAcoI8qn
         EEq9Gs6Y4pwo4HTytn5DhszjHdCxJsgY7uwYGGCu8IjW8I1O295wpEaG3gjrFWBEC/LI
         KjN6zM30xcvcJ/PoAIsfOFsYUd/5hSxG3mxXfOKPd/ISd0apTWN11OpA5LQRJVMyo9VA
         446w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746877892; x=1747482692;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERqcZdE/QgSkPEx9C6J58UbTP4pxZU9OAJ3VS5FDc0Q=;
        b=Rnqh4ew0wa1D3sK7UWi3gtblS79XaKvsVN5yDC3sKr5rCOItbyJ5t8eH8gXpX538Gk
         1isX8lImeSAtNd04QjbD3UCon9nvGBgMv9a7m7jMVOT4i+/fCVLoKOBRiXthUDMOQPTL
         JDfiXFtX1DqOHUKSmm05hqIxKhUi0VIbGT2bBr5XrFafsBW6QECPqRuzrMkGv2O0yc6T
         8uQrkp8urjDbPdqM2lRrncz9Pwzworw4i0VWlFiPzdkpmTDE8jcbJ0UMjBGhkFP12fS9
         xwIwiLF5glq4xoRspkZOFcMTXWjUkQb3TkciGZ5rHbIHhITHnKFL0Wr/4KsyVW8abgf+
         ufKw==
X-Forwarded-Encrypted: i=1; AJvYcCUnWC1AjRwQy8lclFSmpVkEBfFfUJJBJOKOV6JCj8/zDVgV5MpKL5cx8kqtCJYdw1d9wXa+ShSg85FfCAgIsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsn0q2+AdSmgB0YJOecS+3/Ws9UlOyk3Z5GI4oBGSV0jDVSCmF
	+G3SOiorY7esxiJPy45FPInRku+1miM65fxrodV1VoVTWzWZrN3euecHQA==
X-Gm-Gg: ASbGncuD2jz3hT0PCO1mL+bsnQwu7wcCs1585G00RTQ71vhGHxmCR2fj6phQeqBbHtk
	Dz03qnBBJrrARR4OwewwDt05KO0rZiJTZ0wVahzhzxmp7NbaZ4ZZbg/vVbHSCBoMjAaSdNGwCQN
	tYcgoeQnD+0FgA5l5j82RgSE7yzJ643sikGgqW76XWtCPSbXDQ50NPba5ZUSCz8NCdDoEYUW12n
	gwNQTxIL+wZH9cm1pSl615AiIif6jwi9iGhNgeNlz/z7CwvUBCOx63P9Th33eB7cfigh5hNZIO1
	ADn2Ji9wxxHtiBU3GpNYrCKIgv/5JUAR9ZzdfyFstW3TN+Klnv89JUf16Voc
X-Google-Smtp-Source: AGHT+IHn+uJYjuY8M2Nva1V1KouNBWF0CmMy1bfuBd7TjqVfBRzBitEz547QJovH6K152xCaP4sDpg==
X-Received: by 2002:a17:907:1b1a:b0:acb:6edd:b255 with SMTP id a640c23a62f3a-ad21928f9famr713521966b.56.1746877891866;
        Sat, 10 May 2025 04:51:31 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2192c83e4sm309435066b.11.2025.05.10.04.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 May 2025 04:51:31 -0700 (PDT)
Message-ID: <f1a11ab3-9209-48a3-976b-9597cbaae02e@gmail.com>
Date: Sat, 10 May 2025 14:51:29 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next 2/2] wifi: rtw88: usb: Upload the firmware in
 bigger chunks
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <af4d2d58-f567-4bdf-841b-8345d21f7035@gmail.com>
 <9faaa45f-9ba8-46dc-b507-f97b3b6f52d3@gmail.com>
 <670259643afc42f581632c7383fa7f3f@realtek.com>
 <0890b8b7-0426-404e-b833-0144b726e17e@gmail.com>
 <0647d3ed8e7945a3807bd3d82c7fd2a6@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <0647d3ed8e7945a3807bd3d82c7fd2a6@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/05/2025 03:43, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 08/05/2025 06:29, Ping-Ke Shih wrote:
>>> : Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>> RTL8811AU stops responding during the firmware download on some systems:
>>>>
>>>> [  809.256440] rtw_8821au 5-2.1:1.0: Firmware version 42.4.0, H2C version 0
>>>> [  812.759142] rtw_8821au 5-2.1:1.0 wlp48s0f4u2u1: renamed from wlan0
>>>> [  837.315388] rtw_8821au 1-4:1.0: write register 0x1ef4 failed with -110
>>>> [  867.524259] rtw_8821au 1-4:1.0: write register 0x1ef8 failed with -110
>>>> [  868.930976] rtw_8821au 5-2.1:1.0 wlp48s0f4u2u1: entered promiscuous mode
>>>> [  897.730952] rtw_8821au 1-4:1.0: write register 0x1efc failed with -110
>>>>
>>>> Maybe it takes too long when writing the firmware 4 bytes at a time.
>>>>
>>>> Write 196 bytes at a time for RTL8821AU, RTL8811AU, and RTL8812AU,
>>>> and 254 bytes at a time for RTL8723DU. These are the sizes used in
>>>> their official drivers. Tested with all these chips.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Link: https://github.com/lwfinger/rtw88/issues/344
>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>
>>> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>>>
>>> [..]
>>>
>>>> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
>>>> index b16db579fdce..ad15ce12ab7f 100644
>>>> --- a/drivers/net/wireless/realtek/rtw88/usb.c
>>>> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
>>>> @@ -165,6 +165,60 @@ static void rtw_usb_write32(struct rtw_dev *rtwdev, u32 addr, u32 val)
>>>>         rtw_usb_write(rtwdev, addr, val, 4);
>>>>  }
>>>>
>>>> +static void rtw_usb_write_firmware_page(struct rtw_dev *rtwdev, u32 page,
>>>> +                                       const u8 *data, u32 size)
>>>> +{
>>>> +       struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
>>>> +       struct usb_device *udev = rtwusb->udev;
>>>> +       u32 addr = FW_8192C_START_ADDRESS;
>>>
>>> FW_8192C_START_ADDRESS is existing already. But something like
>>> RTW_USB_FW_START_ADDRESS would be better.
>>>
>>
>> I agree, because rtw88 doesn't handle RTL8192C. There is
>> FW_START_ADDR_LEGACY in fw.h. I must not have noticed it before.
>> Should I send v2 for this?
> 
> Yes, please. I don't change patch content during committing to prevent mess up
> something. Since you only change the naming, please carry my Ack-by to next
> version.
> 
>>
>>>> +       u8 *data_dup, *buf;
>>>> +       u32 n, block_size;
>>>> +       int ret;
>>>> +
>>>> +       switch (rtwdev->chip->id) {
>>>> +       case RTW_CHIP_TYPE_8723D:
>>>> +               block_size = 254;
>>>> +               break;
>>>> +       default:
>>>> +               block_size = 196;
>>>> +               break;
>>>> +       }
>>>> +
>>>> +       data_dup = kmemdup(data, size, GFP_KERNEL);
>>>
>>> This is because type of argument `data` of usb_control_msg() is not const, right?
>>> Do you know if usb_control_msg() will actually modify the data?
>>>
>>
>> No, it's because usb_control_msg() rejects memory allocated by
>> vmalloc(). I don't remember what error it printed. Maybe because the
>> memory is not suitable for DMA.
> 
> Do you mean firmware is placed in memory allocated by vmalloc()?
> If so, it makes sense to the reason you said. 
> 

Yes.

