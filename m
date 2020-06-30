Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2729F20EF42
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 09:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbgF3HYe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jun 2020 03:24:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730636AbgF3HYe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jun 2020 03:24:34 -0400
Received: from localhost (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DA9E20759;
        Tue, 30 Jun 2020 07:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593501874;
        bh=HvhnlfmSrJuoYL5PlEkRODPAbslKF6Vpa8TWSCAMJ2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uSns4xvic6/mlnoSOgQc5/edZS7x32JkoEyklhlsEcB9PuhzpROumxHKLRK4QluTI
         4VHuER245AOxthzYmZ1fdrbbXov4KKZ4FMjC0ieRXKo5US8L96tojpRxU3bpyGuxV3
         A0b6JnpyHO7hok9J3FazxeBr1t4Mvl9eZIMReMw0=
Date:   Tue, 30 Jun 2020 09:24:29 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] mt76: mt7663u: fix memory leak in set key
Message-ID: <20200630072429.GD2169@localhost.localdomain>
References: <5e8786d9cf0ccd09dd9c13c24c48ce441afbf0ff.1593491298.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2Z2K0IlrPCVsbNpk"
Content-Disposition: inline
In-Reply-To: <5e8786d9cf0ccd09dd9c13c24c48ce441afbf0ff.1593491298.git.sean.wang@mediatek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--2Z2K0IlrPCVsbNpk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Fix memory leak in set key.
>=20
> Fixes: eb99cc95c3b6 ("mt76: mt7615: introduce mt7663u support")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7615/usb.c   | 22 +++++++++++++------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/usb.c
> index 0ba28d37c414..96a081be108e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
> @@ -165,12 +165,16 @@ __mt7663u_mac_set_key(struct mt7615_dev *dev,
> =20
>  	lockdep_assert_held(&dev->mt76.mutex);
> =20
> -	if (!sta)
> -		return -EINVAL;
> +	if (!sta) {
> +		err =3D -EINVAL;
> +		goto out;
> +	}
> =20
>  	cipher =3D mt7615_mac_get_cipher(key->cipher);
> -	if (cipher =3D=3D MT_CIPHER_NONE)
> -		return -EOPNOTSUPP;
> +	if (cipher =3D=3D MT_CIPHER_NONE) {
> +		err =3D -EOPNOTSUPP;
> +		goto out;
> +	}
> =20
>  	wcid =3D &wd->sta->wcid;
> =20
> @@ -178,19 +182,23 @@ __mt7663u_mac_set_key(struct mt7615_dev *dev,
>  	err =3D mt7615_mac_wtbl_update_key(dev, wcid, key->key, key->keylen,
>  					 cipher, key->cmd);
>  	if (err < 0)
> -		return err;
> +		goto out;
> =20
>  	err =3D mt7615_mac_wtbl_update_pk(dev, wcid, cipher, key->keyidx,
>  					key->cmd);
>  	if (err < 0)
> -		return err;
> +		goto out;
> =20
>  	if (key->cmd =3D=3D SET_KEY)
>  		wcid->cipher |=3D BIT(cipher);
>  	else
>  		wcid->cipher &=3D ~BIT(cipher);
> =20
> -	return 0;
> +out:
> +	kfree(key->key);
> +	kfree(wd);

Actually we do not need to free wd since it is done in mt7663u_wtbl_work()

> +
> +	return err;
>  }
> =20
>  void mt7663u_wtbl_work(struct work_struct *work)
> --=20
> 2.25.1

--2Z2K0IlrPCVsbNpk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXvroqgAKCRA6cBh0uS2t
rPBnAQDmSs/a+RSB3542U4ZITjLG5j04PnwuU5GAChNUlDE94AEAxlto2CvCAt4M
fRHzEhpC4/eXghF7NdpIT5oHldFucQY=
=jr3r
-----END PGP SIGNATURE-----

--2Z2K0IlrPCVsbNpk--
