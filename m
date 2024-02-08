Return-Path: <linux-wireless+bounces-3340-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC5D84E40F
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 16:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E201F2101A
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 15:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A567B3F7;
	Thu,  8 Feb 2024 15:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctFW40L0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B97C7B3F3
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707406143; cv=none; b=CgrLP3V3kaFk6onB3Vf1zIt6pKb/ZDiKNwwT1ylbfIMlKiboQWPnB7WmgfjnvJZNGo2jfN0fdUF/v6/D0dU1BLpa49Ersh9o/cHhZ7AXII4CrK4t6aoA8fSq/IJQud0oTVYk9nmL5baAzNHmH0yszaNU1qf+n+xtSI3bpmOYFKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707406143; c=relaxed/simple;
	bh=tpzl+hJJlNhccTlxTUPmcnjx6HipiSiotA5yYcSI0HI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGYsf5QPvezKDRAlgUb2YP+dAXwnPsCSMLq6My8/+iN75CgnGFpLkaLaVskDdhNtNMVxIsnsexFMNemxHk7RDqHmKGeIkUzH13qi2ph5Ryp8bJjv4SYvVI7GOU3/uoJ5xhmvFGNqjw0X2Ukr4PFyGTHNW+emksd3EtaTWwHvb+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctFW40L0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3286CC433C7;
	Thu,  8 Feb 2024 15:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707406142;
	bh=tpzl+hJJlNhccTlxTUPmcnjx6HipiSiotA5yYcSI0HI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ctFW40L09mgGtRZEx8MwdnelB+M8htRdBHiHdMRZdXnu2nGi2xClrx1nZ1NCqBMj0
	 hSYjsH3D0u/suZJojGI+n9D3CFVfunvphKlM5tIFfsMGLhYmYDeE1dDnduzl5my/+D
	 gQ+/hcB6wphkqaZzBdKA2NvW8hGTwOpVWRmb8kNqgJhWTDpoOgVIdidF9oQQXiSItl
	 WbgksMwmvjJNoeI4GiGsmMXUQW9IrRYU99gQL8VvYFSwu998EaCGaamxyNik268Pdg
	 XHGd5KJgx+t51nNsYULHpdr9fmP5RY9eFUqhbFfbNyagX/CtTnglRCRo7X1BzEDDYq
	 kU93FrTR/B9Og==
Date: Thu, 8 Feb 2024 16:28:58 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: greearb@candelatech.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mac80211:  Ensure bss-coloring is always configured
Message-ID: <ZcTzOm5dU9fPfYwC@lore-desk>
References: <20240130180848.776867-1-greearb@candelatech.com>
 <7c2721f79c1d6c0aa914db4f4d6148c8efce4b85.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tHJlMJTTjpw18MCN"
Content-Disposition: inline
In-Reply-To: <7c2721f79c1d6c0aa914db4f4d6148c8efce4b85.camel@sipsolutions.net>


--tHJlMJTTjpw18MCN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Tue, 2024-01-30 at 10:08 -0800, greearb@candelatech.com wrote:
> > From: Ben Greear <greearb@candelatech.com>
> >=20
> > Old code would not set it to disabled, just assumed that driver
> > would default to disabled.  Change this to explicitly request
> > bss color be flushed on initial driver configuration.
>=20
> Arguably, the current behaviour is in line with the documentation of
> BSS_CHANGED_HE_BSS_COLOR ... but I would tend to agree that
> enabling/disabling coloring should be covered by it as well. Lorenzo?
>=20
> > And I think the beacon-change logic was slightly wrong, so adjust
> > that as well.
>=20
> That's not a great thing for a commit message to say ...
>=20
> > Signed-off-by: Ben Greear <greearb@candelatech.com>
> > ---
> >  net/mac80211/cfg.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> > index 1c7fb0959cfd..1a6c6c764cbc 100644
> > --- a/net/mac80211/cfg.c
> > +++ b/net/mac80211/cfg.c
> > @@ -1331,8 +1331,7 @@ static int ieee80211_start_ap(struct wiphy *wiphy=
, struct net_device *dev,
> >  			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
> >  		changed |=3D BSS_CHANGED_HE_OBSS_PD;
> > =20
> > -		if (params->beacon.he_bss_color.enabled)
> > -			changed |=3D BSS_CHANGED_HE_BSS_COLOR;
> > +		changed |=3D BSS_CHANGED_HE_BSS_COLOR;

I think we should use beacon->he_bss_color_valid here instead of
params->beacon.he_bss_color.enabled, agree?

> >  	}
> > =20
> >  	if (params->he_cap) {
> > @@ -1512,6 +1511,7 @@ static int ieee80211_change_beacon(struct wiphy *=
wiphy, struct net_device *dev,
> >  	int err;
> >  	struct ieee80211_bss_conf *link_conf;
> >  	u64 changed =3D 0;
> > +	bool color_en;
> > =20
> >  	lockdep_assert_wiphy(wiphy);
> > =20
> > @@ -1549,9 +1549,9 @@ static int ieee80211_change_beacon(struct wiphy *=
wiphy, struct net_device *dev,
> >  		return err;
> >  	changed |=3D err;
> > =20
> > -	if (beacon->he_bss_color_valid &&
> > -	    beacon->he_bss_color.enabled !=3D link_conf->he_bss_color.enabled=
) {
> > -		link_conf->he_bss_color.enabled =3D beacon->he_bss_color.enabled;
> > +	color_en =3D beacon->he_bss_color.enabled && beacon->he_bss_color_val=
id;
> > +	if (color_en !=3D link_conf->he_bss_color.enabled) {
> > +		link_conf->he_bss_color.enabled =3D color_en;
> >  		changed |=3D BSS_CHANGED_HE_BSS_COLOR;
> >  	}

this seems fine to me.

Regards,
Lorenzo

> >=20
>=20
> Not sure how this isn't updating the color itself, Lorenzo?
>=20
> johannes
>=20

--tHJlMJTTjpw18MCN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZcTzOgAKCRA6cBh0uS2t
rLjwAP9XBppQXcumtFn6wYnPmAtxfQXKqD1CWIlHUUb3il+K+wD/XI4JGWzZhg5O
NePTC9lpXh7/Uahjgokq1UJ/WLDkqQI=
=WT5l
-----END PGP SIGNATURE-----

--tHJlMJTTjpw18MCN--

