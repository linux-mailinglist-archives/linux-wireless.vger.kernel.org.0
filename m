Return-Path: <linux-wireless+bounces-24639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB20AED245
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 03:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCEAA1703FA
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 01:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD43A81732;
	Mon, 30 Jun 2025 01:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="QA0lYvaj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A474D14A8B;
	Mon, 30 Jun 2025 01:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751248289; cv=none; b=QFp+F/MsjDb+R5QKV+3QrEUxWdiv4P14ZlTJ8gr69PtBcUKcPT9I8DuB5jAZYAFqiGRmQTVrnlFqOrXbny4VGRVqemCyGBiN7huYz2yuKJqPAVNbs9pfGN+OsCXRuWRoHP9xPeaXKBHRghjHbFBz/YyR4PKS646gCWHiujLEW/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751248289; c=relaxed/simple;
	bh=z5utaZjAok3SMsLK5G8+BSjY/xei4JILXCIyrOUAuRM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ng/7GqXJQrKasH8Uw8vfMq4Rpn5rSTyIB4AbrTJYE0Ithh1CSfOPfAZd+Ij3Oh85Vg5Uv9ZMAQV5BNpBoNR/0NYGcWStJH8E2tz52JS8WEcoQEzep0dKMMYJOaYKnNX1TQ8eO3dpUri4WpjWSIy7qD2ZIlnfq48CsVx1kS0133g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=QA0lYvaj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55U1orZQ33802774, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1751248254; bh=xWTvLLWPzUP66I+4GfYn1Z0bMym8AnJFCNygSFBp1aA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=QA0lYvajs7rB66V3qqdtB7Ze6kZ4qFSO83gjBL4d6z9lYu2FAftIbfFDoTiAjOOc/
	 g8WvO7wl/csi6CAL+gmG7cG1TqVg4I4m9+Rbpd7qiiYNPxL3J2HQAxE9Pfg91SH+IX
	 Nmut3aca2kOk9W9UOkrLkTn2EaR4NFSjxEPOV52mt+XnadTrS7ZmMPMKy0xhNjttDH
	 6Xy9uNjoARq0wqbKqNbVyGh5NYUK8xw7dGYEVcxERSr36BH+PjCMDjotpaW6dIRyLy
	 tyOALJal1VOTsi6ivHy6bbFi4c0/B6P5Q+fWUldJ9XPz3xgwRid69S1CYQA6SZPn5i
	 8545zXl+wIgig==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55U1orZQ33802774
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 09:50:54 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Jun 2025 09:51:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 30 Jun 2025 09:51:13 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 30 Jun 2025 09:51:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Kalle Valo
	<kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Fiona Klute <fiona.klute@gmx.de>
Subject: RE: [PATCH] wifi: rtw88: enable TX reports for the management queue
Thread-Topic: [PATCH] wifi: rtw88: enable TX reports for the management queue
Thread-Index: AQHb6HzPChsugwZFCE+9DYTxskrPbLQa8FQQ
Date: Mon, 30 Jun 2025 01:51:13 +0000
Message-ID: <dbd7eee63629497194901210c46bd704@realtek.com>
References: <20250628223048.3597641-1-andrej.skvortzov@gmail.com>
In-Reply-To: <20250628223048.3597641-1-andrej.skvortzov@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> This is needed for AP mode. Otherwise client sees the network, but
> can't connect to it.
>=20
> REG_FWHW_TXQ_CTRL+1 is set to WLAN_TXQ_RPT_EN (0x1F) in common mac
> init function (__rtw8723x_mac_init), but the value was overwritten
> from mac table later.

Since the tables were copied from vendor driver, I suspect people might
overwrite the tables again resulting in regression.=20

So we can add a mac_post_init to set the value after loading parameters:

  rtw_mac_init(rtwdev); // not set REG_FWHW_TXQ_CTRL+1 to WLAN_TXQ_RPT_EN

  chip->ops->phy_set_param(rtwdev); // "0x421, 0x0000000F," by table

  rtw_mac_postinit(rtwdev); // set REG_FWHW_TXQ_CTRL+1 to WLAN_TXQ_RPT_EN=20

Only rtw8703b/rtw8723d implement postinit ops.

>=20
> Tested on rtl8723cs, that reuses rtw8703b driver.
>=20
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c | 1 -
>  drivers/net/wireless/realtek/rtw88/rtw8723d_table.c  | 1 -
>  2 files changed, 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c
> b/drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c
> index 81020fd907aa6..fe4b112f582ba 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c
> @@ -199,7 +199,6 @@ static const u32 rtw8703b_mac[] =3D {
>         0x035, 0x00000000,
>         0x067, 0x00000002,
>         0x092, 0x00000080,
> -       0x421, 0x0000000F,
>         0x428, 0x0000000A,
>         0x429, 0x00000010,
>         0x430, 0x00000000,
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d_table.c
> b/drivers/net/wireless/realtek/rtw88/rtw8723d_table.c
> index 27a22b392df00..bc7c6111782b2 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8723d_table.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8723d_table.c
> @@ -10,7 +10,6 @@ static const u32 rtw8723d_mac[] =3D {
>         0x020, 0x00000013,
>         0x02F, 0x00000010,
>         0x077, 0x00000007,
> -       0x421, 0x0000000F,
>         0x428, 0x0000000A,
>         0x429, 0x00000010,
>         0x430, 0x00000000,
> --
> 2.47.2


