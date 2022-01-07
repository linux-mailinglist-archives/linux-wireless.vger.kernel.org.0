Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80F18487165
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 04:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345890AbiAGDnp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 22:43:45 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51127 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345924AbiAGDnc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 22:43:32 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2073hSzF5023041, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2073hSzF5023041
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 7 Jan 2022 11:43:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 11:43:27 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 11:43:27 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 18/19] rtw89: debug: add stations entry to show ID assignment
Date:   Fri, 7 Jan 2022 11:42:38 +0800
Message-ID: <20220107034239.22002-19-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107034239.22002-1-pkshih@realtek.com>
References: <20220107034239.22002-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/07/2022 03:26:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvNyCkV6TIIDAxOjMzOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to trace the relation of IDs, we add this debugfs entry to make
them clear.

The output looks like:
  map:
          mac_id:    07 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
          addr_cam:  07 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
          bssid_cam: 01 00 00 00 00 00 00 00
          sec_cam:   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  VIF [0] 94:08:53:8e:ef:21
          bssid_cam_idx=0
          addr_cam_idx=0
          -> bssid_cam_idx=0
          sec_cam_bitmap=00 00 00 00 00 00 00 00
  STA [1] 58:00:e3:bb:9c:4f
          addr_cam_idx=1
          -> bssid_cam_idx=0
          sec_cam_bitmap=00 00 00 00 00 00 00 00
  STA [2] 94:08:53:8e:ef:75
          addr_cam_idx=2
          -> bssid_cam_idx=0
          sec_cam_bitmap=00 00 00 00 00 00 00 00

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 9756d75ef24e1..45fefa8bd9562 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -2364,6 +2364,72 @@ static int rtw89_debug_priv_phy_info_get(struct seq_file *m, void *v)
 	return 0;
 }
 
+static void rtw89_dump_addr_cam(struct seq_file *m,
+				struct rtw89_addr_cam_entry *addr_cam)
+{
+	struct rtw89_sec_cam_entry *sec_entry;
+	int i;
+
+	seq_printf(m, "\taddr_cam_idx=%u\n", addr_cam->addr_cam_idx);
+	seq_printf(m, "\t-> bssid_cam_idx=%u\n", addr_cam->bssid_cam_idx);
+	seq_printf(m, "\tsec_cam_bitmap=%*ph\n", (int)sizeof(addr_cam->sec_cam_map),
+		   addr_cam->sec_cam_map);
+	for (i = 0; i < RTW89_SEC_CAM_IN_ADDR_CAM; i++) {
+		sec_entry = addr_cam->sec_entries[i];
+		if (!sec_entry)
+			continue;
+		seq_printf(m, "\tsec[%d]: sec_cam_idx %u", i, sec_entry->sec_cam_idx);
+		if (sec_entry->ext_key)
+			seq_printf(m, ", %u", sec_entry->sec_cam_idx + 1);
+		seq_puts(m, "\n");
+	}
+}
+
+static
+void rtw89_vif_ids_get_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct seq_file *m = (struct seq_file *)data;
+	struct rtw89_bssid_cam_entry *bssid_cam = &rtwvif->bssid_cam;
+
+	seq_printf(m, "VIF [%d] %pM\n", rtwvif->mac_id, rtwvif->mac_addr);
+	seq_printf(m, "\tbssid_cam_idx=%u\n", bssid_cam->bssid_cam_idx);
+	rtw89_dump_addr_cam(m, &rtwvif->addr_cam);
+}
+
+static void rtw89_sta_ids_get_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
+	struct seq_file *m = (struct seq_file *)data;
+
+	seq_printf(m, "STA [%d] %pM\n", rtwsta->mac_id, sta->addr);
+	rtw89_dump_addr_cam(m, &rtwsta->addr_cam);
+}
+
+static int rtw89_debug_priv_stations_get(struct seq_file *m, void *v)
+{
+	struct rtw89_debugfs_priv *debugfs_priv = m->private;
+	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
+	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
+
+	seq_puts(m, "map:\n");
+	seq_printf(m, "\tmac_id:    %*ph\n", (int)sizeof(rtwdev->mac_id_map),
+		   rtwdev->mac_id_map);
+	seq_printf(m, "\taddr_cam:  %*ph\n", (int)sizeof(cam_info->addr_cam_map),
+		   cam_info->addr_cam_map);
+	seq_printf(m, "\tbssid_cam: %*ph\n", (int)sizeof(cam_info->bssid_cam_map),
+		   cam_info->bssid_cam_map);
+	seq_printf(m, "\tsec_cam:   %*ph\n", (int)sizeof(cam_info->sec_cam_map),
+		   cam_info->sec_cam_map);
+
+	ieee80211_iterate_active_interfaces_atomic(rtwdev->hw,
+		IEEE80211_IFACE_ITER_NORMAL, rtw89_vif_ids_get_iter, m);
+
+	ieee80211_iterate_stations_atomic(rtwdev->hw, rtw89_sta_ids_get_iter, m);
+
+	return 0;
+}
+
 static struct rtw89_debugfs_priv rtw89_debug_priv_read_reg = {
 	.cb_read = rtw89_debug_priv_read_reg_get,
 	.cb_write = rtw89_debug_priv_read_reg_select,
@@ -2430,6 +2496,10 @@ static struct rtw89_debugfs_priv rtw89_debug_priv_phy_info = {
 	.cb_read = rtw89_debug_priv_phy_info_get,
 };
 
+static struct rtw89_debugfs_priv rtw89_debug_priv_stations = {
+	.cb_read = rtw89_debug_priv_stations_get,
+};
+
 #define rtw89_debugfs_add(name, mode, fopname, parent)				\
 	do {									\
 		rtw89_debug_priv_ ##name.rtwdev = rtwdev;			\
@@ -2468,6 +2538,7 @@ void rtw89_debugfs_init(struct rtw89_dev *rtwdev)
 	rtw89_debugfs_add_w(btc_manual);
 	rtw89_debugfs_add_w(fw_log_manual);
 	rtw89_debugfs_add_r(phy_info);
+	rtw89_debugfs_add_r(stations);
 }
 #endif
 
-- 
2.25.1

