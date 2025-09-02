Return-Path: <linux-wireless+bounces-26916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD20B3F2AE
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 05:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECBF01A85A87
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 03:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4CA2E0B68;
	Tue,  2 Sep 2025 03:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="NO8UfPX7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A15D1EE7D5
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 03:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756783860; cv=none; b=fp+hLk1DYXIvICZnTCB4ihmLedb65sh9COWA18njVlfl08X6K8yc02v6mHBJAwQMvrgkcZlT7LqMk36WEEInfdk5S04g+q665Q7C6PuLr1hhyEOYwlo2ZJe/+3onsXPos8d9sFcOnfe2szbm5QIjo3j336FwZNgb3+WJY5fE4OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756783860; c=relaxed/simple;
	bh=Vhr5xACKAT7NBqQLJNIV7N+9977+IVfX8Rq/Wp8+znk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sant/GFMNee19c1b/wTHBwi1M4SwxyLUcaE9bmnJy8lqJuuuOCP+VFvhqyugp7/ptdNDyWrqLbJzdgM4XPR6dB4U/9GVaH5f9Q7IG8BPuWzN3Bjg9h35SDr736sQhM8yA3UNIrQdAz632fOrszYIykNkfvFlCF+sy/DCzxUP2Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=NO8UfPX7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5823UqosE2627210, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756783852; bh=s6cNtasxBIYPODRNFEsbjZ/bVcyW6mfsE3/9pfBqgws=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=NO8UfPX76L6ZUD5H1E2apjaCKoszQcxz/kDKtWJNBGUvfcqYuLUOsj8ZeHNyGzDDw
	 tZLQDARjiYV6blDAa2xQgFUY/K8LPyKoUZTiaQ630Ug5MkST+tUD2jkjF/pZD4Oi/x
	 ioBlc4U5tjx7j8Dm+QsF1iKngjJb1MFlPUC6U6Wkd/Fp+5s++k+wggWShPuWEUdw0E
	 /gJVnIaIZO5bGwvCEFcyhYN3Gk8kp6aE0+HzE/F2hCwozudHKD1G/4aU9OAXWNhZDK
	 jOixtsXQI7jKd06/zNS7/8A9OIIElfrBY5E7HQt6ML7q5K1Ry8t7Iw8Zxzcl9tJKuf
	 NCw3UnMkS1Rcw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5823UqosE2627210
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Sep 2025 11:30:52 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 2 Sep 2025 11:30:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 2 Sep 2025 11:30:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>
CC: "usbwifi2024@gmail.com" <usbwifi2024@gmail.com>
Subject: RE: [PATCH rtw-next] wifi: rtw89: Add USB ID 2001:332a for D-Link AX9U rev. A1
Thread-Topic: [PATCH rtw-next] wifi: rtw89: Add USB ID 2001:332a for D-Link
 AX9U rev. A1
Thread-Index: AQHcG7YGyKwASEp4dkiNQegfOxpydLR/O8BQ
Date: Tue, 2 Sep 2025 03:30:52 +0000
Message-ID: <26fa101f2f5240dfb3babbc7c2864e1c@realtek.com>
References: <20250902030207.1968706-1-zenmchen@gmail.com>
In-Reply-To: <20250902030207.1968706-1-zenmchen@gmail.com>
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
> Add USB ID 2001:332a for D-Link AX9U rev. A1 which is a RTL8851BU-based
> Wi-Fi adapter.
>=20
> Only managed mode and AP mode are tested and it works in both.
>=20
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> ---
> Although it works, but it disconnects occasionally and Bitterblue is work=
ing on it.
>=20
> https://github.com/morrownr/rtw89/issues/11

Thank you all for working on this.

> ---
>  drivers/net/wireless/realtek/rtw89/rtw8851bu.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
> b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
> index c3722547c..510d124a4 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
> @@ -19,6 +19,9 @@ static const struct usb_device_id rtw_8851bu_id_table[]=
 =3D {
>         /* TP-Link Archer TX10UB Nano */
>         { USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010b, 0xff, 0xff, 0xff)=
,
>           .driver_info =3D (kernel_ulong_t)&rtw89_8851bu_info },
> +       /* D-Link AX9U rev. A1 */
> +       { USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x332a, 0xff, 0xff, 0xff)=
,

What is the rule you put this entry here? Can they be in increasing order
of VID/PID?

> +         .driver_info =3D (kernel_ulong_t)&rtw89_8851bu_info },
>         /* Edimax EW-7611UXB */
>         { USB_DEVICE_AND_INTERFACE_INFO(0x7392, 0xe611, 0xff, 0xff, 0xff)=
,
>           .driver_info =3D (kernel_ulong_t)&rtw89_8851bu_info },
> --
> 2.51.0


