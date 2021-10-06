Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846D542425A
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Oct 2021 18:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhJFQQn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Oct 2021 12:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbhJFQQn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Oct 2021 12:16:43 -0400
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B559DC061753
        for <linux-wireless@vger.kernel.org>; Wed,  6 Oct 2021 09:14:50 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.92)
        (envelope-from <m@bues.ch>)
        id 1mY9Z0-0002Y7-VV; Wed, 06 Oct 2021 18:14:39 +0200
Date:   Wed, 6 Oct 2021 18:13:58 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] b43legacy: fix a lower bounds test
Message-ID: <20211006181358.67a23e18@wiggum>
In-Reply-To: <20211006073542.GD8404@kili>
References: <20211006073542.GD8404@kili>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/goiVgRssi9A8ba=rcm/gfDw";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/goiVgRssi9A8ba=rcm/gfDw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Oct 2021 10:35:42 +0300
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
> Fixes: 75388acd0cd8 ("[B43LEGACY]: add mac80211-based driver for legacy B=
CM43xx devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> This fix is correct, but making dead code go live can sometimes expose
> bugs which were previously hiding and is always carries a slight risk.
>=20
>  drivers/net/wireless/broadcom/b43legacy/radio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/broadcom/b43legacy/radio.c b/drivers/ne=
t/wireless/broadcom/b43legacy/radio.c
> index 06891b4f837b..fdf78c10a05c 100644
> --- a/drivers/net/wireless/broadcom/b43legacy/radio.c
> +++ b/drivers/net/wireless/broadcom/b43legacy/radio.c
> @@ -283,7 +283,7 @@ u8 b43legacy_radio_aci_scan(struct b43legacy_wldev *d=
ev)
>  			    & 0x7FFF);
>  	b43legacy_set_all_gains(dev, 3, 8, 1);
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

--Sig_/goiVgRssi9A8ba=rcm/gfDw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmFdy0YACgkQ9TK+HZCN
iw5iWA//Qsq+DuoC10lMYoTH3WkopAMR9mKhwbe5FTZUUe0eWQM3r9a7uGKGKOX2
LW47biXVl/9u0PiUulvLWklyV2Kg6QKCewOLmUHbZB7XBPW0PVf/67KRL3Y4Iz7p
0nZhcOzkv00cyoQ5wIOBcjrrqwK9+u0BgK1VUDRWd8yblOyK8jPTaIEf6x0E1VPT
1Ve7yeETJzioF8xeTCgBoY2SUUGAfZ91C/w5dtctfPkuW8RSHwqFH0553f9QICQS
z9XDBvESlPY7GLzDSXv/TulyRPqK3K+jZA5zuiOlW5XJpXiOax1xdNyq/GwcGpV7
a332WOmx4Q0Edc/183OUpx1xoIHFLQiMfs6kpmkvgoaqWdCdjzF7yTr9xXOcM3S7
YSR3Be18aarCLhGR354xz+Wbvb69IIS7hEwK7lBZwD7u6Jd/KyLU+3k77D69gdzl
y+33iLFxH1pWtsw/wGwZrPH1hl9LUE18s3S4vfKpJ4EqJ20+nIGIPgf2EPGhEaEW
IUnA5es/jscNcYdCTvfffyeKRwyo1NZhJHBslqVqF6InC+MMilFHBZo+2ZA3Swey
NBdDueAsTFF/XAdep9Y32U1l1aiXfUoVROXPFQtGnX1V7qP3Aucx1Kpt9ZPiqk4Y
QI85MyfpA7WDWEYLjBP9APcX2uI29nTHrRsztGJxx+SDycGymWU=
=mGEZ
-----END PGP SIGNATURE-----

--Sig_/goiVgRssi9A8ba=rcm/gfDw--
