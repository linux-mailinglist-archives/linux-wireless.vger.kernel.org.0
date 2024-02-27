Return-Path: <linux-wireless+bounces-4120-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C6086A402
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 00:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8AB31F22EF7
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 23:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249255733F;
	Tue, 27 Feb 2024 23:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="r1T0u68r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB2257310;
	Tue, 27 Feb 2024 23:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078150; cv=none; b=HqggtGBYw5jHZmEi8MjHwr20sBPSK77R/wvp6riVYYg6U90RkB9WTAaFWF0GILcK5y8MJzGmrUi0sFDNZtdMbDMz9NFmGmAPuBsuhIVzmZKhf0oinmX8Mva56VUKrIrhLZOqDEvQ5aeV82OoDiAxVpyrdmfP1njLe8xIe1RWO70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078150; c=relaxed/simple;
	bh=5xNNYon6CNx8PoSniG4dbAQaVzi6W93B35lnSCnL2Yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vmu78UjATwWvGyu3i8SAyih6VUIW94MufnFOteL1bQnPjMjzn5wD6AoGpa4WiHQxEVMp8jnm46+5ADwb2uJXBH+v1nYcnINesJPRVrwfYFhqFr0FiF2gQJ5XE+a6JyfD56bOfp/f7q3gG3rlmBChFB+Vmps8f1ybSnqiUJxUdUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=r1T0u68r; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709078136; x=1709682936; i=fiona.klute@gmx.de;
	bh=5xNNYon6CNx8PoSniG4dbAQaVzi6W93B35lnSCnL2Yw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=r1T0u68r5sSk9LaVULgjg+VYa6m/DLYQ8951jIoRvEFdkGwQL8wVoEGZ+3s/CC5f
	 nMkdiY+BuLa2uyCXJl6HNSo+lmQz8KpPlgbhzJclvK3DsezCrjGouIZkflQ/JGmlT
	 +tYeBNscP5Y9LCCy1AejNX1KDs/54jULoBIz8apqRepNeAEkh2uNPkabUY0ef6nbO
	 aEcM/umLs8TNrbpmsH3nEDRUqIbAMv1aEY9JMzLjQghMo6aeLRwA/hc+HIOvfYCjV
	 JoDZz5RL4LmDzVtMABM9bfVnsG0AqzZhfjgtAAVrXoElrNCjOIAWN2BO6AW3O/amB
	 R8oFVJquTraTgXT5bw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.29.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N95iH-1qrMBL03ex-0165Kq; Wed, 28
 Feb 2024 00:55:36 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com
Cc: Fiona Klute <fiona.klute@gmx.de>,
	kvalo@kernel.org,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	pavel@ucw.cz,
	megi@xff.cz
Subject: [PATCH v2 4/9] wifi: rtw88: Add rtw8703b.h
Date: Wed, 28 Feb 2024 00:54:58 +0100
Message-ID: <20240227235507.781615-5-fiona.klute@gmx.de>
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
X-Provags-ID: V03:K1:fgbaevoFwT6dGszOoMl78ud6h8bINHY18yCJjFpQ+757Jk8CQJm
 NwWhyIfDtKomA9waYH3FP81dI1GxAPDsg8AfJnGfeK7x10Zrf8KvxbRiRtFuIlYS7MsTNDK
 A09EShnQKPFeg+RIPaN5RekERkbB9mpDP0rVMAt2/XcezQt/BMqXV0+mBRNRlhDN4v/Ft6L
 9NaH5NhllnNfdgGCvVPZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4F2Xr+DjWaI=;/6FreK3V6lvZH2daxg9WPtWlA9W
 oncxsuKuKz9VUdITLHHRhCHJrkhY2vnQt4+lIhhNDNDJpIilLYrW9AnYvUEYbhIJutDee8AZD
 r1Pn1bXXTi4CXE1ncgYO0joJYHcYqXOn8pyC6t0MywK0rqqerS0j825DqJit6qMjhULf42TSm
 yZQNwiFng2iTMs9jPOF07Kbt4uk5i1dvXvhVHx3FfuexusgH56PqU0mNfPPwD3Xc4h6vrRd0m
 NzGldwVH9C3XvmO8ooYYg1Rlso00bqy1el1/b1JVlqLuq45bZi41M3PMYRLqiamXmljyK1dem
 g3b744velZAklcg/QN5Ap9GrNfzoar/k3mwOZ4gVNJMkSmQLMr3qRsmHR6czrcHoLbk8ig8AI
 1v2gDDW/wIGbI1JXONsgUEM6FAh+oDrsm6KnVEw/MF8L9UwqkPt494KX3QQ0RmnSPablLn0zT
 0iIDBLSwsX7FpWVTD4aiRZlmPsY6i8idnbarEWoEifR+7MaTlq7glJZoB03dMsnb92cCFCj97
 VNvEsWz55B/b+LMuyRg3STFPzIq7AjOPqR8B9tDSir1dzs4CU8ks1jW0NmUkkWN94Sy61sr8E
 9NPsuw9WX0gQgNtd9AXl0zzyuhs+eL4R5ZmBtE1LAXD7s8lt4Iv6McbQJgGxTTW+x8yzQpxhQ
 9++R4zwq7bOTUfW+s8l0K30z3/B6Ep0edRUaQbM8KEThAEdl5s+SBszwDFR1CHs3AC9gJm8bV
 29PfTBffDpRP6ZznyVTGzyya/4P/k4GSIe8yJ5eJIoDfghYHgYUqY4OlRGw9kPuvqxUkyclJy
 jC9wzGzDnpXyNW0BGiOBtB7KxSzDIDoo3CAsaktlJCS/g=

This is the main header for the new rtw88_8703b chip driver.

Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
=2D--
 drivers/net/wireless/realtek/rtw88/rtw8703b.h | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.h

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.h b/drivers/net/w=
ireless/realtek/rtw88/rtw8703b.h
new file mode 100644
index 00000000000..69dac101d33
=2D-- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright Fiona Klute <fiona.klute@gmx.de> */
+
+#ifndef __RTW8703B_H__
+#define __RTW8703B_H__
+
+#include <linux/types.h>
+#include <linux/compiler_attributes.h>
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


