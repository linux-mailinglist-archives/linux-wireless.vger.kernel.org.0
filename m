Return-Path: <linux-wireless+bounces-11889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3503E95DFC8
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 21:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B59B31F22F1A
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2024 19:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FDB56742;
	Sat, 24 Aug 2024 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6L6seli"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745DE14A85
	for <linux-wireless@vger.kernel.org>; Sat, 24 Aug 2024 19:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724527116; cv=none; b=lZ8emBV80NyZ8gm3D4cV2Qp7lpf/7ZpWzokR0wK8iQWrsk1QyjHiGytIf1aoELRaYwNfR6repnqD/VpAxlu1byZS6XiyUQYnJmVM3m2tFY0XI9YAe/uJJ0HGaq2YjDsEEElGki8sevm2blMjepu2F4xts8492MnqpN8f+p7j6UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724527116; c=relaxed/simple;
	bh=HpWeafV2F5Hjsl8GMNPzY/4hNJW9alCS0GcPboH5bfs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=K1T1+lihbexcPNnRuheAlnUstA1Y50qV4alFAqEC3TCMHRHGcVDa6vywQ8syz+6C7i9c4pCdfyy8thVrsoshZJaW7dBmjs+7QFkY+qDzmSR83kZGp1NKPK+HrklKmKXPcdFLAEOoV+oSEtuJIp+qhCda4sZTKadaNXxhVaBPWKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6L6seli; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-709428a9469so2896035a34.3
        for <linux-wireless@vger.kernel.org>; Sat, 24 Aug 2024 12:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724527114; x=1725131914; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aZn3T3TMp54nUloXbXnxjQ0Ru/RTXJEf7kHaHIFc6Ng=;
        b=d6L6seliwNJbud2Dsv8xhHS4oSy0G1NeWuYRb2QVlNZ6VTA/e5Zeu1yY4O2TP0Giqr
         5K1VP7A8jPum1sb6yFQJp1isDdyxzW1n+ZjpZ3uFCaVQScdRZ+x9m1TtKOWKHWZWEKry
         8F9kty2lRUMjPeF7JgDXT+N+3KSq604u7KYpoRhr8tr3RrrQ7vk/gaZVZ5O0762rCvAK
         JgJKo34k/9Qgt6nOx5rLpO6TC+EpCIKeEQ04UsfeV+GFnsh5rehaH1M+dA6xRlkb2p2C
         wVG2g7SL6ni2te9tao5uJ5pAfTBoRM4IZIZzCZeZSBoWFONW0Dy1SF6EmY4qL4DvoM+D
         ndvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724527114; x=1725131914;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aZn3T3TMp54nUloXbXnxjQ0Ru/RTXJEf7kHaHIFc6Ng=;
        b=dX6weH/1ydVmhRlDafHoWocRP4BPGBKkiefMI5Vtta9V2/5n5Rs6JEY5xXbXACjft8
         zytp5jzFuvHhHMXMz7UnHe0UbG8HkKnHVedfgP57XwQIB0Uz2rvhFdQsGB6S46HcEMt/
         meFpvsfHXVhPbJ3TK/SmJjBx2X/Q4NiwNsS/nI+2aVlzQ9EEWU5exEKyr/o1k4YU7ZKY
         qJ0zt9/Movpa/ahQoSdKUWudF99EyEjhugufY8UZpLVuV1nzZO2o7T0FmKrfg9xYsww1
         03rZ50EAk9XkoqsAXGm72Db11PNgfPZctEnmDcgtlc/EN40twF0GZcvyusBs+yWUlIIB
         6uzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUWoR6sZZ/nzrEp8tqsnRlXRyR9lpqTO5ptXz0m2Np+zwcvQcXt9P7TS3P/2YWaYCNcU46vbDTSg2BPlbang==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Ryn9YWE341XNqEwwtq4NutdFpx5wylvl5ycnfHW57w9fS2/c
	H4z9YCeJ3ySdvEMvv26aAqFxZEq/c43GjBk2wcbYFuWaxpJon5YK
X-Google-Smtp-Source: AGHT+IG2rgsVwJntp+zHu54ZMj5RMzdgO7wHYHSDgd/hzAmdHT+qIc7TaNasisFgM65lve2ZH4Ha3g==
X-Received: by 2002:a05:6808:1815:b0:3da:d8b9:6e56 with SMTP id 5614622812f47-3de2a8867e3mr7717423b6e.15.1724527114115;
        Sat, 24 Aug 2024 12:18:34 -0700 (PDT)
Received: from ?IPV6:2600:8804:8c40:89::28e? ([2600:8804:8c40:89::28e])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3de225c52a6sm1307462b6e.44.2024.08.24.12.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Aug 2024 12:18:33 -0700 (PDT)
From: Nick Morrow <usbwifi2024@gmail.com>
X-Google-Original-From: Nick Morrow <USBWiFi2024@gmail.com>
Message-ID: <db84ee3a-1aed-4721-ac27-8c6d116979bf@gmail.com>
Date: Sat, 24 Aug 2024 14:18:33 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] linux-firmware: Add firmware for RTL8812AU device
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-firmware@kernel.org" <linux-firmware@kernel.org>
Cc: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <f815d748-6578-441e-b61e-0a220d45e168@gmail.com>
 <774a7dd01718448da4048e966f5430f1@realtek.com>
Content-Language: en-US
In-Reply-To: <774a7dd01718448da4048e966f5430f1@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/24 19:58, Ping-Ke Shih wrote:
> +linux-wireless
> 
> Hi Nick,
> 
> Please always Cc linux-wireless for rtw88 firmware.
> 
> And subject prefix would be "rtw88: ..."

Hi Ping-Ke, I am trying to resolve what you are asking for vs. the instructions at linux-firmware. Should the subject for V3 be:

  [PATCH V3] linux-firmware: rtw88: Add firmware for RTL8812AU device

> 
> Nick Morrow <usbwifi2024@gmail.com> wrote:
>> This firmware was extracted from the  20210708 - v5.13.6-23 release of
>> the vendor driver for this device and is believed to be the latest
>> release by Realtek. Testing of the new driver has been accomplished
>> using this firmware. Numerous testers have been involved.
>>
>> Signed-off-by: Nick Morrow <USBWiFi2024@gmail.com>
>> ---
>> v2:
>>     - No change. Resubmitted now that the driver is in review.
>> ---
>>    WHENCE                |   1 +
>>    rtw88/README          |   3 +++
>>    rtw88/rtw8812a_fw.bin | Bin 0 -> 27030 bytes
>>    3 files changed, 4 insertions(+)
>>    create mode 100644 rtw88/rtw8812a_fw.bin
>>
>> diff --git a/WHENCE b/WHENCE
>> index 8aebe56b..d6bd4814 100644
>> --- a/WHENCE
>> +++ b/WHENCE
>> @@ -3270,6 +3270,7 @@ Licence: Redistributable. See LICENCE.rtlwifi_firmware.txt for details.
>>    Driver: rtw88 - Realtek 802.11ac WLAN driver for RTL8822BE and RTL8822CE
>>
>>    Info: Sent to Larry Finger by Realtek engineer Yan-Hsuan Chuang <yhchuang@realtek.com>
>> +File: rtw88/rtw8812a_fw.bin
>>    File: rtw88/rtw8821a_fw.bin
> 
> I failed to apply this patch, even this textual part.
> 
> Two leading spaces before "File: rtw88/rtw8821a_fw.bin", but actually this
> should be only one. Not sure what is wrong.

I am carefully going over this patch again... while preparing a new version of the patch. I do not recall editing the line that has two leading spaces.


