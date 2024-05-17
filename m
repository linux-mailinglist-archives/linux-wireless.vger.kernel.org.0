Return-Path: <linux-wireless+bounces-7769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CCE8C818D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 09:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0748F1C209FD
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 07:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0797817741;
	Fri, 17 May 2024 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kh54zjZq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F96175AD;
	Fri, 17 May 2024 07:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715931559; cv=none; b=GwPQqpvORh1QjR0IynArRQKmqkKxDPPUf6jOiWrds13lCvVsq7SpZEmfZEiq8hrGYx8v0fYc0UbJpFpYdSO6BzeaKSEmjEluvjTDBbclII09Rd4EuhSs+3A8wFxDsLcLvluOqDWytV8RIOqAYM/Me+kWPiXr+7y6Sx/m7elsgMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715931559; c=relaxed/simple;
	bh=tXV0yYKpvKn/RfGN/Y44iVcXp2iZr9dOA16KJTdqPm8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=nEvGANZD2TjEFI+EIOB50nKgvdtFTvYmaIl1OYhq9bbSZrIVHF5FmJ7RprmrSTXeaUkVe872fuvw84ojq4qK8OTvQRN+PWS1e3FDkGVSLBTiOjTzk8x55hvTlmRJagX7gUXA6HEOD1keleGQGf6OBPZC3u0MVt50sJTdEfjiWLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kh54zjZq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB02DC2BD10;
	Fri, 17 May 2024 07:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715931559;
	bh=tXV0yYKpvKn/RfGN/Y44iVcXp2iZr9dOA16KJTdqPm8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Kh54zjZqNXQhFKCFgh2n3rWBHho8Gk5KJ9BNVt4kvCLZHXt6ySYnGrIs2c5dEc16Z
	 QOFUSo0SH7hs1Zcusgyre8dMkVfpj+hJL6B4GJl34nYG1lhqMY6W6PcX1BP7d4E6yE
	 5itjmvJ0wo9su+l0+dG9cuVhqZGpqR6e0ta+enNMrPcS834lZeW1H/6smBUfBQqwRs
	 X1sTvOHeB1XvAODlc9AqRU2fCXPrJpAkI2rtYIloqpr2erf92RDHWVp6CCVFK5wAh5
	 JA1yQjX3A0z0lxmnlI+4qXO2d8CQ1u/QTgj5E+bffipWep4DO2aLnrYIArmYsl+ktZ
	 f66ujMs4vVBUg==
From: Kalle Valo <kvalo@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,  Linux regressions mailing
 list <regressions@lists.linux.dev>,  Carl Huang
 <quic_cjhuang@quicinc.com>,  Luca Weiss <luca.weiss@fairphone.com>,
  ath11k@lists.infradead.org,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/2] wifi: ath11k: supports 2 station interfaces
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
Date: Fri, 17 May 2024 10:39:15 +0300
In-Reply-To: <613ecd58-9f65-4d03-98df-40f3959376d6@leemhuis.info> (Thorsten
	Leemhuis's message of "Fri, 17 May 2024 08:04:26 +0200")
Message-ID: <874jawhopo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <regressions@leemhuis.info> writes:

> On 17.05.24 07:25, Kalle Valo wrote:
>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>> 
>>> On 5/16/2024 4:45 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>> On 11.05.24 05:12, Carl Huang wrote:
>>>>> I'll send out the formal patch next week.
>>>>
>>>> Hmmm, from here it looks like this did not happen. Did I miss something,
>>>> is there some reason to reevaluate things again, or did this maybe
>>>> simply fall through the cracks?
>>>
>>> Formal patch is still under internal review
>> 
>> BTW I'm also experimenting with regzbot to help me track regressions in
>> wireless and to avoid missing important fixes.
>
> Not sure, but I tend to think that's still too early; better wait a few
> more months.

FWIW I have been pretty happy so far and would prefer to continue using
it with wireless drivers regressions. But of course if it's better for
you I'll stop for now.

>> Thorsten, I don't know if you take wishes but it would be nice to have
>> in regzbot some kind of filtering per subsystem or label. Maybe
>> something like this:
>> https://linux-regtracking.leemhuis.info/regzbot/mainline/?subsystem=wireless
>> 
>> And then a have command for regzbot setting the subsystem (or a label).
>> That way I could easily see only the wireless related regressions, now
>> it's harder to find them from the list.
>
> I listen to wishes, but in this case the idea is not new: exactly
> something like this is pretty high on my todo list. But there are still
> two other things on top of it and requires some major reworks; and I
> currently also don't find much time to work on the code. :-/ But sooner
> or later I'll get there!

Trust me, I know how it is :) These are just wishlist stuff and low
priority.

One more to the wishlist: refreshing the HTML page once an hour or so. I
now keep the regzbot page always open and it would be nice to have it
up-to-date without pressing CTRL-R. Yes, I'm lazy :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

