Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D39396C2E51
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Mar 2023 10:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjCUJ6a (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Mar 2023 05:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCUJ62 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Mar 2023 05:58:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9311FF1
        for <linux-wireless@vger.kernel.org>; Tue, 21 Mar 2023 02:58:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C19C60F45
        for <linux-wireless@vger.kernel.org>; Tue, 21 Mar 2023 09:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45330C433EF;
        Tue, 21 Mar 2023 09:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679392705;
        bh=Ni7yiuO6rpbL0gt4gbfUWVY312iWHLGDDEfTnPT79T0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M78zXoYDddA9/zyMEEgKOk2UZH8NWlgrDwTPmQGONSOiTKCe6NcZYm5ji3G8HuHRe
         Wf5bipf8cWjAVpgzgtSRcvESaV8MggOyLymQM2jMxGNWMYXRPYDdTT56hRPGNIyouy
         l4uUI0NIpRJbbuhyK5uCoroVgHF3y5HJdjRtM7/4882XuERdobljHwtZFKJlTxSjTZ
         vjPx0nlwCVeGqVARzMSYjAFG4vNmStB+HeCfCgypxYHnOfhDfgMJLvEtnS9LeOG58w
         0X54hQk09RcvjBNTLoJiy9vbpHW+K7BP3RBjU+HTnmgYuNxw0ySmhO/gOGdGIO5Uad
         /S++PqUbRUVuQ==
Date:   Tue, 21 Mar 2023 10:58:21 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wireless: mt76: mt7921: Fix use-after-free in fw
 features query.
Message-ID: <ZBl/vVj3wiaZl+du@lore-desk>
References: <20230308175832.2394061-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P/4+7czqGEvE9wGq"
Content-Disposition: inline
In-Reply-To: <20230308175832.2394061-1-greearb@candelatech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--P/4+7czqGEvE9wGq
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
> ...
>=20
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/init.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/init.c
> index 38d6563cb12f..d2bb8d02ce0a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -165,12 +165,12 @@ mt7921_mac_init_band(struct mt7921_dev *dev, u8 ban=
d)
> =20
>  u8 mt7921_check_offload_capability(struct device *dev, const char *fw_wm)
>  {
> -	struct mt7921_fw_features *features =3D NULL;
>  	const struct mt76_connac2_fw_trailer *hdr;
>  	struct mt7921_realease_info *rel_info;
>  	const struct firmware *fw;
>  	int ret, i, offset =3D 0;
>  	const u8 *data, *end;
> +	u8 offload_caps =3D 0;
> =20
>  	ret =3D request_firmware(&fw, fw_wm, dev);
>  	if (ret)
> @@ -197,12 +197,19 @@ u8 mt7921_check_offload_capability(struct device *d=
ev, const char *fw_wm)
>  	data +=3D sizeof(*rel_info);
>  	end =3D data + le16_to_cpu(rel_info->len);
> =20
> +	/* TODO:  This needs better sanity checking I think.
> +	 * Likely a corrupted firmware with bad rel_info->len, for instance,
> +	 * would blow this up.
> +	 */

can you please repost dropping this comment?

Regards,
Lorenzo

>  	while (data < end) {
>  		rel_info =3D (struct mt7921_realease_info *)data;
>  		data +=3D sizeof(*rel_info);
> =20
>  		if (rel_info->tag =3D=3D MT7921_FW_TAG_FEATURE) {
> +			struct mt7921_fw_features *features;
> +
>  			features =3D (struct mt7921_fw_features *)data;
> +			offload_caps =3D features->data;
>  			break;
>  		}
> =20
> @@ -211,7 +218,7 @@ u8 mt7921_check_offload_capability(struct device *dev=
, const char *fw_wm)
> =20
>  	release_firmware(fw);
> =20
> -	return features ? features->data : 0;
> +	return offload_caps;
>  }
>  EXPORT_SYMBOL_GPL(mt7921_check_offload_capability);
> =20
> --=20
> 2.39.1
>=20

--P/4+7czqGEvE9wGq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZBl/vQAKCRA6cBh0uS2t
rJrPAP9qQu0lRK8VZz504BNGvGOHyvcl/WPPCpccLqTw2M01+AEA3h/ftJt2I1Mt
JjqAPdaLIvnqIAGjp8OVVWv5h/urzQI=
=Yfvv
-----END PGP SIGNATURE-----

--P/4+7czqGEvE9wGq--
