Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E029F7664AF
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 09:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbjG1HDf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jul 2023 03:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbjG1HDe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jul 2023 03:03:34 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 752FD1FFF
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 00:03:30 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36S73AmA4031347, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36S73AmA4031347
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 28 Jul 2023 15:03:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 28 Jul 2023 15:03:22 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 28 Jul
 2023 15:03:21 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 01/10] wifi: rtw89: add chip_info::chip_gen to determine chip generation
Date:   Fri, 28 Jul 2023 15:02:43 +0800
Message-ID: <20230728070252.66525-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230728070252.66525-1-pkshih@realtek.com>
References: <20230728070252.66525-1-pkshih@realtek.com>
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The coming WiFi 7 chip is 8922AE which uses different hardware rate and
register naming rule. Adding a chip_info::chip_gen field can help to
do things by generations accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 9 +++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 1 +
 5 files changed, 13 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d2c67db97db1a..d44f428d30b45 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -109,6 +109,14 @@ enum rtw89_core_chip_id {
 	RTL8852B,
 	RTL8852C,
 	RTL8851B,
+	RTL8922A,
+};
+
+enum rtw89_chip_gen {
+	RTW89_CHIP_AX,
+	RTW89_CHIP_BE,
+
+	RTW89_CHIP_GEN_NUM,
 };
 
 enum rtw89_cv {
@@ -3177,6 +3185,7 @@ struct rtw89_antdiv_info {
 
 struct rtw89_chip_info {
 	enum rtw89_core_chip_id chip_id;
+	enum rtw89_chip_gen chip_gen;
 	const struct rtw89_chip_ops *ops;
 	const char *fw_basename;
 	u8 fw_format_max;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index c3ffcb645ebf7..456b8369fb068 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2334,6 +2334,7 @@ static const struct wiphy_wowlan_support rtw_wowlan_stub_8851b = {
 
 const struct rtw89_chip_info rtw8851b_chip_info = {
 	.chip_id		= RTL8851B,
+	.chip_gen		= RTW89_CHIP_AX,
 	.ops			= &rtw8851b_chip_ops,
 	.fw_basename		= RTW8851B_FW_BASENAME,
 	.fw_format_max		= RTW8851B_FW_FORMAT_MAX,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 6257414a3b4bd..0fc5eb777a4aa 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2071,6 +2071,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 
 const struct rtw89_chip_info rtw8852a_chip_info = {
 	.chip_id		= RTL8852A,
+	.chip_gen		= RTW89_CHIP_AX,
 	.ops			= &rtw8852a_chip_ops,
 	.fw_basename		= RTW8852A_FW_BASENAME,
 	.fw_format_max		= RTW8852A_FW_FORMAT_MAX,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 718f993da62af..d76d74cc867ad 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2503,6 +2503,7 @@ static const struct wiphy_wowlan_support rtw_wowlan_stub_8852b = {
 
 const struct rtw89_chip_info rtw8852b_chip_info = {
 	.chip_id		= RTL8852B,
+	.chip_gen		= RTW89_CHIP_AX,
 	.ops			= &rtw8852b_chip_ops,
 	.fw_basename		= RTW8852B_FW_BASENAME,
 	.fw_format_max		= RTW8852B_FW_FORMAT_MAX,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 9c7c9812d4f45..f269832b2bc6f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2802,6 +2802,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 
 const struct rtw89_chip_info rtw8852c_chip_info = {
 	.chip_id		= RTL8852C,
+	.chip_gen		= RTW89_CHIP_AX,
 	.ops			= &rtw8852c_chip_ops,
 	.fw_basename		= RTW8852C_FW_BASENAME,
 	.fw_format_max		= RTW8852C_FW_FORMAT_MAX,
-- 
2.25.1

