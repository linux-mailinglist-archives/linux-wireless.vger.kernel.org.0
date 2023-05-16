Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0A07047B0
	for <lists+linux-wireless@lfdr.de>; Tue, 16 May 2023 10:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjEPIZV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 04:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjEPIZT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 04:25:19 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B1B30EA
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 01:25:17 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34G8OurT6024306, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34G8OurT6024306
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 16 May 2023 16:24:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 16 May 2023 16:25:05 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 16 May
 2023 16:25:04 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/3] wifi: rtw89: ser: reset total_sta_assoc and tdls_peer when L2
Date:   Tue, 16 May 2023 16:24:39 +0800
Message-ID: <20230516082441.11154-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230516082441.11154-1-pkshih@realtek.com>
References: <20230516082441.11154-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

The total_sta_assoc and the tdls_peer are used for statistics accodring
to stations' information. L2 (Level 2) SER (system error recovery) will
call ieee80211_restart_hw() which re-invokes sta_state ops. And then,
the total_sta_assoc and tdls_peer will be re-increased. In case wrong
statistics results, we reset them in SER L2 handling.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/ser.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 9ba99f3764e7e..54b314b8b3292 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -303,6 +303,7 @@ static void ser_reset_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_core_release_bit_map(rtwdev->hw_port, rtwvif->port);
 	rtwvif->net_type = RTW89_NET_TYPE_NO_LINK;
 	rtwvif->trigger = false;
+	rtwvif->tdls_peer = 0;
 }
 
 static void ser_sta_deinit_cam_iter(void *data, struct ieee80211_sta *sta)
@@ -341,6 +342,8 @@ static void ser_reset_mac_binding(struct rtw89_dev *rtwdev)
 	rtw89_core_release_all_bits_map(rtwdev->mac_id_map, RTW89_MAX_MAC_ID_NUM);
 	rtw89_for_each_rtwvif(rtwdev, rtwvif)
 		ser_reset_vif(rtwdev, rtwvif);
+
+	rtwdev->total_sta_assoc = 0;
 }
 
 /* hal function */
-- 
2.25.1

