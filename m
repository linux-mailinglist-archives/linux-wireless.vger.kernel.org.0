Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94463638D6
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Apr 2021 02:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbhDSAiw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 20:38:52 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:54341 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbhDSAis (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 20:38:48 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13J0cE9I1013543, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13J0cE9I1013543
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 19 Apr 2021 08:38:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 19 Apr 2021 08:38:13 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 19 Apr
 2021 08:38:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <vincent_fann@realtek.com>
Subject: [PATCH v2 3/3] rtw88: 8822c: debug: allow debugfs to enable/disable TXGAPK
Date:   Mon, 19 Apr 2021 08:37:48 +0800
Message-ID: <20210419003748.3224-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210419003748.3224-1-pkshih@realtek.com>
References: <20210419003748.3224-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMTggpFWkyCAwNDowNDowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/19/2021 00:21:51
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163189 [Apr 18 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {Track_Chinese_Simplified, headers_charset}
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/19/2021 00:25:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/19/2021 00:21:51
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163189 [Apr 18 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: 127.0.0.199:7.1.2;realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/19/2021 00:25:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Guo-Feng Fan <vincent_fann@realtek.com>

Use "cat dm_cap" to show all features; where, prefix +/- means feature is
enabled/disabled:

$ cat dm_cap
DM capability 0x00000002
( 1) +TXGAPK

To control dm_cap:
use "echo +1 > dm_cap" to enable TXGAPK
use "echo -1 > dm_cap" to disable TXGAPK

Below is an example to disable TXGAPK.

$ echo -1 > dm_cap
$ cat dm_cap
DM capability 0x00000000
( 1) -TXGAPK

Below is an example to show TXGAPK status
$ echo 1 > dm_cap; cat dm_cap

( 1) +TXGAPK

path 0:
0x56 = 0x88c89
[TXGAPK] offset 1 0
[TXGAPK] offset 1 1
[TXGAPK] offset 1 2
[TXGAPK] offset 1 3
[TXGAPK] offset 0 4
[TXGAPK] offset 0 5
[TXGAPK] offset 0 6
[TXGAPK] offset 0 7
[TXGAPK] offset 0 8
[TXGAPK] offset 0 9

path 1:
0x56 = 0x89c89
[TXGAPK] offset 1 0
[TXGAPK] offset 1 1
[TXGAPK] offset 1 2
[TXGAPK] offset 1 3
[TXGAPK] offset 0 4
[TXGAPK] offset 0 5
[TXGAPK] offset 0 6
[TXGAPK] offset 0 7
[TXGAPK] offset 0 8
[TXGAPK] offset 0 9

Signed-off-by: Guo-Feng Fan <vincent_fann@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c    | 91 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h     |  8 ++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 15 ++-
 3 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 5c44fa87ed2e..18ab472ea46c 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -35,9 +35,17 @@ struct rtw_debugfs_priv {
 			u32 addr;
 			u32 len;
 		} read_reg;
+		struct {
+			u8 bit;
+		} dm_cap;
 	};
 };
 
+static const char * const rtw_dm_cap_strs[] = {
+	[RTW_DM_CAP_NA] = "NA",
+	[RTW_DM_CAP_TXGAPK] = "TXGAPK",
+};
+
 static int rtw_debugfs_single_show(struct seq_file *m, void *v)
 {
 	struct rtw_debugfs_priv *debugfs_priv = m->private;
@@ -853,6 +861,83 @@ static int rtw_debugfs_get_fw_crash(struct seq_file *m, void *v)
 	return 0;
 }
 
+static ssize_t rtw_debugfs_set_dm_cap(struct file *filp,
+				      const char __user *buffer,
+				      size_t count, loff_t *loff)
+{
+	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
+	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	int bit;
+	bool en;
+
+	if (kstrtoint_from_user(buffer, count, 10, &bit))
+		return -EINVAL;
+
+	en = bit > 0;
+	bit = abs(bit);
+
+	if (bit >= RTW_DM_CAP_NUM) {
+		rtw_warn(rtwdev, "unknown DM CAP %d\n", bit);
+		return -EINVAL;
+	}
+
+	if (en)
+		dm_info->dm_flags &= ~BIT(bit);
+	else
+		dm_info->dm_flags |= BIT(bit);
+
+	debugfs_priv->dm_cap.bit = bit;
+
+	return count;
+}
+
+static void dump_gapk_status(struct rtw_dev *rtwdev, struct seq_file *m)
+{
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	struct rtw_gapk_info *txgapk = &rtwdev->dm_info.gapk;
+	int i, path;
+	u32 val;
+
+	seq_printf(m, "\n(%2d) %c%s\n\n", RTW_DM_CAP_TXGAPK,
+		   dm_info->dm_flags & BIT(RTW_DM_CAP_TXGAPK) ? '-' : '+',
+		   rtw_dm_cap_strs[RTW_DM_CAP_TXGAPK]);
+
+	for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
+		val = rtw_read_rf(rtwdev, path, RF_GAINTX, RFREG_MASK);
+		seq_printf(m, "path %d:\n0x%x = 0x%x\n", path, RF_GAINTX, val);
+
+		for (i = 0; i < RF_HW_OFFSET_NUM; i++)
+			seq_printf(m, "[TXGAPK] offset %d %d\n",
+				   txgapk->rf3f_fs[path][i], i);
+		seq_puts(m, "\n");
+	}
+}
+
+static int rtw_debugfs_get_dm_cap(struct seq_file *m, void *v)
+{
+	struct rtw_debugfs_priv *debugfs_priv = m->private;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	int i;
+
+	switch (debugfs_priv->dm_cap.bit) {
+	case RTW_DM_CAP_TXGAPK:
+		dump_gapk_status(rtwdev, m);
+		break;
+	default:
+		for (i = 1; i < RTW_DM_CAP_NUM; i++) {
+			seq_printf(m, "(%2d) %c%s\n", i,
+				   dm_info->dm_flags & BIT(i) ? '-' : '+',
+				   rtw_dm_cap_strs[i]);
+		}
+		break;
+	}
+	debugfs_priv->dm_cap.bit = RTW_DM_CAP_NA;
+	return 0;
+}
+
 #define rtw_debug_impl_mac(page, addr)				\
 static struct rtw_debugfs_priv rtw_debug_priv_mac_ ##page = {	\
 	.cb_read = rtw_debug_get_mac_page,			\
@@ -961,6 +1046,11 @@ static struct rtw_debugfs_priv rtw_debug_priv_fw_crash = {
 	.cb_read = rtw_debugfs_get_fw_crash,
 };
 
+static struct rtw_debugfs_priv rtw_debug_priv_dm_cap = {
+	.cb_write = rtw_debugfs_set_dm_cap,
+	.cb_read = rtw_debugfs_get_dm_cap,
+};
+
 #define rtw_debugfs_add_core(name, mode, fopname, parent)		\
 	do {								\
 		rtw_debug_priv_ ##name.rtwdev = rtwdev;			\
@@ -1035,6 +1125,7 @@ void rtw_debugfs_init(struct rtw_dev *rtwdev)
 	rtw_debugfs_add_r(rf_dump);
 	rtw_debugfs_add_r(tx_pwr_tbl);
 	rtw_debugfs_add_rw(fw_crash);
+	rtw_debugfs_add_rw(dm_cap);
 }
 
 #endif /* CONFIG_RTW88_DEBUGFS */
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 1e14dc4ef012..dc3744847ba9 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1516,6 +1516,7 @@ enum rtw_rf_band {
 
 struct rtw_gapk_info {
 	u32 rf3f_bp[RF_BAND_MAX][RF_GAIN_NUM][RTW_RF_PATH_MAX];
+	u32 rf3f_fs[RTW_RF_PATH_MAX][RF_GAIN_NUM];
 	bool txgapk_bp_done;
 	s8 offset[RF_GAIN_NUM][RTW_RF_PATH_MAX];
 	s8 fianl_offset[RF_GAIN_NUM][RTW_RF_PATH_MAX];
@@ -1535,6 +1536,12 @@ struct rtw_cfo_track {
 #define RRSR_INIT_2G 0x15f
 #define RRSR_INIT_5G 0x150
 
+enum rtw_dm_cap {
+	RTW_DM_CAP_NA,
+	RTW_DM_CAP_TXGAPK,
+	RTW_DM_CAP_NUM
+};
+
 struct rtw_dm_info {
 	u32 cck_fa_cnt;
 	u32 ofdm_fa_cnt;
@@ -1603,6 +1610,7 @@ struct rtw_dm_info {
 	struct ewma_evm ewma_evm[RTW_EVM_NUM];
 	struct ewma_snr ewma_snr[RTW_SNR_NUM];
 
+	u32 dm_flags; /* enum rtw_dm_cap */
 	struct rtw_iqk_info iqk;
 	struct rtw_gapk_info gapk;
 	bool is_bt_iqk_timeout;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index daa5150de87b..6cb593cc33c2 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -1665,14 +1665,16 @@ static void rtw8822c_txgapk_write_tx_gain(struct rtw_dev *rtwdev)
 			}
 
 			v = txgapk->rf3f_bp[band][i][path];
-			if (_rtw8822c_txgapk_gain_valid(rtwdev, v))
+			if (_rtw8822c_txgapk_gain_valid(rtwdev, v)) {
 				rtw_dbg(rtwdev, RTW_DBG_RFK,
 					"[TXGAPK] tx_gain=0x%03X >= 0xCEX\n",
 					txgapk->rf3f_bp[band][i][path]);
-			else
+			} else {
+				txgapk->rf3f_fs[path][i] = offset_tmp[i];
 				rtw_dbg(rtwdev, RTW_DBG_RFK,
 					"[TXGAPK] offset %d %d\n",
 					offset_tmp[i], i);
+			}
 		}
 
 		rtw_write_rf(rtwdev, path, RF_LUTWE2, RFREG_MASK, 0x10000);
@@ -1704,6 +1706,9 @@ static void rtw8822c_txgapk_save_all_tx_gain_table(struct rtw_dev *rtwdev)
 	u8 path, band, gain, rf0_idx;
 	u32 rf18, v;
 
+	if (rtwdev->dm_info.dm_flags & BIT(RTW_DM_CAP_TXGAPK))
+		return;
+
 	rtw_dbg(rtwdev, RTW_DBG_RFK, "[TXGAPK] ======>%s\n", __func__);
 
 	if (txgapk->read_txgain == 1) {
@@ -1794,6 +1799,12 @@ static void rtw8822c_txgapk(struct rtw_dev *rtwdev)
 
 static void rtw8822c_do_gapk(struct rtw_dev *rtwdev)
 {
+	struct rtw_dm_info *dm = &rtwdev->dm_info;
+
+	if (dm->dm_flags & BIT(RTW_DM_CAP_TXGAPK)) {
+		rtw_dbg(rtwdev, RTW_DBG_RFK, "[TXGAPK] feature disable!!!\n");
+		return;
+	}
 	rtw8822c_rfk_handshake(rtwdev, true);
 	rtw8822c_txgapk(rtwdev);
 	rtw8822c_rfk_handshake(rtwdev, false);
-- 
2.21.0

