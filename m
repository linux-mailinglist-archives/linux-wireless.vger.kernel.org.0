Return-Path: <linux-wireless+bounces-5415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8257288F221
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 23:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7D81F2E63C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 22:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CD214EC70;
	Wed, 27 Mar 2024 22:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMTYERlE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010FD153BD4
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 22:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580010; cv=none; b=KlXISC+rSP9CqY6AUUXPxFN8dRSM/PBhBxDX0N2C6oSaGLNCrZK4P2SryLVIQx52/BsCPxq5YCHZ7l6LqKqe8weTbAHtVChvQcktqTTcbJtafhH1av95I20KmD7Vy0x7wzx8hHO948FjM4uiqAnBS5vyar9AlRc4c9pyra8DUSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580010; c=relaxed/simple;
	bh=tlgCnpczpfliKROOuglblRQyzOJXNRjfpTKOVHogpl4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ggwoq6LAi3Gjd0HB9j/k9KuP1eu6d08qA7Ozqkjk85yJljfDIj5amfAIwyYOEGYgi10ZXU76aBZWF5LoDxgFJrRNZRc/1eez/69c/hKvjW6ZWgrz/dYf878ycDZH0Cd8pROdTV90O6+4lIv2HSpN+Ay0He4Pcf6Kp+2NKI9bitU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMTYERlE; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33ec7e38b84so171807f8f.1
        for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 15:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711580007; x=1712184807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pFuLW57lqSEyCGUOdTd5EeOVNne107OIXLY8bzA3t08=;
        b=bMTYERlEq/xpIFYhbViJ0PHCB7qlaLPUKBHAyXKLOuCB8m/Z/hY80mI/ylArqGTEVD
         RFo+J7UQN9cLBNSGYB5NnSt+TdvE7fCePnrXpNVkrLNSzeF2WXbB6t8VuRWB/u77v8F+
         yyV5JpCQ5WohNAHUcI+A24LDNgDsTSHqtXaofSJEz0ZFlO5sMde1XYjXOwKgelwJPPfD
         fdIezU1g49BM086X6TZXN+P0WJTQsuqTvUTd1iRJCma62j9VsQ8sMsu5zHrsenWy+6RV
         xQBfeex4OM+prFcFZ1TswsyzLAYC/2Ly0L+xSNjgFHFUiraD8+WcqwkDJYIARZ9WSOYB
         +l+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711580007; x=1712184807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pFuLW57lqSEyCGUOdTd5EeOVNne107OIXLY8bzA3t08=;
        b=PRqr9QFzr5vgnDvIW9KaEXvrUZ8kadAGROq6hPIb5jaWQ3aTXglcSuKMnxNEHj6vcS
         5kNcGW5vinv0PsHyLj/XR8SmsievEtY5Ifrd7Jy1PWScwqkh60tlhyKyRFKMjMInpqEV
         PD+JqkOGVe/UV4W9x3IPxnwdWjs8wcHQv90w4BOFdd7hFv79E1MRg7kR8AybZGbEmjZS
         pY6Ez7CENSVrXpvqnpDQ2tsmD3XJHvORBMfMxQPlaCQNnKCgsavD8FR5kfZaibHHEkmJ
         Om0B08f3Z47fcH91Oh83LNdYxlAwXKJN3zpxugFueCuUYcszfvvFJA7zaT+muvmGKLGz
         1fqg==
X-Forwarded-Encrypted: i=1; AJvYcCU9zsiyyl447jG6D5zyxC4Pfg2S7VaKb8AijBqXIIi1uyRm2LqMwg9DfWjMPireuPO5tWqPJPacHc+njj4wevC7dMumZLglCE9g/GiJtlQ=
X-Gm-Message-State: AOJu0Yy1lHtLvwXR0DhhCqHrqyUcw2WpHfrYjm18RNP5AtClHh5CC4rG
	/6pvKiyg/0jm12xBLQvutjz/S+jZeHraGyY3v6IxBRVSppQ3ZPZt
X-Google-Smtp-Source: AGHT+IFoA+1zi5ARtBbAnXoGLib1MW2Vc43PZWm0epn5iASUhsMGO8wLhQz31Trw5QjLZ4AgNTTHOA==
X-Received: by 2002:a05:6000:1091:b0:33e:c7e3:b1bb with SMTP id y17-20020a056000109100b0033ec7e3b1bbmr752649wrw.16.1711580007148;
        Wed, 27 Mar 2024 15:53:27 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.188])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c502300b004149744dc49sm306299wmr.22.2024.03.27.15.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 15:53:26 -0700 (PDT)
Message-ID: <5696990a-4450-4d92-bbda-1d9ca3a9a619@gmail.com>
Date: Thu, 28 Mar 2024 00:53:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
 "s.l-h@gmx.de" <s.l-h@gmx.de>, "chewitt@libreelec.tv" <chewitt@libreelec.tv>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
 <2eb79c8c-cf2c-4696-b958-e8d961628e17@gmail.com>
 <f86a40493745a53ff73083f87b3e8fae215eac77.camel@realtek.com>
 <66565618-3638-47e5-afe5-3530214da0c9@gmail.com> <87ttkrzf1m.fsf@kernel.org>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <87ttkrzf1m.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/03/2024 20:48, Kalle Valo wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> writes:
> 
>> On 22/03/2024 08:04, Ping-Ke Shih wrote:
>>> On Wed, 2024-03-20 at 21:43 +0200, Bitterblue Smith wrote:
>>
>> [...]
>>
>>>> +DEFINE_MUTEX(globalmutex_power);
>>>> +DEFINE_MUTEX(globalmutex_for_fwdownload);
>>>> +DEFINE_MUTEX(globalmutex_for_power_and_efuse);
>>>> +DEFINE_MUTEX(globalmutex_for_mac0_2g_mac1_5g);
>>>
>>> The consumers of globalmutex_for_mac0_2g_mac1_5g are complex. Why do they
>>> check mutex_is_locked()? Race conditions between two instances?
>>>
>>
>> I couldn't think of a sufficiently short name, like
>> "lock_mac0_2g_mac1_5g", so I used mutex_is_locked(). That's probably
>> a bad idea. It should be like this:
>>
>> 	/* Let the first starting mac load RF parameters and do LCK */
>> 	if (rtlhal->macphymode == DUALMAC_DUALPHY &&
>> 	    ((rtlhal->interfaceindex == 0 && rtlhal->bandset == BAND_ON_2_4G) ||
>> 	     (rtlhal->interfaceindex == 1 && rtlhal->bandset == BAND_ON_5G))) {
>> 		mutex_lock(&globalmutex_for_mac0_2g_mac1_5g);
>> 		lock_mac0_2g_mac1_5g = true;
>> 	}
> 
> Few quick comments, I haven't reviewed the actual patchset yet:
> 
> The mutexes look too finegrained and makes me suspicious about the
> locking design.
> > Having global variables like globalmutex_power is a big no no. They would
> not work if there are two devices on the same host, right?
> 
> Conditional locking is usually something to avoid.
> 

The design is not mine, I can't fix that. I don't even have
the type of device which needs all these mutexes. There are
two types of RTL8192DU:

* Single MAC single PHY: this is the one I have. I can still
buy it from Aliexpress. It's a lot like the other Realtek
Wifi 4 USB devices.

* Dual MAC dual PHY: this I can't find to buy anymore. This
appears in the system as two Wifi devices, each working on
a different band. It has two USB interfaces. Two instances
of the driver access the same device. This is what the
mutexes are for.

I said earlier that I think two devices can work at the same
time, even with the global mutexes, but now I remembered there
are two more global variables: curveindex_5g[] and
curveindex_2g[] in phy.c. One driver instance fills one array
during LC calibration, but the other driver instance reads
from the array when switching the channel. If I'm reading this
right. So two devices plugged in at the same time probably
won't work correctly.

How can you avoid this when the hardware is the way it is?
My one idea is to add a global map to hold the mutexes and
arrays, using the USB port number, etc as the key.

> I'm starting to wonder if extending rtlwifi is actually the right
> approach. We have modern drivers like rtl8xxxu, rtw88 etc. with better
> design.
> 

I think extending rtlwifi is the right approach when it already
has most of the code needed. I really don't want to reinvent this
particular wheel. I don't want to add the dual MAC stuff to
rtl8xxxu or rtw88. I don't think rtw88 is the right driver for
this old chip, anyway.

