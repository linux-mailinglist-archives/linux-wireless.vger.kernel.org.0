Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A236259957A
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Aug 2022 08:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244274AbiHSGsu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Aug 2022 02:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244973AbiHSGsq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Aug 2022 02:48:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA0BC4C603
        for <linux-wireless@vger.kernel.org>; Thu, 18 Aug 2022 23:48:40 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 27J6mEA11001739, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 27J6mEA11001739
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 19 Aug 2022 14:48:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 19 Aug 2022 14:48:27 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 19 Aug
 2022 14:48:27 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <timlee@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 1/5] wifi: rtw89: add retry to change power_mode state
Date:   Fri, 19 Aug 2022 14:48:07 +0800
Message-ID: <20220819064811.37700-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819064811.37700-1-pkshih@realtek.com>
References: <20220819064811.37700-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 08/19/2022 06:25:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvMTkgpFekyCAwMTo1MzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

When starting to send heavy traffic in low power mode,
driver will call multiple tx wake notify to wake firmware
within a short time. In this situation, firmware may miss
power mode change request from driver and leads to status
error. So we change driver to call power_mode_change at most
three times to make sure firmware could get the request.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 23 +++++++++++++++++------
 drivers/net/wireless/realtek/rtw89/mac.h |  1 +
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 93124b815825f..61c7e79714925 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1053,18 +1053,29 @@ void rtw89_mac_power_mode_change(struct rtw89_dev *rtwdev, bool enter)
 	enum rtw89_rpwm_req_pwr_state state;
 	unsigned long delay = enter ? 10 : 150;
 	int ret;
+	int i;
 
 	if (enter)
 		state = rtw89_mac_get_req_pwr_state(rtwdev);
 	else
 		state = RTW89_MAC_RPWM_REQ_PWR_STATE_ACTIVE;
 
-	rtw89_mac_send_rpwm(rtwdev, state, false);
-	ret = read_poll_timeout_atomic(rtw89_mac_check_cpwm_state, ret, !ret,
-				       delay, 15000, false, rtwdev, state);
-	if (ret)
-		rtw89_err(rtwdev, "firmware failed to ack for %s ps mode\n",
-			  enter ? "entering" : "leaving");
+	for (i = 0; i < RPWM_TRY_CNT; i++) {
+		rtw89_mac_send_rpwm(rtwdev, state, false);
+		ret = read_poll_timeout_atomic(rtw89_mac_check_cpwm_state, ret,
+					       !ret, delay, 15000, false,
+					       rtwdev, state);
+		if (!ret)
+			break;
+
+		if (i == RPWM_TRY_CNT - 1)
+			rtw89_err(rtwdev, "firmware failed to ack for %s ps mode\n",
+				  enter ? "entering" : "leaving");
+		else
+			rtw89_debug(rtwdev, RTW89_DBG_UNEXP,
+				    "%d time firmware failed to ack for %s ps mode\n",
+				    i + 1, enter ? "entering" : "leaving");
+	}
 }
 
 void rtw89_mac_notify_wake(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index f66619354734d..986e359a82237 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -11,6 +11,7 @@
 #define ADDR_CAM_ENT_SIZE  0x40
 #define BSSID_CAM_ENT_SIZE 0x08
 #define HFC_PAGE_UNIT 64
+#define RPWM_TRY_CNT 3
 
 enum rtw89_mac_hwmod_sel {
 	RTW89_DMAC_SEL = 0,
-- 
2.25.1

