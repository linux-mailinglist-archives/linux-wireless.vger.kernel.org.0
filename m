Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CA9424259
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Oct 2021 18:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239342AbhJFQQl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Oct 2021 12:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbhJFQQk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Oct 2021 12:16:40 -0400
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AE3C061746
        for <linux-wireless@vger.kernel.org>; Wed,  6 Oct 2021 09:14:48 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.92)
        (envelope-from <m@bues.ch>)
        id 1mY9Z1-0002Y7-Es; Wed, 06 Oct 2021 18:14:39 +0200
Date:   Wed, 6 Oct 2021 18:13:34 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Kalle Valo <kvalo@codeaurora.org>, kernel-janitors@vger.kernel.org,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
Subject: Re: [PATCH 2/2] b43: fix a lower bounds test
Message-ID: <20211006181334.621ac10c@wiggum>
In-Reply-To: <20211006073621.GE8404@kili>
References: <20211006073542.GD8404@kili>
        <20211006073621.GE8404@kili>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QqtpiT/CB7f5fqDpH1ja61U";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/QqtpiT/CB7f5fqDpH1ja61U
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Oct 2021 10:36:22 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The problem is that "channel" is an unsigned int, when it's less 5 the
> value of "channel - 5" is not a negative number as one would expect but
> is very high positive value instead.
>=20
> This means that "start" becomes a very high positive value.  The result
> of that is that we never enter the "for (i =3D start; i <=3D end; i++) {"
> loop.  Instead of storing the result from b43legacy_radio_aci_detect()
> it just uses zero.
>=20
> Fixes: ef1a628d83fc ("b43: Implement dynamic PHY API")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/net/wireless/broadcom/b43/phy_g.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/broadcom/b43/phy_g.c b/drivers/net/wire=
less/broadcom/b43/phy_g.c
> index d5a1a5c58236..ac72ca39e409 100644
> --- a/drivers/net/wireless/broadcom/b43/phy_g.c
> +++ b/drivers/net/wireless/broadcom/b43/phy_g.c
> @@ -2297,7 +2297,7 @@ static u8 b43_gphy_aci_scan(struct b43_wldev *dev)
>  	b43_phy_mask(dev, B43_PHY_G_CRS, 0x7FFF);
>  	b43_set_all_gains(dev, 3, 8, 1);
> =20
> -	start =3D (channel - 5 > 0) ? channel - 5 : 1;
> +	start =3D (channel > 5) ? channel - 5 : 1;
>  	end =3D (channel + 5 < 14) ? channel + 5 : 13;
> =20
>  	for (i =3D start; i <=3D end; i++) {

Nice finding.

Acked-by: Michael B=C3=BCsch <m@bues.ch>


--=20
Michael

https://bues.ch/

--Sig_/QqtpiT/CB7f5fqDpH1ja61U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmFdyy4ACgkQ9TK+HZCN
iw4crQ//YkcAD+VIJxm2yzxA85cp8FKUG68UeFSuTudaxcEmwNxvgoM29sYjEk0C
zT2gP0KOGrJ5WcjSEVeHs0x8MNJ0mjby9YYGJ30ggM4Mz/jWABF9SckOs4Vou2XA
ssWJGPu9Qp44BbQrrJpds81piTlEjPtBuzAusYN58NfnHnI3jSOT+gPw59sQ17Re
X7qRCRdNkTejmyE7FtZ19/r0zHhtxJ/cVeSewYRrPdrXr7mIMbXIQeQffRczoGER
4ntZUyHSOTamVrwDNr6X1sg7+p2jYwN2PmQyhH53NYQZcdHEhWcPa9iFBIdBCUyb
CXRVP+uZ1nmQ/muZ+tf85Wbm651RN8B20y3eoABozHOVST0wZAs0t5Ql7H1CJsWh
3160MN9nzRG2rCuuXq5MIHzHv8QvPEIH5oev2lzBzH+O4iAjY6J07SKc1ajJtvlt
fsfw3WsenslRrUE33js3mM3M8ZMxG0uV8QGbDsIY+xQo6zumN2hja5qaonYnUpkt
ZRZM2kA+qTkNvsq0ZaRwiGQnCPpPGT5GCPsZ61woeL1NLPlAq1/nNsPG9skP38Om
3FiwBuz7jbawgO+FOeizDmC1/rz2shzcQ1MLsHa2AvIYPQF9Zmg8VoNpCIBwddgo
s6GbKK+1Mt0MOprjl8vAh7IaP02JYtecWFN0E5r9L5gGLqHRP5g=
=o5Qg
-----END PGP SIGNATURE-----

--Sig_/QqtpiT/CB7f5fqDpH1ja61U--
