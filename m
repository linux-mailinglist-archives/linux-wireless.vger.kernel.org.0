Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98CD6394471
	for <lists+linux-wireless@lfdr.de>; Fri, 28 May 2021 16:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbhE1OuJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 May 2021 10:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44349 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235094AbhE1OuG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 May 2021 10:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622213309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=urI3ne+Gv+EETq6Hv3/IN7q6n20HJ1319uzM7p9frP8=;
        b=a796f9Eiv6CnvkAJrz2VXJR/VgRIRbPaDh5OgGE/yEDp13AqwQxtXqeyg4E1IHSDEPMDDP
        aLahIHkoMqDuX5GwulO0QEvp7OCbg3TK8ruD0PVsQOARjhAnN4QKfDujU3eUZqXcyuIQE+
        4IUkOZ62ZiADxKqBtd5fGBOf0z5Ju8M=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-ADoNZKw1OBie8Z6NhPvKHg-1; Fri, 28 May 2021 10:48:25 -0400
X-MC-Unique: ADoNZKw1OBie8Z6NhPvKHg-1
Received: by mail-ed1-f72.google.com with SMTP id dd28-20020a056402313cb029038fc9850034so718603edb.7
        for <linux-wireless@vger.kernel.org>; Fri, 28 May 2021 07:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=urI3ne+Gv+EETq6Hv3/IN7q6n20HJ1319uzM7p9frP8=;
        b=clGc/ariyEQxzvrhI/+M42HfJGUOQNpMFYY1SFDVtV2HMBaL4EOVgEbDy/xHzNq61O
         ahb4JDfBhkTrOZXOgrSy3np2hahe9CHg7ViGk5oGBJ8221Ccx0LIESVgANtbzbZzm0ne
         CVpjsAd43C+fTRfx+Qr6Gkl6wZBY3X5ifzrpSJKrC5IzWV+lujMuR4pbzYoBRDU4Em2O
         iyHskoplSF/z3Vgh7wGywNrEu9QozEJcOXTFvaAflu0AjAzIHThl9zqWB8U0y6+RPT0U
         9j1k02BYdtay9yakf213vQIqSQxlYFLMYuJmEKp4CKxx3C0MlJNGv3N0+vn2+c1ut1dX
         oreA==
X-Gm-Message-State: AOAM531UZgB4A1OXdb3T5mWEKsp35E0SvKoz8/VMgAa8eGP7KEPWGdxr
        mx1wnGwtKf+uUMskyL3vr/P9wFnkJvBE55+4U9d0ne5kmbsGzuGbGMQG22WvyRDpMioyGg/t/8p
        qxdOJeBziSuYYZgHRNwRH8lqQT+E=
X-Received: by 2002:a17:906:2bd0:: with SMTP id n16mr9524855ejg.110.1622213303977;
        Fri, 28 May 2021 07:48:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzXVo7bQV/yaNb7IHUE8CVF/P5MY4+VwBqod1FFPKaFURC3Fl8F+XFuhi+AtQ0yvb8pbIlBKg==
X-Received: by 2002:a17:906:2bd0:: with SMTP id n16mr9524842ejg.110.1622213303829;
        Fri, 28 May 2021 07:48:23 -0700 (PDT)
Received: from localhost (net-2-44-34-39.cust.vodafonedsl.it. [2.44.34.39])
        by smtp.gmail.com with ESMTPSA id i15sm313851ejk.30.2021.05.28.07.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 07:48:23 -0700 (PDT)
Date:   Fri, 28 May 2021 16:48:19 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] mt76: mt7921: set MT76_RESET during mac reset
Message-ID: <YLECsxSLgurAzyIS@lore-desk>
References: <f201e2d43858d022eb149a7cc29c82ea0361d328.1622210344.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ENfnrD664C3bmRIX"
Content-Disposition: inline
In-Reply-To: <f201e2d43858d022eb149a7cc29c82ea0361d328.1622210344.git.lorenzo@kernel.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--ENfnrD664C3bmRIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Set MT76_RESET during mt7921_mac_reset in order to avoid packet
> transmissions. Move tx scheduling at the end of reset routine.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Felix,

please drop this patch, I need to fix an issue.

Regards,
Lorenzo

> ---
> Changes since v1:
> - move tx scheduling at the end of reset routine
> ---
>  .../net/wireless/mediatek/mt76/mt7921/mac.c   | 20 ++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mac.c
> index 4d1050ae9f39..baaca4eb715e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -1255,6 +1255,7 @@ mt7921_mac_reset(struct mt7921_dev *dev)
>  	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
>  	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0x0);
> =20
> +	set_bit(MT76_RESET, &dev->mphy.state);
>  	set_bit(MT76_MCU_RESET, &dev->mphy.state);
>  	wake_up(&dev->mt76.mcu.wait);
>  	skb_queue_purge(&dev->mt76.mcu.res_q);
> @@ -1274,17 +1275,13 @@ mt7921_mac_reset(struct mt7921_dev *dev)
>  	if (err)
>  		return err;
> =20
> +	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
> +
>  	mt76_for_each_q_rx(&dev->mt76, i) {
>  		napi_enable(&dev->mt76.napi[i]);
>  		napi_schedule(&dev->mt76.napi[i]);
>  	}
> =20
> -	napi_enable(&dev->mt76.tx_napi);
> -	napi_schedule(&dev->mt76.tx_napi);
> -	mt76_worker_enable(&dev->mt76.tx_worker);
> -
> -	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
> -
>  	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA,
>  		MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
>  		MT_INT_MCU_CMD);
> @@ -1302,7 +1299,16 @@ mt7921_mac_reset(struct mt7921_dev *dev)
>  	if (err)
>  		return err;
> =20
> -	return __mt7921_start(&dev->phy);
> +	err =3D __mt7921_start(&dev->phy);
> +	if (err)
> +		return err;
> +
> +	clear_bit(MT76_RESET, &dev->mphy.state);
> +	napi_enable(&dev->mt76.tx_napi);
> +	napi_schedule(&dev->mt76.tx_napi);
> +	mt76_worker_enable(&dev->mt76.tx_worker);
> +
> +	return 0;
>  }
> =20
>  /* system error recovery */
> --=20
> 2.31.1
>=20

--ENfnrD664C3bmRIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYLECqwAKCRA6cBh0uS2t
rE1IAQDjl6E3OUxBK/+DyFsLQX7r0S2qqD4VvwYpalnWOzhyogD8CLjlC8yfU9Ev
aDHqIh5cdJ4xwVJzOtJlEJp4n2sTCQo=
=HOWx
-----END PGP SIGNATURE-----

--ENfnrD664C3bmRIX--

