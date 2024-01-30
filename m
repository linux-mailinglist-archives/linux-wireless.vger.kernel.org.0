Return-Path: <linux-wireless+bounces-2810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 887AB842586
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 13:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FEBA291E8A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jan 2024 12:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6B74C66;
	Tue, 30 Jan 2024 12:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIHHybCI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A196A358
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619243; cv=none; b=V4D531jPVek1Sl3wOdOZgp3qAPKBdFw2KmxmHaqm0vAwxhukORx7uwXIPJNz3HD2GcjB9GU4DaDut78hjChsRKJCUU1+Ja0Q9kATEg7fpqCbchUZj9WQsioNSx/Xc+IPzQTHmUGpUSER++tHmE8f2VzLgybOqfdbHH0peBB9OjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619243; c=relaxed/simple;
	bh=37rlY7TEdg6MfBVD5uS8l2W6aL1RKwxgfNjE+Z1PAWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kvIZSXcCu62vmlClDqsmlasuiutmxoSsEYqHYNyUoHjKeByKv6eHefaNGsZrDfEBPvUyRuz8SfYMhH7/rE8sWtLeFGgzOgmzTElxq9ECH5WJakzY+SxmW21k55/LlCuQV+6asrQ7GItcGXBo9ME62/qyVPiJ6OYpXAoI0BW7J1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIHHybCI; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6da202aa138so2366135b3a.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jan 2024 04:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706619241; x=1707224041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yh58aEZnPawRcyoxyEguPHXoy0YC/i0Ha+qWlZElNoo=;
        b=OIHHybCI3gonwZmG6S0H98RGoXKFfaNpoI6lll2qXl6mj+D6zT+mMVrYYzS72CFl3J
         2rbPbZ9HLdL3TWwTywKwjZymUDMkjRFaqgNawFzqFOKJapUHsrq/YqGlKx32U+bEPimz
         cWphLWgIKFLMENUZ5eoy5fhEkOdvzXjkkYVOCpbqFozR+TmZMxiDt4jPb4c72HJG/EHq
         GbSvZ/tv+H0lI8dnLI1H/61t7S5v+5p+nQIc3v4lpWSNnt5ExfbTQlK3AeHOy3ypzW6f
         RvliuxV9k/3NMEbTZLHYvhnJnzYwXSsziaB2ShzIaxScm3VhtRHngLAENhPKCIEWgjKb
         xAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706619241; x=1707224041;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yh58aEZnPawRcyoxyEguPHXoy0YC/i0Ha+qWlZElNoo=;
        b=u6G4lU2+8mGLV/NZt9jFFmWg9Fii9suBkPyerxSQrnqocqIGyie+ZxdPz6Sl2aHZah
         sNRwAFKq8AdlP56xY6A0Kna/hVdJkbG9xQRVfzL79HuAVK33PAIYPTkH/BRkLdiLd1Af
         KOw1+SytIk/+PV1BwpuGSoXVexICygcMzkauYN7UJ9TMRFpl8rtq60Dd6wPwyv0VF1oM
         o3/RHFGNv5UGeZheTkLtTbDn+kkg6AOeS1hp1edM4gy0lkPgo3nPf5EuXuXlagd8yAV5
         i87imxklpNaoPMEvoEg1enHRx2efc3Q7/tF4HDYW8T+ARQ98flhKLAVmgZVpRVDmXbAm
         dFlA==
X-Gm-Message-State: AOJu0Yy3DLdDf+YK/0/EUR5ZlATsYiQtA8Yx21vFqBp8tNJ+OLOlbo1T
	FBsdlfECMlpKXtikNqD63jnQZgc/vmp9dvmJLN7vBz8xIEaug13Nt9xnuQRV4OM=
X-Google-Smtp-Source: AGHT+IEFSj5u1r11az+V40GDMyfeJ0AEUzOlxOvLSkE25B5G/x9DQhlbQkodRnRzeWSxj9zh91PG7Q==
X-Received: by 2002:a05:6a21:196:b0:19c:6ce1:d62b with SMTP id le22-20020a056a21019600b0019c6ce1d62bmr8362842pzb.9.1706619241410;
        Tue, 30 Jan 2024 04:54:01 -0800 (PST)
Received: from [192.168.254.83] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id e12-20020aa78c4c000000b006dde0df3a7esm7717067pfd.101.2024.01.30.04.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 04:54:00 -0800 (PST)
Message-ID: <0a2ab448-3205-4ee0-8fdd-428eb2f2ed56@gmail.com>
Date: Tue, 30 Jan 2024 04:54:00 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k multicast action frame RX
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>,
 "open list:MEDIATEK MT76 WIRELESS LAN DRIVER"
 <linux-wireless@vger.kernel.org>, ath11k@lists.infradead.org
References: <dcdbd757-ad6e-4fe0-a0c1-fe328431b73b@locusrobotics.com>
 <642b61a6-e3c0-4831-887f-f25314bf166d@locusrobotics.com>
 <90ac3bdc-8797-4d57-8bc9-48e0ad406674@quicinc.com>
 <1dafe0e5-292b-4764-86c7-cc1757aeb3b6@gmail.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <1dafe0e5-292b-4764-86c7-cc1757aeb3b6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/30/24 4:47 AM, James Prestwood wrote:
> Hi Baochen,
>
> On 1/29/24 11:00 PM, Baochen Qiang wrote:
>>
>>
>> On 1/27/2024 3:18 AM, James Prestwood wrote:
>>> On 1/24/24 5:06 AM, James Prestwood wrote:
>>>
>>>> Hi,
>>>>
>>>> I recently added support to ath10k, for the QCA6174, to receive 
>>>> multicast action frames in order to support DPP. I'm trying to do 
>>>> this for the ath11k QCNFA765/WCN6855. I took the same approach as 
>>>> ath10k which was actually quite simple but I'm unable to see any 
>>>> multicast frames coming over even when I enable RX/DATA debugging.
>>>>
>>>> What I've done so far is:
>>>>
>>>>  - Add FIF_MCAST_ACTION to the supported filters list
>>>>
>>>>  - Created/started a monitor vdev from within 
>>>> ath11k_mac_op_configure_filter()
>>>>
>>>>     ath11k_mac_monitor_vdev_create(ar);
>>>>
>>>>     ath11k_mac_monitor_start(ar);
>>>>
>>>> - Also tried adding
>>>>
>>>>     ath11k_mac_config_mon_status_default(ar, true);
>>>>
>>>> I can successfully create/start the monitor vdev. I see now as I'm 
>>>> writing this email that my specific hardware does not support 
>>>> monitor mode outright... Is this a dead end or is there hope with 
>>>> purely driver changes? or is it some filtering at the firmware 
>>>> level preventing this?
>>>
>>> I was able to finally see my broadcast frame after some additional 
>>> testing. It seems the driver/firmware/something gets a bit hung up 
>>> when I attempt to put it in monitor mode. It will start printing 
>>> these messages for about a minute:
>>>
>>> [   51.093034] ath11k_pci 0000:00:06.0: data dest_rx: new ppdu_id 
>>> a1a2 != status ppdu_id a1a1 dest_mon_not_reaped = 650 dest_mon_stuck 
>>> = 12
>>> [   51.094461] ath11k_pci 0000:00:06.0: data dest_rx: new ppdu_id 
>>> a1a3 != status ppdu_id a1a2 dest_mon_not_reaped = 651 dest_mon_stuck 
>>> = 12
>>> [   51.096281] ath11k_pci 0000:00:06.0: data dest_rx: new ppdu_id 
>>> a1a5 != status ppdu_id a1a3 dest_mon_not_reaped = 652 dest_mon_stuck 
>>> = 12
>>>
>>> In most cases these ppdu ID's are a one-off from the expected ID 
>>> which seemed weird to me. But if I let it sit long enough I all of a 
>>> sudden get a ton of "data rx" messages, which is what I would expect 
>>> if I enabled a monitor vdev. Once this flurry starts I see the 
>>> action frame from my other client, sometimes at least. The firmware 
>>> generally crashes after a while so I've still got a ways to go but 
>>> it seems within the realm of possibility that this device could 
>>> receive broadcast action frames?
>>>
>>> Hoping for some breadcrumbs to follow here...
>>>
>> Hi James, as you already mentioned, ath11k/WCN6855 doesn't support 
>> monitor mode yet. I don't know why you are testing multicast action 
>> frame with monitor mode. So if monitor mode is not a must, could you 
>> test this with STATION mode? We would look into this if any issue found.
>
> As you may have guessed I don't _really_ know what I'm doing. When I 
> got this working with ath10k I saw monitor device was being used in 
> order to receive probes, and did the same for multicast action frames 
> and it "just worked". The frames themselves were still being received 
> on the station device. I attempted to mimic the changes with ath11k.
>
> The end goal here is just that, be able to receive multicast action 
> frames on the station device which currently does not work. I'm only 
> seeing unicast frames when i enable RX debugging. The driver support 
> for multicast action RX in the kernel for this is basically zero. An 
> extended feature flag was added by Jouni when he added support to 
> ath9k, I added limited ath10k support for a variant I tested, and I'd 
> like to do the same for ath11k as we are transitioning to the WCN6855.
>
> And help is much appreciated, and I'm happy to put in the work its 
> just a steep learning curve coupled with the fact that any FW level 
> communication is proprietary. I really just need a nudge in the right 
> direction.

Meant to mention, I swapped out my email to prestwoj@gmail.com, with 
multiple emails accounts sometimes my corporate account sneaks in. Sorry 
for the confusion.

>
> Thanks,
>
> James
>
>>
>>> Thanks,
>>>
>>> James
>>>
>>>>
>>>> Thanks,
>>>>
>>>> James
>>>>
>>>>
>>

