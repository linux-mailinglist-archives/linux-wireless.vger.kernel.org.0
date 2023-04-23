Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3706EBE1D
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Apr 2023 10:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjDWIz0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Apr 2023 04:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjDWIzZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Apr 2023 04:55:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6AA1BDF
        for <linux-wireless@vger.kernel.org>; Sun, 23 Apr 2023 01:55:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pqVV3-0007h4-A5; Sun, 23 Apr 2023 10:55:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pqVV1-00DD1z-3a; Sun, 23 Apr 2023 10:55:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pqVV0-00FWQi-DY; Sun, 23 Apr 2023 10:55:10 +0200
Date:   Sun, 23 Apr 2023 10:55:10 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Gregory Greenman <gregory.greenman@intel.com>
Cc:     =?utf-8?Q?J=C3=BCrgen?= Bausa <Juergen.bausa@online.de>,
        Marc Haber <mh+debian-user-german@zugschlus.de>,
        Rene Engelhard <rene@debian.org>,
        Tycho Kirchner <tychokirchner@gmail.com>,
        Sebastian Suchanek <sebastian.suchanek@gmx.de>,
        Paul Muster <exp-311223@news.muster.net>,
        linux-wireless@vger.kernel.org
Subject: iwlwifi in German ICE4 trains
Message-ID: <20230423085510.xpmcuzfhzqa4dyhs@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xwimo4lh5mopwzk5"
Content-Disposition: inline
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--xwimo4lh5mopwzk5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Gregory,

there is a thread on debian-user-german@lists.debian.org[1] about
broken wifi on Thinkpads when they are supposed to be connected to the
hotspots available in ICE4 trains. The mailing lists language is German
and the thread is long, so I sum up the problem:

- It only affects the wifi equipment in ICE4 trains, the older ones work
  fine.

- Can be seen at least on
  - J=FCrgen's laptop (Intel Corporation Wireless 8260 [8086:24f3] (rev 3a))
  - Marc's Thinkpad X260 (Intel Corporation Wireless 8260 [8086:24f3] (rev =
3a))
  - Uwe's Thinkpad T460p (Intel Corporation Wireless 8260 [8086:24f3] (rev =
3a))

- Other Thinkpads with a Realtek-Chip doesn't show the problem

- Works on puppy-Linux with 4.19.23, however Debian with 4.19.0-18 is
  also broken.

- The OP provided a syslog dump at
  https://lists.debian.org/msgid-search/75ad7ff2-ef25-90cd-2cb3-1f49f3e4909=
e@online.de

  I don't reproduce it here, but the gist seems to be:

	Jun 23 15:44:53 lina kernel: [ 1006.011129] wlp1s0: deauthenticated from 3=
c:51:0e:56:32:80 (Reason: 2=3DPREV_AUTH_NOT_VALID)

- it seems to help to do:
  $ cat /etc/modprobe.d/iwlwifi.conf
  options iwlwifi 11n_disable=3D1 swcrypto=3D0 bt_coex_active=3D0 power_sav=
e=3D0
  options iwlmvm power_scheme=3D1
  options iwlwifi d0i3_disable=3D1
  options iwlwifi uapsd_disable=3D1
  options iwlwifi lar_disable=3D1

I added all participants of said thread to Cc, in case I forgot
something relevant.

Tomorrow I might have the opportunity to test and reproduce the problem
(I don't know if my train will be an ice4 or one of the older ones
though.)

I wonder if there is something you want me to test. Without further
input I will try with the modprobe options and check for a minimal
subset of them that makes the problem disappear.

Is there something I can do to make the problem better understandable
for someone who knows about the hardware? Or to find out the critical
detail about the wifi hotspot that triggers the problem?

Best regards
Uwe

[1] https://lists.debian.org/msgid-search/da8c1552-6bcb-14c3-0e86-abcb835ec=
350@online.de

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xwimo4lh5mopwzk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRE8m0ACgkQj4D7WH0S
/k7pkQgAtDOTytreGctMiZszEfN09fM6JxA/tl/gB4CcjQ9wRDbc+M62eLqYI7U1
gIpY2ssXJbqkZzEDTlUbL/vXr62miSZqoXcmGoI1LlTfOdbh4c7oHtpIWG4KKGs/
P3+TTefVdJ0qteDTLn1RU/bAcOTfT0ncjPp6mv593LWvhxdc6ruG4I4/o6eVImvd
JHhXcpyl55f1icQl2FH8Kc0vYJGza7R+Cicmj5muadSCVEFmTVbXGplib+nZ4rIU
EyHk7Dgt6/M08tdVXxPnFgCBpymNPvhzDrmd09hoTWHEUkckqpFU4ivVht5rQI1O
1DPnujqJZgaogKi3EVtYkFwMEQE3vg==
=GhGq
-----END PGP SIGNATURE-----

--xwimo4lh5mopwzk5--
