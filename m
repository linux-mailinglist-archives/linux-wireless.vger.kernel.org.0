Return-Path: <linux-wireless+bounces-25166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C54AFF82A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 06:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BC961699D0
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 04:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748E5219A6B;
	Thu, 10 Jul 2025 04:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="i2ulREGY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5DA86334;
	Thu, 10 Jul 2025 04:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752122819; cv=none; b=A2L3+/V2WypXOKNU6Z4sKqgl3eAkaw0W2UiaVvLh9JHiofdCJYYRfRJyLDV32UHGjWlRtMkEL4jgOW0Ds5URjJUslThW56OwWt+O6P9+1I6kDyDU7m3vDerDOXJATmnJvX6ZO+VEG82oiBeq/5pON7cyq9PbVQ8yZOGJSMh4xN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752122819; c=relaxed/simple;
	bh=lRrvdxoQ8kfjvlyq8xtDDHfI24t2jxQ7rUu1QQGbZfA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H5v0F7ASICq2q9/ljlG/UVE5dsl30AoSB0Tm4YiZYceM4rPglOt8Z/JcTbNsljy/7yHhATSY0WphZi8/JUqDHvd/V5JzM72pmoZA9zFlWgwmHX9vpTd2ThWqc02qURZ6zmt4hjpe/UBP16FM9FLA/UOBUUi2J3U7I4koVX8ux4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=i2ulREGY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56A4keMT32473185, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752122800; bh=MSGiwy5B293W63Ftra/XBc6fKHi2m/FMSRKkjudLxM0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=i2ulREGYvF0znCMLLmJzOhRS/ZEuzEPYOnWyVCF7Hx+DoXkiijUpJrfm2roAHCKZU
	 Mfy/JzucG/fcShSftV8rbHO/sQAC4HiNU2GbNkN+6AlwkAk7Tzk2dObpLX34NXhuRv
	 6xhzLecZN0izeQHugOTGc5EUnJ4MJ/9QrAdLPTKdZYv+PBx6Coty0dgVnxNpoodNfV
	 me8KAUxnRhgSlEIkmYqKVioXD/A/OOfu1AMfHKM4XO1BPvRzsBpnmuZ0gEJgag3m6m
	 IXGo0x1a27EzZhH2ewfVUKcbw12B3xy5t82KqiqhIGjHPAsuHH15m1Zz1nebFifO/b
	 7K97qAlb+x3aA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56A4keMT32473185
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 12:46:40 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Jul 2025 12:46:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 10 Jul 2025 12:46:39 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 10 Jul 2025 12:46:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Kalle Valo
	<kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Fiona Klute <fiona.klute@gmx.de>
Subject: RE: [PATCH v2 1/2] wifi: rtw88: introduce callback to override phy parameters from tables
Thread-Topic: [PATCH v2 1/2] wifi: rtw88: introduce callback to override phy
 parameters from tables
Thread-Index: AQHb8SHTsg0YI0LK4kuloM5YSiDzqbQqyHqg
Date: Thu, 10 Jul 2025 04:46:39 +0000
Message-ID: <7862f0bc08014a80be76f5513c1b6cd8@realtek.com>
References: <20250709223159.2787192-1-andrej.skvortzov@gmail.com>
 <20250709223159.2787192-2-andrej.skvortzov@gmail.com>
In-Reply-To: <20250709223159.2787192-2-andrej.skvortzov@gmail.com>
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

Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> tables with register values for phy parameters initialization are
> copied from vendor driver usually. Sometimes these parameters has to
> be modified. When table will be regenerated, manual modifications to
> it may be lost. To avoid regressions in this case new callback
> mac_postinit is introduced, that is called after parameters from table
> are set.
>=20
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---
>  drivers/net/wireless/realtek/rtw88/mac.c  | 11 +++++++++++
>  drivers/net/wireless/realtek/rtw88/mac.h  |  1 +
>  drivers/net/wireless/realtek/rtw88/main.c |  6 ++++++
>  drivers/net/wireless/realtek/rtw88/main.h |  1 +
>  4 files changed, 19 insertions(+)
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/mac.c b/drivers/net/wirel=
ess/realtek/rtw88/mac.c
> index 011b81c82f3ba..e05d06678050d 100644
> --- a/drivers/net/wireless/realtek/rtw88/mac.c
> +++ b/drivers/net/wireless/realtek/rtw88/mac.c
> @@ -1409,3 +1409,14 @@ int rtw_mac_init(struct rtw_dev *rtwdev)
>=20
>         return 0;
>  }
> +
> +int rtw_mac_postinit(struct rtw_dev *rtwdev)
> +{
> +       const struct rtw_chip_info *chip =3D rtwdev->chip;
> +       int ret =3D 0;

This initializer is not necessary. See [1]

[1] http://wifibot.sipsolutions.net/results/980760/14150387/build_clang/std=
err

> +
> +       if (chip->ops->mac_postinit)
> +               ret =3D chip->ops->mac_postinit(rtwdev);
> +
> +       return 0;
> +}
> diff --git a/drivers/net/wireless/realtek/rtw88/mac.h b/drivers/net/wirel=
ess/realtek/rtw88/mac.h
> index e92b1483728d5..b73af90ee1d7f 100644
> --- a/drivers/net/wireless/realtek/rtw88/mac.h
> +++ b/drivers/net/wireless/realtek/rtw88/mac.h
> @@ -38,6 +38,7 @@ void rtw_write_firmware_page(struct rtw_dev *rtwdev, u3=
2 page,
>                              const u8 *data, u32 size);
>  int rtw_download_firmware(struct rtw_dev *rtwdev, struct rtw_fw_state *f=
w);
>  int rtw_mac_init(struct rtw_dev *rtwdev);
> +int rtw_mac_postinit(struct rtw_dev *rtwdev);
>  void rtw_mac_flush_queues(struct rtw_dev *rtwdev, u32 queues, bool drop)=
;
>  int rtw_set_trx_fifo_info(struct rtw_dev *rtwdev);
>  int rtw_ddma_to_fw_fifo(struct rtw_dev *rtwdev, u32 ocp_src, u32 size);
> diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wire=
less/realtek/rtw88/main.c
> index 97756bdf57b27..b706c5a21a6c5 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.c
> +++ b/drivers/net/wireless/realtek/rtw88/main.c
> @@ -1412,6 +1412,12 @@ int rtw_power_on(struct rtw_dev *rtwdev)
>=20
>         chip->ops->phy_set_param(rtwdev);
>=20
> +       ret =3D rtw_mac_postinit(rtwdev);
> +       if (ret) {
> +               rtw_err(rtwdev, "failed to configure mac in postinit\n");
> +               goto err_off;
> +       }
> +
>         ret =3D rtw_hci_start(rtwdev);
>         if (ret) {
>                 rtw_err(rtwdev, "failed to start hci\n");
> diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wire=
less/realtek/rtw88/main.h
> index b42538cce3598..43ed6d6b42919 100644
> --- a/drivers/net/wireless/realtek/rtw88/main.h
> +++ b/drivers/net/wireless/realtek/rtw88/main.h
> @@ -858,6 +858,7 @@ struct rtw_chip_ops {
>         int (*power_on)(struct rtw_dev *rtwdev);
>         void (*power_off)(struct rtw_dev *rtwdev);
>         int (*mac_init)(struct rtw_dev *rtwdev);
> +       int (*mac_postinit)(struct rtw_dev *rtwdev);
>         int (*dump_fw_crash)(struct rtw_dev *rtwdev);
>         void (*shutdown)(struct rtw_dev *rtwdev);
>         int (*read_efuse)(struct rtw_dev *rtwdev, u8 *map);
> --
> 2.47.2


