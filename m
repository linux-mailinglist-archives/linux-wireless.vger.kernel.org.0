Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488F35005E6
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Apr 2022 08:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbiDNGXp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Apr 2022 02:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240056AbiDNGXk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Apr 2022 02:23:40 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1871C4D277
        for <linux-wireless@vger.kernel.org>; Wed, 13 Apr 2022 23:21:13 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23E6L7Vc8001379, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23E6L7Vc8001379
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Apr 2022 14:21:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 14:21:07 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 14 Apr
 2022 14:21:06 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 09/12] rtw89: 8852c: add set channel function of RF part
Date:   Thu, 14 Apr 2022 14:20:23 +0800
Message-ID: <20220414062027.62638-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414062027.62638-1-pkshih@realtek.com>
References: <20220414062027.62638-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/14/2022 06:05:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMTQgpFekyCAwMzo1OTowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Prepare functions to configure channel and bandwidth accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |  24 ++
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 214 ++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.h |  14 ++
 3 files changed, 252 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index bd5526ffb8dbd..d666c6e2a9dec 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3158,6 +3158,23 @@
 #define RR_DTXLOK 0x08
 #define RR_RSV2 0x09
 #define RR_CFGCH 0x18
+#define RR_CFGCH_V1 0x10018
+#define RR_CFGCH_BAND1 GENMASK(17, 16)
+#define CFGCH_BAND1_2G 0
+#define CFGCH_BAND1_5G 1
+#define CFGCH_BAND1_6G 3
+#define RR_CFGCH_BAND0 GENMASK(9, 8)
+#define CFGCH_BAND0_2G 0
+#define CFGCH_BAND0_5G 1
+#define CFGCH_BAND0_6G 0
+#define RR_CFGCH_BW GENMASK(11, 10)
+#define RR_CFGCH_CH GENMASK(7, 0)
+#define CFGCH_BW_20M 3
+#define CFGCH_BW_40M 2
+#define CFGCH_BW_80M 1
+#define CFGCH_BW_160M 0
+#define RR_APK 0x19
+#define RR_APK_MOD GENMASK(5, 4)
 #define RR_BTC 0x1a
 #define RR_BTC_TXBB GENMASK(14, 12)
 #define RR_BTC_RXBB GENMASK(11, 10)
@@ -3176,8 +3193,10 @@
 #define RR_RXK_SEL2G BIT(8)
 #define RR_LUTWA 0x33
 #define RR_LUTWA_MASK GENMASK(9, 0)
+#define RR_LUTWA_M2 GENMASK(4, 0)
 #define RR_LUTWD1 0x3e
 #define RR_LUTWD0 0x3f
+#define RR_LUTWD0_LB GENMASK(5, 0)
 #define RR_TM 0x42
 #define RR_TM_TRI BIT(19)
 #define RR_TM_VAL GENMASK(6, 1)
@@ -3260,6 +3279,7 @@
 #define RR_LUTDBG 0xdf
 #define RR_LUTDBG_LOK BIT(2)
 #define RR_LUTWE2 0xee
+#define RR_LUTWE2_RTXBW BIT(2)
 #define RR_LUTWE 0xef
 #define RR_LUTWE_LOK BIT(2)
 #define RR_RFC 0xf0
@@ -3856,6 +3876,10 @@
 #define B_IQKINF2_FCNT GENMASK(23, 16)
 #define B_IQKINF2_KCNT GENMASK(15, 8)
 #define B_IQKINF2_NCTLV GENMAKS(7, 0)
+#define R_P0_CFCH_BW0 0xC0D4
+#define B_P0_CFCH_BW0 GENMASK(27, 26)
+#define R_P0_CFCH_BW1 0xC0D8
+#define B_P0_CFCH_BW1 GENMASK(8, 5)
 
 /* WiFi CPU local domain */
 #define R_AX_WDT_CTRL 0x0040
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
new file mode 100644
index 0000000000000..56f0876c03fbd
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2019-2022  Realtek Corporation
+ */
+
+#include "debug.h"
+#include "phy.h"
+#include "reg.h"
+#include "rtw8852c.h"
+#include "rtw8852c_rfk.h"
+
+static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK]dbcc_en: %x,  PHY%d\n",
+		    rtwdev->dbcc_en, phy_idx);
+
+	if (!rtwdev->dbcc_en)
+		return RF_AB;
+
+	if (phy_idx == RTW89_PHY_0)
+		return RF_A;
+	else
+		return RF_B;
+}
+
+static void _bw_setting(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
+			enum rtw89_bandwidth bw, bool is_dav)
+{
+	u32 rf_reg18;
+	u32 reg_reg18_addr;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK]===>%s\n", __func__);
+	if (is_dav)
+		reg_reg18_addr = RR_CFGCH;
+	else
+		reg_reg18_addr = RR_CFGCH_V1;
+
+	rf_reg18 = rtw89_read_rf(rtwdev, path, reg_reg18_addr, RFREG_MASK);
+	rf_reg18 &= ~RR_CFGCH_BW;
+
+	switch (bw) {
+	case RTW89_CHANNEL_WIDTH_5:
+	case RTW89_CHANNEL_WIDTH_10:
+	case RTW89_CHANNEL_WIDTH_20:
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BW, CFGCH_BW_20M);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0 | (path << 8), B_P0_CFCH_BW0, 0x3);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1 | (path << 8), B_P0_CFCH_BW1, 0xf);
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BW, CFGCH_BW_40M);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0 | (path << 8), B_P0_CFCH_BW0, 0x3);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1 | (path << 8), B_P0_CFCH_BW1, 0xf);
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BW, CFGCH_BW_80M);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0 | (path << 8), B_P0_CFCH_BW0, 0x2);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1 | (path << 8), B_P0_CFCH_BW1, 0xd);
+		break;
+	case RTW89_CHANNEL_WIDTH_160:
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BW, CFGCH_BW_160M);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW0 | (path << 8), B_P0_CFCH_BW0, 0x1);
+		rtw89_phy_write32_mask(rtwdev, R_P0_CFCH_BW1 | (path << 8), B_P0_CFCH_BW1, 0xb);
+		break;
+	default:
+		break;
+	}
+
+	rtw89_write_rf(rtwdev, path, reg_reg18_addr, RFREG_MASK, rf_reg18);
+}
+
+static void _ctrl_bw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		     enum rtw89_bandwidth bw)
+{
+	bool is_dav;
+	u8 kpath, path;
+	u32 tmp = 0;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK]===>%s\n", __func__);
+	kpath = _kpath(rtwdev, phy);
+
+	for (path = 0; path < 2; path++) {
+		if (!(kpath & BIT(path)))
+			continue;
+
+		is_dav = true;
+		_bw_setting(rtwdev, path, bw, is_dav);
+		is_dav = false;
+		_bw_setting(rtwdev, path, bw, is_dav);
+		if (rtwdev->dbcc_en)
+			continue;
+
+		if (path == RF_PATH_B && rtwdev->hal.cv == CHIP_CAV) {
+			rtw89_write_rf(rtwdev, RF_PATH_B, RR_RSV1, RR_RSV1_RST, 0x0);
+			tmp = rtw89_read_rf(rtwdev, RF_PATH_A, RR_CFGCH, RFREG_MASK);
+			rtw89_write_rf(rtwdev, RF_PATH_B, RR_APK, RR_APK_MOD, 0x3);
+			rtw89_write_rf(rtwdev, RF_PATH_B, RR_CFGCH, RFREG_MASK, tmp);
+			fsleep(100);
+			rtw89_write_rf(rtwdev, RF_PATH_B, RR_RSV1, RR_RSV1_RST, 0x1);
+		}
+	}
+}
+
+static void _ch_setting(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
+			u8 central_ch, enum rtw89_band band, bool is_dav)
+{
+	u32 rf_reg18;
+	u32 reg_reg18_addr;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK]===>%s\n", __func__);
+	if (is_dav)
+		reg_reg18_addr = 0x18;
+	else
+		reg_reg18_addr = 0x10018;
+
+	rf_reg18 = rtw89_read_rf(rtwdev, path, reg_reg18_addr, RFREG_MASK);
+	rf_reg18 &= ~(RR_CFGCH_BAND1 | RR_CFGCH_BAND0 | RR_CFGCH_CH);
+	rf_reg18 |= FIELD_PREP(RR_CFGCH_CH, central_ch);
+
+	switch (band) {
+	case RTW89_BAND_2G:
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BAND1, CFGCH_BAND1_2G);
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BAND0, CFGCH_BAND0_2G);
+		break;
+	case RTW89_BAND_5G:
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BAND1, CFGCH_BAND1_5G);
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BAND0, CFGCH_BAND0_5G);
+		break;
+	case RTW89_BAND_6G:
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BAND1, CFGCH_BAND1_6G);
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BAND0, CFGCH_BAND0_6G);
+		break;
+	default:
+		break;
+	}
+	rtw89_write_rf(rtwdev, path, reg_reg18_addr, RFREG_MASK, rf_reg18);
+	fsleep(100);
+}
+
+static void _ctrl_ch(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		     u8 central_ch, enum rtw89_band band)
+{
+	u8 kpath, path;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK]===>%s\n", __func__);
+	if (band != RTW89_BAND_6G) {
+		if ((central_ch > 14 && central_ch < 36) ||
+		    (central_ch > 64 && central_ch < 100) ||
+		    (central_ch > 144 && central_ch < 149) || central_ch > 177)
+			return;
+	} else {
+		if (central_ch > 253 || central_ch  == 2)
+			return;
+	}
+
+	kpath = _kpath(rtwdev, phy);
+
+	for (path = 0; path < 2; path++) {
+		if (kpath & BIT(path)) {
+			_ch_setting(rtwdev, path, central_ch, band, true);
+			_ch_setting(rtwdev, path, central_ch, band, false);
+		}
+	}
+}
+
+static void _rxbb_bw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		     enum rtw89_bandwidth bw)
+{
+	u8 kpath;
+	u8 path;
+	u32 val;
+
+	kpath = _kpath(rtwdev, phy);
+	for (path = 0; path < 2; path++) {
+		if (!(kpath & BIT(path)))
+			continue;
+
+		rtw89_write_rf(rtwdev, path, RR_LUTWE2, RR_LUTWE2_RTXBW, 0x1);
+		rtw89_write_rf(rtwdev, path, RR_LUTWA, RR_LUTWA_M2, 0xa);
+		switch (bw) {
+		case RTW89_CHANNEL_WIDTH_20:
+			val = 0x1b;
+			break;
+		case RTW89_CHANNEL_WIDTH_40:
+			val = 0x13;
+			break;
+		case RTW89_CHANNEL_WIDTH_80:
+			val = 0xb;
+			break;
+		case RTW89_CHANNEL_WIDTH_160:
+		default:
+			val = 0x3;
+			break;
+		}
+		rtw89_write_rf(rtwdev, path, RR_LUTWD0, RR_LUTWD0_LB, val);
+		rtw89_write_rf(rtwdev, path, RR_LUTWE2, RR_LUTWE2_RTXBW, 0x0);
+	}
+}
+
+static
+void rtw8852c_ctrl_bw_ch(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			 u8 central_ch, enum rtw89_band band,
+			 enum rtw89_bandwidth bw)
+{
+	_ctrl_ch(rtwdev, phy, central_ch, band);
+	_ctrl_bw(rtwdev, phy, bw);
+	_rxbb_bw(rtwdev, phy, bw);
+}
+
+void rtw8852c_set_channel_rf(struct rtw89_dev *rtwdev,
+			     struct rtw89_channel_params *param,
+			     enum rtw89_phy_idx phy_idx)
+{
+	rtw8852c_ctrl_bw_ch(rtwdev, phy_idx, param->center_chan, param->band_type,
+			    param->bandwidth);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
new file mode 100644
index 0000000000000..0e75555c1612d
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2019-2022  Realtek Corporation
+ */
+
+#ifndef __RTW89_8852C_RFK_H__
+#define __RTW89_8852C_RFK_H__
+
+#include "core.h"
+
+void rtw8852c_set_channel_rf(struct rtw89_dev *rtwdev,
+			     struct rtw89_channel_params *param,
+			     enum rtw89_phy_idx phy_idx);
+
+#endif
-- 
2.25.1

