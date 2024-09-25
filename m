Return-Path: <linux-wireless+bounces-13146-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AADE9857F9
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 13:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CAA11F21597
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 11:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64AD78B50;
	Wed, 25 Sep 2024 11:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FS0DNDLn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02E86FDC
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727263743; cv=none; b=lb9UDUj9AEWi1ePdAdpGUWLRW6lCiVzfOPN0akl48p/X5NE+cronQhUVoDP+EcaRwqzFNeGLhXjFwg1nnuyVDODWY2cs+ILaF4V1O91OgerGnGdB6tqDJzBxVhIyF1IZO8Jcc6n0ILE6XdA/8gNDSZGARtHQKUyrVye/XLR1QOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727263743; c=relaxed/simple;
	bh=wiAhu38/lZACRlv5pXXy3jtwSC4Oq3wSBLHfPfizgRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PEVJ8rMP4N/vSo8VgRSiijfyJCwuA3Zg7QaUPm8J8D/rbREZI2XVlOswpStoKGy+JZw9NsPHV0787EjdZ7j+mv3S1sdsp+Cv6Vaq5FCj0mKUCZJZllJNeRmGGg1hXmjK26edl59p9bMw+fPeUwZWkeQococTyHGQZnwipl5GSvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FS0DNDLn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so63066555e9.3
        for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 04:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727263740; x=1727868540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQL6xWa9HHBUaHaRglGfs0VlwV9GZStm9rjfA5XbkBs=;
        b=FS0DNDLne3+zlM0NQNtyxT7szr/B3qofkkZNc/RtaVz5YghAAOO4PlRhZF7JnDJFob
         sweOKFbFUEiQudU1G1VatkyUiXgeov92P9CDPZopvCL8g/tdTkLKSyw4NJJ2eNddultJ
         pW1E2Lk6OHODFDEWeuVHkN27wCWriu8w82fCR0S/07PrmZJCzXTFXLOvijtyysCDbQGe
         xVDrQSmfM/wZJLw5H04XHsvBRqrBn5EaEtVB7rqe7WAX/G3qKjZ7OCMtfpEjUuJY+2zO
         i3gKbVx++IL3j3Il3IquYDaRNqg73hnzzmFGX6MzzwenBEXttNGN5E8dieGKBk7sDzg/
         ZpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727263740; x=1727868540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IQL6xWa9HHBUaHaRglGfs0VlwV9GZStm9rjfA5XbkBs=;
        b=bmqd1UpmGJR4NkTHeokZLcZJ7bkEiWJquGSt21bwvcA7047mI31jQwSExr191rwrpT
         1edWxieXZESBgUQI7akT52jB7bAJqum4+Bkb3hN8t907Y8v2FWoyEPh5qFUExpoddBHp
         QbM+RXvq69aPI9HrEZjkvNekvS3MikDCwiYXdir3lYvLFKvofH+kd6KKWbcJgTYHTfpB
         UU1KljnLC+lB61/ZFEgxWLhhHcUq8g2cHAoP4oDCQkmTMRIAuh6MXcUJXt2HhKfEaRof
         HUNMG/FZxk4iQujnCwe53/499K29/RRmUfDPxWhrJB7Z49GVQbam+auk6NhecfBBMxv0
         8KTg==
X-Forwarded-Encrypted: i=1; AJvYcCXtM2YEwUZAhYM16OWkK7U/O18QpBl9l5UP1uzKTiLggMCphuRYQoSwMSMiqLejuxxDGaNjflmpdA3zV4ggeg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxvAAu31SnjytLaZDfCB5BoqxKAjHTDUcCLTUd41NOzLgemcPjs
	CHj1bMLjTyeB+239bsYnwlbaqfSxYfKMdAKVlpfFa3pEaBVsptlM
X-Google-Smtp-Source: AGHT+IGFd/mQeW+O6VbaXNREenRP3gAWL0dXWWhGxGhPtGHQQMy8pYQQ1iKpDwt2JjqU3Efmt9PO8w==
X-Received: by 2002:a05:600c:4f0f:b0:42c:ba1f:543e with SMTP id 5b1f17b1804b1-42e9613635amr16206295e9.26.1727263739784;
        Wed, 25 Sep 2024 04:28:59 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e9027450asm38837835e9.0.2024.09.25.04.28.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 04:28:59 -0700 (PDT)
Message-ID: <d621b3ed-86f5-40d4-b826-79615a2def6e@gmail.com>
Date: Wed, 25 Sep 2024 14:28:56 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/20] wifi: rtw88: Add rtw8821a.{c,h}
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <f25d00ab-4481-4540-956b-bc1028a501e1@gmail.com>
 <e365c61d730d4f49915b543dcb0063d5@realtek.com>
 <dafaac0c-fb55-4406-b8ff-69aa66d3fd06@gmail.com>
 <1aca96c68f914f90b6d1baf8780e6ce4@realtek.com>
 <bebaa40a-1c7a-4b1e-99cd-7c7aac7c76f4@gmail.com>
 <f583e9470ca84234ad2e00f3a0371664@realtek.com>
 <38553e79-6747-4ab3-9bf4-fa7f2af852cd@gmail.com>
 <73de8e7135554ae9a0f7968780644515@realtek.com>
 <b4c9ff5c-a8ca-401f-aa79-3798239ffd57@gmail.com>
 <9c991498a48043d0b0b06dc05356cbae@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <9c991498a48043d0b0b06dc05356cbae@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/09/2024 04:25, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 23/09/2024 08:47, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>>>>>>>> +
>>>>>>>>>> +const struct rtw_chip_info rtw8812a_hw_spec = {
>>>>>>>>>
>>>>>>>>> Is it possible moving 8812a to individual file?
>>>>>>>>> Since you have rtw8812au.c and rtw8821au.c.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I think it is possible. But most of the code is common to both chips.
>>>>>>>> Only the IQ calibration could be moved.
>>>>>>>
>>>>>>> Yep, depend on how much IQK code echo chip has.
>>>>>>>
>>>>>>
>>>>>> The IQ calibration for RTL8812AU is about 700 lines.
>>>>>
>>>>> rtw8812au  -----> (a) rtw8812a
>>>>>                         |
>>>>>                         v
>>>>>                   (b) rtw8821a_common  (hard to give a name)
>>>>>                         ^
>>>>>                         |
>>>>> rtw8821au  -----> (c) rtw8821a
>>>>>
>>>>> Put all common code to (b). IQK code in (a) or (c).
>>>>>
>>>>> I feel you have thought above picture already. What are problems we will encounter?
>>>>> Many export symbols? If so, how about below?
>>>>>
>>>>> rtw8812au  -----> (1) rtw8812a
>>>>>     +---------+
>>>>>               +-> (2) rtw8821a_common  (hard to give a name)
>>>>>     +---------+
>>>>> rtw8821au  -----> (3) rtw8821a
>>>>>
>>>>> Put rtw8812a_hw_spec and rtw8821a_hw_spec in (2). Only IQK code in (1) and (3)
>>>>> respectively, and export IQK entry only. Does it work?
>>>>>
>>>>>
>>>> For the name of the common module, I was thinking rtw88_88xxa.ko.
>>>>
>>>> I wonder, what is the goal? To put the code in separate kernel
>>>> modules, or just separate files?
>>>
>>> I would like to reduce runtime memory. As I asked, how many IQK code are different
>>> from them? If you have separated and compiled them, can you share size by the
>>> output of 'size' command?
>>>
>>
>> I separated the IQK code into two files (still just one module).
>> size says:
>>
>>    text    data     bss     dec     hex filename
>>    7192      32       0    7224    1c38 rtw8821a-iqk.o
>>   12319      40       0   12359    3047 rtw8812a-iqk.o
>>
>> This is x86_64.
>>
>>>>
>>>> I think we can have rtw88xxa.c (common code), rtw8821a.c (IQK code,
>>>> rtw8821a_hw_spec, bluetooth stuff), and rtw8812a.c (IQK code,
>>>> rtw8812a_hw_spec, some efuse stuff, channel switching)... if these
>>>> three files compile into a single module, rtw88_88xxa.ko.
>>>>
>>>> If each file compiles into a module of its own, we have circular
>>>> dependencies: rtw8821a_hw_spec -> common code -> IQK code.
>>>> If *_hw_spec go in the common module, it still depends on both of
>>>> the other two modules, so what use is it?
>>>
>>> If we have dependency of common code -> IQK code, we can't save runtime
>>> memory, because common code reference to both IQK code. So I felt
>>> dependency of IQK code would be rtw8812au --> IQK code as above second
>>> diagram.
>>>
>>> But if the work is complicated and save not few runtime memory, we can
>>> use simple design as current did.
>>>
>>>
>>
>> The IQK code can be separated into different modules if I duplicate
>> rtw8821a_ops and rtw8821a_pwr_track, and rtw8821a_phy_pwrtrack takes
>> a pointer to the IQK function. Then your first diagram above can work.
> 
> Not sure the "duplicate" you meant. If it only a struct, that would be fine.
> Not prefer duplicate of tables.
> 

Yes, it's a struct rtw_chip_ops.

>>
>> The tables also take up a bit of space:
>>
>>   text    data     bss     dec     hex filename
>>   16832       0       0   16832    41c0 rtw8821a_table.o
>>   21552       0       0   21552    5430 rtw8812a_table.o
> 
> Good point. 
> 
>>
>> I don't know how many kilobytes is enough to make it worth
>> creating two more modules.
> 
> I think we can list all *.o related to rtw8821a/8812a, and check the
> percentage to make decisions. I mean if it occupies 50%, I will prefer
> to have separated module. But I don't have an exact number now. 
> 

   text    data     bss     dec     hex filename
  12319      40       0   12359    3047 rtw8812a-iqk.o
  21552       0       0   21552    5430 rtw8812a_table.o
   7192      32       0    7224    1c38 rtw8821a-iqk.o
  16832       0       0   16832    41c0 rtw8821a_table.o
  29445     429       0   29874    74b2 rtw8821a.o
=========
  87340 total. So it's about 38% for 8812a and 27% for 8821a.
Maybe a bit more in the final version.

