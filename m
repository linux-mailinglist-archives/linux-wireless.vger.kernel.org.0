Return-Path: <linux-wireless+bounces-7669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EEF8C613D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 09:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99D928326F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 07:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4249243ABC;
	Wed, 15 May 2024 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="R2pLt/FY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from prime.voidband.net (prime.voidband.net [199.247.17.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB1D43AA4;
	Wed, 15 May 2024 07:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.247.17.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757330; cv=none; b=jmLjixoqltouEXNSI15vgdaZWHUGR5N74zIHjrzhl76eZUESzzbn47ARHvj787OgiY2MzRk7HVfUo0HdqAeI9Juzj4dT9RKhVObwBrHM2ai4gWwXIWoXkjW1qe2BtljzU2t/gG5Z9/ygDB3uxLtGUEW26PE+ZpTHHeH5FB0gOsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757330; c=relaxed/simple;
	bh=MQDUZN0OMyoox6Z93YbNjehKhvRKHn2tu12DYd6IG4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghFr2urQg1ppKa6+inJK5x5SI7qLFzU7y+gkq/i6o5o2QclGQlKc0EaCfFXwd7oNddrsmSjY8j++LOY8npricnCNHCe0PDi2WKCNka7duI5hUUYzbiTJjQsnYjecapxrdqlSwZ1byWBaNrsSNmutMPXPNj2W+PmZPMf+x9/6zCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name; spf=pass smtp.mailfrom=natalenko.name; dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b=R2pLt/FY; arc=none smtp.client-ip=199.247.17.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=natalenko.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=natalenko.name
Received: from spock.localnet (unknown [94.142.239.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by prime.voidband.net (Postfix) with ESMTPSA id E595E6356CD1;
	Wed, 15 May 2024 09:15:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
	s=dkim-20170712; t=1715757325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MQDUZN0OMyoox6Z93YbNjehKhvRKHn2tu12DYd6IG4c=;
	b=R2pLt/FYUh5KewsQxU5COKqCEmn9Ug1dJfcyz6XCkQVzGWAgY6RTxKZsQ1ubJWTjXFc4rB
	JvAY6X3Y0cgHtC/c95eZQKKg50iKAHuomQrTPUjDcxcr+LwKJv9OHodC5nt453x7DZ74KX
	Z3yaVPZmfRloZIom6ZcitNrAqAMcWLE=
From: Oleksandr Natalenko <oleksandr@natalenko.name>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Peter Chiu <chui-hao.chiu@mediatek.com>,
 StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [REGRESSION] MT7915E doesn't work any more with v6.9
Date: Wed, 15 May 2024 09:15:12 +0200
Message-ID: <2200096.irdbgypaU6@natalenko.name>
In-Reply-To: <60fe8df750a74331b8a54a76d55d5e8349ac46b4.camel@sipsolutions.net>
References:
 <6061263.lOV4Wx5bFT@natalenko.name> <2341660.ElGaqSPkdT@natalenko.name>
 <60fe8df750a74331b8a54a76d55d5e8349ac46b4.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart13529873.uLZWGnKmhe";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart13529873.uLZWGnKmhe
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [REGRESSION] MT7915E doesn't work any more with v6.9
Date: Wed, 15 May 2024 09:15:12 +0200
Message-ID: <2200096.irdbgypaU6@natalenko.name>
MIME-Version: 1.0

Hello Johannes.

On st=C5=99eda 15. kv=C4=9Btna 2024 8:23:35, SEL=C4=8C Johannes Berg wrote:
> On Wed, 2024-05-15 at 00:51 +0200, Oleksandr Natalenko wrote:
> > Also /cc Johannes because of this commit:
> >=20
> > 6092077ad09ce wifi: mac80211: introduce 'channel request'
> >=20
> > On st=C5=99eda 15. kv=C4=9Btna 2024 0:43:40, SEL=C4=8C Oleksandr Natale=
nko wrote:
> > > Hello Felix, Lorenzo et al.
> > >=20
> > > With v6.9 kernel the following card:
> > >=20
> > > 01:00.0 Unclassified device [0002]: MEDIATEK Corp. MT7915E 802.11ax P=
CI Express Wireless Network Adapter [14c3:7915]
> > >=20
> > > doesn't work any more. Upon mt7915e module insertion the following sp=
lat happens:
> > >=20
>=20
> 6.9 didn't get commit 2f7cf3b61d85 ("wifi: mt76: mt7915: add missing
> chanctx ops")? Huh?

Yes, you are right, this commit is not present in v6.9, and I can find it i=
n the "next" branch only.

I can also confirm this commit fixes the regression for me.

Thank you.

> johannes
>=20


=2D-=20
Oleksandr Natalenko (post-factum)
--nextPart13529873.uLZWGnKmhe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEZUOOw5ESFLHZZtOKil/iNcg8M0sFAmZEYQAACgkQil/iNcg8
M0vELBAAtzFurVLA2p05EBkdZqnYzYFZSF1PqO+Gl9ycGnsEtOrfdBLnJX68Fe3Y
2ALMWI/SiP+nY16RnLH74Zv1vZPZ4cCraP2RcsZx7foWX3/5Vp6HXZNCTft4mY/z
ukh1bYGL22wgMYzcdxcsYzNWx8hPPBWtcQBLlI135gWwsFMWLceLqSxdSArycjjM
RgmmKUYWC7hicfeQ2IusZ+KIETvOadet1mW5Jkgtb0Xl7BD2bdeWmTEaPudRye4/
alYhrMEKUDWRr48uV5KohVlj4SR06t3RF2TVg9bGfupyhD80DRobXE2MqTsQ04ve
2X9XeXPkfhVzo1MjZMqNhbln1tG1C9v3E+yQIqyZ4N9hrCZ4T6RMztz/OooHkNqq
NfVnZFf59FTPfkd4kCb4gzJ6bcxT2DVnbnBndeGSQ3yh+4xA5uokbezQBUuw9ub/
iVoPo6bTo15GE3uM47+LEGQcahYG6PC798n5megvVCuBepFvVEkOW4Tku6vI3rx+
ox+NpWdgm7u0262OdwpMXBEQzj0aCJC8KafE9TmfAMF+5DNdD6r+gqR+4SL0A90l
GJHudrVX0MD9ZixIq5Nc0rVpT2i167xZHgMfq24Uw04M2awxSZIb9oyEiwYCP9QL
svxPKWThbWw8uZB2yWKDUqzotS1Xo6cYZEV/MrgN28czKZlvA0Q=
=EtZ6
-----END PGP SIGNATURE-----

--nextPart13529873.uLZWGnKmhe--




