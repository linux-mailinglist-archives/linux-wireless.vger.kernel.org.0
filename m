Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A447E3DD09D
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 08:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbhHBGch (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 02:32:37 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:40036 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbhHBGch (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 02:32:37 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1726WM3H0015014, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1726WM3H0015014
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 2 Aug 2021 14:32:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 2 Aug 2021 14:32:21 +0800
Received: from localhost (172.16.21.121) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 2 Aug 2021
 14:32:20 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 3/4] rtw88: support adaptivity for ETSI/JP DFS region
Date:   Mon, 2 Aug 2021 14:31:39 +0800
Message-ID: <20210802063140.25670-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802063140.25670-1-pkshih@realtek.com>
References: <20210802063140.25670-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.21.121]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/02/2021 06:13:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzgvMiCkV6TIIDA2OjAxOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 08/02/2021 06:21:01
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165335 [Aug 01 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 449 449 5db59deca4a4f5e6ea34a93b13bc730e229092f4
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;realtek.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 08/02/2021 06:23:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Add Energy Detected CCA (EDCCA) mechanism to detect energy on the channel.
And EDCCA support adaptivity mode now. From MIC Ordinance Regulating Radio
Equipment article 49.20, ETSI EN-300-328 and EN-301-893, the device should
be able to dynamically pause TX activity when energy detected on the air.
According to ETSI/JP DFS region, driver will set corresponding threshold
and stop TX activity if the detected energy exceeds the threshold. For now,
we support it on 8822b and 8822c first.

By default, EDCCA mechanism is turned on. For ETSI/JP DFS region, it will
turn to adaptivity mode. However, with adaptivity, if environment is too
nosiy, TX may often be halted. So, a debugfs for EDCCA is added. It can
show what EDCCA mode is used currently. And EDCCA mechanism can be turned
on/off through the debugfs while debugging.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c    | 38 ++++++++++++
 drivers/net/wireless/realtek/rtw88/main.c     |  1 +
 drivers/net/wireless/realtek/rtw88/main.h     | 29 +++++++++
 drivers/net/wireless/realtek/rtw88/phy.c      | 59 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/phy.h      |  2 +
 drivers/net/wireless/realtek/rtw88/reg.h      |  2 +
 drivers/net/wireless/realtek/rtw88/regd.c     |  8 ++-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 43 ++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822b.h |  8 +++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 47 +++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.h |  3 +
 11 files changed, 238 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index df0740e84f04..babf7fb238cc 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -829,6 +829,38 @@ static int rtw_debugfs_get_coex_enable(struct seq_file *m, void *v)
 	return 0;
 }
 
+static ssize_t rtw_debugfs_set_edcca_enable(struct file *filp,
+					    const char __user *buffer,
+					    size_t count, loff_t *loff)
+{
+	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
+	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	bool input;
+	int err;
+
+	err = kstrtobool_from_user(buffer, count, &input);
+	if (err)
+		return err;
+
+	rtw_edcca_enabled = input;
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
+	seq_printf(m, "EDCCA %s: EDCCA mode %d\n",
+		   rtw_edcca_enabled ? "enabled" : "disabled",
+		   dm_info->edcca_mode);
+	return 0;
+}
+
 static ssize_t rtw_debugfs_set_fw_crash(struct file *filp,
 					const char __user *buffer,
 					size_t count, loff_t *loff)
@@ -1049,6 +1081,11 @@ static struct rtw_debugfs_priv rtw_debug_priv_coex_info = {
 	.cb_read = rtw_debugfs_get_coex_info,
 };
 
+static struct rtw_debugfs_priv rtw_debug_priv_edcca_enable = {
+	.cb_write = rtw_debugfs_set_edcca_enable,
+	.cb_read = rtw_debugfs_get_edcca_enable,
+};
+
 static struct rtw_debugfs_priv rtw_debug_priv_fw_crash = {
 	.cb_write = rtw_debugfs_set_fw_crash,
 	.cb_read = rtw_debugfs_get_fw_crash,
@@ -1132,6 +1169,7 @@ void rtw_debugfs_init(struct rtw_dev *rtwdev)
 	}
 	rtw_debugfs_add_r(rf_dump);
 	rtw_debugfs_add_r(tx_pwr_tbl);
+	rtw_debugfs_add_rw(edcca_enable);
 	rtw_debugfs_add_rw(fw_crash);
 	rtw_debugfs_add_rw(dm_cap);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index f458496bddd5..c06f22d20b20 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -23,6 +23,7 @@ EXPORT_SYMBOL(rtw_disable_lps_deep_mode);
 bool rtw_bf_support = true;
 unsigned int rtw_debug_mask;
 EXPORT_SYMBOL(rtw_debug_mask);
+bool rtw_edcca_enabled = true;
 
 module_param_named(disable_lps_deep, rtw_disable_lps_deep_mode, bool, 0644);
 module_param_named(support_bf, rtw_bf_support, bool, 0644);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 2e5cebba1f21..723316347876 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -41,6 +41,7 @@
 extern bool rtw_bf_support;
 extern bool rtw_disable_lps_deep_mode;
 extern unsigned int rtw_debug_mask;
+extern bool rtw_edcca_enabled;
 extern const struct ieee80211_ops rtw_ops;
 
 #define RTW_MAX_CHANNEL_NUM_2G 14
@@ -545,6 +546,11 @@ struct rtw_rf_sipi_addr {
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
@@ -815,6 +821,7 @@ enum rtw_regd_state {
 struct rtw_regd {
 	enum rtw_regd_state state;
 	const struct rtw_regulatory *regulatory;
+	enum nl80211_dfs_regions dfs_region;
 };
 
 struct rtw_chip_ops {
@@ -852,6 +859,8 @@ struct rtw_chip_ops {
 			      struct ieee80211_bss_conf *conf);
 	void (*cfg_csi_rate)(struct rtw_dev *rtwdev, u8 rssi, u8 cur_rate,
 			     u8 fixrate_en, u8 *new_rate);
+	void (*adaptivity_init)(struct rtw_dev *rtwdev);
+	void (*adaptivity)(struct rtw_dev *rtwdev);
 	void (*cfo_init)(struct rtw_dev *rtwdev);
 	void (*cfo_track)(struct rtw_dev *rtwdev);
 	void (*config_tx_path)(struct rtw_dev *rtwdev, u8 tx_path,
@@ -1207,6 +1216,10 @@ struct rtw_chip_info {
 	u8 bfer_su_max_num;
 	u8 bfer_mu_max_num;
 
+	struct rtw_hw_reg_offset *edcca_th;
+	s8 l2h_th_ini_cs;
+	s8 l2h_th_ini_ad;
+
 	const char *wow_fw_name;
 	const struct wiphy_wowlan_support *wowlan_stub;
 	const u8 max_sched_scan_ssids;
@@ -1555,6 +1568,20 @@ struct rtw_gapk_info {
 	u8 channel;
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
 struct rtw_cfo_track {
 	bool is_adjust;
 	u8 crystal_cap;
@@ -1646,6 +1673,8 @@ struct rtw_dm_info {
 	struct rtw_gapk_info gapk;
 	bool is_bt_iqk_timeout;
 
+	s8 l2h_th_ini;
+	enum rtw_edcca_mode edcca_mode;
 	u8 scan_density;
 };
 
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index df4ca915228c..e0daf12d2484 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -120,6 +120,63 @@ static void rtw_phy_cck_pd_init(struct rtw_dev *rtwdev)
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
+	switch (rtwdev->regd.dfs_region) {
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
+	rtw_phy_adaptivity_set_mode(rtwdev);
+	if (chip->ops->adaptivity_init)
+		chip->ops->adaptivity_init(rtwdev);
+}
+
+static void rtw_phy_adaptivity(struct rtw_dev *rtwdev)
+{
+	if (rtwdev->chip->ops->adaptivity)
+		rtwdev->chip->ops->adaptivity(rtwdev);
+}
+
 static void rtw_phy_cfo_init(struct rtw_dev *rtwdev)
 {
 	struct rtw_chip_info *chip = rtwdev->chip;
@@ -160,6 +217,7 @@ void rtw_phy_init(struct rtw_dev *rtwdev)
 	rtw_phy_cck_pd_init(rtwdev);
 
 	dm_info->iqk.done = false;
+	rtw_phy_adaptivity_init(rtwdev);
 	rtw_phy_cfo_init(rtwdev);
 	rtw_phy_tx_path_div_init(rtwdev);
 }
@@ -712,6 +770,7 @@ void rtw_phy_dynamic_mechanism(struct rtw_dev *rtwdev)
 	rtw_phy_cfo_track(rtwdev);
 	rtw_phy_dpk_track(rtwdev);
 	rtw_phy_pwr_track(rtwdev);
+	rtw_phy_adaptivity(rtwdev);
 }
 
 #define FRAC_BITS 3
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index 112ed125970a..02d1ec47ffb1 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -59,6 +59,8 @@ bool rtw_phy_pwrtrack_need_lck(struct rtw_dev *rtwdev);
 bool rtw_phy_pwrtrack_need_iqk(struct rtw_dev *rtwdev);
 void rtw_phy_config_swing_table(struct rtw_dev *rtwdev,
 				struct rtw_swing_table *swing_table);
+void rtw_phy_set_edcca_th(struct rtw_dev *rtwdev, u8 l2h, u8 h2l);
+void rtw_phy_adaptivity_set_mode(struct rtw_dev *rtwdev);
 void rtw_phy_parsing_cfo(struct rtw_dev *rtwdev,
 			 struct rtw_rx_pkt_stat *pkt_stat);
 void rtw_phy_tx_path_diversity(struct rtw_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw88/reg.h b/drivers/net/wireless/realtek/rtw88/reg.h
index f5ce75095e90..8adac30ee08e 100644
--- a/drivers/net/wireless/realtek/rtw88/reg.h
+++ b/drivers/net/wireless/realtek/rtw88/reg.h
@@ -361,10 +361,12 @@
 #define REG_AGGR_BREAK_TIME	0x051A
 #define REG_SLOT		0x051B
 #define REG_TX_PTCL_CTRL	0x0520
+#define BIT_DIS_EDCCA		BIT(15)
 #define BIT_SIFS_BK_EN		BIT(12)
 #define REG_TXPAUSE		0x0522
 #define BIT_AC_QUEUE		GENMASK(7, 0)
 #define REG_RD_CTRL		0x0524
+#define BIT_EDCCA_MSK_CNTDOWN_EN BIT(11)
 #define BIT_DIS_TXOP_CFE	BIT(10)
 #define BIT_DIS_LSIG_CFE	BIT(9)
 #define BIT_DIS_STBC_CFE	BIT(8)
diff --git a/drivers/net/wireless/realtek/rtw88/regd.c b/drivers/net/wireless/realtek/rtw88/regd.c
index cd50f419f85d..315c2b193e92 100644
--- a/drivers/net/wireless/realtek/rtw88/regd.c
+++ b/drivers/net/wireless/realtek/rtw88/regd.c
@@ -18,12 +18,13 @@ do {								\
 	struct rtw_dev *__d = (_dev);				\
 	const struct rtw_regd *__r =  &__d->regd;		\
 	rtw_dbg(__d, RTW_DBG_REGD, _msg				\
-		"apply alpha2 %c%c, regd {%d, %d}\n",		\
+		"apply alpha2 %c%c, regd {%d, %d}, dfs_region %d\n",\
 		##_args,					\
 		__r->regulatory->alpha2[0],			\
 		__r->regulatory->alpha2[1],			\
 		__r->regulatory->txpwr_regd_2g,			\
-		__r->regulatory->txpwr_regd_5g);		\
+		__r->regulatory->txpwr_regd_5g,			\
+		__r->dfs_region);				\
 } while (0)
 
 /* If country code is not correctly defined in efuse,
@@ -357,6 +358,7 @@ int rtw_regd_init(struct rtw_dev *rtwdev)
 	}
 
 	rtwdev->regd.regulatory = &rtw_reg_ww;
+	rtwdev->regd.dfs_region = NL80211_DFS_UNSET;
 	rtw_dbg_regd_dump(rtwdev, "regd init state %d: ", rtwdev->regd.state);
 
 	rtw_regd_apply_hw_cap_flags(wiphy);
@@ -450,6 +452,7 @@ static bool rtw_regd_state_hdl(struct rtw_dev *rtwdev,
 			       struct regulatory_request *request)
 {
 	next_regd->regulatory = rtw_reg_find_by_name(request->alpha2);
+	next_regd->dfs_region = request->dfs_region;
 	return rtw_regd_handler[rtwdev->regd.state](rtwdev, next_regd, request);
 }
 
@@ -482,6 +485,7 @@ void rtw_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request)
 			  request->alpha2[1],
 			  request->initiator);
 
+	rtw_phy_adaptivity_set_mode(rtwdev);
 	rtw_phy_set_tx_power_level(rtwdev, hal->current_channel);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 49e8420ab33e..c409c8c29ec8 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -1553,6 +1553,39 @@ static void rtw8822b_bf_config_bfee(struct rtw_dev *rtwdev, struct rtw_vif *vif,
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
@@ -2126,6 +2159,8 @@ static struct rtw_chip_ops rtw8822b_ops = {
 	.config_bfee		= rtw8822b_bf_config_bfee,
 	.set_gid_table		= rtw_bf_set_gid_table,
 	.cfg_csi_rate		= rtw_bf_cfg_csi_rate,
+	.adaptivity_init	= rtw8822b_adaptivity_init,
+	.adaptivity		= rtw8822b_adaptivity,
 
 	.coex_set_init		= rtw8822b_coex_cfg_init,
 	.coex_set_ant_switch	= rtw8822b_coex_cfg_ant_switch,
@@ -2455,6 +2490,11 @@ static const struct rtw_reg_domain coex_info_hw_regs_8822b[] = {
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
@@ -2503,6 +2543,9 @@ struct rtw_chip_info rtw8822b_hw_spec = {
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
index f3ad079967a6..46b881e8e4fe 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -4497,6 +4497,39 @@ static void rtw8822c_pwr_track(struct rtw_dev *rtwdev)
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
@@ -4912,6 +4945,8 @@ static struct rtw_chip_ops rtw8822c_ops = {
 	.config_bfee		= rtw8822c_bf_config_bfee,
 	.set_gid_table		= rtw_bf_set_gid_table,
 	.cfg_csi_rate		= rtw_bf_cfg_csi_rate,
+	.adaptivity_init	= rtw8822c_adaptivity_init,
+	.adaptivity		= rtw8822c_adaptivity,
 	.cfo_init		= rtw8822c_cfo_init,
 	.cfo_track		= rtw8822c_cfo_track,
 	.config_tx_path		= rtw8822c_config_tx_path,
@@ -5197,6 +5232,15 @@ static const struct rtw_pwr_track_tbl rtw8822c_rtw_pwr_track_tbl = {
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
@@ -5289,6 +5333,9 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.bfer_mu_max_num = 1,
 	.rx_ldpc = true,
 	.tx_stbc = true,
+	.edcca_th = rtw8822c_edcca_th,
+	.l2h_th_ini_cs = 60,
+	.l2h_th_ini_ad = 45,
 
 #ifdef CONFIG_PM
 	.wow_fw_name = "rtw88/rtw8822c_wow_fw.bin",
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.h b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
index 364afc6d851b..3df627419d81 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.h
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.h
@@ -162,6 +162,7 @@ const struct rtw_table name ## _tbl = {			\
 #define GET_PHY_STAT_P1_RXSNR_B(phy_stat)                                      \
 	le32_get_bits(*((__le32 *)(phy_stat) + 0x06), GENMASK(15, 8))
 
+#define RTW8822C_EDCCA_MAX	0x7f
 #define REG_ANAPARLDO_POW_MAC	0x0029
 #define BIT_LDOE25_PON		BIT(0)
 #define XCAP_MASK		GENMASK(6, 0)
@@ -174,6 +175,8 @@ const struct rtw_table name ## _tbl = {			\
 #define REG_ANTMAP0		0x820
 #define BIT_ANT_PATH		GENMASK(1, 0)
 #define REG_ANTMAP		0x824
+#define REG_EDCCA_DECISION	0x844
+#define BIT_EDCCA_OPTION	GENMASK(30, 29)
 #define REG_DYMPRITH		0x86c
 #define REG_DYMENTH0		0x870
 #define REG_DYMENTH		0x874
-- 
2.25.1

