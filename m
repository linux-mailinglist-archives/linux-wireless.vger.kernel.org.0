Return-Path: <linux-wireless+bounces-15304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D57BF9C8F64
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 17:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F03FEB3B3FE
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 16:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4BE13AD39;
	Thu, 14 Nov 2024 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="KZp+ZsGR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23003136327;
	Thu, 14 Nov 2024 15:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731599975; cv=none; b=AaS2X7zR6I7K2PcDf8baNq7XGX4rJNw61KCqDLPEv3dEUCpp4vCBOx8Y/lxeIcx8iUpJhIGVpknPIdKezc4jrbQD1FbocYC8FGKuY24e8O5tz9iEEXxjjrLYTSQyo6oCyoHLIm49FUCUtGd+1FOE5d6K83fJ0UBLk3jySgg7Idk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731599975; c=relaxed/simple;
	bh=r/TelsO6eMqcZs26e0NDIxSygpb0lF1YMKIOsmhK8IU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hxc80OydG/pUfn9vZ+Hg16+JIDlA1qv1QkZHaFAGr7psBxDJuz644agV6HZpp0Z/dQSrBAwZE1eYlsVDY7K2mMLNRC/BbdvsQVaNS8SnVs/tum+G3V5EkrByW+U4pNiD3/iXkQqAPNBcTsr1YAYoUG8oLaAOsJ55GC4EVHlej2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=KZp+ZsGR; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=r/TelsO6eMqcZs26e0NDIxSygpb0lF1YMKIOsmhK8IU=;
	t=1731599974; x=1732809574; b=KZp+ZsGRd4lJX7GSpt6haoPDgPP4hffrOROJNYWaPG+x3CA
	lcb6IkuniM1jJksGg/X2Hyzv1haaPhxYK0Zsx7Z5fAy0T/PwPRAUInBpIdheaWmbl9Oj7MrudahU2
	wj1CmRJCY2T0BsKkU34nwJpkBS+xscBD+byGyEuxj4klxXcNm3OQwB30lYHt4p1JNIF9tA2tazGHN
	EjWI3ZBZRyBv9iAS7sq9nrF6z0kUFYospftCROp3SMKsg6wfWW9CkWko3b0heAT20nprRbc3Xtbi2
	EoO0XWU6+EqhJ7E8RKm6eni7lyAZxDfGRhP3ItZDuiTW9Af6Op3xHLD4bp5oUXQw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tBcFg-00000004nmK-3PoR;
	Thu, 14 Nov 2024 16:59:24 +0100
Message-ID: <4d7c6baf9c1dd3f9623782c614d24d346a5ec7b7.camel@sipsolutions.net>
Subject: Re: [REGRESSION] The iwl4965 driver broke somewhere between 6.10.10
 and 6.11.5 (probably 6.11rc)
From: Johannes Berg <johannes@sipsolutions.net>
To: Thorsten Leemhuis <regressions@leemhuis.info>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: Andrey Batyiev <batyiev@gmail.com>, linux-wireless@vger.kernel.org, Greg
 KH <gregkh@linuxfoundation.org>, Linux regressions mailing list
 <regressions@lists.linux.dev>, Kalle Valo <kvalo@kernel.org>, Alf Marius
 <post@alfmarius.net>
Date: Thu, 14 Nov 2024 16:59:23 +0100
In-Reply-To: <8a647709-8c33-4ac9-92da-bbf83ae2ed93@leemhuis.info>
References: <60f752e8-787e-44a8-92ae-48bdfc9b43e7@app.fastmail.com>
	 <87wmhg61yp.fsf@kernel.org>
	 <CAEQQxWx7PXw3O_j1FWn7G+DhUUXt3sEB0qDyA2+udRQ6r28FUA@mail.gmail.com>
	 <4f689121-f2c1-45ec-bd5b-105a770af935@app.fastmail.com>
	 <87ttcauv7x.fsf@kernel.org>
	 <5f64abc6-017f-4283-bf08-dba1aea28e9d@leemhuis.info>
	 <9fa869ddec6c22c0bb299676e27b7b33d3e3b5d7.camel@sipsolutions.net>
	 <8a647709-8c33-4ac9-92da-bbf83ae2ed93@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Thu, 2024-11-14 at 16:30 +0100, Thorsten Leemhuis wrote:
>=20
> My approach/attitude is based on actions from Linus and/or what I expect
> he wants me to do, so let's bring him in to give him a chance to state
> if I went to far here.

Umm, no. You own your attitude and communication behaviour. That's not
Linus's fault. Maybe he asked you to pay attention to how fixes enter
mainline, maybe he didn't, I don't know or don't even care. But the fact
is that for a very long time now pretty much every single interaction
we've had has been in one way or the other you complaining about how
I/we did something. It really does feel like all you care about is
piling on more pressure.

Also, FTR, I wasn't even involved in the patch.

> Well, Linus is known to have no problem at all with picking up fixes
> straight from lists if there are good reasons (like the unlucky timing
> we have here), as long as that does not become the norm. That approach
> was actually used in the situation I pointed to, as it really is quite
> similar.

And we've obviously done that in the past. For _important_ fixes. A
single user reported this, was able to use an older kernel while it's
getting fixed, and it's on a device that's somewhere around 15 years old
at this point.

But you seem to think it's *free* to do this. It isn't! It needs
coordination, asking, it needs to be managed, etc.
>=20
> The problem is, that bring this up in situations like this is making the
> "maintainer burnout" problem worse. I hate that and feed sorry for that.

I don't buy it any more. That worked a long time ago, but it's clearly
the only thing you ever do, and you seem to be pretty comfortable doing
it over and over and over again.

johannes

