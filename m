Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF0679D9D9
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Sep 2023 22:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbjILUBZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Sep 2023 16:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjILUBY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Sep 2023 16:01:24 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F87FE4B
        for <linux-wireless@vger.kernel.org>; Tue, 12 Sep 2023 13:01:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qg9ZW-0007RT-PH; Tue, 12 Sep 2023 22:01:18 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qg9ZW-005qVs-9g; Tue, 12 Sep 2023 22:01:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qg9ZV-0019cq-MS; Tue, 12 Sep 2023 22:01:17 +0200
Date:   Tue, 12 Sep 2023 22:01:17 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH net-next] wifi: ti/wlcore: Convert to platform remove
 callback returning void
Message-ID: <20230912200117.5ygpaucixihppg65@pengutronix.de>
References: <20230912171249.755901-1-u.kleine-koenig@pengutronix.de>
 <87sf7jcnll.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ebwt7imbll6jyb7y"
Content-Disposition: inline
In-Reply-To: <87sf7jcnll.fsf@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--ebwt7imbll6jyb7y
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Sep 12, 2023 at 08:23:18PM +0300, Kalle Valo wrote:
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> writes:
>=20
> > The .remove() callback for a platform driver returns an int which makes
> > many driver authors wrongly assume it's possible to do error handling by
> > returning an error code.  However the value returned is (mostly) ignored
> > and this typically results in resource leaks. To improve here there is a
> > quest to make the remove callback return void. In the first step of this
> > quest all drivers are converted to .remove_new() which already returns
> > void.
> >
> > wlcore_remove() returned zero unconditionally. With that converted to
> > return void instead, the wl12xx and wl18xx driver can be converted to
> > .remove_new trivially.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/net/wireless/ti/wl12xx/main.c   | 6 +++---
> >  drivers/net/wireless/ti/wl18xx/main.c   | 2 +-
> >  drivers/net/wireless/ti/wlcore/main.c   | 6 ++----
> >  drivers/net/wireless/ti/wlcore/wlcore.h | 2 +-
> >  4 files changed, 7 insertions(+), 9 deletions(-)
>=20
> wireless patches go to wireless-next, not net-next. But no need to
> resend because of this.

So for the next patch to drivers/net/wireless: I should write "[PATCH
wireless-next]" in the Subject? Do the other special rules for net-next
apply to wireless-next, too? (E.g. that I must not send patches for
-next during the merge window and the rules about comments.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ebwt7imbll6jyb7y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUAw4wACgkQj4D7WH0S
/k7zQwgAj3eUZ0jf3+FFz8zPoIlE9CSdX0aoTeRvhCunDnnVQTQrAwxfUZbNin7p
A7qPEwr6CFh8V0HtOY9X2vOuqIqRkBeL9HoSzgb/AlJbKpgs89yWZjeVkp2jutTc
zBVGWBA/LyX5ihs095B6BnoDPqMtCmycQJmX2ofceG7DjEzvL33lHrflMF5Bb9Eu
pAd03c5lJ7blUZbVlIexih20TWBDGpzxW7SzWr/G34ua+FjCQoLDbw+Zd9JFOABW
eotxl73BbFSobXoyUDhVHNdGAcxbt0Xb0mZfPloImXj79bN62kBRlCXtLXF43ytm
s5W5ABjH20Y8nxmPklwyA9LPYc7pfQ==
=otqT
-----END PGP SIGNATURE-----

--ebwt7imbll6jyb7y--
