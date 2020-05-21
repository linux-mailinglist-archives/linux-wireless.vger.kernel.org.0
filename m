Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5101DCB3B
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 12:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgEUKqW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 06:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgEUKqV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 06:46:21 -0400
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0CAC061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 03:46:21 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.92)
        (envelope-from <m@bues.ch>)
        id 1jbiiM-0006mA-Kt; Thu, 21 May 2020 12:46:14 +0200
Date:   Thu, 21 May 2020 12:46:08 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Rui Salvaterra <rsalvaterra@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
Message-ID: <20200521124608.4b5c78f2@wiggum>
In-Reply-To: <CALjTZvYMF_ERBfzkhaHvsTu6kt7MW+L_979sOVs8hcH7zF_Nyg@mail.gmail.com>
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
        <3483242e-c2ad-ec83-0c2c-ce952bc9b638@lwfinger.net>
        <CALjTZvatxQ2BvUeZGcTFijBf1PiLizJuDdENxg2b=tPQL_NAzQ@mail.gmail.com>
        <CALjTZvYSJOx0xeMVkN6dHcGTdgW9O9NVbgXPKK4d6-31VX+0JQ@mail.gmail.com>
        <29f5e3de-a32c-6292-9197-19dcc57fa6a3@lwfinger.net>
        <CALjTZvaroTrgK9=W8uTwq9YcYayfuEU31BUc0qNYJr+08hevfg@mail.gmail.com>
        <CALjTZvaPi2FL-epk-Vd2wOLye2O0J8G5aZPsqzHXt2b7u=HyuQ@mail.gmail.com>
        <263e247c-3bf9-6d42-996b-bc513efe4b71@lwfinger.net>
        <CALjTZvauK0Hh+aoabcDX9kkQZ4zN2ZjPnB+aq7YrJ9+-4ihiAg@mail.gmail.com>
        <87fffd5d-242a-7195-c4cc-80260dbd53c5@lwfinger.net>
        <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
        <CALjTZvYMF_ERBfzkhaHvsTu6kt7MW+L_979sOVs8hcH7zF_Nyg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZtB=3+4AkPv+iRnV+pRksNN";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/ZtB=3+4AkPv+iRnV+pRksNN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 21 May 2020 10:07:38 +0100
Rui Salvaterra <rsalvaterra@gmail.com> wrote:

> Well, I'm glad I was wrong. :) With your second patch, not only MFP is
> working in WPA2, but also WPA3. And iw list shows all the cyphers as
> supported.

Great. Thank you for testing.

Should we consider defaulting hwcrypto to off?

I wonder what the performance penalty is, if any, on today's CPUs
that have some HW-crypto embedded. Of course that depends on whether we
actually use that here.

Could we have some benchmarks (throughput and CPU load wise)?
=20

--=20
Michael

--Sig_/ZtB=3+4AkPv+iRnV+pRksNN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAl7GW/AACgkQ9TK+HZCN
iw6g5xAAzZ1Lm7V8+H8yKXfhoV94nEJ23dgfyzwo8mI5zzJzhxinbGkk0ksIluej
ot3P0dsBYtw+4fLzbi5j3vKg4dzVTcwbPgDQ7TW/dnUwobMrCiLqJ6WoOIrbtJEF
OBqe7BbJtAu6D7NxuIr1zJJt+Q5uIh7FA19uyJqg5Oyxztb41dBw2/U752JvSaX/
I5aE0uBS31NrinPxAB7PIqGXp+oHb8AM9EWcBLJ6uh3Zmk7euGYoFWz8Rk/LDMva
WjzTtZG60IHTEJ7vJ1+pOC0Xeq8MgGEAb07ijarSf7FYeLvKn33p5pUZEMLU2t3A
VtD3YQHikNgJBzJCvj3KItd2cPIKgUoks6iqrfAoOZjcp+dRHtDwiN3exP6qZ+F2
8RfW46hzJj39DSE6SIwnsgBA1iKFflpr4LVF/eJP2q0lfS80KDyMDPniC8ADyrh6
XQtNAR0CrswEW5tHQxBJ5OA17w7hFwBKih8HraVDI2FfcIcYd9DUpx5YSkQNEGpN
CF3fj4dWEdcqqYSgNrvuOFrsJ/bBT15yRqdKCquTUlVIJ+CU5XmXMfVRt7ESadvx
MKjZO7o63BvreupULIc94AUyQM2sTNU2xtZNFLgQsPO2JxUYa5GaVIUKrIbBNiH4
nawx6h9tNZpdH+nQJCGTe4rohYmb824CdCyVLGdjCBtwV3mveWo=
=VH6L
-----END PGP SIGNATURE-----

--Sig_/ZtB=3+4AkPv+iRnV+pRksNN--
