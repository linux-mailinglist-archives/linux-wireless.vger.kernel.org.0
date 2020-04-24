Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3231B8270
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Apr 2020 01:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726059AbgDXX2x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 19:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDXX2w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 19:28:52 -0400
X-Greylist: delayed 1333 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Apr 2020 16:28:52 PDT
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0DEC09B049;
        Fri, 24 Apr 2020 16:28:52 -0700 (PDT)
Received: by bues.ch with esmtpsa (Exim 4.92)
        (envelope-from <m@bues.ch>)
        id 1jS7P1-0005Hg-8R; Sat, 25 Apr 2020 01:06:35 +0200
Date:   Sat, 25 Apr 2020 01:05:05 +0200
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     John Oldman <john.oldman@polehill.co.uk>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] :ssb sprom.c: Fixed block comments coding style issues
Message-ID: <20200425010505.586bbad4@wiggum>
In-Reply-To: <20200424175043.16261-1-john.oldman@polehill.co.uk>
References: <20200424175043.16261-1-john.oldman@polehill.co.uk>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+Zg=N8FpeLMAEgxEZqKZX9_";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/+Zg=N8FpeLMAEgxEZqKZX9_
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 24 Apr 2020 18:50:43 +0100
John Oldman <john.oldman@polehill.co.uk> wrote:

> Fixed coding style issues
>=20
> Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
> ---
>  drivers/ssb/sprom.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/ssb/sprom.c b/drivers/ssb/sprom.c
> index 52d2e0f33be7..42d620cee8a9 100644
> --- a/drivers/ssb/sprom.c
> +++ b/drivers/ssb/sprom.c
> @@ -78,7 +78,8 @@ ssize_t ssb_attr_sprom_show(struct ssb_bus *bus, char *=
buf,
> =20
>  	/* Use interruptible locking, as the SPROM write might
>  	 * be holding the lock for several seconds. So allow userspace
> -	 * to cancel operation. */
> +	 * to cancel operation.
> +	 */
>  	err =3D -ERESTARTSYS;
>  	if (mutex_lock_interruptible(&bus->sprom_mutex))
>  		goto out_kfree;
> @@ -121,7 +122,8 @@ ssize_t ssb_attr_sprom_store(struct ssb_bus *bus,
> =20
>  	/* Use interruptible locking, as the SPROM write might
>  	 * be holding the lock for several seconds. So allow userspace
> -	 * to cancel operation. */
> +	 * to cancel operation.
> +	 */
>  	err =3D -ERESTARTSYS;
>  	if (mutex_lock_interruptible(&bus->sprom_mutex))
>  		goto out_kfree;
> @@ -188,9 +190,11 @@ int ssb_fill_sprom_with_fallback(struct ssb_bus *bus=
, struct ssb_sprom *out)
>  bool ssb_is_sprom_available(struct ssb_bus *bus)
>  {
>  	/* status register only exists on chipcomon rev >=3D 11 and we need che=
ck
> -	   for >=3D 31 only */
> +	 * for >=3D 31 only
> +	 */
>  	/* this routine differs from specs as we do not access SPROM directly
> -	   on PCMCIA */
> +	 * on PCMCIA
> +	 */
>  	if (bus->bustype =3D=3D SSB_BUSTYPE_PCI &&
>  	    bus->chipco.dev &&	/* can be unavailable! */
>  	    bus->chipco.dev->id.revision >=3D 31)


Acked-by: Michael B=C3=BCsch <m@bues.ch>

--=20
Michael

--Sig_/+Zg=N8FpeLMAEgxEZqKZX9_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAl6jcKEACgkQ9TK+HZCN
iw4GnQ/9HBXu8gdGeHKJsOxPtAxlbFVHXaPGp3qKQb7Si1i3RvA+yxwMY10SOIPJ
gc52OhmgTqgVYrug9z9JcZu8W0FXy0ti9HTIxUm7ufOTnoL0H/k5uvi4f+UnqV2i
JQOcH+bKOCGRIUTEq0O/V1Z44YxiNkd8aT3pmPoRzapyR9pD8qtbTTOTXShyhFvx
wj0SQXoiEh5Tz9KtnnaZc3fR3QzQGTeUx9lZJ3hDdIuA+IyK6oEZP4992N1cBY3Z
LihdOriotdEAFxw+2+CZX5SKvjQneLcQJM9XhiF/jEWxPas+LmCy87tyhc5TU7xP
217PE6BpktDXAtG/mY6D0ckAwchVpkKowxzDYjqA2g6ft/TeUBQ6oerk/8GQC+MV
AOR8HwwxB1ZB3kwpWGD0PpqWvxz3YBFl3VxW9CmVi77xoVTjDXRA7ehylHENeZHY
WO7Jlp53DuVUUlpnWNC/E2welHvaBkwEtJW+eWb7m5vZg0kx7SxsOBSZP6hn2bK0
4eioFb/c6qqhzshbGyF/wU+OOGufjpnYmJ8eXje3913IpXRpem8Ek8wktwSrLbdG
zOC6UylqqHOZB3Fe+BeX42vCTjPyViRX8xpT3r9ADLTGQi3k1ghdmPJnrX4+SB0e
Atk0L7ybsJjdOgIvokCYCpppzYllyWwzpfMyNA/YgQeJdQSO6Cw=
=V+Rq
-----END PGP SIGNATURE-----

--Sig_/+Zg=N8FpeLMAEgxEZqKZX9_--
