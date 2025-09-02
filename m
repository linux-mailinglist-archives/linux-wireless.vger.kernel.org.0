Return-Path: <linux-wireless+bounces-26920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA74B3F3BB
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 06:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0959C3A501A
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 04:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895AD146D45;
	Tue,  2 Sep 2025 04:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="SQ23w13f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A636032F761
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 04:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756787183; cv=none; b=oKk4lDFE/hhxYKa4tdEXX9K3XW9Fi70r81hR8zBGGq3/XoG7yVUxKSSeH6as/PxuF9k5RyrpbU9IsxK5xXU+daVPdx+TWbBJirtCPzGiqI9nGovvgixenFpn2FHrMjvx24QlXF+6mv8cvhxcOf84beqMLpuauC+W8vYXH1msVDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756787183; c=relaxed/simple;
	bh=Jncw5tZINqonnSUIVMS7CJV08ZYRpKRXUjBlY5aZ80M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aSS7tsntAr/RTO459Lcq8DTkRay5bLxRbsRKD/Qnky+N3N5dFd1ty1DjyqXDkJZKr7Y7X0p98udYN5yaDEX37IjpiGXeyiTLWupc2zN6xxlQwaMkeGGcyP+hc6FKW0D+a2J5KZxOMSxQKrgiDy3olta8FFuINBpPsoYriCx2Qu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=SQ23w13f; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5824QHDk82686220, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756787177; bh=dg/0BELTweDxvtiBIhvRTpVjfchYlKy+aNqKDLpMAVE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=SQ23w13ffGEwgwvl2eKWe/qPQNdvdkrrjhPeVk8tuRH9rEW6+NYcjbrNhaADpWHEH
	 YedrUcp7qpRiWEq7MS/Bt+JUVptWYW+YZN5Yb7VKlw9rkEHKVQv2r7YH+QxdKv5dCF
	 8Yyb3HWsfzyVEUHa/fZkSRGWVhoEguU1hb36m0KPOVrJMkcAmbZAHK1juK1rVKEXI0
	 zMJ6sQQOHRkH3txB7Y86JljxUs82JK95Eo0DCVQ/mKWTW5O14y2ocy15KkMGh1e8Dm
	 MownUS4VnBDGQZNo+WA/cfJk/Oo9Q6+M/qZZoyj+FivxyZBx9JeHqbhkghjFK7X2Ul
	 83mUgFY+OXCog==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5824QHDk82686220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Sep 2025 12:26:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 2 Sep 2025 12:26:16 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 2 Sep 2025 12:26:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>
CC: "usbwifi2024@gmail.com" <usbwifi2024@gmail.com>
Subject: RE: [PATCH rtw-next v2] wifi: rtw89: Add USB ID 2001:332a for D-Link AX9U rev. A1
Thread-Topic: [PATCH rtw-next v2] wifi: rtw89: Add USB ID 2001:332a for D-Link
 AX9U rev. A1
Thread-Index: AQHcG73MlcoLYYzdbU2MZAMOKfZZn7R/S9Qw
Date: Tue, 2 Sep 2025 04:26:16 +0000
Message-ID: <1369e3a263734c9783fd4677013ff3e5@realtek.com>
References: <20250902035755.1969530-1-zenmchen@gmail.com>
In-Reply-To: <20250902035755.1969530-1-zenmchen@gmail.com>
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

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
> v2:
>  - Sort the VID/PID by alphanumeric order

Thanks for the prompt fix.=20

> ---
>  drivers/net/wireless/realtek/rtw89/rtw8851bu.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
> b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
> index c3722547c..04e1ab13b 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8851bu.c
> @@ -16,6 +16,9 @@ static const struct rtw89_driver_info rtw89_8851bu_info=
 =3D {
>  static const struct usb_device_id rtw_8851bu_id_table[] =3D {
>         { USB_DEVICE_AND_INTERFACE_INFO(0x0bda, 0xb851, 0xff, 0xff, 0xff)=
,
>           .driver_info =3D (kernel_ulong_t)&rtw89_8851bu_info },
> +       /* D-Link AX9U rev. A1 */
> +       { USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x332a, 0xff, 0xff, 0xff)=
,
> +         .driver_info =3D (kernel_ulong_t)&rtw89_8851bu_info },
>         /* TP-Link Archer TX10UB Nano */
>         { USB_DEVICE_AND_INTERFACE_INFO(0x3625, 0x010b, 0xff, 0xff, 0xff)=
,
>           .driver_info =3D (kernel_ulong_t)&rtw89_8851bu_info },
> --
> 2.51.0


