Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E6850F11A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Apr 2022 08:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245341AbiDZGhE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Apr 2022 02:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245205AbiDZGgs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Apr 2022 02:36:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95AFA1DA57
        for <linux-wireless@vger.kernel.org>; Mon, 25 Apr 2022 23:33:19 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23Q6XEmgC015288, This message is accepted by code: ctloc85258
Received: from mail.realtek.com ([172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23Q6XEmgC015288
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 26 Apr 2022 14:33:14 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 26 Apr 2022 14:33:13 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 26 Apr
 2022 14:33:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 12/15] rtw89: ps: fine tune polling interval while changing low power mode
Date:   Tue, 26 Apr 2022 14:32:32 +0800
Message-ID: <20220426063235.41650-13-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426063235.41650-1-pkshih@realtek.com>
References: <20220426063235.41650-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 04/26/2022 06:17:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjYgpFekyCAwNDozODowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

By experiments, it spends ~45/1090~2480us to enter/leave low power mode,
so the old polling interval 1000us can waste time. Use smaller polling
interval depends on experimental results to reduce the time to transition
state.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 05b94842fe662..07f6634d56a01 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1050,6 +1050,7 @@ static int rtw89_mac_check_cpwm_state(struct rtw89_dev *rtwdev,
 void rtw89_mac_power_mode_change(struct rtw89_dev *rtwdev, bool enter)
 {
 	enum rtw89_rpwm_req_pwr_state state;
+	unsigned long delay = enter ? 10 : 150;
 	int ret;
 
 	if (enter)
@@ -1059,7 +1060,7 @@ void rtw89_mac_power_mode_change(struct rtw89_dev *rtwdev, bool enter)
 
 	rtw89_mac_send_rpwm(rtwdev, state, false);
 	ret = read_poll_timeout_atomic(rtw89_mac_check_cpwm_state, ret, !ret,
-				       1000, 15000, false, rtwdev, state);
+				       delay, 15000, false, rtwdev, state);
 	if (ret)
 		rtw89_err(rtwdev, "firmware failed to ack for %s ps mode\n",
 			  enter ? "entering" : "leaving");
-- 
2.25.1

