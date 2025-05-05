Return-Path: <linux-wireless+bounces-22417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D7FAA8A66
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 02:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9938D1726B1
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 00:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8C92AD16;
	Mon,  5 May 2025 00:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dbGswGSO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95232A944
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 00:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746405271; cv=none; b=FNHh8+QA48PKvN6iBkoD+YMusY8V6c/vIj+EerSm0UjScOatNRRmHwGBQFsLrDduS9DFwMEzRyfMxKbs4TQJOqIFdEc84hHuH8f0g7VlNWA13b49G5d5H5wMi20dlN9Ijmj9yVC3Y4fxSup1J6pBz7IJJeTHEkv8y7bnpN5zuN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746405271; c=relaxed/simple;
	bh=yK7fievSpJ8DYmHPrD9ih7cdqMn8lW1yS5B6SEkl0uQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JIW3YSbwF8L5f8my96o3yueBhAgMom5C1xXuRUZn0t5XkL2rwlzv4rjv0w20M+pOm4nXSG/nxchy8jZiS4Vf/iS48vJdURwFntzLlRFpcWaD8f8nEa5z3+b8s+OSYaR7tWr/KRT8+SZzVt0zM2s0x4tB1g7jDXfTf5dXIq6gJsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dbGswGSO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5450YMWh83281679, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746405263; bh=yK7fievSpJ8DYmHPrD9ih7cdqMn8lW1yS5B6SEkl0uQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dbGswGSOAdTY30isAZ2coFlmJD1R/Ax0FUN49ghmfQE/lkXwN99RU/MHkln30ZNK+
	 ReWWGnQ74QABj4XjG2TDf0i+epNtcayRrMz3P93nZkPZbkr7fAgNwSjBpvx+SCqKha
	 HTlr2VB6nDUYEVrnD9zXRHXq1HyljHO1rvATpPX8s2D0D/Kf5YoNlWRGw7tKw7Z7Ua
	 bVgsFuhyFR9TyxZm04CKQmxZG7PDWIkbb8McoeZbRBBrCp3Ifo/l1pP43n7BF6d9et
	 cYQYpZwDZe3xPYYekWFD44OcXw/4duNTg6GCjkL74T8bSAbeHzHuebhekSbz5WRhMp
	 SZvtLiea6NxaQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5450YMWh83281679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 May 2025 08:34:23 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 08:34:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 May 2025 08:34:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 5 May 2025 08:34:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Yuuki NAGAO <wf.yn386@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] wifi:rtw88:rtw8822bu VID/PID for BUFFALO WI-U2-866DM
Thread-Topic: [PATCH v2] wifi:rtw88:rtw8822bu VID/PID for BUFFALO WI-U2-866DM
Thread-Index: AQHbu8Lf4URMlhWg0kuofo87RowCu7PDMqvg
Date: Mon, 5 May 2025 00:34:21 +0000
Message-ID: <deb6f384a0bf4f96b2c3092fd7f767e1@realtek.com>
References: <CA+Tmi=P0kFARoU3yrbMTOBhXz=1Q8MoroaSNbQDw_NZye6r60A@mail.gmail.com>
 <20250503003227.6673-1-wf.yn386@gmail.com>
In-Reply-To: <20250503003227.6673-1-wf.yn386@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

Yuuki NAGAO <wf.yn386@gmail.com> wrote:
>=20
> Add VID/PID 0411/03d1 for recently released
> BUFFALO WI-U2-866DM USB WiFi adapter.
>=20
> Signed-off-by: Yuuki NAGAO <wf.yn386@gmail.com>

For the subject, need spaces after "wifi:" and "rtw88:".
I can add spaces when I merge.

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
> Changes since v1:
> - Fixed malformed patch.
> ---
> ---
>  drivers/net/wireless/realtek/rtw88/rtw8822bu.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
> b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
> index 572d1f31832e..ab50b3c40562 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822bu.c
> @@ -77,6 +77,8 @@ static const struct usb_device_id rtw_8822bu_id_table[]=
 =3D {
>           .driver_info =3D (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* Merc=
usys MA30N */
>         { USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3322, 0xff, 0xff, 0xff)=
,
>           .driver_info =3D (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* D-Li=
nk DWA-T185 rev. A1 */
> +       { USB_DEVICE_AND_INTERFACE_INFO(0x0411, 0x03d1, 0xff, 0xff, 0xff)=
,
> +         .driver_info =3D (kernel_ulong_t)&(rtw8822b_hw_spec) }, /* BUFF=
ALO WI-U2-866DM */
>         {},
>  };
>  MODULE_DEVICE_TABLE(usb, rtw_8822bu_id_table);
> --
> 2.43.0


