Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4DC460C90
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 03:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbhK2CK5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Nov 2021 21:10:57 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:36901 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbhK2CI4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Nov 2021 21:08:56 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1AT25Vj44007819, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36503.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1AT25Vj44007819
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Nov 2021 10:05:32 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36503.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 10:05:31 +0800
Received: from localhost (172.21.69.188) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 29 Nov
 2021 10:05:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2] rtw88: add debugfs to fix tx rate
Date:   Mon, 29 Nov 2021 10:05:06 +0800
Message-ID: <20211129020506.6273-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 11/29/2021 01:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzExLzI4IKRVpMggMTE6NDM6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36503.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

It is useful to fix the bit rate of TX packets. For example, if
someone is measuring the TX power, or debugging with the issues
of the TX throughput on the field.

To set the value of fixed rate, one should input corresponding
desc rate index (ex, 0x0b for DESC_RATE54M to fix at 54 Mbps).
Set a value larger than DESC_RATE_MAX will disable fix rate, so
the rate adaptive mechanism can resume to work.

Example,
  To fix rate at MCS 1:
  echo 0x0d > /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate

  To not to fix rate:
  echo 0xff > /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate

  To know which rate was fixed at:
  cat /sys/kernel/debug/ieee80211/phy0/rtw88/fix_rate

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: rebase to the latest
---
 drivers/net/wireless/realtek/rtw88/debug.c | 47 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.c  |  1 +
 drivers/net/wireless/realtek/rtw88/main.h  |  1 +
 drivers/net/wireless/realtek/rtw88/tx.c    |  9 +++++
 4 files changed, 58 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 37cf1439a8a01..2eb832246ad32 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -152,6 +152,22 @@ static int rtw_debugfs_get_rf_read(struct seq_file *m, void *v)
 	return 0;
 }
 
+static int rtw_debugfs_get_fix_rate(struct seq_file *m, void *v)
+{
+	struct rtw_debugfs_priv *debugfs_priv = m->private;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 fix_rate = dm_info->fix_rate;
+
+	if (fix_rate >= DESC_RATE_MAX) {
+		seq_printf(m, "Fix rate disabled, fix_rate = %u\n", fix_rate);
+		return 0;
+	}
+
+	seq_printf(m, "Data frames fixed at desc rate %u\n", fix_rate);
+	return 0;
+}
+
 static int rtw_debugfs_copy_from_user(char tmp[], int size,
 				      const char __user *buffer, size_t count,
 				      int num)
@@ -437,6 +453,31 @@ static ssize_t rtw_debugfs_set_rf_read(struct file *filp,
 	return count;
 }
 
+static ssize_t rtw_debugfs_set_fix_rate(struct file *filp,
+					const char __user *buffer,
+					size_t count, loff_t *loff)
+{
+	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
+	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 fix_rate;
+	char tmp[32 + 1];
+	int ret;
+
+	rtw_debugfs_copy_from_user(tmp, sizeof(tmp), buffer, count, 1);
+
+	ret = kstrtou8(tmp, 0, &fix_rate);
+	if (ret) {
+		rtw_warn(rtwdev, "invalid args, [rate]\n");
+		return ret;
+	}
+
+	dm_info->fix_rate = fix_rate;
+
+	return count;
+}
+
 static int rtw_debug_get_mac_page(struct seq_file *m, void *v)
 {
 	struct rtw_debugfs_priv *debugfs_priv = m->private;
@@ -1094,6 +1135,11 @@ static struct rtw_debugfs_priv rtw_debug_priv_read_reg = {
 	.cb_read = rtw_debugfs_get_read_reg,
 };
 
+static struct rtw_debugfs_priv rtw_debug_priv_fix_rate = {
+	.cb_write = rtw_debugfs_set_fix_rate,
+	.cb_read = rtw_debugfs_get_fix_rate,
+};
+
 static struct rtw_debugfs_priv rtw_debug_priv_dump_cam = {
 	.cb_write = rtw_debugfs_set_single_input,
 	.cb_read = rtw_debugfs_get_dump_cam,
@@ -1164,6 +1210,7 @@ void rtw_debugfs_init(struct rtw_dev *rtwdev)
 	rtw_debugfs_add_rw(read_reg);
 	rtw_debugfs_add_w(rf_write);
 	rtw_debugfs_add_rw(rf_read);
+	rtw_debugfs_add_rw(fix_rate);
 	rtw_debugfs_add_rw(dump_cam);
 	rtw_debugfs_add_rw(rsvd_page);
 	rtw_debugfs_add_r(phy_info);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index a0d4d6e31fb49..78fcbc20942db 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1862,6 +1862,7 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 
 	rtwdev->sec.total_cam_num = 32;
 	rtwdev->hal.current_channel = 1;
+	rtwdev->dm_info.fix_rate = U8_MAX;
 	set_bit(RTW_BC_MC_MACID, rtwdev->mac_id_map);
 
 	rtw_stats_init(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index c37f1d5088826..5e043101ee74c 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1631,6 +1631,7 @@ struct rtw_dm_info {
 	u8 cck_gi_u_bnd;
 	u8 cck_gi_l_bnd;
 
+	u8 fix_rate;
 	u8 tx_rate;
 	u32 rrsr_val_init;
 	u32 rrsr_mask_min;
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index f9332fa463ca1..efcc1b0371a8d 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -312,7 +312,9 @@ static void rtw_tx_data_pkt_info_update(struct rtw_dev *rtwdev,
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_hw *hw = rtwdev->hw;
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	struct rtw_sta_info *si;
+	u8 fix_rate;
 	u16 seq;
 	u8 ampdu_factor = 0;
 	u8 ampdu_density = 0;
@@ -364,6 +366,13 @@ static void rtw_tx_data_pkt_info_update(struct rtw_dev *rtwdev,
 	pkt_info->bw = bw;
 	pkt_info->stbc = stbc;
 	pkt_info->ldpc = ldpc;
+
+	fix_rate = dm_info->fix_rate;
+	if (fix_rate < DESC_RATE_MAX) {
+		pkt_info->rate = fix_rate;
+		pkt_info->dis_rate_fallback = true;
+		pkt_info->use_rate = true;
+	}
 }
 
 void rtw_tx_pkt_info_update(struct rtw_dev *rtwdev,
-- 
2.25.1

