Return-Path: <linux-wireless+bounces-10149-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E35292D144
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 14:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 786A91C2104D
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jul 2024 12:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640C518562C;
	Wed, 10 Jul 2024 12:06:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5708684A35;
	Wed, 10 Jul 2024 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.255.230.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720613164; cv=none; b=nUAJOjs1ed2LeFVfzNXXaSKMyGNEln1RcsBmjMNhYqQT3JiySYcaKtWL2Uzmu9qwqL4Uj99Rqel5gXuQggNnbl9T5OjIyDORk4icKjSZYbZ13bBT8juIdn3cmtKaBertmZuGgfPfAGtl9w0G65Xlm2q6y/MDO48MvJSUxMRIW6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720613164; c=relaxed/simple;
	bh=ZPI86qgor8IoI1RvOaruiWMTbPTasSePoe9+lZgw+Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iu0jYGJFWegr7SFqDB2BtcuY8IDoVGQPEb9/Yi3mlaVGX223kfeoIBxCmX2FvS+fas9gXXF048RCJ5Zk3j5CvTbYwRgWpuAta554pwsfEizvF2k3RCp6YG6nchEnRF3tw10csrYD8sQoUQDlVvr2uJ9PAcfzV9+uGJY3sBshkbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de; spf=fail smtp.mailfrom=denx.de; arc=none smtp.client-ip=46.255.230.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=denx.de
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 83E171C0082; Wed, 10 Jul 2024 14:06:00 +0200 (CEST)
Date: Wed, 10 Jul 2024 14:06:00 +0200
From: Pavel Machek <pavel@denx.de>
To: Greg KH <greg@kroah.com>
Cc: Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+253cd2d2491df77c93ac@syzkaller.appspotmail.com,
	Johannes Berg <johannes.berg@intel.com>, johannes@sipsolutions.net,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19] wifi: cfg80211: wext: add extra SIOCSIWSCAN
 data check
Message-ID: <Zo55KEC5MmfeXJxq@duo.ucw.cz>
References: <20240701001526.2921645-1-sashal@kernel.org>
 <Zo5cn37w8NjVyZdj@duo.ucw.cz>
 <2024071033-geologic-emerald-f6a2@gregkh>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h8B8MqXnRZWc0TjU"
Content-Disposition: inline
In-Reply-To: <2024071033-geologic-emerald-f6a2@gregkh>


--h8B8MqXnRZWc0TjU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2024-07-10 12:24:55, Greg KH wrote:
> On Wed, Jul 10, 2024 at 12:04:15PM +0200, Pavel Machek wrote:
> > Hi!
> >=20
> > > [ Upstream commit 6ef09cdc5ba0f93826c09d810c141a8d103a80fc ]
> > >=20
> > > In 'cfg80211_wext_siwscan()', add extra check whether number of
> > > channels passed via 'ioctl(sock, SIOCSIWSCAN, ...)' doesn't exceed
> > > IW_MAX_FREQUENCIES and reject invalid request with -EINVAL otherwise.
> >=20
> > This results in very confusing code in 4.19 at least. It should goto
> > out for consistency, exploting kfree(NULL) to be nop. Ok, not sure we
> > care...
>=20
> kfree(NULL) is always supposed to be a nop, we have relied on that for
> decades, that's not an issue anywhere.

Take a look at the code, especially after this patch is applied.

BR,
								Pavel
--=20
DENX Software Engineering GmbH,        Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--h8B8MqXnRZWc0TjU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCZo55KAAKCRAw5/Bqldv6
8ljuAJ0enT/gmiGamREzJrliRAs8myr33gCfcXJEf1bnxtJt4X1QMBTe5uP4n90=
=aepH
-----END PGP SIGNATURE-----

--h8B8MqXnRZWc0TjU--

