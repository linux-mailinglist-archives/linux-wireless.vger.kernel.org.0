Return-Path: <linux-wireless+bounces-22285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C3F0AA5817
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 00:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBDEB9A59BA
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 22:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45F31EB1AF;
	Wed, 30 Apr 2025 22:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="J08/FooU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A762132103;
	Wed, 30 Apr 2025 22:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746053156; cv=none; b=ahCg3mhgw7NnzMXFyDsdqG45Tgbxai+tlBlnBedYsn1kpF0pie003PzTdxhlJ7Du0u3kuzuqRe9Hl/Y/LiSfGgIRP6NkDXWfZQCKMm+XkxJf58UgyOh2HKvFHlHwbNcRxihP4JgmwNh4ZcqDUKlagU4/BUYrFkGG/H7iK5uPv38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746053156; c=relaxed/simple;
	bh=jqLBqMY4yAcntp0l0+g+tCIcrJiPm6Uwai2DlVWQpE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTAQvA6KUlD77O8lSwyTzCh40Xi4npM1CujUD8FVu4KwR5Zr+RUBS5NHaf0QVjxY1rSBmnhch427sIdvqmrhK4izLkxILDG4hzKDX0PA0Z0S9GDInTRf9aBop3lLEe/QpZKDFZOabrRGvp2qCb6qucP8Bpq9UGU6OAJlTRBzfsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=J08/FooU; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1746053146;
	bh=JRygT+SyBFc2uC+emZfzW2rSxVNWDcYolOT6AOJjZvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J08/FooUm5L9xsJFyP5LD+1NpAPRc8ryxyDDjZvysTalp2g8KWinpRAhilRY5Xx+3
	 SBWsdaeQcrOuu9g93Epg+bQ9AUcaIJnkCRMVC2OHAKQwv7+vfn5VGK6jM6ArGcSdI3
	 ebCeOaICMCDLfAERszvXk88vBkQnRba8CG/1re0Fyz939ocJ8ciZcTnWDX3UtN+Ocr
	 SfcE4tMZ9HPh4qVLutmfbLx4519n1OSlSDOkuzj8eBhhn8yp2U3ThFkS7v089KRZix
	 DTCgrK+k3RclPO+e8O4x/OAOs2Ek7gfOkr0ts0KXDk69wUI9vE2XL3VwgA0+Qd3+hM
	 jc2YbHFVZeKUA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Znsj6360vz4x5k;
	Thu,  1 May 2025 08:45:46 +1000 (AEST)
Date: Thu, 1 May 2025 08:45:45 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>, Wireless
  <linux-wireless@vger.kernel.org>, linux-next@vger.kernel.org
Subject: Re: Introducing iwlwifi-next Tree
Message-ID: <20250501084545.2c9de121@canb.auug.org.au>
In-Reply-To: <2d3c5c2946e4356ba99edb4cca4fa205149c0356.camel@sipsolutions.net>
References: <MW5PR11MB5810F9A009F45F1A58AC0E63A3832@MW5PR11MB5810.namprd11.prod.outlook.com>
	<2d3c5c2946e4356ba99edb4cca4fa205149c0356.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eRja0g37.XI3MhWX7M7qewE";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/eRja0g37.XI3MhWX7M7qewE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

On Wed, 30 Apr 2025 11:32:37 +0200 Johannes Berg <johannes@sipsolutions.net=
> wrote:
>
> On Wed, 2025-04-30 at 08:52 +0000, Korenblit, Miriam Rachel wrote:
> > Hi,
> >=20
> > This is to inform you that a dedicated tree, iwlwifi-next, will be used=
 going forward for development.
> > (instead of wireless/wireless-next)
> >=20
> > The tree will have 2 branches:
> > 1. fixes =E2=80=93 only urgent fix that needs to go to wireless.
> >      Patches for this branch should be sent with [PATCH iwlwifi-fixes] =
in the subject
> > 2. next =E2=80=93 all the other patches.
> >     Patches for this branch should be sent with [PATCH iwlwifi-next] in=
 the subject =20
>=20
> Could you please add this tree to linux-next?
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next.git/
>=20
> with "next" and "fixes" branches.

Added from today.  Currently only you, Johannes, are listed as a
contact for these trees - if you want more added, please let me know.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--Sig_/eRja0g37.XI3MhWX7M7qewE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmgSqBkACgkQAVBC80lX
0GyoVQf+KinMJUX7A59j2/ovmowwX4EoqU6KqAAVQLGMTWWv5ropQ/qj2vHPIrv1
BPzv2Ey/S6NK+5z8iNXK8GSqoCTTzLRnO9imZkNL8jv4So88PSioi1ZfleAGQjtd
WXZZj+XocEIHZwmLloRoxV/gZMmCwwETaYFnukL/vj2235YOB6QaGvRa/g4mOup4
5kcNQIno7jwqtfYfRv1+cs51XaoeYILT+6uo42HSs1His/rZcroWQYuEhP1RAfH8
thOrAPZ5qNWGItmNSlCuCIQhr+c+Uj2i0gG1azxLjHXO7j4UFOjEHnFGwLginKd8
oHzbkfJgLMUiDb1h8L/K73yJWQ9ssQ==
=zYMf
-----END PGP SIGNATURE-----

--Sig_/eRja0g37.XI3MhWX7M7qewE--

