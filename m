Return-Path: <linux-wireless+bounces-29683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AAC1CB7757
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 01:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 40F0F30021D4
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 00:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BA61FAC42;
	Fri, 12 Dec 2025 00:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="UFPtnwha"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97561F419F
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 00:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765499877; cv=none; b=K22mtlp6lwv+njMZQnHFZIWqWjylwOs6D17PdTs3EQH7EFcD1fe0j0gNzJX97DX2vZaihFsD+UzuSBEAndO1+FdY26AOoj42PiCcnTZCJJKa0SzE0qn4hDKD5mAWniNubByKDZ/vVJ4QuTiOc/N4nJFYD4Mba3GgfZiurldOvTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765499877; c=relaxed/simple;
	bh=hkz/FIWNxIP2CLhhmUGGzKL+WAH375PMkYraMx/9pkU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eK65ztd0o0Hgzj2O55dHq7jy5zRzieXAZrUYwGTK+uirSKXpmX9VtEXuUj17fszwqrfJCG57QvO///heNL3OYNMkZM0qwhqI4M02gbr39/XsDgcCScLWe0mny9pb08HuynknL8gdQkSjKN1TiEgvO6yeNNSOYVyZSD9zrpL56Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=UFPtnwha; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BC0bjvX73235206, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765499866; bh=m0jVQ7PvSkYq8eGzEkWOKu1SuqhH6re8aPzXjfyw4LY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=UFPtnwhaosOsbjTOqfbdwwy2oSIGGMFCbJXb7LjcIw2RwXc0qckJ6lGRGF+wXxuia
	 P4J17Ee69B7OHihh0zgA+K5sk7ayFkcaQRxxhP3ifB0ZiVpItdOoGMqYF7xBl2JkSb
	 HyjL8yAPSEdfT5QZrS6OK5KCAYGwS8CsWrfUTS8qQWcsU4xgRkvzrwrLGLtkgnDOV/
	 UZsvf20AJAqQUz4lisS33hHRLRS2yk5D7T9X8bhQOtCRSFtFqJ/F2QneLiJ64x3mmR
	 +Ze1zNAvxkcS7UBs/X9Vlq4R7TySr7vOPhPRddyXKs02sQKdprU4PYwrl0gyEkBC1W
	 TT8eAViz0KhAg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BC0bjvX73235206
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Dec 2025 08:37:46 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 12 Dec 2025 08:37:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 12 Dec 2025 08:37:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::2fa5:eccb:34ee:7bb%10]) with mapi id
 15.02.1544.027; Fri, 12 Dec 2025 08:37:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jan Gerber <j@mailb.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] Add support for TP TX30U Plus
Thread-Topic: [PATCH] Add support for TP TX30U Plus
Thread-Index: AQHcauOQHxs8lRr/MkO5jntZAIyByrUdKFrg
Date: Fri, 12 Dec 2025 00:37:44 +0000
Message-ID: <5b26cb7740894638b84fedfcad52ca03@realtek.com>
References: <20251211211707.2020656-1-j@mailb.org>
In-Reply-To: <20251211211707.2020656-1-j@mailb.org>
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

Jan Gerber <j@mailb.org> wrote:
> the device shows up like this and everything seams to work:
>=20
> Bus 004 Device 003: ID 3625:010d Realtek 802.11ax WLAN Adapter

Subject should be "wifi: rtw89: 8852au: add support for TP TX30U Plus"

Missed your s-o-b.

> ---
>  drivers/net/wireless/realtek/rtw89/rtw8852au.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852au.c
> b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
> index ca782469c..83a8321e8 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852au.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852au.c
> @@ -62,6 +62,8 @@ static const struct usb_device_id rtw_8852au_id_table[]=
 =3D {
>           .driver_info =3D (kernel_ulong_t)&rtw89_8852au_info },

To keep increasing order of device ID, move new entry here.

>         { USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010f, 0xff, 0xff, 0xff)=
,
>           .driver_info =3D (kernel_ulong_t)&rtw89_8852au_info },
> +       { USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010d, 0xff, 0xff, 0xff)=
,
> +         .driver_info =3D (kernel_ulong_t)&rtw89_8852au_info },
>         {},
>  };
>  MODULE_DEVICE_TABLE(usb, rtw_8852au_id_table);
> --
> 2.51.0
>=20


