Return-Path: <linux-wireless+bounces-11128-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A4A94BEE0
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 15:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C391C23CF6
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 13:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3D018E741;
	Thu,  8 Aug 2024 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjQtoA7E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC03518E740
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723125287; cv=none; b=mz+08WZCx4xBpjCIormhN+kEkOntMsXMvHsXjLtZedeYt+4E1AIqNUcdi2CsCQZe4pz/iUXHWYjGekbwDAi7vfHJjmpBk+lFWM33XtVXpCBgjhTbrHBMceAc7K6hZ1Z34AL63p9b88U250Xp+Tu99oREr/V5Z9D944zzTbJLRhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723125287; c=relaxed/simple;
	bh=nkObpOmCwLhZ5WtPiXbo12v6b7I55cOTWSNb1UA4iA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o4s+SFfFRUek5Nl+pI1fgOCR67+mqwhtzXHBVtiPOYsYhhpX+hAuFI3Sr/kUuClUJX7fKnR9aC4x9bYc+ORkij+SziuaSnw03OxsIFpSymNQ4h611GbebmspRYh0zAIbqgrs7q8KMv1AAeCtxotZ6iDKak+OZQ6F7v4pDB4IYDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjQtoA7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD01C32782;
	Thu,  8 Aug 2024 13:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723125287;
	bh=nkObpOmCwLhZ5WtPiXbo12v6b7I55cOTWSNb1UA4iA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AjQtoA7E3/9K2JistB9hZi0dmjmmPzlatZnnAutOjyxjbDktB23H+crHRz9nXHv5V
	 OEep1kUk1z5YniKdELz48XmIuCtVj06ueRbE4+4yFsu4ZYtDvnYQvGjxjRAGyPjYxB
	 GyCUGurt/wlECX50034Ec7Kn9Ayg1ECImyvku/AYT5XZKeLOYaGsnWTDG0u8rkRZOt
	 Av37PsEW1LmZ100VsQsvwJOVuJDj0tDnqTO26eNcUn5676jMguKu5qu2y9BpRpFukO
	 OOTSNPsJ3lFROKSfXGPCGHFr2Dussxj4rt8io5gIuFmmLnv2e/yo+EuTAIkMmK4/zo
	 RRdsaZAtZzvsg==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 0B22B14AD703; Thu, 08 Aug 2024 15:54:44 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Felix Fietkau <nbd@nbd.name>, Rosen Penev <rosenp@gmail.com>,
 linux-wireless@vger.kernel.org
Subject: Re: [PATCH] net: ath9k: use devm for request_irq
In-Reply-To: <87o7632qff.fsf@kernel.org>
References: <20240731210243.7467-1-rosenp@gmail.com>
 <201f06b6-14f5-41bb-8897-49665cf14b66@nbd.name>
 <CAKxU2N9r3Y=Z+rtPbCteWA8-5fRb2NTy2e4xG+=7JvhtzHPg7A@mail.gmail.com>
 <5dfa4b5a-d8eb-42a8-92bb-81e713fe3395@nbd.name>
 <CAKxU2N_9naiGUk8uOwWNUNbzf8SFPdYPt-Wzg93pksjau2tLLA@mail.gmail.com>
 <48cdd408-ab33-4b2e-83e3-73a89c10e368@nbd.name> <87plqjpds4.fsf@toke.dk>
 <87zfpn2ua8.fsf@kernel.org> <87jzgrpaf9.fsf@toke.dk>
 <87o7632qff.fsf@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 08 Aug 2024 15:54:44 +0200
Message-ID: <87ed6zp1az.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kalle Valo <kvalo@kernel.org> writes:

> Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org> writes:
>
>>> But honestly more and more I'm starting to think that we should just
>>> reject all these "drive-by cleanups". We have better things to do than
>>> fixing unnecessary their bugs. Thoughts?
>>
>> Hmm, yeah, maybe. I do kinda like the fact that people send patches to
>> improve small things, though. We all started out as new to the kernel,
>> and I appreciate the fact that people try to improve our "commons" in
>> this way even if it's small things.
>
> Yeah, you have a point. It's just that the extra work from cleanups
> feels so unnecessary compared to the practical benefits. And most of the
> time we don't hear from these people ever again, that's why I call them
> "drive-by cleanup".

Sure, I share the frustration, and not everyone turns into regular
contributors. But I like to think that even those who don't get
something else out of it at least. And on our side I guess there's a
balance to be struck between being welcoming and not expending too much
effort on it :)

>> I do try to be critical of things that can break stuff before ack'ing
>> these fixes, but I'll admit that it seems like I don't have that great
>> of a track record for judging "correct" in this context (cf this one,
>> and that debugfs regression). So I guess you're right that I should at
>> least raise the bar somewhat; will try to recalibrate and say no more :)
>
> You are doing a great job :) Nobody can catch all bugs in review, I
> would say there is a small percentage (5%?) of all cleanup patches that
> cause issues. Though it would be cool to see some real statistics.

Thanks! Yeah, would love to see some statistics, but I suppose it's not
trivial to identity "cleanup patches" in the first place in a way that
can be automated. Maybe something to poke at sometime one has time to
spare (ha!) or needs a break from the regular drudgery :)

-Toke

