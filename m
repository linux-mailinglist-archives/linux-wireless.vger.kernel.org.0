Return-Path: <linux-wireless+bounces-1719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC0C82B10E
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 15:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD60282E1A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 14:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437A94CDEF;
	Thu, 11 Jan 2024 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsJOdL0w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250264CDF8
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e62425c60so3102935e9.3
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 06:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704984726; x=1705589526; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7E9bHs9XH2CBgscyRBfm1uVKGzD4R3hr2HRsqbzvJKQ=;
        b=IsJOdL0wnMEhrMLJYMJ00FuXb8gMQfK7gQuok1qzosCmwoewqLuTsErdYzuya9iu3A
         toc95KeSVMC0ZQt99cMocdwduHj9IYK2iOzggEZc39wiCVeBhWwhFhiZS/96C9SY9jvb
         DZyD7PmN9lweQzeuJQuM63dLvdCJCubrft/+cdmdu/LbpHQB95cwYfdkiMPAO1Hnjbg8
         /2owAVz6Bf3UC+Rw2ESVNyokIRFvdF/gTrv9ZFMPbfrc4JfQeU0cdFPRfTW6X7BQl09R
         2dVKNrWeSUf8NWgSChQAw6E34g7dbJlZhc+wUqhs25ILkUw6dGhnrl+RRGMJKKtZxcLM
         IC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704984726; x=1705589526;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7E9bHs9XH2CBgscyRBfm1uVKGzD4R3hr2HRsqbzvJKQ=;
        b=udZsQhFepzkA8hjzv17uZCSZCN5yURox4CCt5MDAfW3sUDn3KmC+/ws4K43id6FNUX
         iFrtRnvPtCEu4AlIagsqQJWSn5LnbBwM4eTRex0qlMsUW3fyT47ROCzLwdVGo2DyaxRW
         SZ9oA01H6iiqNw/wnSSLMzUC3OKFfaT6kIJ7dS1DkkL3fo+z7GZXWD9MSxgZXYyWSLys
         m0Go6ugoyB5kUb+HCdR98D7Dy4ZzK8X2EgF4cnZynCyawETwNCN3ZUQo3UUSghyQngnx
         gf6KQ7y8qPiVBL/1BTx4/twDE7wTcFjkSS6CUeJm7lOekaz+VtqFCCj/XjntZduyLLBa
         GKMw==
X-Gm-Message-State: AOJu0YzU5HJ8kyBkK0kgmWDOo5AaVuI7zZJIOM+gwl6yqL/EWUpYQ3NT
	k/OdXOQ+5bO8eXAgiIQa4TpxMT/Mfks=
X-Google-Smtp-Source: AGHT+IGxl8+hpNfAwxFg88yIJquHfClHdDoGypSeTXeoX5c8kSLU7dV+xM/oUTTwEN8vmA856dcdWA==
X-Received: by 2002:a05:600c:1e03:b0:40e:50c5:d88b with SMTP id ay3-20020a05600c1e0300b0040e50c5d88bmr525365wmb.14.1704984725966;
        Thu, 11 Jan 2024 06:52:05 -0800 (PST)
Received: from [192.168.1.50] ([81.196.40.51])
        by smtp.gmail.com with ESMTPSA id j42-20020a05600c1c2a00b0040e48e4bf8asm2266623wms.10.2024.01.11.06.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 06:52:05 -0800 (PST)
Message-ID: <26984f36-2f62-4b28-a332-da62a1ea2d3c@gmail.com>
Date: Thu, 11 Jan 2024 16:52:02 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: rtlwifi: rtl_usb: Use sync register writes
Content-Language: en-US
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
References: <400ec3ff-2ab7-469f-b32f-43dfd62621f9@gmail.com>
 <d3468d464cab444f93a347e1b612ebca@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <d3468d464cab444f93a347e1b612ebca@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/01/2024 03:59, Ping-Ke Shih wrote:
> 
> 
>> -----Original Message-----
>> From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> Sent: Wednesday, January 10, 2024 9:47 PM
>> To: linux-wireless@vger.kernel.org
>> Cc: Ping-Ke Shih <pkshih@realtek.com>; Larry Finger <Larry.Finger@lwfinger.net>
>> Subject: [PATCH v2] wifi: rtlwifi: rtl_usb: Use sync register writes
>>
>> Currently rtl_usb performs register writes using the async
>> usb_submit_urb() function. This appears to work fine for the RTL8192CU,
>> but the RTL8192DU (soon to be supported by rtlwifi) has a problem:
>> it transmits everything at the 1M rate in the 2.4 GHz band. (The 5 GHz
>> band is still untested.)
>>
>> With this patch, rtl_usb performs the register writes using the
>> synchronous usb_control_msg() function, and the RTL8192DU works
>> normally. The RTL8192CU still works.
>>
>> The vendor drivers use the async writes in only one function,
>> rtl8192du_trigger_gpio_0 / rtl8192cu_trigger_gpio_0, which probably
>> doesn't even run in real life. They use sync writes everywhere else.
>>
>> Also, remove "sync" and "async" from the names of the members of
>> struct rtl_io to avoid confusion:
>>
>> write{8,16,32}_async -> write{8,16,32}
>>  read{8,16,32}_sync  ->  read{8,16,32}
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
>> ---
>> v2:
>>  - Rename the members of struct rtl_io.
>> ---
>>  drivers/net/wireless/realtek/rtlwifi/pci.c  |  12 +-
>>  drivers/net/wireless/realtek/rtlwifi/usb.c  | 163 ++++++--------------
>>  drivers/net/wireless/realtek/rtlwifi/wifi.h |  30 ++--
>>  3 files changed, 66 insertions(+), 139 deletions(-)
>>
> 
> [...]
> 
>> @@ -114,18 +51,15 @@ static int _usbctrl_vendorreq_sync_read(struct usb_device *udev, u8 request,
>>         } while (++vendorreq_times < MAX_USBCTRL_VENDORREQ_TIMES);
>>
>>         if (status < 0 && count++ < 4)
>> -               pr_err("reg 0x%x, usbctrl_vendorreq TimeOut! status:0x%x value=0x%x\n",
>> -                      value, status, *(u32 *)pdata);
>> -       return status;
>> +               pr_err("reg 0x%x, usbctrl_vendorreq TimeOut! status:0x%x value=0x%x reqtype=0x%x\n",
> 
> nit: Since you touch this, would you like to use dev_err() instead?
> 
Sure, I can do that.

>> +                      value, status, *(u32 *)pdata, reqtype);
>>  }
>>
> 
> [...]
> 


