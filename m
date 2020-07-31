Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED05233D73
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jul 2020 04:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbgGaCq0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 22:46:26 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46511 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730820AbgGaCqZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 22:46:25 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06V2kDwK5008077, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06V2kDwK5008077
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 31 Jul 2020 10:46:13 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 31 Jul 2020 10:46:13 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 31 Jul 2020 10:46:12 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>,
        <briannorris@chromium.org>
Subject: [PATCH v8 2/2] rtw88: add adaptivity support for EU/JP regulatory
Date:   Fri, 31 Jul 2020 10:46:07 +0800
Message-ID: <20200731024607.5817-3-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200731024607.5817-1-yhchuang@realtek.com>
References: <20200731024607.5817-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

From MIC Ordinance Regulating Radio Equipment article 49.20,
ETSI EN-300-328 and EN-301-893, the device should be able to
dynamically pause TX activity when energy detected on the air.

To achieve this, add Energy Detected CCA (EDCCA) support to
detect the energy in the channel. Driver will set corresponding
thresholds to the device, if the energy detected exceeds the
threshold, the TX activity will be halted immediately.

As this could lead to performance downgrade when the environment
is noisy, add a debugfs to disable this for debugging usage.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c    | 37 +++++++++++
 drivers/net/wireless/realtek/rtw88/main.c     |  1 +
 drivers/net/wireless/realtek/rtw88/main.h     | 31 ++++++++++
 drivers/net/wireless/realtek/rtw88/phy.c      | 61 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/phy.h      |  2 +
 drivers/net/wireless/realtek/rtw88/reg.h      |  2 +
 drivers/net/wireless/realtek/rtw88/regd.c     | 22 +++++++
 drivers/net/wireless/realtek/rtw88/regd.h     |  2 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 43 +++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822b.h |  8 +++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 47 ++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.h |  3 +
 12 files changed, 259 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 09f04feb8fe1..e0a13de62edf 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -746,6 +746,37 @@ static int rtw_debugfs_get_coex_enable(struct seq_file *m, void *v)
 	return 0;
 }
 
+static ssize_t rtw_debugfs_set_edcca_enable(struct file *filp,
+					    const char __user *buffer,
+					    size_t count, loff_t *loff)
+{
+	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
+	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	char tmp[32 + 1];
+	int err;
+
+	rtw_debugfs_copy_from_user(tmp, sizeof(tmp), buffer, count, 1);
+
+	err = kstrtobool(tmp, &rtw_edcca_enabled);
+	if (err)
+		return err;
+	rtw_phy_adaptivity_set_mode(rtwdev);
+
+	return count;
+}
+
+static int rtw_debugfs_get_edcca_enable(struct seq_file *m, void *v)
+{
+	struct rtw_debugfs_priv *debugfs_priv = m->private;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+
+	seq_printf(m, "EDCCA mode %d\n", dm_info->edcca_mode);
+
+	return 0;
+}
+
 #define rtw_debug_impl_mac(page, addr)				\
 static struct rtw_debugfs_priv rtw_debug_priv_mac_ ##page = {	\
 	.cb_read = rtw_debug_get_mac_page,			\
@@ -845,6 +876,11 @@ static struct rtw_debugfs_priv rtw_debug_priv_coex_info = {
 	.cb_read = rtw_debugfs_get_coex_info,
 };
 
+static struct rtw_debugfs_priv rtw_debug_priv_edcca_enable = {
+	.cb_write = rtw_debugfs_set_edcca_enable,
+	.cb_read = rtw_debugfs_get_edcca_enable,
+};
+
 #define rtw_debugfs_add_core(name, mode, fopname, parent)		\
 	do {								\
 		rtw_debug_priv_ ##name.rtwdev = rtwdev;			\
@@ -917,6 +953,7 @@ void rtw_debugfs_init(struct rtw_dev *rtwdev)
 	}
 	rtw_debugfs_add_r(rf_dump);
 	rtw_debugfs_add_r(tx_pwr_tbl);
+	rtw_debugfs_add_rw(edcca_enable);
 }
 
 #endif /* CONFIG_RTW88_DEBUGFS */
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index e381b4309663..3c5df03a809c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -21,6 +21,7 @@ EXPORT_SYMBOL(rtw_fw_lps_deep_mode);
 bool rtw_bf_support = true;
 unsigned int rtw_debug_mask;
 EXPORT_SYMBOL(rtw_debug_mask);
+bool rtw_edcca_enabled = true;
 
 module_param_named(lps_deep_mode, rtw_fw_lps_deep_mode, uint, 0644);
 module_param_named(support_bf, rtw_bf_support, bool, 0644);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index d60830ea6569..9a6691e4065b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -39,6 +39,7 @@
 extern bool rtw_bf_support;
 extern unsigned int rtw_fw_lps_deep_mode;
 extern unsigned int rtw_debug_mask;
+extern bool rtw_edcca_enabled;
 extern const struct ieee80211_ops rtw_ops;
 
 #define RTW_MAX_CHANNEL_NUM_2G 14
@@ -328,6 +329,8 @@ enum rtw_trx_desc_rate {
 	DESC_RATE_MAX,
 };
 
+#define RTW_REGION_INVALID 0xff
+
 enum rtw_regulatory_domains {
 	RTW_REGD_FCC		= 0,
 	RTW_REGD_MKK		= 1,
@@ -542,6 +545,11 @@ struct rtw_rf_sipi_addr {
 	u32 lssi_read_pi;
 };
 
+struct rtw_hw_reg_offset {
+	struct rtw_hw_reg hw_reg;
+	u8 offset;
+};
+
 struct rtw_backup_info {
 	u8 len;
 	u32 reg;
@@ -795,6 +803,7 @@ struct rtw_regulatory {
 	char alpha2[2];
 	u8 chplan;
 	u8 txpwr_regd;
+	enum nl80211_dfs_regions region;
 };
 
 struct rtw_chip_ops {
@@ -831,6 +840,8 @@ struct rtw_chip_ops {
 			      struct ieee80211_bss_conf *conf);
 	void (*cfg_csi_rate)(struct rtw_dev *rtwdev, u8 rssi, u8 cur_rate,
 			     u8 fixrate_en, u8 *new_rate);
+	void (*adaptivity_init)(struct rtw_dev *rtwdev);
+	void (*adaptivity)(struct rtw_dev *rtwdev);
 
 	/* for coex */
 	void (*coex_set_init)(struct rtw_dev *rtwdev);
@@ -1144,6 +1155,10 @@ struct rtw_chip_info {
 	u8 bfer_su_max_num;
 	u8 bfer_mu_max_num;
 
+	struct rtw_hw_reg_offset *edcca_th;
+	s8 l2h_th_ini_cs;
+	s8 l2h_th_ini_ad;
+
 	const char *wow_fw_name;
 	const struct wiphy_wowlan_support *wowlan_stub;
 	const u8 max_sched_scan_ssids;
@@ -1436,6 +1451,20 @@ struct rtw_iqk_info {
 	} result;
 };
 
+#define EDCCA_TH_L2H_IDX 0
+#define EDCCA_TH_H2L_IDX 1
+#define EDCCA_TH_L2H_LB 48
+#define EDCCA_ADC_BACKOFF 12
+#define EDCCA_IGI_BASE 50
+#define EDCCA_IGI_L2H_DIFF 8
+#define EDCCA_L2H_H2L_DIFF 7
+#define EDCCA_L2H_H2L_DIFF_NORMAL 8
+
+enum rtw_edcca_mode {
+	RTW_EDCCA_NORMAL	= 0,
+	RTW_EDCCA_ADAPTIVITY	= 1,
+};
+
 struct rtw_dm_info {
 	u32 cck_fa_cnt;
 	u32 ofdm_fa_cnt;
@@ -1501,6 +1530,8 @@ struct rtw_dm_info {
 	struct ewma_snr ewma_snr[RTW_SNR_NUM];
 
 	struct rtw_iqk_info iqk;
+	s8 l2h_th_ini;
+	enum rtw_edcca_mode edcca_mode;
 };
 
 struct rtw_efuse {
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 8d93f3159746..d8fe3cde946c 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -9,6 +9,7 @@
 #include "fw.h"
 #include "phy.h"
 #include "debug.h"
+#include "regd.h"
 
 struct phy_cfg_pair {
 	u32 addr;
@@ -119,6 +120,58 @@ static void rtw_phy_cck_pd_init(struct rtw_dev *rtwdev)
 	dm_info->cck_fa_avg = CCK_FA_AVG_RESET;
 }
 
+void rtw_phy_set_edcca_th(struct rtw_dev *rtwdev, u8 l2h, u8 h2l)
+{
+	struct rtw_hw_reg_offset *edcca_th = rtwdev->chip->edcca_th;
+
+	rtw_write32_mask(rtwdev,
+			 edcca_th[EDCCA_TH_L2H_IDX].hw_reg.addr,
+			 edcca_th[EDCCA_TH_L2H_IDX].hw_reg.mask,
+			 l2h + edcca_th[EDCCA_TH_L2H_IDX].offset);
+	rtw_write32_mask(rtwdev,
+			 edcca_th[EDCCA_TH_H2L_IDX].hw_reg.addr,
+			 edcca_th[EDCCA_TH_H2L_IDX].hw_reg.mask,
+			 h2l + edcca_th[EDCCA_TH_H2L_IDX].offset);
+}
+EXPORT_SYMBOL(rtw_phy_set_edcca_th);
+
+void rtw_phy_adaptivity_set_mode(struct rtw_dev *rtwdev)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+
+	/* turn off in debugfs for debug usage */
+	if (!rtw_edcca_enabled) {
+		dm_info->edcca_mode = RTW_EDCCA_NORMAL;
+		rtw_dbg(rtwdev, RTW_DBG_PHY, "EDCCA disabled, cannot be set\n");
+		return;
+	}
+
+	switch (rtwdev->regd.region) {
+	case NL80211_DFS_ETSI:
+		dm_info->edcca_mode = RTW_EDCCA_ADAPTIVITY;
+		dm_info->l2h_th_ini = chip->l2h_th_ini_ad;
+		break;
+	case NL80211_DFS_JP:
+		dm_info->edcca_mode = RTW_EDCCA_ADAPTIVITY;
+		dm_info->l2h_th_ini = chip->l2h_th_ini_cs;
+		break;
+	default:
+		dm_info->edcca_mode = RTW_EDCCA_NORMAL;
+		break;
+	}
+}
+
+static void rtw_phy_adaptivity_init(struct rtw_dev *rtwdev)
+{
+	struct rtw_chip_info *chip = rtwdev->chip;
+
+	rtw_regd_init_dfs_region(rtwdev, rtwdev->regd.region);
+	rtw_phy_adaptivity_set_mode(rtwdev);
+	if (chip->ops->adaptivity_init)
+		chip->ops->adaptivity_init(rtwdev);
+}
+
 void rtw_phy_init(struct rtw_dev *rtwdev)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
@@ -140,6 +193,7 @@ void rtw_phy_init(struct rtw_dev *rtwdev)
 	rtw_phy_cck_pd_init(rtwdev);
 
 	dm_info->iqk.done = false;
+	rtw_phy_adaptivity_init(rtwdev);
 }
 EXPORT_SYMBOL(rtw_phy_init);
 
@@ -554,6 +608,12 @@ static void rtw_phy_pwr_track(struct rtw_dev *rtwdev)
 	rtwdev->chip->ops->pwr_track(rtwdev);
 }
 
+static void rtw_phy_adaptivity(struct rtw_dev *rtwdev)
+{
+	if (rtwdev->chip->ops->adaptivity)
+		rtwdev->chip->ops->adaptivity(rtwdev);
+}
+
 void rtw_phy_dynamic_mechanism(struct rtw_dev *rtwdev)
 {
 	/* for further calculation */
@@ -563,6 +623,7 @@ void rtw_phy_dynamic_mechanism(struct rtw_dev *rtwdev)
 	rtw_phy_ra_info_update(rtwdev);
 	rtw_phy_dpk_track(rtwdev);
 	rtw_phy_pwr_track(rtwdev);
+	rtw_phy_adaptivity(rtwdev);
 }
 
 #define FRAC_BITS 3
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index b924ed07630a..13035c43e834 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -58,6 +58,8 @@ s8 rtw_phy_pwrtrack_get_pwridx(struct rtw_dev *rtwdev,
 bool rtw_phy_pwrtrack_need_iqk(struct rtw_dev *rtwdev);
 void rtw_phy_config_swing_table(struct rtw_dev *rtwdev,
 				struct rtw_swing_table *swing_table);
+void rtw_phy_set_edcca_th(struct rtw_dev *rtwdev, u8 l2h, u8 h2l);
+void rtw_phy_adaptivity_set_mode(struct rtw_dev *rtwdev);
 
 struct rtw_txpwr_lmt_cfg_pair {
 	u8 regd;
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index f1275757f6b4..a650fb54e612 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -352,9 +352,11 @@
 #define REG_AGGR_BREAK_TIME	0x051A
 #define REG_SLOT		0x051B
 #define REG_TX_PTCL_CTRL	0x0520
+#define BIT_DIS_EDCCA		BIT(15)
 #define BIT_SIFS_BK_EN		BIT(12)
 #define REG_TXPAUSE		0x0522
 #define REG_RD_CTRL		0x0524
+#define BIT_EDCCA_MSK_CNTDOWN_EN BIT(11)
 #define BIT_DIS_TXOP_CFE	BIT(10)
 #define BIT_DIS_LSIG_CFE	BIT(9)
 #define BIT_DIS_STBC_CFE	BIT(8)
diff --git a/drivers/net/wireless/realtek/rtw88/regd.c b/drivers/net/wireless/realtek/rtw88/regd.c
index 52a7491bb134..768e4fcfa345 100644
--- a/drivers/net/wireless/realtek/rtw88/regd.c
+++ b/drivers/net/wireless/realtek/rtw88/regd.c
@@ -363,6 +363,22 @@ static bool rtw_regd_is_match(struct rtw_dev *rtwdev, char *alpha2)
 	return !memcmp(rtwdev->regd.alpha2, alpha2, RTW_ALPHA2_LEN);
 }
 
+void rtw_regd_init_dfs_region(struct rtw_dev *rtwdev,
+			      enum nl80211_dfs_regions curr_region)
+{
+	struct ieee80211_hw *hw = rtwdev->hw;
+	const struct ieee80211_regdomain *wiphy_regd = NULL;
+
+	if (curr_region != RTW_REGION_INVALID)
+		return;
+
+	rcu_read_lock();
+	wiphy_regd = rcu_dereference(hw->wiphy->regd);
+	if (wiphy_regd)
+		rtwdev->regd.region = wiphy_regd->dfs_region;
+	rcu_read_unlock();
+}
+
 static int rtw_regd_notifier_apply(struct rtw_dev *rtwdev,
 				   struct wiphy *wiphy,
 				   struct regulatory_request *request)
@@ -383,10 +399,13 @@ static int rtw_regd_notifier_apply(struct rtw_dev *rtwdev,
 	    !rtwdev->efuse.country_worldwide) {
 		rtwdev->regd =
 			rtw_regd_find_reg_by_name(rtwdev->efuse.country_code);
+		/* return to the efuse setting */
+		rtw_regd_init_dfs_region(rtwdev, RTW_REGION_INVALID);
 		return 0;
 	}
 	rtwdev->regd = rtw_regd_find_reg_by_name(request->alpha2);
 	rtw_regd_apply_world_flags(wiphy, request->initiator);
+	rtwdev->regd.region = request->dfs_region;
 
 	return 0;
 }
@@ -425,6 +444,7 @@ int rtw_regd_init(struct rtw_dev *rtwdev,
 
 	rtwdev->regd = rtw_regd_find_reg_by_name(rtwdev->efuse.country_code);
 	rtw_regd_init_wiphy(rtwdev, wiphy, reg_notifier);
+	rtwdev->regd.region = RTW_REGION_INVALID;
 
 	return 0;
 }
@@ -448,5 +468,7 @@ void rtw_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 		request->initiator, rtwdev->regd.chplan,
 		rtwdev->regd.txpwr_regd);
 
+	rtw_phy_adaptivity_set_mode(rtwdev);
+
 	rtw_phy_set_tx_power_level(rtwdev, hal->current_channel);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/regd.h b/drivers/net/wireless/realtek/rtw88/regd.h
index 5eb252c41383..1cdb5e2c3935 100644
--- a/drivers/net/wireless/realtek/rtw88/regd.h
+++ b/drivers/net/wireless/realtek/rtw88/regd.h
@@ -70,4 +70,6 @@ int rtw_regd_init(struct rtw_dev *rtwdev,
 		  void (*reg_notifier)(struct wiphy *wiphy,
 				       struct regulatory_request *request));
 void rtw_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request);
+void rtw_regd_init_dfs_region(struct rtw_dev *rtwdev,
+			      enum nl80211_dfs_regions curr_region);
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 351cd055a295..2dda71cb1e51 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -1550,6 +1550,39 @@ static void rtw8822b_bf_config_bfee(struct rtw_dev *rtwdev, struct rtw_vif *vif,
 		rtw_warn(rtwdev, "wrong bfee role\n");
 }
 
+static void rtw8822b_adaptivity_init(struct rtw_dev *rtwdev)
+{
+	rtw_phy_set_edcca_th(rtwdev, RTW8822B_EDCCA_MAX, RTW8822B_EDCCA_MAX);
+
+	/* mac edcca state setting */
+	rtw_write32_clr(rtwdev, REG_TX_PTCL_CTRL, BIT_DIS_EDCCA);
+	rtw_write32_set(rtwdev, REG_RD_CTRL, BIT_EDCCA_MSK_CNTDOWN_EN);
+	rtw_write32_mask(rtwdev, REG_EDCCA_SOURCE, BIT_SOURCE_OPTION,
+			 RTW8822B_EDCCA_SRC_DEF);
+	rtw_write32_mask(rtwdev, REG_EDCCA_POW_MA, BIT_MA_LEVEL, 0);
+
+	/* edcca decision opt */
+	rtw_write32_set(rtwdev, REG_EDCCA_DECISION, BIT_EDCCA_OPTION);
+}
+
+static void rtw8822b_adaptivity(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	s8 l2h, h2l;
+	u8 igi;
+
+	igi = dm_info->igi_history[0];
+	if (dm_info->edcca_mode == RTW_EDCCA_NORMAL) {
+		l2h = max_t(s8, igi + EDCCA_IGI_L2H_DIFF, EDCCA_TH_L2H_LB);
+		h2l = l2h - EDCCA_L2H_H2L_DIFF_NORMAL;
+	} else {
+		l2h = min_t(s8, igi, dm_info->l2h_th_ini);
+		h2l = l2h - EDCCA_L2H_H2L_DIFF;
+	}
+
+	rtw_phy_set_edcca_th(rtwdev, l2h, h2l);
+}
+
 static const struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8822b[] = {
 	{0x0086,
 	 RTW_PWR_CUT_ALL_MSK,
@@ -2123,6 +2156,8 @@ static struct rtw_chip_ops rtw8822b_ops = {
 	.config_bfee		= rtw8822b_bf_config_bfee,
 	.set_gid_table		= rtw_bf_set_gid_table,
 	.cfg_csi_rate		= rtw_bf_cfg_csi_rate,
+	.adaptivity_init	= rtw8822b_adaptivity_init,
+	.adaptivity		= rtw8822b_adaptivity,
 
 	.coex_set_init		= rtw8822b_coex_cfg_init,
 	.coex_set_ant_switch	= rtw8822b_coex_cfg_ant_switch,
@@ -2428,6 +2463,11 @@ static const struct rtw_reg_domain coex_info_hw_regs_8822b[] = {
 	{0xc50,  MASKBYTE0, RTW_REG_DOMAIN_MAC8},
 };
 
+static struct rtw_hw_reg_offset rtw8822b_edcca_th[] = {
+	[EDCCA_TH_L2H_IDX] = {{.addr = 0x8a4, .mask = MASKBYTE0}, .offset = 0},
+	[EDCCA_TH_H2L_IDX] = {{.addr = 0x8a4, .mask = MASKBYTE1}, .offset = 0},
+};
+
 struct rtw_chip_info rtw8822b_hw_spec = {
 	.ops = &rtw8822b_ops,
 	.id = RTW_CHIP_TYPE_8822B,
@@ -2475,6 +2515,9 @@ struct rtw_chip_info rtw8822b_hw_spec = {
 	.bfer_su_max_num = 2,
 	.bfer_mu_max_num = 1,
 	.rx_ldpc = true,
+	.edcca_th = rtw8822b_edcca_th,
+	.l2h_th_ini_cs = 10 + EDCCA_IGI_BASE,
+	.l2h_th_ini_ad = -14 + EDCCA_IGI_BASE,
 
 	.coex_para_ver = 0x20070206,
 	.bt_desired_ver = 0x6,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.h b/drivers/net/wireless/realtek/rtw88/rtw8822b.h
index 6211f4b547b9..3fff8b881854 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.h
@@ -140,6 +140,8 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 #define GET_PHY_STAT_P1_RXSNR_B(phy_stat)                                      \
 	le32_get_bits(*((__le32 *)(phy_stat) + 0x06), GENMASK(15, 8))
 
+#define RTW8822B_EDCCA_MAX	0x7f
+#define RTW8822B_EDCCA_SRC_DEF	1
 #define REG_HTSTFWT	0x800
 #define REG_RXPSEL	0x808
 #define BIT_RX_PSEL_RST		(BIT(28) | BIT(29))
@@ -152,11 +154,17 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
 #define REG_L1PKWT	0x840
 #define REG_MRC		0x850
 #define REG_CLKTRK	0x860
+#define REG_EDCCA_POW_MA	0x8a0
+#define BIT_MA_LEVEL	GENMASK(1, 0)
 #define REG_ADCCLK	0x8ac
 #define REG_ADC160	0x8c4
 #define REG_ADC40	0x8c8
+#define REG_EDCCA_DECISION	0x8dc
+#define BIT_EDCCA_OPTION	BIT(5)
 #define REG_CDDTXP	0x93c
 #define REG_TXPSEL1	0x940
+#define REG_EDCCA_SOURCE	0x944
+#define BIT_SOURCE_OPTION	GENMASK(29, 28)
 #define REG_ACBB0	0x948
 #define REG_ACBBRXFIR	0x94c
 #define REG_ACGG2TBL	0x958
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 426808413baa..642e31e51326 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -3560,6 +3560,39 @@ static void rtw8822c_pwr_track(struct rtw_dev *rtwdev)
 	dm_info->pwr_trk_triggered = false;
 }
 
+static void rtw8822c_adaptivity_init(struct rtw_dev *rtwdev)
+{
+	rtw_phy_set_edcca_th(rtwdev, RTW8822C_EDCCA_MAX, RTW8822C_EDCCA_MAX);
+
+	/* mac edcca state setting */
+	rtw_write32_clr(rtwdev, REG_TX_PTCL_CTRL, BIT_DIS_EDCCA);
+	rtw_write32_set(rtwdev, REG_RD_CTRL, BIT_EDCCA_MSK_CNTDOWN_EN);
+
+	/* edcca decistion opt */
+	rtw_write32_clr(rtwdev, REG_EDCCA_DECISION, BIT_EDCCA_OPTION);
+}
+
+static void rtw8822c_adaptivity(struct rtw_dev *rtwdev)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	s8 l2h, h2l;
+	u8 igi;
+
+	igi = dm_info->igi_history[0];
+	if (dm_info->edcca_mode == RTW_EDCCA_NORMAL) {
+		l2h = max_t(s8, igi + EDCCA_IGI_L2H_DIFF, EDCCA_TH_L2H_LB);
+		h2l = l2h - EDCCA_L2H_H2L_DIFF_NORMAL;
+	} else {
+		if (igi < dm_info->l2h_th_ini - EDCCA_ADC_BACKOFF)
+			l2h = igi + EDCCA_ADC_BACKOFF;
+		else
+			l2h = dm_info->l2h_th_ini;
+		h2l = l2h - EDCCA_L2H_H2L_DIFF;
+	}
+
+	rtw_phy_set_edcca_th(rtwdev, l2h, h2l);
+}
+
 static const struct rtw_pwr_seq_cmd trans_carddis_to_cardemu_8822c[] = {
 	{0x0086,
 	 RTW_PWR_CUT_ALL_MSK,
@@ -3974,6 +4007,8 @@ static struct rtw_chip_ops rtw8822c_ops = {
 	.config_bfee		= rtw8822c_bf_config_bfee,
 	.set_gid_table		= rtw_bf_set_gid_table,
 	.cfg_csi_rate		= rtw_bf_cfg_csi_rate,
+	.adaptivity_init	= rtw8822c_adaptivity_init,
+	.adaptivity		= rtw8822c_adaptivity,
 
 	.coex_set_init		= rtw8822c_coex_cfg_init,
 	.coex_set_ant_switch	= NULL,
@@ -4252,6 +4287,15 @@ static const struct rtw_pwr_track_tbl rtw8822c_rtw_pwr_track_tbl = {
 	.pwrtrk_2g_ccka_p = rtw8822c_pwrtrk_2g_cck_a_p,
 };
 
+static struct rtw_hw_reg_offset rtw8822c_edcca_th[] = {
+	[EDCCA_TH_L2H_IDX] = {
+		{.addr = 0x84c, .mask = MASKBYTE2}, .offset = 0x80
+	},
+	[EDCCA_TH_H2L_IDX] = {
+		{.addr = 0x84c, .mask = MASKBYTE3}, .offset = 0x80
+	},
+};
+
 #ifdef CONFIG_PM
 static const struct wiphy_wowlan_support rtw_wowlan_stub_8822c = {
 	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_GTK_REKEY_FAILURE |
@@ -4339,6 +4383,9 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.bfer_su_max_num = 2,
 	.bfer_mu_max_num = 1,
 	.rx_ldpc = true,
+	.edcca_th = rtw8822c_edcca_th,
+	.l2h_th_ini_cs = 60,
+	.l2h_th_ini_ad = 45,
 
 #ifdef CONFIG_PM
 	.wow_fw_name = "rtw88/rtw8822c_wow_fw.bin",
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
index 32b4771e04d0..9f07653fb216 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
@@ -162,6 +162,7 @@ const struct rtw_table name ## _tbl = {			\
 #define GET_PHY_STAT_P1_RXSNR_B(phy_stat)                                      \
 	le32_get_bits(*((__le32 *)(phy_stat) + 0x06), GENMASK(15, 8))
 
+#define RTW8822C_EDCCA_MAX	0x7f
 #define REG_ANAPARLDO_POW_MAC	0x0029
 #define BIT_LDOE25_PON		BIT(0)
 #define REG_RRSR		0x0440
@@ -171,6 +172,8 @@ const struct rtw_table name ## _tbl = {			\
 #define REG_DFIRBW	0x810
 #define REG_ANTMAP0	0x820
 #define REG_ANTMAP	0x824
+#define REG_EDCCA_DECISION	0x844
+#define BIT_EDCCA_OPTION	GENMASK(30, 29)
 #define REG_DYMPRITH	0x86c
 #define REG_DYMENTH0	0x870
 #define REG_DYMENTH	0x874
-- 
2.17.1

