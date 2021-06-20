Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BDE3ADDE7
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Jun 2021 11:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhFTJqa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Jun 2021 05:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:42630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhFTJq3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Jun 2021 05:46:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 244856100A;
        Sun, 20 Jun 2021 09:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624182257;
        bh=ZVpCRDYLtBBwy7xkskFEB+FcTLVSN6KKKd1Hft64J0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s2FW1waHDmMcQYOwP4vbKZENkaPwbvReIIhmHSxKZnOmz/C9sRfpIERYsobkHHVQU
         zbOBhkEdWbXv9+T+epJ/Km1hTn2RajYinJqDRgeCqfMlGwzbdThSgkLX5aCADivC93
         Oza1stKSE7G/ZmcuIsLaYqZ7exKOcVL/syKNv/OGExuSRtLyfVAoZXq6l4say1aq9i
         zxt4HwhhjzRqSv8q9pyUrVbu1v5Fkjk3silMB55Gc5WVT53+UH9mgA7PW3Sm8Q7B/8
         OwE5BTdkG7y4gQeQz8FTu6feiGWvzOvQ+uJEkWAbTx+I+AdgteGYAy1KtPclqEFCD9
         4bf6bNWwIEdFQ==
Date:   Sun, 20 Jun 2021 11:44:12 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, jemele@google.com, yenlinlai@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] mt76: mt7921: enable aspm by default
Message-ID: <YM8N7BRIk5QzaEZy@lore-desk>
References: <9b704807383f3048898944d2b9cb74e6b4e8d83d.1624174954.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yw7NNhvB76jksAQU"
Content-Disposition: inline
In-Reply-To: <9b704807383f3048898944d2b9cb74e6b4e8d83d.1624174954.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--yw7NNhvB76jksAQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> mt7921 is mainly used in NB, CE and IoT application where battery life is
> much concerned so the patch enabled PCIe ASPM by default to shut off the
> clocks related PCIe as much as possible when MT7921 is either in suspend
> state or in runtime pm to lower power consumption.
>=20
> We still leave disable aspm as an option with module_param for users to
> disable ASPM if necessary.

instead of adding a module parameter (deprecated), why not just enable it by
default for mt7921 and add a debugfs knob to flip it?

Regards,
Lorenzo

>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index c3905bcab360..33782e1ee312 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -17,6 +17,10 @@ static const struct pci_device_id mt7921_pci_device_ta=
ble[] =3D {
>  	{ },
>  };
> =20
> +static bool mt7921_disable_aspm;
> +module_param_named(disable_aspm, mt7921_disable_aspm, bool, 0644);
> +MODULE_PARM_DESC(disable_aspm, "disable PCI ASPM support");
> +
>  static void
>  mt7921_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q)
>  {
> @@ -132,7 +136,8 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>  	if (ret)
>  		goto err_free_pci_vec;
> =20
> -	mt76_pci_disable_aspm(pdev);
> +	if (mt7921_disable_aspm)
> +		mt76_pci_disable_aspm(pdev);
> =20
>  	mdev =3D mt76_alloc_device(&pdev->dev, sizeof(*dev), &mt7921_ops,
>  				 &drv_ops);
> --=20
> 2.25.1
>=20

--yw7NNhvB76jksAQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYM8N6QAKCRA6cBh0uS2t
rNimAP4jh3ekcFwCAH/JZUIv6wMtxWc8AC6WF6ZBLFXVSHKwfgEAo/v9Lpm+g7na
G+XNKkipa6La+NdzwgzP+qTgpG+nngk=
=dJNJ
-----END PGP SIGNATURE-----

--yw7NNhvB76jksAQU--
