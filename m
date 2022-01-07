Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A0E487157
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 04:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345889AbiAGDnH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 22:43:07 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:51054 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345891AbiAGDnG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 22:43:06 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2073h2EN1022895, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2073h2EN1022895
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 7 Jan 2022 11:43:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 7 Jan 2022 11:43:01 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 11:43:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 04/19] rtw89: add C2H handle of BCN_CNT
Date:   Fri, 7 Jan 2022 11:42:24 +0800
Message-ID: <20220107034239.22002-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107034239.22002-1-pkshih@realtek.com>
References: <20220107034239.22002-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 01/07/2022 03:26:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvNyCkV6TIIDAxOjMzOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This C2H notify driver the beacon count we send out. We don't handle the
content for now, so add a dummy handler to avoid messages, like
  rtw89_pci 0000:03:00.0: c2h class 0 func 3 not support
  C2H: 00000000: 01 03 01 3f 0f 00 00 00 80 0a 00 00 00 00 a0
  rtw89_pci 0000:03:00.0: c2h class 0 func 3 not support
  C2H: 00000000: 01 03 01 40 0f 00 00 00 00 03 20 00 00 00 a5

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 6 ++++++
 drivers/net/wireless/realtek/rtw89/mac.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b98c47e9ecfe3..59b6ef91afb0a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3114,6 +3114,11 @@ rtw89_mac_c2h_log(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 		   RTW89_GET_C2H_LOG_SRT_PRT(c2h->data));
 }
 
+static void
+rtw89_mac_c2h_bcn_cnt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+}
+
 static
 void (* const rtw89_mac_c2h_ofld_handler[])(struct rtw89_dev *rtwdev,
 					    struct sk_buff *c2h, u32 len) = {
@@ -3130,6 +3135,7 @@ void (* const rtw89_mac_c2h_info_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_MAC_C2H_FUNC_REC_ACK] = rtw89_mac_c2h_rec_ack,
 	[RTW89_MAC_C2H_FUNC_DONE_ACK] = rtw89_mac_c2h_done_ack,
 	[RTW89_MAC_C2H_FUNC_C2H_LOG] = rtw89_mac_c2h_log,
+	[RTW89_MAC_C2H_FUNC_BCN_CNT] = rtw89_mac_c2h_bcn_cnt,
 };
 
 void rtw89_mac_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index b7d13edf7dd19..65e4ebe05f6ad 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -308,6 +308,7 @@ enum rtw89_mac_c2h_info_func {
 	RTW89_MAC_C2H_FUNC_REC_ACK,
 	RTW89_MAC_C2H_FUNC_DONE_ACK,
 	RTW89_MAC_C2H_FUNC_C2H_LOG,
+	RTW89_MAC_C2H_FUNC_BCN_CNT,
 	RTW89_MAC_C2H_FUNC_INFO_MAX,
 };
 
-- 
2.25.1

