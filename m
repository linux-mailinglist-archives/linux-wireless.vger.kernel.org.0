Return-Path: <linux-wireless+bounces-22187-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FCB5AA0383
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 08:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9221717BE1B
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Apr 2025 06:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0319D274FD5;
	Tue, 29 Apr 2025 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="X7y2rkDG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8E325332F;
	Tue, 29 Apr 2025 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745908650; cv=none; b=hJE/Sz5tKENndARtrokl4X0pBUk/abi/QlFoLI3ttxhIfLZK+gvSA0LW4W2b7B7SF/LSzjfUCQjTSL/iELGr1RH8ucj/Rc24F2LnumZ+D0JvwdK//+8lCMRmGIs/MS+fWdc04Wvfbj+Z4AuImoPQx8zwA4gKlX9KyOtbD0g8EiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745908650; c=relaxed/simple;
	bh=ZBMNuBVX183nBnmmiTyKfHBu1rn0hQF2iq2wjCZQab0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YP6K1Kz6R/RJNxBRrBCrTh0FCVk30oYmRQBZ28h8UqDlczQfln/gB6cdenG+o5sWGDQH38O37gbdGFqvNRBicwLQjkcOYGJWrFeSq9JrsrnTksebJvPO//Yw1x4cDpICLyi1bUV8cHQvC1fEA2Wp47XXrosfeKTasgtaboBYw/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=X7y2rkDG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53T6bPqJ5240826, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745908646; bh=ZBMNuBVX183nBnmmiTyKfHBu1rn0hQF2iq2wjCZQab0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=X7y2rkDG885ArPv6UXmqE99IAJOVQuWB1OJyzOOcPOAfpJJA2CI3uBq3U+UrDaOjt
	 JJY9OAyU9BqeuCxx24fErLPjZB9Olvz18e4CnUuMDVL6CPzWbrTTVS620N+pfaj+6A
	 FhFdbHcnHCc7ZKgQ7xgYuhGXvicribGLE3ttElOcqGvzi6i9zdKG5LUNKLBAzG6JhL
	 pyYEugpaUCrO4sh9D3xNsv7QDQynhshNwiHEHcOvZ8HMUYe4IGxUacdQMsjlw06JHU
	 WKnGanTFZFjijc6f9oGbUqqo7PtIK5pBs09NHZ/eAHNP26DKMxJgEW6gu0j9xuVY0Z
	 UyGVj34kIykeA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53T6bPqJ5240826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 14:37:26 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 29 Apr 2025 14:37:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 29 Apr 2025 14:37:26 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 29 Apr 2025 14:37:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?iso-8859-2?Q?Ond=F8ej_Jirman?= <megi@xff.cz>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] wifi: rtw89: Fix inadverent sharing of struct ieee80211_supported_band data
Thread-Topic: [PATCH v2 2/2] wifi: rtw89: Fix inadverent sharing of struct
 ieee80211_supported_band data
Thread-Index: AQHbuK1tYn+yqWfERUyrGlhwjWwZPbO6MB/Q
Date: Tue, 29 Apr 2025 06:37:26 +0000
Message-ID: <91c53b3583864650a48de2ffa0dfccd1@realtek.com>
References: <20250429022046.1656056-1-megi@xff.cz>
 <20250429022046.1656056-3-megi@xff.cz>
In-Reply-To: <20250429022046.1656056-3-megi@xff.cz>
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
>  drivers/net/wireless/realtek/rtw89/core.c | 33 +++++++++++++++++++----
>  1 file changed, 28 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wire=
less/realtek/rtw89/core.c
> index b164bc767e82..48e21a3549ff 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.c
> +++ b/drivers/net/wireless/realtek/rtw89/core.c
> @@ -4400,17 +4400,40 @@ static int rtw89_init_he_eht_cap(struct rtw89_dev=
 *rtwdev,
>         return 0;
>  }
>=20
> +static struct ieee80211_supported_band *
> +rtw89_core_sband_dup(struct rtw89_dev *rtwdev,
> +                    const struct ieee80211_supported_band *sband)
> +{
> +       struct ieee80211_supported_band *dup;
> +
> +       dup =3D devm_kmemdup(rtwdev->dev, sband, sizeof(*sband), GFP_KERN=
EL);
> +       if (!dup)
> +               return NULL;
> +
> +       dup->channels =3D devm_kmemdup(rtwdev->dev, sband->channels,
> +                                    sizeof(struct ieee80211_channel) * s=
band->n_channels,

sizeof(*sband->channels) * sband->n_channels,

> +                                    GFP_KERNEL);
> +       if (!dup->channels)
> +               return NULL;
> +
> +       dup->bitrates =3D devm_kmemdup(rtwdev->dev, sband->bitrates,
> +                                    sizeof(struct ieee80211_rate) * sban=
d->n_bitrates,

sizeof(*sband->bitrates) * sband->n_bitrates,

> +                                    GFP_KERNEL);
> +       if (!dup->bitrates)
> +               return NULL;
> +
> +       return dup;
> +}
> +

[...]



