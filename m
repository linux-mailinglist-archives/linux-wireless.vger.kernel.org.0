Return-Path: <linux-wireless+bounces-21285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28264A81AB9
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 03:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBCB465E69
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Apr 2025 01:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562E515624B;
	Wed,  9 Apr 2025 01:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="QrLXbEna"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE42929A2
	for <linux-wireless@vger.kernel.org>; Wed,  9 Apr 2025 01:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744163485; cv=none; b=eSu3lEFkwM4iDdwqTHsmv2GvZwPfDqxw1IaPQ/1em1uvesL6HKfaQqBzERBR5zuTnWJZuVveqLKk/oouW2GGTjcvLcVdwtwCoFuKnpSipXPiU2qFT+9vrr/chJ5KDS+pKoerCyAYWHQxBwAQ/4b2J4JBtLY2+4e7MRDDqJfD7As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744163485; c=relaxed/simple;
	bh=PRRXnL/GZ9BwyfCKUa99+/2XuyX0pwNup+DFgUQX6D0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c8NV058J2rO6mu8I8FpxONm/511Pq49gGLe7Xo7MFe0NqNpw9PXDiUPAYYEZNkeFaMWPLL0Lj8Nq7XWNwtsdyd8JBtIUKvTkLtWfoMMMeac6Rc4sDhmrFZ/I8pm39v/lPhnwQXPSEzjVQIqCes6zdaO/fshFLKka/BF/ZRl7CBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=QrLXbEna; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5391lerW7432169, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744163260; bh=PRRXnL/GZ9BwyfCKUa99+/2XuyX0pwNup+DFgUQX6D0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=QrLXbEnaiBDPHWd5mg7BjciqXic+GlMTq4WipOcMfalauOtfDdgahvcsogvIPwjog
	 DIhkdhya+Wx8hsswmHldCA5tzETl65W+rAfkpWFb4G1JP1p0ugrxAWSWv/HRwOWTou
	 EdqrEGZdkCwXl1IDRlHojdMWFfcqdZJsHNTlfzzJghGZH7GTQoUDY4+UyfGOT0Vqzs
	 P2ydbESmVtnDeIBhn3ArAm2dbUV43Oe44GolNJ0W6ber0dhUR8XvF/f/BJ/Qwg0HPU
	 RG0zECT4HRrgv0rgA6FsrxBlotvxNoMsv+8XBGVZrSYoDcGPmDOHmMqJng/B4X8tvw
	 Oqju7rioV9nxQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5391lerW7432169
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 09:47:40 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 9 Apr 2025 09:47:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 9 Apr 2025 09:47:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 9 Apr 2025 09:47:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dmitry Antipov <dmantipov@yandex.ru>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: Dmitry Kandybka <d.kandybka@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: RE: [PATCH] wifi: rtlwifi: add array bounds check in rtl92d_dm_rxgain_tracking_thermalmeter()
Thread-Topic: [PATCH] wifi: rtlwifi: add array bounds check in
 rtl92d_dm_rxgain_tracking_thermalmeter()
Thread-Index: AQHbqJsbv2+k5U1pEE2yOB6/XqdbB7Oajvaw
Date: Wed, 9 Apr 2025 01:47:40 +0000
Message-ID: <3bd6c53a69ae4c48871bbae7a58b6948@realtek.com>
References: <20250408151744.3907215-1-dmantipov@yandex.ru>
In-Reply-To: <20250408151744.3907215-1-dmantipov@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Dmitry Antipov <dmantipov@yandex.ru> wrote:
> In 'rtl92d_dm_rxgain_tracking_thermalmeter()', add an extra 'index_mappin=
g'
> array bounds check and use the convenient 'array_index_nospec()' to prote=
ct
> against spectre. Compile tested only.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c
> b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c
> index 20373ce998bf..44f1d3b40d22 100644
> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c
> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192d/dm_common.c
> @@ -139,6 +139,9 @@ static void rtl92d_dm_rxgain_tracking_thermalmeter(st=
ruct ieee80211_hw *hw)
>         u32 u4tmp;
>=20
>         idx =3D rtlpriv->efuse.eeprom_thermalmeter - rtlpriv->dm.thermalv=
alue_rxgain;
> +       if (WARN_ON_ONCE(idx < 0 || idx >=3D ARRAY_SIZE(index_mapping)))
> +               return;

By original flow, we can ensure rtlpriv->dm.thermalvalue_rxgain must be sma=
ller
or equal to rtlpriv->efuse.eeprom_thermalmeter, so 'idx < 0' is not possibl=
e.=20

Maybe we can clamp the range within [0, RX_INDEX_MAPPING_NUM - 1] when
assigning value to rtlpriv->dm.thermalvalue_rxgain.=20

> +       idx =3D array_index_nospec(idx, ARRAY_SIZE(index_mapping));

Does this overkill? I'm not very clear when we should use this to prevent C=
PU
speculates, but if this is really needed, the statements will be added
everywhere.=20

>         u4tmp =3D index_mapping[idx] << 12;
>=20
>         rtl_dbg(rtlpriv, COMP_POWER_TRACKING, DBG_LOUD,
> --
> 2.49.0
>=20


