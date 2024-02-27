Return-Path: <linux-wireless+bounces-4119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD7F86A404
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 00:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B8BFB226DF
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 23:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB6056B68;
	Tue, 27 Feb 2024 23:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="Ca+c2DdL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE02A56479;
	Tue, 27 Feb 2024 23:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078148; cv=none; b=OkUUFmMDiLScZgKUUMuNMWtQZQo/Gz3brtk9iqfBAIV3+7QYLKasX96tzz3nLB2gaK+pttgqivEjhPDtNn6aqIRDwSLrfb82pd0TtUWqnSpOOn4sjz0eqRJGKO5Zjwgb9mM73AfLgjvqM7cP7Uc+j9Yky6gjGI6Ic/P8TbEsUYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078148; c=relaxed/simple;
	bh=XvAPxyc9DHaIpCEbFAs8b6vV/ZYFjz7q3yvMoig5AEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZxBvPOoZlcBAE+Wem6+GVjeAEE9ge2J7rUVDi3gyzgu211pIHG9dIrGvIUTLPqkezh6oKJNYy/0pv7D4O5Uz8ywmjyXa120gy9sR/8MNkKXDOpt/TMRAvl6cCO60R8zcK4r9/9OGB3WjSrQ0CtwBBHwhrOc7FlIPlMWsVy0mGJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=Ca+c2DdL; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709078134; x=1709682934; i=fiona.klute@gmx.de;
	bh=XvAPxyc9DHaIpCEbFAs8b6vV/ZYFjz7q3yvMoig5AEs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=Ca+c2DdL/UdzS+UoWrqr3X8V3Q8VfDvJgC2UDBQ2iW3NfZff5B/Edx/48nGSNL3i
	 MfPJSR70Qfv2sWPjrYUBcG1S9fGXUEwhMHMwLE9qG11IGCyUdZ9DNC+4NJjdSEfrh
	 gdw9pRkf/gt6JjSKlLiTELgA2HW80pxNnkiWV2wPP2TJSnB0jzhMjlt5PoBacAHoZ
	 Bphq4mEgZ8Z2Nrs2KfrBtDkpyD4zTbti+B+z/RoRp5ezz9YjdBvBWX38ySGtvyeEc
	 3WU1Ecb+87rmS+iV48LFyOz8c61BTMYhnDLiXDxEo9lAht5Ycc8hC8q3EqRjTTzsP
	 NbzZbpcI3mhUghHuXA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.29.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MoO2E-1r8DJG2s3s-00opCh; Wed, 28
 Feb 2024 00:55:34 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com
Cc: Fiona Klute <fiona.klute@gmx.de>,
	kvalo@kernel.org,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	pavel@ucw.cz,
	megi@xff.cz
Subject: [PATCH v2 3/9] wifi: rtw88: Add definitions for 8703b chip
Date: Wed, 28 Feb 2024 00:54:57 +0100
Message-ID: <20240227235507.781615-4-fiona.klute@gmx.de>
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
X-Provags-ID: V03:K1:XOb+cOJM2BKqTrVFA90Pu81UExdD+n/jvgjcncB8jUpG3FBsZZs
 ijZBjuIKXf9fxfdcLtZP7Hzm/EAEoHQfe5R/gtVhBB8vv71kvP4GQqQac/TZaIHbOx8rbj0
 wJsz9fKiQMip5WeXe3csBFLMX8s54qZC1qMdK2SKR/+oGFH8YvW1kk72bCeHKZ9vYuQAOTf
 TOq6xlg4+Hp/yC9ZWErtw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xs5066mGKYA=;YVlsnRY2i634aGLw85Ce6vHCZVv
 rfBvVPTFYuIlId0YjL3+klMxqSqGzdIRJoaqAITU+4+PVmpulLK8SlcRJJ2SsQaLCwh86Hulc
 L2hdVUXc5gAT+4bdbxau11Fe4Mf9AgY/24wg4+mcXlucPz0tsLMwRSyeRV9n0cmNeNj1B3fF+
 RUQz4haGK9T3o54y1MX82wcQz33n63pP5PDJn8i02yhKLZOxClvkaxSmpHn30JKxB3atf22jA
 RECfiWE6LKtc5iQWnlGGr6UZcy1InT8fHO0mereEKqPiksIdZVRf8sECLfB3nZhxieJm8KDlj
 wNwvPdwkBDsXdNsEEBYasAf4kshebeVWvOYZuJo5QTohm/RSHe/e1yjXloJAubnAwdrr6tuQi
 U2s9ZYfPrXED6oaeBUWEKnm4QE7wS8NklXUyrjVyiNFlDMzDedx/s1fanvKLShE/GydZXNoIT
 jtCyIbhhxdKkSNnzfcpEa7hi+O/9rN39HAMZA2JmU8mjv8ZsCx0rB3mfVPP5C6Sawt/WptLl6
 DVSe7zzJRrXrMYEL4YjRlTGB7H+oY7YmZxAQn0Aabsht/4WG1VHThJO50Kf+XGVEfKq5hEzC1
 vNqlpMfO09gCU/T1QPffWlyUdvKtRiInAEQx+0sWiJisLG5frVxpYv0cwlr/q11BzoHKGWemw
 Dpa+97Di8ck+ibg4Hk+X3LGzb/dh31LMSc1j/MH/66C23nKVQU+Bv2XHysJGCRjHxEataT9NQ
 1aYtVyjCGINBdwo/j4naOZZ386YeHSHL8ES9sw+naA5he/zarVd1lG4Jju3GcuWXMbm6EAC7C
 ZcVtWhClmcCb65HvtDAkpxtOoHCMHYzrrnK+4nQ3OR6l4=

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


