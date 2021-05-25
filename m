Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0A6638FD58
	for <lists+linux-wireless@lfdr.de>; Tue, 25 May 2021 11:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhEYJEl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 May 2021 05:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37333 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230511AbhEYJEl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 May 2021 05:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621933391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a2kNHkfYuDvhtz55vby6f2oRc2ENLoFARbVzBwJeBQ4=;
        b=Vo4fhVJ/r00yiRK+NoNX+9mWBJPXucxrGP4wmTPO5tvaOrs7Vb56+7JIURMowTXKMEnTiy
        p3gvSYmH5Tr7LfOkhQBQ1gQ0imDduiGFyH1o/7N05c3CZmdS4piiaJD5PLL0IZi8C2CG+l
        JVMT1iz5C+41B1ZQ9CbAXtheC9sIBwM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-XL5jQQziM2qP1nPLB8JeiQ-1; Tue, 25 May 2021 05:03:08 -0400
X-MC-Unique: XL5jQQziM2qP1nPLB8JeiQ-1
Received: by mail-ed1-f72.google.com with SMTP id n6-20020a0564020606b029038cdc241890so16957536edv.20
        for <linux-wireless@vger.kernel.org>; Tue, 25 May 2021 02:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a2kNHkfYuDvhtz55vby6f2oRc2ENLoFARbVzBwJeBQ4=;
        b=eKBwiTZhAo1o8Ld8X6G43zB5oua82g2hVqpxrVL3wYROnr8EgFReEnzJdDRYoA6DvT
         MiiKJ22Gg1t/+wTBbch6p7bd9s9qBZpG7I37vsuD20xGkazEc/w4wOzv91B8e3QmkmhA
         lQ226XCI9Wus+5/68plr3ecNW4wpUYDmQocPErvTIYLU5RGWXvutk6E8TqiPkpIfQulg
         037TcsE0S3OFDh7Tg4u4zwkDaNTgg0cBGNqq1uQEX8qGMT4Lxml3jYc+Y8pa+kCOTO2U
         bqMZJ/Mdlp1MU866No6SHeHIexel9SBYvNGrbBaBZ3ZmS2rqG+qD5Bx/WSrNGiWmUl1a
         XNsg==
X-Gm-Message-State: AOAM532tqH1JOOvj4B/P16j+RZ5kcmhFaCFIYr7ub91BO3hZAbdErTJS
        lc2tl099JHBmk7GD/9weyKgdpHTlxmm9mvOYBUJqFQj7SiPszfXpxDTEURGNDbYZhzPnfNm4Tiy
        EqcKyQxxtCdKLQRUlymixAPHNmA0=
X-Received: by 2002:a50:9f6b:: with SMTP id b98mr31056016edf.318.1621933387641;
        Tue, 25 May 2021 02:03:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnRK2ZPRObjKxHo/vtL2A69CdhsgrDNtXNBQ3caZ72RPzMWV5eb250CZXjcRnmC4neCqoC+g==
X-Received: by 2002:a50:9f6b:: with SMTP id b98mr31056000edf.318.1621933387507;
        Tue, 25 May 2021 02:03:07 -0700 (PDT)
Received: from localhost (net-93-66-91-66.cust.vodafonedsl.it. [93.66.91.66])
        by smtp.gmail.com with ESMTPSA id q26sm8790541ejc.3.2021.05.25.02.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 02:03:06 -0700 (PDT)
Date:   Tue, 25 May 2021 11:03:03 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] mt76: mt7615: add .offset_tsf callback
Message-ID: <YKy9R82co40IqVSw@lore-desk>
References: <324aa6af6a191a1f929fd3054148b001acd0bd13.1621931743.git.ryder.lee@mediatek.com>
 <02303700150757de92fec3525fe51c04d1aca416.1621931743.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wDAorh6uHV8+h+wZ"
Content-Disposition: inline
In-Reply-To: <02303700150757de92fec3525fe51c04d1aca416.1621931743.git.ryder.lee@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--wDAorh6uHV8+h+wZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> It's much more accurate than .get_tsf + .set_tsf, and switch to use
> mt76_rmw to operate tsf registers.
>=20
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7615/mac.c   |  2 +-
>  .../net/wireless/mediatek/mt76/mt7615/main.c  | 32 +++++++++++++++++--
>  .../net/wireless/mediatek/mt76/mt7615/regs.h  |  2 ++
>  .../wireless/mediatek/mt76/mt7615/usb_sdio.c  |  2 +-
>  4 files changed, 34 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mac.c
> index 71af122a0b38..2ac7d0b0eff4 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> @@ -1125,7 +1125,7 @@ void mt7615_mac_set_rates(struct mt7615_phy *phy, s=
truct mt7615_sta *sta,
>  	idx =3D idx > HW_BSSID_MAX ? HW_BSSID_0 : idx;
>  	addr =3D idx > 1 ? MT_LPON_TCR2(idx): MT_LPON_TCR0(idx);
> =20
> -	mt76_set(dev, addr, MT_LPON_TCR_MODE); /* TSF read */
> +	mt76_rmw(dev, addr, MT_LPON_TCR_MODE, MT_LPON_TCR_READ); /* TSF read */
>  	sta->rate_set_tsf =3D mt76_rr(dev, MT_LPON_UTTR0) & ~BIT(0);
>  	sta->rate_set_tsf |=3D rd.rateset;
> =20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7615/main.c
> index e36c52290985..3bd755634d5b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
> @@ -891,7 +891,8 @@ mt7615_get_tsf(struct ieee80211_hw *hw, struct ieee80=
211_vif *vif)
> =20
>  	mt7615_mutex_acquire(dev);
> =20
> -	mt76_set(dev, reg, MT_LPON_TCR_MODE); /* TSF read */
> +	/* TSF read */
> +	mt76_rmw(dev, reg, MT_LPON_TCR_MODE, MT_LPON_TCR_READ);
>  	tsf.t32[0] =3D mt76_rr(dev, MT_LPON_UTTR0);
>  	tsf.t32[1] =3D mt76_rr(dev, MT_LPON_UTTR1);
> =20
> @@ -921,11 +922,37 @@ mt7615_set_tsf(struct ieee80211_hw *hw, struct ieee=
80211_vif *vif,
>  	mt76_wr(dev, MT_LPON_UTTR0, tsf.t32[0]);
>  	mt76_wr(dev, MT_LPON_UTTR1, tsf.t32[1]);
>  	/* TSF software overwrite */
> -	mt76_set(dev, reg, MT_LPON_TCR_WRITE);
> +	mt76_rmw(dev, reg, MT_LPON_TCR_MODE, MT_LPON_TCR_WRITE);
> =20
>  	mt7615_mutex_release(dev);
>  }
> =20
> +static void
> +mt7615_offset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
> +		  s64 timestamp)
> +{
> +	struct mt7615_vif *mvif =3D (struct mt7615_vif *)vif->drv_priv;
> +	struct mt7615_dev *dev =3D mt7615_hw_dev(hw);
> +	union {
> +		u64 t64;
> +		u32 t32[2];
> +	} tsf =3D { .t64 =3D timestamp, };

same here

> +	u16 idx =3D mvif->mt76.omac_idx;
> +	u32 reg;
> +
> +	idx =3D idx > HW_BSSID_MAX ? HW_BSSID_0 : idx;
> +	reg =3D idx > 1 ? MT_LPON_TCR2(idx): MT_LPON_TCR0(idx);
> +
> +	mutex_lock(&dev->mt76.mutex);

mt7615_mutex_acquire(dev);=20

> +
> +	mt76_wr(dev, MT_LPON_UTTR0, tsf.t32[0]);
> +	mt76_wr(dev, MT_LPON_UTTR1, tsf.t32[1]);
> +	/* TSF software adjust*/
> +	mt76_rmw(dev, reg, MT_LPON_TCR_MODE, MT_LPON_TCR_ADJUST);
> +
> +	mutex_unlock(&dev->mt76.mutex);

mt7615_mutex_release(dev);

Regards,
Lorenzo
> +}
> +
>  static void
>  mt7615_set_coverage_class(struct ieee80211_hw *hw, s16 coverage_class)
>  {
> @@ -1308,6 +1335,7 @@ const struct ieee80211_ops mt7615_ops =3D {
>  	.get_stats =3D mt7615_get_stats,
>  	.get_tsf =3D mt7615_get_tsf,
>  	.set_tsf =3D mt7615_set_tsf,
> +	.offset_tsf =3D mt7615_offset_tsf,
>  	.get_survey =3D mt76_get_survey,
>  	.get_antenna =3D mt76_get_antenna,
>  	.set_antenna =3D mt7615_set_antenna,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/n=
et/wireless/mediatek/mt76/mt7615/regs.h
> index 63c081bb04d0..6712ad9faeaa 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
> @@ -463,7 +463,9 @@ enum mt7615_reg_base {
>  #define MT_LPON_TCR0(_n)		MT_LPON(0x010 + ((_n) * 4))
>  #define MT_LPON_TCR2(_n)		MT_LPON(0x0f8 + ((_n) - 2) * 4)
>  #define MT_LPON_TCR_MODE		GENMASK(1, 0)
> +#define MT_LPON_TCR_READ		GENMASK(1, 0)
>  #define MT_LPON_TCR_WRITE		BIT(0)
> +#define MT_LPON_TCR_ADJUST		BIT(1)
> =20
>  #define MT_LPON_UTTR0			MT_LPON(0x018)
>  #define MT_LPON_UTTR1			MT_LPON(0x01c)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drive=
rs/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
> index 75a05f8dd7e7..996d48cca18a 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
> @@ -123,7 +123,7 @@ static int mt7663_usb_sdio_set_rates(struct mt7615_de=
v *dev,
>  	idx =3D idx > HW_BSSID_MAX ? HW_BSSID_0 : idx;
>  	addr =3D idx > 1 ? MT_LPON_TCR2(idx): MT_LPON_TCR0(idx);
> =20
> -	mt76_set(dev, addr, MT_LPON_TCR_MODE); /* TSF read */
> +	mt76_rmw(dev, addr, MT_LPON_TCR_MODE, MT_LPON_TCR_READ); /* TSF read */
>  	val =3D mt76_rr(dev, MT_LPON_UTTR0);
>  	sta->rate_set_tsf =3D (val & ~BIT(0)) | rate->rateset;
> =20
> --=20
> 2.18.0
>=20

--wDAorh6uHV8+h+wZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYKy9QwAKCRA6cBh0uS2t
rN8IAQCQ4liOss2SnQgl2OWEh8uhfFUuIF6Fr4p2lF+rUv3U8gD/Q6V9q7MqyQ4U
uOjMWqhIHyqMEdDV4eFK0f9a3gXXQw4=
=YaBR
-----END PGP SIGNATURE-----

--wDAorh6uHV8+h+wZ--

