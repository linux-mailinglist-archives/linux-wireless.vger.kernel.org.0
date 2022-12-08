Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85728646D76
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 11:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiLHKq5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 05:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiLHKqU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 05:46:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84255C0FB
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 02:42:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4145B61EBC
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 10:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506B2C433D6;
        Thu,  8 Dec 2022 10:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670496120;
        bh=UGeHAm02eu2xmFsYY2SsC2cspuHqpxjPLBa+/QMjVlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fm0DBDocxITCLXpizgLRMOwHAOfVwa4bidyObF6NldthyeUO/v++GUtzZvPYO8AA4
         G32VTM4AdbUXImIaoY69ogZRak8yxMPv1zvRv3E68WCQFuZuUKtgxNiffojqIfI/Gt
         0h/u1LiJusDF0igaYaxasNvEpGwvsuN22JjmnNKRKJOECFYEmi/ziAJ+tReagEu9Tg
         tdqLHA5YZKx7uxV7YvqXQz9XhyKfRgUfs4krtgCVS2KLoNCETjjgD6jJWSZehpJlcC
         51s2neEVu4jpwmU8rH9CZuLoTLSynXa/MDxxlvzw3wVoffv+MdlHfVVUmDpU02nrct
         uW2ymAlKWd4ow==
Date:   Thu, 8 Dec 2022 11:41:56 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: take into possible mt76_rx_token_consume
 failures
Message-ID: <Y5G/dH3vLLg//xL0@lore-desk>
References: <22857067961409cc4873a7c8b7aa6f18e3dbb324.1670449810.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wjTMmi2raw4IPF8E"
Content-Disposition: inline
In-Reply-To: <22857067961409cc4873a7c8b7aa6f18e3dbb324.1670449810.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--wjTMmi2raw4IPF8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Take into account possible error conditions of mt76_rx_token_consume
> routine in mt7915_mmio_wed_init_rx_buf() and mt76_dma_add_buf()
>=20
> Fixes: cd372b8c99c5 ("wifi: mt76: add WED RX support to mt76_dma_{add,get=
}_buf")
> Fixes: 4f831d18d12d ("wifi: mt76: mt7915: enable WED RX support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Felix,

please drop this version, I will post a new one.

Regards,
Lorenzo

> ---
>  drivers/net/wireless/mediatek/mt76/dma.c         | 10 +++++++++-
>  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c |  7 +++++++
>  drivers/net/wireless/mediatek/mt76/tx.c          |  6 ++++--
>  3 files changed, 20 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wirel=
ess/mediatek/mt76/dma.c
> index e017d7529c2a..e1527a5a0b4d 100644
> --- a/drivers/net/wireless/mediatek/mt76/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> @@ -234,6 +234,9 @@ mt76_dma_add_buf(struct mt76_dev *dev, struct mt76_qu=
eue *q,
> =20
>  			rx_token =3D mt76_rx_token_consume(dev, (void *)skb, t,
>  							 buf[0].addr);
> +			if (rx_token < 0)
> +				return -ENOMEM;
> +
>  			buf1 |=3D FIELD_PREP(MT_DMA_CTL_TOKEN, rx_token);
>  			ctrl =3D FIELD_PREP(MT_DMA_CTL_SD_LEN0, buf[0].len) |
>  			       MT_DMA_CTL_TO_HOST;
> @@ -602,7 +605,12 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_q=
ueue *q)
>  		qbuf.addr =3D addr + offset;
>  		qbuf.len =3D len - offset;
>  		qbuf.skip_unmap =3D false;
> -		mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t);
> +		if (mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t) < 0) {
> +			dma_unmap_single(dev->dma_dev, addr, len,
> +					 DMA_FROM_DEVICE);
> +			skb_free_frag(buf);
> +			break;
> +		}
>  		frames++;
>  	}
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/mmio.c
> index 0a95c3da241b..8388e2a65853 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
> @@ -653,6 +653,13 @@ static u32 mt7915_mmio_wed_init_rx_buf(struct mtk_we=
d_device *wed, int size)
> =20
>  		desc->buf0 =3D cpu_to_le32(phy_addr);
>  		token =3D mt76_rx_token_consume(&dev->mt76, ptr, t, phy_addr);
> +		if (token < 0) {
> +			dma_unmap_single(dev->mt76.dma_dev, phy_addr,
> +					 wed->wlan.rx_size, DMA_TO_DEVICE);
> +			skb_free_frag(ptr);
> +			goto unmap;
> +		}
> +
>  		desc->token |=3D cpu_to_le32(FIELD_PREP(MT_DMA_CTL_TOKEN,
>  						      token));
>  		desc++;
> diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wirele=
ss/mediatek/mt76/tx.c
> index 24568b98ed9d..363d861a1d3e 100644
> --- a/drivers/net/wireless/mediatek/mt76/tx.c
> +++ b/drivers/net/wireless/mediatek/mt76/tx.c
> @@ -766,8 +766,10 @@ int mt76_rx_token_consume(struct mt76_dev *dev, void=
 *ptr,
>  			  GFP_ATOMIC);
>  	spin_unlock_bh(&dev->rx_token_lock);
> =20
> -	t->ptr =3D ptr;
> -	t->dma_addr =3D phys;
> +	if (token >=3D 0) {
> +		t->ptr =3D ptr;
> +		t->dma_addr =3D phys;
> +	}
> =20
>  	return token;
>  }
> --=20
> 2.38.1
>=20

--wjTMmi2raw4IPF8E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY5G/dAAKCRA6cBh0uS2t
rDJUAQDGMSKd8L0f2BXNyj+lUOf096Ifi6KcBhNSWmbnKl9O8wEAqQSEc2imMySV
x60vF0Hy64OnmOVOdcdpH0zWkEGAMws=
=82oD
-----END PGP SIGNATURE-----

--wjTMmi2raw4IPF8E--
