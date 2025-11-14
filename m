Return-Path: <linux-wireless+bounces-28991-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E7EC5F6DA
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 22:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6F03B47DC
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 21:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBE43074B0;
	Fri, 14 Nov 2025 21:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIjjPfPU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DAF2868A9
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 21:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763157151; cv=none; b=uqdOvpyqrwTereEpr7kZvD7ScE5z7Xmiuq3g0ihTyAwfVQRqLYe9VZFfoxVH+66mNt6v3KWxQWMbwtQKhrGjRptE4bcZ4afqrq4QP8FUGctkFXbNe8sp5Ba16L4eT7eeXcA38tJee+6Wt4rsGZXvwexMT4WQHvPzmvvtvK8qfvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763157151; c=relaxed/simple;
	bh=l4MO1Buh/7VNPMnliMoi0BcKK5GHq9xjLan0QwuNUg8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=IakY2D7AeNoK+1RdjY4HBI5tNexp2zZx+OyLrWVtl9Cl0xr2Q72BC/2E2iyUOMJdKtyXs1ifF3vYvTc6M/yymCXXtq5yJrkbDYdOBuJp7CAUR0nTzsahhqXy8uAx0w8EROR4HEyT+jpyY34j/t3mkv8FDiiddl3yZ4rx6SuhYDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIjjPfPU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-298144fb9bcso26868345ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 13:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763157148; x=1763761948; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lBzw9/79/QPfcWGFG2BWQFjy8N10Vm14Ce5F2O5dqjE=;
        b=ZIjjPfPUipeq+bvbTDdNto1nCnmV6s/n/xKb2gnoiFc/DpgphgpV960kiI7ui3Bgm+
         sdX7KDcEdEz/z0stCyEnOIGJWgHb03xIHlml55P8ZJxFnVvey/+2qcPJftO1lWUbd5ZT
         doSrESvSNXAgz9OQ1vJoZLGgSVSde0MJW3XGeuFzxv1HDgnP6iyQKkAcYgmacDvSJzJ+
         4FZCvGUL3emToS7/8hCOnqcHf7AKSdnrUvpFCpBHscsnXdDbNX4BkzhZDTBYGdmH3eDt
         jl9Q3WfN+mYJst1Z935ACM1Kp0JKUpTpXO+HViGmABZk1FnRZUEMpBDfzr7JSNeiWLuk
         Obdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763157148; x=1763761948;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBzw9/79/QPfcWGFG2BWQFjy8N10Vm14Ce5F2O5dqjE=;
        b=REfwDk/SssDhfHP5wkeDW3rpyIvSDMtR3aW/qvwI1nZ9mEZq31nu2pg1RqfymBtg0o
         mWHDewKoPkoEs1VMbLNsJmLkO5/1OrvxueRhcqefJLsRMIAY5yE2oWAjfPq5SKYQQhnA
         nP+haBvXrfrGRZBQGyLa8efemJjJyFpQ4clpYzNCyDnUP8pjcaT+RJ5hC4t1BgeeZnxg
         QXkBlzQ+3CeE7LRBYlatR+vO/fRsAFxlhxJI5aDM8O2vx3FP1NCsyxSQpF+DSLkX8fvt
         SETN5dzVy1kwhVXciBtERHlKayexur/MvKx3S56ywoXeHAqaGOq1VZrMqfLTsSMaLRfl
         jOXg==
X-Forwarded-Encrypted: i=1; AJvYcCUsA3X76LA/niZjIraCFxIXUK5vyNcgCWvBbMic1b94OaKFdarTdjJXUequpHUExCcZPX3nmw5wCd5vE+x5lg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8HcZ+0meBVqiZ9l149+qntq6utP0tmePq5syEIVG7m40RLJh2
	beJRSN6T5xxkz0ixb8gPtewpNvWDYieKXJIO8aG5vQk6GhY9z14QQc3K
X-Gm-Gg: ASbGncvEbzO0+3YDtn00PtG6BoehFJmHDr1bOPz26/zx7Yw2SRDOG8hzhUebnICcoKX
	UjwsqzFyDrIsWjm6sn/qDjvdpEXxscVeKfImkHTghVoo3tJijQTBdeWrmEbkXbmdUOnUsNN4DWx
	w047PrFlWiUTSVqxjED2LSE3Cv6GB27g0T4wwwb1pIEzTJzm4aGMgPKuNWa+pYe1Fxt0B2olmb6
	QibB5/4dvpFvRMuryiGTf7bjjry7ATwPHUSDScdcaUqvuKBzEzvd+BR54b4z134RNDkdxVrZ3aT
	fnKHYIMHpi+KUWUUSas14hHwfuHzVxpaej6V6MIu/aT/4mYz5QnN8oje/QH4nuIQx99S/t2O7b1
	9m9EBeyReECioG8L76gpayMxSHCe/Z1GpOWy8oSHIS8y6MqgeYu7SnSD6cJor6lXp13xRdqr5BY
	ykvjjsQ4mqr3mSlSdzlnu2B8Lw
X-Google-Smtp-Source: AGHT+IFzG5G8loVPrt2m99Vf9liH4+Os353C7jesl5WB/ulucNS7A9E/E7KQAAQHqOfMxC4w0C9YHg==
X-Received: by 2002:a17:90b:17cc:b0:33b:bf8d:6172 with SMTP id 98e67ed59e1d1-343fa74be0amr4908759a91.34.1763157146855;
        Fri, 14 Nov 2025 13:52:26 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456516cf89sm1487932a91.10.2025.11.14.13.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Nov 2025 13:52:26 -0800 (PST)
Message-ID: <b2838a23-ea30-4dee-b513-f5471d486af2@gmail.com>
Date: Fri, 14 Nov 2025 13:52:22 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath10k "failed to install key for vdev 0 peer <mac>: -110"
From: James Prestwood <prestwoj@gmail.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>,
 Jeff Johnson <quic_jjohnson@quicinc.com>, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org
References: <e780560a-86eb-4189-ab5d-3bed3ee5825e@gmail.com>
 <54fac081-7d70-4d31-9f2a-07f5d75d675d@quicinc.com>
 <ea2e7c62-f6e9-4cba-ae81-19fc9abed8b7@gmail.com>
 <22978701-ca79-4e90-8ceb-16bdaf230e8f@quicinc.com>
 <dda85730-3f19-490e-bb0f-99b13511c062@quicinc.com>
 <54f29515-047d-483d-8d9f-a0315a71ad7a@quicinc.com>
 <d5587bb4-4622-4ba2-bb4d-71a21e237021@gmail.com>
 <0e474fe5-cebc-487e-8884-ba505d83711a@quicinc.com>
 <69232460-cd7b-4723-9ed4-b4473a7c5d90@gmail.com>
Content-Language: en-US
In-Reply-To: <69232460-cd7b-4723-9ed4-b4473a7c5d90@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/9/24 4:37 AM, James Prestwood wrote:
>
> On 12/8/24 10:48 PM, Baochen Qiang wrote:
>>
>> On 12/6/2024 8:27 PM, James Prestwood wrote:
>>> Hi Baochen,
>>>
>>> On 12/5/24 6:47 PM, Baochen Qiang wrote:
>>>> On 9/5/2024 9:46 AM, Baochen Qiang wrote:
>>>>> On 9/5/2024 2:03 AM, Jeff Johnson wrote:
>>>>>> On 8/16/2024 5:04 AM, James Prestwood wrote:
>>>>>>> Hi Baochen,
>>>>>>>
>>>>>>> On 8/16/24 3:19 AM, Baochen Qiang wrote:
>>>>>>>> On 7/12/2024 9:11 PM, James Prestwood wrote:
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> I've seen this error mentioned on random forum posts, but its 
>>>>>>>>> always associated
>>>>>>>>> with a kernel crash/warning or some very obvious negative 
>>>>>>>>> behavior. I've noticed
>>>>>>>>> this occasionally and at one location very frequently during 
>>>>>>>>> FT roaming,
>>>>>>>>> specifically just after CMD_ASSOCIATE is issued. For our 
>>>>>>>>> company run networks I'm
>>>>>>>>> not seeing any negative behavior apart from a 3 second delay 
>>>>>>>>> in sending the re-
>>>>>>>>> association frame since the kernel waits for this timeout. But 
>>>>>>>>> we have some
>>>>>>>>> networks our clients run on that we do not own (different 
>>>>>>>>> vendor), and we are
>>>>>>>>> seeing association timeouts after this error occurs and in 
>>>>>>>>> some cases the AP is
>>>>>>>>> sending a deauthentication with reason code 8 instead of 
>>>>>>>>> replying with a
>>>>>>>>> reassociation reply and an error status, which is quite odd.
>>>>>>>>>
>>>>>>>>> We are chasing down this with the vendor of these APs as well, 
>>>>>>>>> but the behavior
>>>>>>>>> always happens after we see this key removal failure/timeout 
>>>>>>>>> on the client side. So
>>>>>>>>> it would appear there is potentially a problem on both the 
>>>>>>>>> client and AP. My guess
>>>>>>>>> is _something_ about the re-association frame changes when 
>>>>>>>>> this error is
>>>>>>>>> encountered, but I cannot see how that would be the case. We 
>>>>>>>>> are working to get
>>>>>>>>> PCAPs now, but its through a 3rd party, so that timing is out 
>>>>>>>>> of my control.
>>>>>>>>>
>>>>>>>>>    From the kernel code this error would appear innocuous, the 
>>>>>>>>> old key is failing to
>>>>>>>>> be removed but it gets immediately replaced by the new key. 
>>>>>>>>> And we don't see that
>>>>>>>>> addition failing. Am I understanding that logic correctly? 
>>>>>>>>> I.e. this logic:
>>>>>>>>>
>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/ 
>>>>>>>>>
>>>>>>>>> mac80211/key.c#n503
>>>>>>>>>
>>>>>>>>> Below are a few kernel logs of the issue happening, some with 
>>>>>>>>> the deauth being sent
>>>>>>>>> by the AP, some with just timeouts:
>>>>>>>>>
>>>>>>>>> --- No deauth frame sent, just association timeouts after the 
>>>>>>>>> error ---
>>>>>>>>>
>>>>>>>>> Jul 11 00:05:30 kernel: wlan0: disconnect from AP <previous 
>>>>>>>>> BSS> for new assoc to
>>>>>>>>> <new BSS>
>>>>>>>>> Jul 11 00:05:33 kernel: ath10k_pci 0000:02:00.0: failed to 
>>>>>>>>> install key for vdev 0
>>>>>>>>> peer <previous BSS>: -110
>>>>>>>>> Jul 11 00:05:33 kernel: wlan0: failed to remove key 
>>>>>>>>> (0, <previous BSS>) from
>>>>>>>>> hardware (-110)
>>>>>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 2/3)
>>>>>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 3/3)
>>>>>>>>> Jul 11 00:05:33 kernel: wlan0: association with <new BSS> 
>>>>>>>>> timed out
>>>>>>>>> Jul 11 00:05:36 kernel: wlan0: authenticate with <new BSS>
>>>>>>>>> Jul 11 00:05:36 kernel: wlan0: send auth to <new BSS>a (try 1/3)
>>>>>>>>> Jul 11 00:05:36 kernel: wlan0: authenticated
>>>>>>>>> Jul 11 00:05:36 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>>>>>> Jul 11 00:05:36 kernel: wlan0: RX AssocResp from <new BSS> 
>>>>>>>>> (capab=0x1111 status=0
>>>>>>>>> aid=16)
>>>>>>>>> Jul 11 00:05:36 kernel: wlan0: associated
>>>>>>>>>
>>>>>>>>> --- Deauth frame sent amidst the association timeouts ---
>>>>>>>>>
>>>>>>>>> Jul 11 00:43:18 kernel: wlan0: disconnect from AP <previous 
>>>>>>>>> BSS> for new assoc to
>>>>>>>>> <new BSS>
>>>>>>>>> Jul 11 00:43:21 kernel: ath10k_pci 0000:02:00.0: failed to 
>>>>>>>>> install key for vdev 0
>>>>>>>>> peer <previous BSS>: -110
>>>>>>>>> Jul 11 00:43:21 kernel: wlan0: failed to remove key (0, 
>>>>>>>>> <previous BSS>) from
>>>>>>>>> hardware (-110)
>>>>>>>>> Jul 11 00:43:21 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>>>>>> Jul 11 00:43:21 kernel: wlan0: deauthenticated from <new BSS> 
>>>>>>>>> while associating
>>>>>>>>> (Reason: 8=DISASSOC_STA_HAS_LEFT)
>>>>>>>>> Jul 11 00:43:24 kernel: wlan0: authenticate with <new BSS>
>>>>>>>>> Jul 11 00:43:24 kernel: wlan0: send auth to <new BSS> (try 1/3)
>>>>>>>>> Jul 11 00:43:24 kernel: wlan0: authenticated
>>>>>>>>> Jul 11 00:43:24 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>>>>>> Jul 11 00:43:24 kernel: wlan0: RX AssocResp from <new BSS> 
>>>>>>>>> (capab=0x1111 status=0
>>>>>>>>> aid=101)
>>>>>>>>> Jul 11 00:43:24 kernel: wlan0: associated
>>>>>>>>>
>>>>>>>> Hi James, this is QCA6174, right? could you also share firmware 
>>>>>>>> version?
>>>>>>> Yep, using:
>>>>>>>
>>>>>>> qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1dac:0261
>>>>>>> firmware ver WLAN.RM.4.4.1-00288- api 6 features 
>>>>>>> wowlan,ignore-otp,mfp
>>>>>>> crc32 bf907c7c
>>>>>>>
>>>>>>> I did try in one instance the latest firmware, 309, and still 
>>>>>>> saw the
>>>>>>> same behavior but 288 is what all our devices are running.
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>> James
>>>>>> Baochen, are you looking more into this? Would prefer to fix the 
>>>>>> root cause
>>>>>> rather than take "[RFC 0/1] wifi: ath10k: improvement on key 
>>>>>> removal failure"
>>>>> I asked CST team to try to reproduce this issue such that we can 
>>>>> get firmware dump for
>>>>> debug further. What I got is that CST team is currently busy at 
>>>>> other critical
>>>>> schedules and they are planning to debug this ath10k issue after 
>>>>> those schedules get
>>>>> finished.
>>>>>
>>>> Jeff, I am notified that CST team can not reproduce this issue.
>>> Thanks for reaching out to them at least. Maybe the firmware team 
>>> can provide some info
>>> about how long it _should_ take to remove a key and we can make the 
>>> timeout reflect that?
>> are you implying that the failure is due to a not-long-enough wait in 
>> host driver? or you
>> want to know the maximum time firmware needs in removing key, and if 
>> it is less than 3s we
>> can reduce current timeout to WAR the issue you hit?
> No I'm not implying the wait isn't long enough. I would like to know 
> the maximum time the firmware should take normally and only wait that 
> amount of time, which would fix the issues we see with Cisco APs.
>>
>>> Thanks,
>>>
>>> James
>>>
>>>
Attempting to revive this thread again with additional information. 
After initially discovering this I have been carrying a patch which 
lowers the timeout to 1 second instead of 3. Though undesirable (since 
it delays roams by 1 second) it did work around the issue with Cisco 
APs. Unfortunately we now see the same issue with another vendor, 
"Extreme Networks", despite the delay being only 1 second.

I can't remember if it was mentioned but we do not see this failure with 
other AP vendors like Meraki or Aruba, and even some clients that use 
Cisco don't experience it. But it appears to happen more (sometimes 90%+ 
of the time) with certain AP vendors. I cannot begin to imagine how the 
AP would have any effect on the driver/firmware's ability to remove a 
key locally, but here we are.

Currently I'm thinking I have 2 options:

   - Further reduce the wait, but given the failure happens so 
consistently the roaming time will be at minimum whatever I set the 
timeout to.

   - Remove the wait entirely for DISABLE_KEY. I have no idea if this is 
safe/recommenced but given the failure isn't handled (only an error log) 
it feels like I could remove it.

Thanks,

James


