Return-Path: <linux-wireless+bounces-13207-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8A5986555
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 19:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5CBA2878D8
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 17:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4202B4AEF2;
	Wed, 25 Sep 2024 17:10:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ACF4644E;
	Wed, 25 Sep 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.190.117.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727284230; cv=none; b=imQk77dQ+ctFymzQ6+J/mNbJfrmYih74TxtzBxTzv38nCPecaVgmrH4i1SMhiGGKk3r3kfULm26kG+BLRkP81G983+6STjCq/rzVOyYDBd8toBUZOWY4Yvxk4Hh3Mg7s80+zkYZEODZsi42c4a/Y8Z07LzMLUWnlyQDzLTX60gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727284230; c=relaxed/simple;
	bh=TOCt44VkqdV5ypGeTN0RwLGvfKEJvT3VeOGAWd3GSgU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMIAyRDHoeyd2rdAvttVSpCy8Jf3FhIbvVkOKmlJlorPIFyeOX5s84YpEkSTGP9We7WMb/EftnB4E2FGNFa5i7kUqI6muEtbOxQ6yeWmD71hf9KRQO8hVStd0J3SeT94E1kKOZyoMNFbFPbi3+99JhIcb7I5CHHBGvwfC98lquo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; arc=none smtp.client-ip=80.190.117.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1stUrv-000900-0j;
	Wed, 25 Sep 2024 18:27:58 +0200
Date: Wed, 25 Sep 2024 18:27:39 +0200
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ssb: Call ssb_bus_may_powerdown(bus) only once in
 ssb_bus_register()
Message-ID: <20240925182739.5c9ca063@barney>
In-Reply-To: <d6037759-4dc8-4cc7-922f-95739761d068@web.de>
References: <d6037759-4dc8-4cc7-922f-95739761d068@web.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aNddZWZt3dx.2k1eFLmMqqG";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/aNddZWZt3dx.2k1eFLmMqqG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Sep 2024 21:33:49 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:

> diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
> index aa6165e3db4a..458858b5472e 100644
> --- a/drivers/ssb/main.c
> +++ b/drivers/ssb/main.c
> @@ -663,11 +663,9 @@ ssb_bus_register(struct ssb_bus *bus,
>  	ssb_extif_init(&bus->extif);
>  	ssb_mipscore_init(&bus->mipscore);
>  	err =3D ssb_fetch_invariants(bus, get_invariants);
> -	if (err) {
> -		ssb_bus_may_powerdown(bus);
> -		goto err_pcmcia_exit;
> -	}
>  	ssb_bus_may_powerdown(bus);
> +	if (err)
> +		goto err_pcmcia_exit;
>=20
>  	/* Queue it for attach.
>  	 * See the comment at the ssb_is_early_boot definition.


Acked-by: Michael B=C3=BCsch <m@bues.ch>


--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/aNddZWZt3dx.2k1eFLmMqqG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmb0OfsACgkQ9TK+HZCN
iw4kQxAAtBtUTH+OXL//YvxKvG+B5e5GGj4AyXa8p2xzp9pmx4dV5/Vqgcjf2yUb
AKkUy9Ox+YCGQspqm0LXTyyY9QPvEZlIa0SonUVuXLXvtWMs+BUjGAK8Sy2KG5Bn
mXDKpYNVyGjT0KUgN5Y9/F8pDC1NTklIi4V4wK5LYUddDCwCW1nw2Oi6waAWCv05
XtGYszGIw45F1VI8HscuRYjyzHsMXEubDAnO7WorQZpIBtqwZ8zT+a6x0RmkXYRW
t6oZV5j6tqSa8uIU3p00MygF1yJIrGEkMAIWJW/JDLtpr3MKc5rGeml097WLq9PA
etp9H5dUB0JwqlJK5/suRT1eLzhOa8qG9HfuY9wqU8CL7TNG6Ofo9xjFNpfOQlrW
Sz1kb5DJEdg91UYgOZFlI0J2447F7diolLVDgpO/eaCZs1HDLCDqkr2fva8QBKCO
vslCcvWA4+8FzyEZox3QR6KfirbStG58XMGRLkTUiR7haW3IC9dXQancrnqPwih1
ARwDMBT4J35WRSyhaNCYfjCBhS25R04/EEByEx64Tj1UVGU70GBoSeclGynwiQ/5
fRoOw8yPb4PzUq88LCVE8t0B8SzXa3YBU876Q05LIZ8HZPqsTU5i20B12AsQRMMl
FKA8On5aef0MAGhQSuquZDgey91+G9jqvC4ygeVsVXLG2QVmlns=
=dBdW
-----END PGP SIGNATURE-----

--Sig_/aNddZWZt3dx.2k1eFLmMqqG--

