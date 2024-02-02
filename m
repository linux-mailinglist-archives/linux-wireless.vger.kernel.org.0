Return-Path: <linux-wireless+bounces-3018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 821B8846FD7
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 13:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5E541C25A4C
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 12:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E22913DBA7;
	Fri,  2 Feb 2024 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="bPpVhLV7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6095513E23F;
	Fri,  2 Feb 2024 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875889; cv=none; b=mJdakgWPzA6NpGLTnCeeXTMhNWE866IhaFbcOyKeRHL67gs+jMjbdR4uvteUd/Vna0oHkCGK8/RF1NdZwH27t9uFKowjPOtkA/QFwZ36u+CSdrw5PjP0zF6UdEz5kW595JvyuOlljbVIk8H0dyCDvrmCGFbiKFN9IG1qp/Xgn1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875889; c=relaxed/simple;
	bh=mE8SzbL6wMrUFQ39voA3RuYy6EiGmDq5pJOdRFgVfJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjTR+hcQhqNZpOgpBXj/Jt9nQ7QfodpOn2ef1chzMTOyb97T+LRrbiBazJqc/VaW9uuRK/NgV0ISQnSh+j7rP3+ekF3i7qKcJMQaG/BfDMX4FHheUV7AQYAxM6YXAdKiBfYyizeT7djDb5L9QdNfaRI1ZvMo8pZ1hwFWdehewOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=bPpVhLV7; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706875875; x=1707480675; i=fiona.klute@gmx.de;
	bh=mE8SzbL6wMrUFQ39voA3RuYy6EiGmDq5pJOdRFgVfJU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=bPpVhLV7MzjZUldtVY+x6XSNevb3JQFEg7TckbP4k7MZ1si807bUOjnWXjKmLZ4A
	 qS7QvCTr910hxjSY9QCuMeZZoiuJmLWbaBhjrJ3G7f4lTtF581JpaXM5VnSbbDB16
	 oC3QAuQ84qxfGNoPaDGnfeL9necufauePGhuAT+lodSGLBxbWeFBNuo8wCwWQLBdh
	 8hWp7p3syMIh4dMlRg7jvCKSBOc9Tm0V+8gB73LJVUrlGyl1vMTu0B5AYTLtvwMNC
	 s5Opt5DQLuIl9PAIf9RjIQ+XlT8wozVqUkZGM69woK+A26I1Yd4mAndwo952RBWY/
	 7OzjkBwoEQU1VkyEHA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.17.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgeoI-1qoosI48lw-00h8ah; Fri, 02
 Feb 2024 13:11:15 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH 2/9] wifi: rtw88: Debug output for rtw8723x EFUSE
Date: Fri,  2 Feb 2024 13:10:41 +0100
Message-ID: <20240202121050.977223-3-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202121050.977223-1-fiona.klute@gmx.de>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hhim8u6S1K4cztHDTdh6Tqj/cqxRJoAOdCMHmgKQalmkAZL8z9f
 rrIHBVpBukOIZc3h3aghefH8O17/kluPHlLyT45zd1Fgw5clKzVca2BoFdkGcHcd4JvXVS0
 Fz3K0MRlJMb/kUikYr/ZLDxiNtixl+fyWrNQ7UVGCs9mIBKuyT6IiOhJIzs38AuCni7war4
 Pyv6G4l4LKUM8gjdAFVng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Au8e50DKBQw=;Sj2iVWfk/UxMb55TIkeab/Szsa5
 nzniYCwhCszLppVZpuV6h5ubH4tYlGKPtGoiTD3eJp+WSQZq0BviW39r2uV27eVmZY+bB8EN5
 yssjbQjcDKAK2aHsrpG0sod5olIFM5BHxJ9JWDEUYdzvddHW8ZSdmhk48MKP+pvoZ6olsPCIU
 a0R60KkEO8abe+A6xd6CYIy6ra99FY7YeU7YdjyL0VuWNM0u5MCEd4IhkIuBLJohXUG9TWAZh
 fWzEwAh2qVAtAEg9OSoT6WgVY3T9gD5fjA4O/xL5hRaWBsDxuFdF1txTd+HsgSAL8QtUzE8sn
 UzDugSarqGyUrXQTiHfWUo1iE/QH4vd38ZYxWXgDwymHOTRKabasocBefZcmQRWkMvP70JMgR
 YN/o5i8EUF+MzAWYWcxFc79ciQZlgs4j9SlEmq2HWADRRe9FTN9LJWHgeITgh1HWqxGviYdtf
 VAgz+i/Wbf5VCM6mKHHNxxrmHw8JP9l0NpQSF46g3QsdN64dP+PJnXu85ubvxiMVs2zKkcYFW
 IGB6QGddMZZJFUSPK3IylQaRspeGv+WEV7Dvkpn+EocSnyBOQqH2I7yebJZWKZKohRuHuJP1C
 YbxO/m9C+9vL1Tu8iQjM+K2rMa4JGO+4gbv/XlFGM0dwXL0Tq0l4WVBsX3th4bGwj3l55i9bE
 S7rucnRGzzIsQpQQCBBiRW+OBn7M0wDVy5EsaK0++QCOiTyOzai97kCa3adMoq1uVQJvFdb4Y
 R1aDfXXntx5NVHRy+Vq+wt1NeO3P4SihUlBsG+oR+RR5Hf+TtOJ3SewYToRimhtg9O6bjjOGT
 ULva5Xto3OSd0bXUz5sfl1S78X+xvbvrTUfw9OX9KaX2g=

Some 8703b chips contain invalid EFUSE data, getting detailed
information is critical when analyzing issues caused by that.

Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
=2D--
The TX power table debug output function (rtw8723x_debug_txpwr_limit)
isn't specific to the chip family. Should I move it to debug.c
(e.g. as rtw_debug_txpwr_limit_2g)?

 drivers/net/wireless/realtek/rtw88/rtw8723x.c | 159 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8723x.h |  11 ++
 2 files changed, 170 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.c b/drivers/net/w=
ireless/realtek/rtw88/rtw8723x.c
index 2b58064547..bca650c6bb 100644
=2D-- a/drivers/net/wireless/realtek/rtw88/rtw8723x.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.c
@@ -63,6 +63,163 @@ static void __rtw8723x_lck(struct rtw_dev *rtwdev)
 		rtw_write8(rtwdev, REG_TXPAUSE, 0x00);
 }

+#define DBG_EFUSE_VAL(map, name)			 \
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, # name "=3D0x%x\n", \
+		(map)->name)
+#define DBG_EFUSE_2BYTE(map, name)			   \
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, # name "=3D0x%x%x\n", \
+		(map)->name[0], (map)->name[1])
+
+static void rtw8723xe_efuse_debug(struct rtw_dev *rtwdev,
+				  struct rtw8723x_efuse *map)
+{
+	rtw_dbg(rtwdev, RTW_DBG_EFUSE, "mac_addr=3D%pM\n", map->e.mac_addr);
+	DBG_EFUSE_2BYTE(map, e.vendor_id);
+	DBG_EFUSE_2BYTE(map, e.device_id);
+	DBG_EFUSE_2BYTE(map, e.sub_vendor_id);
+	DBG_EFUSE_2BYTE(map, e.sub_device_id);
+}
+
+static void rtw8723xu_efuse_debug(struct rtw_dev *rtwdev,
+				  struct rtw8723x_efuse *map)
+{
+	DBG_EFUSE_2BYTE(map, u.vendor_id);
+	DBG_EFUSE_2BYTE(map, u.product_id);
+	DBG_EFUSE_VAL(map, u.usb_option);
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
+	DBG_EFUSE_VAL(map, rtl_id);
+	DBG_EFUSE_VAL(map, afe);
+	rtw8723x_debug_txpwr_limit(rtwdev, map->txpwr_idx_table, 4);
+	DBG_EFUSE_VAL(map, channel_plan);
+	DBG_EFUSE_VAL(map, xtal_k);
+	DBG_EFUSE_VAL(map, thermal_meter);
+	DBG_EFUSE_VAL(map, iqk_lck);
+	DBG_EFUSE_VAL(map, pa_type);
+	DBG_EFUSE_2BYTE(map, lna_type_2g);
+	DBG_EFUSE_2BYTE(map, lna_type_5g);
+	DBG_EFUSE_VAL(map, rf_board_option);
+	DBG_EFUSE_VAL(map, rf_feature_option);
+	DBG_EFUSE_VAL(map, rf_bt_setting);
+	DBG_EFUSE_VAL(map, eeprom_version);
+	DBG_EFUSE_VAL(map, eeprom_customer_id);
+	DBG_EFUSE_VAL(map, tx_bb_swing_setting_2g);
+	DBG_EFUSE_VAL(map, tx_pwr_calibrate_rate);
+	DBG_EFUSE_VAL(map, rf_antenna_option);
+	DBG_EFUSE_VAL(map, rfe_option);
+	DBG_EFUSE_2BYTE(map, country_code);
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
index d3930f1f2c..f5c46b714c 100644
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


