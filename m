Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEDEA18153C
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 10:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgCKJpf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 05:45:35 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:51078 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728263AbgCKJpf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 05:45:35 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02B9jRbI019761, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02B9jRbI019761
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Mar 2020 17:45:27 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 11 Mar 2020 17:45:27 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 11 Mar 2020 17:45:26 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <tehuang@realtek.com>
Subject: [PATCH v4 2/2] rtw88: add adaptivity support for EU/JP regulatory
Date:   Wed, 11 Mar 2020 17:45:24 +0800
Message-ID: <20200311094524.18884-3-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311094524.18884-1-yhchuang@realtek.com>
References: <20200311094524.18884-1-yhchuang@realtek.com>
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

v4
  * first added

 drivers/net/wireless/realtek/rtw88/debug.c    | 33 ++++++++++
 drivers/net/wireless/realtek/rtw88/main.c     |  1 +
 drivers/net/wireless/realtek/rtw88/main.h     | 32 ++++++++++
 drivers/net/wireless/realtek/rtw88/phy.c      | 60 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/phy.h      |  2 +
 drivers/net/wireless/realtek/rtw88/reg.h      |  2 +
 drivers/net/wireless/realtek/rtw88/regd.c     | 24 +++++++-
 drivers/net/wireless/realtek/rtw88/regd.h     |  2 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 41 +++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822b.h |  6 ++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 45 ++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.h |  2 +
 12 files changed, 249 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 5a181e01ebef..a84b7d6e0cda 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -694,6 +694,33 @@ static int rtw_debugfs_get_phy_info(struct seq_file *m, void *v)
 	return 0;
 }
 
+static ssize_t rtw_debugfs_set_edcca_enable(struct file *filp,
+					    const char __user *buffer,
+					    size_t count, loff_t *loff)
+{
+	struct rtw_debugfs_priv *debugfs_priv = filp->private_data;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	char tmp[32 + 1];
+
+	rtw_debugfs_copy_from_user(tmp, sizeof(tmp), buffer, count, 1);
+
+	kstrtobool(tmp, &rtw_edcca_enabled);
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
@@ -784,6 +811,11 @@ static struct rtw_debugfs_priv rtw_debug_priv_phy_info = {
 	.cb_read = rtw_debugfs_get_phy_info,
 };
 
+static struct rtw_debugfs_priv rtw_debug_priv_edcca_enable = {
+	.cb_write = rtw_debugfs_set_edcca_enable,
+	.cb_read = rtw_debugfs_get_edcca_enable,
+};
+
 #define rtw_debugfs_add_core(name, mode, fopname, parent)		\
 	do {								\
 		rtw_debug_priv_ ##name.rtwdev = rtwdev;			\
@@ -854,6 +886,7 @@ void rtw_debugfs_init(struct rtw_dev *rtwdev)
 	}
 	rtw_debugfs_add_r(rf_dump);
 	rtw_debugfs_add_r(tx_pwr_tbl);
+	rtw_debugfs_add_rw(edcca_enable);
 }
 
 #endif /* CONFIG_RTW88_DEBUGFS */
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 635d9964beaa..ec33d0f5e5d9 100644
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
index 5e0ee86048bd..182fbd20223e 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -38,6 +38,7 @@
 extern bool rtw_bf_support;
 extern unsigned int rtw_fw_lps_deep_mode;
 extern unsigned int rtw_debug_mask;
+extern bool rtw_edcca_enabled;
 extern const struct ieee80211_ops rtw_ops;
 extern struct rtw_chip_info rtw8822b_hw_spec;
 extern struct rtw_chip_info rtw8822c_hw_spec;
@@ -327,6 +328,8 @@ enum rtw_trx_desc_rate {
 	DESC_RATE_MAX,
 };
 
+#define RTW_REGION_INVALID 0xff
+
 enum rtw_regulatory_domains {
 	RTW_REGD_FCC		= 0,
 	RTW_REGD_MKK		= 1,
@@ -515,6 +518,11 @@ struct rtw_hw_reg {
 	u32 mask;
 };
 
+struct rtw_hw_reg_offset {
+	struct rtw_hw_reg hw_reg;
+	u8 offset;
+};
+
 struct rtw_backup_info {
 	u8 len;
 	u32 reg;
@@ -764,6 +772,7 @@ struct rtw_regulatory {
 	char alpha2[2];
 	u8 chplan;
 	u8 txpwr_regd;
+	enum nl80211_dfs_regions region;
 };
 
 struct rtw_chip_ops {
@@ -797,6 +806,8 @@ struct rtw_chip_ops {
 			      struct ieee80211_bss_conf *conf);
 	void (*cfg_csi_rate)(struct rtw_dev *rtwdev, u8 rssi, u8 cur_rate,
 			     u8 fixrate_en, u8 *new_rate);
+	void (*adaptivity_init)(struct rtw_dev *rtwdev);
+	void (*adaptivity)(struct rtw_dev *rtwdev);
 
 	/* for coex */
 	void (*coex_set_init)(struct rtw_dev *rtwdev);
@@ -1085,6 +1096,10 @@ struct rtw_chip_info {
 	u8 bfer_su_max_num;
 	u8 bfer_mu_max_num;
 
+	struct rtw_hw_reg_offset *edcca_th;
+	s8 l2h_th_ini_cs;
+	s8 l2h_th_ini_ad;
+
 	const char *wow_fw_name;
 	const struct wiphy_wowlan_support *wowlan_stub;
 	const u8 max_sched_scan_ssids;
@@ -1354,6 +1369,20 @@ struct rtw_pkt_count {
 DECLARE_EWMA(evm, 10, 4);
 DECLARE_EWMA(snr, 10, 4);
 
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
@@ -1413,6 +1442,9 @@ struct rtw_dm_info {
 	struct rtw_pkt_count last_pkt_count;
 	struct ewma_evm ewma_evm[RTW_EVM_NUM];
 	struct ewma_snr ewma_snr[RTW_SNR_NUM];
+
+	s8 l2h_th_ini;
+	enum rtw_edcca_mode edcca_mode;
 };
 
 struct rtw_efuse {
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 8793dd22188f..9e398c18f631 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -9,6 +9,7 @@
 #include "fw.h"
 #include "phy.h"
 #include "debug.h"
+#include "regd.h"
 
 struct phy_cfg_pair {
 	u32 addr;
@@ -115,6 +116,57 @@ static void rtw_phy_cck_pd_init(struct rtw_dev *rtwdev)
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
@@ -134,6 +186,7 @@ void rtw_phy_init(struct rtw_dev *rtwdev)
 	mask = chip->dig[0].mask;
 	dm_info->igi_history[0] = rtw_read32_mask(rtwdev, addr, mask);
 	rtw_phy_cck_pd_init(rtwdev);
+	rtw_phy_adaptivity_init(rtwdev);
 }
 
 void rtw_phy_dig_write(struct rtw_dev *rtwdev, u8 igi)
@@ -543,6 +596,12 @@ static void rtw_phy_pwr_track(struct rtw_dev *rtwdev)
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
@@ -552,6 +611,7 @@ void rtw_phy_dynamic_mechanism(struct rtw_dev *rtwdev)
 	rtw_phy_ra_info_update(rtwdev);
 	rtw_phy_dpk_track(rtwdev);
 	rtw_phy_pwr_track(rtwdev);
+	rtw_phy_adaptivity(rtwdev);
 }
 
 #define FRAC_BITS 3
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index af916d8784cd..ca7af828b5a7 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -56,6 +56,8 @@ s8 rtw_phy_pwrtrack_get_pwridx(struct rtw_dev *rtwdev,
 bool rtw_phy_pwrtrack_need_iqk(struct rtw_dev *rtwdev);
 void rtw_phy_config_swing_table(struct rtw_dev *rtwdev,
 				struct rtw_swing_table *swing_table);
+void rtw_phy_set_edcca_th(struct rtw_dev *rtwdev, u8 l2h, u8 h2l);
+void rtw_phy_adaptivity_set_mode(struct rtw_dev *rtwdev);
 
 struct rtw_txpwr_lmt_cfg_pair {
 	u8 regd;
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index 9d94534c9674..b8c6601e5123 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -265,9 +265,11 @@
 #define BIT_SHIFT_SIFS_OFDM_TRX	24
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
index 500a02b97a9c..0275312e5af8 100644
--- a/drivers/net/wireless/realtek/rtw88/regd.c
+++ b/drivers/net/wireless/realtek/rtw88/regd.c
@@ -358,6 +358,22 @@ static bool rtw_regd_is_ww(struct rtw_regulatory *reg)
 	return false;
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
@@ -374,10 +390,13 @@ static int rtw_regd_notifier_apply(struct rtw_dev *rtwdev,
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
@@ -416,6 +435,7 @@ int rtw_regd_init(struct rtw_dev *rtwdev,
 
 	rtwdev->regd = rtw_regd_find_reg_by_name(rtwdev->efuse.country_code);
 	rtw_regd_init_wiphy(rtwdev, wiphy, reg_notifier);
+	rtwdev->regd.region = RTW_REGION_INVALID;
 
 	return 0;
 }
@@ -426,12 +446,14 @@ void rtw_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 	struct rtw_dev *rtwdev = hw->priv;
 	struct rtw_hal *hal = &rtwdev->hal;
 
-	if (!rtw_regd_notifier_apply(rtwdev, wiphy, request))
+	if (!rtw_regd_notifier_apply(rtwdev, wiphy, request)) {
 		rtw_dbg(rtwdev, RTW_DBG_REGD,
 			"get alpha2 %c%c from initiator %d, mapping to chplan 0x%x, txregd %d\n",
 			request->alpha2[0], request->alpha2[1],
 			request->initiator, rtwdev->regd.chplan,
 			rtwdev->regd.txpwr_regd);
+		rtw_phy_adaptivity_set_mode(rtwdev);
+	}
 
 	rtw_phy_set_tx_power_level(rtwdev, hal->current_channel);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/regd.h b/drivers/net/wireless/realtek/rtw88/regd.h
index 5d4578331788..b50d5fb9545a 100644
--- a/drivers/net/wireless/realtek/rtw88/regd.h
+++ b/drivers/net/wireless/realtek/rtw88/regd.h
@@ -68,4 +68,6 @@ int rtw_regd_init(struct rtw_dev *rtwdev,
 		  void (*reg_notifier)(struct wiphy *wiphy,
 				       struct regulatory_request *request));
 void rtw_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request);
+void rtw_regd_init_dfs_region(struct rtw_dev *rtwdev,
+			      enum nl80211_dfs_regions curr_region);
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 96aa332fb28d..8b73b7e0a9f6 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -1543,6 +1543,37 @@ static void rtw8822b_bf_config_bfee(struct rtw_dev *rtwdev, struct rtw_vif *vif,
 		rtw_warn(rtwdev, "wrong bfee role\n");
 }
 
+static void rtw8822b_adaptivity_init(struct rtw_dev *rtwdev)
+{
+	rtw_phy_set_edcca_th(rtwdev, 0x7f, 0x7f);
+	/* mac edcca state setting */
+	rtw_write32_mask(rtwdev, REG_TX_PTCL_CTRL, BIT_DIS_EDCCA, 0);
+	rtw_write32_mask(rtwdev, REG_RD_CTRL, BIT_EDCCA_MSK_CNTDOWN_EN, 1);
+
+	rtw_write32_mask(rtwdev, REG_EDCCA_SOURCE, BIT_SOURCE_OPTION, 1);
+	rtw_write32_mask(rtwdev, REG_EDCCA_POW_MA, BIT_MA_LEVEL, 0);
+	/* edcca decistion opt */
+	rtw_write32_mask(rtwdev, REG_EDCCA_DECISION, BIT_EDCCA_OPTION, 1);
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
@@ -2094,6 +2125,8 @@ static struct rtw_chip_ops rtw8822b_ops = {
 	.config_bfee		= rtw8822b_bf_config_bfee,
 	.set_gid_table		= rtw_bf_set_gid_table,
 	.cfg_csi_rate		= rtw_bf_cfg_csi_rate,
+	.adaptivity_init	= rtw8822b_adaptivity_init,
+	.adaptivity		= rtw8822b_adaptivity,
 
 	.coex_set_init		= rtw8822b_coex_cfg_init,
 	.coex_set_ant_switch	= rtw8822b_coex_cfg_ant_switch,
@@ -2371,6 +2404,11 @@ static const struct rtw_pwr_track_tbl rtw8822b_rtw_pwr_track_tbl = {
 	.pwrtrk_2g_ccka_p = rtw8822b_pwrtrk_2g_cck_a_p,
 };
 
+static struct rtw_hw_reg_offset rtw8822b_edcca_th[] = {
+	[EDCCA_TH_L2H_IDX] = {{.addr = 0x8a4, .mask = MASKBYTE0}, .offset = 0},
+	[EDCCA_TH_H2L_IDX] = {{.addr = 0x8a4, .mask = MASKBYTE1}, .offset = 0},
+};
+
 struct rtw_chip_info rtw8822b_hw_spec = {
 	.ops = &rtw8822b_ops,
 	.id = RTW_CHIP_TYPE_8822B,
@@ -2413,6 +2451,9 @@ struct rtw_chip_info rtw8822b_hw_spec = {
 	.iqk_threshold = 8,
 	.bfer_su_max_num = 2,
 	.bfer_mu_max_num = 1,
+	.edcca_th = rtw8822b_edcca_th,
+	.l2h_th_ini_cs = 10 + EDCCA_IGI_BASE,
+	.l2h_th_ini_ad = -14 + EDCCA_IGI_BASE,
 
 	.coex_para_ver = 0x19062706,
 	.bt_desired_ver = 0x6,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.h b/drivers/net/wireless/realtek/rtw88/rtw8822b.h
index 6211f4b547b9..f2518356a464 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.h
@@ -152,11 +152,17 @@ _rtw_write32s_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u32 data)
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
index 146f693c7592..b55b4058dd3a 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -3414,6 +3414,37 @@ static void rtw8822c_pwr_track(struct rtw_dev *rtwdev)
 	dm_info->pwr_trk_triggered = false;
 }
 
+static void rtw8822c_adaptivity_init(struct rtw_dev *rtwdev)
+{
+	rtw_phy_set_edcca_th(rtwdev, 0x7f, 0x7f);
+	/* mac edcca state setting */
+	rtw_write32_mask(rtwdev, REG_TX_PTCL_CTRL, BIT_DIS_EDCCA, 0);
+	rtw_write32_mask(rtwdev, REG_RD_CTRL, BIT_EDCCA_MSK_CNTDOWN_EN, 1);
+	/* edcca decistion opt */
+	rtw_write32_mask(rtwdev, REG_EDCCA_DECISION, BIT_EDCCA_OPTION, 0);
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
@@ -3803,6 +3834,8 @@ static struct rtw_chip_ops rtw8822c_ops = {
 	.config_bfee		= rtw8822c_bf_config_bfee,
 	.set_gid_table		= rtw_bf_set_gid_table,
 	.cfg_csi_rate		= rtw_bf_cfg_csi_rate,
+	.adaptivity_init	= rtw8822c_adaptivity_init,
+	.adaptivity		= rtw8822c_adaptivity,
 
 	.coex_set_init		= rtw8822c_coex_cfg_init,
 	.coex_set_ant_switch	= NULL,
@@ -4080,6 +4113,15 @@ static const struct rtw_pwr_track_tbl rtw8822c_rtw_pwr_track_tbl = {
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
@@ -4137,6 +4179,9 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.iqk_threshold = 8,
 	.bfer_su_max_num = 2,
 	.bfer_mu_max_num = 1,
+	.edcca_th = rtw8822c_edcca_th,
+	.l2h_th_ini_cs = 60,
+	.l2h_th_ini_ad = 45,
 
 #ifdef CONFIG_PM
 	.wow_fw_name = "rtw88/rtw8822c_wow_fw.bin",
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
index dfd8662a0c0e..953fb19fad7e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
@@ -171,6 +171,8 @@ const struct rtw_table name ## _tbl = {			\
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

