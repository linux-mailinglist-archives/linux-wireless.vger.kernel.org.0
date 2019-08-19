Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC61691FEB
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2019 11:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfHSJTo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Aug 2019 05:19:44 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:46955 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfHSJTo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Aug 2019 05:19:44 -0400
Received: by atrey.karlin.mff.cuni.cz (Postfix, from userid 512)
        id BF9CA815D4; Mon, 19 Aug 2019 11:19:28 +0200 (CEST)
Date:   Mon, 19 Aug 2019 11:19:41 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>, nekit1000@gmail.com,
        mpartap@gmx.net, Merlijn Wajer <merlijn@wizzup.org>,
        "open list:TI WILINK WIRELES..." <linux-wireless@vger.kernel.org>
Subject: Re: wifi on Motorola Droid 4 in 5.3-rc2
Message-ID: <20190819091941.GA21072@amd>
References: <20190818104629.GA27360@amd>
 <CAOf5uwnUx3mtGGHFGqKB30qcb_AMhMEhHLp2pf-4pUdhi7KP7w@mail.gmail.com>
 <20190818114332.GA32205@amd>
 <87h86elgaa.fsf@tynnyri.adurom.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <87h86elgaa.fsf@tynnyri.adurom.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2019-08-18 17:06:05, Kalle Valo wrote:
> Pavel Machek <pavel@ucw.cz> writes:
>=20
> > On Sun 2019-08-18 12:53:01, Michael Nazzareno Trimarchi wrote:
> >> Hi
> >>=20
> >> On Sun, Aug 18, 2019 at 12:46 PM Pavel Machek <pavel@ucw.cz> wrote:
> >> >
> >> > Hi!
> >> >
> >> > First, I guess I should mention that this is first time I'm attempti=
ng
> >> > to get wifi going on D4.
> >> >
> >> > I'm getting this:
> >> >
> >> > user@devuan:~/g/ofono$ sudo ifconfig wlan0 down
> >> > user@devuan:~/g/ofono$ sudo ifconfig wlan0 up
> >> > user@devuan:~/g/ofono$ sudo iwlist wlan0 scan
> >> > wlan0     Interface doesn't support scanning.
> >> >
> >>=20
> >> Try to use iw command. iwlist use an obsolete interface that you need
> >> to activate in kernel for back compatibility with old command. Can be
> >> your problem?
> >
> > Let me see ... CONFIG_CFG80211_WEXT was not set.
> >
> > Tried enabling it, and now I got. I remember getting it before,
> > too... let me try few more boots, perhaps it is random.
>=20
> >From developers' point of view WEXT is ancient and untested, everybody
> should switch to nl80211. So I strongly using iw (which uses nl80211).
> Of course this nothing to do with the wlcore warning you saw, just
> wanted to make you aware the state of wireless extensions.

You may want to add this to Kconfig test... and maybe it would be good
to mention iwconfig there, for easier grepping.

I'm using rather old distro; I'll update, but kernel is expected to be
back-compatible.. and tested :-).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl1aaa0ACgkQMOfwapXb+vLfxgCgwnUj/6zNjDP8mVxxlrKZK1lM
pPoAnRZSZcbtXRDj7ieMQtZo77crQdVF
=S9kP
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
