Return-Path: <linux-wireless+bounces-13053-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D0097D547
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 14:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E857B21853
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 12:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 942D113B2B0;
	Fri, 20 Sep 2024 12:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Zu1NXJua"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA5123D2
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726834349; cv=none; b=cPhdOGqPdJOeiSUDAXn8VKF22qRBnLksqwn3x17/1hG+8y7cE0Sk4lSQYU26w3nMrVu2B7zH/EugqDPCWAcRgNpQGKQQrs5oflhTDhlckETbDGxkwXNfRb81T6Uz8g2bNuP+7LfOiajQiW3bWzB8/xHETpQiOOGXcGqacakNHMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726834349; c=relaxed/simple;
	bh=eCLF+OsW0ELXFgDebpWzvm8mUhVBev4xPHjaoyN4xqE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mTvYwUwT0p/SldQHdUsiLZFu0UDOnnzWDBeFZ5vtQlyeNvtG9DH3tzCFsskcKwUvhB+QpssgbjFASrk3bXB59SFx1l+HPDkjaa/+DqwnNmtdGDeLtP7jj203JAdshopUCVfLbRlYyy4e4hnMHeAbq/cMsNjTwug4zwS4w1Tz8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Zu1NXJua; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=W0D3CEDwI9W8S3gSoMSLxj0PkonSRRsD3HLTywT+8nU=;
	t=1726834347; x=1728043947; b=Zu1NXJuaYlyJYkMNHhn2Fv6ssG+8CMEvNGbJPLw2f/wXGQw
	XLDrFr6VogyIx+tz6o7fDhMBjl/pH9OxF5Yx82Wsj9BwEmlktrxJ/e3IBG43N2e9rtlnhVR31Wk5u
	BVEpkjmuR2xcuTfCsBtRZyC6PBsDk5hppdVQQ9AshvAurjmmYzTrkBM1MXepbxN44BXZBJiOMmRaj
	n5vDkIezCIY6gC49ATMpsDwS5X9KWuW7oEnCQFxfM1c2lcC6tAFpXbvLh9Ue7nhfYftJtPNaClOh9
	3be6gTGDMh0VQWwQFBzHqLyzvX/3p30Sc2ZzJzoAlJoUjaePrjxwzHiJI38px+uw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1srcUq-000000075T4-2piO;
	Fri, 20 Sep 2024 14:12:25 +0200
Message-ID: <13e473715fa721e0055464c1b5c78d47f969d74e.camel@sipsolutions.net>
Subject: Re: Missing wiphy lock in ieee80211_color_collision_detection_work
From: Johannes Berg <johannes@sipsolutions.net>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>, Nicolas
 Escande <nescande@freebox.fr>, linux-wireless@vger.kernel.org
Date: Fri, 20 Sep 2024 14:12:23 +0200
In-Reply-To: <Zu1mMZNxTIsYNH20@pilgrim>
References: <D4A40Q44OAY2.W3SIF6UEPBUN@freebox.fr>
	 <b9d5550c-8ac1-41d7-9abb-caa11f484064@green-communications.fr>
	 <c48876507ec971c9195e468e6037cc251dcf2218.camel@sipsolutions.net>
	 <Zu0yRl4iyfspa8AV@pilgrim> <Zu01VbjzUFYYjGJi@pilgrim>
	 <f00e76b9425b10dbfe347f8d107bf6a044e81069.camel@sipsolutions.net>
	 <Zu1ldqE5zneiHOeK@pilgrim> <Zu1mMZNxTIsYNH20@pilgrim>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-09-20 at 14:10 +0200, Remi Pommarel wrote:
> On Fri, Sep 20, 2024 at 02:07:19PM +0200, Remi Pommarel wrote:
> > On Fri, Sep 20, 2024 at 12:00:08PM +0200, Johannes Berg wrote:
> > > On Fri, 2024-09-20 at 10:41 +0200, Remi Pommarel wrote:
> > > > > I think using timer_pending(&link->color_collision_detect_work->t=
imer)
> > > > > to replace delayed_work_pending(), even if the semantic is a bit
> > > > > different, would be ok to fulfill the rate limiting purpose.
> > >=20
> > > I think you're right. We could as well check list_empty() or so, but =
it
> > > wouldn't make a big difference. As you say:
> > >=20
> > > > > Having the
> > > > > same delayed_work_pending() semantics on wiphy work queue would r=
equire
> > > > > to take wiphy lock
> > >=20
> > > To really have it known _precisely_, that's true.
> > >=20
> > > > >  which seem a bit superfluous here.
> > >=20
> > > It's actually simply also not possible - if we could sleep in
> > > ieee80211_obss_color_collision_notify() and take the wiphy mutex, we'=
d
> > > probably have done this completely differently :)
> > >=20
> > > And a hypothetical wiphy_delayed_work_pending() API should therefore =
not
> > > be required to be called with the wiphy mutex held.
> > >=20
> > > I think that perhaps we should add such a trivial inline instead of
> > > open-coding the timer_pending() check, but I'm not sure whether or no=
t
> > > it should also check the list (i.e. check if timer has expired, but w=
ork
> > > hasn't started yet): on the one hand it seems more appropriate, and i=
f
> > > actually holding the wiphy mutex it would in fact be completely corre=
ct,
> > > on the other hand maybe it encourages being sloppily thinking the ret=
urn
> > > value is always perfect?
> > >=20
> > > Right now I'd tend to have the check and document that it's only
> > > guaranteed when under the wiphy mutex.
> >=20
> > I had this exact train of thought and was replying that I did agree on
> > that, and then I checked the other *_pending semantics for which I tend
> > to forget the details.

Haha, yes, no kidding.

> > IIUC timer_pending() and work_pending() can both
> > return false if callback is still running (or even not yet started).
> > Thus the hypothetical wiphy_work_pending() semantics could allow to
> > implement it using timer_pending().
> >=20
> > Adding a list_empty() check while making it more "precise" does not mak=
e
> > it "perfect" (even if there is no clear notion of what perfection shoul=
d
> > be here) even with wiphy lock held. Indeed if wiphy_work_pending() is
> > called precisely after delayed work timer has cleared its pending state
> > but before the callback (i.e wiphy_delayed_work_timer()) has added the
> > work in the list both !timer_pending() and list_empty(work->entry) woul=
d
> > be true. So there is a small window where wiphy_work_pending() wouldn't
> > be more precise than just checking timer_pending() as show below:
> >=20
> >       CPU0                               CPU1
> >  expire_timers
> >    detach_timer
> >                                     wiphy_work_pending() -> return fals=
e
> >    timer->function
> >      wiphy_work_queue
> >        list_add_tail()
> >                                     wiphy_work_pending() -> return fals=
e
>=20
> I meant wiphy_work_pending() -> return true here ^.
>=20
Good point! The second call could even be before the list_add_tail and
still return false, so yeah, wiphy lock doesn't do anything.

But I guess we can live with both of these too, given sufficient
documentation :)

Agree also with Nicolas though that we could just ratelimit this
differently too, this was just a convenient way of achieving it with the
existing infrastructure.

johannes



