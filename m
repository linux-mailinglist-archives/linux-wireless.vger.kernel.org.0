Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D77A8183FA8
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Mar 2020 04:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgCMDac (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 23:30:32 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:54226 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgCMDac (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 23:30:32 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02D3UBGZ000329, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02D3UBGZ000329
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Mar 2020 11:30:11 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 13 Mar 2020 11:30:11 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 13 Mar 2020 11:30:11 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <johannes@sipsolutions.net>, <arend.vanspriel@broadcom.com>,
        <tamizhr@codeaurora.org>
Subject: [PATCH v3 2/2] rtw88: add a debugfs entry to enable/disable coex mechanism
Date:   Fri, 13 Mar 2020 11:30:07 +0800
Message-ID: <20200313033008.20070-3-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313033008.20070-1-yhchuang@realtek.com>
References: <20200313033008.20070-1-yhchuang@realtek.com>
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

Sometimes we need to stop the coex mechanism to debug, so that we
can manually control the device through various outer commands.
Hence, add a new debugfs coex_enable to allow us to enable/disable
the coex mechanism when driver is running.

To disable coex
echo 0 > /sys/kernel/debug/ieee80211/phyX/rtw88/coex_enable

To enable coex
echo 1 > /sys/kernel/debug/ieee80211/phyX/rtw88/coex_enable

To check coex dm is enabled or not
cat /sys/kernel/debug/ieee80211/phyX/rtw88/coex_enable

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v2
  * no change

v2 -> v3
  * use kstrtobool() instead of sscanf()

 drivers/net/wireless/realtek/rtw88/debug.c | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index b2d264270752..b4964306de61 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -706,6 +706,45 @@ static int rtw_debugfs_get_coex_info(struct seq_file *m, void *v)
 	return 0;
 }
 
+static ssize_t rtw_debugfs_set_coex_enable(struct file *filp,
+					   const char __user *buffer,
+					   size_t count, loff_t *loff)
+{
+	struct seq_file *seqpriv = (struct seq_file *)filp->private_data;
+	struct rtw_debugfs_priv *debugfs_priv = seqpriv->private;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	struct rtw_coex *coex = &rtwdev->coex;
+	char tmp[32 + 1];
+	bool enable;
+	int ret;
+
+	rtw_debugfs_copy_from_user(tmp, sizeof(tmp), buffer, count, 1);
+
+	ret = kstrtobool(tmp, &enable);
+	if (ret) {
+		rtw_warn(rtwdev, "invalid arguments\n");
+		return ret;
+	}
+
+	mutex_lock(&rtwdev->mutex);
+	coex->stop_dm = enable == 0;
+	mutex_unlock(&rtwdev->mutex);
+
+	return count;
+}
+
+static int rtw_debugfs_get_coex_enable(struct seq_file *m, void *v)
+{
+	struct rtw_debugfs_priv *debugfs_priv = m->private;
+	struct rtw_dev *rtwdev = debugfs_priv->rtwdev;
+	struct rtw_coex *coex = &rtwdev->coex;
+
+	seq_printf(m, "coex mechanism %s\n",
+		   coex->stop_dm ? "disabled" : "enabled");
+
+	return 0;
+}
+
 #define rtw_debug_impl_mac(page, addr)				\
 static struct rtw_debugfs_priv rtw_debug_priv_mac_ ##page = {	\
 	.cb_read = rtw_debug_get_mac_page,			\
@@ -796,6 +835,11 @@ static struct rtw_debugfs_priv rtw_debug_priv_phy_info = {
 	.cb_read = rtw_debugfs_get_phy_info,
 };
 
+static struct rtw_debugfs_priv rtw_debug_priv_coex_enable = {
+	.cb_write = rtw_debugfs_set_coex_enable,
+	.cb_read = rtw_debugfs_get_coex_enable,
+};
+
 static struct rtw_debugfs_priv rtw_debug_priv_coex_info = {
 	.cb_read = rtw_debugfs_get_coex_info,
 };
@@ -831,6 +875,7 @@ void rtw_debugfs_init(struct rtw_dev *rtwdev)
 	rtw_debugfs_add_rw(rsvd_page);
 	rtw_debugfs_add_r(phy_info);
 	rtw_debugfs_add_r(coex_info);
+	rtw_debugfs_add_rw(coex_enable);
 	rtw_debugfs_add_r(mac_0);
 	rtw_debugfs_add_r(mac_1);
 	rtw_debugfs_add_r(mac_2);
-- 
2.17.1

