Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B126EA1CB
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 04:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjDUCqf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 22:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbjDUCqe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 22:46:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26CF865B3
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 19:46:29 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33L2kNVf9016490, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33L2kNVf9016490
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 21 Apr 2023 10:46:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 21 Apr 2023 10:46:03 +0800
Received: from localhost.localdomain (172.21.69.188) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 21 Apr 2023 10:46:02 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <gary.chang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/8] wifi: rtw89: 8851b: add support WoWLAN to 8851B
Date:   Fri, 21 Apr 2023 10:45:50 +0800
Message-ID: <20230421024551.29994-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421024551.29994-1-pkshih@realtek.com>
References: <20230421024551.29994-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
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

From: Chih-Kang Chang <gary.chang@realtek.com>

Add WoWLAN stub to 8851B, and decalre this chip can support magic packet
and disconnect wakeup.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 12 ++++++++++++
 drivers/net/wireless/realtek/rtw89/wow.c      |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 5ed699ab75a40..ce5c7a8644c39 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -31,6 +31,15 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.h2c_dctl_sec_cam	= NULL,
 };
 
+#ifdef CONFIG_PM
+static const struct wiphy_wowlan_support rtw_wowlan_stub_8851b = {
+	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
+	.n_patterns = RTW89_MAX_PATTERN_NUM,
+	.pattern_max_len = RTW89_MAX_PATTERN_SIZE,
+	.pattern_min_len = 1,
+};
+#endif
+
 const struct rtw89_chip_info rtw8851b_chip_info = {
 	.chip_id		= RTL8851B,
 	.ops			= &rtw8851b_chip_ops,
@@ -101,6 +110,9 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
 	.edcca_lvl_reg		= R_SEG0R_EDCCA_LVL_V1,
+#ifdef CONFIG_PM
+	.wowlan_stub		= &rtw_wowlan_stub_8851b,
+#endif
 	.xtal_info		= &rtw8851b_xtal_info,
 };
 EXPORT_SYMBOL(rtw8851b_chip_info);
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 2ca8abb70f110..364e546221500 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -91,7 +91,7 @@ static void rtw89_wow_show_wakeup_reason(struct rtw89_dev *rtwdev)
 	u32 wow_reason_reg;
 	u8 reason;
 
-	if (chip_id == RTL8852A || chip_id == RTL8852B)
+	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B)
 		wow_reason_reg = R_AX_C2HREG_DATA3 + 3;
 	else
 		wow_reason_reg = R_AX_C2HREG_DATA3_V1 + 3;
-- 
2.25.1

