Return-Path: <linux-wireless+bounces-14657-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A015E9B4FE2
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 17:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2497282210
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 16:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CB01DBB0D;
	Tue, 29 Oct 2024 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrxHdU8f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD351DA109;
	Tue, 29 Oct 2024 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730220933; cv=none; b=XBQp7dVFO5UCJLeggkVeW+khUXsyRxQ4GdJbBO6eWxOH90mgJo+FTNvA83hzh4ox0xjm8fs0m6yT/Wr25V1woLNp27WFoml5+RPbo7OECFyrLfx59bRIFwHFsXuPnh4IeEB7T/ojuMjNBm+TfY23QVyDosj6//GhVXYR7GPH62Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730220933; c=relaxed/simple;
	bh=ImzQCH+ElIZyec1q+jTsxb3591cOsayG2TTvgKePiuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3YOsVcSxKZBwUd/wQekzXPal64ic05lLHRtxxcUeWElPnnHo4ct8PlMLJQl6aoxgc9j/F0u6O41NAA5KkCo4uw6n2Gz+WCvIQj16Y6od3dpjka0wKI/tNqyQ4G/rAWExvlxFXrGWBNxKG2tnorK5x+0ebGGVelsWSwYhms+zpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrxHdU8f; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-460ab1bc2aeso34978841cf.3;
        Tue, 29 Oct 2024 09:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730220930; x=1730825730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NV7+11P6IP6fL3dudKkoFNDPPkiYDy8aACWR+asLUpc=;
        b=KrxHdU8fAuJOzN7SX8kHC9HCY4I74nhPSCkiUSV8M4zGpG5AV2jT2MWx3RenpCBV02
         Z01SjmboFiBc8mcziKw/qK9Vfv9ul8rAtjn4KnE2QzGpVRMJ18TYseWFYVRZSOXnnbhj
         7RAuWLrZGOnePAyg+DHqsTD+OqoH5DeWg3kBBIZBowxFCb/2SHU41p3aM30TrHmZhPyA
         QOvb3yMeJUuCHHDVV9ZXAEVSOEyCnRqnVdG17or9HY3k1FzbYX/z+a2OetFSh3SOWSA9
         z0KnSDAu9IDK/zOueST5m9C51I6ltnAk0BfsnWvT1KDskNka31259xXUB24/r0zW+5dx
         weIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730220930; x=1730825730;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NV7+11P6IP6fL3dudKkoFNDPPkiYDy8aACWR+asLUpc=;
        b=c5M9xnndhqfw87MH+4y96RUU3Y8tLYK6pnGy//CUfkEU1MF/3pGIjp6A4iTGU6uLW+
         IXe848bOxoomcK+kSpVpKw/eM9orTuTZU3sKPDUA4gXqxmHNM+yoT1gw2SBrElm/vZfD
         PCAiDmFWXVyJ6cg9PhEkKfAcfC735MUW6y4bnTC7DUEDokSZrYnfg8oKlUUbwji22l2S
         uuho2DKPqeYZ7N+EWjvU3ozoQ+k/w+zFGYKtAcBLb+++3hriapY+XC4CsMiiYXdhenFW
         /ufNi967KssjBwhKubRe0ZpwQKMPXe3Q/Msic/3FbGr2OjV1CPOun+sCi8n2SkP8gT9/
         ykjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkHsEJA76NfpPcQ6pO8i4jl0Z2xpDT8N48soo46JIwoHyaWVGseMJeLRw9DU+HcnBLwWk1xJVL4ZwEORk=@vger.kernel.org, AJvYcCVvKpsuZ+ohDys+zkhYBjhdV/o/Auv4bx2yBIwHJaF4cUmSThryRMxd7rowmnUPyewRp3QKIKy4@vger.kernel.org
X-Gm-Message-State: AOJu0YztJzokRweKsBNt1pKUa3XVbSjw/svEBqTUM7AJgxI5K43jk3wj
	CLpuERkDy4sErSZjCO4xmskHQ/ozPhP1N3ix6ndNTRUmuMlZQ7rm
X-Google-Smtp-Source: AGHT+IGJo/n2GXzas1QOCnqNw7j7TGroghd68OmFRCuyK91aOyz9vd/UBY8qT4kEwxXSaeCunMHvWQ==
X-Received: by 2002:a05:622a:1a8a:b0:460:9946:56af with SMTP id d75a77b69052e-4613c198696mr221933341cf.44.1730220930267;
        Tue, 29 Oct 2024 09:55:30 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461323a1fbesm46202051cf.82.2024.10.29.09.55.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 09:55:29 -0700 (PDT)
Message-ID: <baf6d88e-e753-4aaf-a340-991373d77fa8@gmail.com>
Date: Tue, 29 Oct 2024 18:55:25 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtlwifi: Drastically reduce the attempts to read
 efuse bytes in case of failures
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "kvalo@kernel.org" <kvalo@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com"
 <syzbot+edd9fe0d3a65b14588d5@syzkaller.appspotmail.com>
References: <20241025150226.896613-1-gpiccoli@igalia.com>
 <ed8114c231d1423893d3c90c458f35f3@realtek.com>
 <61aae4ff-8f80-252e-447a-cd8a51a325a1@igalia.com>
 <c93c8e9c109b444b91489ac0e88b987c@realtek.com>
 <14c3164c-0e1e-4d9d-89d9-28d3240861c6@gmail.com>
 <d6e01e56-51e7-cbb2-024a-c7db86dc70fb@igalia.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <d6e01e56-51e7-cbb2-024a-c7db86dc70fb@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/10/2024 15:31, Guilherme G. Piccoli wrote:
> On 29/10/2024 10:20, Bitterblue Smith wrote:
>> On 29/10/2024 02:50, Ping-Ke Shih wrote:
>>>>
>>>> But can you help me on finding a USB adapter that runs this path? If you
>>>> know a commodity model that uses this specific driver, could you point
>>>> me so I can buy one for testing?
>>>>
>>>
>>> I don't know that. Maybe, Bitterblue Smith (Cc'd) can share how/where he got
>>> USB adapters. 
>>>
>>>
>>
>> I got them from Aliexpress. Both listings are gone now, but I still
>> see others:
>>
>> https://www.aliexpress.com/item/1005007655660231.html
>> https://www.aliexpress.com/item/1005007688991958.html
>>
>> Mine was only 6 USD in March 2023. I don't know why this obsolete
>> product got so expensive.
>>
>> For RTL8192DU only modules are available:
>>
>> https://www.aliexpress.com/item/4000191417711.html
>> https://www.aliexpress.com/item/1005007343563100.html
>>
>> Someone gave me this link (I didn't buy):
>> https://www.amazon.com/Netis-Wireless-Raspberry-Windows-RTL8188CUS/dp/B008O2AL0K
>>
>> Note that the Netis WF2120 can have newer chips inside which will
>> not use this driver.
>>
> 
> Thanks a bunch for the info and links, much appreciated! I can try to
> grab one for testing, but let me ask also: would you be willing to test
> that for me, Bitterblue? If so, I can resubmit today with the PCI check.
> 
> If not possible, no worries, I can buy one.
> Cheers,
> 
> 
> Guilherme

I tested your patch. Both my devices can still read the efuse.

