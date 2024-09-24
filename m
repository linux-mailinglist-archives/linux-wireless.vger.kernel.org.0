Return-Path: <linux-wireless+bounces-13128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF605984CA5
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 23:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3EA1F22013
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Sep 2024 21:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13AB12D758;
	Tue, 24 Sep 2024 21:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O881cHYd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20857139D
	for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 21:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727212779; cv=none; b=U7LMUiJNtEZiL0XliEY6VguZSdvXXWQD3Cr9amkdsfY6F98ml/4ooRhsHJooeHwN5eF6/p5lZC2bP1wuP0sxqEhwk+0s6DRqXfNTncsRjBrWYno80pD1hZ2R01tPy5dNkPfLuuV9lQvclIT79tpX7H63u++yesCs+/H7cjI0cdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727212779; c=relaxed/simple;
	bh=YdrUWO2SxbbRT19GcQspuAK5vxwcu7bmx7l8Q3N3mRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WtOFHU+UPD8gsv49xouUdHQLDCPgwe2Gr5ZtmyZQQrvMBDVGw1+H6NuPDzZhRsz4wRxsMbEmoc8/lsVI7mykIRSHgZb6axHWS0VgX97u4XigDWHZsEjrlO4pAIWylyZqaHzhLdX473L05Z01cFxb/SoG5heJZ4WhxhHG3o9Qfuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O881cHYd; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c42e7adbddso7925134a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 24 Sep 2024 14:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727212776; x=1727817576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ak/CEYREmPrBG/r8L5en9z0ieDGpcHqp0gwQtXV1UYk=;
        b=O881cHYdatb91donX6hBoTITTqwysndOLbiuzujS5dEr2+Ho1lTsXHNc7uZ7jiGwlS
         Uzglyck79VtRRaMRO4ICae1uxfuWUfO8rz5FB2w9F94wE41ISfpp3w73VdAkDFlCx5nn
         hM7d5LRhRgYfB7gHaB8kve2taNANkxlS1fVpZTZanOG10CaAh8ViUfbcFzppPA/USWFc
         4xw8EFtV2S03R9EheUwcp8uoLSyT92QgkykcaHEB3mBOMQ8dVeN0iIyvBLf7yGoVFYZX
         klMuPXUA6U81EbIq+7FKn+IqW8hBl5QBE+4OmgmvHgZrie6EkNBZ7CBVS3Dinb3zvuZ1
         tSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727212776; x=1727817576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ak/CEYREmPrBG/r8L5en9z0ieDGpcHqp0gwQtXV1UYk=;
        b=KmZxT/wLWTGGcXC07c8iHRpC1oHLX+F1vWyV5d7iWTYo1+GJoNXtrTHgheQbpnnYUy
         tC1Fog9YNf87sWRgPKj1p6PEwd3SIQoFq5N/TLvupz8b068yiThvqmgqgF0SdLFNnzPa
         ejEH2m8mhUfUL3dqUWzl3JWqsuHQ7ihFwoOFQ+UPS6vIzl08KsfEhRNK18Y/spn7iZWl
         Jo32BRqiVaKq7MeLaUvOWlSZvgpqRpoC6Y7Uokwh0GGUqUVnMBjMcgKLUXw4ACuevu4e
         eeAa0QnSzJWE7uJp9dPUxvIY+qMsoawJv2WMIkvvYssrvbjyC6envvEpl42/Tj2wokwc
         hAuA==
X-Forwarded-Encrypted: i=1; AJvYcCUZCc0DTq7365yhsCR1VVKeAD7F39VR5X341IIwKklwVucPIm6BMl1m9Fefjf4nXLV+ivTGdNEkzsKbHge5cw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWhaOQO/IcoXY+5VRrzZafFcarih7x63JUxOEMt62MOa9Phpof
	8WGgJw48vVx3tXHA9VS1RsvkxH310Weo71qXeH2iGwCYrzucYp+N7PNt5Q==
X-Google-Smtp-Source: AGHT+IG406IcM3yPQrQO+wYeuIqMsl1KyUDvVbvPkezwk1QF6p86HVbN4GQhtBsx+/L7MlN8uo6paQ==
X-Received: by 2002:a17:907:6d23:b0:a8d:25d3:65e4 with SMTP id a640c23a62f3a-a93a03f65b7mr48718066b.36.1727212775992;
        Tue, 24 Sep 2024 14:19:35 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f3429csm132278666b.36.2024.09.24.14.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 14:19:35 -0700 (PDT)
Message-ID: <b4c9ff5c-a8ca-401f-aa79-3798239ffd57@gmail.com>
Date: Wed, 25 Sep 2024 00:19:34 +0300
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
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <73de8e7135554ae9a0f7968780644515@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/09/2024 08:47, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>>>>>> +
>>>>>>>> +const struct rtw_chip_info rtw8812a_hw_spec = {
>>>>>>>
>>>>>>> Is it possible moving 8812a to individual file?
>>>>>>> Since you have rtw8812au.c and rtw8821au.c.
>>>>>>>
>>>>>>
>>>>>> I think it is possible. But most of the code is common to both chips.
>>>>>> Only the IQ calibration could be moved.
>>>>>
>>>>> Yep, depend on how much IQK code echo chip has.
>>>>>
>>>>
>>>> The IQ calibration for RTL8812AU is about 700 lines.
>>>
>>> rtw8812au  -----> (a) rtw8812a
>>>                         |
>>>                         v
>>>                   (b) rtw8821a_common  (hard to give a name)
>>>                         ^
>>>                         |
>>> rtw8821au  -----> (c) rtw8821a
>>>
>>> Put all common code to (b). IQK code in (a) or (c).
>>>
>>> I feel you have thought above picture already. What are problems we will encounter?
>>> Many export symbols? If so, how about below?
>>>
>>> rtw8812au  -----> (1) rtw8812a
>>>     +---------+
>>>               +-> (2) rtw8821a_common  (hard to give a name)
>>>     +---------+
>>> rtw8821au  -----> (3) rtw8821a
>>>
>>> Put rtw8812a_hw_spec and rtw8821a_hw_spec in (2). Only IQK code in (1) and (3)
>>> respectively, and export IQK entry only. Does it work?
>>>
>>>
>> For the name of the common module, I was thinking rtw88_88xxa.ko.
>>
>> I wonder, what is the goal? To put the code in separate kernel
>> modules, or just separate files?
> 
> I would like to reduce runtime memory. As I asked, how many IQK code are different
> from them? If you have separated and compiled them, can you share size by the
> output of 'size' command? 
> 

I separated the IQK code into two files (still just one module).
size says:

   text    data     bss     dec     hex filename
   7192      32       0    7224    1c38 rtw8821a-iqk.o
  12319      40       0   12359    3047 rtw8812a-iqk.o

This is x86_64.

>>
>> I think we can have rtw88xxa.c (common code), rtw8821a.c (IQK code,
>> rtw8821a_hw_spec, bluetooth stuff), and rtw8812a.c (IQK code,
>> rtw8812a_hw_spec, some efuse stuff, channel switching)... if these
>> three files compile into a single module, rtw88_88xxa.ko.
>>
>> If each file compiles into a module of its own, we have circular
>> dependencies: rtw8821a_hw_spec -> common code -> IQK code.
>> If *_hw_spec go in the common module, it still depends on both of
>> the other two modules, so what use is it?
> 
> If we have dependency of common code -> IQK code, we can't save runtime
> memory, because common code reference to both IQK code. So I felt
> dependency of IQK code would be rtw8812au --> IQK code as above second
> diagram. 
> 
> But if the work is complicated and save not few runtime memory, we can
> use simple design as current did. 
> 
> 

The IQK code can be separated into different modules if I duplicate
rtw8821a_ops and rtw8821a_pwr_track, and rtw8821a_phy_pwrtrack takes
a pointer to the IQK function. Then your first diagram above can work.

The tables also take up a bit of space:

  text    data     bss     dec     hex filename
  16832       0       0   16832    41c0 rtw8821a_table.o
  21552       0       0   21552    5430 rtw8812a_table.o

I don't know how many kilobytes is enough to make it worth
creating two more modules.

