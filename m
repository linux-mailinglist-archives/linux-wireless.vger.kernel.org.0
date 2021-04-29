Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E136336EEC7
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Apr 2021 19:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237244AbhD2RXD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Apr 2021 13:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbhD2RXD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Apr 2021 13:23:03 -0400
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05130C06138B;
        Thu, 29 Apr 2021 10:22:16 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.92)
        (envelope-from <m@bues.ch>)
        id 1lcAMU-0001MZ-Jx; Thu, 29 Apr 2021 19:22:02 +0200
Date:   Thu, 29 Apr 2021 19:21:22 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] ssb: Remove redundant assignment to err
Message-ID: <20210429192122.56acf711@wiggum>
In-Reply-To: <1619693230-108804-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1619693230-108804-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2V4K/B7ucivuZf+W3L2fsGM";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/2V4K/B7ucivuZf+W3L2fsGM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Apr 2021 18:47:10 +0800
Yang Li <yang.lee@linux.alibaba.com> wrote:

> Variable 'err' is set to zero but this value is never read as it is
> overwritten with a new value later on, hence it is a redundant
> assignment and can be removed.
>=20
> Clean up the following clang-analyzer warning:
>=20
> drivers/ssb/main.c:1306:3: warning: Value stored to 'err' is never read
> [clang-analyzer-deadcode.DeadStores]
> drivers/ssb/main.c:1312:3: warning: Value stored to 'err' is never read
> [clang-analyzer-deadcode.DeadStores]
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  drivers/ssb/main.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/ssb/main.c b/drivers/ssb/main.c
> index 0a26984..ab23554 100644
> --- a/drivers/ssb/main.c
> +++ b/drivers/ssb/main.c
> @@ -1303,13 +1303,11 @@ static int __init ssb_modinit(void)
>  	if (err) {
>  		pr_err("Broadcom 43xx PCI-SSB-bridge initialization failed\n");
>  		/* don't fail SSB init because of this */
> -		err =3D 0;
>  	}
>  	err =3D ssb_host_pcmcia_init();
>  	if (err) {
>  		pr_err("PCMCIA host initialization failed\n");
>  		/* don't fail SSB init because of this */
> -		err =3D 0;
>  	}
>  	err =3D ssb_gige_init();
>  	if (err) {


The assignment is there just as a visual guide to tell the reader that
we ignore the error.
However, there's also a comment that says the same thing. Therefore:

Acked-by: Michael B=C3=BCsch <m@bues.ch>

--=20
Michael

--Sig_/2V4K/B7ucivuZf+W3L2fsGM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmCK6xIACgkQ9TK+HZCN
iw4TsBAApcU9A/M/yPldF+nzyK7yf5LvDfQGGmvF+iX8QZLo80xZvVEW+MJjm0+o
jj4k1KuIzmb+c03FizX6CnbpKvcCYZ7D1UObt+OjBSlhPDer6SFsUHgVzaVI7TaS
Ryi8rlIU+K2PPIM713rc25+D7wK+XotMYMFlZobj75YBoJwYSiyPOYcWnWtCYp/Q
fFjyQQFlstZuvc0gZicPLrhi6bVynmQsm6eqItQMWJgEqWqLOpq/xCw9Ug6J/n33
b7H6QvAY+orrfl3Su92QWxmN6EVoeWbVWfD7sw0zcxYWW+3I9OoVP3A+2mFpuiLN
VoqPsw+R/KrPLSgfzff2i+CXwirYSDtNQSVHIu9FsbPfIoF2xEn3x0tJniqG8O1Y
sLOpYABMCOOVtZtd5QV+G05UKAwr2JFg/eaaPdbnUn8uiOIbLnSyn50PZOCUTljt
hDu9ptXZBmhkyJ47ypH3xsYz7Luc6ftHIwNr9VS0tC2J/el9ymvXFxSfZDDEKC9J
vtRya1cJWyRQzNpondBAHZaaHHnxT2cdV0pRIutoFgXXJC7Chwa/rsP6e45ARxEJ
NrNrpylFZmQ9saaD3Ax6cnYFzIRHr3wceGRpVRjicjbf3l6YkYK8/WUxzPCkSRBr
fa8iXCxpieyogCz/ODXZDWhH87NBUGS7Ix2/Icvvhi5AHXxvmyU=
=rOhK
-----END PGP SIGNATURE-----

--Sig_/2V4K/B7ucivuZf+W3L2fsGM--
