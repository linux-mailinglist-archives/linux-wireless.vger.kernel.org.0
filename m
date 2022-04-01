Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2BE4EE7F4
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Apr 2022 07:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245221AbiDAFxx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Apr 2022 01:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245206AbiDAFxu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Apr 2022 01:53:50 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C732619AC
        for <linux-wireless@vger.kernel.org>; Thu, 31 Mar 2022 22:52:01 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2315pl3F3019750, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2315pl3F3019750
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 1 Apr 2022 13:51:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Apr 2022 13:51:47 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 1 Apr
 2022 13:51:46 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <ku920601@realtek.com>,
        <phhuang@realtek.com>
Subject: [PATCH v2 1/4] rtw89: change idle mode condition during hw_scan
Date:   Fri, 1 Apr 2022 13:50:40 +0800
Message-ID: <20220401055043.12512-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220401055043.12512-1-pkshih@realtek.com>
References: <20220401055043.12512-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 04/01/2022 05:41:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMSCkV6TIIDAzOjI4OjAw?=
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

From: Po Hao Huang <phhuang@realtek.com>

Previously we only consider single interface's status, idle mode
behavior could be unexpected when multiple interfaces is active.
Change to enter/leave idle mode by mac80211's configuration state.

Signed-off-by: Po Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index c61061358980b..be25b9a42fc11 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1798,9 +1798,9 @@ static void rtw89_ips_work(struct work_struct *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						ips_work);
-
 	mutex_lock(&rtwdev->mutex);
-	rtw89_enter_ips(rtwdev);
+	if (rtwdev->hw->conf.flags & IEEE80211_CONF_IDLE)
+		rtw89_enter_ips(rtwdev);
 	mutex_unlock(&rtwdev->mutex);
 }
 
@@ -2703,7 +2703,7 @@ void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 
 	rtwdev->scanning = true;
 	rtw89_leave_lps(rtwdev);
-	if (hw_scan && rtwvif->net_type == RTW89_NET_TYPE_NO_LINK)
+	if (hw_scan && (rtwdev->hw->conf.flags & IEEE80211_CONF_IDLE))
 		rtw89_leave_ips(rtwdev);
 
 	ether_addr_copy(rtwvif->mac_addr, mac_addr);
@@ -2727,7 +2727,7 @@ void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 
 	rtwdev->scanning = false;
 	rtwdev->dig.bypass_dig = true;
-	if (hw_scan && rtwvif->net_type == RTW89_NET_TYPE_NO_LINK)
+	if (hw_scan && (rtwdev->hw->conf.flags & IEEE80211_CONF_IDLE))
 		ieee80211_queue_work(rtwdev->hw, &rtwdev->ips_work);
 }
 
-- 
2.25.1

