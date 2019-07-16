Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00FE26A1CF
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jul 2019 07:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfGPF3C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jul 2019 01:29:02 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:58478 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfGPF3C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jul 2019 01:29:02 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x6G5SpVi020227, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x6G5SpVi020227
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 16 Jul 2019 13:28:52 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Tue, 16 Jul 2019 13:28:51 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v2] rtw88: debug: dump tx power indexes in use
Date:   Tue, 16 Jul 2019 13:28:20 +0800
Message-ID: <1563254900-9219-1-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Add a read entry in debugfs to dump current tx power
indexes in use for each path and each rate section.
The corresponding power bases, power by rate, and
power limit are also included.

Also this patch fixes unused function warning.

Fixes: b741422218ef ("rtw88: refine flow to get tx power index")
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v2

    refine seq_printf format from such as

      "%5s%-5s", "CCK_", cck_rate[idx]
    to
 
      " CCK_%-5s", cck_rate[idx]


 drivers/net/wireless/realtek/rtw88/debug.c | 112 +++++++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index f0ae260..383b04c 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -8,6 +8,7 @@
 #include "sec.h"
 #include "fw.h"
 #include "debug.h"
+#include "phy.h"
 
 #ifdef CONFIG_RTW88_DEBUGFS
 
@@ -460,6 +461,112 @@ static int rtw_debug_get_rf_dump(struct seq_file *m, void *v)
 	return 0;
 }
 
+static void rtw_print_cck_rate_txt(struct seq_file *m, u8 rate)
+{
+	static const char * const
+	cck_rate[] = {"1M", "2M", "5.5M", "11M"};
+	u8 idx = rate - DESC_RATE1M;
+
+	seq_printf(m, " CCK_%-5s", cck_rate[idx]);
+}
+
+static void rtw_print_ofdm_rate_txt(struct seq_file *m, u8 rate)
+{
+	static const char * const
+	ofdm_rate[] = {"6M", "9M", "12M", "18M", "24M", "36M", "48M", "54M"};
+	u8 idx = rate - DESC_RATE6M;
+
+	seq_printf(m, " OFDM_%-4s", ofdm_rate[idx]);
+}
+
+static void rtw_print_ht_rate_txt(struct seq_file *m, u8 rate)
+{
+	u8 mcs_n = rate - DESC_RATEMCS0;
+
+	seq_printf(m, " MCS%-6u", mcs_n);
+}
+
+static void rtw_print_vht_rate_txt(struct seq_file *m, u8 rate)
+{
+	u8 idx = rate - DESC_RATEVHT1SS_MCS0;
+	u8 n_ss, mcs_n;
+
+	/* n spatial stream */
+	n_ss = 1 + idx / 10;
+	/* MCS n */
+	mcs_n = idx % 10;
+	seq_printf(m, " VHT%uSMCS%u", n_ss, mcs_n);
+}
+
+static int rtw_debugfs_get_tx_pwr_tbl(struct seq_file *m, void *v)
+{
+	struct rtw_debugfs_priv *debugfs_priv = m->private;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	struct rtw_hal *hal = &rtwdev->hal;
+	void (*print_rate)(struct seq_file *, u8) = NULL;
+	u8 path, rate;
+	struct rtw_power_params pwr_param = {0};
+	u8 bw = hal->current_band_width;
+	u8 ch = hal->current_channel;
+	u8 regd = rtwdev->regd.txpwr_regd;
+
+	seq_printf(m, "%-4s %-10s %-3s%6s %-4s %4s (%-4s %-4s)\n",
+		   "path", "rate", "pwr", "", "base", "", "byr", "lmt");
+
+	mutex_lock(&hal->tx_power_mutex);
+	for (path = RF_PATH_A; path <= RF_PATH_B; path++) {
+		/* there is no CCK rates used in 5G */
+		if (hal->current_band_type == RTW_BAND_5G)
+			rate = DESC_RATE6M;
+		else
+			rate = DESC_RATE1M;
+
+		/* now, not support vht 3ss and vht 4ss*/
+		for (; rate <= DESC_RATEVHT2SS_MCS9; rate++) {
+			/* now, not support ht 3ss and ht 4ss*/
+			if (rate > DESC_RATEMCS15 &&
+			    rate < DESC_RATEVHT1SS_MCS0)
+				continue;
+
+			switch (rate) {
+			case DESC_RATE1M...DESC_RATE11M:
+				print_rate = rtw_print_cck_rate_txt;
+				break;
+			case DESC_RATE6M...DESC_RATE54M:
+				print_rate = rtw_print_ofdm_rate_txt;
+				break;
+			case DESC_RATEMCS0...DESC_RATEMCS15:
+				print_rate = rtw_print_ht_rate_txt;
+				break;
+			case DESC_RATEVHT1SS_MCS0...DESC_RATEVHT2SS_MCS9:
+				print_rate = rtw_print_vht_rate_txt;
+				break;
+			default:
+				print_rate = NULL;
+				break;
+			}
+
+			rtw_get_tx_power_params(rtwdev, path, rate, bw,
+						ch, regd, &pwr_param);
+
+			seq_printf(m, "%4c ", path + 'A');
+			if (print_rate)
+				print_rate(m, rate);
+			seq_printf(m, " %3u(0x%02x) %4u %4d (%4d %4d)\n",
+				   hal->tx_pwr_tbl[path][rate],
+				   hal->tx_pwr_tbl[path][rate],
+				   pwr_param.pwr_base,
+				   min_t(s8, pwr_param.pwr_offset,
+					 pwr_param.pwr_limit),
+				   pwr_param.pwr_offset, pwr_param.pwr_limit);
+		}
+	}
+
+	mutex_unlock(&hal->tx_power_mutex);
+
+	return 0;
+}
+
 #define rtw_debug_impl_mac(page, addr)				\
 static struct rtw_debugfs_priv rtw_debug_priv_mac_ ##page = {	\
 	.cb_read = rtw_debug_get_mac_page,			\
@@ -514,6 +621,10 @@ static struct rtw_debugfs_priv rtw_debug_priv_rf_dump = {
 	.cb_read = rtw_debug_get_rf_dump,
 };
 
+static struct rtw_debugfs_priv rtw_debug_priv_tx_pwr_tbl = {
+	.cb_read = rtw_debugfs_get_tx_pwr_tbl,
+};
+
 static struct rtw_debugfs_priv rtw_debug_priv_write_reg = {
 	.cb_write = rtw_debugfs_set_write_reg,
 };
@@ -610,6 +721,7 @@ void rtw_debugfs_init(struct rtw_dev *rtwdev)
 		rtw_debugfs_add_r(bb_41);
 	}
 	rtw_debugfs_add_r(rf_dump);
+	rtw_debugfs_add_r(tx_pwr_tbl);
 }
 
 #endif /* CONFIG_RTW88_DEBUGFS */
-- 
2.7.4

