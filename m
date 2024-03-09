Return-Path: <linux-wireless+bounces-4511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE9E8770D3
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 12:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1A21F2148E
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 11:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4052D383AB;
	Sat,  9 Mar 2024 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="fALC1WAK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1720939ADF;
	Sat,  9 Mar 2024 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709985468; cv=none; b=Sh9iKL4ECCz9bRlWF7r1h26JDBCTV+JiIPiH/x2pRY55VjB/jyUVN1yDg9ChYksEkxCn4X8ifzCnJ94OcI2w26p31x7XcQeM+S6U9hM5fh5sjPbAW7QEfbalDcKNJr+n+UkQRgy4qhX+PgVZlyYziCQ6Ib2/xxtESzykdrwllRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709985468; c=relaxed/simple;
	bh=XvAPxyc9DHaIpCEbFAs8b6vV/ZYFjz7q3yvMoig5AEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mrAanhuQvealalLtpSsBeSs/QdfSl0PzQlKTO4xp5nAc6Jl3rsUqEM/aeYqyyFeom1iwzAcpvRdaPbOoDtGyGhrlFlX9Qr0y6tVIvaLk9hYrw9UtpqKCSqIr8wh6+y2mK5Sta8PqfMuugBxYPM/8HBKvrTA2jjdn907MCE0g+Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=fALC1WAK; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709985453; x=1710590253; i=fiona.klute@gmx.de;
	bh=XvAPxyc9DHaIpCEbFAs8b6vV/ZYFjz7q3yvMoig5AEs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=fALC1WAKOM6TkuF6j5SI5cwgxIAIK5zk9ozPlfdCBqtMCZX+FwIoOaLNKcz7ygl5
	 TiFH2U+RrN2T8X8PufkXxpJz9sGTmsS57Og//IrfoALZuW9+gbNhLn8rIAKPV9pOi
	 /0laD5idnMWGkYm//FjQ8CWL7cKkXTBsqqoPERJj0FPWvveMz5JWYlB5RA9Dx5J4n
	 hheDzZqWcPjv7LI1uxJWi/aCnULJdPx/ous/g+6Ae7HHc4mK/hVg/FOfaYN0aB52n
	 gNAycaSdgkqucYWNztiIqKlGrYqhA2kQC1e7atTsnMVaXIgaS/3UDnqxR37Vz6nMJ
	 rI4sGEcIfFCnXI60CA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.112.71]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq2E-1qpzG92b9M-00tBQT; Sat, 09
 Mar 2024 12:57:33 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: Fiona Klute <fiona.klute@gmx.de>,
	Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
Subject: [PATCH v3 3/9] wifi: rtw88: Add definitions for 8703b chip
Date: Sat,  9 Mar 2024 12:56:39 +0100
Message-ID: <20240309115650.367204-4-fiona.klute@gmx.de>
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
X-Provags-ID: V03:K1:DRZSFdgY1izw8gykmQsJFFb1TiWMwBzbuQ5qLQB8Iitm5e0FcpG
 M7SmkNFwX8vYgoyo23Ln11Vuo2HuVsAZJMli1hEA4hfQVlcJ1uGV93KBzxK0RaPvcjgLYHS
 +0Z6lZgjtpjtFJkvZvjsaj6n59/gTmZcOMW2108zk4bpq+WXYeQeEROoNFoLVxcj0K4iGuh
 g4Rulezr//vBUl9clR0ww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iL9Q/H3kfqE=;sGreXSx7WrszlckoRZCUJ/AGvdi
 n2OQHr6Qx12ZlFyWoPmxyaPbLX5A1txG6Lxy8hfnLjpZQbQivOll4Vbkkua9Buefff+2xiCoB
 AXkCfvommM2LcQlYZe1n9M1vRIH2P3vMCkYHDw/5vBTlzr400mI/GB7TxXu684/R8seCA2j79
 q/hRM1Vozm9hTesX+EHDqvNGfnEUqA3Y3/f6BgCdvaxT7tef9o9nkc6camzon//FKyLgKrvgs
 7WPlSJDeekDqsWXS9dnqSyK1x8PqjyUkbNUxFcrU+pr8yJom33bQV1SWseu5Xz4dHnxuqypFf
 7C359Wh6a1QfVOMh1f63aR6n03QN4hhMkmxTKy8aLos3BAPEd/8qyUEcIMYZM/+FTKzyXoh5A
 M+u1joNZ+xVXUGt4+qel/A/rdlq4A1j/fYM+RC7ar4vb7vLOd/G74n11eS0o+xDqNuxyf+GBI
 URMwu3TbtBHxUKQdvyYc8/kM22OsRCNSp0WSRWcPtJlVBl6V4mquopdoa4SbW5KHuAKX9O4k6
 ptU/NyyOZ9M/tNaP4zHTX9vsQcYgP25zp8t/CV8H2SkPN+BA9poQ5UgAZb3ITYnZ6qqzFueCL
 CElGwqJTNHNlwrgEzoey37SSfxsSp/MpFkd4RLHZPj309BZ+ifcRPncXBv8kpNQ3B5FFcS38F
 cyqGYNw5CYQkCr2c1AvciQIGbkFfeGfy0oqp/zM5B/hd7BO9/7jRU9KNLuGhSV5MxE5rD9+zf
 kUZpa2OpdkO8LVL+/vIJu5ZAZoPuChPJkLb6qrVgqzzC/lHBTi7WBwhDdqE+90ytujy6puXE0
 OXKsc+XZ2sAGadEFbjVohj5je/xvRtyiBBsVkHV/zLmcY=

default_cck_index is used in power track, the rx_cck_agc_report_type
for RX PHY status.

Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
=2D--
 drivers/net/wireless/realtek/rtw88/main.h     |  3 +++
 drivers/net/wireless/realtek/rtw88/rtw8723x.h | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wirel=
ess/realtek/rtw88/main.h
index e14d1da4394..49894331f7b 100644
=2D-- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -187,6 +187,7 @@ enum rtw_chip_type {
 	RTW_CHIP_TYPE_8822C,
 	RTW_CHIP_TYPE_8723D,
 	RTW_CHIP_TYPE_8821C,
+	RTW_CHIP_TYPE_8703B,
 };

 enum rtw_tx_queue_type {
@@ -1700,11 +1701,13 @@ struct rtw_dm_info {
 	s8 delta_power_index[RTW_RF_PATH_MAX];
 	s8 delta_power_index_last[RTW_RF_PATH_MAX];
 	u8 default_ofdm_index;
+	u8 default_cck_index;
 	bool pwr_trk_triggered;
 	bool pwr_trk_init_trigger;
 	struct ewma_thermal avg_thermal[RTW_RF_PATH_MAX];
 	s8 txagc_remnant_cck;
 	s8 txagc_remnant_ofdm;
+	u8 rx_cck_agc_report_type;

 	/* backup dack results for each path and I/Q */
 	u32 dack_adck[RTW_RF_PATH_MAX];
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723x.h b/drivers/net/w=
ireless/realtek/rtw88/rtw8723x.h
index d6dfee5a180..e93bfce994b 100644
=2D-- a/drivers/net/wireless/realtek/rtw88/rtw8723x.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723x.h
@@ -165,6 +165,8 @@ extern const struct rtw8723x_common rtw8723x_common;
 #define MAX_TOLERANCE	5
 #define IQK_TX_X_ERR	0x142
 #define IQK_TX_Y_ERR	0x42
+#define IQK_RX_X_ERR	0x132
+#define IQK_RX_Y_ERR	0x36
 #define IQK_RX_X_UPPER	0x11a
 #define IQK_RX_X_LOWER	0xe6
 #define IQK_RX_Y_LMT	0x1a
@@ -177,6 +179,10 @@ extern const struct rtw8723x_common rtw8723x_common;
 #define DIS_3WIRE		0xccf000c0
 #define EN_3WIRE		0xccc000c0
 #define START_PSD		0x400000
+#define FREQ_CH5		0xfccd
+#define FREQ_CH6		0xfc4d
+#define FREQ_CH7		0xffcd
+#define FREQ_CH8		0xff4d
 #define FREQ_CH13		0xfccd
 #define FREQ_CH14		0xff9a
 #define RFCFGCH_CHANNEL_MASK	GENMASK(7, 0)
@@ -239,10 +245,13 @@ extern const struct rtw8723x_common rtw8723x_common;
 #define BIT_MASK_OFDM0_EXT_C	BIT(29)
 #define BIT_MASK_OFDM0_EXTS	(BIT(31) | BIT(29) | BIT(28))
 #define BIT_SET_OFDM0_EXTS(a, c, d) (((a) << 31) | ((c) << 29) | ((d) << =
28))
+#define BIT_MASK_OFDM0_EXTS_B	(BIT(27) | BIT(25) | BIT(24))
+#define BIT_SET_OFDM0_EXTS_B(a, c, d) (((a) << 27) | ((c) << 25) | ((d) <=
< 24))
 #define REG_OFDM0_XAAGC1	0x0c50
 #define REG_OFDM0_XBAGC1	0x0c58
 #define REG_AGCRSSI		0x0c78
 #define REG_OFDM_0_XA_TX_IQ_IMBALANCE	0x0c80
+#define REG_OFDM_0_XB_TX_IQ_IMBALANCE	0x0c88
 #define BIT_MASK_TXIQ_ELM_A	0x03ff
 #define BIT_SET_TXIQ_ELM_ACD(a, c, d) (((d) << 22) | (((c) & 0x3F) << 16)=
 |    \
 				       ((a) & 0x03ff))
@@ -303,6 +312,8 @@ extern const struct rtw8723x_common rtw8723x_common;
 #define REG_IQK_AGC_RSP_11N	0x0e4c
 #define REG_TX_IQK_TONE_B	0x0e50
 #define REG_RX_IQK_TONE_B	0x0e54
+#define REG_TXIQK_PI_B		0x0e58
+#define REG_RXIQK_PI_B		0x0e5c
 #define REG_IQK_RES_TX		0x0e94
 #define BIT_MASK_RES_TX		GENMASK(25, 16)
 #define REG_IQK_RES_TY		0x0e9c
=2D-
2.43.0


