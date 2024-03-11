Return-Path: <linux-wireless+bounces-4549-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7116877E2F
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 11:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE3F2825C0
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 10:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DD737169;
	Mon, 11 Mar 2024 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="bbFryVTk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51D8111AA;
	Mon, 11 Mar 2024 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710153503; cv=none; b=PCHK81oIXBfhJONT6kR+/fw0Mh73ulCwiIihZTcmUqEH5zJUYfqe7k/8Xt85hf9EqCpqU4Bx0gyQo5vR+Ambxh+EjdHaAxXcDPYiC5rXoCIT8UIBvtaqA1D5laPkgdnYrrmZ0gPN2dAI7mpbwJn+xIhDLBK1CYrIPwbubcb8ibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710153503; c=relaxed/simple;
	bh=PxoFEcu7unejY1iHkcJHEaUePuL2NaKdYsqWsj2Q984=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d1Q1wWc8KNpuHJP2CzAyiVFdflYj1P9/d0AVSCBLsDT25s4f/PLWDT+DIXr1dbO/cDeRq8T8D4QqQOGraC8IYY5ECRrPVef2yUV0BVdQsscCC8Mbp/DMjEDnXrcj6WzUT2RaNF980e73AWjgwWXAxjAdG+4XCDOkhnt3kmKcjd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=bbFryVTk; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710153489; x=1710758289; i=fiona.klute@gmx.de;
	bh=PxoFEcu7unejY1iHkcJHEaUePuL2NaKdYsqWsj2Q984=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=bbFryVTkWPY5iJUAejqsisRQsgxJGI2o35nygRbIo7lKvMZ4YOTFQ69VzH+VYP9K
	 inEvv8eCEu8STaisQXXofICwjQDW8Ja1UzjFfUGO4qFX3D1HIIeRjbXmxXk472MFS
	 D4cE85LncoGQ+o87/8o9kM7a/m3/VMjJTARY9LPUMZfvdWFO2j0qhBZJ0cjwbGwoc
	 LmZjc6uMp4AgHEA6QGf4hrKQhvqMiVqJBbwaBkHRv60KmmuxVc2sq8+MQYyNmrCRi
	 QTB/3joeYsG1sdq8kdim5lUwgFlYetgkjLm6AHCTL9S3t6xgncFc2XsTYTAS+kkaJ
	 ssPSCvBNxhahSOceyQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.108.92]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2DxE-1qfzsV1nXq-013aze; Mon, 11
 Mar 2024 11:38:09 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: Fiona Klute <fiona.klute@gmx.de>,
	Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
Subject: [PATCH v4 4/9] wifi: rtw88: Add rtw8703b.h
Date: Mon, 11 Mar 2024 11:37:08 +0100
Message-ID: <20240311103735.615541-5-fiona.klute@gmx.de>
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
X-Provags-ID: V03:K1:AW4H/PKDgcvAmmAxtrLglm4U1cZKQKUG0W4QQravxulJCQIEA76
 OTQh7M+ylsFxzJjwcwEdCTLiJ9c3qe2mdgn7V/JWDfBkXdpcyjOR8vdXh4DF6bXW1mKsCYK
 A3/7q8NtYAofQbemDREaw5LIQ3YQswLKjQYBzf3/fHPxAP1nU6uO+yLufj80eI9YQlucz94
 RU/qmOf/rZEtu4Sp5f26Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:b9ffb4t4L5w=;B85z3OMW2qjO5QwKOLVi5OzZ203
 euF7OCcmDoS2OPbQyjXwKjR2/lcWnb6T3hSVQajuTqjE6ebBJPsH4sqZTxywmN3/y3WsbUwlJ
 b5VKjzSlMww2FmJQ+oCgex7RJaObjHZJfM5N//pPDmsYDDP0hQ39Rafjq9Kxfmle4JbaNzZiQ
 Oxh815FpQbqobLDNnbrNX9wS36IU9AwqVDMKugXwdcKYiWKkjW+1eHSdYP43qhNOXumPG6gTT
 oFn7m1DsSgaoCo0ZE4poxLZ+Q00FZNIroh+EmKKhn6Wpuvpt9S5C8diDQWS3fK+aNTN85lg47
 aS3+z0fhxxoa/tsUQSte8eewKBn33j7bdvfFvQBgkWyUZhqAlqoH7LgQimidyWUORybqkr8rx
 ZBdctgwmzScTTfnUOXdNZPh4++436iKxo1RBW9ibB8cLB9SutT+lcptoP0j+ToE5vaaP8Nhnd
 XF+QOq6/hgQ76Q6p/wSvzyBJTnNmIngVoZOR1D+nzgcVVkf9ODVN75oRkfyMrglSLwFkPpijA
 TbFzi6NjHaIS4cIEp9kxNpiwYqhN8waBg4yV5xI8yg98TYgckUiTKNASJmSdyEqH7D3D9NQpK
 CbHYQisMZsnzja8UPRPBd0fuJ4vC3jUw6fgADIEGt17iDEBqU+yiECwPTR0VWJ441Ce2hOHys
 aY5hezq9KLMRBJEtKeLS/pFd+wz1bU8mUGgHpFHR9CzcdBtuW8jUjmjYMtHW1CuZl2IYZOSrq
 j/8hjW3ckBFIwt+5FK2fbozUpSwhT8N2e2WuqhBAxdUjtFV8M24W2HFCo7sUdBMWSt9D80kY8
 pz2J2x5VR7Zm9QW2LSn7Av4x1EY05AhjCJQ9sI+iLavBA=

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


