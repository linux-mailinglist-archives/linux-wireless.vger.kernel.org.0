Return-Path: <linux-wireless+bounces-4510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B978770D2
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 12:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7D63B21191
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 11:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EC139FD1;
	Sat,  9 Mar 2024 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="H1UPuZEB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB31938F9C;
	Sat,  9 Mar 2024 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709985466; cv=none; b=Tq3ZKATmXBYK7nTAfMCyZzVsIi25RqXm2M4UPZyrGLWvL5JVGEmkLd2MZdgng4kvzSNDN+zvXjnrLA7IDg6Sg+5vCaDtF8bgwWjJhs9MV2mA7QbZcyaBQzcVrZcMS3MmGt6phg7bF/qxm8OLaXKLkV4SLfB9W8LRim+zdmYX/W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709985466; c=relaxed/simple;
	bh=PxoFEcu7unejY1iHkcJHEaUePuL2NaKdYsqWsj2Q984=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eADqPIBaTZqJnJJ3NZ4YsWNStbChXXSW6xrmDu9HnoeTflNTfY0o6rkzRn7QaouRPd3WPoug9pZYh4YBxEptRtVLgOKRreL/jFWZMXXEM5nxrs0PjfszQdLDOyvLiIMjdPjZjDWmWASjg9G/G/envYKcefIcQJWdqJZboZE1xs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=H1UPuZEB; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709985454; x=1710590254; i=fiona.klute@gmx.de;
	bh=PxoFEcu7unejY1iHkcJHEaUePuL2NaKdYsqWsj2Q984=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=H1UPuZEBp+NJhGgjlAOyGQjc0KAERmttR8Y2xElh8gEUHTcOW0njnY43sKtpzo/N
	 oTvFHNyxTxtxtG/WkJDsFG0m1Q0hAF92/NyS30US7YoGToWibvbylUHxibuDlWLWd
	 u+xLCGF+s4bHR3GlUdE7fOiRjEWDV8peQx6wpMFZPNHYpsMAIEnMsHryqr7QyFTya
	 k4dkhGUOEt3kvStqMys5m43Lq+LdnIqhVMOAUC7R8nPvUOhqP7KnK54KWu1epKJjt
	 gLTcnjVqHRBisvsIIlJp8V/e88sJRqXAQOtaQ9W+aUI5OCrjzTr5qttUwJvyjhzU+
	 y3WaefcePJdHlkbW3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.112.71]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUXpK-1rIUVq0XvE-00QP7l; Sat, 09
 Mar 2024 12:57:34 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: Fiona Klute <fiona.klute@gmx.de>,
	Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
Subject: [PATCH v3 4/9] wifi: rtw88: Add rtw8703b.h
Date: Sat,  9 Mar 2024 12:56:40 +0100
Message-ID: <20240309115650.367204-5-fiona.klute@gmx.de>
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
X-Provags-ID: V03:K1:p3rodSXJaar+QUA9ERLQGPht9x+oSo7tBSFydp7TlHHvWSbIZpJ
 raFwj0E623VMTYGbgTA/JFHI5V2Wz5POqTAsynaimXnzw211+1daKqzyqfGBN/iJQcsVjP8
 RVEnaiXzel0fa8vgM518e+YzGKNqP8ffdExa+wQXWPBWl5n5QN/6012ncxH5fG4Lxp1alOV
 hbjFhRv2PhHqdzwbMUADg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LiBzmxmD7dA=;LGOGcsBVU2HFHAn1wm02/A+YBjm
 epgG1TWOBqwjS/BwYsy3UtSknYelxyPDNulYrjKXNCn3bI5vST4yWcSWxXblN++iANRgWKwe/
 snHOKG45rBiWl0kcPTJ1WoVS8BrEi2NFa+ND3e9/iH5UY3qQw/BoEKXTyFZrurtJb7YQEM1Zc
 6fM+ti2nF09CkKkzUpldxN3ijaC+6vY8b6B2Zy2JKnj6u+sbNr2nOtMOpBLBrwO+SYAoaVLCQ
 Jc6/+OmoavTc5hDi2P6m+tpXrGJMi32evL3pwY3xgD5rIRdRGB7futKg2vnmVXEoDuIF8g+0h
 qRcQcxId8EPdqGmYk/0Hnod5auEcyEWkTDWBJLkYb2/M4LlNepre3LsoV/jZSXZtgvUjPwGbL
 dZwJgvTiDljxuRiaJF2ouIOrTXAFhFa7XaRhC2wkuooTxlHguRI9NlKYNSLkWoXL2YrWFAuGy
 Hna+eLY5knWhGkZxXpIpsJf9JdfHNPKFCJJBJFC7mHX0I02P/uYQSP7ZQuTLrFJMGlq2FzlzW
 y0c6+ktaYoNPqfvVwKOgbSQztQATOE3cMI4FND4+El/HzilpiAmYwbHQlU8brVz5oRv6I18Zy
 Cjwr6W+YGiO9SVULAzLpd4zUDZDhsMIOisswcuclc86olCUOquAhMft+WvLvwPHrTrNnoJmMR
 bDBO4CaZlt4dLqAgNTMW+7nDkk9wmBThpTRhVdfftRhYZpAuCotxbzrv4rPwZvzIhUbJWKI8G
 cM2LmOnXxGDSOkTWm1QQaUUMQvLUGK865HxQwtLqefQOFbmhhhxVtK7AI99F5kNshZXXx6JYd
 eHVN1w8e32HMDD73l3W6+fJueGmxzoCtTGzOcmwBcNBB0=

This is the main header for the new rtw88_8703b chip driver.

Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
=2D--
 drivers/net/wireless/realtek/rtw88/rtw8703b.h | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.h

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.h b/drivers/net/w=
ireless/realtek/rtw88/rtw8703b.h
new file mode 100644
index 00000000000..3e2da2e6739
=2D-- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright Fiona Klute <fiona.klute@gmx.de> */
+
+#ifndef __RTW8703B_H__
+#define __RTW8703B_H__
+
+#include "rtw8723x.h"
+
+extern const struct rtw_chip_info rtw8703b_hw_spec;
+
+/* phy status parsing */
+#define VGA_BITS GENMASK(4, 0)
+#define LNA_L_BITS GENMASK(7, 5)
+#define LNA_H_BIT BIT(7)
+/* masks for assembling LNA index from high and low bits */
+#define BIT_LNA_H_MASK BIT(3)
+#define BIT_LNA_L_MASK GENMASK(2, 0)
+
+struct phy_rx_agc_info {
+#ifdef __LITTLE_ENDIAN
+	u8 gain: 7;
+	u8 trsw: 1;
+#else
+	u8 trsw: 1;
+	u8 gain: 7;
+#endif
+} __packed;
+
+/* This struct is called phy_status_rpt_8192cd in the vendor driver,
+ * there might be potential to share it with drivers for other chips
+ * of the same generation.
+ */
+struct phy_status_8703b {
+	struct phy_rx_agc_info path_agc[2];
+	u8 ch_corr[2];
+	u8 cck_sig_qual_ofdm_pwdb_all;
+	/* for CCK: bits 0:4: VGA index, bits 5:7: LNA index (low) */
+	u8 cck_agc_rpt_ofdm_cfosho_a;
+	/* for CCK: bit 7 is high bit of LNA index if long report type */
+	u8 cck_rpt_b_ofdm_cfosho_b;
+	u8 reserved_1;
+	u8 noise_power_db_msb;
+	s8 path_cfotail[2];
+	u8 pcts_mask[2];
+	s8 stream_rxevm[2];
+	u8 path_rxsnr[2];
+	u8 noise_power_db_lsb;
+	u8 reserved_2[3];
+	u8 stream_csi[2];
+	u8 stream_target_csi[2];
+	s8 sig_evm;
+	u8 reserved_3;
+
+#ifdef __LITTLE_ENDIAN
+	u8 antsel_rx_keep_2: 1;
+	u8 sgi_en: 1;
+	u8 rxsc: 2;
+	u8 idle_long: 1;
+	u8 r_ant_train_en: 1;
+	u8 ant_sel_b: 1;
+	u8 ant_sel: 1;
+#else /* __BIG_ENDIAN */
+	u8 ant_sel: 1;
+	u8 ant_sel_b: 1;
+	u8 r_ant_train_en: 1;
+	u8 idle_long: 1;
+	u8 rxsc: 2;
+	u8 sgi_en: 1;
+	u8 antsel_rx_keep_2: 1;
+#endif
+} __packed;
+
+/* Baseband registers */
+#define REG_BB_PWR_SAV5_11N 0x0818
+/* BIT(11) should be 1 for 8703B *and* 8723D, which means LNA uses 4
+ * bit for CCK rates in report, not 3. Vendor driver logs a warning if
+ * it's 0, but handles the case.
+ *
+ * Purpose of other parts of this register is unknown, 8723cs driver
+ * code indicates some other chips use certain bits for antenna
+ * diversity.
+ */
+#define REG_BB_AMP 0x0950
+#define BIT_MASK_RX_LNA (BIT(11))
+
+/* 0xaXX: 40MHz channel settings */
+#define REG_CCK_TXSF2 0x0a24  /* CCK TX filter 2 */
+#define REG_CCK_DBG 0x0a28  /* debug port */
+#define REG_OFDM0_A_TX_AFE 0x0c84
+#define REG_TXIQK_MATRIXB_LSB2_11N 0x0c9c
+#define REG_OFDM0_TX_PSD_NOISE 0x0ce4  /* TX pseudo noise weighting */
+#define REG_IQK_RDY 0x0e90  /* is !=3D 0 when IQK is done */
+
+/* RF registers */
+#define RF_RCK1 0x1E
+
+#define AGG_BURST_NUM 3
+#define AGG_BURST_SIZE 0 /* 1K */
+#define BIT_MASK_AGG_BURST_NUM (GENMASK(3, 2))
+#define BIT_MASK_AGG_BURST_SIZE (GENMASK(5, 4))
+
+#endif /* __RTW8703B_H__ */
=2D-
2.43.0


