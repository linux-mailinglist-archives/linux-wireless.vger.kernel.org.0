Return-Path: <linux-wireless+bounces-15689-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE219D8679
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 14:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267BC1696A0
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Nov 2024 13:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46C28F5E;
	Mon, 25 Nov 2024 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lq2zzXw6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC9A2B9B7
	for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 13:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732541532; cv=none; b=cccjWVU55zODK/PI5a15QKmG+HVNive7Wrf9knB3xP6hvsUUTQsES84+TAQbzqeBIJTGNzF2+cJwMI1wrg4f5iVO5Y9rF3R6ycq4al0dqlr97Jl4K1IoQA9Jtin88FkyEgL/E+6gz+8HrqxuVODlJ8UePawlQ8dpD3Kd4kaNhTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732541532; c=relaxed/simple;
	bh=TrFWoAzyBqhpPUx2G3g1QyOzcfjPBmsWren5yar13Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tFISZsiiTWqm4SEDqUdBtaq8G+/N4w6KJ7b4qd3eYYiJzkOkorksWTj6cgeU+ltlK6XrT4mk/nfSNsgbzRljlSZcox3/sbsh7wIdgsFzgQHs5TJ/AbjBIktltayUwfuf7/D28aMJGAnkqPjhMfCbKJvJ5TWp6Nkmht3PUSrG+Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lq2zzXw6; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7b150dc7bc0so294782585a.1
        for <linux-wireless@vger.kernel.org>; Mon, 25 Nov 2024 05:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732541530; x=1733146330; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZhQpteI+JLPbTs96NH5Q2R+bV4YCuAlyZ2+sdKHomVw=;
        b=Lq2zzXw6MxdKojA25k/HeCoViQVDFcIoBGiKPOITGTlnFtZv/janrfaUpTYgKbhRNu
         gU6pLkLVvpnpsOAqeHViHLS9/ehXZmp/HMjfMCAaTvU7xjdVcqP+kGfgsBEzYnDamzfp
         K54btAKHEoQvQt6nRhsH0ebNJDdjREs/IbjDRmVvMVfYBgGb0PNkxYIPJRZNalt41Ag+
         p0VmDp9DQH9cN5xfVakQxmMF5XA76+UiOKLlEW3J5SrnY5mVZUDHLt5SX744TI3L/SzU
         yJfv91KtXtm5KitphMGRTxLrKRGBbDthqNSu4fdXdK3FjT8nBLvxHKbEAevGnB9OJBtZ
         q6Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732541530; x=1733146330;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhQpteI+JLPbTs96NH5Q2R+bV4YCuAlyZ2+sdKHomVw=;
        b=ldlMNEm76EjGmrghb6iQd0QwfO1m/6qIBnXC2wnX/sdiGTZnb69vsCkOIiHAdJX2jx
         ORB+bl8E/ltmIBId0LRRxElaFslSBtCaUwvacVDYbYcVmsLdgDVRPMC8dA5acq+kzcsT
         RK4jqknNa8+Y4gJl5ORBKaT0Jb25kYMy/3n+hvHdh2CKbh1YHVN0jwtv6GNr2Wryouwg
         3lE9GpI06Kuzcv6HCDxqAUoagfppJCzdaXJJ5JXJE02eVe/WdWEkWiEynBwni9ETbxAc
         mhw/Wa4ZWBTo5YJQTvuOiL7cKHLlIngDEaQ+xl61jdoUW2a5cf/NN7rIsi/dWpmCOwma
         UpZw==
X-Forwarded-Encrypted: i=1; AJvYcCU8MZZ5rIc3PMflrAFE8LW3XGj9dNbPbXik14qUUBximjDgrq0NRg3+jWbfXRXOrVI3RyPBPNQSJXSR0jdKKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUwCEPPiRNgJUz3stVynELpIBlieDtpbLvcoBcVgxfocMaL4FS
	vSBqHqAIm9tHaTBudyQfRxUWm/JCu2sNOBD9Hh3gB67yNkm6rIHf
X-Gm-Gg: ASbGncsCqWHrDCuLxtueKDoZ5442It5dbJ/+8uaaVX9OkkLdH65DQ4BbCUjh9d4V2VQ
	c3Ele9qu2j/ozChb8a29XtY7zsEXo2uN7G3fxSH2ClywJTul12FzUhH661OjCUjk9OoZov9kmRJ
	DIvxM7UI6LGe98OCaL34Mi65W301eNZe12hXSBWEis856rTBbrFEdncxr4sVnrIHiObWFq8BeJN
	iKN3JXTaWUBTOZKW7addMGJRxrHcDRRNLZ6Fp3SBQw/2SAdaYstXQ==
X-Google-Smtp-Source: AGHT+IEURwGuMC4Gy8Zr5QFKX+tkbku+wwToefBd6e+40wJ70jL4HPvic9pgjmPB0UZbuDDNXbTE6g==
X-Received: by 2002:a05:620a:44cf:b0:7a9:b268:3655 with SMTP id af79cd13be357-7b5145909d5mr1812046485a.43.1732541529780;
        Mon, 25 Nov 2024 05:32:09 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6676409casm133541585a.50.2024.11.25.05.32.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 05:32:09 -0800 (PST)
Message-ID: <87c9bf22-9534-4292-bf9f-013cc710a3bc@gmail.com>
Date: Mon, 25 Nov 2024 05:32:06 -0800
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
 ath10k@lists.infradead.org, Kalle Valo <kvalo@kernel.org>
References: <e780560a-86eb-4189-ab5d-3bed3ee5825e@gmail.com>
 <54fac081-7d70-4d31-9f2a-07f5d75d675d@quicinc.com>
 <ea2e7c62-f6e9-4cba-ae81-19fc9abed8b7@gmail.com>
 <22978701-ca79-4e90-8ceb-16bdaf230e8f@quicinc.com>
 <dda85730-3f19-490e-bb0f-99b13511c062@quicinc.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <dda85730-3f19-490e-bb0f-99b13511c062@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Baochen,

On 9/4/24 6:46 PM, Baochen Qiang wrote:
>
> On 9/5/2024 2:03 AM, Jeff Johnson wrote:
>> On 8/16/2024 5:04 AM, James Prestwood wrote:
>>> Hi Baochen,
>>>
>>> On 8/16/24 3:19 AM, Baochen Qiang wrote:
>>>> On 7/12/2024 9:11 PM, James Prestwood wrote:
>>>>> Hi,
>>>>>
>>>>> I've seen this error mentioned on random forum posts, but its always associated with a kernel crash/warning or some very obvious negative behavior. I've noticed this occasionally and at one location very frequently during FT roaming, specifically just after CMD_ASSOCIATE is issued. For our company run networks I'm not seeing any negative behavior apart from a 3 second delay in sending the re-association frame since the kernel waits for this timeout. But we have some networks our clients run on that we do not own (different vendor), and we are seeing association timeouts after this error occurs and in some cases the AP is sending a deauthentication with reason code 8 instead of replying with a reassociation reply and an error status, which is quite odd.
>>>>>
>>>>> We are chasing down this with the vendor of these APs as well, but the behavior always happens after we see this key removal failure/timeout on the client side. So it would appear there is potentially a problem on both the client and AP. My guess is _something_ about the re-association frame changes when this error is encountered, but I cannot see how that would be the case. We are working to get PCAPs now, but its through a 3rd party, so that timing is out of my control.
>>>>>
>>>>>   From the kernel code this error would appear innocuous, the old key is failing to be removed but it gets immediately replaced by the new key. And we don't see that addition failing. Am I understanding that logic correctly? I.e. this logic:
>>>>>
>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/mac80211/key.c#n503
>>>>>
>>>>> Below are a few kernel logs of the issue happening, some with the deauth being sent by the AP, some with just timeouts:
>>>>>
>>>>> --- No deauth frame sent, just association timeouts after the error ---
>>>>>
>>>>> Jul 11 00:05:30 kernel: wlan0: disconnect from AP <previous BSS> for new assoc to <new BSS>
>>>>> Jul 11 00:05:33 kernel: ath10k_pci 0000:02:00.0: failed to install key for vdev 0 peer <previous BSS>: -110
>>>>> Jul 11 00:05:33 kernel: wlan0: failed to remove key (0, <previous BSS>) from hardware (-110)
>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 2/3)
>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 3/3)
>>>>> Jul 11 00:05:33 kernel: wlan0: association with <new BSS> timed out
>>>>> Jul 11 00:05:36 kernel: wlan0: authenticate with <new BSS>
>>>>> Jul 11 00:05:36 kernel: wlan0: send auth to <new BSS>a (try 1/3)
>>>>> Jul 11 00:05:36 kernel: wlan0: authenticated
>>>>> Jul 11 00:05:36 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>> Jul 11 00:05:36 kernel: wlan0: RX AssocResp from <new BSS> (capab=0x1111 status=0 aid=16)
>>>>> Jul 11 00:05:36 kernel: wlan0: associated
>>>>>
>>>>> --- Deauth frame sent amidst the association timeouts ---
>>>>>
>>>>> Jul 11 00:43:18 kernel: wlan0: disconnect from AP <previous BSS> for new assoc to <new BSS>
>>>>> Jul 11 00:43:21 kernel: ath10k_pci 0000:02:00.0: failed to install key for vdev 0 peer <previous BSS>: -110
>>>>> Jul 11 00:43:21 kernel: wlan0: failed to remove key (0, <previous BSS>) from hardware (-110)
>>>>> Jul 11 00:43:21 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>> Jul 11 00:43:21 kernel: wlan0: deauthenticated from <new BSS> while associating (Reason: 8=DISASSOC_STA_HAS_LEFT)
>>>>> Jul 11 00:43:24 kernel: wlan0: authenticate with <new BSS>
>>>>> Jul 11 00:43:24 kernel: wlan0: send auth to <new BSS> (try 1/3)
>>>>> Jul 11 00:43:24 kernel: wlan0: authenticated
>>>>> Jul 11 00:43:24 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>> Jul 11 00:43:24 kernel: wlan0: RX AssocResp from <new BSS> (capab=0x1111 status=0 aid=101)
>>>>> Jul 11 00:43:24 kernel: wlan0: associated
>>>>>
>>>> Hi James, this is QCA6174, right? could you also share firmware version?
>>> Yep, using:
>>>
>>> qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1dac:0261
>>> firmware ver WLAN.RM.4.4.1-00288- api 6 features wowlan,ignore-otp,mfp
>>> crc32 bf907c7c
>>>
>>> I did try in one instance the latest firmware, 309, and still saw the
>>> same behavior but 288 is what all our devices are running.
>>>
>>> Thanks,
>>>
>>> James
>> Baochen, are you looking more into this? Would prefer to fix the root cause
>> rather than take "[RFC 0/1] wifi: ath10k: improvement on key removal failure"
> I asked CST team to try to reproduce this issue such that we can get firmware dump for debug further. What I got is that CST team is currently busy at other critical schedules and they are planning to debug this ath10k issue after those schedules get finished.

Any movement on this front? We are still carrying that RFC patch to work 
around the associated compatibility issues with Cisco APs when this 
timeout occurs.

While I do agree the RFC patch isn't optimal, trying to get a firmware 
fix for ~6 year old hardware also may not be very easy. fwiw we've been 
running the RFC patch for about 3 months now, as of today its running on 
over 4000 client devices. So IMO the patch itself is safe if there was 
any concern.

Thanks,

James


