Return-Path: <linux-wireless+bounces-4212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D780C86B795
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 19:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C67321C20F2F
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 18:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A646971EAE;
	Wed, 28 Feb 2024 18:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ac6pwsO4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15FF71EB0
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 18:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146010; cv=none; b=GAsJBdE54eA2bmILS5ru9rkJtgfjXkgf3lQckQRhtf/jJRD35nBeVNTp2x5FK8RD0Om9F59wlrKw4029Hp816QRyDEB4FqxKjTDfbyIQZ1KSUGCLCMeYZY/d5gm38fA54LyFX9z28xxDxSSTTxiLOlU8/ZcK2c40f1bwZRFlAwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146010; c=relaxed/simple;
	bh=saSHKYQ5L7ihvRJfQPH3ZpaibZPWmOL0qJjM/8cJrEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eos9kP3r/8pVk4MiHAGnroNj+Z5uqVeh7EwuKDPQexXy1M8CasvTQS4no2wU2B/NRwYqgPGScmKP1qqmNadeqElVFbNTmDZqBseTdanUke4akJPsgcqGP1Lfp28Nb0w3FinyNfyMfLJOCwIBF13SHyJf4slJ+tuTbp8ImUgsf1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ac6pwsO4; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42e89610ed8so149811cf.3
        for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 10:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709146008; x=1709750808; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PHuw2uncckIZhbhm2xvPn9FEgRi3tDLRWW2k4Bzu7Ns=;
        b=Ac6pwsO4cTgB8sDaxkFaQiPlEHwlYIjEUH2bjNYHe0/WTW194PjZOTDUrBNia4Brqq
         91Gd607rpEojNooFxpLRxgIjQ/WByokAMVBWd8t4C8glTgDPB7SIchzQKJHfJVp9B9ll
         jWjQq0q/KlQV2e4HowoaM/C3YVMyYKU4XABLusK55uAwgFucvaYtruhVWZXE932o8164
         RDAmv/TefkGcD2/DLJrG31MCwmUGZDHrHwt9/J3mVVHfJ/CX06gNkCTpAqzKQfJngSH4
         uFy0dJJHQT9Ue3peeY39ps072KyVPK0iMzoNN3sQLtK3SwMubw8wZJLHORr3wYUGFac4
         kJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709146008; x=1709750808;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHuw2uncckIZhbhm2xvPn9FEgRi3tDLRWW2k4Bzu7Ns=;
        b=FLkZh641+YpJlLKEdf4TLk8ZBoeL1++Vmtpl9QxQZXyxp3kxVYSRrMsou0fYqCBRrt
         Aq2Ag/DBaUAFK5O23rSsvLWtO+h5LseKXy9zAsHzzuHagqwq0zDEQGuAAVPtImcoEdE6
         4XGwkruslOg7Dn0ooVyLrYNg8GEvvVftGTWaOMXLZphPgS8hpeVermXT8CwPIPx2GYdE
         NJjzPsO2dUI6eroHI3bs/QCLqDym7ogszB5126cq5RFJsWOf4PGr2nV2JBon7QuUwr8K
         gRxn0WW+cuJ+REnB8lCydKDSsVpZrRB24dSDbKnGDSq9lysJG+1kBXlUOH3LHdPWh2Q6
         VTLA==
X-Gm-Message-State: AOJu0YypILP+N/7S6zw56DcFHbOqOi+4V4DgAelLw92sCDuBxGEFUVPb
	qXji1X4Wvtg1OCm5dSOS5YqX4ohP9qf/BAE3Nit5es87CIm1Oppa
X-Google-Smtp-Source: AGHT+IHlslU2XdNksuaZaX3Gi0NN29fJA1PPl8Wp5p7mMyg8xMXPyIIC2VYMkGn/4eaoSq99d65yxg==
X-Received: by 2002:ac8:5c96:0:b0:42e:b063:a35f with SMTP id r22-20020ac85c96000000b0042eb063a35fmr1850048qta.8.1709146007686;
        Wed, 28 Feb 2024 10:46:47 -0800 (PST)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id t6-20020ac85306000000b0042c1ce79b4bsm18198qtn.50.2024.02.28.10.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 10:46:47 -0800 (PST)
Message-ID: <6362d9b2-6ed2-4454-bf1b-8614d181bc93@gmail.com>
Date: Wed, 28 Feb 2024 10:46:45 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: poll service ready message before failing
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20240221031729.2707-1-quic_bqiang@quicinc.com>
 <d67fb4f4-aea2-4668-aac4-6e7eca8db4fa@gmail.com>
 <0ee7ae2f-8034-4908-b6e3-fa17a995c661@quicinc.com>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <0ee7ae2f-8034-4908-b6e3-fa17a995c661@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Baochen,

On 2/21/24 6:18 PM, Baochen Qiang wrote:
>
>
> On 2/21/2024 8:38 PM, James Prestwood wrote:
>> Hi Baochen,
>>
>> On 2/20/24 7:17 PM, Baochen Qiang wrote:
>>> Currently host relies on CE interrupts to get notified that
>>> the service ready message is ready. This results in timeout
>>> issue if the interrupt is not fired, due to some unknown
>>> reasons. See below logs:
>>>
>>> [76321.937866] ath10k_pci 0000:02:00.0: wmi service ready event not 
>>> received
>>> ...
>>> [76322.016738] ath10k_pci 0000:02:00.0: Could not init core: -110
>>>
>>> And finally it causes WLAN interface bring up failure.
>>>
>>> Change to give it one more chance here by polling CE rings,
>>> before failing directly.
>>>
>>> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1
>>>
>>> Fixes: 5e3dd157d7e7 ("ath10k: mac80211 driver for Qualcomm Atheros 
>>> 802.11ac CQA98xx devices")
>>> Reported-by: James Prestwood <prestwoj@gmail.com>
>>> Link: 
>>> https://lore.kernel.org/linux-wireless/304ce305-fbe6-420e-ac2a-d61ae5e6ca1a@gmail.com/
>>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>>> ---
>>>   drivers/net/wireless/ath/ath10k/wmi.c | 22 +++++++++++++++++++---
>>>   1 file changed, 19 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath10k/wmi.c 
>>> b/drivers/net/wireless/ath/ath10k/wmi.c
>>> index ddf15717d504..bf6cb2c73128 100644
>>> --- a/drivers/net/wireless/ath/ath10k/wmi.c
>>> +++ b/drivers/net/wireless/ath/ath10k/wmi.c
>>> @@ -1763,12 +1763,28 @@ void ath10k_wmi_put_wmi_channel(struct 
>>> ath10k *ar, struct wmi_channel *ch,
>>>   int ath10k_wmi_wait_for_service_ready(struct ath10k *ar)
>>>   {
>>> -    unsigned long time_left;
>>> +    unsigned long time_left, i;
>>>       time_left = wait_for_completion_timeout(&ar->wmi.service_ready,
>>>                           WMI_SERVICE_READY_TIMEOUT_HZ);
>>> -    if (!time_left)
>>> -        return -ETIMEDOUT;
>>> +    if (!time_left) {
>>> +        /* Sometimes the PCI HIF doesn't receive interrupt
>>> +         * for the service ready message even if the buffer
>>> +         * was completed. PCIe sniffer shows that it's
>>> +         * because the corresponding CE ring doesn't fires
>>> +         * it. Workaround here by polling CE rings once.
>>> +         */
>>> +        ath10k_warn(ar, "failed to receive service ready 
>>> completion, polling..\n");
>>> +
>>> +        for (i = 0; i < CE_COUNT; i++)
>>> +            ath10k_hif_send_complete_check(ar, i, 1);
>>> +
>>> +        time_left = 
>>> wait_for_completion_timeout(&ar->wmi.service_ready,
>>> +                            WMI_SERVICE_READY_TIMEOUT_HZ);
>>> +        if (!time_left)
>>> +            return -ETIMEDOUT;
>>> +    }
>>> +
>>>       return 0;
>>>   }
>>>
>>> base-commit: 707e306f3573fa321ae197d77366578e4566cff5
>>
>> Thank you for looking at this I will test this and see if it resolves 
>> the problem we're seeing but since its somewhat rare it may take me a 
>> bit to validate.
>>
>> Is this any different than just trying to bring up the interface 
>> again from userspace? I could be wrong, but my concern with this is 
>> that when I retried in userspace things got into a very odd state:
>>
>>   - IWD starts
>>
>>   - ifdown interface
>>
>>   - ifup interface, timeout -110
>>
>>   - Retry ifup, success
>>
>>   - Authenticate/associate succeed
>>
>>   - 4-way handshake fails because the device never received the 1/4 
>> frame.
>>
> Don't get time to look into this case, but I suppose there might be 
> some issues in error handling when interface up fails, kind of 
> incorrect irq enable/disable or something else impacting data path, so 
> no data frame received even after a second interface up retry succeeds,
>
> Anyway please test this patch, which is supposed to be the right fix 
> to this issue.

This does appear to have fixed it! For reference this was my test:

  for i in $(seq 1 100000); do sudo ip link set wlan0 down; sudo ip link 
set wlan0 up; echo $?; done

I never saw the up command fail, and after a while I noticed one of the 
iterations took a bit longer to complete. Checked dmesg and saw:

[ 1006.017198] ath10k_pci 0000:02:00.0: failed to receive service ready 
completion, polling..
[ 1006.017295] ath10k_pci 0000:02:00.0: service ready completion 
received, continuing normally

I then started IWD and it was able to connect fine (data frames were 
being passed). I was able to trigger this 3 times relatively quickly, 
each time IWD connected afterwards. So from my end this appears fixed.

You can add tested-by me if you like:

Tested-By: James Prestwood <prestwoj@gmail.com> # on QCA6174 hw3.2


>
>> IWD would then retry indefinitely with auth/assoc succeeding but 
>> never receiving any 4-way handshake frames. The only way to get 
>> things working again was reloading the ath10k driver/reboot. Maybe 
>> this patch is different because its waiting for the initial request 
>> and no issuing a second one? Just wanted to point that out in case it 
>> sheds any light.
>>
>> Thanks,
>>
>> James
>>

