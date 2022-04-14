Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261905005D8
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Apr 2022 08:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240005AbiDNGXl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Apr 2022 02:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240018AbiDNGXf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Apr 2022 02:23:35 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7261EED1
        for <linux-wireless@vger.kernel.org>; Wed, 13 Apr 2022 23:21:10 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23E6L3tuC001355, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23E6L3tuC001355
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 14 Apr 2022 14:21:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 14 Apr 2022 14:21:03 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 14 Apr
 2022 14:21:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 06/12] rtw89: 8852c: support bb gain info
Date:   Thu, 14 Apr 2022 14:20:20 +0800
Message-ID: <20220414062027.62638-7-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Add parser for bb gain table and configure bb gain table for 8852c.
While ctrl_ch, obtain bb gain error settings and write them to phy.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  37 +++
 drivers/net/wireless/realtek/rtw89/phy.c      | 243 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 178 +++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.h |   1 +
 4 files changed, 459 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index fd6b17b6498b9..8ceee254d6274 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3000,6 +3000,41 @@ struct rtw89_hw_scan_info {
 	u8 op_band;
 };
 
+enum rtw89_phy_bb_gain_band {
+	RTW89_BB_GAIN_BAND_2G = 0,
+	RTW89_BB_GAIN_BAND_5G_L = 1,
+	RTW89_BB_GAIN_BAND_5G_M = 2,
+	RTW89_BB_GAIN_BAND_5G_H = 3,
+	RTW89_BB_GAIN_BAND_6G_L = 4,
+	RTW89_BB_GAIN_BAND_6G_M = 5,
+	RTW89_BB_GAIN_BAND_6G_H = 6,
+	RTW89_BB_GAIN_BAND_6G_UH = 7,
+
+	RTW89_BB_GAIN_BAND_NR,
+};
+
+enum rtw89_phy_bb_rxsc_num {
+	RTW89_BB_RXSC_NUM_40 = 9, /* SC: 0, 1~8 */
+	RTW89_BB_RXSC_NUM_80 = 13, /* SC: 0, 1~8, 9~12 */
+	RTW89_BB_RXSC_NUM_160 = 15, /* SC: 0, 1~8, 9~12, 13~14 */
+};
+
+struct rtw89_phy_bb_gain_info {
+	s8 lna_gain[RTW89_BB_GAIN_BAND_NR][RF_PATH_MAX][LNA_GAIN_NUM];
+	s8 tia_gain[RTW89_BB_GAIN_BAND_NR][RF_PATH_MAX][TIA_GAIN_NUM];
+	s8 lna_gain_bypass[RTW89_BB_GAIN_BAND_NR][RF_PATH_MAX][LNA_GAIN_NUM];
+	s8 lna_op1db[RTW89_BB_GAIN_BAND_NR][RF_PATH_MAX][LNA_GAIN_NUM];
+	s8 tia_lna_op1db[RTW89_BB_GAIN_BAND_NR][RF_PATH_MAX]
+			[LNA_GAIN_NUM + 1]; /* TIA0_LNA0~6 + TIA1_LNA6 */
+	s8 rpl_ofst_20[RTW89_BB_GAIN_BAND_NR][RF_PATH_MAX];
+	s8 rpl_ofst_40[RTW89_BB_GAIN_BAND_NR][RF_PATH_MAX]
+		      [RTW89_BB_RXSC_NUM_40];
+	s8 rpl_ofst_80[RTW89_BB_GAIN_BAND_NR][RF_PATH_MAX]
+		      [RTW89_BB_RXSC_NUM_80];
+	s8 rpl_ofst_160[RTW89_BB_GAIN_BAND_NR][RF_PATH_MAX]
+		       [RTW89_BB_RXSC_NUM_160];
+};
+
 struct rtw89_dev {
 	struct ieee80211_hw *hw;
 	struct device *dev;
@@ -3062,6 +3097,8 @@ struct rtw89_dev {
 	struct rtw89_env_monitor_info env_monitor;
 	struct rtw89_dig_info dig;
 	struct rtw89_phy_ch_info ch_info;
+	struct rtw89_phy_bb_gain_info bb_gain;
+
 	struct delayed_work track_work;
 	struct delayed_work coex_act1_work;
 	struct delayed_work coex_bt_devinfo_work;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index aff03261ab727..7d0593d8fafe9 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -790,6 +790,245 @@ static void rtw89_phy_config_bb_reg(struct rtw89_dev *rtwdev,
 		rtw89_phy_write32(rtwdev, reg->addr, reg->data);
 }
 
+union rtw89_phy_bb_gain_arg {
+	u32 addr;
+	struct {
+		union {
+			u8 type;
+			struct {
+				u8 rxsc_start:4;
+				u8 bw:4;
+			};
+		};
+		u8 path;
+		u8 gain_band;
+		u8 cfg_type;
+	};
+} __packed;
+
+static void
+rtw89_phy_cfg_bb_gain_error(struct rtw89_dev *rtwdev,
+			    union rtw89_phy_bb_gain_arg arg, u32 data)
+{
+	struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain;
+	u8 type = arg.type;
+	u8 path = arg.path;
+	u8 gband = arg.gain_band;
+	int i;
+
+	switch (type) {
+	case 0:
+		for (i = 0; i < 4; i++, data >>= 8)
+			gain->lna_gain[gband][path][i] = data & 0xff;
+		break;
+	case 1:
+		for (i = 4; i < 7; i++, data >>= 8)
+			gain->lna_gain[gband][path][i] = data & 0xff;
+		break;
+	case 2:
+		for (i = 0; i < 2; i++, data >>= 8)
+			gain->tia_gain[gband][path][i] = data & 0xff;
+		break;
+	default:
+		rtw89_warn(rtwdev,
+			   "bb gain error {0x%x:0x%x} with unknown type: %d\n",
+			   arg.addr, data, type);
+		break;
+	}
+}
+
+enum rtw89_phy_bb_rxsc_start_idx {
+	RTW89_BB_RXSC_START_IDX_FULL = 0,
+	RTW89_BB_RXSC_START_IDX_20 = 1,
+	RTW89_BB_RXSC_START_IDX_20_1 = 5,
+	RTW89_BB_RXSC_START_IDX_40 = 9,
+	RTW89_BB_RXSC_START_IDX_80 = 13,
+};
+
+static void
+rtw89_phy_cfg_bb_rpl_ofst(struct rtw89_dev *rtwdev,
+			  union rtw89_phy_bb_gain_arg arg, u32 data)
+{
+	struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain;
+	u8 rxsc_start = arg.rxsc_start;
+	u8 bw = arg.bw;
+	u8 path = arg.path;
+	u8 gband = arg.gain_band;
+	u8 rxsc;
+	s8 ofst;
+	int i;
+
+	switch (bw) {
+	case RTW89_CHANNEL_WIDTH_20:
+		gain->rpl_ofst_20[gband][path] = (s8)data;
+		break;
+	case RTW89_CHANNEL_WIDTH_40:
+		if (rxsc_start == RTW89_BB_RXSC_START_IDX_FULL) {
+			gain->rpl_ofst_40[gband][path][0] = (s8)data;
+		} else if (rxsc_start == RTW89_BB_RXSC_START_IDX_20) {
+			for (i = 0; i < 2; i++, data >>= 8) {
+				rxsc = RTW89_BB_RXSC_START_IDX_20 + i;
+				ofst = (s8)(data & 0xff);
+				gain->rpl_ofst_40[gband][path][rxsc] = ofst;
+			}
+		}
+		break;
+	case RTW89_CHANNEL_WIDTH_80:
+		if (rxsc_start == RTW89_BB_RXSC_START_IDX_FULL) {
+			gain->rpl_ofst_80[gband][path][0] = (s8)data;
+		} else if (rxsc_start == RTW89_BB_RXSC_START_IDX_20) {
+			for (i = 0; i < 4; i++, data >>= 8) {
+				rxsc = RTW89_BB_RXSC_START_IDX_20 + i;
+				ofst = (s8)(data & 0xff);
+				gain->rpl_ofst_80[gband][path][rxsc] = ofst;
+			}
+		} else if (rxsc_start == RTW89_BB_RXSC_START_IDX_40) {
+			for (i = 0; i < 2; i++, data >>= 8) {
+				rxsc = RTW89_BB_RXSC_START_IDX_40 + i;
+				ofst = (s8)(data & 0xff);
+				gain->rpl_ofst_80[gband][path][rxsc] = ofst;
+			}
+		}
+		break;
+	case RTW89_CHANNEL_WIDTH_160:
+		if (rxsc_start == RTW89_BB_RXSC_START_IDX_FULL) {
+			gain->rpl_ofst_160[gband][path][0] = (s8)data;
+		} else if (rxsc_start == RTW89_BB_RXSC_START_IDX_20) {
+			for (i = 0; i < 4; i++, data >>= 8) {
+				rxsc = RTW89_BB_RXSC_START_IDX_20 + i;
+				ofst = (s8)(data & 0xff);
+				gain->rpl_ofst_160[gband][path][rxsc] = ofst;
+			}
+		} else if (rxsc_start == RTW89_BB_RXSC_START_IDX_20_1) {
+			for (i = 0; i < 4; i++, data >>= 8) {
+				rxsc = RTW89_BB_RXSC_START_IDX_20_1 + i;
+				ofst = (s8)(data & 0xff);
+				gain->rpl_ofst_160[gband][path][rxsc] = ofst;
+			}
+		} else if (rxsc_start == RTW89_BB_RXSC_START_IDX_40) {
+			for (i = 0; i < 4; i++, data >>= 8) {
+				rxsc = RTW89_BB_RXSC_START_IDX_40 + i;
+				ofst = (s8)(data & 0xff);
+				gain->rpl_ofst_160[gband][path][rxsc] = ofst;
+			}
+		} else if (rxsc_start == RTW89_BB_RXSC_START_IDX_80) {
+			for (i = 0; i < 2; i++, data >>= 8) {
+				rxsc = RTW89_BB_RXSC_START_IDX_80 + i;
+				ofst = (s8)(data & 0xff);
+				gain->rpl_ofst_160[gband][path][rxsc] = ofst;
+			}
+		}
+		break;
+	default:
+		rtw89_warn(rtwdev,
+			   "bb rpl ofst {0x%x:0x%x} with unknown bw: %d\n",
+			   arg.addr, data, bw);
+		break;
+	}
+}
+
+static void
+rtw89_phy_cfg_bb_gain_bypass(struct rtw89_dev *rtwdev,
+			     union rtw89_phy_bb_gain_arg arg, u32 data)
+{
+	struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain;
+	u8 type = arg.type;
+	u8 path = arg.path;
+	u8 gband = arg.gain_band;
+	int i;
+
+	switch (type) {
+	case 0:
+		for (i = 0; i < 4; i++, data >>= 8)
+			gain->lna_gain_bypass[gband][path][i] = data & 0xff;
+		break;
+	case 1:
+		for (i = 4; i < 7; i++, data >>= 8)
+			gain->lna_gain_bypass[gband][path][i] = data & 0xff;
+		break;
+	default:
+		rtw89_warn(rtwdev,
+			   "bb gain bypass {0x%x:0x%x} with unknown type: %d\n",
+			   arg.addr, data, type);
+		break;
+	}
+}
+
+static void
+rtw89_phy_cfg_bb_gain_op1db(struct rtw89_dev *rtwdev,
+			    union rtw89_phy_bb_gain_arg arg, u32 data)
+{
+	struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain;
+	u8 type = arg.type;
+	u8 path = arg.path;
+	u8 gband = arg.gain_band;
+	int i;
+
+	switch (type) {
+	case 0:
+		for (i = 0; i < 4; i++, data >>= 8)
+			gain->lna_op1db[gband][path][i] = data & 0xff;
+		break;
+	case 1:
+		for (i = 4; i < 7; i++, data >>= 8)
+			gain->lna_op1db[gband][path][i] = data & 0xff;
+		break;
+	case 2:
+		for (i = 0; i < 4; i++, data >>= 8)
+			gain->tia_lna_op1db[gband][path][i] = data & 0xff;
+		break;
+	case 3:
+		for (i = 4; i < 8; i++, data >>= 8)
+			gain->tia_lna_op1db[gband][path][i] = data & 0xff;
+		break;
+	default:
+		rtw89_warn(rtwdev,
+			   "bb gain op1db {0x%x:0x%x} with unknown type: %d\n",
+			   arg.addr, data, type);
+		break;
+	}
+}
+
+static void rtw89_phy_config_bb_gain(struct rtw89_dev *rtwdev,
+				     const struct rtw89_reg2_def *reg,
+				     enum rtw89_rf_path rf_path,
+				     void *extra_data)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	union rtw89_phy_bb_gain_arg arg = { .addr = reg->addr };
+
+	if (arg.gain_band >= RTW89_BB_GAIN_BAND_NR)
+		return;
+
+	if (arg.path >= chip->rf_path_num)
+		return;
+
+	if (arg.addr >= 0xf9 && arg.addr <= 0xfe) {
+		rtw89_warn(rtwdev, "bb gain table with flow ctrl\n");
+		return;
+	}
+
+	switch (arg.cfg_type) {
+	case 0:
+		rtw89_phy_cfg_bb_gain_error(rtwdev, arg, reg->data);
+		break;
+	case 1:
+		rtw89_phy_cfg_bb_rpl_ofst(rtwdev, arg, reg->data);
+		break;
+	case 2:
+		rtw89_phy_cfg_bb_gain_bypass(rtwdev, arg, reg->data);
+		break;
+	case 3:
+		rtw89_phy_cfg_bb_gain_op1db(rtwdev, arg, reg->data);
+		break;
+	default:
+		rtw89_warn(rtwdev,
+			   "bb gain {0x%x:0x%x} with unknown cfg type: %d\n",
+			   arg.addr, reg->data, arg.cfg_type);
+		break;
+	}
+}
+
 static void
 rtw89_phy_cofig_rf_reg_store(struct rtw89_dev *rtwdev,
 			     const struct rtw89_reg2_def *reg,
@@ -1033,9 +1272,13 @@ void rtw89_phy_init_bb_reg(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_phy_table *bb_table = chip->bb_table;
+	const struct rtw89_phy_table *bb_gain_table = chip->bb_gain_table;
 
 	rtw89_phy_init_reg(rtwdev, bb_table, rtw89_phy_config_bb_reg, NULL);
 	rtw89_chip_init_txpwr_unit(rtwdev, RTW89_PHY_0);
+	if (bb_gain_table)
+		rtw89_phy_init_reg(rtwdev, bb_gain_table,
+				   rtw89_phy_config_bb_gain, NULL);
 	rtw89_phy_bb_reset(rtwdev, RTW89_PHY_0);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 9c6bef665c764..dba2799383472 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -495,6 +495,184 @@ static void rtw8852c_power_trim(struct rtw89_dev *rtwdev)
 	rtw8852c_pa_bias_trim(rtwdev);
 }
 
+struct rtw8852c_bb_gain {
+	u32 gain_g[BB_PATH_NUM_8852C];
+	u32 gain_a[BB_PATH_NUM_8852C];
+	u32 gain_mask;
+};
+
+static const struct rtw8852c_bb_gain bb_gain_lna[LNA_GAIN_NUM] = {
+	{ .gain_g = {0x4678, 0x475C}, .gain_a = {0x45DC, 0x4740},
+	  .gain_mask = 0x00ff0000 },
+	{ .gain_g = {0x4678, 0x475C}, .gain_a = {0x45DC, 0x4740},
+	  .gain_mask = 0xff000000 },
+	{ .gain_g = {0x467C, 0x4760}, .gain_a = {0x4660, 0x4744},
+	  .gain_mask = 0x000000ff },
+	{ .gain_g = {0x467C, 0x4760}, .gain_a = {0x4660, 0x4744},
+	  .gain_mask = 0x0000ff00 },
+	{ .gain_g = {0x467C, 0x4760}, .gain_a = {0x4660, 0x4744},
+	  .gain_mask = 0x00ff0000 },
+	{ .gain_g = {0x467C, 0x4760}, .gain_a = {0x4660, 0x4744},
+	  .gain_mask = 0xff000000 },
+	{ .gain_g = {0x4680, 0x4764}, .gain_a = {0x4664, 0x4748},
+	  .gain_mask = 0x000000ff },
+};
+
+static const struct rtw8852c_bb_gain bb_gain_tia[TIA_GAIN_NUM] = {
+	{ .gain_g = {0x4680, 0x4764}, .gain_a = {0x4664, 0x4748},
+	  .gain_mask = 0x00ff0000 },
+	{ .gain_g = {0x4680, 0x4764}, .gain_a = {0x4664, 0x4748},
+	  .gain_mask = 0xff000000 },
+};
+
+struct rtw8852c_bb_gain_bypass {
+	u32 gain_g[BB_PATH_NUM_8852C];
+	u32 gain_a[BB_PATH_NUM_8852C];
+	u32 gain_mask_g;
+	u32 gain_mask_a;
+};
+
+static
+const struct rtw8852c_bb_gain_bypass bb_gain_bypass_lna[LNA_GAIN_NUM] = {
+	{ .gain_g = {0x4BB8, 0x4C7C}, .gain_a = {0x4BB4, 0x4C78},
+	  .gain_mask_g = 0xff000000, .gain_mask_a = 0xff},
+	{ .gain_g = {0x4BBC, 0x4C80}, .gain_a = {0x4BB4, 0x4C78},
+	  .gain_mask_g = 0xff, .gain_mask_a = 0xff00},
+	{ .gain_g = {0x4BBC, 0x4C80}, .gain_a = {0x4BB4, 0x4C78},
+	  .gain_mask_g = 0xff00, .gain_mask_a = 0xff0000},
+	{ .gain_g = {0x4BBC, 0x4C80}, .gain_a = {0x4BB4, 0x4C78},
+	  .gain_mask_g = 0xff0000, .gain_mask_a = 0xff000000},
+	{ .gain_g = {0x4BBC, 0x4C80}, .gain_a = {0x4BB8, 0x4C7C},
+	  .gain_mask_g = 0xff000000, .gain_mask_a = 0xff},
+	{ .gain_g = {0x4BC0, 0x4C84}, .gain_a = {0x4BB8, 0x4C7C},
+	  .gain_mask_g = 0xff, .gain_mask_a = 0xff00},
+	{ .gain_g = {0x4BC0, 0x4C84}, .gain_a = {0x4BB8, 0x4C7C},
+	  .gain_mask_g = 0xff00, .gain_mask_a = 0xff0000},
+};
+
+struct rtw8852c_bb_gain_op1db {
+	struct {
+		u32 lna[BB_PATH_NUM_8852C];
+		u32 tia_lna[BB_PATH_NUM_8852C];
+		u32 mask;
+	} reg[LNA_GAIN_NUM];
+	u32 reg_tia0_lna6[BB_PATH_NUM_8852C];
+	u32 mask_tia0_lna6;
+};
+
+static const struct rtw8852c_bb_gain_op1db bb_gain_op1db_a = {
+	.reg = {
+		{ .lna = {0x4668, 0x474c}, .tia_lna = {0x4670, 0x4754},
+		  .mask = 0xff},
+		{ .lna = {0x4668, 0x474c}, .tia_lna = {0x4670, 0x4754},
+		  .mask = 0xff00},
+		{ .lna = {0x4668, 0x474c}, .tia_lna = {0x4670, 0x4754},
+		  .mask = 0xff0000},
+		{ .lna = {0x4668, 0x474c}, .tia_lna = {0x4670, 0x4754},
+		  .mask = 0xff000000},
+		{ .lna = {0x466c, 0x4750}, .tia_lna = {0x4674, 0x4758},
+		  .mask = 0xff},
+		{ .lna = {0x466c, 0x4750}, .tia_lna = {0x4674, 0x4758},
+		  .mask = 0xff00},
+		{ .lna = {0x466c, 0x4750}, .tia_lna = {0x4674, 0x4758},
+		  .mask = 0xff0000},
+	},
+	.reg_tia0_lna6 = {0x4674, 0x4758},
+	.mask_tia0_lna6 = 0xff000000,
+};
+
+static enum rtw89_phy_bb_gain_band
+rtw8852c_mapping_gain_band(enum rtw89_subband subband)
+{
+	switch (subband) {
+	default:
+	case RTW89_CH_2G:
+		return RTW89_BB_GAIN_BAND_2G;
+	case RTW89_CH_5G_BAND_1:
+		return RTW89_BB_GAIN_BAND_5G_L;
+	case RTW89_CH_5G_BAND_3:
+		return RTW89_BB_GAIN_BAND_5G_M;
+	case RTW89_CH_5G_BAND_4:
+		return RTW89_BB_GAIN_BAND_5G_H;
+	case RTW89_CH_6G_BAND_IDX0:
+	case RTW89_CH_6G_BAND_IDX1:
+		return RTW89_BB_GAIN_BAND_6G_L;
+	case RTW89_CH_6G_BAND_IDX2:
+	case RTW89_CH_6G_BAND_IDX3:
+		return RTW89_BB_GAIN_BAND_6G_M;
+	case RTW89_CH_6G_BAND_IDX4:
+	case RTW89_CH_6G_BAND_IDX5:
+		return RTW89_BB_GAIN_BAND_6G_H;
+	case RTW89_CH_6G_BAND_IDX6:
+	case RTW89_CH_6G_BAND_IDX7:
+		return RTW89_BB_GAIN_BAND_6G_UH;
+	}
+}
+
+static void rtw8852c_set_gain_error(struct rtw89_dev *rtwdev,
+				    enum rtw89_subband subband,
+				    enum rtw89_rf_path path)
+{
+	const struct rtw89_phy_bb_gain_info *gain = &rtwdev->bb_gain;
+	u8 gain_band = rtw8852c_mapping_gain_band(subband);
+	s32 val;
+	u32 reg;
+	u32 mask;
+	int i;
+
+	for (i = 0; i < LNA_GAIN_NUM; i++) {
+		if (subband == RTW89_CH_2G)
+			reg = bb_gain_lna[i].gain_g[path];
+		else
+			reg = bb_gain_lna[i].gain_a[path];
+
+		mask = bb_gain_lna[i].gain_mask;
+		val = gain->lna_gain[gain_band][path][i];
+		rtw89_phy_write32_mask(rtwdev, reg, mask, val);
+
+		if (subband == RTW89_CH_2G) {
+			reg = bb_gain_bypass_lna[i].gain_g[path];
+			mask = bb_gain_bypass_lna[i].gain_mask_g;
+		} else {
+			reg = bb_gain_bypass_lna[i].gain_a[path];
+			mask = bb_gain_bypass_lna[i].gain_mask_a;
+		}
+
+		val = gain->lna_gain_bypass[gain_band][path][i];
+		rtw89_phy_write32_mask(rtwdev, reg, mask, val);
+
+		if (subband != RTW89_CH_2G) {
+			reg = bb_gain_op1db_a.reg[i].lna[path];
+			mask = bb_gain_op1db_a.reg[i].mask;
+			val = gain->lna_op1db[gain_band][path][i];
+			rtw89_phy_write32_mask(rtwdev, reg, mask, val);
+
+			reg = bb_gain_op1db_a.reg[i].tia_lna[path];
+			mask = bb_gain_op1db_a.reg[i].mask;
+			val = gain->tia_lna_op1db[gain_band][path][i];
+			rtw89_phy_write32_mask(rtwdev, reg, mask, val);
+		}
+	}
+
+	if (subband != RTW89_CH_2G) {
+		reg = bb_gain_op1db_a.reg_tia0_lna6[path];
+		mask = bb_gain_op1db_a.mask_tia0_lna6;
+		val = gain->tia_lna_op1db[gain_band][path][7];
+		rtw89_phy_write32_mask(rtwdev, reg, mask, val);
+	}
+
+	for (i = 0; i < TIA_GAIN_NUM; i++) {
+		if (subband == RTW89_CH_2G)
+			reg = bb_gain_tia[i].gain_g[path];
+		else
+			reg = bb_gain_tia[i].gain_a[path];
+
+		mask = bb_gain_tia[i].gain_mask;
+		val = gain->tia_gain[gain_band][path][i];
+		rtw89_phy_write32_mask(rtwdev, reg, mask, val);
+	}
+}
+
 static void rtw8852c_bb_reset_all(struct rtw89_dev *rtwdev,
 				  enum rtw89_phy_idx phy_idx)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.h b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
index d0594716040bc..d1c5b4367a9d2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
@@ -8,6 +8,7 @@
 #include "core.h"
 
 #define RF_PATH_NUM_8852C 2
+#define BB_PATH_NUM_8852C 2
 
 struct rtw8852c_u_efuse {
 	u8 rsvd[0x38];
-- 
2.25.1

