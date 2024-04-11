Return-Path: <linux-wireless+bounces-6197-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E868A1DC6
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 20:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDE4628AA28
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 18:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866A9205E39;
	Thu, 11 Apr 2024 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8s+UbqG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B17056458
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712856517; cv=none; b=GskjjQvj/x1y3tTHriP3CkZJB4vua6ufYU0ZZz6eK0QDnlh8qifrPvIUhK1TjtRqT9YtF6mTZnsv6VOBjL7bqPIkhDjldsR2bxyMQKmJwKFHS3MY+3AareBAPGmLj8xwXS/AvaHzOXP4sE0OjL6o0j1CnmdWbkNXRmCheVD7mKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712856517; c=relaxed/simple;
	bh=YEGi9Jy+zH0Fbu65l8woHH0AF4eBEty5nu13kp4o6d8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qkLqa0yanpM+/slNbNVYVNtXHdlVSO6L0bEqg75hjuBx5VxPSeKqcIiJrXGkgYpBXBbvrVZHvy1E3KLdg5weDU1TkcaeFXpY2189HhTHE4nG5phjYrjowTMCHR/ZXjmsX8tyW/MFulAVhO5K+4rHhyTLQXf6ABKFcPTys6DuofI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8s+UbqG; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5a7d6bc81c6so58511eaf.2
        for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 10:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712856514; x=1713461314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0T8rtoqQ92EDxuwLceugcaPWhIqaMxutxDInAl4oXOs=;
        b=G8s+UbqG8h0kHmqn35Y7JN+oh8ZHC8SrZzQDo/nXl81kp29Ea4AERjhTfgA2T1DFOD
         77G1f1y69A/nFqxwhfKpu6W7Du54QJV6WnJCwY6gSywyWP51zGbUBMYoqRF6FRXYUc1K
         5NhdHsK6lC7AdYE+ycAO1vkp9rfTtbxZK+LWaTWj3+pidHmJVpiFcKc39I9GhbBEFPj2
         v1Q/ajTwZkm9tVuIwgdFvuaa5T6BCKIBcPRCoUY/0RRMQ/gOVIHM/gL96qUHjGP+/pCh
         kz7XIXkVmPvS5V0PyHtPl2BehzoAA47vMwPDiyUdK2BIoNRy3MCLGT22mMogF6am/Wir
         D5gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712856514; x=1713461314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0T8rtoqQ92EDxuwLceugcaPWhIqaMxutxDInAl4oXOs=;
        b=p3Q6ATjuqrzzD7QBAMoAp+3AXXvurEO/OHyeVkwwM0xvi5fPZf9X5Ybkt7iSk0gNU+
         IztrlKmJxII+g3YAer2u4hQuwn+eBcPIkFwuXcxQEez435VzSWGfQrOXHkn5qyQiXkST
         pqistVZH2nrIWgDkWMqOJZSICCqaQXUh7HAXTGKopcS/oobRiDwM9dbNfxcFHKHzip7M
         n83jCV37dqTPxWE+n7Q7Y8Tja3lFobge6eg37Eqf7Z5OXS9aAd9SHhfdh64zwRtjvtFY
         jyoIwY8w7qyhg6wVJz47Hw8STaYyJuW5HMhpwrh7x+sUSO0WmAycSRfgBXUXDXwmgmfX
         7UgA==
X-Forwarded-Encrypted: i=1; AJvYcCVMBcJ57sLTFE0vozE3kc0u+MwYuvh4lY4Np6bkYo5MBalPrU858aFCRDujgxvcj3D3Mq6hNKAWdZiT081C0/lfpW/bz+pg8Gdnk9JQ06s=
X-Gm-Message-State: AOJu0YwgD8WN2OmrLR8BZ6cD9uRMge/JGmm4bIhsfgz2Qg2LRhcmNpil
	KkOSAwOqz7qBPJj52ZeTLXj77Xfu2LT5j8CGPdWWNNti9/DohZ1i
X-Google-Smtp-Source: AGHT+IF2VHmoqavvNAVsZhtSDshMzodfyvV3IJQ+2x4RRdPtaxtgzQ0JgtsglTpciWB2Ad2kqheJow==
X-Received: by 2002:a05:6870:972a:b0:220:bd1c:6c21 with SMTP id n42-20020a056870972a00b00220bd1c6c21mr145816oaq.39.1712856514381;
        Thu, 11 Apr 2024 10:28:34 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id wz2-20020a0568707ec200b0022e9ffdb5a5sm434641oab.24.2024.04.11.10.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 10:28:33 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <46745fe7-a43d-4f7c-b247-f0fde01ee63e@lwfinger.net>
Date: Thu, 11 Apr 2024 12:28:33 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] rtw88: Fix startup problems for SDIO wifi plus UART
 Bluetooth
To: Kalle Valo <kvalo@kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Larry Finger <Larry.Finger@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <4umro86wvv84.MjDfYvt4P5uZryt8boBK8Q2@1EHFQ.trk.elasticemail.com>
 <5af71338f3904aac9d2c237637c851e7@realtek.com>
 <287e9d4e-316a-4579-961e-58e75abea534@lwfinger.net>
 <87o7agjs00.fsf@kernel.org>
Content-Language: en-US
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <87o7agjs00.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/11/24 2:08 AM, Kalle Valo wrote:
> (dropping stable list from cc)
> 
> Larry Finger <Larry.Finger@lwfinger.net> writes:
> 
>> On 4/10/24 9:13 PM, Ping-Ke Shih wrote:
>>> Larry Finger <Larry.Finger@gmail.com> wrote:
>>>
>>>> As discussed in the links below, the SDIO part of RTW8821CS fails to
>>>> start correctly if such startup happens while the UART portion of
>>>> the chip is initializing.
>>> I checked with SDIO team internally, but they didn't meet this case,
>>> so we may
>>> take this workaround.
>>> SDIO team wonder if something other than BT cause this failure, and
>>> after
>>> system boots everything will be well. Could you boot the system without WiFi/BT
>>> drivers, but insmod drivers manually after booting?
>>
>> I sent the request to the user with the problem. I do not have any SDIO devices.
>>
>>>
>>>> ---
>>>>    drivers/net/wireless/realtek/rtw88/sdio.c | 28 +++++++++++++++++++++++
>>>>    1 file changed, 28 insertions(+)
>>>>
>>>> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wireless/realtek/rtw88/sdio.c
>>>> index 0cae5746f540..eec0ad85be72 100644
>>>> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
>>>> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
>>>> @@ -1325,6 +1325,34 @@ int rtw_sdio_probe(struct sdio_func *sdio_func,
>>> [...]
>>>
>>>> +       mdelay(500);
>>> Will it better to use sleep function?
>>
>> My thoughts were that a sleep function would tie up a CPU, whereas the
>> delay would not.
> 
> It's actually the opposite, msleep() allows other processes to run.
> 
> "In general, use of mdelay is discouraged and code should be refactored
> to allow for the use of msleep."
> 
> https://docs.kernel.org/timers/timers-howto.html

Kalle and Ping-ke,

Sorry that I got that wrong. I have become just another confused old man. :)

The OP at GitHub has tested kernels where he blacklisted the BT drivers. The 
wifi failed every time (3 tries with a delay and 3 times without). When he built 
a kernel with BT built-in rather than as a module, it worked (again 3 tries). 
There definitely is an interaction between the BT initialization and the wifi 
setup. If the BT part is not started and has not completed the UART 
initialization, SDIO wifi does not initialize correctly.

When it fails, unloading the wifi driver and reloading it restores wifi.

I originally wondered if there was a power problem when both were simultaneously 
started, but I see that is not the case. To reiterate, the BT must start first 
and complete UART initialization before the wifi starts initializing. It seems 
to me that a suitable msleep() at the start of the SDIO probe routine seems to 
be a viable workaround even though it is not aesthetically pleasing. A sleep of 
150 ms is too short, but 500 seems to work reliably.

Perhaps the SDIO experts at Realtek may be able to offer a more satisfying 
explanation. The OP at GitHub and I will try to answer any questions they might 
have. Note that I do not have the hardware, but my contact at GitHub is 
knowledgeable, and seems eager to help.

Larry



