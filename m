Return-Path: <linux-wireless+bounces-8884-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEA29053E8
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 15:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CF82839A6
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 13:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC0117A931;
	Wed, 12 Jun 2024 13:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="nzGo1tqe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D6C178398;
	Wed, 12 Jun 2024 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718199479; cv=none; b=eWnw0n612KOuMQegVlPG3wjiCWIpCv+unZMdEPgFy24m0aHFSa5TLYtxCta5qniUWkc5oGuUKFJwFLn1lATHUGG7g+xlyyngU4Mfxjoq05/ejWGKYvcoqDgdKcTmvSViJtp9g1hHX25p3U9BvBciLh0ZYveq2M71GaPwqXV/Tu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718199479; c=relaxed/simple;
	bh=tsZU/m7OocLp2Lkbaeswpovpc5i3uD+mhKLpdF0PJC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lV1YsDpPdoM5E+s4LLBb6cNXAw8pBPmAVSUBEYeNrg4LKd0rJIT4WjV+IpSgaOSJ8VKS/sPfR7B4wlKtW5owarXllpHqTvptOMaZawFCKLFuqWCttWh5A9unbjBr293/87DuEN7C1SPsvaIq0hivOW7EPHL8NEFKcOcnKVPm9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=nzGo1tqe; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1718199459; x=1718804259; i=christian@heusel.eu;
	bh=tsZU/m7OocLp2Lkbaeswpovpc5i3uD+mhKLpdF0PJC8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nzGo1tqe/cdg/Np7sj6B3nMS5GnrzSw3yS7ZqjG3Mb6yc5JJl0gHgtjvjd5I7hXi
	 dhtrJpD2rAUtZWG7dKwpPCkCom1wgaY2p2Yp6fRkkdJ4aX9N/tG7JEqO3QObqiSTu
	 Bd1djEslXQFnerrtuHeSY10vdPOyWbncf2ehj3w5Yje0/mKQQsVFFPaun7anQPnZE
	 05EgYtDmdKNyI3eqssEoJRTLenzAAyW3W75WJ3RN64K7y/5gRHaHOiAeBNokMNgP3
	 meS6iWIC3RX4FaQEB9pHetkGEykpjxryGx91fqIcRDhfkSLSdJ5c9sXnWAlnZ/Ycm
	 N5UThFYkJ8U7Pu57MA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue107
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MyKYE-1scFPu2Fe0-015hkR; Wed, 12
 Jun 2024 15:31:58 +0200
Date: Wed, 12 Jun 2024 15:31:56 +0200
From: Christian Heusel <christian@heusel.eu>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Ping-Ke Shih <pkshih@realtek.com>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, Savyasaachi Vanga <savyasaachiv@gmail.com>, 
	Kalle Valo <kvalo@kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [REGRESSION][BISECTED] wifi: RTL8821CE does not work in monitor
 mode
Message-ID: <3a6b3ea1-986f-4066-8408-cdb56e095d41@heusel.eu>
References: <chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
 <a51f223f-18ac-4d67-9120-8da1c169b7eb@leemhuis.info>
 <809d2332-625e-4a46-a77e-ca2e49b0d651@leemhuis.info>
 <0e65ca6b471b4186a370b9a57de11abe@realtek.com>
 <36c1f49acfcc2cc16c7e54ffeb76f1e93cb96e91.camel@sipsolutions.net>
 <5318640d6eb74301b1fbf6d9385ba69e@realtek.com>
 <6a88e0d3e47ebbd1f0f383094e4804a627c41870.camel@sipsolutions.net>
 <7869b9b29b6796c95fd5af649e4bd6696e56dcaf.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2e2w45cfz5ro3syf"
Content-Disposition: inline
In-Reply-To: <7869b9b29b6796c95fd5af649e4bd6696e56dcaf.camel@sipsolutions.net>
X-Provags-ID: V03:K1:PVCZg4NTCK9VJJlSCI0O8ZqJgGt3sMCY3kufv3Iq/7gvLAwXApY
 f0I11ciyiDQRguivz95omRpZ4ns7Pk1wZ+DieEy7KlsWzVbVleNtt8YwasBDm+1lmtK6Ax9
 KDm3i2NJK24XatI0bMitrpd1mag8C5tYj2dF3fPO7wks/urE6RsnbU8EGV4iDJ4TcAdejnf
 GAgXnOKJJdLe+Xe72ZpNQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CyJIKlqnMh8=;5fUCl+DeNHJnKEsBPEdqjAi9g9B
 +7XosA2TnxJpvl4GK9bmEnuF9bZMl0GoD5wiKRHBsId2Klgdn61iTFHwSsTQaKq3JM4TIPD0/
 sUC+azNgeKNtFdLJJVjDIWvjBNjY3Dx2xRxE5/pX58QcoRUtBd7r84O0nNhTes78Q7MLtZpry
 sNEhN8Gj9LiC6qRICLzGB3bH3f0vgRrNeHpJJD0QYp35dufbzAD3A7dseVGSpn5ilOuRSClMC
 cS64KHtCbFUEg0w0dFKxUk5Xh0/29QIUqyR4q8fOOjhLKsQW4YIn++Sm4xNAC/vXBgz58iOWP
 MQsUNtTPG9LIX9sjJe/HN6hG4RnQseVznKPecveBozC8xjrvQ41fxRBzzbB9xGzazwqI8+p9J
 ImJFWAVAnw5cj8cIyXn8sl249G5MpptvdePFrRwnZLXVVr9HQp12qxbrIkCD0yzZn07XYAJmU
 dfIirG6hehFHAau+XsOk6eurZ9REzwhllJq63IuQDc8iHrqJeHzL5ozpiuJgpwzZ6EG/Qpqkj
 AaWX1iz6Dc4cFZ87kWm+NpbXAZXmXkG96NFLiCZQMvoaojV8yjQ9bXeMVNCbukNo4AWEzZQUx
 V/oVfTvBRvONdMvz6TPG2iYmIUKOanQwFKrbuVlAOiUTjy0b9WNnrTrmehyr3SoC84U9+STHD
 C6tUo52KSTN0A8AX+LOGdkhDrud4RzxtSlLGTF6be0P7aIwEb1RQQCwmpO+TgCaScA2Xwd7lW
 HST1x4MFXQC6k1ZyInKHhp+KhnSNGCNWH1aBgu2EkG9nF1snU1U4MY=


--2e2w45cfz5ro3syf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 24/06/12 09:58AM, Johannes Berg wrote:
> On Wed, 2024-06-12 at 09:07 +0200, Johannes Berg wrote:
> > On Wed, 2024-06-12 at 00:56 +0000, Ping-Ke Shih wrote:
> >=20
> >=20
> > > > Just got pinged (sp?) about this, can you share the driver fix so I=
 can
> > > > take a look what the issue is about?
> > > >=20
> > >=20
> > > Please reference patch below. I copy this idea from rtw89 [1], which =
the main
> > > stuff is to add WANT_MONITOR_VIF and case NL80211_IFTYPE_MONITOR in a=
dd_interface().=20
> >=20
> > Ah, OK, but that gives me a hint. Yes, I see the issue now.
> >=20
> > OK it's not trivial and it might leave ath12k still not working (though
> > not sure it ever did before? or maybe I'm missing something...), but I
> > think I can fix this. Let's see.
> >=20
>=20
> I don't have any of the affected hardware, could someone test this?
>=20
> https://p.sipsolutions.net/619a4ce4a197b2b4.txt
>=20

This also [fixes][2] the issue for the initial reporter on our
bugtracker:

Tested-by: Savyasaachi Vanga <savyasaachiv@gmail.com>

The test was done using 6.10-rc3 as base + the proposed patch from the
previous email.

Cheers,
chris

[2]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issu=
es/54#note_191037

--2e2w45cfz5ro3syf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmZpo0wACgkQwEfU8yi1
JYX5IQ//RU63RMmDQkSoJE8Gdx2X6OvhNwE4VhP9HtMfwm0KuVbiqZEYaDNPiaMv
THAJBPeXCoccjHe5a5anejye1ofgOOn9KdOMF2iin/s1045xGLSELzY1RMVtb9Dx
JT1Et0zY+LdwODfjF4FWB9wc36DeDCr+2uxDRh2mp+8PBFFD8S5ND+kA/F5ysh1L
OBeOCQK1kLE4xrzqQ4NsP/9D9vnb/Ufs1XeBFy9/XXiVCuCtQMeLg4+GilF6xpp+
zkgO3n8iXVKW2XwZJkNtghv9+ak8ZJN4BbYrKlxnuV29dE4uTm4zQwVYzDDepdd7
Fe6K7Wx6/jiOTuY6MX+tHTECDhNF9+dqN6MyTMQTzE+QU8yEO5+xsr9yxJlkCgbe
WXF7JcqNidoDmrtBnUMdJxadWqlNLwdLd3jyT7lGis8X/FwvWmHY9c4m23n82v6T
XWagElaR1uxLEYM+fGembET6Pd9i3qIbCbD3fEcJ4IH+c7DZHWEgzVEaOOdcyNxa
XHgRpRshk81QhVBG/qKLKOpr0cZbbPodWygm71HcrUA22i9Ga8rmKH6ufzi3osON
jB4Qpd8MOHJ4UjjM+7UFVnb8X9ei+pxCKC23Sdj/UnZXIBmpgzu2DKXGotmma3rC
TzK5q1VpY2LX0/UGawmbtRCwA2Yj4eZsUxZH+++nEM1emquWQ0U=
=iVDo
-----END PGP SIGNATURE-----

--2e2w45cfz5ro3syf--

