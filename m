Return-Path: <linux-wireless+bounces-27722-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB51BAB24F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 05:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EE9D17E105
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 03:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1561E1A17;
	Tue, 30 Sep 2025 03:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Xw9OLlBL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FC8212556;
	Tue, 30 Sep 2025 03:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759202398; cv=none; b=T+G+PfRyNlg6O40d28EI/fZ49qabotESCaadnWmQWZoLFoA+BGhawzHFp5myBad5L4OyOIPb6/CUjK71lRSutB86YAj6xIMAau4GlmkhkmRtA5zNM51NT6l/AQ7IcnRNyaAaBLGpCcESt5nsccJ1ye5CFi8eQR/AbbdlNzvpxxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759202398; c=relaxed/simple;
	bh=nKXfEIuJI2N+x0hlIYifGuuwrZygUhSUtw9qDuQCMAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fQrlG/J49h4eo2w74pEO9HnNOAONYje+Vf6VtYHG4eboGxMs3lq2/FJ4RHM3KgPAZzbiAhYlj3MeZ4x4rfdCLDqGfLpfVxXgx60ykIpP35QedFZkGGZdTx+rypvsD9HygRhRgWADuqx2L9dvzvU2DY7vTmY+b6aXiK6VS9//2CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Xw9OLlBL; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58U3JoEI2352911, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1759202390; bh=AsAGURb4DGJeqftQtwaspgpBnuIrU1yiSAdVCHvOtng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Xw9OLlBLWaQ5CzBHjDEjEcH97coB49YMoZtzYSWtOOb6/IEOCGADQHGuq4wxiT1SU
	 ahHXjfLjqGhG9FUtopMZ2s8NqS2lrBxCa+i3UEU6B1Fl0deVOWPfIa7Myxt60V96ev
	 zEyUncCTnibtF+DNNZYOiglozYlq7sq16sQd2WD3VwfQW6IXitNSc+2olthjeqnpjm
	 aIPJkK/UEUX0QKaJu+V/NZznK1KhehxOaunyY8sWBQWrooPG67UiBiZLHktb1uLGuE
	 QxI8o6WjoQ7u/uXhPw6OTKOSrkjUXIsZuJH6EhtfOBY7LmS4b8yHHjil/fF9A3L6GY
	 IbZfY/Zwf5Ygw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58U3JoEI2352911
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 11:19:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 30 Sep 2025 11:19:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Tue, 30 Sep 2025 11:19:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Zenm Chen <zenmchen@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com"
	<rtl8821cerfe2@gmail.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtl8xxxu: Add USB ID 2001:3328 for D-Link AN3U rev. A1
Thread-Topic: [PATCH rtw-next] wifi: rtl8xxxu: Add USB ID 2001:3328 for D-Link
 AN3U rev. A1
Thread-Index: AQHcMPU4LFvfPiVdyEmxJ5atcfU8NbSrAmPg
Date: Tue, 30 Sep 2025 03:19:50 +0000
Message-ID: <62f767e17eaf428393cf79d55666a011@realtek.com>
References: <20250929035719.6172-1-zenmchen@gmail.com>
In-Reply-To: <20250929035719.6172-1-zenmchen@gmail.com>
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
> Add USB ID 2001:3328 for D-Link AN3U rev. A1 which is a RTL8192FU-based
> Wi-Fi adapter.
>=20
> Compile tested only.
>=20
> Cc: stable@vger.kernel.org # 6.6.x
> Signed-off-by: Zenm Chen <zenmchen@gmail.com>
> ---
> Link to the Windows driver for D-Link AN3U rev. A1
>=20
> https://www.dlinktw.com.tw/techsupport/ProductInfo.aspx?m=3DAN3U

Could you please enlighten me how you address this is RTL8192FU-based?
I downloaded the setup.ext and decompressed the file, but I can't find
8192FU.

> ---
>  drivers/net/wireless/realtek/rtl8xxxu/core.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> index 3ded59527..be39463bd 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/core.c
> @@ -8136,6 +8136,9 @@ static const struct usb_device_id dev_table[] =3D {
>  /* TP-Link TL-WN823N V2 */
>  {USB_DEVICE_AND_INTERFACE_INFO(0x2357, 0x0135, 0xff, 0xff, 0xff),
>         .driver_info =3D (unsigned long)&rtl8192fu_fops},
> +/* D-Link AN3U rev. A1 */
> +{USB_DEVICE_AND_INTERFACE_INFO(0x2001, 0x3328, 0xff, 0xff, 0xff),
> +       .driver_info =3D (unsigned long)&rtl8192fu_fops},
>  #ifdef CONFIG_RTL8XXXU_UNTESTED
>  /* Still supported by rtlwifi */
>  {USB_DEVICE_AND_INTERFACE_INFO(USB_VENDOR_ID_REALTEK, 0x8176, 0xff, 0xff=
, 0xff),
> --
> 2.51.0


