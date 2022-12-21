Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26626652F78
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Dec 2022 11:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234586AbiLUKaw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Dec 2022 05:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234505AbiLUK3p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Dec 2022 05:29:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5969E21884
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 02:26:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA78561758
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 10:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62BEC433D2;
        Wed, 21 Dec 2022 10:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671618385;
        bh=vX5YCsGjJRB4RCj7GNynp2IUhgssJobCUhxfzQJjB+g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jf6cVpE5cjFigkl95FcmSS2mVuEvejcwjXRb9wNQojkN9ee6otVvbpSz6ioCBfmSX
         TsYUWENSp0eNODdZs4uuyAo0h0X1kLTyWrOQwKPjZ6Fbj2uJcYDkfm49CEwvRfHyHm
         QSCVfQ41LuUpP+9jzZJXqeh0bsl2jSg1uwcgxlATB/menVwcz/Zj5IBsaYEOcOAlgJ
         VgwYjhm569FLwyTZB7EVTuXC21Z0JpTdA7XuDMa7kedW0qYxu3HNK6pLmMxeQbG6BN
         XZH172uOuklJxORO6GSZ8Pjd2bo6AxCF04/fwNdffuv8lzyfTbuszlrJaGW4VxWVGk
         Xy/wY4qr9Wt6g==
Date:   Wed, 21 Dec 2022 11:26:21 +0100
From:   "lorenzo@kernel.org" <lorenzo@kernel.org>
To:     Sujuan Chen =?utf-8?B?KOmZiOe0oOWonyk=?= 
        <Sujuan.Chen@mediatek.com>
Cc:     Bo Jiao =?utf-8?B?KOeEpuazoik=?= <Bo.Jiao@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Shayne Chen =?utf-8?B?KOmZs+i7kuS4nik=?= 
        <Shayne.Chen@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        Evelyn Tsai =?utf-8?B?KOiUoeePiumIuik=?= 
        <Evelyn.Tsai@mediatek.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] wifi: mt76: fix potential memory leakage
Message-ID: <Y6LfTUoSZ8W/gJ0Y@lore-desk>
References: <0a218783098a6b1b90ff120c7182acee93dc8feb.1671423784.git.Bo.Jiao@mediatek.com>
 <Y6A1Et1yzcWnWhpy@lore-desk>
 <9d8aa92e3650128c94af91435a222c00ff2acb1c.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SyFKwzvfz74vbiYO"
Content-Disposition: inline
In-Reply-To: <9d8aa92e3650128c94af91435a222c00ff2acb1c.camel@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--SyFKwzvfz74vbiYO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]

> Hi Lore,

Hi Sujuan,

>=20
> we love your patch, but we have another patch to avoid memory
> fragmentation by duplicating the rx skb after mt76_dma_dequeue(). it
> requires mt76_get_rxwi() be placed before page_frag_alloc().
>=20
> the below patch(need rebase) will be sent after the current patch is
> accepted.
>=20
> --- a/drivers/net/wireless/mediatek/mt76/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> @@ -386,9 +386,11 @@ mt76_dma_get_buf(struct mt76_dev *dev, struct
> mt76_queue *q, int idx,
>                                  SKB_WITH_OVERHEAD(q->buf_size),
>                                  DMA_FROM_DEVICE);
>=20
> -               buf =3D t->ptr;
> +               buf =3D page_frag_alloc(&q->rx_page, q->buf_size,
> GFP_ATOMIC);
> +               if (!buf)
> +                       return NULL;
> +               memcpy(buf, t->ptr, SKB_WITH_OVERHEAD(q->buf_size));

We this approach we still need to allocate the buffer (in mt76_dma_get_buf()
instead of mt76_dma_rx_fill()) but we need even to copy the full buffer that
can be pretty expensive instead of relying on the DMA, so I would avoid this
approach.

Regards,
Lorenzo

>                 t->dma_addr =3D 0;
> -               t->ptr =3D NULL;
>=20
>                 mt76_put_rxwi(dev, t);
>=20
> @@ -569,6 +571,7 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct
> mt76_queue *q)
>         while (q->queued < q->ndesc - 1) {
>                 struct mt76_txwi_cache *t =3D NULL;
>                 struct mt76_queue_buf qbuf;
> +               bool skip_alloc =3D false;
>                 void *buf =3D NULL;
>=20
>                 if ((q->flags & MT_QFLAG_WED) &&
> @@ -576,11 +579,19 @@ mt76_dma_rx_fill(struct mt76_dev *dev, struct
> mt76_queue *q)
>                         t =3D mt76_get_rxwi(dev);
>                         if (!t)
>                                 break;
> +
> +                       if (t->ptr) {
> +                               skip_alloc =3D true;
> +                               buf =3D t->ptr;
> +                       }
>                 }
>=20
> -               buf =3D page_frag_alloc(&q->rx_page, q->buf_size,
> GFP_ATOMIC);
> -               if (!buf)
> -                       break;
> +               if (!skip_alloc) {
> +                       buf =3D page_frag_alloc(&q->rx_page, q->buf_size,
> +                                             GFP_ATOMIC);
> +                       if (!buf)
> +                               break;
> +               }
>=20
>                 addr =3D dma_map_single(dev->dma_dev, buf, len,
> DMA_FROM_DEVICE);
>                 if (unlikely(dma_mapping_error(dev->dma_dev, addr))) {
> --
> 2.18.0
>=20
> > > --=20
> > > 2.18.0
> > >=20

--SyFKwzvfz74vbiYO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY6LfTQAKCRA6cBh0uS2t
rBF/AP0ce3mIwZ/Uk5Zj1Y0rWsZg6hECTlHMNDdzISxhS4OuiwD/RSy8M9Sf3rVK
R4S5GCzFMqSqiU0ogdBVoRnk0nsccg0=
=wWbO
-----END PGP SIGNATURE-----

--SyFKwzvfz74vbiYO--
