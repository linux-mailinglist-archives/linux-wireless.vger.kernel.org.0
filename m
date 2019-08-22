Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA7299047
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 12:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbfHVKCm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 06:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729321AbfHVKCm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 06:02:42 -0400
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05B2F205C9;
        Thu, 22 Aug 2019 10:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566468160;
        bh=bpAle+yqyoDF2QC+HgJHvIWAHCDrhP8MPIO2TGu3K8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gGUr2xCUDyZUyOmEh63XgKU6auhi8Yn+sRm3T5wWYmmEUkAjOe81kKX2WK3q+ALfA
         y4z9DLnwFjAY7+lfGGeKTjj8qsXYXygPRb/UDY7Y1cB2efQyhWOD/uYGWSS6Zx9stt
         WxzJm2EbEBTh4NipYMd4bGijiouM/0Uu8mUBAIIs=
Date:   Thu, 22 Aug 2019 12:02:36 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: mt7615: apply calibration-free data from OTP
Message-ID: <20190822100236.GB3350@localhost.localdomain>
References: <20190821191443.36764-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dTy3Mrz/UPE2dbVg"
Content-Disposition: inline
In-Reply-To: <20190821191443.36764-1-nbd@nbd.name>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--dTy3Mrz/UPE2dbVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> MT7615 chips usually come pre-calibrated, even when used on embedded boar=
ds.
> In that case, the on-flash EEPROM data needs to be merged with some data
> from OTP ROM.
> Run this merge if the external EEPROM data is valid and OTP has valid fie=
lds.
>=20

Tested-by: Lorenzo Bianconi <lorenzo@kernel.org>

> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  .../wireless/mediatek/mt76/mt7615/eeprom.c    | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c b/drivers=
/net/wireless/mediatek/mt76/mt7615/eeprom.c
> index dc94f52e6e8b..515bb58e19fd 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/eeprom.c
> @@ -154,6 +154,42 @@ int mt7615_eeprom_get_power_index(struct mt7615_dev =
*dev,
>  	return index;
>  }
> =20
> +static void mt7615_apply_cal_free_data(struct mt7615_dev *dev)
> +{
> +	static const u16 ical[] =3D {
> +		0x53, 0x54, 0x55, 0x56, 0x57, 0x5c, 0x5d, 0x62, 0x63, 0x68,
> +		0x69, 0x6e, 0x6f, 0x73, 0x74, 0x78, 0x79, 0x82, 0x83, 0x87,
> +		0x88, 0x8c, 0x8d, 0x91, 0x92, 0x96, 0x97, 0x9b, 0x9c, 0xa0,
> +		0xa1, 0xaa, 0xab, 0xaf, 0xb0, 0xb4, 0xb5, 0xb9, 0xba, 0xf4,
> +		0xf7, 0xff,
> +		0x140, 0x141, 0x145, 0x146, 0x14a, 0x14b, 0x154, 0x155, 0x159,
> +		0x15a, 0x15e, 0x15f, 0x163, 0x164, 0x168, 0x169, 0x16d, 0x16e,
> +		0x172, 0x173, 0x17c, 0x17d, 0x181, 0x182, 0x186, 0x187, 0x18b,
> +		0x18c
> +	};
> +	static const u16 ical_nocheck[] =3D {
> +		0x110, 0x111, 0x112, 0x113, 0x114, 0x115, 0x116, 0x117, 0x118,
> +		0x1b5, 0x1b6, 0x1b7, 0x3ac, 0x3ad, 0x3ae, 0x3af, 0x3b0, 0x3b1,
> +		0x3b2
> +	};
> +	u8 *eeprom =3D dev->mt76.eeprom.data;
> +	u8 *otp =3D dev->mt76.otp.data;
> +	int i;
> +
> +	if (!otp)
> +		return;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ical); i++)
> +		if (!otp[ical[i]])
> +			return;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ical); i++)
> +		eeprom[ical[i]] =3D otp[ical[i]];
> +
> +	for (i =3D 0; i < ARRAY_SIZE(ical_nocheck); i++)
> +		eeprom[ical_nocheck[i]] =3D otp[ical_nocheck[i]];
> +}
> +
>  int mt7615_eeprom_init(struct mt7615_dev *dev)
>  {
>  	int ret;
> @@ -166,6 +202,8 @@ int mt7615_eeprom_init(struct mt7615_dev *dev)
>  	if (ret && dev->mt76.otp.data)
>  		memcpy(dev->mt76.eeprom.data, dev->mt76.otp.data,
>  		       MT7615_EEPROM_SIZE);
> +	else
> +		mt7615_apply_cal_free_data(dev);
> =20
>  	mt7615_eeprom_parse_hw_cap(dev);
>  	memcpy(dev->mt76.macaddr, dev->mt76.eeprom.data + MT_EE_MAC_ADDR,
> --=20
> 2.17.0
>=20

--dTy3Mrz/UPE2dbVg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXV5oOQAKCRA6cBh0uS2t
rGWeAP9spRwBTXlt6UfgbXkTDNrSthUgdem7Ov5m9yfEosYlBQEAvhXPfPSJf6QU
hOyf4phmCTC+N16n6F8ogzP00OBAAQU=
=M5Fz
-----END PGP SIGNATURE-----

--dTy3Mrz/UPE2dbVg--
