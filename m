Return-Path: <linux-wireless+bounces-14185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62F939A3447
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 07:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2600E285DF5
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 05:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5421714BF;
	Fri, 18 Oct 2024 05:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="toS/p7b5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ED215381A;
	Fri, 18 Oct 2024 05:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729229536; cv=none; b=ZUThU/nbx5pwuNS9zcC6Vciw8diOS3F/fSlIwL7FoRSJT6yvT9XggtTTuEOuiXudDArnU6B8KOE4448dfMA+EjUWDtG8sNphFNrwo4m7MIeoWqLQ0OFj2b3dpNEcMG8j4VFjr9bvn9yahVnaWN3+c9lFZKXEqezN9xAnZs9jcvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729229536; c=relaxed/simple;
	bh=aCuJTRQqAlzX4ksRnTcNehM+fFAx64niezjkxYpEhr8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ofl9t8HJJi5pm5t/Op+UT2JnHzcGmJwvno8fZvxygau27aeroOs4caMpXkwULQN9/HEF/j14PuZ0AB+tCLkjjADawvNZkVqbdetOoO+bR1VnQc9pmLEy33PTRRytGu7QBBGPyvkJpbOgFzsm9rKNTM3JG8TTZaxvxFemOk9d8R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=toS/p7b5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49I5W0CL01553263, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729229520; bh=aCuJTRQqAlzX4ksRnTcNehM+fFAx64niezjkxYpEhr8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=toS/p7b5YwKXs8ylP6rav5JQO0idGy8gGEKAXQaR9FqmxIFK5tcnnz2Yi4kSBqn7I
	 mNRduwkuAp/FLnA2HS7Nk7Viax57bolOuO9A9uEMceKgLGA/tImzAm42SZ8SShMHf4
	 gDOLuxYuljym3SZ9wCinm95gUGPRs0+KRA7GM1HTiI+O0Nl+GnkUJvISn3cXrSMHxW
	 TYVlgUN8zcBxwIQJ85uCUrO6QnznXjbnWstlrNoT5e4adLU/TA3UT6qJPXMa0BBgxD
	 59LgFkOzgH/gczJuRHQCCoW8f7XPLhh9d99RS5m1RVataq7N6Y+H5R7wSr8t5Np1rd
	 CFBvOBx5R8VHQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49I5W0CL01553263
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 13:32:00 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 13:32:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 18 Oct 2024 13:32:00 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 18 Oct 2024 13:32:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Mohammed Anees <pvmohammedanees2003@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH v2] wifi: rtw88: Refactor looping in rtw_phy_store_tx_power_by_rate
Thread-Topic: [PATCH v2] wifi: rtw88: Refactor looping in
 rtw_phy_store_tx_power_by_rate
Thread-Index: AQHbIGuMqxz8Rb2d/UazSc++jiptXbKL/LXg
Date: Fri, 18 Oct 2024 05:32:00 +0000
Message-ID: <87a0854a459549a5addfd39ab94669c1@realtek.com>
References: <20241017080638.13074-1-pvmohammedanees2003@gmail.com>
In-Reply-To: <20241017080638.13074-1-pvmohammedanees2003@gmail.com>
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

Mohammed Anees <pvmohammedanees2003@gmail.com> wrote:
> The previous implementation included an unnecessary else
> condition paired with a continue statement. Since a check
> is already performed to determine if the band is either
> 2G or 5G, the else condition will never be triggered.
> We can remove this check.
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202410171143.OnFlgIwK-lkp@i=
ntel.com/

no need this Closes link because of typo of v1. I will remove this during m=
erging.=20

> Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>

Acked-by: Ping-Ke Shih <pkshih@realtek.com>

> ---
> v2:
> - Changed from using a pointer approach to a simpler if-else structure fo=
r clarity.
> ---
>  drivers/net/wireless/realtek/rtw88/phy.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wirel=
ess/realtek/rtw88/phy.c
> index 37ef80c9091d..8b9f8f73c14c 100644
> --- a/drivers/net/wireless/realtek/rtw88/phy.c
> +++ b/drivers/net/wireless/realtek/rtw88/phy.c
> @@ -1470,10 +1470,8 @@ static void rtw_phy_store_tx_power_by_rate(struct =
rtw_dev *rtwdev,
>                 rate =3D rates[i];
>                 if (band =3D=3D PHY_BAND_2G)
>                         hal->tx_pwr_by_rate_offset_2g[rfpath][rate] =3D o=
ffset;
> -               else if (band =3D=3D PHY_BAND_5G)
> -                       hal->tx_pwr_by_rate_offset_5g[rfpath][rate] =3D o=
ffset;
>                 else
> -                       continue;
> +                       hal->tx_pwr_by_rate_offset_5g[rfpath][rate] =3D o=
ffset;
>         }
>  }
>=20
> --
> 2.47.0


