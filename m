Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FFF36DB73
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Apr 2021 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbhD1PUk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Apr 2021 11:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239851AbhD1PUj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Apr 2021 11:20:39 -0400
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C92C061573;
        Wed, 28 Apr 2021 08:19:53 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.92)
        (envelope-from <m@bues.ch>)
        id 1lblTS-0007jW-4c; Wed, 28 Apr 2021 16:47:34 +0200
Date:   Wed, 28 Apr 2021 16:41:17 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Shubhankar Kuranagatti <shubhankarvk@gmail.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanjanasrinidhi1810@gmail.com, shubhankar.vk@gmail.com
Subject: Re: [PATCH] drivers: ssb: main.c: Fix indentation of comment
Message-ID: <20210428164117.5d9d36a2@wiggum>
In-Reply-To: <20210428072453.obrjwxus3u2ytpgn@kewl-virtual-machine>
References: <20210428072453.obrjwxus3u2ytpgn@kewl-virtual-machine>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/9dv.WcsY/Y+AIANTyP1/i6v";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/9dv.WcsY/Y+AIANTyP1/i6v
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Apr 2021 12:54:53 +0530
Shubhankar Kuranagatti <shubhankarvk@gmail.com> wrote:

> Shifted the closing */ to the next line
> This is done to maintain code uniformity.
>=20
> Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>

Acked-by: Michael B=C3=BCsch <m@bues.ch>


--=20
Michael

--Sig_/9dv.WcsY/Y+AIANTyP1/i6v
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmCJdA4ACgkQ9TK+HZCN
iw5vWhAAoy9hIBG2YSeiEhBk+OEJHlwSDVbVM7+GRAQyyzJEDFYoyXYXGCtnGbw6
mmsbsH4NkAdmIzuq/ab4ZHKiodpXLg7/0d4sPO5UjdGR9yi07D+pgJMfE/6//0eH
WFjvuJrXikJP38lBVCwGR9rEkuikXUwbI+wIxC3Onj6lxwHT5yzMypGI7nLaJ9iC
ibo455+PbSgXZOGfyBD1UO1auns5OFfIJI46TiyzfVs8Pls461K/rqP1UEp7eUa6
IAUj9IQ18Wtx/y3a8YYa/nSdm75fySg2PF9k9lxaVjZ7LihpbXs8NoeUlx1F1ckb
VbXS6xMb/ON43KplqYUzOXzxt9jC5TXV1ZWPdeMV9Dc7JqqooXT6+ulxhSHte76R
Z/byw3znRnv261ZPc2M2SWj3McCrxNcgBmO7LvfPnSIp4uvQXigDgMfdzzblE7PG
fvt2UMWO2m/hQFpkTBU2dgAUtYI/M0NjsTd9lJod8s7GrrjzrS/1jKiv5z3AwrQm
YYeyuuBSP/SGGOSafdTDTNBursIg4FLMSWNuj16YWOLDwvedH7NVeyP9XuoEomol
8gQtyo3h8RqfPydZKubZhACDHDT1ppWHXAudWPzrowxwIFd2qnwK0wUgc/4WK/LF
gnHCO/VlFf95lBlxuQiB9IAefNtR0VG6cySMe3/ticfmSPWTMU4=
=4JUh
-----END PGP SIGNATURE-----

--Sig_/9dv.WcsY/Y+AIANTyP1/i6v--
