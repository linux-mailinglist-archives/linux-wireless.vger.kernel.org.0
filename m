Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56F6814C3BA
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2020 00:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgA1Xuy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Jan 2020 18:50:54 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:49082 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbgA1Xuy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Jan 2020 18:50:54 -0500
Received: from camp.crustytoothpaste.net (castro.crustytoothpaste.net [75.10.60.170])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B3A3260482;
        Tue, 28 Jan 2020 23:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1580255452;
        bh=HAjq+o5KoQrhx7h7+3uyhHM6tREzzW4WtGky8ozp1d8=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=EBEv9OjzXkmsox4JFiC6l9+6VlAC/IuFntFYOUsKyHkVtstmAwFHjLUf5EOlcKrO1
         WrQbQEGzFWhsxxC2nJ8xJPfd41NE0SklzxXhowuNsIX7suDHSy4x+4pcSrRBhDRE/C
         ypRRMClou5+1xXJxCaJaJ7Q9RHn2MoUzzFd0qui5WzzPyISL2Ev86wSVn3/2vaf8/u
         3bDsieKfS8HXZrGFQsLijzZTWvnwXZl4jJAE2FPZNU20igqoA2pk6MqEJkBGCp3paV
         iOy9R6LUFsDbtgFAp92nHdp45dn5gDuqXccmPHPL7JHzoH6d/hZUE5dZvyQUIn5QFb
         u0KsP+O0C+wqGGF3SjqHyFN0w+EanpZ31OR1yQqRVO3RLYbkhErMcENc/wnHlW+TrN
         QGs3iKQE89czxwhnr8vnrKLRDiSlOEKb7dgVG2R/ip79EVjNkiYXTM/Ndl/1+WoBG1
         Y6wN9K7M8ryfXivjpTa+QpIOZo7AjF9JSKa7vP6Bz4TUQxDbdAP
Date:   Tue, 28 Jan 2020 23:50:47 +0000
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
Message-ID: <20200128235047.GJ4113372@camp.crustytoothpaste.net>
References: <20200126155108.7DDD7C433CB@smtp.codeaurora.org>
 <20200126193339.167346-1-sandals@crustytoothpaste.net>
 <16fe3b278d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <20200126230029.GI4113372@camp.crustytoothpaste.net>
 <71763ca9-ed7a-2403-b85a-d7dc624cd050@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cDtQGJ/EJIRf/Cpq"
Content-Disposition: inline
In-Reply-To: <71763ca9-ed7a-2403-b85a-d7dc624cd050@broadcom.com>
X-Machine: Running on camp using GNU/Linux on x86_64 (Linux kernel
 5.3.0-3-amd64)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--cDtQGJ/EJIRf/Cpq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-01-28 at 09:47:37, Arend Van Spriel wrote:
> On 1/27/2020 12:00 AM, brian m. carlson wrote:
> > There is also precedent for users acquiring firmware themselves via the
> > b43 and b43legacy drivers, where users have to use a script to extract
> > the firmware from other drivers.
> >=20
> > I wish I had a better answer to this, but I don't work for Broadcom or
> > anyone associated with it and am just trying to get the Mac I was given
> > for $DAYJOB to work with Linux.  Perhaps since you do you'd be willing
> > to ask them to release the firmware.
> >=20
> > The alternative is that the chip doesn't work at all (and can't be added
> > via the new_id sysfs entry because of the rambase setting) and users
> > have to compile a custom patched kernel to make their wireless card work
> > at all.  I'd really prefer to avoid that if possible, since it's
> > a strictly worse experience in every way.
>=20
> How about putting this device under some Kconfig flag. If distro kernel
> start probing the device and fail, most users will probably turn to their
> distro for help. Having a Kconfig with a good description could avoid tha=
t.
> It would mean an extra step of building the driver though.

I can certainly do that.  I don't think it provides a lot of value,
since the only benefit I see is that it avoids warning about missing
firmware that the distro can't ship.  A typical Debian system currently
warns about missing firmware for numerous other drivers (e.g., i915) at
the moment without ill consequences.

But if you'd prefer it that way, I can provide a v3 that does that.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--cDtQGJ/EJIRf/Cpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.19 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl4wyNYACgkQv1NdgR9S
9ou+mg/8Ds4gifqnQzzDmSB/GypbIBNHch7EbqNTrlnhvOEFzJZLELaPCRMbhZvx
rdUgcJoZlJ8Lgxqyk1lPO/WjlPPXw+tnqhYm/vPp20UwhPGBRa9C0bEdXOeVY+DK
QnwUQYuxnjlqOjKhXixnK1xPf64CQrWEeY8mELSByLU/k2fDsFXGGJjIKScfIiSa
gW47XHNj+wFjQYTzXjDQjj2foyp2/7GGb6i9DUwyOrEKqS05dB5JKZO4Mwnw2Q8E
ipCzVPkR9Dfq+MCnXC88v0Bg4MMQ7tgOAEgMtDvygWSvM4JibvffyNq+G6Y9MyHQ
bEcJdz6InSpcZHfRx2EL6uwsFVYtTeszeURYRB+WDNjUKRjTScodID4wvKcT3Na4
s5RyiRlTpLWR/f6/yvjgOJ3P7hpf8nVQt7eyRRdceihcVu0rTdP1xUEuqGHg/YWv
BBNLRPp8j+De1UwPRKJGgQ4dghQShIoDQ7h4qn4KmQG0l/znDRWtyy+b+3XlSJIr
5BApYyj1HtHdKFngeh0738V7wHd8cT2tPKFB9zlx5ZO1/SlIbPMwsHHcTPa7nEhy
eb5AQMPAJKYB8r1WLl+QZtwmVoIWtB7rNa4luB7lj0PyxYzP0B9PgEpOaM/MbgVM
v4EkRnT/F/tW72oCT7Ro3T/Ekc949qapMhsIi02CJeId8xa6uvI=
=iy6n
-----END PGP SIGNATURE-----

--cDtQGJ/EJIRf/Cpq--
