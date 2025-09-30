Return-Path: <linux-wireless+bounces-27733-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31640BABF15
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 09:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34B619266DF
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 08:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5530B22B5AC;
	Tue, 30 Sep 2025 07:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HWJQDITY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD7A189B80;
	Tue, 30 Sep 2025 07:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759219188; cv=none; b=KD/kOjz9GWsBdEaXh9lD6uZuTosNJqAIRhPcbBU4k8A0GU8YfXsK0Ek3RSJW6mkcQvM7w7aEHLJ6IGulLH09GfT6DqtJO1TxZebU8ZoblNdNUhA3qoL/6WdySA3k/iLgnUSeKNzVgruYvYHV1RbS7p1qYpkI+1nYRff5zIz+OF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759219188; c=relaxed/simple;
	bh=KxVWZlKGEdX0BFcT+W8new4feZRmllZCk4QiolejEpg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A7L7F0jM6q2TJJmMVnO3zpsjoMj/IpwwmwO9h//KkXt1Y2TbNaLiXtjK+jsTNf6M1xVSg+5L80Nkxnr40F3mQ+2oKBHWR3QCsvOH2xbiwG8V91x4MeeP7PVb/upamsvkl2vpZX1YdiEry1k3B7NV77iiP7Eqf2xuqN4I0vxEeAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HWJQDITY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58U7xgJ13730265, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1759219182; bh=tRXtgh81FcBzXNeymsjjMSw4q708tnvVa1rtN35qpqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=HWJQDITY9IdwALqhYFqf8B/5b/13DVv23hTZBL4dFHuF323z/qxXUNrQ/8vX0XPck
	 5iWE5AkICr4s4pPM0B33dcfnGy0BSdICGeAgwuMwx9hES1D6L6GM3xPJaL/vdBOpF4
	 8HRvnYt8s9BXPcvjD6trkvr92fC8x07x1Wtv2iJ1xkivpGYS6GKy/Y+NKd08dC50so
	 gofPvc/FLFhAGBVYO7HG0T8lu5ZtB7YqAa6AbZ6SztxK99zguqavql7D5kl7ncWzS9
	 jWQlBrQbKrie5GH0qxk7xhbjv6ZSCgif2SmFXJQ3fZITxgdzrVvmCScafEajwzlWzK
	 UxssnZQ2Zesog==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58U7xgJ13730265
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 15:59:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 30 Sep 2025 15:59:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 30 Sep 2025 15:59:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: Add USB ID 2001:3329 for D-Link AC13U rev. A1
Thread-Topic: [PATCH rtw-next] wifi: rtw88: Add USB ID 2001:3329 for D-Link
 AC13U rev. A1
Thread-Index: AQHcMPU5hCUM159tz0WqTXkJwzs92rSrXlFA
Date: Tue, 30 Sep 2025 07:59:42 +0000
Message-ID: <39b7c458b22e45f28edc54c62e571431@realtek.com>
References: <20250929035719.6172-1-zenmchen@gmail.com>
 <20250929035719.6172-2-zenmchen@gmail.com>
In-Reply-To: <20250929035719.6172-2-zenmchen@gmail.com>
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
> Add USB ID 2001:3329 for D-Link AC13U rev. A1 which is a RTL8812CU-based
> Wi-Fi adapter.
>=20
> Compile tested only.
>=20
> Cc: stable@vger.kernel.org # 6.6.x
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
> Link to the Windows driver for D-Link AC13U rev. A1
>=20
> https://support.dlink.com/ProductInfo.aspx?m=3DAC13U
> ---
>  drivers/net/wireless/realtek/rtw88/rtw8822cu.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822cu.c
> b/drivers/net/wireless/realtek/rtw88/rtw8822cu.c
> index 324fd5c8b..755f76840 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8822cu.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822cu.c
> @@ -21,6 +21,8 @@ static const struct usb_device_id rtw_8822cu_id_table[]=
 =3D {
>           .driver_info =3D (kernel_ulong_t)&(rtw8822c_hw_spec) },
>         { USB_DEVICE_AND_INTERFACE_INFO(0x13b1, 0x0043, 0xff, 0xff, 0xff)=
,
>           .driver_info =3D (kernel_ulong_t)&(rtw8822c_hw_spec) }, /* Alph=
a - Alpha */
> +       { USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3329, 0xff, 0xff, 0xff)=
,
> +         .driver_info =3D (kernel_ulong_t)&(rtw8822c_hw_spec) }, /* D-Li=
nk AC13U rev. A1 */
>         {},
>  };
>  MODULE_DEVICE_TABLE(usb, rtw_8822cu_id_table);
> --
> 2.51.0


