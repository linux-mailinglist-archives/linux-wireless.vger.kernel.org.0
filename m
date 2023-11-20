Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8449A7F0E5A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Nov 2023 10:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjKTJER (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 04:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjKTJER (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 04:04:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31A0B8
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 01:04:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA5FC433C8;
        Mon, 20 Nov 2023 09:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700471053;
        bh=hot5sDVCzsRPH0e3Y2pQh0BXJobZ2r4KAF/Bw8Oaf5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B936dTkbFhA+GmiU/a37uc44KZTkMjCHD69bfAtxdPoZZe1iN4wFPBXotUTRZeiCe
         uxNi3MvmpbWLCLAR2ks/c+brwOHGXZrBFX1skxuQS+4lN9LUl46HJIIICn+9hckRad
         buqPBSA/yMM09WzRAVAMvlvI+nB/vzH08jiXNUpiDm+ggel4qmoonYAGKOYSOEFKhc
         bHNjShvd6Mk19wW9nlqLugpeucGK+B2PRtbSC7rQOaBO1aUIGMHQwMqlJbt3KAIs/U
         vMUf7g96lCwa8TWYHIh856s1luDdVz3BPTkbWyf9OOMwNKMuJvzlcUTuGU0xJbMnJC
         ZuyiGaWdD8lDg==
Date:   Mon, 20 Nov 2023 10:04:09 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Mingyen Hsieh <mingyen.hsieh@mediatek.com>
Cc:     nbd@nbd.name, deren.wu@mediatek.com, Sean.Wang@mediatek.com,
        Soul.Huang@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, Quan.Zhou@mediatek.com,
        Ryder.Lee@mediatek.com, Shayne.Chen@mediatek.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] wifi: mt76: mt7921: fix country count limitation for
 CLC
Message-ID: <ZVshCS5T2EBCn1HH@lore-desk>
References: <20231120032750.19747-1-mingyen.hsieh@mediatek.com>
 <20231120032750.19747-2-mingyen.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MMCwj60EzpBmdCna"
Content-Disposition: inline
In-Reply-To: <20231120032750.19747-2-mingyen.hsieh@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--MMCwj60EzpBmdCna
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>=20
> Due to the increase in the number of power tables on CLC, the variable
> nr_country is no longer sufficient to represent the total quantity.
> Therefore, we have switched to calculating the length of clc buf to
> obtain the correct power table. Additionally, the version number has
> been incremented to 1.
>=20
> Fixes: 23bdc5d8cadf ("wifi: mt76: mt7921: introduce Country Location Cont=
rol support")
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mcu.c
> index 753a4fc45c70..e4edea1ab3dd 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> @@ -1264,6 +1264,7 @@ int __mt7921_mcu_set_clc(struct mt792x_dev *dev, u8=
 *alpha2,
>  		u8 mtcl_conf;
>  		u8 rsvd[62];
>  	} __packed req =3D {
> +		.ver =3D 1,
>  		.idx =3D idx,
>  		.env =3D env_cap,
>  		.env_6g =3D dev->phy.power_type,
> @@ -1271,7 +1272,8 @@ int __mt7921_mcu_set_clc(struct mt792x_dev *dev, u8=
 *alpha2,
>  		.mtcl_conf =3D mt792x_acpi_get_mtcl_conf(&dev->phy, alpha2),
>  	};
>  	int ret, valid_cnt =3D 0;
> -	u8 i, *pos;
> +	__le16 buf_len =3D 0;

I think here should be:
	u16 buf_len;

Regards,
Lorenzo

> +	u8 *pos;
> =20
>  	if (!clc)
>  		return 0;
> @@ -1281,12 +1283,15 @@ int __mt7921_mcu_set_clc(struct mt792x_dev *dev, =
u8 *alpha2,
>  	if (mt76_find_power_limits_node(&dev->mt76))
>  		req.cap |=3D CLC_CAP_DTS_EN;
> =20
> +	buf_len =3D le16_to_cpu(clc->len) - sizeof(*clc);
>  	pos =3D clc->data;
> -	for (i =3D 0; i < clc->nr_country; i++) {
> +	while (buf_len > 16) {
>  		struct mt7921_clc_rule *rule =3D (struct mt7921_clc_rule *)pos;
>  		u16 len =3D le16_to_cpu(rule->len);
> +		u16 offset =3D len + sizeof(*rule);
> =20
> -		pos +=3D len + sizeof(*rule);
> +		pos +=3D offset;
> +		buf_len -=3D offset;
>  		if (rule->alpha2[0] !=3D alpha2[0] ||
>  		    rule->alpha2[1] !=3D alpha2[1])
>  			continue;
> --=20
> 2.18.0
>=20

--MMCwj60EzpBmdCna
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZVshCQAKCRA6cBh0uS2t
rIREAQD5H+ObbE8ZQzZx7NucAaG9CKKtB3ffJ+HYAsh3jyy3mwD/csi/JSC80R93
M4Cc4k16HlLewFDXfS34E8ILJNfmKQI=
=ex5T
-----END PGP SIGNATURE-----

--MMCwj60EzpBmdCna--
