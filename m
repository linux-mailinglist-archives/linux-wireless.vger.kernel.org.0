Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C6928D049
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Oct 2020 16:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388774AbgJMOc1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Oct 2020 10:32:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388759AbgJMOcY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Oct 2020 10:32:24 -0400
Received: from localhost (unknown [176.207.245.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD37B24820;
        Tue, 13 Oct 2020 14:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602599544;
        bh=nlrAZjqJxX9vdddn8aXvAscP7F1pvuM9S1dbNM2/jVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NwB8vz0xRf7LguIsGPgeOEPU6irZJpAhwlOSxaJiTBOqE2WEd4sefGVOQLhth0CiM
         Ioxzn6MaX2z53FrDUnLsVat8UGl6ot6A9fIle1xKvoR2Z0AM9sdDh4EMVmw/0JvTrW
         g0ArJ3NlsO6fR6HpTtgQ5l+Sr6OmFbw3NQoziSms=
Date:   Tue, 13 Oct 2020 16:32:19 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     David Bauer <mail@david-bauer.net>
Cc:     nbd@nbd.name, lorenzo.bianconi83@gmail.com, ryder.lee@mediatek.com,
        kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        dev@andreas-ziegler.de, Ron Asimi <ron.asimi@gmail.com>
Subject: Re: [PATCH] mt76: mt7603: add additional EEPROM chip ID
Message-ID: <20201013143219.GA2854@lore-desk>
References: <20201013142326.8361-1-mail@david-bauer.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline
In-Reply-To: <20201013142326.8361-1-mail@david-bauer.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Some newer MT7628 based routers (notably the TP-Link Archer C50 v4) are
> shipped with a chip-id of 0x7600 in the on-flash EEPROM. Add this as a
> possible valid ID.
>=20
> Ref: https://bugs.openwrt.org/index.php?do=3Ddetails&task_id=3D2781
>=20
> Suggested-by: Ron Asimi <ron.asimi@gmail.com>
> Signed-off-by: David Bauer <mail@david-bauer.net>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c b/drivers=
/net/wireless/mediatek/mt76/mt7603/eeprom.c
> index 3ee06e2577b8..422b9d9e8962 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7603/eeprom.c
> @@ -141,6 +141,7 @@ static int mt7603_check_eeprom(struct mt76_dev *dev)
>  	switch (val) {
>  	case 0x7628:
>  	case 0x7603:
> +	case 0x7600:

is it a hw bug or does this part-number really exist?


>  		return 0;
>  	default:
>  		return -EINVAL;
> --=20
> 2.28.0
>=20

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX4W6cAAKCRA6cBh0uS2t
rCraAQD03vio5aoOukhuwyIWHyRQwWl1NcGCxNWnrJnZR98HZQEAtvGu1EFpLnpS
UjdM09Z8W6a+1xMmU/G+B5xVf8bklAo=
=oV0x
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--
