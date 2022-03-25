Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD524E6E07
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 07:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358407AbiCYGDv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 02:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358396AbiCYGDu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 02:03:50 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96460C682F
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 23:02:16 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22P62AhfC011112, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22P62AhfC011112
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Mar 2022 14:02:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 14:02:10 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 14:02:09 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>
Subject: [PATCH 09/16] rtw89: update STA scheduler parameters for v1 chip
Date:   Fri, 25 Mar 2022 14:00:48 +0800
Message-ID: <20220325060055.58482-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220325060055.58482-1-pkshih@realtek.com>
References: <20220325060055.58482-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/25/2022 05:51:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMjUgpFekyCAwNDo0ODowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

The v1 chip has additional setting of STA scheduler, so add it.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 16 +++++++++++++++-
 drivers/net/wireless/realtek/rtw89/reg.h |  9 +++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 92ab86144ea94..e729da8446d52 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1636,6 +1636,17 @@ static bool dle_is_txq_empty(struct rtw89_dev *rtwdev)
 	return false;
 }
 
+static void _patch_ss2f_path(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B)
+		return;
+
+	rtw89_write32_mask(rtwdev, R_AX_SS2FINFO_PATH, B_AX_SS_DEST_QUEUE_MASK,
+			   SS2F_PATH_WLCPU);
+}
+
 static int sta_sch_init(struct rtw89_dev *rtwdev)
 {
 	u32 p_val;
@@ -1657,7 +1668,10 @@ static int sta_sch_init(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
-	rtw89_write32_set(rtwdev, R_AX_SS_CTRL, B_AX_SS_WARM_INIT_FLG);
+	rtw89_write32_set(rtwdev, R_AX_SS_CTRL, B_AX_SS_WARM_INIT_FLG |
+						B_AX_SS_NONEMPTY_SS2FINFO_EN);
+
+	_patch_ss2f_path(rtwdev);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 9d9554d28ab6a..fd9874137af72 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -801,8 +801,17 @@
 #define R_AX_SS_CTRL 0x9E10
 #define B_AX_SS_INIT_DONE_1 BIT(31)
 #define B_AX_SS_WARM_INIT_FLG BIT(29)
+#define B_AX_SS_NONEMPTY_SS2FINFO_EN BIT(28)
 #define B_AX_SS_EN BIT(0)
 
+#define R_AX_SS2FINFO_PATH 0x9E50
+#define B_AX_SS_UL_REL BIT(31)
+#define B_AX_SS_REL_QUEUE_MASK GENMASK(29, 24)
+#define B_AX_SS_REL_PORT_MASK GENMASK(18, 16)
+#define B_AX_SS_DEST_QUEUE_MASK GENMASK(13, 8)
+#define SS2F_PATH_WLCPU 0x0A
+#define B_AX_SS_DEST_PORT_MASK GENMASK(2, 0)
+
 #define R_AX_SS_MACID_PAUSE_0 0x9EB0
 #define B_AX_SS_MACID31_0_PAUSE_SH 0
 #define B_AX_SS_MACID31_0_PAUSE_MASK GENMASK(31, 0)
-- 
2.25.1

