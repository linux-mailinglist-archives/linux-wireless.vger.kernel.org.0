Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9236A4CF19A
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 07:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbiCGGHJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 01:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbiCGGHI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 01:07:08 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8A45F24E
        for <linux-wireless@vger.kernel.org>; Sun,  6 Mar 2022 22:06:12 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 227666xfC022635, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 227666xfC022635
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Mar 2022 14:06:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 7 Mar 2022 14:06:05 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 7 Mar
 2022 14:06:05 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 12/13] rtw89: 8852c: process efuse of phycap
Date:   Mon, 7 Mar 2022 14:04:56 +0800
Message-ID: <20220307060457.56789-13-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307060457.56789-1-pkshih@realtek.com>
References: <20220307060457.56789-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/07/2022 05:48:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvNyCkV6TIIDAzOjQ5OjAw?=
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

Read phycap data programmed in efuse, and store them into array.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |   4 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 159 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.h |   2 +
 3 files changed, 165 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 3582e352c4a66..a769fccc8c016 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2637,18 +2637,22 @@ struct rtw89_cfo_tracking_info {
 
 /* 2GL, 2GH, 5GL1, 5GH1, 5GM1, 5GM2, 5GH1, 5GH2 */
 #define TSSI_TRIM_CH_GROUP_NUM 8
+#define TSSI_TRIM_CH_GROUP_NUM_6G 16
 
 #define TSSI_CCK_CH_GROUP_NUM 6
 #define TSSI_MCS_2G_CH_GROUP_NUM 5
 #define TSSI_MCS_5G_CH_GROUP_NUM 14
+#define TSSI_MCS_6G_CH_GROUP_NUM 32
 #define TSSI_MCS_CH_GROUP_NUM \
 	(TSSI_MCS_2G_CH_GROUP_NUM + TSSI_MCS_5G_CH_GROUP_NUM)
 
 struct rtw89_tssi_info {
 	u8 thermal[RF_PATH_MAX];
 	s8 tssi_trim[RF_PATH_MAX][TSSI_TRIM_CH_GROUP_NUM];
+	s8 tssi_trim_6g[RF_PATH_MAX][TSSI_TRIM_CH_GROUP_NUM_6G];
 	s8 tssi_cck[RF_PATH_MAX][TSSI_CCK_CH_GROUP_NUM];
 	s8 tssi_mcs[RF_PATH_MAX][TSSI_MCS_CH_GROUP_NUM];
+	s8 tssi_6g_mcs[RF_PATH_MAX][TSSI_MCS_6G_CH_GROUP_NUM];
 	s8 extra_ofst[RF_PATH_MAX];
 	bool tssi_tracking_check[RF_PATH_MAX];
 	u8 default_txagc_offset[RF_PATH_MAX];
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index e17e0ab75d0eb..df6e9bf69f90a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2019-2022  Realtek Corporation
  */
 
+#include "debug.h"
 #include "fw.h"
 #include "mac.h"
 #include "reg.h"
@@ -220,7 +221,163 @@ static int rtw8852c_pwr_off_func(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static void rtw8852c_phycap_parsing_tssi(struct rtw89_dev *rtwdev, u8 *phycap_map)
+{
+	struct rtw89_tssi_info *tssi = &rtwdev->tssi;
+	static const u32 tssi_trim_addr[RF_PATH_NUM_8852C] = {0x5D6, 0x5AB};
+	static const u32 tssi_trim_addr_6g[RF_PATH_NUM_8852C] = {0x5CE, 0x5A3};
+	u32 addr = rtwdev->chip->phycap_addr;
+	bool pg = false;
+	u32 ofst;
+	u8 i, j;
+
+	for (i = 0; i < RF_PATH_NUM_8852C; i++) {
+		for (j = 0; j < TSSI_TRIM_CH_GROUP_NUM; j++) {
+			/* addrs are in decreasing order */
+			ofst = tssi_trim_addr[i] - addr - j;
+			tssi->tssi_trim[i][j] = phycap_map[ofst];
+
+			if (phycap_map[ofst] != 0xff)
+				pg = true;
+		}
+
+		for (j = 0; j < TSSI_TRIM_CH_GROUP_NUM_6G; j++) {
+			/* addrs are in decreasing order */
+			ofst = tssi_trim_addr_6g[i] - addr - j;
+			tssi->tssi_trim_6g[i][j] = phycap_map[ofst];
+
+			if (phycap_map[ofst] != 0xff)
+				pg = true;
+		}
+	}
+
+	if (!pg) {
+		memset(tssi->tssi_trim, 0, sizeof(tssi->tssi_trim));
+		memset(tssi->tssi_trim_6g, 0, sizeof(tssi->tssi_trim_6g));
+		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+			    "[TSSI][TRIM] no PG, set all trim info to 0\n");
+	}
+
+	for (i = 0; i < RF_PATH_NUM_8852C; i++)
+		for (j = 0; j < TSSI_TRIM_CH_GROUP_NUM; j++)
+			rtw89_debug(rtwdev, RTW89_DBG_TSSI,
+				    "[TSSI] path=%d idx=%d trim=0x%x addr=0x%x\n",
+				    i, j, tssi->tssi_trim[i][j],
+				    tssi_trim_addr[i] - j);
+}
+
+static void rtw8852c_phycap_parsing_thermal_trim(struct rtw89_dev *rtwdev,
+						 u8 *phycap_map)
+{
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	static const u32 thm_trim_addr[RF_PATH_NUM_8852C] = {0x5DF, 0x5DC};
+	u32 addr = rtwdev->chip->phycap_addr;
+	u8 i;
+
+	for (i = 0; i < RF_PATH_NUM_8852C; i++) {
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
+static void rtw8852c_thermal_trim(struct rtw89_dev *rtwdev)
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
+	for (i = 0; i < RF_PATH_NUM_8852C; i++) {
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
+static void rtw8852c_phycap_parsing_pa_bias_trim(struct rtw89_dev *rtwdev,
+						 u8 *phycap_map)
+{
+	struct rtw89_power_trim_info *info = &rtwdev->pwr_trim;
+	static const u32 pabias_trim_addr[RF_PATH_NUM_8852C] = {0x5DE, 0x5DB};
+	u32 addr = rtwdev->chip->phycap_addr;
+	u8 i;
+
+	for (i = 0; i < RF_PATH_NUM_8852C; i++) {
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
+static void rtw8852c_pa_bias_trim(struct rtw89_dev *rtwdev)
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
+	for (i = 0; i < RF_PATH_NUM_8852C; i++) {
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
+static int rtw8852c_read_phycap(struct rtw89_dev *rtwdev, u8 *phycap_map)
+{
+	rtw8852c_phycap_parsing_tssi(rtwdev, phycap_map);
+	rtw8852c_phycap_parsing_thermal_trim(rtwdev, phycap_map);
+	rtw8852c_phycap_parsing_pa_bias_trim(rtwdev, phycap_map);
+
+	return 0;
+}
+
+static void rtw8852c_power_trim(struct rtw89_dev *rtwdev)
+{
+	rtw8852c_thermal_trim(rtwdev);
+	rtw8852c_pa_bias_trim(rtwdev);
+}
+
 static const struct rtw89_chip_ops rtw8852c_chip_ops = {
+	.read_phycap		= rtw8852c_read_phycap,
+	.power_trim		= rtw8852c_power_trim,
 	.pwr_on_func		= rtw8852c_pwr_on_func,
 	.pwr_off_func		= rtw8852c_pwr_off_func,
 };
@@ -238,6 +395,8 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.limit_efuse_size	= 1280,
 	.dav_phy_efuse_size	= 96,
 	.dav_log_efuse_size	= 16,
+	.phycap_addr		= 0x590,
+	.phycap_size		= 0x60,
 	.hci_func_en_addr	= R_AX_HCI_FUNC_EN_V1,
 	.h2c_ctrl_reg		= R_AX_H2CREG_CTRL_V1,
 	.h2c_regs		= rtw8852c_h2c_regs,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.h b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
index 68a397223a814..8abca49e6c84b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.h
@@ -7,6 +7,8 @@
 
 #include "core.h"
 
+#define RF_PATH_NUM_8852C 2
+
 extern const struct rtw89_chip_info rtw8852c_chip_info;
 
 #endif
-- 
2.25.1

