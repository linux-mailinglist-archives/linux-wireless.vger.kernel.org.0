Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF94391667
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Aug 2019 13:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfHRLqy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Aug 2019 07:46:54 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56418 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbfHRLqy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Aug 2019 07:46:54 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id 5EFF381381; Sun, 18 Aug 2019 13:46:39 +0200 (CEST)
Date:   Sun, 18 Aug 2019 13:46:51 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>, nekit1000@gmail.com,
        mpartap@gmx.net, Merlijn Wajer <merlijn@wizzup.org>,
        "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>
Subject: Re: wifi on Motorola Droid 4 in 5.3-rc2
Message-ID: <20190818114651.GB32205@amd>
References: <20190818104629.GA27360@amd>
 <CAOf5uwnUx3mtGGHFGqKB30qcb_AMhMEhHLp2pf-4pUdhi7KP7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
In-Reply-To: <CAOf5uwnUx3mtGGHFGqKB30qcb_AMhMEhHLp2pf-4pUdhi7KP7w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > First, I guess I should mention that this is first time I'm attempting
> > to get wifi going on D4.
> >
> > I'm getting this:
> >
> > user@devuan:~/g/ofono$ sudo ifconfig wlan0 down
> > user@devuan:~/g/ofono$ sudo ifconfig wlan0 up
> > user@devuan:~/g/ofono$ sudo iwlist wlan0 scan
> > wlan0     Interface doesn't support scanning.
> >
>=20
> Try to use iw command. iwlist use an obsolete interface that you need
> to activate in kernel for back compatibility with old command. Can be
> your problem?

Two more reboots (with no changes in the config) and wifi now
works. Thanks!
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1ZOqsACgkQMOfwapXb+vJeKgCgszMHogT0O+ruZtqWBP12TiL9
+ksAoKsdUdt9JhrYHrfPq4rbghETIMap
=hXX3
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
