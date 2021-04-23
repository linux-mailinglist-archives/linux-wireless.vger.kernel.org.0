Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3BAA368E2B
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 09:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240999AbhDWHzy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 03:55:54 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:34619 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbhDWHzx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 03:55:53 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13N7tA8y9030471, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13N7tA8y9030471
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 23 Apr 2021 15:55:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 23 Apr 2021 15:55:10 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 23 Apr
 2021 15:55:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH v2 2/3] rtw88: add path diversity
Date:   Fri, 23 Apr 2021 15:54:41 +0800
Message-ID: <20210423075442.17498-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210423075442.17498-1-pkshih@realtek.com>
References: <20210423075442.17498-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMjMgpFekyCAwNjowMDowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/23/2021 07:32:30
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163299 [Apr 22 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 443 443 d64ad0ad6f66abd85f8fb55fe5d831fdcc4c44a0
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/23/2021 07:34:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/23/2021 07:36:31
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163299 [Apr 22 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 443 443 d64ad0ad6f66abd85f8fb55fe5d831fdcc4c44a0
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/23/2021 07:39:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

This feature chooses to transmit with antenna that has better signal
strength periodically under 1ss rate.

It can benefit connection quality in the following cases:
1. User is far away from the AP.
2. The far-field pattern of the antenna showed significant signal
strength difference.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: fix access address should be natural alignment
---
 drivers/net/wireless/realtek/rtw88/debug.h    |  1 +
 drivers/net/wireless/realtek/rtw88/main.h     | 15 ++++
 drivers/net/wireless/realtek/rtw88/phy.c      | 81 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/phy.h      |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 39 +++++++--
 5 files changed, 131 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.h b/drivers/net/wireless/realtek/rtw88/debug.h
index c8efd1900a34..0dd3f9a88c8d 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.h
+++ b/drivers/net/wireless/realtek/rtw88/debug.h
@@ -20,6 +20,7 @@ enum rtw_debug_mask {
 	RTW_DBG_BF		= 0x00000800,
 	RTW_DBG_WOW		= 0x00001000,
 	RTW_DBG_CFO		= 0x00002000,
+	RTW_DBG_PATH_DIV	= 0x00004000,
 
 	RTW_DBG_ALL		= 0xffffffff
 };
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 321667c03b16..02ad175055cb 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -841,6 +841,10 @@ struct rtw_chip_ops {
 			     u8 fixrate_en, u8 *new_rate);
 	void (*cfo_init)(struct rtw_dev *rtwdev);
 	void (*cfo_track)(struct rtw_dev *rtwdev);
+	void (*config_tx_path)(struct rtw_dev *rtwdev, u8 tx_path,
+			       enum rtw_bb_path tx_path_1ss,
+			       enum rtw_bb_path tx_path_cck,
+			       bool is_tx2_path);
 
 	/* for coex */
 	void (*coex_set_init)(struct rtw_dev *rtwdev);
@@ -1136,7 +1140,9 @@ struct rtw_chip_info {
 	u8 max_power_index;
 
 	u16 fw_fifo_addr[RTW_FW_FIFO_MAX];
+	u8 default_1ss_tx_path;
 
+	bool path_div_supported;
 	bool ht_supported;
 	bool vht_supported;
 	u8 lps_deep_mode_supported;
@@ -1781,6 +1787,14 @@ struct rtw_hal {
 		     [DESC_RATE_MAX];
 };
 
+struct rtw_path_div {
+	enum rtw_bb_path current_tx_path;
+	u32 path_a_sum;
+	u32 path_b_sum;
+	u16 path_a_cnt;
+	u16 path_b_cnt;
+};
+
 struct rtw_dev {
 	struct ieee80211_hw *hw;
 	struct device *dev;
@@ -1849,6 +1863,7 @@ struct rtw_dev {
 	DECLARE_BITMAP(flags, NUM_OF_RTW_FLAGS);
 
 	u8 mp_mode;
+	struct rtw_path_div dm_path_div;
 
 	struct rtw_fw_state wow_fw;
 	struct rtw_wow_param wow;
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 8146acaf1893..569dd3cfde35 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -127,6 +127,17 @@ static void rtw_phy_cfo_init(struct rtw_dev *rtwdev)
 		chip->ops->cfo_init(rtwdev);
 }
 
+static void rtw_phy_tx_path_div_init(struct rtw_dev *rtwdev)
+{
+	struct rtw_path_div *path_div = &rtwdev->dm_path_div;
+
+	path_div->current_tx_path = rtwdev->chip->default_1ss_tx_path;
+	path_div->path_a_cnt = 0;
+	path_div->path_a_sum = 0;
+	path_div->path_b_cnt = 0;
+	path_div->path_b_sum = 0;
+}
+
 void rtw_phy_init(struct rtw_dev *rtwdev)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
@@ -149,6 +160,7 @@ void rtw_phy_init(struct rtw_dev *rtwdev)
 
 	dm_info->iqk.done = false;
 	rtw_phy_cfo_init(rtwdev);
+	rtw_phy_tx_path_div_init(rtwdev);
 }
 EXPORT_SYMBOL(rtw_phy_init);
 
@@ -695,6 +707,7 @@ void rtw_phy_dynamic_mechanism(struct rtw_dev *rtwdev)
 	rtw_phy_dig(rtwdev);
 	rtw_phy_cck_pd(rtwdev);
 	rtw_phy_ra_track(rtwdev);
+	rtw_phy_tx_path_diversity(rtwdev);
 	rtw_phy_cfo_track(rtwdev);
 	rtw_phy_dpk_track(rtwdev);
 	rtw_phy_pwr_track(rtwdev);
@@ -2315,3 +2328,71 @@ bool rtw_phy_pwrtrack_need_iqk(struct rtw_dev *rtwdev)
 	return false;
 }
 EXPORT_SYMBOL(rtw_phy_pwrtrack_need_iqk);
+
+static void rtw_phy_set_tx_path_by_reg(struct rtw_dev *rtwdev,
+				       enum rtw_bb_path tx_path_sel_1ss)
+{
+	struct rtw_path_div *path_div = &rtwdev->dm_path_div;
+	enum rtw_bb_path tx_path_sel_cck = tx_path_sel_1ss;
+	struct rtw_chip_info *chip = rtwdev->chip;
+
+	if (tx_path_sel_1ss == path_div->current_tx_path)
+		return;
+
+	path_div->current_tx_path = tx_path_sel_1ss;
+	rtw_dbg(rtwdev, RTW_DBG_PATH_DIV, "Switch TX path=%s\n",
+		tx_path_sel_1ss == BB_PATH_A ? "A" : "B");
+	chip->ops->config_tx_path(rtwdev, rtwdev->hal.antenna_tx,
+				  tx_path_sel_1ss, tx_path_sel_cck, false);
+}
+
+static void rtw_phy_tx_path_div_select(struct rtw_dev *rtwdev)
+{
+	struct rtw_path_div *path_div = &rtwdev->dm_path_div;
+	enum rtw_bb_path path = path_div->current_tx_path;
+	s32 rssi_a = 0, rssi_b = 0;
+
+	if (path_div->path_a_cnt)
+		rssi_a = path_div->path_a_sum / path_div->path_a_cnt;
+	else
+		rssi_a = 0;
+	if (path_div->path_b_cnt)
+		rssi_b = path_div->path_b_sum / path_div->path_b_cnt;
+	else
+		rssi_b = 0;
+
+	if (rssi_a != rssi_b)
+		path = (rssi_a > rssi_b) ? BB_PATH_A : BB_PATH_B;
+
+	path_div->path_a_cnt = 0;
+	path_div->path_a_sum = 0;
+	path_div->path_b_cnt = 0;
+	path_div->path_b_sum = 0;
+	rtw_phy_set_tx_path_by_reg(rtwdev, path);
+}
+
+static void rtw_phy_tx_path_diversity_2ss(struct rtw_dev *rtwdev)
+{
+	if (rtwdev->hal.antenna_rx != BB_PATH_AB) {
+		rtw_dbg(rtwdev, RTW_DBG_PATH_DIV,
+			"[Return] tx_Path_en=%d, rx_Path_en=%d\n",
+			rtwdev->hal.antenna_tx, rtwdev->hal.antenna_rx);
+		return;
+	}
+	if (rtwdev->sta_cnt == 0) {
+		rtw_dbg(rtwdev, RTW_DBG_PATH_DIV, "No Link\n");
+		return;
+	}
+
+	rtw_phy_tx_path_div_select(rtwdev);
+}
+
+void rtw_phy_tx_path_diversity(struct rtw_dev *rtwdev)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+
+	if (!chip->path_div_supported)
+		return;
+
+	rtw_phy_tx_path_diversity_2ss(rtwdev);
+}
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index 0b6f2fc8193c..112ed125970a 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -61,6 +61,7 @@ void rtw_phy_config_swing_table(struct rtw_dev *rtwdev,
 				struct rtw_swing_table *swing_table);
 void rtw_phy_parsing_cfo(struct rtw_dev *rtwdev,
 			 struct rtw_rx_pkt_stat *pkt_stat);
+void rtw_phy_tx_path_diversity(struct rtw_dev *rtwdev);
 
 struct rtw_txpwr_lmt_cfg_pair {
 	u8 regd;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 6cb593cc33c2..b6b43654e5c6 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -80,6 +80,13 @@ static void rtw8822c_header_file_init(struct rtw_dev *rtwdev, bool pre)
 		rtw_write32_set(rtwdev, REG_ENCCK, BIT_CCK_OFDM_BLK_EN);
 }
 
+static void rtw8822c_bb_reset(struct rtw_dev *rtwdev)
+{
+	rtw_write16_set(rtwdev, REG_SYS_FUNC_EN, BIT_FEN_BB_RSTB);
+	rtw_write16_clr(rtwdev, REG_SYS_FUNC_EN, BIT_FEN_BB_RSTB);
+	rtw_write16_set(rtwdev, REG_SYS_FUNC_EN, BIT_FEN_BB_RSTB);
+}
+
 static void rtw8822c_dac_backup_reg(struct rtw_dev *rtwdev,
 				    struct rtw_backup_info *backup,
 				    struct rtw_backup_info *backup_rf)
@@ -2424,10 +2431,11 @@ static void rtw8822c_config_cck_tx_path(struct rtw_dev *rtwdev, u8 tx_path,
 		else
 			rtw_write32_mask(rtwdev, REG_RXCCKSEL, 0xf0000000, 0x8);
 	}
+	rtw8822c_bb_reset(rtwdev);
 }
 
 static void rtw8822c_config_ofdm_tx_path(struct rtw_dev *rtwdev, u8 tx_path,
-					 bool is_tx2_path)
+					 enum rtw_bb_path tx_path_sel_1ss)
 {
 	if (tx_path == BB_PATH_A) {
 		rtw_write32_mask(rtwdev, REG_ANTMAP0, 0xff, 0x11);
@@ -2436,21 +2444,28 @@ static void rtw8822c_config_ofdm_tx_path(struct rtw_dev *rtwdev, u8 tx_path,
 		rtw_write32_mask(rtwdev, REG_ANTMAP0, 0xff, 0x12);
 		rtw_write32_mask(rtwdev, REG_TXLGMAP, 0xff, 0x0);
 	} else {
-		if (is_tx2_path) {
+		if (tx_path_sel_1ss == BB_PATH_AB) {
 			rtw_write32_mask(rtwdev, REG_ANTMAP0, 0xff, 0x33);
 			rtw_write32_mask(rtwdev, REG_TXLGMAP, 0xffff, 0x0404);
-		} else {
+		} else if (tx_path_sel_1ss == BB_PATH_B) {
+			rtw_write32_mask(rtwdev, REG_ANTMAP0, 0xff, 0x32);
+			rtw_write32_mask(rtwdev, REG_TXLGMAP, 0xffff, 0x0400);
+		} else if (tx_path_sel_1ss == BB_PATH_A) {
 			rtw_write32_mask(rtwdev, REG_ANTMAP0, 0xff, 0x31);
 			rtw_write32_mask(rtwdev, REG_TXLGMAP, 0xffff, 0x0400);
 		}
 	}
+	rtw8822c_bb_reset(rtwdev);
 }
 
 static void rtw8822c_config_tx_path(struct rtw_dev *rtwdev, u8 tx_path,
+				    enum rtw_bb_path tx_path_sel_1ss,
+				    enum rtw_bb_path tx_path_cck,
 				    bool is_tx2_path)
 {
-	rtw8822c_config_cck_tx_path(rtwdev, tx_path, is_tx2_path);
-	rtw8822c_config_ofdm_tx_path(rtwdev, tx_path, is_tx2_path);
+	rtw8822c_config_cck_tx_path(rtwdev, tx_path_cck, is_tx2_path);
+	rtw8822c_config_ofdm_tx_path(rtwdev, tx_path, tx_path_sel_1ss);
+	rtw8822c_bb_reset(rtwdev);
 }
 
 static void rtw8822c_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
@@ -2466,7 +2481,8 @@ static void rtw8822c_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
 		rtw_write32_mask(rtwdev, REG_ORITXCODE2, MASK20BITS, 0x11111);
 
 	rtw8822c_config_rx_path(rtwdev, rx_path);
-	rtw8822c_config_tx_path(rtwdev, tx_path, is_tx2_path);
+	rtw8822c_config_tx_path(rtwdev, tx_path, BB_PATH_A, BB_PATH_A,
+				is_tx2_path);
 
 	rtw8822c_toggle_igi(rtwdev);
 }
@@ -2517,6 +2533,7 @@ static void query_phy_status_page0(struct rtw_dev *rtwdev, u8 *phy_status,
 static void query_phy_status_page1(struct rtw_dev *rtwdev, u8 *phy_status,
 				   struct rtw_rx_pkt_stat *pkt_stat)
 {
+	struct rtw_path_div *p_div = &rtwdev->dm_path_div;
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	u8 rxsc, bw;
 	s8 min_rx_power = -120;
@@ -2559,6 +2576,13 @@ static void query_phy_status_page1(struct rtw_dev *rtwdev, u8 *phy_status,
 	for (path = 0; path <= rtwdev->hal.rf_path_num; path++) {
 		rssi = rtw_phy_rf_power_2_rssi(&pkt_stat->rx_power[path], 1);
 		dm_info->rssi[path] = rssi;
+		if (path == RF_PATH_A) {
+			p_div->path_a_sum += rssi;
+			p_div->path_a_cnt++;
+		} else if (path == RF_PATH_B) {
+			p_div->path_b_sum += rssi;
+			p_div->path_b_cnt++;
+		}
 		dm_info->rx_snr[path] = pkt_stat->rx_snr[path] >> 1;
 		dm_info->cfo_tail[path] = (pkt_stat->cfo_tail[path] * 5) >> 1;
 
@@ -4851,6 +4875,7 @@ static struct rtw_chip_ops rtw8822c_ops = {
 	.cfg_csi_rate		= rtw_bf_cfg_csi_rate,
 	.cfo_init		= rtw8822c_cfo_init,
 	.cfo_track		= rtw8822c_cfo_track,
+	.config_tx_path		= rtw8822c_config_tx_path,
 
 	.coex_set_init		= rtw8822c_coex_cfg_init,
 	.coex_set_ant_switch	= NULL,
@@ -5192,6 +5217,8 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.band = RTW_BAND_2G | RTW_BAND_5G,
 	.page_size = 128,
 	.dig_min = 0x20,
+	.default_1ss_tx_path = BB_PATH_A,
+	.path_div_supported = true,
 	.ht_supported = true,
 	.vht_supported = true,
 	.lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK) | BIT(LPS_DEEP_MODE_PG),
-- 
2.21.0

