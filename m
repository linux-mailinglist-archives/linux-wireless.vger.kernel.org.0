Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B11364EFB2
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Dec 2022 17:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiLPQsc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 16 Dec 2022 11:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPQs1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 16 Dec 2022 11:48:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBE018E1D
        for <linux-wireless@vger.kernel.org>; Fri, 16 Dec 2022 08:48:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD938B81DD1
        for <linux-wireless@vger.kernel.org>; Fri, 16 Dec 2022 16:48:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA999C433D2;
        Fri, 16 Dec 2022 16:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671209304;
        bh=jyl/zC15tNhZDmBGJE+3qLmjSeuFuNsHM8XNNGU5gQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mMnE57b0hxgZX7IWHY/j8UL+kmKQ24u24QvVKoQ2xy7jZAGERfkdn9XlHDaWH6s1k
         QfPOzaNEYXOqjhvO6cJA80XBKT93kVnZD/0tAL0g4DTeRhmoRzmR0T3hwvQKh7QMFY
         nanEVY9vpLxUBUi9E5tqrVozSx782+aL733UaAdf2dYPPUuv6Wr45C1pOj9od2gBSx
         B9ytBTqj4U12GIEmHfFZOz5NnobreAsCcA+7hjVOOaMH8uX1aTYghLiqXLW/nlGgmD
         CGmtjq1CZSshYJbPiKYMKErOKMyC/F2sYhXJdSLx0OVrQvpTVcFqNgaGSItnK0I9nA
         isctU2UWnCMUw==
Date:   Fri, 16 Dec 2022 17:48:20 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Bo Jiao <bo.jiao@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] wifi: mt76: fix potential memory leakage
Message-ID: <Y5yhVN0lwPOyq6oP@lore-desk>
References: <c663e984077ae903d8d4d34ed470986c6ccb4757.1671157658.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kytPndXVJDl+F4EW"
Content-Disposition: inline
In-Reply-To: <c663e984077ae903d8d4d34ed470986c6ccb4757.1671157658.git.Bo.Jiao@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--kytPndXVJDl+F4EW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Bo Jiao <Bo.Jiao@mediatek.com>
>=20
> fix potential memory leakage, recycle rxwi when mt76_dma_add_buf() call f=
ails.
>=20
> Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/dma.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wirel=
ess/mediatek/mt76/dma.c
> index fc24b35..9053344 100644
> --- a/drivers/net/wireless/mediatek/mt76/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> @@ -592,6 +592,7 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_qu=
eue *q)
>  		qbuf.len =3D len - offset;
>  		qbuf.skip_unmap =3D false;
>  		if (mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t) < 0) {
> +			mt76_put_rxwi(dev, t);

I think we should add it even if page_frag_alloc or dma_map_single fail.

Regards,
Lorenzo

>  			dma_unmap_single(dev->dma_dev, addr, len,
>  					 DMA_FROM_DEVICE);
>  			skb_free_frag(buf);
> --=20
> 2.18.0
>=20

--kytPndXVJDl+F4EW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY5yhVAAKCRA6cBh0uS2t
rBTHAP9ya7XWNqF0ld0OIGv50h74+PKRugcN9VCTYk8bV6qaUQEA+wPVmG/pCeCn
jNfS+uiMW1sWTJOALvATPDJm+kvLswg=
=3NtI
-----END PGP SIGNATURE-----

--kytPndXVJDl+F4EW--
