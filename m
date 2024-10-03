Return-Path: <linux-wireless+bounces-13474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 054E698F0CD
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 15:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7CDC281060
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 13:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003D5154C12;
	Thu,  3 Oct 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="bflVE0Qs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB68C07
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 13:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963359; cv=none; b=NmgXonAD04KN/KK/d7RXR31771dgfed1B3P/UNUvV/gs3arPadLwzghGJlFO8DC/rDYwf2bEoIBdwmGCFi+cIA+UsioJ0Pz5TLCOJb0Tau9do580trCgibQrnmtn5bJ+mHWNcUHsus5vhZlWylYhSruRhHVafEgIP9qypP0Ae7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963359; c=relaxed/simple;
	bh=Au+vH3Ul2AH870PbHTY6fBQWPnwE+hIIZy3Xl+rBTZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fOKr8iB4hKkSAPbGEZ4x4tnJYpNhFF8u85FybW54NGD/kp7js63m9Bfkyk2repg/rU2JZqpN0gSc/6WCOuklbns3HcZF3WwUXfC9b1HF8lautZRcHUzQXPE2JAHir639Mwgf9uGKh7OUPPdEQDGyOnEZ5gf/L9gjoWYGqfI8dbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=bflVE0Qs; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 02224885B3;
	Thu,  3 Oct 2024 15:49:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727963355;
	bh=pySa0ZEjzpolSCt1gyo8y5CwZMP3CKgL4mSy9UJIWLc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bflVE0QscQyqqIXeZAQ65jNUon4XXwA5u7nnP1+ZRn8w8yjOYDB65h7nLsBFQRR2c
	 AWJGsslM2z21QvEydyI7bla9oCW7J3Bm5pueC//TgynfI1JNyKJXvdlOx4hVk9S3HV
	 GLM/1RJ2MHhpMnneyoPXTXVLQE2Cbh9YuaGTurazVLucLioy3wOKWEuY0+fwmaCeQI
	 nxvFrdVTtWQYiIdONmlhKEz53x/XBO7Nds4MQ4jG7cZPaDKnCnqKBAfyojU+ZMMfx3
	 cBZZ9KEDjtfWoI09UllSoIG1U/8nmB6cflSK25wILS/5r1LwYAjvvYpD2kPS6bIrbn
	 54B/xVtyhTSEA==
Message-ID: <42e5e310-dc89-4e6e-bf8d-7d1e83e923d0@denx.de>
Date: Thu, 3 Oct 2024 15:18:06 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: wilc1000: Keep slot powered on during
 suspend/resume
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
References: <20240926195113.2823392-1-marex@denx.de>
 <87ed5481ro.fsf@kernel.org> <b3429a32-111b-4bab-9f4f-84c75bb3a049@denx.de>
 <372e6f65-79f1-4a64-a323-2939269a8a45@bootlin.com>
 <1e7351db-366b-4e4a-b423-92867f24cbb5@denx.de>
 <923ee7fa-d7fe-40b4-802a-b89d9b84c20d@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <923ee7fa-d7fe-40b4-802a-b89d9b84c20d@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/3/24 2:58 PM, Alexis Lothoré wrote:
> On 10/3/24 12:49, Marek Vasut wrote:
>> On 10/3/24 10:31 AM, Alexis Lothoré wrote:
>>> On 9/29/24 17:23, Marek Vasut wrote:
>>>> On 9/28/24 1:18 PM, Kalle Valo wrote:
>>>>> Marek Vasut <marex@denx.de> writes:
>>>>>
>>>>>> The WILC3000 can suspend and enter low power state. According to local
>>>>>> measurements, the WILC3000 consumes the same amount of power if the slot
>>>>>> is powered up and WILC3000 is suspended, and if the WILC3000 is powered
>>>>>> off. Use the former option, keep the WILC3000 powered up as that allows
>>>>>> for things like WoWlan to work.
>>>>>>
>>>>>> Note that this is tested on WILC3000 only, not on WILC1000 .
>>>>>>
>>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>>> ---
>>>>>> Cc: Ajay Singh <ajay.kathat@microchip.com>
>>>>>> Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
>>>>>> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>>>>> Cc: Kalle Valo <kvalo@kernel.org>
>>>>>> Cc: Marek Vasut <marex@denx.de>
>>>>>> Cc: linux-wireless@vger.kernel.org
>>>>>> ---
>>>>>> V2: Rebase on next-20240926
>>>>>
>>>>> BTW I recommend using wireless-next as the baseline for wireless
>>>>> patches. For example, wireless-next is not pulled to linux-next during
>>>>> merge windows or other patches in linux-next might create unnecessary
>>>>> conflicts. Of course most of the cases using linux-next is fine.
>>>> I didn't know there was one such tree, added to remotes, thanks !
>>>
>>> +1, as already mentioned in previous revisions, I would gladly test wilc3000
>>> changes on both wilc3000 and wilc1000 on my platform, and having the series on
>>> top of wireless-next would allow to do it on top of any change also affecting
>>> the driver in wireless-next :)
>>
>> I just had a look at a diff between wireless-next/main and next/master 20241003
>> for drivers/net/wireless/microchip , there are no changes to the driver between
>> the two trees, so it should be possible to test this patch on either tree. Can
>> you give it a try ? Ideally test this patch separately on WILC1000 across
>> suspend/resume and check if it works. You might need the MMC controller fix
>> which sets struct mmc_host .pm_caps |= MMC_PM_KEEP_POWER for your controller ,
>> unless this is already upstream.
>>
>> The WILC3000 series depends on this patch.
>>
> Meh, you are right, I have read too fast your answer to my initial question
> about used base branch, and omitted the suspend/resume patch (I assumed it
> conflicted because of some other patches in wireless-next).
Nope, it conflicted because I (again) didn't include cover letter with 
the WILC3000 series, which mentions this information. I really need to 
find some suitable tooling to manage the cover letters, branch 
description does not seem to cut it quite as I hoped it would.

