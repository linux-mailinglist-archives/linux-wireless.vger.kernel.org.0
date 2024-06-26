Return-Path: <linux-wireless+bounces-9593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF022917C33
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 11:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992731F28DAA
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jun 2024 09:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8870B16A949;
	Wed, 26 Jun 2024 09:13:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D953B17D88C;
	Wed, 26 Jun 2024 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719393192; cv=none; b=nD2KX4pMEWP03NXbZetMj9sJ/cqw48is8kcq5V4VoYGqD7pFXoE9RxmqtXDYhDb3fgWgY0sHxRlNoc/726rLgoEjzM98D+iH281i/+RCvIsIuReU6KjI9UFlYMNiWzeenakYNVPICsbi+xg5mTtvWPWAnfEfpEVXx98ruMplkB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719393192; c=relaxed/simple;
	bh=44Vn7eB0agzpUOe23DYj6aCAcQP4QozlBkYWgU+gaeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KT6M3anVMk/V8v0N95rKORYE4UYseQpKyl7sfpp3hGQ2UkzhX932dVskY19M014yUPgi5pgW1r2+ghuaSeep/ynzDbWPGAhPrKVAT2LfGLzoGae7qv/Oe7BFDIQxboRMz9M9xNro5ZOwHjOeVF7CgbGdcTqbWe7iCr2UipXMaIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3584C61E5FE05;
	Wed, 26 Jun 2024 11:12:16 +0200 (CEST)
Message-ID: <082024ce-fdd4-4fb1-8055-6d25f7d2e524@molgen.mpg.de>
Date: Wed, 26 Jun 2024 11:12:15 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: invalid vht params rate 1920 100kbps nss 2 mcs 9
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: Kalle Valo <kvalo@kernel.org>, James Prestwood <prestwoj@gmail.com>,
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 LKML <linux-kernel@vger.kernel.org>
References: <fba24cd3-4a1e-4072-8585-8402272788ff@molgen.mpg.de>
 <1faa7eee-ed1e-477b-940d-a5cf4478cf73@gmail.com> <87iky7mvxt.fsf@kernel.org>
 <37ba6cb0-d887-4fcf-b7dc-c93a5fc5900f@gmail.com> <875xu6mtgh.fsf@kernel.org>
 <f7faff80-864a-4411-ad28-4f1151bc1e51@quicinc.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <f7faff80-864a-4411-ad28-4f1151bc1e51@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Baochen,


Thank you for your reply.

Am 26.06.24 um 10:53 schrieb Baochen Qiang:

> On 6/18/2024 6:33 PM, Kalle Valo wrote:
>> + baochen
>>
>> James Prestwood <prestwoj@gmail.com> writes:

>>> On 6/17/24 8:27 AM, Kalle Valo wrote:
>>>> James Prestwood writes:

>>>>> On 6/16/24 6:10 AM, Paul Menzel wrote:

>>>>>> Linux 6.10-rc3 (commit a3e18a540541) logged the warning below when
>>>>>> connecting to a public WiFi:
>>>>>>
>>>>>>       ath10k_pci 0000:3a:00.0: invalid vht params rate 1920 100kbps nss 2 mcs 9
>>>>>
>>>>> This has been reported/discussed [1]. It was hinted that there was a
>>>>> firmware fix for this, but none that I tried got rid of it. I got fed
>>>>> up enough with the logs filling up with this I patched our kernel to
>>>>> remove the warning. AFAICT it appears benign (?). Removing the warning
>>>>> was purely "cosmetic" so other devs stopped complaining about it :)
>>>>>
>>>>> [1] https://www.mail-archive.com/ath10k@lists.infradead.org/msg13406.html
>>>>
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
>>>
>>> I think its more than this combination (Paul's are different).
>>
>> Good point.
>>
>>> So how many combinations are we willing to add here? Seems like that
>>> could get out of hand if there are more than a few invalid
>>> combinations.
>>
>> Yeah, but there haven't been that many different values reported yet,
>> right? And I expect that ath10k user base will just get smaller in the
>> future so the chances are that we will get less reports.
>>
>>> Would we also want to restrict the workaround to specific
>>> hardware/firmware?
>>
>> Good idea, limiting per hardware would be simple to implement using
>> hw_params. Of course we could even limit this per firmware version using
>> enum ath10k_fw_features, but not sure if that's worth all the extra work.
>>
>> Baochen, do you know more about this firmware bug? Any suggestions?
> 
> OK, there are two issues here:
> 
> 1. invalid HT rate: "ath10k_pci 0000:02:00.0: invalid ht params rate 1440 100kbps nss 2 mcs 7".
> 
> As commented by Wen quite some time ago, this has been fixed from
> firmware side, and firmware newer than [ver:241] has the fix
> included.
This is the issue from 2021, correct?

> 2. invaid VHT rate: "ath10k_pci 0000:3a:00.0: invalid vht params rate 1920 100kbps nss 2 mcs 9".
> 
> After checking with firmware team, I thought this is because there is
> a mismatch in rate definition between host and firmware: In host, the
> rate for 'nss 2 mcs 9' is defined as {1560, 1733}, see
> supported_vht_mcs_rate_nss2[]. While in firmware this is defined as
> {1730, 1920}. So seems we can update host definition to avoid this
> issue.
Looking through the logs since May 2024, I have four different logs:

1.  invalid vht params rate 878 100kbps nss 3 mcs 2
2.  invalid vht params rate 960 100kbps nss 1 mcs 9
3.  invalid vht params rate 1730 100kbps nss 2 mcs 9
4.  invalid vht params rate 1920 100kbps nss 2 mcs 9

I believe it’s only happening with Cisco networks. I am happy to test a 
patch.

By the way, is the firmware version logged by Linux?

     ath10k_pci 0000:3a:00.0: qca6174 hw3.2 target 0x05030000 chip_id 
0x00340aff sub 1a56:1535
     ath10k_pci 0000:3a:00.0: kconfig debug 0 debugfs 0 tracing 0 dfs 0 
testmode 0
     ath10k_pci 0000:3a:00.0: firmware ver WLAN.RM.4.4.1-00288- api 6 
features wowlan,ignore-otp,mfp crc32 bf907c7c
     ath10k_pci 0000:3a:00.0: board_file api 2 bmi_id N/A crc32 d2863f91
     ath10k_pci 0000:3a:00.0: htt-ver 3.87 wmi-op 4 htt-op 3 cal otp 
max-sta 32 raw 0 hwcrypto 1

Is it 4.4.1-00288? How can I find the file in `/lib/firmware/`?


Kind regards,

Paul

