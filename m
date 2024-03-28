Return-Path: <linux-wireless+bounces-5457-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6046890035
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 14:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148C81C23743
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Mar 2024 13:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8967F7C3;
	Thu, 28 Mar 2024 13:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yb13vG14"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EC63032A
	for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711632681; cv=none; b=NhB+VzOBnw7Wg0j6HRq0tdOib6AYrMEa6h3dEKzweuKlVE1BOBzp5v9GQBxTxs9blgztbHWwUNTbkxkPMhQgKBaXSDmS496MK6IOXJiljDl+LayF/m11yEiwzvxWj/NY915I8kF9YfnDgfUPfkGmiBNDGJ6UZUKZz0DpuQCzSr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711632681; c=relaxed/simple;
	bh=azxE9yNP5eaAvbPhCCtYsbc/uR4PqOX0QhLrDaoSzcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KS95ALcOky2TPwmJ+GlAhLplUrZSQ8VXklSSDTKMZX4W9Yj1HM2UKXXkT/OelKoaQxEvbqCs7C7H+Z4Kt9z4nNpkkQJE9OwsOv785d9dBMuJXQr1AAApQLpG69DEJeW77hgWI+ysbFqS73a4VnKtG/ajsTHZaby3wUnh7LLH5gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yb13vG14; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4149749cc36so6995495e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 28 Mar 2024 06:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711632677; x=1712237477; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U8IcRdMdpGN8ilyT4ORGc/9pN5lQ3dxvtj2bHTjUTYU=;
        b=Yb13vG14r3ZVTDgDJt3gnXEhaah+1KOa2F3YUHFQtr25bnFm5Ka1r/cqNy9/VwMh4r
         hdVPCrKre7/F/wlls0C74nXJ9sH8VsYZnMiBn/XYXJ8cZ3C9DIzF3qQ0LfIMhOFSMkeQ
         qvXbD00Nfy+5fynXz3nS/YL/lVrCd2liEhzaYUm9N/1pTgqbyCdHd4bcezxRp4zo0nZe
         2sn2MuCbCRdodj4EFrH9d+MEPaJ/Lq+tMjCu5L+QTnTMeytdCbnINt90zRge1Af4QJDF
         CyKj9AzdvzTqsQ7rLkG/wb/BQ2UGGpUlW1wJlaCU5zxlRs6BZLHgmPkAD60Gd15ZEOes
         +LVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711632677; x=1712237477;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8IcRdMdpGN8ilyT4ORGc/9pN5lQ3dxvtj2bHTjUTYU=;
        b=tTJb0890ezVz6flHh8kNispe9jwN5RdwkubyW/EV/LEv8x5Up+DkICrDA/r4VtkmHK
         /k4g2hTPJOy+hiXSQyd+mLDri5J6NwzNItjNi77MFECOkuPTb08JBiE4YCSiFyQZ7voK
         8AILI7BxZoYRR48bCN+PAyuaJQoKzWLfpLDPN2F9C+J70UNR7xoWEEDODiPAwvukLCst
         SFXjgrk5Q9tz8CuMHnSSFgZQHNHoblMlp+EzDWlgxEuKDAwIdQqBn1dYCzAYFpjT8EzT
         jzuzNvaG7NpebNI0ZG0n/ZZ2c9UBVgD3pqAn/jh1voLNVR4Svd8Qf3OPr2weR1cybQCN
         IJSQ==
X-Gm-Message-State: AOJu0YyL/SqTNOCtvvBxRFZq9f+MULXnA6097PZZgw4TSOXQi4XWhQIJ
	yLMxLhRiNlm6jvs7lBys9kwgue+VmBf7du1sFDJtnAYW5z/82lCS
X-Google-Smtp-Source: AGHT+IGSkHRinw4jr0ANuoT2BoWOLPVrOk4o+5RSQLMbxkxLdEhq0nVMLPVWf/hv7bBxU2CjwK2/0A==
X-Received: by 2002:a05:600c:3149:b0:414:56ec:22e7 with SMTP id h9-20020a05600c314900b0041456ec22e7mr2420999wmo.21.1711632677428;
        Thu, 28 Mar 2024 06:31:17 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.188])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c314900b004147b824b08sm2348340wmo.7.2024.03.28.06.31.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 06:31:17 -0700 (PDT)
Message-ID: <7873dee1-46a8-48a7-9059-bc300ac98c23@gmail.com>
Date: Thu, 28 Mar 2024 15:31:14 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
To: Ping-Ke Shih <pkshih@realtek.com>, "kvalo@kernel.org" <kvalo@kernel.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
 "s.l-h@gmx.de" <s.l-h@gmx.de>, "chewitt@libreelec.tv" <chewitt@libreelec.tv>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
 <2eb79c8c-cf2c-4696-b958-e8d961628e17@gmail.com>
 <f86a40493745a53ff73083f87b3e8fae215eac77.camel@realtek.com>
 <66565618-3638-47e5-afe5-3530214da0c9@gmail.com> <87ttkrzf1m.fsf@kernel.org>
 <5696990a-4450-4d92-bbda-1d9ca3a9a619@gmail.com>
 <4672072ef782ae1200886a190c740e0f3ccec2c8.camel@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <4672072ef782ae1200886a190c740e0f3ccec2c8.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/03/2024 03:46, Ping-Ke Shih wrote:
> On Thu, 2024-03-28 at 00:53 +0200, Bitterblue Smith wrote:
>>
>> On 27/03/2024 20:48, Kalle Valo wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
>>>
>>>> On 22/03/2024 08:04, Ping-Ke Shih wrote:
>>>>> On Wed, 2024-03-20 at 21:43 +0200, Bitterblue Smith wrote:
>>>>
>>>> [...]
>>>>
>>>>>> +DEFINE_MUTEX(globalmutex_power);
>>>>>> +DEFINE_MUTEX(globalmutex_for_fwdownload);
>>>>>> +DEFINE_MUTEX(globalmutex_for_power_and_efuse);
>>>>>> +DEFINE_MUTEX(globalmutex_for_mac0_2g_mac1_5g);
>>>>>
>>>>> The consumers of globalmutex_for_mac0_2g_mac1_5g are complex. Why do they
>>>>> check mutex_is_locked()? Race conditions between two instances?
>>>>>
>>>>
>>>> I couldn't think of a sufficiently short name, like
>>>> "lock_mac0_2g_mac1_5g", so I used mutex_is_locked(). That's probably
>>>> a bad idea. It should be like this:
>>>>
>>>>      /* Let the first starting mac load RF parameters and do LCK */
>>>>      if (rtlhal->macphymode == DUALMAC_DUALPHY &&
>>>>          ((rtlhal->interfaceindex == 0 && rtlhal->bandset == BAND_ON_2_4G) ||
>>>>           (rtlhal->interfaceindex == 1 && rtlhal->bandset == BAND_ON_5G))) {
>>>>              mutex_lock(&globalmutex_for_mac0_2g_mac1_5g);
>>>>              lock_mac0_2g_mac1_5g = true;
>>>>      }
> 
> globalmutex_for_mac0_2g_mac1_5g is only used in rtl92du_hw_init(), and
> globalmutex_for_power_and_efuse does very similar thing. Can we combine them
> into one? Since both are only used in rtl92du_hw_init(), it would not be a
> problem to enlarge their critical section.  
> 
> 
>>
>> * Dual MAC dual PHY: this I can't find to buy anymore. This
>> appears in the system as two Wifi devices, each working on
>> a different band. It has two USB interfaces. Two instances
>> of the driver access the same device. This is what the
>> mutexes are for.
> 
> I traced the code, and found rules of two MAC/PHY are:
> 1. read efuse to decide single or two MAC/PHY
> 2.1. if single MAC/PHY, register_hw as 2T2R (done)
> 2.2. if dual MAC/PHY (to step 3)
> 3. read interface index (USB: from bInterfaceNumber; PCI: from PCI onfigure space)
> 4. register interface index 0 as 1T1R on 5 GHz band only.
>    register interface index 1 as 1T1R on 2 GHz band only.
> 
> This is the case two instances (netdev) access single one hardware device,
> so seemingly it is hard to avoid global locks to prevent racing between them.
> An alternative thought is to support only single MAC/PHY, but not sure if
> driver can override setting of efuse that programmed the card as two MAC/PHY.
> 
>>
>> I said earlier that I think two devices can work at the same
>> time, even with the global mutexes, but now I remembered there
>> are two more global variables: curveindex_5g[] and
>> curveindex_2g[] in phy.c. One driver instance fills one array
>> during LC calibration, but the other driver instance reads
>> from the array when switching the channel. If I'm reading this
>> right. So two devices plugged in at the same time probably
>> won't work correctly.
> 
> That should be a problem. 
> 
>>
>> How can you avoid this when the hardware is the way it is?
>> My one idea is to add a global map to hold the mutexes and
>> arrays, using the USB port number, etc as the key.
> 
> Seemingly we need something like per device data. 
> 

I got another idea: if we have a guarantee that the two USB
interfaces are probed one at a time, then we can move the global
things into struct rtl_priv. The first probe call will allocate
the arrays and initialise the mutexes. The second probe call
will obtain those from the first struct rtl_priv:

int rtl_usb_probe(struct usb_interface *intf, ...) {
	udev = interface_to_usbdev(intf);
	struct ieee80211_hw *first_hw = usb_get_intfdata(udev->actconfig->interface[0]);
	struct rtl_priv *first_rtlpriv = rtl_priv(first_hw);

Something like that.

I am having regrets...

