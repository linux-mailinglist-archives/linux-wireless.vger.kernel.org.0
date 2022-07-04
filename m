Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D198564BC3
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 04:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiGDCgG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 3 Jul 2022 22:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiGDCgE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 3 Jul 2022 22:36:04 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F746547
        for <linux-wireless@vger.kernel.org>; Sun,  3 Jul 2022 19:36:03 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2642Zla36011105, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2642Zla36011105
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 4 Jul 2022 10:35:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 4 Jul 2022 10:35:47 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Mon, 4 Jul
 2022 10:35:47 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/6] rtw89: 8852a: update HW setting on BB
Date:   Mon, 4 Jul 2022 10:34:49 +0800
Message-ID: <20220704023453.19935-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704023453.19935-1-pkshih@realtek.com>
References: <20220704023453.19935-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 07/04/2022 02:15:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzcvMyCkVaTIIDEwOjAwOjAw?=
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Sometimes, BB might encounter RX problem on OFDM 6M. It's not quite
easy to happen, but if it happens, we will keep getting stuck on RX.
And, since we cannot properly receive layer 2 ACK, it also casues TX
problem, e.g. constantly retrying TX. Eventually, after some time, we
would get disconnected due to abnormal behavior.

Update break setting and phy status parsing time to make BB get out
of stuck state faster.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      | 3 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index ebf28719d935e..986e27c445aa7 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3431,8 +3431,9 @@
 #define R_MAC_PIN_SEL 0x0734
 #define B_CH_IDX_SEG0 GENMASK(23, 16)
 #define R_PLCP_HISTOGRAM 0x0738
-#define B_STS_DIS_TRIG_BY_BRK BIT(2)
+#define B_STS_PARSING_TIME GENMASK(19, 16)
 #define B_STS_DIS_TRIG_BY_FAIL BIT(3)
+#define B_STS_DIS_TRIG_BY_BRK BIT(2)
 #define R_PHY_STS_BITMAP_ADDR_START R_PHY_STS_BITMAP_SEARCH_FAIL
 #define B_PHY_STS_BITMAP_ADDR_MASK GENMASK(6, 2)
 #define R_PHY_STS_BITMAP_SEARCH_FAIL 0x073C
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 81bd0c4fe21bc..7125dbef9d8a8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1102,11 +1102,12 @@ static void rtw8852a_bb_sethw(struct rtw89_dev *rtwdev)
 	if (rtwdev->hal.cv <= CHIP_CCV) {
 		rtw89_phy_write32_set(rtwdev, R_RSTB_WATCH_DOG, B_P0_RSTB_WATCH_DOG);
 		rtw89_phy_write32(rtwdev, R_BRK_ASYNC_RST_EN_1, 0x864FA000);
-		rtw89_phy_write32(rtwdev, R_BRK_ASYNC_RST_EN_2, 0x3F);
+		rtw89_phy_write32(rtwdev, R_BRK_ASYNC_RST_EN_2, 0x43F);
 		rtw89_phy_write32(rtwdev, R_BRK_ASYNC_RST_EN_3, 0x7FFF);
 		rtw89_phy_write32_set(rtwdev, R_SPOOF_ASYNC_RST, B_SPOOF_ASYNC_RST);
 		rtw89_phy_write32_set(rtwdev, R_P0_TXPW_RSTB, B_P0_TXPW_RSTB_MANON);
 		rtw89_phy_write32_set(rtwdev, R_P1_TXPW_RSTB, B_P1_TXPW_RSTB_MANON);
+		rtw89_phy_write32_set(rtwdev, R_PLCP_HISTOGRAM, B_STS_PARSING_TIME);
 	}
 	rtw89_phy_write32_mask(rtwdev, R_CFO_TRK0, B_CFO_TRK_MSK, 0x1f);
 	rtw89_phy_write32_mask(rtwdev, R_CFO_TRK1, B_CFO_TRK_MSK, 0x0c);
-- 
2.25.1

