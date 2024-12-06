Return-Path: <linux-wireless+bounces-15969-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A599E6E17
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 13:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6171882E68
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 12:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879CA1D9A4E;
	Fri,  6 Dec 2024 12:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLc4kZuQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D6C2010F4
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733488045; cv=none; b=LPXsI30LncdRyF19y6Jv+3prcFx7ieAZtFJGwytxDT2AQx+PXr2ITyToS5BCHM1F7IiUvmbGwJdKB6J+Ibt9lizTQ7oGegbjipNc9IktH+d0XdMDlCZHryRBKVCPJxcSR2QvUJGQV+mgUehwYeCn87Zvp/cBurbjpflZCe9S7QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733488045; c=relaxed/simple;
	bh=js5htYTqIT+yjjdW3GG+ip0utxJcW2mmg0QTtTRWtR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qqwBbGdZJ+v5QuYaVz4LLTA1Q7tmcykIKUCawb+JTW597HMofdTAcp+hN+zd+d5OU9dbEKtzo3/odLuKKAztxel6UWHo8WPX28yRUIhaFVRfyA6rzo872JDWmKiabQho3HYCb3e+Whu6iFpkPzCyPtJ86BbeEqRDjQIiEDOZDjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLc4kZuQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21619108a6bso3588375ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 06 Dec 2024 04:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733488043; x=1734092843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/7cxDYGURsL5gkV+0SpqL58pd20ALFslfNYgsoF4uBM=;
        b=eLc4kZuQJ9n97SF/jyQ3JdzkzJlvauGkYLFLmkvS5bM2sCMKK6pAHjv3UhRGmPFIyK
         M/lczQkM8YuEw7razEaRkIPz+5eRTWG6maHq7pp4T4xqHs91G8lpjwL7lnVapJ1vct6j
         Ef2bfL2mflJYqMCvTUCDL42Ob02z8apLh6p0KpkbkYnZSCtN+ODPP3pHtVFqTWTQ4/Ch
         RSKB4DJIsUQgiuxCoDKOnVFuewETHzL0V0akAYhTHKlFFxMtclveInmUVs0YIBb5TLmD
         4KzqDD06KEJsfjUqKliDRskBQt1qRo+qBpK0kFGOIqPQqv9BMV03QNF10lQYiE02ONvK
         N2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733488043; x=1734092843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/7cxDYGURsL5gkV+0SpqL58pd20ALFslfNYgsoF4uBM=;
        b=xIPWNZR3B+7aKsTP+GeWgW3LH2wsnb5cUUORgz0Xk8WTVTCo2pqyGc7JO9LdRRxicF
         AmOrU8lu2cfOMXooB6owhqDnLi7Yos0BtVcS/w/lWV12d5NOca2oKm1SkQ2VLadtHIJZ
         VfQsi7mrixTpBvSuuT1a4HpU0ZpiM7e1UHplPJyocJltyAwnqO1ozTLlmcnn2Dm+nGPj
         AswAWQ+F0T2rkQE5W9xU62K6DTXg8lL2WkAU72V2TOSnSlQVjtZozhSYwT7PjpB5Sjix
         JOmE8WjAWYd7cWcrhwyJ3D3B29gxU4OvjkPe4O3wx8WCsmBsvhPjBEc8Ls8eLJWmF1wv
         cvgw==
X-Forwarded-Encrypted: i=1; AJvYcCWEthTrLj26M3E7Qj73cYg8xKLdmhxgr/odjYQfh6ApBUgQa4lISvsAzhDjLdg8iCCQ0j6nx7NPfMkbP4dmoA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrWgUUCIt5ew9BwQAHzNKTFelVg/0JEVp91pnLhDrjjBL21f45
	hD7+tv/dSfY3AjwDW/6kwm7yWKcU76YrQ0ZOtZnoqAaQHRVvt9L+sa6h8Q==
X-Gm-Gg: ASbGncvMG4bdqSVi3fI0oaVysncbkvcO+jMrJ9nrgfSEEDRkJo3hHOWByHbPeoB4wwF
	xKy6CqdZvWCCfE1nTvQKNOyI8CmnQ6Aayo+xmoEFjS7xVDp/RNrcTkkBDhYgkbDhqfvsGn0rsPj
	ScJfyY0WvK26Ue03BFyW8eDX1OOtg0w7un4d/OzPArkHk6LoTp0xDi3nvAIT1tU8T9GZNlO+1TS
	X1QG5pTP9zn0/1QIqSrJ71wm+xHz1AU/CYA0vomeqD4y7hR2RsbGrE6jndxsMV13tm/8pO4tHUu
	8jNw5D6oVoTfmvGD3GHXcFV/z5sx
X-Google-Smtp-Source: AGHT+IHwgi3jIg5cM3Gld+lrQWC8IKCrJk7nBa4AWQoviVQ28seWu7ZgnDFsMF6uuPvBU1PWa2gvnw==
X-Received: by 2002:a17:903:230e:b0:215:aee1:7e3e with SMTP id d9443c01a7336-21614d19681mr42519275ad.5.1733488043015;
        Fri, 06 Dec 2024 04:27:23 -0800 (PST)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3fd47sm27705445ad.39.2024.12.06.04.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 04:27:22 -0800 (PST)
Message-ID: <d5587bb4-4622-4ba2-bb4d-71a21e237021@gmail.com>
Date: Fri, 6 Dec 2024 04:27:21 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath10k "failed to install key for vdev 0 peer <mac>: -110"
To: Baochen Qiang <quic_bqiang@quicinc.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org
References: <e780560a-86eb-4189-ab5d-3bed3ee5825e@gmail.com>
 <54fac081-7d70-4d31-9f2a-07f5d75d675d@quicinc.com>
 <ea2e7c62-f6e9-4cba-ae81-19fc9abed8b7@gmail.com>
 <22978701-ca79-4e90-8ceb-16bdaf230e8f@quicinc.com>
 <dda85730-3f19-490e-bb0f-99b13511c062@quicinc.com>
 <54f29515-047d-483d-8d9f-a0315a71ad7a@quicinc.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <54f29515-047d-483d-8d9f-a0315a71ad7a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Baochen,

On 12/5/24 6:47 PM, Baochen Qiang wrote:
>
> On 9/5/2024 9:46 AM, Baochen Qiang wrote:
>>
>> On 9/5/2024 2:03 AM, Jeff Johnson wrote:
>>> On 8/16/2024 5:04 AM, James Prestwood wrote:
>>>> Hi Baochen,
>>>>
>>>> On 8/16/24 3:19 AM, Baochen Qiang wrote:
>>>>> On 7/12/2024 9:11 PM, James Prestwood wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I've seen this error mentioned on random forum posts, but its always associated with a kernel crash/warning or some very obvious negative behavior. I've noticed this occasionally and at one location very frequently during FT roaming, specifically just after CMD_ASSOCIATE is issued. For our company run networks I'm not seeing any negative behavior apart from a 3 second delay in sending the re-association frame since the kernel waits for this timeout. But we have some networks our clients run on that we do not own (different vendor), and we are seeing association timeouts after this error occurs and in some cases the AP is sending a deauthentication with reason code 8 instead of replying with a reassociation reply and an error status, which is quite odd.
>>>>>>
>>>>>> We are chasing down this with the vendor of these APs as well, but the behavior always happens after we see this key removal failure/timeout on the client side. So it would appear there is potentially a problem on both the client and AP. My guess is _something_ about the re-association frame changes when this error is encountered, but I cannot see how that would be the case. We are working to get PCAPs now, but its through a 3rd party, so that timing is out of my control.
>>>>>>
>>>>>>   From the kernel code this error would appear innocuous, the old key is failing to be removed but it gets immediately replaced by the new key. And we don't see that addition failing. Am I understanding that logic correctly? I.e. this logic:
>>>>>>
>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/mac80211/key.c#n503
>>>>>>
>>>>>> Below are a few kernel logs of the issue happening, some with the deauth being sent by the AP, some with just timeouts:
>>>>>>
>>>>>> --- No deauth frame sent, just association timeouts after the error ---
>>>>>>
>>>>>> Jul 11 00:05:30 kernel: wlan0: disconnect from AP <previous BSS> for new assoc to <new BSS>
>>>>>> Jul 11 00:05:33 kernel: ath10k_pci 0000:02:00.0: failed to install key for vdev 0 peer <previous BSS>: -110
>>>>>> Jul 11 00:05:33 kernel: wlan0: failed to remove key (0, <previous BSS>) from hardware (-110)
>>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 2/3)
>>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 3/3)
>>>>>> Jul 11 00:05:33 kernel: wlan0: association with <new BSS> timed out
>>>>>> Jul 11 00:05:36 kernel: wlan0: authenticate with <new BSS>
>>>>>> Jul 11 00:05:36 kernel: wlan0: send auth to <new BSS>a (try 1/3)
>>>>>> Jul 11 00:05:36 kernel: wlan0: authenticated
>>>>>> Jul 11 00:05:36 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>>> Jul 11 00:05:36 kernel: wlan0: RX AssocResp from <new BSS> (capab=0x1111 status=0 aid=16)
>>>>>> Jul 11 00:05:36 kernel: wlan0: associated
>>>>>>
>>>>>> --- Deauth frame sent amidst the association timeouts ---
>>>>>>
>>>>>> Jul 11 00:43:18 kernel: wlan0: disconnect from AP <previous BSS> for new assoc to <new BSS>
>>>>>> Jul 11 00:43:21 kernel: ath10k_pci 0000:02:00.0: failed to install key for vdev 0 peer <previous BSS>: -110
>>>>>> Jul 11 00:43:21 kernel: wlan0: failed to remove key (0, <previous BSS>) from hardware (-110)
>>>>>> Jul 11 00:43:21 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>>> Jul 11 00:43:21 kernel: wlan0: deauthenticated from <new BSS> while associating (Reason: 8=DISASSOC_STA_HAS_LEFT)
>>>>>> Jul 11 00:43:24 kernel: wlan0: authenticate with <new BSS>
>>>>>> Jul 11 00:43:24 kernel: wlan0: send auth to <new BSS> (try 1/3)
>>>>>> Jul 11 00:43:24 kernel: wlan0: authenticated
>>>>>> Jul 11 00:43:24 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>>> Jul 11 00:43:24 kernel: wlan0: RX AssocResp from <new BSS> (capab=0x1111 status=0 aid=101)
>>>>>> Jul 11 00:43:24 kernel: wlan0: associated
>>>>>>
>>>>> Hi James, this is QCA6174, right? could you also share firmware version?
>>>> Yep, using:
>>>>
>>>> qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1dac:0261
>>>> firmware ver WLAN.RM.4.4.1-00288- api 6 features wowlan,ignore-otp,mfp
>>>> crc32 bf907c7c
>>>>
>>>> I did try in one instance the latest firmware, 309, and still saw the
>>>> same behavior but 288 is what all our devices are running.
>>>>
>>>> Thanks,
>>>>
>>>> James
>>> Baochen, are you looking more into this? Would prefer to fix the root cause
>>> rather than take "[RFC 0/1] wifi: ath10k: improvement on key removal failure"
>> I asked CST team to try to reproduce this issue such that we can get firmware dump for debug further. What I got is that CST team is currently busy at other critical schedules and they are planning to debug this ath10k issue after those schedules get finished.
>>
> Jeff, I am notified that CST team can not reproduce this issue.

Thanks for reaching out to them at least. Maybe the firmware team can 
provide some info about how long it _should_ take to remove a key and we 
can make the timeout reflect that?

Thanks,

James



