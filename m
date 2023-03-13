Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3947E6B7DCE
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 17:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjCMQjK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 12:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjCMQin (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 12:38:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C7F15CA1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 09:38:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D511B81196
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 16:38:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35DAC433D2;
        Mon, 13 Mar 2023 16:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678725515;
        bh=S+Zuod+aYRKVw0CySkrGpsd8YzEXpHKYCBbg7a+t4gE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kp70ZQ3cnk1Gg+Ox3q5Jj7v6caYVSq4L3MpYKpQme6SyMXNWVLHq2tRMNjg+wGnhN
         IDuU7hz1lYZo1F5r4b9+QnHZvz10MdIcZ6jEvjDEeY4NbMoHd76TQt5dnHt+/vVaeb
         D8pHJALraa7Ez+Ju0d531pmNE7Iz8zhTiTzh2XsPSyKegV/neWMdSUDlsc0gi7JMXC
         mPWfO0ccVovJK98rbsHqBQCLU7BC36GNNjNtf6b2Drd3t4i+ZhWnsUk5yNfd30+34+
         oceu3BIqEteoB7Hgw0WStAsEdmJL87owFy9h1M7bFvuj5TKnHyNLnuij4smvRncthd
         6lhYdth6uADJA==
Date:   Mon, 13 Mar 2023 17:38:31 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] wireless: mt76: mt7921: Fix use-after-free in fw
 features query.
Message-ID: <ZA9Rh1je1gLmAXLp@lore-desk>
References: <20230308175832.2394061-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="I5v+iUVw3MUvn8PU"
Content-Disposition: inline
In-Reply-To: <20230308175832.2394061-1-greearb@candelatech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--I5v+iUVw3MUvn8PU
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

I would say even this patch can go trough wireless tree.

@Felix: agree?

Regards,
Lorenzo

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

--I5v+iUVw3MUvn8PU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZA9RhwAKCRA6cBh0uS2t
rI1gAQCAH9D1pkjaCZtMUrpSCRSBrRBrqhJhRNczexj/+iNRuAEAuzPmQK4/JQul
lpi0Ooe6lySGG2cbQ0k2u9U1+yJVPQA=
=tfwd
-----END PGP SIGNATURE-----

--I5v+iUVw3MUvn8PU--
