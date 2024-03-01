Return-Path: <linux-wireless+bounces-4284-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB1D86D967
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 03:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D1EEB219F6
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 02:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A953A1D3;
	Fri,  1 Mar 2024 02:09:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91B33A1C7;
	Fri,  1 Mar 2024 02:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709258997; cv=none; b=rFsyR9dpzVjy3787NKQABZC3bktn3UqJ1igZ04U7Q9QQvJu0CT8wC0XiQ8aZ2g5H+GB4HjjoEiakZOXKkTywCH95TfzPddSuY0rhKCiv9UQIubkEn6+UEEiBvNPTELFCYkuwcR0flN6SftBX8+k++0QA3qjdzm3JXgKuJ5jKdjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709258997; c=relaxed/simple;
	bh=wKbzgF7btcnqKbKR5CyMWZfzZIgS+eVlx7Eybf3w1Qg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o6957BTkefpoU7GCH4DZotm2Jp/NF9bmkVRgW0epZ5fEZJKoLfRsS6nPqBuWmN8tw2W5Ultqfp5ueIlIASFGTVnpIuEapSHm4OL12aUctOTQO9LE4cP0OklfSaVxpnSbvQL7KEE+SBx6jC4mRgiLIVSomH1RZS78Ii3SyiwmWtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42129PRA01814929, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42129PRA01814929
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 10:09:26 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 1 Mar 2024 10:09:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 10:09:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Fri, 1 Mar 2024 10:09:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fiona Klute <fiona.klute@gmx.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "kvalo@kernel.org" <kvalo@kernel.org>,
        "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "megi@xff.cz"
	<megi@xff.cz>
Subject: RE: [PATCH v2 4/9] wifi: rtw88: Add rtw8703b.h
Thread-Topic: [PATCH v2 4/9] wifi: rtw88: Add rtw8703b.h
Thread-Index: AQHaadiMK/BK89PGSkKvgAdLkkf/lLEiJPZA
Date: Fri, 1 Mar 2024 02:09:25 +0000
Message-ID: <368ebc04c2ec436791a27b5661189783@realtek.com>
References: <20240227235507.781615-1-fiona.klute@gmx.de>
 <20240227235507.781615-5-fiona.klute@gmx.de>
In-Reply-To: <20240227235507.781615-5-fiona.klute@gmx.de>
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



> -----Original Message-----
> From: Fiona Klute <fiona.klute@gmx.de>
> Sent: Wednesday, February 28, 2024 7:55 AM
> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
> Cc: Fiona Klute <fiona.klute@gmx.de>; kvalo@kernel.org; ulf.hansson@linar=
o.org; linux-mmc@vger.kernel.org;
> pavel@ucw.cz; megi@xff.cz
> Subject: [PATCH v2 4/9] wifi: rtw88: Add rtw8703b.h
>=20
> This is the main header for the new rtw88_8703b chip driver.
>=20
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> ---
>  drivers/net/wireless/realtek/rtw88/rtw8703b.h | 103 ++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.h
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.h
> b/drivers/net/wireless/realtek/rtw88/rtw8703b.h
> new file mode 100644
> index 00000000000..69dac101d33
> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.h
> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
> +/* Copyright Fiona Klute <fiona.klute@gmx.de> */
> +
> +#ifndef __RTW8703B_H__
> +#define __RTW8703B_H__
> +
> +#include <linux/types.h>
> +#include <linux/compiler_attributes.h>

Removing these two headers can still compiled pass in my side. Please check=
 why
you need them.

By the way, rtw8723d.h does
   #include "rtw8723x.h"

Can we use the same stuff?


> +
> +extern const struct rtw_chip_info rtw8703b_hw_spec;
> +
> +/* phy status parsing */
> +#define VGA_BITS GENMASK(4, 0)
> +#define LNA_L_BITS GENMASK(7, 5)
> +#define LNA_H_BIT BIT(7)
> +/* masks for assembling LNA index from high and low bits */
> +#define BIT_LNA_H_MASK BIT(3)
> +#define BIT_LNA_L_MASK GENMASK(2, 0)
> +
> +struct phy_rx_agc_info {
> +#ifdef __LITTLE_ENDIAN
> +       u8 gain: 7;
> +       u8 trsw: 1;
> +#else
> +       u8 trsw: 1;
> +       u8 gain: 7;
> +#endif
> +} __packed;

This struct is quite simple, or I will suggest to define MASK and access th=
em
by u8_get_bits(), like

#define RX_AGC_GAIN GENMASK(6, 0)
gain =3D u8_get_bits(RX_AGC_GAIN, raw);

Then,=20
struct phy_status_8703b {
	u8 path_agc[2];
	...

Just for reference. You can decide if changing to this style.=20

> +
> +/* This struct is called phy_status_rpt_8192cd in the vendor driver,
> + * there might be potential to share it with drivers for other chips
> + * of the same generation.
> + */
> +struct phy_status_8703b {
> +       struct phy_rx_agc_info path_agc[2];
> +       u8 ch_corr[2];
> +       u8 cck_sig_qual_ofdm_pwdb_all;
> +       /* for CCK: bits 0:4: VGA index, bits 5:7: LNA index (low) */
> +       u8 cck_agc_rpt_ofdm_cfosho_a;
> +       /* for CCK: bit 7 is high bit of LNA index if long report type */
> +       u8 cck_rpt_b_ofdm_cfosho_b;
> +       u8 reserved_1;
> +       u8 noise_power_db_msb;
> +       s8 path_cfotail[2];
> +       u8 pcts_mask[2];
> +       s8 stream_rxevm[2];
> +       u8 path_rxsnr[2];
> +       u8 noise_power_db_lsb;
> +       u8 reserved_2[3];
> +       u8 stream_csi[2];
> +       u8 stream_target_csi[2];
> +       s8 sig_evm;
> +       u8 reserved_3;
> +
> +#ifdef __LITTLE_ENDIAN
> +       u8 antsel_rx_keep_2: 1;
> +       u8 sgi_en: 1;
> +       u8 rxsc: 2;
> +       u8 idle_long: 1;
> +       u8 r_ant_train_en: 1;
> +       u8 ant_sel_b: 1;
> +       u8 ant_sel: 1;
> +#else /* __BIG_ENDIAN */
> +       u8 ant_sel: 1;
> +       u8 ant_sel_b: 1;
> +       u8 r_ant_train_en: 1;
> +       u8 idle_long: 1;
> +       u8 rxsc: 2;
> +       u8 sgi_en: 1;
> +       u8 antsel_rx_keep_2: 1;
> +#endif
> +} __packed;
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
> +#define REG_IQK_RDY 0x0e90  /* is !=3D 0 when IQK is done */
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


