Return-Path: <linux-wireless+bounces-33789-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Fd1JIvlwmm/nAQAu9opvQ
	(envelope-from <linux-wireless+bounces-33789-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 20:27:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED3931B7F1
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 20:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDF99305B312
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 19:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561D73002CF;
	Tue, 24 Mar 2026 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdzeotiw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B922F0673
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 19:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774380312; cv=none; b=ge8cw6NcY7Pe66KhFnt5NgSBfRlJHKw7EzjQUQE1DI4XCS3dhN41vB7MDH6COigmz8Zn00dYANy4X+a3+Fm26Fvtyzp0dABDudzZ5OkTOrN5R0QChKc/irp2I594vo52REkSyAI4AkuaGsPac9ubjzpd/ssYWDX2uIKTYTqCaEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774380312; c=relaxed/simple;
	bh=W2kqahuI0dRdiWt2FzF8BjyOm6F3ukwameRH6zo7Z/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NwFPDuR9MCYucSr8NBaBbD7fO3BFcakT5Mo5B8ef83Ett8FusQX/64cx6kWsWi7CxLYqaAFJTcFDxjZK5QgPe//lSyYv5poGpwaVDCfBKuQyOP7C4nGMjzGEgEVHr/jJYXSTi/5xruZXRCut+OfJF8iqUm0HsD/lcfqokpK87E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdzeotiw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9702C2BCC6
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 19:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774380311;
	bh=W2kqahuI0dRdiWt2FzF8BjyOm6F3ukwameRH6zo7Z/8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rdzeotiwu5t7bs+XXjN4poTi0+pT9sYIJzYXAQWmlMXlKwWLsxRYZAAbJXccMqRz8
	 tcluVY9BwAb7qsiK8RsqA4nQvuLEaq1b8Sp5s8suPn1KCBpzZvBLQE0KNEIfBgaKjx
	 aeiLrLs9r//AB52n/i/SDVfilfWwvxT2rKgD7YR9AIpmdD0+RmUJWFdh1xHZ2YEq7s
	 8KaerkGa41v2sYwzkuicShvaBHEPPxGRXjlwBFJ/4uzGtqrtvL31IstDILkRPa8/Su
	 q0IB5KrAjH91mqiIfUWhXDw5oV02/P2p382m2+DUXN+xIkt+lvJR0TW2E991WqG4Xi
	 9pA7kvG+0M5Pw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-38ad12fb595so1836711fa.0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 12:25:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV6iarbyVvyuAXG4t+dd3SZVpu3N4SvDl89eTjMea0W7oyymS8KOEa2eL3t0H6WVZbNUqmDkaeHNTld7bSonw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm2YDK6kSRZ5TQ5OidBf+3k6YV/XxArKJsYMxgJsqWW2WbMWD4
	Z7bCWwwwYjrgPXgJNsGl6yXa9jFJ+wll3Sw06QHIu17rdyJNQhunBaFBGO39soYXWgg+nhEWBB0
	oI9goPBrNs3GP8x0I3FLIIshCDRK8g8I=
X-Received: by 2002:a05:651c:310:b0:387:a16:ee83 with SMTP id
 38308e7fff4ca-38c32931d14mr11373651fa.11.1774380310067; Tue, 24 Mar 2026
 12:25:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319-mt7927-wifi-support-v2-v2-0-d627a7fad70d@jetm.me> <20260319-mt7927-wifi-support-v2-v2-5-d627a7fad70d@jetm.me>
In-Reply-To: <20260319-mt7927-wifi-support-v2-v2-5-d627a7fad70d@jetm.me>
From: Sean Wang <sean.wang@kernel.org>
Date: Tue, 24 Mar 2026 14:24:58 -0500
X-Gmail-Original-Message-ID: <CAGp9LzoYcJEmFKTKGsF3WchxLedyo7HvGCn8Vi=WaEXS1N-VTg@mail.gmail.com>
X-Gm-Features: AQROBzCJFXGOj3qOH6JxvcssVN9WorUl4nD9nSO254z7rVrluItXC4oVHqFFQWg
Message-ID: <CAGp9LzoYcJEmFKTKGsF3WchxLedyo7HvGCn8Vi=WaEXS1N-VTg@mail.gmail.com>
Subject: Re: [PATCH v2 05/13] wifi: mt76: mt7925: advertise EHT 320MHz
 capabilities for 6GHz band
To: Javier Tia <floss@jetm.me>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Deren Wu <deren.wu@mediatek.com>, 
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Marcin FM <marcin@lgic.pl>, 
	Cristian-Florin Radoi <radoi.chris@gmail.com>, George Salukvadze <giosal90@gmail.com>, 
	Evgeny Kapusta <3193631@gmail.com>, Samu Toljamo <samu.toljamo@gmail.com>, 
	Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>, Chapuis Dario <chapuisdario4@gmail.com>, 
	=?UTF-8?Q?Thibaut_Fran=C3=A7ois?= <tibo@humeurlibre.fr>, 
	=?UTF-8?B?5byg5pet5ra1?= <Loong.0x00@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33789-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org,lgic.pl,humeurlibre.fr];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 2ED3931B7F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Thu, Mar 19, 2026 at 5:26=E2=80=AFPM Javier Tia <floss@jetm.me> wrote:
>
> mt7925_init_eht_caps() only populates EHT MCS/NSS maps for BW <=3D 80
> and BW =3D 160, but never sets BW =3D 320. This means iw phy shows no
> 320MHz MCS map entries even though the hardware supports 320MHz
> operation in the 6GHz band.
>
> Add the missing 320MHz capability bits for 6GHz, following the same
> pattern as mt7996:
>   - PHY_CAP0: IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ
>   - PHY_CAP1: beamformee SS for 320MHz
>   - PHY_CAP2: sounding dimensions for 320MHz
>   - PHY_CAP6: MCS15 support for 320MHz width
>   - PHY_CAP7: non-OFDMA UL MU-MIMO and MU beamformer for 320MHz
>   - MCS/NSS: populate bw._320 maps for 6GHz band
>
> Introduce is_320mhz_supported() as a generic capability check using the
> mt7925 family ID. This avoids chip-specific references in common code,
> and automatically extends to new chips once they join the
> is_mt7925() family via chip ID helpers.
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
>  drivers/net/wireless/mediatek/mt76/mt7925/main.c | 28 ++++++++++++++++++=
+++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/n=
et/wireless/mediatek/mt76/mt76_connac.h
> index 813d61bffc2c..554716e01ee6 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> @@ -177,6 +177,11 @@ static inline bool is_mt7925(struct mt76_dev *dev)
>         return mt76_chip(dev) =3D=3D 0x7925;
>  }
>
> +static inline bool is_320mhz_supported(struct mt76_dev *dev)
> +{
> +       return is_mt7925(dev);

I don't think this is correct for mt7925, and it will cause a
regression there. Was this tested on actual mt7925 hardware?

> +}
> +
>  static inline bool is_mt7920(struct mt76_dev *dev)
>  {
>         return mt76_chip(dev) =3D=3D 0x7920;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7925/main.c
> index f128a198f81d..cd043ac266fb 100644
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
> @@ -230,6 +245,11 @@ mt7925_init_eht_caps(struct mt792x_phy *phy, enum nl=
80211_band band,
>                 IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_80MHZ |
>                 IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_160MHZ;
>
> +       if (band =3D=3D NL80211_BAND_6GHZ && is_320mhz_supported(&phy->de=
v->mt76))
> +               eht_cap_elem->phy_cap_info[7] |=3D
> +                       IEEE80211_EHT_PHY_CAP7_NON_OFDMA_UL_MU_MIMO_320MH=
Z |
> +                       IEEE80211_EHT_PHY_CAP7_MU_BEAMFORMER_320MHZ;
> +

I don't think this should be copied from mt7996 as-is for mt7927. I'd
suggest dropping the eht_cap_elem->phy_cap_info[7] change and keeping
it conservative for now.

>         val =3D u8_encode_bits(nss, IEEE80211_EHT_MCS_NSS_RX) |
>               u8_encode_bits(nss, IEEE80211_EHT_MCS_NSS_TX);
>
> @@ -239,6 +259,12 @@ mt7925_init_eht_caps(struct mt792x_phy *phy, enum nl=
80211_band band,
>         eht_nss->bw._160.rx_tx_mcs9_max_nss =3D val;
>         eht_nss->bw._160.rx_tx_mcs11_max_nss =3D val;
>         eht_nss->bw._160.rx_tx_mcs13_max_nss =3D val;
> +
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

