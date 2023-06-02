Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE61D7208AB
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 19:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236997AbjFBRzX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 13:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbjFBRzS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 13:55:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC886E6A
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 10:55:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCBF460F15
        for <linux-wireless@vger.kernel.org>; Fri,  2 Jun 2023 17:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BA2C433D2;
        Fri,  2 Jun 2023 17:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685728511;
        bh=wHywu+RF91fy7hmYuHvNUaDvXGEq/Uct5KanB8RILG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yjqx9fv9dYrvA/mX2DcMrrQvh1Ek+2ZA7mvCIAYvnL550HIRqIH22r0e+PxgieXev
         EcJhJLXwanmOlqx8CEcsMyPSrfU91mJVYDwOwoT0tBWnJg6q+bE9YdRW3hQEkm48XO
         ltfN9p1SdHmbmL8CJ0keYKfM/TbLh5DdX+b6SabluyEFpgaSTc9LamY7VMTptMNvM4
         ZQABpnmrrU8AT47Pu8H9ZWRkz6tJl8OSsp1LK0+Tf2Ly8tY00Uzw18/+tfdfAkwBk7
         Ml10uBndLpFH9doUqiyjv+6wTTmYPEM0+tjfv3akkli4Ms4LpWH4T6Gp1C+Gx8tWP+
         OB+jA02Qb1tHw==
Date:   Fri, 2 Jun 2023 19:55:07 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Shayne Chen <shayne.chen@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: Re: [PATCH 02/12] wifi: mt76: connac: add a setting bit for dsp
 firmware
Message-ID: <ZHos+yjBQRAx3gpA@lore-desk>
References: <20230602152108.26860-1-shayne.chen@mediatek.com>
 <20230602152108.26860-2-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aogP8xRthm0enbSl"
Content-Disposition: inline
In-Reply-To: <20230602152108.26860-2-shayne.chen@mediatek.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--aogP8xRthm0enbSl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Peter Chiu <chui-hao.chiu@mediatek.com>
>=20
> Add FW_START_WORKING_PDA_DSP for the indication of starting DSP
> firmware download.
>=20
> Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
> Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index ca1ce97a6d2f..4a21c237ea6e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -22,6 +22,7 @@
> =20
>  #define FW_START_OVERRIDE		BIT(0)
>  #define FW_START_WORKING_PDA_CR4	BIT(2)
> +#define FW_START_WORKING_PDA_DSP	BIT(3)

I would say this patch can be merged with 3/12 where FW_START_WORKING_PDA_D=
SP
is actually used.

Regards,
Lorenzo

> =20
>  #define PATCH_SEC_NOT_SUPPORT		GENMASK(31, 0)
>  #define PATCH_SEC_TYPE_MASK		GENMASK(15, 0)
> --=20
> 2.39.2
>=20

--aogP8xRthm0enbSl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZHos+wAKCRA6cBh0uS2t
rNJhAQChExhBQeOGbdISgwlArNKKtp8KXZLWUinOxzzUZ/z08wEAtSTuDIDJAKPO
4nnt6W+k8BOJllWKLi/pbgaL1HQQmQI=
=jdxX
-----END PGP SIGNATURE-----

--aogP8xRthm0enbSl--
