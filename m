Return-Path: <linux-wireless+bounces-26675-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E1AB379C2
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 07:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4008D16AADC
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 05:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2DF30C35D;
	Wed, 27 Aug 2025 05:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="EXfiD2aS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160D230FC3C;
	Wed, 27 Aug 2025 05:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756272419; cv=none; b=atkCYsYlQnpn07rD1yjIXo2eKhA6BGqBvI0HtknRM/7qPv9R6L4aax9Kw8CCAS5bI6xZ3GWLclgBQsrYSUIGTfnLsqIIzO5cK3+YgygB4gCvWbUzfSDHIX2Oyn689V7cXCqeIRs1T/Br1h+kqOW0jD4Cuv3ypHflqBfEV032hSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756272419; c=relaxed/simple;
	bh=vsQho9dfXGKdYJSEdtMVrJRSEqciIAWtXQcTuLYpQIg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JIQL4S50Ad3lEvSHTnvrCR8SMyDH1MbJ2Zoc7GoND+GlJ7LGNaizjDdoaWes+x4hqIbixFynwTzAejG/8jTVe9s3X5TIKLahxMV8PPwPvjw8HzUnUxewhG6pjSnFTJFYkOHBOrRfKo/Tyl1dZ40Qa+87eKPpdVe7tZ+N5JZM/KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=EXfiD2aS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57R5QruU62930968, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1756272413; bh=IUZGHKKLL6Q2RG8Oo3w98aeWPVU2J53tl/8Hb10MVzU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=EXfiD2aS2xXYeqrhOZoZDcNxdGQ6LmMWRrApcccrLVJeZKVdNR+I5vNZBSPXb1ZDf
	 6LiAQOBPoqqJdepAaa3nrcF3gcmmBfXZcp7FxFAm+V+F9HZvpdf2yyFqeDg9Sexcm8
	 3iB0WxzGWidfTwWmL8bq6Z4K2kQmTe+3JArYfzrxQxB0Gv0ydiDu4eKnl5qoJ+jJfX
	 196i16ItVrG/itMwih80zyGUYmwxi0GYrcOfSmwK7mP6b4zwejqxUimDLw6DixNeNl
	 D/+eeFs0e2WQcl3xdtPJ33EpAd/0Np6WT+uw5PR5OjGilwoZKOSXptMfqKAhvNzkq0
	 NX3Zvmn+zSzSQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57R5QruU62930968
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 13:26:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 27 Aug 2025 13:26:53 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 27 Aug 2025 13:26:52 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Wed, 27 Aug 2025 13:26:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Liao Yuanhong <liaoyuanhong@vivo.com>,
        "open list:REALTEK WIRELESS DRIVER
 (rtw89)" <linux-wireless@vger.kernel.org>,
        open list
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: 8852bt: Remove redundant off_reverse variables
Thread-Topic: [PATCH] wifi: rtw89: 8852bt: Remove redundant off_reverse
 variables
Thread-Index: AQHcFwgL5yWiVoTtL0GaLbiP5ja9NrR196fQ
Date: Wed, 27 Aug 2025 05:26:52 +0000
Message-ID: <07dd869670914c659c98eae0315c704a@realtek.com>
References: <20250827040643.208541-1-liaoyuanhong@vivo.com>
In-Reply-To: <20250827040643.208541-1-liaoyuanhong@vivo.com>
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

Liao Yuanhong <liaoyuanhong@vivo.com> wrote:
> The variable off_reverse and its related code are completely redundant in
> the function. Remove them to clean the code.
>=20
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
> b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
> index d0e299803225..f23754a5c7b9 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
> @@ -1799,22 +1799,14 @@ static void _dpk_onoff(struct rtw89_dev *rtwdev, =
enum rtw89_rf_path path, bool o
>  {
>         struct rtw89_dpk_info *dpk =3D &rtwdev->dpk;
>         u8 val, kidx =3D dpk->cur_idx[path];
> -       bool off_reverse;
>=20
> -       val =3D dpk->is_dpk_enable && !off && dpk->bp[path][kidx].path_ok=
;
> -
> -       if (off)
> -               off_reverse =3D false;
> -       else
> -               off_reverse =3D true;
> -
> -       val =3D dpk->is_dpk_enable & off_reverse & dpk->bp[path][kidx].pa=
th_ok;
> +       val =3D dpk->is_dpk_enable & !off & dpk->bp[path][kidx].path_ok;

The previous patch has merged. Please re-spin this patch on top of rtw-next=
 [1].
The subject should be "[PATCH rtw-next]", so NIPA can do correct tree selec=
tion.=20

[1] https://github.com/pkshih/rtw.git rtw-next

>=20
>         rtw89_phy_write32_mask(rtwdev, R_DPD_CH0A + (path << 8) + (kidx <=
< 2),
>                                BIT(24), val);
>=20
>         rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] S%d[%d] DPK %s !!!\n", =
path,
> -                   kidx, str_enable_disable(dpk->is_dpk_enable & off_rev=
erse));
> +                   kidx, str_enable_disable(dpk->is_dpk_enable & !off));
>  }
>=20
>  static void _dpk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx p=
hy,
> --
> 2.34.1


