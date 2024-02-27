Return-Path: <linux-wireless+bounces-4118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC26086A400
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 00:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496B91F22C09
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 23:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2253856B71;
	Tue, 27 Feb 2024 23:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="fvrR3raK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FD856B68;
	Tue, 27 Feb 2024 23:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078147; cv=none; b=oiptCveatrDliGo4ap2lDqVmI0eIaERsMJroKxCvUxYGn5EjDuy+4w5YeGok1O5VmtsSAfKuJqomoL24SRSr/aX9JwzxqTf7NVUZAfVDQ9mese5VrOHqJb3Y0CxcpBHZxhyneYCNRjFQojHcNHokmOhAdPISazEr16kJ6C8D0rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078147; c=relaxed/simple;
	bh=ooeW0olJcKtrOPC9EaLEKi3aw9llP9kQIYdvZPa1Ujk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+COesgTWvIL/ER7J8B+M+0Zmr76y+syQ09UnlRTg/bW8eYJrT0hlX2MGEFS6iBG1F6R6M0rRIid83OEHuyh8mzBwgnL4A6a5H6kTIAukeUktBhkCUD5erMQFSrhcg01dWTVYpFmZGoFU6eKJ0RmkZmhv/z+NbyQc0zB0CqVik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=fvrR3raK; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709078133; x=1709682933; i=fiona.klute@gmx.de;
	bh=ooeW0olJcKtrOPC9EaLEKi3aw9llP9kQIYdvZPa1Ujk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=fvrR3raKOFVh+fDQBz+VURdNHbvBO94mbB/HzdCd2VZ0H4QBl2XkQy/TueMBqYPI
	 /zj1NWnUQPsoVFqzSjNG63HxyEe6OuZPR8nyTPIHHENIUxicJj+aTCIURMSg5nhiN
	 6G7WzHwKLqtdpL8jiCAiKo6ajpwevSmQO7yJoJsbuQ6OjdQzpqNPJhn89wJoCwEVH
	 9hvQjR/bSSoLt/15oXKmSC0APDsh/eggGE8ZQimgQJXCZOnSqzqo9Nv2vbMgKhpUw
	 Ue2MNPY4y583fLbCOdS2+zMv2/9K2ZTKCKh0YmYGJ2BewEKTCKiWcynK/balpDyRK
	 aJ3NllctdUAWZivkig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.29.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MLR1V-1rNAlq0cmB-00ITO0; Wed, 28
 Feb 2024 00:55:33 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com
Cc: Fiona Klute <fiona.klute@gmx.de>,
	kvalo@kernel.org,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	pavel@ucw.cz,
	megi@xff.cz
Subject: [PATCH v2 2/9] wifi: rtw88: Debug output for rtw8723x EFUSE
Date: Wed, 28 Feb 2024 00:54:56 +0100
Message-ID: <20240227235507.781615-3-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227235507.781615-1-fiona.klute@gmx.de>
References: <20240227235507.781615-1-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/UHeh6tqjfXAiQBUW+YFgct6iD/YVzVkeNiPdDFYSgiJpeQimVD
 NhwEnYkJuXXOTOh5DUMvsAXXZlUmAJ+WAmHyhIERMEYi/6A8QvdOWzIORAVruVuXg5HHKRb
 cNI6ry1oOYFSx+4FZlWYgqKHn9PVsCy5VgUjAabHzastqt/GxOhE49F6jw9Qwgm0Nms8V/4
 gK7YAJ86iock3bYgTybQg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lTjxEISvE9E=;lpc5ZDDDSj4x1QMabskrNHBkXmc
 p0VESsBYs6H8OTwur7Br9wzL1kCS9SzITi7Qcv6iuBDBCpFscZS4uwe1Tc6uPpKd39XYlxWZC
 lbUzBvH/8ZVOcc1FGKtrXYTJtbxOPv/T8XC9+5Gzlplp91Qy3V6Q1jWw7G4Ln72DuaO9V0fpx
 rKXnVcPqc25qJLnmnpi2zayG8kUiZ2aGLBCo5dORHO4Z6THsUcgoSGuP4b7RwhPPv6z4xOfSz
 bAi71p7iTfK3Xa5p16cJnjWrgliHiu15fjpHQbzmu5oYUWzDIQ7PRo4cEBypkzJYJ7gDjUkaB
 iIFzadycRlbwCp33YC0pXaDVbDJU1k0PIdSzsfymJ57RD4UoCjV0MajFAuL/su9L0JR0+0jkS
 gtBi8CwnbszkU5S+zU6r/l9j2CXaJ4TO61GH45vsgRkf2Q3pxV7FuHvatqtCeHvcXugDfCgtO
 DVD7F3nX2oCIkNKFapFBnhJUodE85pyFeARH5QiPu5YOasC69yipwYDtsT5Ib4Qwfht26VWGa
 PLOd6ljWIPO0jSWAge2T0Ww1eMaIMXr2c1pZQEWBEle1x9kZtHSnQKiNdj8SGPNJ/NX3WghSb
 axUhsO85lvheJB3aeUzZ0IAEBELBezBlnTIXYqJzevPwl+VhF9ncpqdJswWtU4KHXm34HjfV/
 bH5keik7ooZRZeuHHA5/XTxFIAgvwdm7v3UQwCmeEPO0saM2TuspDAV87ghfAfaEaZtPDkx51
 xUsgekVNG2wP/44t2waU7WYJywXZCebG+HrCsZXOn8eXrWzK02ys44oj8Fy+Gw31iTXBy2ayD
 aSGnPDYEy2vXpDo5wCqxx6h+pdoklSvD7TWUqJty4lsD0=

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


