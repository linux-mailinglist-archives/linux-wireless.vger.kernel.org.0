Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B651A6DC350
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Apr 2023 07:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjDJFfG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Apr 2023 01:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJFfF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Apr 2023 01:35:05 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D45B30F5
        for <linux-wireless@vger.kernel.org>; Sun,  9 Apr 2023 22:35:02 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33A5YRsA4024126, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33A5YRsA4024126
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 10 Apr 2023 13:34:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Mon, 10 Apr 2023 13:34:49 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 10 Apr
 2023 13:34:48 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <timlee@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] wifi: rtw89: support WoWLAN mode for 8852be
Date:   Mon, 10 Apr 2023 13:34:37 +0800
Message-ID: <20230410053438.10682-1-pkshih@realtek.com>
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

From: Chin-Yen Lee <timlee@realtek.com>

To support WoWLAN mode for 8852be, we add one PLE quota setting and
WoWLAN stub, which shows that supported WLAN events include receiving
magic packet, rekey packet and deauth packet, and disconnecting from AP.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c      |  2 ++
 drivers/net/wireless/realtek/rtw89/mac.h      |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 16 ++++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index d0e138f8b880a..62f7447415f0d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1473,6 +1473,8 @@ const struct rtw89_mac_size_set rtw89_mac_size = {
 	.ple_qt58 = {147, 0, 16, 20, 157, 13, 229, 0, 172, 14, 24, 0,},
 	/* 8852A PCIE WOW */
 	.ple_qt_52a_wow = {264, 0, 32, 20, 64, 13, 1005, 0, 64, 128, 120,},
+	/* 8852B PCIE WOW */
+	.ple_qt_52b_wow = {147, 0, 16, 20, 157, 13, 133, 0, 172, 14, 24, 0,},
 };
 EXPORT_SYMBOL(rtw89_mac_size);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 8064d3953d7f2..87a781945eb1d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -815,6 +815,7 @@ struct rtw89_mac_size_set {
 	const struct rtw89_ple_quota ple_qt47;
 	const struct rtw89_ple_quota ple_qt58;
 	const struct rtw89_ple_quota ple_qt_52a_wow;
+	const struct rtw89_ple_quota ple_qt_52b_wow;
 };
 
 extern const struct rtw89_mac_size_set rtw89_mac_size;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index bae80984cfd51..da26e485d5235 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -48,6 +48,10 @@ static const struct rtw89_dle_mem rtw8852b_dle_mem_pcie[] = {
 			   &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt6,
 			   &rtw89_mac_size.wde_qt6, &rtw89_mac_size.ple_qt18,
 			   &rtw89_mac_size.ple_qt58},
+	[RTW89_QTA_WOW] = {RTW89_QTA_WOW, &rtw89_mac_size.wde_size6,
+			   &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt6,
+			   &rtw89_mac_size.wde_qt6, &rtw89_mac_size.ple_qt18,
+			   &rtw89_mac_size.ple_qt_52b_wow},
 	[RTW89_QTA_DLFW] = {RTW89_QTA_DLFW, &rtw89_mac_size.wde_size9,
 			    &rtw89_mac_size.ple_size8, &rtw89_mac_size.wde_qt4,
 			    &rtw89_mac_size.wde_qt4, &rtw89_mac_size.ple_qt13,
@@ -2477,6 +2481,15 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.btc_set_policy		= rtw89_btc_set_policy_v1,
 };
 
+#ifdef CONFIG_PM
+static const struct wiphy_wowlan_support rtw_wowlan_stub_8852b = {
+	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
+	.n_patterns = RTW89_MAX_PATTERN_NUM,
+	.pattern_max_len = RTW89_MAX_PATTERN_SIZE,
+	.pattern_min_len = 1,
+};
+#endif
+
 const struct rtw89_chip_info rtw8852b_chip_info = {
 	.chip_id		= RTL8852B,
 	.ops			= &rtw8852b_chip_ops,
@@ -2573,6 +2586,9 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
 	.edcca_lvl_reg		= R_SEG0R_EDCCA_LVL_V1,
+#ifdef CONFIG_PM
+	.wowlan_stub		= &rtw_wowlan_stub_8852b,
+#endif
 };
 EXPORT_SYMBOL(rtw8852b_chip_info);
 
-- 
2.25.1

