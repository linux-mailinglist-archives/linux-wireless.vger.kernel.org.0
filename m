Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE8E57317C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 10:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbiGMIsk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 04:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbiGMIs2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 04:48:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C8BD2ECB99
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 01:48:26 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 26D8mHKt9018993, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 26D8mHKt9018993
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 13 Jul 2022 16:48:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 13 Jul 2022 16:48:19 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Wed, 13 Jul
 2022 16:48:19 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/7] wifi: rtw88: fix WARNING:rtw_get_tx_power_params() during HW scan
Date:   Wed, 13 Jul 2022 16:47:55 +0800
Message-ID: <20220713084758.41654-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713084758.41654-1-pkshih@realtek.com>
References: <20220713084758.41654-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 07/13/2022 08:26:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzcvMTMgpFekyCAwNjo1NDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chih-Kang Chang <gary.chang@realtek.com>

During HW scan, the channel related feilds in hal struct changed partially.
If setting Tx power will get WARNING:rtw_get_tx_power_params() due to some
of fields in hal struct mismatch. Therefore, we fix to change all required
fields in hal struct when channel switch during HW scan.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       | 37 +++++++++++++------
 drivers/net/wireless/realtek/rtw88/fw.h       |  2 +-
 drivers/net/wireless/realtek/rtw88/mac80211.c |  2 +-
 drivers/net/wireless/realtek/rtw88/main.h     |  1 +
 4 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 5ad94022437ba..964b99483c3d6 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -14,6 +14,7 @@
 #include "util.h"
 #include "wow.h"
 #include "ps.h"
+#include "phy.h"
 
 static void rtw_fw_c2h_cmd_handle_ext(struct rtw_dev *rtwdev,
 				      struct sk_buff *skb)
@@ -2087,10 +2088,9 @@ void rtw_hw_scan_complete(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 	rtw_core_scan_complete(rtwdev, vif, true);
 
 	rtwvif = (struct rtw_vif *)vif->drv_priv;
-	if (chan) {
-		hal->current_channel = chan;
-		hal->current_band_type = chan > 14 ? RTW_BAND_5G : RTW_BAND_2G;
-	}
+	if (chan)
+		rtw_store_op_chan(rtwdev, false);
+	rtw_phy_set_tx_power_level(rtwdev, hal->current_channel);
 	ieee80211_wake_queues(rtwdev->hw);
 	ieee80211_scan_completed(rtwdev->hw, &info);
 
@@ -2179,14 +2179,23 @@ void rtw_hw_scan_status_report(struct rtw_dev *rtwdev, struct sk_buff *skb)
 		rtw_dbg(rtwdev, RTW_DBG_HW_SCAN, "HW scan aborted with code: %d\n", rc);
 }
 
-void rtw_store_op_chan(struct rtw_dev *rtwdev)
+void rtw_store_op_chan(struct rtw_dev *rtwdev, bool backup)
 {
 	struct rtw_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct rtw_hal *hal = &rtwdev->hal;
+	u8 band;
 
-	scan_info->op_chan = hal->current_channel;
-	scan_info->op_bw = hal->current_band_width;
-	scan_info->op_pri_ch_idx = hal->current_primary_channel_index;
+	if (backup) {
+		scan_info->op_chan = hal->current_channel;
+		scan_info->op_bw = hal->current_band_width;
+		scan_info->op_pri_ch_idx = hal->current_primary_channel_index;
+		scan_info->op_pri_ch = hal->primary_channel;
+	} else {
+		band = scan_info->op_chan > 14 ? RTW_BAND_5G : RTW_BAND_2G;
+		rtw_update_channel(rtwdev, scan_info->op_chan,
+				   scan_info->op_pri_ch,
+				   band, scan_info->op_bw);
+	}
 }
 
 void rtw_clear_op_chan(struct rtw_dev *rtwdev)
@@ -2196,6 +2205,7 @@ void rtw_clear_op_chan(struct rtw_dev *rtwdev)
 	scan_info->op_chan = 0;
 	scan_info->op_bw = 0;
 	scan_info->op_pri_ch_idx = 0;
+	scan_info->op_pri_ch = 0;
 }
 
 static bool rtw_is_op_chan(struct rtw_dev *rtwdev, u8 channel)
@@ -2210,7 +2220,7 @@ void rtw_hw_scan_chan_switch(struct rtw_dev *rtwdev, struct sk_buff *skb)
 	struct rtw_hal *hal = &rtwdev->hal;
 	struct rtw_c2h_cmd *c2h;
 	enum rtw_scan_notify_id id;
-	u8 chan, status;
+	u8 chan, band, status;
 
 	if (!test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
 		return;
@@ -2221,10 +2231,13 @@ void rtw_hw_scan_chan_switch(struct rtw_dev *rtwdev, struct sk_buff *skb)
 	status = GET_CHAN_SWITCH_STATUS(c2h->payload);
 
 	if (id == RTW_SCAN_NOTIFY_ID_POSTSWITCH) {
-		if (rtw_is_op_chan(rtwdev, chan))
+		band = chan > 14 ? RTW_BAND_5G : RTW_BAND_2G;
+		rtw_update_channel(rtwdev, chan, chan, band,
+				   RTW_CHANNEL_WIDTH_20);
+		if (rtw_is_op_chan(rtwdev, chan)) {
+			rtw_store_op_chan(rtwdev, false);
 			ieee80211_wake_queues(rtwdev->hw);
-		hal->current_channel = chan;
-		hal->current_band_type = chan > 14 ? RTW_BAND_5G : RTW_BAND_2G;
+		}
 	} else if (id == RTW_SCAN_NOTIFY_ID_PRESWITCH) {
 		if (IS_CH_5G_BAND(chan)) {
 			rtw_coex_switchband_notify(rtwdev, COEX_SWITCH_TO_5G);
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 20c56e0312c1e..a5a965803a3cc 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -847,7 +847,7 @@ int rtw_fw_dump_fifo(struct rtw_dev *rtwdev, u8 fifo_sel, u32 addr, u32 size,
 		     u32 *buffer);
 void rtw_fw_scan_notify(struct rtw_dev *rtwdev, bool start);
 void rtw_fw_adaptivity(struct rtw_dev *rtwdev);
-void rtw_store_op_chan(struct rtw_dev *rtwdev);
+void rtw_store_op_chan(struct rtw_dev *rtwdev, bool backup);
 void rtw_clear_op_chan(struct rtw_dev *rtwdev);
 void rtw_hw_scan_start(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 		       struct ieee80211_scan_request *req);
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 2fa94c3024417..f9809b68febbe 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -397,7 +397,7 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 		if (is_zero_ether_addr(rtwvif->bssid))
 			rtw_clear_op_chan(rtwdev);
 		else
-			rtw_store_op_chan(rtwdev);
+			rtw_store_op_chan(rtwdev, true);
 	}
 
 	if (changed & BSS_CHANGED_BEACON_INT) {
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 9bb8053413d24..b50089506857d 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1966,6 +1966,7 @@ struct rtw_hw_scan_info {
 	struct ieee80211_vif *scanning_vif;
 	u8 probe_pg_size;
 	u8 op_pri_ch_idx;
+	u8 op_pri_ch;
 	u8 op_chan;
 	u8 op_bw;
 };
-- 
2.25.1

