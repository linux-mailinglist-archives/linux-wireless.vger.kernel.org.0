Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87394E6E06
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Mar 2022 07:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358409AbiCYGDw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Mar 2022 02:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358400AbiCYGDu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Mar 2022 02:03:50 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E49C6828
        for <linux-wireless@vger.kernel.org>; Thu, 24 Mar 2022 23:02:16 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22P629zhC011097, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22P629zhC011097
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Mar 2022 14:02:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 25 Mar 2022 14:02:09 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 14:02:08 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>
Subject: [PATCH 08/16] rtw89: extend dmac_pre_init to support 8852C
Date:   Fri, 25 Mar 2022 14:00:47 +0800
Message-ID: <20220325060055.58482-9-pkshih@realtek.com>
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

DMAC is short for data MAC. 8852C has more settings than 8852A, so add
them.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c | 37 +++++++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/reg.h |  1 +
 2 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 87adaa08fdb93..92ab86144ea94 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2832,18 +2832,41 @@ static int rtw89_mac_enable_cpu(struct rtw89_dev *rtwdev, u8 boot_reason,
 	return 0;
 }
 
-static int rtw89_mac_fw_dl_pre_init(struct rtw89_dev *rtwdev)
+static int rtw89_mac_dmac_pre_init(struct rtw89_dev *rtwdev)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	u32 val;
 	int ret;
 
-	val = B_AX_MAC_FUNC_EN | B_AX_DMAC_FUNC_EN | B_AX_DISPATCHER_EN |
-	      B_AX_PKT_BUF_EN;
+	if (chip_id == RTL8852C)
+		val = B_AX_MAC_FUNC_EN | B_AX_DMAC_FUNC_EN | B_AX_DISPATCHER_EN |
+		      B_AX_PKT_BUF_EN | B_AX_H_AXIDMA_EN;
+	else
+		val = B_AX_MAC_FUNC_EN | B_AX_DMAC_FUNC_EN | B_AX_DISPATCHER_EN |
+		      B_AX_PKT_BUF_EN;
 	rtw89_write32(rtwdev, R_AX_DMAC_FUNC_EN, val);
 
 	val = B_AX_DISPATCHER_CLK_EN;
 	rtw89_write32(rtwdev, R_AX_DMAC_CLK_EN, val);
 
+	if (chip_id != RTL8852C)
+		goto dle;
+
+	val = rtw89_read32(rtwdev, R_AX_HAXI_INIT_CFG1);
+	val &= ~(B_AX_DMA_MODE_MASK | B_AX_STOP_AXI_MST);
+	val |= FIELD_PREP(B_AX_DMA_MODE_MASK, DMA_MOD_PCIE_1B) |
+	       B_AX_TXHCI_EN_V1 | B_AX_RXHCI_EN_V1;
+	rtw89_write32(rtwdev, R_AX_HAXI_INIT_CFG1, val);
+
+	rtw89_write32_clr(rtwdev, R_AX_HAXI_DMA_STOP1,
+			  B_AX_STOP_ACH0 | B_AX_STOP_ACH1 | B_AX_STOP_ACH3 |
+			  B_AX_STOP_ACH4 | B_AX_STOP_ACH5 | B_AX_STOP_ACH6 |
+			  B_AX_STOP_ACH7 | B_AX_STOP_CH8 | B_AX_STOP_CH9 |
+			  B_AX_STOP_CH12 | B_AX_STOP_ACH2);
+	rtw89_write32_clr(rtwdev, R_AX_HAXI_DMA_STOP2, B_AX_STOP_CH10 | B_AX_STOP_CH11);
+	rtw89_write32_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_AXIDMA_EN);
+
+dle:
 	ret = dle_init(rtwdev, RTW89_QTA_DLFW, rtwdev->mac.qta_mode);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]DLE pre init %d\n", ret);
@@ -2901,16 +2924,16 @@ int rtw89_mac_partial_init(struct rtw89_dev *rtwdev)
 
 	rtw89_mac_hci_func_en(rtwdev);
 
+	ret = rtw89_mac_dmac_pre_init(rtwdev);
+	if (ret)
+		return ret;
+
 	if (rtwdev->hci.ops->mac_pre_init) {
 		ret = rtwdev->hci.ops->mac_pre_init(rtwdev);
 		if (ret)
 			return ret;
 	}
 
-	ret = rtw89_mac_fw_dl_pre_init(rtwdev);
-	if (ret)
-		return ret;
-
 	rtw89_mac_disable_cpu(rtwdev);
 	ret = rtw89_mac_enable_cpu(rtwdev, 0, true);
 	if (ret)
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 21a451264e504..9d9554d28ab6a 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -120,6 +120,7 @@
 #define B_AX_R_AX_BG GENMASK(1, 0)
 
 #define R_AX_PLATFORM_ENABLE 0x0088
+#define B_AX_AXIDMA_EN BIT(3)
 #define B_AX_WCPU_EN BIT(1)
 #define B_AX_PLATFORM_EN BIT(0)
 
-- 
2.25.1

