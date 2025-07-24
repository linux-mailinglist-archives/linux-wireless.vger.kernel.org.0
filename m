Return-Path: <linux-wireless+bounces-25986-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6956B10575
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 11:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280751CC449B
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 09:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CFE24BBEE;
	Thu, 24 Jul 2025 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="dOYspMuB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E072C24A069
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348508; cv=none; b=ju9tq+hLYo8PlusUNeYnEXFVzNNem/4KTKrN4ubte76gIWNx0I7waiU0vf05nTEOoHWuEt8GWDtFBD8rN/aUtXeg1VGEfrhZHiQL4IhRcRpTOj2GjxiUmeyKqyKOf7K6LdTwo2ZpJ4GDiE0IAoWOHi0ExWZ+1Bspyu3ssV7VZLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348508; c=relaxed/simple;
	bh=b/ep7UWfV3lLN5VnUWWEIzluGbCSu2i3ogT1AMGivO8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZEf99ybj+G1JaDNYYH8AlYy9i4RVfNpRQpDuJyevku3CSC2LXDUFdl8qgB1zbZdm+2D44lOKV5StpFKgtwL/9WORZY52+JURnPrfann9Wyh1tFAp80x5aJhgaV+dl8pid5q5PJizGRkbRp6O3K7uuIbvS4LbiyGF01h9hwKmXyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dOYspMuB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56O9F1sA4216968, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753348501; bh=xDjXZmYoMGAWWficpkEAxQdA4+wuPypmTBxPqfSFKPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=dOYspMuB7TMma9afOIGr2gfkY3/sQmrBE7mqhbEr7K9v+RYfiYN+VA0kI44RgI8J9
	 kAnMUcWKg6sQIWnssw/2k1crJ6AZSB5n00gH1uQU/5VmedNWSToI7g3WeCnrxnxEqd
	 A+Ynm3kkqcLUeVGJGM+OrHeNpHlEyNYwTfsN8IUkom4LDgiwx9Rnxt0LcnEJy8STEy
	 DVTQdE6OuhkN1r6lQwuEMlGy4ZFmWtT8PDV4DDXFAy9hupbZF2kTmV7lDg3ecI9rcz
	 szEr6YV6JwUK53Q8WdHUuE16NQhjp1g9x4z2mXe+YZ+UJ8ctJjd/BodEPFrustZ3p3
	 WVuQVDfSis2qQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56O9F1sA4216968
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 17:15:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Jul 2025 17:15:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 24 Jul 2025 17:14:59 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Thu, 24 Jul 2025 17:14:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "piotr.oniszczuk@gmail.com" <piotr.oniszczuk@gmail.com>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
Subject: RE: [PATCH rtw-next] wifi: rtw88: sdio: use indirect IO for device registers before power-on
Thread-Topic: [PATCH rtw-next] wifi: rtw88: sdio: use indirect IO for device
 registers before power-on
Thread-Index: AQHb/DS8S6Z9LuNHSkqUfz4BHLn6GLRA/c+A
Date: Thu, 24 Jul 2025 09:14:59 +0000
Message-ID: <64c55860acf04b00a4dac49acb9012db@realtek.com>
References: <20250724004815.7043-1-pkshih@realtek.com>
In-Reply-To: <20250724004815.7043-1-pkshih@realtek.com>
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

Ping-Ke Shih <pkshih@realtek.com> wrote:
> The register REG_SYS_CFG1 is used to determine chip basic information
> as arguments of following flows, such as download firmware and load PHY
> parameters, so driver read the value early (before power-on).
>=20
> However, the direct IO is disallowed before power-on, or it causes wrong
> values, which driver recognizes a chip as a wrong type RF_1T1R, but
> actually RF_2T2R, causing driver warns:
>=20
>   rtw88_8822cs mmc1:0001:1: unsupported rf path (1)
>=20
> Fix it by using indirect IO before power-on.
>=20
> Reported-by: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
> Closes: https://lore.kernel.org/linux-wireless/699C22B4-A3E3-4206-97D0-22=
AB3348EBF6@gmail.com/T/#t
> Suggested-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Pick from [1] & remove mailto:

Tested-by: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>

[1] https://lore.kernel.org/linux-wireless/699C22B4-A3E3-4206-97D0-22AB3348=
EBF6@gmail.com/T/#m5af73c4f7f35f16071392f395ebec10e36d39128

> ---
>  drivers/net/wireless/realtek/rtw88/sdio.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/sdio.c b/drivers/net/wire=
less/realtek/rtw88/sdio.c
> index cc2d4fef3587..99d7c629eac6 100644
> --- a/drivers/net/wireless/realtek/rtw88/sdio.c
> +++ b/drivers/net/wireless/realtek/rtw88/sdio.c
> @@ -144,6 +144,10 @@ static u32 rtw_sdio_to_io_address(struct rtw_dev *rt=
wdev, u32 addr,
>=20
>  static bool rtw_sdio_use_direct_io(struct rtw_dev *rtwdev, u32 addr)
>  {
> +	if (!test_bit(RTW_FLAG_POWERON, rtwdev->flags) &&
> +	    !rtw_sdio_is_bus_addr(addr))
> +		return false;
> +
>  	return !rtw_sdio_is_sdio30_supported(rtwdev) ||
>  		rtw_sdio_is_bus_addr(addr);
>  }
> --
> 2.25.1
>=20


