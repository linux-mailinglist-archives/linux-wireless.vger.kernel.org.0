Return-Path: <linux-wireless+bounces-5365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E07788E88D
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 16:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910261F3357F
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Mar 2024 15:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4551465A3;
	Wed, 27 Mar 2024 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Xv8hUgYJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242EA12F36C
	for <linux-wireless@vger.kernel.org>; Wed, 27 Mar 2024 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552041; cv=none; b=KmuHyOrjCqA9Qefegg+W7daAHq7eCXEVVmkltUJ9jUxnaNMdje76hRammSClYejnfYpRGeTObZ9eh4UvbDvEE03knIhBW4zVAXJ/SHBCwlbyVJ4fAcSS2ooqVoEa/a5ZjBTqLQfawOYonRgFioZjQzfN0T2PeA6Lw+Wm2+EPOOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552041; c=relaxed/simple;
	bh=mzk+bgPSkQUzL/vnXJBmrg/umyndJWoEggObcfG9yAE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KhKwZ8Hs6JHhsHG5DS3tu0o9dEEP2yPC28l3HbrcFxneSPsWk4q4ue6VkgrOAtNjsZaVeKK4wqEPvg7ZdnnkOFjRRJr3KTEZRKVIk77u045gn4DGpj2xBrSY7T2qkT3sk/7Jgky1aYvwtE4K9nCgIGEZT3ucYPsVkYPWDdLJ7io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Xv8hUgYJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=mzk+bgPSkQUzL/vnXJBmrg/umyndJWoEggObcfG9yAE=;
	t=1711552039; x=1712761639; b=Xv8hUgYJu6xv70b5vHEiLDkMoUCB0LD8/Y4yIvE0EMo/o0n
	l//qs2pztVxQ1Z81ZudEgoj/xQBz/jI7ILl+IumIYA1+Rwn0evQDQwGQJS431Q/lGG5CHzNCSn8Op
	ZxasN0KReqVcTodxpYLLSblp5oyJuAsOq1nob4gs8FLsq3KOp4qfNZ7k8nGfDRUcTYp4PBgXs6cMV
	V0RuiY5dFfKHFwh5/XPmAemVNfiQugCq9amU3V6o9QC9lSM3UIdwIhKGebCXZmfIDheW5VdHmUQFG
	pRddKATeMr8HLgmNLIh3WeNcphvzBrLGJ08y0Lyb9FTMyc3XRNXpy9n/l91Od4ew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rpUru-0000000HAgP-26MD;
	Wed, 27 Mar 2024 16:07:10 +0100
Message-ID: <f5cb9edcea875920e0ce156be76d06c78d1279ec.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] wifi: cfg80211/mac80211: Add support to rx retry
 stats
From: Johannes Berg <johannes@sipsolutions.net>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Hari Chandrakanthan
	 <quic_haric@quicinc.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Date: Wed, 27 Mar 2024 16:07:09 +0100
In-Reply-To: <68c6fcbd-0aaa-43b2-b5e2-08367c11e79d@quicinc.com>
References: <20240319134522.4021062-1-quic_haric@quicinc.com>
	 <20240319134522.4021062-2-quic_haric@quicinc.com>
	 <d364e872eb29f03236630bab49a3243e2118ab22.camel@sipsolutions.net>
	 <14699537-99b2-e468-6a7b-7b721193400e@quicinc.com>
	 <b9dfab64822bacf0cc72380c0de034b79d489668.camel@sipsolutions.net>
	 <68c6fcbd-0aaa-43b2-b5e2-08367c11e79d@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-03-27 at 08:02 -0700, Jeff Johnson wrote:
> > I'm also imagining that we change the API from cfg80211 to the drivers
> > to get the *link* STA information, and do the summing up and/or "best"
> > selection there in cfg80211 itself. However, I am prepared to accept th=
e
> > possibility that we may do _both_ in the API, if not all drivers can
> > even do all of the statistics per link. We should probably still have
> > the link STAs in the statistics in nl80211, but then they may not be
> > populated?
>=20
> First remember that there are a lot of statistics, and each driver is fre=
e to
> return as many or as few as they support, indicating the ones they are
> returning using the "filled" bitmap.=C2=A0

Yes, I'd think we want to use the same data structure for both, though
setting something in *both* links and *mld* would (should) be an error.

> I would expect MLO-capable drivers to
> provide the same information on a per-link basis that they previously pro=
vided
> on a per-interface basis, but the "filled" bitmap leaves that to the driv=
ers.

Unless we don't actually ask the drivers at the MLD level if (the
station is an MLD). But I suspect we will have to do both, ask for MLD-
level stats and link-level stats.

> But I think a fundamental question needs to be answered: To what extent d=
o we
> need to support legacy userspace applications that are not MLO-aware?

I have no idea who even uses this and how :-) But I guess things like
NetworkManager might, even just to show some signal strength values
etc.?

> My expectation is that MLO-aware applications only need the per-link
> information, and from that they can derive their own "aggregate" of the
> per-link information.

Agree, though it'll be a long time until all applications are MLO-aware?
Unless there aren't many using it, but ...

> So to support that we'd need per-link nesting of the
> associated attributes.

Sure, that's a given.

> And if we don't need to support legacy userspace we
> could completely remove populating the top-level statistic attributes. No=
n-MLO
> interfaces would have a single link nest that contains the same informati=
on
> that is now in the top-level of the NL message.
>=20
> But if we need to support legacy userspace then we would indeed need to
> continue to populate those top-level attributes with some form of aggrega=
te data.

I think we probably have to.

> And even for the MLO-aware case there is the issue of how do we want to h=
andle
> the case that links may come and go, and hence aggregate counters would a=
ppear
> to have huge fluctuations in values when links are added or removed if th=
e
> aggregate values are only calculated by adding the values from the
> currently-attached links.

Good point, when they're really removed we'd want to probably keep that
value as a bias for the MLD-level stats?

johannes

