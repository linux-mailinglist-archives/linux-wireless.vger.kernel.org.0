Return-Path: <linux-wireless+bounces-19215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752C7A3DBCA
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 14:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 582B017C7DA
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Feb 2025 13:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D04A1F9AB6;
	Thu, 20 Feb 2025 13:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3daON+2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF10D1F91E3
	for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740059760; cv=none; b=BNmtcKezv84/ImkrVPq5Qh3Ma486V7A9p9AcBv1kuOxyw3Gvs+9BDFBn1tD8u+caMydeCPbCd/hhlqzraNWtEsKDbrSHloEzmpGbK/4XFx75MHz/pfdJ+SNEOCI6TsbturGFmsOKwvNS4zfJWBTDLnGJlIiQ4vZIhkuytecP/L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740059760; c=relaxed/simple;
	bh=E8R7d+nbY0Cbw1Bt89Ilj/wJog3OxmHABvuKNlKv5qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMpg/69WVCSdGgm0LATIgA4Z0cCLgLAQLWVvP6Te3B2oAE9wNlb66Nfuhe0HVHiYyEdRsSq8XZVTuzQWbMONlzs+Y6VLfv7pZ5Q5oZnqudyIfwPmEAEHwQwd3hL0OkQNEGr222oAMcZJHlUeX9YjFE/bjjoTQOP0D6S7YqZ4DoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3daON+2; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e6827984b2so10340086d6.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Feb 2025 05:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740059757; x=1740664557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pSs/K2VQQrrOagAXRPAvXhDuiMH4NijPOc7sJYHkPsg=;
        b=M3daON+2cov2sUkv+9hKlD1ghNAI3Za2+5r7PWab5EIgEj+FlrarVl8iKY7ch/B/5B
         /88zWFdLIkKH5d983YCmdDWuw3HpPxtSa3LSS6N5eySiql0ecyz7Zvesmob390cZ1yNc
         nOJNu3B4fzkEZ3Re5ud/o1lxOB2dAlkQ1V4Q+cLpzdsgOWv6Oh3CaQ1EM2h707eamwFg
         oC6c1ndV2vLlIXHU+wy0O4NOj89LJrKBry7TULJi/RHoINZ4J8jkSATbrYfY89OPx1eW
         CE2MXOZB4GTQBUMBPxuyKfbK1RHT/e65OkfgXSMPg6RFhjcz16M5UPOX7C0wJfu+3Xeo
         bn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740059757; x=1740664557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSs/K2VQQrrOagAXRPAvXhDuiMH4NijPOc7sJYHkPsg=;
        b=BnlBBvDFxecVzJlxpxgojgl4UNk+fJ9Z6Gfc3Tq6AAkb9Efx/yxFoofE+EkpNHz6zI
         RsZgBIUcBuq+NkSfgeMfjUyV37tEpG1i6NqWR23ksHA0ylgaTfpux+zT96qGFHb0GiOh
         TRTy5T/rj1DUoCnfHSYwDrFyKFeunTsPxSzwv8ZhyQk1CEYS6jxKNWodXYYH7p6SuEKf
         9N8xyDAzSb6/ybh3Aan3YV4CRgbmVdXhavWAyBMPVaNP13tcRXuwMakGZLTMys+q+ZA0
         Ogw+nXsmsGO5kc9rebSS4OOPTtvn4YsFV9S0i7nU+i1YWAlHThwpqYnpt7vqeNpmZ/Zq
         t7Dw==
X-Forwarded-Encrypted: i=1; AJvYcCUhlzIY2WMBv3JGeEEC59KDd/hzWfTdl8wA2gkjCgilX5faakfBda92lMYk4MWzrPN2uAJ3kbjhiPmo10U/eQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsm9RFz7FRxRK7V8rXflTGLhDamEKtHQoeeIY/PWwgpOIFZjGX
	DD56Kvz02GIXQqqOdV/W9fHwSwemtF8wVd08d8zj4cfVuXturYjJ
X-Gm-Gg: ASbGncuEHWY+KdGnkoHLjG++zKMUNNAE0HuLnQAaoisq61vwJNeNU5ZprCkl/kh+pps
	dvOeCgFuzLhGQ45GyRSFkiDHxf2GZABa572Wv3CnqX0wfaUYrxWBg/5VOSmrIyBwfIx3Qi7gZSU
	nWrUUw40jYHieEhdzeS/b3FYqBMpgpkvAC2Bm6+BN3p+d+BFwQu+kKzVpZ4vMGlx+G2KeIp0ECu
	qf1T3do+oKwbFnpdIBLv7rQnGE9ekHwTv4KWjCNaefUZCs/hLJrRBeGXEWbwDFmvapox+x+tHAt
	raeudBSiMRoWWgYqSKk=
X-Google-Smtp-Source: AGHT+IG//EwMg38LvAk1MF7ryiTZFxH2eRowNFWBaeVsSmMv9351WHPYqaTDf4aQnLSkkZsRhf8o6g==
X-Received: by 2002:ad4:5fcd:0:b0:6d8:a0c8:e468 with SMTP id 6a1803df08f44-6e66ccd4b26mr282933056d6.24.1740059757566;
        Thu, 20 Feb 2025 05:55:57 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65dcf946asm86463026d6.125.2025.02.20.05.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 05:55:57 -0800 (PST)
Message-ID: <966f3c12-4995-4b46-a833-3b5522921764@gmail.com>
Date: Thu, 20 Feb 2025 05:55:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] ath10k: failed to flush transmit queue
To: Kalle Valo <kvalo@kernel.org>, Felix Fietkau <nbd@nbd.name>
Cc: Cedric Veilleux <veilleux.cedric@gmail.com>,
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
References: <CA+Xfe4FjUmzM5mvPxGbpJsF3SvSdE5_wgxvgFJ0bsdrKODVXCQ@mail.gmail.com>
 <1df0c5cc-ce58-450e-9f91-7f8f599cb11d@nbd.name> <87le1hjupo.fsf@kernel.org>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <87le1hjupo.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi All,

On 7/31/24 11:13 AM, Kalle Valo wrote:
> Felix Fietkau <nbd@nbd.name> writes:
>
>> On 12.07.24 04:23, Cedric Veilleux wrote:
>>
>>> AP mode.
>>> Both 2.4 and 5ghz channels.
>>> Using WLE600VX (QCA986x/988x), we are seeing the following errors in
>>> kernel logs:
>>> [12978.022077] ath10k_pci 0000:04:00.0: failed to flush transmit
>>> queue
>>> (skip 0 ar-state 1): 0
>>> [13343.069189] ath10k_pci 0000:04:00.0: failed to flush transmit queue
>>> (skip 0 ar-state 1): 0
>>> They are somewhat random but frequent. Can happen once a day or many
>>> times per hour.
>>> They are associated with 3-4 seconds of radio silence. Full packet
>>> loss. Then everything resumes normally, STA are still associated and
>>> traffic resumes.
>>> I have tested with major kernel versions:
>>> 6.1.97: stable (tested for many days on 10+ access points)
>>> 6.2.16: stable (tested for few hours single machine)
>>> 6.3.13: stable (tested for few hours single machine)
>>> 6.4.16: unstable  (we have errors within an hour)
>>> 6.5.13: unstable  (we have errors within an hour)
>>> 6.6.39: unstable  (we have errors within an hour)
>>> 6.7.12: unstable  (we have errors within an hour)
>>> 6.8.10: unstable  (we have errors within an hour)
>>> 6.9.7: unstable  (we have errors within an hour)
>>>   From these tests I believe something changed in 6.4 series causing
>>> instabilities and the dreaded "failed to flush transmit queue" error.
>>> This is a custom linux distribution. Only change is the kernel. All
>>> other packages are same versions. Everything rebuilt from source using
>>> bitbake/yocto. Same linux-firmware files.
>> I'm pretty sure it's caused by this commit:
>>
>> commit 0b75a1b1e42e07ae84e3a11d2368b418546e2bec
>> Author: Johannes Berg <johannes.berg@intel.com>
>> Date:   Fri Mar 31 16:59:16 2023 +0200
>>
>>      wifi: mac80211: flush queues on STA removal
>>
>> I guess somebody needs to look into making the queue flush on ath10k
>> more reliable (or even better, implement a more lightweight .flush_sta
>> op).
>>
>> I don't have time to do the work myself, but hopefully this
>> information could help somebody else take care of it.
> Adding ath10k list so that everyone see this.

I want to revive this thread and provide some additional data. This is 
not just something that happens in AP mode, or specifically with the 
hardware mentioned. After upgrading from 6.2 to 6.8 we started seeing 
this on client devices running the QCA6174 hw 3.2 firmware ver 
WLAN.RM.4.4.1-00288- api 6. We see it during disconnects which isn't as 
big of a deal, the more concerning time is during roams which makes 
roams go from less than 200ms to over 5 seconds.

Based on this report I have tried using Remi's set of patches [1] which 
implement flush_sta(), but we end up with the same ~5 second hang, just 
in ath10k_flush_sta() instead of ath10k_flush(). I'm unsure if this is a 
firmware problem, or some race within the driver itself. In the past I 
have reduced timeouts [2] to work around these type of things but its 
really just a band-aid.

I would agree that this was "introduced" by Johannes' commit above, but 
the original commit does make sense... This is just an ath10k problem 
with flushing the queue's.

At this point I'm really left with two options:

  - Revert Johannes commit to flush the queues, thereby reducing 
security, OR

  - Reduce the timeout from 5 seconds to something more manageable, like 
1 second (hopefully someone more in the know can comment here).

Has anyone else looked at this regression? Maybe has some workaround 
other than my options above?

Thanks,

James

[1] 
https://lore.kernel.org/linux-wireless/17d26d6a3e80ff03939ee7935fdc07f979b61a4f.1732293922.git.repk@triplefau.lt/

[2] 
https://lore.kernel.org/linux-wireless/20240814164507.996303-2-prestwoj@gmail.com/


