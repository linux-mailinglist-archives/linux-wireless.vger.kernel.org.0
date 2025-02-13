Return-Path: <linux-wireless+bounces-18868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0B0A3343C
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 01:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1CD41885C9A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 00:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33DF1CF8B;
	Thu, 13 Feb 2025 00:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZiF+Qmbi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464CA171D2
	for <linux-wireless@vger.kernel.org>; Thu, 13 Feb 2025 00:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739407541; cv=none; b=EoC54fzUhctMjRY9YA2dR/AMy+6ii0qR60dN6szgN9pgjcwCo/hfxyxy3I1GDljlOf0ggstqVjjeCtTng1Xb8GV/urvcmCkNp+AxkzqZGS877f2mqZ1LHlERz5yZiw6WYk/v5MPYWoDkFyFAddotoNs5GAB/eZBcEXeNbqc7p8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739407541; c=relaxed/simple;
	bh=S1kZaI1JF4k3dQ7XrXp3udSqdqkPEgWHbO2PeR7te3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=liGTsbc2FItQZ+KnSNibR8YLV+VZv/Dp+XEM6TKpbP3P7Kf3T/MX+dj34zVfh/72AaD1Ie/Awkz73nF29bsUWmJlJdfWPyjDt6P28TRtjVHiwLDZTPXY03IRtDRtYEcLsrD1ORYMLhvcpwMxfBtWS39IoCpFdsX+DN9tsmqU4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZiF+Qmbi; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51D0jQBM1035189, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739407526; bh=S1kZaI1JF4k3dQ7XrXp3udSqdqkPEgWHbO2PeR7te3M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ZiF+Qmbis+tPiQlEmrzZWXvty+A/gpuyXPMEgupF5c1wj3mgetpJW+3tMluvQsoxc
	 3ZFtVWLOmAFN8XF0rfGGu3onf8PYwRrQhXuRgDj67SCLGBmaFQI6jYuggIJK0Nqzxx
	 r6xwlAvi3mWg4qtzQFIrxn8zO7qltAaW4GMl0jr55qZ7JHruBOAVBKUtzujmGa79XL
	 XqoSrHDNsDPb2f2Xbj2oghiaNqT+dm+DUmtD6kvg6dsk8BA1qImd7Re6WgztiVmUbe
	 UGnZnAKmbeaHfgGWKij66DIg+14mOakK0yt6wJeYceFyKDvMna8vTc9EIQPnpH5ffX
	 //Xjkf8qdWA3Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51D0jQBM1035189
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 08:45:26 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Feb 2025 08:45:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 13 Feb 2025 08:45:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Thu, 13 Feb 2025 08:45:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
CC: Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2] wifi: rtw89: rtw8852b{t}: fix TSSI debug timestamps
Thread-Topic: [PATCH v2] wifi: rtw89: rtw8852b{t}: fix TSSI debug timestamps
Thread-Index: AQHbfSIjRaeBmuo4q0K0PK8zTEPHLbNEZYwA
Date: Thu, 13 Feb 2025 00:45:24 +0000
Message-ID: <2a466aad362d456abbc4bde0a592483c@realtek.com>
References: <0b028bab48ab4d64ac82b1228e1ad21c@realtek.com>
 <20250212073833.1265407-1-dmantipov@yandex.ru>
In-Reply-To: <20250212073833.1265407-1-dmantipov@yandex.ru>
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

"As vendor driver...."

I think I shouldn't be the reason...

> 'tssi_alimk_time' of 'struct rtw89_tssi_info'
> is in microseconds. So adjust rtw8852b{t}-specific '_tssi_alimentk()'
> to not mess the former with nanoseconds and print both per-call
> and accumulated times. Compile tested only.
>=20
> Fixes: 7f18a70d7b4d ("wifi: rtw89: 8852b: rfk: add TSSI")
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
> v2: actually use microseconds and print both times
> ---
>  drivers/net/wireless/realtek/rtw89/core.h          |  2 +-
>  drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c  | 12 ++++++------
>  drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c | 12 ++++++------
>  3 files changed, 13 insertions(+), 13 deletions(-)
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
> index ef47a5facc83..1e0490813c40 100644
> --- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
> +++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
> @@ -3585,7 +3585,7 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev=
, enum rtw89_phy_idx phy,
>         u8 ch_idx =3D _tssi_ch_to_idx(rtwdev, channel);
>         struct rtw8852bx_bb_tssi_bak tssi_bak;
>         s32 aliment_diff, tssi_cw_default;
> -       u32 start_time, finish_time;
> +       ktime_t start_time, this_time;
>         u32 bb_reg_backup[8] =3D {0};
>         const s16 *power;
>         u8 band;
> @@ -3613,7 +3613,7 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev=
, enum rtw89_phy_idx phy,
>                 return;
>         }
>=20
> -       start_time =3D ktime_get_ns();
> +       start_time =3D ktime_get();
>=20
>         if (chan->band_type =3D=3D RTW89_BAND_2G)
>                 power =3D power_2g;
> @@ -3738,12 +3738,12 @@ static void _tssi_alimentk(struct rtw89_dev *rtwd=
ev, enum rtw89_phy_idx phy,
>         rtw8852bx_bb_restore_tssi(rtwdev, phy, &tssi_bak);
>         rtw8852bx_bb_tx_mode_switch(rtwdev, phy, 0);
>=20
> -       finish_time =3D ktime_get_ns();
> -       tssi_info->tssi_alimk_time +=3D finish_time - start_time;
> +       this_time =3D ktime_us_delta(ktime_get(), start_time);

As prototype=20
   static inline s64 ktime_us_delta(const ktime_t later, const ktime_t earl=
ier)

The type of this_time should be s64 instead of ktime_t.=20


> +       tssi_info->tssi_alimk_time +=3D this_time;
>=20
>         rtw89_debug(rtwdev, RTW89_DBG_RFK,
> -                   "[TSSI PA K] %s processing time =3D %d ms\n", __func_=
_,
> -                   tssi_info->tssi_alimk_time);
> +                   "[TSSI PA K] %s processing time =3D %llu us (acc =3D =
%llu us)\n",
> +                   __func__, this_time, tssi_info->tssi_alimk_time);
>  }
>=20
>  void rtw8852b_dpk_init(struct rtw89_dev *rtwdev)

[...]


