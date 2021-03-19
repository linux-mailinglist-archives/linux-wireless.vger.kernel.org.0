Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33050341506
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 06:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhCSFnd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 01:43:33 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:39745 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233865AbhCSFn1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 01:43:27 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 12J5hLCB1007756, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 12J5hLCB1007756
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 19 Mar 2021 13:43:21 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 19 Mar
 2021 13:43:20 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <ku920601@realtek.com>,
        <phhuang@realtek.com>, <shaofu@realtek.com>,
        <steventing@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 6/7] rtw88: 8822c: add CFO tracking
Date:   Fri, 19 Mar 2021 13:42:17 +0800
Message-ID: <20210319054218.3319-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210319054218.3319-1-pkshih@realtek.com>
References: <20210319054218.3319-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Add CFO tracking mechanism to mitigate the effect of oscillator
frequency discrepancy.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/coex.h     |   8 ++
 drivers/net/wireless/realtek/rtw88/debug.h    |   1 +
 drivers/net/wireless/realtek/rtw88/main.h     |  13 ++
 drivers/net/wireless/realtek/rtw88/phy.c      |  66 +++++++++
 drivers/net/wireless/realtek/rtw88/phy.h      |   2 +
 drivers/net/wireless/realtek/rtw88/reg.h      |   1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 129 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/rtw8822c.h |   5 +
 8 files changed, 224 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/coex.h b/drivers/net/wireless/realtek/rtw88/coex.h
index 57018700ac39..fc61a0cab3e4 100644
--- a/drivers/net/wireless/realtek/rtw88/coex.h
+++ b/drivers/net/wireless/realtek/rtw88/coex.h
@@ -406,4 +406,12 @@ void rtw_coex_switchband_notify(struct rtw_dev *rtwdev, u8 type);
 void rtw_coex_wl_status_change_notify(struct rtw_dev *rtwdev, u32 type);
 void rtw_coex_display_coex_info(struct rtw_dev *rtwdev, struct seq_file *m);
 
+static inline bool rtw_coex_disabled(struct rtw_dev *rtwdev)
+{
+	struct rtw_coex *coex = &rtwdev->coex;
+	struct rtw_coex_stat *coex_stat = &coex->stat;
+
+	return coex_stat->bt_disabled;
+}
+
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/debug.h b/drivers/net/wireless/realtek/rtw88/debug.h
index e16e0da26e77..c8efd1900a34 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.h
+++ b/drivers/net/wireless/realtek/rtw88/debug.h
@@ -19,6 +19,7 @@ enum rtw_debug_mask {
 	RTW_DBG_PS		= 0x00000400,
 	RTW_DBG_BF		= 0x00000800,
 	RTW_DBG_WOW		= 0x00001000,
+	RTW_DBG_CFO		= 0x00002000,
 
 	RTW_DBG_ALL		= 0xffffffff
 };
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 4be1c8b3b83c..ef77b9cb3e21 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -626,6 +626,7 @@ struct rtw_rx_pkt_stat {
 
 	struct rtw_sta_info *si;
 	struct ieee80211_vif *vif;
+	struct ieee80211_hdr *hdr;
 };
 
 DECLARE_EWMA(tp, 10, 2);
@@ -839,6 +840,8 @@ struct rtw_chip_ops {
 			      struct ieee80211_bss_conf *conf);
 	void (*cfg_csi_rate)(struct rtw_dev *rtwdev, u8 rssi, u8 cur_rate,
 			     u8 fixrate_en, u8 *new_rate);
+	void (*cfo_init)(struct rtw_dev *rtwdev);
+	void (*cfo_track)(struct rtw_dev *rtwdev);
 
 	/* for coex */
 	void (*coex_set_init)(struct rtw_dev *rtwdev);
@@ -1500,6 +1503,15 @@ struct rtw_iqk_info {
 	} result;
 };
 
+struct rtw_cfo_track {
+	bool is_adjust;
+	u8 crystal_cap;
+	s32 cfo_tail[RTW_RF_PATH_MAX];
+	s32 cfo_cnt[RTW_RF_PATH_MAX];
+	u32 packet_count;
+	u32 packet_count_pre;
+};
+
 #define RRSR_INIT_2G 0x15f
 #define RRSR_INIT_5G 0x150
 
@@ -1553,6 +1565,7 @@ struct rtw_dm_info {
 	u8 dack_dck[RTW_RF_PATH_MAX][2][DACK_DCK_BACKUP_NUM];
 
 	struct rtw_dpk_info dpk_info;
+	struct rtw_cfo_track cfo_track;
 
 	/* [bandwidth 0:20M/1:40M][number of path] */
 	u8 cck_pd_lv[2][RTW_RF_PATH_MAX];
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index b3c0a38771a7..fac89d644305 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -119,6 +119,14 @@ static void rtw_phy_cck_pd_init(struct rtw_dev *rtwdev)
 	dm_info->cck_fa_avg = CCK_FA_AVG_RESET;
 }
 
+static void rtw_phy_cfo_init(struct rtw_dev *rtwdev)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->cfo_init)
+		chip->ops->cfo_init(rtwdev);
+}
+
 void rtw_phy_init(struct rtw_dev *rtwdev)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
@@ -140,6 +148,7 @@ void rtw_phy_init(struct rtw_dev *rtwdev)
 	rtw_phy_cck_pd_init(rtwdev);
 
 	dm_info->iqk.done = false;
+	rtw_phy_cfo_init(rtwdev);
 }
 EXPORT_SYMBOL(rtw_phy_init);
 
@@ -528,6 +537,62 @@ static void rtw_phy_dpk_track(struct rtw_dev *rtwdev)
 		chip->ops->dpk_track(rtwdev);
 }
 
+struct rtw_rx_addr_match_data {
+	struct rtw_dev *rtwdev;
+	struct ieee80211_hdr *hdr;
+	struct rtw_rx_pkt_stat *pkt_stat;
+	u8 *bssid;
+};
+
+static void rtw_phy_parsing_cfo_iter(void *data, u8 *mac,
+				     struct ieee80211_vif *vif)
+{
+	struct rtw_rx_addr_match_data *iter_data = data;
+	struct rtw_dev *rtwdev = iter_data->rtwdev;
+	struct rtw_rx_pkt_stat *pkt_stat = iter_data->pkt_stat;
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	struct rtw_cfo_track *cfo = &dm_info->cfo_track;
+	u8 *bssid = iter_data->bssid;
+	u8 i;
+
+	if (!ether_addr_equal(vif->bss_conf.bssid, bssid))
+		return;
+
+	for (i = 0; i < rtwdev->hal.rf_path_num; i++) {
+		cfo->cfo_tail[i] += pkt_stat->cfo_tail[i];
+		cfo->cfo_cnt[i]++;
+	}
+
+	cfo->packet_count++;
+}
+
+void rtw_phy_parsing_cfo(struct rtw_dev *rtwdev,
+			 struct rtw_rx_pkt_stat *pkt_stat)
+{
+	struct ieee80211_hdr *hdr = pkt_stat->hdr;
+	struct rtw_rx_addr_match_data data = {};
+
+	if (pkt_stat->crc_err || pkt_stat->icv_err || !pkt_stat->phy_status ||
+	    ieee80211_is_ctl(hdr->frame_control))
+		return;
+
+	data.rtwdev = rtwdev;
+	data.hdr = hdr;
+	data.pkt_stat = pkt_stat;
+	data.bssid = get_hdr_bssid(hdr);
+
+	rtw_iterate_vifs_atomic(rtwdev, rtw_phy_parsing_cfo_iter, &data);
+}
+EXPORT_SYMBOL(rtw_phy_parsing_cfo);
+
+static void rtw_phy_cfo_track(struct rtw_dev *rtwdev)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->cfo_track)
+		chip->ops->cfo_track(rtwdev);
+}
+
 #define CCK_PD_FA_LV1_MIN	1000
 #define CCK_PD_FA_LV0_MAX	500
 
@@ -629,6 +694,7 @@ void rtw_phy_dynamic_mechanism(struct rtw_dev *rtwdev)
 	rtw_phy_dig(rtwdev);
 	rtw_phy_cck_pd(rtwdev);
 	rtw_phy_ra_track(rtwdev);
+	rtw_phy_cfo_track(rtwdev);
 	rtw_phy_dpk_track(rtwdev);
 	rtw_phy_pwr_track(rtwdev);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index a0742a69446d..0b6f2fc8193c 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -59,6 +59,8 @@ bool rtw_phy_pwrtrack_need_lck(struct rtw_dev *rtwdev);
 bool rtw_phy_pwrtrack_need_iqk(struct rtw_dev *rtwdev);
 void rtw_phy_config_swing_table(struct rtw_dev *rtwdev,
 				struct rtw_swing_table *swing_table);
+void rtw_phy_parsing_cfo(struct rtw_dev *rtwdev,
+			 struct rtw_rx_pkt_stat *pkt_stat);
 
 struct rtw_txpwr_lmt_cfg_pair {
 	u8 regd;
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index a85fe29f13f7..f719a39cc575 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -516,6 +516,7 @@
 #define BIT_RFE_BUF_EN		BIT(3)
 
 #define REG_ANAPAR_XTAL_0	0x1040
+#define BIT_XCAP_0              GENMASK(23, 10)
 #define REG_CPU_DMEM_CON	0x1080
 #define BIT_WL_PLATFORM_RST	BIT(16)
 #define BIT_WL_SECURITY_CLK	BIT(15)
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 9453a20f966a..8ed70f468cda 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -17,6 +17,7 @@
 #include "util.h"
 #include "bf.h"
 #include "efuse.h"
+#include "coex.h"
 
 #define IQK_DONE_8822C 0xaa
 
@@ -39,7 +40,7 @@ static int rtw8822c_read_efuse(struct rtw_dev *rtwdev, u8 *log_map)
 
 	efuse->rfe_option = map->rfe_option;
 	efuse->rf_board_option = map->rf_board_option;
-	efuse->crystal_cap = map->xtal_k;
+	efuse->crystal_cap = map->xtal_k & XCAP_MASK;
 	efuse->channel_plan = map->channel_plan;
 	efuse->country_code[0] = map->country_code[0];
 	efuse->country_code[1] = map->country_code[1];
@@ -1866,6 +1867,7 @@ static void query_phy_status_page1(struct rtw_dev *rtwdev, u8 *phy_status,
 		}
 		dm_info->rx_evm_dbm[path] = evm_dbm;
 	}
+	rtw_phy_parsing_cfo(rtwdev, pkt_stat);
 }
 
 static void query_phy_status(struct rtw_dev *rtwdev, u8 *phy_status,
@@ -1921,6 +1923,7 @@ static void rtw8822c_query_rx_desc(struct rtw_dev *rtwdev, u8 *rx_desc,
 
 	hdr = (struct ieee80211_hdr *)(rx_desc + desc_sz + pkt_stat->shift +
 				       pkt_stat->drv_info_sz);
+	pkt_stat->hdr = hdr;
 	if (pkt_stat->phy_status) {
 		phy_status = rx_desc + desc_sz + pkt_stat->shift;
 		query_phy_status(rtwdev, phy_status, pkt_stat);
@@ -3436,6 +3439,128 @@ static void rtw8822c_dpk_track(struct rtw_dev *rtwdev)
 	}
 }
 
+#define XCAP_EXTEND(val) ({typeof(val) _v = (val); _v | _v << 7; })
+static void rtw8822c_set_crystal_cap_reg(struct rtw_dev *rtwdev, u8 crystal_cap)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	struct rtw_cfo_track *cfo = &dm_info->cfo_track;
+	u32 val = 0;
+
+	val = XCAP_EXTEND(crystal_cap);
+	cfo->crystal_cap = crystal_cap;
+	rtw_write32_mask(rtwdev, REG_ANAPAR_XTAL_0, BIT_XCAP_0, val);
+}
+
+static void rtw8822c_set_crystal_cap(struct rtw_dev *rtwdev, u8 crystal_cap)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	struct rtw_cfo_track *cfo = &dm_info->cfo_track;
+
+	if (cfo->crystal_cap == crystal_cap)
+		return;
+
+	rtw8822c_set_crystal_cap_reg(rtwdev, crystal_cap);
+}
+
+static void rtw8822c_cfo_tracking_reset(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	struct rtw_cfo_track *cfo = &dm_info->cfo_track;
+
+	cfo->is_adjust = true;
+
+	if (cfo->crystal_cap > rtwdev->efuse.crystal_cap)
+		rtw8822c_set_crystal_cap(rtwdev, cfo->crystal_cap - 1);
+	else if (cfo->crystal_cap < rtwdev->efuse.crystal_cap)
+		rtw8822c_set_crystal_cap(rtwdev, cfo->crystal_cap + 1);
+}
+
+static void rtw8822c_cfo_init(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	struct rtw_cfo_track *cfo = &dm_info->cfo_track;
+
+	cfo->crystal_cap = rtwdev->efuse.crystal_cap;
+	cfo->is_adjust = true;
+}
+
+#define REPORT_TO_KHZ(val) ({typeof(val) _v = (val); (_v << 1) + (_v >> 1); })
+static s32 rtw8822c_cfo_calc_avg(struct rtw_dev *rtwdev, u8 path_num)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	struct rtw_cfo_track *cfo = &dm_info->cfo_track;
+	s32 cfo_avg, cfo_path_sum = 0, cfo_rpt_sum;
+	u8 i;
+
+	for (i = 0; i < path_num; i++) {
+		cfo_rpt_sum = REPORT_TO_KHZ(cfo->cfo_tail[i]);
+
+		if (cfo->cfo_cnt[i])
+			cfo_avg = cfo_rpt_sum / cfo->cfo_cnt[i];
+		else
+			cfo_avg = 0;
+
+		cfo_path_sum += cfo_avg;
+	}
+
+	for (i = 0; i < path_num; i++) {
+		cfo->cfo_tail[i] = 0;
+		cfo->cfo_cnt[i] = 0;
+	}
+
+	return cfo_path_sum / path_num;
+}
+
+static void rtw8822c_cfo_need_adjust(struct rtw_dev *rtwdev, s32 cfo_avg)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	struct rtw_cfo_track *cfo = &dm_info->cfo_track;
+
+	if (!cfo->is_adjust) {
+		if (abs(cfo_avg) > CFO_TRK_ENABLE_TH)
+			cfo->is_adjust = true;
+	} else {
+		if (abs(cfo_avg) <= CFO_TRK_STOP_TH)
+			cfo->is_adjust = false;
+	}
+
+	if (!rtw_coex_disabled(rtwdev)) {
+		cfo->is_adjust = false;
+		rtw8822c_set_crystal_cap(rtwdev, rtwdev->efuse.crystal_cap);
+	}
+}
+
+static void rtw8822c_cfo_track(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	struct rtw_cfo_track *cfo = &dm_info->cfo_track;
+	u8 path_num = rtwdev->hal.rf_path_num;
+	s8 crystal_cap = cfo->crystal_cap;
+	s32 cfo_avg = 0;
+
+	if (rtwdev->sta_cnt != 1) {
+		rtw8822c_cfo_tracking_reset(rtwdev);
+		return;
+	}
+
+	if (cfo->packet_count == cfo->packet_count_pre)
+		return;
+
+	cfo->packet_count_pre = cfo->packet_count;
+	cfo_avg = rtw8822c_cfo_calc_avg(rtwdev, path_num);
+	rtw8822c_cfo_need_adjust(rtwdev, cfo_avg);
+
+	if (cfo->is_adjust) {
+		if (cfo_avg > CFO_TRK_ADJ_TH)
+			crystal_cap++;
+		else if (cfo_avg < -CFO_TRK_ADJ_TH)
+			crystal_cap--;
+
+		crystal_cap = clamp_t(s8, crystal_cap, 0, XCAP_MASK);
+		rtw8822c_set_crystal_cap(rtwdev, (u8)crystal_cap);
+	}
+}
+
 static const struct rtw_phy_cck_pd_reg
 rtw8822c_cck_pd_reg[RTW_CHANNEL_WIDTH_40 + 1][RTW_RF_PATH_MAX] = {
 	{
@@ -4016,6 +4141,8 @@ static struct rtw_chip_ops rtw8822c_ops = {
 	.config_bfee		= rtw8822c_bf_config_bfee,
 	.set_gid_table		= rtw_bf_set_gid_table,
 	.cfg_csi_rate		= rtw_bf_cfg_csi_rate,
+	.cfo_init		= rtw8822c_cfo_init,
+	.cfo_track		= rtw8822c_cfo_track,
 
 	.coex_set_init		= rtw8822c_coex_cfg_init,
 	.coex_set_ant_switch	= NULL,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
index bb2495b8609e..e2b134ce0b3f 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
@@ -165,6 +165,11 @@ const struct rtw_table name ## _tbl = {			\
 #define REG_ANAPARLDO_POW_MAC	0x0029
 #define BIT_LDOE25_PON		BIT(0)
 
+#define XCAP_MASK		GENMASK(6, 0)
+#define CFO_TRK_ENABLE_TH	20
+#define CFO_TRK_STOP_TH		10
+#define CFO_TRK_ADJ_TH		10
+
 #define REG_TXDFIR0	0x808
 #define REG_DFIRBW	0x810
 #define REG_ANTMAP0	0x820
-- 
2.21.0

