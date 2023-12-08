Return-Path: <linux-wireless+bounces-578-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4779C809FEB
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 10:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6CC281566
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Dec 2023 09:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9918612B74;
	Fri,  8 Dec 2023 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJfliCgu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B25012B72
	for <linux-wireless@vger.kernel.org>; Fri,  8 Dec 2023 09:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD36C433C7;
	Fri,  8 Dec 2023 09:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702029048;
	bh=L9DxrpPFg0VTqK80YUh2VKclrBVQGECuF1G7kvWyV08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dJfliCguy5HYrm4dng/CDcIi4Poly96g1Yf1IcD9+MxktxlX+kuhFvXFJkt2CsDZv
	 aTzTNiwJ8JcgBtiwJNw/OwE4jb4nuhDkx1wvGtjPOTUdG+IyLOPqRLK/VWnbqGKg1x
	 GvnacppmAvOc6FaDcz4W6tr0ssIqmHMSQpOBeFc65EDNM05Xwrww1RVFm6k3MzxAeB
	 IWUDviA31y7+oz2A9xfl8bx+FE6G555wd5I8WEg/FExInujs34l3gKCsjyx0KKB+0l
	 wLXC0TuZDRNFGYnZ/27xz5XbSoWXheu78rsO39fx0DdumjrZUhKZVh5J3XdWsuR8tV
	 vLOaerldC/MmA==
Date: Fri, 8 Dec 2023 10:50:45 +0100
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Felix Fietkau <nbd@nbd.name>
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org
Subject: Re: [PATCH wireless] wifi: mt76: fix crash with WED rx support
 enabled
Message-ID: <ZXLm9Xx5kBpRDwmY@lore-desk>
References: <20231208075004.69843-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tGMiBgMY/Bp2dzE7"
Content-Disposition: inline
In-Reply-To: <20231208075004.69843-1-nbd@nbd.name>


--tGMiBgMY/Bp2dzE7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> If WED rx is enabled, rx buffers are added to a buffer pool that can be
> filled from multiple page pools. Because buffers freed from rx poll are
> not guaranteed to belong to the processed queue's page pool, lockless
> caching must not be used in this case.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Cc: stable@vger.kernel.org
> Fixes: 2f5c3c77fc9b ("wifi: mt76: switch to page_pool allocator")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  drivers/net/wireless/mediatek/mt76/dma.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/dma.c b/drivers/net/wirel=
ess/mediatek/mt76/dma.c
> index 511fe7e6e744..68ad915203aa 100644
> --- a/drivers/net/wireless/mediatek/mt76/dma.c
> +++ b/drivers/net/wireless/mediatek/mt76/dma.c
> @@ -783,7 +783,7 @@ mt76_dma_rx_reset(struct mt76_dev *dev, enum mt76_rxq=
_id qid)
> =20
>  static void
>  mt76_add_fragment(struct mt76_dev *dev, struct mt76_queue *q, void *data,
> -		  int len, bool more, u32 info)
> +		  int len, bool more, u32 info, bool allow_direct)
>  {
>  	struct sk_buff *skb =3D q->rx_head;
>  	struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> @@ -795,7 +795,7 @@ mt76_add_fragment(struct mt76_dev *dev, struct mt76_q=
ueue *q, void *data,
> =20
>  		skb_add_rx_frag(skb, nr_frags, page, offset, len, q->buf_size);
>  	} else {
> -		mt76_put_page_pool_buf(data, true);
> +		mt76_put_page_pool_buf(data, allow_direct);
>  	}
> =20
>  	if (more)
> @@ -815,6 +815,7 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76=
_queue *q, int budget)
>  	struct sk_buff *skb;
>  	unsigned char *data;
>  	bool check_ddone =3D false;
> +	bool allow_direct =3D !mt76_queue_is_wed_rx(q);
>  	bool more;
> =20
>  	if (IS_ENABLED(CONFIG_NET_MEDIATEK_SOC_WED) &&
> @@ -855,7 +856,8 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76=
_queue *q, int budget)
>  		}
> =20
>  		if (q->rx_head) {
> -			mt76_add_fragment(dev, q, data, len, more, info);
> +			mt76_add_fragment(dev, q, data, len, more, info,
> +					  allow_direct);
>  			continue;
>  		}
> =20
> @@ -884,7 +886,7 @@ mt76_dma_rx_process(struct mt76_dev *dev, struct mt76=
_queue *q, int budget)
>  		continue;
> =20
>  free_frag:
> -		mt76_put_page_pool_buf(data, true);
> +		mt76_put_page_pool_buf(data, allow_direct);
>  	}
> =20
>  	mt76_dma_rx_fill(dev, q, true);
> --=20
> 2.41.0
>=20
>=20

--tGMiBgMY/Bp2dzE7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZXLm9QAKCRA6cBh0uS2t
rC5oAQC2nXTmX8376jlL9OSpVjDymjH8FNbX4BDUDKlymEtS1QD/elhhDUgbxmQp
XqlSBSDw47VbaFgcXo2OA3RZN71hCQI=
=r7Qu
-----END PGP SIGNATURE-----

--tGMiBgMY/Bp2dzE7--

