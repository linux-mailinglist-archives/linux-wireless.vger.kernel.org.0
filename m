Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2A86BCF15
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Mar 2023 13:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjCPMOC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Mar 2023 08:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCPMNz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Mar 2023 08:13:55 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C918193EC
        for <linux-wireless@vger.kernel.org>; Thu, 16 Mar 2023 05:13:44 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 32GCDO5p8022859, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 32GCDO5p8022859
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 16 Mar 2023 20:13:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 16 Mar 2023 20:13:16 +0800
Received: from localhost (172.16.16.31) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 16 Mar
 2023 20:13:16 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 4/5] wifi: rtw89: add flag check for power state
Date:   Thu, 16 Mar 2023 20:12:05 +0800
Message-ID: <20230316121206.11479-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230316121206.11479-1-pkshih@realtek.com>
References: <20230316121206.11479-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.31]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
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

Use POWER_ON flag to make sure power on/off is symmetric. Since both
remain_on_channel and hw_scan both alter the power state, this makes
sure that we don't enter/leave IPS mode twice.
Also, replace IPS related functions with inline function that does
similar logic so we can track it more easily.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 7 +++----
 drivers/net/wireless/realtek/rtw89/ps.c   | 6 ++++++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0bcfc995f0ab6..bed1d9f045a4d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2211,8 +2211,7 @@ static void rtw89_ips_work(struct work_struct *work)
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						ips_work);
 	mutex_lock(&rtwdev->mutex);
-	if (rtwdev->hw->conf.flags & IEEE80211_CONF_IDLE)
-		rtw89_enter_ips(rtwdev);
+	rtw89_enter_ips_by_hwflags(rtwdev);
 	mutex_unlock(&rtwdev->mutex);
 }
 
@@ -3509,8 +3508,8 @@ void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 
 	rtwdev->scanning = true;
 	rtw89_leave_lps(rtwdev);
-	if (hw_scan && (rtwdev->hw->conf.flags & IEEE80211_CONF_IDLE))
-		rtw89_leave_ips(rtwdev);
+	if (hw_scan)
+		rtw89_leave_ips_by_hwflags(rtwdev);
 
 	ether_addr_copy(rtwvif->mac_addr, mac_addr);
 	rtw89_btc_ntfy_scan_start(rtwdev, RTW89_PHY_0, chan->band_type);
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index 40498812205ea..cf72861c7adcd 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -155,6 +155,9 @@ void rtw89_enter_ips(struct rtw89_dev *rtwdev)
 
 	set_bit(RTW89_FLAG_INACTIVE_PS, rtwdev->flags);
 
+	if (!test_bit(RTW89_FLAG_POWERON, rtwdev->flags))
+		return;
+
 	rtw89_for_each_rtwvif(rtwdev, rtwvif)
 		rtw89_mac_vif_deinit(rtwdev, rtwvif);
 
@@ -166,6 +169,9 @@ void rtw89_leave_ips(struct rtw89_dev *rtwdev)
 	struct rtw89_vif *rtwvif;
 	int ret;
 
+	if (test_bit(RTW89_FLAG_POWERON, rtwdev->flags))
+		return;
+
 	ret = rtw89_core_start(rtwdev);
 	if (ret)
 		rtw89_err(rtwdev, "failed to leave idle state\n");
-- 
2.25.1

