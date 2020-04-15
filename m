Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03C21A99C2
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Apr 2020 11:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408507AbgDOJ70 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Apr 2020 05:59:26 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:47644 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405824AbgDOJ7Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Apr 2020 05:59:25 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03F9xF931005961, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03F9xF931005961
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Apr 2020 17:59:15 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 15 Apr 2020 17:59:15 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 15 Apr 2020 17:59:15 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH] rtw88: set power trim according to efuse PG values
Date:   Wed, 15 Apr 2020 17:59:12 +0800
Message-ID: <20200415095912.18194-2-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415095912.18194-1-yhchuang@realtek.com>
References: <20200415095912.18194-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

8822C devices have power trim, thermal and PA bias values
programmed in efuse. Driver should configure the RF components
according to the values.

If the power trim is not configured, then the devices might have
distortion on the output tx power.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/efuse.c    |  21 ++++
 drivers/net/wireless/realtek/rtw88/efuse.h    |   3 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 111 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.h |  28 +++++
 4 files changed, 163 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/efuse.c b/drivers/net/wireless/realtek/rtw88/efuse.c
index 212c8376a8c9..f037fa586915 100644
--- a/drivers/net/wireless/realtek/rtw88/efuse.c
+++ b/drivers/net/wireless/realtek/rtw88/efuse.c
@@ -116,6 +116,27 @@ static int rtw_dump_physical_efuse_map(struct rtw_dev *rtwdev, u8 *map)
 	return 0;
 }
 
+int rtw_read8_physical_efuse(struct rtw_dev *rtwdev, u16 addr, u8 *data)
+{
+	u32 efuse_ctl, cnt;
+
+	rtw_write32_mask(rtwdev, REG_EFUSE_CTRL, 0x3ff00, addr);
+	rtw_write32_clr(rtwdev, REG_EFUSE_CTRL, BIT_EF_FLAG);
+	cnt = 1000;
+	do {
+		mdelay(1);
+		efuse_ctl = rtw_read32(rtwdev, REG_EFUSE_CTRL);
+		if (--cnt == 0) {
+			*data = EFUSE_READ_FAIL;
+			return -EBUSY;
+		}
+	} while (!(efuse_ctl & BIT_EF_FLAG));
+
+	*data = rtw_read8(rtwdev, REG_EFUSE_CTRL);
+
+	return 0;
+}
+
 int rtw_parse_efuse_map(struct rtw_dev *rtwdev)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
diff --git a/drivers/net/wireless/realtek/rtw88/efuse.h b/drivers/net/wireless/realtek/rtw88/efuse.h
index 115bbe85946a..97a51f0b0e46 100644
--- a/drivers/net/wireless/realtek/rtw88/efuse.h
+++ b/drivers/net/wireless/realtek/rtw88/efuse.h
@@ -10,6 +10,8 @@
 #define EFUSE_HW_CAP_SUPP_BW80		7
 #define EFUSE_HW_CAP_SUPP_BW40		6
 
+#define EFUSE_READ_FAIL			0xff
+
 #define GET_EFUSE_HW_CAP_HCI(hw_cap)					       \
 	le32_get_bits(*((__le32 *)(hw_cap) + 0x01), GENMASK(3, 0))
 #define GET_EFUSE_HW_CAP_BW(hw_cap)					       \
@@ -22,5 +24,6 @@
 	le32_get_bits(*((__le32 *)(hw_cap) + 0x01), GENMASK(27, 26))
 
 int rtw_parse_efuse_map(struct rtw_dev *rtwdev);
+int rtw_read8_physical_efuse(struct rtw_dev *rtwdev, u16 addr, u8 *data);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index c99b1de54bfc..705a48de7fa3 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -15,6 +15,7 @@
 #include "debug.h"
 #include "util.h"
 #include "bf.h"
+#include "efuse.h"
 
 static void rtw8822c_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
 				     u8 rx_path, bool is_tx2_path);
@@ -1000,10 +1001,120 @@ static void rtw8822c_rf_x2_check(struct rtw_dev *rtwdev)
 	}
 }
 
+static void rtw8822c_set_power_trim(struct rtw_dev *rtwdev, s8 bb_gain[2][8])
+{
+#define RF_SET_POWER_TRIM(_path, _seq, _idx)					\
+		do {								\
+			rtw_write_rf(rtwdev, _path, 0x33, RFREG_MASK, _seq);	\
+			rtw_write_rf(rtwdev, _path, 0x3f, RFREG_MASK,		\
+				     bb_gain[_path][_idx]);			\
+		} while (0)
+	u8 path;
+
+	for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
+		rtw_write_rf(rtwdev, path, 0xee, BIT(19), 1);
+		RF_SET_POWER_TRIM(path, 0x0, 0);
+		RF_SET_POWER_TRIM(path, 0x1, 1);
+		RF_SET_POWER_TRIM(path, 0x2, 2);
+		RF_SET_POWER_TRIM(path, 0x3, 2);
+		RF_SET_POWER_TRIM(path, 0x4, 3);
+		RF_SET_POWER_TRIM(path, 0x5, 4);
+		RF_SET_POWER_TRIM(path, 0x6, 5);
+		RF_SET_POWER_TRIM(path, 0x7, 6);
+		RF_SET_POWER_TRIM(path, 0x8, 7);
+		RF_SET_POWER_TRIM(path, 0x9, 3);
+		RF_SET_POWER_TRIM(path, 0xa, 4);
+		RF_SET_POWER_TRIM(path, 0xb, 5);
+		RF_SET_POWER_TRIM(path, 0xc, 6);
+		RF_SET_POWER_TRIM(path, 0xd, 7);
+		RF_SET_POWER_TRIM(path, 0xe, 7);
+		rtw_write_rf(rtwdev, path, 0xee, BIT(19), 0);
+	}
+#undef RF_SET_POWER_TRIM
+}
+
+static void rtw8822c_power_trim(struct rtw_dev *rtwdev)
+{
+	u8 pg_pwr = 0xff, i, path, idx;
+	s8 bb_gain[2][8] = {0};
+	u16 rf_efuse_2g[3] = {PPG_2GL_TXAB, PPG_2GM_TXAB, PPG_2GH_TXAB};
+	u16 rf_efuse_5g[2][5] = {{PPG_5GL1_TXA, PPG_5GL2_TXA, PPG_5GM1_TXA,
+				  PPG_5GM2_TXA, PPG_5GH1_TXA},
+				 {PPG_5GL1_TXB, PPG_5GL2_TXB, PPG_5GM1_TXB,
+				  PPG_5GM2_TXB, PPG_5GH1_TXB} };
+	bool set = false;
+
+	for (i = 0; i < ARRAY_SIZE(rf_efuse_2g); i++) {
+		rtw_read8_physical_efuse(rtwdev, rf_efuse_2g[i], &pg_pwr);
+		if (pg_pwr == EFUSE_READ_FAIL)
+			continue;
+		set = true;
+		bb_gain[RF_PATH_A][i] = FIELD_GET(PPG_2G_A_MASK, pg_pwr);
+		bb_gain[RF_PATH_B][i] = FIELD_GET(PPG_2G_B_MASK, pg_pwr);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(rf_efuse_5g[0]); i++) {
+		for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
+			rtw_read8_physical_efuse(rtwdev, rf_efuse_5g[path][i],
+						 &pg_pwr);
+			if (pg_pwr == EFUSE_READ_FAIL)
+				continue;
+			set = true;
+			idx = i + ARRAY_SIZE(rf_efuse_2g);
+			bb_gain[path][idx] = FIELD_GET(PPG_5G_MASK, pg_pwr);
+		}
+	}
+	if (set)
+		rtw8822c_set_power_trim(rtwdev, bb_gain);
+}
+
+static void rtw8822c_thermal_trim(struct rtw_dev *rtwdev)
+{
+	u16 rf_efuse[2] = {PPG_THERMAL_A, PPG_THERMAL_B};
+	u8 pg_therm = 0xff, thermal[2] = {0}, path;
+
+	for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
+		rtw_read8_physical_efuse(rtwdev, rf_efuse[path], &pg_therm);
+		if (pg_therm == EFUSE_READ_FAIL)
+			return;
+		/* Efuse value of BIT(0) shall be move to BIT(3), and the value
+		 * of BIT(1) to BIT(3) should be right shifted 1 bit.
+		 */
+		thermal[path] = FIELD_GET(GENMASK(3, 1), pg_therm);
+		thermal[path] |= FIELD_PREP(BIT(3), pg_therm & BIT(0));
+		rtw_write_rf(rtwdev, path, 0x43, RF_THEMAL_MASK, thermal[path]);
+	}
+}
+
+static void rtw8822c_pa_bias(struct rtw_dev *rtwdev)
+{
+	u16 rf_efuse_2g[2] = {PPG_PABIAS_2GA, PPG_PABIAS_2GB};
+	u16 rf_efuse_5g[2] = {PPG_PABIAS_5GA, PPG_PABIAS_5GB};
+	u8 pg_pa_bias = 0xff, path;
+
+	for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
+		rtw_read8_physical_efuse(rtwdev, rf_efuse_2g[path],
+					 &pg_pa_bias);
+		if (pg_pa_bias == EFUSE_READ_FAIL)
+			return;
+		pg_pa_bias = FIELD_GET(PPG_PABIAS_MASK, pg_pa_bias);
+		rtw_write_rf(rtwdev, path, 0x60, RF_PABIAS_2G_MASK, pg_pa_bias);
+	}
+	for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
+		rtw_read8_physical_efuse(rtwdev, rf_efuse_5g[path],
+					 &pg_pa_bias);
+		pg_pa_bias = FIELD_GET(PPG_PABIAS_MASK, pg_pa_bias);
+		rtw_write_rf(rtwdev, path, 0x60, RF_PABIAS_5G_MASK, pg_pa_bias);
+	}
+}
+
 static void rtw8822c_rf_init(struct rtw_dev *rtwdev)
 {
 	rtw8822c_rf_dac_cal(rtwdev);
 	rtw8822c_rf_x2_check(rtwdev);
+	rtw8822c_thermal_trim(rtwdev);
+	rtw8822c_power_trim(rtwdev);
+	rtw8822c_pa_bias(rtwdev);
 }
 
 static void rtw8822c_pwrtrack_init(struct rtw_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
index dfd8662a0c0e..32b4771e04d0 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
@@ -309,4 +309,32 @@ const struct rtw_table name ## _tbl = {			\
 #define BIT_GS_PWSF		GENMASK(27, 0)
 #define BIT_RPT_DGAIN		GENMASK(27, 16)
 #define BIT_TX_CFIR		GENMASK(31, 30)
+
+#define PPG_THERMAL_A 0x1ef
+#define PPG_THERMAL_B 0x1b0
+#define RF_THEMAL_MASK GENMASK(19, 16)
+#define PPG_2GL_TXAB 0x1d4
+#define PPG_2GM_TXAB 0x1ee
+#define PPG_2GH_TXAB 0x1d2
+#define PPG_2G_A_MASK GENMASK(3, 0)
+#define PPG_2G_B_MASK GENMASK(7, 4)
+#define PPG_5GL1_TXA 0x1ec
+#define PPG_5GL2_TXA 0x1e8
+#define PPG_5GM1_TXA 0x1e4
+#define PPG_5GM2_TXA 0x1e0
+#define PPG_5GH1_TXA 0x1dc
+#define PPG_5GL1_TXB 0x1eb
+#define PPG_5GL2_TXB 0x1e7
+#define PPG_5GM1_TXB 0x1e3
+#define PPG_5GM2_TXB 0x1df
+#define PPG_5GH1_TXB 0x1db
+#define PPG_5G_MASK GENMASK(4, 0)
+#define PPG_PABIAS_2GA 0x1d6
+#define PPG_PABIAS_2GB 0x1d5
+#define PPG_PABIAS_5GA 0x1d8
+#define PPG_PABIAS_5GB 0x1d7
+#define PPG_PABIAS_MASK GENMASK(3, 0)
+#define RF_PABIAS_2G_MASK GENMASK(15, 12)
+#define RF_PABIAS_5G_MASK GENMASK(19, 16)
+
 #endif
-- 
2.17.1

