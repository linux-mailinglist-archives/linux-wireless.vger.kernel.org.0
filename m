Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF287217A25
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2020 23:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbgGGVSb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jul 2020 17:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726273AbgGGVSb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jul 2020 17:18:31 -0400
Received: from localhost (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7485120674;
        Tue,  7 Jul 2020 21:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594156711;
        bh=XL0tUECTDEwrDwToDqVJYlqz0LbTPyF5pQwI+PIscnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MgVclfRlZvRYeBqsxUtdjp9u1Vr6d7uVSao1gFYbZrCmfSTVZncYwl3vBKuMdm4wk
         /y/1hRtvE2pyw/r7Yu9bMsAh2k7kljnZdXWkN/52t6rTPd4S4LVzxCbSYLkAS1Hg1Z
         fJIWqPn8CxbuhPjnB0PzihdHC3LRUpz0IIndo8+o=
Date:   Tue, 7 Jul 2020 23:18:25 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/3] mt76: mt7663u: fix memory leak in set key
Message-ID: <20200707211825.GB388366@localhost.localdomain>
References: <57b81f8efe7e767616a0d5957728756cbfdfa235.1594148548.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <57b81f8efe7e767616a0d5957728756cbfdfa235.1594148548.git.sean.wang@mediatek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Fix memory leak in set key.
>=20
> v1 -> v2:
> 	- remove unneeded kfree
>=20
> Fixes: eb99cc95c3b6 ("mt76: mt7615: introduce mt7663u support")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  .../net/wireless/mediatek/mt76/mt7615/usb.c   | 21 ++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/usb.c
> index 0ba28d37c414..f3c3ad3509c8 100644
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
> @@ -178,19 +182,22 @@ __mt7663u_mac_set_key(struct mt7615_dev *dev,
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
> +
> +	return err;
>  }
> =20
>  void mt7663u_wtbl_work(struct work_struct *work)
> --=20
> 2.25.1

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXwTmnwAKCRA6cBh0uS2t
rLr8AQCULFrwZ7G32qjUjOLKsbnlci1fSkQNN4w1aSp3ARP41wD+P7qxShJrHRgo
8s5pPVZzF4QjWgGzu0Gm7RBUSw3z8w0=
=Um2P
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
