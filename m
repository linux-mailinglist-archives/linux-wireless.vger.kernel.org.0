Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D5269F2A0
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Feb 2023 11:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjBVKYE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Feb 2023 05:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjBVKYD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Feb 2023 05:24:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107862F781
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 02:24:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65E07B8114D
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 10:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8409CC433D2;
        Wed, 22 Feb 2023 10:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677061438;
        bh=/IPqJeGoKimjKk8TQKkgo327g7gx9IzFFcnl0z+a32U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mkgnYa44WjsnBwuRg3yuLBvS4gFNYXwRu72NouLMesRcP0jHRx5Ka3lXHmwuSQtHn
         DQ9alQ5kkWQikxYufIBVLdTts59QCUVf1JK4Rxn2WCuLJ1aee5z+4073alGTjaCFQs
         b+osux5N4jfk9RDV8bTI9R1AMfHSoqxZ1i8KGWAViWr6ZsPjQqYpLGEMI6BU/3DWQl
         +mKsQQnHNFbuv1L+kDSri8PetRzFY1ZkANlJ6dYWFfQ/MzmVtcsxEVgu56iNpBfxIi
         8YC0PhjAVnmIX3td+H1zzrR8MSS2vjzxuTYOU7VSHaxMvcRBxcAT5D92bEcuTPxOvG
         EXiRqW7ZQOEfw==
Date:   Wed, 22 Feb 2023 11:23:54 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Sujuan Chen <sujuan.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Bo Jiao <bo.jiao@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] wifi: mt76: mt7915: add dev->hif2 support for mt7916
 WED device
Message-ID: <Y/XtOhW5fUshrUPY@lore-desk>
References: <73e1988a12a60fa0c661edc8328a302b92392b94.1677056399.git.sujuan.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jW1opb75XE5j4F3L"
Content-Disposition: inline
In-Reply-To: <73e1988a12a60fa0c661edc8328a302b92392b94.1677056399.git.sujuan.chen@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--jW1opb75XE5j4F3L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Enable two PCIe interfaces (dev->hif2) support for mt7916 when WED is ena=
bled.
>=20
> Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/dma.c  | 10 ++++++++--
>  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c  |  4 +++-
>  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c | 10 +++++-----
>  3 files changed, 16 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/dma.c
> index abe17dac9996..43a5456d4b97 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/dma.c
> @@ -87,8 +87,14 @@ static void mt7915_dma_config(struct mt7915_dev *dev)
>  				   MT7916_RXQ_BAND0);
>  			RXQ_CONFIG(MT_RXQ_MCU_WA, WFDMA0, MT_INT_WED_RX_DONE_WA_MT7916,
>  				   MT7916_RXQ_MCU_WA);
> -			RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0, MT_INT_WED_RX_DONE_BAND1_MT7916,
> -				   MT7916_RXQ_BAND1);
> +			if (dev->hif2)
> +				RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0,
> +					   MT_INT_RX_DONE_BAND1_MT7916,
> +					   MT7916_RXQ_BAND1);
> +			else
> +				RXQ_CONFIG(MT_RXQ_BAND1, WFDMA0,
> +					   MT_INT_WED_RX_DONE_BAND1_MT7916,
> +					   MT7916_RXQ_BAND1);
>  			RXQ_CONFIG(MT_RXQ_MAIN_WA, WFDMA0, MT_INT_WED_RX_DONE_WA_MAIN_MT7916,
>  				   MT7916_RXQ_MCU_WA_MAIN);
>  			TXQ_CONFIG(0, WFDMA0, MT_INT_WED_TX_DONE_BAND0,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mcu.c
> index 5545a8bdf1d0..1dfbcc9bf755 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@ -2370,7 +2370,9 @@ int mt7915_mcu_init_firmware(struct mt7915_dev *dev)
>  	if (ret)
>  		return ret;
> =20
> -	if (mtk_wed_device_active(&dev->mt76.mmio.wed) && is_mt7915(&dev->mt76))
> +	if ((mtk_wed_device_active(&dev->mt76.mmio.wed) &&
> +	     is_mt7915(&dev->mt76)) ||
> +	    (!mtk_wed_get_rx_capa(&dev->mt76.mmio.wed)))

you do not need brackets around mtk_wed_get_rx_capa().

Regards,
Lorenzo

>  		mt7915_mcu_wa_cmd(dev, MCU_WA_PARAM_CMD(CAPABILITY), 0, 0, 0);
> =20
>  	ret =3D mt7915_mcu_set_mwds(dev, 1);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/mmio.c
> index 225a19604d3e..6f0c0e2ae045 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> @@ -989,13 +989,13 @@ irqreturn_t mt7915_irq_handler(int irq, void *dev_i=
nstance)
>  	struct mt7915_dev *dev =3D dev_instance;
>  	struct mtk_wed_device *wed =3D &dev->mt76.mmio.wed;
> =20
> -	if (mtk_wed_device_active(wed)) {
> +	if (mtk_wed_device_active(wed))
>  		mtk_wed_device_irq_set_mask(wed, 0);
> -	} else {
> +	else
>  		mt76_wr(dev, MT_INT_MASK_CSR, 0);
> -		if (dev->hif2)
> -			mt76_wr(dev, MT_INT1_MASK_CSR, 0);
> -	}
> +
> +	if (dev->hif2)
> +		mt76_wr(dev, MT_INT1_MASK_CSR, 0);
> =20
>  	if (!test_bit(MT76_STATE_INITIALIZED, &dev->mphy.state))
>  		return IRQ_NONE;
> --=20
> 2.18.0
>=20

--jW1opb75XE5j4F3L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY/XtOgAKCRA6cBh0uS2t
rENuAQD4VLHFi+3as+XO3kqv/YNJnjnIwnzxtjNgbjSOaOQ+PQEA/W7ZaHwxlSK2
9IZuP08C7N/VpbvHyKD697BA639yjAQ=
=OivV
-----END PGP SIGNATURE-----

--jW1opb75XE5j4F3L--
