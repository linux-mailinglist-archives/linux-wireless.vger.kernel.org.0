Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC8C3F55A1
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Aug 2021 04:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233700AbhHXCID (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Aug 2021 22:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhHXCID (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Aug 2021 22:08:03 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DF7C061575;
        Mon, 23 Aug 2021 19:07:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gtstq05sMz9sXM;
        Tue, 24 Aug 2021 12:07:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1629770835;
        bh=r4ymY9gWQpZ6Z04duXoJmp16wAd5c4r06ImlbHiBxZA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YG9629AJIr/aPfPGVYetbttRIYIz9QesWb6LN3wm0NAVEUIHsxJRais88+s+MZdmU
         eNysElEtF3Xwr6Ziio/qKklzXJmjDw2OhpPAhccrV4pf9UpLbtP+DfIcqU4VXYaQTD
         F5Eqif24WAXtkUt+850mE25Sjl7uu0D7Bbmrm4F0uW+JVZ4JrZP2w3M712gXNqekjx
         GRh6ZisQ1Gp57BGWyJ03Byr1z+jxirEhPlfjhsYAQXLfM8MJw5uXMuVL+QiQ7BRptP
         nsyRdZS5StzAwe5angKjQUTL9Pv+JU8JwcPHzaAMRAB751EWOzmDTkcGlrc1VjCkBV
         tgzxKgmsciwSA==
Date:   Tue, 24 Aug 2021 12:07:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kalle Valo <kvalo@codeaurora.org>,
        Wireless <linux-wireless@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Chris Down <chris@chrisdown.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: linux-next: manual merge of the wireless-drivers-next tree with
 the printk tree
Message-ID: <20210824120714.421e734d@canb.auug.org.au>
In-Reply-To: <20210809131813.3989f9e8@canb.auug.org.au>
References: <20210809131813.3989f9e8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4UxtGFUocPEUzdTXtzwtA1y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--Sig_/4UxtGFUocPEUzdTXtzwtA1y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 9 Aug 2021 13:18:13 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the wireless-drivers-next tree got a
> conflict in:
>=20
>   MAINTAINERS
>=20
> between commit:
>=20
>   337015573718 ("printk: Userspace format indexing support")
>=20
> from the printk tree and commit:
>=20
>   d249ff28b1d8 ("intersil: remove obsolete prism54 wireless driver")
>=20
> from the wireless-drivers-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc MAINTAINERS
> index 5cf181197a50,492bc169c3bd..000000000000
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@@ -14974,18 -14927,6 +14974,11 @@@ S:	Maintaine
>   F:	include/linux/printk.h
>   F:	kernel/printk/
>  =20
>  +PRINTK INDEXING
>  +R:	Chris Down <chris@chrisdown.name>
>  +S:	Maintained
>  +F:	kernel/printk/index.c
>  +
> - PRISM54 WIRELESS DRIVER
> - M:	Luis Chamberlain <mcgrof@kernel.org>
> - L:	linux-wireless@vger.kernel.org
> - S:	Obsolete
> - W:	https://wireless.wiki.kernel.org/en/users/Drivers/p54
> - F:	drivers/net/wireless/intersil/prism54/
> -=20
>   PROC FILESYSTEM
>   L:	linux-kernel@vger.kernel.org
>   L:	linux-fsdevel@vger.kernel.org

This is now a conflict between the net-next tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/4UxtGFUocPEUzdTXtzwtA1y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmEkVFIACgkQAVBC80lX
0GwNggf/afvc+h6lbKU/zmPTyivHHMDmEn3zYtbtVXiEVHLUs2m3Oeoo+/OVhY6Q
ajQChLL5WGw9Zk1Ov5d5X6i2PH7456RiIdBcJz6bCsuGQUfEs//7GXS8IOL8g5Dd
A+KIoufI8FgUagoAJ+39osPvWb4Sj+xIcgLr1211lRAOz2l7t8h487XRedLb0DHN
2PMZr4XC9t3Vmwv85F54lfbqJM4CjC2WwCKjmEsCwFO6SKsXQPnn2FU496n5DAtM
GcllVU1D/84VtplRF4j+CJzaW5Q3QsM2S9Qt0RuAOvbvMFdyO5eTTz0fMNChAktY
n0MN+ldVhx76izsvs8MEOMrvKkK4fQ==
=YKJx
-----END PGP SIGNATURE-----

--Sig_/4UxtGFUocPEUzdTXtzwtA1y--
