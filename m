Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E732C4D52
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Nov 2020 03:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbgKZCMx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 25 Nov 2020 21:12:53 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:60675 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732908AbgKZCM2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 25 Nov 2020 21:12:28 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0AQ2CKQa8030316, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0AQ2CKQa8030316
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 26 Nov 2020 10:12:20 +0800
Received: from localhost.localdomain (172.21.69.213) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Thu, 26 Nov 2020 10:12:20 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <tony0620emma@gmail.com>, <ku920601@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 02/10] rtw88: coex: add debug message
Date:   Thu, 26 Nov 2020 10:10:51 +0800
Message-ID: <20201126021059.11981-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201126021059.11981-1-pkshih@realtek.com>
References: <20201126021059.11981-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.213]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

Add message for debugging usage and the program flow is no change.
Add a variable reserved for WLAN firmware synchronize.
Add a group of variable to save BT packet counter, it will be
assigned as mechanism judgment in the future. Now it is just for
debug usage.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.c  | 131 +++++++++++++++++++--
 drivers/net/wireless/realtek/rtw88/debug.c |  23 ++++
 drivers/net/wireless/realtek/rtw88/debug.h |   1 +
 drivers/net/wireless/realtek/rtw88/main.h  |   5 +
 4 files changed, 150 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.c b/drivers/net/wireless/realtek/rtw88/coex.c
index 7b69c7b01e22..33fef8530db7 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.c
+++ b/drivers/net/wireless/realtek/rtw88/coex.c
@@ -8,6 +8,7 @@
 #include "ps.h"
 #include "debug.h"
 #include "reg.h"
+#include "phy.h"
 
 static u8 rtw_coex_next_rssi_state(struct rtw_dev *rtwdev, u8 pre_state,
 				   u8 rssi, u8 rssi_thresh)
@@ -349,6 +350,10 @@ static void rtw_coex_check_rfk(struct rtw_dev *rtwdev)
 			if (!btk && !wlk)
 				break;
 
+			rtw_dbg(rtwdev, RTW_DBG_COEX,
+				"[BTCoex], (Before Ant Setup) wlk = %d, btk = %d\n",
+				wlk, btk);
+
 			mdelay(COEX_MIN_DELAY);
 		} while (++cnt < wait_cnt);
 
@@ -1054,7 +1059,8 @@ static void rtw_coex_tdma(struct rtw_dev *rtwdev, bool force, u32 tcase)
 	coex_dm->cur_ps_tdma_on = turn_on;
 	coex_dm->cur_ps_tdma = type;
 
-	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], coex tdma type (%d)\n", type);
+	rtw_dbg(rtwdev, RTW_DBG_COEX, "[BTCoex], coex tdma type(%s, %d)\n",
+		turn_on ? "on" : "off", type);
 }
 
 static void rtw_coex_set_ant_path(struct rtw_dev *rtwdev, bool force, u8 phase)
@@ -3016,6 +3022,81 @@ static const char *rtw_coex_get_reason_string(u8 reason)
 	}
 }
 
+static u8 rtw_coex_get_table_index(struct rtw_dev *rtwdev, u32 wl_reg_6c0,
+				   u32 wl_reg_6c4)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	u8 ans = 0xFF;
+	u8 n, i;
+	u32 load_bt_val;
+	u32 load_wl_val;
+	bool share_ant = efuse->share_ant;
+
+	if (share_ant)
+		n = chip->table_sant_num;
+	else
+		n = chip->table_nsant_num;
+
+	for (i = 0; i < n; i++) {
+		if (share_ant) {
+			load_bt_val = chip->table_sant[i].bt;
+			load_wl_val = chip->table_sant[i].wl;
+		} else {
+			load_bt_val = chip->table_nsant[i].bt;
+			load_wl_val = chip->table_nsant[i].wl;
+		}
+
+		if (wl_reg_6c0 == load_bt_val &&
+		    wl_reg_6c4 == load_wl_val) {
+			ans = i;
+			if (!share_ant)
+				ans += 100;
+			break;
+		}
+	}
+
+	return ans;
+}
+
+static u8 rtw_coex_get_tdma_index(struct rtw_dev *rtwdev, u8 *tdma_para)
+{
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	u8 ans = 0xFF;
+	u8 n, i, j;
+	u8 load_cur_tab_val;
+	bool valid = false;
+	bool share_ant = efuse->share_ant;
+
+	if (share_ant)
+		n = chip->tdma_sant_num;
+	else
+		n = chip->tdma_nsant_num;
+
+	for (i = 0; i < n; i++) {
+		valid = false;
+		for (j = 0; j < 5; j++) {
+			if (share_ant)
+				load_cur_tab_val = chip->tdma_sant[i].para[j];
+			else
+				load_cur_tab_val = chip->tdma_nsant[i].para[j];
+
+			if (*(tdma_para + j) != load_cur_tab_val)
+				break;
+
+			if (j == 4)
+				valid = true;
+		}
+		if (valid) {
+			ans = i;
+			break;
+		}
+	}
+
+	return ans;
+}
+
 static int rtw_coex_addr_info(struct rtw_dev *rtwdev,
 			      const struct rtw_reg_domain *reg,
 			      char addr_info[], int n)
@@ -3305,6 +3386,13 @@ void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
 	bt_lo_pri = rtw_read32(rtwdev, REG_BT_ACT_STATISTICS_1);
 	rtw_write8(rtwdev, REG_BT_COEX_ENH_INTR_CTRL,
 		   BIT_R_GRANTALL_WLMASK | BIT_STATIS_BT_EN);
+
+	coex_stat->hi_pri_tx = FIELD_GET(MASKLWORD, bt_hi_pri);
+	coex_stat->hi_pri_rx = FIELD_GET(MASKHWORD, bt_hi_pri);
+
+	coex_stat->lo_pri_tx = FIELD_GET(MASKLWORD, bt_lo_pri);
+	coex_stat->lo_pri_rx = FIELD_GET(MASKHWORD, bt_lo_pri);
+
 	sys_lte = rtw_read8(rtwdev, 0x73);
 	lte_coex = rtw_coex_read_indirect_reg(rtwdev, 0x38);
 	bt_coex = rtw_coex_read_indirect_reg(rtwdev, 0x54);
@@ -3356,15 +3444,17 @@ void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
 		   coex_stat->bt_slave ? "Slave" : "Master",
 		   coex_stat->cnt_bt[COEX_CNT_BT_ROLESWITCH],
 		   coex_dm->ignore_wl_act);
-	seq_printf(m, "%-40s = %u.%u/ 0x%x/ %c\n",
-		   "WL FW/ BT FW/ KT",
+	seq_printf(m, "%-40s = %u.%u/ 0x%x/ 0x%x/ %c\n",
+		   "WL FW/ BT FW/ BT FW Desired/ KT",
 		   fw->version, fw->sub_version,
-		   coex_stat->patch_ver, coex_stat->kt_ver + 65);
+		   coex_stat->patch_ver,
+		   chip->wl_fw_desired_ver, coex_stat->kt_ver + 65);
 	seq_printf(m, "%-40s = %u/ %u/ %u/ ch-(%u)\n",
 		   "AFH Map",
 		   coex_dm->wl_ch_info[0], coex_dm->wl_ch_info[1],
 		   coex_dm->wl_ch_info[2], hal->current_channel);
 
+	rtw_debugfs_get_simple_phy_info(m);
 	seq_printf(m, "**********************************************\n");
 	seq_printf(m, "\t\tBT Status\n");
 	seq_printf(m, "**********************************************\n");
@@ -3408,8 +3498,8 @@ void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
 		   score_board_WB, score_board_BW);
 	seq_printf(m, "%-40s = %u/%u, %u/%u\n",
 		   "Hi-Pri TX/RX, Lo-Pri TX/RX",
-		   bt_hi_pri & 0xffff, bt_hi_pri >> 16,
-		   bt_lo_pri & 0xffff, bt_lo_pri >> 16);
+		   coex_stat->hi_pri_tx, coex_stat->hi_pri_rx,
+		   coex_stat->lo_pri_tx, coex_stat->lo_pri_rx);
 	for (i = 0; i < COEX_BTINFO_SRC_BT_IQK; i++)
 		seq_printf(m, "%-40s = %7ph\n",
 			   rtw_coex_get_bt_info_src_string(i),
@@ -3438,9 +3528,11 @@ void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
 		seq_printf(m, "**********************************************\n");
 		seq_printf(m, "\t\tMechanism (Under Manual)\n");
 		seq_printf(m, "**********************************************\n");
-		seq_printf(m, "%-40s = %5ph\n",
+		seq_printf(m, "%-40s = %5ph (%d)\n",
 			   "TDMA Now",
-			   coex_dm->fw_tdma_para);
+			   coex_dm->fw_tdma_para,
+			   rtw_coex_get_tdma_index(rtwdev,
+						   &coex_dm->fw_tdma_para[0]));
 	} else {
 		seq_printf(m, "**********************************************\n");
 		seq_printf(m, "\t\tMechanism\n");
@@ -3454,9 +3546,11 @@ void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
 		   rtw_coex_get_wl_coex_mode(coex_stat->wl_coex_mode),
 		   coex->freerun ? "Yes" : "No",
 		   coex_stat->tdma_timer_base);
-	seq_printf(m, "%-40s = %d/ 0x%08x/ 0x%08x/ 0x%08x\n",
+	seq_printf(m, "%-40s = %d(%d)/ 0x%08x/ 0x%08x/ 0x%08x\n",
 		   "Table/ 0x6c0/ 0x6c4/ 0x6c8",
-		   coex_dm->cur_table, wl_reg_6c0, wl_reg_6c4, wl_reg_6c8);
+		   coex_dm->cur_table,
+		   rtw_coex_get_table_index(rtwdev, wl_reg_6c0, wl_reg_6c4),
+		   wl_reg_6c0, wl_reg_6c4, wl_reg_6c8);
 	seq_printf(m, "%-40s = 0x%08x/ 0x%08x/ %d/ reason (%s)\n",
 		   "0x778/ 0x6cc/ Run Count/ Reason",
 		   wl_reg_778, wl_reg_6cc,
@@ -3520,5 +3614,22 @@ void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m)
 		   coex_stat->wl_noisy_level);
 
 	rtw_coex_set_coexinfo_hw(rtwdev, m);
+	seq_printf(m, "%-40s = %d/ %d/ %d/ %d\n",
+		   "EVM A/ EVM B/ SNR A/ SNR B",
+		   -dm_info->rx_evm_dbm[RF_PATH_A],
+		   -dm_info->rx_evm_dbm[RF_PATH_B],
+		   -dm_info->rx_snr[RF_PATH_A],
+		   -dm_info->rx_snr[RF_PATH_B]);
+	seq_printf(m, "%-40s = %d/ %d/ %d/ %d\n",
+		   "CCK-CCA/CCK-FA/OFDM-CCA/OFDM-FA",
+		   dm_info->cck_cca_cnt, dm_info->cck_fa_cnt,
+		   dm_info->ofdm_cca_cnt, dm_info->ofdm_fa_cnt);
+	seq_printf(m, "%-40s = %d/ %d/ %d/ %d\n", "CRC OK CCK/11g/11n/11ac",
+		   dm_info->cck_ok_cnt, dm_info->ofdm_ok_cnt,
+		   dm_info->ht_ok_cnt, dm_info->vht_ok_cnt);
+	seq_printf(m, "%-40s = %d/ %d/ %d/ %d\n", "CRC Err CCK/11g/11n/11ac",
+		   dm_info->cck_err_cnt, dm_info->ofdm_err_cnt,
+		   dm_info->ht_err_cnt, dm_info->vht_err_cnt);
+
 }
 #endif /* CONFIG_RTW88_DEBUGFS */
diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 5974a8ef8b34..3344ac92a094 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -617,6 +617,29 @@ static int rtw_debugfs_get_tx_pwr_tbl(struct seq_file *m, void *v)
 	return 0;
 }
 
+void rtw_debugfs_get_simple_phy_info(struct seq_file *m)
+{
+	struct rtw_debugfs_priv *debugfs_priv = m->private;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	struct rtw_hal *hal = &rtwdev->hal;
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	struct rtw_traffic_stats *stats = &rtwdev->stats;
+
+	seq_printf(m, "%-40s = %ddBm/ %d\n", "RSSI/ STA Channel",
+		   dm_info->rssi[RF_PATH_A] - 100, hal->current_channel);
+
+	seq_printf(m, "TP {Tx, Rx} = {%u, %u}Mbps\n",
+		   stats->tx_throughput, stats->rx_throughput);
+
+	seq_puts(m, "[Tx Rate] = ");
+	rtw_print_rate(m, dm_info->tx_rate);
+	seq_printf(m, "(0x%x)\n", dm_info->tx_rate);
+
+	seq_puts(m, "[Rx Rate] = ");
+	rtw_print_rate(m, dm_info->curr_rx_rate);
+	seq_printf(m, "(0x%x)\n", dm_info->curr_rx_rate);
+}
+
 static int rtw_debugfs_get_phy_info(struct seq_file *m, void *v)
 {
 	struct rtw_debugfs_priv *debugfs_priv = m->private;
diff --git a/drivers/net/wireless/realtek/rtw88/debug.h b/drivers/net/wireless/realtek/rtw88/debug.h
index a0f36f29b4a6..e16e0da26e77 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.h
+++ b/drivers/net/wireless/realtek/rtw88/debug.h
@@ -26,6 +26,7 @@ enum rtw_debug_mask {
 #ifdef CONFIG_RTW88_DEBUGFS
 
 void rtw_debugfs_init(struct rtw_dev *rtwdev);
+void rtw_debugfs_get_simple_phy_info(struct seq_file *m);
 
 #else
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 3941aea51f9c..af5f2024251b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1198,6 +1198,7 @@ struct rtw_chip_info {
 	const struct coex_5g_afh_map *afh_5g;
 	const struct rtw_hw_reg *btg_reg;
 	const struct rtw_reg_domain *coex_info_hw_regs;
+	u32 wl_fw_desired_ver;
 };
 
 enum rtw_coex_bt_state_cnt {
@@ -1333,6 +1334,10 @@ struct rtw_coex_stat {
 
 	u32 bt_supported_version;
 	u32 bt_supported_feature;
+	u32 hi_pri_tx;
+	u32 hi_pri_rx;
+	u32 lo_pri_tx;
+	u32 lo_pri_rx;
 	u32 patch_ver;
 	u16 bt_reg_vendor_ae;
 	u16 bt_reg_vendor_ac;
-- 
2.21.0

