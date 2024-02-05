Return-Path: <linux-wireless+bounces-3119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2189B84925D
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 03:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5DB1F227B0
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 02:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1A78F59;
	Mon,  5 Feb 2024 02:25:04 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F28D8F40;
	Mon,  5 Feb 2024 02:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707099904; cv=none; b=aM/QjVfksrrZOrTwEFz6kci7kf03c+6oawJQXbT8HVoawTxEpLqVdmxT9KFOpJI8PZ8OeGNy2RQPcbBTPA6jlrfBetSZKBrXUn+6JJp9ROE447mRRsu1IsDiw0/M0zmooJtgcPjSm+FLZt/SZrosaOSAqEfcdmOZICtgvY1t1nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707099904; c=relaxed/simple;
	bh=EdgEYBYZbXwgtXqXZx5g3uYb1QhMsXnYvesv8fJ9+go=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WAq1odG/XetBpjgInCB1QSWnQ9gPUdYcHYBBI6Ws8jQ3USk8v6dlVuJihsV22QWD4OGCHNxy/bGyCY0LwhfgAUZCkPnizjvTqwX6GDebsi54r9331NxqclcSZySntURwrnaFwvFe/MQPsWrktZ15Nob+zfpimYhPMirYgoNEcTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4152OhQ123017468, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4152OhQ123017468
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 10:24:44 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Mon, 5 Feb 2024 10:24:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 10:24:43 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Mon, 5 Feb 2024 10:24:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fiona Klute <fiona.klute@gmx.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Pavel Machek
	<pavel@ucw.cz>,
        =?iso-8859-2?Q?Ond=F8ej_Jirman?= <megi@xff.cz>
Subject: RE: [PATCH 4/9] wifi: rtw88: Add rtw8703b.h
Thread-Topic: [PATCH 4/9] wifi: rtw88: Add rtw8703b.h
Thread-Index: AQHaVdEBnjIVXUjW50myYkvW9x3LeLD7B6Vg
Date: Mon, 5 Feb 2024 02:24:43 +0000
Message-ID: <64e338d9e0dd43e69fa2e6e1dd3ecb2c@realtek.com>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
 <20240202121050.977223-5-fiona.klute@gmx.de>
In-Reply-To: <20240202121050.977223-5-fiona.klute@gmx.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback



> -----Original Message-----
> From: Fiona Klute <fiona.klute@gmx.de>
> Sent: Friday, February 2, 2024 8:11 PM
> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; =
linux-mmc@vger.kernel.org; Pavel
> Machek <pavel@ucw.cz>; Ond=F8ej Jirman <megi@xff.cz>; Fiona Klute <fiona.=
klute@gmx.de>
> Subject: [PATCH 4/9] wifi: rtw88: Add rtw8703b.h
>=20
> This is the main header for the new rtw88_8703b chip driver.
>=20
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> ---
>  drivers/net/wireless/realtek/rtw88/rtw8703b.h | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.h
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.h
> b/drivers/net/wireless/realtek/rtw88/rtw8703b.h
> new file mode 100644
> index 0000000000..f5ff23f2ee
> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/* Copyright Fiona Klute <fiona.klute@gmx.de> */
> +
> +#ifndef __RTW8703B_H__
> +#define __RTW8703B_H__
> +
> +extern const struct rtw_chip_info rtw8703b_hw_spec;
> +
> +/* phy status parsing */
> +#define GET_PHY_STAT_AGC_GAIN_A(phy_stat)                               =
    \
> +       (le32_get_bits(*((__le32 *)(phy_stat) + 0x00), GENMASK(6, 0)))

We are planning to use struct and le32_get_bits() directly, so don't introd=
uce
this old style anymore. An example is

struct rtw8703b_phy_stat {
	__le32 w0;
	__le32 w1;
	...
};

#define RTW8703B_PHY_STAT_W0_AGC_GAIN_A GENMASK(6, 0)

val_s8 =3D le32_get_bits(stat->w0, RTW8703B_PHY_STAT_W0_AGC_GAIN_A);

> +
> +#define GET_PHY_STAT_PWDB(phy_stat)                                     =
    \
> +       le32_get_bits(*((__le32 *)(phy_stat) + 0x01), GENMASK(7, 0))
> +#define GET_PHY_STAT_VGA(phy_stat)                                      =
    \
> +       le32_get_bits(*((__le32 *)(phy_stat) + 0x01), GENMASK(12, 8))
> +#define GET_PHY_STAT_LNA_L(phy_stat)                                    =
    \
> +       le32_get_bits(*((__le32 *)(phy_stat) + 0x01), GENMASK(15, 13))
> +/* the high LNA stat bit if 4 bit format is used */
> +#define GET_PHY_STAT_LNA_H(phy_stat)                                    =
    \
> +       le32_get_bits(*((__le32 *)(phy_stat) + 0x01), BIT(23))
> +#define BIT_LNA_H_MASK BIT(3)
> +#define BIT_LNA_L_MASK GENMASK(2, 0)
> +
> +#define GET_PHY_STAT_CFO_TAIL_A(phy_stat)                               =
    \
> +       (le32_get_bits(*((__le32 *)(phy_stat) + 0x02), GENMASK(15, 8)))
> +#define GET_PHY_STAT_RXEVM_A(phy_stat)                                  =
    \
> +       (le32_get_bits(*((__le32 *)(phy_stat) + 0x03), GENMASK(15, 8)))
> +#define GET_PHY_STAT_RXSNR_A(phy_stat)                                  =
    \
> +       (le32_get_bits(*((__le32 *)(phy_stat) + 0x03), GENMASK(31, 24)))
> +
> +/* Baseband registers */
> +#define REG_BB_PWR_SAV5_11N 0x0818
> +/* BIT(11) should be 1 for 8703B *and* 8723D, which means LNA uses 4
> + * bit for CCK rates in report, not 3. Vendor driver logs a warning if
> + * it's 0, but handles the case.
> + *
> + * Purpose of other parts of this register is unknown, 8723cs driver
> + * code indicates some other chips use certain bits for antenna
> + * diversity.
> + */
> +#define REG_BB_AMP 0x0950
> +#define BIT_MASK_RX_LNA (BIT(11))
> +
> +/* 0xaXX: 40MHz channel settings */
> +#define REG_CCK_TXSF2 0x0a24  /* CCK TX filter 2 */
> +#define REG_CCK_DBG 0x0a28  /* debug port */
> +#define REG_OFDM0_A_TX_AFE 0x0c84
> +#define REG_TXIQK_MATRIXB_LSB2_11N 0x0c9c
> +#define REG_OFDM0_TX_PSD_NOISE 0x0ce4  /* TX pseudo noise weighting */
> +/* is !=3D 0 when IQK is done */

Is this comment for 0x0e90? move to rear of the line?

> +#define REG_IQK_RDY 0x0e90
> +
> +/* RF registers */
> +#define RF_RCK1 0x1E
> +
> +#define AGG_BURST_NUM 3
> +#define AGG_BURST_SIZE 0 /* 1K */
> +#define BIT_MASK_AGG_BURST_NUM (GENMASK(3, 2))
> +#define BIT_MASK_AGG_BURST_SIZE (GENMASK(5, 4))
> +
> +#endif /* __RTW8703B_H__ */
> --
> 2.43.0
>=20


