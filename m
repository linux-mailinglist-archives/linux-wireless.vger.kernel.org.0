Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C3A7E9AB9
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 12:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjKMLI7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 06:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjKMLI6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 06:08:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4218810DB
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 03:08:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6061AC433C9;
        Mon, 13 Nov 2023 11:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699873733;
        bh=KALW0XAt2W9xqmDl2Dewx6Qe5FPupyQKP9nRMmTBR2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f0o+5iopELrIRLQ0runKmuVCXTFT3Ru7rxqUo7Mhj8aM0/rvA+c/oLFeBb2GSDWsI
         XHKE5QrxENycxawwWgxwgC6GeiH+yRGq5AUQCYreoR2y/RlRMdTYEeJZLbJ6sSCGDs
         7KRh15C5qNY7qUPRraxdOyRgz2uo7v+HeQ6Ue0R/T6FLpyvkyt0e7eLIt7bpootWka
         lHb/LHBB4/rTCnrE9azgZ0/ZDFooFDHhtEPQD66j7i2+4zlPTvbeBcPax2GdCq23C4
         K4FYc3BtjB1lZ6rbPhSKa+MHOXi3opeo6P6Bob4Okc3QSMziJ0xYxiKSBfn8cP5uTX
         LMx3U3+ncL6Og==
Date:   Mon, 13 Nov 2023 12:08:49 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Subject: Re: [PATCH 5/8] wifi: mt76: mt7996: support mt7992 eeprom loading
Message-ID: <ZVIDwUD8ESJIpsnM@lore-desk>
References: <20231113070619.19964-1-shayne.chen@mediatek.com>
 <20231113070619.19964-6-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MaAtsoH7HqLGRCZk"
Content-Disposition: inline
In-Reply-To: <20231113070619.19964-6-shayne.chen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--MaAtsoH7HqLGRCZk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
>=20
> Add the default eeprom and 0x7992 check to mt7996_check_eeprom().
> This is a preliminary patch for mt7992 chipsets support.
>=20
> Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7996/eeprom.c    | 15 ++++++++++++---
>  .../net/wireless/mediatek/mt76/mt7996/mt7996.h    |  1 +
>  2 files changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c b/drivers=
/net/wireless/mediatek/mt76/mt7996/eeprom.c
> index 9db7e531076d..9c3735bed50c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.c
> @@ -12,9 +12,12 @@ static int mt7996_check_eeprom(struct mt7996_dev *dev)
>  	u8 *eeprom =3D dev->mt76.eeprom.data;
>  	u16 val =3D get_unaligned_le16(eeprom);
> =20
> +#define CHECK_EEPROM_ERR(match)	(match ? 0 : -EINVAL)

I do not see the point of using this macro here, the code is so simply you =
can
use 'open code' directly.

Regards,
Lorenzo

>  	switch (val) {
>  	case 0x7990:
> -		return 0;
> +		return CHECK_EEPROM_ERR(is_mt7996(&dev->mt76));
> +	case 0x7992:
> +		return CHECK_EEPROM_ERR(is_mt7992(&dev->mt76));
>  	default:
>  		return -EINVAL;
>  	}
> @@ -22,8 +25,14 @@ static int mt7996_check_eeprom(struct mt7996_dev *dev)
> =20
>  static char *mt7996_eeprom_name(struct mt7996_dev *dev)
>  {
> -	/* reserve for future variants */
> -	return MT7996_EEPROM_DEFAULT;
> +	switch (mt76_chip(&dev->mt76)) {
> +	case 0x7990:
> +		return MT7996_EEPROM_DEFAULT;
> +	case 0x7992:
> +		return MT7992_EEPROM_DEFAULT;
> +	default:
> +		return MT7996_EEPROM_DEFAULT;
> +	}
>  }
> =20
>  static int
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers=
/net/wireless/mediatek/mt76/mt7996/mt7996.h
> index 87822663870f..5cdde28ce83f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
> @@ -39,6 +39,7 @@
>  #define MT7992_ROM_PATCH		"mediatek/mt7996/mt7992_rom_patch.bin"
> =20
>  #define MT7996_EEPROM_DEFAULT		"mediatek/mt7996/mt7996_eeprom.bin"
> +#define MT7992_EEPROM_DEFAULT		"mediatek/mt7996/mt7992_eeprom.bin"
>  #define MT7996_EEPROM_SIZE		7680
>  #define MT7996_EEPROM_BLOCK_SIZE	16
>  #define MT7996_TOKEN_SIZE		16384
> --=20
> 2.39.2
>=20

--MaAtsoH7HqLGRCZk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZVIDwQAKCRA6cBh0uS2t
rDW1AQC0xxbrwxWw+jGwPj05E9g7NJUYXMwq9tiFM5NOUkhe5QD/SUev/jPEcRow
gl6SZeJ4S0JY5Bl0qEADvCZz5znCjQE=
=xB70
-----END PGP SIGNATURE-----

--MaAtsoH7HqLGRCZk--
