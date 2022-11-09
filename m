Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3869D622B16
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 13:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiKIMD5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Nov 2022 07:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIMD4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Nov 2022 07:03:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59242AC78
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 04:03:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75FE76187F
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 12:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF823C433C1;
        Wed,  9 Nov 2022 12:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667995434;
        bh=NJ5GVcvGeMR/bawxbaeebqLkYeMabe8bNBhIIG7od8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FGPowr6k0l3Uh6VRLu4qXFdovu90YOb0M7cXRFg7nOZTbW2zshBedhLR6Aojse7LK
         juwDK0aXlpMq4I5+RYm0a8yfGF5ViB/xGQZxT4ll8DnmkdCuhj1Yg9Jo1hxtEyZjrv
         COV+u8D/WypzWy9Cjk69ZzAfEF6UbVs6OOGHDQO37apBfpZqE3vkJMdFwPswRcvb79
         Dpf0yuA/X587wCwhYlsjYijk9Fdw9/SlCFIw+t6mFeGozw4woM1l2OemkimnGX8bok
         Low4/WcAiwypBTnIx9zf83Pk+Y83JdsjbQJQRGlYSoWbqASEY3y11Mf5Of53H1YYwY
         mThMixSm0aQvw==
Date:   Wed, 9 Nov 2022 13:03:50 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 08/10] wifi: mt76: connac: add more starec command tags
Message-ID: <Y2uXJh5rFm9uocvz@localhost.localdomain>
References: <20221031164000.17063-1-shayne.chen@mediatek.com>
 <20221031164000.17063-9-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gT3vqYmmKO2wHLuj"
Content-Disposition: inline
In-Reply-To: <20221031164000.17063-9-shayne.chen@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--gT3vqYmmKO2wHLuj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Add starec tags which will be used in new chipset.
> This is a preliminary patch to add mt7996 chipset support.
>=20
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index ed1d24822c37..336c20fcc8dc 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -791,6 +791,8 @@ enum {
>  	STA_REC_PHY =3D 0x15,
>  	STA_REC_HE_6G =3D 0x17,
>  	STA_REC_HE_V2 =3D 0x19,
> +	STA_REC_HDRT =3D 0x28,
> +	STA_REC_HDR_TRANS =3D 0x2B,
>  	STA_REC_MAX_NUM
>  };

I guess this patch does not apply cleanly.

Regards,
Lorenzo

> =20
> --=20
> 2.25.1
>=20

--gT3vqYmmKO2wHLuj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY2uXIgAKCRA6cBh0uS2t
rIDMAPsE3oby14vVQSHX2fTS4hhlkEtnCaTSTymIorjldcYNtQD/WadNMgazZTTg
KV5JGHuWZzPzgbCa49tzU5mBIP3NvQA=
=wk8x
-----END PGP SIGNATURE-----

--gT3vqYmmKO2wHLuj--
