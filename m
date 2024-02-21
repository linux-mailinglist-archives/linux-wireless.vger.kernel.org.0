Return-Path: <linux-wireless+bounces-3857-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 356E585D7E2
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 13:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5904C1C21E11
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 12:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE5451C30;
	Wed, 21 Feb 2024 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKMYueo7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F259A55C3C
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708518292; cv=none; b=f9JYXjb44qNZ38OzuNuolryXeoEHL8ahgvqwVsxM4lK9KYJIWugAUsAEU1vZQogtlrMzaK9lQmMq7AnXpKWIKYfuPvv5PpWXPG7Mgphu1Rcs4kzICEKK7GtQ71yt6GJ4uWd5Nf74WfB4RU9d0ilkyEs2PU8bfg+njlj0vLuc/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708518292; c=relaxed/simple;
	bh=ZTh9IpAXXJ1qqf7ZWeJmXMLLunYfQM1CIFlNKOQsc9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B5AioqfOKIvC/bVMPcAjTZ6naquLQTfVvWBLB4Bc9Qvf5+Jk0CalVWzA7BMZiu9aUTA4mvSpU7N2+UYDV/nFUuV18BfyTSWN3Zy37ZruPYn+qrEn1QKrt2fSLViwZoAvDaaZ5f2XGeU4RjXaimnuGIigbRsDQ4ohk6hVa+1B5s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKMYueo7; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dc0e5b223eso20436475ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 04:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708518290; x=1709123090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66a1SkriqYZwFi+KxueabQNi4cABZqW0pWRLSi43YVE=;
        b=PKMYueo7X4hdbwkXp8OE3j8p5ibzgaHM3wux8ciKIvPBPPGGVbSQEzQ6a2XT9L3wdX
         MI9CiSsaBFqAeRjd1QXSgvY9TN+RmnEX8fRRn4E+8DC/5Pc81VssME+XaYIjJBkL20gJ
         Mx2MeDiOLNwgqKEr347NsBEHIQbZBv6H8yy6UTIvQujwNqqiey+7UaY7ZcFlcipNnUpD
         DYlDM3AHUheW4aHchjb1SuZ2o7ydn9QQIq7ODKFuCenKtWLDTESQSHWr4o8XSmqAAhO7
         L2E6/4w6AKhac+pp/gGSPyVbXqOBtkboxaxMFN0EsNrV/+kaiUKcwLD20PbKkkXergHL
         ac/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708518290; x=1709123090;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66a1SkriqYZwFi+KxueabQNi4cABZqW0pWRLSi43YVE=;
        b=cRJaXnxz8oLCWuYhdgDgDdEPNbiF31/CwqMTdsq9dyxaxCsUbVWmr0wxx9GuaSZYem
         P5oo8fH0bhblEEBaE6hrHVf5R/K6lePFxFQs/1RDrk8PfWpMRJSL5uHzFSv0cDJia9EO
         Qa+AWCLAr9VmJ48Obajwjdx89QaWDLVhEkaElOWR6cTbOIRdmrN5S3+8YQ4sqMwoQolB
         Au2rKuUtpxbAdN10KbhTX1UjVvVD0Jlw3UqUOk27e9N/iSbYvm7DyB5SKxnSkZYy4JrX
         XGIXz19x58CIWbxlx3NajuF46SQ6PGK2Ux9xGDxbPHNZtMAMhkSvPd1m+hmidZZZ+zVT
         Nb4g==
X-Forwarded-Encrypted: i=1; AJvYcCWQY3kWKxWoBx7FkgrkKSVX0TAES+pejR3ZgVDuuRfSwUNoZYZieQB0nr3EcB07CcKKxXhxXUjEMdlZ5q2H5Ntw29aKGBrMB0BdEJsJQ/8=
X-Gm-Message-State: AOJu0YwgiZMqcrI0qrpP5X7szaJlo1EMV6lbMGjxgp7v9+7llgBzToXt
	A7hMlRvHD4ArkzTBwA38y1ItEl4GpSbz56SNdoxMjJZPBucrPtii
X-Google-Smtp-Source: AGHT+IHsgSyPRttNapmppYGXK+6DSIPGbvQQeZ1yGtvCffImSGXYgZvo/wz8HielDR5at32g8xM2+Q==
X-Received: by 2002:a17:90b:1c0b:b0:29a:36f0:7d7e with SMTP id oc11-20020a17090b1c0b00b0029a36f07d7emr27134pjb.38.1708518289806;
        Wed, 21 Feb 2024 04:24:49 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id ch19-20020a17090af41300b0029996fd70e2sm6749962pjb.45.2024.02.21.04.24.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 04:24:49 -0800 (PST)
Message-ID: <eaeb8e9b-3809-4f89-a5b2-7949aa01fbde@gmail.com>
Date: Wed, 21 Feb 2024 04:24:46 -0800
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
 <ed8eeb92-e1eb-445e-989d-2340c26faf44@quicinc.com>
 <7a62031b-ad1f-4da2-8217-19a5d7fdc0f4@gmail.com>
 <f363f179-b41f-4bea-882f-e4aacb8ad519@quicinc.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <f363f179-b41f-4bea-882f-e4aacb8ad519@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2/20/24 7:45 PM, Baochen Qiang wrote:
>
>
> On 1/31/2024 8:28 PM, James Prestwood wrote:
>> Hi Baochen,
>>
>>>> As you may have guessed I don't _really_ know what I'm doing. When 
>>>> I got this working with ath10k I saw monitor device was being used 
>>>> in order to receive probes, and did the same for multicast action 
>>>> frames and it "just worked". The frames themselves were still being 
>>>> received on the station device. I attempted to mimic the changes 
>>>> with ath11k.
>>>>
>>>> The end goal here is just that, be able to receive multicast action 
>>>> frames on the station device which currently does not work. I'm 
>>>> only seeing unicast frames when i enable RX debugging. The driver 
>>>> support for multicast action RX in the kernel for this is basically 
>>>> zero. An extended feature flag was added by Jouni when he added 
>>>> support to ath9k, I added limited ath10k support for a variant I 
>>>> tested, and I'd like to do the same for ath11k as we are 
>>>> transitioning to the WCN6855.
>>> OK, so you are testing this with latest ath.git, without any private 
>>> changes, and it doesn't work, right? Could you share your test 
>>> steps? Basically how are you sending multicast action frames from 
>>> AP/peer, and how to check if that frame received or not (I am 
>>> assuming by checking RX logs)?
>>
>> Yep I'm on the latest ath.git, and with no changes apart from that 
>> MSI vector hack to get it working with vfio-pci.
>>
>> The way I'm testing this is using IWD with DPP PKEX. Building IWD 
>> should be relatively straight forward, very few dependencies. This 
>> will also include iwctl which is IWD's command line utility:
>>
>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/
>>
>> I have two devices, the configurator device (device A, ath11k) is 
>> what should be able to receive the multicast action frames. The 
>> enrollee device (device B) can use probably any hardware as sending 
>> multicast action frames should be supported. IWD will not start a DPP 
>> PKEX configurator without EXT_FEATURE_MULTICAST_REGISTRATIONS set but 
>> if you enable RX logging that should be good enough to see if the 
>> frame is making it to the ath11k driver itself. Once multicast RX is 
>> supported we would need to add that extended feature to ath11k, or at 
>> least the tested variant. If you want, you can hack in that feature 
>> bit and start a configurator but if your able to get the muticast RX 
>> working I can probably take it from there:
>>
>> 1. Enable RX logging on device A
>>
>> 2. Start IWD on device A
>>
>>      iwd -d
>>
>> 3. Connect to a network on device A
>>
>>      iwctl station <wlan> connect <ssid>
>>
>>      <enter passphrase>
>>
>> # Optional: start a configurator. This won't work without the ext 
>> feature set
>>
>>     iwctl pkex <wlan> configure secret123
>>
>> 4. Start IWD on device B, do not connect.
>>
>>      iwd -d
>>
>> 5. Start DPP PKEX as an enrollee on device B:
>>
>>      iwctl pkex <wlan> enroll secret123
>>
>> On device B you should see IWD first scan to establish nearby 
>> APs/frequencies, then begin iterating those frequencies and sending a 
>> multicast action frame.
> Hi James, I reproduced this issue following your guide. From the 
> advise of firmware team, a new flag is needed. With that flag, I did 
> see the multicast action frame in device A logging. Before I proceed, 
> want to clarify something: that frame is only seen after device A 
> triggers a scan (I triggered it manually using iw, not IWD itself 
> because IWD not working on device A due to unknown errors), if no scan 
> no frame seen. I am not sure if this behavior is expected so now 
> checking with internal team on it.
>
> So there comes a question: will IWD triggers scan on device A in order 
> to receive that frame?

That's great its possible! And thank you for looking into this.

That seems very odd that device A would need to scan in order to receive 
a multicast frame. In all reality neither device should have to scan at 
all, device B just does in order to know what frequencies to start 
sending the multicast frames on. Even this isn't entirely needed if the 
frequency was known ahead of time. I think something is not right if a 
scan must be issued in order to receive these frames. This wasn't 
required by ath10k when I added it, nor is it by mac80211_hwsim; you can 
just start listening and receive the frames.

Thanks,

James

>
>>
>> Thanks,
>>
>> James
>>
>>>
>>>>
>>>> And help is much appreciated, and I'm happy to put in the work its 
>>>> just a steep learning curve coupled with the fact that any FW level 
>>>> communication is proprietary. I really just need a nudge in the 
>>>> right direction.
>>>>
>>>> Thanks,
>>>>
>>>> James
>>>>
>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> James
>>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>> James
>>>>>>>
>>>>>>>
>>>>>

