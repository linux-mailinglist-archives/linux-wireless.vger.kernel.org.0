Return-Path: <linux-wireless+bounces-15306-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 978929C934C
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 21:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2965C1F230B7
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 20:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0914D1ABED8;
	Thu, 14 Nov 2024 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g26WEkE2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37FF1A2645;
	Thu, 14 Nov 2024 20:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731616569; cv=none; b=IZ7rB38oUOyWfq/JHixDQ2Olm6ds4c2K3IFrpiXqTt9FCBx6vXVSIhP5A5j3AiO59MO0B766dCBZVxzrZTX26E02HGCrHUf44j20mM5CoTDC63Yamn2J0pdqagDd4o3FkE1xA1roKw2EQwBBjIsXFstMOjxH7fnyfttZfqfW8Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731616569; c=relaxed/simple;
	bh=lSORdJiPT7Wc6EoF0/Oqeke73jDK1EcS/a9kZa+bn9U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L6YMJs9QtA+PiS8rak3N7UgoT6Y9JD1qHwnqMwiEfyGHA8MmkERnE8f0/hN501dOq5iD7G8oApLRX9gvM0CKiak/cn2zzRUcPX2qRBWV05aCYgj6QpaVqyLfAWC4qQXiNzsKXHlGTI3ZW0vNjltmaAI1tC1sioDLzQzedEgr1p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g26WEkE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A11C4CECD;
	Thu, 14 Nov 2024 20:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731616569;
	bh=lSORdJiPT7Wc6EoF0/Oqeke73jDK1EcS/a9kZa+bn9U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=g26WEkE2CcDE7x5C4XvBg3dOXZmLyYlqtswgZNoFPp/J+P03xF74ZHb6pigKolwIM
	 mRbEPbZI9vB5p78gbbRwNjGbAmKUR0J5vuAcKWynNi7q1WKoswAGOIAleTJzWmVZJ3
	 4FQCuorDUYfybsoTgZL+47gZVjliykFrNlMJ1ujQYUndhv4BZS61PUSwjJ/HvllmXH
	 2iklC2wqehc1oxHPCCRlBk5EYez3ynIDiWFOs8qmeW+UbBAsez139Bba3Dorgz+mrr
	 ju6T2h3OOl3XKC8FbcTl4nAAR52VTm/+GZ+xcIGJwylrd0CtwZlPVWc/PgiDbk9N14
	 NRajdWDQTQEiw==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C87A7164D177; Thu, 14 Nov 2024 21:36:06 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>, Linus Torvalds
 <torvalds@linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: Andrey Batyiev <batyiev@gmail.com>, linux-wireless@vger.kernel.org, Greg
 KH <gregkh@linuxfoundation.org>, Linux regressions mailing list
 <regressions@lists.linux.dev>, Kalle Valo <kvalo@kernel.org>, Alf Marius
 <post@alfmarius.net>
Subject: Re: [REGRESSION] The iwl4965 driver broke somewhere between 6.10.10
 and 6.11.5 (probably 6.11rc)
In-Reply-To: <8a647709-8c33-4ac9-92da-bbf83ae2ed93@leemhuis.info>
References: <60f752e8-787e-44a8-92ae-48bdfc9b43e7@app.fastmail.com>
 <87wmhg61yp.fsf@kernel.org>
 <CAEQQxWx7PXw3O_j1FWn7G+DhUUXt3sEB0qDyA2+udRQ6r28FUA@mail.gmail.com>
 <4f689121-f2c1-45ec-bd5b-105a770af935@app.fastmail.com>
 <87ttcauv7x.fsf@kernel.org>
 <5f64abc6-017f-4283-bf08-dba1aea28e9d@leemhuis.info>
 <9fa869ddec6c22c0bb299676e27b7b33d3e3b5d7.camel@sipsolutions.net>
 <8a647709-8c33-4ac9-92da-bbf83ae2ed93@leemhuis.info>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 14 Nov 2024 21:36:06 +0100
Message-ID: <87bjyhr1s9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Thorsten

Quoting a bit selectively and out of order to comment on a few unrelated
aspects of this (meta-)discussion:

Thorsten Leemhuis <regressions@leemhuis.info> writes:
> On 14.11.24 10:52, Johannes Berg wrote:
>> On Thu, 2024-11-14 at 10:24 +0100, Linux regression tracking (Thorsten
>> Leemhuis) wrote:
>>>
>>> Sigh.
>>=20
>> Please. You really should consider adjusting your attitude on all this.=
=C2=A0
>
> If the revert is only merged during the merge window, it will likely
> take [...] four additional weeks if we are really unlucky.
>
> Things like that bother me -- and thus, yes, sorry, also influence my
> attitude, which lead to the quoted "sigh". It's just that "fixes are
> there, they just take a long time to reach mainline and stable releases"
> is the biggest problem I see during my regression tracking work.

I understand your frustration, certainly, and I get that you are tasked
with a thankless job in trying to improve the regression handling
situation. However, I also agree with Johannes that by letting your
frustration shine through (which is basically what you're doing with
that "sigh"), you are turning a general frustration at a difficult
systemic problem into animosity towards the *person* you are directing
your email at. This comes across as incredibly condescending, and it
only fosters animosity in the other direction, even creating a perverse
incentive to just ignore regressions entirely, as Johannes also pointed
out in his follow-up email[0].

Or to put it another way: the actual patch being discussed here should
be held up as an example of a *successful* regression handling: A
relatively obscure issue was reported, and within a week a fix was
committed to the relevant subsystem tree. If we had been *anywhere* else
in the cycle than where we are right now, this would have percolated up
to Linus' tree in time for the next -rc, or at the very latest one week
later. Judging from the numbers you presented at LPC, this would be a
very timely fix in all cases.

So yes, it's unfortunate that this happened to land at an unlucky time
in the cycle, and yes, in the ideal world this would just have been
fast-tracked. But by reacting with frustration to something that, for
all intents and purposes, is a proper and timely handling of a
regression, you are antagonising people and hurting your cause, not
helping it.

As for a concrete suggestion for how this could have been handled
better, if you had followed up your "Many thx for taking care of this!"
(which was great!) with a "I noticed there's an opportunity to get this
in before 6.12 is released, which will mean this gets to users several
weeks faster. Would you mind asking Linus to (cherry-pick/pull) this out
of order, as he has indicated he is willing to do", instead of the
"sigh, you are doing this wrong", you would have a much higher chance of
actually getting results.


As a side note, on this point...

> My approach/attitude is based on actions from Linus and/or what I expect
> he wants me to do, so let's bring him in to give him a chance to state
> if I went to far here.

...I will add that I personally find the whole "appeal to authority"
approach you are taking with the regression handling processes to be
somewhat off-putting. "Because Linus says so" is a terrible argument for
doing anything (on its own). If you can't persuade people by the
strength of your argument, appealing to authority will at best get you
grudging least-effort compliance, and at worst it will be actively
harmful because you antagonise people.

And yes, convincing people to change the way they work is hard,
especially when the ask is for them to do *more* work. That doesn't mean
it is impossible, but it takes time and patience and a variety of
approaches to succeed in the long term.


Note that I am saying all of the above as someone who is generally
sympathetic to the goals of your work (as I am sure you are aware, since
you're using my exchange with Linus about this in your slides :)). I do
not believe you are trying to antagonise people on purpose, so please
view the above as a good faith attempt at providing some feedback on how
you can continue this work without ending up doing so unintentionally.

-Toke

[0] https://lore.kernel.org/r/35bee1c6146cf261ad6b47f585a5b454ad0763ec.came=
l@sipsolutions.net

