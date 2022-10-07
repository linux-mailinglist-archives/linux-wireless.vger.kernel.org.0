Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21965F73C7
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Oct 2022 06:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiJGE7Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Oct 2022 00:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJGE7W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Oct 2022 00:59:22 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 77237112AA6
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 21:59:20 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2974wincF015218, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2974wincF015218
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 7 Oct 2022 12:58:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 7 Oct 2022 12:59:12 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 7 Oct 2022
 12:59:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] wifi: rtw89: correct 6 GHz scan behavior
Date:   Fri, 7 Oct 2022 12:58:59 +0800
Message-ID: <20221007045900.10823-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-Antiphishing-Bases: 10/07/2022 04:26:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzcgpFekyCAxMjoyNDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Change active scan behavior to fit 6GHz requirements. There are many
different rules on active scan between 6GHz and 2GHz/5GHz, so if the
SSID is not specified, do fast passive scanning and limit number of
probe requests we send for now until new firmware can support all
rules.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 28 +++++++++++++++++++------
 drivers/net/wireless/realtek/rtw89/fw.h |  1 +
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d57e3610fb88e..bdcc7af737ea2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2565,6 +2565,9 @@ static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 				   struct rtw89_mac_chinfo *ch_info)
 {
 	struct rtw89_hw_scan_info *scan_info = &rtwdev->scan_info;
+	struct ieee80211_vif *vif = rtwdev->scan_info.scanning_vif;
+	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
+	struct cfg80211_scan_request *req = rtwvif->scan_req;
 	struct rtw89_pktofld_info *info;
 	u8 band, probe_count = 0;
 
@@ -2576,13 +2579,13 @@ static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 	ch_info->tx_pwr_idx = 0;
 	ch_info->tx_null = false;
 	ch_info->pause_data = false;
+	ch_info->probe_id = RTW89_SCANOFLD_PKT_NONE;
 
 	if (ssid_num) {
 		ch_info->num_pkt = ssid_num;
 		band = rtw89_hw_to_nl80211_band(ch_info->ch_band);
 
 		list_for_each_entry(info, &scan_info->pkt_list[band], list) {
-			ch_info->probe_id = info->id;
 			ch_info->pkt_id[probe_count] = info->id;
 			if (++probe_count >= ssid_num)
 				break;
@@ -2591,9 +2594,16 @@ static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 			rtw89_err(rtwdev, "SSID num differs from list len\n");
 	}
 
+	if (ch_info->ch_band == RTW89_BAND_6G) {
+		if (ssid_num == 1 && req->ssids[0].ssid_len == 0) {
+			ch_info->tx_pkt = false;
+			if (!req->duration_mandatory)
+				ch_info->period -= RTW89_DWELL_TIME;
+		}
+	}
+
 	switch (chan_type) {
 	case RTW89_CHAN_OPERATE:
-		ch_info->probe_id = RTW89_SCANOFLD_PKT_NONE;
 		ch_info->central_ch = scan_info->op_chan;
 		ch_info->pri_ch = scan_info->op_pri_ch;
 		ch_info->ch_band = scan_info->op_band;
@@ -2602,8 +2612,9 @@ static void rtw89_hw_scan_add_chan(struct rtw89_dev *rtwdev, int chan_type,
 		ch_info->num_pkt = 0;
 		break;
 	case RTW89_CHAN_DFS:
-		ch_info->period = max_t(u8, ch_info->period,
-					RTW89_DFS_CHAN_TIME);
+		if (ch_info->ch_band != RTW89_BAND_6G)
+			ch_info->period = max_t(u8, ch_info->period,
+						RTW89_DFS_CHAN_TIME);
 		ch_info->dwell_time = RTW89_DWELL_TIME;
 		break;
 	case RTW89_CHAN_ACTIVE:
@@ -2637,8 +2648,13 @@ static int rtw89_hw_scan_add_chan_list(struct rtw89_dev *rtwdev,
 			goto out;
 		}
 
-		ch_info->period = req->duration_mandatory ?
-				  req->duration : RTW89_CHANNEL_TIME;
+		if (req->duration_mandatory)
+			ch_info->period = req->duration;
+		else if (channel->band == NL80211_BAND_6GHZ)
+			ch_info->period = RTW89_CHANNEL_TIME_6G + RTW89_DWELL_TIME;
+		else
+			ch_info->period = RTW89_CHANNEL_TIME;
+
 		ch_info->ch_band = rtw89_nl80211_to_hw_band(channel->band);
 		ch_info->central_ch = channel->hw_value;
 		ch_info->pri_ch = channel->hw_value;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 0047d5d0e9b19..6ef392ef9c6fb 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -197,6 +197,7 @@ struct rtw89_h2creg_sch_tx_en {
 
 #define RTW89_H2C_MAX_SIZE 2048
 #define RTW89_CHANNEL_TIME 45
+#define RTW89_CHANNEL_TIME_6G 20
 #define RTW89_DFS_CHAN_TIME 105
 #define RTW89_OFF_CHAN_TIME 100
 #define RTW89_DWELL_TIME 20
-- 
2.25.1

