Return-Path: <linux-wireless+bounces-29507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB19CCA5C2F
	for <lists+linux-wireless@lfdr.de>; Fri, 05 Dec 2025 01:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9517130DD949
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Dec 2025 00:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42D6158857;
	Fri,  5 Dec 2025 00:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="SfDSAned"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A14DBA3F
	for <linux-wireless@vger.kernel.org>; Fri,  5 Dec 2025 00:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764895797; cv=none; b=EomPKxigsXMq4K5Ma/NVf9REUdHEWIztGnVdD/FTWwyrkAPYnhilRoFr+5gmZu+AmW0oC5qDA9ZbXTZsz3XRs3V3WqzdploQ+s/IEIq0RAzvqnz0BluOi8jAE25MmNwsMBJ0vSIlAv7TtlyrlOCVHedR/crMOSwaP4gZMRSlkVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764895797; c=relaxed/simple;
	bh=AnKI0afWdrMt7pW1fkRwZyzfYh0fcFzasCoAqNQtJ8Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SgisZwprwoEjAuPT7dWxu+uK7CjhGWeW/Y16UFoygJOpA9kJNYGMG6zOBJonlycbDOEkGVmagotHDA01lJ5dMLFs7nth2dySU8x+zSdKcDen9J+tkt3BVRMo0U8SbO07vaKojU6lovRcFnf/xtGTJ9pCpVSmeN5gZ4nh7gY8whA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=SfDSAned; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5B50nm9G31204034, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1764895788; bh=hxU2seBvNrtg0nRvte3b4aF7HmFUnQ9RUF73fMqvBkA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=SfDSAnedU3Ol1hidtcIzA8VMYXANxTz4p7M3Rxu9V7f3Loh36hAi3S2PplMPIFMFH
	 AJOnRf72LatV0bR59Wv90CHxmhn5LIULhe6whTv6rU0tPm3RAuNww9ivjl2sc6EqCp
	 CDP+YHzISh3771G5Q5IMpahaoTEQGjyoIGGjbRUWARUN9t7bc67Vw/rd6l2/zxqCXN
	 KgR3EQkM7JjJbou0sC0WlzuxAAaNa5eT+itsrqC8whxiD+T61xhp4kt6OgvFgIX0xU
	 lImuQz/7GE8R4n9oRknYqmiFuoo2Xmd4uLyztKRUNxxwUMiea1K+M3wZY/xX3Cht3m
	 2ov1NYxo2Wsxg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5B50nm9G31204034
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Dec 2025 08:49:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 5 Dec 2025 08:49:49 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 5 Dec 2025 08:49:49 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::2fa5:eccb:34ee:7bb%10]) with mapi id
 15.02.1544.027; Fri, 5 Dec 2025 08:49:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Hsiu-Ming Chang <cges30901@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH RESEND] wifi: rtw88: rtw8821cu: Add ID for Mercusys MU6H
Thread-Topic: [PATCH RESEND] wifi: rtw88: rtw8821cu: Add ID for Mercusys MU6H
Thread-Index: AQHcZX7BMFOXaWWo7E68t+p74epIbbUSNjsg
Date: Fri, 5 Dec 2025 00:49:48 +0000
Message-ID: <f0db83b1f3d94e33a1dccbad284c912e@realtek.com>
References: <20251205003245.5762-1-cges30901@gmail.com>
In-Reply-To: <20251205003245.5762-1-cges30901@gmail.com>
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

Hsiu-Ming Chang <cges30901@gmail.com> wrote:
> Add support for Mercusys MU6H AC650 High Gain Wireless Dual Band USB Adap=
ter
> V1.30. It is based on RTL8811CU, usb device ID is 2c4e:0105.
>=20
> Signed-off-by: Hsiu-Ming Chang <cges30901@gmail.com>

Not sure why you want to RESEND your patch? If you wonder I missed your
patch, check patchwork to see the status [1].

[1] https://patchwork.kernel.org/project/linux-wireless/patch/2025112210182=
9.18319-1-cges30901@gmail.com/

This looks good to me, so

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
>  drivers/net/wireless/realtek/rtw88/rtw8821cu.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
> b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
> index 7a0fffc35..8cd09d666 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8821cu.c
> @@ -37,6 +37,8 @@ static const struct usb_device_id rtw_8821cu_id_table[]=
 =3D {
>           .driver_info =3D (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Edim=
ax */
>         { USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xd811, 0xff, 0xff, 0xff)=
,
>           .driver_info =3D (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Edim=
ax */
> +       { USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0105, 0xff, 0xff, 0xff)=
,
> +         .driver_info =3D (kernel_ulong_t)&(rtw8821c_hw_spec) }, /* Merc=
usys */
>         {},
>  };
>  MODULE_DEVICE_TABLE(usb, rtw_8821cu_id_table);
> --
> 2.52.0


