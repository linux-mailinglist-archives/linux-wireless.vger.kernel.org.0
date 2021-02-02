Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DDC30B76E
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Feb 2021 06:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbhBBFwH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Feb 2021 00:52:07 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:33970 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbhBBFwF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Feb 2021 00:52:05 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1125pH6E1018650, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 1125pH6E1018650
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 2 Feb 2021 13:51:17 +0800
Received: from localhost (172.21.236.51) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 2 Feb 2021
 13:51:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/3] rtw88: 8821c: Correct CCK RSSI
Date:   Tue, 2 Feb 2021 13:50:11 +0800
Message-ID: <20210202055012.8296-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210202055012.8296-1-pkshih@realtek.com>
References: <20210202055012.8296-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.236.51]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Guo-Feng Fan <vincent_fann@realtek.com>

Incorrect CCK RSSI may cause periodically scan from upper layer.

8821c phy status does NOT has actual value of CCK power. It provides only
lna and vga index. Driver have to use these indexes to calculate
actual RSSI.

Signed-off-by: Guo-Feng Fan <vincent_fann@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 46 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw88/rtw8821c.h |  8 ++++
 2 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 8f53afb67870..f0a56f56f0d5 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -15,6 +15,10 @@
 #include "debug.h"
 #include "bf.h"
 
+static const s8 lna_gain_table_0[8] = {22, 8, -6, -22, -31, -40, -46, -52};
+static const s8 lna_gain_table_1[16] = {10, 6, 2, -2, -6, -10, -14, -17,
+					-20, -24, -28, -31, -34, -37, -40, -44};
+
 static void rtw8821ce_efuse_parsing(struct rtw_efuse *efuse,
 				    struct rtw8821c_efuse *map)
 {
@@ -426,17 +430,49 @@ static void rtw8821c_set_channel(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 	rtw8821c_set_channel_rxdfir(rtwdev, bw);
 }
 
+static s8 get_cck_rx_pwr(struct rtw_dev *rtwdev, u8 lna_idx, u8 vga_idx)
+{
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	const s8 *lna_gain_table;
+	int lna_gain_table_size;
+	s8 rx_pwr_all = 0;
+	s8 lna_gain = 0;
+
+	if (efuse->rfe_option == 0) {
+		lna_gain_table = lna_gain_table_0;
+		lna_gain_table_size = ARRAY_SIZE(lna_gain_table_0);
+	} else {
+		lna_gain_table = lna_gain_table_1;
+		lna_gain_table_size = ARRAY_SIZE(lna_gain_table_1);
+	}
+
+	if (lna_idx >= lna_gain_table_size) {
+		rtw_info(rtwdev, "incorrect lna index (%d)\n", lna_idx);
+		return -120;
+	}
+
+	lna_gain = lna_gain_table[lna_idx];
+	rx_pwr_all = lna_gain - 2 * vga_idx;
+
+	return rx_pwr_all;
+}
+
 static void query_phy_status_page0(struct rtw_dev *rtwdev, u8 *phy_status,
 				   struct rtw_rx_pkt_stat *pkt_stat)
 {
-	s8 min_rx_power = -120;
-	u8 pwdb = GET_PHY_STAT_P0_PWDB(phy_status);
+	s8 rx_power;
+	u8 lna_idx = 0;
+	u8 vga_idx = 0;
 
-	pkt_stat->rx_power[RF_PATH_A] = pwdb - 100;
+	vga_idx = GET_PHY_STAT_P0_VGA(phy_status);
+	lna_idx = FIELD_PREP(BIT_LNA_H_MASK, GET_PHY_STAT_P0_LNA_H(phy_status)) |
+		  FIELD_PREP(BIT_LNA_L_MASK, GET_PHY_STAT_P0_LNA_L(phy_status));
+	rx_power = get_cck_rx_pwr(rtwdev, lna_idx, vga_idx);
+
+	pkt_stat->rx_power[RF_PATH_A] = rx_power;
 	pkt_stat->rssi = rtw_phy_rf_power_2_rssi(pkt_stat->rx_power, 1);
 	pkt_stat->bw = RTW_CHANNEL_WIDTH_20;
-	pkt_stat->signal_power = max(pkt_stat->rx_power[RF_PATH_A],
-				     min_rx_power);
+	pkt_stat->signal_power = rx_power;
 }
 
 static void query_phy_status_page1(struct rtw_dev *rtwdev, u8 *phy_status,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.h b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
index e11e3fc41c95..4d197541430d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.h
@@ -148,6 +148,14 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 /* phy status page0 */
 #define GET_PHY_STAT_P0_PWDB(phy_stat)                                         \
 	le32_get_bits(*((__le32 *)(phy_stat) + 0x00), GENMASK(15, 8))
+#define GET_PHY_STAT_P0_VGA(phy_stat)                                          \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x03), GENMASK(12, 8))
+#define GET_PHY_STAT_P0_LNA_L(phy_stat)                                        \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x03), GENMASK(15, 13))
+#define GET_PHY_STAT_P0_LNA_H(phy_stat)                                        \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x03), BIT(23))
+#define BIT_LNA_H_MASK BIT(3)
+#define BIT_LNA_L_MASK GENMASK(2, 0)
 
 /* phy status page1 */
 #define GET_PHY_STAT_P1_PWDB_A(phy_stat)                                       \
-- 
2.21.0

