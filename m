Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A3038FD52
	for <lists+linux-wireless@lfdr.de>; Tue, 25 May 2021 11:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbhEYJDK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 May 2021 05:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230437AbhEYJDJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 May 2021 05:03:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621933299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7a8uccHKxMO4pJ6R9+M8IQk9eToV/9h1P/Rfg0CpgHo=;
        b=YDlJTXwDkFjY4iaX4n+nmgYE7evWx/voJcb6wGBNqUhIuqpMh91UU2rml/8jSdU5lAAY0a
        obDCNrpBvupoI+g1TlJjE5F3pJXsBNwdFXonbr/+0X/qGOm4aK2rNlLruV6mhkFx1c+pAp
        3AfT3zQ6NlprOHqhjqOoXO/NXx6MNK0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-30t1xbBLOr2JsVLgOsBkdg-1; Tue, 25 May 2021 05:01:37 -0400
X-MC-Unique: 30t1xbBLOr2JsVLgOsBkdg-1
Received: by mail-ed1-f72.google.com with SMTP id w22-20020a05640234d6b029038d04376b6aso16901526edc.21
        for <linux-wireless@vger.kernel.org>; Tue, 25 May 2021 02:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7a8uccHKxMO4pJ6R9+M8IQk9eToV/9h1P/Rfg0CpgHo=;
        b=tr6tgLfVR/X2p986xHKl5b0/wZukFtU3wn/XjeQ5iEESi88uKczzJ/cxW1hcAYCKiM
         z8Msc3f65buBtQgUpleklJBTev7vyFOCkP0VGPAF6oiTX3rF1hnfxJmVztmTZrNrZtoT
         slD8zviz9eAH4oESoIkY2dVEfkjwyRKKVQJMom573vh2RB1bIzMVLmlmf4FiWaEqzIsM
         ALMOgj3MatK5Yz8se381xDB1zIAil8XRr5ZUUuOEtsW7Xuth6OvM0rZi6ZT+pJPcd38b
         B/XT1j17FR+AugspzYYjEUZ7224WIEcWJInSKUWXD6LkrcQ7QD6DwBJboTmWdNOgqmNl
         oZqw==
X-Gm-Message-State: AOAM5315z5Uw7IhBx2oQjf+quperY8iNSvlqlTuT1obP7JFjz+JWBRjN
        +Llo1tc3q9igxJH5aUOl2vNB+LbHmHD8hRmzPDrRoUbtwXQUIptSUdNpyPRsSDpRIp6MnqGK0m7
        7RyDe13+GGVBF2yiXo93kOQ3roKg=
X-Received: by 2002:a17:906:4a46:: with SMTP id a6mr27502835ejv.322.1621933296126;
        Tue, 25 May 2021 02:01:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHVUngetbgXrhhvOXykp8L+UmaszxqzLb2qbERMC34AfxVSMSGdhMWtU6XbhMuJTQtYrM9Ww==
X-Received: by 2002:a17:906:4a46:: with SMTP id a6mr27502818ejv.322.1621933295955;
        Tue, 25 May 2021 02:01:35 -0700 (PDT)
Received: from localhost (net-93-66-91-66.cust.vodafonedsl.it. [93.66.91.66])
        by smtp.gmail.com with ESMTPSA id i2sm10270089edc.96.2021.05.25.02.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 02:01:35 -0700 (PDT)
Date:   Tue, 25 May 2021 11:01:32 +0200
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Ryder Lee <ryder.lee@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] mt76: mt7915: add .offset_tsf callback
Message-ID: <YKy87P+PcRTdNkwN@lore-desk>
References: <324aa6af6a191a1f929fd3054148b001acd0bd13.1621931743.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uVU+kXXvkjpZrYMy"
Content-Disposition: inline
In-Reply-To: <324aa6af6a191a1f929fd3054148b001acd0bd13.1621931743.git.ryder.lee@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--uVU+kXXvkjpZrYMy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> It's much more accurate than .get_tsf + .set_tsf, and switch to use
> mt76_rmw to operate tsf registers.
>=20
> Tested-by: Xing Song <xing.song@mediatek.com>
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7915/main.c  | 33 +++++++++++++++++--
>  .../net/wireless/mediatek/mt76/mt7915/regs.h  |  2 ++
>  2 files changed, 33 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7915/main.c
> index 64f9ebe4424a..2485f65766e7 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
> @@ -816,7 +816,8 @@ mt7915_get_tsf(struct ieee80211_hw *hw, struct ieee80=
211_vif *vif)
> =20
>  	n =3D mvif->omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : mvif->omac_idx;
>  	/* TSF software read */
> -	mt76_set(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_MODE);
> +	mt76_rmw(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_MODE,
> +		 MT_LPON_TCR_SW_READ);
>  	tsf.t32[0] =3D mt76_rr(dev, MT_LPON_UTTR0(band));
>  	tsf.t32[1] =3D mt76_rr(dev, MT_LPON_UTTR1(band));
> =20
> @@ -845,7 +846,34 @@ mt7915_set_tsf(struct ieee80211_hw *hw, struct ieee8=
0211_vif *vif,
>  	mt76_wr(dev, MT_LPON_UTTR0(band), tsf.t32[0]);
>  	mt76_wr(dev, MT_LPON_UTTR1(band), tsf.t32[1]);
>  	/* TSF software overwrite */
> -	mt76_set(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_WRITE);
> +	mt76_rmw(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_MODE,
> +		 MT_LPON_TCR_SW_WRITE);
> +
> +	mutex_unlock(&dev->mt76.mutex);
> +}
> +
> +static void
> +mt7915_offset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
> +		  s64 timestamp)
> +{
> +	struct mt7915_vif *mvif =3D (struct mt7915_vif *)vif->drv_priv;
> +	struct mt7915_dev *dev =3D mt7915_hw_dev(hw);
> +	struct mt7915_phy *phy =3D mt7915_hw_phy(hw);
> +	bool band =3D phy !=3D &dev->phy;
> +	union {
> +		u64 t64;
> +		u32 t32[2];
> +	} tsf =3D { .t64 =3D timestamp, };

nit: new line here after '{' and before '}'

Regards,
Lorenzo

> +	u16 n;
> +
> +	mutex_lock(&dev->mt76.mutex);
> +
> +	n =3D mvif->omac_idx > HW_BSSID_MAX ? HW_BSSID_0 : mvif->omac_idx;
> +	mt76_wr(dev, MT_LPON_UTTR0(band), tsf.t32[0]);
> +	mt76_wr(dev, MT_LPON_UTTR1(band), tsf.t32[1]);
> +	/* TSF software adjust*/
> +	mt76_rmw(dev, MT_LPON_TCR(band, n), MT_LPON_TCR_SW_MODE,
> +		 MT_LPON_TCR_SW_ADJUST);
> =20
>  	mutex_unlock(&dev->mt76.mutex);
>  }
> @@ -1036,6 +1064,7 @@ const struct ieee80211_ops mt7915_ops =3D {
>  	.get_stats =3D mt7915_get_stats,
>  	.get_tsf =3D mt7915_get_tsf,
>  	.set_tsf =3D mt7915_set_tsf,
> +	.offset_tsf =3D mt7915_offset_tsf,
>  	.get_survey =3D mt76_get_survey,
>  	.get_antenna =3D mt76_get_antenna,
>  	.set_antenna =3D mt7915_set_antenna,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/n=
et/wireless/mediatek/mt76/mt7915/regs.h
> index efe0f2904c66..e36b30d84f07 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
> @@ -124,6 +124,8 @@
>  #define MT_LPON_TCR(_band, n)		MT_WF_LPON(_band, 0x0a8 + (n) * 4)
>  #define MT_LPON_TCR_SW_MODE		GENMASK(1, 0)
>  #define MT_LPON_TCR_SW_WRITE		BIT(0)
> +#define MT_LPON_TCR_SW_ADJUST		BIT(1)
> +#define MT_LPON_TCR_SW_READ		GENMASK(1, 0)
> =20
>  /* MIB: band 0(0x24800), band 1(0xa4800) */
>  #define MT_WF_MIB_BASE(_band)		((_band) ? 0xa4800 : 0x24800)
> --=20
> 2.18.0
>=20

--uVU+kXXvkjpZrYMy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYKy85wAKCRA6cBh0uS2t
rMEhAQDboiqJgm8kUrg/P/UTTQCE3imz7XDGPemtpIGhjdUcpwD/bv4UK3RBVx8e
iFphNPar4svpKwivVpq8WFxV38SuIgs=
=cQPB
-----END PGP SIGNATURE-----

--uVU+kXXvkjpZrYMy--

