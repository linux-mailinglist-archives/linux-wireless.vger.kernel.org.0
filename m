Return-Path: <linux-wireless+bounces-7739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BC78C756C
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 13:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0871F21821
	for <lists+linux-wireless@lfdr.de>; Thu, 16 May 2024 11:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80CB14535E;
	Thu, 16 May 2024 11:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="gtMlIfD7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FB326AD0;
	Thu, 16 May 2024 11:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715859933; cv=none; b=pV+JhcQQ1CO4wZk8Gj9AaWPrLW9rthKDs5w7xRBbDwx9f1yrhI8E8eeSB3q86ZCGJFJJrC49N4OFLWPCEfMuL4bYpmK7uDPFyHUgXd9ytqytNTncxsbc9s3sy7Z/Uh5m0tAutMGfInmC6HFdXNCbcVkjoM0vbWLU2/UMBASEahI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715859933; c=relaxed/simple;
	bh=m/u2AEh8dkP1yAi0De9tYVEVPBXMJgaynXnQLwOS6s4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEJ1QG2ZkpAkglxeRxx7WiheWh3r1vtUZ4OatlUYoO/bSTpLDi3NNCjaHVIE1nynt/VDGO/WGP1xf6yln6worbszjCuxFhWHMVlsGDyO4bdMjZzSWMQ7FPNuabjP5vBhrtLZNDBbb+6mvjVkXzZdBsRPJWOeh2RKBlLicligqjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=gtMlIfD7; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=F5IOrlXciR4ynap6Hu3tkcXwPLk/q7jpxjQCXcoFPjo=;
	t=1715859931; x=1716291931; b=gtMlIfD7Y3ZAnTuRgiq5Yh76k7FQiEXZQ9U3LLx06izcE87
	S20FjY8aA58lt6aubOHxUJXG/gh4d2loPOXHJxs0Ct1/Q0WhLeeEPAOkHhz5xcsC+veYe2MdtGbjE
	R1ProVH5OryN7EcUh5hpHbiUdnBBNdcXMXxt9/aRI3KSU/ph/P2Ma2B5a4MlFtKAMX1Dmz9EZZ36h
	8s5k4u85Seiljq4+IC2rMyZuFUoHBV7+Uollu68CEsq5JUAl7ob0BjJ4/WrKQl8UROMVGZmnwioF4
	qcKWKd2pXV/8LLZMfYHT0OIsN0gHmi/raMYdNyVwnFT8s/ZSQPbQKmdqcaD7xA6Q==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s7ZY8-0002AK-2j; Thu, 16 May 2024 13:45:28 +0200
Message-ID: <a53e2188-b982-44b7-9dfe-f5dfd6b802ca@leemhuis.info>
Date: Thu, 16 May 2024 13:45:27 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath11k: supports 2 station interfaces
To: Carl Huang <quic_cjhuang@quicinc.com>
Cc: Luca Weiss <luca.weiss@fairphone.com>, ath11k@lists.infradead.org,
 linux-wireless@vger.kernel.org, regressions@lists.linux.dev,
 Kalle Valo <kvalo@kernel.org>
References: <20230714023801.2621802-1-quic_cjhuang@quicinc.com>
 <20230714023801.2621802-2-quic_cjhuang@quicinc.com>
 <D15TIIDIIESY.D1EKKJLZINMA@fairphone.com> <87jzk2km0g.fsf@kernel.org>
 <93c15c59-f24c-4472-ae7e-969fd1e3bfec@quicinc.com>
 <871q69lqh5.fsf@kernel.org>
 <4e21e556-527f-4d1e-aa29-cacec14155af@quicinc.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <4e21e556-527f-4d1e-aa29-cacec14155af@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715859931;72c24141;
X-HE-SMSGID: 1s7ZY8-0002AK-2j

On 11.05.24 05:12, Carl Huang wrote:
> On 2024/5/10 21:57, Kalle Valo wrote:
>> Carl Huang <quic_cjhuang@quicinc.com> writes:
>>> On 2024/5/10 18:18, Kalle Valo wrote:
>>>> "Luca Weiss" <luca.weiss@fairphone.com> writes:
>>>>> On Fri Jul 14, 2023 at 4:38 AM CEST, Carl Huang wrote:
>>>>>> Add hardware parameter support_dual_stations to indicate
>>>>>> whether 2 station interfaces are supported. For chips which
>>>>>> support this feature, limit total number of AP interface and
>>>>>> mesh point to 1. The max interfaces are 3 for such chips.
>>>>>> [...]
>>>>> Unfortunately this commit breaks wifi on a QCM6490 smartphone
>>>>> (qcm6490-fairphone-fp5) and makes the board crash.
>>>>>
>>>>> Reverting this commit (plus for conflict resolution 5dc9d1a55e95
>>>>> ("wifi:
>>>>> ath11k: add support for QCA2066") and 24395ec11707 ("wifi: ath11k:
>>>>> provide address list if chip supports 2 stations")) makes wifi work
>>>>> again.
>>>> Thanks for the report. So the broken commit is:
>>>> f019f4dff2e4 wifi: ath11k: support 2 station interfaces
>>>> This went into v6.9-rc1 so I'm guessing that WCN6750 support will be
>>>> fully broken in v6.9? Not good. And most likely Linus will release v6.9
>>>> on Sunday so it's too late to get a fix included in the final release.
>>>> Carl, can you fix this ASAP? Or should we just revert the broken
>>>> commits?
>>> Kalle, looks we're not able to fix it before Sunday as I don't have
>>> WCN6750 setup to verify the fix.
>> We are so late in the cycle that we would have to send the fix directly
>> to Linus and ask him to apply the fix before he tags the release. I
>> prefer that we are on the safe side here and send the fix to v6.10-rc1
>> via the usual route (the wireless tree). We get more testing time that
>> way.
>>
> No problem, Kalle.
> 
> I think more tags are needed like Tested-on WCN6750 and Tested-by Luca.
> 
> I'll send out the formal patch next week.

Hmmm, from here it looks like this did not happen. Did I miss something,
is there some reason to reevaluate things again, or did this maybe
simply fall through the cracks?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

>>> The fix could be to define a dedicated function
>>> ath11k_init_wmi_config_wcn6750() for WCN6750. I'll send the patch out
>>> so others like Luca can have a try.
>>
>> Thanks for the quick patches!
>>
> 
> 

