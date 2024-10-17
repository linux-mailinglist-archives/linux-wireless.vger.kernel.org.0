Return-Path: <linux-wireless+bounces-14112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E389A17E7
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 03:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236581F2381B
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 01:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB13D1DFE8;
	Thu, 17 Oct 2024 01:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="F3CutST/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15271BF37;
	Thu, 17 Oct 2024 01:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729128126; cv=none; b=d1C/MaHDYNWBSalQV+4LUZn1rf5S7BScpZazdAaOsR3UdrDMHeO2reqOgZbLfSbWVIFe2ReRmNVqzprxZKQvgKTRS5lPAouWK7paZE9Xyo+7pbVpX4Lc1QsXy2BdfU/ZksSMbz8Lwd0aNEQob6Ye3xIOgsOPTJR3UwsbKlLFVow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729128126; c=relaxed/simple;
	bh=I1NKDZJkPOOTvvqsSWxUshi93ZcySyT610+Knx4s2jc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WC8B3FbLJ/xepHnTkbmvSAz6cAyV9lQAEq3vgsf4sYk6SmUE/T8MkPBg877wUrCIP+9ZVVuGUbm7E2YSNRV4PqG4jGn0ARRBLXiAL2liNB1NH3uoGMevehPquuni0CKQaDdAu/fhBrPSfMqeyB0ywJ06gfRlpwmASnwmk9kGEwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=F3CutST/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49H1LtI423838934, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729128115; bh=I1NKDZJkPOOTvvqsSWxUshi93ZcySyT610+Knx4s2jc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=F3CutST/SLvaPV5es11bRUtGhdVJl8YIAi4k18T1/H85naLGT/LPPUfHXWa019l7B
	 RkgE9SrIjBz3l4unElvX4DdL7ulJGM0Gvc+kdPxyO1EAffJRDAMYZyP1ks00nwUkJp
	 BsLofuADn94IQm9hFGBl4+2kCplx9B96RHNmfwhYPPTqskU5++Yb22OAQLHul7LrQS
	 05M5WRG5wMo6qiOWwiOkIsbRxwCh+8OB5e+ZfuADbC/ixZqADJxqMP7P0q+VOKw6VJ
	 5ZcZ7ykEYKfENdxo7Vaqxd2xqxcWt8bgQqX1hi0kOkbFMcV5Ek65sBtrE+4fdtDItI
	 iW77VZ7SVJYtw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49H1LtI423838934
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 09:21:55 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 09:21:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 17 Oct 2024 09:21:54 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 17 Oct 2024 09:21:54 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>
Subject: RE: [PATCH] wifi: rtw88: Refactor looping in rtw_phy_store_tx_power_by_rate
Thread-Topic: [PATCH] wifi: rtw88: Refactor looping in
 rtw_phy_store_tx_power_by_rate
Thread-Index: AQHbH5G7zMXB5WLj7UST4uYO5eihKrKKJAjA
Date: Thu, 17 Oct 2024 01:21:54 +0000
Message-ID: <c0f6c6c3b87c4d048ad9f42dc1dfaed9@realtek.com>
References: <20241016060605.11359-1-pvmohammedanees2003@gmail.com>
In-Reply-To: <20241016060605.11359-1-pvmohammedanees2003@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

Mohammed Anees <pvmohammedanees2003@gmail.com> wrote:
>=20
> The previous implementation performs check for the band
> in each iteration, which is unnecessary and further more
> there is a else condition which will never get triggered,

I feel compilers can optimize the check for the band, and we can just remov=
e
the else condition. Or=20
   if (2ghz)
      foo_2g();
   else
      foo_5g();


> since a check is done to see if the band is either 2G or
> 5G earlier and the band either be any of those 2. We can
> refactor this by assigning a pointer to the appropriate
> power offset array based on the band before the loop and
> updating this.
>=20
> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtw88/phy.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wirel=
ess/realtek/rtw88/phy.c
> index 37ef80c9091d..17d61f1d9257 100644
> --- a/drivers/net/wireless/realtek/rtw88/phy.c
> +++ b/drivers/net/wireless/realtek/rtw88/phy.c
> @@ -1465,15 +1465,14 @@ static void rtw_phy_store_tx_power_by_rate(struct=
 rtw_dev *rtwdev,
>                     rate_num > RTW_RF_PATH_MAX))
>                 return;
>=20
> +       s8 (*tx_pwr_by_rate_offset) =3D (band =3D=3D PHY_BANK_2G)
> +                                               ? hal->tx_pwr_by_rate_off=
set_2g[rfpath]
> +                                               : hal->tx_pwr_by_rate_off=
set_5g[rfpath];
> +

Though -Wdeclaration-after-statement was dropped, still recommend to place
declarations at the beginning of function.

The operands ? and : should place at the end of statement.=20

x =3D y ?
    z0 :
    z1;


>         for (i =3D 0; i < rate_num; i++) {
>                 offset =3D pwr_by_rate[i];
>                 rate =3D rates[i];
> -               if (band =3D=3D PHY_BAND_2G)
> -                       hal->tx_pwr_by_rate_offset_2g[rfpath][rate] =3D o=
ffset;
> -               else if (band =3D=3D PHY_BAND_5G)
> -                       hal->tx_pwr_by_rate_offset_5g[rfpath][rate] =3D o=
ffset;
> -               else
> -                       continue;
> +               tx_pwr_by_rate_offset[rate] =3D offset;
>         }
>  }
>=20
> --
> 2.47.0


