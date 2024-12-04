Return-Path: <linux-wireless+bounces-15887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8765E9E3BB1
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 14:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 041AEB29360
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 13:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28121BBBEE;
	Wed,  4 Dec 2024 13:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="I9f/1e1k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAD61B4F02;
	Wed,  4 Dec 2024 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733318935; cv=none; b=SAHcqOzuxPP+5KMj4DxSq1FCxUaOQhOok0SrMLKp4l2wkAd+7zU7we9z9GxVsP/EpSGEMDYvWtabqgWRBB4hzsWnRXIjv8/Z8tJ5KInVHX4osHJqvQRDeq7+JQKcpnaULBbVzym4Ik0J8L4C0T6FdkYqNWAowaEwY5giygazZr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733318935; c=relaxed/simple;
	bh=JFMEaqJARTgv5xD0VK6lGzTRXH+hjD5csEE/MmFFaWI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bTwP2dulHNu9Si8ryFo7mBfP7XYUkeFlQYwsgJAL9XIDB2ojN6h8BhSTRBr1fMejKAK4cDi6nWWKusAOoefxk4wHR11L28XQ0JnJ2myYxpkfeL8Zq0JKV8izN7MdEJq9vRjGHaIGj3HsRg/on8SsULmYAixDKCkVpZ/q6Ti3C0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=I9f/1e1k; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=4LmJ93oPNxvI+0AIIhL25FFOu/bFnhYn5Nx8R+9oCn8=;
	t=1733318934; x=1734528534; b=I9f/1e1ksBRPdUDlFXvH/HnDesJrnDMorx7/NduDuwO+HCK
	9yvpJl2anEFA9CZgA0DsemJWXekj5LYFMomlSQ8jFjnAQYMy0nI9yAG1w93HyoQjSFNbdXUdHNhNy
	fYRJYDrc2sFTWaeLVKAGJL2+hrS3kYsfVxQkm728zjl6gA17ihfH/salvqZr6cNZModwHn7KknGdX
	aoUDB3LyS/rWXmPgCfPxWgFsw5vihsvu4r84OUzOuzLVbX6yaJKlGY87jJbR6LsL5FUFiQqC0sNCK
	2pp2otM6p7YRZF2twLMifFxUhjpKXekC1ZHpln3eD3Vu39k5oEYDRIbE1dZqjrhw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tIpQp-00000006UlJ-0HWQ;
	Wed, 04 Dec 2024 14:28:43 +0100
Message-ID: <cc0a13f9674238d3b7607e9d9b58ee6e5cc4aa5c.camel@sipsolutions.net>
Subject: Re: [PATCH net-next v1 7/7] netlink: specs: wireless: add a spec
 for nl80211
From: Johannes Berg <johannes@sipsolutions.net>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 linux-wireless@vger.kernel.org, donald.hunter@redhat.com
Date: Wed, 04 Dec 2024 14:28:42 +0100
In-Reply-To: <CAD4GDZyCPiw1r02BHA_atDQdhsyVhxg=W1dnwi-Bc_tnkxtVeA@mail.gmail.com>
References: <20241203130655.45293-1-donald.hunter@gmail.com>
	 <20241203130655.45293-8-donald.hunter@gmail.com>
	 <016ba49a8b072f89fc4340341be166e26cc1b9a8.camel@sipsolutions.net>
	 <CAD4GDZyCPiw1r02BHA_atDQdhsyVhxg=W1dnwi-Bc_tnkxtVeA@mail.gmail.com>
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

On Wed, 2024-12-04 at 13:12 +0000, Donald Hunter wrote:
> My main motivation is coverage, for 2 reasons: firstly to flush out
> any feature gaps in YNL such as the ones I fixed in this series

Yeah, OK, though I'm not sure YNL is really meant to be feature complete
for everything netlink may be doing, rather than for what's needed - and
some of the things we did may even be things that are not meant to be
done any more (e.g. nested array vs. multi-attr arrays.)

> and
> secondly to achieve a critical mass of YNL specs that encourages
> people to build more tooling around the specs.

OK, fair :)

> YNL is already used for
> in-tree test automation and documentation generation. There is
> potential for generating strace dumpers and people are starting to use
> generated user space code.

Right.

> > Also, I don't know how we will maintain this if it's not tied to any
> > kernel code. What do you suggest? Do you want to just maintain it
> > following the nl80211.h spec all the time?
>=20
> It's a good question. I am okay with maintaining it alongside the
> nl80211.h file, which will likely motivate me to write some automation
> at least for notifying any divergence. There might come a time when it
> becomes desirable to generate some of nl80211.h from the spec, as
> Stanislav Fomichev is doing for ethtool here:
>=20
> https://lore.kernel.org/netdev/20241202162936.3778016-1-sdf@fomichev.me/

I think I wouldn't mind that - I'm hoping it'll also generate policies
etc.? Though on that front we probably have weird quirks too ...

But until then I guess someone's going to have to maintain it, and I'm
not sure I want that to be me right now :)

> > > +      name: get-wiphy
> > > +      doc: Get information about a wiphy or dump a list of all wiphy=
s
> > > +      attribute-set: nl80211-attrs
> > > +      do:
> > > +        request:
> > > +          value: 1
> > > +          attributes:
> > > +            - wiphy
> > > +        reply:
> > > +          value: 3
> > > +      dump:
> > > +        request:
> > > +          attributes:
> > > +            - wiphy
> > >=20
> >=20
> > This already seems wrong - dump wiphy really should unconditionally
> > include NL80211_ATTR_SPLIT_WIPHY_DUMP these days.
>=20
> Yes, the valid parameter attributes should be wiphy, wdev, ifindex and
> split-wiphy-dump by the look of it.

Well there's that about valid parameters, but also no (new) tools today
should ever *not* include the split-wiphy-dump attribute. I guess that
can't be expressed here, but it's a gotcha for implementers that just
follow the YNL spec?

johannes

