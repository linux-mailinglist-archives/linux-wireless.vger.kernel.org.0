Return-Path: <linux-wireless+bounces-3120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095C0849298
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 04:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 344721C21E38
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Feb 2024 03:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F7C8F51;
	Mon,  5 Feb 2024 03:02:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D608F40;
	Mon,  5 Feb 2024 03:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707102135; cv=none; b=peMowPuzmydsS0Zi1K4Iqy0q6Aix9ASZrubPSCaK9ASHed6W+0lc7abreWRQBSCzigGZs3d6iciYIfGkjoUkSLtO994UaQUm8cxt2MLvJkbUT+kegwth2i1BchK2phFA0I3CJlPiDQGZ0JKvMH3mUPFkN/pwCXkTgpGCI5JQXVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707102135; c=relaxed/simple;
	bh=7j0m3mi/g0wR+ttLaeDuMzQ81Xc3XPiiw7eZkpWVXNE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WWpuuuTz45zAp9w3xCS862f+MnVSqLzWdQMjn9My/+tdet/DVnGqmPdz24q9yjDu+ahW+3Y0Gh1mL1f5p9ETVzBlH0th+uJy9v+1pLPtuXcpra1bHlj+L+TirO2i1mdsRQI1MxQ5nmtaOqfrWsWUf6dUd6XlGGNNVEZw5aAvlyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41531ebX63032400, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41531ebX63032400
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 11:01:40 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Mon, 5 Feb 2024 11:01:40 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 11:01:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Mon, 5 Feb 2024 11:01:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fiona Klute <fiona.klute@gmx.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Pavel Machek
	<pavel@ucw.cz>,
        =?iso-8859-2?Q?Ond=F8ej_Jirman?= <megi@xff.cz>
Subject: RE: [PATCH 5/9] wifi: rtw88: Add rtw8703b.c
Thread-Topic: [PATCH 5/9] wifi: rtw88: Add rtw8703b.c
Thread-Index: AQHaVdEYYqBCMRgw70+09sEUFj+8t7D7CVrA
Date: Mon, 5 Feb 2024 03:01:39 +0000
Message-ID: <8b20f91585694702bac414680ba937c9@realtek.com>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
 <20240202121050.977223-6-fiona.klute@gmx.de>
In-Reply-To: <20240202121050.977223-6-fiona.klute@gmx.de>
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



> -----Original Message-----
> From: Fiona Klute <fiona.klute@gmx.de>
> Sent: Friday, February 2, 2024 8:11 PM
> To: linux-wireless@vger.kernel.org; Ping-Ke Shih <pkshih@realtek.com>
> Cc: Kalle Valo <kvalo@kernel.org>; Ulf Hansson <ulf.hansson@linaro.org>; =
linux-mmc@vger.kernel.org; Pavel
> Machek <pavel@ucw.cz>; Ond=F8ej Jirman <megi@xff.cz>; Fiona Klute <fiona.=
klute@gmx.de>
> Subject: [PATCH 5/9] wifi: rtw88: Add rtw8703b.c
>=20
> This is the main source for the new rtw88_8703b chip driver.
>=20
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> ---
>=20
> rtw8703b_read_efuse retrieves the MAC address from DT, if
> available. The code is not tied to any particular hardware, but
> required to get a persistent address on the Pinephone. Do I need to
> add a DT binding for this? Also, I think this could be moved into
> rtw_chip_efuse_info_setup(), in preference to falling back to a random
> MAC if there isn't a valid one in EFUSE. Would that be acceptable? If
> yes, should EFUSE or DT take priority?
>=20
> All the RTL8723CS EFUSE samples I've seen so far contain almost
> entirely invalid data (all 0xff, except rtl_id, afe, and
> thermal_meter), so I've added fallbacks in the EFUSE parser. In some
> cases they alter specific bits so parsing in rtw_chip_efuse_info_setup
> will get the right results. I'm not sure if this is the best approach:
> The good part is that it works without changing the core EFUSE code,
> the negative is that it's not visible to the core code that a fallback
> has been applied. What do you think?

I think efuse take priority, but you have said most are invalid data, so
you can write a rule to determine efuse is valid before using them. If
invalid, just use DT.

Sorry, I'm not familiar with DT, could you show me an example of DT node?=20


>=20
>  drivers/net/wireless/realtek/rtw88/rtw8703b.c | 2106 +++++++++++++++++
>  1 file changed, 2106 insertions(+)
>  create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.c
>=20
> diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
> b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
> new file mode 100644
> index 0000000000..ac9b1bf6ea
> --- /dev/null
> +++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
> @@ -0,0 +1,2106 @@
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

use struct and le32_get_bits() directly.=20

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
> +#define TRANS_SEQ_END \
> +       { \
> +               0xFFFF, \
> +               RTW_PWR_CUT_ALL_MSK, \
> +               RTW_PWR_INTF_ALL_MSK, \
> +               0, \
> +               RTW_PWR_CMD_END, 0, 0}

nit: This looks a little odd, not like others of trans_pre_enable_8703b[].
How about this:=20

#define TRANS_SEQ_END \
	{0xFFFF, \
	 RTW_PWR_CUT_ALL_MSK, \
	 RTW_PWR_INTF_ALL_MSK, \
	 0, \
	 RTW_PWR_CMD_END, 0, 0}

[...]

> +static const u8 rtw8703b_cck_swing_table[][16] =3D {
> +       {0x44, 0x42, 0x3C, 0x33, 0x28, 0x1C, 0x13, 0x0B, 0x05, 0x02,
> +               0x00, 0x00, 0x00, 0x00, 0x00, 0x00}, /*-16dB*/

nit: align "{" ?

	{0x44, 0x42, 0x3C, 0x33, 0x28, 0x1C, 0x13, 0x0B, 0x05, 0x02,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00}, /*-16dB*/

[...]

> +
> +/* Default power index table for RTL8703B, used if EFUSE does not
> + * contain valid data. Replaces EFUSE data from offset 0x10 (start of
> + * txpwr_idx_table).
> + */
> +static const u8 rtw8703b_txpwr_idx_table[] =3D {
> +       0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x2D,
> +       0x2D, 0x2D, 0x2D, 0x2D, 0x2D, 0x02
> +};
> +
> +#define RTW8703B_TXPWR_IDX_TABLE_LEN ARRAY_SIZE(rtw8703b_txpwr_idx_table=
)

nit: This definition seems not save much.

> +
> +#define DBG_EFUSE_FIX(name)                                         \

suggest to not hide 'rtwdev'

> +       rtw_dbg(rtwdev, RTW_DBG_EFUSE, "Fixed invalid EFUSE value: " \
> +               # name "=3D0x%x\n", rtwdev->efuse.name)

a blank line?

> +static int rtw8703b_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
> +{
> +       struct rtw_efuse *efuse =3D &rtwdev->efuse;
> +       int ret =3D rtw8723x_read_efuse(rtwdev, log_map);

I prefer

	int ret;

	ret =3D rtw8723x_read_efuse(rtwdev, log_map);
	if (ret)
		return ret;


> +
> +       if (ret !=3D 0)
> +               return ret;
> +
> +#ifdef CONFIG_OF
> +       /* Prefer MAC from DT, if available. On some devices like the
> +        * Pinephone that might be the only way to get a valid MAC.
> +        */
> +       struct device_node *node =3D rtwdev->dev->of_node;

Should move this statement to topmost of this function? no compiler warning=
?=20

Or, make an individual function to read mac addr from DT?

> +
> +       if (node) {
> +               ret =3D of_get_mac_address(node, efuse->addr);
> +               if (ret =3D=3D 0) {
> +                       rtw_dbg(rtwdev, RTW_DBG_EFUSE,
> +                               "got wifi mac address from DT: %pM\n",
> +                               efuse->addr);
> +               }
> +       }
> +#endif /* CONFIG_OF */
> +
> +       /* If TX power index table in EFUSE is invalid, fall back to
> +        * built-in table.
> +        */
> +       u8 *pwr =3D (u8 *)efuse->txpwr_idx_table;
> +       bool valid =3D false;

I tend to move these declaration to top of this function too, but not sure =
why
compiler also doesn't warn this in my side. Seemingly kernel changes defaul=
t
compiler flags?=20


[...]

> +static void rtw8703b_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, =
u8 bw,
> +                                   u8 primary_ch_idx)
> +{
> +       const struct rtw_backup_info *cck_dfir;
> +       int i;
> +
> +       cck_dfir =3D channel <=3D 13 ? cck_dfir_cfg[0] : cck_dfir_cfg[1];
> +
> +       for (i =3D 0; i < CCK_DFIR_NR_8703B; i++, cck_dfir++)
> +               rtw_write32(rtwdev, cck_dfir->reg, cck_dfir->val);
> +
> +       switch (bw) {
> +       case RTW_CHANNEL_WIDTH_20:
> +               rtw_write32_mask(rtwdev, REG_FPGA0_RFMOD, BIT_MASK_RFMOD,=
 0x0);
> +               rtw_write32_mask(rtwdev, REG_FPGA1_RFMOD, BIT_MASK_RFMOD,=
 0x0);
> +               rtw_write32_mask(rtwdev, REG_OFDM0_TX_PSD_NOISE,
> +                                GENMASK(31, 20), 0x0);
> +               rtw_write32(rtwdev, REG_BBRX_DFIR, 0x4A880000);
> +               rtw_write32(rtwdev, REG_OFDM0_A_TX_AFE, 0x19F60000);
> +               break;
> +       case RTW_CHANNEL_WIDTH_40:
> +               rtw_write32_mask(rtwdev, REG_FPGA0_RFMOD, BIT_MASK_RFMOD,=
 0x1);
> +               rtw_write32_mask(rtwdev, REG_FPGA1_RFMOD, BIT_MASK_RFMOD,=
 0x1);
> +               rtw_write32(rtwdev, REG_BBRX_DFIR, 0x40100000);
> +               rtw_write32(rtwdev, REG_OFDM0_A_TX_AFE, 0x51F60000);
> +               rtw_write32_mask(rtwdev, REG_CCK0_SYS, BIT_CCK_SIDE_BAND,
> +                                (primary_ch_idx =3D=3D RTW_SC_20_UPPER ?=
 1 : 0));

unnecessary parenthesis around ? :

> +               rtw_write32_mask(rtwdev, REG_OFDM_FA_RSTD_11N, 0xC00,
> +                                primary_ch_idx =3D=3D RTW_SC_20_UPPER ? =
2 : 1);
> +
> +               rtw_write32_mask(rtwdev, REG_BB_PWR_SAV5_11N, GENMASK(27,=
 26),
> +                                primary_ch_idx =3D=3D RTW_SC_20_UPPER ? =
1 : 2);
> +               break;
> +       default:
> +               break;
> +       }
> +}
> +

[...]

> +static void rtw8703b_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
> +                                  struct rtw_rx_pkt_stat *pkt_stat,
> +                                  struct ieee80211_rx_status *rx_status)
> +{
> +       struct ieee80211_hdr *hdr;
> +       u32 desc_sz =3D rtwdev->chip->rx_pkt_desc_sz;
> +       u8 *phy_status =3D NULL;
> +
> +       memset(pkt_stat, 0, sizeof(*pkt_stat));
> +
> +       pkt_stat->phy_status =3D GET_RX_DESC_PHYST(rx_desc);
> +       pkt_stat->icv_err =3D GET_RX_DESC_ICV_ERR(rx_desc);
> +       pkt_stat->crc_err =3D GET_RX_DESC_CRC32(rx_desc);
> +       pkt_stat->decrypted =3D !GET_RX_DESC_SWDEC(rx_desc) &&
> +                             GET_RX_DESC_ENC_TYPE(rx_desc) !=3D RX_DESC_=
ENC_NONE;
> +       pkt_stat->is_c2h =3D GET_RX_DESC_C2H(rx_desc);
> +       pkt_stat->pkt_len =3D GET_RX_DESC_PKT_LEN(rx_desc);
> +       pkt_stat->drv_info_sz =3D GET_RX_DESC_DRV_INFO_SIZE(rx_desc);
> +       pkt_stat->shift =3D GET_RX_DESC_SHIFT(rx_desc);
> +       pkt_stat->rate =3D GET_RX_DESC_RX_RATE(rx_desc);
> +       pkt_stat->cam_id =3D GET_RX_DESC_MACID(rx_desc);
> +       pkt_stat->ppdu_cnt =3D 0;
> +       pkt_stat->tsf_low =3D GET_RX_DESC_TSFL(rx_desc);

Could you add a separate patch to convert these macros to struct style?=20
It is fine to keep as it was, and do this conversion afterward. =20

[...]

> +static
> +void rtw8703b_iqk_fill_a_matrix(struct rtw_dev *rtwdev, const s32 result=
[])
> +{
> +       s32 oldval_1;
> +       s32 x, y;
> +       s32 tx1_a, tx1_a_ext;
> +       s32 tx1_c, tx1_c_ext;
> +       u32 tmp_rx_iqi =3D 0x40000100 & GENMASK(31, 16);

reverse X'mas tree order


> +
> +static void rtw8703b_phy_calibration(struct rtw_dev *rtwdev)
> +{
> +       /* For some reason path A is called S1 and B S0 in shared
> +        * rtw88 calibration data.
> +        */
> +       struct rtw_dm_info *dm_info =3D &rtwdev->dm_info;
> +       s32 result[IQK_ROUND_SIZE][IQK_NR];
> +       struct rtw8723x_iqk_backup_regs backup;
> +       u8 i, j;
> +       u8 final_candidate =3D IQK_ROUND_INVALID;
> +       bool good;

reverse X'mas tree order

> +MODULE_FIRMWARE("rtw88/rtw8703b_wow_fw.bin");

Just curious. Have you tried WOW for this chip?=20



