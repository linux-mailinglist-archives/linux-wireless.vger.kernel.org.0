Return-Path: <linux-wireless+bounces-18739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9242A30325
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 06:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22D017A4000
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 05:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824491E3DC8;
	Tue, 11 Feb 2025 05:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GuglRDK7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A021E8823
	for <linux-wireless@vger.kernel.org>; Tue, 11 Feb 2025 05:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739253579; cv=none; b=JghMxFZ6p+ZMNHo4T3JdEANyEkQFGx2qYJNBQq0MW+Ou3ZdUx49dZE1VqqZrSKYozWbw6wpxvbdy5x+b+CTAvAkcTtq7Czw3L9Im7OfXmsvmKdKvFvWSsyZIYPZEjQp0Ze80kQlE9Us/ARrYokSe9ZiQ3McBcjIfIOGcSzTLY8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739253579; c=relaxed/simple;
	bh=boQEDTV9CNhHhm4BpsQ9Lt/4KesZO3CRgan8LwB8UT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=co8kqbzdrp/V2XzVEUDe6XJWorSpg6HTll7RS5HkolTfqtIC5LyMT5ZUIMx1Tmyp5gGWCRG5kzC6uG8/l0QJw1neDzlvyNjYu5l2Z3Iw05GbDvY5Q8dc0nHprn7kdEPYbJYg0fBES5CWSfMbnZV2nCTMwR3wgQl+TYpjCWI8Vso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GuglRDK7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51B5xU9A14049110, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739253570; bh=boQEDTV9CNhHhm4BpsQ9Lt/4KesZO3CRgan8LwB8UT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GuglRDK73bmsPdxjrcFYe00XOG/H1YjGtk6OZEewtbYjNWi19QZtyYTg75VMbY/QM
	 KjFy4VTSBzZQKCzfnb6z+oQ+mOkk+khoqjFf7iob0Y70U19sxLnrbmWjnHOSeBJrCa
	 2XtdQVO+1WYAEWZfFnDC8d2j1gEMvUIhoo/W08G5qvoyF8jTz8+Aa1AWepRiD6dR5I
	 U5eXdurwnvGBUcVEgRg0XMKHVUqFPu64cG6KanD1zMzJv8fwd/3CQCopgZpk6sogvm
	 SxSVnpfzGq/t1aLyuiAQ9/HvklwIphUGJHrcHKqlGckjDC/djmKGplAkB4EWDigmQ7
	 qSKC7u8K83BPQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51B5xU9A14049110
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 13:59:30 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Feb 2025 13:59:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 11 Feb 2025 13:59:30 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Tue, 11 Feb 2025 13:59:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH] wifi: rtw88: Add support for Mercusys MA30N and D-Link DWA-T185 rev. A1
Thread-Topic: [PATCH] wifi: rtw88: Add support for Mercusys MA30N and D-Link
 DWA-T185 rev. A1
Thread-Index: AQHbe455GovrMsKY002rA8aWeyvE1bNBm+8w
Date: Tue, 11 Feb 2025 05:59:30 +0000
Message-ID: <1f46070899bf4ddaa7b668a1f96b85ed@realtek.com>
References: <20250210073610.4174-1-zenmchen@gmail.com>
In-Reply-To: <20250210073610.4174-1-zenmchen@gmail.com>
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

Zenm Chen <zenmchen@gmail.com> wrote:
> Add two more USB IDs found in
> https://github.com/RinCat/RTL88x2BU-Linux-Driver
> to support Mercusys MA30N and D-Link DWA-T185 rev. A1.
>=20
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
> Related discussions:
> https://github.com/RinCat/RTL88x2BU-Linux-Driver/issues/237
> https://github.com/RinCat/RTL88x2BU-Linux-Driver/issues/146
> ---
>  drivers/net/wireless/realtek/rtw88/rtw8822bu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
> b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
> index 8883300fc6ad..572d1f31832e 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
> @@ -73,6 +73,10 @@ static const struct usb_device_id rtw_8822bu_id_table[=
] =3D {
>           .driver_info =3D (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* ELEC=
OM WDB-867DU3S */
>         { USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x0107, 0xff, 0xff, 0xff)=
,
>           .driver_info =3D (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* Merc=
usys MA30H */
> +       { USB_DEVICE_AND_INTERFACE_INFO(0x2c4e, 0x010a, 0xff, 0xff, 0xff)=
,
> +         .driver_info =3D (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* Merc=
usys MA30N */
> +       { USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3322, 0xff, 0xff, 0xff)=
,
> +         .driver_info =3D (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* D-Li=
nk DWA-T185 rev. A1 */

By the way, these IDs aren't in increasing order, how did you pick IDs
from vendor driver?

Not sure if it's worth to sort these IDs so that it would be easier to
align IDs with vendor driver (it should be sorted as well).=20



