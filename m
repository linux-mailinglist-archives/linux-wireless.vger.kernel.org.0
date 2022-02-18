Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE3F4BB05C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Feb 2022 04:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiBRDqU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Feb 2022 22:46:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiBRDqT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Feb 2022 22:46:19 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF2A1B7B6
        for <linux-wireless@vger.kernel.org>; Thu, 17 Feb 2022 19:46:03 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 21I3jvhF7024413, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 21I3jvhF7024413
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 18 Feb 2022 11:45:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 11:45:57 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 18 Feb
 2022 11:45:56 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <chiuyitang@realtek.com>,
        <yuanhan1020@realtek.com>
Subject: [PATCH] rtw89: Limit the CFO boundaries of x'tal value
Date:   Fri, 18 Feb 2022 11:45:37 +0800
Message-ID: <20220218034537.9338-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 02/18/2022 03:22:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzIvMTggpFekyCAwMTo1MDowMA==?=
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

From: Yi-Tang Chiu <chiuyitang@realtek.com>

Set the boundaries of x'tal value to avoid extremely adjusted results,
causing severely unexpected CFO.

Signed-off-by: Yi-Tang Chiu <chiuyitang@realtek.com>
Signed-off-by: Yuan-Han Zhang <yuanhan1020@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  4 ++++
 drivers/net/wireless/realtek/rtw89/phy.c  | 21 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h  |  1 +
 3 files changed, 26 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2c81e19d4b51c..6a88578898e01 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -2613,6 +2613,10 @@ struct rtw89_cfo_tracking_info {
 	s32 residual_cfo_acc;
 	u8 phy_cfotrk_state;
 	u8 phy_cfotrk_cnt;
+	bool divergence_lock_en;
+	u8 x_cap_lb;
+	u8 x_cap_ub;
+	u8 lock_cnt;
 };
 
 /* 2GL, 2GH, 5GL1, 5GH1, 5GM1, 5GM2, 5GH1, 5GH2 */
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 719a2d6be0be9..c6953a78658ae 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1743,8 +1743,12 @@ static void rtw89_phy_cfo_init(struct rtw89_dev *rtwdev)
 	cfo->crystal_cap_default = efuse->xtal_cap & B_AX_XTAL_SC_MASK;
 	cfo->crystal_cap = cfo->crystal_cap_default;
 	cfo->def_x_cap = cfo->crystal_cap;
+	cfo->x_cap_ub = min_t(int, cfo->def_x_cap + CFO_BOUND, 0x7f);
+	cfo->x_cap_lb = max_t(int, cfo->def_x_cap - CFO_BOUND, 0x1);
 	cfo->is_adjust = false;
+	cfo->divergence_lock_en = false;
 	cfo->x_cap_ofst = 0;
+	cfo->lock_cnt = 0;
 	cfo->rtw89_multi_cfo_mode = RTW89_TP_BASED_AVG_MODE;
 	cfo->apply_compensation = false;
 	cfo->residual_cfo_acc = 0;
@@ -1962,6 +1966,23 @@ static void rtw89_phy_cfo_dm(struct rtw89_dev *rtwdev)
 		rtw89_debug(rtwdev, RTW89_DBG_CFO, "curr_cfo=0\n");
 		return;
 	}
+	if (cfo->divergence_lock_en) {
+		cfo->lock_cnt++;
+		if (cfo->lock_cnt > CFO_PERIOD_CNT) {
+			cfo->divergence_lock_en = false;
+			cfo->lock_cnt = 0;
+		} else {
+			rtw89_phy_cfo_reset(rtwdev);
+		}
+		return;
+	}
+	if (cfo->crystal_cap >= cfo->x_cap_ub ||
+	    cfo->crystal_cap <= cfo->x_cap_lb) {
+		cfo->divergence_lock_en = true;
+		rtw89_phy_cfo_reset(rtwdev);
+		return;
+	}
+
 	rtw89_phy_cfo_crystal_cap_adjust(rtwdev, new_cfo);
 	cfo->cfo_avg_pre = new_cfo;
 	x_cap_update =  cfo->crystal_cap != pre_x_cap;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 1fb2d96fbca31..d6bc84ae6cd71 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -55,6 +55,7 @@
 #define CFO_TRK_STOP_TH (2 << 2)
 #define CFO_SW_COMP_FINE_TUNE (2 << 2)
 #define CFO_PERIOD_CNT 15
+#define CFO_BOUND 32
 #define CFO_TP_UPPER 100
 #define CFO_TP_LOWER 50
 #define CFO_COMP_PERIOD 250
-- 
2.25.1

