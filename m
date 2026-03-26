Return-Path: <linux-wireless+bounces-33917-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sME9LZPOxGnb3wQAu9opvQ
	(envelope-from <linux-wireless+bounces-33917-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 07:13:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 181BA32FAB2
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 07:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0488300D6AB
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 06:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101073AEF25;
	Thu, 26 Mar 2026 06:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VW7PLw9U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE0E3914FA
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 06:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774505347; cv=none; b=mM+8v46N04S2YJ9KaXB/dYWbHylK6bM0jkRhgBogYJ/LuS3LCl+tW25VtXfSAxYhiVYKGgtkwfeGf2soY/mvlWZ1j1QNVWkKFD3Y3JTp/kyskilYk7jwLxA1dyZ5mi4KmAWB7ryTKp8K1bnLgrHxdGSQr8XKRyUWQhRPjmlZ2lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774505347; c=relaxed/simple;
	bh=YYJzzBUZ5xCz3VewPGgIe4VjqU3krL4cpevmT2J0q6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uk2DUDTWbLGHCU2PiUVIS+gxEVBTWs8PzbySLGkVWfB+n2C1g4LAPJN4zX+hVJSfcqc0YFxyDnw/whCjSnpr5GRbRvC1Hu+DT5b/RRkPUzisyYDGxWXumw76zBXIyTDiBeY0ypxP8dlq9bqhd5SzOYMDosJs4aqvgaz2W71RM18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VW7PLw9U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F77DC2BCB2
	for <linux-wireless@vger.kernel.org>; Thu, 26 Mar 2026 06:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774505347;
	bh=YYJzzBUZ5xCz3VewPGgIe4VjqU3krL4cpevmT2J0q6U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VW7PLw9U98ap5cmm0HGJgn8kBNyx9LWjDm5ZwUMF6xoHYiwy7jysd+EM7DB6/+rFy
	 Wmg9Y8V+VjjBW9gfO4eXuoP703pzTrNFwpa/Ukb+BoVKxodZrGDW7mx/er4SoM0KTy
	 SijiYEUN/tvU26aKd8QOaAwnovAHIfG9JiNFiFC0JKNBclaB96suWXPmgfLA5BlRw/
	 CwKG0e1Ucdq8SdHypvZy0wXYdqjMrhNup1Z74iF2uiGLAiTsyFiN7GyvJAgxyrVqmI
	 ImYtVQLGAvuwEMY7kDE0qNjfGLl24U7danZ1ze6cC00PpIf8aMimiboCkeMxEQdHyP
	 hjlwjPPFtqlbA==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38c551f2497so3902001fa.2
        for <linux-wireless@vger.kernel.org>; Wed, 25 Mar 2026 23:09:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJfNGHYyk0EqkdZCLgVMos+swXYujh9pEFzLavQZN6yLN4aQOPbpLq01A7N0mhHRbuy7JBLT/WgrSVsgw7/g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5vpryjd3RS0gUdqbIGhgDr1GGZAZm1TLkwAcyD4cAFHo/mawU
	6ZSI3uBMUDrdl1TFJ1hc0ZFn2L/80rsoUyf/UV4zkgwj+8QzjFx7WBBVaKaYr54cGs9bvS6HhyC
	Nib9JOW64UYyILQfaJlQrTA5L5w03ZI4=
X-Received: by 2002:a05:651c:1469:b0:38c:6b7:ad47 with SMTP id
 38308e7fff4ca-38c43072d48mr24340281fa.7.1774505345770; Wed, 25 Mar 2026
 23:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325-mt7927-wifi-support-v2-v3-0-5ca66c97a755@jetm.me> <20260325-mt7927-wifi-support-v2-v3-5-5ca66c97a755@jetm.me>
In-Reply-To: <20260325-mt7927-wifi-support-v2-v3-5-5ca66c97a755@jetm.me>
From: Sean Wang <sean.wang@kernel.org>
Date: Thu, 26 Mar 2026 01:08:56 -0500
X-Gmail-Original-Message-ID: <CAGp9Lzr1Fgj5Gk2cAUFWq6sfKZZR2Cd6ymrzP7wKQh-7P9eo1A@mail.gmail.com>
X-Gm-Features: AQROBzAUYeAj2eTTTOIP2gLEFHOEoyZYt5R3yZNXfXyqfKxhXOUP9a1iwLeqE3c
Message-ID: <CAGp9Lzr1Fgj5Gk2cAUFWq6sfKZZR2Cd6ymrzP7wKQh-7P9eo1A@mail.gmail.com>
Subject: Re: [PATCH v3 05/13] wifi: mt76: mt7925: advertise EHT 320MHz
 capabilities for 6GHz band
To: Javier Tia <floss@jetm.me>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, Deren Wu <deren.wu@mediatek.com>, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Marcin FM <marcin@lgic.pl>, Cristian-Florin Radoi <radoi.chris@gmail.com>, 
	George Salukvadze <giosal90@gmail.com>, Evgeny Kapusta <3193631@gmail.com>, 
	Samu Toljamo <samu.toljamo@gmail.com>, Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>, 
	Chapuis Dario <chapuisdario4@gmail.com>, =?UTF-8?Q?Thibaut_Fran=C3=A7ois?= <tibo@humeurlibre.fr>, 
	=?UTF-8?B?5byg5pet5ra1?= <Loong.0x00@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[jetm.me:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-33917-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	GREYLIST(0.00)[pass,meta];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org,lgic.pl,humeurlibre.fr];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.454];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,jetm.me:email,humeurlibre.fr:email,lgic.pl:email]
X-Rspamd-Queue-Id: 181BA32FAB2
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

Hi, Javier

On Wed, Mar 25, 2026 at 5:14=E2=80=AFPM Javier Tia <floss@jetm.me> wrote:
>
> mt7925_init_eht_caps() only populates EHT MCS/NSS maps for BW <=3D 80
> and BW =3D 160, but never sets BW =3D 320. This means iw phy shows no
> 320MHz MCS map entries even though the hardware supports 320MHz
> operation in the 6GHz band.
>
> Add the missing 320MHz capability bits for 6GHz:
>   - PHY_CAP0: IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ
>   - PHY_CAP1: beamformee SS for 320MHz
>   - PHY_CAP2: sounding dimensions for 320MHz
>   - PHY_CAP6: MCS15 support for 320MHz width
>   - MCS/NSS: populate bw._320 maps for 6GHz band
>
> Introduce is_320mhz_supported() to gate 320MHz on MT7927 only, since
> MT7925 does not support 320MHz operation.
>
> Tested-by: Marcin FM <marcin@lgic.pl>
> Tested-by: Cristian-Florin Radoi <radoi.chris@gmail.com>
> Tested-by: George Salukvadze <giosal90@gmail.com>
> Tested-by: Evgeny Kapusta <3193631@gmail.com>
> Tested-by: Samu Toljamo <samu.toljamo@gmail.com>
> Tested-by: Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>
> Tested-by: Chapuis Dario <chapuisdario4@gmail.com>
> Tested-by: Thibaut Fran=C3=A7ois <tibo@humeurlibre.fr>
> Tested-by: =E5=BC=A0=E6=97=AD=E6=B6=B5 <Loong.0x00@gmail.com>
> Signed-off-by: Javier Tia <floss@jetm.me>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76_connac.h |  5 +++++
>  drivers/net/wireless/mediatek/mt76/mt7925/main.c | 22 ++++++++++++++++++=
+++-
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/n=
et/wireless/mediatek/mt76/mt76_connac.h
> index 813d61bffc2c..3785fbf5ac99 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> @@ -177,6 +177,11 @@ static inline bool is_mt7925(struct mt76_dev *dev)
>         return mt76_chip(dev) =3D=3D 0x7925;
>  }
>
> +static inline bool is_320mhz_supported(struct mt76_dev *dev)
> +{
> +       return is_mt7927(dev);

This looks like it would cause a build error since is_mt7927() is not
introduced until patch 6.

> +}
> +
>  static inline bool is_mt7920(struct mt76_dev *dev)
>  {
>         return mt76_chip(dev) =3D=3D 0x7920;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7925/main.c
> index f128a198f81d..cfce851a94e2 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
> @@ -183,6 +183,10 @@ mt7925_init_eht_caps(struct mt792x_phy *phy, enum nl=
80211_band band,
>                 IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMER |
>                 IEEE80211_EHT_PHY_CAP0_SU_BEAMFORMEE;
>
> +       if (band =3D=3D NL80211_BAND_6GHZ && is_320mhz_supported(&phy->de=
v->mt76))
> +               eht_cap_elem->phy_cap_info[0] |=3D
> +                       IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
> +
>         eht_cap_elem->phy_cap_info[0] |=3D
>                 u8_encode_bits(u8_get_bits(sts - 1, BIT(0)),
>                                IEEE80211_EHT_PHY_CAP0_BEAMFORMEE_SS_80MHZ=
_MASK);
> @@ -193,10 +197,20 @@ mt7925_init_eht_caps(struct mt792x_phy *phy, enum n=
l80211_band band,
>                 u8_encode_bits(sts - 1,
>                                IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_SS_160MH=
Z_MASK);
>
> +       if (band =3D=3D NL80211_BAND_6GHZ && is_320mhz_supported(&phy->de=
v->mt76))
> +               eht_cap_elem->phy_cap_info[1] |=3D
> +                       u8_encode_bits(sts - 1,
> +                                      IEEE80211_EHT_PHY_CAP1_BEAMFORMEE_=
SS_320MHZ_MASK);
> +
>         eht_cap_elem->phy_cap_info[2] =3D
>                 u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_D=
IM_80MHZ_MASK) |
>                 u8_encode_bits(sts - 1, IEEE80211_EHT_PHY_CAP2_SOUNDING_D=
IM_160MHZ_MASK);
>
> +       if (band =3D=3D NL80211_BAND_6GHZ && is_320mhz_supported(&phy->de=
v->mt76))
> +               eht_cap_elem->phy_cap_info[2] |=3D
> +                       u8_encode_bits(sts - 1,
> +                                      IEEE80211_EHT_PHY_CAP2_SOUNDING_DI=
M_320MHZ_MASK);
> +
>         eht_cap_elem->phy_cap_info[3] =3D
>                 IEEE80211_EHT_PHY_CAP3_NG_16_SU_FEEDBACK |
>                 IEEE80211_EHT_PHY_CAP3_NG_16_MU_FEEDBACK |
> @@ -217,7 +231,8 @@ mt7925_init_eht_caps(struct mt792x_phy *phy, enum nl8=
0211_band band,
>                 u8_encode_bits(u8_get_bits(0x11, GENMASK(1, 0)),
>                                IEEE80211_EHT_PHY_CAP5_MAX_NUM_SUPP_EHT_LT=
F_MASK);
>
> -       val =3D width =3D=3D NL80211_CHAN_WIDTH_160 ? 0x7 :
> +       val =3D width =3D=3D NL80211_CHAN_WIDTH_320 ? 0xf :
> +             width =3D=3D NL80211_CHAN_WIDTH_160 ? 0x7 :
>               width =3D=3D NL80211_CHAN_WIDTH_80 ? 0x3 : 0x1;
>         eht_cap_elem->phy_cap_info[6] =3D
>                 u8_encode_bits(u8_get_bits(0x11, GENMASK(4, 2)),
> @@ -239,6 +254,11 @@ mt7925_init_eht_caps(struct mt792x_phy *phy, enum nl=
80211_band band,
>         eht_nss->bw._160.rx_tx_mcs9_max_nss =3D val;
>         eht_nss->bw._160.rx_tx_mcs11_max_nss =3D val;
>         eht_nss->bw._160.rx_tx_mcs13_max_nss =3D val;
> +       if (band =3D=3D NL80211_BAND_6GHZ && is_320mhz_supported(&phy->de=
v->mt76)) {
> +               eht_nss->bw._320.rx_tx_mcs9_max_nss =3D val;
> +               eht_nss->bw._320.rx_tx_mcs11_max_nss =3D val;
> +               eht_nss->bw._320.rx_tx_mcs13_max_nss =3D val;
> +       }
>  }
>
>  int mt7925_init_mlo_caps(struct mt792x_phy *phy)
>
> --
> 2.53.0
>
>

