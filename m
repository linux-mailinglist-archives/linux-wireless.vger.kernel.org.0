Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A375ED828
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 10:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiI1Ir5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 04:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbiI1IrD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 04:47:03 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E06C1E72A
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 01:44:42 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28S8i9Gf9013415, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28S8i9Gf9013415
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 28 Sep 2022 16:44:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 16:44:34 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 28 Sep
 2022 16:44:33 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/9] wifi: rtw89: 8852b: add chip_ops::set_txpwr
Date:   Wed, 28 Sep 2022 16:43:33 +0800
Message-ID: <20220928084336.34981-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928084336.34981-1-pkshih@realtek.com>
References: <20220928084336.34981-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 09/28/2022 08:30:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzkvMjggpFekyCAwNzowMzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This chip_ops is to set TX power according to country, channel, rate and
so on.  Since shared code is used to configure TX power, we only implement
specific part in this patch.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c      |   1 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   5 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 200 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/rtw8852b.h |  13 ++
 4 files changed, 218 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852b.h

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 0508dfca8edf7..878c33fa30bdc 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4819,6 +4819,7 @@ int rtw89_mac_read_xtal_si(struct rtw89_dev *rtwdev, u8 offset, u8 *val)
 
 	return 0;
 }
+EXPORT_SYMBOL(rtw89_mac_read_xtal_si);
 
 static
 void rtw89_mac_pkt_drop_sta(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta)
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index ca20bb024b407..6809ff812abb7 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -2991,6 +2991,7 @@
 
 #define R_AX_PWR_RATE_CTRL 0xD200
 #define R_AX_PWR_RATE_CTRL_C1 0xF200
+#define B_AX_PWR_REF GENMASK(27, 10)
 #define B_AX_FORCE_PWR_BY_RATE_EN BIT(9)
 #define B_AX_FORCE_PWR_BY_RATE_VALUE_MASK GENMASK(8, 0)
 
@@ -3770,6 +3771,7 @@
 #define B_DCFO_WEIGHT_MSK GENMASK(27, 24)
 #define R_DCFO_OPT 0x4494
 #define B_DCFO_OPT_EN BIT(29)
+#define B_TXSHAPE_TRIANGULAR_CFG GENMASK(25, 24)
 #define R_BANDEDGE 0x4498
 #define B_BANDEDGE_EN BIT(30)
 #define R_TXPATH_SEL 0x458C
@@ -4003,6 +4005,9 @@
 #define B_TXPWRB_VAL GENMASK(27, 19)
 #define R_DPD_OFT_EN 0x5800
 #define B_DPD_OFT_EN BIT(28)
+#define B_DPD_TSSI_CW GENMASK(26, 18)
+#define B_DPD_PWR_CW GENMASK(17, 9)
+#define B_DPD_REF GENMASK(8, 0)
 #define R_DPD_OFT_ADDR 0x5804
 #define B_DPD_OFT_ADDR GENMASK(31, 27)
 #define R_TXPWRB_H 0x580c
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 9f9908418ee4e..ec6833080b80a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2,9 +2,14 @@
 /* Copyright(c) 2019-2022  Realtek Corporation
  */
 
-#include "core.h"
+#include "coex.h"
+#include "fw.h"
 #include "mac.h"
+#include "phy.h"
 #include "reg.h"
+#include "rtw8852b.h"
+#include "rtw8852b_table.h"
+#include "txrx.h"
 
 static const struct rtw89_dle_mem rtw8852b_dle_mem_pcie[] = {
 	[RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size6,
@@ -19,6 +24,195 @@ static const struct rtw89_dle_mem rtw8852b_dle_mem_pcie[] = {
 			       NULL},
 };
 
+static u32 rtw8852b_bb_cal_txpwr_ref(struct rtw89_dev *rtwdev,
+				     enum rtw89_phy_idx phy_idx, s16 ref)
+{
+	const u16 tssi_16dbm_cw = 0x12c;
+	const u8 base_cw_0db = 0x27;
+	const s8 ofst_int = 0;
+	s16 pwr_s10_3;
+	s16 rf_pwr_cw;
+	u16 bb_pwr_cw;
+	u32 pwr_cw;
+	u32 tssi_ofst_cw;
+
+	pwr_s10_3 = (ref << 1) + (s16)(ofst_int) + (s16)(base_cw_0db << 3);
+	bb_pwr_cw = FIELD_GET(GENMASK(2, 0), pwr_s10_3);
+	rf_pwr_cw = FIELD_GET(GENMASK(8, 3), pwr_s10_3);
+	rf_pwr_cw = clamp_t(s16, rf_pwr_cw, 15, 63);
+	pwr_cw = (rf_pwr_cw << 3) | bb_pwr_cw;
+
+	tssi_ofst_cw = (u32)((s16)tssi_16dbm_cw + (ref << 1) - (16 << 3));
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
+		    "[TXPWR] tssi_ofst_cw=%d rf_cw=0x%x bb_cw=0x%x\n",
+		    tssi_ofst_cw, rf_pwr_cw, bb_pwr_cw);
+
+	return FIELD_PREP(B_DPD_TSSI_CW, tssi_ofst_cw) |
+	       FIELD_PREP(B_DPD_PWR_CW, pwr_cw) |
+	       FIELD_PREP(B_DPD_REF, ref);
+}
+
+static void rtw8852b_set_txpwr_ref(struct rtw89_dev *rtwdev,
+				   enum rtw89_phy_idx phy_idx)
+{
+	static const u32 addr[RF_PATH_NUM_8852B] = {0x5800, 0x7800};
+	const u32 mask = B_DPD_TSSI_CW | B_DPD_PWR_CW | B_DPD_REF;
+	const u8 ofst_ofdm = 0x4;
+	const u8 ofst_cck = 0x8;
+	const s16 ref_ofdm = 0;
+	const s16 ref_cck = 0;
+	u32 val;
+	u8 i;
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set txpwr reference\n");
+
+	rtw89_mac_txpwr_write32_mask(rtwdev, phy_idx, R_AX_PWR_RATE_CTRL,
+				     B_AX_PWR_REF, 0x0);
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set bb ofdm txpwr ref\n");
+	val = rtw8852b_bb_cal_txpwr_ref(rtwdev, phy_idx, ref_ofdm);
+
+	for (i = 0; i < RF_PATH_NUM_8852B; i++)
+		rtw89_phy_write32_idx(rtwdev, addr[i] + ofst_ofdm, mask, val,
+				      phy_idx);
+
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set bb cck txpwr ref\n");
+	val = rtw8852b_bb_cal_txpwr_ref(rtwdev, phy_idx, ref_cck);
+
+	for (i = 0; i < RF_PATH_NUM_8852B; i++)
+		rtw89_phy_write32_idx(rtwdev, addr[i] + ofst_cck, mask, val,
+				      phy_idx);
+}
+
+static void rtw8852b_bb_set_tx_shape_dfir(struct rtw89_dev *rtwdev,
+					  u8 tx_shape_idx,
+					  enum rtw89_phy_idx phy_idx)
+{
+#define __DFIR_CFG_ADDR(i) (R_TXFIR0 + ((i) << 2))
+#define __DFIR_CFG_MASK 0xffffffff
+#define __DFIR_CFG_NR 8
+#define __DECL_DFIR_PARAM(_name, _val...) \
+	static const u32 param_ ## _name[] = {_val}; \
+	static_assert(ARRAY_SIZE(param_ ## _name) == __DFIR_CFG_NR)
+
+	__DECL_DFIR_PARAM(flat,
+			  0x023D23FF, 0x0029B354, 0x000FC1C8, 0x00FDB053,
+			  0x00F86F9A, 0x06FAEF92, 0x00FE5FCC, 0x00FFDFF5);
+	__DECL_DFIR_PARAM(sharp,
+			  0x023D83FF, 0x002C636A, 0x0013F204, 0x00008090,
+			  0x00F87FB0, 0x06F99F83, 0x00FDBFBA, 0x00003FF5);
+	__DECL_DFIR_PARAM(sharp_14,
+			  0x023B13FF, 0x001C42DE, 0x00FDB0AD, 0x00F60F6E,
+			  0x00FD8F92, 0x0602D011, 0x0001C02C, 0x00FFF00A);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	u8 ch = chan->channel;
+	const u32 *param;
+	u32 addr;
+	int i;
+
+	if (ch > 14) {
+		rtw89_warn(rtwdev,
+			   "set tx shape dfir by unknown ch: %d on 2G\n", ch);
+		return;
+	}
+
+	if (ch == 14)
+		param = param_sharp_14;
+	else
+		param = tx_shape_idx == 0 ? param_flat : param_sharp;
+
+	for (i = 0; i < __DFIR_CFG_NR; i++) {
+		addr = __DFIR_CFG_ADDR(i);
+		rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
+			    "set tx shape dfir: 0x%x: 0x%x\n", addr, param[i]);
+		rtw89_phy_write32_idx(rtwdev, addr, __DFIR_CFG_MASK, param[i],
+				      phy_idx);
+	}
+
+#undef __DECL_DFIR_PARAM
+#undef __DFIR_CFG_NR
+#undef __DFIR_CFG_MASK
+#undef __DECL_CFG_ADDR
+}
+
+static void rtw8852b_set_tx_shape(struct rtw89_dev *rtwdev,
+				  const struct rtw89_chan *chan,
+				  enum rtw89_phy_idx phy_idx)
+{
+	u8 band = chan->band_type;
+	u8 regd = rtw89_regd_get(rtwdev, band);
+	u8 tx_shape_cck = rtw89_8852b_tx_shape[band][RTW89_RS_CCK][regd];
+	u8 tx_shape_ofdm = rtw89_8852b_tx_shape[band][RTW89_RS_OFDM][regd];
+
+	if (band == RTW89_BAND_2G)
+		rtw8852b_bb_set_tx_shape_dfir(rtwdev, tx_shape_cck, phy_idx);
+
+	rtw89_phy_write32_mask(rtwdev, R_DCFO_OPT, B_TXSHAPE_TRIANGULAR_CFG,
+			       tx_shape_ofdm);
+}
+
+static void rtw8852b_set_txpwr(struct rtw89_dev *rtwdev,
+			       const struct rtw89_chan *chan,
+			       enum rtw89_phy_idx phy_idx)
+{
+	rtw89_phy_set_txpwr_byrate(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_offset(rtwdev, chan, phy_idx);
+	rtw8852b_set_tx_shape(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_limit(rtwdev, chan, phy_idx);
+	rtw89_phy_set_txpwr_limit_ru(rtwdev, chan, phy_idx);
+}
+
+static void rtw8852b_set_txpwr_ctrl(struct rtw89_dev *rtwdev,
+				    enum rtw89_phy_idx phy_idx)
+{
+	rtw8852b_set_txpwr_ref(rtwdev, phy_idx);
+}
+
+static
+void rtw8852b_set_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
+				     s8 pw_ofst, enum rtw89_mac_idx mac_idx)
+{
+	u32 reg;
+
+	if (pw_ofst < -16 || pw_ofst > 15) {
+		rtw89_warn(rtwdev, "[ULTB] Err pwr_offset=%d\n", pw_ofst);
+		return;
+	}
+
+	reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_CTRL, mac_idx);
+	rtw89_write32_set(rtwdev, reg, B_AX_PWR_UL_TB_CTRL_EN);
+
+	reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_1T, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_AX_PWR_UL_TB_1T_MASK, pw_ofst);
+
+	pw_ofst = max_t(s8, pw_ofst - 3, -16);
+	reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_2T, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_AX_PWR_UL_TB_1T_MASK, pw_ofst);
+}
+
+static int
+rtw8852b_init_txpwr_unit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+{
+	int ret;
+
+	ret = rtw89_mac_txpwr_write32(rtwdev, phy_idx, R_AX_PWR_UL_CTRL2, 0x07763333);
+	if (ret)
+		return ret;
+
+	ret = rtw89_mac_txpwr_write32(rtwdev, phy_idx, R_AX_PWR_COEXT_CTRL, 0x01ebf000);
+	if (ret)
+		return ret;
+
+	ret = rtw89_mac_txpwr_write32(rtwdev, phy_idx, R_AX_PWR_UL_CTRL0, 0x0002f8ff);
+	if (ret)
+		return ret;
+
+	rtw8852b_set_txpwr_ul_tb_offset(rtwdev, 0, phy_idx == RTW89_PHY_1 ?
+						   RTW89_MAC_1 : RTW89_MAC_0);
+
+	return 0;
+}
+
 static int rtw8852b_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
 {
 	int ret;
@@ -75,10 +269,14 @@ static int rtw8852b_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
 static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.enable_bb_rf		= rtw8852b_mac_enable_bb_rf,
 	.disable_bb_rf		= rtw8852b_mac_disable_bb_rf,
+	.set_txpwr		= rtw8852b_set_txpwr,
+	.set_txpwr_ctrl		= rtw8852b_set_txpwr_ctrl,
+	.init_txpwr_unit	= rtw8852b_init_txpwr_unit,
 };
 
 const struct rtw89_chip_info rtw8852b_chip_info = {
 	.chip_id		= RTL8852B,
+	.ops			= &rtw8852b_chip_ops,
 	.fifo_size		= 196608,
 	.dle_scc_rsvd_size	= 98304,
 	.dle_mem		= rtw8852b_dle_mem_pcie,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.h b/drivers/net/wireless/realtek/rtw89/rtw8852b.h
new file mode 100644
index 0000000000000..a5ff269752a30
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2019-2022  Realtek Corporation
+ */
+
+#ifndef __RTW89_8852B_H__
+#define __RTW89_8852B_H__
+
+#include "core.h"
+
+#define RF_PATH_NUM_8852B 2
+#define BB_PATH_NUM_8852B 2
+
+#endif
-- 
2.25.1

