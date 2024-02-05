Return-Path: <linux-wireless+bounces-3118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FF7849251
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 03:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD581C21D7C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 02:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E211FA953;
	Mon,  5 Feb 2024 02:17:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CEBA93A;
	Mon,  5 Feb 2024 02:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707099468; cv=none; b=KZiGeUanjnPFAhp1d8O232lxbdrsEAj2efkyPX77rASThIQAcSS6tdJZw5YIlTs+b4ngS9KWSs3PzIS37ldv6G+zSbsAQq6WGchcQazBu2mxOkulsQucnnjbMJQmza9+lyqDF72C52BiBGwTp+RuoTR1AsnKyA+LR5Jhl9utQs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707099468; c=relaxed/simple;
	bh=WNDuIPvjuiv1VdTFhlWFLweTVVPgBsw2pUB1O0BQSS4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S0+6vj/4qvHUY4BdpUwZTyJc9+PYgcQyRB99Y3dNdxS0oOrZig9Pxvx7iVfVLLdLvvmskg9roAFeySU4gJbY3Z+Jf1l2wlnrMBzZUtZlf9tOPTrm71zHb6NsWXsowr+Z52FGJK4fOC2FCft6bwWzp56bdkLIeCD2GXU3T30XXsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4152HSL303002743, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4152HSL303002743
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 10:17:28 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Mon, 5 Feb 2024 10:17:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 10:17:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Mon, 5 Feb 2024 10:17:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fiona Klute <fiona.klute@gmx.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Pavel Machek
	<pavel@ucw.cz>,
        =?iso-8859-2?Q?Ond=F8ej_Jirman?= <megi@xff.cz>
Subject: RE: [PATCH 2/9] wifi: rtw88: Debug output for rtw8723x EFUSE
Thread-Topic: [PATCH 2/9] wifi: rtw88: Debug output for rtw8723x EFUSE
Thread-Index: AQHaVdDuc4Tx2NyUOkComV3+akm5JLD7AKug
Date: Mon, 5 Feb 2024 02:17:27 +0000
Message-ID: <40d7f3f551254cb8b3cdfcba25052550@realtek.com>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
 <20240202121050.977223-3-fiona.klute@gmx.de>
In-Reply-To: <20240202121050.977223-3-fiona.klute@gmx.de>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback



> -----Original Message-----
> From: Fiona Klute <fiona.klute@gmx.de>
> Sent: Friday, February 2, 2024 8:11 PM
> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; =
linux-mmc@vger.kernel.org; Pavel
> Machek <pavel@ucw.cz>; Ond=F8ej Jirman <megi@xff.cz>; Fiona Klute <fiona.=
klute@gmx.de>
> Subject: [PATCH 2/9] wifi: rtw88: Debug output for rtw8723x EFUSE
>=20
> Some 8703b chips contain invalid EFUSE data, getting detailed
> information is critical when analyzing issues caused by that.
>=20
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> ---
> The TX power table debug output function (rtw8723x_debug_txpwr_limit)
> isn't specific to the chip family. Should I move it to debug.c
> (e.g. as rtw_debug_txpwr_limit_2g)?

I think no need. My another thinking is to add an debugfs entry to read
these stuff out, but if failed to probe we can't get these information.=20

>=20
>  drivers/net/wireless/realtek/rtw88/rtw8723x.c | 159 ++++++++++++++++++
>  drivers/net/wireless/realtek/rtw88/rtw8723x.h |  11 ++
>  2 files changed, 170 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.c
> b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
> index 2b58064547..bca650c6bb 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8723x.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
> @@ -63,6 +63,163 @@ static void __rtw8723x_lck(struct rtw_dev *rtwdev)
>                 rtw_write8(rtwdev, REG_TXPAUSE, 0x00);
>  }
>=20
> +#define DBG_EFUSE_VAL(map, name)                        \

I think we should not hide 'rtwdev'

> +       rtw_dbg(rtwdev, RTW_DBG_EFUSE, # name "=3D0x%x\n", \
> +               (map)->name)
> +#define DBG_EFUSE_2BYTE(map, name)                        \
> +       rtw_dbg(rtwdev, RTW_DBG_EFUSE, # name "=3D0x%x%x\n", \

Should format be '%02x%02x' for two bytes?

> +               (map)->name[0], (map)->name[1])
> +
> +static void rtw8723xe_efuse_debug(struct rtw_dev *rtwdev,
> +                                 struct rtw8723x_efuse *map)
> +{
> +       rtw_dbg(rtwdev, RTW_DBG_EFUSE, "mac_addr=3D%pM\n", map->e.mac_add=
r);
> +       DBG_EFUSE_2BYTE(map, e.vendor_id);
> +       DBG_EFUSE_2BYTE(map, e.device_id);
> +       DBG_EFUSE_2BYTE(map, e.sub_vendor_id);
> +       DBG_EFUSE_2BYTE(map, e.sub_device_id);
> +}
> +
> +static void rtw8723xu_efuse_debug(struct rtw_dev *rtwdev,
> +                                 struct rtw8723x_efuse *map)
> +{
> +       DBG_EFUSE_2BYTE(map, u.vendor_id);
> +       DBG_EFUSE_2BYTE(map, u.product_id);
> +       DBG_EFUSE_VAL(map, u.usb_option);
> +       rtw_dbg(rtwdev, RTW_DBG_EFUSE, "mac_addr=3D%pM\n", map->u.mac_add=
r);

Just curious why 'mac_addr' is the first one in rtw8723xe_efuse_debug(), bu=
t
the last one here?


> +}
> +

[...]



