Return-Path: <linux-wireless+bounces-4709-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C769A87B487
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 23:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DF58B20F84
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 22:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F81B59B56;
	Wed, 13 Mar 2024 22:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTihWBUs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E3E59B40
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 22:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710369952; cv=none; b=dYMhupHKCjzDxbh7cu+cSjvfxDgQEZ6QW/1GmuUygGbpkZaavCBAX8ZpgbIeP+8C3TkaeGhXEFcT3iYMeeUsTbBamyCg85G2CxjpDvR0Ugt6MSRBXNKnmqPbkKn1KlH5vxSzjaAobNafkQK/JVo18eUtwZZ2P4irX3MVCuYleA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710369952; c=relaxed/simple;
	bh=Vc7CXOMVJLO+cLwiNp2iOZmzA625Qw3FpG7x3kqGtKc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=tgzi1IrbGnUDwjFhCIAM9t9EhYvOp5ZI5THVxWpjT9Q9tIhdTQzxETgCx4+3c2cu7WxAe+qWnIJII02bc9XOxVlKQQMCLr8A+An2/PwY7KlHGeSrKDNF+LtrKcNfdtXYLZagzxnppCoGNOxnK17HCgo3EuvnkZtmlbehSsQM658=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTihWBUs; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e95b68b3eso244722f8f.1
        for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 15:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710369949; x=1710974749; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vuhteVjsNA14JFD90A9MRwHUSNKPyCCZGXeZClRl81U=;
        b=jTihWBUsFbcFSQgYJYMqj2GDND6tHwLxmtemKsGNmDK/apnmW/aIEdNNaUl4xlOMGY
         HzaFDBjvo4zNhDHYV2EgQXX/+Mv+xOZQW6TcE/Qn/74lFpUmeTaNJg11JA4wh88/BZvJ
         W5QSQGvFdaVqsmASpHmEusp7hJEaMupPHU/yrLeLTkkd8/MoDUv9pxTXaiOJBVNjUv5X
         kwkXj1yenxdL6BWEbNuqEBWd58+TqwO9ump/qHVOd6P/3t/JBzPWfRhzkdHPJ6OyAGgY
         b5aRF6tILJ774Xeh4O2T3DJSREV+Aq2dSKzuvykjASY0GtyoQsWQKVXcaU1yjvSrJ8bY
         1gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710369949; x=1710974749;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vuhteVjsNA14JFD90A9MRwHUSNKPyCCZGXeZClRl81U=;
        b=A3PL0RhL624vTewxY6Nz3Tl1+dbDAkOCCdAw9y4ohNW02UUSgJpbBoTTE9oN9rw1l9
         x4qHaAHnV3M56yWeYkya3J8wvd2Bt6Xkg8a3r+ow6A6vPNIVagryC4oK1CuSwHU7SFD+
         J3wYxy/qjnVkKdaA8SyQhtFdoVYxeDCRvH11fNVye6mBI4Lch7W1wS13tZ0g1keKvxss
         sllGw0uhBuwH8Q3WmCz5qlwhW8oumDfpsyhh+o+m1idAvGzAbTeaTAYLfakVcnRmnsnM
         YtPYX5HtFRxnb8bMFXZSuCnA2bLYXwEwgo9Gb4lVi4nFhBWapw/p68mrARZXVfQU3Og8
         tbmw==
X-Forwarded-Encrypted: i=1; AJvYcCXQGrXJqPRcBXcwhgOFn5TaGy3xGdoSQ7AAdWEH8aTx64TP3rAJWfG1JMDeS02XIUaQEdex9hQkswp3xsoCzeWhFKRfRdzN7ksR3prWFvY=
X-Gm-Message-State: AOJu0Yws6yT2O0Q9FfE6ENCbqhHSPbbuSYCxbGQM2QZH5hYeusdVrhR1
	HRyP2tdh5kMKgXpifMIe4VukZg5ooqHsZVi9PpFP/1vO9ANqvdO+jCJbuXZb
X-Google-Smtp-Source: AGHT+IEre73d84AShoI6/6zaFPVl7oP3O0F7/g6Re/dR4c/AcLSYqIEAgACdlI4gYcijelSsJbB8Uw==
X-Received: by 2002:a5d:64ed:0:b0:33d:fb3:9021 with SMTP id g13-20020a5d64ed000000b0033d0fb39021mr3122946wri.54.1710369948736;
        Wed, 13 Mar 2024 15:45:48 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id bn5-20020a056000060500b0033e49aebafasm176437wrb.3.2024.03.13.15.45.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 15:45:48 -0700 (PDT)
Message-ID: <1cfe8151-0989-4853-961d-e14daf293744@gmail.com>
Date: Thu, 14 Mar 2024 00:45:47 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 3/3] wifi: rtlwifi: Add new rtl8192du driver
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
 "s.l-h@gmx.de" <s.l-h@gmx.de>, "chewitt@libreelec.tv" <chewitt@libreelec.tv>
References: <e1922019-21eb-4013-a35f-0077167e92cf@gmail.com>
 <303a7402-43f0-4f98-9aa1-b4eb660eead0@gmail.com>
 <9e5485592f792339593d0b03b86794e5e010337a.camel@realtek.com>
Content-Language: en-US
In-Reply-To: <9e5485592f792339593d0b03b86794e5e010337a.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/2024 07:49, Ping-Ke Shih wrote:
> On Wed, 2024-03-13 at 00:23 +0200, Bitterblue Smith wrote:
>>
>> The RTL8192DU is an older Wifi 4 dual band chip. It comes in two
>> flavours: single MAC single PHY (like most Realtek Wifi 4 USB devices),
>> and dual MAC dual PHY.
>>
>> The single MAC single PHY version is 2T2R and can work either in the
>> 2.4 GHz band or the 5 GHz band.
>>
>> The dual MAC dual PHY version has two USB interfaces and appears to the
>> system as two separate 1T1R Wifi devices, one working in the 2.4 GHz
>> band, the other in the 5 GHz band.
>>
>> This was tested only with a single MAC single PHY device.
> 
> 
> Please run checkpatch.pl that reports:
>   "total: 0 errors, 11 warnings, 27 checks, 8045 lines checked"
> 
> (Sorry, I wrongly posted above result on patch 2/3)> 

I did run checkpatch, these are the things I decided to ignore. :)
I will have another look.

>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>
>> Should I split this into multiple patches, one for each new file,
>> to make reviewing easier?
>>
>> ---
>>  drivers/net/wireless/realtek/rtlwifi/Kconfig  |   12 +
>>  drivers/net/wireless/realtek/rtlwifi/Makefile |    1 +
>>  .../realtek/rtlwifi/rtl8192du/Makefile        |   13 +
>>  .../wireless/realtek/rtlwifi/rtl8192du/dm.c   |  788 +++++
>>  .../wireless/realtek/rtlwifi/rtl8192du/dm.h   |   10 +
>>  .../wireless/realtek/rtlwifi/rtl8192du/fw.c   |  109 +
>>  .../wireless/realtek/rtlwifi/rtl8192du/fw.h   |    9 +
>>  .../wireless/realtek/rtlwifi/rtl8192du/hw.c   | 1238 +++++++
>>  .../wireless/realtek/rtlwifi/rtl8192du/hw.h   |   24 +
>>  .../wireless/realtek/rtlwifi/rtl8192du/led.c  |   10 +
>>  .../wireless/realtek/rtlwifi/rtl8192du/led.h  |    9 +
>>  .../wireless/realtek/rtlwifi/rtl8192du/phy.c  | 3064 +++++++++++++++++
>>  .../wireless/realtek/rtlwifi/rtl8192du/phy.h  |   32 +
>>  .../wireless/realtek/rtlwifi/rtl8192du/rf.c   |  236 ++
>>  .../wireless/realtek/rtlwifi/rtl8192du/rf.h   |   11 +
>>  .../wireless/realtek/rtlwifi/rtl8192du/sw.c   |  310 ++
>>  .../wireless/realtek/rtlwifi/rtl8192du/sw.h   |   12 +
>>  .../realtek/rtlwifi/rtl8192du/table.c         | 1675 +++++++++
>>  .../realtek/rtlwifi/rtl8192du/table.h         |   30 +
>>  .../wireless/realtek/rtlwifi/rtl8192du/trx.c  |  380 ++
>>  .../wireless/realtek/rtlwifi/rtl8192du/trx.h  |   60 +
>>  21 files changed, 8033 insertions(+)
> 
> Please split this patch to small ones. Like make dm.c/dm.h as a patch,
> hw.c/hw.h as another patch and etc. For smaller files such as led.c/led.h,
> it is fine to combine with others. 
> 

Okay.

> 
> Though you have done 8192DU in rtlwifi, I still want to know how you decide
> to support 8192DU in rtlwifi instead of rtl8xxxu. IIRC most USB users of
> Realtek WiFi use rtl8xxxu. 
> 
> Ping-Ke
> 

Originally I worked on rtl8xxxu. I didn't like how many changes
it needed to support this chip. And then the first test with
rtl8xxxu produced no scan results. At that point I gave up and
modified rtl8192de instead. (The first test with the modified
rtl8192de also produced no scan results... but rtlwifi has a lot
of debugging output, which helped.)

