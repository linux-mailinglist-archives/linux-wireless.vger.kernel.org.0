Return-Path: <linux-wireless+bounces-3121-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E319D8492A6
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 04:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC921F228B7
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 03:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010379449;
	Mon,  5 Feb 2024 03:05:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9950945A;
	Mon,  5 Feb 2024 03:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707102319; cv=none; b=rNceojzOJVY+u/L+zwcTqQGMpmoub8lq0gtGVwVktM3RPCKjrB6kZIPzs6OQ8PQ4BjtxllEGDGJi8L7GeH03bPTdE9lDVtAa7MVsu/Nj/H808T/Lt1ikZmLLLLJvongNgkz+9/xk2hW6a5jMQsWg6QyJtWPt+f9J0n5pfyOMrbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707102319; c=relaxed/simple;
	bh=aGcz+kwdVgCI14Vhut2k38YHIgfop7qVfXrlTvOjUpU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rmjgCC5X4nK1QBlGzn/PuSfrjXEUWj0IHFXBER9osuWrO3BoEx5bBDZO6uLqzUZXQMJ1mTPjxBvpkvX5cFNXfE4QtU1xxSgO8bDfTKwmIgZ8v1Hdg3q+6DyBvmw0hGVr9Wg01CPRcXCdgJcEC7tN5n3JP+Ar39vqgJvyUU5M5ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 415350ZL03032978, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 415350ZL03032978
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 11:05:00 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Mon, 5 Feb 2024 11:05:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 11:05:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Mon, 5 Feb 2024 11:05:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fiona Klute <fiona.klute@gmx.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Pavel Machek
	<pavel@ucw.cz>,
        =?iso-8859-2?Q?Ond=F8ej_Jirman?= <megi@xff.cz>
Subject: RE: [PATCH 8/9] wifi: rtw88: Reset 8703b firmware before download
Thread-Topic: [PATCH 8/9] wifi: rtw88: Reset 8703b firmware before download
Thread-Index: AQHaVdEGm9PdtNCN9kWLwSLylHN2w7D7FCFA
Date: Mon, 5 Feb 2024 03:05:00 +0000
Message-ID: <3f625eaee20e4399b8b6ef7d2776a530@realtek.com>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
 <20240202121050.977223-9-fiona.klute@gmx.de>
In-Reply-To: <20240202121050.977223-9-fiona.klute@gmx.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



> -----Original Message-----
> From: Fiona Klute <fiona.klute@gmx.de>
> Sent: Friday, February 2, 2024 8:11 PM
> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; =
linux-mmc@vger.kernel.org; Pavel
> Machek <pavel@ucw.cz>; Ond=F8ej Jirman <megi@xff.cz>; Fiona Klute <fiona.=
klute@gmx.de>
> Subject: [PATCH 8/9] wifi: rtw88: Reset 8703b firmware before download
>=20
> Sometimes 8703b firmware is still active from previous use when the
> driver needs to download the firmware during MAC activation. Reset it
> in that case.
>=20
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> ---
>  drivers/net/wireless/realtek/rtw88/mac.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wirel=
ess/realtek/rtw88/mac.c
> index 298663b035..b6de097e44 100644
> --- a/drivers/net/wireless/realtek/rtw88/mac.c
> +++ b/drivers/net/wireless/realtek/rtw88/mac.c
> @@ -936,6 +936,12 @@ static int __rtw_download_firmware_legacy(struct rtw=
_dev *rtwdev,
>  {
>         int ret =3D 0;
>=20
> +       /* reset firmware if still present */
> +       if (rtwdev->chip->id =3D=3D RTW_CHIP_TYPE_8703B &&
> +           rtw_read8(rtwdev, REG_MCUFW_CTRL) & BIT_RAM_DL_SEL) {

rtw_read8_mask(rtwdev, REG_MCUFW_CTRL, BIT_RAM_DL_SEL)=20

> +               rtw_write8(rtwdev, REG_MCUFW_CTRL, 0x00);
> +       }
> +
>         en_download_firmware_legacy(rtwdev, true);
>         ret =3D download_firmware_legacy(rtwdev, fw->firmware->data, fw->=
firmware->size);
>         en_download_firmware_legacy(rtwdev, false);
> --
> 2.43.0
>=20


