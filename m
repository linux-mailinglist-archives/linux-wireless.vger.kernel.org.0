Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22516EC452
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 06:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjDXEVs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Apr 2023 00:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDXEVr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Apr 2023 00:21:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3066271C
        for <linux-wireless@vger.kernel.org>; Sun, 23 Apr 2023 21:21:44 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pqnht-00060j-Ce; Mon, 24 Apr 2023 06:21:41 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pqnhr-00DOXE-LB; Mon, 24 Apr 2023 06:21:39 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pqnhq-00FikL-De; Mon, 24 Apr 2023 06:21:38 +0200
Date:   Mon, 24 Apr 2023 06:21:35 +0200
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
Message-ID: <20230424042135.4xwtbobs2p5wmnjk@pengutronix.de>
References: <20230423085510.xpmcuzfhzqa4dyhs@pengutronix.de>
 <c0153e5dd0459d351807002df7cef9eb30b04e86.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ztqlfrzktcl5rjzz"
Content-Disposition: inline
In-Reply-To: <c0153e5dd0459d351807002df7cef9eb30b04e86.camel@intel.com>
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


--ztqlfrzktcl5rjzz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Gregory,

first of all: thanks for your prompt response.

On Sun, Apr 23, 2023 at 01:06:45PM +0000, Greenman, Gregory wrote:
> Based on the log, I can understand that it had successfully connected to =
the AP
> (supplicant management interface state: associating -> completed);
> then there're some DHCP errors and eventually the AP sends a deauth.
> It's hard to say what can cause it, but if you'll be able to reproduce
> the issue, it'd be great if you could collect a trace-cmd dump with
> this command:
> sudo trace-cmd record -e iwlwifi -e mac80211 -e cfg80211 -e iwlwifi_msg

Done, see https://www.kleine-koenig.org/tmp/20230424-trace.dat for the
resulting trace.dat file.

> It'll be also helpfull if you'll be able to say which specific
> modprobe option fixes the issue.

The relevant one is
	options iwlwifi 11n_disable=3D1

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ztqlfrzktcl5rjzz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRGA84ACgkQj4D7WH0S
/k44Sgf/eiYLuPtHGr23vMMIGj9j38PkBpMbMY5BhkH/g3wVJYN9Zozcm/M1yklc
KznQrXJKBvOEKgvRLIiUOKyOt5WpK6LqnQdhy9qbiFlRFQYtyyqus7IAJjP1GoAS
JQsbC9BTNFeotk9uyyqII+R7Wp+o385gTGWku5JqKghkRdGVwJEimZVcJtq8Ev9J
BmrN3HD36SMf9OcSpFpazM13wBc2wXHV8ch9VVLZNCquONNHVJrjW8PJN0ctKUyY
h+nPWVM6Jyv+/5InkBzhm/gL9nlRbxyeknxBqliHtGU2X3ISHws6RKz9GrdIf5g5
oPJ7l1n9huw5Ox78tMdsJe8knjeZwQ==
=MqfJ
-----END PGP SIGNATURE-----

--ztqlfrzktcl5rjzz--
