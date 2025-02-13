Return-Path: <linux-wireless+bounces-18903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F981A33958
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 08:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 104891886D8C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 07:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DC220AF6D;
	Thu, 13 Feb 2025 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="f8ou9XEq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D510E20B21B
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739433377; cv=none; b=WQXL9AJb5OBRl5CXtiYy+L7yjqPGWt+utwb3R/KXHMFN6HPnsiEldc/yBk0mCtUipRGR2j2jdmkbDbbCLQxwFjjr1nzTEr18lpD1uKeUA+kBPk/FCwycUTBqzanmWr5TIy74sFdV1QbMCyS88SbVz6Mb1PApwq+41opFAf2R9Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739433377; c=relaxed/simple;
	bh=vd9tnTCoVsNcZsFYQMUi0wcVF6VYhtDfF2+9/HganUk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WcZmtUqQgLAIXfPd4ZoN91IVPEK5H2R5KKynEo0FpvMHRFDsiw4E3WkSNqu0d+EIVfa7tzamTZbIyqqXnhgboJ6BCPj0ZnVKDBwUrlhZmNGTjJ6bI55DC80epXhnnkI4005kMC6YgpR4RXkdoqfcqGgIoTIb3OPiypwrU09F0uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=f8ou9XEq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51D7u10Q1609683, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739433361; bh=vd9tnTCoVsNcZsFYQMUi0wcVF6VYhtDfF2+9/HganUk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=f8ou9XEq8Y0sV7iopy3sjZDIxL5QQcWvikD9amiXFRhvm/hCmt5FgYSa5ZmALp3xU
	 ZSgMzR2Mada/YTexhy2R/LXlBMSFVdRxX4/IH+x0+8AVq+rktC7YU+7y9uNj9s6kd1
	 zDG2c0/nIGmaCpyBK2svYDdBVeOwItV2O/FpjhqEaCSxrK+zuPcJxgw30jqlR5Lifo
	 YssnxYz7gngYC66rqHQISOm9OlGwQjTwYVUnGlZVfW+iOK3ZuSWfFGt6i3utxmeQwl
	 5tPXOVQ7Pzn5BQ9bR4DRGbzO/CMkKpwFqVyAcWssOVbo18QcVcBmEGHTytl3IfENra
	 i5dcMh4PvKHSw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51D7u10Q1609683
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 15:56:01 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Feb 2025 15:55:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 13 Feb 2025 15:55:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Thu, 13 Feb 2025 15:55:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v3] wifi: rtw89: rtw8852b{t}: fix TSSI debug timestamps
Thread-Topic: [PATCH v3] wifi: rtw89: rtw8852b{t}: fix TSSI debug timestamps
Thread-Index: AQHbfdsmtu5JfUhMlEqL7T1ur05SKLNE3SPg
Date: Thu, 13 Feb 2025 07:55:57 +0000
Message-ID: <8c7cc2e680cf43379734aa86f22f8d49@realtek.com>
References: <2a466aad362d456abbc4bde0a592483c@realtek.com>
 <20250213054248.1284672-1-dmantipov@yandex.ru>
In-Reply-To: <20250213054248.1284672-1-dmantipov@yandex.ru>
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
> According to Ping-Ke,=20

I meant please don't mention my name in commit message. I don't think that
helps.=20

> the vendor driver measures 'tssi_alimk_time' of
> 'struct rtw89_tssi_info' in microseconds. So adjust rtw8852b{t}-specific
> '_tssi_alimentk()' to not mess the former with nanoseconds and print both
> per-call and accumulated times. Compile tested only.
>=20
> Fixes: 7f18a70d7b4d ("wifi: rtw89: 8852b: rfk: add TSSI")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v3: do not mess s64 vs. ktime_t and print the former as signed
> v2: actually use microseconds and print both times
> ---
>  drivers/net/wireless/realtek/rtw89/core.h          |  2 +-
>  drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  | 13 +++++++------
>  drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 13 +++++++------
>  3 files changed, 15 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wire=
less/realtek/rtw89/core.h
> index b3fdd8eded21..eb2a6b90c940 100644
> --- a/drivers/net/wireless/realtek/rtw89/core.h
> +++ b/drivers/net/wireless/realtek/rtw89/core.h
> @@ -5141,7 +5141,7 @@ struct rtw89_tssi_info {
>         u32 alignment_backup_by_ch[RF_PATH_MAX][TSSI_MAX_CH_NUM][TSSI_ALI=
MK_VALUE_NUM];
>         u32 alignment_value[RF_PATH_MAX][TSSI_ALIMK_MAX][TSSI_ALIMK_VALUE=
_NUM];
>         bool alignment_done[RF_PATH_MAX][TSSI_ALIMK_MAX];
> -       u32 tssi_alimk_time;
> +       u64 tssi_alimk_time;
>  };
>=20
>  struct rtw89_power_trim_info {
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
> b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
> index ef47a5facc83..8b1cc8b71d1f 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
> @@ -3585,7 +3585,8 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev=
, enum rtw89_phy_idx phy,
>         u8 ch_idx =3D _tssi_ch_to_idx(rtwdev, channel);
>         struct rtw8852bx_bb_tssi_bak tssi_bak;
>         s32 aliment_diff, tssi_cw_default;
> -       u32 start_time, finish_time;
> +       ktime_t start_time;
> +       s64 this_time;

In reverse X'mas tree order.

>         u32 bb_reg_backup[8] =3D {0};
>         const s16 *power;
>         u8 band;
> @@ -3613,7 +3614,7 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev=
, enum rtw89_phy_idx phy,
>                 return;
>         }
>=20
> -       start_time =3D ktime_get_ns();
> +       start_time =3D ktime_get();
>=20
>         if (chan->band_type =3D=3D RTW89_BAND_2G)
>                 power =3D power_2g;
> @@ -3738,12 +3739,12 @@ static void _tssi_alimentk(struct rtw89_dev *rtwd=
ev, enum rtw89_phy_idx phy,
>         rtw8852bx_bb_restore_tssi(rtwdev, phy, &tssi_bak);
>         rtw8852bx_bb_tx_mode_switch(rtwdev, phy, 0);
>=20
> -       finish_time =3D ktime_get_ns();
> -       tssi_info->tssi_alimk_time +=3D finish_time - start_time;
> +       this_time =3D ktime_us_delta(ktime_get(), start_time);
> +       tssi_info->tssi_alimk_time +=3D this_time;
>=20
>         rtw89_debug(rtwdev, RTW89_DBG_RFK,
> -                   "[TSSI PA K] %s processing time =3D %d ms\n", __func_=
_,
> -                   tssi_info->tssi_alimk_time);
> +                   "[TSSI PA K] %s processing time =3D %lld us (acc =3D =
%llu us)\n",
> +                   __func__, this_time, tssi_info->tssi_alimk_time);
>  }
>=20
>  void rtw8852b_dpk_init(struct rtw89_dev *rtwdev)
> diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
> b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
> index 336a83e1d46b..07c31929222e 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
> @@ -3663,7 +3663,8 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev=
, enum rtw89_phy_idx phy,
>         u8 ch_idx =3D _tssi_ch_to_idx(rtwdev, channel);
>         struct rtw8852bx_bb_tssi_bak tssi_bak;
>         s32 aliment_diff, tssi_cw_default;
> -       u32 start_time, finish_time;
> +       ktime_t start_time;
> +       s64 this_time;

ditto.=20

>         u32 bb_reg_backup[8] =3D {};
>         const s16 *power;
>         u8 band;
> @@ -3675,7 +3676,7 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev=
, enum rtw89_phy_idx phy,
>                     "=3D=3D=3D=3D=3D=3D> %s   channel=3D%d   path=3D%d\n"=
, __func__, channel,
>                     path);
>=20
> -       start_time =3D ktime_get_ns();
> +       start_time =3D ktime_get();
>=20
>         if (chan->band_type =3D=3D RTW89_BAND_2G)
>                 power =3D power_2g;
> @@ -3802,12 +3803,12 @@ static void _tssi_alimentk(struct rtw89_dev *rtwd=
ev, enum rtw89_phy_idx phy,
>         rtw8852bx_bb_restore_tssi(rtwdev, phy, &tssi_bak);
>         rtw8852bx_bb_tx_mode_switch(rtwdev, phy, 0);
>=20
> -       finish_time =3D ktime_get_ns();
> -       tssi_info->tssi_alimk_time +=3D finish_time - start_time;
> +       this_time =3D ktime_us_delta(ktime_get(), start_time);
> +       tssi_info->tssi_alimk_time +=3D this_time;
>=20
>         rtw89_debug(rtwdev, RTW89_DBG_RFK,
> -                   "[TSSI PA K] %s processing time =3D %d ms\n", __func_=
_,
> -                   tssi_info->tssi_alimk_time);
> +                   "[TSSI PA K] %s processing time =3D %lld us (acc =3D =
%llu us)\n",
> +                   __func__, this_time, tssi_info->tssi_alimk_time);
>  }
>=20
>  void rtw8852bt_dpk_init(struct rtw89_dev *rtwdev)
> --
> 2.48.1
>=20


