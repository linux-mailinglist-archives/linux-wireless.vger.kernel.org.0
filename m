Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F91D4D7B61
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Mar 2022 08:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbiCNHO7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Mar 2022 03:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236540AbiCNHO5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Mar 2022 03:14:57 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9694011168
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 00:13:48 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22E7DfhA6003299, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22E7DfhA6003299
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 14 Mar 2022 15:13:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 14 Mar 2022 15:13:41 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 14 Mar
 2022 15:13:41 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
Subject: [PATCH 3/8] rtw89: mac: correct decision on error status by scenario
Date:   Mon, 14 Mar 2022 15:12:45 +0800
Message-ID: <20220314071250.40292-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220314071250.40292-1-pkshih@realtek.com>
References: <20220314071250.40292-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/14/2022 06:57:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTQgpFekyCAwNjowMDowMA==?=
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

The raw error code might combine error scenario and error status.
But, the error scenario isn't parsed previously. It makes us mishandle
cpu exception and assertion. Now, we correct the error status for them.

Besides, a few uses of error status are refined.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 12 ++++++++++--
 drivers/net/wireless/realtek/rtw89/mac.h |  8 ++++++++
 drivers/net/wireless/realtek/rtw89/ser.c |  6 ++++--
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 942c56c3dce09..0a8fd672b41f6 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -257,7 +257,9 @@ static void rtw89_mac_dump_err_status(struct rtw89_dev *rtwdev,
 	u32 dmac_err, cmac_err;
 
 	if (err != MAC_AX_ERR_L1_ERR_DMAC &&
-	    err != MAC_AX_ERR_L0_PROMOTE_TO_L1)
+	    err != MAC_AX_ERR_L0_PROMOTE_TO_L1 &&
+	    err != MAC_AX_ERR_L0_ERR_CMAC0 &&
+	    err != MAC_AX_ERR_L0_ERR_CMAC1)
 		return;
 
 	rtw89_info(rtwdev, "--->\nerr=0x%x\n", err);
@@ -458,7 +460,7 @@ static void rtw89_mac_dump_err_status(struct rtw89_dev *rtwdev,
 
 u32 rtw89_mac_get_err_status(struct rtw89_dev *rtwdev)
 {
-	u32 err;
+	u32 err, err_scnr;
 	int ret;
 
 	ret = read_poll_timeout(rtw89_read32, err, (err != 0), 1000, 100000,
@@ -471,6 +473,12 @@ u32 rtw89_mac_get_err_status(struct rtw89_dev *rtwdev)
 	err = rtw89_read32(rtwdev, R_AX_HALT_C2H);
 	rtw89_write32(rtwdev, R_AX_HALT_C2H_CTRL, 0);
 
+	err_scnr = RTW89_ERROR_SCENARIO(err);
+	if (err_scnr == RTW89_WCPU_CPU_EXCEPTION)
+		err = MAC_AX_ERR_CPU_EXCEPTION;
+	else if (err_scnr == RTW89_WCPU_ASSERTION)
+		err = MAC_AX_ERR_ASSERTION;
+
 	rtw89_fw_st_dbg_dump(rtwdev);
 	rtw89_mac_dump_err_status(rtwdev, err);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 8aed3596bc145..aeee078ea69ec 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -521,6 +521,13 @@ struct rtw89_mac_dle_dfi_qempty {
 	u32 qempty;
 };
 
+enum rtw89_mac_error_scenario {
+	RTW89_WCPU_CPU_EXCEPTION	= 2,
+	RTW89_WCPU_ASSERTION		= 3,
+};
+
+#define RTW89_ERROR_SCENARIO(__err) ((__err) >> 28)
+
 /* Define DBG and recovery enum */
 enum mac_ax_err_info {
 	/* Get error info */
@@ -659,6 +666,7 @@ enum mac_ax_err_info {
 	MAC_AX_ERR_L2_ERR_APB_BBRF_TO_OTHERS = 0x2370,
 	MAC_AX_ERR_L2_RESET_DONE = 0x2400,
 	MAC_AX_ERR_CPU_EXCEPTION = 0x3000,
+	MAC_AX_ERR_ASSERTION = 0x4000,
 	MAC_AX_GET_ERR_MAX,
 	MAC_AX_DUMP_SHAREBUFF_INDICATOR = 0x80000000,
 
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index e86f3d89ef1bf..5327b97b9c728 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -477,7 +477,7 @@ int rtw89_ser_notify(struct rtw89_dev *rtwdev, u32 err)
 {
 	u8 event = SER_EV_NONE;
 
-	rtw89_info(rtwdev, "ser event = 0x%04x\n", err);
+	rtw89_info(rtwdev, "SER catches error: 0x%x\n", err);
 
 	switch (err) {
 	case MAC_AX_ERR_L1_ERR_DMAC:
@@ -503,8 +503,10 @@ int rtw89_ser_notify(struct rtw89_dev *rtwdev, u32 err)
 		break;
 	}
 
-	if (event == SER_EV_NONE)
+	if (event == SER_EV_NONE) {
+		rtw89_warn(rtwdev, "SER cannot recognize error: 0x%x\n", err);
 		return -EINVAL;
+	}
 
 	ser_send_msg(&rtwdev->ser, event);
 	return 0;
-- 
2.25.1

