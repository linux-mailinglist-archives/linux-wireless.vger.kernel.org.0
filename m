Return-Path: <linux-wireless+bounces-21598-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86278A8B452
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 10:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09BFE188DABC
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Apr 2025 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55E921E0AF;
	Wed, 16 Apr 2025 08:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="vSl3E5Lt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BFC21D594
	for <linux-wireless@vger.kernel.org>; Wed, 16 Apr 2025 08:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744793377; cv=none; b=mp59Q5WBwnTe9leC9LuAj+w5NFJuT43IICrMmOhIhb010AGjIHQe2UWkTIzbgYnqCrUnbs3D7Ovl5erJrfrH5LnOrbKegkT3Oc5HIdbd+3FPNX+zm+6oqTXwf347lP5wWpTEAHOL91pvb6anBBDA606tsHo+nD+CfTQ1N8MswCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744793377; c=relaxed/simple;
	bh=nx/LJIWxK0kOANqKd3q2ZUDBgt2D1QreZBHu5I/vdd8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gK6sMVGGPu+0MiJ2pDVqL7EfP9412IIwFVSrYU3NzOAWApWfK1CtcBSRrtDCk2UmXjSpJg/IiVODrORgdvyzhKpw92U12MUHL/lH5tEp4e1yczTYWtLaGixmVaK6EvI70bfxPafL1aaExDZBCv5URQXloMyYm4wjDTwMjIzevpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=vSl3E5Lt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53G8nJTd92990271, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1744793359; bh=nx/LJIWxK0kOANqKd3q2ZUDBgt2D1QreZBHu5I/vdd8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=vSl3E5LtECzkTSxzUpcfjqjfI3kE/M53mS3MtP6qdopEWDFLBMfK52tAoEUXqIRBy
	 73oF3WeujIl6WDrJqZpESeTRogf8vLMwGsdFt8y9x7qCYTRedWWc+ytFXUfiKcAZ6b
	 zCUzDD/LGI40pjsc0kdaC6ZE6kc79+zlkWYGp0wdXRiJH0CxTwlY0Z0UMO/2i5UBpK
	 Xd3/HZYoSQWRXXWGBiCKrYpSUJsP6JPC6sR5sF6Br/qcEVrvYsrsUJ7CJ+wWneoqCP
	 Ze/8jvGUALFW7ElveQ6vsGcaBw4FCpbOZmVWeiWniuBR61pxs+Mr3qLLdWTQy7je9J
	 YzZOcExiGEo0g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53G8nJTd92990271
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 16:49:19 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Apr 2025 16:49:19 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 16 Apr 2025 16:49:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 16 Apr 2025 16:49:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH] wifi: rtw88: do not ignore hardware read error during DPK
Thread-Topic: [PATCH] wifi: rtw88: do not ignore hardware read error during
 DPK
Thread-Index: AQHbreXsLqjNiLFCjEWoOXW3xlZAjbOl+9oQ
Date: Wed, 16 Apr 2025 08:49:18 +0000
Message-ID: <bf895477781f4febb998fc5d413355a0@realtek.com>
References: <20250415090720.194048-1-dmantipov@yandex.ru>
In-Reply-To: <20250415090720.194048-1-dmantipov@yandex.ru>
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

Dmitry Antipov <dmantipov@yandex.ru> wrote:
> In 'rtw8822c_dpk_cal_coef1()', do not ignore error returned
> by 'check_hw_ready()' but issue a warning to denote possible
> DPK issue. Compile tested only.
>=20
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>=20
> Fixes: 5227c2ee453d ("rtw88: 8822c: add SW DPK support")
> Suggested-by: Ping-Ke Shih <pkshih@realtek.com>
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/net/wireless/realtek/rtw88/rtw8822c.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> index 5e53e0db177e..8937a7b656ed 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
> @@ -3951,7 +3951,8 @@ static void rtw8822c_dpk_cal_coef1(struct rtw_dev *=
rtwdev)
>         rtw_write32(rtwdev, REG_NCTL0, 0x00001148);
>         rtw_write32(rtwdev, REG_NCTL0, 0x00001149);
>=20
> -       check_hw_ready(rtwdev, 0x2d9c, MASKBYTE0, 0x55);
> +       if (!check_hw_ready(rtwdev, 0x2d9c, MASKBYTE0, 0x55))
> +               rtw_warn(rtwdev, "DPK stuck, performance may be suboptima=
l");

I tested 10 times with real hardware. No warnings to bother users.

But this test is extra load to me. I might ignore this kind of patch in the=
 future.

>=20
>         rtw_write8(rtwdev, 0x1b10, 0x0);
>         rtw_write32_mask(rtwdev, REG_NCTL0, BIT_SUBPAGE, 0x0000000c);
> --
> 2.49.0
>=20


