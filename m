Return-Path: <linux-wireless+bounces-3017-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E26846FD6
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 13:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38BB429AF69
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 12:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B00E13EFF3;
	Fri,  2 Feb 2024 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="lNGb1WVg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352D113E233;
	Fri,  2 Feb 2024 12:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875889; cv=none; b=fYctKhDj4Tc7xnqZ5vcwgpkRBzGOwAK4oB9eQtL3tmf32ReMM2j9pBNduPdzqM2tlaxOlk8pwLehlIKKc5yqiYni+96dmIFtPLhIkEpkHVpwh++P2kvW6TZCtiuWFnP2oSsDj6/7xt3riFPrdmNKEluhCdNvYQPjboj9NyCbbUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875889; c=relaxed/simple;
	bh=QtGV7AvFbjaiTQJvn+BibswCju4yQS011kbuxVxcpNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dt3E0S6UYD2FHyVtMgo95vZERxysmojKuWbgL5ubfsdxpZ/6LvVlDCmWDwx9DVbk6u5OmaRg6+CNYvPTqWOMY5JTrx0kXyiwdoGS/NUdDtiro1hNDPmWCeXgvqvUrqjQ+4vNbn1JWyIAyOh6g6dhCMYKY5Goybq0T54DISUoTds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=lNGb1WVg; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706875875; x=1707480675; i=fiona.klute@gmx.de;
	bh=QtGV7AvFbjaiTQJvn+BibswCju4yQS011kbuxVxcpNM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=lNGb1WVga/DLNHoDoUmISINRjFgPGJNU5Sim6dMzm3W97QXCbINwQ5zIMSIgFDV4
	 FrapEWczxgxQsugomhS831/pF91PuvDDSNrEdBhrsuTQfCAzY+jaQFh3Lx+rOm2up
	 UB3PooiSu4Dg2NRbOpJ/oTcU2ld2dRWCHLulWDFPxtTgRxiar3dKzKpr1Xe8AccJa
	 Z39ffM50Ogaj1XOFBdl7Ke1jUIzlSICU3f+Vk4GO8HOGviOHoWdwVXsGv7GUPfy6x
	 gtDUBTeQ1S2K+Sazi3D2bYG9EI1bHQ6k1n+K6PPhOf7UXoLXJUJg+zFVcJixpHhCj
	 wrKEFW08vzRSOKMbGQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.17.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnaoZ-1qmxBG23m9-00jbYg; Fri, 02
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
Subject: [PATCH 3/9] wifi: rtw88: Add definitions for 8703b chip
Date: Fri,  2 Feb 2024 13:10:42 +0100
Message-ID: <20240202121050.977223-4-fiona.klute@gmx.de>
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
X-Provags-ID: V03:K1:kkl71RbyD6rqZrKBn0d4svAObi3JSxWxzAHX7DhZ1oXosgUsaYS
 vVHLcTBC+unWqqMrLo9zOYocRsG/0WvsEJ/TWVaTDgiCA2lZ7sd6dd2nAY1bCtQaiSeg3DE
 raBnjjjICoXSs+oIkK5ziYhHjsBIN9lCUvWC79EdrplhJnFfm5Yk+403A5t5xIOGu+rDzKL
 /V0eEkOCeDtFxs+UZ8/5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CcYZLnfZPUk=;0z9D8jvttSBlMoDx9wK7zMfaoV/
 ATO1RGAVPY/QZN3CTT5XGg1QcJbpSi2GRl1suWFr67ixiBie78y3IDibo9a/R+Ds6xhgYzJlU
 HRMIcFIbfw/p3QlAVy++tGHG9FWQTmClp81Rf2sHtBpqjgpoId/V3oAJvpWcC+eEVPJo7i5j2
 pox7xdjp5RoFqujQV3gi82y4NbvLY/K4S4M0aNYOUxvgYhj0kf0az4eX90HjXJ9rhY/dkD7Xs
 QWwj3hImvlPSgd0NlLUJ4bjRwvs8NlVeZSjezPjpwaeAeNHmIF1UnpTeq5WequSmqlwufcNK/
 CzneojjfglLU7QQpJmQteWTmeosjDWwX1eodLbjvnD7Pj/0NDjvfFfAJ3TDC7AyKLUcVremiz
 NhxfKjhL9bQ9A7pEprVz1eDs4jtnaH/tdU0GZX7IU/nW3YHPHNzZ///y/y0FCqbWavhiCRe0L
 Y/sJzuxA831mQv0ROF8w9aeRWX4z9H6eyLGCUPOb/HU722yatMZzvPyq8xpRpfKA0nrh677wZ
 2U0CtQWpcUCJMEiN7iwnNo33saqtw+1iofQpjva0wKCkaG5+ucs7ch+FQzHSfs7StFPWgO9AZ
 pkoZoYji0d23kB+vgC9XcgAuP8mvF74h0jvaRmAzZsXCJNgBaDX3u2+d/jW3B+yYysbhqiELf
 agAaNALyD4ADRcEdJreD4N3Y9+y8e1jhTLwyo6mgJy3WU8tLGbgdRqTvSfezJROEgJFJMLUFw
 K7LFjKMVD85/uNQQAPhgQ4n9k0FUpjH0L0T3t/LTC9LWnhX+SK1bfiWwOlNG4gbLLFbu1fSFL
 I7wU0GRYX9aGwR11072G8KcCE82ALO1218mcV8S/o3gC4=

default_cck_index is used in power track, the rx_cck_agc_report_type
for RX PHY status.

Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
=2D--
 drivers/net/wireless/realtek/rtw88/main.h     |  3 +++
 drivers/net/wireless/realtek/rtw88/rtw8723x.h | 11 +++++++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wirel=
ess/realtek/rtw88/main.h
index e14d1da439..49894331f7 100644
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
index f5c46b714c..13fec99a86 100644
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


