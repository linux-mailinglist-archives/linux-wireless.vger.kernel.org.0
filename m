Return-Path: <linux-wireless+bounces-23519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C080AC9CCC
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 23:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA33F3B8A76
	for <lists+linux-wireless@lfdr.de>; Sat, 31 May 2025 21:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5171714B2;
	Sat, 31 May 2025 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo/aQNcj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B41610D
	for <linux-wireless@vger.kernel.org>; Sat, 31 May 2025 21:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748725433; cv=none; b=ehl98CIAHlOlEzqfQ8qKn6A9c6sWpHHpzKQv+yiW+Za7ToZBq8n8rboKxtSVZxxzrYbKrw27XTM5rOkGXl/Q+Grtmt1EhqNC0QRvk+WS6B+hl4ec5NdlRQJPB73AoxQ3ztI3uK34etVCDgDxUFiQfFXErdBvY3GuYQR4GF93I1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748725433; c=relaxed/simple;
	bh=u/gMTzx5eA3y9tc9iUdljsKDCug5alRUvMgqv/qaC0s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=Li15/tAzaiKflukqvhQrcpCIkGqFmjVeLvXnCxNC+qyNZcAL73q3YZGemqhJwPOzjX/WAf4gNjpVCL/Lvl3DW/uB/2+D11BEDHmyn/x6UmQCtGi9OCHMm+jpdFpROnQi9rLj0pZMxTk2ZsNE73rQAWtz5NqhwZHvihz9JKTPEuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zo/aQNcj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a4d877dfb3so3322334f8f.1
        for <linux-wireless@vger.kernel.org>; Sat, 31 May 2025 14:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748725430; x=1749330230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aKN3s7VEW4vyMIU1zME6A4/yFAR52WBFASZs7HZrq0U=;
        b=Zo/aQNcjbJMsuaPkLyA8oGH7QmDokg4UuTyFZ13pYxkTMbLkicvVdFO/wHQOfE8aup
         zyLzW6zuOexocLlWiRHBjQSY5w77WGKjrSLCx8dkShhQ4hEIgEgO2DtpuVO1RpVqEkD0
         Uw+r2VNcMtdH74hxKRLLTlTp4nh4FttY7OQd/pAhW7Yo0yE6ZMuvoYhI4jDJguRt4I8o
         qgTedPJNMoN4GRmsKZvEkDtwHfTxMMoeOdL08r9ZV/Y4gXpxdSWamZZp0sSDSMVMEHnV
         4OS2/ee9/wAGzH4zqEY2mIJR4RtOqaVDEOv0eK3weI949FSHAz543W4apf+u30eoEFbc
         4GcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748725430; x=1749330230;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKN3s7VEW4vyMIU1zME6A4/yFAR52WBFASZs7HZrq0U=;
        b=HAqgY4K6SSrNYEHtJRPUsr2fIXVC7Sz+ejzQ13moQO+TJigrnVxeH0cqr0Vu7yg3sp
         sbrULHvl78tbZRv9JJnqLS3EL+Lq0G1ZjqrRFBSJ3s0M89YQU1pfdCpBK7rEbRowwqVz
         5jWvD1gfuQMre9LmSyo9/WFpgWCfuS121DxQAE6ip3wi+86kIUMtqT6qvy3LNKWhqOEY
         hgemfqadMb6RPftOEzvRJtjFpDcGDAp0UuRNKhjw5dinlSF2EwrusjKFqYFLVfzTMrF3
         2AW22aYLaPIOhojd2pbFZc8r7a5Tgl0Ag64GUaDdZU+rBC5gvRdqJdVMCtNl+D7cyzsZ
         QA6g==
X-Forwarded-Encrypted: i=1; AJvYcCUnCClZRSeuMX2c1Tb0v4LyrPJQyxy542OzUakEIy82/4RumIRE9Y5WhSyWTSnIoVKJM9sI0s7KWsthN8L+Vg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJerYEn9TF2UyO4aTtYbpdRrHTW8U9egu9vU+ewRWI/GMFFrYg
	kQJDBi2j9wMfpGrRXk2xg/dhuCku9d85ojIeJa9VDbUB9am+I6usunU1IEHRLA==
X-Gm-Gg: ASbGncsVMIkBL46tNA+qgG6exQ23lXMnYSK2St7lvs4WIfLYEtvQ+6Gc1bR1hC8rY91
	i0nnRJ9JyFfONWrIaO0OiPu9NM5KkMheofSXvU3gnnnSCXaUCdvWdaO4fCx5Ix01wsqHJtmFSMW
	fYqAhLDQzb/hn9DiioqsegkVk4eiqq74TS5bbEY+b+1p5ih+/A54sixAeRfmJVbex+3vtl/2ILe
	HLXMqayRdAVPs1s85DFGKp3tYBKZuPhv7gF0Zd4aaesJd7B0YVa0279X99tpq5akT3DAlW3raaj
	+SHeKP1XPdXzSGWV5HPFjy3F1TFUvdT7uUT+t77NBlRSnED0sBiWjK4H8KY=
X-Google-Smtp-Source: AGHT+IGeitAZHmnxhYTHircqq6NaYB5jfU3y8zvce32UL3CVUNWGKFi456MhsLywPNcWkgdwCsjk6g==
X-Received: by 2002:a5d:5f45:0:b0:3a4:e706:52f5 with SMTP id ffacd0b85a97d-3a4fe169afemr2416208f8f.13.1748725429719;
        Sat, 31 May 2025 14:03:49 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45048816a08sm103036765e9.0.2025.05.31.14.03.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 May 2025 14:03:49 -0700 (PDT)
Message-ID: <186e841f-54d7-460e-92e1-3e7aee3d3744@gmail.com>
Date: Sun, 1 Jun 2025 00:03:48 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw-next v1 11/13] wifi: rtw89: Add usb.{c,h}
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <9a3d63a2-2a8f-4f1d-a9cb-b79c255c1a51@gmail.com>
 <60b78caaf3c049a1a5595bb89d553777@realtek.com>
 <f9f205bb-9084-42c0-9942-533d2787fd13@gmail.com>
 <5d96c9b2693143f7914dca322e518435@realtek.com>
Content-Language: en-US
In-Reply-To: <5d96c9b2693143f7914dca322e518435@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/05/2025 06:18, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 13/05/2025 09:12, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>> Add very basic USB support. No TX/RX aggregation, no TX queues, no
>>>> switching to USB 3 mode.
>>>>
>>>> RTL8851BU and RTL8832BU work.
>>>>
>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>> ---
>>>>  drivers/net/wireless/realtek/rtw89/usb.c | 1030 ++++++++++++++++++++++
>>>>  drivers/net/wireless/realtek/rtw89/usb.h |   61 ++
>>>>  2 files changed, 1091 insertions(+)
>>>>  create mode 100644 drivers/net/wireless/realtek/rtw89/usb.c
>>>>  create mode 100644 drivers/net/wireless/realtek/rtw89/usb.h
>>>>
>>>> diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
>>>> new file mode 100644
>>>> index 000000000000..6e8a544b352c
>>>> --- /dev/null
>>>> +++ b/drivers/net/wireless/realtek/rtw89/usb.c
>>>> @@ -0,0 +1,1030 @@
>>>> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>>>> +/* Copyright(c) 2025  Realtek Corporation
>>>> + */
>>>> +
>>>> +#include <linux/usb.h>
>>>> +#include "debug.h"
>>>> +#include "mac.h"
>>>> +#include "reg.h"
>>>> +#include "txrx.h"
>>>> +#include "usb.h"
>>>> +
>>>> +static void rtw89_usb_vendorreq(struct rtw89_dev *rtwdev, u32 addr,
>>>> +                               void *data, u16 len, u8 reqtype)
>>>> +{
>>>> +       struct rtw89_usb *rtwusb = rtw89_get_usb_priv(rtwdev);
>>>> +       struct usb_device *udev = rtwusb->udev;
>>>> +       unsigned int pipe;
>>>> +       u16 value, index;
>>>> +       int attempt, ret;
>>>> +
>>>> +       value = addr & 0x0000ffff;
>>>> +       index = (addr & 0x00ff0000) >> 16;
>>>
>>> u16_get_bits(addr, GENMASK(23, 16)) ?
>>>
>>>
>>>> +
>>>> +       mutex_lock(&rtwusb->vendor_req_mutex);
>>>
>>> rtw89 takes wiphy_lock for control path. Is there any case more than
>>> one threads run at the same time?
>>>
>>
>> Maybe not. I just copied this from the vendor driver. How can I be
>> sure only one thread runs?
> 
> For rtw89, currently all ieee80211_ops take wiphy_lock except to TX related
> ops. The works forked by rtw89 use wiphy works basically. Some works still 
> use ieee80211 works only if they only set a simple flags or so. 
> 
> Here, I would like to avoid adding unnecessary mutex at development stage,
> because it is hard to remove a mutex with simple review. You can see only 
> one existing mutex is 'struct mutex rf_mutex'. I want to remove it, but
> I'm still afraid that I miss something by review. 
> 
>>
>> I added this above the mutex_lock() today:
>>
>>         if (mutex_is_locked(&rtwusb->vendor_req_mutex))
>>                 pr_err("mutex already locked elsewhere\n");
>>
>> So far it hasn't printed the message.
> 
> Not sure if this function depends on lock debugging of kernel options.
> 

I checked, mutex_is_locked() works with my Arch Linux kernel.

> By the experiments, this mutex seems to be unnecessary, right?
> 

Yes, it looks unnecessary.

