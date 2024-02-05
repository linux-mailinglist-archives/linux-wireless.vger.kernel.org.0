Return-Path: <linux-wireless+bounces-3117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDC7849237
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 02:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426081F219E0
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 01:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFC17493;
	Mon,  5 Feb 2024 01:45:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CFF8467;
	Mon,  5 Feb 2024 01:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707097558; cv=none; b=CQPXwFBy0TofXvSKp6MkEFIgMTyLPXtTLA6gnEAX/4TqVtsyZUCsf6ZYT0qEDJT2CijdGuKTLjv6lHbPlhESkZSE1JmjUeOGpQ0p2zNFmV7JKuBmkjNqITM2CbVC+yaWTrQtFVItvaBZPB14BXfkc/TygKuPRKQGHLRwjfOSQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707097558; c=relaxed/simple;
	bh=+EbyDk/jC4cEAhnmMCEd9/IWy+urbSGU8qqV9yVUUUw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p/4RnqRg60h7JbuJpApyIJ0IFsxESN+GXnzFqysvk6AIKJAiTlYeNYYp00iwlPBKvIoQPk9wL6gJzA2SeT7cTR1n6Zj0k6Ki3IpVrQYjknHipMJk6OgQa17vzfGvK4C84sknXYr372y3WGL7Nv08ZE3ufxWkLJo3YjCl84w6pkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4151jEPK12981397, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4151jEPK12981397
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 09:45:15 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Mon, 5 Feb 2024 09:45:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 09:45:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Mon, 5 Feb 2024 09:45:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fiona Klute <fiona.klute@gmx.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Pavel Machek
	<pavel@ucw.cz>,
        =?iso-8859-2?Q?Ond=F8ej_Jirman?= <megi@xff.cz>
Subject: RE: [PATCH 1/9] wifi: rtw88: Shared module for rtw8723x devices
Thread-Topic: [PATCH 1/9] wifi: rtw88: Shared module for rtw8723x devices
Thread-Index: AQHaVdEUTzPlOvo4Mky3DaFmsU9017D6+D/g
Date: Mon, 5 Feb 2024 01:45:15 +0000
Message-ID: <ef2a9567a01642a99eb20d67269713e2@realtek.com>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
 <20240202121050.977223-2-fiona.klute@gmx.de>
In-Reply-To: <20240202121050.977223-2-fiona.klute@gmx.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



> -----Original Message-----
> From: Fiona Klute <fiona.klute@gmx.de>
> Sent: Friday, February 2, 2024 8:11 PM
> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; =
linux-mmc@vger.kernel.org; Pavel
> Machek <pavel@ucw.cz>; Ond=F8ej Jirman <megi@xff.cz>; Fiona Klute <fiona.=
klute@gmx.de>
> Subject: [PATCH 1/9] wifi: rtw88: Shared module for rtw8723x devices
>=20
> The already supported 8723d chip is very similar to 8703b/8723cs,
> split code that can be shared into a new module. The spec definition
> tables are combined into a struct so we only need one EXPORT_SYMBOL
> for them all.
>=20
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> ---
> I'm not sure how who should be MODULE_AUTHOR in rtw8723x.c. Most of
> the code is from rtw8723d, I created the separate module. I don't want
> to claim authorship over code I didn't write, but assigning authorship
> unasked (by copying the MODULE_AUTHOR from rtw8723d.c) also seems
> wrong.

If two MODULE_AUTHOR are allowed, maybe list both?=20

[...]

> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> index c575476a00..68245f34b5 100644
> --- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c

[...]

> @@ -930,6 +532,8 @@ static u8 rtw8723d_iqk_check_rx_failed(struct rtw_dev=
 *rtwdev,
>         return 0;
>  }
>=20
> +#define IQK_LTE_WRITE_VAL 0x0000ff00
> +
>  static void rtw8723d_iqk_one_shot(struct rtw_dev *rtwdev, bool tx,
>                                   const struct rtw_8723d_iqk_cfg *iqk_cfg=
)
>  {
> @@ -937,7 +541,7 @@ static void rtw8723d_iqk_one_shot(struct rtw_dev *rtw=
dev, bool tx,
>=20
>         /* enter IQK mode */
>         rtw_write32_mask(rtwdev, REG_FPGA0_IQK_11N, BIT_MASK_IQK_MOD, EN_=
IQK);
> -       rtw8723d_iqk_config_lte_path_gnt(rtwdev);
> +       rtw8723x_iqk_config_lte_path_gnt(rtwdev, IQK_LTE_WRITE_VAL);

It would be better to discriminate IQK_LTE_WRITE_VAL_8723D and
IQK_LTE_WRITE_VAL_8703B to prevent misreading.=20

>=20
>         rtw_write32(rtwdev, REG_LTECOEX_CTRL, 0x800f0054);
>         mdelay(1);

[...]

> +#define ADDA_ON_VAL 0x03c00016
>=20
>  static
> -void rtw8723d_iqk_precfg_path(struct rtw_dev *rtwdev, enum rtw8723d_path=
 path)
> +void rtw8723d_iqk_precfg_path(struct rtw_dev *rtwdev, enum rtw8723x_path=
 path)
>  {
>         if (path =3D=3D PATH_S0) {
>                 rtw8723d_iqk_rf_standby(rtwdev, RF_PATH_A);
> -               rtw8723d_iqk_path_adda_on(rtwdev);
> +               rtw8723x_iqk_path_adda_on(rtwdev, ADDA_ON_VAL);

ditto. (I don't point out more similar things later)

>         }
>=20
>         rtw_write32_mask(rtwdev, REG_FPGA0_IQK_11N, BIT_MASK_IQK_MOD, EN_=
IQK);

[...]

> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.c
> b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
> new file mode 100644
> index 0000000000..2b58064547
> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
> @@ -0,0 +1,561 @@

[...]

> +const struct rtw8723x_common rtw8723x_common =3D {
> +       .iqk_adda_regs =3D {
> +               0x85c, 0xe6c, 0xe70, 0xe74, 0xe78, 0xe7c, 0xe80, 0xe84,
> +               0xe88, 0xe8c, 0xed0, 0xed4, 0xed8, 0xedc, 0xee0, 0xeec
> +       },
> +       .iqk_mac8_regs =3D {0x522, 0x550, 0x551},
> +       .iqk_mac32_regs =3D {0x40},
> +       .iqk_bb_regs =3D {
> +               0xc04, 0xc08, 0x874, 0xb68, 0xb6c, 0x870, 0x860, 0x864, 0=
xa04
> +       },
> +
> +       .ltecoex_addr =3D {
> +               .ctrl =3D REG_LTECOEX_CTRL,
> +               .wdata =3D REG_LTECOEX_WRITE_DATA,
> +               .rdata =3D REG_LTECOEX_READ_DATA,
> +       },
> +       .rf_sipi_addr =3D {
> +               [RF_PATH_A] =3D { .hssi_1 =3D 0x820, .lssi_read    =3D 0x=
8a0,
> +                               .hssi_2 =3D 0x824, .lssi_read_pi =3D 0x8b=
8},
> +               [RF_PATH_B] =3D { .hssi_1 =3D 0x828, .lssi_read    =3D 0x=
8a4,
> +                               .hssi_2 =3D 0x82c, .lssi_read_pi =3D 0x8b=
c},
> +       },
> +       .dig =3D {
> +               [0] =3D { .addr =3D 0xc50, .mask =3D 0x7f },
> +               [1] =3D { .addr =3D 0xc50, .mask =3D 0x7f },
> +       },
> +       .dig_cck =3D {
> +               [0] =3D { .addr =3D 0xa0c, .mask =3D 0x3f00 },
> +       },
> +       .prioq_addrs =3D {
> +               .prio[RTW_DMA_MAPPING_EXTRA] =3D {
> +                       .rsvd =3D REG_RQPN_NPQ + 2, .avail =3D REG_RQPN_N=
PQ + 3,
> +               },
> +               .prio[RTW_DMA_MAPPING_LOW] =3D {
> +                       .rsvd =3D REG_RQPN + 1, .avail =3D REG_FIFOPAGE_C=
TRL_2 + 1,
> +               },
> +               .prio[RTW_DMA_MAPPING_NORMAL] =3D {
> +                       .rsvd =3D REG_RQPN_NPQ, .avail =3D REG_RQPN_NPQ +=
 1,
> +               },
> +               .prio[RTW_DMA_MAPPING_HIGH] =3D {
> +                       .rsvd =3D REG_RQPN, .avail =3D REG_FIFOPAGE_CTRL_=
2,
> +               },
> +               .wsize =3D false,
> +       },
> +
> +       .lck =3D __rtw8723x_lck,
> +       .read_efuse =3D __rtw8723x_read_efuse,
> +       .mac_init =3D __rtw8723x_mac_init,
> +       .cfg_ldo25 =3D __rtw8723x_cfg_ldo25,
> +       .set_tx_power_index =3D __rtw8723x_set_tx_power_index,
> +       .efuse_grant =3D __rtw8723x_efuse_grant,
> +       .false_alarm_statistics =3D __rtw8723x_false_alarm_statistics,
> +       .iqk_backup_regs =3D __rtw8723x_iqk_backup_regs,
> +       .iqk_restore_regs =3D __rtw8723x_iqk_restore_regs,
> +       .iqk_similarity_cmp =3D __rtw8723x_iqk_similarity_cmp,
> +       .pwrtrack_get_limit_ofdm =3D __rtw8723x_pwrtrack_get_limit_ofdm,
> +       .pwrtrack_set_xtal =3D __rtw8723x_pwrtrack_set_xtal,
> +       .coex_cfg_init =3D __rtw8723x_coex_cfg_init,
> +       .fill_txdesc_checksum =3D __rtw8723x_fill_txdesc_checksum,
> +};
> +EXPORT_SYMBOL(rtw8723x_common);

I think these are just copy-and-paste stuff. Is there anything special you =
want
me look deeper?


> +
> +MODULE_AUTHOR("Fiona Klute <fiona.klute@gmx.de>");
> +MODULE_DESCRIPTION("Common functions for Realtek 802.11n wireless 8723x =
drivers");
> +MODULE_LICENSE("Dual BSD/GPL");
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.h
> b/drivers/net/wireless/realtek/rtw88/rtw8723x.h
> new file mode 100644
> index 0000000000..d3930f1f2c
> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.h

[...]


> +/* IQK helper functions, defined as inline so they can be shared
> + * without needing an EXPORT_SYMBOL each.
> + */
> +inline void

These inline functions should be 'static'.=20
(I believe you have addressed this, and will change them by v2.)

> +rtw8723x_iqk_backup_path_ctrl(struct rtw_dev *rtwdev,
> +                             struct rtw8723x_iqk_backup_regs *backup)
> +{
> +       backup->btg_sel =3D rtw_read8(rtwdev, REG_BTG_SEL);
> +       rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] original 0x67 =3D 0x%x\n",
> +               backup->btg_sel);
> +}
> +

[...]


