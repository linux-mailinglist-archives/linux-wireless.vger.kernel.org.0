Return-Path: <linux-wireless+bounces-3342-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB6B84E471
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 16:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73991B232E8
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 15:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6C07C6CF;
	Thu,  8 Feb 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlKCy6o5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6656BFA7
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407757; cv=none; b=Z6m+bvOA64h4qeEQB1JJesNgLk+RVU84nbjZgFmTPem78Q2uF7cm3obD4cWXNoYblowD36c44OpLOvczw5QNCwqrg1RwikIXhCU4h+yNN/cI+iOUrk2PlrY+Bv5TDOb8eBiYCfwkRwIQhzRBCe+Vsh09/2D0b4lRvK2S5/LKeMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407757; c=relaxed/simple;
	bh=k2Pspga8vvvkKgGQS46NRSyUq8KK4BiZsk/7oXLkJOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElW+VsCShnqC1NZeRSzzHZmVdZFg//28jVcgqjpV0v2B+H2yGHlNj5mfX0DOBp2U0ZHP3SqdUbJLz0LuO+DweFaUvm+vrLI0xDUd07UJQl5OFPbuPofKhKhLPY/aZEhXM2Lc6Ne/AlPgM3uLY5ki5hN8P0GBNVV8njNHZgBFWqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlKCy6o5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFBCC433C7;
	Thu,  8 Feb 2024 15:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707407756;
	bh=k2Pspga8vvvkKgGQS46NRSyUq8KK4BiZsk/7oXLkJOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MlKCy6o5wJ6e7YJw6DU1f7+CI5lKK2fhAbdtxw/5Ih6xXJVgIUoUT9Xuhhx9NtuMJ
	 NPpkj3QyL8swygoQ7ydQZ0L3yEVh96x1HFmCXnefJNjUKnU7H7Sds83l3ZkFpDFvWW
	 fgN4rr0LVyqu4e0bRkNX4bdY5G7iHgnLoG9IeHXEfw/oFa0OhWUP9gUe6qv0prZ14k
	 SZPGZwxm0OaTBVe0SiStFpP4W7GrS5Yer1aKdPOgi1ctviuvt3lXeJYeBEIHdX9UuJ
	 PVx0ETSldOZ1Y7PegLq2x4Ku/f6Yq6XI6AmPFb9jxUV3MvbxND7r1A93rJ0LhB4yVV
	 Y1iDziltSyi0Q==
Date: Thu, 8 Feb 2024 16:55:53 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Ben Greear <greearb@candelatech.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mac80211: Ensure bss-coloring is always configured
Message-ID: <ZcT5ibvlnU0ivp5s@lore-desk>
References: <20240130180848.776867-1-greearb@candelatech.com>
 <7c2721f79c1d6c0aa914db4f4d6148c8efce4b85.camel@sipsolutions.net>
 <ZcTzOm5dU9fPfYwC@lore-desk>
 <48e6ced8-b138-36a8-6c8b-b56127952bf9@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CeqolN0Vm+RT5wDe"
Content-Disposition: inline
In-Reply-To: <48e6ced8-b138-36a8-6c8b-b56127952bf9@candelatech.com>


--CeqolN0Vm+RT5wDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 2/8/24 7:28 AM, Lorenzo Bianconi wrote:
> > > On Tue, 2024-01-30 at 10:08 -0800, greearb@candelatech.com wrote:
> > > > From: Ben Greear <greearb@candelatech.com>
> > > >=20
> > > > Old code would not set it to disabled, just assumed that driver
> > > > would default to disabled.  Change this to explicitly request
> > > > bss color be flushed on initial driver configuration.
> > >=20
> > > Arguably, the current behaviour is in line with the documentation of
> > > BSS_CHANGED_HE_BSS_COLOR ... but I would tend to agree that
> > > enabling/disabling coloring should be covered by it as well. Lorenzo?
> > >=20
> > > > And I think the beacon-change logic was slightly wrong, so adjust
> > > > that as well.
> > >=20
> > > That's not a great thing for a commit message to say ...
> > >=20
> > > > Signed-off-by: Ben Greear <greearb@candelatech.com>
> > > > ---
> > > >   net/mac80211/cfg.c | 10 +++++-----
> > > >   1 file changed, 5 insertions(+), 5 deletions(-)
> > > >=20
> > > > diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> > > > index 1c7fb0959cfd..1a6c6c764cbc 100644
> > > > --- a/net/mac80211/cfg.c
> > > > +++ b/net/mac80211/cfg.c
> > > > @@ -1331,8 +1331,7 @@ static int ieee80211_start_ap(struct wiphy *w=
iphy, struct net_device *dev,
> > > >   			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
> > > >   		changed |=3D BSS_CHANGED_HE_OBSS_PD;
> > > > -		if (params->beacon.he_bss_color.enabled)
> > > > -			changed |=3D BSS_CHANGED_HE_BSS_COLOR;
> > > > +		changed |=3D BSS_CHANGED_HE_BSS_COLOR;
> >=20
> > I think we should use beacon->he_bss_color_valid here instead of
> > params->beacon.he_bss_color.enabled, agree?
>=20
> Either way, the value changed from un-set/un-known to some value, so why =
not just
> mark it changed and flush to the driver?

IIUC what you mean here, if bss color changes from an un-set/un-known to a
configured (valid) value, beacon->he_bss_color_valid will be true
(he_bss_color_valid is used to indicate userspace provided a proper color f=
or
beacons). What is the difference?
The other way around ("undo" some leftover color from a previous run), it
seems a driver/fw bug, and it must be fixed there. Don't you think?

Regards,
Lorenzo

>=20
> Thanks,
> Ben
>=20
> >=20
> > > >   	}
> > > >   	if (params->he_cap) {
> > > > @@ -1512,6 +1511,7 @@ static int ieee80211_change_beacon(struct wip=
hy *wiphy, struct net_device *dev,
> > > >   	int err;
> > > >   	struct ieee80211_bss_conf *link_conf;
> > > >   	u64 changed =3D 0;
> > > > +	bool color_en;
> > > >   	lockdep_assert_wiphy(wiphy);
> > > > @@ -1549,9 +1549,9 @@ static int ieee80211_change_beacon(struct wip=
hy *wiphy, struct net_device *dev,
> > > >   		return err;
> > > >   	changed |=3D err;
> > > > -	if (beacon->he_bss_color_valid &&
> > > > -	    beacon->he_bss_color.enabled !=3D link_conf->he_bss_color.ena=
bled) {
> > > > -		link_conf->he_bss_color.enabled =3D beacon->he_bss_color.enabled;
> > > > +	color_en =3D beacon->he_bss_color.enabled && beacon->he_bss_color=
_valid;
> > > > +	if (color_en !=3D link_conf->he_bss_color.enabled) {
> > > > +		link_conf->he_bss_color.enabled =3D color_en;
> > > >   		changed |=3D BSS_CHANGED_HE_BSS_COLOR;
> > > >   	}
> >=20
> > this seems fine to me. >
> > Regards,
> > Lorenzo
> >=20
> > > >=20
> > >=20
> > > Not sure how this isn't updating the color itself, Lorenzo?
> > >=20
> > > johannes
> > >=20
>=20
>=20
> --=20
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com

--CeqolN0Vm+RT5wDe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZcT5iQAKCRA6cBh0uS2t
rBtAAQDS9Ja4f7sD4kFT1T1VSCaPxZUq6qgwaxqKPGL9IC+UJgD+K3f+pYsYn3wZ
KK6F50+Wr6k9BiQ4XcKsZv204uNvHwk=
=OOeI
-----END PGP SIGNATURE-----

--CeqolN0Vm+RT5wDe--

