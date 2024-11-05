Return-Path: <linux-wireless+bounces-14925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DA29BCDCC
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 14:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23C9F1C20E85
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 13:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8B81D1F75;
	Tue,  5 Nov 2024 13:30:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B0E1D3593
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813415; cv=none; b=SrOg2blUnIts1AaPiXmAtq6DtdwJ0lqbMniYu1Um1nZiaW0jU4Z+86evJZxECCe2R4980QLf/sau6SJerp4f5n3q9sQEZIDLaAErCzdhjvlBymcg4mHO3GSTPTTyy8k6g5KkQck4C5+cvSzK/y6yqbJsX0cHG/Pz+bh71UWrNkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813415; c=relaxed/simple;
	bh=HipVrN/NsVVNsLy8mMH1FMPnfXDKic8U7Hd2Iyjylcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V7+OFXO1m3RW0kGlPJkKtvOnQBfKwyqzmnQxzGc/hf71is5eHJs3ZChMSF5MGrhYhvmQ66w5Eb1cJQ02xvGYedvpLkfEqiM8Y52O3zqhwyPpkRKk6iZ5+KJa3omAMC0KnobbMdYQoRoMVYHlBN/SmTkBKT7mXj4j3WBlWQPlcuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from prime.localnet (p200300C597373Ed83F7C154cd12B5cD5.dip0.t-ipconnect.de [IPv6:2003:c5:9737:3ed8:3f7c:154c:d12b:5cd5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 96608FA132;
	Tue,  5 Nov 2024 14:30:09 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: Issam Hamdi <ih@simonwunderlich.de>, johannes@sipsolutions.net,
 Toke =?ISO-8859-1?Q?H=F8iland=2DJ=F8rgensen?= <toke@kernel.org>
Cc: linux-wireless@vger.kernel.org, mathias.kretschmer@fit.fraunhofer.de,
 Simon Wunderlich <simon.wunderlich@open-mesh.com>,
 Sven Eckelmann <se@simonwunderlich.de>, Issam Hamdi <ih@simonwunderlich.de>
Subject: Re: [PATCH 2/2] wifi: ath9k: Reset chip on potential deaf state
Date: Tue, 05 Nov 2024 14:30:05 +0100
Message-ID: <6688984.G0QQBjFxQf@prime>
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
Content-Type: multipart/signed; boundary="nextPart6740989.4vTCxPXJkl";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart6740989.4vTCxPXJkl
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; protected-headers="v1"
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Tue, 05 Nov 2024 14:30:05 +0100
Message-ID: <6688984.G0QQBjFxQf@prime>
In-Reply-To: <87h68l96l4.fsf@toke.dk>
MIME-Version: 1.0

On Tuesday, November 5, 2024 2:02:31 PM CET Toke H=F8iland-J=F8rgensen wrot=
e:
> Issam Hamdi <ih@simonwunderlich.de> writes:
> > From: Simon Wunderlich <simon.wunderlich@open-mesh.com>
> >=20
> > The chip is switching seemingly random into a state which can be descri=
bed
> > as "deaf". No or nearly no interrupts are generated anymore for incoming
> > packets. Existing links either break down after a while and new links w=
ill
> > not be established.
> >=20
> > The driver doesn't know if there is no other device available or if it
> > ended up in an "deaf" state. Resetting the chip proactively avoids
> > permanent problems in case the chip really was in its "deaf" state but
> > maybe causes unnecessary resets in case it wasn't "deaf".
>=20
> Proactively resetting the device if there is no traffic on the network
> for four seconds seems like a tad aggressive. Do you have any
> information on under which conditions this actually happens in practice?
> I assume this is a patch that has been lying around in openwrt for a
> while, or something?

Hi Toke,

this patch has been around for a long time (8 years or so?), and it has bee=
n=20
integrated in various vendor firmwares (at least three I know of) as well a=
s=20
mesh community firmwares [1]. The circumstances leading to this "deafness" =
is=20
still unclear, but we see that some particular chips (especially 2-stream 1=
1n=20
SoCs, but also others) can go 'deaf' when running AP or mesh (or both) afte=
r=20
some time. It's probably a hardware issue, and doing a channel scan to trig=
ger=20
a chip reset (which one normally can't do on an AP interface) recovers the=
=20
hardware. This patch provides a workaround within the kernel.

We submitted it only as RFC back then [2], and since we had colleagues=20
suffering the same problem again we though we give it another shot to final=
ly=20
get it integrated upstream. :)

The idea is that if the radio is idle anyway, a quick reset (which takes a =
few=20
tens of ms maximum) doesn't hurt much, and it helps to recover non-function=
al=20
APs or mesh points.

Cheers,
      Simon

[1] https://github.com/freifunk-gluon/gluon/pull/2114
[2] https://patchwork.kernel.org/project/linux-wireless/patch/
20161117083614.19188-2-sven.eckelmann@open-mesh.com/
--nextPart6740989.4vTCxPXJkl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAmcqHd0ACgkQoSvjmEKS
nqHEURAAiiCKZlg+VVDdzoKFvZ6SFLtPMfSiLTfpEWbPysZ4RDhS6xJX1EpUzWh4
wssTngjogRXgqA8P2TaUtukC27y+rLVTmWp+jHTEYn+c9K9sxJCw8I/NytZ52+lR
+hCw+8E1Fkrq2srSMnxNNCmqYAUodijF3OI0OgaGz3hzHgAhbAOEds6RQZr+m/DN
fk1dHTczWW7abSxFDh4h7CPxsRlkBQCJWQOFrmH/Ardu0nNaJTFLo76kIphqXZHL
KSZ7KFbGknPNu+FHroFJu2x3Az1SbEGxraMBItUVjV+QP+sr+Oj3PDwGwTlmozSn
O4129h1mjIV6IJYfAtiaP9BDsd1Oxx9XaCuiMVk4bZ2BizkLf7hB4CoSDW6J6UHL
Tj6mcSvdTtG/awytYdSvbh0p3Osk9DvOHqzz/V8kWYVYD0Na/yTGs1nuzzJLaqce
dzwG12HFANhMppdClglBcVj1DrEZF92AGkE9IIZBatYlIckTVne9GTjjX3K64zmo
zqFicg4gAdhr0u2bOfbglHc2Vd/rqTtG5gNRnvEfTf8VrVeBmiIp7hfAkfOn6WJa
q3fNPkNeBiakD/ETCTx8gEFvfhxYxnGPk9miAtDcWSnCjT56yPO4MwUzvlBL7glW
MUOiVW0wnASDWx6Kc8R/26UbN8fMTIMYOXBX18Zd05X8TFmbgiw=
=TfLE
-----END PGP SIGNATURE-----

--nextPart6740989.4vTCxPXJkl--




