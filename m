Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA7ADFEBEA
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2019 12:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbfKPLnU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Nov 2019 06:43:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:52262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727428AbfKPLnT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Nov 2019 06:43:19 -0500
Received: from localhost.localdomain (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B15A7206F4;
        Sat, 16 Nov 2019 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573904598;
        bh=ZDWu7zRL8I0itAlOS5O77JXUDCd7xFTf5gzefg5Hehw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RsuT0q4xelMJ+vr8yxW6+wGHda6yXONyLdpqtKEYYPUlycBlDx+PJJpsHvoSK/GYV
         E94iVAFygxCwmanf3Sl7iYVYhDzpVC8FOx1XpyDU6fS6MYIOxGu0/9V1jGdGs8WHlG
         7heRJMQR4YCXJyMo9s7iOEwCy0aAeeTCk1ApHNtk=
Date:   Sat, 16 Nov 2019 13:43:12 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH 3/4] mt76: speed up usb bulk copy
Message-ID: <20191116114312.GC20820@localhost.localdomain>
References: <20191116111709.4686-1-markus.theil@tu-ilmenau.de>
 <20191116111709.4686-4-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qtZFehHsKgwS5rPz"
Content-Disposition: inline
In-Reply-To: <20191116111709.4686-4-markus.theil@tu-ilmenau.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--qtZFehHsKgwS5rPz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Use larger batches for usb copy to speed this operation up. Otherwise it
> would be too slow for copying new beacons or broadcast frames over usb.
>=20
> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
> ---

Hi Markus,

>  drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
>  .../wireless/mediatek/mt76/mt76x02_beacon.c   |  1 -
>  drivers/net/wireless/mediatek/mt76/usb.c      | 22 ++++++++++++++-----
>  3 files changed, 17 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index 8aec7ccf2d79..7a6f5d097a3d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -383,7 +383,7 @@ enum mt76u_out_ep {
>  struct mt76_usb {
>  	struct mutex usb_ctrl_mtx;
>  	union {
> -		u8 data[32];
> +		u8 data[128];
>  		__le32 reg_val;
>  	};
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/driver=
s/net/wireless/mediatek/mt76/mt76x02_beacon.c
> index 47207b790bf9..8b2f7a0d58b5 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> @@ -86,7 +86,6 @@ int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 =
vif_idx,
>  	dev->beacons[vif_idx] =3D skb;
>  	__mt76x02_mac_set_beacon(dev, vif_idx, skb);
> =20
> -
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(mt76x02_mac_set_beacon);
> diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wirel=
ess/mediatek/mt76/usb.c
> index 20c6fe510e9d..6183105166ec 100644
> --- a/drivers/net/wireless/mediatek/mt76/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> @@ -149,18 +149,28 @@ static void mt76u_copy(struct mt76_dev *dev, u32 of=
fset,
>  		       const void *data, int len)
>  {
>  	struct mt76_usb *usb =3D &dev->usb;
> -	const u32 *val =3D data;
> -	int i, ret;
> +	const u8 *val =3D data;
> +	int ret;
> +	const int batch_size_max =3D sizeof(usb->data);
> +	int current_batch_size;
> +	int i =3D 0;
> =20
>  	mutex_lock(&usb->usb_ctrl_mtx);
> -	for (i =3D 0; i < DIV_ROUND_UP(len, 4); i++) {
> -		put_unaligned(val[i], (u32 *)usb->data);
> +	while (i < len) {
> +		if(len - i > batch_size_max) {
> +			current_batch_size =3D batch_size_max;
> +		} else {
> +			current_batch_size =3D len - i;
> +		}

		current_batch_size =3D min(sizeof(usb->data), len - i);

> +		memcpy(usb->data, val + i, current_batch_size);
>  		ret =3D __mt76u_vendor_request(dev, MT_VEND_MULTI_WRITE,
>  					     USB_DIR_OUT | USB_TYPE_VENDOR,
> -					     0, offset + i * 4, usb->data,
> -					     sizeof(u32));
> +					     0, offset + i, usb->data,
> +					     current_batch_size);

@Stanislaw: I vaguely remember you reported some issues if the burst size=
=20
is greater than 4B (but I can be wrong)

>  		if (ret < 0)
>  			break;
> +
> +		i +=3D current_batch_size;
>  	}
>  	mutex_unlock(&usb->usb_ctrl_mtx);
>  }
> --=20
> 2.24.0
>=20

--qtZFehHsKgwS5rPz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXc/gzQAKCRA6cBh0uS2t
rGA5AP9MViTw4/Ut2W1IY8CxjzGFW9RVp3CC3mmkUduh/kNyzgD/X7Di18vpsAZM
x00LmYeQ2szyyjOsVSuPAFZ0crLmjQE=
=rsfO
-----END PGP SIGNATURE-----

--qtZFehHsKgwS5rPz--
