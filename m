Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB2CC102410
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2019 13:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfKSMQG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Nov 2019 07:16:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55519 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727584AbfKSMQF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Nov 2019 07:16:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574165765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Gj53kqjgev8BshVuL8J75J52vbRfjviOqli+qa97sU=;
        b=J2F7kxY7J7X8f01585CXDEJUI/gS6aTrkj3osEWSEywo6AFPk3O+DvBhUtwqfUUVwm9HQE
        nWgrYA3pDqLSQnp2FX2dcTKKCrNPa+XSZ6IkUGZKUR+64Y+h5v0MPRWk/pKpFIvhsvZc4O
        N+Z0gFYH2FJPS+9EeJeTf5e6pOUbAkU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-JTl4K5k3NxyQMcnEHk40VQ-1; Tue, 19 Nov 2019 07:16:01 -0500
X-MC-Unique: JTl4K5k3NxyQMcnEHk40VQ-1
Received: by mail-wr1-f70.google.com with SMTP id q12so18222053wrr.3
        for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2019 04:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DJzqQbNYSiy/ma/rbwgC0jbDQY5TM7vhJ+eymGotkS8=;
        b=IRJuwJj/DdpAsachGL2q9P8Pdq1uwVAzvJKfFzKjRv22LLNaijGNZfBN6fkqTTZvyK
         ArVrit3b5CKdVjbg9kmf354gSWAwOtwWdJq8kaZK/uwdueI87LhEvExp7xvz7mq4Bn4V
         1nNmlPyQzULfclIhwuLL94CvPlvmHJ454DTY9yD/1kHkY09GOcbY1aUDQFmY3Pq+i4C5
         GFpndl02/HtDuZ8V42P86FbHeA8HgsGXeuyKo20P0Pv7z1W81dI1l16xXps3/iREk7P1
         E3XTBfeDpmK/kD+spGmrhWXGGlQ/l4hPB8H1l4zAYYLSX/QFl9EDvwMR82ziNgWjFioN
         p7+A==
X-Gm-Message-State: APjAAAU2oNFe8W0EvNVDfC6nS7+25iO8wbpg3HOhDnhTae53HI2G0Epb
        DZmWCMR8Q+/fqJil6zP1AcKv4VAQYhOZR7I5SRMsno1G4jrxZnMaBvcWG0l7dw8atu/G4BtEUxF
        ZOkjiFP+Qkdx+pSN38fOzu42qv7Q=
X-Received: by 2002:a05:600c:23ce:: with SMTP id p14mr5229975wmb.176.1574165760659;
        Tue, 19 Nov 2019 04:16:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqy5eTZTGUaEsydiW55kC2ZUjesi2KcdTVc7fFQ+Sd182C4VocOcgoTcTSLolAOrE2jG5XoruA==
X-Received: by 2002:a05:600c:23ce:: with SMTP id p14mr5229946wmb.176.1574165760371;
        Tue, 19 Nov 2019 04:16:00 -0800 (PST)
Received: from localhost.localdomain ([77.139.212.74])
        by smtp.gmail.com with ESMTPSA id z8sm26357108wrp.49.2019.11.19.04.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 04:15:59 -0800 (PST)
Date:   Tue, 19 Nov 2019 14:15:56 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        Stanislaw Gruszka <sgruszka@redhat.com>
Subject: Re: [PATCH v4 3/4] mt76: speed up usb bulk copy
Message-ID: <20191119121556.GB3449@localhost.localdomain>
References: <20191118221540.14886-1-markus.theil@tu-ilmenau.de>
 <20191118221540.14886-4-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
In-Reply-To: <20191118221540.14886-4-markus.theil@tu-ilmenau.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Content-Disposition: inline
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Use larger batches for usb copy to speed this operation up. Otherwise it
> would be too slow for copying new beacons or broadcast frames over usb.
> Assure, that always a multiple of 4 Bytes is copied, as outlined in
> 850e8f6fbd "mt76: round up length on mt76_wr_copy" from Felix Fietkau.
>=20
> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76.h |  2 +-
>  drivers/net/wireless/mediatek/mt76/usb.c  | 24 +++++++++++++++++------
>  2 files changed, 19 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wire=
less/mediatek/mt76/mt76.h
> index 8aec7ccf2d79..7a6f5d097a3d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76.h
> @@ -383,7 +383,7 @@ enum mt76u_out_ep {
>  struct mt76_usb {
>  =09struct mutex usb_ctrl_mtx;
>  =09union {
> -=09=09u8 data[32];
> +=09=09u8 data[128];
>  =09=09__le32 reg_val;
>  =09};
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/usb.c b/drivers/net/wirel=
ess/mediatek/mt76/usb.c
> index 20c6fe510e9d..f1f67b0f8265 100644
> --- a/drivers/net/wireless/mediatek/mt76/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/usb.c
> @@ -149,18 +149,30 @@ static void mt76u_copy(struct mt76_dev *dev, u32 of=
fset,
>  =09=09       const void *data, int len)
>  {
>  =09struct mt76_usb *usb =3D &dev->usb;
> -=09const u32 *val =3D data;
> -=09int i, ret;
> +=09const u8 *val =3D data;
> +=09int ret;
> +=09int current_batch_size;
> +=09int i =3D 0;
> +
> +=09/* Assure that always a multiple of 4 bytes are copied,
> +=09 * otherwise beacons can be corrupted.
> +=09 * See: "mt76: round up length on mt76_wr_copy"
> +=09 * Commit 850e8f6fbd5d0003b0
> +=09 */
> +=09len =3D DIV_ROUND_UP(len, 4) * 4;
> =20
>  =09mutex_lock(&usb->usb_ctrl_mtx);
> -=09for (i =3D 0; i < DIV_ROUND_UP(len, 4); i++) {
> -=09=09put_unaligned(val[i], (u32 *)usb->data);
> +=09while (i < len) {
> +=09=09current_batch_size =3D min((int)sizeof(usb->data), len - i);

What about using min_t() here?

> +=09=09memcpy(usb->data, val + i, current_batch_size);
>  =09=09ret =3D __mt76u_vendor_request(dev, MT_VEND_MULTI_WRITE,
>  =09=09=09=09=09     USB_DIR_OUT | USB_TYPE_VENDOR,
> -=09=09=09=09=09     0, offset + i * 4, usb->data,
> -=09=09=09=09=09     sizeof(u32));
> +=09=09=09=09=09     0, offset + i, usb->data,
> +=09=09=09=09=09     current_batch_size);
>  =09=09if (ret < 0)
>  =09=09=09break;
> +
> +=09=09i +=3D current_batch_size;
>  =09}
>  =09mutex_unlock(&usb->usb_ctrl_mtx);
>  }
> --=20
> 2.24.0
>=20

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXdPc+gAKCRA6cBh0uS2t
rOPPAQDFiNaE1LmwMZU+OatXaOQvc1g2xiG3Ai5Yoefg8zpasAD8DnT7FNDFUBO2
OhZjQDx0qsQJvUmacNjWqXE8BmYLmAM=
=yUQi
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--

