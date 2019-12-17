Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 661E61227CC
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 10:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfLQJkZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 04:40:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfLQJkZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 04:40:25 -0500
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C94BE20716;
        Tue, 17 Dec 2019 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576575624;
        bh=HwSc7jqdF2nRf+IWIoEgGrJ14H6o7WGoDjUwpCH0zrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z6LaWnmOqwqqAlVjurEId5WyK+v82KHQjbnZm9f3jkP1rRWtIEw8RxUbR+vPZ2tLD
         eCCzt4JY0m+mFf+wsvdoESblspl1ogu2q0RMRzg4qfDL1gst1iZP4mILAGlJqNtXqR
         pPycXO1GOihKnIpUJjlroP2A5tjbWI0fY8NzbW50=
Date:   Tue, 17 Dec 2019 10:40:19 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH v9 4/6] mt76: mt76x02: remove a copy call for usb speedup
Message-ID: <20191217094019.GA2567@localhost.localdomain>
References: <20191126214704.27297-1-markus.theil@tu-ilmenau.de>
 <20191126214704.27297-5-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Content-Disposition: inline
In-Reply-To: <20191126214704.27297-5-markus.theil@tu-ilmenau.de>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> This patch removes a mt76_wr_copy call from the beacon path to hw.
> The skb which is used in this place gets therefore build with txwi
> inside its data. For mt76 usb drivers, this saves one synchronuous
> copy call over usb, which lets the beacon work complete faster.
>=20
> In mmio case, there is not enough headroom to put the txwi into the
> skb, it is therefore using an additional mt76_wr_copy, which is fast
> over mmio. Thanks Stanislaw for pointing this out.
>=20
> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
> ---
>  .../wireless/mediatek/mt76/mt76x02_beacon.c   | 20 +++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/driver=
s/net/wireless/mediatek/mt76/mt76x02_beacon.c
> index 1c4bdf88f712..68a4f512319e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> @@ -26,15 +26,27 @@ static int
>  mt76x02_write_beacon(struct mt76x02_dev *dev, int offset, struct sk_buff=
 *skb)
>  {
>  	int beacon_len =3D dev->beacon_ops->slot_size;
> -	struct mt76x02_txwi txwi;
> =20
>  	if (WARN_ON_ONCE(beacon_len < skb->len + sizeof(struct mt76x02_txwi)))
>  		return -ENOSPC;
> =20
> -	mt76x02_mac_write_txwi(dev, &txwi, skb, NULL, NULL, skb->len);
> +	/* USB devices already reserve enough skb headroom for txwi's. This
> +	 * helps to save slow copies over USB.
> +	 */
> +	if (mt76_is_usb(&dev->mt76)) {
> +		struct mt76x02_txwi *txwi;
> +
> +		mt76_insert_hdr_pad(skb);

Do we really need mt76_insert_hdr_pad? I think beacon header should be 4B
aligned.

Regards,
Lorenzo

> +		txwi =3D (struct mt76x02_txwi *)(skb->data - sizeof(*txwi));
> +		mt76x02_mac_write_txwi(dev, txwi, skb, NULL, NULL, skb->len);
> +		skb_push(skb, sizeof(*txwi));
> +	} else {
> +		struct mt76x02_txwi txwi;
> =20
> -	mt76_wr_copy(dev, offset, &txwi, sizeof(txwi));
> -	offset +=3D sizeof(txwi);
> +		mt76x02_mac_write_txwi(dev, &txwi, skb, NULL, NULL, skb->len);
> +		mt76_wr_copy(dev, offset, &txwi, sizeof(txwi));
> +		offset +=3D sizeof(txwi);
> +	}
> =20
>  	mt76_wr_copy(dev, offset, skb->data, skb->len);
>  	return 0;
> --=20
> 2.24.0
>=20

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXfiigAAKCRA6cBh0uS2t
rP39AP0XHdP07RFAGJSTNPNbJc0GkwaOeqDwyG+YeHIgUo301AD8DjAyiHKLUwqd
rfFHvNbBzcJJT9vmrudA4KP+HDjFRgE=
=Bp44
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
