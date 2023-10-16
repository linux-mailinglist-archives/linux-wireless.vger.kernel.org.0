Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824867C9FF3
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Oct 2023 08:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjJPGwC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Oct 2023 02:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjJPGwA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Oct 2023 02:52:00 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55614E5
        for <linux-wireless@vger.kernel.org>; Sun, 15 Oct 2023 23:51:56 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39G6pn4qB2264257, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39G6pn4qB2264257
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Oct 2023 14:51:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 16 Oct 2023 14:51:50 +0800
Received: from [127.0.1.1] (172.21.71.113) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 16 Oct
 2023 14:51:49 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <cj.hsieh@realtek.com>, <hsuan8331@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/5] wifi: rtw89: move software DCFO compensation setting to proper position
Date:   Mon, 16 Oct 2023 14:51:15 +0800
Message-ID: <20231016065115.751662-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016065115.751662-1-pkshih@realtek.com>
References: <20231016065115.751662-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.71.113]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Cheng-Chieh Hsieh <cj.hsieh@realtek.com>

We need this register setting only for the software DCFO(digital carrier
frequency offset) compensation so we move it to the proper position to
prevent the incorrect setting.

Signed-off-by: Cheng-Chieh Hsieh <cj.hsieh@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 3b671a314e60..17ccc9efed28 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2588,12 +2588,14 @@ static void rtw89_dcfo_comp_init(struct rtw89_dev *rtwdev)
 	rtw89_phy_set_phy_regs(rtwdev, cfo->comp, cfo->weighting_mask, 8);
 
 	if (chip->chip_gen == RTW89_CHIP_AX) {
-		if (chip->cfo_hw_comp)
+		if (chip->cfo_hw_comp) {
 			rtw89_write32_mask(rtwdev, R_AX_PWR_UL_CTRL2,
 					   B_AX_PWR_UL_CFO_MASK, 0x6);
-		else
+		} else {
+			rtw89_phy_set_phy_regs(rtwdev, R_DCFO, B_DCFO, 1);
 			rtw89_write32_clr(rtwdev, R_AX_PWR_UL_CTRL2,
 					  B_AX_PWR_UL_CFO_MASK);
+		}
 	}
 }
 
@@ -2617,7 +2619,6 @@ static void rtw89_phy_cfo_init(struct rtw89_dev *rtwdev)
 	rtw89_debug(rtwdev, RTW89_DBG_CFO, "Default xcap=%0x\n",
 		    cfo->crystal_cap_default);
 	rtw89_phy_cfo_set_crystal_cap(rtwdev, cfo->crystal_cap_default, true);
-	rtw89_phy_set_phy_regs(rtwdev, R_DCFO, B_DCFO, 1);
 	rtw89_dcfo_comp_init(rtwdev);
 	cfo->cfo_timer_ms = 2000;
 	cfo->cfo_trig_by_timer_en = false;
-- 
2.25.1

