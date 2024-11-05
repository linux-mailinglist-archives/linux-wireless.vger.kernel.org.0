Return-Path: <linux-wireless+bounces-14926-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7069BCDE7
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 14:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28EEB1F22969
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 13:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9169D1D63D7;
	Tue,  5 Nov 2024 13:34:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0891D63D4
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813645; cv=none; b=nqfaFV57i4txPUH23eB0bTgcik1kFMqoBS+smvjPtv/viA7eOWmuwOZYIuzH7UoFLjMHsv8bK99pR/dFnUFtRrW4tVzgEXOovm23q2GkHaCmoULgJ1tgOGzjzwbwpXLNmWuJ/HfLuVmZ0zuZWwN16GLPy4HKJFOG6R37uBlhkts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813645; c=relaxed/simple;
	bh=qXylrw50i46LQPRyneVLDRcnDDFR9S8KA8yOdW5A1eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5V4wUEbSlUeYIrMyfUQLgsE4wJF3dRTM/2bHBlXFTxmesBVyqsGG2NVqw/AlN28jdYviJyHQBMSB92fVJ1B11NLs7tYxgp7K63QqVX1J5W8qL939q8AmwInYEzx6wy+W4mx7trrywE5YB9UWJCnSB3VfdaqE1VkPWUQ20ZEXjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from prime.localnet (p200300C597373Ed83F7C154cd12B5cD5.dip0.t-ipconnect.de [IPv6:2003:c5:9737:3ed8:3f7c:154c:d12b:5cd5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 265AEFA132;
	Tue,  5 Nov 2024 14:34:01 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: Issam Hamdi <ih@simonwunderlich.de>, johannes@sipsolutions.net,
 Toke =?ISO-8859-1?Q?H=F8iland=2DJ=F8rgensen?= <toke@kernel.org>
Cc: linux-wireless@vger.kernel.org, mathias.kretschmer@fit.fraunhofer.de,
 Simon Wunderlich <simon.wunderlich@open-mesh.com>,
 Sven Eckelmann <se@simonwunderlich.de>, Issam Hamdi <ih@simonwunderlich.de>
Subject: Re: [PATCH 2/2] wifi: ath9k: Reset chip on potential deaf state
Date: Tue, 05 Nov 2024 14:34:00 +0100
Message-ID: <3642470.LM0AJKV5NW@prime>
In-Reply-To: <87h68l96l4.fsf@toke.dk>
References:
 <20241104171627.3789199-1-ih@simonwunderlich.de>
 <20241104171627.3789199-2-ih@simonwunderlich.de> <87h68l96l4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart16975068.geO5KgaWL5";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart16975068.geO5KgaWL5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 05 Nov 2024 14:34:00 +0100
Message-ID: <3642470.LM0AJKV5NW@prime>
In-Reply-To: <87h68l96l4.fsf@toke.dk>
MIME-Version: 1.0

On Tuesday, November 5, 2024 2:02:31 PM CET Toke H=F8iland-J=F8rgensen wrot=
e:
> Relying on the debugfs counters for this seems like an odd roundabout
> way of going about things. Why not just record the last time an RX
> interrupt was received directly in the interrupt handler code, and then
> have the watchdog check if that time was too far in the past?
>=20
> Recording both TX and RX times may even help distinguish between 'deaf'
> and 'idle' (cf the comment above): if we transmitted something, but got
> no RX, that's a good indication of the deaf state; but if nothing
> happened in either direction, it's probably just the network that's
> idle. I think?=20
>=20
> -Toke

=46orgot to comment here: On the AR934x hardware we worked on in the very=20
beginning, we actually still had a few interrupts coming even if the hardwa=
re=20
was 'deaf'. This why we did not implement it with a timer, but counted the=
=20
number of interrupts for a given time and compared it to a minimum expected=
=20
ratio, as done in this patch.

I understand your argument for the TX part, but I think it actually breaks =
the=20
AP mode and prevents the recovery: if we can't hear any clients, they will =
not=20
use the Internet and the AP has not much to TX either. So an already deaf A=
P=20
has nothing to transmit just as an idle AP, but for a different reason ...

Cheers,
       Simon
--nextPart16975068.geO5KgaWL5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAmcqHsgACgkQoSvjmEKS
nqFXFA/8DYqkBjwK4gZ6MTG7Vb5JRB4Mb+nW8Iy4dY1u3DBQo3vILKSwzpavCx1y
EDX/aDWxgCUDqE2i6lWhKpxwdhrFHa84KTOEkqg5lKEOcitbgLvw6wILMZNVhPFx
LffNqC+AjXpevVFEXWWVOkSHN/WkZxLxqJ3JvWKwiBUZnVFTD+89XAbra/8HLeQU
A+0P/U1h6emcE+Up2SwFbtwy15u541/6/jIYASNZcZzodNaB7paX0SrsysUyZubg
7sfnodkE1YUF6XbIRtRl40Az/V2EiJq6P1qDw73/1DRSPBF4I20F1Qk3SeT1mKav
eUcXptBDxcSYHEtURaLZQSU97n0102BpczoPmubudujZivLHN/POhAbjo1KhjlZj
WFsUszJUdCiKIlHnFAMR+60ztbDjjt/E/c4Be3tfCTdrPro6YBD5+dq88GNflhzx
J3MZUYfdD6w/Hq4camYc/VnEuYwqKLBxpGSs1HCTpkv9rFFWWHZ3ymJCCLHoTf0n
qaw0P/+OVvtcw5Rvnc+6n6mouz2e2HdtPwlbTybYRSPkykdNoLCfN/7viqtQrDqp
ctUuuZMa9xb9carJto10gbbg9dC6B6x8+7aKj0N8jDqrV2/Y4c58Udcuk3cE0pU0
g/JCa2MIRxLBPcCR23lqpHcVMNYLAvM9lbO6ZojkebP+lzB+Yrg=
=4RAr
-----END PGP SIGNATURE-----

--nextPart16975068.geO5KgaWL5--




