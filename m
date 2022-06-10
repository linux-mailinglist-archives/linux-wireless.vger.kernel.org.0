Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9D8545CAE
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 08:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242210AbiFJGwG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 02:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346455AbiFJGwA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 02:52:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D0D36E01
        for <linux-wireless@vger.kernel.org>; Thu,  9 Jun 2022 23:51:55 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 25A6pgAI3000807, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 25A6pgAI3000807
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jun 2022 14:51:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 14:51:42 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 10 Jun
 2022 14:51:41 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <gary.chang@realtek.com>,
        <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 4/5] rtw88: fix store OP channel info timing when HW scan
Date:   Fri, 10 Jun 2022 14:51:01 +0800
Message-ID: <20220610065102.17580-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610065102.17580-1-pkshih@realtek.com>
References: <20220610065102.17580-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 06/10/2022 06:35:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzYvMTAgpFekyCAwNDoyMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
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

The original timing that store OP channel info is after associated.
However, HW scan might happen before associated without backing to
OP channel, that will cause authentication or association fail.
Therefore, we modify the timing of storing OP channel info.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       | 14 ++++++++++++--
 drivers/net/wireless/realtek/rtw88/fw.h       |  1 +
 drivers/net/wireless/realtek/rtw88/mac80211.c |  5 ++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index bb2e743d2ab22..85a8491e44066 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -2077,7 +2077,7 @@ void rtw_hw_scan_complete(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 	rtw_core_scan_complete(rtwdev, vif, true);
 
 	rtwvif = (struct rtw_vif *)vif->drv_priv;
-	if (rtwvif->net_type == RTW_NET_MGD_LINKED) {
+	if (chan) {
 		hal->current_channel = chan;
 		hal->current_band_type = chan > 14 ? RTW_BAND_5G : RTW_BAND_2G;
 	}
@@ -2121,6 +2121,7 @@ int rtw_hw_scan_offload(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 			bool enable)
 {
 	struct rtw_vif *rtwvif = vif ? (struct rtw_vif *)vif->drv_priv : NULL;
+	struct rtw_hw_scan_info *scan_info = &rtwdev->scan_info;
 	struct rtw_ch_switch_option cs_option = {0};
 	struct rtw_chan_list chan_list = {0};
 	int ret = 0;
@@ -2129,7 +2130,7 @@ int rtw_hw_scan_offload(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 		return -EINVAL;
 
 	cs_option.switch_en = enable;
-	cs_option.back_op_en = rtwvif->net_type == RTW_NET_MGD_LINKED;
+	cs_option.back_op_en = scan_info->op_chan != 0;
 	if (enable) {
 		ret = rtw_hw_scan_prehandle(rtwdev, rtwvif, &chan_list);
 		if (ret)
@@ -2178,6 +2179,15 @@ void rtw_store_op_chan(struct rtw_dev *rtwdev)
 	scan_info->op_pri_ch_idx = hal->current_primary_channel_index;
 }
 
+void rtw_clear_op_chan(struct rtw_dev *rtwdev)
+{
+	struct rtw_hw_scan_info *scan_info = &rtwdev->scan_info;
+
+	scan_info->op_chan = 0;
+	scan_info->op_bw = 0;
+	scan_info->op_pri_ch_idx = 0;
+}
+
 static bool rtw_is_op_chan(struct rtw_dev *rtwdev, u8 channel)
 {
 	struct rtw_hw_scan_info *scan_info = &rtwdev->scan_info;
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 5bb69d89a146b..d73894b226289 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -847,6 +847,7 @@ int rtw_fw_dump_fifo(struct rtw_dev *rtwdev, u8 fifo_sel, u32 addr, u32 size,
 void rtw_fw_scan_notify(struct rtw_dev *rtwdev, bool start);
 void rtw_fw_adaptivity(struct rtw_dev *rtwdev);
 void rtw_store_op_chan(struct rtw_dev *rtwdev);
+void rtw_clear_op_chan(struct rtw_dev *rtwdev);
 void rtw_hw_scan_start(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 		       struct ieee80211_scan_request *req);
 void rtw_hw_scan_complete(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index 2e322f75fd162..18e0448e97247 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -377,7 +377,6 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 			rtw_coex_media_status_notify(rtwdev, conf->assoc);
 			if (rtw_bf_support)
 				rtw_bf_assoc(rtwdev, vif, conf);
-			rtw_store_op_chan(rtwdev);
 		} else {
 			rtw_leave_lps(rtwdev);
 			rtw_bf_disassoc(rtwdev, vif, conf);
@@ -395,6 +394,10 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_BSSID) {
 		ether_addr_copy(rtwvif->bssid, conf->bssid);
 		config |= PORT_SET_BSSID;
+		if (is_zero_ether_addr(rtwvif->bssid))
+			rtw_clear_op_chan(rtwdev);
+		else
+			rtw_store_op_chan(rtwdev);
 	}
 
 	if (changed & BSS_CHANGED_BEACON_INT) {
-- 
2.25.1

