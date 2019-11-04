Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C27DBEE484
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2019 17:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbfKDQRT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Nov 2019 11:17:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbfKDQRT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Nov 2019 11:17:19 -0500
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B3DEB90C99
        for <linux-wireless@vger.kernel.org>; Mon,  4 Nov 2019 16:17:18 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id u2so4527132wrm.7
        for <linux-wireless@vger.kernel.org>; Mon, 04 Nov 2019 08:17:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IyQ+4JUWbfmaAcHb0YjJWmh9HnZSg4yUhaVLsd07I5Y=;
        b=B2BUzuUTkBZMR+yHgrRC7tgd5rf04rpvGv/JBJ7KpZmPWsipQtWNe8BaOCCEYENkZd
         69tMy/kC+bWGd1J4LfzCwqKS+Z0x1eHxaJGkBaiUTrLadaxhJxo1wqXBLtGdkcLDzL/Z
         wE46lg1i7Mjlg9CO69ooZypJvcBlxdFF3lk50I6FUDJMjv+rMWG2U/yT4VHdq7m5PF59
         TTVPcz/db7nYJZwvM/FE35YGK76rkvRRo1HAzukc+sR2NbEjtv9syFnwof7Xv+XHPeBH
         b/XMU5YVQFTP/F8QrnYwjzZvxRFOgJfRrwbh2hsiUTJ5Q/aSI/ViakJWWaBMWyiTQF+k
         6Ymw==
X-Gm-Message-State: APjAAAVGyol3GgaqQRObAuKRzwlpFy5B3wkl/L26/tAcvRbvsiBQ2BNK
        IuE4JKb0fy+fI5ZOHTbdiqF3UbDOXW6p4fEvXjv02socbVQt6FUQO4zIq6cyBJ2ZJe7pZu9JElv
        teGlZ0qruBKeHV4OdwR5sap9VIm4=
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr16785231wmi.124.1572884237464;
        Mon, 04 Nov 2019 08:17:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqzBGOQBNV5uSVHURPywZwmTQSqroeLL62NUNQfhAqyXYJG8K3K27+A+2f4ubs17/YdQTP5khQ==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr16785212wmi.124.1572884237230;
        Mon, 04 Nov 2019 08:17:17 -0800 (PST)
Received: from localhost.localdomain ([176.229.194.15])
        by smtp.gmail.com with ESMTPSA id m3sm13192203wrw.20.2019.11.04.08.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 08:17:16 -0800 (PST)
Date:   Mon, 4 Nov 2019 18:17:12 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     nbd@nbd.name, sgruszka@redhat.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] mt76: mt76x02: fix num slots in beacon config init
Message-ID: <20191104161712.GF3935@localhost.localdomain>
References: <20191104150341.13896-1-markus.theil@tu-ilmenau.de>
 <20191104154537.GE3935@localhost.localdomain>
 <a6238611-45d6-ffbc-1db2-2b3203c987f8@tu-ilmenau.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WlEyl6ow+jlIgNUh"
Content-Disposition: inline
In-Reply-To: <a6238611-45d6-ffbc-1db2-2b3203c987f8@tu-ilmenau.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--WlEyl6ow+jlIgNUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Nov 04, Markus Theil wrote:
> On 04.11.19 16:45, Lorenzo Bianconi wrote:
> >> mt76x02 mmio and usb devices use a different number of beacon slots (8
> >> vs. 5). Consider this in mt76x02_init_beacon_config.
> >>
> >> Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
> >> ---
> >>  drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/dri=
vers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> >> index 4209209ac940..b7412953ff26 100644
> >> --- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> >> +++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
> >> @@ -249,7 +249,7 @@ void mt76x02_init_beacon_config(struct mt76x02_dev=
 *dev)
> >>  	mt76_set(dev, MT_BEACON_TIME_CFG, MT_BEACON_TIME_CFG_SYNC_MODE);
> >>  	mt76_wr(dev, MT_BCN_BYPASS_MASK, 0xffff);
> >> =20
> >> -	for (i =3D 0; i < 8; i++)
> >> +	for (i =3D 0; i < dev->beacon_ops->nslots; i++)
> >>  		mt76x02_mac_set_beacon(dev, i, NULL);
> >> =20
> >>  	mt76x02_set_beacon_offsets(dev);
> > Hi Markus,
> >
> > mt76x02_init_beacon_config is run just at bootstrap and it is used to c=
lean all
> > beacon RAM memory. It can't see any issue with the current code.
> >
> > Regards,
> > Lorenzo
> >
> >> --=20
> >> 2.17.1
> >>
> Hi Lorenzo,
>=20
> I just thought this function should overwrite all 8192 byte beacon RAM
> memory. If the loop count is set to 8 it would overwrite 8 x 1024 =3D 8192
> byte in the mmio case and 8 x 1638 =3D 13104 byte in the USB case. 1638 is
> 8192 / N_BCN_SLOTS. N_BCN_SLOTS is currently 5 for USB. mt76x02_beacon.c
> has no further checks for beacon_ops->nslots in the case of setting a
> beacon.

ops..I did not notice beacon_len in __mt76x02_mac_set_beacon

Lorenzo

>=20
> Markus
>=20
>=20

--WlEyl6ow+jlIgNUh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXcBPBgAKCRA6cBh0uS2t
rFWzAQDrh+JC/h/hyOeszGLapiPlTJPeQMdKcr7GmBU1N4QdRgD+JvpXiXAqGK7F
gl/To3Hol642UOR/HJ7lUXBOqp4CLws=
=9/bX
-----END PGP SIGNATURE-----

--WlEyl6ow+jlIgNUh--
