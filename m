Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABAEC2DD920
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 20:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbgLQTJ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 14:09:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727260AbgLQTJ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 14:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608232080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tQDlFNlNuVGYhVYVH7sseQWqlAqcdzXvx4q32bqmEFA=;
        b=cbkNJFhkq9xTxgsNGmYMd6tiz33OCi7Kv0McJJwh4oIqV5oM5Bxk5vkERqPktl0kfX6QEO
        rD+kEI6D25iLOTp59ZWtPKuThn7R5Rukd4mxdjmqx9un1HhS0RvoV2strxGJGih3OMDFkt
        oh32gsM0m3I806jzRMW0cclOdNO/vTc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-Bp1SE1rgPj-GMqsiCb-0jA-1; Thu, 17 Dec 2020 14:07:58 -0500
X-MC-Unique: Bp1SE1rgPj-GMqsiCb-0jA-1
Received: by mail-ej1-f71.google.com with SMTP id w6so5382446ejo.2
        for <linux-wireless@vger.kernel.org>; Thu, 17 Dec 2020 11:07:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tQDlFNlNuVGYhVYVH7sseQWqlAqcdzXvx4q32bqmEFA=;
        b=XNb0S2s1bpO8JK83W8Fm5B187+UbJL8E9ZJ1KCzikwdisPMoUq6CpKUEAo/fsESWGU
         2UycDaqvyRN22aDReE+j95bFmVjUl1V/whONsrxNFwCAqzumkahE0VxdmkayEpYxYQDu
         tMpHRdxzpMYB9pgHZxg9wbKiB0Ip/d4boeUUvsjNWbRa+5hmjTQvqyOzwpnc8bs5/XbY
         Nu+yp//Wh1WLQ25A5kfbBR9tf65P+FGTDEwTYro/tMeSW2cKy7ivwHthiNq7PYcxRpDj
         /Lj22uC6hezhiNwlpiXFJjFs531THtGrJttcuKoAJppQUKs6zDLqaGmZr7U7U2oltrL5
         1UGA==
X-Gm-Message-State: AOAM532j59uL5XtzHlDKZbGDKkjaz3L1bFr3+a7cbq/HX79mdbRPva18
        CqqsX6dX6vON2DdPU2sJjV/AxFU6L1qxmmkE2BJelYuVMkJBYf/CUHIZmhlLMz/VJmkD3ZYKxL9
        pM1nHDa8BXngYURbvlzWpoXN/Mlg=
X-Received: by 2002:a17:906:e082:: with SMTP id gh2mr463552ejb.406.1608232077273;
        Thu, 17 Dec 2020 11:07:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfrBnTeU15kgy9Yro+q1OVh6axpFKjlo4TAAoli5P+ygFqAW18UYZIr1UtyFupIWse7z4DKw==
X-Received: by 2002:a17:906:e082:: with SMTP id gh2mr463537ejb.406.1608232077096;
        Thu, 17 Dec 2020 11:07:57 -0800 (PST)
Received: from localhost ([151.66.8.153])
        by smtp.gmail.com with ESMTPSA id qh23sm4350625ejb.71.2020.12.17.11.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 11:07:56 -0800 (PST)
Date:   Thu, 17 Dec 2020 20:07:53 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     kvalo@codeaurora.org
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 2/2] mt76: sdio: remove wake logic in
 mt76s_process_tx_queue
Message-ID: <20201217190753.GF16606@lore-desk>
References: <cover.1607164041.git.lorenzo@kernel.org>
 <d2d7d9d437f4dec2ef1df0ed070b9cf299f021ad.1607164041.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L2Brqb15TUChFOBK"
Content-Disposition: inline
In-Reply-To: <d2d7d9d437f4dec2ef1df0ed070b9cf299f021ad.1607164041.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--L2Brqb15TUChFOBK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Similar to mmio/usb code path, remove wake logic in mt76s_process_tx_queue
> routine

Starting from commit '90d494c99a99fa2eb858754345c4a9c851b409a0
("mt76: improve tx queue stop/wake")', the wake queue logic on
the sdio status path is no longer necessary since the hw queues
are no longer stopped on the mt76 tx path.

Regards,
Lorenzo

>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/sdio.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/sdio.c b/drivers/net/wire=
less/mediatek/mt76/sdio.c
> index 62b5b912818f..7cd995118257 100644
> --- a/drivers/net/wireless/mediatek/mt76/sdio.c
> +++ b/drivers/net/wireless/mediatek/mt76/sdio.c
> @@ -157,7 +157,7 @@ static void mt76s_net_worker(struct mt76_worker *w)
> =20
>  static int mt76s_process_tx_queue(struct mt76_dev *dev, struct mt76_queu=
e *q)
>  {
> -	bool wake, mcu =3D q =3D=3D dev->q_mcu[MT_MCUQ_WM];
> +	bool mcu =3D q =3D=3D dev->q_mcu[MT_MCUQ_WM];
>  	struct mt76_queue_entry entry;
>  	int nframes =3D 0;
> =20
> @@ -177,21 +177,12 @@ static int mt76s_process_tx_queue(struct mt76_dev *=
dev, struct mt76_queue *q)
>  		nframes++;
>  	}
> =20
> -	wake =3D q->stopped && q->queued < q->ndesc - 8;
> -	if (wake)
> -		q->stopped =3D false;
> -
>  	if (!q->queued)
>  		wake_up(&dev->tx_wait);
> =20
> -	if (mcu)
> -		goto out;
> -
> -	mt76_txq_schedule(&dev->phy, q->qid);
> +	if (!mcu)
> +		mt76_txq_schedule(&dev->phy, q->qid);
> =20
> -	if (wake)
> -		ieee80211_wake_queue(dev->hw, q->qid);
> -out:
>  	return nframes;
>  }
> =20
> --=20
> 2.28.0
>=20

--L2Brqb15TUChFOBK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCX9ushgAKCRA6cBh0uS2t
rMoXAP0TAvzxxZvTve9cRp+TQ0j5bBWOGEJ3bqQ3cQygOOz95wEAm4uKggyqlWBS
8M4NbG3DCTum1xIKiNVFbUPJQTMNWgs=
=z043
-----END PGP SIGNATURE-----

--L2Brqb15TUChFOBK--

