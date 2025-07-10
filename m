Return-Path: <linux-wireless+bounces-25167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12ACAFF837
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 06:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E61A97ACFB8
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 04:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905E4285052;
	Thu, 10 Jul 2025 04:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="KUms6eQu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46D284B49;
	Thu, 10 Jul 2025 04:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752123032; cv=none; b=BPVvKJ6VAf7zmIppqB+C2KSJ6ttdFz/9mxwJSpea2/mQQQjEDv8o1nSKizHmIDAR5cZlppOYWrgk7Mic+9qoUf4BxEqhlWaa1YNFX4F+x24SZ4OsX09aYBbnbDdrefCFlQh4VM9m3g/WznHMNY/Xu/qmxGqpRKoN8H7ZVHb26OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752123032; c=relaxed/simple;
	bh=kZ/ylLXT2MeeVuB6IPYhBtZKr6OgXzwn7dgqQtMdadI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZsHsGjtW1WOMzdMt98gEhV93GTmY3/m8NVU+XAwegPhRNy0OKffmVxdMHatpboHDgdnP5aIoBPirCn5bUSvoyiu0yGUihs0I3LjxjRndZnUgWSsLImIIRdxNGKMDrHCRPeqMjMF2SN7kmNaFOa81JVCvGVFOaaf3+9VoEMNKLOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=KUms6eQu; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56A4oI2Q12476140, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752123018; bh=V63Xr5ofcbQFwfidC3iJF+xwR/ygrvqygGNwe7Mnt7E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=KUms6eQu7KskwO7hkvkdFhpoF0ovZlGM31Tk+iopOfsVxLGmSyuqOvT4ZA8FC/Q4m
	 IirLV8CqYMkXDEp5aZ9QePUYPRG33MiYo8WfdjMZt1UhtUS6PfyUhhtGR4B2QM5ngn
	 +X0+dS2kE9E3dhPXev9B91j1bBHl6vexy6Oo4iIDp+6w4MJdC5M4dKUY9MLCef3xy4
	 65ZATQ6hKtB2KVyZ/jeLsB0JEGzma51WHA/yoVI2i1660lURKgic1svD4YdcNImNXP
	 a5cTbmq5wb60RocVeh0hirn1Yx19WPvlIGvOR1QIMIyGPNufp+lL9giXFRg02aXoge
	 4wDb9vB5RhvOw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56A4oI2Q12476140
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 12:50:18 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Jul 2025 12:50:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 10 Jul 2025 12:50:17 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 10 Jul 2025 12:50:17 +0800
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
Subject: RE: [PATCH v2 2/2] wifi: rtw88: enable TX reports for the management queue
Thread-Topic: [PATCH v2 2/2] wifi: rtw88: enable TX reports for the management
 queue
Thread-Index: AQHb8SHZ/70ooBa4REOlYvaNTPCilLQqyRaw
Date: Thu, 10 Jul 2025 04:50:17 +0000
Message-ID: <65e152e2d7ea403eafeaff9e4817d29f@realtek.com>
References: <20250709223159.2787192-1-andrej.skvortzov@gmail.com>
 <20250709223159.2787192-3-andrej.skvortzov@gmail.com>
In-Reply-To: <20250709223159.2787192-3-andrej.skvortzov@gmail.com>
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
> from mac table later. mac_postinit is run after registers from mac
> table are set, this allows to set correct values.
>=20
> Tested on rtl8723cs, that reuses rtw8703b driver.
>=20
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtw88/rtw8703b.c | 1 +
>  drivers/net/wireless/realtek/rtw88/rtw8723d.c | 1 +
>  drivers/net/wireless/realtek/rtw88/rtw8723x.c | 9 ++++++++-
>  drivers/net/wireless/realtek/rtw88/rtw8723x.h | 6 ++++++
>  4 files changed, 16 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
> b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
> index 03475af973b52..821c28d9cb5d4 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
> @@ -1832,6 +1832,7 @@ static const struct rtw_chip_ops rtw8703b_ops =3D {
>         .power_on               =3D rtw_power_on,
>         .power_off              =3D rtw_power_off,
>         .mac_init               =3D rtw8723x_mac_init,
> +       .mac_postinit           =3D rtw8723x_mac_postinit,

If chips don't have this ops, please give them NULL to be clear that
we don't miss it.

Since these two patches are small, I don't mind to combine them together.
Make decision yourself.

By the way, please select rtw-next tree by [PATCH v3 rtw-next].

>         .dump_fw_crash          =3D NULL,
>         .shutdown               =3D NULL,
>         .read_efuse             =3D rtw8703b_read_efuse,

[...]


