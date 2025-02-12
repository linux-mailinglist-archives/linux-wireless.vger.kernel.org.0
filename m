Return-Path: <linux-wireless+bounces-18803-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B0BA31E00
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 06:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E5BE1883A8B
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 05:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6653EB67E;
	Wed, 12 Feb 2025 05:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="b9R4WOyd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1060C271837
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 05:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739338581; cv=none; b=OgrnCorD8oYuw8iwnaukiTC6/yhzJKae67xP68vNn0smr4WmZpvE1Qje8d6lpCTq/QuLl7GKCXjARobSVgUCAfxB5SOB0YhFUv7aVnO+hXV6jqq8UKB13i/F1frgNoETRLXWZvuwRRHwxLOLGyODiGzT9uoGl8T0ZM5skz//E2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739338581; c=relaxed/simple;
	bh=sWTQdi5QEBF3wuLJBRo7MN0ZSF2WrqkcVHqMUsIJOhE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LAEtz8E6IcSW/a73efKaCFDrIacc+jlf2KTVk0Z3L3loH4hfAFaG8CdkFWvN8t0K3NbxAqG55HvpSk1+eLnV5pToI9082CAd4zGWPdlOLbnGCLx6O+tSww0MysbLzM1U6T6cPa12GOkiLDF06h6ZBe08sVuzhPnI7ox7p9avLMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=b9R4WOyd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51C5ZxshE1641516, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739338559; bh=sWTQdi5QEBF3wuLJBRo7MN0ZSF2WrqkcVHqMUsIJOhE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=b9R4WOydGKL6x0LbBRyLBGD1IynXOpMC1SZJ3xI6k5yCki09MDdnxTOroJvULMAXx
	 Mr1g0j17bGg0LqEfoX51SLkS/a5foaMvhje/2xaXSj+uH0wXKy3ExIoHjanlbcivzX
	 Ws6P1LLNYmg1C3ss4jCDcV8XUFw/wNw022QAS2LH9h3EryhGhBMjsWaWOo/Px2od3v
	 oK5YAlHaD4zl8za7DEYZsbl3hRwsc0d5bv7cHXxsRu+n207Jkbn+diPG0xdKvgmjQN
	 RNjGynheiTyUTqt5K7+VDgrOMs1LJAKZqZ6zEKvg9SjlmsAYy9u22a7O+p9eePAy61
	 yImhIjEV1hhQA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51C5ZxshE1641516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 13:35:59 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Feb 2025 13:35:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 12 Feb 2025 13:35:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Wed, 12 Feb 2025 13:35:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 1/2] wifi: rtw89: simplify rtw89_debug_priv_mac_reg_dump_select()
Thread-Topic: [PATCH 1/2] wifi: rtw89: simplify
 rtw89_debug_priv_mac_reg_dump_select()
Thread-Index: AQHbfFk56mvBm0SA2EqV5dpc1gpdrLNDJtmQ
Date: Wed, 12 Feb 2025 05:35:58 +0000
Message-ID: <6e498ecb91a440199539fcc001b9af4b@realtek.com>
References: <20250211073915.648418-1-dmantipov@yandex.ru>
In-Reply-To: <20250211073915.648418-1-dmantipov@yandex.ru>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

Dmitry Antipov <dmantipov@yandex.ru> wrote:
> Simplify 'rtw89_debug_priv_mac_reg_dump_select()' by using
> the convenient 'kstrtoint_from_user()'. Compile tested only.
>=20
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

The function has been changed, because of switch wiphy_lock().=20
No copy_from_user() now. Skip this patch.=20

> ---
>  drivers/net/wireless/realtek/rtw89/debug.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wir=
eless/realtek/rtw89/debug.c
> index 09fa977a6e6d..339f9f6672fd 100644
> --- a/drivers/net/wireless/realtek/rtw89/debug.c
> +++ b/drivers/net/wireless/realtek/rtw89/debug.c
> @@ -924,17 +924,10 @@ rtw89_debug_priv_mac_reg_dump_select(struct file *f=
ilp,
>         struct rtw89_debugfs_priv *debugfs_priv =3D m->private;
>         struct rtw89_dev *rtwdev =3D debugfs_priv->rtwdev;
>         const struct rtw89_chip_info *chip =3D rtwdev->chip;
> -       char buf[32];
> -       size_t buf_size;
>         int sel;
>         int ret;
>=20
> -       buf_size =3D min(count, sizeof(buf) - 1);
> -       if (copy_from_user(buf, user_buf, buf_size))
> -               return -EFAULT;
> -
> -       buf[buf_size] =3D '\0';
> -       ret =3D kstrtoint(buf, 0, &sel);
> +       ret =3D kstrtoint_from_user(user_buf, count, 0, &sel);
>         if (ret)
>                 return ret;
>=20
> --
> 2.48.1
>=20


