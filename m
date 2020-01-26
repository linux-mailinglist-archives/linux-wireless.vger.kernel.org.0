Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27992149D78
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2020 00:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgAZXAg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Jan 2020 18:00:36 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47656 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726443AbgAZXAg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Jan 2020 18:00:36 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 2ADB96044F;
        Sun, 26 Jan 2020 23:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1580079635;
        bh=jPHvpsFb5iIpr03nA8BbdnRf1GWh3y+ijCWCjrYA2/o=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=GD1tC3Z15VwY0xqKPaTBIzpIhRfk5oLopUhlV6g6zxDEe1/bz75fSiwLwnsq5O8Ms
         /xLSsRwbRsOkq9hvz3dLwGscSSEVp17zJ+Q0pTjbOnIqb7iYcQTsGQAxHFCQvz2WSc
         /uHZFuzti3+YnueTwPm07PVH23B/jLalhynxqCUwfAk0JkTdxziLw8ZUttcgQdtz7W
         T5MwwLdxYvwBTqb8Bkfn+Q2VNeOLH0Zw/aevxN8O3P+E+RkGzJc+DtJgMQ3OpLV8gw
         o73VvFUvlTYYh1HzUVntDe2K32at7FrC0KGVU3/oaBDRw6exPfJDoY7Dpchu4p2DAJ
         0YMMT0+oqZYwHSVJ3KYtWQLGCph5qKKep51h2PbhH3HW7RkkS70ea8sL4I+j/aW97b
         7qfoADK1gxrPTyjtkYBhggBj4i/FtQ+vfPee32W+V01FmQaJ2q5KDnHCTdqlALdH9e
         J/VxVu0hsTe/7duPhKNk7Fg7hI/vsOL4O65TgdGvLhbGlAFw+9k
Date:   Sun, 26 Jan 2020 23:00:29 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>
Subject: Re: [PATCH v2] brcmfmac: add the BRCM 4364 found in MacBook Pro 15,2
Message-ID: <20200126230029.GI4113372@camp.crustytoothpaste.net>
References: <20200126155108.7DDD7C433CB@smtp.codeaurora.org>
 <20200126193339.167346-1-sandals@crustytoothpaste.net>
 <16fe3b278d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CNK/L7dwKXQ4Ub8J"
Content-Disposition: inline
In-Reply-To: <16fe3b278d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--CNK/L7dwKXQ4Ub8J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-26 at 21:12:02, Arend Van Spriel wrote:
> On January 26, 2020 8:34:18 PM "brian m. carlson"
> <sandals@crustytoothpaste.net> wrote:
>=20
> > The 2018 13" MacBook Pro (MacBookPro15,2) has a Broadcom chip, the 4364.
> > This chip appears to be specific to Apple and is not found in other
> > hardware.
> >=20
> > Add this chip to the brcmfmac driver so that it can be recognized
> > automatically.  Note that the PCI device id is 4464 even though the chip
> > is referred to as the 4364.
>=20
> So what is the plan regarding firmware. In the previous patch you mention=
ed
> it can be copied from macos, but I am not sure if that is acceptable from
> legal perspective. At least Linux distributions will have problem with th=
at
> for sure.

I don't have a way to solve that problem.  The firmware copyright
presumably belongs to Broadcom and they would be able to grant that
permission or ship firmware through the normal channels.

As far as I know, this chip only comes with Apple systems, so users will
acquire the system with macOS.  I'm not aware of any legal reason that a
user cannot copy the firmware from one location on their hard disk to
another, so users will probably be able to legally use the firmware,
even if it's not shipped with distros.

There is also precedent for users acquiring firmware themselves via the
b43 and b43legacy drivers, where users have to use a script to extract
the firmware from other drivers.

I wish I had a better answer to this, but I don't work for Broadcom or
anyone associated with it and am just trying to get the Mac I was given
for $DAYJOB to work with Linux.  Perhaps since you do you'd be willing
to ask them to release the firmware.

The alternative is that the chip doesn't work at all (and can't be added
via the new_id sysfs entry because of the rambase setting) and users
have to compile a custom patched kernel to make their wireless card work
at all.  I'd really prefer to avoid that if possible, since it's
a strictly worse experience in every way.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--CNK/L7dwKXQ4Ub8J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4uGg0ACgkQv1NdgR9S
9osoRhAAsAMjTYBIENYFnQ+z1qi5v4aJrxoW01vQo+bOktFu9n7j07E0y8Xe5vBM
av36ZazqbqvThFUS3qfJoW8+kqFP95mnrKSEy7jdKNz63S7NlvNY0omadAIl1/TX
czMV0qvcNnEHqfdYq/F1eixZiAKTbKXItNirkBdcqGyFnfpkBnkl5Jj+NvR/oV5Z
gvppaGKsh9mXk+UGOycwggC5pGS8wlo0UdvqOOlJSxTQYsrU5LgSuaWJAXZhhzZa
Bt0cyFTkWn4HF9Z/AhqiWsSkzcOmsP+CcVvrYdo2Pkh8UVmtiMYqLhpHAmpaBh11
q2C6iN+M/A5syJcGH8IKj+U+bD5ciLFhnXVkKXs7TWh+wbAqOxSAtrL08XzabsrH
Zrb82enS5GWyBRgiaJHBgYe35NPUssoJdefgiRSFE2kP2bQZUrpvkoOKdgDxW9Wk
/zu2tUDOtcDoDaGsHZ/B0KqZwfhI98J39OmRUaVv0YqBu4uVsvUfhYj15yzspk3g
T2KvBmdh2l1AoSSMfMWCtDJHQwpxWydcW7EXD+3VyxqxxXaSkCLso3v4kGZALAYo
GGwMyVoJJ4DnEi164FFToABmh8oZ5Uja7W79Q5LkW6WzLWThGhLN3FhnDLLpOR7T
zfFHFBaSoVg+LSRKEW0HDKOMVxhiSJtk1STk3smpp3qamSiW5nY=
=cYDC
-----END PGP SIGNATURE-----

--CNK/L7dwKXQ4Ub8J--
