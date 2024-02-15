Return-Path: <linux-wireless+bounces-3608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 100F0855A3F
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 06:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5091DB2413E
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Feb 2024 05:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62654A12;
	Thu, 15 Feb 2024 05:58:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F59BA2E
	for <linux-wireless@vger.kernel.org>; Thu, 15 Feb 2024 05:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707976730; cv=none; b=RgPNSQ+jj23cckID2mYUC8ER9KwkxNWOkRT2XrWGR2O71Gp6nWJsPnQy4Z6/4jb0IgivgKdt9oZk2D+Own3ayRuOIsQUCWAoxvTDgEe+Rt8i8nd6AqrmmCt1q3eBF0PclS5tGcN9BQBgZ3Z2uY6HmoFNMg4IfyiWYwfWJhxSE88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707976730; c=relaxed/simple;
	bh=rWnOqSUsFhKYNUg8rPtHa2NOULbiMKxpClLIgB+LnJs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=co+81PchbLkT3HzYQhXOJoTaX7hlXBWnrh7El6OFasmWCYG+a+qQFDdVzPA5OmvJg0X5bS4TiMxKrSpG8ZoF3xgJ+fNPyg98/RopPKUbJTrwBUuzDzfYtlu6B3KszF6kb7KRjAwCWv6pJFyn5ies60GAmihLUgSTdMdQaQKbDhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41F5whDiB2372787, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41F5whDiB2372787
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 13:58:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 15 Feb 2024 13:58:43 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 15 Feb
 2024 13:58:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/4] wifi: rtw89: 8922a: add set_channel RF part
Date: Thu, 15 Feb 2024 13:57:40 +0800
Message-ID: <20240215055741.14148-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240215055741.14148-1-pkshih@realtek.com>
References: <20240215055741.14148-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Configure RF registers according to band, channel, bandwidth. Since this
chip will support MLO, it needs check the operating mode to decide paths
we are going to configure.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c      |  72 +++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h      |   4 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   8 ++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.c | 120 ++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.h |   3 +
 6 files changed, 208 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index dfbf59895e4e..12da63d64307 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -6378,6 +6378,78 @@ void rtw89_phy_edcca_track(struct rtw89_dev *rtwdev)
 	rtw89_phy_edcca_log(rtwdev);
 }
 
+enum rtw89_rf_path_bit rtw89_phy_get_kpath(struct rtw89_dev *rtwdev,
+					   enum rtw89_phy_idx phy_idx)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[RFK] kpath dbcc_en: 0x%x, mode=0x%x, PHY%d\n",
+		    rtwdev->dbcc_en, rtwdev->mlo_dbcc_mode, phy_idx);
+
+	switch (rtwdev->mlo_dbcc_mode) {
+	case MLO_1_PLUS_1_1RF:
+		if (phy_idx == RTW89_PHY_0)
+			return RF_A;
+		else
+			return RF_B;
+	case MLO_1_PLUS_1_2RF:
+		if (phy_idx == RTW89_PHY_0)
+			return RF_A;
+		else
+			return RF_D;
+	case MLO_0_PLUS_2_1RF:
+	case MLO_2_PLUS_0_1RF:
+		if (phy_idx == RTW89_PHY_0)
+			return RF_AB;
+		else
+			return RF_AB;
+	case MLO_0_PLUS_2_2RF:
+	case MLO_2_PLUS_0_2RF:
+	case MLO_2_PLUS_2_2RF:
+	default:
+		if (phy_idx == RTW89_PHY_0)
+			return RF_AB;
+		else
+			return RF_CD;
+	}
+}
+EXPORT_SYMBOL(rtw89_phy_get_kpath);
+
+enum rtw89_rf_path rtw89_phy_get_syn_sel(struct rtw89_dev *rtwdev,
+					 enum rtw89_phy_idx phy_idx)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[RFK] kpath dbcc_en: 0x%x, mode=0x%x, PHY%d\n",
+		    rtwdev->dbcc_en, rtwdev->mlo_dbcc_mode, phy_idx);
+
+	switch (rtwdev->mlo_dbcc_mode) {
+	case MLO_1_PLUS_1_1RF:
+		if (phy_idx == RTW89_PHY_0)
+			return RF_PATH_A;
+		else
+			return RF_PATH_B;
+	case MLO_1_PLUS_1_2RF:
+		if (phy_idx == RTW89_PHY_0)
+			return RF_PATH_A;
+		else
+			return RF_PATH_D;
+	case MLO_0_PLUS_2_1RF:
+	case MLO_2_PLUS_0_1RF:
+		if (phy_idx == RTW89_PHY_0)
+			return RF_PATH_A;
+		else
+			return RF_PATH_B;
+	case MLO_0_PLUS_2_2RF:
+	case MLO_2_PLUS_0_2RF:
+	case MLO_2_PLUS_2_2RF:
+	default:
+		if (phy_idx == RTW89_PHY_0)
+			return RF_PATH_A;
+		else
+			return RF_PATH_C;
+	}
+}
+EXPORT_SYMBOL(rtw89_phy_get_syn_sel);
+
 static const struct rtw89_ccx_regs rtw89_ccx_regs_ax = {
 	.setting_addr = R_CCX,
 	.edcca_opt_mask = B_CCX_EDCCA_OPT_MSK,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index de19f1c7f931..082231ebbee5 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -945,5 +945,9 @@ void rtw89_decode_chan_idx(struct rtw89_dev *rtwdev, u8 chan_idx,
 void rtw89_phy_config_edcca(struct rtw89_dev *rtwdev, bool scan);
 void rtw89_phy_edcca_track(struct rtw89_dev *rtwdev);
 void rtw89_phy_edcca_thre_calc(struct rtw89_dev *rtwdev);
+enum rtw89_rf_path_bit rtw89_phy_get_kpath(struct rtw89_dev *rtwdev,
+					   enum rtw89_phy_idx phy_idx);
+enum rtw89_rf_path rtw89_phy_get_syn_sel(struct rtw89_dev *rtwdev,
+					 enum rtw89_phy_idx phy_idx);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 9f3d10766b04..37ccd8ffa87a 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7497,6 +7497,12 @@
 #define CFGCH_BAND0_2G 0
 #define CFGCH_BAND0_5G 1
 #define CFGCH_BAND0_6G 0
+#define RR_CFGCH_BW_V2 GENMASK(12, 10)
+#define CFGCH_BW_V2_20M 0
+#define CFGCH_BW_V2_40M 1
+#define CFGCH_BW_V2_80M 2
+#define CFGCH_BW_V2_160M 3
+#define CFGCH_BW_V2_320M 4
 #define RR_CFGCH_BW GENMASK(11, 10)
 #define RR_CFGCH_CH GENMASK(7, 0)
 #define CFGCH_BW_20M 3
@@ -7683,6 +7689,8 @@
 #define RR_MMD 0xd5
 #define RR_MMD_RST_EN BIT(8)
 #define RR_MMD_RST_SYN BIT(6)
+#define RR_SMD 0xd6
+#define RR_VCO2 BIT(19)
 #define RR_IQKPLL 0xdc
 #define RR_IQKPLL_MOD GENMASK(9, 8)
 #define RR_SYNLUT 0xdd
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 361e66954924..dbbf6f344f3a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -1781,6 +1781,7 @@ static void rtw8922a_set_channel(struct rtw89_dev *rtwdev,
 {
 	rtw8922a_set_channel_mac(rtwdev, chan, mac_idx);
 	rtw8922a_set_channel_bb(rtwdev, chan, phy_idx);
+	rtw8922a_set_channel_rf(rtwdev, chan, phy_idx);
 }
 
 static void rtw8922a_dfs_en_idx(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
index d8ef986e7877..72953b7358df 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
@@ -34,6 +34,126 @@ void rtw8922a_tssi_cont_en_phyidx(struct rtw89_dev *rtwdev, bool en, u8 phy_idx)
 	}
 }
 
+static
+void rtw8922a_ctl_band_ch_bw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			     u8 central_ch, enum rtw89_band band,
+			     enum rtw89_bandwidth bw)
+{
+	const u32 rf_addr[2] = {RR_CFGCH, RR_CFGCH_V1};
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u32 rf_reg[RF_PATH_NUM_8922A][2];
+	u8 synpath;
+	u32 rf18;
+	u8 kpath;
+	u8 path;
+	u8 i;
+
+	rf_reg[RF_PATH_A][0] = rtw89_read_rf(rtwdev, RF_PATH_A, rf_addr[0], RFREG_MASK);
+	rf_reg[RF_PATH_A][1] = rtw89_read_rf(rtwdev, RF_PATH_A, rf_addr[1], RFREG_MASK);
+	rf_reg[RF_PATH_B][0] = rtw89_read_rf(rtwdev, RF_PATH_B, rf_addr[0], RFREG_MASK);
+	rf_reg[RF_PATH_B][1] = rtw89_read_rf(rtwdev, RF_PATH_B, rf_addr[1], RFREG_MASK);
+
+	kpath = rtw89_phy_get_kpath(rtwdev, phy);
+	synpath = rtw89_phy_get_syn_sel(rtwdev, phy);
+
+	rf18 = rtw89_read_rf(rtwdev, synpath, RR_CFGCH, RFREG_MASK);
+	if (rf18 == INV_RF_DATA) {
+		rtw89_warn(rtwdev, "[RFK] Invalid RF18 value\n");
+		return;
+	}
+
+	for (path = 0; path < RF_PATH_NUM_8922A; path++) {
+		if (!(kpath & BIT(path)))
+			continue;
+
+		for (i = 0; i < 2; i++) {
+			if (rf_reg[path][i] == INV_RF_DATA) {
+				rtw89_warn(rtwdev,
+					   "[RFK] Invalid RF_0x18 for Path-%d\n", path);
+				return;
+			}
+
+			rf_reg[path][i] &= ~(RR_CFGCH_BAND1 | RR_CFGCH_BW |
+					     RR_CFGCH_BAND0 | RR_CFGCH_CH);
+			rf_reg[path][i] |= u32_encode_bits(central_ch, RR_CFGCH_CH);
+
+			if (band == RTW89_BAND_2G)
+				rtw89_write_rf(rtwdev, path, RR_SMD, RR_VCO2, 0x0);
+			else
+				rtw89_write_rf(rtwdev, path, RR_SMD, RR_VCO2, 0x1);
+
+			switch (band) {
+			case RTW89_BAND_2G:
+			default:
+				break;
+			case RTW89_BAND_5G:
+				rf_reg[path][i] |=
+					u32_encode_bits(CFGCH_BAND1_5G, RR_CFGCH_BAND1) |
+					u32_encode_bits(CFGCH_BAND0_5G, RR_CFGCH_BAND0);
+				break;
+			case RTW89_BAND_6G:
+				rf_reg[path][i] |=
+					u32_encode_bits(CFGCH_BAND1_6G, RR_CFGCH_BAND1) |
+					u32_encode_bits(CFGCH_BAND0_6G, RR_CFGCH_BAND0);
+				break;
+			}
+
+			switch (bw) {
+			case RTW89_CHANNEL_WIDTH_5:
+			case RTW89_CHANNEL_WIDTH_10:
+			case RTW89_CHANNEL_WIDTH_20:
+			default:
+				break;
+			case RTW89_CHANNEL_WIDTH_40:
+				rf_reg[path][i] |=
+					u32_encode_bits(CFGCH_BW_V2_40M, RR_CFGCH_BW_V2);
+				break;
+			case RTW89_CHANNEL_WIDTH_80:
+				rf_reg[path][i] |=
+					u32_encode_bits(CFGCH_BW_V2_80M, RR_CFGCH_BW_V2);
+				break;
+			case RTW89_CHANNEL_WIDTH_160:
+				rf_reg[path][i] |=
+					u32_encode_bits(CFGCH_BW_V2_160M, RR_CFGCH_BW_V2);
+				break;
+			case RTW89_CHANNEL_WIDTH_320:
+				rf_reg[path][i] |=
+					u32_encode_bits(CFGCH_BW_V2_320M, RR_CFGCH_BW_V2);
+				break;
+			}
+
+			rtw89_write_rf(rtwdev, path, rf_addr[i],
+				       RFREG_MASK, rf_reg[path][i]);
+			fsleep(100);
+		}
+	}
+
+	if (hal->cv != CHIP_CAV)
+		return;
+
+	if (band == RTW89_BAND_2G) {
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x80000);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x00003);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD1, RFREG_MASK, 0x0c990);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD0, RFREG_MASK, 0xebe38);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x00000);
+	} else {
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x80000);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWA, RFREG_MASK, 0x00003);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD1, RFREG_MASK, 0x0c190);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWD0, RFREG_MASK, 0xebe38);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LUTWE, RFREG_MASK, 0x00000);
+	}
+}
+
+void rtw8922a_set_channel_rf(struct rtw89_dev *rtwdev,
+			     const struct rtw89_chan *chan,
+			     enum rtw89_phy_idx phy_idx)
+{
+	rtw8922a_ctl_band_ch_bw(rtwdev, phy_idx, chan->channel, chan->band_type,
+				chan->band_width);
+}
+
 enum _rf_syn_pow {
 	RF_SYN_ON_OFF,
 	RF_SYN_OFF_ON,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h
index de5fa6c74530..27a2ff8166d0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.h
@@ -8,6 +8,9 @@
 #include "core.h"
 
 void rtw8922a_tssi_cont_en_phyidx(struct rtw89_dev *rtwdev, bool en, u8 phy_idx);
+void rtw8922a_set_channel_rf(struct rtw89_dev *rtwdev,
+			     const struct rtw89_chan *chan,
+			     enum rtw89_phy_idx phy_idx);
 void rtw8922a_rfk_hw_init(struct rtw89_dev *rtwdev);
 
 #endif
-- 
2.25.1


