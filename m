Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A063C3261CB
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Feb 2021 12:11:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhBZLKf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Feb 2021 06:10:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:36592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhBZLKe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Feb 2021 06:10:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C79E64E6C;
        Fri, 26 Feb 2021 11:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614337793;
        bh=XKQsWPvdzq64BeQHNfSblBPY8Ec1i9KpZVWh59++8mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gcjvcRK5rXHGPdLgv4cOCXcjveQ1dAiH1l1Bxj/S+h5sv1ptpWp4SpeZE/E6X2evT
         FWAi1I+dcIVmJchWD/4m4gaDmhOc60JQPavKcQ9vRUlXlxquySO/8wSrPNs7r4Cc6y
         TC/vNcVqJHYSH9DcdLzVLebyp/BixAf5ax2y/6/NDac9Ts/2k7pT3PIsvt3erFzo/h
         fDnnjiztAxyrAXNecRS4ySl3+RSnE5GrYXkZK6z+h1oOdrHodXlqa/QJ0oHKM2QKus
         Cedj7VwQCsEli6zOPJ+8jHmXQU7Vxfmf8cHvO6UuhpjpTv0VuwRh+03AmZJKmB/t9Q
         dMCpzns/DQuiA==
Date:   Fri, 26 Feb 2021 12:09:48 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] mt76: mt7921: fix the base of PCIe interrupt
Message-ID: <YDjW/LfRmgb84T4H@lore-desk>
References: <4ff45223ff7ecff8e20a722ffd2db77fe51fea00.1614327185.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TeJPtBiF6yJ8P6Q6"
Content-Disposition: inline
In-Reply-To: <4ff45223ff7ecff8e20a722ffd2db77fe51fea00.1614327185.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--TeJPtBiF6yJ8P6Q6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Should use 0x10000 as the base to operate PCIe interrupt according
> to the vendor reference driver.
>=20
> Fixes: ffa1bf97425b ("mt76: mt7921: introduce PM support")
> Co-developed-by: YN Chen <YN.Chen@mediatek.com>
> Signed-off-by: YN Chen <YN.Chen@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

For the series:

Tested-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/pci.c  | 4 ++--
>  drivers/net/wireless/mediatek/mt76/mt7921/regs.h | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index 3e430c04c97e..def8b7816609 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -137,7 +137,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
> =20
>  	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
> =20
> -	mt7921_l1_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
> +	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
> =20
>  	ret =3D devm_request_irq(mdev->dev, pdev->irq, mt7921_irq_handler,
>  			       IRQF_SHARED, KBUILD_MODNAME, dev);
> @@ -248,7 +248,7 @@ static int mt7921_pci_resume(struct pci_dev *pdev)
>  		return 0;
> =20
>  	/* enable interrupt */
> -	mt7921_l1_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
> +	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
>  	mt7921_irq_enable(dev, MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
>  			  MT_INT_MCU_CMD);
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/n=
et/wireless/mediatek/mt76/mt7921/regs.h
> index 419add751980..c4bd31cc81cb 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
> @@ -391,7 +391,7 @@
>  #define MT_HW_CHIPID			0x70010200
>  #define MT_HW_REV			0x70010204
> =20
> -#define MT_PCIE_MAC_BASE		0x74030000
> +#define MT_PCIE_MAC_BASE		0x10000
>  #define MT_PCIE_MAC(ofs)		(MT_PCIE_MAC_BASE + (ofs))
>  #define MT_PCIE_MAC_INT_ENABLE		MT_PCIE_MAC(0x188)
> =20
> --=20
> 2.25.1
>=20

--TeJPtBiF6yJ8P6Q6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYDjW+gAKCRA6cBh0uS2t
rOmCAQCGVOdXmAXui1aktXC219Tdpl8GYbAGv6Pmht16KBauswD+KyYzlblAvYc5
3TKPeEeY4rUsGsD/dKRZJzo2Yzc/twM=
=upGh
-----END PGP SIGNATURE-----

--TeJPtBiF6yJ8P6Q6--
