Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8325C76E62A
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 13:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjHCLCn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 07:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbjHCLCd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 07:02:33 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 026E630DB
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 04:02:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 373B260u8003583, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 373B260u8003583
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 3 Aug 2023 19:02:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 3 Aug 2023 19:02:15 +0800
Received: from [127.0.1.1] (172.16.16.139) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 3 Aug 2023
 19:02:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] wifi: rtw89: 8852b: rfk: fine tune IQK parameters to improve performance on 2GHz band
Date:   Thu, 3 Aug 2023 19:01:50 +0800
Message-ID: <20230803110150.8457-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.139]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A few samples get bad performance on 2GHz band, so use proper IQK command
code and select another group to have wider range of calibration value.

Fixes: f2abe804e823 ("wifi: rtw89: 8852b: rfk: add IQK")
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index fa018e1f499b..259df67836a0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -846,7 +846,7 @@ static bool _iqk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 	case ID_NBTXK:
 		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x0);
 		rtw89_phy_write32_mask(rtwdev, R_IQK_DIF4, B_IQK_DIF4_TXT, 0x011);
-		iqk_cmd = 0x308 | (1 << (4 + path));
+		iqk_cmd = 0x408 | (1 << (4 + path));
 		break;
 	case ID_NBRXK:
 		rtw89_phy_write32_mask(rtwdev, R_P0_RFCTM, B_P0_RFCTM_EN, 0x1);
@@ -1078,7 +1078,7 @@ static bool _iqk_nbtxk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u8
 {
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	bool kfail;
-	u8 gp = 0x3;
+	u8 gp = 0x2;
 
 	switch (iqk_info->iqk_band[path]) {
 	case RTW89_BAND_2G:
-- 
2.25.1

