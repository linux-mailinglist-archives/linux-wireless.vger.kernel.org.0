Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887994D58AB
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Mar 2022 04:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345914AbiCKDFD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 22:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345900AbiCKDFC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 22:05:02 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112F619CCF3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 19:03:58 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22B33qtD6021489, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22B33qtD6021489
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Mar 2022 11:03:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Mar 2022 11:03:52 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 11 Mar
 2022 11:03:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <hsuan8331@realtek.com>, <yuanhan1020@realtek.com>
Subject: [PATCH 04/11] rtw89: 8852c: add read/write rf register function
Date:   Fri, 11 Mar 2022 11:02:54 +0800
Message-ID: <20220311030301.33921-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311030301.33921-1-pkshih@realtek.com>
References: <20220311030301.33921-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/11/2022 02:42:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTEgpFekyCAwMTowNjowMA==?=
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

From: Chung-Hsuan Hung <hsuan8331@realtek.com>

Using encoded address which BIT(16) is used to discriminate which region is
going to access. Illustrate the calling flow as below

rtw89_phy_write_rf_v1() -+-> rtw89_phy_write_rf()   // old interface
                         +-> rtw89_phy_write_rf_a() // new interface

Signed-off-by: Chung-Hsuan Hung <hsuan8331@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c      | 110 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h      |   5 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  15 +++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   4 +
 4 files changed, 134 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index b75d08697a224..43d73ec3f7594 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -604,6 +604,12 @@ u8 rtw89_phy_get_txsc(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_phy_get_txsc);
 
+static bool rtw89_phy_check_swsi_busy(struct rtw89_dev *rtwdev)
+{
+	return !!rtw89_phy_read32_mask(rtwdev, R_SWSI_V1, B_SWSI_W_BUSY_V1) ||
+	       !!rtw89_phy_read32_mask(rtwdev, R_SWSI_V1, B_SWSI_R_BUSY_V1);
+}
+
 u32 rtw89_phy_read_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 		      u32 addr, u32 mask)
 {
@@ -626,6 +632,56 @@ u32 rtw89_phy_read_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 }
 EXPORT_SYMBOL(rtw89_phy_read_rf);
 
+static u32 rtw89_phy_read_rf_a(struct rtw89_dev *rtwdev,
+			       enum rtw89_rf_path rf_path, u32 addr, u32 mask)
+{
+	bool busy;
+	bool done;
+	u32 val;
+	int ret;
+
+	ret = read_poll_timeout_atomic(rtw89_phy_check_swsi_busy, busy, !busy,
+				       1, 30, false, rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "read rf busy swsi\n");
+		return INV_RF_DATA;
+	}
+
+	mask &= RFREG_MASK;
+
+	val = FIELD_PREP(B_SWSI_READ_ADDR_PATH_V1, rf_path) |
+	      FIELD_PREP(B_SWSI_READ_ADDR_ADDR_V1, addr);
+	rtw89_phy_write32_mask(rtwdev, R_SWSI_READ_ADDR_V1, B_SWSI_READ_ADDR_V1, val);
+	udelay(2);
+
+	ret = read_poll_timeout_atomic(rtw89_phy_read32_mask, done, done, 1,
+				       30, false, rtwdev, R_SWSI_V1,
+				       B_SWSI_R_DATA_DONE_V1);
+	if (ret) {
+		rtw89_err(rtwdev, "read swsi busy\n");
+		return INV_RF_DATA;
+	}
+
+	return rtw89_phy_read32_mask(rtwdev, R_SWSI_V1, mask);
+}
+
+u32 rtw89_phy_read_rf_v1(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
+			 u32 addr, u32 mask)
+{
+	bool ad_sel = FIELD_GET(RTW89_RF_ADDR_ADSEL_MASK, addr);
+
+	if (rf_path >= rtwdev->chip->rf_path_num) {
+		rtw89_err(rtwdev, "unsupported rf path (%d)\n", rf_path);
+		return INV_RF_DATA;
+	}
+
+	if (ad_sel)
+		return rtw89_phy_read_rf(rtwdev, rf_path, addr, mask);
+	else
+		return rtw89_phy_read_rf_a(rtwdev, rf_path, addr, mask);
+}
+EXPORT_SYMBOL(rtw89_phy_read_rf_v1);
+
 bool rtw89_phy_write_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 			u32 addr, u32 mask, u32 data)
 {
@@ -651,6 +707,60 @@ bool rtw89_phy_write_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 }
 EXPORT_SYMBOL(rtw89_phy_write_rf);
 
+static bool rtw89_phy_write_rf_a(struct rtw89_dev *rtwdev,
+				 enum rtw89_rf_path rf_path, u32 addr, u32 mask,
+				 u32 data)
+{
+	u8 bit_shift;
+	u32 val;
+	bool busy, b_msk_en = false;
+	int ret;
+
+	ret = read_poll_timeout_atomic(rtw89_phy_check_swsi_busy, busy, !busy,
+				       1, 30, false, rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "write rf busy swsi\n");
+		return false;
+	}
+
+	data &= RFREG_MASK;
+	mask &= RFREG_MASK;
+
+	if (mask != RFREG_MASK) {
+		b_msk_en = true;
+		rtw89_phy_write32_mask(rtwdev, R_SWSI_BIT_MASK_V1, RFREG_MASK,
+				       mask);
+		bit_shift = __ffs(mask);
+		data = (data << bit_shift) & RFREG_MASK;
+	}
+
+	val = FIELD_PREP(B_SWSI_DATA_BIT_MASK_EN_V1, b_msk_en) |
+	      FIELD_PREP(B_SWSI_DATA_PATH_V1, rf_path) |
+	      FIELD_PREP(B_SWSI_DATA_ADDR_V1, addr) |
+	      FIELD_PREP(B_SWSI_DATA_VAL_V1, data);
+
+	rtw89_phy_write32_mask(rtwdev, R_SWSI_DATA_V1, MASKDWORD, val);
+
+	return true;
+}
+
+bool rtw89_phy_write_rf_v1(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
+			   u32 addr, u32 mask, u32 data)
+{
+	bool ad_sel = FIELD_GET(RTW89_RF_ADDR_ADSEL_MASK, addr);
+
+	if (rf_path >= rtwdev->chip->rf_path_num) {
+		rtw89_err(rtwdev, "unsupported rf path (%d)\n", rf_path);
+		return false;
+	}
+
+	if (ad_sel)
+		return rtw89_phy_write_rf(rtwdev, rf_path, addr, mask, data);
+	else
+		return rtw89_phy_write_rf_a(rtwdev, rf_path, addr, mask, data);
+}
+EXPORT_SYMBOL(rtw89_phy_write_rf_v1);
+
 static void rtw89_phy_bb_reset(struct rtw89_dev *rtwdev,
 			       enum rtw89_phy_idx phy_idx)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index d6bc84ae6cd71..e600e01cbdd17 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -8,6 +8,7 @@
 #include "core.h"
 
 #define RTW89_PHY_ADDR_OFFSET	0x10000
+#define RTW89_RF_ADDR_ADSEL_MASK  BIT(16)
 
 #define get_phy_headline(addr)		FIELD_GET(GENMASK(31, 28), addr)
 #define PHY_HEADLINE_VALID	0xf
@@ -395,8 +396,12 @@ u8 rtw89_phy_get_txsc(struct rtw89_dev *rtwdev,
 		      enum rtw89_bandwidth dbw);
 u32 rtw89_phy_read_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 		      u32 addr, u32 mask);
+u32 rtw89_phy_read_rf_v1(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
+			 u32 addr, u32 mask);
 bool rtw89_phy_write_rf(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
 			u32 addr, u32 mask, u32 data);
+bool rtw89_phy_write_rf_v1(struct rtw89_dev *rtwdev, enum rtw89_rf_path rf_path,
+			   u32 addr, u32 mask, u32 data);
 void rtw89_phy_init_bb_reg(struct rtw89_dev *rtwdev);
 void rtw89_phy_init_rf_reg(struct rtw89_dev *rtwdev);
 void rtw89_phy_dm_init(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 09bf3afd6d9f5..26efdfa70c044 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -1805,6 +1805,17 @@
 #define B_ANAPAR_FLTRST BIT(22)
 #define B_ANAPAR_CRXBB GENMASK(18, 16)
 #define B_ANAPAR_14 GENMASK(15, 0)
+#define R_SWSI_DATA_V1 0x0370
+#define B_SWSI_DATA_VAL_V1 GENMASK(19, 0)
+#define B_SWSI_DATA_ADDR_V1 GENMASK(27, 20)
+#define B_SWSI_DATA_PATH_V1 GENMASK(30, 28)
+#define B_SWSI_DATA_BIT_MASK_EN_V1 BIT(31)
+#define R_SWSI_BIT_MASK_V1 0x0374
+#define B_SWSI_BIT_MASK_V1 GENMASK(19, 0)
+#define R_SWSI_READ_ADDR_V1 0x0378
+#define B_SWSI_READ_ADDR_ADDR_V1 GENMASK(7, 0)
+#define B_SWSI_READ_ADDR_PATH_V1 GENMASK(10, 8)
+#define B_SWSI_READ_ADDR_V1 GENMASK(10, 0)
 #define R_UPD_CLK_ADC 0x0700
 #define B_UPD_CLK_ADC_ON BIT(24)
 #define B_UPD_CLK_ADC_VAL GENMASK(26, 25)
@@ -1912,6 +1923,10 @@
 #define R_CFO_COMP_SEG0_H 0x1388
 #define R_CFO_COMP_SEG0_CTRL 0x138C
 #define R_DBG32_D 0x1730
+#define R_SWSI_V1 0x174C
+#define B_SWSI_W_BUSY_V1 BIT(24)
+#define B_SWSI_R_BUSY_V1 BIT(25)
+#define B_SWSI_R_DATA_DONE_V1 BIT(26)
 #define R_TX_COUNTER 0x1A40
 #define R_IFS_CLM_TX_CNT 0x1ACC
 #define B_IFS_CLM_EDCCA_EXCLUDE_CCA_FA_MSK GENMASK(31, 16)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index c74dedea511a4..173008b14c4d6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -5,6 +5,7 @@
 #include "debug.h"
 #include "fw.h"
 #include "mac.h"
+#include "phy.h"
 #include "reg.h"
 #include "rtw8852c.h"
 
@@ -484,6 +485,8 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.read_efuse		= rtw8852c_read_efuse,
 	.read_phycap		= rtw8852c_read_phycap,
 	.power_trim		= rtw8852c_power_trim,
+	.read_rf		= rtw89_phy_read_rf_v1,
+	.write_rf		= rtw89_phy_write_rf_v1,
 	.set_txpwr_ul_tb_offset	= rtw8852c_set_txpwr_ul_tb_offset,
 	.pwr_on_func		= rtw8852c_pwr_on_func,
 	.pwr_off_func		= rtw8852c_pwr_off_func,
@@ -494,6 +497,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.ops			= &rtw8852c_chip_ops,
 	.fw_name		= "rtw89/rtw8852c_fw.bin",
 	.dle_mem		= rtw8852c_dle_mem_pcie,
+	.rf_base_addr		= {0xe000, 0xf000},
 	.pwr_on_seq		= NULL,
 	.pwr_off_seq		= NULL,
 	.sec_ctrl_efuse_size	= 4,
-- 
2.25.1

