Return-Path: <linux-wireless+bounces-3345-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 045A884E55E
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 17:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808301F219FA
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 16:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7FD7EF14;
	Thu,  8 Feb 2024 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6zUh089"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683417C6EF
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410677; cv=none; b=Htt/Y+gilBdpCryyMkPw54Yx1neErZYV8p+9dPjcd6FToqPNjGICM2UKSEusRtRBdtCni4N8w4L2ndlbaMryK7zkjdz7WnUZrYOU6gLkHEuSMcaOucaGu9lGi92bQFivj+jIUmuVKcQ8ZCKf3XXiF2nAsOgqrufHkeX5Zsh2fbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410677; c=relaxed/simple;
	bh=SxnCYQkA4f2t+MDqgtYdC2kh5Ve1qNkIdKaNPHYC6Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgjnxwsbR2CbFAgVtJRDHyxKAZ2keAB897JL+A+/LaG7/KcVETE05tK2IS+g0HxeR/3cQ/1+vZxPK+/8NyR2vJBUVi+jvpVZvUuhs3FE9GTVYbi5zmhF6HnvD9hepIcwERySvA+pjyybHeZkLw26wqXQhG14dA70H8OpWqmvfhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6zUh089; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4555C433C7;
	Thu,  8 Feb 2024 16:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707410677;
	bh=SxnCYQkA4f2t+MDqgtYdC2kh5Ve1qNkIdKaNPHYC6Ew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o6zUh0898EDSd/THWS18PblKdyhtR4yp6nt6ic+n44DKPFj3s1XNokKz2NHGQuEld
	 oGh3mRkqCS5qw7DdnZYSL9FRqU3P2wcelzS5+yM/dLQa3DYsIRwg0gxqWcuaQC2GEF
	 sfpw5jHu6RJJJvYIyAb/WVHPN63uhbB3GkfcgPCwTQkQu48TeUrEkEesfeopYxRSt8
	 oIfbUBnrwOs6QQdy5FXaOCaQPk7+EKBvrgO9UyW9j8j2+gHEaERTTTx6ad3juEeXWi
	 bGYKkqhItyjxfXdoSrWS9PWugzqBvEo9Vg8+XynCTSGjU/tXYkgJQGcJGISEdm7H0e
	 rgeNv8WESH83Q==
Date: Thu, 8 Feb 2024 17:44:33 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Ben Greear <greearb@candelatech.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mac80211: Ensure bss-coloring is always configured
Message-ID: <ZcUE8VU3Nu7vBr3b@lore-desk>
References: <20240130180848.776867-1-greearb@candelatech.com>
 <7c2721f79c1d6c0aa914db4f4d6148c8efce4b85.camel@sipsolutions.net>
 <ZcTzOm5dU9fPfYwC@lore-desk>
 <48e6ced8-b138-36a8-6c8b-b56127952bf9@candelatech.com>
 <ZcT5ibvlnU0ivp5s@lore-desk>
 <93a4c2ef-bc8f-0d68-477e-bb88afa37583@candelatech.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qt59ZqEpXlHT2eOl"
Content-Disposition: inline
In-Reply-To: <93a4c2ef-bc8f-0d68-477e-bb88afa37583@candelatech.com>


--qt59ZqEpXlHT2eOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On 2/8/24 07:55, Lorenzo Bianconi wrote:
> > > On 2/8/24 7:28 AM, Lorenzo Bianconi wrote:
> > > > > On Tue, 2024-01-30 at 10:08 -0800, greearb@candelatech.com wrote:
> > > > > > From: Ben Greear <greearb@candelatech.com>
> > > > > >=20
> > > > > > Old code would not set it to disabled, just assumed that driver
> > > > > > would default to disabled.  Change this to explicitly request
> > > > > > bss color be flushed on initial driver configuration.
> > > > >=20
> > > > > Arguably, the current behaviour is in line with the documentation=
 of
> > > > > BSS_CHANGED_HE_BSS_COLOR ... but I would tend to agree that
> > > > > enabling/disabling coloring should be covered by it as well. Lore=
nzo?
> > > > >=20
> > > > > > And I think the beacon-change logic was slightly wrong, so adju=
st
> > > > > > that as well.
> > > > >=20
> > > > > That's not a great thing for a commit message to say ...
> > > > >=20
> > > > > > Signed-off-by: Ben Greear <greearb@candelatech.com>
> > > > > > ---
> > > > > >    net/mac80211/cfg.c | 10 +++++-----
> > > > > >    1 file changed, 5 insertions(+), 5 deletions(-)
> > > > > >=20
> > > > > > diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> > > > > > index 1c7fb0959cfd..1a6c6c764cbc 100644
> > > > > > --- a/net/mac80211/cfg.c
> > > > > > +++ b/net/mac80211/cfg.c
> > > > > > @@ -1331,8 +1331,7 @@ static int ieee80211_start_ap(struct wiph=
y *wiphy, struct net_device *dev,
> > > > > >    			      IEEE80211_HE_OPERATION_RTS_THRESHOLD_MASK);
> > > > > >    		changed |=3D BSS_CHANGED_HE_OBSS_PD;
> > > > > > -		if (params->beacon.he_bss_color.enabled)
> > > > > > -			changed |=3D BSS_CHANGED_HE_BSS_COLOR;
> > > > > > +		changed |=3D BSS_CHANGED_HE_BSS_COLOR;
> > > >=20
> > > > I think we should use beacon->he_bss_color_valid here instead of
> > > > params->beacon.he_bss_color.enabled, agree?
> > >=20
> > > Either way, the value changed from un-set/un-known to some value, so =
why not just
> > > mark it changed and flush to the driver?
> >=20
> > IIUC what you mean here, if bss color changes from an un-set/un-known t=
o a
> > configured (valid) value, beacon->he_bss_color_valid will be true
> > (he_bss_color_valid is used to indicate userspace provided a proper col=
or for
> > beacons). What is the difference?
> > The other way around ("undo" some leftover color from a previous run), =
it
> > seems a driver/fw bug, and it must be fixed there. Don't you think?
>=20
> Well, no.  I think the stack should set to known state, thus my original
> patch to do so.
>=20
> But, not worth arguing about as it seems to have no functional difference
> at this point.

I think the second part is fine and should be applied.

Regards,
Lorenzo

>=20
> Thanks,
> Ben
>=20
> >=20
> > Regards,
> > Lorenzo
> >=20
> > >=20
> > > Thanks,
> > > Ben
> > >=20
> > > >=20
> > > > > >    	}
> > > > > >    	if (params->he_cap) {
> > > > > > @@ -1512,6 +1511,7 @@ static int ieee80211_change_beacon(struct=
 wiphy *wiphy, struct net_device *dev,
> > > > > >    	int err;
> > > > > >    	struct ieee80211_bss_conf *link_conf;
> > > > > >    	u64 changed =3D 0;
> > > > > > +	bool color_en;
> > > > > >    	lockdep_assert_wiphy(wiphy);
> > > > > > @@ -1549,9 +1549,9 @@ static int ieee80211_change_beacon(struct=
 wiphy *wiphy, struct net_device *dev,
> > > > > >    		return err;
> > > > > >    	changed |=3D err;
> > > > > > -	if (beacon->he_bss_color_valid &&
> > > > > > -	    beacon->he_bss_color.enabled !=3D link_conf->he_bss_color=
=2Eenabled) {
> > > > > > -		link_conf->he_bss_color.enabled =3D beacon->he_bss_color.ena=
bled;
> > > > > > +	color_en =3D beacon->he_bss_color.enabled && beacon->he_bss_c=
olor_valid;
> > > > > > +	if (color_en !=3D link_conf->he_bss_color.enabled) {
> > > > > > +		link_conf->he_bss_color.enabled =3D color_en;
> > > > > >    		changed |=3D BSS_CHANGED_HE_BSS_COLOR;
> > > > > >    	}
> > > >=20
> > > > this seems fine to me. >
> > > > Regards,
> > > > Lorenzo
> > > >=20
> > > > > >=20
> > > > >=20
> > > > > Not sure how this isn't updating the color itself, Lorenzo?
> > > > >=20
> > > > > johannes
> > > > >=20
> > >=20
> > >=20
> > > --=20
> > > Ben Greear <greearb@candelatech.com>
> > > Candela Technologies Inc  http://www.candelatech.com
>=20
> --=20
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>=20
>=20

--qt59ZqEpXlHT2eOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZcUE8QAKCRA6cBh0uS2t
rB7HAQDmY/XngIbf6cl9JLJTEURrjd8z7/0+vrBGyluouRoILAEA+KJ9R9h3uPlN
A5U5bg/XIqXe+MhhVp1RfbIHLrClNwM=
=bYXg
-----END PGP SIGNATURE-----

--qt59ZqEpXlHT2eOl--

