Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1E25ED829
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 10:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbiI1IsB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 04:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbiI1IrE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 04:47:04 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0519C3D597
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 01:44:47 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 28S8iBf45013424, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 28S8iBf45013424
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 28 Sep 2022 16:44:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 28 Sep 2022 16:44:36 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 28 Sep
 2022 16:44:36 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 8/9] wifi: rtw89: 8852b: add chip_ops to read phy cap
Date:   Wed, 28 Sep 2022 16:43:35 +0800
Message-ID: <20220928084336.34981-9-pkshih@realtek.com>
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

This efuse region is to store PHY calibration, and it is a separated region
from the region that stores MAC address. Then, use these data to configure
via chip_ops::power_trim that is a calibration mechanism of TX power.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 184 ++++++++++++++++++
 2 files changed, 188 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index be39d2200e054..51af91b30fc4d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -84,6 +84,7 @@ enum rtw89_subband {
 	RTW89_CH_6G_BAND_IDX7, /* Ultra-high */
 
 	RTW89_SUBBAND_NR,
+	RTW89_SUBBAND_2GHZ_5GHZ_NR = RTW89_CH_5G_BAND_4 + 1,
 };
 
 enum rtw89_gain_offset {
@@ -2196,6 +2197,7 @@ struct rtw89_sta {
 
 struct rtw89_efuse {
 	bool valid;
+	bool power_k_valid;
 	u8 xtal_cap;
 	u8 addr[ETH_ALEN];
 	u8 rfe_type;
@@ -3425,8 +3427,10 @@ struct rtw89_phy_bb_gain_info {
 
 struct rtw89_phy_efuse_gain {
 	bool offset_valid;
+	bool comp_valid;
 	s8 offset[RF_PATH_MAX][RTW89_GAIN_OFFSET_NR]; /* S(8, 0) */
 	s8 offset_base[RTW89_PHY_MAX]; /* S(8, 4) */
+	s8 comp[RF_PATH_MAX][RTW89_SUBBAND_NR]; /* S(8, 0) */
 };
 
 struct rtw89_dev {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 8911900e06f87..e2cdac505a8af 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -123,6 +123,186 @@ static int rtw8852b_read_efuse(struct rtw89_dev *rtwdev, u8 *log_map)
 	return 0;
 }
 
+static void rtw8852b_phycap_parsing_power_cal(struct rtw89_dev *rtwdev, u8 *phycap_map)
+{
+#define PWR_K_CHK_OFFSET 0x5E9
+#define PWR_K_CHK_VALUE 0xAA
+	u32 offset = PWR_K_CHK_OFFSET - rtwdev->chip->phycap_addr;
+
+	if (phycap_map[offset] == PWR_K_CHK_VALUE)
+		rtwdev->efuse.power_k_valid = true;
+}
+
+static void rtw8852b_phycap_parsing_tssi(struct rtw89_dev *rtwdev, u8 *phycap_map)
+{
+	struct rtw89_tssi_info *tssi = &rtwdev->tssi;
+	static const u32 tssi_trim_addr[RF_PATH_NUM_8852B] = {0x5D6, 0x5AB};
+	u32 addr = rtwdev->chip->phycap_addr;
+	bool pg = false;
+	u32 ofst;
+	u8 i, j;
+
+	for (i = 0; i < RF_PATH_NUM_8852B; i++) {
+		for (j = 0; j < TSSI_TRIM_CH_GROUP_NUM; j++) {
+			/* addrs are in decreasing order */
+			ofst = tssi_trim_addr[i] - addr - j;
+			tssi->tssi_trim[i][j] = phycap_map[ofst];
+
+			if (phycap_map[ofst] != 0xff)
+				pg = true;
+		}
+	}
+
+	if (!pg) {
+		memset(tssi->tssi_trim, 0, sizeof(tssi->tssi_trim));
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM] no PG, set all trim info to 0\n");
+	}
+
+	for (i = 0; i < RF_PATH_NUM_8852B; i++)
+		for (j = 0; j < TSSI_TRIM_CH_GROUP_NUM; j++)
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "[TSSI] path=%d idx=%d trim=0x%x addr=0x%x\n",
+				    i, j, tssi->tssi_trim[i][j],
+				    tssi_trim_addr[i] - j);
+}
+
+static void rtw8852b_phycap_parsing_thermal_trim(struct rtw89_dev *rtwdev,
+						 u8 *phycap_map)
+{
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	static const u32 thm_trim_addr[RF_PATH_NUM_8852B] = {0x5DF, 0x5DC};
+	u32 addr = rtwdev->chip->phycap_addr;
+	u8 i;
+
+	for (i = 0; i < RF_PATH_NUM_8852B; i++) {
+		info->thermal_trim[i] = phycap_map[thm_trim_addr[i] - addr];
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[THERMAL][TRIM] path=%d thermal_trim=0x%x\n",
+			    i, info->thermal_trim[i]);
+
+		if (info->thermal_trim[i] != 0xff)
+			info->pg_thermal_trim = true;
+	}
+}
+
+static void rtw8852b_thermal_trim(struct rtw89_dev *rtwdev)
+{
+#define __thm_setting(raw)				\
+({							\
+	u8 __v = (raw);					\
+	((__v & 0x1) << 3) | ((__v & 0x1f) >> 1);	\
+})
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	u8 i, val;
+
+	if (!info->pg_thermal_trim) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[THERMAL][TRIM] no PG, do nothing\n");
+
+		return;
+	}
+
+	for (i = 0; i < RF_PATH_NUM_8852B; i++) {
+		val = __thm_setting(info->thermal_trim[i]);
+		rtw89_write_rf(rtwdev, i, RR_TM2, RR_TM2_OFF, val);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[THERMAL][TRIM] path=%d thermal_setting=0x%x\n",
+			    i, val);
+	}
+#undef __thm_setting
+}
+
+static void rtw8852b_phycap_parsing_pa_bias_trim(struct rtw89_dev *rtwdev,
+						 u8 *phycap_map)
+{
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	static const u32 pabias_trim_addr[RF_PATH_NUM_8852B] = {0x5DE, 0x5DB};
+	u32 addr = rtwdev->chip->phycap_addr;
+	u8 i;
+
+	for (i = 0; i < RF_PATH_NUM_8852B; i++) {
+		info->pa_bias_trim[i] = phycap_map[pabias_trim_addr[i] - addr];
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[PA_BIAS][TRIM] path=%d pa_bias_trim=0x%x\n",
+			    i, info->pa_bias_trim[i]);
+
+		if (info->pa_bias_trim[i] != 0xff)
+			info->pg_pa_bias_trim = true;
+	}
+}
+
+static void rtw8852b_pa_bias_trim(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	u8 pabias_2g, pabias_5g;
+	u8 i;
+
+	if (!info->pg_pa_bias_trim) {
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[PA_BIAS][TRIM] no PG, do nothing\n");
+
+		return;
+	}
+
+	for (i = 0; i < RF_PATH_NUM_8852B; i++) {
+		pabias_2g = FIELD_GET(GENMASK(3, 0), info->pa_bias_trim[i]);
+		pabias_5g = FIELD_GET(GENMASK(7, 4), info->pa_bias_trim[i]);
+
+		rtw89_debug(rtwdev, RTW89_DBG_RFK,
+			    "[PA_BIAS][TRIM] path=%d 2G=0x%x 5G=0x%x\n",
+			    i, pabias_2g, pabias_5g);
+
+		rtw89_write_rf(rtwdev, i, RR_BIASA, RR_BIASA_TXG, pabias_2g);
+		rtw89_write_rf(rtwdev, i, RR_BIASA, RR_BIASA_TXA, pabias_5g);
+	}
+}
+
+static void rtw8852b_phycap_parsing_gain_comp(struct rtw89_dev *rtwdev, u8 *phycap_map)
+{
+	static const u32 comp_addrs[][RTW89_SUBBAND_2GHZ_5GHZ_NR] = {
+		{0x5BB, 0x5BA, 0, 0x5B9, 0x5B8},
+		{0x590, 0x58F, 0, 0x58E, 0x58D},
+	};
+	struct rtw89_phy_efuse_gain *gain = &rtwdev->efuse_gain;
+	u32 phycap_addr = rtwdev->chip->phycap_addr;
+	bool valid = false;
+	int path, i;
+	u8 data;
+
+	for (path = 0; path < 2; path++)
+		for (i = 0; i < RTW89_SUBBAND_2GHZ_5GHZ_NR; i++) {
+			if (comp_addrs[path][i] == 0)
+				continue;
+
+			data = phycap_map[comp_addrs[path][i] - phycap_addr];
+			valid |= _decode_efuse_gain(data, NULL,
+						    &gain->comp[path][i]);
+		}
+
+	gain->comp_valid = valid;
+}
+
+static int rtw8852b_read_phycap(struct rtw89_dev *rtwdev, u8 *phycap_map)
+{
+	rtw8852b_phycap_parsing_power_cal(rtwdev, phycap_map);
+	rtw8852b_phycap_parsing_tssi(rtwdev, phycap_map);
+	rtw8852b_phycap_parsing_thermal_trim(rtwdev, phycap_map);
+	rtw8852b_phycap_parsing_pa_bias_trim(rtwdev, phycap_map);
+	rtw8852b_phycap_parsing_gain_comp(rtwdev, phycap_map);
+
+	return 0;
+}
+
+static void rtw8852b_power_trim(struct rtw89_dev *rtwdev)
+{
+	rtw8852b_thermal_trim(rtwdev);
+	rtw8852b_pa_bias_trim(rtwdev);
+}
+
 static u32 rtw8852b_bb_cal_txpwr_ref(struct rtw89_dev *rtwdev,
 				     enum rtw89_phy_idx phy_idx, s16 ref)
 {
@@ -369,6 +549,8 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.enable_bb_rf		= rtw8852b_mac_enable_bb_rf,
 	.disable_bb_rf		= rtw8852b_mac_disable_bb_rf,
 	.read_efuse		= rtw8852b_read_efuse,
+	.read_phycap		= rtw8852b_read_phycap,
+	.power_trim		= rtw8852b_power_trim,
 	.set_txpwr		= rtw8852b_set_txpwr,
 	.set_txpwr_ctrl		= rtw8852b_set_txpwr_ctrl,
 	.init_txpwr_unit	= rtw8852b_init_txpwr_unit,
@@ -386,6 +568,8 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.limit_efuse_size	= 1280,
 	.dav_phy_efuse_size	= 96,
 	.dav_log_efuse_size	= 16,
+	.phycap_addr		= 0x580,
+	.phycap_size		= 128,
 	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
-- 
2.25.1

