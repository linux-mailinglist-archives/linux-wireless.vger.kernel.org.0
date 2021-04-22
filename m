Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8148C3677AA
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Apr 2021 05:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbhDVDFS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 23:05:18 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:45296 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhDVDFO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 23:05:14 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 13M34XMB0021051, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 13M34XMB0021051
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 22 Apr 2021 11:04:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 22 Apr 2021 11:04:32 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 22 Apr
 2021 11:04:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <steventing@realtek.com>
Subject: [PATCH v2 2/2] rtw88: add debugfs to force lowest basic rate
Date:   Thu, 22 Apr 2021 11:04:13 +0800
Message-ID: <20210422030413.9738-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210422030413.9738-1-pkshih@realtek.com>
References: <20210422030413.9738-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXH36502.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzQvMjEgpFWkyCAxMToyMzowMA==?=
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/22/2021 02:42:46
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163276 [Apr 21 2021]
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
X-KSE-Antiphishing-Bases: 04/22/2021 02:45:00
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 04/22/2021 02:46:47
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 10
X-KSE-AntiSpam-Info: Lua profiles 163276 [Apr 21 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 442 442 b985cb57763b61d2a20abb585d5d4cc10c315b09
X-KSE-AntiSpam-Info: {Prob_from_in_msgid}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: realtek.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 10
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/22/2021 02:50:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yu-Yen Ting <steventing@realtek.com>

The management frame with high rate e.g. 24M may not be transmitted
smoothly in long range environment.
Add a debugfs to force to use the lowest basic rate
in order to debug the reachability of transmitting management frame.

obtain current setting
cat /sys/kernel/debug/ieee80211/phyX/rtw88/basic_rates

force lowest rate:
echo 1 > /sys/kernel/debug/ieee80211/phyX/rtw88/basic_rates

Signed-off-by: Yu-Yen Ting <steventing@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c | 39 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/main.h  |  1 +
 drivers/net/wireless/realtek/rtw88/tx.c    |  3 +-
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 18ab472ea46c..a99a3dc6f9f9 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -861,6 +861,39 @@ static int rtw_debugfs_get_fw_crash(struct seq_file *m, void *v)
 	return 0;
 }
 
+static ssize_t rtw_debugfs_set_basic_rates(struct file *filp,
+					   const char __user *buffer,
+					   size_t count, loff_t *loff)
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
+	if (input)
+		set_bit(RTW_FLAG_USE_LOWEST_RATE, rtwdev->flags);
+	else
+		clear_bit(RTW_FLAG_USE_LOWEST_RATE, rtwdev->flags);
+
+	return count;
+}
+
+static int rtw_debugfs_get_basic_rates(struct seq_file *m, void *v)
+{
+	struct rtw_debugfs_priv *debugfs_priv = m->private;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+
+	seq_printf(m, "use lowest: %d\n",
+		   test_bit(RTW_FLAG_USE_LOWEST_RATE, rtwdev->flags));
+
+	return 0;
+}
+
 static ssize_t rtw_debugfs_set_dm_cap(struct file *filp,
 				      const char __user *buffer,
 				      size_t count, loff_t *loff)
@@ -1046,6 +1079,11 @@ static struct rtw_debugfs_priv rtw_debug_priv_fw_crash = {
 	.cb_read = rtw_debugfs_get_fw_crash,
 };
 
+static struct rtw_debugfs_priv rtw_debug_priv_basic_rates = {
+	.cb_write = rtw_debugfs_set_basic_rates,
+	.cb_read = rtw_debugfs_get_basic_rates,
+};
+
 static struct rtw_debugfs_priv rtw_debug_priv_dm_cap = {
 	.cb_write = rtw_debugfs_set_dm_cap,
 	.cb_read = rtw_debugfs_get_dm_cap,
@@ -1125,6 +1163,7 @@ void rtw_debugfs_init(struct rtw_dev *rtwdev)
 	rtw_debugfs_add_r(rf_dump);
 	rtw_debugfs_add_r(tx_pwr_tbl);
 	rtw_debugfs_add_rw(fw_crash);
+	rtw_debugfs_add_rw(basic_rates);
 	rtw_debugfs_add_rw(dm_cap);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index dc3744847ba9..0df5df3a62ab 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -362,6 +362,7 @@ enum rtw_flags {
 	RTW_FLAG_BUSY_TRAFFIC,
 	RTW_FLAG_WOWLAN,
 	RTW_FLAG_RESTARTING,
+	RTW_FLAG_USE_LOWEST_RATE,
 
 	NUM_OF_RTW_FLAGS,
 };
diff --git a/drivers/net/wireless/realtek/rtw88/tx.c b/drivers/net/wireless/realtek/rtw88/tx.c
index e5949a775283..0aeed15736c8 100644
--- a/drivers/net/wireless/realtek/rtw88/tx.c
+++ b/drivers/net/wireless/realtek/rtw88/tx.c
@@ -238,8 +238,9 @@ static u8 rtw_get_mgmt_rate(struct rtw_dev *rtwdev, struct sk_buff *skb,
 {
 	struct ieee80211_tx_info *tx_info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_vif *vif = tx_info->control.vif;
+	bool use_lowest = test_bit(RTW_FLAG_USE_LOWEST_RATE, rtwdev->flags);
 
-	if (!vif || !vif->bss_conf.basic_rates || ignore_rate)
+	if (!vif || !vif->bss_conf.basic_rates || ignore_rate || use_lowest)
 		return lowest_rate;
 
 	return __ffs(vif->bss_conf.basic_rates) + lowest_rate;
-- 
2.21.0

