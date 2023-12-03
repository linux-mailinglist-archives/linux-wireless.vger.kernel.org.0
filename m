Return-Path: <linux-wireless+bounces-340-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD529802663
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Dec 2023 19:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A541F20FC5
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Dec 2023 18:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A27517983;
	Sun,  3 Dec 2023 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qW2pjun2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC8CDA;
	Sun,  3 Dec 2023 10:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QtIyW3E7F8b3M4DB9PWxzuQJmSmGS9EQPoqv9FPpM1U=;
	t=1701629492; x=1702839092; b=qW2pjun2tRXyr19yfLBkGwYew6Y3r9bPL8/A1+kUKplDeZ/
	ldV0TjT8AuTI6EQf5FdMCs8UydjJ7/wcK16uVGcGEQaPH1/V+ePaTPiXhGh0yDmlt8HXGCY+oypML
	GxAjWy9sUmxhqQab/5yTX0UilJ8KYQqjIyFrb/DMwTW9xcwNZFJrtGDUIrTXfKsW42OkHEwSrRCIK
	96vhJpnlc0s5UUVRTjglvwx0ZmbUJJFOZonjgZHDOKXCuX+j0vB1T+/lXgTwoSD5pDFekeeCb7NZ1
	v0W8K6zNHREu+E2lHN39L0kh8ZCp659iMY24kQWvWRrbu1MIDSCjBSR+vqTt0YuA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1r9rYv-0000000DmPt-3GxJ;
	Sun, 03 Dec 2023 19:51:30 +0100
Message-ID: <efd89dee78a4c42b7825fa55bbceafad9bb9df36.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 0/3] netlink carrier race workaround
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Sun, 03 Dec 2023 19:51:28 +0100
In-Reply-To: <20231202104655.68138ab4@kernel.org>
References: 
	<346b21d87c69f817ea3c37caceb34f1f56255884.camel@sipsolutions.net>
	 <20231201104329.25898-5-johannes@sipsolutions.net>
	 <20231201162844.14d1bbb0@kernel.org>
	 <339c73a6318bf94803a821d5e8ea7d4c736dc78e.camel@sipsolutions.net>
	 <20231202104655.68138ab4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sat, 2023-12-02 at 10:46 -0800, Jakub Kicinski wrote:
> On Sat, 02 Dec 2023 11:06:36 +0100 Johannes Berg wrote:
> > > Would it work if we exposed "linkwatch is pending" / "link is
> > > transitioning" bit to user space? =20
> >=20
> > Not sure, not by much or more than what this did? It's basically the
> > same, I think: I exposed the carrier_up_count at the kernel time, so if
> > userspace hasn't seen an event with a value >=3D that it knows the link=
 is
> > transitioning.
>=20
> The benefit being that it'd work for everyone, without having to add
> the carrier count in random events?

Well, true. You'd still have to add random rtnl_getlink() calls to your
userspace, and then wait for an event if it's transitioning? Actually a
bit _more_ complicated since then we'd have to do rtnl_getlink() after
receiving the assoc event, and then wait if still transitioning. Or I
guess we could do it when sending a frame there in the tests, but it's
another call into the kernel vs. getting the information we need in the
event.

But yeah honestly I don't mind that either, and maybe it helps address
some other use cases like what Andrew had in mind in his reply to my
original thread.

> > > Even crazier, would it help if we had rtnl_getlink() run
> > > linkwatch for the target link if linkwatch is pending? =20
> >=20
> > Sure, if we were to just synchronize that at the right time (doesn't
> > even need to be rtnl_getlink, could be a new operation) that'd solve th=
e
> > issue too, perhaps more easily.
>=20
> I was wondering about the new op, too, but "synchronize things please"
> op feels a little hacky.

Agree ... but then again it's all a bit hacky. You can even read
"carrier is on" when it's really not yet ready...

> rtnl_getlink returns link state, so it feels
> somewhat natural for it to do the sync, to make sure that what it
> returns is in fact correct information.

Yeah that's a good point that I just mentioned above though - today the
kernel will happily return a state that it's not actually willing to
honour yet, i.e. if you actively read the state, you'll see carrier on
before the kernel is actually willing to transmit packets on the link.

Fixing that _would_ be nice, but I'm somewhat worried that it will cause
performance regressions to always sync there? OTOH, it would hopefully
not actually have to wait most of the time since link_watch isn't always
pending...

> rtnl_getlink does return a lot, so maybe a new rtnl_getcarrier op?

Does it matter? Just another attribute ...

> Or we can make reading sysfs "carrier" do the sync?

I think I wouldn't mind now, and perhaps if we want to sync in netlink
we should also do this here so that it's consistent, but I'm not sure
I'd want this to be the only way to do it, I might imagine that someone
might want this in some kind of container that doesn't necessarily have
(full) access there? Dunno.


We _could_ also use an input attribute on the rtnl_getlink() call to
have userspace explicitly opt in to doing the sync before returning
information?


johannes

