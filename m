Return-Path: <linux-wireless+bounces-7765-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E350A8C80C5
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 08:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D58AB20F1E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 06:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80E114F64;
	Fri, 17 May 2024 06:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="vKI4AP2W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C66C14F61;
	Fri, 17 May 2024 06:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715925871; cv=none; b=pdhNgUetxxrCu2MEPRGNYwO9bev+KjkQb3j9nTT9JDRrse/uFeYq9v+k/c0PkmSiqJaSDQjn2PsGrruXFKpp+crBL4LiSoMptDMSPvinfpnzDbp3dlt6UeqjXL725gBHposGsEZ+jFktRHgEnv0vjA3kc/2SKFdicuxkaJSei3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715925871; c=relaxed/simple;
	bh=/uVkMkpHgcsZnX5ONm08UPsVfSt/tt/ellrNfK9gsII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4nlsHiadNbrL2IEFjihfPZ02AjpAqye609ZGXhc6EttD+DS6O88YvpTZxvv9SIu7dSAO8zYQNH31oGVRhpiz4ITFvPbGXVWGdYj2ukvStz0HtSpj+2TodGOYJEkiY37RB9rYJHZId8k4coXJQjURE9tVhj29QwOMtweRDrKK3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=vKI4AP2W; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=g950LNR8tFR9TBwlOx9w9TDBT5UMfzV59UR2knY+mS8=; t=1715925869;
	x=1716357869; b=vKI4AP2WW8muGxiew2XKtqXw1o1/QUioVG5A7A90GZdBHAfH65Pcyzgplsnkp
	8VAPnDCKbK9Hiu8vx9s462KebQYY2mIQ5bd62jjD+TOOADQnTKKZ428uhAMGlro3HWDcIfjDJ9wdR
	RI2VYD/T/Ps7NuuUMQxt621CHX5CMIKuln9JZT718GIXKzEGGGPmIR/SBu6RqRIaAPdiPUrUCQHIg
	eI5BGeODbuVBHE9QqGjkOhmt9485q0biJpRV5BVhOMIkdQrpfyBaHAF9bfuVoQuKL+r+0e74fwEHm
	IriV9yJVxuOBys3C+3CJOpJR6dUCsJtQ02OH6NyggLXG9wVE6Q==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s7qhe-0001eR-J3; Fri, 17 May 2024 08:04:26 +0200
Message-ID: <613ecd58-9f65-4d03-98df-40f3959376d6@leemhuis.info>
Date: Fri, 17 May 2024 08:04:26 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: ath11k: supports 2 station interfaces
To: Kalle Valo <kvalo@kernel.org>, Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
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
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <87fruhggcw.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1715925869;7b655ce5;
X-HE-SMSGID: 1s7qhe-0001eR-J3

On 17.05.24 07:25, Kalle Valo wrote:
> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> 
>> On 5/16/2024 4:45 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> On 11.05.24 05:12, Carl Huang wrote:
>>>> I'll send out the formal patch next week.
>>>
>>> Hmmm, from here it looks like this did not happen. Did I miss something,
>>> is there some reason to reevaluate things again, or did this maybe
>>> simply fall through the cracks?
>>
>> Formal patch is still under internal review
> 
> BTW I'm also experimenting with regzbot to help me track regressions in
> wireless and to avoid missing important fixes.

Not sure, but I tend to think that's still too early; better wait a few
more months.

> Thorsten, I don't know if you take wishes but it would be nice to have
> in regzbot some kind of filtering per subsystem or label. Maybe
> something like this:
> https://linux-regtracking.leemhuis.info/regzbot/mainline/?subsystem=wireless
> 
> And then a have command for regzbot setting the subsystem (or a label).
> That way I could easily see only the wireless related regressions, now
> it's harder to find them from the list.

I listen to wishes, but in this case the idea is not new: exactly
something like this is pretty high on my todo list. But there are still
two other things on top of it and requires some major reworks; and I
currently also don't find much time to work on the code. :-/ But sooner
or later I'll get there!

Ciao, Thorsten


