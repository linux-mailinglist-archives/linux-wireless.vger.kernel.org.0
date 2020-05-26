Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FED81AD7C1
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgDQHrL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:47:11 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37003 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729190AbgDQHrJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:47:09 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03H7l1Oi9020020, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03H7l1Oi9020020
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Apr 2020 15:47:01 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:00 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:00 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>,
        <briannorris@chromium.org>, <kevin_yang@realtek.com>
Subject: [PATCH 04/40] rtw88: 8723d: Add RF read/write ops
Date:   Fri, 17 Apr 2020 15:46:17 +0800
Message-ID: <20200417074653.15591-5-yhchuang@realtek.com>
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

8723D use SIPI to indirectly read RF register instead of directly read,
so introduce a new struct rtw_rf_sipi_addr and new function
rtw_phy_read_rf_sipi(). Since other chips don't use the new function,
only 8723D needs to fill struct rtw_rf_sipi_addr in rtw_chip_info.

Because there are two kinds of functions for reading RF registers now,
change rtw_phy_read_rf() to chip->ops->read_rf() in
rtw_phy_write_rf_reg_sipi() so that we can switch tp proper RF read
functions depends on the type of the chip.

Though 8723D is an 1x1 chip, it has two RF PHY and we can switch to
one of them, and that should be configured properly. Hence, add a
fix_rf_phy_num to struct rtw_chip_info to allow driver to set one of
the PHY's registers for 8723D, even it is only 1x1. Another variable
rf_phy_num is introduced to keep the constraint number of RF path we
can access, and its value is:
	rf_phy_num = (fix_rf_phy_num ? fix_rf_phy_num : rf_path_num)

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c     |  5 ++
 drivers/net/wireless/realtek/rtw88/main.h     | 10 ++++
 drivers/net/wireless/realtek/rtw88/phy.c      | 56 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw88/phy.h      |  6 ++
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 12 ++++
 5 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 6dfe4895c352..c851830132d0 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -472,6 +472,7 @@ static u8 hw_bw_cap_to_bitamp(u8 bw_cap)
 static void rtw_hw_config_rf_ant_num(struct rtw_dev *rtwdev, u8 hw_ant_num)
 {
 	struct rtw_hal *hal = &rtwdev->hal;
+	struct rtw_chip_info *chip = rtwdev->chip;
 
 	if (hw_ant_num == EFUSE_HW_CAP_IGNORE ||
 	    hw_ant_num >= hal->rf_path_num)
@@ -481,6 +482,8 @@ static void rtw_hw_config_rf_ant_num(struct rtw_dev *rtwdev, u8 hw_ant_num)
 	case 1:
 		hal->rf_type = RF_1T1R;
 		hal->rf_path_num = 1;
+		if (!chip->fix_rf_phy_num)
+			hal->rf_phy_num = hal->rf_path_num;
 		hal->antenna_tx = BB_PATH_A;
 		hal->antenna_rx = BB_PATH_A;
 		break;
@@ -1130,6 +1133,8 @@ static int rtw_chip_parameter_setup(struct rtw_dev *rtwdev)
 		hal->antenna_tx = BB_PATH_A;
 		hal->antenna_rx = BB_PATH_A;
 	}
+	hal->rf_phy_num = chip->fix_rf_phy_num ? chip->fix_rf_phy_num :
+			  hal->rf_path_num;
 
 	efuse->physical_size = chip->phy_efuse_size;
 	efuse->logical_size = chip->log_efuse_size;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index e852ab194315..8f15fc113af0 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -529,6 +529,13 @@ struct rtw_reg_domain {
 	u8 domain;
 };
 
+struct rtw_rf_sipi_addr {
+	u32 hssi_1;
+	u32 hssi_2;
+	u32 lssi_read;
+	u32 lssi_read_pi;
+};
+
 struct rtw_backup_info {
 	u8 len;
 	u32 reg;
@@ -1087,6 +1094,8 @@ struct rtw_chip_info {
 	const struct rtw_hw_reg *dig;
 	u32 rf_base_addr[2];
 	u32 rf_sipi_addr[2];
+	const struct rtw_rf_sipi_addr *rf_sipi_read_addr;
+	u8 fix_rf_phy_num;
 
 	const struct rtw_table *mac_tbl;
 	const struct rtw_table *agc_tbl;
@@ -1571,6 +1580,7 @@ struct rtw_hal {
 	u8 sec_ch_offset;
 	u8 rf_type;
 	u8 rf_path_num;
+	u8 rf_phy_num;
 	u32 antenna_tx;
 	u32 antenna_rx;
 	u8 bfee_sts_cap;
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 8793dd22188f..8489abfdc12e 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -679,7 +679,7 @@ u32 rtw_phy_read_rf(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 	const u32 *base_addr = chip->rf_base_addr;
 	u32 val, direct_addr;
 
-	if (rf_path >= hal->rf_path_num) {
+	if (rf_path >= hal->rf_phy_num) {
 		rtw_err(rtwdev, "unsupported rf path (%d)\n", rf_path);
 		return INV_RF_DATA;
 	}
@@ -693,6 +693,54 @@ u32 rtw_phy_read_rf(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 	return val;
 }
 
+u32 rtw_phy_read_rf_sipi(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
+			 u32 addr, u32 mask)
+{
+	struct rtw_hal *hal = &rtwdev->hal;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	const struct rtw_rf_sipi_addr *rf_sipi_addr;
+	const struct rtw_rf_sipi_addr *rf_sipi_addr_a;
+	u32 val32;
+	u32 en_pi;
+	u32 r_addr;
+	u32 shift;
+
+	if (rf_path >= hal->rf_phy_num) {
+		rtw_err(rtwdev, "unsupported rf path (%d)\n", rf_path);
+		return INV_RF_DATA;
+	}
+
+	if (!chip->rf_sipi_read_addr) {
+		rtw_err(rtwdev, "rf_sipi_read_addr isn't defined\n");
+		return INV_RF_DATA;
+	}
+
+	rf_sipi_addr = &chip->rf_sipi_read_addr[rf_path];
+	rf_sipi_addr_a = &chip->rf_sipi_read_addr[RF_PATH_A];
+
+	addr &= 0xff;
+
+	val32 = rtw_read32(rtwdev, rf_sipi_addr->hssi_2);
+	val32 = (val32 & ~LSSI_READ_ADDR_MASK) | (addr << 23);
+	rtw_write32(rtwdev, rf_sipi_addr->hssi_2, val32);
+
+	/* toggle read edge of path A */
+	val32 = rtw_read32(rtwdev, rf_sipi_addr_a->hssi_2);
+	rtw_write32(rtwdev, rf_sipi_addr_a->hssi_2, val32 & ~LSSI_READ_EDGE_MASK);
+	rtw_write32(rtwdev, rf_sipi_addr_a->hssi_2, val32 | LSSI_READ_EDGE_MASK);
+
+	udelay(120);
+
+	en_pi = rtw_read32_mask(rtwdev, rf_sipi_addr->hssi_1, BIT(8));
+	r_addr = en_pi ? rf_sipi_addr->lssi_read_pi : rf_sipi_addr->lssi_read;
+
+	val32 = rtw_read32_mask(rtwdev, r_addr, LSSI_READ_DATA_MASK);
+
+	shift = __ffs(mask);
+
+	return (val32 & mask) >> shift;
+}
+
 bool rtw_phy_write_rf_reg_sipi(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 			       u32 addr, u32 mask, u32 data)
 {
@@ -703,7 +751,7 @@ bool rtw_phy_write_rf_reg_sipi(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 	u32 old_data = 0;
 	u32 shift;
 
-	if (rf_path >= hal->rf_path_num) {
+	if (rf_path >= hal->rf_phy_num) {
 		rtw_err(rtwdev, "unsupported rf path (%d)\n", rf_path);
 		return false;
 	}
@@ -712,7 +760,7 @@ bool rtw_phy_write_rf_reg_sipi(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 	mask &= RFREG_MASK;
 
 	if (mask != RFREG_MASK) {
-		old_data = rtw_phy_read_rf(rtwdev, rf_path, addr, RFREG_MASK);
+		old_data = chip->ops->read_rf(rtwdev, rf_path, addr, RFREG_MASK);
 
 		if (old_data == INV_RF_DATA) {
 			rtw_err(rtwdev, "Write fail, rf is disabled\n");
@@ -740,7 +788,7 @@ bool rtw_phy_write_rf_reg(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 	const u32 *base_addr = chip->rf_base_addr;
 	u32 direct_addr;
 
-	if (rf_path >= hal->rf_path_num) {
+	if (rf_path >= hal->rf_phy_num) {
 		rtw_err(rtwdev, "unsupported rf path (%d)\n", rf_path);
 		return false;
 	}
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index af916d8784cd..413bf7165cc0 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -21,6 +21,8 @@ void rtw_phy_dynamic_mechanism(struct rtw_dev *rtwdev);
 u8 rtw_phy_rf_power_2_rssi(s8 *rf_power, u8 path_num);
 u32 rtw_phy_read_rf(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 		    u32 addr, u32 mask);
+u32 rtw_phy_read_rf_sipi(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
+			 u32 addr, u32 mask);
 bool rtw_phy_write_rf_reg_sipi(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
 			       u32 addr, u32 mask, u32 data);
 bool rtw_phy_write_rf_reg(struct rtw_dev *rtwdev, enum rtw_rf_path rf_path,
@@ -178,4 +180,8 @@ enum rtw_phy_cck_pd_lv {
 
 #define CCK_FA_AVG_RESET 0xffffffff
 
+#define LSSI_READ_ADDR_MASK	0x7f800000
+#define LSSI_READ_EDGE_MASK	0x80000000
+#define LSSI_READ_DATA_MASK	0xfffff
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 5b97730f1407..679c6c19516c 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -15,6 +15,8 @@
 #include "debug.h"
 
 static struct rtw_chip_ops rtw8723d_ops = {
+	.read_rf		= rtw_phy_read_rf_sipi,
+	.write_rf		= rtw_phy_write_rf_reg_sipi,
 	.set_antenna		= NULL,
 	.config_bfee		= NULL,
 	.set_gid_table		= NULL,
@@ -422,6 +424,13 @@ static const struct rtw_pwr_seq_cmd *card_disable_flow_8723d[] = {
 	NULL
 };
 
+static const struct rtw_rf_sipi_addr rtw8723d_rf_sipi_addr[] = {
+	[RF_PATH_A] = { .hssi_1 = 0x820, .lssi_read    = 0x8a0,
+			.hssi_2 = 0x824, .lssi_read_pi = 0x8b8},
+	[RF_PATH_B] = { .hssi_1 = 0x828, .lssi_read    = 0x8a4,
+			.hssi_2 = 0x82c, .lssi_read_pi = 0x8bc},
+};
+
 struct rtw_chip_info rtw8723d_hw_spec = {
 	.ops = &rtw8723d_ops,
 	.id = RTW_CHIP_TYPE_8723D,
@@ -444,6 +453,9 @@ struct rtw_chip_info rtw8723d_hw_spec = {
 	.sys_func_en = 0xFD,
 	.pwr_on_seq = card_enable_flow_8723d,
 	.pwr_off_seq = card_disable_flow_8723d,
+	.rf_sipi_addr = {0x840, 0x844},
+	.rf_sipi_read_addr = rtw8723d_rf_sipi_addr,
+	.fix_rf_phy_num = 2,
 };
 EXPORT_SYMBOL(rtw8723d_hw_spec);
 
-- 
2.17.1

