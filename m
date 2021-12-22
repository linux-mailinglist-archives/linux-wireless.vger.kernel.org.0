Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED99547D0B2
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 12:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240249AbhLVLQi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 06:16:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244514AbhLVLQh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 06:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640171795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/vCKBX4ztR/l36gQ5MyV9nvdNnkC/8nxLd8Fi4Qr088=;
        b=gV4NurcBkmvpuXWg60JFktgB3goFwe19x37qXoKBOcHrFGjNfJPZoTEerF5UzY4sccOUAY
        GBSTJ0DLLB/ZfOwDYhWiKfqE8amPhpGIn1RwJ/PTWMz951rRbLmkG2utd2v4rvL83jq3zn
        zNI/sUkpR4GeppoWhfYnILRALuXab2c=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56-LDp3iopOMuej_L7Oqp0sng-1; Wed, 22 Dec 2021 06:16:33 -0500
X-MC-Unique: LDp3iopOMuej_L7Oqp0sng-1
Received: by mail-qk1-f199.google.com with SMTP id h10-20020a05620a284a00b0047649c94bc7so129230qkp.20
        for <linux-wireless@vger.kernel.org>; Wed, 22 Dec 2021 03:16:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/vCKBX4ztR/l36gQ5MyV9nvdNnkC/8nxLd8Fi4Qr088=;
        b=xoeZAFa813U2F6BJuUY/g9Ef+2AIU7PlaMomQszlA5X7FTH5oPNt5flEw/I7IDHVVC
         0oz6WxLizBHsGA//7DJWahTCGwVAQpWAQDnTMXxaLLLC5nAlNuf9O8JYAH7DRAF0I4w4
         9JqDZMudFhoAwH2pkXHbjJEPScwQu0eOHvJCn+9mLuLUYhN1gu/fZgRQofLjYDAAbzrw
         AFtckt8sFz5OKpQWpgCquVdtrTaTCYb2dJJIERMD0frP4gsAGsw8fJejt5qfSYgch6ar
         fnR55MwQhgilHqE+i9vhYvd5XVhv5AIj5fVepFqYeV74CW2heHF0+cM7qZgzWmF4Zwar
         RLMA==
X-Gm-Message-State: AOAM533L4if9ZCGh7zfOrGMByivwRokWVkXfoH9AXkBL9uO8de3vY48l
        Rv6ovFKTPuIfbz0O+fqfYTgvt/TW9BABtzx7v8biBeeT1ACoOe2e2JTbT9fjmAyzzN+iaE6ObKF
        ZfS6SBnlKN7OYF8ehVJS0nTGrHTo=
X-Received: by 2002:a05:622a:19a3:: with SMTP id u35mr1078604qtc.303.1640171793177;
        Wed, 22 Dec 2021 03:16:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw9nbq7aKZd3kohuuTe+I5dL9pVTLs8N1Hma9aa1hhv0rCqLy6tawJcGG7mJz2Q1h/poCUepQ==
X-Received: by 2002:a05:622a:19a3:: with SMTP id u35mr1078570qtc.303.1640171792935;
        Wed, 22 Dec 2021 03:16:32 -0800 (PST)
Received: from localhost (net-93-146-37-237.cust.vodafonedsl.it. [93.146.37.237])
        by smtp.gmail.com with ESMTPSA id u16sm1462731qke.127.2021.12.22.03.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 03:16:32 -0800 (PST)
Date:   Wed, 22 Dec 2021 12:16:29 +0100
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
Subject: Re: [PATCH] mt76: sdio: lock sdio when it is needed
Message-ID: <YcMJDdDrDVIT0Y55@lore-desk>
References: <7aaf68bc8073c4f1cef063d1e0989e5402ac358c.1640151426.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QoOniBAhkIvv76Ai"
Content-Disposition: inline
In-Reply-To: <7aaf68bc8073c4f1cef063d1e0989e5402ac358c.1640151426.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--QoOniBAhkIvv76Ai
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Acquire the SDIO as needed as possible because either MT7663S or MT7921S
> is a multiple-function device that always includes Bluetooth that would
> share with the same SDIO bus. So not to avoid breaking Bluetooth pairing,
> audio, and HID such kind of time critical application on that, we only
> lock sdio bus when it is necessary in WiFi driver.
>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7615/sdio.c | 3 +++
>  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c | 3 +++
>  drivers/net/wireless/mediatek/mt76/sdio_txrx.c   | 8 ++++++++
>  3 files changed, 14 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/n=
et/wireless/mediatek/mt76/mt7615/sdio.c
> index 31c4a76b7f91..71162befdae8 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
> @@ -56,7 +56,10 @@ static int mt7663s_parse_intr(struct mt76_dev *dev, st=
ruct mt76s_intr *intr)
>  	struct mt7663s_intr *irq_data =3D sdio->intr_data;
>  	int i, err;
> =20
> +	sdio_claim_host(sdio->func);
>  	err =3D sdio_readsb(sdio->func, irq_data, MCR_WHISR, sizeof(*irq_data));
> +	sdio_release_host(sdio->func);

I guess you can move this in mt76s_rx_handler() and remove the duplicated c=
ode
in mt7921_sdio.c

Regards,
Lorenzo

> +
>  	if (err)
>  		return err;
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/sdio.c
> index 65d693902c22..743b63f66efa 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> @@ -58,7 +58,10 @@ static int mt7921s_parse_intr(struct mt76_dev *dev, st=
ruct mt76s_intr *intr)
>  	struct mt7921_sdio_intr *irq_data =3D sdio->intr_data;
>  	int i, err;
> =20
> +	sdio_claim_host(sdio->func);
>  	err =3D sdio_readsb(sdio->func, irq_data, MCR_WHISR, sizeof(*irq_data));
> +	sdio_release_host(sdio->func);
> +
>  	if (err < 0)
>  		return err;
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net=
/wireless/mediatek/mt76/sdio_txrx.c
> index 801590a0a334..f2b46975d831 100644
> --- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> +++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
> @@ -102,7 +102,10 @@ mt76s_rx_run_queue(struct mt76_dev *dev, enum mt76_r=
xq_id qid,
> =20
>  	buf =3D page_address(page);
> =20
> +	sdio_claim_host(sdio->func);
>  	err =3D sdio_readsb(sdio->func, buf, MCR_WRDR(qid), len);
> +	sdio_release_host(sdio->func);
> +
>  	if (err < 0) {
>  		dev_err(dev->dev, "sdio read data failed:%d\n", err);
>  		put_page(page);
> @@ -214,7 +217,10 @@ static int __mt76s_xmit_queue(struct mt76_dev *dev, =
u8 *data, int len)
>  	if (len > sdio->func->cur_blksize)
>  		len =3D roundup(len, sdio->func->cur_blksize);
> =20
> +	sdio_claim_host(sdio->func);
>  	err =3D sdio_writesb(sdio->func, MCR_WTDR1, data, len);
> +	sdio_release_host(sdio->func);
> +
>  	if (err)
>  		dev_err(dev->dev, "sdio write failed: %d\n", err);
> =20
> @@ -298,6 +304,7 @@ void mt76s_txrx_worker(struct mt76_sdio *sdio)
>  	/* disable interrupt */
>  	sdio_claim_host(sdio->func);
>  	sdio_writel(sdio->func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, NULL);
> +	sdio_release_host(sdio->func);
> =20
>  	do {
>  		nframes =3D 0;
> @@ -327,6 +334,7 @@ void mt76s_txrx_worker(struct mt76_sdio *sdio)
>  	} while (nframes > 0);
> =20
>  	/* enable interrupt */
> +	sdio_claim_host(sdio->func);
>  	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
>  	sdio_release_host(sdio->func);
>  }
> --=20
> 2.25.1
>=20

--QoOniBAhkIvv76Ai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYcMJDQAKCRA6cBh0uS2t
rNBHAP90xJ+Mada+OCDe3sgAR7bOZEJiGQbcCDVAyv0qDwuBdwD7B2xzkTpTv7Tk
p/MUb4rB7hR+2QQQfaJbmPXIH3Jd6QQ=
=J2gf
-----END PGP SIGNATURE-----

--QoOniBAhkIvv76Ai--

