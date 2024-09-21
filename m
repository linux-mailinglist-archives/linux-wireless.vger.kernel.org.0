Return-Path: <linux-wireless+bounces-13074-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F4097DF7D
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Sep 2024 00:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 002B21C20B00
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2024 22:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A0B126BFB;
	Sat, 21 Sep 2024 22:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6YED0GR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97B023D7
	for <linux-wireless@vger.kernel.org>; Sat, 21 Sep 2024 22:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726958867; cv=none; b=bXcaQ3qjaYYlkUdXw5+Vd1bVQFCrL5jxuuRCKcKOKZIYk8wU+ZDU8cUR4EbRpWQQD/jfQM2z/ZIntl1LiV7nGNulJdBcKWm+VvvcJLeN22XvDje9h1LFvmYbZ3sd+nzxscAZsm+I4V18x3uAVJuyHylQPGSoQBzTEaIxjDLJlwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726958867; c=relaxed/simple;
	bh=YX1t3aWdc+NiRBAgFcJmu5lUE5yuagRqyf9kO4YvLNI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=eXsC6hINabp72XtrameI4WgTZwWThA2XHZyGX434gwDeiVKQF1Mgxtq9xpVLPdYvxhr6ftZ5yyDG1o3RRwztOdnfUtnYAFYkz+SSwxgkzxfzfDWTqOnAy0DD5IHDUNWI0YwhuohjeyTK/1nuuHd1CZaYF2UzelSG6UzNYI//s90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6YED0GR; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso39817205e9.2
        for <linux-wireless@vger.kernel.org>; Sat, 21 Sep 2024 15:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726958864; x=1727563664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stTZ41G3D1NYpDE5ov4MqOkutQdFJQRl3wa5bThTrOU=;
        b=G6YED0GRmDeBMR8KpeVguZ3bfy3Q1RCp9upmZSTsAWSkzs3vUhIatU21K55OSl69zY
         Ah/Pi8GKUwruDYBhvfu6ruqCNGZy9M928Gwng6Q7OUJ8rdB6xCrmfNmA5NWM8IbenM1n
         so3ten77sE+op79mEZc7JANFgYHphwI0p04aFfVTn94LC+i5ektuvcTigq7d3EQUYfny
         dvvujTZgnuzTBtViSqyyOmTHIVCY0i2UKl9vh4fkGvyG0yrHz41NAe8+sUZP9fvbFzv6
         GGo30mHpldfSyhP0peo13G8s4gWncKv0j+mzTy9kYkLe0wAakKuOwG+zUbXKenvVD4+B
         2hRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726958864; x=1727563664;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=stTZ41G3D1NYpDE5ov4MqOkutQdFJQRl3wa5bThTrOU=;
        b=UJ2T0zX0V5vYxRoirFSZ9OYIMVRhBPXqQM/Q/jhZPcE/GNXAYMJKXUbDnKcjS9/ym+
         RArpYt/GVpdw+d0eaEdp293Eu35CYnGfdHxF8aX/Gk7RxGvZqpvl2wxVSm3so44xT5cQ
         SuM41tnD4mqxCI6KrSgBDfjTYCF1fCJbFa/kdAOJkcO061ql7jOVadDPAPwokZBzACDN
         qJ5eyD06AOUB8vS7Qo+A/IrDkRSsLMH8bjbEGELvp2Gi1SO25RPE+L1pYUAgvZt+8v2y
         JlT3R2uys991QWXX4cZPA2FuiBSWseXDFFHzdrrhslXqYO780H2yeszZmyFdJ30u5ojy
         11mA==
X-Forwarded-Encrypted: i=1; AJvYcCVQwGNclmhNaIQhaTwlydwNgEswyPfcY/8mM2BtByWKjncYGTzzLCgms5L7P671eq2uRfqBM4eCzS5DaEHY2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOH12QFgn7xyJcyFdFjS44EWLDD8cZqcmXUMdeaaUCsYI98xSB
	VpmckVKgco/EYsNcS+CmLLpf81ClLHE0NpVLw3Uwfq5OzGlf9OO06OatbA==
X-Google-Smtp-Source: AGHT+IEJy832+HF9bsKKRdaMrG9Icyj7XKGe+hcl6bK5p9f908tXuU+KgIRcHYJpyIVZUDpfKPTQtw==
X-Received: by 2002:a5d:4804:0:b0:374:c6af:1658 with SMTP id ffacd0b85a97d-37a422535a5mr6524349f8f.1.1726958863773;
        Sat, 21 Sep 2024 15:47:43 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7805337sm20868221f8f.104.2024.09.21.15.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Sep 2024 15:47:42 -0700 (PDT)
Message-ID: <38553e79-6747-4ab3-9bf4-fa7f2af852cd@gmail.com>
Date: Sun, 22 Sep 2024 01:47:40 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
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
Content-Language: en-US
In-Reply-To: <f583e9470ca84234ad2e00f3a0371664@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/09/2024 04:50, Ping-Ke Shih wrote:
>>>
>>> #define REG_3WIRE_SWA 0xc00
>>> #define REG_3WIRE_SWB 0xe00
>>>
>>> (0xc00 page for path A, 0xe00 page for path B)
>>>
>>
>> Previously, you called 0xe00 REG_HSSI_WRITE_B. Are both names correct?
>> (I'm not sure why I put 0xc00 and 0xe00 on the list if you already gave
>> them a name.)
> 
> In fact, there is no _formal_ names for PHY registers, so I gave names by
> abbreviation name from RTL code. Previously I may reference to vendor
> drivers instead. Just choose one you like. 
> 
>>>> 0xe90
>>>
>>> #define REG_PREDISTB 0xe90
>>>
>>
>> I put 0xe90 on the list by mistake. We already have a name for it
>> in the official driver:
>>
>> ./include/Hal8812PhyReg.h:66:#define rB_LSSIWrite_Jaguar                        0xe90 /* RF write addr */
>>
>> I translated that as REG_LSSI_WRITE_B. Is REG_PREDISTB also a valid
>> name? Do we need both names?
> 
> For the use case of 0xe90 in rtw8812a_iqk_tx_fill():
> 
>    rtw_write32_mask(rtwdev, 0xc90, BIT(7), 0x1);
> 
> "RF write addr" seems not reasonable. I suggest to define both for this case. 
> 
> 
>> Some of these names are very different from their counterparts
>> from page C. In your previous email you said:
>>
>>> I think we can reuse existing definitions:
>>>
>>> rtw8723x.h:#define REG_OFDM_0_XA_TX_IQ_IMBALANCE        0x0c80
>>> rtw8703b.h:#define REG_OFDM0_A_TX_AFE 0x0c84
>>> rtw8723x.h:#define REG_OFDM_0_XB_TX_IQ_IMBALANCE        0x0c88
>>>
>>> #define REG_TSSI_TRK_SW 0xc8c
>>>
>>> rtw8821a.h:#define REG_TXAGCIDX                         0xc94
>>
>> Can we reuse these definitions?
> 
> Yes. You can reuse existing first. For non-existing definition, use the names
> I gave in this thread. 
> 
> Basically we can have two ways to have names. One is from vendor drivers, and
> the other is from abbreviation name of RTL code, which bit name instead of
> whole register name is given. Also I'm not very familiar with the functionality,
> so I did just paste reasonable names for undefined magic numbers.
> 

I see. Thank you for the explanations.

>>>>>> +
>>>>>> +const struct rtw_chip_info rtw8812a_hw_spec = {
>>>>>
>>>>> Is it possible moving 8812a to individual file?
>>>>> Since you have rtw8812au.c and rtw8821au.c.
>>>>>
>>>>
>>>> I think it is possible. But most of the code is common to both chips.
>>>> Only the IQ calibration could be moved.
>>>
>>> Yep, depend on how much IQK code echo chip has.
>>>
>>
>> The IQ calibration for RTL8812AU is about 700 lines.
> 
> rtw8812au  -----> (a) rtw8812a 
>                         |
>                         v
>                   (b) rtw8821a_common  (hard to give a name)
>                         ^
>                         |
> rtw8821au  -----> (c) rtw8821a
> 
> Put all common code to (b). IQK code in (a) or (c). 
> 
> I feel you have thought above picture already. What are problems we will encounter?
> Many export symbols? If so, how about below?
> 
> rtw8812au  -----> (1) rtw8812a 
>     +---------+
>               +-> (2) rtw8821a_common  (hard to give a name)
>     +---------+
> rtw8821au  -----> (3) rtw8821a
> 
> Put rtw8812a_hw_spec and rtw8821a_hw_spec in (2). Only IQK code in (1) and (3)
> respectively, and export IQK entry only. Does it work?
> 
>
For the name of the common module, I was thinking rtw88_88xxa.ko.

I wonder, what is the goal? To put the code in separate kernel
modules, or just separate files?

I think we can have rtw88xxa.c (common code), rtw8821a.c (IQK code,
rtw8821a_hw_spec, bluetooth stuff), and rtw8812a.c (IQK code,
rtw8812a_hw_spec, some efuse stuff, channel switching)... if these
three files compile into a single module, rtw88_88xxa.ko.

If each file compiles into a module of its own, we have circular
dependencies: rtw8821a_hw_spec -> common code -> IQK code.
If *_hw_spec go in the common module, it still depends on both of
the other two modules, so what use is it?

