Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2613DEE41F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2019 16:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfKDPpp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Nov 2019 10:45:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48106 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbfKDPpo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Nov 2019 10:45:44 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6410785363
        for <linux-wireless@vger.kernel.org>; Mon,  4 Nov 2019 15:45:44 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id w4so2144641wro.10
        for <linux-wireless@vger.kernel.org>; Mon, 04 Nov 2019 07:45:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HjVN0GWcfbh2vitrv3uWENtlKz3PGxY7PqqXYAEPvlI=;
        b=S8PuPakbMLTk7owwdWMSs4efK9rdQ7pzN91viU0xNGIeen00sE7Hq8+aCShi3zh9E2
         rEUoTHwnaaNKKxrkm7DyELgTAgf+dtP3P5n4NW+VelkNW06QxyAklVDeSGmQI9Z9y5hQ
         BAaqVMxmylrQgXqfcHWIJOgMWbcR5jDy5p6XvWrY5G/B3Rqnozg+3mxpc3CeNZwc3ui9
         QfKjqMfA+0L48VrDIXX3Xk3VZrvD2M7b0TDKvb22yFL6SDqOdHwW0a4JuaMhLPdgIMug
         +J3TmxZcN4QGySI6fHPFzFmoB4rL50RSV+K2zZ72hA3BQ5lSvY3g/xDbLGsahvaIj32f
         oLEg==
X-Gm-Message-State: APjAAAUECKswIAhM9dHq4yjtEI/BNZWQCBHkpIphkfRHK02Sl8zDPpWw
        8kOUcZyKxg2yVX2+oTSgMzvqCmtS2YdVRZq8qBA+l71jYexh5twli5PFaRwsbqOP+uiWqZCTjPh
        ChhqPO9959ONijoSP0hlHCSd8FYY=
X-Received: by 2002:a1c:f302:: with SMTP id q2mr24118070wmq.142.1572882343151;
        Mon, 04 Nov 2019 07:45:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqyS4tHQTuGtlTCFV9Y7t97TPsvPlcjS4q7cw2TbyUgdfOSmogLxKeA4PY3yuD8W28LR9AiCkQ==
X-Received: by 2002:a1c:f302:: with SMTP id q2mr24118046wmq.142.1572882342891;
        Mon, 04 Nov 2019 07:45:42 -0800 (PST)
Received: from localhost.localdomain ([176.229.194.15])
        by smtp.gmail.com with ESMTPSA id x9sm13318914wru.32.2019.11.04.07.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 07:45:41 -0800 (PST)
Date:   Mon, 4 Nov 2019 17:45:37 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, sgruszka@redhat.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: mt76x02: fix num slots in beacon config init
Message-ID: <20191104154537.GE3935@localhost.localdomain>
References: <20191104150341.13896-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
Content-Disposition: inline
In-Reply-To: <20191104150341.13896-1-markus.theil@tu-ilmenau.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> mt76x02 mmio and usb devices use a different number of beacon slots (8
> vs. 5). Consider this in mt76x02_init_beacon_config.
>=20
> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/driver=
s/net/wireless/mediatek/mt76/mt76x02_beacon.c
> index 4209209ac940..b7412953ff26 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> @@ -249,7 +249,7 @@ void mt76x02_init_beacon_config(struct mt76x02_dev *d=
ev)
>  	mt76_set(dev, MT_BEACON_TIME_CFG, MT_BEACON_TIME_CFG_SYNC_MODE);
>  	mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xffff);
> =20
> -	for (i =3D 0; i < 8; i++)
> +	for (i =3D 0; i < dev->beacon_ops->nslots; i++)
>  		mt76x02_mac_set_beacon(dev, i, NULL);
> =20
>  	mt76x02_set_beacon_offsets(dev);

Hi Markus,

mt76x02_init_beacon_config is run just at bootstrap and it is used to clean=
 all
beacon RAM memory. It can't see any issue with the current code.

Regards,
Lorenzo

> --=20
> 2.17.1
>=20

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXcBHngAKCRA6cBh0uS2t
rDTMAP0VZpY3/cVC1ziPlnBKymKfJGRfvV2J7SIX4eQn15O8LAEAwI+v8OvjQpg0
CsUvB4hbfN2yPAWlPb7GwuuPdZSC5Ac=
=fWp+
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--
