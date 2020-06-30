Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B211820EF15
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 09:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgF3HNQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jun 2020 03:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730663AbgF3HNQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jun 2020 03:13:16 -0400
Received: from localhost (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A14EB2073E;
        Tue, 30 Jun 2020 07:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593501196;
        bh=MGeDmhHK147t17Kohj7p/leccWrWnai1SGaLq6YZOYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gxnjBKkeDTArNQKVPCuwPcv+oaM0h8p5eZHOu1jQfnvxGWCq33ciGRyq5aPJ8Dq75
         I8qjOo1jwMhIZf+GDx2hTmi7/13i5rwuUrwf8GiWAFVM19I/qBrTbXaN2IOJ+8n+3i
         KlxkwRB50fZ5e9wRuxubK5Gj+AyKHhPDuuDqTS1E=
Date:   Tue, 30 Jun 2020 09:13:11 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/3] mt76: mt7663u: fix potential memory leak in mcu
 message handler
Message-ID: <20200630071311.GB2169@localhost.localdomain>
References: <5e8786d9cf0ccd09dd9c13c24c48ce441afbf0ff.1593491298.git.sean.wang@mediatek.com>
 <74f27a79f53c6df3c49484a27c5b954d827cd9a5.1593491298.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
In-Reply-To: <74f27a79f53c6df3c49484a27c5b954d827cd9a5.1593491298.git.sean.wang@mediatek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Fix potential memory leak in mcu message handler on error condition.
>=20
> Fixes: eb99cc95c3b6 ("mt76: mt7615: introduce mt7663u support")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c b/driver=
s/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
> index cd709fd617db..3e66ff98cab8 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
> @@ -34,7 +34,6 @@ mt7663u_mcu_send_message(struct mt76_dev *mdev, struct =
sk_buff *skb,
> =20
>  	ret =3D mt76u_bulk_msg(&dev->mt76, skb->data, skb->len, NULL,
>  			     1000, ep);
> -	dev_kfree_skb(skb);
>  	if (ret < 0)
>  		goto out;
> =20
> @@ -43,6 +42,7 @@ mt7663u_mcu_send_message(struct mt76_dev *mdev, struct =
sk_buff *skb,
> =20
>  out:
>  	mutex_unlock(&mdev->mcu.mutex);
> +	dev_kfree_skb(skb);
> =20
>  	return ret;
>  }
> --=20
> 2.25.1

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXvrmBAAKCRA6cBh0uS2t
rDL3AQDekyN9KmPt67FocQBPL8/zYcFN3x6LLS54SLs+zbRGhwD/Yk6u2mmFYrAp
7aOdW76sPlrJa466ooMBLtZXcTX9+gI=
=49FR
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--
