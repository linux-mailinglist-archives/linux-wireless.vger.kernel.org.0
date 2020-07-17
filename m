Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515722234E5
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jul 2020 08:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGQGuF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jul 2020 02:50:05 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55023 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGQGuF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jul 2020 02:50:05 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 06H6o0N01028960, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 06H6o0N01028960
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Jul 2020 14:50:01 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Jul 2020 14:50:00 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Jul 2020 14:50:00 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/7] rtw88: add h2c command in debugfs
Date:   Fri, 17 Jul 2020 14:49:37 +0800
Message-ID: <20200717064937.27966-8-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717064937.27966-1-yhchuang@realtek.com>
References: <20200717064937.27966-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

It's very useful to send H2C command for debug usage. Add an entry
for sending H2C command to firmware.

usage example:
echo 42,00,00,43,02,00,00,00 > /sys/kernel/debug/ieee80211/phyX/rtw88

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/debug.c | 30 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/fw.c    |  5 ++++
 drivers/net/wireless/realtek/rtw88/fw.h    |  2 ++
 3 files changed, 37 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 09f04feb8fe1..f769c982cc91 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -344,6 +344,31 @@ static ssize_t rtw_debugfs_set_write_reg(struct file *filp,
 	return count;
 }
 
+static ssize_t rtw_debugfs_set_h2c(struct file *filp,
+				   const char __user *buffer,
+				   size_t count, loff_t *loff)
+{
+	struct rtw_debugfs_priv *debugfs_priv = filp->private_data;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	char tmp[32 + 1];
+	u8 param[8];
+	int num;
+
+	rtw_debugfs_copy_from_user(tmp, sizeof(tmp), buffer, count, 3);
+
+	num = sscanf(tmp, "%hhx,%hhx,%hhx,%hhx,%hhx,%hhx,%hhx,%hhx",
+		     &param[0], &param[1], &param[2], &param[3],
+		     &param[4], &param[5], &param[6], &param[7]);
+	if (num != 8) {
+		rtw_info(rtwdev, "invalid H2C command format for debug\n");
+		return -EINVAL;
+	}
+
+	rtw_fw_h2c_cmd_dbg(rtwdev, param);
+
+	return count;
+}
+
 static ssize_t rtw_debugfs_set_rf_write(struct file *filp,
 					const char __user *buffer,
 					size_t count, loff_t *loff)
@@ -808,6 +833,10 @@ static struct rtw_debugfs_priv rtw_debug_priv_write_reg = {
 	.cb_write = rtw_debugfs_set_write_reg,
 };
 
+static struct rtw_debugfs_priv rtw_debug_priv_h2c = {
+	.cb_write = rtw_debugfs_set_h2c,
+};
+
 static struct rtw_debugfs_priv rtw_debug_priv_rf_write = {
 	.cb_write = rtw_debugfs_set_rf_write,
 };
@@ -877,6 +906,7 @@ void rtw_debugfs_init(struct rtw_dev *rtwdev)
 	rtw_debugfs_add_r(phy_info);
 	rtw_debugfs_add_r(coex_info);
 	rtw_debugfs_add_rw(coex_enable);
+	rtw_debugfs_add_w(h2c);
 	rtw_debugfs_add_r(mac_0);
 	rtw_debugfs_add_r(mac_1);
 	rtw_debugfs_add_r(mac_2);
diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index c922b4bb8d72..63b00bc19000 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -253,6 +253,11 @@ static void rtw_fw_send_h2c_command(struct rtw_dev *rtwdev,
 	spin_unlock(&rtwdev->h2c.lock);
 }
 
+void rtw_fw_h2c_cmd_dbg(struct rtw_dev *rtwdev, u8 *h2c)
+{
+	rtw_fw_send_h2c_command(rtwdev, h2c);
+}
+
 static void rtw_fw_send_h2c_packet(struct rtw_dev *rtwdev, u8 *h2c_pkt)
 {
 	int ret;
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 470e1809645a..686dcd3bbda6 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -563,4 +563,6 @@ void rtw_fw_set_nlo_info(struct rtw_dev *rtwdev, bool enable);
 void rtw_fw_update_pkt_probe_req(struct rtw_dev *rtwdev,
 				 struct cfg80211_ssid *ssid);
 void rtw_fw_channel_switch(struct rtw_dev *rtwdev, bool enable);
+void rtw_fw_h2c_cmd_dbg(struct rtw_dev *rtwdev, u8 *h2c);
+
 #endif
-- 
2.17.1

