Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4553E6DE8D9
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Apr 2023 03:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjDLB2y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Apr 2023 21:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjDLB2w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Apr 2023 21:28:52 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569A73594
        for <linux-wireless@vger.kernel.org>; Tue, 11 Apr 2023 18:28:51 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33C1SNsM4009271, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33C1SNsM4009271
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 12 Apr 2023 09:28:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 12 Apr 2023 09:28:44 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 12 Apr
 2023 09:28:44 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/4] wifi: rtw89: coex: Add path control register to monitor list
Date:   Wed, 12 Apr 2023 09:28:29 +0800
Message-ID: <20230412012831.10519-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230412012831.10519-1-pkshih@realtek.com>
References: <20230412012831.10519-1-pkshih@realtek.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ching-Te Ku <ku920601@realtek.com>

Chips use similar hardware for path control, but could different
path/antenna configuration. Add these register to monitor, if there are
wrong settings, these register can help to debug.

Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 4 +++-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index ed12f72301be7..a7f69d105fbbc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -355,7 +355,9 @@ static const struct rtw89_btc_fbtc_mreg rtw89_btc_8852b_mon_reg[] = {
 	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xd200),
 	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xd220),
 	RTW89_DEF_FBTC_MREG(REG_BB, 4, 0x980),
-	RTW89_DEF_FBTC_MREG(REG_BT_MODEM, 4, 0x178),
+	RTW89_DEF_FBTC_MREG(REG_BB, 4, 0x4738),
+	RTW89_DEF_FBTC_MREG(REG_BB, 4, 0x4688),
+	RTW89_DEF_FBTC_MREG(REG_BB, 4, 0x4694),
 };
 
 static const u8 rtw89_btc_8852b_wl_rssi_thres[BTC_WL_RSSI_THMAX] = {70, 60, 50, 40};
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 78d618dd714c0..1db1298ca9863 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2570,6 +2570,9 @@ static const struct rtw89_btc_fbtc_mreg rtw89_btc_8852c_mon_reg[] = {
 	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xd200),
 	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xd220),
 	RTW89_DEF_FBTC_MREG(REG_BB, 4, 0x980),
+	RTW89_DEF_FBTC_MREG(REG_BB, 4, 0x4aa4),
+	RTW89_DEF_FBTC_MREG(REG_BB, 4, 0x4778),
+	RTW89_DEF_FBTC_MREG(REG_BB, 4, 0x476c),
 };
 
 static
-- 
2.25.1

