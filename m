Return-Path: <linux-wireless+bounces-4514-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 796208770D9
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 12:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8E011F2171F
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 11:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BCC3A1CD;
	Sat,  9 Mar 2024 11:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="HyWAMzNt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0A439AD5;
	Sat,  9 Mar 2024 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709985470; cv=none; b=Zlx3Zb5E4w6Mo6Vd6q19FNfZGnRTyY0YBE/2bHAGNqm5pet58wL5ZGPLXBUgfGH2LpryAVNpigM+cseec0thAHTsjO+nry+nFtkZ7ARVKUpFdpWAWm+ChPSIG9vIj1SoIFFy8GtChTSata0sQTrg0FFCCY0ltPkOolyff7vwB0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709985470; c=relaxed/simple;
	bh=asIyRKUqD/SqGU88du+2ZMNTAKoRoXyMVaBC7MLIqeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKhBxZxVXUUSfIocrtD7nXN6sJNBqLCR3wtjith7Z+1M4ym4O6AfLaw3aNaLjmCDcsym1fRY91Q9ReeVgfQoVkrU1Sn5WrV8PC0JRvLEQONUCa2cW/Dtp0ThiHkzlKj82bfFy0+BeutEoA5DAqD0IJD6NudNVLCfXV2BeEpxizI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=HyWAMzNt; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709985449; x=1710590249; i=fiona.klute@gmx.de;
	bh=asIyRKUqD/SqGU88du+2ZMNTAKoRoXyMVaBC7MLIqeo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=HyWAMzNtCanS777pPJGpzQwwP0j6Eu8nVfBMo1QQwKqPJergGjyGD5H/wlILOhTF
	 TPwof2UrHMM5s+LVsReEuuCYZe5lz4ovFLLZXs5/1aV+NoWRkTl8Fxy3xA7KScOY/
	 /eI2xOUcioxSU2nW2l+KYYIRhdfqdIloXewEKEUfMHdlLjghxeB0UbiWpQOImbBaa
	 eEf5mH1rjxNYn+aCwgDxS5+vCAzdNdOasN6YZ8TYxLVKI6bPsv/dLQS399lzh2e2G
	 OBOUnFjJIaJW1qX3/Qx8VKOvO1Q0Bx0lZl4uyyl08Gz9vxVKFxgVI2CtfOBIbWi3R
	 jjfog876Um3t8xiHug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.112.71]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsnP-1rODgL09sL-00LDeS; Sat, 09
 Mar 2024 12:57:28 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: Fiona Klute <fiona.klute@gmx.de>,
	Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
Subject: [PATCH v3 1/9] wifi: rtw88: Shared module for rtw8723x devices
Date: Sat,  9 Mar 2024 12:56:37 +0100
Message-ID: <20240309115650.367204-2-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240309115650.367204-1-fiona.klute@gmx.de>
References: <20240309115650.367204-1-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WgiOHY5P5Qt95c3RxGuGYfOljWGVP5sC1Kqx3NPGPMe1tEy1Y0f
 MRRUzDfJjz43kHFxs6nVaL7i7GEVJsUbD3xDeotgFsIM4zByimicg/KcgEZ2VV29KGi+3Zb
 /ZoenHemELtKlAcIxvQN/4dVh/8QDmCpgZiVJxy8vq6MfwJOk/MKSFiTBeom4QqWdrIk45G
 IFv9sClc1P5cCTx5v66Tg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q4ds8tVFqmo=;lJbT1ee4ESh98qxcxvC5cQBNAN7
 k5nIU3OwCMv1l075mwKxEB7aXT8LIVS3a9hdGxmLicawuKC71BGUeVGc69V80LwjRg60Hn5j2
 MPaXsTj5Kp5PTqQngZEvmg2/AftBD0DVAG+tMJUuXyESrvEPpFR48xe+B/PVBWsqyXQvqTt0T
 HVenj3tMbAY4XKsBCx1KelgCi8ZLKedC4/8MWXPOOcdgqd823cRQIaXdV1jfk/KHymqrbk+ma
 t7RxltysSSCqsE8VZg/7pQZoXVmb7tl40YKFNRCgibZRp4xy/pa6D48q8Ek7KzUz9sO/P4hjx
 WUXBRDBnSzei4JOLA35Sl6RD4unDjCMn4hMNTL/RZssqf+qei0i4+Vm3WkOPIDVL8MYcu2jUv
 hYtQB1jg9DeBOPwAmnt24LwNj1ISgp3Sx+6jKn8GDq5YpqpAQmmznxMbs4w/2YUltyf+aWnsc
 25A/ESb9lYUm256QVH+gFh/LfUWhcBQq2iq3LLsuz4rjZiywguqFFMP3Cvz8Q0QCz/YnebG5M
 +NyStZihdh28FuA3QSIpbwerb7rKWOntI36UQPGQqEeXRYPqq1S9UiD3DZRpq8vKTGaqYyxgh
 LpWlnQSnMYrZ3Pt8BFNtp/gD6ayI6kQTyrVVTnh5Od2uEsvD2c8ACXdXjv0ad6oe0HjJc0D6v
 QIjbV25Egd06xPwAhreGhJ0AKmib7n2+tH5xf+wgIxZY4iuew8kNeygtXsvzrxA7tXZGW3N9P
 v5CuTQZJlTvfuxSx52A82TlvVDtfWtSlBUrJOXFimBTpUGjRPXH8PeeVtWdkTlnWIeVdC3Shl
 iOU8nqlxot6MhIOtR+vl3TmX0Upe/uv7c+JujTcqDqQnw=

The already supported 8723d chip is very similar to 8703b/8723cs,
split code that can be shared into a new module. The spec definition
tables are combined into a struct so we only need one EXPORT_SYMBOL
for them all.

Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
=2D--
 drivers/net/wireless/realtek/rtw88/Kconfig    |   4 +
 drivers/net/wireless/realtek/rtw88/Makefile   |   3 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 673 ++----------------
 drivers/net/wireless/realtek/rtw88/rtw8723d.h | 269 +------
 drivers/net/wireless/realtek/rtw88/rtw8723x.c | 562 +++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723x.h | 496 +++++++++++++
 6 files changed, 1107 insertions(+), 900 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723x.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723x.h

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wire=
less/realtek/rtw88/Kconfig
index cffad1c0124..07b5b2f6eef 100644
=2D-- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -28,8 +28,12 @@ config RTW88_8822B
 config RTW88_8822C
 	tristate

+config RTW88_8723X
+	tristate
+
 config RTW88_8723D
 	tristate
+	select RTW88_8723X

 config RTW88_8821C
 	tristate
diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wir=
eless/realtek/rtw88/Makefile
index fd212c09d88..22516c98460 100644
=2D-- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -44,6 +44,9 @@ rtw88_8822cs-objs		:=3D rtw8822cs.o
 obj-$(CONFIG_RTW88_8822CU)	+=3D rtw88_8822cu.o
 rtw88_8822cu-objs		:=3D rtw8822cu.o

+obj-$(CONFIG_RTW88_8723X)	+=3D rtw88_8723x.o
+rtw88_8723x-objs		:=3D rtw8723x.o
+
 obj-$(CONFIG_RTW88_8723D)	+=3D rtw88_8723d.o
 rtw88_8723d-objs		:=3D rtw8723d.o rtw8723d_table.o

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/w=
ireless/realtek/rtw88/rtw8723d.c
index c575476a002..f8df4c84d39 100644
=2D-- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -9,36 +9,13 @@
 #include "tx.h"
 #include "rx.h"
 #include "phy.h"
+#include "rtw8723x.h"
 #include "rtw8723d.h"
 #include "rtw8723d_table.h"
 #include "mac.h"
 #include "reg.h"
 #include "debug.h"

-static const struct rtw_hw_reg rtw8723d_txagc[] =3D {
-	[DESC_RATE1M]	=3D { .addr =3D 0xe08, .mask =3D 0x0000ff00 },
-	[DESC_RATE2M]	=3D { .addr =3D 0x86c, .mask =3D 0x0000ff00 },
-	[DESC_RATE5_5M]	=3D { .addr =3D 0x86c, .mask =3D 0x00ff0000 },
-	[DESC_RATE11M]	=3D { .addr =3D 0x86c, .mask =3D 0xff000000 },
-	[DESC_RATE6M]	=3D { .addr =3D 0xe00, .mask =3D 0x000000ff },
-	[DESC_RATE9M]	=3D { .addr =3D 0xe00, .mask =3D 0x0000ff00 },
-	[DESC_RATE12M]	=3D { .addr =3D 0xe00, .mask =3D 0x00ff0000 },
-	[DESC_RATE18M]	=3D { .addr =3D 0xe00, .mask =3D 0xff000000 },
-	[DESC_RATE24M]	=3D { .addr =3D 0xe04, .mask =3D 0x000000ff },
-	[DESC_RATE36M]	=3D { .addr =3D 0xe04, .mask =3D 0x0000ff00 },
-	[DESC_RATE48M]	=3D { .addr =3D 0xe04, .mask =3D 0x00ff0000 },
-	[DESC_RATE54M]	=3D { .addr =3D 0xe04, .mask =3D 0xff000000 },
-	[DESC_RATEMCS0]	=3D { .addr =3D 0xe10, .mask =3D 0x000000ff },
-	[DESC_RATEMCS1]	=3D { .addr =3D 0xe10, .mask =3D 0x0000ff00 },
-	[DESC_RATEMCS2]	=3D { .addr =3D 0xe10, .mask =3D 0x00ff0000 },
-	[DESC_RATEMCS3]	=3D { .addr =3D 0xe10, .mask =3D 0xff000000 },
-	[DESC_RATEMCS4]	=3D { .addr =3D 0xe14, .mask =3D 0x000000ff },
-	[DESC_RATEMCS5]	=3D { .addr =3D 0xe14, .mask =3D 0x0000ff00 },
-	[DESC_RATEMCS6]	=3D { .addr =3D 0xe14, .mask =3D 0x00ff0000 },
-	[DESC_RATEMCS7]	=3D { .addr =3D 0xe14, .mask =3D 0xff000000 },
-};
-
-#define WLAN_TXQ_RPT_EN		0x1F
 #define WLAN_SLOT_TIME		0x09
 #define WLAN_RL_VAL		0x3030
 #define WLAN_BAR_VAL		0x0201ffff
@@ -65,34 +42,6 @@ static const struct rtw_hw_reg rtw8723d_txagc[] =3D {
 #define WLAN_LTR_CTRL1		0xCB004010
 #define WLAN_LTR_CTRL2		0x01233425

-static void rtw8723d_lck(struct rtw_dev *rtwdev)
-{
-	u32 lc_cal;
-	u8 val_ctx, rf_val;
-	int ret;
-
-	val_ctx =3D rtw_read8(rtwdev, REG_CTX);
-	if ((val_ctx & BIT_MASK_CTX_TYPE) !=3D 0)
-		rtw_write8(rtwdev, REG_CTX, val_ctx & ~BIT_MASK_CTX_TYPE);
-	else
-		rtw_write8(rtwdev, REG_TXPAUSE, 0xFF);
-	lc_cal =3D rtw_read_rf(rtwdev, RF_PATH_A, RF_CFGCH, RFREG_MASK);
-
-	rtw_write_rf(rtwdev, RF_PATH_A, RF_CFGCH, RFREG_MASK, lc_cal | BIT_LCK);
-
-	ret =3D read_poll_timeout(rtw_read_rf, rf_val, rf_val !=3D 0x1,
-				10000, 1000000, false,
-				rtwdev, RF_PATH_A, RF_CFGCH, BIT_LCK);
-	if (ret)
-		rtw_warn(rtwdev, "failed to poll LCK status bit\n");
-
-	rtw_write_rf(rtwdev, RF_PATH_A, RF_CFGCH, RFREG_MASK, lc_cal);
-	if ((val_ctx & BIT_MASK_CTX_TYPE) !=3D 0)
-		rtw_write8(rtwdev, REG_CTX, val_ctx);
-	else
-		rtw_write8(rtwdev, REG_TXPAUSE, 0x00);
-}
-
 static const u32 rtw8723d_ofdm_swing_table[] =3D {
 	0x0b40002d, 0x0c000030, 0x0cc00033, 0x0d800036, 0x0e400039, 0x0f00003c,
 	0x10000040, 0x11000044, 0x12000048, 0x1300004c, 0x14400051, 0x15800056,
@@ -196,7 +145,7 @@ static void rtw8723d_phy_set_param(struct rtw_dev *rtw=
dev)

 	rtw_write16_set(rtwdev, REG_TXDMA_OFFSET_CHK, BIT_DROP_DATA_EN);

-	rtw8723d_lck(rtwdev);
+	rtw8723x_lck(rtwdev);

 	rtw_write32_mask(rtwdev, REG_OFDM0_XAAGC1, MASKBYTE0, 0x50);
 	rtw_write32_mask(rtwdev, REG_OFDM0_XAAGC1, MASKBYTE0, 0x20);
@@ -204,67 +153,6 @@ static void rtw8723d_phy_set_param(struct rtw_dev *rt=
wdev)
 	rtw8723d_pwrtrack_init(rtwdev);
 }

-static void rtw8723de_efuse_parsing(struct rtw_efuse *efuse,
-				    struct rtw8723d_efuse *map)
-{
-	ether_addr_copy(efuse->addr, map->e.mac_addr);
-}
-
-static void rtw8723du_efuse_parsing(struct rtw_efuse *efuse,
-				    struct rtw8723d_efuse *map)
-{
-	ether_addr_copy(efuse->addr, map->u.mac_addr);
-}
-
-static void rtw8723ds_efuse_parsing(struct rtw_efuse *efuse,
-				    struct rtw8723d_efuse *map)
-{
-	ether_addr_copy(efuse->addr, map->s.mac_addr);
-}
-
-static int rtw8723d_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
-{
-	struct rtw_efuse *efuse =3D &rtwdev->efuse;
-	struct rtw8723d_efuse *map;
-	int i;
-
-	map =3D (struct rtw8723d_efuse *)log_map;
-
-	efuse->rfe_option =3D 0;
-	efuse->rf_board_option =3D map->rf_board_option;
-	efuse->crystal_cap =3D map->xtal_k;
-	efuse->pa_type_2g =3D map->pa_type;
-	efuse->lna_type_2g =3D map->lna_type_2g[0];
-	efuse->channel_plan =3D map->channel_plan;
-	efuse->country_code[0] =3D map->country_code[0];
-	efuse->country_code[1] =3D map->country_code[1];
-	efuse->bt_setting =3D map->rf_bt_setting;
-	efuse->regd =3D map->rf_board_option & 0x7;
-	efuse->thermal_meter[0] =3D map->thermal_meter;
-	efuse->thermal_meter_k =3D map->thermal_meter;
-	efuse->afe =3D map->afe;
-
-	for (i =3D 0; i < 4; i++)
-		efuse->txpwr_idx_table[i] =3D map->txpwr_idx_table[i];
-
-	switch (rtw_hci_type(rtwdev)) {
-	case RTW_HCI_TYPE_PCIE:
-		rtw8723de_efuse_parsing(efuse, map);
-		break;
-	case RTW_HCI_TYPE_USB:
-		rtw8723du_efuse_parsing(efuse, map);
-		break;
-	case RTW_HCI_TYPE_SDIO:
-		rtw8723ds_efuse_parsing(efuse, map);
-		break;
-	default:
-		/* unsupported now */
-		return -ENOTSUPP;
-	}
-
-	return 0;
-}
-
 static void query_phy_status_page0(struct rtw_dev *rtwdev, u8 *phy_status=
,
 				   struct rtw_rx_pkt_stat *pkt_stat)
 {
@@ -540,297 +428,11 @@ static void rtw8723d_set_channel(struct rtw_dev *rt=
wdev, u8 channel, u8 bw,
 	rtw8723d_set_channel_bb(rtwdev, channel, bw, primary_chan_idx);
 }

-#define BIT_CFENDFORM		BIT(9)
-#define BIT_WMAC_TCR_ERR0	BIT(12)
-#define BIT_WMAC_TCR_ERR1	BIT(13)
-#define BIT_TCR_CFG		(BIT_CFENDFORM | BIT_WMAC_TCR_ERR0 |	       \
-				 BIT_WMAC_TCR_ERR1)
-#define WLAN_RX_FILTER0		0xFFFF
-#define WLAN_RX_FILTER1		0x400
-#define WLAN_RX_FILTER2		0xFFFF
-#define WLAN_RCR_CFG		0x700060CE
-
-static int rtw8723d_mac_init(struct rtw_dev *rtwdev)
-{
-	rtw_write8(rtwdev, REG_FWHW_TXQ_CTRL + 1, WLAN_TXQ_RPT_EN);
-	rtw_write32(rtwdev, REG_TCR, BIT_TCR_CFG);
-
-	rtw_write16(rtwdev, REG_RXFLTMAP0, WLAN_RX_FILTER0);
-	rtw_write16(rtwdev, REG_RXFLTMAP1, WLAN_RX_FILTER1);
-	rtw_write16(rtwdev, REG_RXFLTMAP2, WLAN_RX_FILTER2);
-	rtw_write32(rtwdev, REG_RCR, WLAN_RCR_CFG);
-
-	rtw_write32(rtwdev, REG_INT_MIG, 0);
-	rtw_write32(rtwdev, REG_MCUTST_1, 0x0);
-
-	rtw_write8(rtwdev, REG_MISC_CTRL, BIT_DIS_SECOND_CCA);
-	rtw_write8(rtwdev, REG_2ND_CCA_CTRL, 0);
-
-	return 0;
-}
-
 static void rtw8723d_shutdown(struct rtw_dev *rtwdev)
 {
 	rtw_write16_set(rtwdev, REG_HCI_OPT_CTRL, BIT_USB_SUS_DIS);
 }

-static void rtw8723d_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
-{
-	u8 ldo_pwr;
-
-	ldo_pwr =3D rtw_read8(rtwdev, REG_LDO_EFUSE_CTRL + 3);
-	if (enable) {
-		ldo_pwr &=3D ~BIT_MASK_LDO25_VOLTAGE;
-		ldo_pwr |=3D (BIT_LDO25_VOLTAGE_V25 << 4) | BIT_LDO25_EN;
-	} else {
-		ldo_pwr &=3D ~BIT_LDO25_EN;
-	}
-	rtw_write8(rtwdev, REG_LDO_EFUSE_CTRL + 3, ldo_pwr);
-}
-
-static void
-rtw8723d_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 r=
s)
-{
-	struct rtw_hal *hal =3D &rtwdev->hal;
-	const struct rtw_hw_reg *txagc;
-	u8 rate, pwr_index;
-	int j;
-
-	for (j =3D 0; j < rtw_rate_size[rs]; j++) {
-		rate =3D rtw_rate_section[rs][j];
-		pwr_index =3D hal->tx_pwr_tbl[path][rate];
-
-		if (rate >=3D ARRAY_SIZE(rtw8723d_txagc)) {
-			rtw_warn(rtwdev, "rate 0x%x isn't supported\n", rate);
-			continue;
-		}
-		txagc =3D &rtw8723d_txagc[rate];
-		if (!txagc->addr) {
-			rtw_warn(rtwdev, "rate 0x%x isn't defined\n", rate);
-			continue;
-		}
-
-		rtw_write32_mask(rtwdev, txagc->addr, txagc->mask, pwr_index);
-	}
-}
-
-static void rtw8723d_set_tx_power_index(struct rtw_dev *rtwdev)
-{
-	struct rtw_hal *hal =3D &rtwdev->hal;
-	int rs, path;
-
-	for (path =3D 0; path < hal->rf_path_num; path++) {
-		for (rs =3D 0; rs <=3D RTW_RATE_SECTION_HT_1S; rs++)
-			rtw8723d_set_tx_power_index_by_rate(rtwdev, path, rs);
-	}
-}
-
-static void rtw8723d_efuse_grant(struct rtw_dev *rtwdev, bool on)
-{
-	if (on) {
-		rtw_write8(rtwdev, REG_EFUSE_ACCESS, EFUSE_ACCESS_ON);
-
-		rtw_write16_set(rtwdev, REG_SYS_FUNC_EN, BIT_FEN_ELDR);
-		rtw_write16_set(rtwdev, REG_SYS_CLKR, BIT_LOADER_CLK_EN | BIT_ANA8M);
-	} else {
-		rtw_write8(rtwdev, REG_EFUSE_ACCESS, EFUSE_ACCESS_OFF);
-	}
-}
-
-static void rtw8723d_false_alarm_statistics(struct rtw_dev *rtwdev)
-{
-	struct rtw_dm_info *dm_info =3D &rtwdev->dm_info;
-	u32 cck_fa_cnt;
-	u32 ofdm_fa_cnt;
-	u32 crc32_cnt;
-	u32 val32;
-
-	/* hold counter */
-	rtw_write32_mask(rtwdev, REG_OFDM_FA_HOLDC_11N, BIT_MASK_OFDM_FA_KEEP, 1=
);
-	rtw_write32_mask(rtwdev, REG_OFDM_FA_RSTD_11N, BIT_MASK_OFDM_FA_KEEP1, 1=
);
-	rtw_write32_mask(rtwdev, REG_CCK_FA_RST_11N, BIT_MASK_CCK_CNT_KEEP, 1);
-	rtw_write32_mask(rtwdev, REG_CCK_FA_RST_11N, BIT_MASK_CCK_FA_KEEP, 1);
-
-	cck_fa_cnt =3D rtw_read32_mask(rtwdev, REG_CCK_FA_LSB_11N, MASKBYTE0);
-	cck_fa_cnt +=3D rtw_read32_mask(rtwdev, REG_CCK_FA_MSB_11N, MASKBYTE3) <=
< 8;
-
-	val32 =3D rtw_read32(rtwdev, REG_OFDM_FA_TYPE1_11N);
-	ofdm_fa_cnt =3D u32_get_bits(val32, BIT_MASK_OFDM_FF_CNT);
-	ofdm_fa_cnt +=3D u32_get_bits(val32, BIT_MASK_OFDM_SF_CNT);
-	val32 =3D rtw_read32(rtwdev, REG_OFDM_FA_TYPE2_11N);
-	dm_info->ofdm_cca_cnt =3D u32_get_bits(val32, BIT_MASK_OFDM_CCA_CNT);
-	ofdm_fa_cnt +=3D u32_get_bits(val32, BIT_MASK_OFDM_PF_CNT);
-	val32 =3D rtw_read32(rtwdev, REG_OFDM_FA_TYPE3_11N);
-	ofdm_fa_cnt +=3D u32_get_bits(val32, BIT_MASK_OFDM_RI_CNT);
-	ofdm_fa_cnt +=3D u32_get_bits(val32, BIT_MASK_OFDM_CRC_CNT);
-	val32 =3D rtw_read32(rtwdev, REG_OFDM_FA_TYPE4_11N);
-	ofdm_fa_cnt +=3D u32_get_bits(val32, BIT_MASK_OFDM_MNS_CNT);
-
-	dm_info->cck_fa_cnt =3D cck_fa_cnt;
-	dm_info->ofdm_fa_cnt =3D ofdm_fa_cnt;
-	dm_info->total_fa_cnt =3D cck_fa_cnt + ofdm_fa_cnt;
-
-	dm_info->cck_err_cnt =3D rtw_read32(rtwdev, REG_IGI_C_11N);
-	dm_info->cck_ok_cnt =3D rtw_read32(rtwdev, REG_IGI_D_11N);
-	crc32_cnt =3D rtw_read32(rtwdev, REG_OFDM_CRC32_CNT_11N);
-	dm_info->ofdm_err_cnt =3D u32_get_bits(crc32_cnt, BIT_MASK_OFDM_LCRC_ERR=
);
-	dm_info->ofdm_ok_cnt =3D u32_get_bits(crc32_cnt, BIT_MASK_OFDM_LCRC_OK);
-	crc32_cnt =3D rtw_read32(rtwdev, REG_HT_CRC32_CNT_11N);
-	dm_info->ht_err_cnt =3D u32_get_bits(crc32_cnt, BIT_MASK_HT_CRC_ERR);
-	dm_info->ht_ok_cnt =3D u32_get_bits(crc32_cnt, BIT_MASK_HT_CRC_OK);
-	dm_info->vht_err_cnt =3D 0;
-	dm_info->vht_ok_cnt =3D 0;
-
-	val32 =3D rtw_read32(rtwdev, REG_CCK_CCA_CNT_11N);
-	dm_info->cck_cca_cnt =3D (u32_get_bits(val32, BIT_MASK_CCK_FA_MSB) << 8)=
 |
-			       u32_get_bits(val32, BIT_MASK_CCK_FA_LSB);
-	dm_info->total_cca_cnt =3D dm_info->cck_cca_cnt + dm_info->ofdm_cca_cnt;
-
-	/* reset counter */
-	rtw_write32_mask(rtwdev, REG_OFDM_FA_RSTC_11N, BIT_MASK_OFDM_FA_RST, 1);
-	rtw_write32_mask(rtwdev, REG_OFDM_FA_RSTC_11N, BIT_MASK_OFDM_FA_RST, 0);
-	rtw_write32_mask(rtwdev, REG_OFDM_FA_RSTD_11N, BIT_MASK_OFDM_FA_RST1, 1)=
;
-	rtw_write32_mask(rtwdev, REG_OFDM_FA_RSTD_11N, BIT_MASK_OFDM_FA_RST1, 0)=
;
-	rtw_write32_mask(rtwdev, REG_OFDM_FA_HOLDC_11N, BIT_MASK_OFDM_FA_KEEP, 0=
);
-	rtw_write32_mask(rtwdev, REG_OFDM_FA_RSTD_11N, BIT_MASK_OFDM_FA_KEEP1, 0=
);
-	rtw_write32_mask(rtwdev, REG_CCK_FA_RST_11N, BIT_MASK_CCK_CNT_KPEN, 0);
-	rtw_write32_mask(rtwdev, REG_CCK_FA_RST_11N, BIT_MASK_CCK_CNT_KPEN, 2);
-	rtw_write32_mask(rtwdev, REG_CCK_FA_RST_11N, BIT_MASK_CCK_FA_KPEN, 0);
-	rtw_write32_mask(rtwdev, REG_CCK_FA_RST_11N, BIT_MASK_CCK_FA_KPEN, 2);
-	rtw_write32_mask(rtwdev, REG_PAGE_F_RST_11N, BIT_MASK_F_RST_ALL, 1);
-	rtw_write32_mask(rtwdev, REG_PAGE_F_RST_11N, BIT_MASK_F_RST_ALL, 0);
-}
-
-static const u32 iqk_adda_regs[] =3D {
-	0x85c, 0xe6c, 0xe70, 0xe74, 0xe78, 0xe7c, 0xe80, 0xe84, 0xe88, 0xe8c,
-	0xed0, 0xed4, 0xed8, 0xedc, 0xee0, 0xeec
-};
-
-static const u32 iqk_mac8_regs[] =3D {0x522, 0x550, 0x551};
-static const u32 iqk_mac32_regs[] =3D {0x40};
-
-static const u32 iqk_bb_regs[] =3D {
-	0xc04, 0xc08, 0x874, 0xb68, 0xb6c, 0x870, 0x860, 0x864, 0xa04
-};
-
-#define IQK_ADDA_REG_NUM	ARRAY_SIZE(iqk_adda_regs)
-#define IQK_MAC8_REG_NUM	ARRAY_SIZE(iqk_mac8_regs)
-#define IQK_MAC32_REG_NUM	ARRAY_SIZE(iqk_mac32_regs)
-#define IQK_BB_REG_NUM		ARRAY_SIZE(iqk_bb_regs)
-
-struct iqk_backup_regs {
-	u32 adda[IQK_ADDA_REG_NUM];
-	u8 mac8[IQK_MAC8_REG_NUM];
-	u32 mac32[IQK_MAC32_REG_NUM];
-	u32 bb[IQK_BB_REG_NUM];
-
-	u32 lte_path;
-	u32 lte_gnt;
-
-	u32 bb_sel_btg;
-	u8 btg_sel;
-
-	u8 igia;
-	u8 igib;
-};
-
-static void rtw8723d_iqk_backup_regs(struct rtw_dev *rtwdev,
-				     struct iqk_backup_regs *backup)
-{
-	int i;
-
-	for (i =3D 0; i < IQK_ADDA_REG_NUM; i++)
-		backup->adda[i] =3D rtw_read32(rtwdev, iqk_adda_regs[i]);
-
-	for (i =3D 0; i < IQK_MAC8_REG_NUM; i++)
-		backup->mac8[i] =3D rtw_read8(rtwdev, iqk_mac8_regs[i]);
-	for (i =3D 0; i < IQK_MAC32_REG_NUM; i++)
-		backup->mac32[i] =3D rtw_read32(rtwdev, iqk_mac32_regs[i]);
-
-	for (i =3D 0; i < IQK_BB_REG_NUM; i++)
-		backup->bb[i] =3D rtw_read32(rtwdev, iqk_bb_regs[i]);
-
-	backup->igia =3D rtw_read32_mask(rtwdev, REG_OFDM0_XAAGC1, MASKBYTE0);
-	backup->igib =3D rtw_read32_mask(rtwdev, REG_OFDM0_XBAGC1, MASKBYTE0);
-
-	backup->bb_sel_btg =3D rtw_read32(rtwdev, REG_BB_SEL_BTG);
-}
-
-static void rtw8723d_iqk_restore_regs(struct rtw_dev *rtwdev,
-				      const struct iqk_backup_regs *backup)
-{
-	int i;
-
-	for (i =3D 0; i < IQK_ADDA_REG_NUM; i++)
-		rtw_write32(rtwdev, iqk_adda_regs[i], backup->adda[i]);
-
-	for (i =3D 0; i < IQK_MAC8_REG_NUM; i++)
-		rtw_write8(rtwdev, iqk_mac8_regs[i], backup->mac8[i]);
-	for (i =3D 0; i < IQK_MAC32_REG_NUM; i++)
-		rtw_write32(rtwdev, iqk_mac32_regs[i], backup->mac32[i]);
-
-	for (i =3D 0; i < IQK_BB_REG_NUM; i++)
-		rtw_write32(rtwdev, iqk_bb_regs[i], backup->bb[i]);
-
-	rtw_write32_mask(rtwdev, REG_OFDM0_XAAGC1, MASKBYTE0, 0x50);
-	rtw_write32_mask(rtwdev, REG_OFDM0_XAAGC1, MASKBYTE0, backup->igia);
-
-	rtw_write32_mask(rtwdev, REG_OFDM0_XBAGC1, MASKBYTE0, 0x50);
-	rtw_write32_mask(rtwdev, REG_OFDM0_XBAGC1, MASKBYTE0, backup->igib);
-
-	rtw_write32(rtwdev, REG_TXIQK_TONE_A_11N, 0x01008c00);
-	rtw_write32(rtwdev, REG_RXIQK_TONE_A_11N, 0x01008c00);
-}
-
-static void rtw8723d_iqk_backup_path_ctrl(struct rtw_dev *rtwdev,
-					  struct iqk_backup_regs *backup)
-{
-	backup->btg_sel =3D rtw_read8(rtwdev, REG_BTG_SEL);
-	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] original 0x67 =3D 0x%x\n",
-		backup->btg_sel);
-}
-
-static void rtw8723d_iqk_config_path_ctrl(struct rtw_dev *rtwdev)
-{
-	rtw_write32_mask(rtwdev, REG_PAD_CTRL1, BIT_BT_BTG_SEL, 0x1);
-	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] set 0x67 =3D 0x%x\n",
-		rtw_read32_mask(rtwdev, REG_PAD_CTRL1, MASKBYTE3));
-}
-
-static void rtw8723d_iqk_restore_path_ctrl(struct rtw_dev *rtwdev,
-					   const struct iqk_backup_regs *backup)
-{
-	rtw_write8(rtwdev, REG_BTG_SEL, backup->btg_sel);
-	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] restore 0x67 =3D 0x%x\n",
-		rtw_read32_mask(rtwdev, REG_PAD_CTRL1, MASKBYTE3));
-}
-
-static void rtw8723d_iqk_backup_lte_path_gnt(struct rtw_dev *rtwdev,
-					     struct iqk_backup_regs *backup)
-{
-	backup->lte_path =3D rtw_read32(rtwdev, REG_LTECOEX_PATH_CONTROL);
-	rtw_write32(rtwdev, REG_LTECOEX_CTRL, 0x800f0038);
-	mdelay(1);
-	backup->lte_gnt =3D rtw_read32(rtwdev, REG_LTECOEX_READ_DATA);
-	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] OriginalGNT =3D 0x%x\n",
-		backup->lte_gnt);
-}
-
-static void rtw8723d_iqk_config_lte_path_gnt(struct rtw_dev *rtwdev)
-{
-	rtw_write32(rtwdev, REG_LTECOEX_WRITE_DATA, 0x0000ff00);
-	rtw_write32(rtwdev, REG_LTECOEX_CTRL, 0xc0020038);
-	rtw_write32_mask(rtwdev, REG_LTECOEX_PATH_CONTROL, BIT_LTE_MUX_CTRL_PATH=
, 0x1);
-}
-
-static void rtw8723d_iqk_restore_lte_path_gnt(struct rtw_dev *rtwdev,
-					      const struct iqk_backup_regs *bak)
-{
-	rtw_write32(rtwdev, REG_LTECOEX_WRITE_DATA, bak->lte_gnt);
-	rtw_write32(rtwdev, REG_LTECOEX_CTRL, 0xc00f0038);
-	rtw_write32(rtwdev, REG_LTECOEX_PATH_CONTROL, bak->lte_path);
-}
-
 struct rtw_8723d_iqk_cfg {
 	const char *name;
 	u32 val_bb_sel_btg;
@@ -930,6 +532,8 @@ static u8 rtw8723d_iqk_check_rx_failed(struct rtw_dev =
*rtwdev,
 	return 0;
 }

+#define IQK_LTE_WRITE_VAL_8723D 0x0000ff00
+
 static void rtw8723d_iqk_one_shot(struct rtw_dev *rtwdev, bool tx,
 				  const struct rtw_8723d_iqk_cfg *iqk_cfg)
 {
@@ -937,7 +541,7 @@ static void rtw8723d_iqk_one_shot(struct rtw_dev *rtwd=
ev, bool tx,

 	/* enter IQK mode */
 	rtw_write32_mask(rtwdev, REG_FPGA0_IQK_11N, BIT_MASK_IQK_MOD, EN_IQK);
-	rtw8723d_iqk_config_lte_path_gnt(rtwdev);
+	rtw8723x_iqk_config_lte_path_gnt(rtwdev, IQK_LTE_WRITE_VAL_8723D);

 	rtw_write32(rtwdev, REG_LTECOEX_CTRL, 0x800f0054);
 	mdelay(1);
@@ -959,9 +563,9 @@ static void rtw8723d_iqk_one_shot(struct rtw_dev *rtwd=
ev, bool tx,

 static void rtw8723d_iqk_txrx_path_post(struct rtw_dev *rtwdev,
 					const struct rtw_8723d_iqk_cfg *iqk_cfg,
-					const struct iqk_backup_regs *backup)
+					const struct rtw8723x_iqk_backup_regs *backup)
 {
-	rtw8723d_iqk_restore_lte_path_gnt(rtwdev, backup);
+	rtw8723x_iqk_restore_lte_path_gnt(rtwdev, backup);
 	rtw_write32(rtwdev, REG_BB_SEL_BTG, backup->bb_sel_btg);

 	/* leave IQK mode */
@@ -974,7 +578,7 @@ static void rtw8723d_iqk_txrx_path_post(struct rtw_dev=
 *rtwdev,

 static u8 rtw8723d_iqk_tx_path(struct rtw_dev *rtwdev,
 			       const struct rtw_8723d_iqk_cfg *iqk_cfg,
-			       const struct iqk_backup_regs *backup)
+			       const struct rtw8723x_iqk_backup_regs *backup)
 {
 	u8 status;

@@ -1033,7 +637,7 @@ static u8 rtw8723d_iqk_tx_path(struct rtw_dev *rtwdev=
,

 static u8 rtw8723d_iqk_rx_path(struct rtw_dev *rtwdev,
 			       const struct rtw_8723d_iqk_cfg *iqk_cfg,
-			       const struct iqk_backup_regs *backup)
+			       const struct rtw8723x_iqk_backup_regs *backup)
 {
 	u32 tx_x, tx_y;
 	u8 status;
@@ -1220,14 +824,6 @@ void rtw8723d_iqk_fill_s0_matrix(struct rtw_dev *rtw=
dev, const s32 result[])
 			 result[IQK_S0_RX_Y]);
 }

-static void rtw8723d_iqk_path_adda_on(struct rtw_dev *rtwdev)
-{
-	int i;
-
-	for (i =3D 0; i < IQK_ADDA_REG_NUM; i++)
-		rtw_write32(rtwdev, iqk_adda_regs[i], 0x03c00016);
-}
-
 static void rtw8723d_iqk_config_mac(struct rtw_dev *rtwdev)
 {
 	rtw_write8(rtwdev, REG_TXPAUSE, 0xff);
@@ -1245,70 +841,14 @@ void rtw8723d_iqk_rf_standby(struct rtw_dev *rtwdev=
, enum rtw_rf_path path)
 	rtw_write32_mask(rtwdev, REG_FPGA0_IQK_11N, BIT_MASK_IQK_MOD, EN_IQK);
 }

-static
-bool rtw8723d_iqk_similarity_cmp(struct rtw_dev *rtwdev, s32 result[][IQK=
_NR],
-				 u8 c1, u8 c2)
-{
-	u32 i, j, diff;
-	u32 bitmap =3D 0;
-	u8 candidate[PATH_NR] =3D {IQK_ROUND_INVALID, IQK_ROUND_INVALID};
-	bool ret =3D true;
-
-	s32 tmp1, tmp2;
-
-	for (i =3D 0; i < IQK_NR; i++) {
-		tmp1 =3D iqkxy_to_s32(result[c1][i]);
-		tmp2 =3D iqkxy_to_s32(result[c2][i]);
-
-		diff =3D abs(tmp1 - tmp2);
-
-		if (diff <=3D MAX_TOLERANCE)
-			continue;
-
-		if ((i =3D=3D IQK_S1_RX_X || i =3D=3D IQK_S0_RX_X) && !bitmap) {
-			if (result[c1][i] + result[c1][i + 1] =3D=3D 0)
-				candidate[i / IQK_SX_NR] =3D c2;
-			else if (result[c2][i] + result[c2][i + 1] =3D=3D 0)
-				candidate[i / IQK_SX_NR] =3D c1;
-			else
-				bitmap |=3D BIT(i);
-		} else {
-			bitmap |=3D BIT(i);
-		}
-	}
-
-	if (bitmap !=3D 0)
-		goto check_sim;
-
-	for (i =3D 0; i < PATH_NR; i++) {
-		if (candidate[i] =3D=3D IQK_ROUND_INVALID)
-			continue;
-
-		for (j =3D i * IQK_SX_NR; j < i * IQK_SX_NR + 2; j++)
-			result[IQK_ROUND_HYBRID][j] =3D result[candidate[i]][j];
-		ret =3D false;
-	}
-
-	return ret;
-
-check_sim:
-	for (i =3D 0; i < IQK_NR; i++) {
-		j =3D i & ~1;	/* 2 bits are a pair for IQ[X, Y] */
-		if (bitmap & GENMASK(j + 1, j))
-			continue;
-
-		result[IQK_ROUND_HYBRID][i] =3D result[c1][i];
-	}
-
-	return false;
-}
+#define ADDA_ON_VAL_8723D 0x03c00016

 static
-void rtw8723d_iqk_precfg_path(struct rtw_dev *rtwdev, enum rtw8723d_path =
path)
+void rtw8723d_iqk_precfg_path(struct rtw_dev *rtwdev, enum rtw8723x_path =
path)
 {
 	if (path =3D=3D PATH_S0) {
 		rtw8723d_iqk_rf_standby(rtwdev, RF_PATH_A);
-		rtw8723d_iqk_path_adda_on(rtwdev);
+		rtw8723x_iqk_path_adda_on(rtwdev, ADDA_ON_VAL_8723D);
 	}

 	rtw_write32_mask(rtwdev, REG_FPGA0_IQK_11N, BIT_MASK_IQK_MOD, EN_IQK);
@@ -1317,13 +857,13 @@ void rtw8723d_iqk_precfg_path(struct rtw_dev *rtwde=
v, enum rtw8723d_path path)

 	if (path =3D=3D PATH_S1) {
 		rtw8723d_iqk_rf_standby(rtwdev, RF_PATH_B);
-		rtw8723d_iqk_path_adda_on(rtwdev);
+		rtw8723x_iqk_path_adda_on(rtwdev, ADDA_ON_VAL_8723D);
 	}
 }

 static
 void rtw8723d_iqk_one_round(struct rtw_dev *rtwdev, s32 result[][IQK_NR],=
 u8 t,
-			    const struct iqk_backup_regs *backup)
+			    const struct rtw8723x_iqk_backup_regs *backup)
 {
 	u32 i;
 	u8 s1_ok, s0_ok;
@@ -1331,7 +871,7 @@ void rtw8723d_iqk_one_round(struct rtw_dev *rtwdev, s=
32 result[][IQK_NR], u8 t,
 	rtw_dbg(rtwdev, RTW_DBG_RFK,
 		"[IQK] IQ Calibration for 1T1R_S0/S1 for %d times\n", t);

-	rtw8723d_iqk_path_adda_on(rtwdev);
+	rtw8723x_iqk_path_adda_on(rtwdev, ADDA_ON_VAL_8723D);
 	rtw8723d_iqk_config_mac(rtwdev);
 	rtw_write32_mask(rtwdev, REG_CCK_ANT_SEL_11N, 0x0f000000, 0xf);
 	rtw_write32(rtwdev, REG_BB_RX_PATH_11N, 0x03a05611);
@@ -1427,7 +967,7 @@ static void rtw8723d_phy_calibration(struct rtw_dev *=
rtwdev)
 {
 	struct rtw_dm_info *dm_info =3D &rtwdev->dm_info;
 	s32 result[IQK_ROUND_SIZE][IQK_NR];
-	struct iqk_backup_regs backup;
+	struct rtw8723x_iqk_backup_regs backup;
 	u8 i, j;
 	u8 final_candidate =3D IQK_ROUND_INVALID;
 	bool good;
@@ -1436,23 +976,23 @@ static void rtw8723d_phy_calibration(struct rtw_dev=
 *rtwdev)

 	memset(result, 0, sizeof(result));

-	rtw8723d_iqk_backup_path_ctrl(rtwdev, &backup);
-	rtw8723d_iqk_backup_lte_path_gnt(rtwdev, &backup);
-	rtw8723d_iqk_backup_regs(rtwdev, &backup);
+	rtw8723x_iqk_backup_path_ctrl(rtwdev, &backup);
+	rtw8723x_iqk_backup_lte_path_gnt(rtwdev, &backup);
+	rtw8723x_iqk_backup_regs(rtwdev, &backup);

 	for (i =3D IQK_ROUND_0; i <=3D IQK_ROUND_2; i++) {
-		rtw8723d_iqk_config_path_ctrl(rtwdev);
-		rtw8723d_iqk_config_lte_path_gnt(rtwdev);
+		rtw8723x_iqk_config_path_ctrl(rtwdev);
+		rtw8723x_iqk_config_lte_path_gnt(rtwdev, IQK_LTE_WRITE_VAL_8723D);

 		rtw8723d_iqk_one_round(rtwdev, result, i, &backup);

 		if (i > IQK_ROUND_0)
-			rtw8723d_iqk_restore_regs(rtwdev, &backup);
-		rtw8723d_iqk_restore_lte_path_gnt(rtwdev, &backup);
-		rtw8723d_iqk_restore_path_ctrl(rtwdev, &backup);
+			rtw8723x_iqk_restore_regs(rtwdev, &backup);
+		rtw8723x_iqk_restore_lte_path_gnt(rtwdev, &backup);
+		rtw8723x_iqk_restore_path_ctrl(rtwdev, &backup);

 		for (j =3D IQK_ROUND_0; j < i; j++) {
-			good =3D rtw8723d_iqk_similarity_cmp(rtwdev, result, j, i);
+			good =3D rtw8723x_iqk_similarity_cmp(rtwdev, result, j, i);

 			if (good) {
 				final_candidate =3D j;
@@ -1546,26 +1086,6 @@ static void rtw8723d_phy_cck_pd_set(struct rtw_dev =
*rtwdev, u8 new_lvl)
 }

 /* for coex */
-static void rtw8723d_coex_cfg_init(struct rtw_dev *rtwdev)
-{
-	/* enable TBTT nterrupt */
-	rtw_write8_set(rtwdev, REG_BCN_CTRL, BIT_EN_BCN_FUNCTION);
-
-	/* BT report packet sample rate	 */
-	/* 0x790[5:0]=3D0x5 */
-	rtw_write8_mask(rtwdev, REG_BT_TDMA_TIME, BIT_MASK_SAMPLE_RATE, 0x5);
-
-	/* enable BT counter statistics */
-	rtw_write8(rtwdev, REG_BT_STAT_CTRL, 0x1);
-
-	/* enable PTA (3-wire function form BT side) */
-	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_BT_PTA_EN);
-	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_PO_BT_PTA_PINS);
-
-	/* enable PTA (tx/rx signal form WiFi side) */
-	rtw_write8_set(rtwdev, REG_QUEUE_CTRL, BIT_PTA_WL_TX_EN);
-}
-
 static void rtw8723d_coex_cfg_gnt_fix(struct rtw_dev *rtwdev)
 {
 }
@@ -1671,39 +1191,6 @@ static void rtw8723d_coex_cfg_wl_rx_gain(struct rtw=
_dev *rtwdev, bool low_gain)
 	}
 }

-static u8 rtw8723d_pwrtrack_get_limit_ofdm(struct rtw_dev *rtwdev)
-{
-	struct rtw_dm_info *dm_info =3D &rtwdev->dm_info;
-	u8 tx_rate =3D dm_info->tx_rate;
-	u8 limit_ofdm =3D 30;
-
-	switch (tx_rate) {
-	case DESC_RATE1M...DESC_RATE5_5M:
-	case DESC_RATE11M:
-		break;
-	case DESC_RATE6M...DESC_RATE48M:
-		limit_ofdm =3D 36;
-		break;
-	case DESC_RATE54M:
-		limit_ofdm =3D 34;
-		break;
-	case DESC_RATEMCS0...DESC_RATEMCS2:
-		limit_ofdm =3D 38;
-		break;
-	case DESC_RATEMCS3...DESC_RATEMCS4:
-		limit_ofdm =3D 36;
-		break;
-	case DESC_RATEMCS5...DESC_RATEMCS7:
-		limit_ofdm =3D 34;
-		break;
-	default:
-		rtw_warn(rtwdev, "pwrtrack unhandled tx_rate 0x%x\n", tx_rate);
-		break;
-	}
-
-	return limit_ofdm;
-}
-
 static void rtw8723d_set_iqk_matrix_by_result(struct rtw_dev *rtwdev,
 					      u32 ofdm_swing, u8 rf_path)
 {
@@ -1845,7 +1332,7 @@ static void rtw8723d_pwrtrack_set(struct rtw_dev *rt=
wdev, u8 path)
 	s8 final_ofdm_swing_index;
 	s8 final_cck_swing_index;

-	limit_ofdm =3D rtw8723d_pwrtrack_get_limit_ofdm(rtwdev);
+	limit_ofdm =3D rtw8723x_pwrtrack_get_limit_ofdm(rtwdev);

 	final_ofdm_swing_index =3D RTW_DEF_OFDM_SWING_INDEX +
 				 dm_info->delta_power_index[path];
@@ -1873,26 +1360,6 @@ static void rtw8723d_pwrtrack_set(struct rtw_dev *r=
twdev, u8 path)
 	rtw_phy_set_tx_power_level(rtwdev, hal->current_channel);
 }

-static void rtw8723d_pwrtrack_set_xtal(struct rtw_dev *rtwdev, u8 therm_p=
ath,
-				       u8 delta)
-{
-	struct rtw_dm_info *dm_info =3D &rtwdev->dm_info;
-	const struct rtw_pwr_track_tbl *tbl =3D rtwdev->chip->pwr_track_tbl;
-	const s8 *pwrtrk_xtal;
-	s8 xtal_cap;
-
-	if (dm_info->thermal_avg[therm_path] >
-	    rtwdev->efuse.thermal_meter[therm_path])
-		pwrtrk_xtal =3D tbl->pwrtrk_xtal_p;
-	else
-		pwrtrk_xtal =3D tbl->pwrtrk_xtal_n;
-
-	xtal_cap =3D rtwdev->efuse.crystal_cap & 0x3F;
-	xtal_cap =3D clamp_t(s8, xtal_cap + pwrtrk_xtal[delta], 0, 0x3F);
-	rtw_write32_mask(rtwdev, REG_AFE_CTRL3, BIT_MASK_XTAL,
-			 xtal_cap | (xtal_cap << 6));
-}
-
 static void rtw8723d_phy_pwrtrack(struct rtw_dev *rtwdev)
 {
 	struct rtw_dm_info *dm_info =3D &rtwdev->dm_info;
@@ -1912,7 +1379,7 @@ static void rtw8723d_phy_pwrtrack(struct rtw_dev *rt=
wdev)
 	do_iqk =3D rtw_phy_pwrtrack_need_iqk(rtwdev);

 	if (do_iqk)
-		rtw8723d_lck(rtwdev);
+		rtw8723x_lck(rtwdev);

 	if (dm_info->pwr_trk_init_trigger)
 		dm_info->pwr_trk_init_trigger =3D false;
@@ -1937,7 +1404,7 @@ static void rtw8723d_phy_pwrtrack(struct rtw_dev *rt=
wdev)
 		rtw8723d_pwrtrack_set(rtwdev, path);
 	}

-	rtw8723d_pwrtrack_set_xtal(rtwdev, RF_PATH_A, delta);
+	rtw8723x_pwrtrack_set_xtal(rtwdev, RF_PATH_A, delta);

 iqk:
 	if (do_iqk)
@@ -1963,49 +1430,29 @@ static void rtw8723d_pwr_track(struct rtw_dev *rtw=
dev)
 	dm_info->pwr_trk_triggered =3D false;
 }

-static void rtw8723d_fill_txdesc_checksum(struct rtw_dev *rtwdev,
-					  struct rtw_tx_pkt_info *pkt_info,
-					  u8 *txdesc)
-{
-	size_t words =3D 32 / 2; /* calculate the first 32 bytes (16 words) */
-	__le16 chksum =3D 0;
-	__le16 *data =3D (__le16 *)(txdesc);
-	struct rtw_tx_desc *tx_desc =3D (struct rtw_tx_desc *)txdesc;
-
-	le32p_replace_bits(&tx_desc->w7, 0, RTW_TX_DESC_W7_TXDESC_CHECKSUM);
-
-	while (words--)
-		chksum ^=3D *data++;
-
-	chksum =3D ~chksum;
-
-	le32p_replace_bits(&tx_desc->w7, __le16_to_cpu(chksum),
-			   RTW_TX_DESC_W7_TXDESC_CHECKSUM);
-}
-
 static struct rtw_chip_ops rtw8723d_ops =3D {
 	.phy_set_param		=3D rtw8723d_phy_set_param,
-	.read_efuse		=3D rtw8723d_read_efuse,
+	.read_efuse		=3D rtw8723x_read_efuse,
 	.query_rx_desc		=3D rtw8723d_query_rx_desc,
 	.set_channel		=3D rtw8723d_set_channel,
-	.mac_init		=3D rtw8723d_mac_init,
+	.mac_init		=3D rtw8723x_mac_init,
 	.shutdown		=3D rtw8723d_shutdown,
 	.read_rf		=3D rtw_phy_read_rf_sipi,
 	.write_rf		=3D rtw_phy_write_rf_reg_sipi,
-	.set_tx_power_index	=3D rtw8723d_set_tx_power_index,
+	.set_tx_power_index	=3D rtw8723x_set_tx_power_index,
 	.set_antenna		=3D NULL,
-	.cfg_ldo25		=3D rtw8723d_cfg_ldo25,
-	.efuse_grant		=3D rtw8723d_efuse_grant,
-	.false_alarm_statistics	=3D rtw8723d_false_alarm_statistics,
+	.cfg_ldo25		=3D rtw8723x_cfg_ldo25,
+	.efuse_grant		=3D rtw8723x_efuse_grant,
+	.false_alarm_statistics	=3D rtw8723x_false_alarm_statistics,
 	.phy_calibration	=3D rtw8723d_phy_calibration,
 	.cck_pd_set		=3D rtw8723d_phy_cck_pd_set,
 	.pwr_track		=3D rtw8723d_pwr_track,
 	.config_bfee		=3D NULL,
 	.set_gid_table		=3D NULL,
 	.cfg_csi_rate		=3D NULL,
-	.fill_txdesc_checksum	=3D rtw8723d_fill_txdesc_checksum,
+	.fill_txdesc_checksum	=3D rtw8723x_fill_txdesc_checksum,

-	.coex_set_init		=3D rtw8723d_coex_cfg_init,
+	.coex_set_init		=3D rtw8723x_coex_cfg_init,
 	.coex_set_ant_switch	=3D NULL,
 	.coex_set_gnt_fix	=3D rtw8723d_coex_cfg_gnt_fix,
 	.coex_set_gnt_debug	=3D rtw8723d_coex_cfg_gnt_debug,
@@ -2592,22 +2039,6 @@ static const struct rtw_rqpn rqpn_table_8723d[] =3D=
 {
 	 RTW_DMA_MAPPING_EXTRA, RTW_DMA_MAPPING_HIGH},
 };

-static const struct rtw_prioq_addrs prioq_addrs_8723d =3D {
-	.prio[RTW_DMA_MAPPING_EXTRA] =3D {
-		.rsvd =3D REG_RQPN_NPQ + 2, .avail =3D REG_RQPN_NPQ + 3,
-	},
-	.prio[RTW_DMA_MAPPING_LOW] =3D {
-		.rsvd =3D REG_RQPN + 1, .avail =3D REG_FIFOPAGE_CTRL_2 + 1,
-	},
-	.prio[RTW_DMA_MAPPING_NORMAL] =3D {
-		.rsvd =3D REG_RQPN_NPQ, .avail =3D REG_RQPN_NPQ + 1,
-	},
-	.prio[RTW_DMA_MAPPING_HIGH] =3D {
-		.rsvd =3D REG_RQPN, .avail =3D REG_FIFOPAGE_CTRL_2,
-	},
-	.wsize =3D false,
-};
-
 static const struct rtw_intf_phy_para pcie_gen1_param_8723d[] =3D {
 	{0x0008, 0x4a22,
 	 RTW_IP_SEL_PHY,
@@ -2628,28 +2059,6 @@ static const struct rtw_intf_phy_para_table phy_par=
a_table_8723d =3D {
 	.n_gen1_para	=3D ARRAY_SIZE(pcie_gen1_param_8723d),
 };

-static const struct rtw_hw_reg rtw8723d_dig[] =3D {
-	[0] =3D { .addr =3D 0xc50, .mask =3D 0x7f },
-	[1] =3D { .addr =3D 0xc50, .mask =3D 0x7f },
-};
-
-static const struct rtw_hw_reg rtw8723d_dig_cck[] =3D {
-	[0] =3D { .addr =3D 0xa0c, .mask =3D 0x3f00 },
-};
-
-static const struct rtw_rf_sipi_addr rtw8723d_rf_sipi_addr[] =3D {
-	[RF_PATH_A] =3D { .hssi_1 =3D 0x820, .lssi_read    =3D 0x8a0,
-			.hssi_2 =3D 0x824, .lssi_read_pi =3D 0x8b8},
-	[RF_PATH_B] =3D { .hssi_1 =3D 0x828, .lssi_read    =3D 0x8a4,
-			.hssi_2 =3D 0x82c, .lssi_read_pi =3D 0x8bc},
-};
-
-static const struct rtw_ltecoex_addr rtw8723d_ltecoex_addr =3D {
-	.ctrl =3D REG_LTECOEX_CTRL,
-	.wdata =3D REG_LTECOEX_WRITE_DATA,
-	.rdata =3D REG_LTECOEX_READ_DATA,
-};
-
 static const struct rtw_rfe_def rtw8723d_rfe_defs[] =3D {
 	[0] =3D { .phy_pg_tbl	=3D &rtw8723d_bb_pg_tbl,
 		.txpwr_lmt_tbl	=3D &rtw8723d_txpwr_lmt_tbl,},
@@ -2770,14 +2179,14 @@ const struct rtw_chip_info rtw8723d_hw_spec =3D {
 	.pwr_off_seq =3D card_disable_flow_8723d,
 	.page_table =3D page_table_8723d,
 	.rqpn_table =3D rqpn_table_8723d,
-	.prioq_addrs =3D &prioq_addrs_8723d,
+	.prioq_addrs =3D &rtw8723x_common.prioq_addrs,
 	.intf_table =3D &phy_para_table_8723d,
-	.dig =3D rtw8723d_dig,
-	.dig_cck =3D rtw8723d_dig_cck,
+	.dig =3D rtw8723x_common.dig,
+	.dig_cck =3D rtw8723x_common.dig_cck,
 	.rf_sipi_addr =3D {0x840, 0x844},
-	.rf_sipi_read_addr =3D rtw8723d_rf_sipi_addr,
+	.rf_sipi_read_addr =3D rtw8723x_common.rf_sipi_addr,
 	.fix_rf_phy_num =3D 2,
-	.ltecoex_addr =3D &rtw8723d_ltecoex_addr,
+	.ltecoex_addr =3D &rtw8723x_common.ltecoex_addr,
 	.mac_tbl =3D &rtw8723d_mac_tbl,
 	.agc_tbl =3D &rtw8723d_agc_tbl,
 	.bb_tbl =3D &rtw8723d_bb_tbl,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/w=
ireless/realtek/rtw88/rtw8723d.h
index 2434e2480cb..fba06c9f480 100644
=2D-- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
@@ -5,90 +5,7 @@
 #ifndef __RTW8723D_H__
 #define __RTW8723D_H__

-enum rtw8723d_path {
-	PATH_S1,
-	PATH_S0,
-	PATH_NR,
-};
-
-enum rtw8723d_iqk_round {
-	IQK_ROUND_0,
-	IQK_ROUND_1,
-	IQK_ROUND_2,
-	IQK_ROUND_HYBRID,
-	IQK_ROUND_SIZE,
-	IQK_ROUND_INVALID =3D 0xff,
-};
-
-enum rtw8723d_iqk_result {
-	IQK_S1_TX_X,
-	IQK_S1_TX_Y,
-	IQK_S1_RX_X,
-	IQK_S1_RX_Y,
-	IQK_S0_TX_X,
-	IQK_S0_TX_Y,
-	IQK_S0_RX_X,
-	IQK_S0_RX_Y,
-	IQK_NR,
-	IQK_SX_NR =3D IQK_NR / PATH_NR,
-};
-
-struct rtw8723de_efuse {
-	u8 mac_addr[ETH_ALEN];		/* 0xd0 */
-	u8 vender_id[2];
-	u8 device_id[2];
-	u8 sub_vender_id[2];
-	u8 sub_device_id[2];
-};
-
-struct rtw8723du_efuse {
-	u8 res4[48];                    /* 0xd0 */
-	u8 vender_id[2];                /* 0x100 */
-	u8 product_id[2];               /* 0x102 */
-	u8 usb_option;                  /* 0x104 */
-	u8 res5[2];			/* 0x105 */
-	u8 mac_addr[ETH_ALEN];          /* 0x107 */
-};
-
-struct rtw8723ds_efuse {
-	u8 res4[0x4a];			/* 0xd0 */
-	u8 mac_addr[ETH_ALEN];		/* 0x11a */
-};
-
-struct rtw8723d_efuse {
-	__le16 rtl_id;
-	u8 rsvd[2];
-	u8 afe;
-	u8 rsvd1[11];
-
-	/* power index for four RF paths */
-	struct rtw_txpwr_idx txpwr_idx_table[4];
-
-	u8 channel_plan;		/* 0xb8 */
-	u8 xtal_k;
-	u8 thermal_meter;
-	u8 iqk_lck;
-	u8 pa_type;			/* 0xbc */
-	u8 lna_type_2g[2];		/* 0xbd */
-	u8 lna_type_5g[2];
-	u8 rf_board_option;
-	u8 rf_feature_option;
-	u8 rf_bt_setting;
-	u8 eeprom_version;
-	u8 eeprom_customer_id;
-	u8 tx_bb_swing_setting_2g;
-	u8 res_c7;
-	u8 tx_pwr_calibrate_rate;
-	u8 rf_antenna_option;		/* 0xc9 */
-	u8 rfe_option;
-	u8 country_code[2];
-	u8 res[3];
-	union {
-		struct rtw8723de_efuse e;
-		struct rtw8723du_efuse u;
-		struct rtw8723ds_efuse s;
-	};
-};
+#include "rtw8723x.h"

 extern const struct rtw_chip_info rtw8723d_hw_spec;

@@ -114,193 +31,9 @@ extern const struct rtw_chip_info rtw8723d_hw_spec;
 #define GET_PHY_STAT_P1_RXSNR_A(phy_stat)                                =
      \
 	le32_get_bits(*((__le32 *)(phy_stat) + 0x06), GENMASK(7, 0))

-static inline s32 iqkxy_to_s32(s32 val)
-{
-	/* val is Q10.8 */
-	return sign_extend32(val, 9);
-}
-
-static inline s32 iqk_mult(s32 x, s32 y, s32 *ext)
-{
-	/* x, y and return value are Q10.8 */
-	s32 t;
-
-	t =3D x * y;
-	if (ext)
-		*ext =3D (t >> 7) & 0x1;	/* Q.16 --> Q.9; get LSB of Q.9 */
-
-	return (t >> 8);	/* Q.16 --> Q.8 */
-}
-
-#define OFDM_SWING_A(swing)		FIELD_GET(GENMASK(9, 0), swing)
-#define OFDM_SWING_B(swing)		FIELD_GET(GENMASK(15, 10), swing)
-#define OFDM_SWING_C(swing)		FIELD_GET(GENMASK(21, 16), swing)
-#define OFDM_SWING_D(swing)		FIELD_GET(GENMASK(31, 22), swing)
 #define RTW_DEF_OFDM_SWING_INDEX	28
 #define RTW_DEF_CCK_SWING_INDEX		28

-#define MAX_TOLERANCE	5
-#define IQK_TX_X_ERR	0x142
-#define IQK_TX_Y_ERR	0x42
-#define IQK_RX_X_UPPER	0x11a
-#define IQK_RX_X_LOWER	0xe6
-#define IQK_RX_Y_LMT	0x1a
-#define IQK_TX_OK	BIT(0)
-#define IQK_RX_OK	BIT(1)
-#define PATH_IQK_RETRY	2
-
-#define SPUR_THRES		0x16
 #define CCK_DFIR_NR		3
-#define DIS_3WIRE		0xccf000c0
-#define EN_3WIRE		0xccc000c0
-#define START_PSD		0x400000
-#define FREQ_CH13		0xfccd
-#define FREQ_CH14		0xff9a
-#define RFCFGCH_CHANNEL_MASK	GENMASK(7, 0)
-#define RFCFGCH_BW_MASK		(BIT(11) | BIT(10))
-#define RFCFGCH_BW_20M		(BIT(11) | BIT(10))
-#define RFCFGCH_BW_40M		BIT(10)
-#define BIT_MASK_RFMOD		BIT(0)
-#define BIT_LCK			BIT(15)
-
-#define REG_GPIO_INTM		0x0048
-#define REG_BTG_SEL		0x0067
-#define BIT_MASK_BTG_WL		BIT(7)
-#define REG_LTECOEX_PATH_CONTROL	0x0070
-#define REG_LTECOEX_CTRL	0x07c0
-#define REG_LTECOEX_WRITE_DATA	0x07c4
-#define REG_LTECOEX_READ_DATA	0x07c8
-#define REG_PSDFN		0x0808
-#define REG_BB_PWR_SAV1_11N	0x0874
-#define REG_ANA_PARAM1		0x0880
-#define REG_ANALOG_P4		0x088c
-#define REG_PSDRPT		0x08b4
-#define REG_FPGA1_RFMOD		0x0900
-#define REG_BB_SEL_BTG		0x0948
-#define REG_BBRX_DFIR		0x0954
-#define BIT_MASK_RXBB_DFIR	GENMASK(27, 24)
-#define BIT_RXBB_DFIR_EN	BIT(19)
-#define REG_CCK0_SYS		0x0a00
-#define BIT_CCK_SIDE_BAND	BIT(4)
-#define REG_CCK_ANT_SEL_11N	0x0a04
-#define REG_PWRTH		0x0a08
-#define REG_CCK_FA_RST_11N	0x0a2c
-#define BIT_MASK_CCK_CNT_KEEP	BIT(12)
-#define BIT_MASK_CCK_CNT_EN	BIT(13)
-#define BIT_MASK_CCK_CNT_KPEN	(BIT_MASK_CCK_CNT_KEEP | BIT_MASK_CCK_CNT_E=
N)
-#define BIT_MASK_CCK_FA_KEEP	BIT(14)
-#define BIT_MASK_CCK_FA_EN	BIT(15)
-#define BIT_MASK_CCK_FA_KPEN	(BIT_MASK_CCK_FA_KEEP | BIT_MASK_CCK_FA_EN)
-#define REG_CCK_FA_LSB_11N	0x0a5c
-#define REG_CCK_FA_MSB_11N	0x0a58
-#define REG_CCK_CCA_CNT_11N	0x0a60
-#define BIT_MASK_CCK_FA_MSB	GENMASK(7, 0)
-#define BIT_MASK_CCK_FA_LSB	GENMASK(15, 8)
-#define REG_PWRTH2		0x0aa8
-#define REG_CSRATIO		0x0aaa
-#define REG_OFDM_FA_HOLDC_11N	0x0c00
-#define BIT_MASK_OFDM_FA_KEEP	BIT(31)
-#define REG_BB_RX_PATH_11N	0x0c04
-#define REG_TRMUX_11N		0x0c08
-#define REG_OFDM_FA_RSTC_11N	0x0c0c
-#define BIT_MASK_OFDM_FA_RST	BIT(31)
-#define REG_A_RXIQI		0x0c14
-#define BIT_MASK_RXIQ_S1_X	0x000003FF
-#define BIT_MASK_RXIQ_S1_Y1	0x0000FC00
-#define BIT_SET_RXIQ_S1_Y1(y)	((y) & 0x3F)
-#define REG_OFDM0_RXDSP		0x0c40
-#define BIT_MASK_RXDSP		GENMASK(28, 24)
-#define BIT_EN_RXDSP		BIT(9)
-#define REG_OFDM_0_ECCA_THRESHOLD	0x0c4c
-#define BIT_MASK_OFDM0_EXT_A	BIT(31)
-#define BIT_MASK_OFDM0_EXT_C	BIT(29)
-#define BIT_MASK_OFDM0_EXTS	(BIT(31) | BIT(29) | BIT(28))
-#define BIT_SET_OFDM0_EXTS(a, c, d) (((a) << 31) | ((c) << 29) | ((d) << =
28))
-#define REG_OFDM0_XAAGC1	0x0c50
-#define REG_OFDM0_XBAGC1	0x0c58
-#define REG_AGCRSSI		0x0c78
-#define REG_OFDM_0_XA_TX_IQ_IMBALANCE	0x0c80
-#define BIT_MASK_TXIQ_ELM_A	0x03ff
-#define BIT_SET_TXIQ_ELM_ACD(a, c, d) (((d) << 22) | (((c) & 0x3F) << 16)=
 |    \
-				       ((a) & 0x03ff))
-#define BIT_MASK_TXIQ_ELM_C	GENMASK(21, 16)
-#define BIT_SET_TXIQ_ELM_C2(c)	((c) & 0x3F)
-#define BIT_MASK_TXIQ_ELM_D	GENMASK(31, 22)
-#define REG_TXIQK_MATRIXA_LSB2_11N	0x0c94
-#define BIT_SET_TXIQ_ELM_C1(c)	(((c) & 0x000003C0) >> 6)
-#define REG_RXIQK_MATRIX_LSB_11N	0x0ca0
-#define BIT_MASK_RXIQ_S1_Y2	0xF0000000
-#define BIT_SET_RXIQ_S1_Y2(y)	(((y) >> 6) & 0xF)
-#define REG_TXIQ_AB_S0		0x0cd0
-#define BIT_MASK_TXIQ_A_S0	0x000007FE
-#define BIT_MASK_TXIQ_A_EXT_S0	BIT(0)
-#define BIT_MASK_TXIQ_B_S0	0x0007E000
-#define REG_TXIQ_CD_S0		0x0cd4
-#define BIT_MASK_TXIQ_C_S0	0x000007FE
-#define BIT_MASK_TXIQ_C_EXT_S0	BIT(0)
-#define BIT_MASK_TXIQ_D_S0	GENMASK(22, 13)
-#define BIT_MASK_TXIQ_D_EXT_S0	BIT(12)
-#define REG_RXIQ_AB_S0		0x0cd8
-#define BIT_MASK_RXIQ_X_S0	0x000003FF
-#define BIT_MASK_RXIQ_Y_S0	0x003FF000
-#define REG_OFDM_FA_TYPE1_11N	0x0cf0
-#define BIT_MASK_OFDM_FF_CNT	GENMASK(15, 0)
-#define BIT_MASK_OFDM_SF_CNT	GENMASK(31, 16)
-#define REG_OFDM_FA_RSTD_11N	0x0d00
-#define BIT_MASK_OFDM_FA_RST1	BIT(27)
-#define BIT_MASK_OFDM_FA_KEEP1	BIT(31)
-#define REG_CTX			0x0d03
-#define BIT_MASK_CTX_TYPE	GENMASK(6, 4)
-#define REG_OFDM1_CFOTRK	0x0d2c
-#define BIT_EN_CFOTRK		BIT(28)
-#define REG_OFDM1_CSI1		0x0d40
-#define REG_OFDM1_CSI2		0x0d44
-#define REG_OFDM1_CSI3		0x0d48
-#define REG_OFDM1_CSI4		0x0d4c
-#define REG_OFDM_FA_TYPE2_11N	0x0da0
-#define BIT_MASK_OFDM_CCA_CNT	GENMASK(15, 0)
-#define BIT_MASK_OFDM_PF_CNT	GENMASK(31, 16)
-#define REG_OFDM_FA_TYPE3_11N	0x0da4
-#define BIT_MASK_OFDM_RI_CNT	GENMASK(15, 0)
-#define BIT_MASK_OFDM_CRC_CNT	GENMASK(31, 16)
-#define REG_OFDM_FA_TYPE4_11N	0x0da8
-#define BIT_MASK_OFDM_MNS_CNT	GENMASK(15, 0)
-#define REG_FPGA0_IQK_11N	0x0e28
-#define BIT_MASK_IQK_MOD	0xffffff00
-#define EN_IQK			0x808000
-#define RST_IQK			0x000000
-#define REG_TXIQK_TONE_A_11N	0x0e30
-#define REG_RXIQK_TONE_A_11N	0x0e34
-#define REG_TXIQK_PI_A_11N	0x0e38
-#define REG_RXIQK_PI_A_11N	0x0e3c
-#define REG_TXIQK_11N		0x0e40
-#define BIT_SET_TXIQK_11N(x, y)	(0x80007C00 | ((x) << 16) | (y))
-#define REG_RXIQK_11N		0x0e44
-#define REG_IQK_AGC_PTS_11N	0x0e48
-#define REG_IQK_AGC_RSP_11N	0x0e4c
-#define REG_TX_IQK_TONE_B	0x0e50
-#define REG_RX_IQK_TONE_B	0x0e54
-#define REG_IQK_RES_TX		0x0e94
-#define BIT_MASK_RES_TX		GENMASK(25, 16)
-#define REG_IQK_RES_TY		0x0e9c
-#define BIT_MASK_RES_TY		GENMASK(25, 16)
-#define REG_IQK_RES_RX		0x0ea4
-#define BIT_MASK_RES_RX		GENMASK(25, 16)
-#define REG_IQK_RES_RY		0x0eac
-#define BIT_IQK_TX_FAIL		BIT(28)
-#define BIT_IQK_RX_FAIL		BIT(27)
-#define BIT_IQK_DONE		BIT(26)
-#define BIT_MASK_RES_RY		GENMASK(25, 16)
-#define REG_PAGE_F_RST_11N		0x0f14
-#define BIT_MASK_F_RST_ALL		BIT(16)
-#define REG_IGI_C_11N			0x0f84
-#define REG_IGI_D_11N			0x0f88
-#define REG_HT_CRC32_CNT_11N		0x0f90
-#define BIT_MASK_HT_CRC_OK		GENMASK(15, 0)
-#define BIT_MASK_HT_CRC_ERR		GENMASK(31, 16)
-#define REG_OFDM_CRC32_CNT_11N		0x0f94
-#define BIT_MASK_OFDM_LCRC_OK		GENMASK(15, 0)
-#define BIT_MASK_OFDM_LCRC_ERR		GENMASK(31, 16)
-#define REG_HT_CRC32_CNT_11N_AGG	0x0fb8

 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.c b/drivers/net/w=
ireless/realtek/rtw88/rtw8723x.c
new file mode 100644
index 00000000000..c23650c5a20
=2D-- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
@@ -0,0 +1,562 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright 2024 Fiona Klute
+ *
+ * Based on code originally in rtw8723d.[ch],
+ * Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#include "main.h"
+#include "debug.h"
+#include "phy.h"
+#include "reg.h"
+#include "tx.h"
+#include "rtw8723x.h"
+
+static const struct rtw_hw_reg rtw8723x_txagc[] =3D {
+	[DESC_RATE1M]	=3D { .addr =3D 0xe08, .mask =3D 0x0000ff00 },
+	[DESC_RATE2M]	=3D { .addr =3D 0x86c, .mask =3D 0x0000ff00 },
+	[DESC_RATE5_5M]	=3D { .addr =3D 0x86c, .mask =3D 0x00ff0000 },
+	[DESC_RATE11M]	=3D { .addr =3D 0x86c, .mask =3D 0xff000000 },
+	[DESC_RATE6M]	=3D { .addr =3D 0xe00, .mask =3D 0x000000ff },
+	[DESC_RATE9M]	=3D { .addr =3D 0xe00, .mask =3D 0x0000ff00 },
+	[DESC_RATE12M]	=3D { .addr =3D 0xe00, .mask =3D 0x00ff0000 },
+	[DESC_RATE18M]	=3D { .addr =3D 0xe00, .mask =3D 0xff000000 },
+	[DESC_RATE24M]	=3D { .addr =3D 0xe04, .mask =3D 0x000000ff },
+	[DESC_RATE36M]	=3D { .addr =3D 0xe04, .mask =3D 0x0000ff00 },
+	[DESC_RATE48M]	=3D { .addr =3D 0xe04, .mask =3D 0x00ff0000 },
+	[DESC_RATE54M]	=3D { .addr =3D 0xe04, .mask =3D 0xff000000 },
+	[DESC_RATEMCS0]	=3D { .addr =3D 0xe10, .mask =3D 0x000000ff },
+	[DESC_RATEMCS1]	=3D { .addr =3D 0xe10, .mask =3D 0x0000ff00 },
+	[DESC_RATEMCS2]	=3D { .addr =3D 0xe10, .mask =3D 0x00ff0000 },
+	[DESC_RATEMCS3]	=3D { .addr =3D 0xe10, .mask =3D 0xff000000 },
+	[DESC_RATEMCS4]	=3D { .addr =3D 0xe14, .mask =3D 0x000000ff },
+	[DESC_RATEMCS5]	=3D { .addr =3D 0xe14, .mask =3D 0x0000ff00 },
+	[DESC_RATEMCS6]	=3D { .addr =3D 0xe14, .mask =3D 0x00ff0000 },
+	[DESC_RATEMCS7]	=3D { .addr =3D 0xe14, .mask =3D 0xff000000 },
+};
+
+static void __rtw8723x_lck(struct rtw_dev *rtwdev)
+{
+	u32 lc_cal;
+	u8 val_ctx, rf_val;
+	int ret;
+
+	val_ctx =3D rtw_read8(rtwdev, REG_CTX);
+	if ((val_ctx & BIT_MASK_CTX_TYPE) !=3D 0)
+		rtw_write8(rtwdev, REG_CTX, val_ctx & ~BIT_MASK_CTX_TYPE);
+	else
+		rtw_write8(rtwdev, REG_TXPAUSE, 0xFF);
+	lc_cal =3D rtw_read_rf(rtwdev, RF_PATH_A, RF_CFGCH, RFREG_MASK);
+
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_CFGCH, RFREG_MASK, lc_cal | BIT_LCK);
+
+	ret =3D read_poll_timeout(rtw_read_rf, rf_val, rf_val !=3D 0x1,
+				10000, 1000000, false,
+				rtwdev, RF_PATH_A, RF_CFGCH, BIT_LCK);
+	if (ret)
+		rtw_warn(rtwdev, "failed to poll LCK status bit\n");
+
+	rtw_write_rf(rtwdev, RF_PATH_A, RF_CFGCH, RFREG_MASK, lc_cal);
+	if ((val_ctx & BIT_MASK_CTX_TYPE) !=3D 0)
+		rtw_write8(rtwdev, REG_CTX, val_ctx);
+	else
+		rtw_write8(rtwdev, REG_TXPAUSE, 0x00);
+}
+
+static void rtw8723xe_efuse_parsing(struct rtw_efuse *efuse,
+				    struct rtw8723x_efuse *map)
+{
+	ether_addr_copy(efuse->addr, map->e.mac_addr);
+}
+
+static void rtw8723xu_efuse_parsing(struct rtw_efuse *efuse,
+				    struct rtw8723x_efuse *map)
+{
+	ether_addr_copy(efuse->addr, map->u.mac_addr);
+}
+
+static void rtw8723xs_efuse_parsing(struct rtw_efuse *efuse,
+				    struct rtw8723x_efuse *map)
+{
+	ether_addr_copy(efuse->addr, map->s.mac_addr);
+}
+
+static int __rtw8723x_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
+{
+	struct rtw_efuse *efuse =3D &rtwdev->efuse;
+	struct rtw8723x_efuse *map;
+	int i;
+
+	map =3D (struct rtw8723x_efuse *)log_map;
+
+	efuse->rfe_option =3D 0;
+	efuse->rf_board_option =3D map->rf_board_option;
+	efuse->crystal_cap =3D map->xtal_k;
+	efuse->pa_type_2g =3D map->pa_type;
+	efuse->lna_type_2g =3D map->lna_type_2g[0];
+	efuse->channel_plan =3D map->channel_plan;
+	efuse->country_code[0] =3D map->country_code[0];
+	efuse->country_code[1] =3D map->country_code[1];
+	efuse->bt_setting =3D map->rf_bt_setting;
+	efuse->regd =3D map->rf_board_option & 0x7;
+	efuse->thermal_meter[0] =3D map->thermal_meter;
+	efuse->thermal_meter_k =3D map->thermal_meter;
+	efuse->afe =3D map->afe;
+
+	for (i =3D 0; i < 4; i++)
+		efuse->txpwr_idx_table[i] =3D map->txpwr_idx_table[i];
+
+	switch (rtw_hci_type(rtwdev)) {
+	case RTW_HCI_TYPE_PCIE:
+		rtw8723xe_efuse_parsing(efuse, map);
+		break;
+	case RTW_HCI_TYPE_USB:
+		rtw8723xu_efuse_parsing(efuse, map);
+		break;
+	case RTW_HCI_TYPE_SDIO:
+		rtw8723xs_efuse_parsing(efuse, map);
+		break;
+	default:
+		/* unsupported now */
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+#define BIT_CFENDFORM		BIT(9)
+#define BIT_WMAC_TCR_ERR0	BIT(12)
+#define BIT_WMAC_TCR_ERR1	BIT(13)
+#define BIT_TCR_CFG		(BIT_CFENDFORM | BIT_WMAC_TCR_ERR0 |	       \
+				 BIT_WMAC_TCR_ERR1)
+#define WLAN_RX_FILTER0		0xFFFF
+#define WLAN_RX_FILTER1		0x400
+#define WLAN_RX_FILTER2		0xFFFF
+#define WLAN_RCR_CFG		0x700060CE
+
+static int __rtw8723x_mac_init(struct rtw_dev *rtwdev)
+{
+	rtw_write8(rtwdev, REG_FWHW_TXQ_CTRL + 1, WLAN_TXQ_RPT_EN);
+	rtw_write32(rtwdev, REG_TCR, BIT_TCR_CFG);
+
+	rtw_write16(rtwdev, REG_RXFLTMAP0, WLAN_RX_FILTER0);
+	rtw_write16(rtwdev, REG_RXFLTMAP1, WLAN_RX_FILTER1);
+	rtw_write16(rtwdev, REG_RXFLTMAP2, WLAN_RX_FILTER2);
+	rtw_write32(rtwdev, REG_RCR, WLAN_RCR_CFG);
+
+	rtw_write32(rtwdev, REG_INT_MIG, 0);
+	rtw_write32(rtwdev, REG_MCUTST_1, 0x0);
+
+	rtw_write8(rtwdev, REG_MISC_CTRL, BIT_DIS_SECOND_CCA);
+	rtw_write8(rtwdev, REG_2ND_CCA_CTRL, 0);
+
+	return 0;
+}
+
+static void __rtw8723x_cfg_ldo25(struct rtw_dev *rtwdev, bool enable)
+{
+	u8 ldo_pwr;
+
+	ldo_pwr =3D rtw_read8(rtwdev, REG_LDO_EFUSE_CTRL + 3);
+	if (enable) {
+		ldo_pwr &=3D ~BIT_MASK_LDO25_VOLTAGE;
+		ldo_pwr |=3D (BIT_LDO25_VOLTAGE_V25 << 4) | BIT_LDO25_EN;
+	} else {
+		ldo_pwr &=3D ~BIT_LDO25_EN;
+	}
+	rtw_write8(rtwdev, REG_LDO_EFUSE_CTRL + 3, ldo_pwr);
+}
+
+static void
+rtw8723x_set_tx_power_index_by_rate(struct rtw_dev *rtwdev, u8 path, u8 r=
s)
+{
+	struct rtw_hal *hal =3D &rtwdev->hal;
+	const struct rtw_hw_reg *txagc;
+	u8 rate, pwr_index;
+	int j;
+
+	for (j =3D 0; j < rtw_rate_size[rs]; j++) {
+		rate =3D rtw_rate_section[rs][j];
+		pwr_index =3D hal->tx_pwr_tbl[path][rate];
+
+		if (rate >=3D ARRAY_SIZE(rtw8723x_txagc)) {
+			rtw_warn(rtwdev, "rate 0x%x isn't supported\n", rate);
+			continue;
+		}
+		txagc =3D &rtw8723x_txagc[rate];
+		if (!txagc->addr) {
+			rtw_warn(rtwdev, "rate 0x%x isn't defined\n", rate);
+			continue;
+		}
+
+		rtw_write32_mask(rtwdev, txagc->addr, txagc->mask, pwr_index);
+	}
+}
+
+static void __rtw8723x_set_tx_power_index(struct rtw_dev *rtwdev)
+{
+	struct rtw_hal *hal =3D &rtwdev->hal;
+	int rs, path;
+
+	for (path =3D 0; path < hal->rf_path_num; path++) {
+		for (rs =3D 0; rs <=3D RTW_RATE_SECTION_HT_1S; rs++)
+			rtw8723x_set_tx_power_index_by_rate(rtwdev, path, rs);
+	}
+}
+
+static void __rtw8723x_efuse_grant(struct rtw_dev *rtwdev, bool on)
+{
+	if (on) {
+		rtw_write8(rtwdev, REG_EFUSE_ACCESS, EFUSE_ACCESS_ON);
+
+		rtw_write16_set(rtwdev, REG_SYS_FUNC_EN, BIT_FEN_ELDR);
+		rtw_write16_set(rtwdev, REG_SYS_CLKR, BIT_LOADER_CLK_EN | BIT_ANA8M);
+	} else {
+		rtw_write8(rtwdev, REG_EFUSE_ACCESS, EFUSE_ACCESS_OFF);
+	}
+}
+
+static void __rtw8723x_false_alarm_statistics(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info =3D &rtwdev->dm_info;
+	u32 cck_fa_cnt;
+	u32 ofdm_fa_cnt;
+	u32 crc32_cnt;
+	u32 val32;
+
+	/* hold counter */
+	rtw_write32_mask(rtwdev, REG_OFDM_FA_HOLDC_11N, BIT_MASK_OFDM_FA_KEEP, 1=
);
+	rtw_write32_mask(rtwdev, REG_OFDM_FA_RSTD_11N, BIT_MASK_OFDM_FA_KEEP1, 1=
);
+	rtw_write32_mask(rtwdev, REG_CCK_FA_RST_11N, BIT_MASK_CCK_CNT_KEEP, 1);
+	rtw_write32_mask(rtwdev, REG_CCK_FA_RST_11N, BIT_MASK_CCK_FA_KEEP, 1);
+
+	cck_fa_cnt =3D rtw_read32_mask(rtwdev, REG_CCK_FA_LSB_11N, MASKBYTE0);
+	cck_fa_cnt +=3D rtw_read32_mask(rtwdev, REG_CCK_FA_MSB_11N, MASKBYTE3) <=
< 8;
+
+	val32 =3D rtw_read32(rtwdev, REG_OFDM_FA_TYPE1_11N);
+	ofdm_fa_cnt =3D u32_get_bits(val32, BIT_MASK_OFDM_FF_CNT);
+	ofdm_fa_cnt +=3D u32_get_bits(val32, BIT_MASK_OFDM_SF_CNT);
+	val32 =3D rtw_read32(rtwdev, REG_OFDM_FA_TYPE2_11N);
+	dm_info->ofdm_cca_cnt =3D u32_get_bits(val32, BIT_MASK_OFDM_CCA_CNT);
+	ofdm_fa_cnt +=3D u32_get_bits(val32, BIT_MASK_OFDM_PF_CNT);
+	val32 =3D rtw_read32(rtwdev, REG_OFDM_FA_TYPE3_11N);
+	ofdm_fa_cnt +=3D u32_get_bits(val32, BIT_MASK_OFDM_RI_CNT);
+	ofdm_fa_cnt +=3D u32_get_bits(val32, BIT_MASK_OFDM_CRC_CNT);
+	val32 =3D rtw_read32(rtwdev, REG_OFDM_FA_TYPE4_11N);
+	ofdm_fa_cnt +=3D u32_get_bits(val32, BIT_MASK_OFDM_MNS_CNT);
+
+	dm_info->cck_fa_cnt =3D cck_fa_cnt;
+	dm_info->ofdm_fa_cnt =3D ofdm_fa_cnt;
+	dm_info->total_fa_cnt =3D cck_fa_cnt + ofdm_fa_cnt;
+
+	dm_info->cck_err_cnt =3D rtw_read32(rtwdev, REG_IGI_C_11N);
+	dm_info->cck_ok_cnt =3D rtw_read32(rtwdev, REG_IGI_D_11N);
+	crc32_cnt =3D rtw_read32(rtwdev, REG_OFDM_CRC32_CNT_11N);
+	dm_info->ofdm_err_cnt =3D u32_get_bits(crc32_cnt, BIT_MASK_OFDM_LCRC_ERR=
);
+	dm_info->ofdm_ok_cnt =3D u32_get_bits(crc32_cnt, BIT_MASK_OFDM_LCRC_OK);
+	crc32_cnt =3D rtw_read32(rtwdev, REG_HT_CRC32_CNT_11N);
+	dm_info->ht_err_cnt =3D u32_get_bits(crc32_cnt, BIT_MASK_HT_CRC_ERR);
+	dm_info->ht_ok_cnt =3D u32_get_bits(crc32_cnt, BIT_MASK_HT_CRC_OK);
+	dm_info->vht_err_cnt =3D 0;
+	dm_info->vht_ok_cnt =3D 0;
+
+	val32 =3D rtw_read32(rtwdev, REG_CCK_CCA_CNT_11N);
+	dm_info->cck_cca_cnt =3D (u32_get_bits(val32, BIT_MASK_CCK_FA_MSB) << 8)=
 |
+			       u32_get_bits(val32, BIT_MASK_CCK_FA_LSB);
+	dm_info->total_cca_cnt =3D dm_info->cck_cca_cnt + dm_info->ofdm_cca_cnt;
+
+	/* reset counter */
+	rtw_write32_mask(rtwdev, REG_OFDM_FA_RSTC_11N, BIT_MASK_OFDM_FA_RST, 1);
+	rtw_write32_mask(rtwdev, REG_OFDM_FA_RSTC_11N, BIT_MASK_OFDM_FA_RST, 0);
+	rtw_write32_mask(rtwdev, REG_OFDM_FA_RSTD_11N, BIT_MASK_OFDM_FA_RST1, 1)=
;
+	rtw_write32_mask(rtwdev, REG_OFDM_FA_RSTD_11N, BIT_MASK_OFDM_FA_RST1, 0)=
;
+	rtw_write32_mask(rtwdev, REG_OFDM_FA_HOLDC_11N, BIT_MASK_OFDM_FA_KEEP, 0=
);
+	rtw_write32_mask(rtwdev, REG_OFDM_FA_RSTD_11N, BIT_MASK_OFDM_FA_KEEP1, 0=
);
+	rtw_write32_mask(rtwdev, REG_CCK_FA_RST_11N, BIT_MASK_CCK_CNT_KPEN, 0);
+	rtw_write32_mask(rtwdev, REG_CCK_FA_RST_11N, BIT_MASK_CCK_CNT_KPEN, 2);
+	rtw_write32_mask(rtwdev, REG_CCK_FA_RST_11N, BIT_MASK_CCK_FA_KPEN, 0);
+	rtw_write32_mask(rtwdev, REG_CCK_FA_RST_11N, BIT_MASK_CCK_FA_KPEN, 2);
+	rtw_write32_mask(rtwdev, REG_PAGE_F_RST_11N, BIT_MASK_F_RST_ALL, 1);
+	rtw_write32_mask(rtwdev, REG_PAGE_F_RST_11N, BIT_MASK_F_RST_ALL, 0);
+}
+
+/* IQK (IQ calibration) */
+
+static
+void __rtw8723x_iqk_backup_regs(struct rtw_dev *rtwdev,
+				struct rtw8723x_iqk_backup_regs *backup)
+{
+	int i;
+
+	for (i =3D 0; i < RTW8723X_IQK_ADDA_REG_NUM; i++)
+		backup->adda[i] =3D rtw_read32(rtwdev,
+					     rtw8723x_common.iqk_adda_regs[i]);
+
+	for (i =3D 0; i < RTW8723X_IQK_MAC8_REG_NUM; i++)
+		backup->mac8[i] =3D rtw_read8(rtwdev,
+					    rtw8723x_common.iqk_mac8_regs[i]);
+	for (i =3D 0; i < RTW8723X_IQK_MAC32_REG_NUM; i++)
+		backup->mac32[i] =3D rtw_read32(rtwdev,
+					      rtw8723x_common.iqk_mac32_regs[i]);
+
+	for (i =3D 0; i < RTW8723X_IQK_BB_REG_NUM; i++)
+		backup->bb[i] =3D rtw_read32(rtwdev,
+					   rtw8723x_common.iqk_bb_regs[i]);
+
+	backup->igia =3D rtw_read32_mask(rtwdev, REG_OFDM0_XAAGC1, MASKBYTE0);
+	backup->igib =3D rtw_read32_mask(rtwdev, REG_OFDM0_XBAGC1, MASKBYTE0);
+
+	backup->bb_sel_btg =3D rtw_read32(rtwdev, REG_BB_SEL_BTG);
+}
+
+static
+void __rtw8723x_iqk_restore_regs(struct rtw_dev *rtwdev,
+				 const struct rtw8723x_iqk_backup_regs *backup)
+{
+	int i;
+
+	for (i =3D 0; i < RTW8723X_IQK_ADDA_REG_NUM; i++)
+		rtw_write32(rtwdev, rtw8723x_common.iqk_adda_regs[i],
+			    backup->adda[i]);
+
+	for (i =3D 0; i < RTW8723X_IQK_MAC8_REG_NUM; i++)
+		rtw_write8(rtwdev, rtw8723x_common.iqk_mac8_regs[i],
+			   backup->mac8[i]);
+	for (i =3D 0; i < RTW8723X_IQK_MAC32_REG_NUM; i++)
+		rtw_write32(rtwdev, rtw8723x_common.iqk_mac32_regs[i],
+			    backup->mac32[i]);
+
+	for (i =3D 0; i < RTW8723X_IQK_BB_REG_NUM; i++)
+		rtw_write32(rtwdev, rtw8723x_common.iqk_bb_regs[i],
+			    backup->bb[i]);
+
+	rtw_write32_mask(rtwdev, REG_OFDM0_XAAGC1, MASKBYTE0, 0x50);
+	rtw_write32_mask(rtwdev, REG_OFDM0_XAAGC1, MASKBYTE0, backup->igia);
+
+	rtw_write32_mask(rtwdev, REG_OFDM0_XBAGC1, MASKBYTE0, 0x50);
+	rtw_write32_mask(rtwdev, REG_OFDM0_XBAGC1, MASKBYTE0, backup->igib);
+
+	rtw_write32(rtwdev, REG_TXIQK_TONE_A_11N, 0x01008c00);
+	rtw_write32(rtwdev, REG_RXIQK_TONE_A_11N, 0x01008c00);
+}
+
+static
+bool __rtw8723x_iqk_similarity_cmp(struct rtw_dev *rtwdev,
+				   s32 result[][IQK_NR],
+				   u8 c1, u8 c2)
+{
+	u32 i, j, diff;
+	u32 bitmap =3D 0;
+	u8 candidate[PATH_NR] =3D {IQK_ROUND_INVALID, IQK_ROUND_INVALID};
+	bool ret =3D true;
+
+	s32 tmp1, tmp2;
+
+	for (i =3D 0; i < IQK_NR; i++) {
+		tmp1 =3D iqkxy_to_s32(result[c1][i]);
+		tmp2 =3D iqkxy_to_s32(result[c2][i]);
+
+		diff =3D abs(tmp1 - tmp2);
+
+		if (diff <=3D MAX_TOLERANCE)
+			continue;
+
+		if ((i =3D=3D IQK_S1_RX_X || i =3D=3D IQK_S0_RX_X) && !bitmap) {
+			if (result[c1][i] + result[c1][i + 1] =3D=3D 0)
+				candidate[i / IQK_SX_NR] =3D c2;
+			else if (result[c2][i] + result[c2][i + 1] =3D=3D 0)
+				candidate[i / IQK_SX_NR] =3D c1;
+			else
+				bitmap |=3D BIT(i);
+		} else {
+			bitmap |=3D BIT(i);
+		}
+	}
+
+	if (bitmap !=3D 0)
+		goto check_sim;
+
+	for (i =3D 0; i < PATH_NR; i++) {
+		if (candidate[i] =3D=3D IQK_ROUND_INVALID)
+			continue;
+
+		for (j =3D i * IQK_SX_NR; j < i * IQK_SX_NR + 2; j++)
+			result[IQK_ROUND_HYBRID][j] =3D result[candidate[i]][j];
+		ret =3D false;
+	}
+
+	return ret;
+
+check_sim:
+	for (i =3D 0; i < IQK_NR; i++) {
+		j =3D i & ~1;	/* 2 bits are a pair for IQ[X, Y] */
+		if (bitmap & GENMASK(j + 1, j))
+			continue;
+
+		result[IQK_ROUND_HYBRID][i] =3D result[c1][i];
+	}
+
+	return false;
+}
+
+static u8 __rtw8723x_pwrtrack_get_limit_ofdm(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info =3D &rtwdev->dm_info;
+	u8 tx_rate =3D dm_info->tx_rate;
+	u8 limit_ofdm =3D 30;
+
+	switch (tx_rate) {
+	case DESC_RATE1M...DESC_RATE5_5M:
+	case DESC_RATE11M:
+		break;
+	case DESC_RATE6M...DESC_RATE48M:
+		limit_ofdm =3D 36;
+		break;
+	case DESC_RATE54M:
+		limit_ofdm =3D 34;
+		break;
+	case DESC_RATEMCS0...DESC_RATEMCS2:
+		limit_ofdm =3D 38;
+		break;
+	case DESC_RATEMCS3...DESC_RATEMCS4:
+		limit_ofdm =3D 36;
+		break;
+	case DESC_RATEMCS5...DESC_RATEMCS7:
+		limit_ofdm =3D 34;
+		break;
+	default:
+		rtw_warn(rtwdev, "pwrtrack unhandled tx_rate 0x%x\n", tx_rate);
+		break;
+	}
+
+	return limit_ofdm;
+}
+
+static
+void __rtw8723x_pwrtrack_set_xtal(struct rtw_dev *rtwdev, u8 therm_path,
+				  u8 delta)
+{
+	struct rtw_dm_info *dm_info =3D &rtwdev->dm_info;
+	const struct rtw_pwr_track_tbl *tbl =3D rtwdev->chip->pwr_track_tbl;
+	const s8 *pwrtrk_xtal;
+	s8 xtal_cap;
+
+	if (dm_info->thermal_avg[therm_path] >
+	    rtwdev->efuse.thermal_meter[therm_path])
+		pwrtrk_xtal =3D tbl->pwrtrk_xtal_p;
+	else
+		pwrtrk_xtal =3D tbl->pwrtrk_xtal_n;
+
+	xtal_cap =3D rtwdev->efuse.crystal_cap & 0x3F;
+	xtal_cap =3D clamp_t(s8, xtal_cap + pwrtrk_xtal[delta], 0, 0x3F);
+	rtw_write32_mask(rtwdev, REG_AFE_CTRL3, BIT_MASK_XTAL,
+			 xtal_cap | (xtal_cap << 6));
+}
+
+static
+void __rtw8723x_fill_txdesc_checksum(struct rtw_dev *rtwdev,
+				     struct rtw_tx_pkt_info *pkt_info,
+				     u8 *txdesc)
+{
+	size_t words =3D 32 / 2; /* calculate the first 32 bytes (16 words) */
+	__le16 chksum =3D 0;
+	__le16 *data =3D (__le16 *)(txdesc);
+	struct rtw_tx_desc *tx_desc =3D (struct rtw_tx_desc *)txdesc;
+
+	le32p_replace_bits(&tx_desc->w7, 0, RTW_TX_DESC_W7_TXDESC_CHECKSUM);
+
+	while (words--)
+		chksum ^=3D *data++;
+
+	chksum =3D ~chksum;
+
+	le32p_replace_bits(&tx_desc->w7, __le16_to_cpu(chksum),
+			   RTW_TX_DESC_W7_TXDESC_CHECKSUM);
+}
+
+static void __rtw8723x_coex_cfg_init(struct rtw_dev *rtwdev)
+{
+	/* enable TBTT nterrupt */
+	rtw_write8_set(rtwdev, REG_BCN_CTRL, BIT_EN_BCN_FUNCTION);
+
+	/* BT report packet sample rate	 */
+	/* 0x790[5:0]=3D0x5 */
+	rtw_write8_mask(rtwdev, REG_BT_TDMA_TIME, BIT_MASK_SAMPLE_RATE, 0x5);
+
+	/* enable BT counter statistics */
+	rtw_write8(rtwdev, REG_BT_STAT_CTRL, 0x1);
+
+	/* enable PTA (3-wire function form BT side) */
+	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_BT_PTA_EN);
+	rtw_write32_set(rtwdev, REG_GPIO_MUXCFG, BIT_PO_BT_PTA_PINS);
+
+	/* enable PTA (tx/rx signal form WiFi side) */
+	rtw_write8_set(rtwdev, REG_QUEUE_CTRL, BIT_PTA_WL_TX_EN);
+}
+
+const struct rtw8723x_common rtw8723x_common =3D {
+	.iqk_adda_regs =3D {
+		0x85c, 0xe6c, 0xe70, 0xe74, 0xe78, 0xe7c, 0xe80, 0xe84,
+		0xe88, 0xe8c, 0xed0, 0xed4, 0xed8, 0xedc, 0xee0, 0xeec
+	},
+	.iqk_mac8_regs =3D {0x522, 0x550, 0x551},
+	.iqk_mac32_regs =3D {0x40},
+	.iqk_bb_regs =3D {
+		0xc04, 0xc08, 0x874, 0xb68, 0xb6c, 0x870, 0x860, 0x864, 0xa04
+	},
+
+	.ltecoex_addr =3D {
+		.ctrl =3D REG_LTECOEX_CTRL,
+		.wdata =3D REG_LTECOEX_WRITE_DATA,
+		.rdata =3D REG_LTECOEX_READ_DATA,
+	},
+	.rf_sipi_addr =3D {
+		[RF_PATH_A] =3D { .hssi_1 =3D 0x820, .lssi_read    =3D 0x8a0,
+				.hssi_2 =3D 0x824, .lssi_read_pi =3D 0x8b8},
+		[RF_PATH_B] =3D { .hssi_1 =3D 0x828, .lssi_read    =3D 0x8a4,
+				.hssi_2 =3D 0x82c, .lssi_read_pi =3D 0x8bc},
+	},
+	.dig =3D {
+		[0] =3D { .addr =3D 0xc50, .mask =3D 0x7f },
+		[1] =3D { .addr =3D 0xc50, .mask =3D 0x7f },
+	},
+	.dig_cck =3D {
+		[0] =3D { .addr =3D 0xa0c, .mask =3D 0x3f00 },
+	},
+	.prioq_addrs =3D {
+		.prio[RTW_DMA_MAPPING_EXTRA] =3D {
+			.rsvd =3D REG_RQPN_NPQ + 2, .avail =3D REG_RQPN_NPQ + 3,
+		},
+		.prio[RTW_DMA_MAPPING_LOW] =3D {
+			.rsvd =3D REG_RQPN + 1, .avail =3D REG_FIFOPAGE_CTRL_2 + 1,
+		},
+		.prio[RTW_DMA_MAPPING_NORMAL] =3D {
+			.rsvd =3D REG_RQPN_NPQ, .avail =3D REG_RQPN_NPQ + 1,
+		},
+		.prio[RTW_DMA_MAPPING_HIGH] =3D {
+			.rsvd =3D REG_RQPN, .avail =3D REG_FIFOPAGE_CTRL_2,
+		},
+		.wsize =3D false,
+	},
+
+	.lck =3D __rtw8723x_lck,
+	.read_efuse =3D __rtw8723x_read_efuse,
+	.mac_init =3D __rtw8723x_mac_init,
+	.cfg_ldo25 =3D __rtw8723x_cfg_ldo25,
+	.set_tx_power_index =3D __rtw8723x_set_tx_power_index,
+	.efuse_grant =3D __rtw8723x_efuse_grant,
+	.false_alarm_statistics =3D __rtw8723x_false_alarm_statistics,
+	.iqk_backup_regs =3D __rtw8723x_iqk_backup_regs,
+	.iqk_restore_regs =3D __rtw8723x_iqk_restore_regs,
+	.iqk_similarity_cmp =3D __rtw8723x_iqk_similarity_cmp,
+	.pwrtrack_get_limit_ofdm =3D __rtw8723x_pwrtrack_get_limit_ofdm,
+	.pwrtrack_set_xtal =3D __rtw8723x_pwrtrack_set_xtal,
+	.coex_cfg_init =3D __rtw8723x_coex_cfg_init,
+	.fill_txdesc_checksum =3D __rtw8723x_fill_txdesc_checksum,
+};
+EXPORT_SYMBOL(rtw8723x_common);
+
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_AUTHOR("Fiona Klute <fiona.klute@gmx.de>");
+MODULE_DESCRIPTION("Common functions for Realtek 802.11n wireless 8723x d=
rivers");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.h b/drivers/net/w=
ireless/realtek/rtw88/rtw8723x.h
new file mode 100644
index 00000000000..cace285fc03
=2D-- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.h
@@ -0,0 +1,496 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright 2024 Fiona Klute
+ *
+ * Based on code originally in rtw8723d.[ch],
+ * Copyright(c) 2018-2019  Realtek Corporation
+ */
+
+#ifndef __RTW8723X_H__
+#define __RTW8723X_H__
+
+#include "main.h"
+#include "debug.h"
+#include "phy.h"
+#include "reg.h"
+
+enum rtw8723x_path {
+	PATH_S1,
+	PATH_S0,
+	PATH_NR,
+};
+
+enum rtw8723x_iqk_round {
+	IQK_ROUND_0,
+	IQK_ROUND_1,
+	IQK_ROUND_2,
+	IQK_ROUND_HYBRID,
+	IQK_ROUND_SIZE,
+	IQK_ROUND_INVALID =3D 0xff,
+};
+
+enum rtw8723x_iqk_result {
+	IQK_S1_TX_X,
+	IQK_S1_TX_Y,
+	IQK_S1_RX_X,
+	IQK_S1_RX_Y,
+	IQK_S0_TX_X,
+	IQK_S0_TX_Y,
+	IQK_S0_RX_X,
+	IQK_S0_RX_Y,
+	IQK_NR,
+	IQK_SX_NR =3D IQK_NR / PATH_NR,
+};
+
+struct rtw8723xe_efuse {
+	u8 mac_addr[ETH_ALEN];		/* 0xd0 */
+	u8 vendor_id[2];
+	u8 device_id[2];
+	u8 sub_vendor_id[2];
+	u8 sub_device_id[2];
+};
+
+struct rtw8723xu_efuse {
+	u8 res4[48];                    /* 0xd0 */
+	u8 vendor_id[2];                /* 0x100 */
+	u8 product_id[2];               /* 0x102 */
+	u8 usb_option;                  /* 0x104 */
+	u8 res5[2];			/* 0x105 */
+	u8 mac_addr[ETH_ALEN];          /* 0x107 */
+};
+
+struct rtw8723xs_efuse {
+	u8 res4[0x4a];			/* 0xd0 */
+	u8 mac_addr[ETH_ALEN];		/* 0x11a */
+};
+
+struct rtw8723x_efuse {
+	__le16 rtl_id;
+	u8 rsvd[2];
+	u8 afe;
+	u8 rsvd1[11];
+
+	/* power index for four RF paths */
+	struct rtw_txpwr_idx txpwr_idx_table[4];
+
+	u8 channel_plan;		/* 0xb8 */
+	u8 xtal_k;
+	u8 thermal_meter;
+	u8 iqk_lck;
+	u8 pa_type;			/* 0xbc */
+	u8 lna_type_2g[2];		/* 0xbd */
+	u8 lna_type_5g[2];
+	u8 rf_board_option;
+	u8 rf_feature_option;
+	u8 rf_bt_setting;
+	u8 eeprom_version;
+	u8 eeprom_customer_id;
+	u8 tx_bb_swing_setting_2g;
+	u8 res_c7;
+	u8 tx_pwr_calibrate_rate;
+	u8 rf_antenna_option;		/* 0xc9 */
+	u8 rfe_option;
+	u8 country_code[2];
+	u8 res[3];
+	union {
+		struct rtw8723xe_efuse e;
+		struct rtw8723xu_efuse u;
+		struct rtw8723xs_efuse s;
+	};
+};
+
+#define RTW8723X_IQK_ADDA_REG_NUM	16
+#define RTW8723X_IQK_MAC8_REG_NUM	3
+#define RTW8723X_IQK_MAC32_REG_NUM	1
+#define RTW8723X_IQK_BB_REG_NUM		9
+
+struct rtw8723x_iqk_backup_regs {
+	u32 adda[RTW8723X_IQK_ADDA_REG_NUM];
+	u8 mac8[RTW8723X_IQK_MAC8_REG_NUM];
+	u32 mac32[RTW8723X_IQK_MAC32_REG_NUM];
+	u32 bb[RTW8723X_IQK_BB_REG_NUM];
+
+	u32 lte_path;
+	u32 lte_gnt;
+
+	u32 bb_sel_btg;
+	u8 btg_sel;
+
+	u8 igia;
+	u8 igib;
+};
+
+struct rtw8723x_common {
+	/* registers that must be backed up before IQK and restored after */
+	u32 iqk_adda_regs[RTW8723X_IQK_ADDA_REG_NUM];
+	u32 iqk_mac8_regs[RTW8723X_IQK_MAC8_REG_NUM];
+	u32 iqk_mac32_regs[RTW8723X_IQK_MAC32_REG_NUM];
+	u32 iqk_bb_regs[RTW8723X_IQK_BB_REG_NUM];
+
+	/* chip register definitions */
+	struct rtw_ltecoex_addr ltecoex_addr;
+	struct rtw_rf_sipi_addr rf_sipi_addr[2];
+	struct rtw_hw_reg dig[2];
+	struct rtw_hw_reg dig_cck[1];
+	struct rtw_prioq_addrs prioq_addrs;
+
+	/* common functions */
+	void (*lck)(struct rtw_dev *rtwdev);
+	int (*read_efuse)(struct rtw_dev *rtwdev, u8 *log_map);
+	int (*mac_init)(struct rtw_dev *rtwdev);
+	void (*cfg_ldo25)(struct rtw_dev *rtwdev, bool enable);
+	void (*set_tx_power_index)(struct rtw_dev *rtwdev);
+	void (*efuse_grant)(struct rtw_dev *rtwdev, bool on);
+	void (*false_alarm_statistics)(struct rtw_dev *rtwdev);
+	void (*iqk_backup_regs)(struct rtw_dev *rtwdev,
+				struct rtw8723x_iqk_backup_regs *backup);
+	void (*iqk_restore_regs)(struct rtw_dev *rtwdev,
+				 const struct rtw8723x_iqk_backup_regs *backup);
+	bool (*iqk_similarity_cmp)(struct rtw_dev *rtwdev, s32 result[][IQK_NR],
+				   u8 c1, u8 c2);
+	u8 (*pwrtrack_get_limit_ofdm)(struct rtw_dev *rtwdev);
+	void (*pwrtrack_set_xtal)(struct rtw_dev *rtwdev, u8 therm_path,
+				  u8 delta);
+	void (*coex_cfg_init)(struct rtw_dev *rtwdev);
+	void (*fill_txdesc_checksum)(struct rtw_dev *rtwdev,
+				     struct rtw_tx_pkt_info *pkt_info,
+				     u8 *txdesc);
+};
+
+extern const struct rtw8723x_common rtw8723x_common;
+
+#define PATH_IQK_RETRY	2
+#define MAX_TOLERANCE	5
+#define IQK_TX_X_ERR	0x142
+#define IQK_TX_Y_ERR	0x42
+#define IQK_RX_X_UPPER	0x11a
+#define IQK_RX_X_LOWER	0xe6
+#define IQK_RX_Y_LMT	0x1a
+#define IQK_TX_OK	BIT(0)
+#define IQK_RX_OK	BIT(1)
+
+#define WLAN_TXQ_RPT_EN		0x1F
+
+#define SPUR_THRES		0x16
+#define DIS_3WIRE		0xccf000c0
+#define EN_3WIRE		0xccc000c0
+#define START_PSD		0x400000
+#define FREQ_CH13		0xfccd
+#define FREQ_CH14		0xff9a
+#define RFCFGCH_CHANNEL_MASK	GENMASK(7, 0)
+#define RFCFGCH_BW_MASK		(BIT(11) | BIT(10))
+#define RFCFGCH_BW_20M		(BIT(11) | BIT(10))
+#define RFCFGCH_BW_40M		BIT(10)
+#define BIT_MASK_RFMOD		BIT(0)
+#define BIT_LCK			BIT(15)
+
+#define REG_GPIO_INTM		0x0048
+#define REG_BTG_SEL		0x0067
+#define BIT_MASK_BTG_WL		BIT(7)
+#define REG_LTECOEX_PATH_CONTROL	0x0070
+#define REG_LTECOEX_CTRL	0x07c0
+#define REG_LTECOEX_WRITE_DATA	0x07c4
+#define REG_LTECOEX_READ_DATA	0x07c8
+#define REG_PSDFN		0x0808
+#define REG_BB_PWR_SAV1_11N	0x0874
+#define REG_ANA_PARAM1		0x0880
+#define REG_ANALOG_P4		0x088c
+#define REG_PSDRPT		0x08b4
+#define REG_FPGA1_RFMOD		0x0900
+#define REG_BB_SEL_BTG		0x0948
+#define REG_BBRX_DFIR		0x0954
+#define BIT_MASK_RXBB_DFIR	GENMASK(27, 24)
+#define BIT_RXBB_DFIR_EN	BIT(19)
+#define REG_CCK0_SYS		0x0a00
+#define BIT_CCK_SIDE_BAND	BIT(4)
+#define REG_CCK_ANT_SEL_11N	0x0a04
+#define REG_PWRTH		0x0a08
+#define REG_CCK_FA_RST_11N	0x0a2c
+#define BIT_MASK_CCK_CNT_KEEP	BIT(12)
+#define BIT_MASK_CCK_CNT_EN	BIT(13)
+#define BIT_MASK_CCK_CNT_KPEN	(BIT_MASK_CCK_CNT_KEEP | BIT_MASK_CCK_CNT_E=
N)
+#define BIT_MASK_CCK_FA_KEEP	BIT(14)
+#define BIT_MASK_CCK_FA_EN	BIT(15)
+#define BIT_MASK_CCK_FA_KPEN	(BIT_MASK_CCK_FA_KEEP | BIT_MASK_CCK_FA_EN)
+#define REG_CCK_FA_LSB_11N	0x0a5c
+#define REG_CCK_FA_MSB_11N	0x0a58
+#define REG_CCK_CCA_CNT_11N	0x0a60
+#define BIT_MASK_CCK_FA_MSB	GENMASK(7, 0)
+#define BIT_MASK_CCK_FA_LSB	GENMASK(15, 8)
+#define REG_PWRTH2		0x0aa8
+#define REG_CSRATIO		0x0aaa
+#define REG_OFDM_FA_HOLDC_11N	0x0c00
+#define BIT_MASK_OFDM_FA_KEEP	BIT(31)
+#define REG_BB_RX_PATH_11N	0x0c04
+#define REG_TRMUX_11N		0x0c08
+#define REG_OFDM_FA_RSTC_11N	0x0c0c
+#define BIT_MASK_OFDM_FA_RST	BIT(31)
+#define REG_A_RXIQI		0x0c14
+#define BIT_MASK_RXIQ_S1_X	0x000003FF
+#define BIT_MASK_RXIQ_S1_Y1	0x0000FC00
+#define BIT_SET_RXIQ_S1_Y1(y)	((y) & 0x3F)
+#define REG_OFDM0_RXDSP		0x0c40
+#define BIT_MASK_RXDSP		GENMASK(28, 24)
+#define BIT_EN_RXDSP		BIT(9)
+#define REG_OFDM_0_ECCA_THRESHOLD	0x0c4c
+#define BIT_MASK_OFDM0_EXT_A	BIT(31)
+#define BIT_MASK_OFDM0_EXT_C	BIT(29)
+#define BIT_MASK_OFDM0_EXTS	(BIT(31) | BIT(29) | BIT(28))
+#define BIT_SET_OFDM0_EXTS(a, c, d) (((a) << 31) | ((c) << 29) | ((d) << =
28))
+#define REG_OFDM0_XAAGC1	0x0c50
+#define REG_OFDM0_XBAGC1	0x0c58
+#define REG_AGCRSSI		0x0c78
+#define REG_OFDM_0_XA_TX_IQ_IMBALANCE	0x0c80
+#define BIT_MASK_TXIQ_ELM_A	0x03ff
+#define BIT_SET_TXIQ_ELM_ACD(a, c, d) (((d) << 22) | (((c) & 0x3F) << 16)=
 |    \
+				       ((a) & 0x03ff))
+#define BIT_MASK_TXIQ_ELM_C	GENMASK(21, 16)
+#define BIT_SET_TXIQ_ELM_C2(c)	((c) & 0x3F)
+#define BIT_MASK_TXIQ_ELM_D	GENMASK(31, 22)
+#define REG_TXIQK_MATRIXA_LSB2_11N	0x0c94
+#define BIT_SET_TXIQ_ELM_C1(c)	(((c) & 0x000003C0) >> 6)
+#define REG_RXIQK_MATRIX_LSB_11N	0x0ca0
+#define BIT_MASK_RXIQ_S1_Y2	0xF0000000
+#define BIT_SET_RXIQ_S1_Y2(y)	(((y) >> 6) & 0xF)
+#define REG_TXIQ_AB_S0		0x0cd0
+#define BIT_MASK_TXIQ_A_S0	0x000007FE
+#define BIT_MASK_TXIQ_A_EXT_S0	BIT(0)
+#define BIT_MASK_TXIQ_B_S0	0x0007E000
+#define REG_TXIQ_CD_S0		0x0cd4
+#define BIT_MASK_TXIQ_C_S0	0x000007FE
+#define BIT_MASK_TXIQ_C_EXT_S0	BIT(0)
+#define BIT_MASK_TXIQ_D_S0	GENMASK(22, 13)
+#define BIT_MASK_TXIQ_D_EXT_S0	BIT(12)
+#define REG_RXIQ_AB_S0		0x0cd8
+#define BIT_MASK_RXIQ_X_S0	0x000003FF
+#define BIT_MASK_RXIQ_Y_S0	0x003FF000
+#define REG_OFDM_FA_TYPE1_11N	0x0cf0
+#define BIT_MASK_OFDM_FF_CNT	GENMASK(15, 0)
+#define BIT_MASK_OFDM_SF_CNT	GENMASK(31, 16)
+#define REG_OFDM_FA_RSTD_11N	0x0d00
+#define BIT_MASK_OFDM_FA_RST1	BIT(27)
+#define BIT_MASK_OFDM_FA_KEEP1	BIT(31)
+#define REG_CTX			0x0d03
+#define BIT_MASK_CTX_TYPE	GENMASK(6, 4)
+#define REG_OFDM1_CFOTRK	0x0d2c
+#define BIT_EN_CFOTRK		BIT(28)
+#define REG_OFDM1_CSI1		0x0d40
+#define REG_OFDM1_CSI2		0x0d44
+#define REG_OFDM1_CSI3		0x0d48
+#define REG_OFDM1_CSI4		0x0d4c
+#define REG_OFDM_FA_TYPE2_11N	0x0da0
+#define BIT_MASK_OFDM_CCA_CNT	GENMASK(15, 0)
+#define BIT_MASK_OFDM_PF_CNT	GENMASK(31, 16)
+#define REG_OFDM_FA_TYPE3_11N	0x0da4
+#define BIT_MASK_OFDM_RI_CNT	GENMASK(15, 0)
+#define BIT_MASK_OFDM_CRC_CNT	GENMASK(31, 16)
+#define REG_OFDM_FA_TYPE4_11N	0x0da8
+#define BIT_MASK_OFDM_MNS_CNT	GENMASK(15, 0)
+#define REG_FPGA0_IQK_11N	0x0e28
+#define BIT_MASK_IQK_MOD	0xffffff00
+#define EN_IQK			0x808000
+#define RST_IQK			0x000000
+#define REG_TXIQK_TONE_A_11N	0x0e30
+#define REG_RXIQK_TONE_A_11N	0x0e34
+#define REG_TXIQK_PI_A_11N	0x0e38
+#define REG_RXIQK_PI_A_11N	0x0e3c
+#define REG_TXIQK_11N		0x0e40
+#define BIT_SET_TXIQK_11N(x, y)	(0x80007C00 | ((x) << 16) | (y))
+#define REG_RXIQK_11N		0x0e44
+#define REG_IQK_AGC_PTS_11N	0x0e48
+#define REG_IQK_AGC_RSP_11N	0x0e4c
+#define REG_TX_IQK_TONE_B	0x0e50
+#define REG_RX_IQK_TONE_B	0x0e54
+#define REG_IQK_RES_TX		0x0e94
+#define BIT_MASK_RES_TX		GENMASK(25, 16)
+#define REG_IQK_RES_TY		0x0e9c
+#define BIT_MASK_RES_TY		GENMASK(25, 16)
+#define REG_IQK_RES_RX		0x0ea4
+#define BIT_MASK_RES_RX		GENMASK(25, 16)
+#define REG_IQK_RES_RY		0x0eac
+#define BIT_IQK_TX_FAIL		BIT(28)
+#define BIT_IQK_RX_FAIL		BIT(27)
+#define BIT_IQK_DONE		BIT(26)
+#define BIT_MASK_RES_RY		GENMASK(25, 16)
+#define REG_PAGE_F_RST_11N		0x0f14
+#define BIT_MASK_F_RST_ALL		BIT(16)
+#define REG_IGI_C_11N			0x0f84
+#define REG_IGI_D_11N			0x0f88
+#define REG_HT_CRC32_CNT_11N		0x0f90
+#define BIT_MASK_HT_CRC_OK		GENMASK(15, 0)
+#define BIT_MASK_HT_CRC_ERR		GENMASK(31, 16)
+#define REG_OFDM_CRC32_CNT_11N		0x0f94
+#define BIT_MASK_OFDM_LCRC_OK		GENMASK(15, 0)
+#define BIT_MASK_OFDM_LCRC_ERR		GENMASK(31, 16)
+#define REG_HT_CRC32_CNT_11N_AGG	0x0fb8
+
+#define OFDM_SWING_A(swing)		FIELD_GET(GENMASK(9, 0), swing)
+#define OFDM_SWING_B(swing)		FIELD_GET(GENMASK(15, 10), swing)
+#define OFDM_SWING_C(swing)		FIELD_GET(GENMASK(21, 16), swing)
+#define OFDM_SWING_D(swing)		FIELD_GET(GENMASK(31, 22), swing)
+
+static inline s32 iqkxy_to_s32(s32 val)
+{
+	/* val is Q10.8 */
+	return sign_extend32(val, 9);
+}
+
+static inline s32 iqk_mult(s32 x, s32 y, s32 *ext)
+{
+	/* x, y and return value are Q10.8 */
+	s32 t;
+
+	t =3D x * y;
+	if (ext)
+		*ext =3D (t >> 7) & 0x1;	/* Q.16 --> Q.9; get LSB of Q.9 */
+
+	return (t >> 8);	/* Q.16 --> Q.8 */
+}
+
+static inline void rtw8723x_lck(struct rtw_dev *rtwdev)
+{
+	rtw8723x_common.lck(rtwdev);
+}
+
+static inline int rtw8723x_read_efuse(struct rtw_dev *rtwdev, u8 *log_map=
)
+{
+	return rtw8723x_common.read_efuse(rtwdev, log_map);
+}
+
+static inline int rtw8723x_mac_init(struct rtw_dev *rtwdev)
+{
+	return rtw8723x_common.mac_init(rtwdev);
+}
+
+static inline void rtw8723x_cfg_ldo25(struct rtw_dev *rtwdev, bool enable=
)
+{
+	rtw8723x_common.cfg_ldo25(rtwdev, enable);
+}
+
+static inline void rtw8723x_set_tx_power_index(struct rtw_dev *rtwdev)
+{
+	rtw8723x_common.set_tx_power_index(rtwdev);
+}
+
+static inline void rtw8723x_efuse_grant(struct rtw_dev *rtwdev, bool on)
+{
+	rtw8723x_common.efuse_grant(rtwdev, on);
+}
+
+static inline void rtw8723x_false_alarm_statistics(struct rtw_dev *rtwdev=
)
+{
+	rtw8723x_common.false_alarm_statistics(rtwdev);
+}
+
+static inline
+void rtw8723x_iqk_backup_regs(struct rtw_dev *rtwdev,
+			      struct rtw8723x_iqk_backup_regs *backup)
+{
+	rtw8723x_common.iqk_backup_regs(rtwdev, backup);
+}
+
+static inline
+void rtw8723x_iqk_restore_regs(struct rtw_dev *rtwdev,
+			       const struct rtw8723x_iqk_backup_regs *backup)
+{
+	rtw8723x_common.iqk_restore_regs(rtwdev, backup);
+}
+
+static inline
+bool rtw8723x_iqk_similarity_cmp(struct rtw_dev *rtwdev, s32 result[][IQK=
_NR],
+				 u8 c1, u8 c2)
+{
+	return rtw8723x_common.iqk_similarity_cmp(rtwdev, result, c1, c2);
+}
+
+static inline u8 rtw8723x_pwrtrack_get_limit_ofdm(struct rtw_dev *rtwdev)
+{
+	return rtw8723x_common.pwrtrack_get_limit_ofdm(rtwdev);
+}
+
+static inline
+void rtw8723x_pwrtrack_set_xtal(struct rtw_dev *rtwdev, u8 therm_path,
+				u8 delta)
+{
+	rtw8723x_common.pwrtrack_set_xtal(rtwdev, therm_path, delta);
+}
+
+static inline void rtw8723x_coex_cfg_init(struct rtw_dev *rtwdev)
+{
+	rtw8723x_common.coex_cfg_init(rtwdev);
+}
+
+static inline
+void rtw8723x_fill_txdesc_checksum(struct rtw_dev *rtwdev,
+				   struct rtw_tx_pkt_info *pkt_info,
+				   u8 *txdesc)
+{
+	rtw8723x_common.fill_txdesc_checksum(rtwdev, pkt_info, txdesc);
+}
+
+/* IQK helper functions, defined as inline so they can be shared
+ * without needing an EXPORT_SYMBOL each.
+ */
+static inline void
+rtw8723x_iqk_backup_path_ctrl(struct rtw_dev *rtwdev,
+			      struct rtw8723x_iqk_backup_regs *backup)
+{
+	backup->btg_sel =3D rtw_read8(rtwdev, REG_BTG_SEL);
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] original 0x67 =3D 0x%x\n",
+		backup->btg_sel);
+}
+
+static inline void rtw8723x_iqk_config_path_ctrl(struct rtw_dev *rtwdev)
+{
+	rtw_write32_mask(rtwdev, REG_PAD_CTRL1, BIT_BT_BTG_SEL, 0x1);
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] set 0x67 =3D 0x%x\n",
+		rtw_read32_mask(rtwdev, REG_PAD_CTRL1, MASKBYTE3));
+}
+
+static inline void
+rtw8723x_iqk_restore_path_ctrl(struct rtw_dev *rtwdev,
+			       const struct rtw8723x_iqk_backup_regs *backup)
+{
+	rtw_write8(rtwdev, REG_BTG_SEL, backup->btg_sel);
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] restore 0x67 =3D 0x%x\n",
+		rtw_read32_mask(rtwdev, REG_PAD_CTRL1, MASKBYTE3));
+}
+
+static inline void
+rtw8723x_iqk_backup_lte_path_gnt(struct rtw_dev *rtwdev,
+				 struct rtw8723x_iqk_backup_regs *backup)
+{
+	backup->lte_path =3D rtw_read32(rtwdev, REG_LTECOEX_PATH_CONTROL);
+	rtw_write32(rtwdev, REG_LTECOEX_CTRL, 0x800f0038);
+	mdelay(1);
+	backup->lte_gnt =3D rtw_read32(rtwdev, REG_LTECOEX_READ_DATA);
+	rtw_dbg(rtwdev, RTW_DBG_RFK, "[IQK] OriginalGNT =3D 0x%x\n",
+		backup->lte_gnt);
+}
+
+static inline void
+rtw8723x_iqk_config_lte_path_gnt(struct rtw_dev *rtwdev,
+				 u32 write_data)
+{
+	rtw_write32(rtwdev, REG_LTECOEX_WRITE_DATA, write_data);
+	rtw_write32(rtwdev, REG_LTECOEX_CTRL, 0xc0020038);
+	rtw_write32_mask(rtwdev, REG_LTECOEX_PATH_CONTROL,
+			 BIT_LTE_MUX_CTRL_PATH, 0x1);
+}
+
+static inline void
+rtw8723x_iqk_restore_lte_path_gnt(struct rtw_dev *rtwdev,
+				  const struct rtw8723x_iqk_backup_regs *bak)
+{
+	rtw_write32(rtwdev, REG_LTECOEX_WRITE_DATA, bak->lte_gnt);
+	rtw_write32(rtwdev, REG_LTECOEX_CTRL, 0xc00f0038);
+	rtw_write32(rtwdev, REG_LTECOEX_PATH_CONTROL, bak->lte_path);
+}
+
+/* set all ADDA registers to the given value */
+static inline void rtw8723x_iqk_path_adda_on(struct rtw_dev *rtwdev, u32 =
value)
+{
+	for (int i =3D 0; i < RTW8723X_IQK_ADDA_REG_NUM; i++)
+		rtw_write32(rtwdev, rtw8723x_common.iqk_adda_regs[i], value);
+}
+
+#endif /* __RTW8723X_H__ */
=2D-
2.43.0


