Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB3D4CF193
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 07:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbiCGGHE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 01:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbiCGGHD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 01:07:03 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2793D5F278
        for <linux-wireless@vger.kernel.org>; Sun,  6 Mar 2022 22:06:07 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22765xPtA022589, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22765xPtA022589
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Mar 2022 14:05:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 7 Mar 2022 14:05:59 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 7 Mar
 2022 14:05:58 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 08/13] rtw89: add chip_info::{h2c,c2h}_reg to support more chips
Date:   Mon, 7 Mar 2022 14:04:52 +0800
Message-ID: <20220307060457.56789-9-pkshih@realtek.com>
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

This is a register-based H2C/C2H interface to exchange data with firmware.
Since the register addresses of 8852A and 8852C are different, add fields
to chip_info to support this.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  4 ++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 20 ++++++++-----------
 drivers/net/wireless/realtek/rtw89/reg.h      | 11 ++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 15 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 15 ++++++++++++++
 5 files changed, 53 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 18e38cc3a6d22..14e8f48520b71 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2284,6 +2284,10 @@ struct rtw89_chip_info {
 	u8 ps_mode_supported;
 
 	u32 hci_func_en_addr;
+	u32 h2c_ctrl_reg;
+	const u32 *h2c_regs;
+	u32 c2h_ctrl_reg;
+	const u32 *c2h_regs;
 };
 
 union rtw89_bus_info {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 97224483f6188..2fe091cc12c0e 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1832,15 +1832,13 @@ void rtw89_fw_c2h_work(struct work_struct *work)
 static int rtw89_fw_write_h2c_reg(struct rtw89_dev *rtwdev,
 				  struct rtw89_mac_h2c_info *info)
 {
-	static const u32 h2c_reg[RTW89_H2CREG_MAX] = {
-		R_AX_H2CREG_DATA0, R_AX_H2CREG_DATA1,
-		R_AX_H2CREG_DATA2, R_AX_H2CREG_DATA3
-	};
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const u32 *h2c_reg = chip->h2c_regs;
 	u8 i, val, len;
 	int ret;
 
 	ret = read_poll_timeout(rtw89_read8, val, val == 0, 1000, 5000, false,
-				rtwdev, R_AX_H2CREG_CTRL);
+				rtwdev, chip->h2c_ctrl_reg);
 	if (ret) {
 		rtw89_warn(rtwdev, "FW does not process h2c registers\n");
 		return ret;
@@ -1854,7 +1852,7 @@ static int rtw89_fw_write_h2c_reg(struct rtw89_dev *rtwdev,
 	for (i = 0; i < RTW89_H2CREG_MAX; i++)
 		rtw89_write32(rtwdev, h2c_reg[i], info->h2creg[i]);
 
-	rtw89_write8(rtwdev, R_AX_H2CREG_CTRL, B_AX_H2CREG_TRIGGER);
+	rtw89_write8(rtwdev, chip->h2c_ctrl_reg, B_AX_H2CREG_TRIGGER);
 
 	return 0;
 }
@@ -1862,10 +1860,8 @@ static int rtw89_fw_write_h2c_reg(struct rtw89_dev *rtwdev,
 static int rtw89_fw_read_c2h_reg(struct rtw89_dev *rtwdev,
 				 struct rtw89_mac_c2h_info *info)
 {
-	static const u32 c2h_reg[RTW89_C2HREG_MAX] = {
-		R_AX_C2HREG_DATA0, R_AX_C2HREG_DATA1,
-		R_AX_C2HREG_DATA2, R_AX_C2HREG_DATA3
-	};
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const u32 *c2h_reg = chip->c2h_regs;
 	u32 ret;
 	u8 i, val;
 
@@ -1873,7 +1869,7 @@ static int rtw89_fw_read_c2h_reg(struct rtw89_dev *rtwdev,
 
 	ret = read_poll_timeout_atomic(rtw89_read8, val, val, 1,
 				       RTW89_C2H_TIMEOUT, false, rtwdev,
-				       R_AX_C2HREG_CTRL);
+				       chip->c2h_ctrl_reg);
 	if (ret) {
 		rtw89_warn(rtwdev, "c2h reg timeout\n");
 		return ret;
@@ -1882,7 +1878,7 @@ static int rtw89_fw_read_c2h_reg(struct rtw89_dev *rtwdev,
 	for (i = 0; i < RTW89_C2HREG_MAX; i++)
 		info->c2hreg[i] = rtw89_read32(rtwdev, c2h_reg[i]);
 
-	rtw89_write8(rtwdev, R_AX_C2HREG_CTRL, 0);
+	rtw89_write8(rtwdev, chip->c2h_ctrl_reg, 0);
 
 	info->id = RTW89_GET_C2H_HDR_FUNC(*info->c2hreg);
 	info->content_len = (RTW89_GET_C2H_HDR_LEN(*info->c2hreg) << 2) -
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 86b18dbbc7691..61f9899f02fc6 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -217,6 +217,17 @@
 #define B_AX_ASFF_FULL_NO_STK BIT(1)
 #define B_AX_EN_STUCK_DBG BIT(0)
 
+#define R_AX_H2CREG_DATA0_V1 0x7140
+#define R_AX_H2CREG_DATA1_V1 0x7144
+#define R_AX_H2CREG_DATA2_V1 0x7148
+#define R_AX_H2CREG_DATA3_V1 0x714C
+#define R_AX_C2HREG_DATA0_V1 0x7150
+#define R_AX_C2HREG_DATA1_V1 0x7154
+#define R_AX_C2HREG_DATA2_V1 0x7158
+#define R_AX_C2HREG_DATA3_V1 0x715C
+#define R_AX_H2CREG_CTRL_V1 0x7160
+#define R_AX_C2HREG_CTRL_V1 0x7164
+
 #define R_AX_HCI_FUNC_EN_V1 0x7880
 
 #define R_AX_PHYREG_SET 0x8040
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 86a5808a76c80..9db8a8f9dd180 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -3,6 +3,7 @@
  */
 
 #include "coex.h"
+#include "fw.h"
 #include "mac.h"
 #include "phy.h"
 #include "reg.h"
@@ -376,6 +377,16 @@ static const struct rtw89_pwr_cfg * const pwr_off_seq_8852a[] = {
 	rtw8852a_pwroff, NULL
 };
 
+static const u32 rtw8852a_h2c_regs[RTW89_H2CREG_MAX] = {
+	R_AX_H2CREG_DATA0, R_AX_H2CREG_DATA1,  R_AX_H2CREG_DATA2,
+	R_AX_H2CREG_DATA3
+};
+
+static const u32 rtw8852a_c2h_regs[RTW89_C2HREG_MAX] = {
+	R_AX_C2HREG_DATA0, R_AX_C2HREG_DATA1, R_AX_C2HREG_DATA2,
+	R_AX_C2HREG_DATA3
+};
+
 static void rtw8852ae_efuse_parsing(struct rtw89_efuse *efuse,
 				    struct rtw8852a_efuse *map)
 {
@@ -2058,6 +2069,10 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 				  BIT(RTW89_PS_MODE_CLK_GATED) |
 				  BIT(RTW89_PS_MODE_PWR_GATED),
 	.hci_func_en_addr	= R_AX_HCI_FUNC_EN,
+	.h2c_ctrl_reg		= R_AX_H2CREG_CTRL,
+	.h2c_regs		= rtw8852a_h2c_regs,
+	.c2h_ctrl_reg		= R_AX_C2HREG_CTRL,
+	.c2h_regs		= rtw8852a_c2h_regs,
 };
 EXPORT_SYMBOL(rtw8852a_chip_info);
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 3fa2dd4ff514c..2f5ec94be50f8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2,10 +2,21 @@
 /* Copyright(c) 2019-2022  Realtek Corporation
  */
 
+#include "fw.h"
 #include "mac.h"
 #include "reg.h"
 #include "rtw8852c.h"
 
+static const u32 rtw8852c_h2c_regs[RTW89_H2CREG_MAX] = {
+	R_AX_H2CREG_DATA0_V1, R_AX_H2CREG_DATA1_V1, R_AX_H2CREG_DATA2_V1,
+	R_AX_H2CREG_DATA3_V1
+};
+
+static const u32 rtw8852c_c2h_regs[RTW89_H2CREG_MAX] = {
+	R_AX_C2HREG_DATA0_V1, R_AX_C2HREG_DATA1_V1, R_AX_C2HREG_DATA2_V1,
+	R_AX_C2HREG_DATA3_V1
+};
+
 static int rtw8852c_pwr_on_func(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
@@ -195,6 +206,10 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.pwr_on_seq		= NULL,
 	.pwr_off_seq		= NULL,
 	.hci_func_en_addr	= R_AX_HCI_FUNC_EN_V1,
+	.h2c_ctrl_reg		= R_AX_H2CREG_CTRL_V1,
+	.h2c_regs		= rtw8852c_h2c_regs,
+	.c2h_ctrl_reg		= R_AX_C2HREG_CTRL_V1,
+	.c2h_regs		= rtw8852c_c2h_regs,
 };
 EXPORT_SYMBOL(rtw8852c_chip_info);
 
-- 
2.25.1

