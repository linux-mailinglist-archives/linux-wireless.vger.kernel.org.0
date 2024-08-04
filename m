Return-Path: <linux-wireless+bounces-10889-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0218946D71
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 10:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C560B2121D
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 08:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8641CAA4;
	Sun,  4 Aug 2024 08:40:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from bues.ch (bues.ch [80.190.117.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C21CAB9;
	Sun,  4 Aug 2024 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.190.117.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722760829; cv=none; b=pEui2XvP7gABERKoEZKQp7tWH4VnOba8YndGxA/QfOg7V8o1Hje0KcNtG2iot2jB7yCjy8t3SlixGR6w4H8NJDApUq0H/rmb8xQzfBeAGfV73rGbATHVbDyEZnO6FZL3n004MrBEXkFXIQi/BLnD1vMkv9nu2YUTpEOYi/WLpkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722760829; c=relaxed/simple;
	bh=KDLsy9QoaiK6Y/X+0TMFFzpHTxsKNIRagpeaknjsurw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZIBWdX5WVyOsGiv9yn4jF89OP+daTeIy6sgodtq+CamIQLJTy6EUcPch13YruGrIwVzbD+8tsMPCDDihIZQsy3GMqwGVN6SFRrinkdhbwNwXzWWRW0yr+T+B8ONv4P0D+OKYWlzG69rbU6UUQmlz6QX7tE7+7mrrRq63RIDPVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch; spf=pass smtp.mailfrom=bues.ch; arc=none smtp.client-ip=80.190.117.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bues.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bues.ch
Received: by bues.ch with esmtpsa (Exim 4.96)
	(envelope-from <m@bues.ch>)
	id 1saWFo-00049Y-33;
	Sun, 04 Aug 2024 10:06:12 +0200
Date: Sun, 4 Aug 2024 10:05:26 +0200
From: Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Kalle Valo <kvalo@kernel.org>, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
 b43-dev@lists.infradead.org
Subject: Re: [PATCH v2] wifi: b43: Constify struct lpphy_tx_gain_table_entry
Message-ID: <20240804100526.19942fbe@barney>
In-Reply-To: <e33bc9e6dff4a5b6cd8d0ab5399aa1abac5bef9d.1722753127.git.christophe.jaillet@wanadoo.fr>
References: <e33bc9e6dff4a5b6cd8d0ab5399aa1abac5bef9d.1722753127.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UpsqFUdF5AJEbJWQ0oj=SGZ";
 protocol="application/pgp-signature"; micalg=pgp-sha512

--Sig_/UpsqFUdF5AJEbJWQ0oj=SGZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun,  4 Aug 2024 08:32:44 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> 'struct lpphy_tx_gain_table_entry' are not modified in this driver.
>=20
> Constifying this structure moves some data to a read-only section, so
> increase overall security.
>=20
> On a x86_64, with allmodconfig:
> Before:
> =3D=3D=3D=3D=3D=3D
>    text	   data	    bss	    dec	    hex	filename
>   16481	   6232	      0	  22713	   58b9	drivers/net/wireless/broadcom/b43=
/tables_lpphy.o
>=20
> After:
> =3D=3D=3D=3D=3D
>    text	   data	    bss	    dec	    hex	filename
>   22305	    395	      0	  22700	   58ac	drivers/net/wireless/broadcom/b43=
/tables_lpphy.o
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested-only.
>=20
> lpphy_write_gain_table() and lpphy_write_gain_table_bulk() could also be
> made static and removed from tables_lpphy.h, but without knowing the reas=
on
> why it is done this way, I've preferred to leave it as-is.
>=20
> Changes in v2:
>   - remove unrelated and un-needed constification   [Michael B=C3=BCsch]
>   - update numbers in the commit log


Acked-By: Michael B=C3=BCsch <m@bues.ch>


--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/UpsqFUdF5AJEbJWQ0oj=SGZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmavNkYACgkQ9TK+HZCN
iw59LxAAx5uah1po1RFYdhFEMNeDkZRN/vjPNfykHH+zmBb1qeL6ZlqaWkS8ja2u
lAMOsBdIN60E9xO2opbn6KV3Ag1ti6gVtL1inIOsdNKnIvjINe3lm7mSgiyTdMUz
oIY1halx6umYdV5CHNi/91Zrp9wcysvAfc+Uu0dWs0Qp2sZWrJQSa8ZdIf8kNyII
j/MeopgVWHHV3V8Pyugaps2bQvc1dDRnfq1hbxfAWG+QUQPzIoOvA3NqX/aImcnf
dLeoAuWxeo1v9JzEOtvIH6MFojUWHw1W2X9FPB8gDckELi8XeYwiMLi38Hark6Bg
JVAzgEx8JN9weaOpgcA8kVflKMLetSo3T73DgMM3d8E+8E4hzbVGPStL5MP4wYON
o5lyk7AswaxK3/0SZ/L6EH5anDgoJZlv/yHlzoe8pLXMk7jlM3GM0pYq1UfPh35l
SlcW6sAl12dNEGELaZqqHD189Wtm2Pf+1HP0YoJw4VkLLifY9Txf0uIFoyNWVoMw
s2kZ0JnsU7uyMjB009+BM/Dt0XCjyM/m8gMxkSVSu9zen2EbU3M1wmJ4bo+Lovqm
ffxPyx3MroDvgcLMyL40LNv1Tbjg+ynTKrE2lC7JC54YlX98bI+NUEF3FVSQUsM4
ATS47ibyPZhmzWsohHe5+NROCK5AI+GJNrVMKcBpXQBs/tRl+8Y=
=+81O
-----END PGP SIGNATURE-----

--Sig_/UpsqFUdF5AJEbJWQ0oj=SGZ--

