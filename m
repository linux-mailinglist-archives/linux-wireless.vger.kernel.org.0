Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E0F2908CB
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Oct 2020 17:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436489AbgJPPqJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Oct 2020 11:46:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436486AbgJPPqC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Oct 2020 11:46:02 -0400
Received: from localhost (unknown [176.207.245.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A657D205CA;
        Fri, 16 Oct 2020 15:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602863161;
        bh=niTpDyZfJRFbAZD949hDaB5cZh5LED6Tjpy2z6iQJrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VOgIS4Nmj843vZ6IiDfsxUjjhmrqfJd2xURjWisHLw2CbJhUZS+oqoPBeMK5Pf4nk
         ggS2cGwb3sNxSU2lfA5Hq4tkTh/oDkUjsNhsQ4T9yLecwdfpd/h9jWt6PbqFaFlRp+
         Yje8h2NqXZHX7F6S102rU6iyCev8xUT0yPUSpGKk=
Date:   Fri, 16 Oct 2020 17:45:56 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, ryder.lee@mediatek.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Sean Wang <objelf@gmail.com>, YN Chen <YN.Chen@mediatek.com>
Subject: Re: [PATCH 1/2] mt76: mt7663: handle failure event for patch
 semaphore cmd
Message-ID: <20201016154556.GA700952@lore-desk>
References: <267346a9a9c5f71caec03292b6c33b39864b38c5.1602807276.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <267346a9a9c5f71caec03292b6c33b39864b38c5.1602807276.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <objelf@gmail.com>
>=20
> Just follow up vendor driver to retry a few times obtaining patch
> semaphore when the event is PATCH_NOT_DL_SEM_FAIL. That usually
> happens in Bluetooth and Wifi driver contends to download patch
> simultaneously.
>=20
> Co-developed-by: YN Chen <YN.Chen@mediatek.com>
> Signed-off-by: YN Chen <YN.Chen@mediatek.com>
> Signed-off-by:  Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mcu.c
> index 2b17bd1c2a32..c990ccd6f472 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
> @@ -1945,14 +1945,21 @@ static int mt7615_load_patch(struct mt7615_dev *d=
ev, u32 addr, const char *name)
>  {
>  	const struct mt7615_patch_hdr *hdr;
>  	const struct firmware *fw =3D NULL;
> -	int len, ret, sem;
> +	int len, ret, sem, c =3D 50;
> =20
> +retry:
>  	sem =3D mt7615_mcu_patch_sem_ctrl(dev, 1);
>  	switch (sem) {
>  	case PATCH_IS_DL:
>  		return 0;
>  	case PATCH_NOT_DL_SEM_SUCCESS:
>  		break;
> +	case PATCH_NOT_DL_SEM_FAIL:
> +		if (is_mt7663(&dev->mt76) && c--) {
> +			msleep(100);
> +			goto retry;
> +		}
> +		fallthrough;

I guess it is more clear to have a dedicated routine for this. E.g:

int mt7615_mcu_get_patch_semaphore()
{
	....
}

Regards,
Lorenzo

>  	default:
>  		dev_err(dev->mt76.dev, "Failed to get patch semaphore\n");
>  		return -EAGAIN;
> --=20
> 2.25.1

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX4nAMQAKCRA6cBh0uS2t
rDqQAQCedzj17j1YTnDbrr3SSz6sBCBFGouH/x53fytdy6+WlwEAnKmO3SqyXcoE
SBNw3YRd/djU6IkXBpH5NEnM0tLJzgc=
=eXek
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
