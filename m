Return-Path: <linux-wireless+bounces-13049-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C30597D3F9
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 12:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858FA1C20AA0
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Sep 2024 10:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A0A5339F;
	Fri, 20 Sep 2024 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bSkJfs8c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6202482CD
	for <linux-wireless@vger.kernel.org>; Fri, 20 Sep 2024 10:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726826421; cv=none; b=eBmPtIT3/u4rGjYCgqC5Yzh8/ispMkh7DUFJ3rsZy5JSTlIZpdFpJ/BtC95hWXtbdMZxOkGp3X5BoShtOzxPu0hI31LU1AdadDOl4Dm1gEahXeLiJjjbf7+uZumdqkwq3dKpUIRsqXRNRbTIcTwRKSnX6zMuvtvjuzp7/8YVwWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726826421; c=relaxed/simple;
	bh=a7733AkM1jCIkMkpilJ/fKfB+dBlAGaYmimRjOfd16I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Cw9hcv+aokPJCNfMIz4tTMtBV8i/iaGlWy0H1wAanujSYabaXOVgj9vQCu1xlVKPHH5nsunKexivqBOuiLIeyTSZamJYfCqgc4DN6nBqIhGe+d1Hh00DFr7KDGZKjs6Sd15dJjeBRhwXLRBMnKDBDOHmSGz0iJsuoMgJ4Osza54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bSkJfs8c; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vXrTbux/VkZGw6te8I3GXQvIpLAegjtWRZgaR5k/lSc=;
	t=1726826419; x=1728036019; b=bSkJfs8c/uwaXgKp2AX7uahIBg1iAITvco69XjbBgIM9aBN
	aV/afd6po0EY4dWtc7kl3+UixIw2Me1eOWwYUoWu2UhLEija1unXps/omonsir4PUswKxYTxvALbh
	KXvBGRT2f7RMmwtBSUgtG6u88w9bHrvCXutT74oipYkByoLcyFW8Gw0cjcl2BkWnInFWVx97iA4w6
	G3g4XV2Sm6IAYl026LpwDUs7KJ4kOHv08LDFZj77UuzVEbLcdHV2jOprjXdpD82v4hu1yfFOxUvxz
	DoEJuOidSystmcxZGECoNT9v3LYH1bmqS+vzWQpjBJmupyyIKGT+6uUcJLwL7lCw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sraQs-00000006td4-0Hiq;
	Fri, 20 Sep 2024 12:00:10 +0200
Message-ID: <f00e76b9425b10dbfe347f8d107bf6a044e81069.camel@sipsolutions.net>
Subject: Re: Missing wiphy lock in ieee80211_color_collision_detection_work
From: Johannes Berg <johannes@sipsolutions.net>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>, Nicolas
 Escande <nescande@freebox.fr>, linux-wireless@vger.kernel.org
Date: Fri, 20 Sep 2024 12:00:08 +0200
In-Reply-To: <Zu01VbjzUFYYjGJi@pilgrim>
References: <D4A40Q44OAY2.W3SIF6UEPBUN@freebox.fr>
	 <b9d5550c-8ac1-41d7-9abb-caa11f484064@green-communications.fr>
	 <c48876507ec971c9195e468e6037cc251dcf2218.camel@sipsolutions.net>
	 <Zu0yRl4iyfspa8AV@pilgrim> <Zu01VbjzUFYYjGJi@pilgrim>
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

On Fri, 2024-09-20 at 10:41 +0200, Remi Pommarel wrote:
> > > That won't work, it's cancel_delayed_work_sync() under the wiphy mute=
x,
> > > so that'll cause deadlocks (and should cause lockdep complaints about
> > > them.)
> >=20
> > Yes you are right, and AFAIU that is this kind of issue using wiphy wor=
k
> > queue would prevent. With wiphy work queue if wiphy_delayed_work_cancel
> > is called with wiphy lock held, work cannot be running after it returns=
;
> > making it handy to replace cancel_delayed_work_sync() with.

Right, and safe under the lock, since the lock is taken externally to
the actual work function. It either is completed or still on the list,
both cases are handled safely (do nothing and remove, respectively.)

> > So, in my opinion, switching to wiphy work queue seems to be the
> > prefered solution here.

Yes.

> > While there is no wiphy work queue equivalent of delayed_work_pending()=
,

Maybe we should add it?

> > I think using timer_pending(&link->color_collision_detect_work->timer)
> > to replace delayed_work_pending(), even if the semantic is a bit
> > different, would be ok to fulfill the rate limiting purpose.

I think you're right. We could as well check list_empty() or so, but it
wouldn't make a big difference. As you say:

> > Having the
> > same delayed_work_pending() semantics on wiphy work queue would require
> > to take wiphy lock

To really have it known _precisely_, that's true.

> >  which seem a bit superfluous here.

It's actually simply also not possible - if we could sleep in
ieee80211_obss_color_collision_notify() and take the wiphy mutex, we'd
probably have done this completely differently :)

And a hypothetical wiphy_delayed_work_pending() API should therefore not
be required to be called with the wiphy mutex held.

I think that perhaps we should add such a trivial inline instead of
open-coding the timer_pending() check, but I'm not sure whether or not
it should also check the list (i.e. check if timer has expired, but work
hasn't started yet): on the one hand it seems more appropriate, and if
actually holding the wiphy mutex it would in fact be completely correct,
on the other hand maybe it encourages being sloppily thinking the return
value is always perfect?

Right now I'd tend to have the check and document that it's only
guaranteed when under the wiphy mutex.


> Forgot to mention that I am currently running a wiphy work version of
> ieee80211_color_collision_detection_work() using timer_pending() as a
> delayed_work_pending() substitute since a couple of hours and lockdep
> did not complain so far.

:)

johannes

