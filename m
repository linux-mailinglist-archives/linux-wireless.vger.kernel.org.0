Return-Path: <linux-wireless+bounces-7827-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C578C95AA
	for <lists+linux-wireless@lfdr.de>; Sun, 19 May 2024 19:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7745B1F2109C
	for <lists+linux-wireless@lfdr.de>; Sun, 19 May 2024 17:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302674DA14;
	Sun, 19 May 2024 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="TiYdk0p+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18BF45C1C;
	Sun, 19 May 2024 17:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716141103; cv=none; b=U9Ja6rZFxr16/r067Ir/vSYtM5ESTNXI55dJWJHu1tbXiw5iDH+RmTRK3TriQgG0ZAuZjPQB0kIC9+/zLjRl62FHJXVxttzmyRWMDKPjHkM1dFGLXmG/oUKoVinQEy/hlgTsemVoVQUN+foYfwUhTnspXjOLwyfHDd2Etxo9r2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716141103; c=relaxed/simple;
	bh=apP8B03jWePnyIhNPpJNd83nCtfVfho0HeEF5bwWnk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qX2bG5Q/LFxj933AbP6V7Mil8zofmoMvwn0MPy9W0/dECm5JWmGvOuyqFsg44B4OAfk+0PQO0eAkDwzT1Z1BVLQ/c7dV96w5slyBMBBErv3ekCRik904rgL4wxChMYE8QyIHIhfzFM6/w16bElD8iXxhGetz/u267MjVli6rQ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=TiYdk0p+; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=EuvoHemgpgcqb4JrOqi04wT1VL8bVB7gZbpZmHmGq58=;
	t=1716141101; x=1716573101; b=TiYdk0p+9Cbh4NORwCOx8+nChvnyMo+mhCY01J/Y0GPPP7M
	cncRDnLO8Jql50mIhhV9wDC6LYanGEuXVh/u3AiXKHc3Lfei9vxn2JPiJXv4gVH2jqZbiRVG9gnS1
	on9i2RDeGLOmkXNLCf8Ltp+oy0B8tFiI4HfGYp2L7kieUmypQ/wgmxszTi1943Rd4xM9ulHVX0AZa
	vdZ8LXag6XmpTW8p2sXewhbjGspJKkp3udVyOP+pLO9JWSHrkmWpnctrP28P85zehKnZF28m8ThuO
	+x11HyOqCA7ChAJA0mcRFKHBFp95jgu3zmTlt1uTR5z/+NUX0u2EIOfsp+uFcCRQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s8kh2-0003pw-T4; Sun, 19 May 2024 19:51:32 +0200
Message-ID: <80b102c5-2d49-41ba-a4e3-801e16f7f2bd@leemhuis.info>
Date: Sun, 19 May 2024 19:51:32 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath11k: supports 2 station interfaces
To: Kalle Valo <kvalo@kernel.org>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 Carl Huang <quic_cjhuang@quicinc.com>, Luca Weiss
 <luca.weiss@fairphone.com>, ath11k@lists.infradead.org,
 linux-wireless@vger.kernel.org
References: <20230714023801.2621802-1-quic_cjhuang@quicinc.com>
 <20230714023801.2621802-2-quic_cjhuang@quicinc.com>
 <D15TIIDIIESY.D1EKKJLZINMA@fairphone.com> <87jzk2km0g.fsf@kernel.org>
 <93c15c59-f24c-4472-ae7e-969fd1e3bfec@quicinc.com>
 <871q69lqh5.fsf@kernel.org>
 <4e21e556-527f-4d1e-aa29-cacec14155af@quicinc.com>
 <a53e2188-b982-44b7-9dfe-f5dfd6b802ca@leemhuis.info>
 <4d72f74a-b2eb-43d3-92a2-1311081ce72c@quicinc.com>
 <87fruhggcw.fsf@kernel.org>
 <613ecd58-9f65-4d03-98df-40f3959376d6@leemhuis.info>
 <874jawhopo.fsf@kernel.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <874jawhopo.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1716141101;56ef6375;
X-HE-SMSGID: 1s8kh2-0003pw-T4

On 17.05.24 09:39, Kalle Valo wrote:
> Thorsten Leemhuis <regressions@leemhuis.info> writes:
>> On 17.05.24 07:25, Kalle Valo wrote:
>>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>>>> On 5/16/2024 4:45 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>>> On 11.05.24 05:12, Carl Huang wrote:
>>>>>> I'll send out the formal patch next week.
>>>>>
>>>>> Hmmm, from here it looks like this did not happen. Did I miss something,
>>>>> is there some reason to reevaluate things again, or did this maybe
>>>>> simply fall through the cracks?
>>>>
>>>> Formal patch is still under internal review
>>>
>>> BTW I'm also experimenting with regzbot to help me track regressions in
>>> wireless and to avoid missing important fixes.
>>
>> Not sure, but I tend to think that's still too early; better wait a few
>> more months.
> 
> FWIW I have been pretty happy so far and would prefer to continue using
> it with wireless drivers regressions. 

Ohh, in that case just continue!

> But of course if it's better for you I'll stop for now.

No, not at all, making regzbot more useful for subsystem developers and
maintainers is the next important step, so I'm glad if it already works
well for you. And if something does not work, just tell me!

>>> Thorsten, I don't know if you take wishes but it would be nice to have
>>> in regzbot some kind of filtering per subsystem or label. Maybe
>>> something like this:
>>> https://linux-regtracking.leemhuis.info/regzbot/mainline/?subsystem=wireless
>>>
>>> And then a have command for regzbot setting the subsystem (or a label).
>>> That way I could easily see only the wireless related regressions, now
>>> it's harder to find them from the list.
>>
>> I listen to wishes, but in this case the idea is not new: exactly
>> something like this is pretty high on my todo list. But there are still
>> two other things on top of it and requires some major reworks; and I
>> currently also don't find much time to work on the code. :-/ But sooner
>> or later I'll get there!
> 
> Trust me, I know how it is :) These are just wishlist stuff and low
> priority.

Apparently depends on the point of view, as I think it's high priority.

> One more to the wishlist: refreshing the HTML page once an hour or so. I
> now keep the regzbot page always open and it would be nice to have it
> up-to-date without pressing CTRL-R. Yes, I'm lazy :)

Added that to the issue tracker to ensure it's not forgotten.

Ciao, Thorsten

