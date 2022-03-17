Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A924DBF1D
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Mar 2022 07:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiCQGSI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 02:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiCQGRv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 02:17:51 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4824C2C7780
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 22:56:58 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22H5upE73009827, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22H5upE73009827
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 17 Mar 2022 13:56:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 17 Mar 2022 13:56:51 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 13:56:51 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <hsuan8331@realtek.com>, <yuanhan1020@realtek.com>
Subject: [PATCH v2 10/12] rtw89: change value assignment style of rtw89_mac_cfg_gnt()
Date:   Thu, 17 Mar 2022 13:55:41 +0800
Message-ID: <20220317055543.40514-11-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317055543.40514-1-pkshih@realtek.com>
References: <20220317055543.40514-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 03/17/2022 05:41:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMTcgpFekyCAwMzoyNjowMA==?=
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

Use if() style would be clear than "? :", because the else cases are
always 0. The read val from rtw89_mac_read_lte() isn't used, so remove
this statement.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 47 +++++++++++++-----------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index d68eb3126d8ae..dd538411a3c2e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3621,29 +3621,32 @@ EXPORT_SYMBOL(rtw89_mac_coex_init);
 int rtw89_mac_cfg_gnt(struct rtw89_dev *rtwdev,
 		      const struct rtw89_mac_ax_coex_gnt *gnt_cfg)
 {
-	u32 val, ret;
+	u32 val = 0, ret;
+
+	if (gnt_cfg->band[0].gnt_bt)
+		val |= B_AX_GNT_BT_RFC_S0_SW_VAL | B_AX_GNT_BT_BB_S0_SW_VAL;
+
+	if (gnt_cfg->band[0].gnt_bt_sw_en)
+		val |= B_AX_GNT_BT_RFC_S0_SW_CTRL | B_AX_GNT_BT_BB_S0_SW_CTRL;
+
+	if (gnt_cfg->band[0].gnt_wl)
+		val |= B_AX_GNT_WL_RFC_S0_SW_VAL | B_AX_GNT_WL_BB_S0_SW_VAL;
+
+	if (gnt_cfg->band[0].gnt_wl_sw_en)
+		val |= B_AX_GNT_WL_RFC_S0_SW_CTRL | B_AX_GNT_WL_BB_S0_SW_CTRL;
+
+	if (gnt_cfg->band[1].gnt_bt)
+		val |= B_AX_GNT_BT_RFC_S1_SW_VAL | B_AX_GNT_BT_BB_S1_SW_VAL;
+
+	if (gnt_cfg->band[1].gnt_bt_sw_en)
+		val |= B_AX_GNT_BT_RFC_S1_SW_CTRL | B_AX_GNT_BT_BB_S1_SW_CTRL;
+
+	if (gnt_cfg->band[1].gnt_wl)
+		val |= B_AX_GNT_WL_RFC_S1_SW_VAL | B_AX_GNT_WL_BB_S1_SW_VAL;
+
+	if (gnt_cfg->band[1].gnt_wl_sw_en)
+		val |= B_AX_GNT_WL_RFC_S1_SW_CTRL | B_AX_GNT_WL_BB_S1_SW_CTRL;
 
-	ret = rtw89_mac_read_lte(rtwdev, R_AX_LTE_SW_CFG_1, &val);
-	if (ret) {
-		rtw89_err(rtwdev, "Read LTE fail!\n");
-		return ret;
-	}
-	val = (gnt_cfg->band[0].gnt_bt ?
-	       B_AX_GNT_BT_RFC_S0_SW_VAL | B_AX_GNT_BT_BB_S0_SW_VAL : 0) |
-	      (gnt_cfg->band[0].gnt_bt_sw_en ?
-	       B_AX_GNT_BT_RFC_S0_SW_CTRL | B_AX_GNT_BT_BB_S0_SW_CTRL : 0) |
-	      (gnt_cfg->band[0].gnt_wl ?
-	       B_AX_GNT_WL_RFC_S0_SW_VAL | B_AX_GNT_WL_BB_S0_SW_VAL : 0) |
-	      (gnt_cfg->band[0].gnt_wl_sw_en ?
-	       B_AX_GNT_WL_RFC_S0_SW_CTRL | B_AX_GNT_WL_BB_S0_SW_CTRL : 0) |
-	      (gnt_cfg->band[1].gnt_bt ?
-	       B_AX_GNT_BT_RFC_S1_SW_VAL | B_AX_GNT_BT_BB_S1_SW_VAL : 0) |
-	      (gnt_cfg->band[1].gnt_bt_sw_en ?
-	       B_AX_GNT_BT_RFC_S1_SW_CTRL | B_AX_GNT_BT_BB_S1_SW_CTRL : 0) |
-	      (gnt_cfg->band[1].gnt_wl ?
-	       B_AX_GNT_WL_RFC_S1_SW_VAL | B_AX_GNT_WL_BB_S1_SW_VAL : 0) |
-	      (gnt_cfg->band[1].gnt_wl_sw_en ?
-	       B_AX_GNT_WL_RFC_S1_SW_CTRL | B_AX_GNT_WL_BB_S1_SW_CTRL : 0);
 	ret = rtw89_mac_write_lte(rtwdev, R_AX_LTE_SW_CFG_1, val);
 	if (ret) {
 		rtw89_err(rtwdev, "Write LTE fail!\n");
-- 
2.25.1

