Return-Path: <linux-wireless+bounces-13475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FEE98F0EA
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 16:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638C51C21928
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A431199936;
	Thu,  3 Oct 2024 13:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gjwSep6S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B0019CC27
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727963998; cv=none; b=iZ/CiMg4dSdLjMWcq+ZAMDs6jsyJvCXTJHfn1KVm7H/7vTda6eBeN8hVH2GvhTycF4WmEJaQPMbFGpWmShqCYkqgOM52TCWVm6pL54hzBrEI0jR3jOaSDftsiWY3J0Zy1daYNowd2K+d76Q6fvXKLmYcJ7N/4HYiffmzirr/rSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727963998; c=relaxed/simple;
	bh=UWD1pjLlFYXRYC7T2W6BOtbBrJHfEnPMKuakyO61wj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4QCcNEttxdOpm0/HuT6p8Y3Lg154j0Jmk+b8KMA3HrCDpF9zUdzNg8dIeGhjcjAPRhXJQEnomrKdbLG6NmhLmlRoLWprqnQwVvLzyHpCknuxfqid9rCE0eE5pb3S5TOrlG9QrZx0abtbUwBAJKaXumhiReTYjzs+hQivxy1iOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gjwSep6S; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D00071BF207;
	Thu,  3 Oct 2024 13:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727963994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q72rhDP857MfBhycC1VFvJaZbTVKgDVoo6Q6IqBvQLo=;
	b=gjwSep6SV2Cs3dFNCmjOrMQ8iPZhk8E8T4zu8BpD74naDRysRl5fjw/PdOk9DAML85UrDh
	dmWcZYz1FPpgX2MLIeP0MRVqaO3p+4I8toEWOjzjIXqJU4Q78SQgvqonuZa0AzEDYHHug0
	WyxZOhye53X5kd3FpOU3GqRyzrFpocfGbk95XuxH9SGbp4pu1MtrN7dv7mOqPnHOEHEXgj
	JdqxUJ9Jk4lJDucZH7faZo3SpN41oBU2KMnUMUBAn7VON57cOrQtk8Yy8gKB7WwmsWNbnO
	jioIim6ZT1LB/O/NKxPQbrEjAN64ubhrEIJPT2Rp2GzoIfiUNKM6CTxuv9xfvQ==
Message-ID: <f45ee99f-2a5a-4a1d-90c9-99d9354e1d7f@bootlin.com>
Date: Thu, 3 Oct 2024 15:59:53 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: wilc1000: Keep slot powered on during
 suspend/resume
To: Marek Vasut <marex@denx.de>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>
References: <20240926195113.2823392-1-marex@denx.de>
 <87ed5481ro.fsf@kernel.org> <b3429a32-111b-4bab-9f4f-84c75bb3a049@denx.de>
 <372e6f65-79f1-4a64-a323-2939269a8a45@bootlin.com>
 <1e7351db-366b-4e4a-b423-92867f24cbb5@denx.de>
 <923ee7fa-d7fe-40b4-802a-b89d9b84c20d@bootlin.com>
 <42e5e310-dc89-4e6e-bf8d-7d1e83e923d0@denx.de>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <42e5e310-dc89-4e6e-bf8d-7d1e83e923d0@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 10/3/24 15:18, Marek Vasut wrote:
> On 10/3/24 2:58 PM, Alexis Lothoré wrote:
>> On 10/3/24 12:49, Marek Vasut wrote:
>>> On 10/3/24 10:31 AM, Alexis Lothoré wrote:
>>>> On 9/29/24 17:23, Marek Vasut wrote:
>>>>> On 9/28/24 1:18 PM, Kalle Valo wrote:
>>>>>> Marek Vasut <marex@denx.de> writes:
>>>>>>
>>>>>>> The WILC3000 can suspend and enter low power state. According to local
>>>>>>> measurements, the WILC3000 consumes the same amount of power if the slot
>>>>>>> is powered up and WILC3000 is suspended, and if the WILC3000 is powered
>>>>>>> off. Use the former option, keep the WILC3000 powered up as that allows
>>>>>>> for things like WoWlan to work.
>>>>>>>
>>>>>>> Note that this is tested on WILC3000 only, not on WILC1000 .
>>>>>>>
>>>>>>> Signed-off-by: Marek Vasut <marex@denx.de>
>>>>>>> ---
>>>>>>> Cc: Ajay Singh <ajay.kathat@microchip.com>
>>>>>>> Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
>>>>>>> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
>>>>>>> Cc: Kalle Valo <kvalo@kernel.org>
>>>>>>> Cc: Marek Vasut <marex@denx.de>
>>>>>>> Cc: linux-wireless@vger.kernel.org
>>>>>>> ---
>>>>>>> V2: Rebase on next-20240926
>>>>>>
>>>>>> BTW I recommend using wireless-next as the baseline for wireless
>>>>>> patches. For example, wireless-next is not pulled to linux-next during
>>>>>> merge windows or other patches in linux-next might create unnecessary
>>>>>> conflicts. Of course most of the cases using linux-next is fine.
>>>>> I didn't know there was one such tree, added to remotes, thanks !
>>>>
>>>> +1, as already mentioned in previous revisions, I would gladly test wilc3000
>>>> changes on both wilc3000 and wilc1000 on my platform, and having the series on
>>>> top of wireless-next would allow to do it on top of any change also affecting
>>>> the driver in wireless-next :)
>>>
>>> I just had a look at a diff between wireless-next/main and next/master 20241003
>>> for drivers/net/wireless/microchip , there are no changes to the driver between
>>> the two trees, so it should be possible to test this patch on either tree. Can
>>> you give it a try ? Ideally test this patch separately on WILC1000 across
>>> suspend/resume and check if it works. You might need the MMC controller fix
>>> which sets struct mmc_host .pm_caps |= MMC_PM_KEEP_POWER for your controller ,
>>> unless this is already upstream.
>>>
>>> The WILC3000 series depends on this patch.
>>>
>> Meh, you are right, I have read too fast your answer to my initial question
>> about used base branch, and omitted the suspend/resume patch (I assumed it
>> conflicted because of some other patches in wireless-next).
> Nope, it conflicted because I (again) didn't include cover letter with the
> WILC3000 series, which mentions this information. I really need to find some
> suitable tooling to manage the cover letters, branch description does not seem
> to cut it quite as I hoped it would.

May I suggest b4 [0] for such task ? It really eases series submissions, taking
care of all the small details that can be easily forgotten :) Latest versions of
the tool will warn you during the sending phase if you forgot to create/update
your cover letter (which is stored by default as an empty commit, this can be
tuned). It is even able now to manage patch sets dependencies (but I still did
not have the opportunity to give this feature a try)

[0] https://b4.docs.kernel.org/en/latest/


-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

