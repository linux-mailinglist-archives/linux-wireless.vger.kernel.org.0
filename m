Return-Path: <linux-wireless+bounces-30242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA9BCEC3C7
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 17:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2FD5E3006993
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 16:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618FA283C93;
	Wed, 31 Dec 2025 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ULNrxI+8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46DD2820A9
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767198092; cv=none; b=gdA8Y/jGGgCx8iqy/JQAu7WYf2HxV4EHo8rCo0Pc+BX9j4bCigGiaA00bGLmOEgar565dkxdnzyVfogiCruzQ1mA93WNssSabm0KxXVpD4NdDHhx8U14f7IEE5lPOMs/EK+beqH5S6hFZqHxPzPN+BnhlK8+pzzjbytyiSPmDVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767198092; c=relaxed/simple;
	bh=PQPa+CUN7MPer5fnijIcj01pN0ziayfCVivvOD3tkS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Am4icy03NcewXR6Bd2LmaBnz8jEYO2YU1IUwBsn8u9chff2YOlvaxLMMirwOuWIzX3sBGetPdx24skB7OyFPIzTYmlTaz+vI0W3tONmnbGRt34NIgR47X/YKVJ08sXQ/1VP0vPRpH8W7mzAtbfZWv99QBdP5u5Z/CVAUOYbHxdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ULNrxI+8; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3e83c40e9dfso7167041fac.1
        for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 08:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1767198089; x=1767802889; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4VxsJvPd3cI1KTNnl7L01TZ9c0Oijs9ErHb2bvB+BxA=;
        b=ULNrxI+8LFnWqLnRNZfMKZ8ZXJ4y4RR2mCoVMiB9Wq0k6HkNay372LWuqdnv1tfXhk
         /SP0jf8RsooInyZaqdox1vv+HcjBFfxKHAJPr6y9fsinQYOxzOEFzSHbkSquMPgIHfoZ
         YVtqoZlZFwPKaEooJkCeJaz3xOUkgAJM4xB+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767198089; x=1767802889;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4VxsJvPd3cI1KTNnl7L01TZ9c0Oijs9ErHb2bvB+BxA=;
        b=afwTN6g+tYmA3XCL+6yYAkRQyv/V5tZLT8Phxkh/vWqlcysLbM9BR8If/MW6AYQRX3
         c5Jdp1wz2jfqjuiUMlf5ijGez2BYvvufgcUzgUQOKj6TsOq0x2yz77EBYj0E6a8UNjiK
         NEflBeUE5uJaZEWsg4ZfFnpUqwZJcb9R8TtMjXWLGHaT3E9KqEjvb7knzo2l9v2KlSJY
         4WcjIG+sFGIwXb8qUzfiBApxylGFpI26OTcJj1OxZdt2DMsxIEoT0Gdnn4yX13VUUsmn
         9tcTN9C3269ghvvA+IV2lA8w9KNLJIdQNadKXDweWCQm5GnfORAMmTbllH/ntuj9NuUm
         /Aag==
X-Forwarded-Encrypted: i=1; AJvYcCXdP6ieOFPch9CFbhzOscx0QeODg+/+wYgBhIRWyjgRi/ozitdYyH9Y0JNLPPyGtzI5/X3mWDgKAj2Giq99/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YywvFboRvamSBVqijA0vwW/fORGecU8GY9o8JSm9p3pByKCBffO
	t9OrvYXbnTo6yS2o1g8myq2eDgjF2HmHWQvkuMWFo1lIMbApaPpFehKGABmyZLu2jZs=
X-Gm-Gg: AY/fxX73fy/SpmqR3a6xILXbCBxvAzZL5xjRACCmInvY2GCs/JW9/DiVCOB4n8JR3M1
	kVhbJHc1NvOu476d6j4VLxBNyWcWDGMQi87LZcRwnLZ9y7C4N0gKYDewLKXy2T1merg8ZncEHlv
	V2fH+eW0RXTQbaew2l89V7cIjlaCW2l0v7Akd3g46Wc7CbqLp9/BKd3tYCGxLYC0nYeAod9Ed1O
	+007Mu4unkG1oHrQ+5nBv42FpvW/FA3fzqUXf3Bxm7RNNbWysRberlv3TsYRs3norxUh0Bh26AL
	Y4HqjQYmsdDtJQRR3wzt31P4qeuhEHoACtyEyC1vf+81987tiyMR4pgdluyavVQRz8pFD7ugGYC
	lom1SQJ10sFXJzCxQHCVINdgRSso6+1IExEe/8MVW6TLSdi4am8VhA4pMhNWX3NbZnTQRmdU2j9
	ok3C08uwjOplauK9Vkc3y4yNM=
X-Google-Smtp-Source: AGHT+IEHyGzJlX9BG5IGxQWI+udvuX8r10ycrsNMN1UZ5U1HR75+jvZ88LGIfUUEQ4FL5FGJJHzKPg==
X-Received: by 2002:a05:6870:c18b:b0:3ec:321c:b2ac with SMTP id 586e51a60fabf-3fda580edb0mr17664156fac.37.1767198088781;
        Wed, 31 Dec 2025 08:21:28 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fdaab65763sm22362927fac.13.2025.12.31.08.21.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 08:21:28 -0800 (PST)
Message-ID: <f9a32a91-e25a-4f25-8c1a-1e4c0e3b07e4@linuxfoundation.org>
Date: Wed, 31 Dec 2025 09:21:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.19-rc1 mediatek mt7921e broke badly
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Matthew Schwartz <matthew.schwartz@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Eric Biggers <ebiggers@kernel.org>,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Mario Limonciello <superm1@kernel.org>,
 Johannes Berg <johannes@sipsolutions.net>, quan.zhou@mediatek.com,
 Felix Fietkau <nbd@nbd.name>, lorenzo@kernel.org, ryder.lee@mediatek.com,
 linux-wireless@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-mediatek@lists.infradead.org, shuah <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <d7f3b00d-beec-41f0-b157-7cfb871f9a46@linuxfoundation.org>
 <756e3f65-b2f2-4da3-985a-17754a7a872d@t-8ch.de>
 <CAHk-=wjO-7uR5HBi-MFnkxAxjhpgfbAQ+HCMKPiXFVwM+AJ7tA@mail.gmail.com>
 <6fc04df5-b753-4b2d-b978-0e59a7f48ff7@linux.dev>
 <c1304430-dd7d-437b-8744-70af9ca85c0d@linuxfoundation.org>
 <8c8c8f27-ba44-48eb-96f6-dae6d2d0cbf8@t-8ch.de>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <8c8c8f27-ba44-48eb-96f6-dae6d2d0cbf8@t-8ch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/31/25 03:36, Thomas Weißschuh wrote:
> On 2025-12-30 16:57:20-0700, Shuah Khan wrote:
>> On 12/29/25 21:21, Matthew Schwartz wrote:
>>> On 12/29/25 4:41 PM, Linus Torvalds wrote:
>>>> On Sat, 27 Dec 2025 at 04:25, Thomas Weißschuh <linux@weissschuh.net> wrote:
>>>>>
>>>>> Hi Shuah,
>>>>>
>>>>> On 2025-12-27 02:07:24-0700, Shuah Khan wrote:
>>>>>> mt7921e doesn't load on my primary laptopn on Linux 6.19-rc1 and problem
>>>>>> still there on 6.19-rc2.
>>>>>
>>>>> This should be a duplicate of
>>>>> https://lore.kernel.org/all/CABXGCsMeAZyNJ-Axt_CUCXgyieWPV3rrcLpWsveMPT8R0YPGnQ@mail.gmail.com/
> 
> (...)
>   
>> Reverting the following fixed my problem.
>> f804a5895eba ("wifi: mt76: Strip whitespace from build ddate")
>>
>> The above fixes an extra newline in the dmesg by making the
>> code more complex it needs to introducing local buffers and
>> strscpy() - the proposed fix replaces this with memcpy().
>>
>> Is there a simple way to do this than introducing memcpy()
>> or strscpy() to remove an extra newline that might or might
>> not exist? Why not check if newline exists or not using
>> strstr()?
> 
> We do have memtostr() which would be a perfect fit to use here.
> That is still a memcpy() under the hood, but the code is clear and safe.
> It does however require the source to be annotated as __nonstring.
> Which also seems to be the right choice here anyways. However for
> consistency, all other similar fields should also be annotated in the
> same way. So it is a bit of a larger change than a pure bugfix.
> 

I am playing with just removing \n from dev_info() - there are
three dev_info()s in the same routine that print the same
information. I will also take a look to see if they are indeed
needed.

thanks,
-- Shuah

