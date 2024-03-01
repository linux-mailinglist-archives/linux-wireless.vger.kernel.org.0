Return-Path: <linux-wireless+bounces-4286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB1886D9CC
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 03:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97D16B22157
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 02:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BE03FB15;
	Fri,  1 Mar 2024 02:33:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A116A37153;
	Fri,  1 Mar 2024 02:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709260415; cv=none; b=dhrlccxQPTdMR+5j2HGE8GFzfWx0Oapw8lMYcyY4B0m/fHik/uEpkBLtocgvWMyL2t2Sf8z8wh53KoWirbd7M3UKJofMjhcplj2FQSVtZOElMBr85rCd/bnR7PboEOXmX29vwT9lcE20KKwqWBIxR0maUUoaHZFsV/y4IzQ6Sh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709260415; c=relaxed/simple;
	bh=3+tJI3TzuprbpWVWEn3ul3kSFMcvmd8KK6ZAYVfd7rA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=psJztt05Q2nufIUg63awprYi4zElYZ5AnTL2gBR75+enp6mKJPmU3y1vf0al+4qggPEHUa69a/AkaOmCcxfnddUC2bIzt6Tx85CqQg87O6ZjCrqWe0hOnuiKBv4xS2xRVYnmG7A+uDWLDEc1M6oDsSzaO/L7iZ+wh5g82wGPNh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4212X8Z301838529, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4212X8Z301838529
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 10:33:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 1 Mar 2024 10:33:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 10:33:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Fri, 1 Mar 2024 10:33:08 +0800
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
Subject: RE: [PATCH v2 5/9] wifi: rtw88: Add rtw8703b.c
Thread-Topic: [PATCH v2 5/9] wifi: rtw88: Add rtw8703b.c
Thread-Index: AQHaadh8n611UJm6iUqkDrqnT0K/C7EiKLcw
Date: Fri, 1 Mar 2024 02:33:07 +0000
Message-ID: <3805850d51334319984bc304ca1dc3c4@realtek.com>
References: <20240227235507.781615-1-fiona.klute@gmx.de>
 <20240227235507.781615-6-fiona.klute@gmx.de>
In-Reply-To: <20240227235507.781615-6-fiona.klute@gmx.de>
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
> Subject: [PATCH v2 5/9] wifi: rtw88: Add rtw8703b.c
>=20
> This is the main source for the new rtw88_8703b chip driver.
>=20
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> ---
>  drivers/net/wireless/realtek/rtw88/rtw8703b.c | 2112 +++++++++++++++++
>  1 file changed, 2112 insertions(+)
>  create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.c
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
> b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
> new file mode 100644
> index 00000000000..83b1da60eb4
> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
> @@ -0,0 +1,2112 @@
> +// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
> +/* Copyright Fiona Klute <fiona.klute@gmx.de> */
> +
> +#include <linux/of_net.h>
> +#include "main.h"
> +#include "coex.h"
> +#include "debug.h"
> +#include "mac.h"
> +#include "phy.h"
> +#include "reg.h"
> +#include "rx.h"
> +#include "rtw8703b.h"
> +#include "rtw8703b_tables.h"
> +#include "rtw8723x.h"
> +
> +#define GET_RX_DESC_BW(rxdesc)                                          =
    \
> +       (le32_get_bits(*((__le32 *)(rxdesc) + 0x04), GENMASK(31, 24)))

Can we move this to rx.h GET_RX_DESC_xxx()?=20

> +
> +#define BIT_MASK_TXQ_INIT (BIT(7))
> +#define WLAN_RL_VAL 0x3030
> +/* disable BAR */
> +#define WLAN_BAR_VAL 0x0201ffff
> +#define WLAN_PIFS_VAL 0
> +#define WLAN_RX_PKT_LIMIT 0x18
> +#define WLAN_SLOT_TIME 0x09
> +#define WLAN_SPEC_SIFS 0x100a
> +#define WLAN_MAX_AGG_NR 0x1f
> +#define WLAN_AMPDU_MAX_TIME 0x70
> +
> +/* unit is 32us */
> +#define TBTT_PROHIBIT_SETUP_TIME 0x04
> +#define TBTT_PROHIBIT_HOLD_TIME 0x80
> +#define TBTT_PROHIBIT_HOLD_TIME_STOP_BCN 0x64
> +
> +/* raw pkt_stat->drv_info_sz is in unit of 8-bytes */
> +#define RX_DRV_INFO_SZ_UNIT_8703B 8
> +
> +#define TRANS_SEQ_END                  \
> +       {0xFFFF,                        \
> +        RTW_PWR_CUT_ALL_MSK,           \
> +        RTW_PWR_INTF_ALL_MSK,          \
> +        0,                             \
> +        RTW_PWR_CMD_END, 0, 0}

Move this macro to main.h along with RTW_PWR_CUT_ALL_MSK.

> +
> +static void rtw8703b_cfg_notch(struct rtw_dev *rtwdev, u8 channel, bool =
notch)
> +{
> +       if (!notch) {
> +               rtw_write32_mask(rtwdev, REG_OFDM0_RXDSP, BIT_MASK_RXDSP,=
 0x1f);
> +               rtw_write32_mask(rtwdev, REG_OFDM0_RXDSP, BIT_EN_RXDSP, 0=
x0);
> +               rtw_write32(rtwdev, REG_OFDM1_CSI1, 0x00000000);
> +               rtw_write32(rtwdev, REG_OFDM1_CSI2, 0x00000000);
> +               rtw_write32(rtwdev, REG_OFDM1_CSI3, 0x00000000);
> +               rtw_write32(rtwdev, REG_OFDM1_CSI4, 0x00000000);
> +               rtw_write32_mask(rtwdev, REG_OFDM1_CFOTRK, BIT_EN_CFOTRK,=
 0x0);
> +               return;
> +       }
> +
> +       switch (channel) {
> +       case 5:
> +               fallthrough;

no need fallthrough unless you do something by case 5.

> +       case 13:
> +               rtw_write32_mask(rtwdev, REG_OFDM0_RXDSP, BIT_MASK_RXDSP,=
 0xb);
> +               rtw_write32_mask(rtwdev, REG_OFDM0_RXDSP, BIT_EN_RXDSP, 0=
x1);
> +               rtw_write32(rtwdev, REG_OFDM1_CSI1, 0x06000000);
> +               rtw_write32(rtwdev, REG_OFDM1_CSI2, 0x00000000);
> +               rtw_write32(rtwdev, REG_OFDM1_CSI3, 0x00000000);
> +               rtw_write32(rtwdev, REG_OFDM1_CSI4, 0x00000000);
> +               rtw_write32_mask(rtwdev, REG_OFDM1_CFOTRK, BIT_EN_CFOTRK,=
 0x1);
> +               break;

[...]





