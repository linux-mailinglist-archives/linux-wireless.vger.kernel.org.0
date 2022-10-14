Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAD05FE8A3
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Oct 2022 08:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbiJNGEK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Oct 2022 02:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJNGEG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Oct 2022 02:04:06 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B3AC1AAE66
        for <linux-wireless@vger.kernel.org>; Thu, 13 Oct 2022 23:03:51 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 29E62URW0023548, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 29E62URW0023548
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 14 Oct 2022 14:02:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 14 Oct 2022 14:03:01 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 14 Oct
 2022 14:03:00 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/4] wifi: rtw89: phy: add dummy C2H handler to avoid warning message
Date:   Fri, 14 Oct 2022 14:02:36 +0800
Message-ID: <20221014060237.29050-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221014060237.29050-1-pkshih@realtek.com>
References: <20221014060237.29050-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 10/14/2022 05:44:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzE0IKRXpMggMDM6MTg6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

The C2H class 2 function 3 is to report retry count of low rate, but driver
doesn't implement yet, so add a dummy case to avoid message:

  rtw89_8852be 0000:03:00.0: c2h class 2 not support

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 4 ++++
 drivers/net/wireless/realtek/rtw89/phy.h | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index d3f47379e4432..35a0d190434a3 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2276,6 +2276,10 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 		if (func < RTW89_PHY_C2H_FUNC_RA_MAX)
 			handler = rtw89_phy_c2h_ra_handler[func];
 		break;
+	case RTW89_PHY_C2H_CLASS_DM:
+		if (func == RTW89_PHY_C2H_DM_FUNC_LOWRT_RTY)
+			return;
+		fallthrough;
 	default:
 		rtw89_info(rtwdev, "c2h class %d not support\n", class);
 		return;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 1e122b1498ba1..995c13f6f906c 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -114,6 +114,15 @@ enum rtw89_phy_c2h_ra_func {
 	RTW89_PHY_C2H_FUNC_RA_MAX,
 };
 
+enum rtw89_phy_c2h_dm_func {
+	RTW89_PHY_C2H_DM_FUNC_FW_TEST,
+	RTW89_PHY_C2H_DM_FUNC_FW_TRIG_TX_RPT,
+	RTW89_PHY_C2H_DM_FUNC_SIGB,
+	RTW89_PHY_C2H_DM_FUNC_LOWRT_RTY,
+	RTW89_PHY_C2H_DM_FUNC_MCC_DIG,
+	RTW89_PHY_C2H_DM_FUNC_NUM,
+};
+
 enum rtw89_phy_c2h_class {
 	RTW89_PHY_C2H_CLASS_RUA,
 	RTW89_PHY_C2H_CLASS_RA,
-- 
2.25.1

