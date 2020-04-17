Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5E61AD7D1
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgDQHrX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:47:23 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37064 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729326AbgDQHrP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:47:15 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03H7l7hH5020159, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03H7l7hH5020159
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Apr 2020 15:47:07 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:04 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:04 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>,
        <briannorris@chromium.org>, <kevin_yang@realtek.com>
Subject: [PATCH 30/40] rtw88: 8723d: set ltecoex register address in chip_info
Date:   Fri, 17 Apr 2020 15:46:43 +0800
Message-ID: <20200417074653.15591-31-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417074653.15591-1-yhchuang@realtek.com>
References: <20200417074653.15591-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

Since 8723D use different address of ltecoex register, this commit add a
new field in chip_info and fill proper address. Then, ltecoex_read_reg()
and ltecoex_reg_write() can use them to access ltecoex according to chip.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     |  7 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  7 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |  3 +++
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  7 +++++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  7 +++++++
 drivers/net/wireless/realtek/rtw88/util.c     | 18 ++++++++++++------
 6 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 8ba8702457f4..35e2fb19ad56 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -517,6 +517,12 @@ struct rtw_hw_reg {
 	u32 mask;
 };
 
+struct rtw_ltecoex_addr {
+	u32 ctrl;
+	u32 wdata;
+	u32 rdata;
+};
+
 struct rtw_reg_domain {
 	u32 addr;
 	u32 mask;
@@ -1118,6 +1124,7 @@ struct rtw_chip_info {
 	u32 rf_sipi_addr[2];
 	const struct rtw_rf_sipi_addr *rf_sipi_read_addr;
 	u8 fix_rf_phy_num;
+	const struct rtw_ltecoex_addr *ltecoex_addr;
 
 	const struct rtw_table *mac_tbl;
 	const struct rtw_table *agc_tbl;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index e93f4f0e5676..27b595fd4640 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2333,6 +2333,12 @@ static const struct rtw_rf_sipi_addr rtw8723d_rf_sipi_addr[] = {
 			.hssi_2 = 0x82c, .lssi_read_pi = 0x8bc},
 };
 
+static const struct rtw_ltecoex_addr rtw8723d_ltecoex_addr = {
+	.ctrl = REG_LTECOEX_CTRL,
+	.wdata = REG_LTECOEX_WRITE_DATA,
+	.rdata = REG_LTECOEX_READ_DATA,
+};
+
 static const struct rtw_rfe_def rtw8723d_rfe_defs[] = {
 	[0] = { .phy_pg_tbl	= &rtw8723d_bb_pg_tbl,
 		.txpwr_lmt_tbl	= &rtw8723d_txpwr_lmt_tbl,},
@@ -2437,6 +2443,7 @@ struct rtw_chip_info rtw8723d_hw_spec = {
 	.rf_sipi_addr = {0x840, 0x844},
 	.rf_sipi_read_addr = rtw8723d_rf_sipi_addr,
 	.fix_rf_phy_num = 2,
+	.ltecoex_addr = &rtw8723d_ltecoex_addr,
 	.mac_tbl = &rtw8723d_mac_tbl,
 	.agc_tbl = &rtw8723d_agc_tbl,
 	.bb_tbl = &rtw8723d_bb_tbl,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.h b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
index a31cf9d85f69..2e20baf58530 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.h
@@ -114,6 +114,9 @@ static inline s32 iqk_mult(s32 x, s32 y, s32 *ext)
 
 #define REG_BTG_SEL		0x0067
 #define REG_LTECOEX_PATH_CONTROL	0x0070
+#define REG_LTECOEX_CTRL	0x07c0
+#define REG_LTECOEX_WRITE_DATA	0x07c4
+#define REG_LTECOEX_READ_DATA	0x07c8
 #define REG_PSDFN		0x0808
 #define REG_BB_PWR_SAV1_11N	0x0874
 #define REG_ANALOG_P4		0x088c
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index bd6a3f4399e1..c76cd0893d12 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2057,6 +2057,12 @@ static const struct rtw_hw_reg rtw8822b_dig[] = {
 	[1] = { .addr = 0xe50, .mask = 0x7f },
 };
 
+static const struct rtw_ltecoex_addr rtw8822b_ltecoex_addr = {
+	.ctrl = LTECOEX_ACCESS_CTRL,
+	.wdata = LTECOEX_WRITE_DATA,
+	.rdata = LTECOEX_READ_DATA,
+};
+
 static const struct rtw_page_table page_table_8822b[] = {
 	{64, 64, 64, 64, 1},
 	{64, 64, 64, 64, 1},
@@ -2455,6 +2461,7 @@ struct rtw_chip_info rtw8822b_hw_spec = {
 	.dig_cck = NULL,
 	.rf_base_addr = {0x2800, 0x2c00},
 	.rf_sipi_addr = {0xc90, 0xe90},
+	.ltecoex_addr = &rtw8822b_ltecoex_addr,
 	.mac_tbl = &rtw8822b_mac_tbl,
 	.agc_tbl = &rtw8822b_agc_tbl,
 	.bb_tbl = &rtw8822b_bb_tbl,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 38e90de14a3c..d2e74ac21d07 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -3793,6 +3793,12 @@ static const struct rtw_hw_reg rtw8822c_dig[] = {
 	[1] = { .addr = 0x1d70, .mask = 0x7f00 },
 };
 
+static const struct rtw_ltecoex_addr rtw8822c_ltecoex_addr = {
+	.ctrl = LTECOEX_ACCESS_CTRL,
+	.wdata = LTECOEX_WRITE_DATA,
+	.rdata = LTECOEX_READ_DATA,
+};
+
 static const struct rtw_page_table page_table_8822c[] = {
 	{64, 64, 64, 64, 1},
 	{64, 64, 64, 64, 1},
@@ -4203,6 +4209,7 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.dig_cck = NULL,
 	.rf_base_addr = {0x3c00, 0x4c00},
 	.rf_sipi_addr = {0x1808, 0x4108},
+	.ltecoex_addr = &rtw8822c_ltecoex_addr,
 	.mac_tbl = &rtw8822c_mac_tbl,
 	.agc_tbl = &rtw8822c_agc_tbl,
 	.bb_tbl = &rtw8822c_bb_tbl,
diff --git a/drivers/net/wireless/realtek/rtw88/util.c b/drivers/net/wireless/realtek/rtw88/util.c
index 10f1117c0cfb..42cf177cd445 100644
--- a/drivers/net/wireless/realtek/rtw88/util.c
+++ b/drivers/net/wireless/realtek/rtw88/util.c
@@ -22,22 +22,28 @@ bool check_hw_ready(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 target)
 
 bool ltecoex_read_reg(struct rtw_dev *rtwdev, u16 offset, u32 *val)
 {
-	if (!check_hw_ready(rtwdev, LTECOEX_ACCESS_CTRL, LTECOEX_READY, 1))
+	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_ltecoex_addr *ltecoex = chip->ltecoex_addr;
+
+	if (!check_hw_ready(rtwdev, ltecoex->ctrl, LTECOEX_READY, 1))
 		return false;
 
-	rtw_write32(rtwdev, LTECOEX_ACCESS_CTRL, 0x800F0000 | offset);
-	*val = rtw_read32(rtwdev, LTECOEX_READ_DATA);
+	rtw_write32(rtwdev, ltecoex->ctrl, 0x800F0000 | offset);
+	*val = rtw_read32(rtwdev, ltecoex->rdata);
 
 	return true;
 }
 
 bool ltecoex_reg_write(struct rtw_dev *rtwdev, u16 offset, u32 value)
 {
-	if (!check_hw_ready(rtwdev, LTECOEX_ACCESS_CTRL, LTECOEX_READY, 1))
+	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_ltecoex_addr *ltecoex = chip->ltecoex_addr;
+
+	if (!check_hw_ready(rtwdev, ltecoex->ctrl, LTECOEX_READY, 1))
 		return false;
 
-	rtw_write32(rtwdev, LTECOEX_WRITE_DATA, value);
-	rtw_write32(rtwdev, LTECOEX_ACCESS_CTRL, 0xC00F0000 | offset);
+	rtw_write32(rtwdev, ltecoex->wdata, value);
+	rtw_write32(rtwdev, ltecoex->ctrl, 0xC00F0000 | offset);
 
 	return true;
 }
-- 
2.17.1

