Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB64677543
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 07:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjAWGyt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 01:54:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbjAWGyr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 01:54:47 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BAD1196AE
        for <linux-wireless@vger.kernel.org>; Sun, 22 Jan 2023 22:54:44 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30N6sUmvD012873, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30N6sUmvD012873
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 23 Jan 2023 14:54:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 23 Jan 2023 14:54:32 +0800
Received: from localhost (172.16.16.32) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 23 Jan
 2023 14:54:32 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/6] wifi: rtw89: add use of pkt_list offload to debug entry
Date:   Mon, 23 Jan 2023 14:53:58 +0800
Message-ID: <20230123065401.14174-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123065401.14174-1-pkshih@realtek.com>
References: <20230123065401.14174-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.32]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/23/2023 06:33:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMjMgpFekyCAxMjozNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Driver can prepare pkt_list for firmware that only uses them to send out
the packets in specific situations. To understand the usage of current
status, and to check if there is leakage problem, dump bitmap and the
indices used by certain function.

An example looks like:

  map:
		...
        pkt_ofld:  3f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ...
                [SCAN 0]: 3
                [SCAN 1]: 4
                [SCAN 3]: 5
  VIF [0] xx:xx:xx:xx:xx:xx
		...
        pkt_ofld[GENERAL]: 0 1 2

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 8297e35bfa52b..ef7959472a646 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3347,6 +3347,31 @@ static void rtw89_dump_addr_cam(struct seq_file *m,
 	}
 }
 
+__printf(3, 4)
+static void rtw89_dump_pkt_offload(struct seq_file *m, struct list_head *pkt_list,
+				   const char *fmt, ...)
+{
+	struct rtw89_pktofld_info *info;
+	struct va_format vaf;
+	va_list args;
+
+	if (list_empty(pkt_list))
+		return;
+
+	va_start(args, fmt);
+	vaf.va = &args;
+	vaf.fmt = fmt;
+
+	seq_printf(m, "%pV", &vaf);
+
+	va_end(args);
+
+	list_for_each_entry(info, pkt_list, list)
+		seq_printf(m, "%d ", info->id);
+
+	seq_puts(m, "\n");
+}
+
 static
 void rtw89_vif_ids_get_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
 {
@@ -3357,6 +3382,7 @@ void rtw89_vif_ids_get_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
 	seq_printf(m, "VIF [%d] %pM\n", rtwvif->mac_id, rtwvif->mac_addr);
 	seq_printf(m, "\tbssid_cam_idx=%u\n", bssid_cam->bssid_cam_idx);
 	rtw89_dump_addr_cam(m, &rtwvif->addr_cam);
+	rtw89_dump_pkt_offload(m, &rtwvif->general_pkt_list, "\tpkt_ofld[GENERAL]: ");
 }
 
 static void rtw89_dump_ba_cam(struct seq_file *m, struct rtw89_sta *rtwsta)
@@ -3395,6 +3421,7 @@ static int rtw89_debug_priv_stations_get(struct seq_file *m, void *v)
 	struct rtw89_debugfs_priv *debugfs_priv = m->private;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
+	u8 idx;
 
 	mutex_lock(&rtwdev->mutex);
 
@@ -3409,6 +3436,15 @@ static int rtw89_debug_priv_stations_get(struct seq_file *m, void *v)
 		   cam_info->sec_cam_map);
 	seq_printf(m, "\tba_cam:    %*ph\n", (int)sizeof(cam_info->ba_cam_map),
 		   cam_info->ba_cam_map);
+	seq_printf(m, "\tpkt_ofld:  %*ph\n", (int)sizeof(rtwdev->pkt_offload),
+		   rtwdev->pkt_offload);
+
+	for (idx = NL80211_BAND_2GHZ; idx < NUM_NL80211_BANDS; idx++) {
+		if (!(rtwdev->chip->support_bands & BIT(idx)))
+			continue;
+		rtw89_dump_pkt_offload(m, &rtwdev->scan_info.pkt_list[idx],
+				       "\t\t[SCAN %u]: ", idx);
+	}
 
 	ieee80211_iterate_active_interfaces_atomic(rtwdev->hw,
 		IEEE80211_IFACE_ITER_NORMAL, rtw89_vif_ids_get_iter, m);
-- 
2.25.1

