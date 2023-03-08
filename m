Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25DC6B026F
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 10:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCHJKD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 04:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjCHJJ4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 04:09:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE28BB9B
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 01:09:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 380CEB81A3C
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 09:09:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB80C4339B;
        Wed,  8 Mar 2023 09:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678266593;
        bh=Di8+VgrUoxorOJabFpFCQfSfT+1t6oSErezqd0MbWaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NTyTcDN+ruhmS7DQr3k64P8xkFeceFBcqIvw88/BHshMBU2LwSViNb3Q7TyeZQWrF
         TThN/jaeAJObf0N1cfr4VDqJ3pyvkP1pF1OGc20xS5baAiSm2tn3U9anHAD0YfOPzo
         aPknhZg4OX+k0EvQuNvObMQtTkSEUSQRDcSPJYlbOMA8NQcoQmDVHKE0Hi+UNj0tmV
         JNA9FKMI2ZiejCCU6g5T8/0GP0Zgth/Wo4qe0wZGwF4ssIUvJngacsn+hNcHmEr1KM
         pVuMaVMala4N2tc7u85Qe3prKiKI7YYOtJhc7FKG35Mc+fsl4F1PQjdMawB3NQErku
         CNCCgh3P+Mtvg==
Date:   Wed, 8 Mar 2023 10:09:49 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wireless: mt76: mt7921: Fix use-after-free in fw
 features query.
Message-ID: <ZAhQ3erbi7yfqyMk@lore-desk>
References: <20230308010026.2206775-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WY5RmKBgtsjfMk4X"
Content-Disposition: inline
In-Reply-To: <20230308010026.2206775-1-greearb@candelatech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--WY5RmKBgtsjfMk4X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Ben Greear <greearb@candelatech.com>
>=20
> Stop referencing 'features' memory after release_firmware is called.
>=20
> Fixes this crash:
>=20
> RIP: 0010:mt7921_check_offload_capability+0x17d
> mt7921_pci_probe+0xca/0x4b0

Hi Ben,

thx for fixing it. Just few minor comments inline.

Regards,
Lorenzo

> ...
>=20
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/init.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/init.c
> index 38d6563cb12f..3b6fb1a6b351 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -171,6 +171,7 @@ u8 mt7921_check_offload_capability(struct device *dev=
, const char *fw_wm)
>  	const struct firmware *fw;
>  	int ret, i, offset =3D 0;
>  	const u8 *data, *end;
> +	u8 rv =3D 0;

I would say we can use a more meaningful name here, something like offload_=
capa
or similar. Moreover I thin you can move features pointer just in the
if (rel_info->tag =3D=3D MT7921_FW_TAG_FEATURE) block.

Regards,
Lorenzo

> =20
>  	ret =3D request_firmware(&fw, fw_wm, dev);
>  	if (ret)
> @@ -197,12 +198,17 @@ u8 mt7921_check_offload_capability(struct device *d=
ev, const char *fw_wm)
>  	data +=3D sizeof(*rel_info);
>  	end =3D data + le16_to_cpu(rel_info->len);
> =20
> +	/* TODO:  This needs better sanity checking I think.
> +	 * Likely a corrupted firmware with bad rel_info->len, for instance,
> +	 * would blow this up.
> +	 */
>  	while (data < end) {
>  		rel_info =3D (struct mt7921_realease_info *)data;
>  		data +=3D sizeof(*rel_info);
> =20
>  		if (rel_info->tag =3D=3D MT7921_FW_TAG_FEATURE) {
>  			features =3D (struct mt7921_fw_features *)data;
> +			rv =3D features->data;
>  			break;
>  		}
> =20
> @@ -211,7 +217,7 @@ u8 mt7921_check_offload_capability(struct device *dev=
, const char *fw_wm)
> =20
>  	release_firmware(fw);
> =20
> -	return features ? features->data : 0;
> +	return rv;
>  }
>  EXPORT_SYMBOL_GPL(mt7921_check_offload_capability);
> =20
> --=20
> 2.39.1
>=20

--WY5RmKBgtsjfMk4X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZAhQ3AAKCRA6cBh0uS2t
rJG+AQChksnGL8H+S9h840ygnl/xprT/fTT2iJ7VYKQcCLRkMAD/Sudu2zranQbX
0g/l2FoFVIsL54ehCppLQqZOuuoWNgU=
=DhpN
-----END PGP SIGNATURE-----

--WY5RmKBgtsjfMk4X--
