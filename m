Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394047A9D34
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 21:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjIUT3n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 15:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjIUT3N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 15:29:13 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C42B93CB
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:05:46 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjMRC-0007Hk-Et; Thu, 21 Sep 2023 18:21:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjMRA-007yFW-9K; Thu, 21 Sep 2023 18:21:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjMR9-003gFQ-O2; Thu, 21 Sep 2023 18:21:55 +0200
Date:   Thu, 21 Sep 2023 18:21:55 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     "Greenman, Gregory" <gregory.greenman@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "mh+debian-user-german@zugschlus.de" 
        <mh+debian-user-german@zugschlus.de>,
        "exp-311223@news.muster.net" <exp-311223@news.muster.net>,
        "tychokirchner@gmail.com" <tychokirchner@gmail.com>,
        "rene@debian.org" <rene@debian.org>,
        "Juergen.bausa@online.de" <Juergen.bausa@online.de>,
        "sebastian.suchanek@gmx.de" <sebastian.suchanek@gmx.de>
Subject: Re: iwlwifi in German ICE4 trains
Message-ID: <20230921162155.peopg2ylibkwrd2p@pengutronix.de>
References: <20230423085510.xpmcuzfhzqa4dyhs@pengutronix.de>
 <c0153e5dd0459d351807002df7cef9eb30b04e86.camel@intel.com>
 <20230424042135.4xwtbobs2p5wmnjk@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lraodpvvtkmojwvh"
Content-Disposition: inline
In-Reply-To: <20230424042135.4xwtbobs2p5wmnjk@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--lraodpvvtkmojwvh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Gregory,

On Mon, Apr 24, 2023 at 06:21:38AM +0200, Uwe Kleine-K=F6nig wrote:
> first of all: thanks for your prompt response.
>=20
> On Sun, Apr 23, 2023 at 01:06:45PM +0000, Greenman, Gregory wrote:
> > Based on the log, I can understand that it had successfully connected t=
o the AP
> > (supplicant management interface state: associating -> completed);
> > then there're some DHCP errors and eventually the AP sends a deauth.
> > It's hard to say what can cause it, but if you'll be able to reproduce
> > the issue, it'd be great if you could collect a trace-cmd dump with
> > this command:
> > sudo trace-cmd record -e iwlwifi -e mac80211 -e cfg80211 -e iwlwifi_msg
>=20
> Done, see https://www.kleine-koenig.org/tmp/20230424-trace.dat for the
> resulting trace.dat file.
>=20
> > It'll be also helpfull if you'll be able to say which specific
> > modprobe option fixes the issue.
>=20
> The relevant one is
> 	options iwlwifi 11n_disable=3D1

I wonder if there is something I can do, to fix this problem. Did you
look into it? Is there something I could do to help you understand the
actual problem?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--lraodpvvtkmojwvh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmUMbaMACgkQj4D7WH0S
/k41Twf/RR8/5BNQMEyVLceL6/D8I+InbKf1Z7jT5ZWSiAkxIC79EStJr8V544U+
/KqveCweV4qGSFzpb2pCE3+eBurZM6H5Wf4BEAJDVPKrX3n7wdfRMm7Pz3hN46HT
IRI5WUl+8UQDtTL1o0oaeW5GRvFY2bgOB26BilSw7mWZrlQe5Y5loAqSfnUS2Q3x
IaUudRFF2Hq86C0jT2nGP5hA/s2HfSELgZt0jO4q/clIFatKVgpvOcC355YdJK5k
b3NMvf6T5i1BBnN4olsfctXayNRe3hpG8KYJ2WCy6qkOgX4iPEWwZZm50WTiEvn5
RwCOLA5IyigMNTU2NtE4eMlS+sowdw==
=GcRQ
-----END PGP SIGNATURE-----

--lraodpvvtkmojwvh--
