Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B839C1DCC43
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 13:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbgEULkn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 07:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgEULkn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 07:40:43 -0400
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42730C061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 04:40:43 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.92)
        (envelope-from <m@bues.ch>)
        id 1jbjZ3-0007A3-1P; Thu, 21 May 2020 13:40:41 +0200
Date:   Thu, 21 May 2020 13:40:11 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
Message-ID: <20200521134011.656381ad@wiggum>
In-Reply-To: <CALjTZvan46UTwcUxOSN=RiE6XHm-29Ln8B6wiv40V_RVxWewtA@mail.gmail.com>
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
        <20200521124608.4b5c78f2@wiggum>
        <CALjTZvan46UTwcUxOSN=RiE6XHm-29Ln8B6wiv40V_RVxWewtA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AV9X9MSUSOSPOMgNOyje6wA";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/AV9X9MSUSOSPOMgNOyje6wA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 21 May 2020 12:30:43 +0100
Rui Salvaterra <rsalvaterra@gmail.com> wrote:

> Also note that this a PowerPC laptop (iBook G4).=20

That's not exactly a modern CPU, but measurements would be useful
anyway.

--=20
Michael

--Sig_/AV9X9MSUSOSPOMgNOyje6wA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAl7GaJsACgkQ9TK+HZCN
iw4hGQ//YPTU7z5h33wbU0LuzQF3mE+KOGduPHaBMAkqpFTcGrDRQWQHPLsujC1n
duRp3TG+RHAZF6Npq8nHCkhx2Q/buFeWg1e4fSvnfWVXd8r4xyt/g68a+oCpWDFq
cQkzu8bd9HKTW+rkCAZEjAz8Y1PNk05Wdy2qrUKFBm4wmpVWT2+ynIS0Cn8YIJZn
BNxtN2S6TYK++ll0EiMn+ckvsUzgGKdWx5FvycUuwmasc01ggk/AcveBFsz/oigp
VjeoROi1Sya2Tilgp48riQyra2mZIoQrp7mUboJNCebuBmw9AWpNDhwhXHjzBjXn
zVib2HRD5NhCn2J4Ko0Hoykdgv4orYzlQh+rkb3rBRvAB33forcTLxHCSKuEgBDk
sbPMaZhze58AsPF1ljfineaeS6cK/Sy7Z+eDXdF9zMCr0OmiCGDtOIMaigQVM358
dv2+z+fGX2SJmVdRAD4EYWcSCaGzAuHJDrGl3Hw0sU6eoIlalUc5AP7m8DTzMUbB
8+LAv35mQNQaLsu8SqmqTR45+X8V4jnjlMMDXd12ReAYmqtT/L9+wCeFKBUX7Es5
Zkc5TEiQ+++/0wXUHxsAuLaDk7+sm+vx5JT+s0Lcc6wZhyB/z37C5OJmVymhRXuX
Ik1qRdodu9GIYGUfPfsDBTqdIOQy91NkDlXz62AVlo+uN5WHX4I=
=11fZ
-----END PGP SIGNATURE-----

--Sig_/AV9X9MSUSOSPOMgNOyje6wA--
