Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399836D9073
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 09:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbjDFHaU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Apr 2023 03:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjDFHaT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Apr 2023 03:30:19 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEEBEE
        for <linux-wireless@vger.kernel.org>; Thu,  6 Apr 2023 00:30:17 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3367TluP6007725, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3367TluP6007725
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Thu, 6 Apr 2023 15:29:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 6 Apr 2023 15:29:55 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 6 Apr 2023
 15:29:54 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <echuang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: correct 5 MHz mask setting
Date:   Thu, 6 Apr 2023 15:28:41 +0800
Message-ID: <20230406072841.8308-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Eric Huang <echuang@realtek.com>

Use primary channel index to determine which 5 MHz mask should be enable.
This mask is used to prevent noise from channel edge to effect CCA
threshold in wide bandwidth (>= 40 MHZ).

Fixes: 1b00e9236a71 ("rtw89: 8852c: add set channel of BB part")
Fixes: 6b0698984eb0 ("wifi: rtw89: 8852b: add chip_ops::set_channel")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 9 +++++----
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index bae80984cfd51..5a46afc97a025 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -1284,7 +1284,7 @@ static void rtw8852b_ctrl_cck_en(struct rtw89_dev *rtwdev, bool cck_en)
 static void rtw8852b_5m_mask(struct rtw89_dev *rtwdev, const struct rtw89_chan *chan,
 			     enum rtw89_phy_idx phy_idx)
 {
-	u8 pri_ch = chan->primary_channel;
+	u8 pri_ch = chan->pri_ch_idx;
 	bool mask_5m_low;
 	bool mask_5m_en;
 
@@ -1292,12 +1292,13 @@ static void rtw8852b_5m_mask(struct rtw89_dev *rtwdev, const struct rtw89_chan *
 	case RTW89_CHANNEL_WIDTH_40:
 		/* Prich=1: Mask 5M High, Prich=2: Mask 5M Low */
 		mask_5m_en = true;
-		mask_5m_low = pri_ch == 2;
+		mask_5m_low = pri_ch == RTW89_SC_20_LOWER;
 		break;
 	case RTW89_CHANNEL_WIDTH_80:
 		/* Prich=3: Mask 5M High, Prich=4: Mask 5M Low, Else: Disable */
-		mask_5m_en = pri_ch == 3 || pri_ch == 4;
-		mask_5m_low = pri_ch == 4;
+		mask_5m_en = pri_ch == RTW89_SC_20_UPMOST ||
+			     pri_ch == RTW89_SC_20_LOWEST;
+		mask_5m_low = pri_ch == RTW89_SC_20_LOWEST;
 		break;
 	default:
 		mask_5m_en = false;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index ba728fca91881..6cd60864eca05 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1375,18 +1375,19 @@ static void rtw8852c_5m_mask(struct rtw89_dev *rtwdev,
 			     const struct rtw89_chan *chan,
 			     enum rtw89_phy_idx phy_idx)
 {
-	u8 pri_ch = chan->primary_channel;
+	u8 pri_ch = chan->pri_ch_idx;
 	bool mask_5m_low;
 	bool mask_5m_en;
 
 	switch (chan->band_width) {
 	case RTW89_CHANNEL_WIDTH_40:
 		mask_5m_en = true;
-		mask_5m_low = pri_ch == 2;
+		mask_5m_low = pri_ch == RTW89_SC_20_LOWER;
 		break;
 	case RTW89_CHANNEL_WIDTH_80:
-		mask_5m_en = ((pri_ch == 3) || (pri_ch == 4));
-		mask_5m_low = pri_ch == 4;
+		mask_5m_en = pri_ch == RTW89_SC_20_UPMOST ||
+			     pri_ch == RTW89_SC_20_LOWEST;
+		mask_5m_low = pri_ch == RTW89_SC_20_LOWEST;
 		break;
 	default:
 		mask_5m_en = false;
-- 
2.25.1

