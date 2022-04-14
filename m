Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907555005E7
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Apr 2022 08:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbiDNGXf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Apr 2022 02:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240018AbiDNGXc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Apr 2022 02:23:32 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFA14BFFC
        for <linux-wireless@vger.kernel.org>; Wed, 13 Apr 2022 23:21:07 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23E6L0FC0001344, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23E6L0FC0001344
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Apr 2022 14:21:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 14:21:00 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 14 Apr
 2022 14:20:59 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 04/12] rtw89: 8852c: phy: configure TSSI bandedge
Date:   Thu, 14 Apr 2022 14:20:18 +0800
Message-ID: <20220414062027.62638-5-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

TSSI is used to manage TX power with thermal value as a factor. This patch
is to configure bandedge to TX proper waveform.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |   1 +
 drivers/net/wireless/realtek/rtw89/phy.c      | 106 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h      |  36 ++++++
 drivers/net/wireless/realtek/rtw89/reg.h      |   5 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 .../wireless/realtek/rtw89/rtw8852c_table.c   |   7 ++
 .../wireless/realtek/rtw89/rtw8852c_table.h   |   1 +
 8 files changed, 158 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1dd558d89567f..fd6b17b6498b9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2380,6 +2380,7 @@ struct rtw89_chip_info {
 	const struct rtw89_phy_table *nctl_table;
 	const struct rtw89_txpwr_table *byr_table;
 	const struct rtw89_phy_dig_gain_table *dig_table;
+	const struct rtw89_phy_tssi_dbw_table *tssi_dbw_table;
 	const s8 (*txpwr_lmt_2g)[RTW89_2G_BW_NUM][RTW89_NTX_NUM]
 				[RTW89_RS_LMT_NUM][RTW89_BF_NUM]
 				[RTW89_REGD_NUM][RTW89_2G_CH_NUM];
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index eed6dbd0d5dbc..aff03261ab727 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3420,3 +3420,109 @@ rtw89_rfk_parser(struct rtw89_dev *rtwdev, const struct rtw89_rfk_tbl *tbl)
 		_rfk_handler[p->flag](rtwdev, p);
 }
 EXPORT_SYMBOL(rtw89_rfk_parser);
+
+#define RTW89_TSSI_FAST_MODE_NUM 4
+
+static const struct rtw89_reg_def rtw89_tssi_fastmode_regs_flat[RTW89_TSSI_FAST_MODE_NUM] = {
+	{0xD934, 0xff0000},
+	{0xD934, 0xff000000},
+	{0xD938, 0xff},
+	{0xD934, 0xff00},
+};
+
+static const struct rtw89_reg_def rtw89_tssi_fastmode_regs_level[RTW89_TSSI_FAST_MODE_NUM] = {
+	{0xD930, 0xff0000},
+	{0xD930, 0xff000000},
+	{0xD934, 0xff},
+	{0xD930, 0xff00},
+};
+
+static
+void rtw89_phy_tssi_ctrl_set_fast_mode_cfg(struct rtw89_dev *rtwdev,
+					   enum rtw89_mac_idx mac_idx,
+					   enum rtw89_tssi_bandedge_cfg bandedge_cfg,
+					   u32 val)
+{
+	const struct rtw89_reg_def *regs;
+	u32 reg;
+	int i;
+
+	if (bandedge_cfg == RTW89_TSSI_BANDEDGE_FLAT)
+		regs = rtw89_tssi_fastmode_regs_flat;
+	else
+		regs = rtw89_tssi_fastmode_regs_level;
+
+	for (i = 0; i < RTW89_TSSI_FAST_MODE_NUM; i++) {
+		reg = rtw89_mac_reg_by_idx(regs[i].addr, mac_idx);
+		rtw89_write32_mask(rtwdev, reg, regs[i].mask, val);
+	}
+}
+
+static const struct rtw89_reg_def rtw89_tssi_bandedge_regs_flat[RTW89_TSSI_SBW_NUM] = {
+	{0xD91C, 0xff000000},
+	{0xD920, 0xff},
+	{0xD920, 0xff00},
+	{0xD920, 0xff0000},
+	{0xD920, 0xff000000},
+	{0xD924, 0xff},
+	{0xD924, 0xff00},
+	{0xD914, 0xff000000},
+	{0xD918, 0xff},
+	{0xD918, 0xff00},
+	{0xD918, 0xff0000},
+	{0xD918, 0xff000000},
+	{0xD91C, 0xff},
+	{0xD91C, 0xff00},
+	{0xD91C, 0xff0000},
+};
+
+static const struct rtw89_reg_def rtw89_tssi_bandedge_regs_level[RTW89_TSSI_SBW_NUM] = {
+	{0xD910, 0xff},
+	{0xD910, 0xff00},
+	{0xD910, 0xff0000},
+	{0xD910, 0xff000000},
+	{0xD914, 0xff},
+	{0xD914, 0xff00},
+	{0xD914, 0xff0000},
+	{0xD908, 0xff},
+	{0xD908, 0xff00},
+	{0xD908, 0xff0000},
+	{0xD908, 0xff000000},
+	{0xD90C, 0xff},
+	{0xD90C, 0xff00},
+	{0xD90C, 0xff0000},
+	{0xD90C, 0xff000000},
+};
+
+void rtw89_phy_tssi_ctrl_set_bandedge_cfg(struct rtw89_dev *rtwdev,
+					  enum rtw89_mac_idx mac_idx,
+					  enum rtw89_tssi_bandedge_cfg bandedge_cfg)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_reg_def *regs;
+	const u32 *data;
+	u32 reg;
+	int i;
+
+	if (bandedge_cfg >= RTW89_TSSI_CFG_NUM)
+		return;
+
+	if (bandedge_cfg == RTW89_TSSI_BANDEDGE_FLAT)
+		regs = rtw89_tssi_bandedge_regs_flat;
+	else
+		regs = rtw89_tssi_bandedge_regs_level;
+
+	data = chip->tssi_dbw_table->data[bandedge_cfg];
+
+	for (i = 0; i < RTW89_TSSI_SBW_NUM; i++) {
+		reg = rtw89_mac_reg_by_idx(regs[i].addr, mac_idx);
+		rtw89_write32_mask(rtwdev, reg, regs[i].mask, data[i]);
+	}
+
+	reg = rtw89_mac_reg_by_idx(R_AX_BANDEDGE_CFG, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_AX_BANDEDGE_CFG_IDX_MASK, bandedge_cfg);
+
+	rtw89_phy_tssi_ctrl_set_fast_mode_cfg(rtwdev, mac_idx, bandedge_cfg,
+					      data[RTW89_TSSI_SBW20]);
+}
+EXPORT_SYMBOL(rtw89_phy_tssi_ctrl_set_bandedge_cfg);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 9c97e77d97072..b8531bb7e606e 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -221,6 +221,35 @@ enum rtw89_dig_gain_tia_idx {
 	RTW89_DIG_GAIN_TIA_IDX1 = 1
 };
 
+enum rtw89_tssi_bandedge_cfg {
+	RTW89_TSSI_BANDEDGE_FLAT,
+	RTW89_TSSI_BANDEDGE_LOW,
+	RTW89_TSSI_BANDEDGE_MID,
+	RTW89_TSSI_BANDEDGE_HIGH,
+
+	RTW89_TSSI_CFG_NUM,
+};
+
+enum rtw89_tssi_sbw_idx {
+	RTW89_TSSI_SBW20,
+	RTW89_TSSI_SBW40_0,
+	RTW89_TSSI_SBW40_1,
+	RTW89_TSSI_SBW80_0,
+	RTW89_TSSI_SBW80_1,
+	RTW89_TSSI_SBW80_2,
+	RTW89_TSSI_SBW80_3,
+	RTW89_TSSI_SBW160_0,
+	RTW89_TSSI_SBW160_1,
+	RTW89_TSSI_SBW160_2,
+	RTW89_TSSI_SBW160_3,
+	RTW89_TSSI_SBW160_4,
+	RTW89_TSSI_SBW160_5,
+	RTW89_TSSI_SBW160_6,
+	RTW89_TSSI_SBW160_7,
+
+	RTW89_TSSI_SBW_NUM,
+};
+
 struct rtw89_txpwr_byrate_cfg {
 	enum rtw89_band band;
 	enum rtw89_nss nss;
@@ -263,6 +292,10 @@ struct rtw89_phy_dig_gain_table {
 	const struct rtw89_phy_dig_gain_cfg *cfg_tia_a;
 };
 
+struct rtw89_phy_tssi_dbw_table {
+	u32 data[RTW89_TSSI_CFG_NUM][RTW89_TSSI_SBW_NUM];
+};
+
 struct rtw89_phy_reg3_tbl {
 	const struct rtw89_reg3_def *reg3;
 	int size;
@@ -446,5 +479,8 @@ void rtw89_phy_set_phy_regs(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 void rtw89_phy_dig_reset(struct rtw89_dev *rtwdev);
 void rtw89_phy_dig(struct rtw89_dev *rtwdev);
 void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif);
+void rtw89_phy_tssi_ctrl_set_bandedge_cfg(struct rtw89_dev *rtwdev,
+					  enum rtw89_mac_idx mac_idx,
+					  enum rtw89_tssi_bandedge_cfg bandedge_cfg);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 98465d7469898..cd7916085e007 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -2958,6 +2958,11 @@
 #define R_AX_PWR_MACID_LMT_TABLE0 0xD36C
 #define R_AX_PWR_MACID_LMT_TABLE127 0xD568
 
+#define R_AX_TSSI_CTRL_HEAD 0xD908
+#define R_AX_BANDEDGE_CFG 0xD94C
+#define B_AX_BANDEDGE_CFG_IDX_MASK GENMASK(31, 30)
+#define R_AX_TSSI_CTRL_TAIL 0xD95C
+
 #define R_AX_TXPWR_IMR 0xD9E0
 #define R_AX_TXPWR_IMR_C1 0xF9E0
 #define R_AX_TXPWR_ISR 0xD9E4
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 2c5bd381ebf58..cb93287d47222 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2113,6 +2113,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.txpwr_factor_rf	= 2,
 	.txpwr_factor_mac	= 1,
 	.dig_table		= &rtw89_8852a_phy_dig_table,
+	.tssi_dbw_table		= NULL,
 	.support_bands		= BIT(NL80211_BAND_2GHZ) |
 				  BIT(NL80211_BAND_5GHZ),
 	.support_bw160		= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 3f727dd420640..1b5f8da2e9e85 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -674,6 +674,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.txpwr_factor_rf	= 2,
 	.txpwr_factor_mac	= 1,
 	.dig_table		= NULL,
+	.tssi_dbw_table		= &rtw89_8852c_tssi_dbw_table,
 	.hw_sec_hdr		= true,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
index e7852d2861379..477c46041c947 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.c
@@ -19461,3 +19461,10 @@ const struct rtw89_txpwr_track_cfg rtw89_8852c_trk_cfg = {
 	.delta_swingidx_2g_cck_a_n = _txpwr_track_delta_swingidx_2g_cck_a_n,
 	.delta_swingidx_2g_cck_a_p = _txpwr_track_delta_swingidx_2g_cck_a_p,
 };
+
+const struct rtw89_phy_tssi_dbw_table rtw89_8852c_tssi_dbw_table = {
+	.data[RTW89_TSSI_BANDEDGE_FLAT] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
+	.data[RTW89_TSSI_BANDEDGE_LOW] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
+	.data[RTW89_TSSI_BANDEDGE_MID] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
+	.data[RTW89_TSSI_BANDEDGE_HIGH] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
+};
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
index 616282c9bb986..7d71a92e2d27c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_table.h
@@ -13,6 +13,7 @@ extern const struct rtw89_phy_table rtw89_8852c_phy_radioa_table;
 extern const struct rtw89_phy_table rtw89_8852c_phy_radiob_table;
 extern const struct rtw89_phy_table rtw89_8852c_phy_nctl_table;
 extern const struct rtw89_txpwr_table rtw89_8852c_byr_table;
+extern const struct rtw89_phy_tssi_dbw_table rtw89_8852c_tssi_dbw_table;
 extern const struct rtw89_txpwr_track_cfg rtw89_8852c_trk_cfg;
 extern const u8 rtw89_8852c_tx_shape[RTW89_BAND_MAX][RTW89_RS_TX_SHAPE_NUM]
 				    [RTW89_REGD_NUM];
-- 
2.25.1

