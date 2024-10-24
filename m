Return-Path: <linux-wireless+bounces-14476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2BF9AEA7B
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 17:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A101284BE0
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 15:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0421EC011;
	Thu, 24 Oct 2024 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="JkmA6aU+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A4C1D8A1E;
	Thu, 24 Oct 2024 15:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783795; cv=none; b=HN0SmW8ySDqZ/1Okepi/piO7i5MtES5AJr+/OceF+BWVlvtu9dQyqzrNXfwZcmZqBkPbz/adSvECad8FfryCjA/TR+9HsEM7yP+7+EZoUv/Xb+Cz+W+l4+LzL/UPkfw67uowzwwpOoyCfKW3+Nk0K6+j/pfiHMi2KSFPj6q0tXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783795; c=relaxed/simple;
	bh=/c3nPV0FlFBZC3KSq4T9BU0smS+lIYhUyC2Quk6Z91M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c2MkxT0WY4LQYSmlsbrF50tuxeFEp+Pj4Zqb5skk3WpBZ654ZLzIzy9U5snNEfswYXdW6knrrJiBo2PMjusZLURLcFVh1vKUdWUjH91gSf6sdazqk8GlRYfa9lHotZbQmKn4mWnnD9cQpXC7msacel5cH7icwVm8qx2nKniQ2OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=JkmA6aU+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1xiupaF61lfS6z4Pq8dSc4R0ENSuX2KdNUITbPAYRRM=;
	t=1729783793; x=1730993393; b=JkmA6aU+xDkflpCKFxNi+2p7k5hXG8/0udrO6D/wvzk0bAk
	okL6v/nw4fUrixwEDCvsL1Olt1a9e5kwVa+tZp/Oj7HiSJosZvG6S9ZWXYyI8xrrFjWKTBaynmqsx
	y2sQCmLqTWOzWtpDZkoTSIO1uh2K1QlVqaKG6i5ozJKHUorIALc7m/kzpwFMOSQ73YHJdbljLNZGu
	01DOOyA5y/QN3ikSFOY4kYWOCVC/DzDJvdm3fJdNiJsiybpzYssrgC0mbp66tQnNJLWysD1Hruag8
	GZjD4sWjnl/AF5mPSBKvIT5KlWXi5Onacih5DkV7EMA923M1bOWmRzJrSAcQovxQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t3zmT-00000003hnS-2GLn;
	Thu, 24 Oct 2024 17:29:45 +0200
Message-ID: <4c9b5027a70f7d9039ffb5579a1e7a08c7fa5ddb.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 2/2] net: convert to nla_get_*_default()
From: Johannes Berg <johannes@sipsolutions.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Date: Thu, 24 Oct 2024 17:29:44 +0200
In-Reply-To: <ZxplEne_oHXQycnc@hog>
References: 
	<20241024131807.0a6c07355832.I3df6aac71d38a5baa1c0a03d0c7e82d4395c030e@changeid>
	 <20241024131807.d5b9f6e57ede.I740beeaa2f70ebfc19bfca1045a24d6151992790@changeid>
	 <8fabb6e5a2eda8c3bd7ca0bccc3e7804ad27bbad.camel@sipsolutions.net>
	 <ZxpeL7S2GZeJOiQw@hog>
	 <2e3b106585cebbb579c0d5cca33737623765ded7.camel@sipsolutions.net>
	 <ZxplEne_oHXQycnc@hog>
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

On Thu, 2024-10-24 at 17:17 +0200, Sabrina Dubroca wrote:
> 2024-10-24, 16:52:00 +0200, Johannes Berg wrote:
> > On Thu, 2024-10-24 at 16:48 +0200, Sabrina Dubroca wrote:
> > >=20
> > > If nla_get_*_default was a macro (generating an "attr ? getter :
> > > default" expression) you wouldn't have that problem I think,=C2=A0
> >=20
> > Hmm. Perhaps. In the conditional operator (?:) they're subject to
> > integer promotion though
>=20
> Is it?
>=20
>     #define nla_get_u16_default(attr, d) (attr ? nla_get_u16(attr) : d)
>     int v =3D nla_get_u16_default(NULL, -1);
>=20
> seems to put the correct value into v.
> (but -ENOFOOD and -ELOWCOFFEE here, so I don't trust this quick test
> much :))

I'm probably -ELOWBLOODSUGAR right now ;-)

But yeah, I couldn't yet construct a scenario where it mattered, but I'
also couldn't convince myself that there isn't one. Maybe too much
inspired by the enum compare warnings:

https://lore.kernel.org/linux-wireless/20241018151841.3821671-1-arnd@kernel=
.org/


> > , I wonder if that could cause some subtle issue
> > too especially if nla_get_u*() is used with signed variables?
>=20
> The issue in that example is pretty subtle and I'm fairly sure people
> are going to mess up :/

I didn't think it was that bad, but it's well possible that my
calibration for "subtle" is way off ;-)

> But I'm not attached to that macro I just suggested, it's just a
> thought.

Sure.

> > > but you
> > > couldn't nicely generate all the helpers with MAKE_NLA_GET_DEFAULT
> > > anymore.
> >=20
> > Right, that too.
> >=20
> > I think it's probably better to just review them, and only commit the
> > obvious ones originally?
>=20
> Well, this one looked reasonable too. I'm not convinced reviewers are
> going to catch those problems. Or authors of new code using those
> _default helpers from the start.

Fair point. I didn't think it was that bad, in fact there were some I
was far less sure about, say

> +	request->page =3D nla_get_u8_default(info->attrs[NL802154_ATTR_PAGE],
> +					   wpan_phy->current_page);

which really depends on the types of 'page' and 'current_page'...


I think for most cases it's probably still worth doing, and I wouldn't
be _too_ concerned about the type issues here, most places are just
using zero or a small constant as the default anyway.

Even nla_get_XX_or_zero() would be a win, but that seemed too special
...

johannes

