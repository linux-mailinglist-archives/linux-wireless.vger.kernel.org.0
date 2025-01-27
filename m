Return-Path: <linux-wireless+bounces-17995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE960A1D133
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 08:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1BE18876F9
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 07:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C070158D8B;
	Mon, 27 Jan 2025 07:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="lPFqCFmU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120601FC101
	for <linux-wireless@vger.kernel.org>; Mon, 27 Jan 2025 07:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737961628; cv=none; b=WaIjqWt45B4Ueuqm88g7dWSdcdPWM1RMl/gl0ViH02mEX7yqgBhxpOfXOSaOce5bQ+if0RrJS3crgiW2/e9+fFqOz38HjnzfqvEUMIQY9HQKKA/ByCPDW6lPycVrZ867TVS8lwfeUGzov+q6j2OdBePXtA10rdNpWEwZYxuWfWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737961628; c=relaxed/simple;
	bh=AfnKuX9gPyZoHO8DvA1xVCVGPgzTmM+O/F5eTQrmNjo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XN6L3Jg1JDUma2pPCpmf8EGuB+9EPnLF4GVTfx78g97VeQkEDOs0nDd5/U1YL2pjQf/oEwJj2YsWzv1hFZ8znVL8xfeEkPwbt3cvzjLY0FxYJRCFRCqo+zE2y3UzrWUHHbpJ2Do3aKhUdrp3aUc/iuC6BdLS1oH9FeV5ce7ut94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=lPFqCFmU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50R76xlxE2633973, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737961619; bh=AfnKuX9gPyZoHO8DvA1xVCVGPgzTmM+O/F5eTQrmNjo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=lPFqCFmUy8F2cCOIYDHKFV0Iz7m1OqWz6xoZDfvIWWGJmxlW5brolwpktNpmc7N49
	 LLGCfjiQ5NH+wXap9ClRYx+21qMnhTmTiKmkfTsxhe3Y8tVd9nnpK1JLRApW2sl76g
	 O713cfQH21p6PYLA0c/2biyaf/YhYdhu+BQs/YqeyFLmpvl1/4xYthDQFw4s0iaQOL
	 gm1yH26OpM57eh8YXMpQSRI62RH8WhfblS/c4Lf4QIMAVCzsj8giMjkC51nRWs9yg9
	 BK7+rmtDP4EhSHB29s1uDusO/qpGjr6yWESZvN3r2rtPz5DryjJFVRV20Jei8eE37m
	 wIydds1OKapaw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50R76xlxE2633973
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jan 2025 15:06:59 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 27 Jan 2025 15:06:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 27 Jan 2025 15:06:59 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 27 Jan 2025 15:06:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 6/7] wifi: rtw88: Extend TX power stuff for 3-4 spatial streams
Thread-Topic: [PATCH 6/7] wifi: rtw88: Extend TX power stuff for 3-4 spatial
 streams
Thread-Index: AQHbcEYvuIiyZrOUc0mXjulK16rnt7MqLKBh
Date: Mon, 27 Jan 2025 07:06:59 +0000
Message-ID: <0fbf26e8e31748f09164026b4d096399@realtek.com>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>,<b5b39106-406c-40fb-a3db-6f755467d6a7@gmail.com>
In-Reply-To: <b5b39106-406c-40fb-a3db-6f755467d6a7@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Although the RTL8814AU only has 3 spatial streams, maybe some other chip
> has 4.
>=20
> Correct the TX power index and TX power limit calculations for 3SS and
> 4SS HT/VHT rates.
>=20
> With this the RTL8814AU can set the TX power correctly.
>=20
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> ---
> I just realised this patch depends on another pending patch:
> https://lore.kernel.org/linux-wireless/8a60f581-0ab5-4d98-a97d-dd83b60500=
8f@gmail.com/
>=20
> Originally this patch was going to be in part 2, but then I rearranged
> them. Too late to turn back now...

Next time, if you want rearrange two or more patchset, just ask me to
drop all patches and re-send with increasing version number.=20

> ---
>  drivers/net/wireless/realtek/rtw88/main.h     |   4 +
>  drivers/net/wireless/realtek/rtw88/phy.c      | 149 ++++++++++++------
>  drivers/net/wireless/realtek/rtw88/phy.h      |   4 +
>  drivers/net/wireless/realtek/rtw88/rtw8821c.c |   2 +-
>  drivers/net/wireless/realtek/rtw88/rtw8822b.c |   2 +-
>  drivers/net/wireless/realtek/rtw88/rtw8822c.c |   2 +-
>  drivers/net/wireless/realtek/rtw88/rtw88xxa.c |   2 +-
>  7 files changed, 114 insertions(+), 51 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wire=
less/realtek/rtw88/main.h
> index ba64d269521a..bbae6d7c1aa9 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.h
> +++ b/drivers/net/wireless/realtek/rtw88/main.h
> @@ -166,6 +166,10 @@ enum rtw_rate_section {
>         RTW_RATE_SECTION_HT_2S,
>         RTW_RATE_SECTION_VHT_1S,
>         RTW_RATE_SECTION_VHT_2S,

Suggest to add a=20
          __RTW_RATE_SECTION_2SS_MAX =3D RTW_RATE_SECTION_VHT_2S,
          or
          __RTW_RATE_SECTION_2SS_NUM =3D RTW_RATE_SECTION_HT_3S,
          (Be careful the place, enumerator will increase automatically)

(The suffix of existing RTW_RATE_SECTION_MAX is wrong -- _NUM instead of _M=
AX)

> +       RTW_RATE_SECTION_HT_3S,
> +       RTW_RATE_SECTION_HT_4S,
> +       RTW_RATE_SECTION_VHT_3S,
> +       RTW_RATE_SECTION_VHT_4S,
>=20
>         /* keep last */
>         RTW_RATE_SECTION_MAX,
> diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wirel=
ess/realtek/rtw88/phy.c
> index 8ed20c89d216..5ddc9d4988b8 100644
> --- a/drivers/net/wireless/realtek/rtw88/phy.c
> +++ b/drivers/net/wireless/realtek/rtw88/phy.c
> @@ -53,21 +53,25 @@ static const u32 db_invert_table[12][8] =3D {
>  };
>=20
>  u8 rtw_cck_rates[] =3D { DESC_RATE1M, DESC_RATE2M, DESC_RATE5_5M, DESC_R=
ATE11M };
> +
>  u8 rtw_ofdm_rates[] =3D {
>         DESC_RATE6M,  DESC_RATE9M,  DESC_RATE12M,
>         DESC_RATE18M, DESC_RATE24M, DESC_RATE36M,
>         DESC_RATE48M, DESC_RATE54M
>  };
> +
>  u8 rtw_ht_1s_rates[] =3D {
>         DESC_RATEMCS0, DESC_RATEMCS1, DESC_RATEMCS2,
>         DESC_RATEMCS3, DESC_RATEMCS4, DESC_RATEMCS5,
>         DESC_RATEMCS6, DESC_RATEMCS7
>  };
> +
>  u8 rtw_ht_2s_rates[] =3D {
>         DESC_RATEMCS8,  DESC_RATEMCS9,  DESC_RATEMCS10,
>         DESC_RATEMCS11, DESC_RATEMCS12, DESC_RATEMCS13,
>         DESC_RATEMCS14, DESC_RATEMCS15
>  };
> +
>  u8 rtw_vht_1s_rates[] =3D {
>         DESC_RATEVHT1SS_MCS0, DESC_RATEVHT1SS_MCS1,
>         DESC_RATEVHT1SS_MCS2, DESC_RATEVHT1SS_MCS3,
> @@ -75,6 +79,7 @@ u8 rtw_vht_1s_rates[] =3D {
>         DESC_RATEVHT1SS_MCS6, DESC_RATEVHT1SS_MCS7,
>         DESC_RATEVHT1SS_MCS8, DESC_RATEVHT1SS_MCS9
>  };
> +
>  u8 rtw_vht_2s_rates[] =3D {
>         DESC_RATEVHT2SS_MCS0, DESC_RATEVHT2SS_MCS1,
>         DESC_RATEVHT2SS_MCS2, DESC_RATEVHT2SS_MCS3,
> @@ -82,10 +87,41 @@ u8 rtw_vht_2s_rates[] =3D {
>         DESC_RATEVHT2SS_MCS6, DESC_RATEVHT2SS_MCS7,
>         DESC_RATEVHT2SS_MCS8, DESC_RATEVHT2SS_MCS9
>  };
> +
> +u8 rtw_ht_3s_rates[] =3D {
> +       DESC_RATEMCS16, DESC_RATEMCS17, DESC_RATEMCS18,
> +       DESC_RATEMCS19, DESC_RATEMCS20, DESC_RATEMCS21,
> +       DESC_RATEMCS22, DESC_RATEMCS23
> +};
> +
> +u8 rtw_ht_4s_rates[] =3D {
> +       DESC_RATEMCS24, DESC_RATEMCS25, DESC_RATEMCS26,
> +       DESC_RATEMCS27, DESC_RATEMCS28, DESC_RATEMCS29,
> +       DESC_RATEMCS30, DESC_RATEMCS31
> +};
> +
> +u8 rtw_vht_3s_rates[] =3D {
> +       DESC_RATEVHT3SS_MCS0, DESC_RATEVHT3SS_MCS1,
> +       DESC_RATEVHT3SS_MCS2, DESC_RATEVHT3SS_MCS3,
> +       DESC_RATEVHT3SS_MCS4, DESC_RATEVHT3SS_MCS5,
> +       DESC_RATEVHT3SS_MCS6, DESC_RATEVHT3SS_MCS7,
> +       DESC_RATEVHT3SS_MCS8, DESC_RATEVHT3SS_MCS9
> +};
> +
> +u8 rtw_vht_4s_rates[] =3D {
> +       DESC_RATEVHT4SS_MCS0, DESC_RATEVHT4SS_MCS1,
> +       DESC_RATEVHT4SS_MCS2, DESC_RATEVHT4SS_MCS3,
> +       DESC_RATEVHT4SS_MCS4, DESC_RATEVHT4SS_MCS5,
> +       DESC_RATEVHT4SS_MCS6, DESC_RATEVHT4SS_MCS7,
> +       DESC_RATEVHT4SS_MCS8, DESC_RATEVHT4SS_MCS9
> +};
> +
>  u8 *rtw_rate_section[RTW_RATE_SECTION_MAX] =3D {
>         rtw_cck_rates, rtw_ofdm_rates,
>         rtw_ht_1s_rates, rtw_ht_2s_rates,
> -       rtw_vht_1s_rates, rtw_vht_2s_rates
> +       rtw_vht_1s_rates, rtw_vht_2s_rates,
> +       rtw_ht_3s_rates, rtw_ht_4s_rates,
> +       rtw_vht_3s_rates, rtw_vht_4s_rates
>  };
>  EXPORT_SYMBOL(rtw_rate_section);
>=20
> @@ -95,17 +131,14 @@ u8 rtw_rate_size[RTW_RATE_SECTION_MAX] =3D {
>         ARRAY_SIZE(rtw_ht_1s_rates),
>         ARRAY_SIZE(rtw_ht_2s_rates),
>         ARRAY_SIZE(rtw_vht_1s_rates),
> -       ARRAY_SIZE(rtw_vht_2s_rates)
> +       ARRAY_SIZE(rtw_vht_2s_rates),
> +       ARRAY_SIZE(rtw_ht_3s_rates),
> +       ARRAY_SIZE(rtw_ht_4s_rates),
> +       ARRAY_SIZE(rtw_vht_3s_rates),
> +       ARRAY_SIZE(rtw_vht_4s_rates)
>  };
>  EXPORT_SYMBOL(rtw_rate_size);
>=20
> -static const u8 rtw_cck_size =3D ARRAY_SIZE(rtw_cck_rates);
> -static const u8 rtw_ofdm_size =3D ARRAY_SIZE(rtw_ofdm_rates);
> -static const u8 rtw_ht_1s_size =3D ARRAY_SIZE(rtw_ht_1s_rates);
> -static const u8 rtw_ht_2s_size =3D ARRAY_SIZE(rtw_ht_2s_rates);
> -static const u8 rtw_vht_1s_size =3D ARRAY_SIZE(rtw_vht_1s_rates);
> -static const u8 rtw_vht_2s_size =3D ARRAY_SIZE(rtw_vht_2s_rates);
> -
>  enum rtw_phy_band_type {
>         PHY_BAND_2G     =3D 0,
>         PHY_BAND_5G     =3D 1,
> @@ -1635,10 +1668,12 @@ static void
>  rtw_xref_txpwr_lmt_by_rs(struct rtw_dev *rtwdev, u8 regd, u8 bw, u8 ch_i=
dx)
>  {
>         u8 rs_idx, rs_ht, rs_vht;
> -       u8 rs_cmp[2][2] =3D {{RTW_RATE_SECTION_HT_1S, RTW_RATE_SECTION_VH=
T_1S},
> -                          {RTW_RATE_SECTION_HT_2S, RTW_RATE_SECTION_VHT_=
2S} };
> +       u8 rs_cmp[4][2] =3D {{RTW_RATE_SECTION_HT_1S, RTW_RATE_SECTION_VH=
T_1S},
> +                          {RTW_RATE_SECTION_HT_2S, RTW_RATE_SECTION_VHT_=
2S},
> +                          {RTW_RATE_SECTION_HT_3S, RTW_RATE_SECTION_VHT_=
3S},
> +                          {RTW_RATE_SECTION_HT_4S, RTW_RATE_SECTION_VHT_=
4S} };

Can be 'static const' by the way.=20

>=20
> -       for (rs_idx =3D 0; rs_idx < 2; rs_idx++) {
> +       for (rs_idx =3D 0; rs_idx < 4; rs_idx++) {
>                 rs_ht =3D rs_cmp[rs_idx][0];
>                 rs_vht =3D rs_cmp[rs_idx][1];
>=20

[...]

> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/=
wireless/realtek/rtw88/rtw8821c.c
> index cc152248407c..106a9e38e428 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
> @@ -709,7 +709,7 @@ static void rtw8821c_set_tx_power_index(struct rtw_de=
v *rtwdev)
>         int rs, path;
>=20
>         for (path =3D 0; path < hal->rf_path_num; path++) {
> -               for (rs =3D 0; rs < RTW_RATE_SECTION_MAX; rs++) {
> +               for (rs =3D 0; rs < RTW_RATE_SECTION_HT_3S; rs++) {

As mentioned above,
        rs < __RTW_RATE_SECTION_2SS_NUM
        or
        rs <=3D __RTW_RATE_SECTION_2SS_MAX

>                         if (rs =3D=3D RTW_RATE_SECTION_HT_2S ||
>                             rs =3D=3D RTW_RATE_SECTION_VHT_2S)
>                                 continue;

