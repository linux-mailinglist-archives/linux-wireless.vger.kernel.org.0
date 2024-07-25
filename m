Return-Path: <linux-wireless+bounces-10519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DDD93C6DF
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 17:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96ECF283E1E
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 15:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BC519D895;
	Thu, 25 Jul 2024 15:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pp9zgOTY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA0F19CCE6;
	Thu, 25 Jul 2024 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721923030; cv=none; b=s1Or3xv53+Lc7xQDEAlAX67ns3CZO/Xe8x7xrPcO/gooyFEBzT3rTvcI2NLR8dp2EVYXX40l0Pd6R81EYHl9FwriOjwiUgQemK1NtoACOAOyuQjYaXclXExCzrfQ2mZ4AtX7Kg2TVLwmuTYqr61AnfXjJ7FZJTYmKVAYRKqaBZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721923030; c=relaxed/simple;
	bh=DEjWokAS1tF5Gx7dsEKPyZPuVua+VuisEbemaZcECas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/VZTdvr7VL2Hyd2RCDdgFMAJS1PkaedoAJ6b8ySI9uG6B78LK3FrQNnP0jOBkAJKpAYIqtcfGJi2KZFZ9UoO2XC0/Bh4thVtGEl083WSIsaZg27hJzC9HZox9y6z7dL2BnGvpUs6rEGUhX7lIya33lvdgmVgFTNzUX6+Ic3F6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pp9zgOTY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C28C32782;
	Thu, 25 Jul 2024 15:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721923029;
	bh=DEjWokAS1tF5Gx7dsEKPyZPuVua+VuisEbemaZcECas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pp9zgOTYSywWUhhBdavHvd7mek3umvIJNYtDbPfuLvH/5kbi+fsFvzCOKRrLiT87A
	 NE8Kd9GkiMJ3hrJa3dLiEFpTCmKpdp7yiqDsS9qYBuGn+vHrswFS/bd00Bro0U2Li0
	 VV2P/CgpI2tZ4yOJMfdeYn+hfD5Myon1oF1j2IF51/ygM1K/cMqOsMAiTMS1+BFEOZ
	 pwDDRF0V6EhRMKL3YDEH63cDh/h4JsjfdldOafknuGQbl9NHBOfuo31gOuiVPFNZNQ
	 x3N76k6L6Uq99hd4D5otWuZClgWFT1IL5dd3Ll1wjwVH9oIYtWVdJcn9wB4ZLfpM3f
	 5fQuywi/Cqe3w==
Date: Thu, 25 Jul 2024 17:57:05 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: ZeroBeat <ZeroBeat@gmx.de>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Linux regressions mailing list <regressions@lists.linux.dev>,
	Felix Fietkau <nbd@nbd.name>, Ryder Lee <ryder.lee@mediatek.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>
Subject: Re: [regression] mt76x2u: NULL pointer dereference since recent
 change to fix chanctx emulation for monitor mode
Message-ID: <ZqJ10ZKHPGM6LbsM@lore-desk>
References: <8c91352f-a404-4ba6-aa27-1253468c830d@leemhuis.info>
 <c4a67a0418e7068fc534f39f3c1dce21d082dd8f.camel@sipsolutions.net>
 <231c6ea5-b8a3-4500-b994-46a45b6ab515@gmx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RpOihqr+zsT1aoD+"
Content-Disposition: inline
In-Reply-To: <231c6ea5-b8a3-4500-b994-46a45b6ab515@gmx.de>


--RpOihqr+zsT1aoD+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Just to mention it here. The regression has now reached the longterm kern=
el:
> affected devices: mt76 series (not affected mt7601u)
>=20
>=20
> before update:
> $ uname -r
> 6.6.40-2-lts
>=20
> $ sudo hcxdumptool -i wlp5s0f4u2 --rcascan=3Dactive
> ^C
> 38 Packet(s) captured by kernel
> 0 Packet(s) dropped by kernel
> 14 PROBERESPONSE(s) captured
>=20
> exit on sigterm
>=20
>=20
>=20
> after update:
> $ uname -r
> 6.6.41-1-lts
>=20
> $ sudo hcxdumptool -i wlp48s0f4u2u1 --rcascan=3Dactive
> ^C
> 0 Packet(s) captured by kernel
> 0 Packet(s) dropped by kernel
> Warning: too less packets received (monitor mode may not work as expected)
> Possible reasons:
>  no transmitter in range
>  frames are filtered out by BPF
>  driver is broken
> Warning: no PROBERESPONSES received (frame injection may not work as expe=
cted)
> Possible reasons:
>  no AP in range
>  frames are filtered out by BPF
>  driver is broken
>  driver does not support frame injection
>=20
> exit on sigterm
>=20
>=20
> Best regards
> Mike

Hi,

I am looking into it. I will get back to you.

Regards,
Lorenzo

>=20
>=20
>=20
>=20
>=20
>=20
> Am 24.07.24 um 10:47 schrieb Johannes Berg:
> > On Wed, 2024-07-24 at 09:58 +0200, Linux regression tracking (Thorsten
> > Leemhuis) wrote:
> > > Hi, Thorsten here, the Linux kernel's regression tracker.
> > >=20
> > > Johannes, Felix, Lorenzo, Ryder, I noticed a report about a regression
> > > in bugzilla.kernel.org that (for my untrained eyes) appears to be a b=
ug
> > > in some code paths of mt76x2u that was exposed by 0d9c2beed116e6 ("wi=
fi:
> > > mac80211: fix monitor channel with chanctx emulation") [v6.10-rc5,
> > > v6.9.7] from Johannes.
> > >=20
> > > As many (most?) kernel developers don't keep an eye on the bug tracke=
r,
> > > I decided to write this mail. To quote from
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D219086 :
> > >=20
> > > >   Michael 2024-07-23 15:38:43 UTC
> > > >=20
> > > > After a user opened this discussion:
> > > > https://github.com/ZerBea/hcxdumptool/discussions/465
> > > >=20
> > > > Jul 21 05:40:39 rpi4b-aarch kernel: mt76x2u 2-2:1.0 wlan1: entered =
promiscuous mode
> > > > Jul 21 05:40:45 rpi4b-aarch kernel: Unable to handle kernel NULL po=
inter dereference at virtual address 0000000000000000
> > > > Jul 21 05:40:45 rpi4b-aarch kernel: Mem abort info:
> > > > Jul 21 05:40:45 rpi4b-aarch kernel:   ESR =3D 0x0000000096000044
> > > > Jul 21 05:40:45 rpi4b-aarch kernel:   EC =3D 0x25: DABT (current EL=
), IL =3D 32 bits
> > > > Jul 21 05:40:45 rpi4b-aarch kernel:   SET =3D 0, FnV =3D 0
> > > > Jul 21 05:40:45 rpi4b-aarch kernel:   EA =3D 0, S1PTW =3D 0
> > > > Jul 21 05:40:45 rpi4b-aarch kernel:   FSC =3D 0x04: level 0 transla=
tion fault
> > > > Jul 21 05:40:45 rpi4b-aarch kernel: Data abort info:
> > > > Jul 21 05:40:45 rpi4b-aarch kernel:   ISV =3D 0, ISS =3D 0x00000044=
, ISS2 =3D 0x00000000
> > > > Jul 21 05:40:45 rpi4b-aarch kernel:   CM =3D 0, WnR =3D 1, TnD =3D =
0, TagAccess =3D 0
> > > > Jul 21 05:40:45 rpi4b-aarch kernel:   GCS =3D 0, Overlay =3D 0, Dir=
tyBit =3D 0, Xs =3D 0
> > > > Jul 21 05:40:45 rpi4b-aarch kernel: user pgtable: 4k pages, 48-bit =
VAs, pgdp=3D0000000041300000
> > > >=20
> >=20
> > Not too well-versed with ARM, does that tel me anything about where in
> > the code the crash was? Without any further information I don't think I
> > can see anything here, and I don't have an affected device.
> >=20
> > johannes






--RpOihqr+zsT1aoD+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZqJ10QAKCRA6cBh0uS2t
rBXrAP4pg667GN/0mnG3RU12IINowXbqv3rtMWNyo3K8jnNcRgEAoQwSdDoRwnnT
h+IrmcYqeDSz+waZ/AERuVKwDka4/A8=
=dT/5
-----END PGP SIGNATURE-----

--RpOihqr+zsT1aoD+--

