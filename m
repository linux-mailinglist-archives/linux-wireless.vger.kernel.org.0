Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127FE7664B3
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jul 2023 09:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjG1HDk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jul 2023 03:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233640AbjG1HDi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jul 2023 03:03:38 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D4D71FFF
        for <linux-wireless@vger.kernel.org>; Fri, 28 Jul 2023 00:03:37 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36S73IdF4031392, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36S73IdF4031392
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 28 Jul 2023 15:03:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 28 Jul 2023 15:03:31 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 28 Jul
 2023 15:03:30 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 06/10] wifi: rtw89: use struct to access firmware C2H event header
Date:   Fri, 28 Jul 2023 15:02:48 +0800
Message-ID: <20230728070252.66525-7-pkshih@realtek.com>
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

Firmware C2H events contain two-word header which can indicate category,
class, function and length of received events. Use struct to access them,
and doesn't change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c |  9 +++++----
 drivers/net/wireless/realtek/rtw89/fw.h | 17 +++++++++--------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index b27734036fb6d..71e8bea6bd76b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2830,12 +2830,13 @@ void rtw89_fw_free_all_early_h2c(struct rtw89_dev *rtwdev)
 
 static void rtw89_fw_c2h_parse_attr(struct sk_buff *c2h)
 {
+	const struct rtw89_c2h_hdr *hdr = (const struct rtw89_c2h_hdr *)c2h->data;
 	struct rtw89_fw_c2h_attr *attr = RTW89_SKB_C2H_CB(c2h);
 
-	attr->category = RTW89_GET_C2H_CATEGORY(c2h->data);
-	attr->class = RTW89_GET_C2H_CLASS(c2h->data);
-	attr->func = RTW89_GET_C2H_FUNC(c2h->data);
-	attr->len = RTW89_GET_C2H_LEN(c2h->data);
+	attr->category = le32_get_bits(hdr->w0, RTW89_C2H_HDR_W0_CATEGORY);
+	attr->class = le32_get_bits(hdr->w0, RTW89_C2H_HDR_W0_CLASS);
+	attr->func = le32_get_bits(hdr->w0, RTW89_C2H_HDR_W0_FUNC);
+	attr->len = le32_get_bits(hdr->w1, RTW89_C2H_HDR_W1_LEN);
 }
 
 static bool rtw89_fw_c2h_chk_atomic(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 831dbe6023935..becd8acce9c1d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3101,14 +3101,15 @@ inline void RTW89_SET_FWCMD_MCC_SET_DURATION_DURATION_Y(void *cmd, u32 val)
 
 #define RTW89_C2H_HEADER_LEN 8
 
-#define RTW89_GET_C2H_CATEGORY(c2h) \
-	le32_get_bits(*((const __le32 *)c2h), GENMASK(1, 0))
-#define RTW89_GET_C2H_CLASS(c2h) \
-	le32_get_bits(*((const __le32 *)c2h), GENMASK(7, 2))
-#define RTW89_GET_C2H_FUNC(c2h) \
-	le32_get_bits(*((const __le32 *)c2h), GENMASK(15, 8))
-#define RTW89_GET_C2H_LEN(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 1), GENMASK(13, 0))
+struct rtw89_c2h_hdr {
+	__le32 w0;
+	__le32 w1;
+} __packed;
+
+#define RTW89_C2H_HDR_W0_CATEGORY GENMASK(1, 0)
+#define RTW89_C2H_HDR_W0_CLASS GENMASK(7, 2)
+#define RTW89_C2H_HDR_W0_FUNC GENMASK(15, 8)
+#define RTW89_C2H_HDR_W1_LEN GENMASK(13, 0)
 
 struct rtw89_fw_c2h_attr {
 	u8 category;
-- 
2.25.1

