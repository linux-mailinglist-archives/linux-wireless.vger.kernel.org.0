Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9782512959
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Apr 2022 04:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbiD1CJV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Apr 2022 22:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbiD1CJU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Apr 2022 22:09:20 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC71938D
        for <linux-wireless@vger.kernel.org>; Wed, 27 Apr 2022 19:06:03 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23S25osdE032452, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23S25osdE032452
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Apr 2022 10:05:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 10:05:50 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 28 Apr
 2022 10:05:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <gary.chang@realtek.com>
Subject: [PATCH 3/3] rtw88: fix hw scan may cause disconnect issue
Date:   Thu, 28 Apr 2022 10:05:21 +0800
Message-ID: <20220428020521.8015-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220428020521.8015-1-pkshih@realtek.com>
References: <20220428020521.8015-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 04/28/2022 01:50:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjggpFekyCAwMTowOTowMA==?=
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

From: Chih-Kang Chang <gary.chang@realtek.com>

After scan aborts we still receive some hw scan c2h packets, and
processing these c2h commands will change current channel. If device
already connect to other AP, driver will set wrong op channel due
to current channel changed. The disconnection happens when hw scan back
to wrong op channel that device can't receive beacon from AP. To fix
this issue, we ignore the late c2h if we are not scanning, and set
current channel back to op channel after scan to align the FW behavior.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 28cc8d680be31..e344e058f9432 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -2056,7 +2056,10 @@ void rtw_hw_scan_complete(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 	struct cfg80211_scan_info info = {
 		.aborted = aborted,
 	};
+	struct rtw_hw_scan_info *scan_info = &rtwdev->scan_info;
+	struct rtw_hal *hal = &rtwdev->hal;
 	struct rtw_vif *rtwvif;
+	u8 chan = scan_info->op_chan;
 
 	if (!vif)
 		return;
@@ -2066,10 +2069,14 @@ void rtw_hw_scan_complete(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 
 	rtw_core_scan_complete(rtwdev, vif, true);
 
+	rtwvif = (struct rtw_vif *)vif->drv_priv;
+	if (rtwvif->net_type == RTW_NET_MGD_LINKED) {
+		hal->current_channel = chan;
+		hal->current_band_type = chan > 14 ? RTW_BAND_5G : RTW_BAND_2G;
+	}
 	ieee80211_wake_queues(rtwdev->hw);
 	ieee80211_scan_completed(rtwdev->hw, &info);
 
-	rtwvif = (struct rtw_vif *)vif->drv_priv;
 	rtwvif->scan_req = NULL;
 	rtwvif->scan_ies = NULL;
 	rtwdev->scan_info.scanning_vif = NULL;
@@ -2178,6 +2185,9 @@ void rtw_hw_scan_chan_switch(struct rtw_dev *rtwdev, struct sk_buff *skb)
 	enum rtw_scan_notify_id id;
 	u8 chan, status;
 
+	if (!test_bit(RTW_FLAG_SCANNING, rtwdev->flags))
+		return;
+
 	c2h = get_c2h_from_skb(skb);
 	chan = GET_CHAN_SWITCH_CENTRAL_CH(c2h->payload);
 	id = GET_CHAN_SWITCH_ID(c2h->payload);
-- 
2.25.1

