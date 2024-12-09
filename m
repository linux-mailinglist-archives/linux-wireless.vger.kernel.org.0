Return-Path: <linux-wireless+bounces-16037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FBF9E9473
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 13:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7489165F3A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 12:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37099228C9F;
	Mon,  9 Dec 2024 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjP/gBND"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413B9223703
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747868; cv=none; b=d9tVObMp9BR6sGcUSVLdFphZAUmaKPSUo9MvZQmo6MMpAxIYXYCZ+7ZuAZ9VlOdp89ahYcyBaq2T+tNQosAy0ldibz8n7oTrpqTsr/qAApvYfmkCg65BunDjp0Kme6P5/lV1BQCfIIcK8HOfS/EUGvQR73AzeVOpom8nPd6rUQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747868; c=relaxed/simple;
	bh=PTRj1uL/6o8ALLHFhMDgXm2AB0fjJxcvpVewZxHxZoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=I0ziiYsGZvkV5gL8nA6c9QyvwNVkhOyj8/L93ua6K0tybLIkMNfOs1FjJ5IBZwDXtYVQKlccMtCc9h/O0cJyI3XzPb28zMzuccGjVZ3pVhM07xzfjKhmxHcvjJjxR7sHAYh+eyzMT20P0fTv5CGvjVa3SjH0EfkgnAdF8VZA03E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjP/gBND; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d87ab49423so42515566d6.0
        for <linux-wireless@vger.kernel.org>; Mon, 09 Dec 2024 04:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733747865; x=1734352665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PIkHrI16OePy61C9ceQR9I8sAvVv6yBqJfVrm74icI0=;
        b=PjP/gBNDROdaeVqKSromD4+w5L6myMlasw4E1jKnSQMO4ZPtABS+f6RxY3eYkW5Evy
         TVRs9XxN8gb7kv/KzBC1cknh6avQyzlI0Bi0jAm5XYJ7uGQOXCosN2TZtJPPET9mscBB
         El8Dk8Tdh1D7QK1nYUg+Fgsp7XBimqAMkSsve4t9g1UVxafYXUbNWw57goemztvBZjYf
         SvIUSPorQauWpgcV8KyfCbVZTnvnFnrUjmGwPvhpmnXKcK0ec2xx9/3c5Rrhh84vHM/X
         MDPZ5yDxMSsoJJhoCUkslQugYt2RMBsHy8brttMFJ+C8/+ZUESlkEotGE4LWz4Pxyvm+
         Yswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733747865; x=1734352665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PIkHrI16OePy61C9ceQR9I8sAvVv6yBqJfVrm74icI0=;
        b=AkilcYwkx65koSX2OKJIj544yDKSGjwUCxqj+2NglHnIWoZjN/wEhdFwa7eh+pPK7l
         ojupspjhL1wesUMgS7EAeDPuBVixzwb81NnsbwM+wcl7kgWFEASNt18S5mVr4TZ/upvE
         HxUrB1gfAqIXWvO3zTlr2aUVf1pQXWFXzvAdL2CePhU1uNHyJuXQiw5rqqwtv9xZ58eO
         4nDh2LIHUXZJ7UBuaD6iqJ2HeNswYmW7BYJ8xrSkde1CPCnBWd5hAI4/QUxaZ94+U+Vh
         1yFmJR9RP8F4pDLmu7wvJ7QCV6Ac0egvYhG/RrqF3TSW3RJeEA0N2rhd7Oc9rbGID0Bj
         +e1w==
X-Forwarded-Encrypted: i=1; AJvYcCVa3vKalRnWA8pm2WPjOIY6mOegpKUUOsg9o+n4uhBnxj/qZcwuMAR/QJA5NBmU4mgU02dlasZ2p72FRgAz4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0qvuV4xR6BBwheZeLKRciVnG5fl/BLCpxX+QRT5mg6tVX8KaA
	14lBSLHxLbI1AvQghayixUf394UByG8l1GURcF6XUwQH7Drg/QdF
X-Gm-Gg: ASbGncumtOvMp8N7nCiOQPGsLJ6NojHjSoLdIdgpqhL8JSguYu/U/zacxpXHGs7rXkb
	A6dLB+HmQdnWr78sOk9T4GxIbSy+YmkD0QTGGMpQTm/qxtgM786F6dFGvOLyLGcKmEqZ8w5K5y4
	ESiUlaVLFqJqyuEY1mqLP0uhSBzQycO68DvYc+sGGfIR0E2W1/I8JBvo4qzUR8X0LncwZSk8S5D
	X4SGZtW0WlaxPe8Baa2KUjXuT5Sz2Qa41jHeL+4uIT11EiIH8hRBQ==
X-Google-Smtp-Source: AGHT+IHCd1tZ8eBTeaXau57tRGRkOjOUigSV7QVgEliVOB2FeKxGji7kvcMAiUD0Vt4thAfD9dnehg==
X-Received: by 2002:ad4:5ae9:0:b0:6d8:9b7b:14b8 with SMTP id 6a1803df08f44-6d91e2d2c9bmr5921426d6.3.1733747865010;
        Mon, 09 Dec 2024 04:37:45 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da9fded9sm48430976d6.76.2024.12.09.04.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 04:37:44 -0800 (PST)
Message-ID: <69232460-cd7b-4723-9ed4-b4473a7c5d90@gmail.com>
Date: Mon, 9 Dec 2024 04:37:42 -0800
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
 <d5587bb4-4622-4ba2-bb4d-71a21e237021@gmail.com>
 <0e474fe5-cebc-487e-8884-ba505d83711a@quicinc.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <0e474fe5-cebc-487e-8884-ba505d83711a@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/8/24 10:48 PM, Baochen Qiang wrote:
>
> On 12/6/2024 8:27 PM, James Prestwood wrote:
>> Hi Baochen,
>>
>> On 12/5/24 6:47 PM, Baochen Qiang wrote:
>>> On 9/5/2024 9:46 AM, Baochen Qiang wrote:
>>>> On 9/5/2024 2:03 AM, Jeff Johnson wrote:
>>>>> On 8/16/2024 5:04 AM, James Prestwood wrote:
>>>>>> Hi Baochen,
>>>>>>
>>>>>> On 8/16/24 3:19 AM, Baochen Qiang wrote:
>>>>>>> On 7/12/2024 9:11 PM, James Prestwood wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I've seen this error mentioned on random forum posts, but its always associated
>>>>>>>> with a kernel crash/warning or some very obvious negative behavior. I've noticed
>>>>>>>> this occasionally and at one location very frequently during FT roaming,
>>>>>>>> specifically just after CMD_ASSOCIATE is issued. For our company run networks I'm
>>>>>>>> not seeing any negative behavior apart from a 3 second delay in sending the re-
>>>>>>>> association frame since the kernel waits for this timeout. But we have some
>>>>>>>> networks our clients run on that we do not own (different vendor), and we are
>>>>>>>> seeing association timeouts after this error occurs and in some cases the AP is
>>>>>>>> sending a deauthentication with reason code 8 instead of replying with a
>>>>>>>> reassociation reply and an error status, which is quite odd.
>>>>>>>>
>>>>>>>> We are chasing down this with the vendor of these APs as well, but the behavior
>>>>>>>> always happens after we see this key removal failure/timeout on the client side. So
>>>>>>>> it would appear there is potentially a problem on both the client and AP. My guess
>>>>>>>> is _something_ about the re-association frame changes when this error is
>>>>>>>> encountered, but I cannot see how that would be the case. We are working to get
>>>>>>>> PCAPs now, but its through a 3rd party, so that timing is out of my control.
>>>>>>>>
>>>>>>>>    From the kernel code this error would appear innocuous, the old key is failing to
>>>>>>>> be removed but it gets immediately replaced by the new key. And we don't see that
>>>>>>>> addition failing. Am I understanding that logic correctly? I.e. this logic:
>>>>>>>>
>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/
>>>>>>>> mac80211/key.c#n503
>>>>>>>>
>>>>>>>> Below are a few kernel logs of the issue happening, some with the deauth being sent
>>>>>>>> by the AP, some with just timeouts:
>>>>>>>>
>>>>>>>> --- No deauth frame sent, just association timeouts after the error ---
>>>>>>>>
>>>>>>>> Jul 11 00:05:30 kernel: wlan0: disconnect from AP <previous BSS> for new assoc to
>>>>>>>> <new BSS>
>>>>>>>> Jul 11 00:05:33 kernel: ath10k_pci 0000:02:00.0: failed to install key for vdev 0
>>>>>>>> peer <previous BSS>: -110
>>>>>>>> Jul 11 00:05:33 kernel: wlan0: failed to remove key (0, <previous BSS>) from
>>>>>>>> hardware (-110)
>>>>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 2/3)
>>>>>>>> Jul 11 00:05:33 kernel: wlan0: associate with <new BSS> (try 3/3)
>>>>>>>> Jul 11 00:05:33 kernel: wlan0: association with <new BSS> timed out
>>>>>>>> Jul 11 00:05:36 kernel: wlan0: authenticate with <new BSS>
>>>>>>>> Jul 11 00:05:36 kernel: wlan0: send auth to <new BSS>a (try 1/3)
>>>>>>>> Jul 11 00:05:36 kernel: wlan0: authenticated
>>>>>>>> Jul 11 00:05:36 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>>>>> Jul 11 00:05:36 kernel: wlan0: RX AssocResp from <new BSS> (capab=0x1111 status=0
>>>>>>>> aid=16)
>>>>>>>> Jul 11 00:05:36 kernel: wlan0: associated
>>>>>>>>
>>>>>>>> --- Deauth frame sent amidst the association timeouts ---
>>>>>>>>
>>>>>>>> Jul 11 00:43:18 kernel: wlan0: disconnect from AP <previous BSS> for new assoc to
>>>>>>>> <new BSS>
>>>>>>>> Jul 11 00:43:21 kernel: ath10k_pci 0000:02:00.0: failed to install key for vdev 0
>>>>>>>> peer <previous BSS>: -110
>>>>>>>> Jul 11 00:43:21 kernel: wlan0: failed to remove key (0, <previous BSS>) from
>>>>>>>> hardware (-110)
>>>>>>>> Jul 11 00:43:21 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>>>>> Jul 11 00:43:21 kernel: wlan0: deauthenticated from <new BSS> while associating
>>>>>>>> (Reason: 8=DISASSOC_STA_HAS_LEFT)
>>>>>>>> Jul 11 00:43:24 kernel: wlan0: authenticate with <new BSS>
>>>>>>>> Jul 11 00:43:24 kernel: wlan0: send auth to <new BSS> (try 1/3)
>>>>>>>> Jul 11 00:43:24 kernel: wlan0: authenticated
>>>>>>>> Jul 11 00:43:24 kernel: wlan0: associate with <new BSS> (try 1/3)
>>>>>>>> Jul 11 00:43:24 kernel: wlan0: RX AssocResp from <new BSS> (capab=0x1111 status=0
>>>>>>>> aid=101)
>>>>>>>> Jul 11 00:43:24 kernel: wlan0: associated
>>>>>>>>
>>>>>>> Hi James, this is QCA6174, right? could you also share firmware version?
>>>>>> Yep, using:
>>>>>>
>>>>>> qca6174 hw3.2 target 0x05030000 chip_id 0x00340aff sub 1dac:0261
>>>>>> firmware ver WLAN.RM.4.4.1-00288- api 6 features wowlan,ignore-otp,mfp
>>>>>> crc32 bf907c7c
>>>>>>
>>>>>> I did try in one instance the latest firmware, 309, and still saw the
>>>>>> same behavior but 288 is what all our devices are running.
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> James
>>>>> Baochen, are you looking more into this? Would prefer to fix the root cause
>>>>> rather than take "[RFC 0/1] wifi: ath10k: improvement on key removal failure"
>>>> I asked CST team to try to reproduce this issue such that we can get firmware dump for
>>>> debug further. What I got is that CST team is currently busy at other critical
>>>> schedules and they are planning to debug this ath10k issue after those schedules get
>>>> finished.
>>>>
>>> Jeff, I am notified that CST team can not reproduce this issue.
>> Thanks for reaching out to them at least. Maybe the firmware team can provide some info
>> about how long it _should_ take to remove a key and we can make the timeout reflect that?
> are you implying that the failure is due to a not-long-enough wait in host driver? or you
> want to know the maximum time firmware needs in removing key, and if it is less than 3s we
> can reduce current timeout to WAR the issue you hit?
No I'm not implying the wait isn't long enough. I would like to know the 
maximum time the firmware should take normally and only wait that amount 
of time, which would fix the issues we see with Cisco APs.
>
>> Thanks,
>>
>> James
>>
>>

