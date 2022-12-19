Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB0465099E
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Dec 2022 10:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiLSJzm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Dec 2022 04:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiLSJzk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Dec 2022 04:55:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1866CDF7E
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 01:55:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8239B80BA3
        for <linux-wireless@vger.kernel.org>; Mon, 19 Dec 2022 09:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1960C433D2;
        Mon, 19 Dec 2022 09:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671443734;
        bh=FVHUfLGk+FwVencu3d0d7zbOlfjP8sAC3w4aJrESkqs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LAE/HLqWA47hFGR/Zlli4C+3R6DLNKkZV62sbQLuveqxzMYRhVWlUjKJBGgrlQImM
         iv9Lb0oEjuMFlNUzhoHQAqglNNFi84IXTM/l8q35DAXAfLJ222zLgrnN8k6Dc4eMqW
         mif+JnyV3RQUYwxPV3f1wttYR2Ha8RoDKUPZQEXG9IT3en6vC7ydUHEm8ubDkeHFoG
         OEymUecbkyHxiEsDJsI5DEpOnu+YacCuL6jhvgB8pLIlYKSe5Q6Eqb8985qgQQ/m+z
         32mIPr+3Zn1+dSbKr7i3ZnOGjW9mQ6PcRds/pvV4Uz3AfAzP4HSIklTjSj1q1lCg2g
         YJAIXHNYaQ1Gg==
Date:   Mon, 19 Dec 2022 10:55:30 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Bo Jiao <bo.jiao@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] wifi: mt76: fix potential memory leakage
Message-ID: <Y6A1Et1yzcWnWhpy@lore-desk>
References: <0a218783098a6b1b90ff120c7182acee93dc8feb.1671423784.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GYX6T5wvBRqxBDpz"
Content-Disposition: inline
In-Reply-To: <0a218783098a6b1b90ff120c7182acee93dc8feb.1671423784.git.Bo.Jiao@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--GYX6T5wvBRqxBDpz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Bo Jiao <Bo.Jiao@mediatek.com>
>=20
> fix potential memory leakage, recycle rxwi when mt76_dma_add_buf() call f=
ail.
>=20
> Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> ---
> v2:
> - recycle rxwi when page_frag_alloc() and dma_map_single() fail.
> ---
>  drivers/net/wireless/mediatek/mt76/dma.c | 27 ++++++++++++++----------
>  1 file changed, 16 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wirel=
ess/mediatek/mt76/dma.c
> index fc24b35..76ad47d 100644
> --- a/drivers/net/wireless/mediatek/mt76/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> @@ -580,24 +580,29 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_=
queue *q)
> =20
>  		buf =3D page_frag_alloc(&q->rx_page, q->buf_size, GFP_ATOMIC);
>  		if (!buf)
> -			break;
> +			goto out;
> =20
>  		addr =3D dma_map_single(dev->dma_dev, buf, len, DMA_FROM_DEVICE);
> -		if (unlikely(dma_mapping_error(dev->dma_dev, addr))) {
> -			skb_free_frag(buf);
> -			break;
> -		}
> +		if (unlikely(dma_mapping_error(dev->dma_dev, addr)))
> +			goto free;
> =20
>  		qbuf.addr =3D addr + offset;
>  		qbuf.len =3D len - offset;
>  		qbuf.skip_unmap =3D false;
> -		if (mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t) < 0) {
> -			dma_unmap_single(dev->dma_dev, addr, len,
> -					 DMA_FROM_DEVICE);
> -			skb_free_frag(buf);
> -			break;
> -		}
> +		if (mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t) < 0)
> +			goto umap;
> +
>  		frames++;
> +		continue;
> +
> +umap:
> +		dma_unmap_single(dev->dma_dev, addr, len,
> +				 DMA_FROM_DEVICE);
> +free:
> +		skb_free_frag(buf);
> +out:
> +		mt76_put_rxwi(dev, t);
> +		break;
>  	}
> =20
>  	if (frames)

Hi Bo,

I guess in the way below, the code is more readable, what do you think?

Regards,
Lorenzo

diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wireles=
s/mediatek/mt76/dma.c
index fad5fe19fe18..001538f698f1 100644
--- a/drivers/net/wireless/mediatek/mt76/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/dma.c
@@ -571,13 +571,6 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_que=
ue *q)
 		struct mt76_queue_buf qbuf;
 		void *buf =3D NULL;
=20
-		if ((q->flags & MT_QFLAG_WED) &&
-		    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) =3D=3D MT76_WED_Q_RX) {
-			t =3D mt76_get_rxwi(dev);
-			if (!t)
-				break;
-		}
-
 		buf =3D page_frag_alloc(&q->rx_page, q->buf_size, GFP_ATOMIC);
 		if (!buf)
 			break;
@@ -588,16 +581,27 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct mt76_qu=
eue *q)
 			break;
 		}
=20
+		if ((q->flags & MT_QFLAG_WED) &&
+		    FIELD_GET(MT_QFLAG_WED_TYPE, q->flags) =3D=3D MT76_WED_Q_RX) {
+			t =3D mt76_get_rxwi(dev);
+			if (!t)
+				goto unmap;
+		}
+
 		qbuf.addr =3D addr + offset;
 		qbuf.len =3D len - offset;
 		qbuf.skip_unmap =3D false;
-		if (mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t) < 0) {
-			dma_unmap_single(dev->dma_dev, addr, len,
-					 DMA_FROM_DEVICE);
-			skb_free_frag(buf);
-			break;
+
+		if (!mt76_dma_add_buf(dev, q, &qbuf, 1, 0, buf, t)) {
+			frames++;
+			continue;
 		}
-		frames++;
+
+unmap:
+		dma_unmap_single(dev->dma_dev, addr, len, DMA_FROM_DEVICE);
+		skb_free_frag(buf);
+		mt76_put_rxwi(dev, t);
+		break;
 	}
=20
 	if (frames)

> --=20
> 2.18.0
>=20

--GYX6T5wvBRqxBDpz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY6A1EgAKCRA6cBh0uS2t
rBwPAQD44i+a+7jteXHTxdG433JNJtOhfHYBcIa/JOOLWl61SQD+J+RUiW2LG8BU
LnZeQn1Ykxqe0g+zW03IxQfjXMv7qw0=
=27vm
-----END PGP SIGNATURE-----

--GYX6T5wvBRqxBDpz--
