Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB8820EF23
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2020 09:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730705AbgF3HRG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jun 2020 03:17:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730636AbgF3HRG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jun 2020 03:17:06 -0400
Received: from localhost (unknown [151.48.138.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67F2F2073E;
        Tue, 30 Jun 2020 07:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593501426;
        bh=5synz2C3U8p1pf1ipeeJ9gOueO9mxDSTwbasc+QhT74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QTc7sF9dri+9YwUbUHXmXr2Y/sQZhmYmAVlC7jghbeRA8/Jz2fy95Lv4DsSVDu1NI
         TZPhXe26/2or6G3dNUUx8zOEMo/yqqNoxUC2pqe/BDFsBIFx90dcKOKAjHLLzAp3C/
         5Hs79htAzqv9egFUqOZU7ap90JhU0O7ZqNDG69c4=
Date:   Tue, 30 Jun 2020 09:17:01 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 3/3] mt76: mt7615: fix potential memory leak in mcu
 message handler
Message-ID: <20200630071701.GC2169@localhost.localdomain>
References: <5e8786d9cf0ccd09dd9c13c24c48ce441afbf0ff.1593491298.git.sean.wang@mediatek.com>
 <b1dc67b62bcc53ad02e86099ac0aab312109094b.1593491298.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
In-Reply-To: <b1dc67b62bcc53ad02e86099ac0aab312109094b.1593491298.git.sean.wang@mediatek.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Fix potential memory leak in mcu message handler on error condition.
>=20

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> Fixes: 0e6a29e477f3 ("mt76: mt7615: add support to read temperature from =
mcu")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mcu.c
> index 1b46cccd93c5..58e3838a3dba 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> @@ -183,8 +183,10 @@ mt7615_mcu_parse_response(struct mt7615_dev *dev, in=
t cmd,
>  	struct mt7615_mcu_rxd *rxd =3D (struct mt7615_mcu_rxd *)skb->data;
>  	int ret =3D 0;
> =20
> -	if (seq !=3D rxd->seq)
> -		return -EAGAIN;
> +	if (seq !=3D rxd->seq) {
> +		ret =3D -EAGAIN;
> +		goto out;
> +	}
> =20
>  	switch (cmd) {
>  	case MCU_CMD_PATCH_SEM_CONTROL:
> @@ -215,6 +217,7 @@ mt7615_mcu_parse_response(struct mt7615_dev *dev, int=
 cmd,
>  	default:
>  		break;
>  	}
> +out:
>  	dev_kfree_skb(skb);
> =20
>  	return ret;
> --=20
> 2.25.1

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXvrm6gAKCRA6cBh0uS2t
rDXrAPsGccYGcgDDRw98f6tuG0QktsFKLRJItNtuQG+mGY2YjgEA4FLMj9tcQOx3
Mz+xeYKB+byp9MDd87Yju/h2fQV1Xws=
=zdsp
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
