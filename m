Return-Path: <linux-wireless+bounces-25235-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076E8B01015
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 02:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CE73ADD2B
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 00:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2175238B;
	Fri, 11 Jul 2025 00:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="SZ/CMihG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEEA376;
	Fri, 11 Jul 2025 00:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752192708; cv=none; b=BeEM0MRsmZlD+tlQnxmj/aWK53xNS4VC97mlez4YqxqfLmN0Rqhukr5tEuB4+byY6fwXrgYVyV94SnRakrJ96SdYMijlyFCLxbelY1TWIIYuF3QTfboJeIbvZFCIN4FH6takn2/4Ck4qXR3SXmNEztniUwl5NElpPej5Z5OsvZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752192708; c=relaxed/simple;
	bh=TQIIfmNqxEhvyQXhWM7U1p5Dnqt020Pcf3TSAkgN6z4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g7+Lx7bPSwHRW65t5gsO12uvc8gDD9n0DypS7XBXy5OR/zlK4/t9eRgA8kmf0eQFLHScaYXSBp1f4sVAl0vrQLaklkcKCHogKI9Z1MuFWIsQPny1PJuqdEGqbOukLtBoIDLD3bHsnTRYGlbjk7p3YQ3Bou1NMespgQWnGJh9vSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=SZ/CMihG; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56B0BLsL43966558, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752192681; bh=JGO2QeMwptWkrM8L6r9tZyPNhODydfWglgaJITahPPA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=SZ/CMihGmOMSbHsFEsDHJiLdIV1/WYNoDuaBBsvd7CwlWqqtdLA78NG8UBZ653bJg
	 UYZ++mquV77LyNINs/dTevy9vDDr1Dkc7zpdFVsfqXq+FKasNUuIQFBqjPsb8bpiEq
	 K6Nw7KU2EoXW/7JzQPe/EIyD0xGO28gma0wuZ6oZYrGxtxVe2PvEjo1cVSpik5yM5U
	 g7RboMEhA/vTesBflPA8n2kKusW591SasWxawhAWQna7jggJHLCttfG6wEXfrk2d6u
	 sBfd7to0ScOh75DXCezn5NbYJbT3XoIYAlcGIxWdJLWaCJRB7vwXSpdvGEL6zworLm
	 JJ3QR/U0NTbow==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56B0BLsL43966558
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 08:11:21 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 11 Jul 2025 08:11:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 11 Jul 2025 08:11:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Fri, 11 Jul 2025 08:11:21 +0800
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
Subject: RE: [PATCH v3] wifi: rtw88: enable TX reports for the management queue
Thread-Topic: [PATCH v3] wifi: rtw88: enable TX reports for the management
 queue
Thread-Index: AQHb8enPOUIDreW220yczxSl7U1tKbQsC/OA
Date: Fri, 11 Jul 2025 00:11:21 +0000
Message-ID: <7e7a3532816b48ef94c18e735a0f7a3f@realtek.com>
References: <20250710222432.3088622-1-andrej.skvortzov@gmail.com>
In-Reply-To: <20250710222432.3088622-1-andrej.skvortzov@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> This is needed for AP mode. Otherwise client sees the network, but
> can't connect to it.
>=20
> REG_FWHW_TXQ_CTRL+1 is set to WLAN_TXQ_RPT_EN (0x1F) in common mac
> init function (__rtw8723x_mac_init), but the value was overwritten
> from mac table later.
>=20
> Tables with register values for phy parameters initialization are
> copied from vendor driver usually. When table will be regenerated,
> manual modifications to it may be lost. To avoid regressions in this
> case new callback mac_postinit is introduced, that is called after
> parameters from table are set.
>=20
> Tested on rtl8723cs, that reuses rtw8703b driver.
>=20
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---
>=20
> Changes in v2:
>  - introduce mac_postinit callback to avoid changing register tables
>=20
> Changes in v3:
>  - merge two patches back together
>  - remove unused initialization in rtw_mac_postinit
>  - init unused .mac_postinit fields in drivers with NULL
>=20
>  drivers/net/wireless/realtek/rtw88/mac.c      | 11 +++++++++++
>  drivers/net/wireless/realtek/rtw88/mac.h      |  1 +
>  drivers/net/wireless/realtek/rtw88/main.c     |  6 ++++++
>  drivers/net/wireless/realtek/rtw88/main.h     |  1 +
>  drivers/net/wireless/realtek/rtw88/rtw8703b.c |  1 +
>  drivers/net/wireless/realtek/rtw88/rtw8723d.c |  1 +
>  drivers/net/wireless/realtek/rtw88/rtw8723x.c |  9 ++++++++-
>  drivers/net/wireless/realtek/rtw88/rtw8723x.h |  6 ++++++
>  drivers/net/wireless/realtek/rtw88/rtw8812a.c |  1 +
>  drivers/net/wireless/realtek/rtw88/rtw8814a.c |  1 +
>  drivers/net/wireless/realtek/rtw88/rtw8821a.c |  1 +
>  drivers/net/wireless/realtek/rtw88/rtw8821c.c |  1 +
>  drivers/net/wireless/realtek/rtw88/rtw8822b.c |  1 +
>  drivers/net/wireless/realtek/rtw88/rtw8822c.c |  1 +
>  14 files changed, 41 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wirel=
ess/realtek/rtw88/mac.c
> index 011b81c82f3ba..e1ec9aa401fa0 100644
> --- a/drivers/net/wireless/realtek/rtw88/mac.c
> +++ b/drivers/net/wireless/realtek/rtw88/mac.c
> @@ -1409,3 +1409,14 @@ int rtw_mac_init(struct rtw_dev *rtwdev)
>=20
>         return 0;
>  }
> +
> +int rtw_mac_postinit(struct rtw_dev *rtwdev)
> +{
> +       const struct rtw_chip_info *chip =3D rtwdev->chip;
> +       int ret;
> +
> +       if (chip->ops->mac_postinit)
> +               ret =3D chip->ops->mac_postinit(rtwdev);
> +

'ret' is not used [1].

Prefer:

if (!chip->ops->mac_postinit)
    return 0;

return chip->ops->mac_postinit(rtwdev);

[1] http://wifibot.sipsolutions.net/results/981272/14152513/build_clang/std=
err

> +       return 0;
> +}

[...]


