Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800F276A6D2
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 04:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjHACMm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jul 2023 22:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbjHACMh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jul 2023 22:12:37 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 90AEF1BE7
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jul 2023 19:12:32 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3712CC5K0017512, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3712CC5K0017512
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 1 Aug 2023 10:12:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 1 Aug 2023 10:12:05 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 1 Aug 2023
 10:12:04 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/8] wifi: rtw89: add firmware suit for BB MCU 0/1
Date:   Tue, 1 Aug 2023 10:11:24 +0800
Message-ID: <20230801021127.15919-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230801021127.15919-1-pkshih@realtek.com>
References: <20230801021127.15919-1-pkshih@realtek.com>
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

For existing chips, firmware is only for WiFi CPU, but WiFi 7 chips add
new hardware component BB MCU that needs firmware as well. The firmwares of
BB MCU 0/1 are also downloaded via the same path like WiFi CPU firmware,
and use the same firmware header format, so add firmware suits to access
them commonly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index a522a559657b3..a92c027cb2967 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3347,6 +3347,8 @@ enum rtw89_fw_type {
 	RTW89_FW_NORMAL = 1,
 	RTW89_FW_WOWLAN = 3,
 	RTW89_FW_NORMAL_CE = 5,
+	RTW89_FW_BBMCU0 = 64,
+	RTW89_FW_BBMCU1 = 65,
 	RTW89_FW_LOGFMT = 255,
 };
 
@@ -3419,6 +3421,8 @@ struct rtw89_fw_info {
 	u8 c2h_counter;
 	struct rtw89_fw_suit normal;
 	struct rtw89_fw_suit wowlan;
+	struct rtw89_fw_suit bbmcu0;
+	struct rtw89_fw_suit bbmcu1;
 	struct rtw89_fw_log log;
 	u32 feature_map;
 };
@@ -4953,10 +4957,19 @@ static inline struct rtw89_fw_suit *rtw89_fw_suit_get(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_fw_info *fw_info = &rtwdev->fw;
 
-	if (type == RTW89_FW_WOWLAN)
+	switch (type) {
+	case RTW89_FW_WOWLAN:
 		return &fw_info->wowlan;
-	else if (type == RTW89_FW_LOGFMT)
+	case RTW89_FW_LOGFMT:
 		return &fw_info->log.suit;
+	case RTW89_FW_BBMCU0:
+		return &fw_info->bbmcu0;
+	case RTW89_FW_BBMCU1:
+		return &fw_info->bbmcu1;
+	default:
+		break;
+	}
+
 	return &fw_info->normal;
 }
 
-- 
2.25.1

