Return-Path: <linux-wireless+bounces-3019-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7C2846FD9
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 13:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429111C2566D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 12:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF874140764;
	Fri,  2 Feb 2024 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="sDUdMfUM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5CE2B9C5;
	Fri,  2 Feb 2024 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875889; cv=none; b=J8Mr9sjBK28HTVcmbTXqh7GF3KFBY3+bNU6rudXnYexr1cKCFOHZzWwnLI/k6THTJ6vh3UhO2HfKc1FVBRddPVTBikHn0TB/9rsJTlwnLj3orDmz3w6LGc2Ndi+yYxgqFITC9G2h8E+j0K5JudZlbH+cRKGbpgtglB8DvuBHjms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875889; c=relaxed/simple;
	bh=t+LlvpWkjXILnr5GovEwIEI0ASj7MaBqOpz10ii4aVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vq0IAXBbcqBA8kFua3je1lVzUxl5ku5uKijX+QKpAxNDYBQdEJ0w+s+uCcCWyltOYDg1nLkl+PRTCbMnwIEw6tOk8LNpUjB+G9Eucc5AUMAWEvGAC9xnnAhKZAIZOiw8sfuch/G02piJZA70z8QqudzAn0xuolN10wXsNhbKuPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=sDUdMfUM; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706875876; x=1707480676; i=fiona.klute@gmx.de;
	bh=t+LlvpWkjXILnr5GovEwIEI0ASj7MaBqOpz10ii4aVc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=sDUdMfUMFbXCU5qkV56yjOwIF7bGiyL647S19lZXi2f6+MdDvOijYYgOHav80CpR
	 mj+X0JQU75cCQBwET3oaSiKtTKiPeMcS49RhWzAntGx2MTcGVaW3p8b31AFXPHuXZ
	 xZkfd7aTnaiUHSgJFj1cU8xINCyl01zOTGvRP89Gcj/tzfY7OdKRFNKszBNP9Gipa
	 qNc0wVQ3EvLfeQLkMNKgNEH3SKhbsuWuCz7BNTg1KK2VhGlXu9ITezQBoUOKdzWKD
	 gJ2jcVmi1P0tvJr7gbKicclWglC0VrtyxHVlDiMcFWmZ8VoOxiQSo6XlerP4Bfnk/
	 M+n4Lsrrct1ETkW+ug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.17.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mf07E-1qqSld48RG-00gatR; Fri, 02
 Feb 2024 13:11:16 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH 4/9] wifi: rtw88: Add rtw8703b.h
Date: Fri,  2 Feb 2024 13:10:43 +0100
Message-ID: <20240202121050.977223-5-fiona.klute@gmx.de>
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
X-Provags-ID: V03:K1:viYXxtrStUEBpeut2PkJJ8VO6c2m1HZal2x+x8YKuxhVnMDHiRO
 qFSCl44n6n8K1iGD2UWVFIE2kuMm6vxw+21RbtdZA/LZ6bfyRLC7iIGXB1G02bXun3x2C0R
 TPNYjSGEgk7Q7RQwkqHh93deLMJOsYuOhh3VtNJF3sonf7kDOB2XHDdUBd5xkzhEThyWwQC
 GcnHfhFMG5cDkM1f9XJTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:naqqOiLpQlE=;m7i1BKeD9yNvi4GrtbDa6USuvRH
 DKHjJJrn9P4HRGkgPxj3mE5xPEGBwFN90EpnP1vmzZHSMdBWejdzQl9rlITZooDuNkoM7yJRP
 SmM+bBP26w5wrMhqHes/tS4v9BtIfOggHO1YTUMw/ipa/MP51GFd8fty2l9AiYG7u/UZKEk2i
 ad2rloCeqxg1uqIyOVwGiI6eaFUFZbcU3iJTpjstV4Izcu4AzRXLfG2ju4igqiSRDfgaFRTET
 ajSzaviThY270XB5V3mFt39VwXd/gb0rVSCYZABzLcaj0RAxXROFKHeW2rXtcIhpaOa33/3y8
 i679WF1WE26cr0XgwTeIDiuT4NMCBpae101myz8wEMXfJiGUSyQYiKZLE9v5EBQFCS//c/RfL
 zkeGHGX68WQE9Ym0ZSbYjV8LxiP4RnsVOH7p+plnfzDVXHGDy5pvt/sd5GYjlXTcEeS1tBgNx
 HT9Rt3Y4nCdTlxjrUCIL+yApP2H+Th8cQ3GATbtklKFJlR5M5VwdP+4p8FJz6cOHsgZdZaCkm
 8fu0X5Epy00cRugtDvx6XSrFnxTUsEN6ULebRiZiVFv+ifLXfao7DY5nBa+8nBhBD9H1mevgw
 61iTemDRE2LF9fShjxqca5BYrVQurg3mGqXCLzFmLyYWLaDCqPY1RysDTe2ixkef0KWgBWoyT
 5rxWJD/zie+G5RHk1zBxHRHLLLnlVZSBXcTJPPMlR3m5lm2ErhBIPqX7nJ/q7YUXFWGd4e53v
 u3RBdwDsnBFsEqtSzcrWiiltozGdVnttDI/2bsvMATOgg0Dl3ymXNfBJbH6Zm51HwsPGkWL37
 LlwT2Qrij3vcOdoZGGgGMme9HCTIaSLx883nk0SRysPhw=

This is the main header for the new rtw88_8703b chip driver.

Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
=2D--
 drivers/net/wireless/realtek/rtw88/rtw8703b.h | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.h

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.h b/drivers/net/w=
ireless/realtek/rtw88/rtw8703b.h
new file mode 100644
index 0000000000..f5ff23f2ee
=2D-- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright Fiona Klute <fiona.klute@gmx.de> */
+
+#ifndef __RTW8703B_H__
+#define __RTW8703B_H__
+
+extern const struct rtw_chip_info rtw8703b_hw_spec;
+
+/* phy status parsing */
+#define GET_PHY_STAT_AGC_GAIN_A(phy_stat)                                =
   \
+	(le32_get_bits(*((__le32 *)(phy_stat) + 0x00), GENMASK(6, 0)))
+
+#define GET_PHY_STAT_PWDB(phy_stat)                                      =
   \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x01), GENMASK(7, 0))
+#define GET_PHY_STAT_VGA(phy_stat)                                       =
   \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x01), GENMASK(12, 8))
+#define GET_PHY_STAT_LNA_L(phy_stat)                                     =
   \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x01), GENMASK(15, 13))
+/* the high LNA stat bit if 4 bit format is used */
+#define GET_PHY_STAT_LNA_H(phy_stat)                                     =
   \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x01), BIT(23))
+#define BIT_LNA_H_MASK BIT(3)
+#define BIT_LNA_L_MASK GENMASK(2, 0)
+
+#define GET_PHY_STAT_CFO_TAIL_A(phy_stat)                                =
   \
+	(le32_get_bits(*((__le32 *)(phy_stat) + 0x02), GENMASK(15, 8)))
+#define GET_PHY_STAT_RXEVM_A(phy_stat)                                   =
   \
+	(le32_get_bits(*((__le32 *)(phy_stat) + 0x03), GENMASK(15, 8)))
+#define GET_PHY_STAT_RXSNR_A(phy_stat)                                   =
   \
+	(le32_get_bits(*((__le32 *)(phy_stat) + 0x03), GENMASK(31, 24)))
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
+/* is !=3D 0 when IQK is done */
+#define REG_IQK_RDY 0x0e90
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


