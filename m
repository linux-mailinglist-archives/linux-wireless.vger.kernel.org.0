Return-Path: <linux-wireless+bounces-9633-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC43C919DA2
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 04:59:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D00281C21714
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 02:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F0DDDA0;
	Thu, 27 Jun 2024 02:59:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D12175A6
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 02:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719457174; cv=none; b=agQZ1yQys9N1F2dLPromkUmKwMf6yLhu5nXimtg2VXx1292kB40agaLC/uSgOrm1pGAuc6slDhXDW1G+z4K6D1yOTLEAABKkNd6dcMwCgMGrUn3YN/fnTRzWx2ODtbEiiihxbtokSEZ4pIqTDYe62huS/eRsIdBKmpNw6QnQ0Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719457174; c=relaxed/simple;
	bh=R+HBJ+325/1hWCoXOG6nJS+14LvPOUMNOO/x+/BEd40=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWrV5Ulwrw7IeeqGfa20Ec2IAHqPtRkx7AzYf7esPQ0+EVSzrlGfzIr4wogNbKc7JEyjLiyaz7ulh7xILROiROkH5DA/0GaisV7BSbdZQ3Uo5iYj6XTLoMhHoz7F0dclQfRUJhDq5Qry0uiIVkV0d3uWsf1ihLacCA+tB3w6Ezk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45R2xTRZ12591134, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 45R2xTRZ12591134
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 10:59:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 10:59:29 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 27 Jun
 2024 10:59:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/4] wifi: rtw89: 8852bt: rfk: add DACK
Date: Thu, 27 Jun 2024 10:58:48 +0800
Message-ID: <20240627025849.25198-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240627025849.25198-1-pkshih@realtek.com>
References: <20240627025849.25198-1-pkshih@realtek.com>
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

DACK (digital-to-analog converters calibration) is used to calibrate DAC
to output signals as expected.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  15 +
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    | 487 ++++++++++++++++++
 .../wireless/realtek/rtw89/rtw8852bt_rfk.h    |   1 +
 3 files changed, 503 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 24e8d244534e..7df36f3bff0b 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7836,6 +7836,7 @@
 #define B_ANAPAR_PW15_H2 GENMASK(27, 26)
 #define R_ANAPAR 0x032C
 #define B_ANAPAR_15 GENMASK(31, 16)
+#define B_ANAPAR_EN1 BIT(31)
 #define B_ANAPAR_ADCCLK BIT(30)
 #define B_ANAPAR_FLTRST BIT(22)
 #define B_ANAPAR_CRXBB GENMASK(18, 16)
@@ -9080,11 +9081,13 @@
 #define B_DCOF0_RST BIT(17)
 #define B_DCOF0_V GENMASK(4, 1)
 #define R_DCOF1 0xC004
+#define B_DCOF1_VAL GENMASK(31, 20)
 #define B_DCOF1_RST BIT(17)
 #define B_DCOF1_S BIT(0)
 #define R_DCOF8 0xC020
 #define B_DCOF8_V GENMASK(4, 1)
 #define R_DCOF9 0xC024
+#define B_DCOF9_VAL GENMASK(31, 20)
 #define B_DCOF9_RST BIT(17)
 #define R_DACK_S0P0 0xC040
 #define B_DACK_S0P0_OK BIT(31)
@@ -9158,11 +9161,18 @@
 #define B_ADDCKR0_DC GENMASK(15, 4)
 #define B_ADDCKR0_A1 GENMASK(9, 0)
 #define R_DACK10 0xC100
+#define B_DACK10_RST BIT(17)
 #define B_DACK10 GENMASK(4, 1)
 #define R_DACK1_K 0xc104
+#define B_DACK1_VAL GENMASK(31, 20)
+#define B_DACK1_RST BIT(17)
 #define B_DACK1_EN BIT(0)
 #define R_DACK11 0xC120
 #define B_DACK11 GENMASK(4, 1)
+#define R_DACK2_K 0xC124
+#define B_DACK2_VAL GENMASK(31, 20)
+#define B_DACK2_RST BIT(17)
+#define B_DACK2_EN BIT(0)
 #define R_DACK_S1P0 0xC140
 #define B_DACK_S1P0_OK BIT(31)
 #define R_DACK_BIAS10 0xC148
@@ -9211,6 +9221,11 @@
 #define B_DACKN0_V GENMASK(21, 14)
 #define R_DACKN1_CTL 0xC224
 #define B_DACKN1_V GENMASK(21, 14)
+#define B_DACKN1_ON BIT(0)
+#define R_DACKN2_CTL 0xC238
+#define B_DACKN2_ON BIT(0)
+#define R_DACKN3_CTL 0xC24C
+#define B_DACKN3_ON BIT(0)
 #define R_GAIN_MAP0 0xE44C
 #define B_GAIN_MAP0_EN BIT(0)
 #define R_GAIN_MAP1 0xE54C
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index 52dfbe0b3d6b..6c2fecb58940 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -407,6 +407,484 @@ static void _rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 	}
 }
 
+static void _drck(struct rtw89_dev *rtwdev)
+{
+	u32 rck_d;
+	u32 val;
+	int ret;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]Ddie RCK start!!!\n");
+	rtw89_phy_write32_mask(rtwdev, R_DRCK, B_DRCK_EN, 0x1);
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, val, val,
+				       1, 10000, false,
+				       rtwdev, R_DRCK_RES, B_DRCK_POL);
+	if (ret)
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DRCK timeout\n");
+
+	rtw89_phy_write32_mask(rtwdev, R_DRCK, B_DRCK_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_DRCK_FH, B_DRCK_LAT, 0x1);
+	udelay(1);
+	rtw89_phy_write32_mask(rtwdev, R_DRCK_FH, B_DRCK_LAT, 0x0);
+
+	rck_d = rtw89_phy_read32_mask(rtwdev, R_DRCK_RES, 0x7c00);
+	rtw89_phy_write32_mask(rtwdev, R_DRCK, B_DRCK_IDLE, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_DRCK, B_DRCK_VAL, rck_d);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0xc0c4 = 0x%x\n",
+		    rtw89_phy_read32_mask(rtwdev, R_DRCK, MASKDWORD));
+}
+
+static void _dack_backup_s0(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	u8 i;
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_DBG, 0x1);
+
+	for (i = 0; i < 0x10; i++) {
+		rtw89_phy_write32_mask(rtwdev, R_DCOF0, B_DCOF0_V, i);
+		dack->msbk_d[0][0][i] =
+			rtw89_phy_read32_mask(rtwdev, R_DACK_S0P2, B_DACK_S0M0);
+
+		rtw89_phy_write32_mask(rtwdev, R_DCOF8, B_DCOF8_V, i);
+		dack->msbk_d[0][1][i] =
+			rtw89_phy_read32_mask(rtwdev, R_DACK_S0P3, B_DACK_S0M1);
+	}
+
+	dack->biask_d[0][0] =
+		rtw89_phy_read32_mask(rtwdev, R_DACK_BIAS00, B_DACK_BIAS00);
+	dack->biask_d[0][1] =
+		rtw89_phy_read32_mask(rtwdev, R_DACK_BIAS01, B_DACK_BIAS01);
+
+	dack->dadck_d[0][0] =
+		rtw89_phy_read32_mask(rtwdev, R_DACK_DADCK00, B_DACK_DADCK00);
+	dack->dadck_d[0][1] =
+		rtw89_phy_read32_mask(rtwdev, R_DACK_DADCK01, B_DACK_DADCK01);
+}
+
+static void _dack_backup_s1(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	u8 i;
+
+	rtw89_phy_write32_mask(rtwdev, R_P1_DBGMOD, B_P1_DBGMOD_ON, 0x1);
+
+	for (i = 0; i < 0x10; i++) {
+		rtw89_phy_write32_mask(rtwdev, R_DACK10, B_DACK10, i);
+		dack->msbk_d[1][0][i] =
+			rtw89_phy_read32_mask(rtwdev, R_DACK10S, B_DACK10S);
+
+		rtw89_phy_write32_mask(rtwdev, R_DACK11, B_DACK11, i);
+		dack->msbk_d[1][1][i] =
+			rtw89_phy_read32_mask(rtwdev, R_DACK11S, B_DACK11S);
+	}
+
+	dack->biask_d[1][0] =
+		rtw89_phy_read32_mask(rtwdev, R_DACK_BIAS10, B_DACK_BIAS10);
+	dack->biask_d[1][1] =
+		rtw89_phy_read32_mask(rtwdev, R_DACK_BIAS11, B_DACK_BIAS11);
+
+	dack->dadck_d[1][0] =
+		rtw89_phy_read32_mask(rtwdev, R_DACK_DADCK10, B_DACK_DADCK10);
+	dack->dadck_d[1][1] =
+		rtw89_phy_read32_mask(rtwdev, R_DACK_DADCK11, B_DACK_DADCK11);
+}
+
+static
+void _dack_reset(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
+{
+	if (path == RF_PATH_A) {
+		rtw89_phy_write32_mask(rtwdev, R_DCOF0, B_DCOF0_RST, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_DCOF0, B_DCOF0_RST, 0x1);
+	} else {
+		rtw89_phy_write32_mask(rtwdev, R_DACK10, B_DACK10_RST, 0x0);
+		rtw89_phy_write32_mask(rtwdev, R_DACK10, B_DACK10_RST, 0x1);
+	}
+}
+
+static
+void _dack_reload_by_path(struct rtw89_dev *rtwdev, u8 path, u8 index)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	u32 tmp, tmp_offset, tmp_reg;
+	u32 idx_offset, path_offset;
+	u8 i;
+
+	if (index == 0)
+		idx_offset = 0;
+	else
+		idx_offset = 0x14;
+
+	if (path == RF_PATH_A)
+		path_offset = 0;
+	else
+		path_offset = 0x28;
+
+	tmp_offset = idx_offset + path_offset;
+
+	rtw89_phy_write32_mask(rtwdev, R_DCOF1, B_DCOF1_RST, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_DCOF9, B_DCOF9_RST, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_DACK1_K, B_DACK1_RST, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_DACK2_K, B_DACK2_RST, 0x1);
+
+	/* msbk_d: 15/14/13/12 */
+	tmp = 0x0;
+	for (i = 0; i < 4; i++)
+		tmp |= dack->msbk_d[path][index][i + 12] << (i * 8);
+	tmp_reg = 0xc200 + tmp_offset;
+	rtw89_phy_write32(rtwdev, tmp_reg, tmp);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x=0x%x\n", tmp_reg,
+		    rtw89_phy_read32_mask(rtwdev, tmp_reg, MASKDWORD));
+
+	/* msbk_d: 11/10/9/8 */
+	tmp = 0x0;
+	for (i = 0; i < 4; i++)
+		tmp |= dack->msbk_d[path][index][i + 8] << (i * 8);
+	tmp_reg = 0xc204 + tmp_offset;
+	rtw89_phy_write32(rtwdev, tmp_reg, tmp);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x=0x%x\n", tmp_reg,
+		    rtw89_phy_read32_mask(rtwdev, tmp_reg, MASKDWORD));
+
+	/* msbk_d: 7/6/5/4 */
+	tmp = 0x0;
+	for (i = 0; i < 4; i++)
+		tmp |= dack->msbk_d[path][index][i + 4] << (i * 8);
+	tmp_reg = 0xc208 + tmp_offset;
+	rtw89_phy_write32(rtwdev, tmp_reg, tmp);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x=0x%x\n", tmp_reg,
+		    rtw89_phy_read32_mask(rtwdev, tmp_reg, MASKDWORD));
+
+	/* msbk_d: 3/2/1/0 */
+	tmp = 0x0;
+	for (i = 0; i < 4; i++)
+		tmp |= dack->msbk_d[path][index][i] << (i * 8);
+	tmp_reg = 0xc20c + tmp_offset;
+	rtw89_phy_write32(rtwdev, tmp_reg, tmp);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x=0x%x\n", tmp_reg,
+		    rtw89_phy_read32_mask(rtwdev, tmp_reg, MASKDWORD));
+
+	/* dadak_d/biask_d */
+	tmp = (dack->biask_d[path][index] << 22) |
+	      (dack->dadck_d[path][index] << 14);
+	tmp_reg = 0xc210 + tmp_offset;
+	rtw89_phy_write32(rtwdev, tmp_reg, tmp);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x=0x%x\n", tmp_reg,
+		    rtw89_phy_read32_mask(rtwdev, tmp_reg, MASKDWORD));
+
+	/* enable DACK result from reg */
+	rtw89_phy_write32_mask(rtwdev, R_DACKN0_CTL + tmp_offset, B_DACKN0_EN, 0x1);
+}
+
+static
+void _dack_reload(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
+{
+	u8 i;
+
+	for (i = 0; i < 2; i++)
+		_dack_reload_by_path(rtwdev, path, i);
+}
+
+static bool _dack_s0_poll(struct rtw89_dev *rtwdev)
+{
+	if (rtw89_phy_read32_mask(rtwdev, R_DACK_S0P0, B_DACK_S0P0_OK) == 0 ||
+	    rtw89_phy_read32_mask(rtwdev, R_DACK_S0P1, B_DACK_S0P1_OK) == 0 ||
+	    rtw89_phy_read32_mask(rtwdev, R_DACK_S0P2, B_DACK_S0P2_OK) == 0 ||
+	    rtw89_phy_read32_mask(rtwdev, R_DACK_S0P3, B_DACK_S0P3_OK) == 0)
+		return false;
+
+	return true;
+}
+
+static void _dack_s0(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	bool done;
+	int ret;
+
+	_txck_force(rtwdev, RF_PATH_A, true, DAC_160M);
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_DBG, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, BIT(28), 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_EN1, 0x0);
+	udelay(100);
+	rtw89_phy_write32_mask(rtwdev, R_DCOF1, B_DCOF1_VAL, 0x30);
+	rtw89_phy_write32_mask(rtwdev, R_DCOF9, B_DCOF9_VAL, 0x30);
+
+	_dack_reset(rtwdev, RF_PATH_A);
+
+	rtw89_phy_write32_mask(rtwdev, R_DCOF1, B_DCOF1_S, 0x1);
+	udelay(1);
+
+	dack->msbk_timeout[0] = false;
+
+	ret = read_poll_timeout_atomic(_dack_s0_poll, done, done,
+				       1, 20000, false, rtwdev);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 DACK timeout\n");
+		dack->msbk_timeout[0] = true;
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_DCOF1, B_DCOF1_S, 0x0);
+
+	_txck_force(rtwdev, RF_PATH_A, false, DAC_960M);
+	_dack_backup_s0(rtwdev);
+	_dack_reload(rtwdev, RF_PATH_A);
+
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_DBG, 0x0);
+}
+
+static bool _dack_s1_poll(struct rtw89_dev *rtwdev)
+{
+	if (rtw89_phy_read32_mask(rtwdev, R_DACK_S1P0, B_DACK_S1P0_OK) == 0 ||
+	    rtw89_phy_read32_mask(rtwdev, R_DACK_S1P1, B_DACK_S1P1_OK) == 0 ||
+	    rtw89_phy_read32_mask(rtwdev, R_DACK_S1P2, B_DACK_S1P2_OK) == 0 ||
+	    rtw89_phy_read32_mask(rtwdev, R_DACK_S1P3, B_DACK_S1P3_OK) == 0)
+		return false;
+
+	return true;
+}
+
+static void _dack_s1(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	bool done;
+	int ret;
+
+	_txck_force(rtwdev, RF_PATH_B, true, DAC_160M);
+
+	rtw89_phy_write32_mask(rtwdev, R_P1_DBGMOD, B_P1_DBGMOD_ON, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, BIT(28), 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_EN1, 0x0);
+	udelay(100);
+	rtw89_phy_write32_mask(rtwdev, R_DACK1_K, B_DACK1_VAL, 0x30);
+	rtw89_phy_write32_mask(rtwdev, R_DACK2_K, B_DACK2_VAL, 0x30);
+
+	_dack_reset(rtwdev, RF_PATH_B);
+
+	rtw89_phy_write32_mask(rtwdev, R_DACK1_K, B_DACK1_EN, 0x1);
+	udelay(1);
+
+	dack->msbk_timeout[1] = false;
+
+	ret = read_poll_timeout_atomic(_dack_s1_poll, done, done,
+				       1, 10000, false, rtwdev);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 DACK timeout\n");
+		dack->msbk_timeout[1] = true;
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_DACK1_K, B_DACK1_EN, 0x0);
+
+	_txck_force(rtwdev, RF_PATH_B, false, DAC_960M);
+	_dack_backup_s1(rtwdev);
+	_dack_reload(rtwdev, RF_PATH_B);
+
+	rtw89_phy_write32_mask(rtwdev, R_P1_DBGMOD, B_P1_DBGMOD_ON, 0x0);
+}
+
+static void _dack(struct rtw89_dev *rtwdev)
+{
+	_dack_s0(rtwdev);
+	_dack_s1(rtwdev);
+}
+
+static void _dack_dump(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	u8 i;
+	u8 t;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DACK]S0 ADC_DCK ic = 0x%x, qc = 0x%x\n",
+		    dack->addck_d[0][0], dack->addck_d[0][1]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DACK]S1 ADC_DCK ic = 0x%x, qc = 0x%x\n",
+		    dack->addck_d[1][0], dack->addck_d[1][1]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DACK]S0 DAC_DCK ic = 0x%x, qc = 0x%x\n",
+		    dack->dadck_d[0][0], dack->dadck_d[0][1]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DACK]S1 DAC_DCK ic = 0x%x, qc = 0x%x\n",
+		    dack->dadck_d[1][0], dack->dadck_d[1][1]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DACK]S0 biask ic = 0x%x, qc = 0x%x\n",
+		    dack->biask_d[0][0], dack->biask_d[0][1]);
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[DACK]S1 biask ic = 0x%x, qc = 0x%x\n",
+		    dack->biask_d[1][0], dack->biask_d[1][1]);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 MSBK ic:\n");
+	for (i = 0; i < 0x10; i++) {
+		t = dack->msbk_d[0][0][i];
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x\n", t);
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 MSBK qc:\n");
+	for (i = 0; i < RTW89_DACK_MSBK_NR; i++) {
+		t = dack->msbk_d[0][1][i];
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x\n", t);
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 MSBK ic:\n");
+	for (i = 0; i < RTW89_DACK_MSBK_NR; i++) {
+		t = dack->msbk_d[1][0][i];
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x\n", t);
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 MSBK qc:\n");
+	for (i = 0; i < RTW89_DACK_MSBK_NR; i++) {
+		t = dack->msbk_d[1][1][i];
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]0x%x\n", t);
+	}
+}
+
+static void _addck_ori(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+	u32 val;
+	int ret;
+
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0, B_ADDCK0_MAN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK1, B_ADDCK1_MAN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_DBG, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_ADCCLK, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_FLTRST, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_FLTRST, 0x1);
+
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15_H, 0xf);
+	udelay(100);
+
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_PATH0_SAMPL_DLY_T_V1, BIT(4), 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15_H, 0x3);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0, B_ADDCK0_TRG, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0, B_ADDCK0_TRG, 0x0);
+	udelay(1);
+
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0, B_ADDCK0, 0x1);
+	dack->addck_timeout[0] = false;
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, val, val,
+				       1, 10000, false,
+				       rtwdev, R_ADDCKR0, BIT(0));
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S0 ADDCK timeout\n");
+		dack->addck_timeout[0] = true;
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_PATH0_SAMPL_DLY_T_V1, BIT(4), 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15_H, 0xc);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_ADCCLK, 0x1);
+
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0, B_ADDCK0, 0x0);
+	dack->addck_d[0][0] =
+		rtw89_phy_read32_mask(rtwdev, R_ADDCKR0, B_ADDCKR0_A0);
+	dack->addck_d[0][1] =
+		rtw89_phy_read32_mask(rtwdev, R_ADDCKR0, B_ADDCKR0_A1);
+	rtw89_phy_write32_mask(rtwdev, R_P0_NRBW, B_P0_NRBW_DBG, 0x0);
+
+	rtw89_phy_write32_mask(rtwdev, R_P1_DBGMOD, B_P1_DBGMOD_ON, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_ADCCLK, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_FLTRST, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_FLTRST, 0x1);
+
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15_H, 0xf);
+	udelay(100);
+
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_PATH1_SAMPL_DLY_T_V1, BIT(4), 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15_H, 0x3);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK1, B_ADDCK1_TRG, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK1, B_ADDCK1_TRG, 0x0);
+	udelay(1);
+
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK1, B_ADDCK1, 0x1);
+	dack->addck_timeout[1] = false;
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, val, val,
+				       1, 10000, false,
+				       rtwdev, R_ADDCKR1, BIT(0));
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]S1 ADDCK timeout\n");
+		dack->addck_timeout[1] = true;
+	}
+
+	rtw89_phy_write32_mask(rtwdev, R_PATH1_SAMPL_DLY_T_V1, BIT(4), 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_EN, 0x1);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR_PW15, B_ANAPAR_PW15_H, 0xc);
+	rtw89_phy_write32_mask(rtwdev, R_ANAPAR, B_ANAPAR_ADCCLK, 0x1);
+
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK1, B_ADDCK1, 0x0);
+	dack->addck_d[1][0] =
+		rtw89_phy_read32_mask(rtwdev, R_ADDCKR1, B_ADDCKR1_A0);
+	dack->addck_d[1][1] =
+		rtw89_phy_read32_mask(rtwdev, R_ADDCKR1, B_ADDCKR1_A1);
+
+	rtw89_phy_write32_mask(rtwdev, R_P1_DBGMOD, B_P1_DBGMOD_ON, 0x0);
+}
+
+static void _addck_reload(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0_RL, B_ADDCK0_RL1, dack->addck_d[0][0]);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0_RL, B_ADDCK0_RL0, dack->addck_d[0][1]);
+
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0_RL, B_ADDCK0_RLS, 0x3);
+
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK1_RL, B_ADDCK1_RL1, dack->addck_d[1][0]);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK1_RL, B_ADDCK1_RL0, dack->addck_d[1][1]);
+
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK1_RL, B_ADDCK1_RLS, 0x3);
+}
+
+static void _dack_manual_off(struct rtw89_dev *rtwdev)
+{
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK0_RL, B_ADDCK0_RLS, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_ADDCK1_RL, B_ADDCK1_RLS, 0x0);
+
+	rtw89_phy_write32_mask(rtwdev, R_DACKN0_CTL, B_DACKN0_EN, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_DACKN1_CTL, B_DACKN1_ON, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_DACKN2_CTL, B_DACKN2_ON, 0x0);
+	rtw89_phy_write32_mask(rtwdev, R_DACKN3_CTL, B_DACKN3_ON, 0x0);
+}
+
+static void _dac_cal(struct rtw89_dev *rtwdev, bool force)
+{
+	struct rtw89_dack_info *dack = &rtwdev->dack;
+
+	dack->dack_done = false;
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK start!!!\n");
+
+	_drck(rtwdev);
+	_dack_manual_off(rtwdev);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RSV1, RFREG_MASK, 0x0);
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_RSV1, RFREG_MASK, 0x0);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MOD, RFREG_MASK, 0x337e1);
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_MOD, RFREG_MASK, 0x337e1);
+	_rxck_force(rtwdev, RF_PATH_A, true, ADC_960M);
+	_rxck_force(rtwdev, RF_PATH_B, true, ADC_960M);
+	_addck_ori(rtwdev);
+
+	_rxck_force(rtwdev, RF_PATH_A, false, ADC_960M);
+	_rxck_force(rtwdev, RF_PATH_B, false, ADC_960M);
+	_addck_reload(rtwdev);
+
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_MODOPT, RFREG_MASK, 0x0);
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_MODOPT, RFREG_MASK, 0x0);
+
+	_dack(rtwdev);
+	_dack_dump(rtwdev);
+	dack->dack_done = true;
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_RSV1, RFREG_MASK, 0x1);
+	rtw89_write_rf(rtwdev, RF_PATH_B, RR_RSV1, RFREG_MASK, 0x1);
+
+	dack->dack_cnt++;
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK finish!!!\n");
+}
+
 static bool _iqk_check_cal(struct rtw89_dev *rtwdev, u8 path, u8 ktype)
 {
 	bool notready = false;
@@ -3312,6 +3790,15 @@ void rtw8852bt_dpk_init(struct rtw89_dev *rtwdev)
 	_set_dpd_backoff(rtwdev, RTW89_PHY_0);
 }
 
+void rtw8852bt_dack(struct rtw89_dev *rtwdev)
+{
+	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0);
+
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DACK, BTC_WRFK_START);
+	_dac_cal(rtwdev, false);
+	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DACK, BTC_WRFK_STOP);
+}
+
 void rtw8852bt_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
index 3ac63a2a63f7..772a5b099377 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
@@ -7,6 +7,7 @@
 
 #include "core.h"
 
+void rtw8852bt_dack(struct rtw89_dev *rtwdev);
 void rtw8852bt_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 void rtw8852bt_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
 void rtw8852bt_dpk_init(struct rtw89_dev *rtwdev);
-- 
2.25.1


