Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06FF836DB75
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Apr 2021 17:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239914AbhD1PUl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Apr 2021 11:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239901AbhD1PUl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Apr 2021 11:20:41 -0400
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6EFC061573;
        Wed, 28 Apr 2021 08:19:56 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.92)
        (envelope-from <m@bues.ch>)
        id 1lblTR-0007jW-Oh; Wed, 28 Apr 2021 16:47:33 +0200
Date:   Wed, 28 Apr 2021 16:46:04 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Shubhankar Kuranagatti <shubhankarvk@gmail.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: ssb: driver_pcicore.c: Fix indentation of
 comment
Message-ID: <20210428164604.3359ac0c@wiggum>
In-Reply-To: <20210428074432.rhw4zq2vbdemglbr@kewl-virtual-machine>
References: <20210428074432.rhw4zq2vbdemglbr@kewl-virtual-machine>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3uwHmM/=O92c+TiwZfdwDWv";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/3uwHmM/=O92c+TiwZfdwDWv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 28 Apr 2021 13:14:32 +0530
Shubhankar Kuranagatti <shubhankarvk@gmail.com> wrote:

> Shifted the closing */ to the next line
> This is done to maintain code uniformity.
>=20
> Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>


Acked-by: Michael B=C3=BCsch <m@bues.ch>


--=20
Michael

--Sig_/3uwHmM/=O92c+TiwZfdwDWv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmCJdSwACgkQ9TK+HZCN
iw7ouw//WCppCsn1BML0RTBrfCUMxoEfV6sWaYsyycZROubcNqO4jcEYMFLx6kOS
FVHuMPfkZ4N+0RIzpEGvkht5+7mF4K955ILcBs2Y0esc/BoY6o9D8FWFiTZ1pWUv
IVyn/WQXpz7FVnahD1rDtwjVrMY85klP2KRku2zGnVW/E//A0y7q19/40DWRgp94
M+D16QCbGB4m7KjiS1jf9OW9jQSAfUZgbx0EkhxWqGt/aPKc0HpdV3u95X9Gui24
KQwUJurveQzecV7Q4YCLYThPqW4sfhMdv8/A+FP2EAb11BfAlrPm4fwiAwAIx8Q9
JSgm6V2nbIfcFi9wZGbl3fMsdabSvc1RpDnYrKfEKCOp8eUMchAyLFhJqgHFZ38y
9PukG+tftiSNHqJHM9nzHNj6n7t2PN+YqMruCZ5Ci0DByYJ1agAjHlsAG/wddc9u
cVb4movq9WpUDr2rec/fmJlcdWevYGyxLTVs+1LOIe1ZN9CmhRUdh3EarVPrIl5M
uZncCSfLkTu6hMQa4NY2a1Hr7OfLa8kZaJoCkr0J7C16c3BTpLPzZuWSDLtGDXfv
NKlDFrfrRuRgm+aCPO4LoMXWnx1u6Cyo3XHvRp0DAici/ajGRB9wDjLSMYAUDnoM
cL6HybleLmTY08f0QV6UqoozF+LbE3ahJEgoKQg1QWlfTL/wW6s=
=1JjS
-----END PGP SIGNATURE-----

--Sig_/3uwHmM/=O92c+TiwZfdwDWv--
