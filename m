Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D357632D458
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 14:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241401AbhCDNkg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Mar 2021 08:40:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44330 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241384AbhCDNkI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Mar 2021 08:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614865123;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Oiw/daA+qGj8KoGgNbsja8mLaNqMYW3y+9Hx03xilNY=;
        b=e4hPZEf4cfU3rAzK0l8AaBZJzVzGmbJQvz72xzB7dQFAP5eAlm5/s3g1Uj/Q4EtA6LZm9s
        WMCLNp7OV6CfdcpCK3nd8MqTy9Zg3WCcMkIpjiah8ZQow2v7GqMkvHgmR1NZvE1yg9C6C2
        vk/Bj8FhuY6zTtxRrizrCsmhPVBMbYI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-sluaC05EMhiCsqsH6Ca3bg-1; Thu, 04 Mar 2021 08:38:38 -0500
X-MC-Unique: sluaC05EMhiCsqsH6Ca3bg-1
Received: by mail-ej1-f70.google.com with SMTP id r26so6592005eja.22
        for <linux-wireless@vger.kernel.org>; Thu, 04 Mar 2021 05:38:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oiw/daA+qGj8KoGgNbsja8mLaNqMYW3y+9Hx03xilNY=;
        b=lQTs0nHwMyWGXNu/RssbuY4/wHYwr/5bOrb5tk1/43B+e3+H5jUcQg/qeSve/uy/c+
         PLNhhCmOowsuj/ZEPmbD/TEluq1N2b2oY8MkqWFsWPAZ2Qm15P/qtEWhgujXZORdas0+
         yS3sja7ZPbuFvw0qA0X1CGhngN7NTScLQjKzzhEXr8Ip+hTFxyZSvR8DedffBRVqYb4r
         VQIUypjDGVc4arkpX561I60euhsrsNPxL5s8jZsqlWMVBV5pnJKKf2+LwayaSnNv5IVV
         55JskDi6LEJ83Hfd/GBL+RQO//hDMwGgPMQNH0+lncdxlzwzclbEdRF/zOIO8F8HXfzj
         QyyA==
X-Gm-Message-State: AOAM531/aGg6E+J6fhKhoWb8AUfE7dgvvi9Lqp7TH/uE6mW49wIdUfDg
        o74kJptKQXuGDVj9k7/WDqs1AxrcGIb/oBQNG2UzUogHfD5YRgalGy71XdSDvhVD4yo8141unEW
        FvUDZxsujayOZWOIR/A+ma4vj1go=
X-Received: by 2002:a17:906:f88a:: with SMTP id lg10mr4363915ejb.39.1614865117674;
        Thu, 04 Mar 2021 05:38:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxggMDSjQQFCKjj5w9R7gOyQG8g99FhdQswp5k69KW2fdMug7MAE6qUSw556i1kut2aBGX9cg==
X-Received: by 2002:a17:906:f88a:: with SMTP id lg10mr4363894ejb.39.1614865117479;
        Thu, 04 Mar 2021 05:38:37 -0800 (PST)
Received: from localhost ([151.66.54.126])
        by smtp.gmail.com with ESMTPSA id mc10sm9780451ejb.56.2021.03.04.05.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 05:38:36 -0800 (PST)
Date:   Thu, 4 Mar 2021 14:38:33 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/3] mt76: mt7663s: make all of packets 4-bytes aligned
 in sdio tx aggregation
Message-ID: <YEDi2VvIBEe7DRuY@lore-desk>
References: <801a2aa986f5486a0e789065feef7b77c612ea7b.1614863741.git.objelf@gmail.com>
 <8f6807d6161efbed6d585a2ca041d4b126b30451.1614863741.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9L+8xSSpwTrxyrty"
Content-Disposition: inline
In-Reply-To: <8f6807d6161efbed6d585a2ca041d4b126b30451.1614863741.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--9L+8xSSpwTrxyrty
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Each packet should be padded with the additional zero to become 4-bytes
> alignment in sdio tx aggregation.
>=20
> Fixes: 1522ff731f84 ("mt76: mt7663s: introduce sdio tx aggregation")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/driv=
ers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
> index 9fb506f2ace6..2d3b7d1e2c92 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
> @@ -218,6 +218,7 @@ static int mt7663s_tx_run_queue(struct mt76_dev *dev,=
 struct mt76_queue *q)
>  	int qid, err, nframes =3D 0, len =3D 0, pse_sz =3D 0, ple_sz =3D 0;
>  	bool mcu =3D q =3D=3D dev->q_mcu[MT_MCUQ_WM];
>  	struct mt76_sdio *sdio =3D &dev->sdio;
> +	u8 pad;
> =20
>  	qid =3D mcu ? ARRAY_SIZE(sdio->xmit_buf) - 1 : q->qid;
>  	while (q->first !=3D q->head) {
> @@ -234,7 +235,8 @@ static int mt7663s_tx_run_queue(struct mt76_dev *dev,=
 struct mt76_queue *q)
>  			goto next;
>  		}
> =20
> -		if (len + e->skb->len + 4 > MT76S_XMIT_BUF_SZ)
> +		pad =3D roundup(e->skb->len, 4) - e->skb->len;
> +		if (len + e->skb->len + pad + 4 > MT76S_XMIT_BUF_SZ)
>  			break;
> =20
>  		if (mt7663s_tx_pick_quota(sdio, mcu, e->buf_sz, &pse_sz,
> @@ -252,6 +254,9 @@ static int mt7663s_tx_run_queue(struct mt76_dev *dev,=
 struct mt76_queue *q)
>  			len +=3D iter->len;
>  			nframes++;
>  		}
> +
> +		memset(sdio->xmit_buf[qid] + len, 0, pad);
> +		len +=3D pad;

maybe it is better to do something like:

		if (unlikely(pad)) {
			memset(sdio->xmit_buf[qid] + len, 0, pad);
			len +=3D pad;
		}

Regards,
Lorenzo

>  next:
>  		q->first =3D (q->first + 1) % q->ndesc;
>  		e->done =3D true;
> --=20
> 2.25.1

--9L+8xSSpwTrxyrty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYEDi1wAKCRA6cBh0uS2t
rBOnAQCp0+5Oy1w/amImTdQwjIk8T+zQYy2ESYYTieRZJI1rDwEAnt+LOxc5buBv
aUfPeEt8StGvDJn/5WPLlwaswFFplgM=
=7B1A
-----END PGP SIGNATURE-----

--9L+8xSSpwTrxyrty--

