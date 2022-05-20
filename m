Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954E052E715
	for <lists+linux-wireless@lfdr.de>; Fri, 20 May 2022 10:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239778AbiETIPz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 May 2022 04:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbiETIPy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 May 2022 04:15:54 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144CB20F7B
        for <linux-wireless@vger.kernel.org>; Fri, 20 May 2022 01:15:51 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24K8FYYS0008250, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24K8FYYS0008250
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 May 2022 16:15:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 20 May 2022 16:15:34 +0800
Received: from localhost (172.16.17.21) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 20 May
 2022 16:15:33 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH] rtw88: fix null vif pointer when hw_scan fails
Date:   Fri, 20 May 2022 16:15:23 +0800
Message-ID: <20220520081523.45987-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.21]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 05/20/2022 07:59:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMjAgpFekyCAwNjozNDowMA==?=
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

From: Po-Hao Huang <phhuang@realtek.com>

Add this check to avoid crash by dereferencing a null pointer. When hwscan
fails due to no memory or dma failure, the scan flag in ieee80211_local is
cleared. So mac80211 determine that it's not hw_scan then calls
sw_scan_complete() with null vif, which is also freed during the fail.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 14289f83feb54..d298cba23e3d3 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1383,9 +1383,12 @@ void rtw_core_scan_start(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif,
 void rtw_core_scan_complete(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 			    bool hw_scan)
 {
-	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
+	struct rtw_vif *rtwvif = vif ? (struct rtw_vif *)vif->drv_priv : NULL;
 	u32 config = 0;
 
+	if (!rtwvif)
+		return;
+
 	clear_bit(RTW_FLAG_SCANNING, rtwdev->flags);
 	clear_bit(RTW_FLAG_DIG_DISABLE, rtwdev->flags);
 
-- 
2.25.1

