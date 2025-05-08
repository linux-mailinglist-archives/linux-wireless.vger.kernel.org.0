Return-Path: <linux-wireless+bounces-22756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A803AB00CA
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 18:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6558A1C0379F
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 16:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE01283148;
	Thu,  8 May 2025 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKafBGhJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53CC278E42
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 16:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746723539; cv=none; b=g1mXHuSPg86oOsCgYpTx3QGQWIWzJbL/794ijog7Bn7Z7IgrXlCkRpmPBVMDS/XIm+1Svqm/7AZbvsbeoJvM0VosHw8a39Pi+5NArY2X+3InC5rL5i5wWqaRKzdd22Fx53Z9+PiKMdFHyw2u63vMsBUI8BRoMEXyp2fYb97iUgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746723539; c=relaxed/simple;
	bh=LedG43Uj2lo44/KgzdsMBaSPayLVIdnJOy4nnNI2yyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a417RBM9KU4vOh3dAOr3tlr/l/kwpX8JL4HIMBl3lRR3bE6VPgjx+uL6It7aSyUkBZ77Y2o/JxzA1TWYb14r5iOI//0Flb5hYB3tE8kG/sExSZ3pgHuw5XQZUcEiW7r9KPNp1OkgOyYlo/3OUwUN7Gmeqa3JZ15hQajzOiifadA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKafBGhJ; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5f624291db6so1928912a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 08 May 2025 09:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746723535; x=1747328335; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tr8HFCWXqvJ0O9IUmbzJCUVwaUN4z3DFygbfJwdUZbE=;
        b=UKafBGhJHH9ayETAoRugpXsjsB5ExZoyZwOOEQI90uZ5UKK9RekUEeBJfMkS9TmayN
         bdezCQe8hIaVJzaQB5Cxvzm+AJL93uIfyODcOnMsRSKVb6V2lGT6a1dbvGWP0Ig+cZD4
         5tzaVwnt/BBV/XNycf1aoW0ftW66bERfDUH1/FJvrrBExTvpNL/h6g7z8gfVzHsckIBh
         +Jl2p1JbxIpYKlsqjeIrG8BYStXP65EtTz7iKrH8Ihw9ccDqUlXjEv3DLQnKD0vi91mH
         QqZLTaVWXQ2efvkl/3gbu5B37KouL+w8L2ZkL3N7QNOymHSCXi/0zu3slqhTCRCEPgBg
         jucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746723535; x=1747328335;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tr8HFCWXqvJ0O9IUmbzJCUVwaUN4z3DFygbfJwdUZbE=;
        b=xNZ9VkSYYnKnv4Z8ZJ559eY1tB+t/nXKGClEvn9whprH9p18QMN0lccuFUbjh1SWOB
         9s2OeVUyBxdkLKk5cV+sosx6/JHhFxKw0/zRumKzMmOUwYSJL+yTgNnvMiPBKIhixmIm
         LePXh/wsIg28UMF9+j0jvC146ldfKGF4uz056z12Prdm9eYfWR5rrV9JxMhbOYUluhFZ
         SJLs+wq5Pbmcbzkp5tqcohylO47tm3MqgClWG6gtBazJm62NSrXLByXvZNKoBBJ0z6a8
         ELwQxXTRGkikrVGYBfm37J/uiqJWvw47MLxPLeANnsqNuA+8eOiQbKuuLGJQhzcN2Ffs
         Ph5A==
X-Forwarded-Encrypted: i=1; AJvYcCXlRklq81uzp7n6n2nTf58fjhBZGx5Ovb+wfBQsl+BJkhNC0G8eXEqfZtoSBiaa7mM8ZH6xa0e0V+J7OrygNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyojgiJjTir0NEPjim+V+k/ia0c5via0XRbt3opPt8PASArNtEz
	j5sYrZo8cU+sfw99+uYpDH6FeCX6k5Tmkowqqb8cgXnYpWJ/vB+t
X-Gm-Gg: ASbGncuC07Al4G2kIBIDLJ6RXlgql9zl0+I5qbvbrHiC/DNniuWNPyOJsZ6AkSWSWSo
	WXpAh/+IGxCGeKslDwHP0PEtMJ5/a/gFZRlK9bN52u9rob4vlork/NxUjV1JdphOrFMW4qI39Jn
	LxVbhKvaS+L9wxasZCeuhRL1kIyfiKKsBkCDvHO/np0AZ4AwTkExG3gAdKO0yf1cfEiGeMvQz3i
	c/CxgAniiUq4jjN+tsU8tyJ41m+MjMWnX0afQfT7WHV/vmX6ISGNafNeSyciGpTMI+w4P0lJbVx
	VjboOT6qowxdliYraAWY1pLveY9AHmeFl3mymV1KGRfLDDWeIC+LRa/ck11H
X-Google-Smtp-Source: AGHT+IFD8Mj7cWkAaBSnVMBU8hPurD5LVZaGrrFdYmfB9rLz4xCTASzli2KJIS6EcWuv3LwJ7qJzCA==
X-Received: by 2002:a05:6402:27d2:b0:5ec:c990:b578 with SMTP id 4fb4d7f45d1cf-5fca0797656mr40188a12.19.1746723534983;
        Thu, 08 May 2025 09:58:54 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.158])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe516asm131216a12.15.2025.05.08.09.58.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 May 2025 09:58:54 -0700 (PDT)
Message-ID: <0890b8b7-0426-404e-b833-0144b726e17e@gmail.com>
Date: Thu, 8 May 2025 19:58:53 +0300
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
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <670259643afc42f581632c7383fa7f3f@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/05/2025 06:29, Ping-Ke Shih wrote:
> : Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> RTL8811AU stops responding during the firmware download on some systems:
>>
>> [  809.256440] rtw_8821au 5-2.1:1.0: Firmware version 42.4.0, H2C version 0
>> [  812.759142] rtw_8821au 5-2.1:1.0 wlp48s0f4u2u1: renamed from wlan0
>> [  837.315388] rtw_8821au 1-4:1.0: write register 0x1ef4 failed with -110
>> [  867.524259] rtw_8821au 1-4:1.0: write register 0x1ef8 failed with -110
>> [  868.930976] rtw_8821au 5-2.1:1.0 wlp48s0f4u2u1: entered promiscuous mode
>> [  897.730952] rtw_8821au 1-4:1.0: write register 0x1efc failed with -110
>>
>> Maybe it takes too long when writing the firmware 4 bytes at a time.
>>
>> Write 196 bytes at a time for RTL8821AU, RTL8811AU, and RTL8812AU,
>> and 254 bytes at a time for RTL8723DU. These are the sizes used in
>> their official drivers. Tested with all these chips.
>>
>> Cc: stable@vger.kernel.org
>> Link: https://github.com/lwfinger/rtw88/issues/344
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> [..]
> 
>> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
>> index b16db579fdce..ad15ce12ab7f 100644
>> --- a/drivers/net/wireless/realtek/rtw88/usb.c
>> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
>> @@ -165,6 +165,60 @@ static void rtw_usb_write32(struct rtw_dev *rtwdev, u32 addr, u32 val)
>>         rtw_usb_write(rtwdev, addr, val, 4);
>>  }
>>
>> +static void rtw_usb_write_firmware_page(struct rtw_dev *rtwdev, u32 page,
>> +                                       const u8 *data, u32 size)
>> +{
>> +       struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
>> +       struct usb_device *udev = rtwusb->udev;
>> +       u32 addr = FW_8192C_START_ADDRESS;
> 
> FW_8192C_START_ADDRESS is existing already. But something like
> RTW_USB_FW_START_ADDRESS would be better. 
> 

I agree, because rtw88 doesn't handle RTL8192C. There is
FW_START_ADDR_LEGACY in fw.h. I must not have noticed it before.
Should I send v2 for this?

>> +       u8 *data_dup, *buf;
>> +       u32 n, block_size;
>> +       int ret;
>> +
>> +       switch (rtwdev->chip->id) {
>> +       case RTW_CHIP_TYPE_8723D:
>> +               block_size = 254;
>> +               break;
>> +       default:
>> +               block_size = 196;
>> +               break;
>> +       }
>> +
>> +       data_dup = kmemdup(data, size, GFP_KERNEL);
> 
> This is because type of argument `data` of usb_control_msg() is not const, right?
> Do you know if usb_control_msg() will actually modify the data?
> 

No, it's because usb_control_msg() rejects memory allocated by
vmalloc(). I don't remember what error it printed. Maybe because the
memory is not suitable for DMA.

