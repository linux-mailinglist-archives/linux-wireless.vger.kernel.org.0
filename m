Return-Path: <linux-wireless+bounces-4551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002DB877E33
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 11:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6A21F217DD
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 10:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8544938DF1;
	Mon, 11 Mar 2024 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="Sgw+zAhO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC45422081;
	Mon, 11 Mar 2024 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710153504; cv=none; b=Nc6GCs1VL8ciPrpuKe4j6yP9OznOE+PhE+trTaUp4EG/2LDoQ2T01pXI4U3Af73AdD6Zbxj+c8ZQfrKWsF7b73v5ADiwyL/SCdedC5GDJXt/gmSZWhCltAKwuhIoP3sfvLcRLHlgBUnvzAdeJ4/tN8gzfAjr/V1rui34CBovamM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710153504; c=relaxed/simple;
	bh=ooeW0olJcKtrOPC9EaLEKi3aw9llP9kQIYdvZPa1Ujk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCk1HNmKC+9hWjKaSruGQLtR/phB+dD/ClPlT9ojzrBPPVIWIn76Uvyx4J+xGnc3+zDFsB5+n3uJaBT+Ieo/GNkjwRZvpU424S9nNiuOBl3y1Ofk1CoGxhf/oNoS7vdOX3EVq94BqRXYUr9vHnbX5fKZAoegJacpv8NLFambn+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=Sgw+zAhO; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710153488; x=1710758288; i=fiona.klute@gmx.de;
	bh=ooeW0olJcKtrOPC9EaLEKi3aw9llP9kQIYdvZPa1Ujk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=Sgw+zAhOxEfimbFPolE6Dq7fw0CoM95lKr9mT1Q6CXEZuVdctmVCrwhaqtmm6WVK
	 i5qHMHJnMiOGZGFhMWxdCf916Ygr1iJz6Ufxon+hN4ZhiDIySdZcmrz788wccQo/v
	 tTvRvlVH9S98ZmuvlPZtCLZQLXtL9iJumiL9rjK3/h0dOwvKCk9/uc22n5+kszqmg
	 5hjrZTGwCc9LacP41KmSaQDKcUEgmvOUH7OTrKKJ+XCZIR2gGUdYbVVUJdegoAYq6
	 o9JQ3rXnpVK3fN9ff46IM6O9Ofw5ENBQLw/5hl3Hr2HsYq7o+kOAs2jA7r1R6xpeR
	 R7nztaWGdA1VhrmBOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.108.92]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTAFh-1rFbbz1hWB-00UXMF; Mon, 11
 Mar 2024 11:38:08 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: Fiona Klute <fiona.klute@gmx.de>,
	Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
Subject: [PATCH v4 2/9] wifi: rtw88: Debug output for rtw8723x EFUSE
Date: Mon, 11 Mar 2024 11:37:06 +0100
Message-ID: <20240311103735.615541-3-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311103735.615541-1-fiona.klute@gmx.de>
References: <20240311103735.615541-1-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kqzSVtMrLKPYcxd2uZSqJ7X/8mPa5+94xh/076Ez2/gvHOwu6lW
 is9BHg4q3v1nohDct/qojGNRbMiPGARN7ftCvj9YRFobpJ8z1Cper2c78H7EP0gfhIJdrKV
 s/rduU2dO7wDDRDIwelx6PkhbUzNCT+czZtsw1gc0414syYmE+8vnqxN+B3N5E2r1j+XSsC
 Toz0jfIahJBCOVrO99ZTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b0Dwe9m2hp4=;pIvAlr99op8r1ewxKZijL+ko43/
 baxADkFVGhitpKkMkFexUlJAQZB0JBcl82+1gfzpIqFRpy83gxfpDvlH0xP5d7bC9PPk1iF/w
 ffcwltnLl7fPMBBA4iS0zqfavhceVTn5o5STGewXls36iNiXUP7tI/Ts4e6vYIqHDOqlJWAfL
 R6Y+DFeXZOGfVX4OZaN9c1G+HkQ1oy0m/QwYJf+u4ak4X1J3Z7g/5ZxlyNIh2UU9KFXIq14N0
 EUsqXXhvQvd229lIDw1oklOe3WNeVEVLYOEOaYZJf5TX3CrM17wGHm9ntaP8k7dkGyQdMpzxE
 ksPQcgvlZS1M8bu0NYzzTT70VgYPYXDkJCF2YGZOAaBJBKyEOGZWVoiFKp4tlwX73DrYlJtV0
 U8hjyuWqoIXk974lL3SuY/TRvjDibreSfBsTwYFBBbH7iMFk1MVSXNtNjO3GAdWB4uURJ4jLH
 T6xflEQU6iTB/P5IdDQrto+bxd3NNtpnvn51kNHONkcqTQ1E1wp+OTgi5KLoyBgYOXpGWUO3V
 mrVPs0yZI3IilqWhd6PoSGZ7ULPp7bH0o93RbqjsWJZqSmw9/SekZ93tUnCsx1TfXeYl+zk3U
 76SneSPHjBMSIiyrtLSoMO4e9oqS2IttI6CJF96BcXcCKJPx6WtT1XKBVPOISQ2UxpKvxedFy
 ih5C81gQQNnHs5vmh0058LWBTC0GTEI3tgU3HnImpzbYGyNg1nPg/V1Rakv5PbHGdnyq3GzFX
 kZo9/VHzO9wMb+0zV1pEIjETV0ZhjivPgXiAsKsIGPV+c+Jd/NBAK9Wd/i0FblIV6QBddmhIm
 L6ZlLMoobspmAHJvktCGgdpKLdq+q/mTGuv0SbY9XJLtA=

Some 8703b chips contain invalid EFUSE data, getting detailed
information is critical when analyzing issues caused by that.

Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
=2D--
 drivers/net/wireless/realtek/rtw88/rtw8723x.c | 159 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723x.h |  11 ++
 2 files changed, 170 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.c b/drivers/net/w=
ireless/realtek/rtw88/rtw8723x.c
index c23650c5a20..0d0b6c2cb9a 100644
=2D-- a/drivers/net/wireless/realtek/rtw88/rtw8723x.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
@@ -63,6 +63,163 @@ static void __rtw8723x_lck(struct rtw_dev *rtwdev)
 		rtw_write8(rtwdev, REG_TXPAUSE, 0x00);
 }

+#define DBG_EFUSE_VAL(rtwdev, map, name)			\
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, # name "=3D0x%02x\n",	\
+		(map)->name)
+#define DBG_EFUSE_2BYTE(rtwdev, map, name)			\
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, # name "=3D0x%02x%02x\n",	\
+		(map)->name[0], (map)->name[1])
+
+static void rtw8723xe_efuse_debug(struct rtw_dev *rtwdev,
+				  struct rtw8723x_efuse *map)
+{
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "mac_addr=3D%pM\n", map->e.mac_addr);
+	DBG_EFUSE_2BYTE(rtwdev, map, e.vendor_id);
+	DBG_EFUSE_2BYTE(rtwdev, map, e.device_id);
+	DBG_EFUSE_2BYTE(rtwdev, map, e.sub_vendor_id);
+	DBG_EFUSE_2BYTE(rtwdev, map, e.sub_device_id);
+}
+
+static void rtw8723xu_efuse_debug(struct rtw_dev *rtwdev,
+				  struct rtw8723x_efuse *map)
+{
+	DBG_EFUSE_2BYTE(rtwdev, map, u.vendor_id);
+	DBG_EFUSE_2BYTE(rtwdev, map, u.product_id);
+	DBG_EFUSE_VAL(rtwdev, map, u.usb_option);
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "mac_addr=3D%pM\n", map->u.mac_addr);
+}
+
+static void rtw8723xs_efuse_debug(struct rtw_dev *rtwdev,
+				  struct rtw8723x_efuse *map)
+{
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "mac_addr=3D%pM\n", map->s.mac_addr);
+}
+
+static void __rtw8723x_debug_txpwr_limit(struct rtw_dev *rtwdev,
+					 struct rtw_txpwr_idx *table,
+					 int tx_path_count)
+{
+	if (!rtw_dbg_is_enabled(rtwdev, RTW_DBG_EFUSE))
+		return;
+
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE,
+		"Power index table (2.4G):\n");
+	/* CCK base */
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "CCK base\n");
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "RF    G0  G1  G2  G3  G4  G5\n");
+	for (int i =3D 0; i < tx_path_count; i++)
+		rtw_dbg(rtwdev, RTW_DBG_EFUSE,
+			"[%c]: %3u %3u %3u %3u %3u %3u\n",
+			'A' + i,
+			table[i].pwr_idx_2g.cck_base[0],
+			table[i].pwr_idx_2g.cck_base[1],
+			table[i].pwr_idx_2g.cck_base[2],
+			table[i].pwr_idx_2g.cck_base[3],
+			table[i].pwr_idx_2g.cck_base[4],
+			table[i].pwr_idx_2g.cck_base[5]);
+	/* CCK diff */
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "CCK diff\n");
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "RF   1S 2S 3S 4S\n");
+	for (int i =3D 0; i < tx_path_count; i++)
+		rtw_dbg(rtwdev, RTW_DBG_EFUSE,
+			"[%c]: %2d %2d %2d %2d\n",
+			'A' + i, 0 /* no diff for 1S */,
+			table[i].pwr_idx_2g.ht_2s_diff.cck,
+			table[i].pwr_idx_2g.ht_3s_diff.cck,
+			table[i].pwr_idx_2g.ht_4s_diff.cck);
+	/* BW40-1S base */
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "BW40-1S base\n");
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "RF    G0  G1  G2  G3  G4\n");
+	for (int i =3D 0; i < tx_path_count; i++)
+		rtw_dbg(rtwdev, RTW_DBG_EFUSE,
+			"[%c]: %3u %3u %3u %3u %3u\n",
+			'A' + i,
+			table[i].pwr_idx_2g.bw40_base[0],
+			table[i].pwr_idx_2g.bw40_base[1],
+			table[i].pwr_idx_2g.bw40_base[2],
+			table[i].pwr_idx_2g.bw40_base[3],
+			table[i].pwr_idx_2g.bw40_base[4]);
+	/* OFDM diff */
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "OFDM diff\n");
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "RF   1S 2S 3S 4S\n");
+	for (int i =3D 0; i < tx_path_count; i++)
+		rtw_dbg(rtwdev, RTW_DBG_EFUSE,
+			"[%c]: %2d %2d %2d %2d\n",
+			'A' + i,
+			table[i].pwr_idx_2g.ht_1s_diff.ofdm,
+			table[i].pwr_idx_2g.ht_2s_diff.ofdm,
+			table[i].pwr_idx_2g.ht_3s_diff.ofdm,
+			table[i].pwr_idx_2g.ht_4s_diff.ofdm);
+	/* BW20 diff */
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "BW20 diff\n");
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "RF   1S 2S 3S 4S\n");
+	for (int i =3D 0; i < tx_path_count; i++)
+		rtw_dbg(rtwdev, RTW_DBG_EFUSE,
+			"[%c]: %2d %2d %2d %2d\n",
+			'A' + i,
+			table[i].pwr_idx_2g.ht_1s_diff.bw20,
+			table[i].pwr_idx_2g.ht_2s_diff.bw20,
+			table[i].pwr_idx_2g.ht_3s_diff.bw20,
+			table[i].pwr_idx_2g.ht_4s_diff.bw20);
+	/* BW40 diff */
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "BW40 diff\n");
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "RF   1S 2S 3S 4S\n");
+	for (int i =3D 0; i < tx_path_count; i++)
+		rtw_dbg(rtwdev, RTW_DBG_EFUSE,
+			"[%c]: %2d %2d %2d %2d\n",
+			'A' + i, 0 /* no diff for 1S */,
+			table[i].pwr_idx_2g.ht_2s_diff.bw40,
+			table[i].pwr_idx_2g.ht_3s_diff.bw40,
+			table[i].pwr_idx_2g.ht_4s_diff.bw40);
+}
+
+static void efuse_debug_dump(struct rtw_dev *rtwdev,
+			     struct rtw8723x_efuse *map)
+{
+	if (!rtw_dbg_is_enabled(rtwdev, RTW_DBG_EFUSE))
+		return;
+
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "EFUSE raw logical map:\n");
+	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_OFFSET, 16, 1,
+		       (u8 *)map, sizeof(struct rtw8723x_efuse), false);
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "Parsed rtw8723x EFUSE data:\n");
+	DBG_EFUSE_VAL(rtwdev, map, rtl_id);
+	DBG_EFUSE_VAL(rtwdev, map, afe);
+	rtw8723x_debug_txpwr_limit(rtwdev, map->txpwr_idx_table, 4);
+	DBG_EFUSE_VAL(rtwdev, map, channel_plan);
+	DBG_EFUSE_VAL(rtwdev, map, xtal_k);
+	DBG_EFUSE_VAL(rtwdev, map, thermal_meter);
+	DBG_EFUSE_VAL(rtwdev, map, iqk_lck);
+	DBG_EFUSE_VAL(rtwdev, map, pa_type);
+	DBG_EFUSE_2BYTE(rtwdev, map, lna_type_2g);
+	DBG_EFUSE_2BYTE(rtwdev, map, lna_type_5g);
+	DBG_EFUSE_VAL(rtwdev, map, rf_board_option);
+	DBG_EFUSE_VAL(rtwdev, map, rf_feature_option);
+	DBG_EFUSE_VAL(rtwdev, map, rf_bt_setting);
+	DBG_EFUSE_VAL(rtwdev, map, eeprom_version);
+	DBG_EFUSE_VAL(rtwdev, map, eeprom_customer_id);
+	DBG_EFUSE_VAL(rtwdev, map, tx_bb_swing_setting_2g);
+	DBG_EFUSE_VAL(rtwdev, map, tx_pwr_calibrate_rate);
+	DBG_EFUSE_VAL(rtwdev, map, rf_antenna_option);
+	DBG_EFUSE_VAL(rtwdev, map, rfe_option);
+	DBG_EFUSE_2BYTE(rtwdev, map, country_code);
+
+	switch (rtw_hci_type(rtwdev)) {
+	case RTW_HCI_TYPE_PCIE:
+		rtw8723xe_efuse_debug(rtwdev, map);
+		break;
+	case RTW_HCI_TYPE_USB:
+		rtw8723xu_efuse_debug(rtwdev, map);
+		break;
+	case RTW_HCI_TYPE_SDIO:
+		rtw8723xs_efuse_debug(rtwdev, map);
+		break;
+	default:
+		/* unsupported now */
+		break;
+	}
+}
+
 static void rtw8723xe_efuse_parsing(struct rtw_efuse *efuse,
 				    struct rtw8723x_efuse *map)
 {
@@ -88,6 +245,7 @@ static int __rtw8723x_read_efuse(struct rtw_dev *rtwdev=
, u8 *log_map)
 	int i;

 	map =3D (struct rtw8723x_efuse *)log_map;
+	efuse_debug_dump(rtwdev, map);

 	efuse->rfe_option =3D 0;
 	efuse->rf_board_option =3D map->rf_board_option;
@@ -553,6 +711,7 @@ const struct rtw8723x_common rtw8723x_common =3D {
 	.pwrtrack_set_xtal =3D __rtw8723x_pwrtrack_set_xtal,
 	.coex_cfg_init =3D __rtw8723x_coex_cfg_init,
 	.fill_txdesc_checksum =3D __rtw8723x_fill_txdesc_checksum,
+	.debug_txpwr_limit =3D __rtw8723x_debug_txpwr_limit,
 };
 EXPORT_SYMBOL(rtw8723x_common);

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.h b/drivers/net/w=
ireless/realtek/rtw88/rtw8723x.h
index cace285fc03..d6dfee5a180 100644
=2D-- a/drivers/net/wireless/realtek/rtw88/rtw8723x.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.h
@@ -154,6 +154,9 @@ struct rtw8723x_common {
 	void (*fill_txdesc_checksum)(struct rtw_dev *rtwdev,
 				     struct rtw_tx_pkt_info *pkt_info,
 				     u8 *txdesc);
+	void (*debug_txpwr_limit)(struct rtw_dev *rtwdev,
+				  struct rtw_txpwr_idx *table,
+				  int tx_path_count);
 };

 extern const struct rtw8723x_common rtw8723x_common;
@@ -346,6 +349,14 @@ static inline s32 iqk_mult(s32 x, s32 y, s32 *ext)
 	return (t >> 8);	/* Q.16 --> Q.8 */
 }

+static inline
+void rtw8723x_debug_txpwr_limit(struct rtw_dev *rtwdev,
+				struct rtw_txpwr_idx *table,
+				int tx_path_count)
+{
+	rtw8723x_common.debug_txpwr_limit(rtwdev, table, tx_path_count);
+}
+
 static inline void rtw8723x_lck(struct rtw_dev *rtwdev)
 {
 	rtw8723x_common.lck(rtwdev);
=2D-
2.43.0


