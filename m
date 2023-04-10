Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EF76DC34F
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Apr 2023 07:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjDJFfJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Apr 2023 01:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJFfH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Apr 2023 01:35:07 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0697F30F4
        for <linux-wireless@vger.kernel.org>; Sun,  9 Apr 2023 22:35:06 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33A5YTaiC024131, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33A5YTaiC024131
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 10 Apr 2023 13:34:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 10 Apr 2023 13:34:50 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 10 Apr
 2023 13:34:50 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <timlee@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw89: fix power save function in WoWLAN mode
Date:   Mon, 10 Apr 2023 13:34:38 +0800
Message-ID: <20230410053438.10682-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230410053438.10682-1-pkshih@realtek.com>
References: <20230410053438.10682-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chih-Kang Chang <gary.chang@realtek.com>

In WoWLAN Mode, it's expected that WiFi chip could enter power save mode
only after all setting is finished, but current wow_enter_lps function
break the rule and may lead to WoWLAN function fail in low probability,
so fix it.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 2 +-
 drivers/net/wireless/realtek/rtw89/ps.c   | 6 ++++--
 drivers/net/wireless/realtek/rtw89/ps.h   | 3 ++-
 drivers/net/wireless/realtek/rtw89/wow.c  | 2 +-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 56a13be2e2833..5f7408dc74b13 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2266,7 +2266,7 @@ static void rtw89_vif_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwv
 
 	if (rtwvif->stats.tx_tfc_lv == RTW89_TFC_IDLE &&
 	    rtwvif->stats.rx_tfc_lv == RTW89_TFC_IDLE)
-		rtw89_enter_lps(rtwdev, rtwvif);
+		rtw89_enter_lps(rtwdev, rtwvif, true);
 }
 
 static void rtw89_enter_lps_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index 40498812205ea..00d309936c55c 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -114,7 +114,8 @@ void rtw89_leave_ps_mode(struct rtw89_dev *rtwdev)
 	__rtw89_leave_ps_mode(rtwdev);
 }
 
-void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
+void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+		     bool ps_mode)
 {
 	lockdep_assert_held(&rtwdev->mutex);
 
@@ -122,7 +123,8 @@ void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 		return;
 
 	__rtw89_enter_lps(rtwdev, rtwvif->mac_id);
-	__rtw89_enter_ps_mode(rtwdev, rtwvif);
+	if (ps_mode)
+		__rtw89_enter_ps_mode(rtwdev, rtwvif);
 }
 
 static void rtw89_leave_lps_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
diff --git a/drivers/net/wireless/realtek/rtw89/ps.h b/drivers/net/wireless/realtek/rtw89/ps.h
index 6ac1f7ea53394..a33a4a3c66fe0 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.h
+++ b/drivers/net/wireless/realtek/rtw89/ps.h
@@ -5,7 +5,8 @@
 #ifndef __RTW89_PS_H_
 #define __RTW89_PS_H_
 
-void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
+void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
+		     bool ps_mode);
 void rtw89_leave_lps(struct rtw89_dev *rtwdev);
 void __rtw89_leave_ps_mode(struct rtw89_dev *rtwdev);
 void __rtw89_enter_ps_mode(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 7cff9c1d8d378..2ca8abb70f110 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -30,7 +30,7 @@ static void rtw89_wow_enter_lps(struct rtw89_dev *rtwdev)
 	struct ieee80211_vif *wow_vif = rtwdev->wow.wow_vif;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)wow_vif->drv_priv;
 
-	rtw89_enter_lps(rtwdev, rtwvif);
+	rtw89_enter_lps(rtwdev, rtwvif, false);
 }
 
 static void rtw89_wow_leave_lps(struct rtw89_dev *rtwdev)
-- 
2.25.1

