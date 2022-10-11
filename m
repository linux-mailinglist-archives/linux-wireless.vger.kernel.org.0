Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDE75FAD94
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 09:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJKHfr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 03:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJKHfn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 03:35:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F06220C4
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 00:35:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26106B810B2
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 07:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E17AC433D6;
        Tue, 11 Oct 2022 07:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665473738;
        bh=61stQUncIy2Z/Nuy/+OMABu7UzdyW4hgl587LgJfF+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nURWmBIwOzR5m71vyVJwzAHaTirrermB4ZTcQENZvRYidsbPjuQfMau4VpXQC5F3Y
         mvES2wVRwdp5sZWEOfFb4p+ojoCRPPbKMLG8WLa5mOTJsifU2BqjXogAXXMBIKFoIu
         PpHlnX3XygWYI8qogUi4m8PHSH82DGy6LI7HU7/LqFbepgIOioSpmgKwh2/E7+29rf
         xSokH28P53ENEHdc5CQdVdnt0wcHIuCSoNFaN9HDiw3YBiSpk5ZYHbhto5372+RVDB
         oOTSzv+9Rnte6tZzBxfMK3h4OmokiWCrgeaDoQfgVaa5xzpM3EsyIaflPuuHmlM9Co
         8kR9M0xainekw==
Date:   Tue, 11 Oct 2022 09:35:35 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: mt7915: prevent unexpected nss setting from
 eeprom
Message-ID: <Y0Ucx6+6TjEfPV17@lore-desk>
References: <efa6ba9cd8ad5124f58e05155cc05008b14c5edf.1665453585.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cDg6v/7QPvTVC2k7"
Content-Disposition: inline
In-Reply-To: <efa6ba9cd8ad5124f58e05155cc05008b14c5edf.1665453585.git.ryder.lee@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--cDg6v/7QPvTVC2k7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add a check to prevent unexpected nss configuration from eeprom.

I am wondering why we need to add a check for this particular field. Is it a
well-known problem?

Regards,
Lorenzo

>=20
> Fixes: 4d8053df67c5 ("wifi: mt76: mt7915: rework eeprom tx paths and stre=
ams init")
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers=
/net/wireless/mediatek/mt76/mt7915/eeprom.c
> index e2482c65d639..6c5155223087 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
> @@ -191,7 +191,6 @@ void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *de=
v,
>  		path =3D 4;
> =20
>  	/* read tx/rx stream */
> -	nss =3D path;
>  	if (dev->dbdc_support) {
>  		if (is_mt7915(&dev->mt76)) {
>  			nss =3D FIELD_GET(MT_EE_WIFI_CONF3_TX_PATH_B0,
> @@ -206,6 +205,11 @@ void mt7915_eeprom_parse_hw_cap(struct mt7915_dev *d=
ev,
> =20
>  		if (!is_mt7986(&dev->mt76))
>  			nss_max =3D 2;
> +
> +		if (!nss)
> +			nss =3D nss_max;
> +	} else {
> +		nss =3D path;
>  	}
> =20
>  	nss =3D min_t(u8, min_t(u8, nss_max, nss), path);
> --=20
> 2.36.1
>=20

--cDg6v/7QPvTVC2k7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY0UcxgAKCRA6cBh0uS2t
rOPdAQCKrWYAct/uSUQzcbTdRqLtPFS6mew43S2Gq0GX5hn+bwEA1rgunDydicfs
G582C7THc97apLzQ8h7NeUOJoNUheQE=
=23rp
-----END PGP SIGNATURE-----

--cDg6v/7QPvTVC2k7--
