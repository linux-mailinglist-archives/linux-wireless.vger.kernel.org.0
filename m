Return-Path: <linux-wireless+bounces-19833-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA6DA54060
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 03:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200E31891A9F
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 02:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FEF18DB2A;
	Thu,  6 Mar 2025 02:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="V4eRQVKN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DB4BE46
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 02:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741227141; cv=none; b=eDEd09YjLvqvhNFYCPD1yjCjO5tDomNLYhrPDCUmyd1onCegELSpEq/7HXtqszfZYujhmm6BvUaV/aH+EhuIYkl8LNT9p5b5lMNo6IljhnPSfengAx6vwGNemh4ncMcJHLGG9LYK8GJQjJKUt+e9P1yLIb4Iaiqzue0+xUeyanw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741227141; c=relaxed/simple;
	bh=1n/BhON7mwgVOmVDEPsg1lXrmAXDqjhe2+aIQSafXzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Czp7+DGrIsTHllLERW3zmvdIIgksc298ZYApkYgTd59s0Zkcwgh/xfBF5M67usDBeD8DlQnhaH/xugwNtRFr/ee18PrKdcQZtsZ7Q0QAHyZAP5zeyljBudagDHYmpLB738/VCVuLITDruXx7PAA16HCnd3v1RxBjM1bh28HjPNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=V4eRQVKN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5262CFtbC2495417, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741227135; bh=1n/BhON7mwgVOmVDEPsg1lXrmAXDqjhe2+aIQSafXzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=V4eRQVKNk0zrywhTdv6QDWr1nLd+MrRC4+aShFVKsxDxv7tQkrdt1xSrwxe+LfnP8
	 13Pg8aEU0eWXptt5VXAhKszgaAHCTxjxBnS0bozy4EUMK/8t/TnMgVFXiUPBDI7cDA
	 lZNdHaECIu+I/VV8Z+0+Y9D8OL6ADTCCvX4OVRlOLkOjGF1PSAKflP36t3ncYhYEyV
	 kOlBji2/Vw8Pcr6Z96cn300iULuzW7VuBV/hZAJXHELauY9oAP6x28Nfgz1usXkta7
	 AmBlhp15/oRuGyZULjJOm6+drn6UbsOX2P3aptupWH18qymsJxWGeYOaJ/RCaMChjv
	 DTKDyNKOqq85A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5262CFtbC2495417
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 6 Mar 2025 10:12:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Mar 2025 10:12:15 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 6 Mar
 2025 10:12:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>
Subject: [PATCH rtw-next 4/5] wifi: rtw89: 8922a: enable dynamic antenna gain
Date: Thu, 6 Mar 2025 10:11:43 +0800
Message-ID: <20250306021144.12854-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250306021144.12854-1-pkshih@realtek.com>
References: <20250306021144.12854-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Kuan-Chung Chen <damon.chen@realtek.com>

The 8922A now supports dynamic antenna gain. However, in firmware
before v0.35.64.0, different transmit powers cannot be applied to
each RF path. To comply with regulatory limits in these older
firmware, the lower of the two requested transmit powers will
be used for both paths when they differ.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c       |  1 +
 drivers/net/wireless/realtek/rtw89/phy.c      |  6 +++
 drivers/net/wireless/realtek/rtw89/phy.h      |  7 +++
 drivers/net/wireless/realtek/rtw89/reg.h      | 28 +++++++---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 54 ++++++++++++++++++-
 6 files changed, 88 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b8f46207141e..c32b74df1443 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4492,6 +4492,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_CH_INFO_BE_V0,
 	RTW89_FW_FEATURE_LPS_CH_INFO,
 	RTW89_FW_FEATURE_NO_PHYCAP_P1,
+	RTW89_FW_FEATURE_NO_POWER_DIFFERENCE,
 };
 
 struct rtw89_fw_suit {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d0a246f415ff..8643b17866f8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -849,6 +849,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 47, 0, CH_INFO_BE_V0),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 49, 0, RFK_PRE_NOTIFY_V1),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 51, 0, NO_PHYCAP_P1),
+	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 64, 0, NO_POWER_DIFFERENCE),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index bd736417f467..f4eee642e5ce 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2050,6 +2050,9 @@ static s8 rtw89_phy_ant_gain_offset(struct rtw89_dev *rtwdev, u8 band, u32 cente
 	offset_patha = rtw89_phy_ant_gain_query(rtwdev, RF_PATH_A, center_freq);
 	offset_pathb = rtw89_phy_ant_gain_query(rtwdev, RF_PATH_B, center_freq);
 
+	if (RTW89_CHK_FW_FEATURE(NO_POWER_DIFFERENCE, &rtwdev->fw))
+		return min(offset_patha, offset_pathb);
+
 	return max(offset_patha, offset_pathb);
 }
 
@@ -2067,6 +2070,9 @@ s16 rtw89_phy_ant_gain_pwr_offset(struct rtw89_dev *rtwdev,
 	if (ant_gain->block_country || !(ant_gain->regd_enabled & BIT(regd)))
 		return 0;
 
+	if (RTW89_CHK_FW_FEATURE(NO_POWER_DIFFERENCE, &rtwdev->fw))
+		return 0;
+
 	offset_patha = rtw89_phy_ant_gain_query(rtwdev, RF_PATH_A, chan->freq);
 	offset_pathb = rtw89_phy_ant_gain_query(rtwdev, RF_PATH_B, chan->freq);
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index e20fff9bac3e..518a100375fb 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -914,6 +914,13 @@ static inline s8 rtw89_phy_txpwr_rf_to_bb(struct rtw89_dev *rtwdev, s8 txpwr_rf)
 	return txpwr_rf << (chip->txpwr_factor_bb - chip->txpwr_factor_rf);
 }
 
+static inline s8 rtw89_phy_txpwr_bb_to_rf(struct rtw89_dev *rtwdev, s8 txpwr_bb)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	return txpwr_bb >> (chip->txpwr_factor_bb - chip->txpwr_factor_rf);
+}
+
 static inline s8 rtw89_phy_txpwr_rf_to_mac(struct rtw89_dev *rtwdev, s8 txpwr_rf)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index ec06f5bd0fab..44201efee01c 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -9181,6 +9181,16 @@
 #define B_IQKINF2_FCNT GENMASK(23, 16)
 #define B_IQKINF2_KCNT GENMASK(15, 8)
 #define B_IQKINF2_NCTLV GENMASK(7, 0)
+#define R_TXAGC_REF_DBM_RF1_P0 0xBC04
+#define B_TXAGC_OFDM_REF_DBM_RF1_P0 GENMASK(10, 2)
+#define B_TXAGC_CCK_REF_DBM_RF1_P0 GENMASK(19, 11)
+#define R_TSSI_K_RF1_P0 0xBC28
+#define B_TSSI_K_OFDM_RF1_P0 GENMASK(9, 0)
+#define R_TXAGC_REF_DBM_RF1_P1 0xBD04
+#define B_TXAGC_OFDM_REF_DBM_RF1_P1 GENMASK(10, 2)
+#define B_TXAGC_CCK_REF_DBM_RF1_P1 GENMASK(19, 11)
+#define R_TSSI_K_RF1_P1 0xBD28
+#define B_TSSI_K_OFDM_RF1_P1 GENMASK(9, 0)
 #define R_RFK_ST 0xBFF8
 #define R_DCOF0 0xC000
 #define B_DCOF0_RST BIT(17)
@@ -9350,16 +9360,18 @@
 #define R_TSSI_MAP_OFST_P1 0xE720
 #define B_TSSI_MAP_OFST_OFDM GENMASK(17, 9)
 #define B_TSSI_MAP_OFST_CCK GENMASK(26, 18)
-#define R_TXAGC_REF0_P0 0xE628
-#define R_TXAGC_REF0_P1 0xE728
-#define B_TXAGC_REF0_OFDM_DBM GENMASK(8, 0)
-#define B_TXAGC_REF0_CCK_DBM GENMASK(17, 9)
-#define B_TXAGC_REF0_OFDM_CW GENMASK(26, 18)
-#define R_TXAGC_REF1_P0 0xE62C
-#define R_TXAGC_REF1_P1 0xE72C
-#define B_TXAGC_REF1_CCK_CW GENMASK(8, 0)
+#define R_TXAGC_REF_DBM_P0 0xE628
+#define B_TXAGC_OFDM_REF_DBM_P0 GENMASK(8, 0)
+#define B_TXAGC_CCK_REF_DBM_P0 GENMASK(17, 9)
+#define R_TSSI_K_P0 0xE6A0
+#define B_TSSI_K_OFDM_P0 GENMASK(29, 20)
 #define R_TXPWR_RSTB 0xE70C
 #define B_TXPWR_RSTB BIT(16)
+#define R_TXAGC_REF_DBM_P1 0xE728
+#define B_TXAGC_OFDM_REF_DBM_P1 GENMASK(8, 0)
+#define B_TXAGC_CCK_REF_DBM_P1 GENMASK(17, 9)
+#define R_TSSI_K_P1 0xE7A0
+#define B_TSSI_K_OFDM_P1 GENMASK(29, 20)
 
 /* WiFi CPU local domain */
 #define R_AX_WDT_CTRL 0x0040
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index d90af2daebcf..8082592db84a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2156,6 +2156,56 @@ static void rtw8922a_set_txpwr_ref(struct rtw89_dev *rtwdev,
 				     B_BE_PWR_REF_CTRL_CCK, ref_cck);
 }
 
+static const struct rtw89_reg_def rtw8922a_txpwr_ref[][3] = {
+	{{ .addr = R_TXAGC_REF_DBM_P0, .mask = B_TXAGC_OFDM_REF_DBM_P0},
+	 { .addr = R_TXAGC_REF_DBM_P0, .mask = B_TXAGC_CCK_REF_DBM_P0},
+	 { .addr = R_TSSI_K_P0, .mask = B_TSSI_K_OFDM_P0}
+	},
+	{{ .addr = R_TXAGC_REF_DBM_RF1_P0, .mask = B_TXAGC_OFDM_REF_DBM_RF1_P0},
+	 { .addr = R_TXAGC_REF_DBM_RF1_P0, .mask = B_TXAGC_CCK_REF_DBM_RF1_P0},
+	 { .addr = R_TSSI_K_RF1_P0, .mask = B_TSSI_K_OFDM_RF1_P0}
+	},
+};
+
+static void rtw8922a_set_txpwr_diff(struct rtw89_dev *rtwdev,
+				    const struct rtw89_chan *chan,
+				    enum rtw89_phy_idx phy_idx)
+{
+	s16 pwr_ofst = rtw89_phy_ant_gain_pwr_offset(rtwdev, chan);
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	static const u32 path_ofst[] = {0x0, 0x100};
+	const struct rtw89_reg_def *txpwr_ref;
+	static const s16 tssi_k_base = 0x12;
+	s16 tssi_k_ofst = abs(pwr_ofst) + tssi_k_base;
+	s16 ofst_dec[RF_PATH_NUM_8922A];
+	s16 tssi_k[RF_PATH_NUM_8922A];
+	s16 pwr_ref_ofst;
+	s16 pwr_ref = 0;
+	u8 i;
+
+	if (rtwdev->hal.cv == CHIP_CAV)
+		pwr_ref = 16;
+
+	pwr_ref <<= chip->txpwr_factor_rf;
+	pwr_ref_ofst = pwr_ref - rtw89_phy_txpwr_bb_to_rf(rtwdev, abs(pwr_ofst));
+
+	ofst_dec[RF_PATH_A] = pwr_ofst > 0 ? pwr_ref : pwr_ref_ofst;
+	ofst_dec[RF_PATH_B] = pwr_ofst > 0 ? pwr_ref_ofst : pwr_ref;
+	tssi_k[RF_PATH_A] = pwr_ofst > 0 ? tssi_k_base : tssi_k_ofst;
+	tssi_k[RF_PATH_B] = pwr_ofst > 0 ? tssi_k_ofst : tssi_k_base;
+
+	for (i = 0; i < RF_PATH_NUM_8922A; i++) {
+		txpwr_ref = rtw8922a_txpwr_ref[phy_idx];
+
+		rtw89_phy_write32_mask(rtwdev, txpwr_ref[0].addr + path_ofst[i],
+				       txpwr_ref[0].mask, ofst_dec[i]);
+		rtw89_phy_write32_mask(rtwdev, txpwr_ref[1].addr + path_ofst[i],
+				       txpwr_ref[1].mask, ofst_dec[i]);
+		rtw89_phy_write32_mask(rtwdev, txpwr_ref[2].addr + path_ofst[i],
+				       txpwr_ref[2].mask, tssi_k[i]);
+	}
+}
+
 static void rtw8922a_bb_tx_triangular(struct rtw89_dev *rtwdev, bool en,
 				      enum rtw89_phy_idx phy_idx)
 {
@@ -2192,6 +2242,8 @@ static void rtw8922a_set_txpwr(struct rtw89_dev *rtwdev,
 	rtw8922a_set_tx_shape(rtwdev, chan, phy_idx);
 	rtw89_phy_set_txpwr_limit(rtwdev, chan, phy_idx);
 	rtw89_phy_set_txpwr_limit_ru(rtwdev, chan, phy_idx);
+	rtw8922a_set_txpwr_diff(rtwdev, chan, phy_idx);
+	rtw8922a_set_txpwr_ref(rtwdev, phy_idx);
 }
 
 static void rtw8922a_set_txpwr_ctrl(struct rtw89_dev *rtwdev,
@@ -2769,7 +2821,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 				  BIT(NL80211_CHAN_WIDTH_80) |
 				  BIT(NL80211_CHAN_WIDTH_160),
 	.support_unii4		= true,
-	.support_ant_gain	= false,
+	.support_ant_gain	= true,
 	.support_tas		= false,
 	.ul_tb_waveform_ctrl	= false,
 	.ul_tb_pwr_diff		= false,
-- 
2.25.1


