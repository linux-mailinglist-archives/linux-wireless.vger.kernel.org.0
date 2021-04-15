Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7269360B12
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Apr 2021 15:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhDONyB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Apr 2021 09:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233168AbhDONyA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Apr 2021 09:54:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 585A6613C0;
        Thu, 15 Apr 2021 13:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618494817;
        bh=HxlQgr9ai/dksl/E9OkOo6I+ld73OP7laqDFtv+3bzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pqq4rwS/Q9W7u9oFfX2FCCgbdSsC1dABmPRdQPeix8G/JcWbg2BtQ0EPlmxFm/q3u
         WdGUIovFOPFTrgH7ukqN84khGDwursbBeyfOm9R25PFIx8DDzlnldXG4SMgX4z0q3m
         qZyQNT+Hoy0NX/63zC52aX+0XoK+IT6T+8AdWTbZ8zabS9nko0MWerbFNqbtbB9aNq
         HeOSekgoBV670nSAoGQ+bdT1CvJVC3G6WyySfU/RAiZse9KSU5OUTGG0pNUPu1H4tO
         fvYZSzV8x1FyPI212pWqiFTK5UO24lI0xHukK+ZLZ6TcOutB4B8allJN9fhzKyA6O7
         ixAvltInr1j4A==
Date:   Thu, 15 Apr 2021 15:53:33 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Eric.Liang@mediatek.com,
        Stella.Chang@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] mt76: mt7921: add debugfs knob for performing wifi
 reset
Message-ID: <YHhFXcgsfziGlCag@lore-desk>
References: <1618494105-5462-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8levkRUDXuehoOxN"
Content-Disposition: inline
In-Reply-To: <1618494105-5462-1-git-send-email-sean.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--8levkRUDXuehoOxN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Introduce chip_reset knob in mt7921 debugfs to export a way to users
> able to trigger wifi reset.
>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/driver=
s/net/wireless/mediatek/mt76/mt7921/debugfs.c
> index 024524173115..1342a0b645e3 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
> @@ -302,6 +302,16 @@ static int mt7921_config(void *data, u64 val)
> =20
>  DEFINE_DEBUGFS_ATTRIBUTE(fops_config, NULL, mt7921_config, "%lld\n");
> =20
> +static int mt7921_chip_reset(void *data, u64 val)
> +{
> +	struct mt7921_dev *dev =3D data;
> +
> +	mt7921_reset(&dev->mt76);
> +
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_reset, NULL, mt7921_chip_reset, "%lld\n");

can we use chip_config for this?

Regards,
Lorenzo

> +
>  int mt7921_init_debugfs(struct mt7921_dev *dev)
>  {
>  	struct dentry *dir;
> @@ -322,6 +332,7 @@ int mt7921_init_debugfs(struct mt7921_dev *dev)
>  	debugfs_create_file("idle-timeout", 0600, dir, dev,
>  			    &fops_pm_idle_timeout);
>  	debugfs_create_file("chip_config", 0600, dir, dev, &fops_config);
> +	debugfs_create_file("chip_reset", 0600, dir, dev, &fops_reset);
> =20
>  	return 0;
>  }
> --=20
> 2.25.1
>=20

--8levkRUDXuehoOxN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYHhFWgAKCRA6cBh0uS2t
rOFtAP9Q+e9TcNmnQkS6+BttcdOc2zkUUk1V1D4v7/zVgEgrJQEA1E30Gz9q/7kh
PJ3WyHJ5SoC+j5r8aehl6bfbWuNFqAg=
=0MF3
-----END PGP SIGNATURE-----

--8levkRUDXuehoOxN--
