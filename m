Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA32440C675
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 15:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234337AbhIONdB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 09:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233429AbhIONdB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 09:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631712701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/azogsROZACSNc4T7vf4fDs5jXSzRpucSpuRzV2HagU=;
        b=bTtSX6xogTo3Tahnk2QESCsY9afvzHh9BuZWuL3RAYAacn6Bw6AO228yE9HKXw4Dvr/gd6
        Wjnj09r+yNDYJPQj4PFnSTz1jkZJkF2uHn9Q8iqs/dYZsik+Plwv46fa5cfdviA2LXjRLd
        epyR4WGgGIlG9ETrLMmLuRZnP8ZLNm4=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-5co-eSNhOP69XRApHL68vw-1; Wed, 15 Sep 2021 09:31:39 -0400
X-MC-Unique: 5co-eSNhOP69XRApHL68vw-1
Received: by mail-ed1-f71.google.com with SMTP id x14-20020a50ba8e000000b003d5a565de3aso683742ede.18
        for <linux-wireless@vger.kernel.org>; Wed, 15 Sep 2021 06:31:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/azogsROZACSNc4T7vf4fDs5jXSzRpucSpuRzV2HagU=;
        b=Ju8o38Juy3kEn/IJwjHXiTOggQvwXlQIsdLQhlnZs8EY2Fy6e4UHADJHxOh6/7zt4w
         Yc5D4cMbcfOgfYcopF49iBy9B0SBSLedmlWTF2xO1g9sK163T7wi5sq3vmCbE7vnJGSo
         s69ZsWJ7kWOERk3/+/uOdBBM9gpnX6nbOAYE9vJvhZy0moGoD+IyuGEoE1rnYQ0EHtQ+
         LMHFoXv0208nTQ4fPjR3zymdAhzRqPVRf8rsMoYWeLoAClIS8hxA+2iqmgkxKiJIiPX/
         a2i5yn0uYiCdxJRGsE7FH9x/7X7Jo/8eCDBgCBTzs089kX5i96jk4GZalgt1O41u+w+8
         h2EQ==
X-Gm-Message-State: AOAM531X+/d3tP8oM8w+Oxz8OlBZZLZ6Q/1A34PY348eqlhedMllrCYV
        k7QxLXs1Uu/TtFWxF8ZTwe19VKr9mPBRJmM2Fr6sGqV/vzsTqPYe55xnvxtb90dETV1BkejtJy0
        czEZzxMy3E4ZIq53jECCNmslhshQ=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr24842808eje.341.1631712698240;
        Wed, 15 Sep 2021 06:31:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsEjBkbEWkA2+9StiChwyA1m/NVzj/aZQdIcFpRw/sIkzpDGntf371lM7p3BYYBx2RdOrhkA==
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr24842784eje.341.1631712698070;
        Wed, 15 Sep 2021 06:31:38 -0700 (PDT)
Received: from localhost (net-130-25-199-50.cust.vodafonedsl.it. [130.25.199.50])
        by smtp.gmail.com with ESMTPSA id n11sm1087754edr.51.2021.09.15.06.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 06:31:37 -0700 (PDT)
Date:   Wed, 15 Sep 2021 15:31:34 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        steve.lee@mediatek.com, jemele@google.com, shawnku@google.com,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 09/16] mt76: mt7921: make all event parser resuable
 between mt7921s and mt7921e
Message-ID: <YUH1tvJA0EUQzLaA@lore-desk>
References: <cover.1631667941.git.objelf@gmail.com>
 <764759a9a2befe09000863f04676287665675555.1631667941.git.objelf@gmail.com>
 <YUHz/gbfzmFszods@lore-desk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pTOOomLTkB8wTJhp"
Content-Disposition: inline
In-Reply-To: <YUHz/gbfzmFszods@lore-desk>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--pTOOomLTkB8wTJhp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > From: Sean Wang <sean.wang@mediatek.com>
> >=20
> > The longer event such as the event for mcu_get_nic_capability would hold
> > the data in paged fragment skb for the SDIO device so we turn the skb to
> > be linearized skb before accessing it to reuse the same event parser
> > betweem mt7921s and mt7921e.
> >=20
> > Tested-by: Deren Wu <deren.wu@mediatek.com>
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/=
net/wireless/mediatek/mt76/mt7921/mcu.c
> > index f5a8f7fa4244..8e49df20a8cb 100644
> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
> > @@ -458,7 +458,14 @@ mt7921_mcu_rx_unsolicited_event(struct mt7921_dev =
*dev, struct sk_buff *skb)
> > =20
> >  void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb)
> >  {
> > -	struct mt7921_mcu_rxd *rxd =3D (struct mt7921_mcu_rxd *)skb->data;
> > +	struct mt7921_mcu_rxd *rxd;
> > +	int ret;
> > +
> > +	ret =3D skb_linearize(skb);
>=20
> is it true for sdio only? if so what about doing something like:
>=20
> if (mt76_is_sdio() && skb_linearize(skb))
> 	return;

please ignore this comment, it is already in skb_linearize()

>=20
> > +	if (ret)
> > +		return;
> > +
> > +	rxd =3D (struct mt7921_mcu_rxd *)skb->data;
> > =20
> >  	if (rxd->eid =3D=3D 0x6) {
> >  		mt76_mcu_rx_event(&dev->mt76, skb);
> > --=20
> > 2.25.1
> >=20



--pTOOomLTkB8wTJhp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYUH1tAAKCRA6cBh0uS2t
rMkyAQDUa3R2Xm/43qa/WcpdImu0zoJb2NOBQIPNJicSkJYLFQEAx99u7hzZHeFi
rHHCgQlXtyx6c+rtwKLoXbvCzLAlYgg=
=BEBo
-----END PGP SIGNATURE-----

--pTOOomLTkB8wTJhp--

