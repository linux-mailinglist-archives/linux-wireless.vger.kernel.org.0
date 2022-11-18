Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA12E62ED11
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Nov 2022 06:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbiKRFLr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Nov 2022 00:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiKRFLn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Nov 2022 00:11:43 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BEF76CA1C
        for <linux-wireless@vger.kernel.org>; Thu, 17 Nov 2022 21:11:42 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 2AI5AsXtA003102, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 2AI5AsXtA003102
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 18 Nov 2022 13:10:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 18 Nov 2022 13:11:35 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 18 Nov
 2022 13:11:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/6] wifi: rtw89: check if atomic before queuing c2h
Date:   Fri, 18 Nov 2022 13:10:38 +0800
Message-ID: <20221118051042.29968-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221118051042.29968-1-pkshih@realtek.com>
References: <20221118051042.29968-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 11/18/2022 04:56:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzExLzE3IKRVpMggMTA6MDA6MDA=?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Before queuing C2H work, we check atomicity of the C2H's handler first now.
If atomic or lock-free, handle it directly; otherwise, handle it with mutex
in work as previous. This prepares for MAC MCC C2Hs which require to be
processed directly. And, their handlers will be functions which can be
considered atomic.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  | 47 ++++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/fw.h  | 14 +++++++
 drivers/net/wireless/realtek/rtw89/mac.c | 10 +++++
 drivers/net/wireless/realtek/rtw89/mac.h |  1 +
 4 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 3d7b99e15967e..544f6d4b68735 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -11,6 +11,9 @@
 #include "phy.h"
 #include "reg.h"
 
+static void rtw89_fw_c2h_cmd_handle(struct rtw89_dev *rtwdev,
+				    struct sk_buff *skb);
+
 static struct sk_buff *rtw89_fw_h2c_alloc_skb(struct rtw89_dev *rtwdev, u32 len,
 					      bool header)
 {
@@ -2382,8 +2385,43 @@ void rtw89_fw_free_all_early_h2c(struct rtw89_dev *rtwdev)
 	mutex_unlock(&rtwdev->mutex);
 }
 
+static void rtw89_fw_c2h_parse_attr(struct sk_buff *c2h)
+{
+	struct rtw89_fw_c2h_attr *attr = RTW89_SKB_C2H_CB(c2h);
+
+	attr->category = RTW89_GET_C2H_CATEGORY(c2h->data);
+	attr->class = RTW89_GET_C2H_CLASS(c2h->data);
+	attr->func = RTW89_GET_C2H_FUNC(c2h->data);
+	attr->len = RTW89_GET_C2H_LEN(c2h->data);
+}
+
+static bool rtw89_fw_c2h_chk_atomic(struct rtw89_dev *rtwdev,
+				    struct sk_buff *c2h)
+{
+	struct rtw89_fw_c2h_attr *attr = RTW89_SKB_C2H_CB(c2h);
+	u8 category = attr->category;
+	u8 class = attr->class;
+	u8 func = attr->func;
+
+	switch (category) {
+	default:
+		return false;
+	case RTW89_C2H_CAT_MAC:
+		return rtw89_mac_c2h_chk_atomic(rtwdev, class, func);
+	}
+}
+
 void rtw89_fw_c2h_irqsafe(struct rtw89_dev *rtwdev, struct sk_buff *c2h)
 {
+	rtw89_fw_c2h_parse_attr(c2h);
+	if (!rtw89_fw_c2h_chk_atomic(rtwdev, c2h))
+		goto enqueue;
+
+	rtw89_fw_c2h_cmd_handle(rtwdev, c2h);
+	dev_kfree_skb_any(c2h);
+	return;
+
+enqueue:
 	skb_queue_tail(&rtwdev->c2h_queue, c2h);
 	ieee80211_queue_work(rtwdev->hw, &rtwdev->c2h_work);
 }
@@ -2391,10 +2429,11 @@ void rtw89_fw_c2h_irqsafe(struct rtw89_dev *rtwdev, struct sk_buff *c2h)
 static void rtw89_fw_c2h_cmd_handle(struct rtw89_dev *rtwdev,
 				    struct sk_buff *skb)
 {
-	u8 category = RTW89_GET_C2H_CATEGORY(skb->data);
-	u8 class = RTW89_GET_C2H_CLASS(skb->data);
-	u8 func = RTW89_GET_C2H_FUNC(skb->data);
-	u16 len = RTW89_GET_C2H_LEN(skb->data);
+	struct rtw89_fw_c2h_attr *attr = RTW89_SKB_C2H_CB(skb);
+	u8 category = attr->category;
+	u8 class = attr->class;
+	u8 func = attr->func;
+	u16 len = attr->len;
 	bool dump = true;
 
 	if (!test_bit(RTW89_FLAG_RUNNING, rtwdev->flags))
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 509a3eac5ffe3..d76d0c80f0256 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -2778,6 +2778,20 @@ static inline void RTW89_SET_FWCMD_TSF32_TOGL_EARLY(void *cmd, u32 val)
 #define RTW89_GET_C2H_LEN(c2h) \
 	le32_get_bits(*((const __le32 *)(c2h) + 1), GENMASK(13, 0))
 
+struct rtw89_fw_c2h_attr {
+	u8 category;
+	u8 class;
+	u8 func;
+	u16 len;
+};
+
+static inline struct rtw89_fw_c2h_attr *RTW89_SKB_C2H_CB(struct sk_buff *skb)
+{
+	static_assert(sizeof(skb->cb) >= sizeof(struct rtw89_fw_c2h_attr));
+
+	return (struct rtw89_fw_c2h_attr *)skb->cb;
+}
+
 #define RTW89_GET_C2H_LOG_SRT_PRT(c2h) (char *)((__le32 *)(c2h) + 2)
 #define RTW89_GET_C2H_LOG_LEN(len) ((len) - RTW89_C2H_HEADER_LEN)
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index ecd603a881345..df83d1bebe543 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4201,6 +4201,16 @@ void (* const rtw89_mac_c2h_info_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_MAC_C2H_FUNC_BCN_CNT] = rtw89_mac_c2h_bcn_cnt,
 };
 
+bool rtw89_mac_c2h_chk_atomic(struct rtw89_dev *rtwdev, u8 class, u8 func)
+{
+	switch (class) {
+	default:
+		return false;
+	case RTW89_MAC_C2H_CLASS_MCC:
+		return true;
+	}
+}
+
 void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			  u32 len, u8 class, u8 func)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 045e8ec61a41e..82b9e81fe4744 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -894,6 +894,7 @@ static inline int rtw89_chip_disable_bb_rf(struct rtw89_dev *rtwdev)
 
 u32 rtw89_mac_get_err_status(struct rtw89_dev *rtwdev);
 int rtw89_mac_set_err_status(struct rtw89_dev *rtwdev, u32 err);
+bool rtw89_mac_c2h_chk_atomic(struct rtw89_dev *rtwdev, u8 class, u8 func);
 void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			  u32 len, u8 class, u8 func);
 int rtw89_mac_setup_phycap(struct rtw89_dev *rtwdev);
-- 
2.25.1

