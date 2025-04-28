Return-Path: <linux-wireless+bounces-22109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB0CA9E5FD
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 03:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF4283B9AD8
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 01:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CBE78F51;
	Mon, 28 Apr 2025 01:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="UUcpAWOS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C029D1CF96;
	Mon, 28 Apr 2025 01:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745805240; cv=none; b=ZxMQFhJxuxwRqqcmftJfCbj549p1cnkXmkjbWYP96EfDWHYj1bVQXuG6p6GiixVqWaEkXkPAeyaas+BHzWLuvrED3DAt/uYY/g57zL3g/Majr/h6L6aMVSgyPgQFBIhwquomy5ldmiOFG/Uu06Mqci4yXJejZoQD8bD3Ut2PMHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745805240; c=relaxed/simple;
	bh=nxyY/WNVcAUuccaX+B2/4kAbRKQRofDQX31TfWMmjvw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pqSJxExx66+DQIUAv2T0Djy1ejkQcBOT8KXlbxM8WRQ0nyFJJmd6WmgL6nTbGWBJ6Dwa+RJQ2nPQ5svgqacCH6nNEHtRPLioMo0/ODWz1f+KTu3igq8wSNcXbR9vjD1np8MYP2a/WikqnXWQgZbs0hyTMbLeiLyM84kPzfe3RKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=UUcpAWOS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53S1rj5yB1180188, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745805225; bh=nxyY/WNVcAUuccaX+B2/4kAbRKQRofDQX31TfWMmjvw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=UUcpAWOS9NYvA/jueu/vLqBOsHGX+bELwcvAMht+ydiGzAolhMeBx20/0UDhaDVy9
	 G+gYL/XbCWy9GvRkfVCFqQ0BvLFcTJJA0LzuOa9phF2TKPkZ0pvvu1M8oKzDiPilDW
	 T4Qe9eeic9+VVW5c0iS5IECaeoMZ++YdEptvOAvXjG00cPYODoWNNYcIU90LRn5e5U
	 X8D3DrobWlm+4FNHtDx7Z7AkMPKehhXsiihdcslmjYlLPLkrDIOyJR8o8cKJicEseN
	 1a3GiDEKp79ROagVNKjDi89HgJn5L3J6Kir4sr5LqNcFa9CyBD/N3jN+OcH8mg+qWy
	 GA5Q/N3IxeDbg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53S1rj5yB1180188
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 09:53:45 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Apr 2025 09:53:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 28 Apr 2025 09:53:44 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 28 Apr 2025 09:53:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?iso-8859-2?Q?Ond=F8ej_Jirman?= <megi@xff.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "open list:REALTEK WIRELESS DRIVER (rtw89)"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: Fix inadverent sharing of struct ieee80211_supported_band data
Thread-Topic: [PATCH] wifi: rtw89: Fix inadverent sharing of struct
 ieee80211_supported_band data
Thread-Index: AQHbtwrOUtNppvqbbk6+hgDxNYRyi7O4TFxA
Date: Mon, 28 Apr 2025 01:53:44 +0000
Message-ID: <d3c6e149a2794551ba4570bdd7f1b7e7@realtek.com>
References: <20250427002414.410791-1-megi@xff.cz>
In-Reply-To: <20250427002414.410791-1-megi@xff.cz>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Ond=F8ej Jirman <megi@xff.cz> wrote:
>=20
> Internally wiphy writes to individual channels in this structure,
> so we must not share one static definition of channel list between
> multiple device instances, because that causes hard to debug
> breakage.
>=20
> For example, with two rtw89 driven devices in the system, channel
> information may get incoherent, preventing channel use.
>=20
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> ---
>=20
> This patch relates to this report of mine:
>=20
>=20
> https://lore.kernel.org/linux-wireless/2goskmst4na36v42p2bs47uernp6kh3gzp=
adhr3u3r2yvyoxlg@bfprgq2qae7p
> /T/#u
>=20
>  drivers/net/wireless/realtek/rtw89/core.c | 48 ++++++++++++++++++-----
>  1 file changed, 38 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wire=
less/realtek/rtw89/core.c
> index cc9b014457ac..ae22954f5f5c 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -4398,16 +4398,44 @@ static void rtw89_init_he_eht_cap(struct rtw89_de=
v *rtwdev,
>         _ieee80211_set_sband_iftype_data(sband, iftype_data, idx);
>  }
>=20
> +static struct ieee80211_supported_band *rtw89_copy_sband(const struct ie=
ee80211_supported_band *sband)

prefer naming rtw89_core_sband_dup().

> +{
> +       struct ieee80211_supported_band *copy =3D kmemdup(sband, sizeof(*=
sband), GFP_KERNEL);

Then, '*dup'.=20

> +
> +       copy->channels =3D kmemdup(sband->channels, sizeof(struct ieee802=
11_channel) * sband->n_channels,
> GFP_KERNEL);

I'm planning to use devm_ series to manage sband data, so we don't need to
free them one by one. Do you interest to adjust that along with this patchs=
et?=20
I mean adding additional patches to adjust the code before this patch, and
make them as a patchset.=20

For kmemdup, the corresponding one is devm_kmemdup.=20

The line is too long. Less than 80 characters is preferred.=20

> +       if (!copy->channels) {
> +               kfree(copy);
> +               return NULL;
> +       }
> +
> +       copy->bitrates =3D kmemdup(sband->bitrates, sizeof(struct ieee802=
11_rate) * sband->n_bitrates,
> GFP_KERNEL);

Since you have duplicated arrays of channels and bitrate, we should add con=
st
to them, like:

  static const struct ieee80211_channel rtw89_channels_{2ghz,5ghz,6ghz}[]
  static const struct ieee80211_rate rtw89_bitrates[]


> +       if (!copy->bitrates) {
> +               kfree(copy->channels);
> +               kfree(copy);
> +               return NULL;
> +       }
> +
> +       return copy;
> +}
> +
> +static void rtw89_free_sband(const struct ieee80211_supported_band *sban=
d)
> +{
> +       if (sband) {
> +               kfree(sband->bitrates);
> +               kfree(sband->channels);
> +               kfree(sband);
> +       }
> +}
> +
>  static int rtw89_core_set_supported_band(struct rtw89_dev *rtwdev)
>  {
>         struct ieee80211_hw *hw =3D rtwdev->hw;
>         struct ieee80211_supported_band *sband_2ghz =3D NULL, *sband_5ghz=
 =3D NULL;
>         struct ieee80211_supported_band *sband_6ghz =3D NULL;
> -       u32 size =3D sizeof(struct ieee80211_supported_band);
>         u8 support_bands =3D rtwdev->chip->support_bands;
>=20
>         if (support_bands & BIT(NL80211_BAND_2GHZ)) {
> -               sband_2ghz =3D kmemdup(&rtw89_sband_2ghz, size, GFP_KERNE=
L);
> +               sband_2ghz =3D rtw89_copy_sband(&rtw89_sband_2ghz);
>                 if (!sband_2ghz)
>                         goto err;
>                 rtw89_init_ht_cap(rtwdev, &sband_2ghz->ht_cap);
> @@ -4416,7 +4444,7 @@ static int rtw89_core_set_supported_band(struct rtw=
89_dev *rtwdev)
>         }
>=20
>         if (support_bands & BIT(NL80211_BAND_5GHZ)) {
> -               sband_5ghz =3D kmemdup(&rtw89_sband_5ghz, size, GFP_KERNE=
L);
> +               sband_5ghz =3D rtw89_copy_sband(&rtw89_sband_5ghz);
>                 if (!sband_5ghz)
>                         goto err;
>                 rtw89_init_ht_cap(rtwdev, &sband_5ghz->ht_cap);
> @@ -4426,7 +4454,7 @@ static int rtw89_core_set_supported_band(struct rtw=
89_dev *rtwdev)
>         }
>=20
>         if (support_bands & BIT(NL80211_BAND_6GHZ)) {
> -               sband_6ghz =3D kmemdup(&rtw89_sband_6ghz, size, GFP_KERNE=
L);
> +               sband_6ghz =3D rtw89_copy_sband(&rtw89_sband_6ghz);
>                 if (!sband_6ghz)
>                         goto err;
>                 rtw89_init_he_eht_cap(rtwdev, NL80211_BAND_6GHZ, sband_6g=
hz);
> @@ -4445,9 +4473,9 @@ static int rtw89_core_set_supported_band(struct rtw=
89_dev *rtwdev)
>                 kfree((__force void *)sband_5ghz->iftype_data);
>         if (sband_6ghz)
>                 kfree((__force void *)sband_6ghz->iftype_data);
> -       kfree(sband_2ghz);
> -       kfree(sband_5ghz);
> -       kfree(sband_6ghz);
> +       rtw89_free_sband(sband_2ghz);
> +       rtw89_free_sband(sband_5ghz);
> +       rtw89_free_sband(sband_6ghz);
>         return -ENOMEM;
>  }
>=20
> @@ -4461,9 +4489,9 @@ static void rtw89_core_clr_supported_band(struct rt=
w89_dev *rtwdev)
>                 kfree((__force void *)hw->wiphy->bands[NL80211_BAND_5GHZ]=
->iftype_data);
>         if (hw->wiphy->bands[NL80211_BAND_6GHZ])
>                 kfree((__force void *)hw->wiphy->bands[NL80211_BAND_6GHZ]=
->iftype_data);
> -       kfree(hw->wiphy->bands[NL80211_BAND_2GHZ]);
> -       kfree(hw->wiphy->bands[NL80211_BAND_5GHZ]);
> -       kfree(hw->wiphy->bands[NL80211_BAND_6GHZ]);
> +       rtw89_free_sband(hw->wiphy->bands[NL80211_BAND_2GHZ]);
> +       rtw89_free_sband(hw->wiphy->bands[NL80211_BAND_5GHZ]);
> +       rtw89_free_sband(hw->wiphy->bands[NL80211_BAND_6GHZ]);
>         hw->wiphy->bands[NL80211_BAND_2GHZ] =3D NULL;
>         hw->wiphy->bands[NL80211_BAND_5GHZ] =3D NULL;
>         hw->wiphy->bands[NL80211_BAND_6GHZ] =3D NULL;

Like I mentioned above, with devm_ series, I suppose this function can be
removed entirely.=20



