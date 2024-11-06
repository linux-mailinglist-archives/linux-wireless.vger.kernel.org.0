Return-Path: <linux-wireless+bounces-15002-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB769BF284
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 17:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDEE51C24FF4
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2024 16:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDA0207A26;
	Wed,  6 Nov 2024 16:03:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CDE20651D
	for <linux-wireless@vger.kernel.org>; Wed,  6 Nov 2024 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730909016; cv=none; b=OncgkChFUEL3j3TDtoLC3xHjlZE0G1nYhB8AI5+MCbs7pQVsBPd8pc/E2RoVd9HIkfqrCTN4TtnkFENCiUk2g5QXC11olym7TfWxPOceHXNsF4A3kyyxMfuU0LFMNaoKCy7LMdvC7A/xlEjIQNV6reoqkgzC0oZxEm7ubdb5zXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730909016; c=relaxed/simple;
	bh=pYnLyeRIOGl7ILblxkvKP3fj8mdw/52D14Kx6IwEMz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGRSL0GrKRCEvdHOKm++5aV2MqqkVstw92LMeOSpmORHbTHr5Yi8ThWg3pCAM3r3KDQnmrnkQrm49B9xpZz/+WhlJdylwcb65Mh64DEZzAOkhvlpTZe2HKgmVcehqIs5r8v1/hak6b6eE/08UdOV4NxWmUxcpVjwp+IOQycOlAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from prime.localnet (p200300c5970b92D8e31DdA1625464252.dip0.t-ipconnect.de [IPv6:2003:c5:970b:92d8:e31d:da16:2546:4252])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 5E80EFA132;
	Wed,  6 Nov 2024 17:03:31 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: Sven Eckelmann <se@simonwunderlich.de>, Kalle Valo <kvalo@kernel.org>,
 Toke =?ISO-8859-1?Q?H=F8iland=2DJ=F8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
 ih@simonwunderlich.de
Subject:
 Re: [PATCH] ath9k: Add RX inactivity detection and reset chip when it occurs
Date: Wed, 06 Nov 2024 17:03:30 +0100
Message-ID: <5009451.31r3eYUQgx@prime>
In-Reply-To: <87msic78no.fsf@toke.dk>
References:
 <20241106-ath9k-deaf-detection-v1-1-736a150d2425@redhat.com>
 <3288096.AJdgDx1Vlc@ripper> <87msic78no.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4653308.LvFx2qVVIh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart4653308.LvFx2qVVIh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Wed, 06 Nov 2024 17:03:30 +0100
Message-ID: <5009451.31r3eYUQgx@prime>
In-Reply-To: <87msic78no.fsf@toke.dk>
MIME-Version: 1.0

On Wednesday, November 6, 2024 3:12:59 PM CET Toke H=F8iland-J=F8rgensen wr=
ote:
> Sven Eckelmann <se@simonwunderlich.de> writes:
> > Hi,
> >=20
> > Thank you for submitting the patch.
> >=20
> > On Wednesday, 6 November 2024 13:41:44 CET Toke H=F8iland-J=F8rgensen w=
rote:
> >> Since this is based on ideas by all three people, but not actually
> >> directly derived from any of the patches, I'm including Suggested-by
> >> tags from Simon, Sven and Felix below, which should hopefully serve as
> >> proper credit.
> >=20
> > At least for me, this is more than enough. Thanks.
> >=20
> > I don't have the setup at the moment to test it again - maybe Issam can=
 do
> > this. One concern I would have (because I don't find the notes regarding
> > this problem), is whether this check is now breaking because we count
> > more things. In the past, rxlp/rxok was used for the check. And now I
> > don't know whether the count for the other ones were still increasing.
> >=20
> > * RXHP (rather sure that "high priority frame" wasn't increasing)
> > * RXEOL ("no RX descriptors available" - I would guess no, but I can't =
say
> > for>=20
> >   sure)
> >=20
> > * RXORN ("FIFO overrun" I would guess no, but I can't say for sure)
> >=20
> > Reviewed-by: Sven Eckelmann <se@simonwunderlich.de>
>=20
> Great, thanks for the review! I'll let it sit in patchwork for a little
> while to give people a chance to test it out before sending it over to
> Kalle to be applied :)
>=20
> -Toke

Hi Toke,

this looks good to me in general. I'm not sure either about the particular =
RX=20
interrupts. We can test this by putting the AP in a shield box and verify t=
hat=20
the counters are actually increasing, and that should be good enough.

Acked-by: Simon Wunderlich <sw@simonwunderlich.de>

Thank you!
      Simon

--nextPart4653308.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAmcrk1MACgkQoSvjmEKS
nqGa3Q//ShTg2V0elDv9t9qZLNeyDo1nG3ucqXHvKIenKNOzCUjp8ohWDXUQXdaP
3oVaMEgFdOFnRFucZ001eHbXfxGmPJOR1ZXNhJ0XhpeaEAf7swA2+4yUWh07W9Po
Duj7YNgPW3M1HvRomhwL1EVb+gJWM/gZYHAJULahNJgAn7wJ8Orexb/EyGvIqryU
A6v15VfHtE8FMP6maKaLvnHodNcD1YslUYtWpBKLkWhEVIwbFshKklprIgN0Q7Jg
fkVfS1MY9AcB7gK6JwBZniJ4CQ94iHxvhg+rXVipRdDna3f0WlDeL/d0ZO/mDFSl
RalcYaMbdU9UwQ5H2T4HIB02612cAR9K6Wsdce5FLvcjqb3Ms2BzESxwtKTUZda9
xz5HiJRX8BpxzlRFfRSuSBC1kj4W3MOrO29t4w4MbVcRNNcPogHZiL9WX/04+f6u
GC00mO0ExMPFkr7CwmaMh9jP6kZNxsgN+weNZYIaWFFPpbBActQa0wbAlT7furVm
NSIjbaUSRH2t6Ghq01P3dbad27n90iVJtUX86OS3iemzuK8qySMH6DCvXnEE3KfL
dZecEfhotqVb/X0XDXUNB3/Jrpg4hWkzuXJj8+1+zhton7dq/wB8lziHIsOmcO8O
xfJq3O6Y3P7HPT3zanLAtHdwEDWt89Q3hSj/8lZRuf4ocAlChuo=
=cCxw
-----END PGP SIGNATURE-----

--nextPart4653308.LvFx2qVVIh--




