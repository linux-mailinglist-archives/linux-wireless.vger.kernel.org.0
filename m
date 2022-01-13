Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB3348D4C2
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 10:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbiAMJJI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 04:09:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:46928 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230094AbiAMJJI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 04:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642064947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5i+ykEDe6nWgdV5O3/8aCcNAbW20DKh9SpDiC8ZGos8=;
        b=JKnqsHFmkuXqN3vlktrYfWABPeIeEbKiF8d1hnF84Yji4wq1eI1OuKm7ko+P3aD1yUzSq7
        F4wdNQucobBt8k0iUYyrr8pJQkriGxqX0EpiNoUi1L5znHBHVxgitdDdmsUJdngYKM9OVS
        P4qIeuTjyN9UoWX8B7LddkkkI/7FYnU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-M9NQ-9AHOOSKHPWqzLQhng-1; Thu, 13 Jan 2022 04:09:04 -0500
X-MC-Unique: M9NQ-9AHOOSKHPWqzLQhng-1
Received: by mail-wr1-f70.google.com with SMTP id d20-20020adfa414000000b001c9207acbe3so210039wra.1
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jan 2022 01:09:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5i+ykEDe6nWgdV5O3/8aCcNAbW20DKh9SpDiC8ZGos8=;
        b=dCxbJ2WaH5cPpyVWwGDePyUa3FGuSzUYqhBeeuoFFetbMM4QmdDYCjx+iOzJGpqLPG
         rlYk0QVvRvWT+R4aNA6Xbpcljo31ezMPjxzvfa3rwWqjptbEgtZWL9NwBA+hokkRXshs
         je/8hzfzUy2SSSSfe6IUdZhlGJrDA3vk5qS3GhaKbTafmhdASMu6xI6CNwD6Z2CP3brC
         SCSXr4d9HgoKMLWHYmg1KZKrx5mPn9UHxLsPUSAh91dHkhA6Wh4XRvkZH9lzbrbu1SuJ
         Q5B2RVjd2WjJEnW/o2VX/4QRFq5J3W2otvkGtj08H4LFGU5EjxjI+ItNWkRwXPaws3H3
         UuhA==
X-Gm-Message-State: AOAM531ODMNWmqzvMOQYFbKOiqp107jsQliJbHiW3ov6dkOz9WaUW+bx
        T9lBq27PNpMNNhvOPtCCWOX0GJTHn9LIW+0O1QiltUKN9vxSWpd/gFazgPVG8k/fKhvX6v+txnM
        xgzJjAs9uxj/fsGk7yqflX8xXNrg=
X-Received: by 2002:a1c:a987:: with SMTP id s129mr9818546wme.161.1642064943433;
        Thu, 13 Jan 2022 01:09:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxqVilqZ5CCJ1w5sQvZLvNFtzkj3cmxk9TlmmPD+fvbSM7UH4TReOF2vZy47/tH0z0pgzXbBA==
X-Received: by 2002:a1c:a987:: with SMTP id s129mr9818518wme.161.1642064943151;
        Thu, 13 Jan 2022 01:09:03 -0800 (PST)
Received: from localhost (net-93-146-37-237.cust.vodafonedsl.it. [93.146.37.237])
        by smtp.gmail.com with ESMTPSA id m12sm2443526wrp.49.2022.01.13.01.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 01:09:02 -0800 (PST)
Date:   Thu, 13 Jan 2022 10:09:00 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Mark-YW.Chen@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, jenhao.yang@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/3] mt76: sdio: remove those unnecessary buffers in
 sdio.xmit_buf
Message-ID: <Yd/sLP8spK7S5M9U@lore-desk>
References: <651a010d8ff888909b5b8363fa4b243aadc62d45.1642061035.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IaqNoFyvwuQdIVzk"
Content-Disposition: inline
In-Reply-To: <651a010d8ff888909b5b8363fa4b243aadc62d45.1642061035.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--IaqNoFyvwuQdIVzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> We don't have to create a separate sdio.xmit_buf buffer for each queue.
> Instead, we just need to create one, reuse it across all queues to reduce
> memory consumption further.
>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h        |  2 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/sdio.c | 15 ++++++---------
>  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c | 15 ++++++---------
>  drivers/net/wireless/mediatek/mt76/sdio_txrx.c   | 15 ++++++---------
>  4 files changed, 19 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index 14f60fcb6a34..4029a2217397 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -507,7 +507,7 @@ struct mt76_sdio {
> =20
>  	struct work_struct stat_work;
> =20
> -	u8 *xmit_buf[IEEE80211_NUM_ACS + 2];
> +	u8 *xmit_buf;
> =20
>  	struct sdio_func *func;
>  	void *intr_data;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/n=
et/wireless/mediatek/mt76/mt7615/sdio.c
> index 71162befdae8..554160b0ea9a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
> @@ -101,7 +101,7 @@ static int mt7663s_probe(struct sdio_func *func,
>  	struct ieee80211_ops *ops;
>  	struct mt7615_dev *dev;
>  	struct mt76_dev *mdev;
> -	int i, ret;
> +	int ret;
> =20
>  	ops =3D devm_kmemdup(&func->dev, &mt7615_ops, sizeof(mt7615_ops),
>  			   GFP_KERNEL);
> @@ -140,14 +140,11 @@ static int mt7663s_probe(struct sdio_func *func,
>  		goto error;
>  	}
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(mdev->sdio.xmit_buf); i++) {
> -		mdev->sdio.xmit_buf[i] =3D devm_kmalloc(mdev->dev,
> -						      MT76S_XMIT_BUF_SZ,
> -						      GFP_KERNEL);
> -		if (!mdev->sdio.xmit_buf[i]) {
> -			ret =3D -ENOMEM;
> -			goto error;
> -		}
> +	mdev->sdio.xmit_buf =3D devm_kmalloc(mdev->dev, MT76S_XMIT_BUF_SZ,
> +					   GFP_KERNEL);
> +	if (!mdev->sdio.xmit_buf) {
> +		ret =3D -ENOMEM;
> +		goto error;
>  	}

I guess we can move buffer allocation in mt76s_init() and remove duplicated
code in mt7663/mt7921.

Reagards,
Lorenzo

> =20
>  	ret =3D mt76s_alloc_rx_queue(mdev, MT_RXQ_MAIN);
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/sdio.c
> index 743b63f66efa..c58c14e28430 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> @@ -121,7 +121,7 @@ static int mt7921s_probe(struct sdio_func *func,
> =20
>  	struct mt7921_dev *dev;
>  	struct mt76_dev *mdev;
> -	int ret, i;
> +	int ret;
> =20
>  	mdev =3D mt76_alloc_device(&func->dev, sizeof(*dev), &mt7921_ops,
>  				 &drv_ops);
> @@ -154,14 +154,11 @@ static int mt7921s_probe(struct sdio_func *func,
>  		goto error;
>  	}
> =20
> -	for (i =3D 0; i < ARRAY_SIZE(mdev->sdio.xmit_buf); i++) {
> -		mdev->sdio.xmit_buf[i] =3D devm_kmalloc(mdev->dev,
> -						      MT76S_XMIT_BUF_SZ,
> -						      GFP_KERNEL);
> -		if (!mdev->sdio.xmit_buf[i]) {
> -			ret =3D -ENOMEM;
> -			goto error;
> -		}
> +	mdev->sdio.xmit_buf =3D devm_kmalloc(mdev->dev, MT76S_XMIT_BUF_SZ,
> +					   GFP_KERNEL);
> +	if (!mdev->sdio.xmit_buf) {
> +		ret =3D -ENOMEM;
> +		goto error;
>  	}
> =20
>  	ret =3D mt76s_alloc_rx_queue(mdev, MT_RXQ_MAIN);
> diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net=
/wireless/mediatek/mt76/sdio_txrx.c
> index 488ad7734d85..a04cd2444247 100644
> --- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> +++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> @@ -229,12 +229,11 @@ static int __mt76s_xmit_queue(struct mt76_dev *dev,=
 u8 *data, int len)
> =20
>  static int mt76s_tx_run_queue(struct mt76_dev *dev, struct mt76_queue *q)
>  {
> -	int qid, err, nframes =3D 0, len =3D 0, pse_sz =3D 0, ple_sz =3D 0;
> +	int err, nframes =3D 0, len =3D 0, pse_sz =3D 0, ple_sz =3D 0;
>  	bool mcu =3D q =3D=3D dev->q_mcu[MT_MCUQ_WM];
>  	struct mt76_sdio *sdio =3D &dev->sdio;
>  	u8 pad;
> =20
> -	qid =3D mcu ? ARRAY_SIZE(sdio->xmit_buf) - 1 : q->qid;
>  	while (q->first !=3D q->head) {
>  		struct mt76_queue_entry *e =3D &q->entry[q->first];
>  		struct sk_buff *iter;
> @@ -262,20 +261,18 @@ static int mt76s_tx_run_queue(struct mt76_dev *dev,=
 struct mt76_queue *q)
>  					&ple_sz))
>  			break;
> =20
> -		memcpy(sdio->xmit_buf[qid] + len, e->skb->data,
> -		       skb_headlen(e->skb));
> +		memcpy(sdio->xmit_buf + len, e->skb->data, skb_headlen(e->skb));
>  		len +=3D skb_headlen(e->skb);
>  		nframes++;
> =20
>  		skb_walk_frags(e->skb, iter) {
> -			memcpy(sdio->xmit_buf[qid] + len, iter->data,
> -			       iter->len);
> +			memcpy(sdio->xmit_buf + len, iter->data, iter->len);
>  			len +=3D iter->len;
>  			nframes++;
>  		}
> =20
>  		if (unlikely(pad)) {
> -			memset(sdio->xmit_buf[qid] + len, 0, pad);
> +			memset(sdio->xmit_buf + len, 0, pad);
>  			len +=3D pad;
>  		}
>  next:
> @@ -284,8 +281,8 @@ static int mt76s_tx_run_queue(struct mt76_dev *dev, s=
truct mt76_queue *q)
>  	}
> =20
>  	if (nframes) {
> -		memset(sdio->xmit_buf[qid] + len, 0, 4);
> -		err =3D __mt76s_xmit_queue(dev, sdio->xmit_buf[qid], len + 4);
> +		memset(sdio->xmit_buf + len, 0, 4);
> +		err =3D __mt76s_xmit_queue(dev, sdio->xmit_buf, len + 4);
>  		if (err)
>  			return err;
>  	}
> --=20
> 2.25.1
>=20

--IaqNoFyvwuQdIVzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYd/sLAAKCRA6cBh0uS2t
rIt9AQC2z+vzZfUGRj9rx+Ye6hLuKiZ/ETuJQmP9wrR0E9PSTwD/RNUl08g0o4qr
gRb0LE+/XZoZt5cwqGlVnLf7Ln14+QM=
=Za6C
-----END PGP SIGNATURE-----

--IaqNoFyvwuQdIVzk--

