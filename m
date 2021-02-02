Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFF7630C19C
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Feb 2021 15:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhBBO2M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Feb 2021 09:28:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:53788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234284AbhBBO0b (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Feb 2021 09:26:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0BBFC64E27;
        Tue,  2 Feb 2021 14:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612275941;
        bh=XrWwgaGjEka3YYtYl5RvUCX0ivrinAxjyRPgZCzKe6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HSb2bdLxmcE1FswNWUgGhyJiw5saVTf+ud//jhf/MEpxlAsGgbeCL/zzaxi2Yhb2l
         mmNxRW1yVdvYguuZzwnk7kOpE/Pzf51Lzow0bNB3Uo29mW1KBEJS9LxC5HgR8Q8ypm
         FN8QlyWGLnb8rIFT89cT+vhiYrirkWDaZfrl2j1Gze6+NiKBC0H+oUonlSDyPH+1HQ
         mi8SHccGoC6Mj40jmVownUzqWZPoEnxnXapnqFChWHH5n7WgsRlgzFezuKDqwQcMhZ
         tvYEdKBhpkS6vQ/Hy7BFDluVrS1qZLVwb2eemhyJRsLNR0RrvfNQFPpuC+0OYeymG3
         VSBtAJb93kM9A==
Date:   Tue, 2 Feb 2021 15:25:36 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mt76: use PCI_VENDOR_ID_MEDIATEK to avoid open coded
Message-ID: <20210202142536.GA4823@lore-desk>
References: <404c3c6be07d4c8b2a9a7297c387509b801e62a5.1612274129.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <404c3c6be07d4c8b2a9a7297c387509b801e62a5.1612274129.git.ryder.lee@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Use PCI standard defines.
>=20
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/wireless/mediatek/mt76/mt7603/pci.c | 2 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/pci.c | 6 +++---
>  drivers/net/wireless/mediatek/mt76/mt76x0/pci.c | 6 +++---
>  drivers/net/wireless/mediatek/mt76/mt76x2/pci.c | 6 +++---
>  drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 2 +-
>  5 files changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7603/pci.c
> index 06fa28f645f2..aa6cb668b012 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7603/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7603/pci.c
> @@ -7,7 +7,7 @@
>  #include "mt7603.h"
> =20
>  static const struct pci_device_id mt76pci_device_table[] =3D {
> -	{ PCI_DEVICE(0x14c3, 0x7603) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7603) },
>  	{ },
>  };
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/pci.c
> index 71487f532f36..11f169cdd603 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
> @@ -13,9 +13,9 @@
>  #include "mcu.h"
> =20
>  static const struct pci_device_id mt7615_pci_device_table[] =3D {
> -	{ PCI_DEVICE(0x14c3, 0x7615) },
> -	{ PCI_DEVICE(0x14c3, 0x7663) },
> -	{ PCI_DEVICE(0x14c3, 0x7611) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7615) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7663) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7611) },
>  	{ },
>  };
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt76x0/pci.c
> index 02d0aa0b815e..5847f943e8da 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
> @@ -221,9 +221,9 @@ mt76x0e_remove(struct pci_dev *pdev)
>  }
> =20
>  static const struct pci_device_id mt76x0e_device_table[] =3D {
> -	{ PCI_DEVICE(0x14c3, 0x7610) },
> -	{ PCI_DEVICE(0x14c3, 0x7630) },
> -	{ PCI_DEVICE(0x14c3, 0x7650) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7610) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7630) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7650) },
>  	{ },
>  };
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt76x2/pci.c
> index ecaf85b483ac..adf288e50e21 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
> @@ -10,9 +10,9 @@
>  #include "mt76x2.h"
> =20
>  static const struct pci_device_id mt76x2e_device_table[] =3D {
> -	{ PCI_DEVICE(0x14c3, 0x7662) },
> -	{ PCI_DEVICE(0x14c3, 0x7612) },
> -	{ PCI_DEVICE(0x14c3, 0x7602) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7662) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7612) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7602) },
>  	{ },
>  };
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index 5570b4a50531..33ed952d7f4c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -13,7 +13,7 @@
>  #include "../trace.h"
> =20
>  static const struct pci_device_id mt7921_pci_device_table[] =3D {
> -	{ PCI_DEVICE(0x14c3, 0x7961) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7961) },
>  	{ },
>  };
> =20
> --=20
> 2.18.0
>=20

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYBlg3gAKCRA6cBh0uS2t
rItiAP9V6iTO4a/8xvCb0xHhu6LSiBh0FUw5huVrqaWwo0rF7AD+KgBLc+8GO/Ei
GnW/5GcqAC3vc52le6nv5whaoomXWQw=
=Hnp6
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
