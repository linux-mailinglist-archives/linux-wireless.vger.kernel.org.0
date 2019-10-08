Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0120CF4EC
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2019 10:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730625AbfJHIVT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Oct 2019 04:21:19 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:47353 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730620AbfJHIVS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Oct 2019 04:21:18 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x988LB8F028162, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x988LB8F028162
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 8 Oct 2019 16:21:12 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 8 Oct 2019 16:21:11 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 10/10] rtw88: add phy_info debugfs to show Tx/Rx physical status
Date:   Tue, 8 Oct 2019 16:21:01 +0800
Message-ID: <20191008082101.2494-11-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191008082101.2494-1-yhchuang@realtek.com>
References: <20191008082101.2494-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tsang-Shian Lin <thlin@realtek.com>

This commit adds several Tx/Rx physical information to phy_info
debugfs for 8822B/8822C. By this debugfs, we can know physical
information, such as Tx/Rx rate, RSSI, EVM,SNR, etc. The
information is gotten from the packets of Tx/Rx path. It has
no impact for the performance of 8822B/8822C.

In the fields, we may meet different kinds of problems, but
we may have no professional instrument to check them. At
this moment, this debugfs is a good tool, and it may provide
useful information for debug.

Signed-off-by: Tsang-Shian Lin <thlin@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c    | 174 +++++++++++++++---
 drivers/net/wireless/realtek/rtw88/main.c     |  37 +++-
 drivers/net/wireless/realtek/rtw88/main.h     |  58 ++++++
 drivers/net/wireless/realtek/rtw88/phy.c      |   9 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  45 +++++
 drivers/net/wireless/realtek/rtw88/rtw8822b.h |  12 ++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  48 +++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.h |  12 ++
 drivers/net/wireless/realtek/rtw88/rx.c       |  69 ++++++-
 9 files changed, 431 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 6ad985e98e42..5a181e01ebef 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -498,12 +498,32 @@ static void rtw_print_vht_rate_txt(struct seq_file *m, u8 rate)
 	seq_printf(m, " VHT%uSMCS%u", n_ss, mcs_n);
 }
 
+static void rtw_print_rate(struct seq_file *m, u8 rate)
+{
+	switch (rate) {
+	case DESC_RATE1M...DESC_RATE11M:
+		rtw_print_cck_rate_txt(m, rate);
+		break;
+	case DESC_RATE6M...DESC_RATE54M:
+		rtw_print_ofdm_rate_txt(m, rate);
+		break;
+	case DESC_RATEMCS0...DESC_RATEMCS15:
+		rtw_print_ht_rate_txt(m, rate);
+		break;
+	case DESC_RATEVHT1SS_MCS0...DESC_RATEVHT2SS_MCS9:
+		rtw_print_vht_rate_txt(m, rate);
+		break;
+	default:
+		seq_printf(m, " Unknown rate=0x%x\n", rate);
+		break;
+	}
+}
+
 static int rtw_debugfs_get_tx_pwr_tbl(struct seq_file *m, void *v)
 {
 	struct rtw_debugfs_priv *debugfs_priv = m->private;
 	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw_hal *hal = &rtwdev->hal;
-	void (*print_rate)(struct seq_file *, u8) = NULL;
 	u8 path, rate;
 	struct rtw_power_params pwr_param = {0};
 	u8 bw = hal->current_band_width;
@@ -528,30 +548,11 @@ static int rtw_debugfs_get_tx_pwr_tbl(struct seq_file *m, void *v)
 			    rate < DESC_RATEVHT1SS_MCS0)
 				continue;
 
-			switch (rate) {
-			case DESC_RATE1M...DESC_RATE11M:
-				print_rate = rtw_print_cck_rate_txt;
-				break;
-			case DESC_RATE6M...DESC_RATE54M:
-				print_rate = rtw_print_ofdm_rate_txt;
-				break;
-			case DESC_RATEMCS0...DESC_RATEMCS15:
-				print_rate = rtw_print_ht_rate_txt;
-				break;
-			case DESC_RATEVHT1SS_MCS0...DESC_RATEVHT2SS_MCS9:
-				print_rate = rtw_print_vht_rate_txt;
-				break;
-			default:
-				print_rate = NULL;
-				break;
-			}
-
 			rtw_get_tx_power_params(rtwdev, path, rate, bw,
 						ch, regd, &pwr_param);
 
 			seq_printf(m, "%4c ", path + 'A');
-			if (print_rate)
-				print_rate(m, rate);
+			rtw_print_rate(m, rate);
 			seq_printf(m, " %3u(0x%02x) %4u %4d (%4d %4d)\n",
 				   hal->tx_pwr_tbl[path][rate],
 				   hal->tx_pwr_tbl[path][rate],
@@ -567,6 +568,132 @@ static int rtw_debugfs_get_tx_pwr_tbl(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int rtw_debugfs_get_phy_info(struct seq_file *m, void *v)
+{
+	struct rtw_debugfs_priv *debugfs_priv = m->private;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	struct rtw_traffic_stats *stats = &rtwdev->stats;
+	struct rtw_pkt_count *last_cnt = &dm_info->last_pkt_count;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+	struct ewma_evm *ewma_evm = dm_info->ewma_evm;
+	struct ewma_snr *ewma_snr = dm_info->ewma_snr;
+	u8 ss, rate_id;
+
+	seq_puts(m, "==========[Common Info]========\n");
+	seq_printf(m, "Is link = %c\n", rtw_is_assoc(rtwdev) ? 'Y' : 'N');
+	seq_printf(m, "Current CH(fc) = %u\n", rtwdev->hal.current_channel);
+	seq_printf(m, "Current BW = %u\n", rtwdev->hal.current_band_width);
+	seq_printf(m, "Current IGI = 0x%x\n", dm_info->igi_history[0]);
+	seq_printf(m, "TP {Tx, Rx} = {%u, %u}Mbps\n\n",
+		   stats->tx_throughput, stats->rx_throughput);
+
+	seq_puts(m, "==========[Tx Phy Info]========\n");
+	seq_puts(m, "[Tx Rate] = ");
+	rtw_print_rate(m, dm_info->tx_rate);
+	seq_printf(m, "(0x%x)\n\n", dm_info->tx_rate);
+
+	seq_puts(m, "==========[Rx Phy Info]========\n");
+	seq_printf(m, "[Rx Beacon Count] = %u\n", last_cnt->num_bcn_pkt);
+	seq_puts(m, "[Rx Rate] = ");
+	rtw_print_rate(m, dm_info->curr_rx_rate);
+	seq_printf(m, "(0x%x)\n", dm_info->curr_rx_rate);
+
+	seq_puts(m, "[Rx Rate Count]:\n");
+	seq_printf(m, " * CCK = {%u, %u, %u, %u}\n",
+		   last_cnt->num_qry_pkt[DESC_RATE1M],
+		   last_cnt->num_qry_pkt[DESC_RATE2M],
+		   last_cnt->num_qry_pkt[DESC_RATE5_5M],
+		   last_cnt->num_qry_pkt[DESC_RATE11M]);
+
+	seq_printf(m, " * OFDM = {%u, %u, %u, %u, %u, %u, %u, %u}\n",
+		   last_cnt->num_qry_pkt[DESC_RATE6M],
+		   last_cnt->num_qry_pkt[DESC_RATE9M],
+		   last_cnt->num_qry_pkt[DESC_RATE12M],
+		   last_cnt->num_qry_pkt[DESC_RATE18M],
+		   last_cnt->num_qry_pkt[DESC_RATE24M],
+		   last_cnt->num_qry_pkt[DESC_RATE36M],
+		   last_cnt->num_qry_pkt[DESC_RATE48M],
+		   last_cnt->num_qry_pkt[DESC_RATE54M]);
+
+	for (ss = 0; ss < efuse->hw_cap.nss; ss++) {
+		rate_id = DESC_RATEMCS0 + ss * 8;
+		seq_printf(m, " * HT_MCS[%u:%u] = {%u, %u, %u, %u, %u, %u, %u, %u}\n",
+			   ss * 8, ss * 8 + 7,
+			   last_cnt->num_qry_pkt[rate_id],
+			   last_cnt->num_qry_pkt[rate_id + 1],
+			   last_cnt->num_qry_pkt[rate_id + 2],
+			   last_cnt->num_qry_pkt[rate_id + 3],
+			   last_cnt->num_qry_pkt[rate_id + 4],
+			   last_cnt->num_qry_pkt[rate_id + 5],
+			   last_cnt->num_qry_pkt[rate_id + 6],
+			   last_cnt->num_qry_pkt[rate_id + 7]);
+	}
+
+	for (ss = 0; ss < efuse->hw_cap.nss; ss++) {
+		rate_id = DESC_RATEVHT1SS_MCS0 + ss * 10;
+		seq_printf(m, " * VHT_MCS-%uss MCS[0:9] = {%u, %u, %u, %u, %u, %u, %u, %u, %u, %u}\n",
+			   ss + 1,
+			   last_cnt->num_qry_pkt[rate_id],
+			   last_cnt->num_qry_pkt[rate_id + 1],
+			   last_cnt->num_qry_pkt[rate_id + 2],
+			   last_cnt->num_qry_pkt[rate_id + 3],
+			   last_cnt->num_qry_pkt[rate_id + 4],
+			   last_cnt->num_qry_pkt[rate_id + 5],
+			   last_cnt->num_qry_pkt[rate_id + 6],
+			   last_cnt->num_qry_pkt[rate_id + 7],
+			   last_cnt->num_qry_pkt[rate_id + 8],
+			   last_cnt->num_qry_pkt[rate_id + 9]);
+	}
+
+	seq_printf(m, "[RSSI(dBm)] = {%d, %d}\n",
+		   dm_info->rssi[RF_PATH_A] - 100,
+		   dm_info->rssi[RF_PATH_B] - 100);
+	seq_printf(m, "[Rx EVM(dB)] = {-%d, -%d}\n",
+		   dm_info->rx_evm_dbm[RF_PATH_A],
+		   dm_info->rx_evm_dbm[RF_PATH_B]);
+	seq_printf(m, "[Rx SNR] = {%d, %d}\n",
+		   dm_info->rx_snr[RF_PATH_A],
+		   dm_info->rx_snr[RF_PATH_B]);
+	seq_printf(m, "[CFO_tail(KHz)] = {%d, %d}\n",
+		   dm_info->cfo_tail[RF_PATH_A],
+		   dm_info->cfo_tail[RF_PATH_B]);
+
+	if (dm_info->curr_rx_rate >= DESC_RATE11M) {
+		seq_puts(m, "[Rx Average Status]:\n");
+		seq_printf(m, " * OFDM, EVM: {-%d}, SNR: {%d}\n",
+			   (u8)ewma_evm_read(&ewma_evm[RTW_EVM_OFDM]),
+			   (u8)ewma_snr_read(&ewma_snr[RTW_SNR_OFDM_A]));
+		seq_printf(m, " * 1SS, EVM: {-%d}, SNR: {%d}\n",
+			   (u8)ewma_evm_read(&ewma_evm[RTW_EVM_1SS]),
+			   (u8)ewma_snr_read(&ewma_snr[RTW_SNR_1SS_A]));
+		seq_printf(m, " * 2SS, EVM: {-%d, -%d}, SNR: {%d, %d}\n",
+			   (u8)ewma_evm_read(&ewma_evm[RTW_EVM_2SS_A]),
+			   (u8)ewma_evm_read(&ewma_evm[RTW_EVM_2SS_B]),
+			   (u8)ewma_snr_read(&ewma_snr[RTW_SNR_2SS_A]),
+			   (u8)ewma_snr_read(&ewma_snr[RTW_SNR_2SS_B]));
+	}
+
+	seq_puts(m, "[Rx Counter]:\n");
+	seq_printf(m, " * CCA (CCK, OFDM, Total) = (%u, %u, %u)\n",
+		   dm_info->cck_cca_cnt,
+		   dm_info->ofdm_cca_cnt,
+		   dm_info->total_cca_cnt);
+	seq_printf(m, " * False Alarm (CCK, OFDM, Total) = (%u, %u, %u)\n",
+		   dm_info->cck_fa_cnt,
+		   dm_info->ofdm_fa_cnt,
+		   dm_info->total_fa_cnt);
+	seq_printf(m, " * CCK cnt (ok, err) = (%u, %u)\n",
+		   dm_info->cck_ok_cnt, dm_info->cck_err_cnt);
+	seq_printf(m, " * OFDM cnt (ok, err) = (%u, %u)\n",
+		   dm_info->ofdm_ok_cnt, dm_info->ofdm_err_cnt);
+	seq_printf(m, " * HT cnt (ok, err) = (%u, %u)\n",
+		   dm_info->ht_ok_cnt, dm_info->ht_err_cnt);
+	seq_printf(m, " * VHT cnt (ok, err) = (%u, %u)\n",
+		   dm_info->vht_ok_cnt, dm_info->vht_err_cnt);
+	return 0;
+}
+
 #define rtw_debug_impl_mac(page, addr)				\
 static struct rtw_debugfs_priv rtw_debug_priv_mac_ ##page = {	\
 	.cb_read = rtw_debug_get_mac_page,			\
@@ -653,6 +780,10 @@ static struct rtw_debugfs_priv rtw_debug_priv_rsvd_page = {
 	.cb_read = rtw_debugfs_get_rsvd_page,
 };
 
+static struct rtw_debugfs_priv rtw_debug_priv_phy_info = {
+	.cb_read = rtw_debugfs_get_phy_info,
+};
+
 #define rtw_debugfs_add_core(name, mode, fopname, parent)		\
 	do {								\
 		rtw_debug_priv_ ##name.rtwdev = rtwdev;			\
@@ -682,6 +813,7 @@ void rtw_debugfs_init(struct rtw_dev *rtwdev)
 	rtw_debugfs_add_rw(rf_read);
 	rtw_debugfs_add_rw(dump_cam);
 	rtw_debugfs_add_rw(rsvd_page);
+	rtw_debugfs_add_r(phy_info);
 	rtw_debugfs_add_r(mac_0);
 	rtw_debugfs_add_r(mac_1);
 	rtw_debugfs_add_r(mac_2);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 71f11c973307..95a8dc81a0e4 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -181,6 +181,7 @@ static void rtw_watch_dog_work(struct work_struct *work)
 {
 	struct rtw_dev *rtwdev = container_of(work, struct rtw_dev,
 					      watch_dog_work.work);
+	struct rtw_traffic_stats *stats = &rtwdev->stats;
 	struct rtw_watch_dog_iter_data data = {};
 	bool busy_traffic = test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags);
 	bool ps_active;
@@ -201,17 +202,24 @@ static void rtw_watch_dog_work(struct work_struct *work)
 	if (busy_traffic != test_bit(RTW_FLAG_BUSY_TRAFFIC, rtwdev->flags))
 		rtw_coex_wl_status_change_notify(rtwdev);
 
-	if (rtwdev->stats.tx_cnt > RTW_LPS_THRESHOLD ||
-	    rtwdev->stats.rx_cnt > RTW_LPS_THRESHOLD)
+	if (stats->tx_cnt > RTW_LPS_THRESHOLD ||
+	    stats->rx_cnt > RTW_LPS_THRESHOLD)
 		ps_active = true;
 	else
 		ps_active = false;
 
+	ewma_tp_add(&stats->tx_ewma_tp,
+		    (u32)(stats->tx_unicast >> RTW_TP_SHIFT));
+	ewma_tp_add(&stats->rx_ewma_tp,
+		    (u32)(stats->rx_unicast >> RTW_TP_SHIFT));
+	stats->tx_throughput = ewma_tp_read(&stats->tx_ewma_tp);
+	stats->rx_throughput = ewma_tp_read(&stats->rx_ewma_tp);
+
 	/* reset tx/rx statictics */
-	rtwdev->stats.tx_unicast = 0;
-	rtwdev->stats.rx_unicast = 0;
-	rtwdev->stats.tx_cnt = 0;
-	rtwdev->stats.rx_cnt = 0;
+	stats->tx_unicast = 0;
+	stats->rx_unicast = 0;
+	stats->tx_cnt = 0;
+	stats->rx_cnt = 0;
 
 	if (test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
 		goto unlock;
@@ -1279,6 +1287,21 @@ int rtw_chip_info_setup(struct rtw_dev *rtwdev)
 }
 EXPORT_SYMBOL(rtw_chip_info_setup);
 
+static void rtw_stats_init(struct rtw_dev *rtwdev)
+{
+	struct rtw_traffic_stats *stats = &rtwdev->stats;
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	int i;
+
+	ewma_tp_init(&stats->tx_ewma_tp);
+	ewma_tp_init(&stats->rx_ewma_tp);
+
+	for (i = 0; i < RTW_EVM_NUM; i++)
+		ewma_evm_init(&dm_info->ewma_evm[i]);
+	for (i = 0; i < RTW_SNR_NUM; i++)
+		ewma_snr_init(&dm_info->ewma_snr[i]);
+}
+
 int rtw_core_init(struct rtw_dev *rtwdev)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
@@ -1327,6 +1350,8 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 	rtw_add_rsvd_page(rtwdev, RSVD_BEACON, false);
 	mutex_unlock(&rtwdev->mutex);
 
+	rtw_stats_init(rtwdev);
+
 	/* default rx filter setting */
 	rtwdev->hal.rcr = BIT_APP_FCS | BIT_APP_MIC | BIT_APP_ICV |
 			  BIT_HTC_LOC_CTRL | BIT_APP_PHYSTS |
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 74d16e49693b..c87ef1730d30 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -28,6 +28,8 @@
 #define RTW_RF_PATH_MAX			4
 #define HW_FEATURE_LEN			13
 
+#define RTW_TP_SHIFT			18 /* bytes/2s --> Mbps */
+
 extern bool rtw_bf_support;
 extern unsigned int rtw_fw_lps_deep_mode;
 extern unsigned int rtw_debug_mask;
@@ -326,6 +328,32 @@ enum rtw_flags {
 	NUM_OF_RTW_FLAGS,
 };
 
+enum rtw_evm {
+	RTW_EVM_OFDM = 0,
+	RTW_EVM_1SS,
+	RTW_EVM_2SS_A,
+	RTW_EVM_2SS_B,
+	/* keep it last */
+	RTW_EVM_NUM
+};
+
+enum rtw_snr {
+	RTW_SNR_OFDM_A = 0,
+	RTW_SNR_OFDM_B,
+	RTW_SNR_OFDM_C,
+	RTW_SNR_OFDM_D,
+	RTW_SNR_1SS_A,
+	RTW_SNR_1SS_B,
+	RTW_SNR_1SS_C,
+	RTW_SNR_1SS_D,
+	RTW_SNR_2SS_A,
+	RTW_SNR_2SS_B,
+	RTW_SNR_2SS_C,
+	RTW_SNR_2SS_D,
+	/* keep it last */
+	RTW_SNR_NUM
+};
+
 /* the power index is represented by differences, which cck-1s & ht40-1s are
  * the base values, so for 1s's differences, there are only ht20 & ofdm
  */
@@ -514,10 +542,16 @@ struct rtw_rx_pkt_stat {
 	s8 rx_power[RTW_RF_PATH_MAX];
 	u8 rssi;
 	u8 rxsc;
+	s8 rx_snr[RTW_RF_PATH_MAX];
+	u8 rx_evm[RTW_RF_PATH_MAX];
+	s8 cfo_tail[RTW_RF_PATH_MAX];
+
 	struct rtw_sta_info *si;
 	struct ieee80211_vif *vif;
 };
 
+DECLARE_EWMA(tp, 10, 2);
+
 struct rtw_traffic_stats {
 	/* units in bytes */
 	u64 tx_unicast;
@@ -530,6 +564,8 @@ struct rtw_traffic_stats {
 	/* units in Mbps */
 	u32 tx_throughput;
 	u32 rx_throughput;
+	struct ewma_tp tx_ewma_tp;
+	struct ewma_tp rx_ewma_tp;
 };
 
 enum rtw_lps_mode {
@@ -1237,10 +1273,21 @@ struct rtw_swing_table {
 	u8 *tdown[RTW_RF_PATH_MAX];
 };
 
+struct rtw_pkt_count {
+	u16 num_bcn_pkt;
+	u16 num_qry_pkt[DESC_RATE_MAX];
+};
+
+DECLARE_EWMA(evm, 10, 4);
+DECLARE_EWMA(snr, 10, 4);
+
 struct rtw_dm_info {
 	u32 cck_fa_cnt;
 	u32 ofdm_fa_cnt;
 	u32 total_fa_cnt;
+	u32 cck_cca_cnt;
+	u32 ofdm_cca_cnt;
+	u32 total_cca_cnt;
 
 	u32 cck_ok_cnt;
 	u32 cck_err_cnt;
@@ -1283,6 +1330,17 @@ struct rtw_dm_info {
 	/* [bandwidth 0:20M/1:40M][number of path] */
 	u8 cck_pd_lv[2][RTW_RF_PATH_MAX];
 	u32 cck_fa_avg;
+
+	/* save the last rx phy status for debug */
+	s8 rx_snr[RTW_RF_PATH_MAX];
+	u8 rx_evm_dbm[RTW_RF_PATH_MAX];
+	s16 cfo_tail[RTW_RF_PATH_MAX];
+	u8 rssi[RTW_RF_PATH_MAX];
+	u8 curr_rx_rate;
+	struct rtw_pkt_count cur_pkt_count;
+	struct rtw_pkt_count last_pkt_count;
+	struct ewma_evm ewma_evm[RTW_EVM_NUM];
+	struct ewma_snr ewma_snr[RTW_SNR_NUM];
 };
 
 struct rtw_efuse {
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index e9c50a274f48..41a458c649a0 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -222,10 +222,19 @@ static void rtw_phy_stat_rssi(struct rtw_dev *rtwdev)
 	dm_info->min_rssi = data.min_rssi;
 }
 
+static void rtw_phy_stat_rate_cnt(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+
+	dm_info->last_pkt_count = dm_info->cur_pkt_count;
+	memset(&dm_info->cur_pkt_count, 0, sizeof(dm_info->cur_pkt_count));
+}
+
 static void rtw_phy_statistics(struct rtw_dev *rtwdev)
 {
 	rtw_phy_stat_rssi(rtwdev);
 	rtw_phy_stat_false_alarm(rtwdev);
+	rtw_phy_stat_rate_cnt(rtwdev);
 }
 
 #define DIG_PERF_FA_TH_LOW			250
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index f3ef5913ae81..72091c08e412 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -820,6 +820,7 @@ static void rtw8822b_config_trx_mode(struct rtw_dev *rtwdev, u8 tx_path,
 static void query_phy_status_page0(struct rtw_dev *rtwdev, u8 *phy_status,
 				   struct rtw_rx_pkt_stat *pkt_stat)
 {
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	s8 min_rx_power = -120;
 	u8 pwdb = GET_PHY_STAT_P0_PWDB(phy_status);
 
@@ -829,13 +830,19 @@ static void query_phy_status_page0(struct rtw_dev *rtwdev, u8 *phy_status,
 	pkt_stat->bw = RTW_CHANNEL_WIDTH_20;
 	pkt_stat->signal_power = max(pkt_stat->rx_power[RF_PATH_A],
 				     min_rx_power);
+	dm_info->rssi[RF_PATH_A] = pkt_stat->rssi;
 }
 
 static void query_phy_status_page1(struct rtw_dev *rtwdev, u8 *phy_status,
 				   struct rtw_rx_pkt_stat *pkt_stat)
 {
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	u8 rxsc, bw;
 	s8 min_rx_power = -120;
+	s8 rx_evm;
+	u8 evm_dbm = 0;
+	u8 rssi;
+	int path;
 
 	if (pkt_stat->rate > DESC_RATE11M && pkt_stat->rate < DESC_RATEMCS0)
 		rxsc = GET_PHY_STAT_P1_L_RXSC(phy_status);
@@ -858,6 +865,34 @@ static void query_phy_status_page1(struct rtw_dev *rtwdev, u8 *phy_status,
 	pkt_stat->signal_power = max3(pkt_stat->rx_power[RF_PATH_A],
 				      pkt_stat->rx_power[RF_PATH_B],
 				      min_rx_power);
+
+	dm_info->curr_rx_rate = pkt_stat->rate;
+
+	pkt_stat->rx_evm[RF_PATH_A] = GET_PHY_STAT_P1_RXEVM_A(phy_status);
+	pkt_stat->rx_evm[RF_PATH_B] = GET_PHY_STAT_P1_RXEVM_B(phy_status);
+
+	pkt_stat->rx_snr[RF_PATH_A] = GET_PHY_STAT_P1_RXSNR_A(phy_status);
+	pkt_stat->rx_snr[RF_PATH_B] = GET_PHY_STAT_P1_RXSNR_B(phy_status);
+
+	pkt_stat->cfo_tail[RF_PATH_A] = GET_PHY_STAT_P1_CFO_TAIL_A(phy_status);
+	pkt_stat->cfo_tail[RF_PATH_B] = GET_PHY_STAT_P1_CFO_TAIL_B(phy_status);
+
+	for (path = 0; path <= rtwdev->hal.rf_path_num; path++) {
+		rssi = rtw_phy_rf_power_2_rssi(&pkt_stat->rx_power[path], 1);
+		dm_info->rssi[path] = rssi;
+		dm_info->rx_snr[path] = pkt_stat->rx_snr[path] >> 1;
+		dm_info->cfo_tail[path] = (pkt_stat->cfo_tail[path] * 5) >> 1;
+
+		rx_evm = pkt_stat->rx_evm[path];
+
+		if (rx_evm < 0) {
+			evm_dbm = ((u8)-rx_evm >> 1);
+
+			if (evm_dbm == 64)
+				evm_dbm = 0;
+		}
+		dm_info->rx_evm_dbm[path] = evm_dbm;
+	}
 }
 
 static void query_phy_status(struct rtw_dev *rtwdev, u8 *phy_status,
@@ -1004,6 +1039,7 @@ static void rtw8822b_false_alarm_statistics(struct rtw_dev *rtwdev)
 	u32 cck_fa_cnt;
 	u32 ofdm_fa_cnt;
 	u32 crc32_cnt;
+	u32 cca32_cnt;
 
 	cck_enable = rtw_read32(rtwdev, 0x808) & BIT(28);
 	cck_fa_cnt = rtw_read16(rtwdev, 0xa5c);
@@ -1027,6 +1063,15 @@ static void rtw8822b_false_alarm_statistics(struct rtw_dev *rtwdev)
 	dm_info->vht_ok_cnt = crc32_cnt & 0xffff;
 	dm_info->vht_err_cnt = (crc32_cnt & 0xffff0000) >> 16;
 
+	cca32_cnt = rtw_read32(rtwdev, 0xf08);
+	dm_info->ofdm_cca_cnt = ((cca32_cnt & 0xffff0000) >> 16);
+	dm_info->total_cca_cnt = dm_info->ofdm_cca_cnt;
+	if (cck_enable) {
+		cca32_cnt = rtw_read32(rtwdev, 0xfcc);
+		dm_info->cck_cca_cnt = cca32_cnt & 0xffff;
+		dm_info->total_cca_cnt += dm_info->cck_cca_cnt;
+	}
+
 	rtw_write32_set(rtwdev, 0x9a4, BIT(17));
 	rtw_write32_clr(rtwdev, 0x9a4, BIT(17));
 	rtw_write32_clr(rtwdev, 0xa2c, BIT(15));
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.h b/drivers/net/wireless/realtek/rtw88/rtw8822b.h
index 0cb93d7d4cfd..6211f4b547b9 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.h
@@ -127,6 +127,18 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 	le32_get_bits(*((__le32 *)(phy_stat) + 0x01), GENMASK(11, 8))
 #define GET_PHY_STAT_P1_HT_RXSC(phy_stat)                                      \
 	le32_get_bits(*((__le32 *)(phy_stat) + 0x01), GENMASK(15, 12))
+#define GET_PHY_STAT_P1_RXEVM_A(phy_stat)                                      \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x04), GENMASK(7, 0))
+#define GET_PHY_STAT_P1_RXEVM_B(phy_stat)                                      \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x04), GENMASK(15, 8))
+#define GET_PHY_STAT_P1_CFO_TAIL_A(phy_stat)                                 \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x05), GENMASK(7, 0))
+#define GET_PHY_STAT_P1_CFO_TAIL_B(phy_stat)                                 \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x05), GENMASK(15, 8))
+#define GET_PHY_STAT_P1_RXSNR_A(phy_stat)                                      \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x06), GENMASK(7, 0))
+#define GET_PHY_STAT_P1_RXSNR_B(phy_stat)                                      \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x06), GENMASK(15, 8))
 
 #define REG_HTSTFWT	0x800
 #define REG_RXPSEL	0x808
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 4c8916516064..41cf989bcf88 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1643,6 +1643,8 @@ static void query_phy_status_page0(struct rtw_dev *rtwdev, u8 *phy_status,
 	u8 gain_a, gain_b;
 	s8 rx_power[RTW_RF_PATH_MAX];
 	s8 min_rx_power = -120;
+	u8 rssi;
+	int path;
 
 	rx_power[RF_PATH_A] = GET_PHY_STAT_P0_PWDB_A(phy_status);
 	rx_power[RF_PATH_B] = GET_PHY_STAT_P0_PWDB_B(phy_status);
@@ -1665,6 +1667,11 @@ static void query_phy_status_page0(struct rtw_dev *rtwdev, u8 *phy_status,
 	pkt_stat->rx_power[RF_PATH_A] = rx_power[RF_PATH_A];
 	pkt_stat->rx_power[RF_PATH_B] = rx_power[RF_PATH_B];
 
+	for (path = 0; path <= rtwdev->hal.rf_path_num; path++) {
+		rssi = rtw_phy_rf_power_2_rssi(&pkt_stat->rx_power[path], 1);
+		dm_info->rssi[path] = rssi;
+	}
+
 	pkt_stat->rssi = rtw_phy_rf_power_2_rssi(pkt_stat->rx_power, 1);
 	pkt_stat->bw = RTW_CHANNEL_WIDTH_20;
 	pkt_stat->signal_power = max(pkt_stat->rx_power[RF_PATH_A],
@@ -1674,8 +1681,13 @@ static void query_phy_status_page0(struct rtw_dev *rtwdev, u8 *phy_status,
 static void query_phy_status_page1(struct rtw_dev *rtwdev, u8 *phy_status,
 				   struct rtw_rx_pkt_stat *pkt_stat)
 {
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	u8 rxsc, bw;
 	s8 min_rx_power = -120;
+	s8 rx_evm;
+	u8 evm_dbm = 0;
+	u8 rssi;
+	int path;
 
 	if (pkt_stat->rate > DESC_RATE11M && pkt_stat->rate < DESC_RATEMCS0)
 		rxsc = GET_PHY_STAT_P1_L_RXSC(phy_status);
@@ -1696,6 +1708,34 @@ static void query_phy_status_page1(struct rtw_dev *rtwdev, u8 *phy_status,
 	pkt_stat->signal_power = max3(pkt_stat->rx_power[RF_PATH_A],
 				      pkt_stat->rx_power[RF_PATH_B],
 				      min_rx_power);
+
+	dm_info->curr_rx_rate = pkt_stat->rate;
+
+	pkt_stat->rx_evm[RF_PATH_A] = GET_PHY_STAT_P1_RXEVM_A(phy_status);
+	pkt_stat->rx_evm[RF_PATH_B] = GET_PHY_STAT_P1_RXEVM_B(phy_status);
+
+	pkt_stat->rx_snr[RF_PATH_A] = GET_PHY_STAT_P1_RXSNR_A(phy_status);
+	pkt_stat->rx_snr[RF_PATH_B] = GET_PHY_STAT_P1_RXSNR_B(phy_status);
+
+	pkt_stat->cfo_tail[RF_PATH_A] = GET_PHY_STAT_P1_CFO_TAIL_A(phy_status);
+	pkt_stat->cfo_tail[RF_PATH_B] = GET_PHY_STAT_P1_CFO_TAIL_B(phy_status);
+
+	for (path = 0; path <= rtwdev->hal.rf_path_num; path++) {
+		rssi = rtw_phy_rf_power_2_rssi(&pkt_stat->rx_power[path], 1);
+		dm_info->rssi[path] = rssi;
+		dm_info->rx_snr[path] = pkt_stat->rx_snr[path] >> 1;
+		dm_info->cfo_tail[path] = (pkt_stat->cfo_tail[path] * 5) >> 1;
+
+		rx_evm = pkt_stat->rx_evm[path];
+
+		if (rx_evm < 0) {
+			evm_dbm = ((u8)-rx_evm >> 1);
+
+			if (evm_dbm == 64)
+				evm_dbm = 0;
+		}
+		dm_info->rx_evm_dbm[path] = evm_dbm;
+	}
 }
 
 static void query_phy_status(struct rtw_dev *rtwdev, u8 *phy_status,
@@ -1850,6 +1890,7 @@ static void rtw8822c_false_alarm_statistics(struct rtw_dev *rtwdev)
 	u32 cck_enable;
 	u32 cck_fa_cnt;
 	u32 crc32_cnt;
+	u32 cca32_cnt;
 	u32 ofdm_fa_cnt;
 	u32 ofdm_fa_cnt1, ofdm_fa_cnt2, ofdm_fa_cnt3, ofdm_fa_cnt4, ofdm_fa_cnt5;
 	u16 parity_fail, rate_illegal, crc8_fail, mcs_fail, sb_search_fail,
@@ -1894,6 +1935,13 @@ static void rtw8822c_false_alarm_statistics(struct rtw_dev *rtwdev)
 	dm_info->vht_ok_cnt = crc32_cnt & 0xffff;
 	dm_info->vht_err_cnt = (crc32_cnt & 0xffff0000) >> 16;
 
+	cca32_cnt = rtw_read32(rtwdev, 0x2c08);
+	dm_info->ofdm_cca_cnt = ((cca32_cnt & 0xffff0000) >> 16);
+	dm_info->cck_cca_cnt = cca32_cnt & 0xffff;
+	dm_info->total_cca_cnt = dm_info->ofdm_cca_cnt;
+	if (cck_enable)
+		dm_info->total_cca_cnt += dm_info->cck_cca_cnt;
+
 	rtw_write32_mask(rtwdev, REG_CCANRX, BIT_CCK_FA_RST, 0);
 	rtw_write32_mask(rtwdev, REG_CCANRX, BIT_CCK_FA_RST, 2);
 	rtw_write32_mask(rtwdev, REG_CCANRX, BIT_OFDM_FA_RST, 0);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
index 438db74d8e7a..abd9f300bedd 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
@@ -149,6 +149,18 @@ const struct rtw_table name ## _tbl = {			\
 	le32_get_bits(*((__le32 *)(phy_stat) + 0x01), GENMASK(11, 8))
 #define GET_PHY_STAT_P1_HT_RXSC(phy_stat)                                      \
 	le32_get_bits(*((__le32 *)(phy_stat) + 0x01), GENMASK(15, 12))
+#define GET_PHY_STAT_P1_RXEVM_A(phy_stat)                                      \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x04), GENMASK(7, 0))
+#define GET_PHY_STAT_P1_RXEVM_B(phy_stat)                                      \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x04), GENMASK(15, 8))
+#define GET_PHY_STAT_P1_CFO_TAIL_A(phy_stat)                                 \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x05), GENMASK(7, 0))
+#define GET_PHY_STAT_P1_CFO_TAIL_B(phy_stat)                                 \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x05), GENMASK(15, 8))
+#define GET_PHY_STAT_P1_RXSNR_A(phy_stat)                                      \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x06), GENMASK(7, 0))
+#define GET_PHY_STAT_P1_RXSNR_B(phy_stat)                                      \
+	le32_get_bits(*((__le32 *)(phy_stat) + 0x06), GENMASK(15, 8))
 
 #define REG_ANAPARLDO_POW_MAC	0x0029
 #define BIT_LDOE25_PON		BIT(0)
diff --git a/drivers/net/wireless/realtek/rtw88/rx.c b/drivers/net/wireless/realtek/rtw88/rx.c
index d97d2c2c57c2..36887f998090 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.c
+++ b/drivers/net/wireless/realtek/rtw88/rx.c
@@ -5,6 +5,7 @@
 #include "main.h"
 #include "rx.h"
 #include "ps.h"
+#include "debug.h"
 
 void rtw_rx_stats(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 		  struct sk_buff *skb)
@@ -37,6 +38,60 @@ struct rtw_rx_addr_match_data {
 	u8 *bssid;
 };
 
+static void rtw_rx_phy_stat(struct rtw_dev *rtwdev,
+			    struct rtw_rx_pkt_stat *pkt_stat,
+			    struct ieee80211_hdr *hdr)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	struct rtw_pkt_count *cur_pkt_cnt = &dm_info->cur_pkt_count;
+	u8 rate_ss, rate_ss_evm, evm_id;
+	u8 i, idx;
+
+	dm_info->curr_rx_rate = pkt_stat->rate;
+
+	if (ieee80211_is_beacon(hdr->frame_control))
+		cur_pkt_cnt->num_bcn_pkt++;
+
+	switch (pkt_stat->rate) {
+	case DESC_RATE1M...DESC_RATE11M:
+		goto pkt_num;
+	case DESC_RATE6M...DESC_RATE54M:
+		rate_ss = 0;
+		rate_ss_evm = 1;
+		evm_id = RTW_EVM_OFDM;
+		break;
+	case DESC_RATEMCS0...DESC_RATEMCS7:
+	case DESC_RATEVHT1SS_MCS0...DESC_RATEVHT1SS_MCS9:
+		rate_ss = 1;
+		rate_ss_evm = 1;
+		evm_id = RTW_EVM_1SS;
+		break;
+	case DESC_RATEMCS8...DESC_RATEMCS15:
+	case DESC_RATEVHT2SS_MCS0...DESC_RATEVHT2SS_MCS9:
+		rate_ss = 2;
+		rate_ss_evm = 2;
+		evm_id = RTW_EVM_2SS_A;
+		break;
+	default:
+		rtw_warn(rtwdev, "unknown pkt rate = %d\n", pkt_stat->rate);
+		return;
+	}
+
+	for (i = 0; i < rate_ss_evm; i++) {
+		idx = evm_id + i;
+		ewma_evm_add(&dm_info->ewma_evm[idx],
+			     dm_info->rx_evm_dbm[i]);
+	}
+
+	for (i = 0; i < rtwdev->hal.rf_path_num; i++) {
+		idx = RTW_SNR_OFDM_A + 4 * rate_ss + i;
+		ewma_snr_add(&dm_info->ewma_snr[idx],
+			     dm_info->rx_snr[i]);
+	}
+pkt_num:
+	cur_pkt_cnt->num_qry_pkt[pkt_stat->rate]++;
+}
+
 static void rtw_rx_addr_match_iter(void *data, u8 *mac,
 				   struct ieee80211_vif *vif)
 {
@@ -48,14 +103,16 @@ static void rtw_rx_addr_match_iter(void *data, u8 *mac,
 	struct rtw_rx_pkt_stat *pkt_stat = iter_data->pkt_stat;
 	u8 *bssid = iter_data->bssid;
 
-	if (ether_addr_equal(vif->bss_conf.bssid, bssid) &&
-	    (ether_addr_equal(vif->addr, hdr->addr1) ||
-	     ieee80211_is_beacon(hdr->frame_control)))
-		sta = ieee80211_find_sta_by_ifaddr(rtwdev->hw, hdr->addr2,
-						   vif->addr);
-	else
+	if (!ether_addr_equal(vif->bss_conf.bssid, bssid))
+		return;
+
+	if (!(ether_addr_equal(vif->addr, hdr->addr1) ||
+	      ieee80211_is_beacon(hdr->frame_control)))
 		return;
 
+	rtw_rx_phy_stat(rtwdev, pkt_stat, hdr);
+	sta = ieee80211_find_sta_by_ifaddr(rtwdev->hw, hdr->addr2,
+					   vif->addr);
 	if (!sta)
 		return;
 
-- 
2.17.1

