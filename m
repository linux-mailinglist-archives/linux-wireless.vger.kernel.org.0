Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3B88184116
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2020 07:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgCMGv0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Mar 2020 02:51:26 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36262 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgCMGv0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Mar 2020 02:51:26 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02D6pH5q012046, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02D6pH5q012046
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Mar 2020 14:51:17 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 13 Mar 2020 14:51:17 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 13 Mar 2020 14:51:17 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH] rtw88: add debugfs to fix tx rate
Date:   Fri, 13 Mar 2020 14:51:14 +0800
Message-ID: <20200313065114.23433-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
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
---
 drivers/net/wireless/realtek/rtw88/debug.c | 47 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.c  |  1 +
 drivers/net/wireless/realtek/rtw88/main.h  |  1 +
 drivers/net/wireless/realtek/rtw88/tx.c    |  9 +++++
 4 files changed, 58 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 5a181e01ebef..72e8877fd5f2 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -140,6 +140,22 @@ static int rtw_debugfs_get_rf_read(struct seq_file *m, void *v)
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
@@ -397,6 +413,31 @@ static ssize_t rtw_debugfs_set_rf_read(struct file *filp,
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
@@ -770,6 +811,11 @@ static struct rtw_debugfs_priv rtw_debug_priv_read_reg = {
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
@@ -811,6 +857,7 @@ void rtw_debugfs_init(struct rtw_dev *rtwdev)
 	rtw_debugfs_add_rw(read_reg);
 	rtw_debugfs_add_w(rf_write);
 	rtw_debugfs_add_rw(rf_read);
+	rtw_debugfs_add_rw(fix_rate);
 	rtw_debugfs_add_rw(dump_cam);
 	rtw_debugfs_add_rw(rsvd_page);
 	rtw_debugfs_add_r(phy_info);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 2f73820cd9ba..ac49142cc4d7 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1394,6 +1394,7 @@ int rtw_core_init(struct rtw_dev *rtwdev)
 
 	rtwdev->sec.total_cam_num = 32;
 	rtwdev->hal.current_channel = 1;
+	rtwdev->dm_info.fix_rate = U8_MAX;
 	set_bit(RTW_BC_MC_MACID, rtwdev->mac_id_map);
 	if (!(BIT(rtw_fw_lps_deep_mode) & chip->lps_deep_mode_supported))
 		rtwdev->lps_conf.deep_mode = LPS_DEEP_MODE_NONE;
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index c074cef22120..69ec6bf63b8b 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1383,6 +1383,7 @@ struct rtw_dm_info {
 	u8 cck_gi_u_bnd;
 	u8 cck_gi_l_bnd;
 
+	u8 fix_rate;
 	u8 tx_rate;
 	u8 thermal_avg[RTW_RF_PATH_MAX];
 	u8 thermal_meter_k;
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index 24c39c60c99a..5d2c59d2c5a5 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -236,7 +236,9 @@ static void rtw_tx_data_pkt_info_update(struct rtw_dev *rtwdev,
 	struct ieee80211_sta *sta = control->sta;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 	struct rtw_sta_info *si;
+	u8 fix_rate;
 	u16 seq;
 	u8 ampdu_factor = 0;
 	u8 ampdu_density = 0;
@@ -288,6 +290,13 @@ static void rtw_tx_data_pkt_info_update(struct rtw_dev *rtwdev,
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
2.17.1

