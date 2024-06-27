Return-Path: <linux-wireless+bounces-9669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B60891AE5D
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 19:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675AE1C20DDE
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 17:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EEF19AA41;
	Thu, 27 Jun 2024 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTdADRzh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3813D13A276;
	Thu, 27 Jun 2024 17:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719510167; cv=none; b=mEZzDzTcgBCkNVFxcQgsCXEwiPPR8pdaQ9eEr+SuADJgpJSLhLvUBmqOa32485U3tpS9LlBHMRZ+TDsVLeei4kb8MVKeDto/jeaIol7oe4IM9SZpYsLwqmOkhwymOnurcMgd5KDq1bw02jpaxzvzcJ2qLByQS/d+hwZiI7S8bC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719510167; c=relaxed/simple;
	bh=18BYPSydRsQbk9N5QMUQyO2sQjo6TlTiWGpxHzojhSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KyidDSNADogLCpwCD4s7io9Y55XSuV3hurXtvRxadQ3+LKzX117Wc0mjLjYa200kUre3NvvOrAOAOT0Ms+2aoQrZnc9kSdHkszwS1KMkrjlbNQQ9qskXRb8AlqcgTpfKRBLdiqQM0YJFwEBaWi1igaag/sZt2KmsWNpwOcgWifU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTdADRzh; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79c0abd3eaaso279031685a.2;
        Thu, 27 Jun 2024 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719510165; x=1720114965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4gLrZc+w7mUh5pQdRJLrbFMJm3I4uzQamXREb3EHkk=;
        b=VTdADRzh28n2H/sT3D5a1LX8OHz/HXL1w+c6yJJ3O8tfDPn13l/vZa9ThscMgQoUcB
         G565NVO28a7Ow9VS3oDJNkU+zsufguKKzu8CvY/y2tvcbY/wkHs1YV5+824+1CtPByc3
         qBu84k7QAbCJY7zcqAachMXeTCZBdNtqH1jlApUTpmkZUqrhE9WDoNiioWsXiD4DpPRk
         TUTAz/5heJkLJRRNNjmhO0amMx5puPnAbfMrR2oP6sURcXDWbqI80/Bo9zD5WL05jY/X
         LLDk+LXpz/2r0yWOtNioOQSujK6ORmbVjZRD6KYHC263fkr92e9arheYOYPwXdIfFzqP
         +1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719510165; x=1720114965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4gLrZc+w7mUh5pQdRJLrbFMJm3I4uzQamXREb3EHkk=;
        b=k7m2bmjBJa/Q4abT5CwCU1netPiU3stU3Gp+xj8vs3MQ6mnqJw3u6ItlfY1m1v5V5C
         QmGk41wDsa+zWkmXXQ19mdAgDVZ1f10qG/MuJuneai8kjY6J1tfvkoLZO3BwDL3+rrXP
         nGroj0jtZ7Ltrf1+2NnGK+stluf5ER4F7MXzTLnr7uZbK2Jn/HOWyALWLlK3CkpsLM6E
         QjH7ly3/jSvb/5v421rrQVk69B26+KNpI9RWh3h1QhtrR0747Bh8L27gFHzgC0QAj/kJ
         4v9I0Nf6cVfO68MvmkyKYrEmuaNmgSw6wSlvCeVYmyHPTMxQTL8B4/eUcNRKn5/dFHZB
         Eo3A==
X-Forwarded-Encrypted: i=1; AJvYcCV2j8GimkJ7Kvj67PPt1klXhmmuonoh+G9/Rkw0fL8VOOiNf+csakZ87HEq3grZK6jk9HPZgp+N0iGbDAcFYE7VaMofSdFYp0ek/J8nVZgkcwY9LP416+Ryoy1ob9FVJbH55OUUBzE4NKVF9fE=
X-Gm-Message-State: AOJu0YxuBfv8DPnwIhhN+kXe2v3EnybXed4t8/S1PrNsxyobLaXKvYBa
	k71rFAam5mSHP3CI7NzTeFW/p5cGuszajwHVoxe2GXGBsEmAd+BA
X-Google-Smtp-Source: AGHT+IEknF/hbYmxJv5GVjta1oahcOg+apR9zJOpwBaCGfSsnRnL26OuoL00t/4W2nMAYNcE1+tBCw==
X-Received: by 2002:a05:620a:1913:b0:79b:e8ca:861b with SMTP id af79cd13be357-79be8ca8876mr1614969285a.17.1719510165141;
        Thu, 27 Jun 2024 10:42:45 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d5c7ff033sm75464285a.40.2024.06.27.10.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 10:42:44 -0700 (PDT)
Message-ID: <d9f95dcc-6343-4af3-8acc-a150fb4e5923@gmail.com>
Date: Thu, 27 Jun 2024 10:42:40 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: invalid vht params rate 1920 100kbps nss 2 mcs 9
To: Baochen Qiang <quic_bqiang@quicinc.com>, Kalle Valo <kvalo@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, linux-wireless@vger.kernel.org,
 ath10k@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
References: <fba24cd3-4a1e-4072-8585-8402272788ff@molgen.mpg.de>
 <1faa7eee-ed1e-477b-940d-a5cf4478cf73@gmail.com> <87iky7mvxt.fsf@kernel.org>
 <37ba6cb0-d887-4fcf-b7dc-c93a5fc5900f@gmail.com> <875xu6mtgh.fsf@kernel.org>
 <f7faff80-864a-4411-ad28-4f1151bc1e51@quicinc.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <f7faff80-864a-4411-ad28-4f1151bc1e51@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

HI Baochen,

On 6/26/24 1:53 AM, Baochen Qiang wrote:
>
> On 6/18/2024 6:33 PM, Kalle Valo wrote:
>> + baochen
>>
>> James Prestwood <prestwoj@gmail.com> writes:
>>
>>> Hi Kalle,
>>>
>>> On 6/17/24 8:27 AM, Kalle Valo wrote:
>>>> James Prestwood <prestwoj@gmail.com> writes:
>>>>
>>>>> Hi Paul,
>>>>>
>>>>> On 6/16/24 6:10 AM, Paul Menzel wrote:
>>>>>> Dear Linux folks,
>>>>>>
>>>>>>
>>>>>> Linux 6.10-rc3 (commit a3e18a540541) logged the warning below when
>>>>>> connecting to a public WiFi:
>>>>>>
>>>>>>       ath10k_pci 0000:3a:00.0: invalid vht params rate 1920 100kbps
>>>>>> nss 2 mcs 9
>>>>> This has been reported/discussed [1]. It was hinted that there was a
>>>>> firmware fix for this, but none that I tried got rid of it. I got fed
>>>>> up enough with the logs filling up with this I patched our kernel to
>>>>> remove the warning. AFAICT it appears benign (?). Removing the warning
>>>>> was purely "cosmetic" so other devs stopped complaining about it :)
>>>>>
>>>>> [1] https://www.mail-archive.com/ath10k@lists.infradead.org/msg13406.html
>>>> More reliable link to the discussion:
>>>>
>>>> https://lore.kernel.org/ath10k/76a816d983e6c4d636311738396f97971b5523fb.1612915444.git.skhan@linuxfoundation.org/
>>>>
>>>> I think we should add this workaround I mentioned in 2021:
>>>>
>>>>      "If the firmware still keeps sending invalid rates we should add a
>>>>       specific check to ignore the known invalid values, but not all of
>>>>       them."
>>>>
>>>>      https://lore.kernel.org/ath10k/87h7mktjgi.fsf@codeaurora.org/
>>>>
>>>> I guess that would be mcs == 7 and rate == 1440?
>>> I think its more than this combination (Paul's are different).
>> Good point.
>>
>>> So how many combinations are we willing to add here? Seems like that
>>> could get out of hand if there are more than a few invalid
>>> combinations.
>> Yeah, but there haven't been that many different values reported yet,
>> right? And I expect that ath10k user base will just get smaller in the
>> future so the chances are that we will get less reports.
>>
>>> Would we also want to restrict the workaround to specific
>>> hardware/firmware?
>> Good idea, limiting per hardware would be simple to implement using
>> hw_params. Of course we could even limit this per firmware version using
>> enum ath10k_fw_features, but not sure if that's worth all the extra work.
>>
>> Baochen, do you know more about this firmware bug? Any suggestions?
> OK, there are two issues here:
>
> 1. invalid HT rate: "ath10k_pci 0000:02:00.0: invalid ht params rate 1440 100kbps nss 2 mcs 7".
>
> As commented by Wen quite some time ago, this has been fixed from firmware side, and firmware newer than [ver:241] has the fix included.
Thanks for pointing this out, I guess I didn't look close enough at the 
log and missed "ht" vs "vht" when I brought it up on that older thread. 
I thought i was seeing the same problem even with newer firmware.
>
> 2. invaid VHT rate: "ath10k_pci 0000:3a:00.0: invalid vht params rate 1920 100kbps nss 2 mcs 9".
>
> After checking with firmware team, I thought this is because there is a mismatch in rate definition between host and firmware: In host, the rate for 'nss 2 mcs 9' is defined as {1560, 1733}, see supported_vht_mcs_rate_nss2[]. While in firmware this is defined as {1730, 1920}. So seems we can update host definition to avoid this issue.
That would be great!

Thanks,

James


