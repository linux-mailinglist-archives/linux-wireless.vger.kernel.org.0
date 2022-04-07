Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDC34F8067
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Apr 2022 15:23:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243018AbiDGNZm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Apr 2022 09:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237646AbiDGNZj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Apr 2022 09:25:39 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D878C7FF
        for <linux-wireless@vger.kernel.org>; Thu,  7 Apr 2022 06:23:38 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 237DNXWU0007529, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 237DNXWU0007529
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 7 Apr 2022 21:23:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 7 Apr 2022 21:23:32 +0800
Received: from localhost (172.16.21.190) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 7 Apr
 2022 21:23:32 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <johnson.lin@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 06/13] rtw89: reset BA CAM
Date:   Thu, 7 Apr 2022 21:23:09 +0800
Message-ID: <20220407132316.61132-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407132316.61132-1-pkshih@realtek.com>
References: <20220407132316.61132-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.21.190]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/07/2022 13:10:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvNyCkV6TIIDA4OjExOjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

BA CAM is used to react receiving AMPDU packets, so reset them to be
expected initial state.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 18 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b6c063e54f4c5..91383c08beb3a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1964,6 +1964,21 @@ static int trxptcl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	return 0;
 }
 
+static void rst_bacam(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+	int ret;
+
+	rtw89_write32_mask(rtwdev, R_AX_RESPBA_CAM_CTRL, B_AX_BACAM_RST_MASK,
+			   S_AX_BACAM_RST_ALL);
+
+	ret = read_poll_timeout_atomic(rtw89_read32_mask, val32, val32 == 0,
+				       1, 1000, false,
+				       rtwdev, R_AX_RESPBA_CAM_CTRL, B_AX_BACAM_RST_MASK);
+	if (ret)
+		rtw89_warn(rtwdev, "failed to reset BA CAM\n");
+}
+
 static int rmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 #define TRXCFG_RMAC_CCA_TO	32
@@ -1978,6 +1993,9 @@ static int rmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
+	if (mac_idx == RTW89_MAC_0)
+		rst_bacam(rtwdev);
+
 	reg = rtw89_mac_reg_by_idx(R_AX_RESPBA_CAM_CTRL, mac_idx);
 	rtw89_write8_set(rtwdev, reg, B_AX_SSN_SEL);
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index e5f8374f49ad5..bc343e756aad7 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -2819,6 +2819,8 @@
 #define R_AX_RESPBA_CAM_CTRL 0xCE3C
 #define R_AX_RESPBA_CAM_CTRL_C1 0xEE3C
 #define B_AX_SSN_SEL BIT(2)
+#define B_AX_BACAM_RST_MASK GENMASK(1, 0)
+#define S_AX_BACAM_RST_ALL 2
 
 #define R_AX_PPDU_STAT 0xCE40
 #define R_AX_PPDU_STAT_C1 0xEE40
-- 
2.25.1

