Return-Path: <linux-wireless+bounces-4550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC13877E31
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 11:38:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31912825C0
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 10:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0AD383B5;
	Mon, 11 Mar 2024 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="Ie30Ka/I"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A4036B1B;
	Mon, 11 Mar 2024 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710153503; cv=none; b=MNBe5iz4LuYreeyJXY8oXrYqk+gcq1irHOchO3q51jYzR0paTUyB/MSS4t0p+OrcoRnfx4B9x+FU7AFxFct9O6GRdDEYse+Ahsxgteu/ACY1QSs6JIsZkyCHdQ0hfiZ8PRof+Sae+ROj2TaAA7hyMV7Kk9T+Jc16JT3ua9H9DGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710153503; c=relaxed/simple;
	bh=uTZpWkNyDddLKSmpl4I93kleoS18beMUcf1ntJQcRuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+y4RD3qPnQdZCOFOKkep1bZ15aJx5zUbW1JZqE4HCV+u/sAIxDmFBiaG7iEG+65RgrchGk321/bLmfhBEXyZGJ+jL306X0rojazxbsna36YKTqzmKVrXcpo/Dl4M9shaB5vnFdhc8zbz4b5qcMwkXdO0KlPFmPBpZDJnRIc/oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=Ie30Ka/I; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710153489; x=1710758289; i=fiona.klute@gmx.de;
	bh=uTZpWkNyDddLKSmpl4I93kleoS18beMUcf1ntJQcRuA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=Ie30Ka/IOJBGSpHGdgCMOjkp7xJGZDcWGrYhW99FfoPh9kD232oCY55rZwBu+EMa
	 1dP5kT99CuR8D8E1h5JocYsNTpBbZZ1u4ODeElYuSAPYkIiMuQI/qqUmwPDgL8moM
	 loNWsnfpWELL8gxsHyufkLcp+XInNFrdD8sfnQ2G++BQJo7sbHfYWLTVTPh+GW1gz
	 sXJEFsbnaJE7/QjS+IWWc2y9OG1rtjrW+wU8+xliqOUylE8+Kc/yU/tzSwiG+4TQO
	 yeTlv6cR/VP282X3YDGva4FJPzcAsXaIAsfkhm6fOn6jPwkqWEaGlfppEyhzFHkNi
	 aV9ebXVctLFwGpQfKg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.108.92]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9Wuk-1rmuIO3pxM-005cs8; Mon, 11
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
Subject: [PATCH v4 3/9] wifi: rtw88: Add definitions for 8703b chip
Date: Mon, 11 Mar 2024 11:37:07 +0100
Message-ID: <20240311103735.615541-4-fiona.klute@gmx.de>
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
X-Provags-ID: V03:K1:zxLnXhWNP0eJ9I0zhWiFTvWHZOomz0i0ysRohUuhqcqyJqPUMCI
 urNL17k6RkEXyeklTbfBsJiXu4Q3KxY6GVZS6dlkDBhzrJ0M3ybLSkuolq24t13TJV80mgy
 +NVkXtflc0iVEP2jLdYu9104xQHpgPV4YHXBHLFVu9G+DoA7pd8wN6mZdGyaq+NnGizsp8t
 RUb+V0v+i8Li07YuGYx8w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZQTefP6jyZQ=;qdDIeDbavpZ55NByojQPmcRThKE
 TP2oFCLR83AEtAX+Mf0BwnTcxr7+FZrXMQ9FnTLBBql3HtEhDKUKq7H5UxFgvGdbuMTP3Qk91
 SwKexyoM3gfROOtAZtGScWdV2Q/6qrMrUU3z5nxGoJ3BvlboWkZeVh/1IiHGm9ACb0MTmMjHf
 mL16eRWWqbzI0VCGM6uI/+3ek+Y47HvO+le+h60fLs3hmDGpVFy1Iu0tRn6kCrNrZkWKS44WH
 TTINuEi6mNqldzlTCZwThdNhWXKjXhHV+yBT/qzuvR29y0lW9LboDrMcHSF5QlqD3SLRzk9CP
 hmAQJfaUwHsLv7y/D+g/nth4mc5ASVLz8KJC/6oAhp/rT3byOqJtgAdppAeq9gZxxsQuwuDu0
 B295Fq3yZkk7CDDVMI42kIApl60VRd0g1cl6e6uy6+KyxQuBjQwg4W+YM/DuBE0wsD2CCHqHh
 3RGFjnMB4F8DuQws9NfQTdlBiCoWAqr+Mc3sngdYy4bod7k1uaU6WjJVwkShEyVfaPs+WfqfJ
 5WLgqgaV/9Ec7UdAaUiMi9kAf8vVFbv3EHdliyg2YR+j5uJ5CFRM8EGYCf48gSZ/BkX/KInSE
 mEpgGHbRhIF/aQd9W+7UAj1M7BYO6UGnwsObWJ7mjWijhj0eExXjTV54UxV73M8sIfLTa1hbU
 ADZaBJUtjMFjvjotvZJZUEOtW9KyyRvqmA02M2uqfVRpCAkz85hcGDoGszY73HN5BOPUZEG/n
 w7WJzaSGLXt9RsLBPX9A1QeHZ8LFXPyryWxdawxpWf7WsFZiyXdC6piijt1T2NGibRWeMs8Ps
 bKHpvyU6rCmzyGqSHG3GkanIIWXvXpZyzsYlrJXyMVxVg=

default_cck_index is used in power track, the rx_cck_agc_report_type
for RX PHY status. GET_RX_DESC_BW is an RX descriptor field not used
by the other chip drivers.

Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Tested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
=2D--
 drivers/net/wireless/realtek/rtw88/main.h     |  3 +++
 drivers/net/wireless/realtek/rtw88/rtw8723x.h | 11 +++++++++++
 drivers/net/wireless/realtek/rtw88/rx.h       |  2 ++
 3 files changed, 16 insertions(+)

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
diff --git a/drivers/net/wireless/realtek/rtw88/rx.h b/drivers/net/wireles=
s/realtek/rtw88/rx.h
index 3342e376128..d3668c4efc2 100644
=2D-- a/drivers/net/wireless/realtek/rtw88/rx.h
+++ b/drivers/net/wireless/realtek/rtw88/rx.h
@@ -40,6 +40,8 @@ enum rtw_rx_desc_enc {
 	le32_get_bits(*((__le32 *)(rxdesc) + 0x02), GENMASK(30, 29))
 #define GET_RX_DESC_TSFL(rxdesc)                                         =
      \
 	le32_get_bits(*((__le32 *)(rxdesc) + 0x05), GENMASK(31, 0))
+#define GET_RX_DESC_BW(rxdesc)                                           =
      \
+	(le32_get_bits(*((__le32 *)(rxdesc) + 0x04), GENMASK(31, 24)))

 void rtw_rx_stats(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 		  struct sk_buff *skb);
=2D-
2.43.0


