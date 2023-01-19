Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A869D6731E8
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 07:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjASGoO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 01:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjASGoL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 01:44:11 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1571F1720
        for <linux-wireless@vger.kernel.org>; Wed, 18 Jan 2023 22:44:09 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 30J6i1TH1026317, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 30J6i1TH1026317
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 19 Jan 2023 14:44:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 19 Jan 2023 14:44:02 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 19 Jan
 2023 14:44:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] wifi: rtw89: fix parsing offset for MCC C2H
Date:   Thu, 19 Jan 2023 14:43:41 +0800
Message-ID: <20230119064342.65391-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
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
X-KSE-Antiphishing-Bases: 01/19/2023 06:25:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIzLzEvMTkgpFekyCAwMzozNzowMA==?=
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

A 8-byte offset is missed during parsing C2Hs (chip to host packets)
of MCC (multi-channel concurrent) series.
So, we fix it.

Fixes: ef9dff4cb491 ("wifi: rtw89: mac: process MCC related C2H")
Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
Hi Kalle,

Though this patch contains Fixes tag, we don't really run into these codes
yet, so please take this to wireless-next.

Thank you

---
 drivers/net/wireless/realtek/rtw89/fw.h | 34 ++++++++++++-------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 3ce59ac48f433..6cb578201b2a8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3219,16 +3219,16 @@ static inline struct rtw89_fw_c2h_attr *RTW89_SKB_C2H_CB(struct sk_buff *skb)
 	le32_get_bits(*((const __le32 *)(c2h) + 5), GENMASK(25, 24))
 
 #define RTW89_GET_MAC_C2H_MCC_RCV_ACK_GROUP(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(1, 0))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(1, 0))
 #define RTW89_GET_MAC_C2H_MCC_RCV_ACK_H2C_FUNC(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(15, 8))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(15, 8))
 
 #define RTW89_GET_MAC_C2H_MCC_REQ_ACK_GROUP(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(1, 0))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(1, 0))
 #define RTW89_GET_MAC_C2H_MCC_REQ_ACK_H2C_RETURN(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(7, 2))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(7, 2))
 #define RTW89_GET_MAC_C2H_MCC_REQ_ACK_H2C_FUNC(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(15, 8))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(15, 8))
 
 struct rtw89_mac_mcc_tsf_rpt {
 	u32 macid_x;
@@ -3242,30 +3242,30 @@ struct rtw89_mac_mcc_tsf_rpt {
 static_assert(sizeof(struct rtw89_mac_mcc_tsf_rpt) <= RTW89_COMPLETION_BUF_SIZE);
 
 #define RTW89_GET_MAC_C2H_MCC_TSF_RPT_MACID_X(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(7, 0))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(7, 0))
 #define RTW89_GET_MAC_C2H_MCC_TSF_RPT_MACID_Y(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(15, 8))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(15, 8))
 #define RTW89_GET_MAC_C2H_MCC_TSF_RPT_GROUP(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(17, 16))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(17, 16))
 #define RTW89_GET_MAC_C2H_MCC_TSF_RPT_TSF_LOW_X(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 1), GENMASK(31, 0))
+	le32_get_bits(*((const __le32 *)(c2h) + 3), GENMASK(31, 0))
 #define RTW89_GET_MAC_C2H_MCC_TSF_RPT_TSF_HIGH_X(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(31, 0))
+	le32_get_bits(*((const __le32 *)(c2h) + 4), GENMASK(31, 0))
 #define RTW89_GET_MAC_C2H_MCC_TSF_RPT_TSF_LOW_Y(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 3), GENMASK(31, 0))
+	le32_get_bits(*((const __le32 *)(c2h) + 5), GENMASK(31, 0))
 #define RTW89_GET_MAC_C2H_MCC_TSF_RPT_TSF_HIGH_Y(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 4), GENMASK(31, 0))
+	le32_get_bits(*((const __le32 *)(c2h) + 6), GENMASK(31, 0))
 
 #define RTW89_GET_MAC_C2H_MCC_STATUS_RPT_STATUS(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(5, 0))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(5, 0))
 #define RTW89_GET_MAC_C2H_MCC_STATUS_RPT_GROUP(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(7, 6))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(7, 6))
 #define RTW89_GET_MAC_C2H_MCC_STATUS_RPT_MACID(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h)), GENMASK(15, 8))
+	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(15, 8))
 #define RTW89_GET_MAC_C2H_MCC_STATUS_RPT_TSF_LOW(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 1), GENMASK(31, 0))
+	le32_get_bits(*((const __le32 *)(c2h) + 3), GENMASK(31, 0))
 #define RTW89_GET_MAC_C2H_MCC_STATUS_RPT_TSF_HIGH(c2h) \
-	le32_get_bits(*((const __le32 *)(c2h) + 2), GENMASK(31, 0))
+	le32_get_bits(*((const __le32 *)(c2h) + 4), GENMASK(31, 0))
 
 #define RTW89_FW_HDR_SIZE 32
 #define RTW89_FW_SECTION_HDR_SIZE 16
-- 
2.25.1

