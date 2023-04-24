Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FB26EC68F
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Apr 2023 08:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjDXGxU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Apr 2023 02:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjDXGxR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Apr 2023 02:53:17 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D77211A
        for <linux-wireless@vger.kernel.org>; Sun, 23 Apr 2023 23:53:15 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33O6r6Rr9029968, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33O6r6Rr9029968
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 24 Apr 2023 14:53:07 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 24 Apr 2023 14:53:08 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 24 Apr
 2023 14:53:07 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/5] wifi: rtw89: 8851b: add set_channel_rf()
Date:   Mon, 24 Apr 2023 14:52:38 +0800
Message-ID: <20230424065242.17477-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230424065242.17477-1-pkshih@realtek.com>
References: <20230424065242.17477-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add to set RF registers according to the channel we want to switch. The
callers will be added afterward.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c | 239 ++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.h |  14 +
 2 files changed, 253 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
new file mode 100644
index 0000000000000..9276e852bb051
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2022-2023  Realtek Corporation
+ */
+
+#include "coex.h"
+#include "debug.h"
+#include "mac.h"
+#include "phy.h"
+#include "reg.h"
+#include "rtw8851b.h"
+#include "rtw8851b_rfk.h"
+#include "rtw8851b_rfk_table.h"
+#include "rtw8851b_table.h"
+
+static u8 _kpath(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	return RF_A;
+}
+
+static void _bw_setting(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
+			enum rtw89_bandwidth bw, bool dav)
+{
+	u32 reg18_addr = dav ? RR_CFGCH : RR_CFGCH_V1;
+	u32 rf_reg18;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK]===> %s\n", __func__);
+
+	rf_reg18 = rtw89_read_rf(rtwdev, path, reg18_addr, RFREG_MASK);
+	if (rf_reg18 == INV_RF_DATA) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[RFK]Invalid RF_0x18 for Path-%d\n", path);
+		return;
+	}
+	rf_reg18 &= ~RR_CFGCH_BW;
+
+	switch (bw) {
+	case RTW89_CHANNEL_WIDTH_5:
+	case RTW89_CHANNEL_WIDTH_10:
+	case RTW89_CHANNEL_WIDTH_20:
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BW, CFGCH_BW_20M);
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BW, CFGCH_BW_40M);
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BW, CFGCH_BW_80M);
+		break;
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK]Fail to set CH\n");
+	}
+
+	rf_reg18 &= ~(RR_CFGCH_POW_LCK | RR_CFGCH_TRX_AH | RR_CFGCH_BCN |
+		      RR_CFGCH_BW2) & RFREG_MASK;
+	rf_reg18 |= RR_CFGCH_BW2;
+	rtw89_write_rf(rtwdev, path, reg18_addr, RFREG_MASK, rf_reg18);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK] set %x at path%d, %x =0x%x\n",
+		    bw, path, reg18_addr,
+		    rtw89_read_rf(rtwdev, path, reg18_addr, RFREG_MASK));
+}
+
+static void _ctrl_bw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		     enum rtw89_bandwidth bw)
+{
+	_bw_setting(rtwdev, RF_PATH_A, bw, true);
+	_bw_setting(rtwdev, RF_PATH_A, bw, false);
+}
+
+static bool _set_s0_arfc18(struct rtw89_dev *rtwdev, u32 val)
+{
+	u32 bak;
+	u32 tmp;
+	int ret;
+
+	bak = rtw89_read_rf(rtwdev, RF_PATH_A, RR_LDO, RFREG_MASK);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LDO, RR_LDO_SEL, 0x1);
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_CFGCH, RFREG_MASK, val);
+
+	ret = read_poll_timeout_atomic(rtw89_read_rf, tmp, tmp == 0, 1, 1000,
+				       false, rtwdev, RF_PATH_A, RR_LPF, RR_LPF_BUSY);
+	if (ret)
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[LCK]LCK timeout\n");
+
+	rtw89_write_rf(rtwdev, RF_PATH_A, RR_LDO, RFREG_MASK, bak);
+
+	return !!ret;
+}
+
+static void _lck_check(struct rtw89_dev *rtwdev)
+{
+	u32 tmp;
+
+	if (rtw89_read_rf(rtwdev, RF_PATH_A, RR_SYNFB, RR_SYNFB_LK) == 0) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[LCK]SYN MMD reset\n");
+
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MMD, RR_MMD_RST_EN, 0x1);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MMD, RR_MMD_RST_SYN, 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MMD, RR_MMD_RST_SYN, 0x1);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_MMD, RR_MMD_RST_EN, 0x0);
+	}
+
+	udelay(10);
+
+	if (rtw89_read_rf(rtwdev, RF_PATH_A, RR_SYNFB, RR_SYNFB_LK) == 0) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[LCK]re-set RF 0x18\n");
+
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LCK_TRG, RR_LCK_TRGSEL, 0x1);
+		tmp = rtw89_read_rf(rtwdev, RF_PATH_A, RR_CFGCH, RFREG_MASK);
+		_set_s0_arfc18(rtwdev, tmp);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LCK_TRG, RR_LCK_TRGSEL, 0x0);
+	}
+
+	if (rtw89_read_rf(rtwdev, RF_PATH_A, RR_SYNFB, RR_SYNFB_LK) == 0) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[LCK]SYN off/on\n");
+
+		tmp = rtw89_read_rf(rtwdev, RF_PATH_A, RR_POW, RFREG_MASK);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RFREG_MASK, tmp);
+		tmp = rtw89_read_rf(rtwdev, RF_PATH_A, RR_SX, RFREG_MASK);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_SX, RFREG_MASK, tmp);
+
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_SYNLUT, RR_SYNLUT_MOD, 0x1);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN, 0x0);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_POW, RR_POW_SYN, 0x3);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_SYNLUT, RR_SYNLUT_MOD, 0x0);
+
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LCK_TRG, RR_LCK_TRGSEL, 0x1);
+		tmp = rtw89_read_rf(rtwdev, RF_PATH_A, RR_CFGCH, RFREG_MASK);
+		_set_s0_arfc18(rtwdev, tmp);
+		rtw89_write_rf(rtwdev, RF_PATH_A, RR_LCK_TRG, RR_LCK_TRGSEL, 0x0);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK, "[LCK]0xb2=%x, 0xc5=%x\n",
+			    rtw89_read_rf(rtwdev, RF_PATH_A, RR_VCO, RFREG_MASK),
+			    rtw89_read_rf(rtwdev, RF_PATH_A, RR_SYNFB, RFREG_MASK));
+	}
+}
+
+static void _set_ch(struct rtw89_dev *rtwdev, u32 val)
+{
+	bool timeout;
+
+	timeout = _set_s0_arfc18(rtwdev, val);
+	if (!timeout)
+		_lck_check(rtwdev);
+}
+
+static void _ch_setting(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
+			u8 central_ch, bool dav)
+{
+	u32 reg18_addr = dav ? RR_CFGCH : RR_CFGCH_V1;
+	bool is_2g_ch = central_ch <= 14;
+	u32 rf_reg18;
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK]===> %s\n", __func__);
+
+	rf_reg18 = rtw89_read_rf(rtwdev, path, reg18_addr, RFREG_MASK);
+	rf_reg18 &= ~(RR_CFGCH_BAND1 | RR_CFGCH_POW_LCK | RR_CFGCH_TRX_AH |
+		      RR_CFGCH_BCN | RR_CFGCH_BAND0 | RR_CFGCH_CH);
+	rf_reg18 |= FIELD_PREP(RR_CFGCH_CH, central_ch);
+
+	if (!is_2g_ch)
+		rf_reg18 |= FIELD_PREP(RR_CFGCH_BAND1, CFGCH_BAND1_5G) |
+			    FIELD_PREP(RR_CFGCH_BAND0, CFGCH_BAND0_5G);
+
+	rf_reg18 &= ~(RR_CFGCH_POW_LCK | RR_CFGCH_TRX_AH | RR_CFGCH_BCN |
+		      RR_CFGCH_BW2) & RFREG_MASK;
+	rf_reg18 |= RR_CFGCH_BW2;
+
+	if (path == RF_PATH_A && dav)
+		_set_ch(rtwdev, rf_reg18);
+	else
+		rtw89_write_rf(rtwdev, path, reg18_addr, RFREG_MASK, rf_reg18);
+
+	rtw89_write_rf(rtwdev, path, RR_LCKST, RR_LCKST_BIN, 0);
+	rtw89_write_rf(rtwdev, path, RR_LCKST, RR_LCKST_BIN, 1);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK,
+		    "[RFK]CH: %d for Path-%d, reg0x%x = 0x%x\n",
+		    central_ch, path, reg18_addr,
+		    rtw89_read_rf(rtwdev, path, reg18_addr, RFREG_MASK));
+}
+
+static void _ctrl_ch(struct rtw89_dev *rtwdev, u8 central_ch)
+{
+	_ch_setting(rtwdev, RF_PATH_A, central_ch, true);
+	_ch_setting(rtwdev, RF_PATH_A, central_ch, false);
+}
+
+static void _set_rxbb_bw(struct rtw89_dev *rtwdev, enum rtw89_bandwidth bw,
+			 enum rtw89_rf_path path)
+{
+	rtw89_write_rf(rtwdev, path, RR_LUTWE2, RR_LUTWE2_RTXBW, 0x1);
+	rtw89_write_rf(rtwdev, path, RR_LUTWA, RR_LUTWA_M2, 0x12);
+
+	if (bw == RTW89_CHANNEL_WIDTH_20)
+		rtw89_write_rf(rtwdev, path, RR_LUTWD0, RR_LUTWD0_LB, 0x1b);
+	else if (bw == RTW89_CHANNEL_WIDTH_40)
+		rtw89_write_rf(rtwdev, path, RR_LUTWD0, RR_LUTWD0_LB, 0x13);
+	else if (bw == RTW89_CHANNEL_WIDTH_80)
+		rtw89_write_rf(rtwdev, path, RR_LUTWD0, RR_LUTWD0_LB, 0xb);
+	else
+		rtw89_write_rf(rtwdev, path, RR_LUTWD0, RR_LUTWD0_LB, 0x3);
+
+	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[RFK] set S%d RXBB BW 0x3F = 0x%x\n", path,
+		    rtw89_read_rf(rtwdev, path, RR_LUTWD0, RR_LUTWD0_LB));
+
+	rtw89_write_rf(rtwdev, path, RR_LUTWE2, RR_LUTWE2_RTXBW, 0x0);
+}
+
+static void _rxbb_bw(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		     enum rtw89_bandwidth bw)
+{
+	u8 kpath, path;
+
+	kpath = _kpath(rtwdev, phy);
+
+	for (path = 0; path < RF_PATH_NUM_8851B; path++) {
+		if (!(kpath & BIT(path)))
+			continue;
+
+		_set_rxbb_bw(rtwdev, bw, path);
+	}
+}
+
+static void rtw8851b_ctrl_bw_ch(struct rtw89_dev *rtwdev,
+				enum rtw89_phy_idx phy, u8 central_ch,
+				enum rtw89_band band, enum rtw89_bandwidth bw)
+{
+	_ctrl_ch(rtwdev, central_ch);
+	_ctrl_bw(rtwdev, phy, bw);
+	_rxbb_bw(rtwdev, phy, bw);
+}
+
+void rtw8851b_set_channel_rf(struct rtw89_dev *rtwdev,
+			     const struct rtw89_chan *chan,
+			     enum rtw89_phy_idx phy_idx)
+{
+	rtw8851b_ctrl_bw_ch(rtwdev, phy_idx, chan->channel, chan->band_type,
+			    chan->band_width);
+}
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
new file mode 100644
index 0000000000000..c81eb98dcf928
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2022-2023  Realtek Corporation
+ */
+
+#ifndef __RTW89_8851B_RFK_H__
+#define __RTW89_8851B_RFK_H__
+
+#include "core.h"
+
+void rtw8851b_set_channel_rf(struct rtw89_dev *rtwdev,
+			     const struct rtw89_chan *chan,
+			     enum rtw89_phy_idx phy_idx);
+
+#endif
-- 
2.25.1

