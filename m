Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F03B440B6
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2019 18:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbfFMQIn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jun 2019 12:08:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:33734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731278AbfFMIo6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jun 2019 04:44:58 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 069C021743;
        Thu, 13 Jun 2019 08:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415496;
        bh=rSatS/AKAubBIgpIZbv6+g/tvv3E+gycd217zm8/QIQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DzpQ622QKYsQvDVdCVCm6ObAMPK3UdWXtMETZQX+T98UeuTvbTsNrGpat9QOKr8fm
         ca+Ydx4ScY80paF8p08FDse43W2E/pYZPjXNuggYskeBidhOV3+PLPseYYCVIdYhp8
         0xoS8J4ZSLpdln4dCXwgPc5rZTXpBjd/V8otax80=
Date:   Thu, 13 Jun 2019 10:44:52 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 3/4] mt76: mt76x02: fix tx status reporting issues
Message-ID: <20190613084451.GB18296@localhost.localdomain>
References: <20190607164355.51876-3-nbd@nbd.name>
 <20190612143833.51959-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="H1spWtNR+x+ondvy"
Content-Disposition: inline
In-Reply-To: <20190612143833.51959-1-nbd@nbd.name>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--H1spWtNR+x+ondvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> When the hardware falls back to lower rates for a transmit attempt, only =
the
> first status report will show the number of retries correctly. The frames
> that follow will report the correct final rate, but number of retries set=
 to 0.
> This can cause the rate control module to vastly underestimate the number=
 of
> retransmissions per rate.
>=20
> To fix this, we need to keep track of the initial requested tx rate per p=
acket
> and pass it to the status information.
> For frames with tx status requested, this is simple: use the rate configu=
red
> in info->control.rates[0] as reference.
> For no-skb tx status information, we have to encode the requested tx rate=
 in
> the packet id (and make it possible to distinguish it from real packet id=
s).
>=20
> To do that, reduce the packet id field size by one bit, and use that bit =
to
> indicate packet id vs rate.
>=20
> This change also improves reporting by filling the status rate array with
> rates from first rate to final rate, taking the same steps as the hardware
> fallback table. This matters in corner cases like MCS8 on HT, where the
> fallback target is MCS0, not MCS7.
>=20

[...]

> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c b/drivers/=
net/wireless/mediatek/mt76/mt76x02_txrx.c
> index cf7abd9b7d2e..95c73049a68b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_txrx.c
> @@ -164,9 +164,14 @@ int mt76x02_tx_prepare_skb(struct mt76_dev *mdev, vo=
id *txwi_ptr,
>  	mt76x02_mac_write_txwi(dev, txwi, tx_info->skb, wcid, sta, len);
> =20
>  	pid =3D mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
> +
> +	/* encode packet rate for no-skb packet id to fix up status reporting */
> +	if (pid =3D=3D MT_PACKET_ID_NO_SKB)
> +		pid =3D MT_PACKET_ID_HAS_RATE | (txwi->rate & MT_RXWI_RATE_INDEX);

I guess here we should do:
		pid =3D MT_PACKET_ID_HAS_RATE | (le16_to_cpu(txwi->rate) & MT_RXWI_RATE_I=
NDEX);


> +
>  	txwi->pktid =3D pid;
> =20
> -	if (pid >=3D MT_PACKET_ID_FIRST)
> +	if (mt76_is_skb_pktid(pid))
>  		qsel =3D MT_QSEL_MGMT;
> =20
>  	tx_info->info =3D FIELD_PREP(MT_TXD_INFO_QSEL, qsel) |
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/driv=
ers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> index 6b89f7eab26c..2436f14ca24a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
> @@ -89,9 +89,14 @@ int mt76x02u_tx_prepare_skb(struct mt76_dev *mdev, voi=
d *data,
>  	skb_push(tx_info->skb, sizeof(*txwi));
> =20
>  	pid =3D mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
> +
> +	/* encode packet rate for no-skb packet id to fix up status reporting */
> +	if (pid =3D=3D MT_PACKET_ID_NO_SKB)
> +		pid =3D MT_PACKET_ID_HAS_RATE | (txwi->rate & MT_RXWI_RATE_INDEX);

same here

Regards,
Lorenzo

> +
>  	txwi->pktid =3D pid;
> =20
> -	if (pid >=3D MT_PACKET_ID_FIRST || ep =3D=3D MT_EP_OUT_HCCA)
> +	if (mt76_is_skb_pktid(pid) || ep =3D=3D MT_EP_OUT_HCCA)
>  		qsel =3D MT_QSEL_MGMT;
>  	else
>  		qsel =3D MT_QSEL_EDCA;
> --=20
> 2.17.0
>=20

--H1spWtNR+x+ondvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXQINAAAKCRA6cBh0uS2t
rP8nAP9V5hBE2y3a32KTteTRi1IpL5pnFhtIJ1C+pFtXu7ecNAEAz7gkR3vM7rwY
BfYe73/68d4w0FPl/gcvXirN+EdVIwM=
=SNfI
-----END PGP SIGNATURE-----

--H1spWtNR+x+ondvy--
